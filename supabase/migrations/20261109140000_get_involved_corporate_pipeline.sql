-- Get Involved pipeline: phone persistence, notifications, Corporate upgrade,
-- idempotent reviews, referral-code immutability and the Kasipromoter rule.
-- Needs public.is_admin() (20261103150000) and the review functions from
-- 20261103130000 / 20261109120000, which are replaced below.
--
-- HTTP status mapping (PostgREST turns SQLSTATE 'PTnnn' into HTTP nnn):
--   PT409 invalid state transition / duplicate     PT422 validation     PT403 role / ownership

-- =====================================================================
-- 1. Profile columns
-- =====================================================================
ALTER TABLE "public"."profile"
    ADD COLUMN IF NOT EXISTS "upgraded_at" timestamptz,
    ADD COLUMN IF NOT EXISTS "upgraded_by_submission_id" uuid,
    ADD COLUMN IF NOT EXISTS "is_kasipromoter" boolean NOT NULL DEFAULT false;

CREATE UNIQUE INDEX IF NOT EXISTS "profile_referral_code_key" ON "public"."profile" ("referral_code");

-- =====================================================================
-- 2. Phone numbers always persist, in one canonical form
-- =====================================================================
-- Accepts 0XXXXXXXXX, +27XXXXXXXXX and 27XXXXXXXXX; returns 27XXXXXXXXX (E.164
-- without the "+", the form already stored and used for sign-in), else NULL.
CREATE OR REPLACE FUNCTION "public"."normalize_sa_phone"("_phone" text) RETURNS text
    LANGUAGE "sql" IMMUTABLE
    AS $$
    SELECT CASE
        WHEN s ~ '^0[0-9]{9}$'      THEN '27' || substr(s, 2)
        WHEN s ~ '^\+27[0-9]{9}$'   THEN substr(s, 2)
        WHEN s ~ '^27[0-9]{9}$'     THEN s
        ELSE NULL
    END
    FROM (SELECT regexp_replace(COALESCE(_phone, ''), '[\s\-()]', '', 'g') AS s) t
$$;

-- Is this user the owner of an approved KasiLift Organisation?
CREATE OR REPLACE FUNCTION "public"."is_kasilift_organisation"("_user_id" uuid) RETURNS boolean
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET search_path = public
    AS $$
    SELECT EXISTS (
        SELECT 1 FROM services.get_involved_submissions s
        WHERE s.user_id = _user_id AND s.is_kasilift AND s.status = 'approved'
    )
$$;
REVOKE ALL ON FUNCTION "public"."is_kasilift_organisation"(uuid) FROM PUBLIC, "anon";
GRANT EXECUTE ON FUNCTION "public"."is_kasilift_organisation"(uuid) TO "authenticated", "service_role";

CREATE TABLE IF NOT EXISTS "public"."kasipromoter_attempt" (
    "id" bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "user_id" uuid NOT NULL,
    "outcome" text NOT NULL CHECK (outcome IN ('allowed', 'blocked')),
    "source" text NOT NULL,
    "created_at" timestamptz NOT NULL DEFAULT now()
);
ALTER TABLE "public"."kasipromoter_attempt" ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON "public"."kasipromoter_attempt" FROM "anon", "authenticated";
GRANT SELECT ON "public"."kasipromoter_attempt" TO "authenticated";
DROP POLICY IF EXISTS "kasipromoter_attempt_select_admin" ON "public"."kasipromoter_attempt";
CREATE POLICY "kasipromoter_attempt_select_admin" ON "public"."kasipromoter_attempt"
    FOR SELECT TO "authenticated" USING (public.is_admin());

