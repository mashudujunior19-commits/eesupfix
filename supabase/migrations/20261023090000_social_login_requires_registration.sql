-- Registration stays compulsory: Google / Apple sign-in may only log in people
-- who already registered, so a first-time social login must not auto-create a
-- profile (and referral) with empty name / ID number.
-- Body is the existing public.handle_new_user() plus the guard at the top.

CREATE OR REPLACE FUNCTION "public"."handle_new_user"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
DECLARE
  ref_name TEXT;
  master_referral_code text;
  is_confirmed BOOLEAN DEFAULT FALSE;
BEGIN
  -- Google / Apple logins never create a Towris profile: registering (with the
  -- name, ID number and/or referral code) is only done through the sign-up
  -- form. Social sign-in is for people who already registered.
  IF COALESCE(NEW.raw_app_meta_data->>'provider', 'email') NOT IN ('email', 'phone') THEN
    RETURN NEW;
  END IF;

  -- Check if the new row has a 'confirmed_at' value
  IF NEW.confirmed_at IS NOT NULL THEN
    -- Check if the user profile does not exist in the 'public.profile' table
    IF NOT EXISTS (SELECT 1 FROM public.profile WHERE user_id = NEW.id) THEN
      -- Determine if the user is a corporate account or not
      IF (NEW.raw_user_meta_data->>'is_corp')::BOOLEAN THEN
        is_confirmed := TRUE;
        ref_name := NEW.raw_user_meta_data->>'corp_name';

        -- Insert corporate profile based on the 'type'
        INSERT INTO public.profile(user_id, email, phone, corp_name, corp_reg, npc_reg, role, is_approved)
        VALUES (NEW.id, NEW.email, NEW.phone, NEW.raw_user_meta_data->>'corp_name',
                NEW.raw_user_meta_data->>'corp_reg', NEW.raw_user_meta_data->>'npc_reg',
                CAST(NEW.raw_user_meta_data->>'type' AS public.user_role), FALSE);

      ELSE
        -- Insert new user profile for non-corporate accounts
        INSERT INTO public.profile(user_id, email, phone, first_name, last_name, rsa_id_number, role)
        VALUES (NEW.id, NEW.email, NEW.phone, NEW.raw_user_meta_data->>'first_name', NEW.raw_user_meta_data->>'last_name',
                NEW.raw_user_meta_data->>'id_number', 'Ubuntunist');

        ref_name := CONCAT(NEW.raw_user_meta_data->>'first_name', ' ', NEW.raw_user_meta_data->>'last_name');
      END IF;
    END IF;

    -- Handle referral if a profile exists for the user
    IF EXISTS (SELECT 1 FROM public.profile WHERE user_id = NEW.id) THEN
      IF NEW.raw_user_meta_data->>'referral_code' IS NOT NULL THEN
        PERFORM public.handle_new_referral(NEW.id, (NEW.raw_user_meta_data->>'referral_code')::INTEGER, ref_name, is_confirmed);
      ELSE

        SELECT text_value INTO master_referral_code FROM system_configs.remote_config
        WHERE id = 'master_referral_code';

        PERFORM public.handle_new_referral(NEW.id, master_referral_code::integer, ref_name, is_confirmed);
      END IF;
    END IF;

  END IF;

  RETURN NEW;
END;
$$;
ALTER FUNCTION "public"."handle_new_user"() OWNER TO "postgres";
