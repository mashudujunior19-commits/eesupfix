-- Application review pipeline: main app -> admin review -> verdict -> notification.
--  * status (pending | approved | declined) derived from approved_at / rejected_at
--  * review RPC: admin only, pending -> approved|declined only, reason required on
--    decline, idempotent, audited
--  * one notification per verdict (same transaction as the verdict, so it is never
--    lost; the app reads it whenever it comes online), carrying the decline reason
--  * users may only see/create/edit their OWN pending application and can never
--    touch the verdict columns; no duplicate pending application per partner

-- 1. Columns ---------------------------------------------------------------
ALTER TABLE "services"."partner_application"
    ADD COLUMN IF NOT EXISTS "decline_reason" text,
    ADD COLUMN IF NOT EXISTS "reviewed_by" uuid,
    ADD COLUMN IF NOT EXISTS "reviewed_at" timestamptz;

ALTER TABLE "services"."partner_application"
    ADD COLUMN IF NOT EXISTS "status" text GENERATED ALWAYS AS (
        CASE WHEN approved_at IS NOT NULL THEN 'approved'
             WHEN rejected_at IS NOT NULL THEN 'declined'
             ELSE 'pending' END
    ) STORED;

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'partner_application_single_verdict') THEN
        ALTER TABLE "services"."partner_application"
            ADD CONSTRAINT "partner_application_single_verdict"
            CHECK (approved_at IS NULL OR rejected_at IS NULL) NOT VALID;
    END IF;
END $$;