-- One guard for everything that must never be changed by a profile save:
--   phone  - normalised, validated, unique, and never emptied by a later save
--   role / referral code / upgrade fields / promoter flag - not the user's to set
--   referral code - immutable for everyone
--   role -> EESUpromoter - only for a KasiLift Organisation
CREATE OR REPLACE FUNCTION "public"."guard_profile_write"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    _n text;
BEGIN
    IF TG_OP = 'INSERT' THEN
        IF NEW.phone IS NOT NULL AND btrim(NEW.phone) <> '' THEN
            -- lenient on sign-up: store the canonical form when it is valid
            NEW.phone := COALESCE(public.normalize_sa_phone(NEW.phone), NEW.phone);
        END IF;
        RETURN NEW;
    END IF;

    -- phone ---------------------------------------------------------------
    IF NEW.phone IS NULL OR btrim(NEW.phone) = '' THEN
        NEW.phone := OLD.phone;   -- a stale or partial save can never wipe it
    ELSIF NEW.phone IS DISTINCT FROM OLD.phone THEN
        _n := public.normalize_sa_phone(NEW.phone);
        IF _n IS NULL THEN
            RAISE EXCEPTION 'Enter a valid South African phone number.' USING ERRCODE = 'PT422';
        END IF;
        IF EXISTS (SELECT 1 FROM public.profile p WHERE p.phone = _n AND p.user_id <> NEW.user_id) THEN
            RAISE EXCEPTION 'This phone number is already linked to another account.' USING ERRCODE = 'PT409';
        END IF;
        NEW.phone := _n;
    END IF;

    -- referral code: immutable for everyone, no transfer --------------------------
    IF NEW.referral_code IS DISTINCT FROM OLD.referral_code THEN
        RAISE EXCEPTION 'The referral code cannot be changed or transferred.' USING ERRCODE = 'PT403';
    END IF;

    -- fields only the system may set -------------------------------------------------
    IF current_user IN ('authenticated', 'anon') THEN
        IF NEW.role IS DISTINCT FROM OLD.role
           OR NEW.upgraded_at IS DISTINCT FROM OLD.upgraded_at
           OR NEW.upgraded_by_submission_id IS DISTINCT FROM OLD.upgraded_by_submission_id
           OR NEW.is_kasipromoter IS DISTINCT FROM OLD.is_kasipromoter THEN
            RAISE EXCEPTION 'FORBIDDEN: this account field can only be changed by a reviewer.' USING ERRCODE = 'PT403';
        END IF;
    END IF;

    -- Kasipromoter: only a KasiLift Organisation --------------------------------------
    IF NEW.role = 'EESUpromoter' AND OLD.role IS DISTINCT FROM 'EESUpromoter'
       AND NOT public.is_kasilift_organisation(NEW.user_id) THEN
        RAISE LOG 'kasipromoter blocked for user % (not a KasiLift Organisation)', NEW.user_id;
        RAISE EXCEPTION 'You cannot be a Kasipromoter. Only a Kasilift Organisation can refer and become a Kasipromoter.'
            USING ERRCODE = 'PT403';
    END IF;

    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS "guard_profile_write_trigger" ON "public"."profile";
CREATE TRIGGER "guard_profile_write_trigger"
    BEFORE INSERT OR UPDATE ON "public"."profile"
    FOR EACH ROW EXECUTE FUNCTION "public"."guard_profile_write"();

-- =====================================================================
-- 3. Kasipromoter: only a KasiLift Organisation
-- =====================================================================
CREATE OR REPLACE FUNCTION "public"."get_kasipromoter_eligibility"()
    RETURNS TABLE("eligible" boolean, "message" text)
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET search_path = public
    AS $$
    SELECT public.is_kasilift_organisation(auth.uid()),
           CASE WHEN public.is_kasilift_organisation(auth.uid()) THEN NULL
                ELSE 'You cannot be a Kasipromoter. Only a Kasilift Organisation can refer and become a Kasipromoter.' END
$$;

-- The one way to become a Kasipromoter. A blocked attempt is logged and returned
-- as a result (not an exception) so that the log row is kept.
CREATE OR REPLACE FUNCTION "public"."become_kasipromoter"() RETURNS TABLE("ok" boolean, "message" text)
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET search_path = public
    AS $$
DECLARE
    _uid uuid := auth.uid();
