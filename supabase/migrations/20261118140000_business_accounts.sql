-- Business profiles as their own accounts.
--
-- 20261109160000 made the Business profile a "mode" of the person's account:
-- switching flipped profile.role to Corporate. Everything else (orders,
-- wallets, addresses, baskets, notifications, KasiPools) stayed shared.
--
-- Now each approved business gets its own account (auth user + profile row)
-- that has no password and cannot be signed into directly. The person reaches
-- it only through Switch Profile, which the switch-profile edge function does
-- by handing the app a session for the business account (and back). Because
-- the business is a separate user, all of its data is separate by itself.
--
-- * public.business_account links a business account to its owner.
-- * public.provision_business_account (service role only) creates the business
--   profile; the edge function creates the auth user first.
-- * get_profile_switch_state works from either side.
-- * switch_profile (the old role flip) is retired and every flipped account is
--   restored to its individual role.

CREATE TABLE IF NOT EXISTS public.business_account (
    business_user_id uuid PRIMARY KEY REFERENCES public.profile(user_id) ON DELETE CASCADE,
    owner_user_id uuid NOT NULL UNIQUE REFERENCES public.profile(user_id) ON DELETE CASCADE,
    created_at timestamptz NOT NULL DEFAULT now(),
    CHECK (business_user_id <> owner_user_id)
);
ALTER TABLE public.business_account ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS business_account_select_own ON public.business_account;
CREATE POLICY business_account_select_own ON public.business_account
    FOR SELECT TO authenticated
    USING (auth.uid() IN (business_user_id, owner_user_id));
REVOKE INSERT, UPDATE, DELETE ON public.business_account FROM anon, authenticated;

-- The owner of a business account, or NULL for a normal account.
CREATE OR REPLACE FUNCTION public.business_owner_of(_user_id uuid) RETURNS uuid
    LANGUAGE sql STABLE SECURITY DEFINER
    SET search_path = public
    AS $$
    SELECT owner_user_id FROM public.business_account WHERE business_user_id = _user_id
$$;
REVOKE ALL ON FUNCTION public.business_owner_of(uuid) FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.business_owner_of(uuid) TO authenticated, service_role;

-- Creates (or returns) the business profile for an owner whose Get Involved
-- application is approved. _business_user_id is the auth user the edge
-- function created for it.
CREATE OR REPLACE FUNCTION public.provision_business_account(_owner uuid, _business_user_id uuid)
    RETURNS uuid
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path = public
    AS $$
DECLARE
    _existing uuid;
    _bp public.business_profile%ROWTYPE;
    _owner_p public.profile%ROWTYPE;
BEGIN
    SELECT business_user_id INTO _existing FROM public.business_account WHERE owner_user_id = _owner;
    IF _existing IS NOT NULL THEN
        RETURN _existing;
    END IF;

    IF NOT public.has_approved_business_profile(_owner) THEN
        RAISE EXCEPTION 'Your business profile is available once your Get Involved application is approved.'
            USING ERRCODE = 'PT403';
    END IF;
    IF public.business_owner_of(_owner) IS NOT NULL THEN
        RAISE EXCEPTION 'A business account cannot have a business profile of its own.' USING ERRCODE = 'PT403';
    END IF;

    SELECT * INTO _owner_p FROM public.profile WHERE user_id = _owner;
    SELECT * INTO _bp FROM public.business_profile WHERE user_id = _owner;

    INSERT INTO public.profile (user_id, role, corp_name, corp_reg, corp_vat_no, referral_code,
                                accepted_ts_and_cs, is_approved, is_verified, foreigner, is_active)
    VALUES (_business_user_id, 'Corporate',
            COALESCE(NULLIF(btrim(_bp.business_name), ''), 'My business'),
            _bp.registration_number, _bp.vat_number,
            COALESCE(_bp.referral_code,
                     (SELECT max(referral_code) + 1 FROM public.profile)),
            true, true, COALESCE(_owner_p.is_verified, false), false, true)
    ON CONFLICT (user_id) DO NOTHING;

    -- A sign-up trigger may already have made an ordinary profile for the new
    -- auth user: turn it into the business profile.
    UPDATE public.profile
    SET role = 'Corporate',
        individual_role = NULL,
        first_name = NULL,
        last_name = NULL,
        corp_name = COALESCE(NULLIF(btrim(_bp.business_name), ''), 'My business'),
        corp_reg = _bp.registration_number,
        corp_vat_no = _bp.vat_number,
        is_verified = COALESCE(_owner_p.is_verified, false),
        foreigner = false,
        accepted_ts_and_cs = true
    WHERE user_id = _business_user_id;

    INSERT INTO public.business_account (business_user_id, owner_user_id)
    VALUES (_business_user_id, _owner);
    RETURN _business_user_id;
