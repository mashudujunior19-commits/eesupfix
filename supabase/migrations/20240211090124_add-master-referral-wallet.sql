set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.handle_new_referral(referee_id uuid, ref_code integer, full_name text, is_confirmed boolean)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    referrer_id UUID;
    wallet_id INTEGER;
    transaction_id INTEGER;
BEGIN
    -- Get referrer ID from profile using referral code
    SELECT user_id INTO referrer_id 
    FROM public.profile 
    WHERE referral_code = ref_code;

    IF NOT EXISTS (SELECT 1 FROM public.referral WHERE refereed_user_id = referee_id AND referrer_user_id = referrer_id) THEN

    -- Check if referrer_id was found
    IF referrer_id IS NULL THEN
        -- Handle the case where the referrer is not found, e.g., raise an exception or exit
        RAISE EXCEPTION 'Referrer not found for referral code %', ref_code;
    END IF;

    -- Get referrer's retail wallet ID
    SELECT id INTO wallet_id 
    FROM finances.wallet 
    WHERE user_id = referrer_id AND type = 'wealth';

    -- Check if wallet_id was found
    IF wallet_id IS NULL THEN
        SELECT text_value::INTEGER INTO wallet_id FROM system_configs.remote_config
        WHERE id = 'master_referral_wallet_id';
    END IF;

    -- Create referral transaction
    SELECT finances.create_wallet_transaction(wallet_id, 'CRC', 1.00, is_confirmed, CONCAT('Referred ', full_name))
    INTO transaction_id;

    -- Insert into the referrals table
    INSERT INTO public.referral(referrer_user_id, refereed_user_id, transaction_id, is_completed) 
    VALUES (referrer_id, referee_id, transaction_id, is_confirmed);

    END IF;
END;
$function$
;


