-- Who may apply:
--  * KasiPreneur: the applicant must be the admin of a PUBLIC KasiPool with
--    more than 25 members.
--  * Kasi Spaza: the applicant must already be a KasiPreneur.
-- Enforced when the application is created, so it holds whatever the app does.

CREATE OR REPLACE FUNCTION "services"."partner_eligibility_for"("_user_id" "uuid", "_partner_id" "text")
    RETURNS TABLE("eligible" boolean, "reason" "text")
    LANGUAGE "plpgsql" STABLE SECURITY DEFINER
    SET search_path = public
    AS $$
DECLARE
    _key text;
BEGIN
    SELECT lower(concat(p.id, ' ', p.title)) INTO _key
    FROM services.partner p WHERE p.id = _partner_id;

    -- Kasi Spaza: must already be a KasiPreneur.
    IF _key LIKE '%spaza%' THEN
        IF EXISTS (SELECT 1 FROM public.profile WHERE user_id = _user_id AND role = 'EESUpreneur') THEN
            RETURN QUERY SELECT true, NULL::text;
        ELSE
            RETURN QUERY SELECT false, 'You must already be a KasiPreneur to apply to be a Kasi Spaza.'::text;
        END IF;
        RETURN;
    END IF;

    -- KasiPreneur: admin of a public KasiPool with more than 25 members.
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

CREATE OR REPLACE FUNCTION "services"."get_partner_eligibility"("_partner_id" "text")
    RETURNS TABLE("eligible" boolean, "reason" "text")
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET search_path = public
    AS $$
    SELECT * FROM services.partner_eligibility_for(auth.uid(), _partner_id);
$$;

REVOKE ALL ON FUNCTION "services"."partner_eligibility_for"("uuid", "text") FROM PUBLIC, "anon", "authenticated";
GRANT EXECUTE ON FUNCTION "services"."partner_eligibility_for"("uuid", "text") TO "service_role";
REVOKE ALL ON FUNCTION "services"."get_partner_eligibility"("text") FROM PUBLIC, "anon";
GRANT EXECUTE ON FUNCTION "services"."get_partner_eligibility"("text") TO "authenticated", "service_role";

CREATE OR REPLACE FUNCTION "services"."enforce_partner_eligibility"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET search_path = public
    AS $$
DECLARE
    _eligible boolean;
    _reason text;
BEGIN
    SELECT e.eligible, e.reason INTO _eligible, _reason
    FROM services.partner_eligibility_for(NEW.user_id, NEW.partner_id) e;

    IF NOT COALESCE(_eligible, false) THEN
        RAISE EXCEPTION '%', COALESCE(_reason, 'You are not eligible to apply for this.');
    END IF;
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS "enforce_partner_eligibility_trigger" ON "services"."partner_application";
CREATE TRIGGER "enforce_partner_eligibility_trigger"
    BEFORE INSERT ON "services"."partner_application"
    FOR EACH ROW EXECUTE FUNCTION "services"."enforce_partner_eligibility"();
