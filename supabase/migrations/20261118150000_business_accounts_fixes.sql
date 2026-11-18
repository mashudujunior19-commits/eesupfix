-- Business accounts: fixes found while testing 20261118140000.
--
-- * The sign-up trigger (public.handle_new_user) runs on every auth.users
--   update. For a business account it made an ordinary Ubuntunist profile with
--   a new referral code and recorded a referral from the master code. Business
--   accounts (app_metadata.business_of, set by the switch-profile function) now
--   skip it entirely.
-- * Business accounts created before the fix are rebuilt with the business's
--   own referral code and without that referral (no money had moved).

CREATE OR REPLACE FUNCTION pg_temp.patch(_fn regprocedure, _from text, _to text) RETURNS void
    LANGUAGE plpgsql AS $$
DECLARE
    d text := pg_get_functiondef(_fn);
BEGIN
    IF position(_from IN d) = 0 THEN
        RAISE EXCEPTION 'business_accounts: "%" not found in %', _from, _fn;
    END IF;
    EXECUTE replace(d, _from, _to);
END;
$$;

SELECT pg_temp.patch('public.handle_new_user()',
    'IF COALESCE(NEW.raw_app_meta_data->>''provider'', ''email'') NOT IN (''email'', ''phone'') THEN',
    'IF NEW.raw_app_meta_data ? ''business_of'' THEN
    RETURN NEW;
  END IF;

  IF COALESCE(NEW.raw_app_meta_data->>''provider'', ''email'') NOT IN (''email'', ''phone'') THEN');

DO $$
DECLARE
    r record;
BEGIN
    FOR r IN
        SELECT ba.business_user_id AS bid, ba.owner_user_id AS oid, ba.created_at,
               bp.business_name, bp.registration_number, bp.vat_number, bp.referral_code,
               o.is_verified
        FROM public.business_account ba
        JOIN public.profile o ON o.user_id = ba.owner_user_id
        LEFT JOIN public.business_profile bp ON bp.user_id = ba.owner_user_id
        JOIN public.profile b ON b.user_id = ba.business_user_id
        WHERE bp.referral_code IS NOT NULL AND b.referral_code IS DISTINCT FROM bp.referral_code
    LOOP
        DELETE FROM public.referral WHERE refereed_user_id = r.bid;
        DELETE FROM public.business_account WHERE business_user_id = r.bid;
        DELETE FROM public.profile WHERE user_id = r.bid;
        INSERT INTO public.profile (user_id, role, corp_name, corp_reg, corp_vat_no, referral_code,
                                    accepted_ts_and_cs, is_approved, is_verified, foreigner, is_active)
        VALUES (r.bid, 'Corporate', COALESCE(NULLIF(btrim(r.business_name), ''), 'My business'),
                r.registration_number, r.vat_number, r.referral_code,
                true, true, COALESCE(r.is_verified, false), false, true);
        INSERT INTO public.business_account (business_user_id, owner_user_id, created_at)
        VALUES (r.bid, r.oid, r.created_at);
    END LOOP;
END;
$$;

DELETE FROM public.referral r
USING public.business_account ba
WHERE r.refereed_user_id = ba.business_user_id;