BEGIN
    IF _uid IS NULL THEN
        RAISE EXCEPTION 'FORBIDDEN: sign in first' USING ERRCODE = 'PT403';
    END IF;

    IF NOT public.is_kasilift_organisation(_uid) THEN
        INSERT INTO public.kasipromoter_attempt(user_id, outcome, source) VALUES (_uid, 'blocked', 'become_kasipromoter');
        RETURN QUERY SELECT false,
            'You cannot be a Kasipromoter. Only a Kasilift Organisation can refer and become a Kasipromoter.'::text;
        RETURN;
    END IF;

    UPDATE public.profile SET is_kasipromoter = true WHERE user_id = _uid;
    INSERT INTO public.kasipromoter_attempt(user_id, outcome, source) VALUES (_uid, 'allowed', 'become_kasipromoter');
    RETURN QUERY SELECT true, NULL::text;
END;
$$;

REVOKE ALL ON FUNCTION "public"."get_kasipromoter_eligibility"() FROM PUBLIC, "anon";
GRANT EXECUTE ON FUNCTION "public"."get_kasipromoter_eligibility"() TO "authenticated", "service_role";
REVOKE ALL ON FUNCTION "public"."become_kasipromoter"() FROM PUBLIC, "anon";
GRANT EXECUTE ON FUNCTION "public"."become_kasipromoter"() TO "authenticated", "service_role";

-- Five completed referrals used to make anyone a Kasipromoter. Now only a
-- KasiLift Organisation can be one; for everyone else the attempt is logged.
CREATE OR REPLACE FUNCTION "public"."promote_referrer_after_five_referrals"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET search_path = public
    AS $$
BEGIN
    IF NEW.is_completed AND NOT COALESCE(OLD.is_completed, false) THEN
        IF (SELECT COUNT(*) FROM public.referral r
            WHERE r.referrer_user_id = NEW.referrer_user_id AND r.is_completed) >= 5 THEN
            IF public.is_kasilift_organisation(NEW.referrer_user_id) THEN
                UPDATE public.profile SET is_kasipromoter = true WHERE user_id = NEW.referrer_user_id;
                INSERT INTO public.kasipromoter_attempt(user_id, outcome, source)
                VALUES (NEW.referrer_user_id, 'allowed', 'five_referrals');
            ELSE
                INSERT INTO public.kasipromoter_attempt(user_id, outcome, source)
                VALUES (NEW.referrer_user_id, 'blocked', 'five_referrals');
            END IF;
        END IF;
    END IF;
    RETURN NEW;
END;
$$;

-- =====================================================================
-- 4. Duplicate submissions: one pending per user per type
-- =====================================================================
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
        RAISE EXCEPTION 'You already have a pending application.' USING ERRCODE = 'PT409';
    END IF;
    RETURN NEW;
END;
$$;

CREATE OR REPLACE FUNCTION "services"."prevent_duplicate_pending_submission"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET search_path = public
    AS $$
BEGIN
    IF NEW.status = 'pending' AND EXISTS (
        SELECT 1 FROM services.get_involved_submissions s
        WHERE s.user_id = NEW.user_id AND s.submission_type = NEW.submission_type AND s.status = 'pending'
    ) THEN
        RAISE EXCEPTION 'You already have a pending application.' USING ERRCODE = 'PT409';
    END IF;
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS "prevent_duplicate_pending_submission_trigger" ON "services"."get_involved_submissions";
CREATE TRIGGER "prevent_duplicate_pending_submission_trigger"
    BEFORE INSERT ON "services"."get_involved_submissions"
    FOR EACH ROW EXECUTE FUNCTION "services"."prevent_duplicate_pending_submission"();

-- =====================================================================
-- 5. Notifications: "under review" on submit, verdict on decision
-- =====================================================================
CREATE OR REPLACE FUNCTION "services"."notify_get_involved_submitted"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET search_path = public
    AS $$
