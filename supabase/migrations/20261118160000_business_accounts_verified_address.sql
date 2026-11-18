-- Business accounts: verified on approval, with the application's address.
--
-- * An approved Get Involved application is the business's verification, so
--   the business account is verified from the start (it has no ID number to
--   verify with).
-- * The address given in the application becomes the business account's
--   primary address (type Business), so it is not asked for one again.

CREATE OR REPLACE FUNCTION public.add_business_account_address(_business_user_id uuid, _owner uuid)
    RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path = public, geolocations
    AS $$
DECLARE
    _bp public.business_profile%ROWTYPE;
    _owner_phone text;
BEGIN
    SELECT * INTO _bp FROM public.business_profile WHERE user_id = _owner;
    IF NULLIF(btrim(COALESCE(_bp.address, '')), '') IS NULL THEN
        RETURN;
    END IF;
    IF EXISTS (SELECT 1 FROM geolocations.address WHERE user_id = _business_user_id) THEN
        RETURN;
    END IF;
    SELECT phone INTO _owner_phone FROM public.profile WHERE user_id = _owner;

    INSERT INTO geolocations.address (user_id, recipient_name, recipient_phone, street_address,
                                      type, province, is_primary)
    VALUES (_business_user_id,
            COALESCE(NULLIF(btrim(_bp.business_name), ''), 'My business'),
            COALESCE(_owner_phone, ''),
            btrim(_bp.address),
            'Business',
            COALESCE(NULLIF(btrim(_bp.province), ''), ''),
            true);
END;
$$;
REVOKE ALL ON FUNCTION public.add_business_account_address(uuid, uuid) FROM PUBLIC, anon, authenticated;
GRANT EXECUTE ON FUNCTION public.add_business_account_address(uuid, uuid) TO service_role;

CREATE OR REPLACE FUNCTION public.provision_business_account(_owner uuid, _business_user_id uuid)
    RETURNS uuid
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path = public
    AS $$
DECLARE
    _existing uuid;
    _bp public.business_profile%ROWTYPE;
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

    SELECT * INTO _bp FROM public.business_profile WHERE user_id = _owner;

    -- Approved by an admin, so verified (a business has no ID number).
    INSERT INTO public.profile (user_id, role, corp_name, corp_reg, corp_vat_no, referral_code,
                                accepted_ts_and_cs, is_approved, is_verified, foreigner, is_active)
    VALUES (_business_user_id, 'Corporate',
            COALESCE(NULLIF(btrim(_bp.business_name), ''), 'My business'),
            _bp.registration_number, _bp.vat_number,
            COALESCE(_bp.referral_code,
                     (SELECT max(referral_code) + 1 FROM public.profile)),
            true, true, true, false, true)
    ON CONFLICT (user_id) DO NOTHING;

    UPDATE public.profile
    SET role = 'Corporate',
        individual_role = NULL,
        first_name = NULL,
        last_name = NULL,
        corp_name = COALESCE(NULLIF(btrim(_bp.business_name), ''), 'My business'),
        corp_reg = _bp.registration_number,
        corp_vat_no = _bp.vat_number,
        is_verified = true,
        foreigner = false,
        accepted_ts_and_cs = true
    WHERE user_id = _business_user_id;

    INSERT INTO public.business_account (business_user_id, owner_user_id)
    VALUES (_business_user_id, _owner);

    PERFORM public.add_business_account_address(_business_user_id, _owner);
    RETURN _business_user_id;
END;
$$;
REVOKE ALL ON FUNCTION public.provision_business_account(uuid, uuid) FROM PUBLIC, anon, authenticated;
GRANT EXECUTE ON FUNCTION public.provision_business_account(uuid, uuid) TO service_role;

-- Business accounts created before this.
UPDATE public.profile p
SET is_verified = true
FROM public.business_account ba
WHERE p.user_id = ba.business_user_id AND NOT p.is_verified;

SELECT public.add_business_account_address(ba.business_user_id, ba.owner_user_id)
FROM public.business_account ba;
