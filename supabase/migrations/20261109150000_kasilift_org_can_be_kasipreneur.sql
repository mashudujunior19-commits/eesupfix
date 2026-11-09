-- An approved Get Involved application makes the account Corporate. A KasiLift
-- Organisation can also be a Kasipreneur (and then a Kasi Spaza), so Corporate
-- accounts may apply for those two programmes. A Corporate account that is NOT a
-- KasiLift Organisation still cannot become a Kasipreneur.

UPDATE services.partner
SET roles = array_append(roles, 'Corporate'::user_role)
WHERE id IN ('eesupreneur', 'kasi_spaza')
  AND NOT ('Corporate'::user_role = ANY(roles));

CREATE OR REPLACE FUNCTION "services"."partner_eligibility_for"("_user_id" uuid, "_partner_id" text)
    RETURNS TABLE("eligible" boolean, "reason" text)
    LANGUAGE "plpgsql" STABLE SECURITY DEFINER
    SET search_path = public
    AS $$
DECLARE
    _key text;
    _role text;
BEGIN
    SELECT lower(concat(p.id, ' ', p.title)) INTO _key
    FROM services.partner p WHERE p.id = _partner_id;
    SELECT role::text INTO _role FROM public.profile WHERE user_id = _user_id;

    -- Kasi Spaza: needs an existing Kasipreneur (a shop owner, whatever their role).
    IF _key LIKE '%spaza%' THEN
        IF _role = 'EESUpreneur'
           OR EXISTS (SELECT 1 FROM services.eesupreneur e WHERE e.owner_id = _user_id) THEN
            RETURN QUERY SELECT true, NULL::text;
        ELSE
            RETURN QUERY SELECT false, 'You must already be a KasiPreneur to apply to be a Kasi Spaza.'::text;
        END IF;
        RETURN;
    END IF;

    -- Kasipreneur: admin of a public KasiPool with more than 25 members; a
    -- Corporate account must also be a KasiLift Organisation.
    IF _key LIKE '%eesupreneur%' OR _key LIKE '%kasipreneur%' THEN
        IF _role IN ('Corporate', 'EESUplift-Corporate') AND NOT public.is_kasilift_organisation(_user_id) THEN
            RETURN QUERY SELECT false, 'Only a Kasilift Organisation can also be a Kasipreneur.'::text;
            RETURN;
        END IF;
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