BEGIN
    INSERT INTO engagements.notification(title, body, type, channel, user_id, data)
    VALUES (
        'Get Involved application received',
        'We have received your Get Involved application for ' || NEW.organisation_name
            || '. It is now being reviewed.',
        'other', 'push', NEW.user_id,
        jsonb_build_object(
            'kind', 'get_involved', 'event', 'submitted',
            'submission_id', NEW.id, 'organisation_name', NEW.organisation_name,
            'status', 'pending', 'decided_at', now()
        )
    );
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS "notify_get_involved_submitted_trigger" ON "services"."get_involved_submissions";
CREATE TRIGGER "notify_get_involved_submitted_trigger"
    AFTER INSERT ON "services"."get_involved_submissions"
    FOR EACH ROW EXECUTE FUNCTION "services"."notify_get_involved_submitted"();

CREATE OR REPLACE FUNCTION "services"."notify_partner_application_submitted"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET search_path = public
    AS $$
DECLARE
    _title text;
BEGIN
    SELECT title INTO _title FROM services.partner WHERE id = NEW.partner_id;
    _title := COALESCE(_title, 'Application');
    INSERT INTO engagements.notification(title, body, type, channel, user_id, data)
    VALUES (
        _title || ' application received',
        'We have received your ' || _title || ' application (#' || NEW.id || '). It is now being reviewed.',
        'other', 'push', NEW.user_id,
        jsonb_build_object(
            'kind', 'partner_application', 'event', 'submitted',
            'application_id', NEW.id, 'partner_id', NEW.partner_id,
            'application_type', _title, 'status', 'pending', 'decided_at', now()
        )
    );
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS "notify_partner_application_submitted_trigger" ON "services"."partner_application";
CREATE TRIGGER "notify_partner_application_submitted_trigger"
    AFTER INSERT ON "services"."partner_application"
    FOR EACH ROW EXECUTE FUNCTION "services"."notify_partner_application_submitted"();

-- verdict notifications now carry the event name too
CREATE OR REPLACE FUNCTION "services"."notify_get_involved_verdict"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET search_path = public
    AS $$
DECLARE
    _body text;
    _event text;
BEGIN
    IF OLD.status = 'pending' AND NEW.status IN ('approved', 'rejected') THEN
        _event := CASE WHEN NEW.status = 'approved' THEN 'approved' ELSE 'declined' END;
        IF NEW.status = 'approved' THEN
            _body := 'Great news! Your Get Involved application for ' || NEW.organisation_name
                  || ' has been approved and your account is now a Corporate account.';
        ELSE
            _body := 'Your Get Involved application for ' || NEW.organisation_name || ' was not approved.'
                  || COALESCE(' Reason: ' || NEW.decision_reason, '');
        END IF;

        INSERT INTO engagements.notification(title, body, type, channel, user_id, data)
        VALUES (
            'Get Involved application ' || CASE WHEN NEW.status = 'approved' THEN 'approved' ELSE 'declined' END,
            _body, 'other', 'push', NEW.user_id,
            jsonb_build_object(
                'kind', 'get_involved', 'event', _event,
                'submission_id', NEW.id, 'organisation_name', NEW.organisation_name,
                'status', _event, 'reason', NEW.decision_reason,
                'decided_at', COALESCE(NEW.reviewed_at, now())
            )
        );
    END IF;
    RETURN NEW;
END;
$$;

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
        RETURN NEW;
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
        _title || ' application ' || _status, _body, 'other', 'push', NEW.user_id,
        jsonb_build_object(
            'kind', 'partner_application', 'event', _status,
            'application_id', NEW.id, 'partner_id', NEW.partner_id,
            'application_type', _title, 'status', _status, 'reason', NEW.decline_reason,
            'decided_at', COALESCE(NEW.reviewed_at, now())
        )
    );
    RETURN NEW;
END;
$$;