END;
$$;
REVOKE ALL ON FUNCTION public.provision_business_account(uuid, uuid) FROM PUBLIC, anon, authenticated;
GRANT EXECUTE ON FUNCTION public.provision_business_account(uuid, uuid) TO service_role;

-- What the Switch Profile screen needs, from either account.
CREATE OR REPLACE FUNCTION public.get_profile_switch_state()
    RETURNS TABLE("available" boolean, "active_profile" text, "business_name" text)
    LANGUAGE sql STABLE SECURITY DEFINER
    SET search_path = public
    AS $$
    WITH me AS (
        SELECT auth.uid() AS uid, public.business_owner_of(auth.uid()) AS owner
    )
    SELECT
        CASE WHEN me.owner IS NOT NULL THEN true
             ELSE public.has_approved_business_profile(me.uid) END,
        CASE WHEN me.owner IS NOT NULL THEN 'business' ELSE 'individual' END,
        COALESCE(
            (SELECT bp.business_name FROM public.business_profile bp
              WHERE bp.user_id = COALESCE(me.owner, me.uid)),
            (SELECT s.organisation_name FROM services.get_involved_submissions s
              WHERE s.user_id = COALESCE(me.owner, me.uid) AND s.status = 'approved'
              ORDER BY s.reviewed_at DESC NULLS LAST LIMIT 1))
    FROM me
$$;
REVOKE ALL ON FUNCTION public.get_profile_switch_state() FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.get_profile_switch_state() TO authenticated, service_role;

-- The owner's details as the business sees them (for the Switch Profile
-- screen's "individual" option).
CREATE OR REPLACE FUNCTION public.get_business_owner_name() RETURNS text
    LANGUAGE sql STABLE SECURITY DEFINER
    SET search_path = public
    AS $$
    SELECT NULLIF(btrim(concat_ws(' ', p.first_name, p.last_name)), '')
    FROM public.profile p
    WHERE p.user_id = public.business_owner_of(auth.uid())
$$;
REVOKE ALL ON FUNCTION public.get_business_owner_name() FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.get_business_owner_name() TO authenticated, service_role;

-- The business details (registration, VAT, ...) stay on the owner's
-- business_profile row; the business account reads them from there.
CREATE OR REPLACE FUNCTION public.get_business_profile()
    RETURNS SETOF public.business_profile
    LANGUAGE sql STABLE SECURITY DEFINER
    SET search_path = public
    AS $$
    SELECT * FROM public.business_profile
    WHERE user_id = COALESCE(public.business_owner_of(auth.uid()), auth.uid())
$$;

-- The old role flip is retired: restore every flipped account.
UPDATE public.profile
SET role = individual_role, individual_role = NULL
WHERE role = 'Corporate' AND individual_role IS NOT NULL;

CREATE OR REPLACE FUNCTION public.switch_profile("_to" text)
    RETURNS TABLE("active_profile" text, "role" text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path = public
    AS $$
BEGIN
    RAISE EXCEPTION 'Please update the app to switch profiles.' USING ERRCODE = 'PT426';
END;
$$;

-- Business accounts are found by their business name when inviting people to
-- a KasiPool (the per-profile membership columns from 20261118120000 are no
-- longer needed for this: a business is its own member).
DROP FUNCTION IF EXISTS communities.search_profiles_for_eesupool_invites(text, integer, integer);
CREATE FUNCTION communities.search_profiles_for_eesupool_invites(query_str text, pool_id integer, limit_to integer)
    RETURNS TABLE(full_name text, corporate_name text, user_id uuid, role user_role, membership_id uuid,
                  status communities.eesupool_request_status, as_business boolean)
    LANGUAGE sql STABLE SECURITY DEFINER
    SET search_path = public, communities
    AS $$
    SELECT
        CASE WHEN p.first_name IS NOT NULL OR p.last_name IS NOT NULL
             THEN concat_ws(' ', p.first_name, p.last_name) END,
        p.corp_name, p.user_id, p.role,
        (SELECT em.id FROM communities.eesupool_member em
          WHERE em.user_id = p.user_id AND em.eesupool_id = pool_id LIMIT 1),
        (SELECT er.status FROM communities.eesupool_request er
          WHERE er.user_id = p.user_id AND er.eesupool_id = pool_id LIMIT 1),
        -- Kept for older apps; a business account is its own user, so its
        -- memberships are ordinary ones.
        false
    FROM public.profile p
    WHERE p.first_name ILIKE '%' || query_str || '%'
       OR p.last_name ILIKE '%' || query_str || '%'
       OR p.corp_name ILIKE '%' || query_str || '%'
       OR CAST(p.referral_code AS TEXT) ILIKE '%' || query_str || '%'
    LIMIT limit_to
$$;
REVOKE ALL ON FUNCTION communities.search_profiles_for_eesupool_invites(text, integer, integer) FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION communities.search_profiles_for_eesupool_invites(text, integer, integer) TO authenticated, service_role;
