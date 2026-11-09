-- Individual <-> Business profile.
--
-- An approved Get Involved application no longer turns the account into Corporate
-- by itself. The person keeps their Individual profile and, only once an
-- application of theirs is approved, can SWITCH to their Business profile (and
-- back). While the Business profile is active the account behaves as a Corporate
-- account everywhere (wallets, roles, partner rules), because the active profile
-- is the account's role: 'Corporate' while in business mode, and the individual
-- role (Ubuntunist / EESUpromoter / EESUpreneur) otherwise. The individual role
-- is remembered in individual_role so switching back restores it exactly.
--
-- Replaces the Corporate-on-approval step of 20261109140000.

ALTER TABLE "public"."profile" ADD COLUMN IF NOT EXISTS "individual_role" "public"."user_role";

-- Has this user an approved Get Involved application?
CREATE OR REPLACE FUNCTION "public"."has_approved_business_profile"("_user_id" uuid) RETURNS boolean
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET search_path = public
    AS $$
    SELECT EXISTS (
        SELECT 1 FROM services.get_involved_submissions s
        WHERE s.user_id = _user_id AND s.status = 'approved'
    )
$$;
REVOKE ALL ON FUNCTION "public"."has_approved_business_profile"(uuid) FROM PUBLIC, "anon";
GRANT EXECUTE ON FUNCTION "public"."has_approved_business_profile"(uuid) TO "authenticated", "service_role";

-- What the menu needs: may this user switch, and which profile is active?
CREATE OR REPLACE FUNCTION "public"."get_profile_switch_state"()
    RETURNS TABLE("available" boolean, "active_profile" text, "business_name" text)
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET search_path = public
    AS $$
    SELECT
        public.has_approved_business_profile(auth.uid())
            AND (p.role IN ('Ubuntunist', 'EESUpromoter', 'EESUpreneur')
                 OR (p.role = 'Corporate' AND p.individual_role IS NOT NULL)),
        CASE WHEN p.role = 'Corporate' AND p.individual_role IS NOT NULL THEN 'business' ELSE 'individual' END,
        (SELECT s.organisation_name FROM services.get_involved_submissions s
          WHERE s.user_id = p.user_id AND s.status = 'approved'
          ORDER BY s.reviewed_at DESC NULLS LAST LIMIT 1)
    FROM public.profile p
    WHERE p.user_id = auth.uid()
$$;
REVOKE ALL ON FUNCTION "public"."get_profile_switch_state"() FROM PUBLIC, "anon";
GRANT EXECUTE ON FUNCTION "public"."get_profile_switch_state"() TO "authenticated", "service_role";

-- The only way to change between the two profiles.
CREATE OR REPLACE FUNCTION "public"."switch_profile"("_to" text)
    RETURNS TABLE("active_profile" text, "role" text)
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET search_path = public
    AS $$
DECLARE
    _uid uuid := auth.uid();
    _p public.profile%ROWTYPE;
BEGIN
    IF _uid IS NULL THEN
        RAISE EXCEPTION 'FORBIDDEN: sign in first' USING ERRCODE = 'PT403';
    END IF;
    _to := lower(trim(COALESCE(_to, '')));
    IF _to NOT IN ('business', 'individual') THEN
        RAISE EXCEPTION 'Choose the business or the individual profile.' USING ERRCODE = 'PT422';
    END IF;

    SELECT * INTO _p FROM public.profile WHERE user_id = _uid FOR UPDATE;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Your profile was not found.' USING ERRCODE = 'PT409';
    END IF;

    IF _to = 'business' THEN
        IF NOT public.has_approved_business_profile(_uid) THEN
            RAISE EXCEPTION 'Your business profile is available once your Get Involved application is approved.'
                USING ERRCODE = 'PT403';
        END IF;
        IF _p.role = 'Corporate' AND _p.individual_role IS NOT NULL THEN
            RETURN QUERY SELECT 'business'::text, _p.role::text;   -- already there
            RETURN;
        END IF;
        IF _p.role NOT IN ('Ubuntunist', 'EESUpromoter', 'EESUpreneur') THEN
            RAISE EXCEPTION 'This account type cannot switch profiles.' USING ERRCODE = 'PT403';
        END IF;
        UPDATE public.profile
        SET individual_role = _p.role, role = 'Corporate'
        WHERE user_id = _uid;
        RETURN QUERY SELECT 'business'::text, 'Corporate'::text;
    ELSE
        IF _p.role = 'Corporate' AND _p.individual_role IS NOT NULL THEN
            UPDATE public.profile
            SET role = _p.individual_role, individual_role = NULL
            WHERE user_id = _uid;
            RETURN QUERY SELECT 'individual'::text, _p.individual_role::text;
        ELSE
            RETURN QUERY SELECT 'individual'::text, _p.role::text;   -- already there
        END IF;
    END IF;
END;
$$;
REVOKE ALL ON FUNCTION "public"."switch_profile"(text) FROM PUBLIC, "anon";
GRANT EXECUTE ON FUNCTION "public"."switch_profile"(text) TO "authenticated", "service_role";