-- =====================================================================
-- 6. Review functions: idempotency key, Corporate upgrade, exact errors
-- =====================================================================
ALTER TABLE "services"."get_involved_audit" ADD COLUMN IF NOT EXISTS "idempotency_key" text;
ALTER TABLE "services"."partner_application_audit" ADD COLUMN IF NOT EXISTS "idempotency_key" text;
CREATE UNIQUE INDEX IF NOT EXISTS "get_involved_audit_idem_key"
    ON "services"."get_involved_audit" ("submission_id", "idempotency_key") WHERE "idempotency_key" IS NOT NULL;
CREATE UNIQUE INDEX IF NOT EXISTS "partner_application_audit_idem_key"
    ON "services"."partner_application_audit" ("application_id", "idempotency_key") WHERE "idempotency_key" IS NOT NULL;

DROP FUNCTION IF EXISTS "services"."review_get_involved_submission"(uuid, text, text, uuid);
CREATE OR REPLACE FUNCTION "services"."review_get_involved_submission"(
    "_submission_id" uuid,
    "_decision" text,
    "_reason" text DEFAULT NULL,
    "_admin_id" uuid DEFAULT NULL,
    "_idempotency_key" text DEFAULT NULL
) RETURNS TABLE("submission_id" uuid, "status" text, "reviewed_at" timestamptz, "already_applied" boolean, "upgraded" boolean)
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET search_path = public
    AS $$
DECLARE
    _admin uuid;
    _action text;
    _target text;
    _reason_clean text;
    _row services.get_involved_submissions%ROWTYPE;
    _now timestamptz := now();
    _upgraded boolean := false;
    _n int;
BEGIN
    IF auth.role() = 'service_role' THEN
        _admin := _admin_id;
    ELSE
        _admin := auth.uid();
        IF _admin IS NULL OR NOT public.is_admin() THEN
            RAISE EXCEPTION 'FORBIDDEN: only an admin can review submissions' USING ERRCODE = 'PT403';
        END IF;
    END IF;

    _decision := lower(trim(COALESCE(_decision, '')));
    IF _decision IN ('approve', 'approved') THEN
        _action := 'approve'; _target := 'approved';
    ELSIF _decision IN ('reject', 'rejected', 'decline', 'declined') THEN
        _action := 'reject'; _target := 'rejected';
    ELSE
        RAISE EXCEPTION 'INVALID_DECISION: decision must be approve or reject' USING ERRCODE = 'PT422';
    END IF;

    _reason_clean := NULLIF(trim(COALESCE(_reason, '')), '');
    IF _action = 'reject' THEN
        IF _reason_clean IS NULL OR char_length(_reason_clean) < 5 THEN
            RAISE EXCEPTION 'REASON_REQUIRED: Reason required to decline.' USING ERRCODE = 'PT422';
        END IF;
        IF char_length(_reason_clean) > 500 THEN
            RAISE EXCEPTION 'REASON_TOO_LONG: the reason can be at most 500 characters' USING ERRCODE = 'PT422';
        END IF;
    ELSE
        _reason_clean := NULL;
    END IF;

    SELECT * INTO _row FROM services.get_involved_submissions s WHERE s.id = _submission_id FOR UPDATE;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'NOT_FOUND: submission does not exist' USING ERRCODE = 'P0002';
    END IF;

    -- a retry of the same request (same key) returns the first result unchanged
    IF _idempotency_key IS NOT NULL AND EXISTS (
        SELECT 1 FROM services.get_involved_audit a
        WHERE a.submission_id = _submission_id AND a.idempotency_key = _idempotency_key
    ) THEN
        RETURN QUERY SELECT _row.id, _row.status, _row.reviewed_at, true,
            (_row.status = 'approved' AND EXISTS (
                SELECT 1 FROM public.profile p WHERE p.user_id = _row.user_id
                  AND p.upgraded_by_submission_id = _row.id));
        RETURN;
    END IF;

    IF _row.status = _target THEN
        RETURN QUERY SELECT _row.id, _row.status, _row.reviewed_at, true, false;
        RETURN;
    END IF;

    IF _row.status <> 'pending' THEN
        RAISE EXCEPTION 'INVALID_TRANSITION: Application already reviewed.' USING ERRCODE = 'PT409';
    END IF;

    UPDATE services.get_involved_submissions s
    SET status = _target, decision_reason = _reason_clean, reviewed_by = _admin, reviewed_at = _now
    WHERE s.id = _submission_id;

    -- Approval upgrades the applicant to Corporate in this same transaction; if
    -- it cannot be done the whole approval rolls back. A rejection never touches
    -- the account. An Admin (or a Driver/Spaza) keeps their role.
    IF _action = 'approve' THEN
        IF NOT EXISTS (SELECT 1 FROM public.profile p WHERE p.user_id = _row.user_id) THEN
            RAISE EXCEPTION 'The applicant profile was not found, so the approval was not saved.'
                USING ERRCODE = 'PT409';
        END IF;
        UPDATE public.profile p
        SET role = 'Corporate',
            upgraded_at = _now,
            upgraded_by_submission_id = _submission_id,
            corp_name = COALESCE(NULLIF(p.corp_name, ''), _row.organisation_name)
        WHERE p.user_id = _row.user_id
          AND p.role IN ('Ubuntunist', 'EESUpromoter', 'EESUpreneur');
        GET DIAGNOSTICS _n = ROW_COUNT;
        _upgraded := _n > 0;
    END IF;

    INSERT INTO services.get_involved_audit(submission_id, admin_id, action, from_status, to_status, reason, idempotency_key, created_at)
    VALUES (_submission_id, _admin, _action, 'pending', _target, _reason_clean, _idempotency_key, _now);

    RETURN QUERY SELECT _submission_id, _target, _now, false, _upgraded;