-- 2. Audit log ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS "services"."partner_application_audit" (
    "id" bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "application_id" integer NOT NULL REFERENCES "services"."partner_application"("id") ON DELETE CASCADE,
    "admin_id" uuid,
    "action" text NOT NULL CHECK (action IN ('approve', 'decline')),
    "from_status" text NOT NULL,
    "to_status" text NOT NULL,
    "reason" text,
    "created_at" timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS "partner_application_audit_app_idx"
    ON "services"."partner_application_audit" ("application_id", "created_at" DESC);
ALTER TABLE "services"."partner_application_audit" ENABLE ROW LEVEL SECURITY;
-- no policies: only the service role / definer functions read or write it
REVOKE ALL ON "services"."partner_application_audit" FROM "anon", "authenticated";

-- 3. Row access: own rows only, nothing deletable by users ---------------------
DROP POLICY IF EXISTS "Enable access for authenticated users only" ON "services"."partner_application";
DROP POLICY IF EXISTS "partner_application_select_own" ON "services"."partner_application";
DROP POLICY IF EXISTS "partner_application_insert_own" ON "services"."partner_application";
DROP POLICY IF EXISTS "partner_application_update_own_pending" ON "services"."partner_application";

CREATE POLICY "partner_application_select_own" ON "services"."partner_application"
    FOR SELECT TO "authenticated" USING (user_id = auth.uid());
CREATE POLICY "partner_application_insert_own" ON "services"."partner_application"
    FOR INSERT TO "authenticated" WITH CHECK (user_id = auth.uid());
CREATE POLICY "partner_application_update_own_pending" ON "services"."partner_application"
    FOR UPDATE TO "authenticated"
    USING (user_id = auth.uid() AND approved_at IS NULL AND rejected_at IS NULL)
    WITH CHECK (user_id = auth.uid());

REVOKE DELETE ON "services"."partner_application" FROM "anon", "authenticated";

-- A signed-in user may only change their survey answers while pending; the
-- verdict columns can only be written by the review function / service role.
CREATE OR REPLACE FUNCTION "services"."guard_partner_application_update"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF current_user IN ('authenticated', 'anon') THEN
        IF NEW.approved_at   IS DISTINCT FROM OLD.approved_at
           OR NEW.rejected_at   IS DISTINCT FROM OLD.rejected_at
           OR NEW.decline_reason IS DISTINCT FROM OLD.decline_reason
           OR NEW.reviewed_by   IS DISTINCT FROM OLD.reviewed_by
           OR NEW.reviewed_at   IS DISTINCT FROM OLD.reviewed_at
           OR NEW.user_id       IS DISTINCT FROM OLD.user_id
           OR NEW.partner_id    IS DISTINCT FROM OLD.partner_id THEN
            RAISE EXCEPTION 'FORBIDDEN: only a reviewer can change the outcome of an application'
                USING ERRCODE = '42501';
        END IF;
    END IF;
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS "guard_partner_application_update_trigger" ON "services"."partner_application";
CREATE TRIGGER "guard_partner_application_update_trigger"
    BEFORE UPDATE ON "services"."partner_application"
    FOR EACH ROW EXECUTE FUNCTION "services"."guard_partner_application_update"();

-- 4. One pending application per user and partner ------------------------------
-- create is idempotent: a second tap returns the application already pending.
CREATE OR REPLACE FUNCTION "services"."create_new_partner_application"("_user_id" uuid, "_partner_id" text)
    RETURNS integer
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    _id integer;
    _current_role user_role;
    _partner_roles user_role[];
BEGIN
    IF auth.role() <> 'service_role' AND _user_id IS DISTINCT FROM auth.uid() THEN
        RAISE EXCEPTION 'FORBIDDEN: you can only apply for yourself' USING ERRCODE = '42501';
    END IF;

    SELECT role INTO _current_role FROM profile WHERE user_id = _user_id;
    SELECT roles INTO _partner_roles FROM services.partner WHERE id = _partner_id;

    IF _current_role = ANY(_partner_roles) THEN
        SELECT id INTO _id FROM services.partner_application
        WHERE user_id = _user_id AND partner_id = _partner_id
          AND approved_at IS NULL AND rejected_at IS NULL
        ORDER BY id DESC LIMIT 1;

        IF _id IS NULL THEN
            INSERT INTO services.partner_application(user_id, partner_id, survey_responses)
            VALUES (_user_id, _partner_id, '{}')
            RETURNING id INTO _id;
        END IF;
    ELSE
        _id := 0;
    END IF;

    RETURN _id;
END;
$$;

CREATE OR REPLACE FUNCTION "services"."prevent_duplicate_pending_application"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET search_path = public
    AS $$
BEGIN
    IF NEW.approved_at IS NULL AND NEW.rejected_at IS NULL AND EXISTS (
        SELECT 1 FROM services.partner_application a
        WHERE a.user_id = NEW.user_id AND a.partner_id = NEW.partner_id
          AND a.approved_at IS NULL AND a.rejected_at IS NULL
    ) THEN
        RAISE EXCEPTION 'DUPLICATE_PENDING: you already have a pending application for this' USING ERRCODE = '23505';
    END IF;
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS "prevent_duplicate_pending_application_trigger" ON "services"."partner_application";
CREATE TRIGGER "prevent_duplicate_pending_application_trigger"
    BEFORE INSERT ON "services"."partner_application"
    FOR EACH ROW EXECUTE FUNCTION "services"."prevent_duplicate_pending_application"();

-- 5. Review RPC -----------------------------------------------------------------
CREATE OR REPLACE FUNCTION "services"."review_partner_application"(
    "_application_id" integer,
    "_decision" text,
    "_reason" text DEFAULT NULL,
    "_admin_id" uuid DEFAULT NULL
) RETURNS TABLE("application_id" integer, "status" text, "reviewed_at" timestamptz, "already_applied" boolean)
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET search_path = public
    AS $$
DECLARE
    _admin uuid;
    _action text;
    _target text;
    _reason_clean text;
    _app services.partner_application%ROWTYPE;
    _now timestamptz := now();
BEGIN
    -- who may review
    IF auth.role() = 'service_role' THEN
        _admin := _admin_id;
    ELSE
        _admin := auth.uid();
        IF _admin IS NULL OR NOT EXISTS (
            SELECT 1 FROM public.profile p WHERE p.user_id = _admin AND p.role = 'Admin'
        ) THEN
            RAISE EXCEPTION 'FORBIDDEN: only an admin can review applications' USING ERRCODE = '42501';
        END IF;
    END IF;

    -- decision
    _decision := lower(trim(COALESCE(_decision, '')));
    IF _decision IN ('approve', 'approved') THEN
        _action := 'approve'; _target := 'approved';
    ELSIF _decision IN ('decline', 'declined', 'reject', 'rejected') THEN
        _action := 'decline'; _target := 'declined';
    ELSE
        RAISE EXCEPTION 'INVALID_DECISION: decision must be approve or decline' USING ERRCODE = '22023';
    END IF;

    _reason_clean := NULLIF(trim(COALESCE(_reason, '')), '');
    IF _action = 'decline' THEN
        IF _reason_clean IS NULL OR char_length(_reason_clean) < 5 THEN
            RAISE EXCEPTION 'REASON_REQUIRED: give the applicant a reason (at least 5 characters)' USING ERRCODE = '22023';
        END IF;
        IF char_length(_reason_clean) > 500 THEN
            RAISE EXCEPTION 'REASON_TOO_LONG: the reason can be at most 500 characters' USING ERRCODE = '22023';
        END IF;
    ELSE
        _reason_clean := NULL;
    END IF;

    -- lock the row so two reviewers cannot both act
    SELECT * INTO _app FROM services.partner_application a WHERE a.id = _application_id FOR UPDATE;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'NOT_FOUND: application % does not exist', _application_id USING ERRCODE = 'P0002';
    END IF;

    -- idempotent: same verdict again is a no-op
    IF _app.status = _target THEN
        RETURN QUERY SELECT _app.id, _app.status, _app.reviewed_at, true;
        RETURN;
    END IF;

    IF _app.status <> 'pending' THEN
        RAISE EXCEPTION 'INVALID_TRANSITION: application is already % and cannot be %', _app.status, _target
            USING ERRCODE = '23514';
    END IF;

    UPDATE services.partner_application a
    SET approved_at = CASE WHEN _action = 'approve' THEN _now END,
        rejected_at = CASE WHEN _action = 'decline' THEN _now END,
        decline_reason = _reason_clean,
        reviewed_by = _admin,
        reviewed_at = _now
    WHERE a.id = _application_id;

    INSERT INTO services.partner_application_audit(application_id, admin_id, action, from_status, to_status, reason, created_at)
    VALUES (_application_id, _admin, _action, 'pending', _target, _reason_clean, _now);

    RETURN QUERY SELECT _application_id, _target, _now, false;
END;
$$;

REVOKE ALL ON FUNCTION "services"."review_partner_application"(integer, text, text, uuid) FROM PUBLIC, "anon";
GRANT EXECUTE ON FUNCTION "services"."review_partner_application"(integer, text, text, uuid) TO "authenticated", "service_role";

-- 6. Verdict notification: once per verdict, with the reason -----------------------
CREATE OR REPLACE FUNCTION "services"."notify_applicant_on_application_update"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET search_path = public
    AS $$
DECLARE
    _title text;
    _status text;
    _body text;
BEGIN
    IF NEW.approved_at IS NOT NULL AND OLD.approved_at IS NULL THEN
        _status := 'approved';
    ELSIF NEW.rejected_at IS NOT NULL AND OLD.rejected_at IS NULL THEN
        _status := 'declined';
    ELSE
        RETURN NEW;   -- not a verdict (e.g. the applicant edited their answers)
    END IF;

    SELECT title INTO _title FROM services.partner WHERE id = NEW.partner_id;
    _title := COALESCE(_title, 'Application');

    IF _status = 'approved' THEN
        _body := 'Great news! Your ' || _title || ' application (#' || NEW.id || ') has been approved.';
    ELSE
        _body := 'Your ' || _title || ' application (#' || NEW.id || ') was declined.'
              || COALESCE(' Reason: ' || NEW.decline_reason, '');
    END IF;

    INSERT INTO engagements.notification(title, body, type, channel, user_id, data)
    VALUES (
        _title || ' application ' || _status,
        _body,
        'other',
        'push',
        NEW.user_id,
        jsonb_build_object(
            'kind', 'partner_application',
            'application_id', NEW.id,
            'partner_id', NEW.partner_id,
            'application_type', _title,
            'status', _status,
            'reason', NEW.decline_reason,
            'decided_at', COALESCE(NEW.reviewed_at, now())
        )
    );
    RETURN NEW;
END;
$$;

-- The role change / shop creation must only happen on the approval itself, not on
-- every later update of an approved application.
CREATE OR REPLACE FUNCTION "services"."on_partner_application_approved"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    _type RECORD;
BEGIN
    IF TG_OP = 'UPDATE' THEN
        IF OLD.approved_at IS NOT NULL THEN
            RETURN NEW;
        END IF;
    END IF;

    IF NEW.approved_at IS NOT NULL AND NEW.rejected_at IS NULL THEN
        IF NEW.partner_id = 'eesup_lift_corp' THEN
            UPDATE profile SET role = 'EESUplift-Corporate' WHERE user_id = NEW.user_id;

            FOR _type IN SELECT wt.id FROM finances.wallet_type wt
            WHERE 'EESUplift-Corporate' = ANY(wt.roles)
            LOOP
                IF NOT EXISTS (SELECT 1 FROM finances.wallet w WHERE w.type = _type.id AND w.user_id = NEW.user_id) THEN
                    INSERT INTO finances.wallet(type, user_id, balance)
                    VALUES (_type.id, NEW.user_id, 0.00);
                END IF;
            END LOOP;
        ELSIF NEW.partner_id = 'eesupreneur' THEN
            UPDATE profile SET role = 'EESUpreneur' WHERE user_id = NEW.user_id;

            INSERT INTO services.eesupreneur(owner_id, name)
            VALUES (NEW.user_id, 'My Shop');
        END IF;
    END IF;

    RETURN NEW;
END;
$$;

-- The original trigger was FOR EACH STATEMENT, where NEW/OLD are empty, so no
-- verdict notification was ever created. It must run per row.
DROP TRIGGER IF EXISTS "notify_applicant_on_application_update_trigger" ON "services"."partner_application";
CREATE TRIGGER "notify_applicant_on_application_update_trigger"
    AFTER UPDATE ON "services"."partner_application"
    FOR EACH ROW EXECUTE FUNCTION "services"."notify_applicant_on_application_update"();
