-- Reviewing Get Involved submissions in the admin app.
--  * Admins (profile role 'Admin') can read every submission, its contacts, its
--    documents and the document files in the private bucket.
--  * Approve / reject through one function: admin only, pending -> approved |
--    rejected only, a reason is required to reject, audited, and the applicant
--    gets a notification (with the reason) in the same transaction.
--  * Users can no longer change a submission's status or the review columns.
-- Needs public.is_admin() (20261103150000).

-- 1. Review columns and audit log ------------------------------------------------
ALTER TABLE "services"."get_involved_submissions"
    ADD COLUMN IF NOT EXISTS "decision_reason" text,
    ADD COLUMN IF NOT EXISTS "reviewed_by" uuid,
    ADD COLUMN IF NOT EXISTS "reviewed_at" timestamptz;

CREATE TABLE IF NOT EXISTS "services"."get_involved_audit" (
    "id" bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "submission_id" uuid NOT NULL REFERENCES "services"."get_involved_submissions"("id") ON DELETE CASCADE,
    "admin_id" uuid,
    "action" text NOT NULL CHECK (action IN ('approve', 'reject')),
    "from_status" text NOT NULL,
    "to_status" text NOT NULL,
    "reason" text,
    "created_at" timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS "get_involved_audit_submission_idx"
    ON "services"."get_involved_audit" ("submission_id", "created_at" DESC);
ALTER TABLE "services"."get_involved_audit" ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON "services"."get_involved_audit" FROM "anon", "authenticated";
GRANT SELECT ON "services"."get_involved_audit" TO "authenticated";

DROP POLICY IF EXISTS "get_involved_audit_select_admin" ON "services"."get_involved_audit";
CREATE POLICY "get_involved_audit_select_admin" ON "services"."get_involved_audit"
    FOR SELECT TO "authenticated" USING (public.is_admin());

-- 2. Admin read access ---------------------------------------------------------------
DROP POLICY IF EXISTS "Admins can view all submissions" ON "services"."get_involved_submissions";
CREATE POLICY "Admins can view all submissions" ON "services"."get_involved_submissions"
    FOR SELECT TO "authenticated" USING (public.is_admin());

DROP POLICY IF EXISTS "Admins can view all submission documents" ON "services"."submission_documents";
CREATE POLICY "Admins can view all submission documents" ON "services"."submission_documents"
    FOR SELECT TO "authenticated" USING (public.is_admin());

DROP POLICY IF EXISTS "Admins can view all submission contacts" ON "services"."submission_contacts";
CREATE POLICY "Admins can view all submission contacts" ON "services"."submission_contacts"
    FOR SELECT TO "authenticated" USING (public.is_admin());

-- the document files themselves (private bucket, folder = applicant's user id)
DROP POLICY IF EXISTS "Admins can view all get involved documents" ON "storage"."objects";
CREATE POLICY "Admins can view all get involved documents" ON "storage"."objects"
    FOR SELECT TO "authenticated"
    USING (bucket_id = 'get_involved_documents' AND public.is_admin());

-- 3. Users cannot decide their own submission ----------------------------------------
CREATE OR REPLACE FUNCTION "services"."guard_get_involved_update"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF current_user IN ('authenticated', 'anon') THEN
        IF NEW.status          IS DISTINCT FROM OLD.status
           OR NEW.decision_reason IS DISTINCT FROM OLD.decision_reason
           OR NEW.reviewed_by     IS DISTINCT FROM OLD.reviewed_by
           OR NEW.reviewed_at     IS DISTINCT FROM OLD.reviewed_at
           OR NEW.user_id         IS DISTINCT FROM OLD.user_id THEN
            RAISE EXCEPTION 'FORBIDDEN: only a reviewer can change the outcome of a submission'
                USING ERRCODE = '42501';
        END IF;
    END IF;
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS "guard_get_involved_update_trigger" ON "services"."get_involved_submissions";
CREATE TRIGGER "guard_get_involved_update_trigger"
    BEFORE UPDATE ON "services"."get_involved_submissions"
    FOR EACH ROW EXECUTE FUNCTION "services"."guard_get_involved_update"();

-- 4. Review function -----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION "services"."review_get_involved_submission"(
    "_submission_id" uuid,
    "_decision" text,
    "_reason" text DEFAULT NULL,
    "_admin_id" uuid DEFAULT NULL
) RETURNS TABLE("submission_id" uuid, "status" text, "reviewed_at" timestamptz, "already_applied" boolean)
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
BEGIN
    IF auth.role() = 'service_role' THEN
        _admin := _admin_id;
    ELSE
        _admin := auth.uid();
        IF _admin IS NULL OR NOT public.is_admin() THEN
            RAISE EXCEPTION 'FORBIDDEN: only an admin can review submissions' USING ERRCODE = '42501';
        END IF;
    END IF;

    _decision := lower(trim(COALESCE(_decision, '')));
    IF _decision IN ('approve', 'approved') THEN
        _action := 'approve'; _target := 'approved';
    ELSIF _decision IN ('reject', 'rejected', 'decline', 'declined') THEN
        _action := 'reject'; _target := 'rejected';
    ELSE
        RAISE EXCEPTION 'INVALID_DECISION: decision must be approve or reject' USING ERRCODE = '22023';
    END IF;

    _reason_clean := NULLIF(trim(COALESCE(_reason, '')), '');
    IF _action = 'reject' THEN
        IF _reason_clean IS NULL OR char_length(_reason_clean) < 5 THEN
            RAISE EXCEPTION 'REASON_REQUIRED: give the applicant a reason (at least 5 characters)' USING ERRCODE = '22023';
        END IF;
        IF char_length(_reason_clean) > 500 THEN
            RAISE EXCEPTION 'REASON_TOO_LONG: the reason can be at most 500 characters' USING ERRCODE = '22023';
        END IF;
    ELSE
        _reason_clean := NULL;
    END IF;

    SELECT * INTO _row FROM services.get_involved_submissions s WHERE s.id = _submission_id FOR UPDATE;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'NOT_FOUND: submission does not exist' USING ERRCODE = 'P0002';
    END IF;

    IF _row.status = _target THEN
        RETURN QUERY SELECT _row.id, _row.status, _row.reviewed_at, true;
        RETURN;
    END IF;

    IF _row.status <> 'pending' THEN
        RAISE EXCEPTION 'INVALID_TRANSITION: submission is already % and cannot be %', _row.status, _target
            USING ERRCODE = '23514';
    END IF;

    UPDATE services.get_involved_submissions s
    SET status = _target,
        decision_reason = _reason_clean,
        reviewed_by = _admin,
        reviewed_at = _now
    WHERE s.id = _submission_id;

    INSERT INTO services.get_involved_audit(submission_id, admin_id, action, from_status, to_status, reason, created_at)
    VALUES (_submission_id, _admin, _action, 'pending', _target, _reason_clean, _now);

    RETURN QUERY SELECT _submission_id, _target, _now, false;
END;
$$;

REVOKE ALL ON FUNCTION "services"."review_get_involved_submission"(uuid, text, text, uuid) FROM PUBLIC, "anon";
GRANT EXECUTE ON FUNCTION "services"."review_get_involved_submission"(uuid, text, text, uuid) TO "authenticated", "service_role";

-- 5. Verdict notification (once, with the reason) ----------------------------------------------
CREATE OR REPLACE FUNCTION "services"."notify_get_involved_verdict"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET search_path = public
    AS $$
DECLARE
    _body text;
BEGIN
    IF OLD.status = 'pending' AND NEW.status IN ('approved', 'rejected') THEN
        IF NEW.status = 'approved' THEN
            _body := 'Great news! Your Get Involved application for ' || NEW.organisation_name || ' has been approved.';
        ELSE
            _body := 'Your Get Involved application for ' || NEW.organisation_name || ' was not approved.'
                  || COALESCE(' Reason: ' || NEW.decision_reason, '');
        END IF;

        INSERT INTO engagements.notification(title, body, type, channel, user_id, data)
        VALUES (
            'Get Involved application ' || CASE WHEN NEW.status = 'approved' THEN 'approved' ELSE 'not approved' END,
            _body,
            'other',
            'push',
            NEW.user_id,
            jsonb_build_object(
                'kind', 'get_involved',
                'submission_id', NEW.id,
                'organisation_name', NEW.organisation_name,
                'status', NEW.status,
                'reason', NEW.decision_reason,
                'decided_at', COALESCE(NEW.reviewed_at, now())
            )
        );
    END IF;
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS "notify_get_involved_verdict_trigger" ON "services"."get_involved_submissions";
CREATE TRIGGER "notify_get_involved_verdict_trigger"
    AFTER UPDATE ON "services"."get_involved_submissions"
    FOR EACH ROW EXECUTE FUNCTION "services"."notify_get_involved_verdict"();