END;
$$;

REVOKE ALL ON FUNCTION "services"."review_get_involved_submission"(uuid, text, text, uuid, text) FROM PUBLIC, "anon";
GRANT EXECUTE ON FUNCTION "services"."review_get_involved_submission"(uuid, text, text, uuid, text) TO "authenticated", "service_role";

DROP FUNCTION IF EXISTS "services"."review_partner_application"(integer, text, text, uuid);
CREATE OR REPLACE FUNCTION "services"."review_partner_application"(
    "_application_id" integer,
    "_decision" text,
    "_reason" text DEFAULT NULL,
    "_admin_id" uuid DEFAULT NULL,
    "_idempotency_key" text DEFAULT NULL
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
    IF auth.role() = 'service_role' THEN
        _admin := _admin_id;
    ELSE
        _admin := auth.uid();
        IF _admin IS NULL OR NOT public.is_admin() THEN
            RAISE EXCEPTION 'FORBIDDEN: only an admin can review applications' USING ERRCODE = 'PT403';
        END IF;
    END IF;

    _decision := lower(trim(COALESCE(_decision, '')));
    IF _decision IN ('approve', 'approved') THEN
        _action := 'approve'; _target := 'approved';
    ELSIF _decision IN ('decline', 'declined', 'reject', 'rejected') THEN
        _action := 'decline'; _target := 'declined';
    ELSE
        RAISE EXCEPTION 'INVALID_DECISION: decision must be approve or decline' USING ERRCODE = 'PT422';
    END IF;

    _reason_clean := NULLIF(trim(COALESCE(_reason, '')), '');
    IF _action = 'decline' THEN
        IF _reason_clean IS NULL OR char_length(_reason_clean) < 5 THEN
            RAISE EXCEPTION 'REASON_REQUIRED: Reason required to decline.' USING ERRCODE = 'PT422';
        END IF;
        IF char_length(_reason_clean) > 500 THEN
            RAISE EXCEPTION 'REASON_TOO_LONG: the reason can be at most 500 characters' USING ERRCODE = 'PT422';
        END IF;
    ELSE
        _reason_clean := NULL;
    END IF;

    SELECT * INTO _app FROM services.partner_application a WHERE a.id = _application_id FOR UPDATE;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'NOT_FOUND: application % does not exist', _application_id USING ERRCODE = 'P0002';
    END IF;

    IF _idempotency_key IS NOT NULL AND EXISTS (
        SELECT 1 FROM services.partner_application_audit a
        WHERE a.application_id = _application_id AND a.idempotency_key = _idempotency_key
    ) THEN
        RETURN QUERY SELECT _app.id, _app.status, _app.reviewed_at, true;
        RETURN;
    END IF;

    IF _app.status = _target THEN
        RETURN QUERY SELECT _app.id, _app.status, _app.reviewed_at, true;
        RETURN;
    END IF;

    IF _app.status <> 'pending' THEN
        RAISE EXCEPTION 'INVALID_TRANSITION: Application already reviewed.' USING ERRCODE = 'PT409';
    END IF;

    UPDATE services.partner_application a
    SET approved_at = CASE WHEN _action = 'approve' THEN _now END,
        rejected_at = CASE WHEN _action = 'decline' THEN _now END,
        decline_reason = _reason_clean,
        reviewed_by = _admin,
        reviewed_at = _now
    WHERE a.id = _application_id;

    INSERT INTO services.partner_application_audit(application_id, admin_id, action, from_status, to_status, reason, idempotency_key, created_at)
    VALUES (_application_id, _admin, _action, 'pending', _target, _reason_clean, _idempotency_key, _now);

    RETURN QUERY SELECT _application_id, _target, _now, false;
END;
$$;

REVOKE ALL ON FUNCTION "services"."review_partner_application"(integer, text, text, uuid, text) FROM PUBLIC, "anon";
GRANT EXECUTE ON FUNCTION "services"."review_partner_application"(integer, text, text, uuid, text) TO "authenticated", "service_role";

-- A KasiLift Organisation stays Corporate when it also becomes a Kasipreneur
-- (it just gets the shop); Admins, as before, keep their role.
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
            UPDATE profile SET role = 'EESUplift-Corporate'
            WHERE user_id = NEW.user_id AND role NOT IN ('Admin', 'Corporate');

            FOR _type IN SELECT wt.id FROM finances.wallet_type wt
            WHERE 'EESUplift-Corporate' = ANY(wt.roles)
            LOOP
                IF NOT EXISTS (SELECT 1 FROM finances.wallet w WHERE w.type = _type.id AND w.user_id = NEW.user_id) THEN
                    INSERT INTO finances.wallet(type, user_id, balance)
                    VALUES (_type.id, NEW.user_id, 0.00);
                END IF;
            END LOOP;
        ELSIF NEW.partner_id = 'eesupreneur' THEN
            UPDATE profile SET role = 'EESUpreneur'
            WHERE user_id = NEW.user_id AND role NOT IN ('Admin', 'Corporate', 'EESUplift-Corporate');

            INSERT INTO services.eesupreneur(owner_id, name)
            VALUES (NEW.user_id, 'My Shop');
        END IF;
    END IF;

    RETURN NEW;
END;
$$;

-- Kasi Spaza needs an existing Kasipreneur: a shop owner, whatever their role.
CREATE OR REPLACE FUNCTION "services"."partner_eligibility_for"("_user_id" uuid, "_partner_id" text)
    RETURNS TABLE("eligible" boolean, "reason" text)
    LANGUAGE "plpgsql" STABLE SECURITY DEFINER
    SET search_path = public
    AS $$
DECLARE
    _key text;
BEGIN
    SELECT lower(concat(p.id, ' ', p.title)) INTO _key
    FROM services.partner p WHERE p.id = _partner_id;

    IF _key LIKE '%spaza%' THEN
        IF EXISTS (SELECT 1 FROM public.profile WHERE user_id = _user_id AND role = 'EESUpreneur')
           OR EXISTS (SELECT 1 FROM services.eesupreneur e WHERE e.owner_id = _user_id) THEN
            RETURN QUERY SELECT true, NULL::text;
        ELSE
            RETURN QUERY SELECT false, 'You must already be a KasiPreneur to apply to be a Kasi Spaza.'::text;
        END IF;
        RETURN;
    END IF;

    IF _key LIKE '%eesupreneur%' OR _key LIKE '%kasipreneur%' THEN
        IF EXISTS (
            SELECT 1
            FROM communities.eesupool ep
            JOIN communities.eesupool_member a
                ON a.eesupool_id = ep.id AND a.user_id = _user_id AND a.role = 'Admin'
            WHERE ep.is_public = true
              AND (SELECT count(*) FROM communities.eesupool_member m WHERE m.eesupool_id = ep.id) > 25
        ) THEN
            RETURN QUERY SELECT true, NULL::text;
        ELSE
            RETURN QUERY SELECT false,
                'To apply to be a KasiPreneur you must be the admin of a public KasiPool with more than 25 members.'::text;
        END IF;
        RETURN;
    END IF;

    RETURN QUERY SELECT true, NULL::text;
END;
$$;

-- =====================================================================
-- 7. Reconciliation: what the admin app re-reads after every verdict
-- =====================================================================
CREATE OR REPLACE FUNCTION "services"."reconcile_get_involved"("_submission_id" uuid)
    RETURNS TABLE("status" text, "applicant_role" text, "upgraded_by_submission_id" uuid,
                  "notification_count" integer, "audit_count" integer)
    LANGUAGE "plpgsql" STABLE SECURITY DEFINER
    SET search_path = public
    AS $$
BEGIN
    IF auth.role() <> 'service_role' AND NOT public.is_admin() THEN
        RAISE EXCEPTION 'FORBIDDEN: only an admin can do this' USING ERRCODE = 'PT403';
    END IF;
    RETURN QUERY
    SELECT s.status,
           p.role::text,
           p.upgraded_by_submission_id,
           (SELECT count(*)::int FROM engagements.notification n
             WHERE n.user_id = s.user_id AND n.data->>'kind' = 'get_involved'
               AND n.data->>'submission_id' = s.id::text
               AND n.data->>'event' = CASE s.status WHEN 'approved' THEN 'approved'
                                                    WHEN 'rejected' THEN 'declined' ELSE 'submitted' END),
           (SELECT count(*)::int FROM services.get_involved_audit a WHERE a.submission_id = s.id)
    FROM services.get_involved_submissions s
    LEFT JOIN public.profile p ON p.user_id = s.user_id
    WHERE s.id = _submission_id;
END;
$$;

CREATE OR REPLACE FUNCTION "services"."reconcile_partner_application"("_application_id" integer)
    RETURNS TABLE("status" text, "applicant_role" text, "notification_count" integer, "audit_count" integer)
    LANGUAGE "plpgsql" STABLE SECURITY DEFINER
    SET search_path = public
    AS $$
BEGIN
    IF auth.role() <> 'service_role' AND NOT public.is_admin() THEN
        RAISE EXCEPTION 'FORBIDDEN: only an admin can do this' USING ERRCODE = 'PT403';
    END IF;
    RETURN QUERY
    SELECT a.status,
           p.role::text,
           (SELECT count(*)::int FROM engagements.notification n
             WHERE n.user_id = a.user_id AND n.data->>'kind' = 'partner_application'
               AND n.data->>'application_id' = a.id::text
               AND n.data->>'event' = CASE a.status WHEN 'approved' THEN 'approved'
                                                    WHEN 'declined' THEN 'declined' ELSE 'submitted' END),
           (SELECT count(*)::int FROM services.partner_application_audit x WHERE x.application_id = a.id)
    FROM services.partner_application a
    LEFT JOIN public.profile p ON p.user_id = a.user_id
    WHERE a.id = _application_id;
END;
$$;

REVOKE ALL ON FUNCTION "services"."reconcile_get_involved"(uuid) FROM PUBLIC, "anon";
GRANT EXECUTE ON FUNCTION "services"."reconcile_get_involved"(uuid) TO "authenticated", "service_role";
REVOKE ALL ON FUNCTION "services"."reconcile_partner_application"(integer) FROM PUBLIC, "anon";
GRANT EXECUTE ON FUNCTION "services"."reconcile_partner_application"(integer) TO "authenticated", "service_role";