-- Users cannot set the individual role themselves either.
CREATE OR REPLACE FUNCTION "public"."guard_profile_write"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    _n text;
BEGIN
    IF TG_OP = 'INSERT' THEN
        IF NEW.phone IS NOT NULL AND btrim(NEW.phone) <> '' THEN
            NEW.phone := COALESCE(public.normalize_sa_phone(NEW.phone), NEW.phone);
        END IF;
        RETURN NEW;
    END IF;

    IF NEW.phone IS NULL OR btrim(NEW.phone) = '' THEN
        NEW.phone := OLD.phone;
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

    IF NEW.referral_code IS DISTINCT FROM OLD.referral_code THEN
        RAISE EXCEPTION 'The referral code cannot be changed or transferred.' USING ERRCODE = 'PT403';
    END IF;

    IF current_user IN ('authenticated', 'anon') THEN
        IF NEW.role IS DISTINCT FROM OLD.role
           OR NEW.individual_role IS DISTINCT FROM OLD.individual_role
           OR NEW.upgraded_at IS DISTINCT FROM OLD.upgraded_at
           OR NEW.upgraded_by_submission_id IS DISTINCT FROM OLD.upgraded_by_submission_id
           OR NEW.is_kasipromoter IS DISTINCT FROM OLD.is_kasipromoter THEN
            RAISE EXCEPTION 'FORBIDDEN: this account field can only be changed by a reviewer.' USING ERRCODE = 'PT403';
        END IF;
    END IF;

    IF NEW.role = 'EESUpromoter' AND OLD.role IS DISTINCT FROM 'EESUpromoter'
       AND NOT public.is_kasilift_organisation(NEW.user_id) THEN
        RAISE LOG 'kasipromoter blocked for user % (not a KasiLift Organisation)', NEW.user_id;
        RAISE EXCEPTION 'You cannot be a Kasipromoter. Only a Kasilift Organisation can refer and become a Kasipromoter.'
            USING ERRCODE = 'PT403';
    END IF;

    RETURN NEW;
END;
$$;

-- Approving no longer changes the role: it unlocks the business profile. The
-- profile is only marked (upgraded_at / upgraded_by_submission_id) so the admin
-- can see which application unlocked it.
DROP FUNCTION IF EXISTS "services"."review_get_involved_submission"(uuid, text, text, uuid, text);
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
    _unlocked boolean := false;
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

    -- Approval unlocks the business profile (in the same transaction); a
    -- rejection never touches the account.
    IF _action = 'approve' THEN
        IF NOT EXISTS (SELECT 1 FROM public.profile p WHERE p.user_id = _row.user_id) THEN
            RAISE EXCEPTION 'The applicant profile was not found, so the approval was not saved.'
                USING ERRCODE = 'PT409';
        END IF;
        UPDATE public.profile p
        SET upgraded_at = COALESCE(p.upgraded_at, _now),
            upgraded_by_submission_id = COALESCE(p.upgraded_by_submission_id, _submission_id),
            corp_name = COALESCE(NULLIF(p.corp_name, ''), _row.organisation_name)
        WHERE p.user_id = _row.user_id;
        GET DIAGNOSTICS _n = ROW_COUNT;
        _unlocked := _n > 0;
    END IF;

    INSERT INTO services.get_involved_audit(submission_id, admin_id, action, from_status, to_status, reason, idempotency_key, created_at)
    VALUES (_submission_id, _admin, _action, 'pending', _target, _reason_clean, _idempotency_key, _now);

    RETURN QUERY SELECT _submission_id, _target, _now, false, _unlocked;
END;
$$;
REVOKE ALL ON FUNCTION "services"."review_get_involved_submission"(uuid, text, text, uuid, text) FROM PUBLIC, "anon";
GRANT EXECUTE ON FUNCTION "services"."review_get_involved_submission"(uuid, text, text, uuid, text) TO "authenticated", "service_role";

-- Approval message now says what the person can do next.
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
                  || ' has been approved. You can now switch to your business profile from the menu.';
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

-- While the business profile is active the role is 'Corporate': an approved
-- Kasipreneur / EESUplift application must not overwrite that, but must still be
-- remembered for when the person switches back to their individual profile.
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
            -- in business mode the individual role to return to becomes Kasipreneur
            UPDATE profile SET individual_role = 'EESUpreneur'
            WHERE user_id = NEW.user_id AND role = 'Corporate' AND individual_role IS NOT NULL;

            INSERT INTO services.eesupreneur(owner_id, name)
            VALUES (NEW.user_id, 'My Shop');
        END IF;
    END IF;

    RETURN NEW;
END;
$$;

-- Mark the people already approved (no role change), so the admin can link to
-- the application and the account is consistent with the new rule.
UPDATE public.profile p
SET upgraded_at = COALESCE(p.upgraded_at, s.reviewed_at),
    upgraded_by_submission_id = COALESCE(p.upgraded_by_submission_id, s.id)
FROM (
    SELECT DISTINCT ON (user_id) user_id, id, reviewed_at
    FROM services.get_involved_submissions
    WHERE status = 'approved'
    ORDER BY user_id, reviewed_at DESC NULLS LAST
) s
WHERE s.user_id = p.user_id AND p.upgraded_by_submission_id IS NULL;
