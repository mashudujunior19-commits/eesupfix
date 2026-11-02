-- TOWRIS fixes:
--  * Welcome notification is created when a profile is created (it never was,
--    so there was nothing to show).
--  * The person who referred a new member is notified when that member
--    registers with their referral code.
--  * The R1 referral bonus is gone: no transaction is created, every wallet
--    starts at R0.
--  * Wallet "available" balances no longer count deleted transactions, so the
--    Wealth wallet (and the others) reflect what is really there.

-- 1. Welcome notification -----------------------------------------------------
CREATE OR REPLACE FUNCTION "public"."send_welcome_notification"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET search_path = public, engagements
    AS $$
BEGIN
    INSERT INTO engagements.notification(user_id, title, body, data, type, channel)
    VALUES (
        NEW.user_id,
        'Welcome to TOWRIS',
        'Welcome to the TOWRIS family. We are excited to have you on board. OWN YOUR ECONOMY.',
        jsonb_build_object('kind', 'welcome'),
        'other',
        'push'
    );
    RETURN NEW;
END;
$$;
ALTER FUNCTION "public"."send_welcome_notification"() OWNER TO "postgres";

DROP TRIGGER IF EXISTS "send_welcome_notification_trigger" ON "public"."profile";
CREATE TRIGGER "send_welcome_notification_trigger"
    AFTER INSERT ON "public"."profile"
    FOR EACH ROW EXECUTE FUNCTION "public"."send_welcome_notification"();

-- Members who registered recently and never got one (notifications expire
-- after 30 days, so there is no point going further back).
INSERT INTO engagements.notification(user_id, title, body, data, type, channel)
SELECT p.user_id,
       'Welcome to TOWRIS',
       'Welcome to the TOWRIS family. We are excited to have you on board. OWN YOUR ECONOMY.',
       jsonb_build_object('kind', 'welcome'),
       'other',
       'push'
FROM public.profile p
WHERE p.created_at > now() - interval '30 days'
  AND NOT EXISTS (
      SELECT 1 FROM engagements.notification n
      WHERE n.user_id = p.user_id AND n.data ->> 'kind' = 'welcome'
  );

-- 2 + 3. Referral: notify the referrer, no R1 bonus ----------------------------
CREATE OR REPLACE FUNCTION "public"."handle_new_referral"("referee_id" "uuid", "ref_code" integer, "full_name" "text", "is_confirmed" boolean) RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET search_path = public, engagements, system_configs
    AS $$
DECLARE
    referrer_id UUID;
    master_code text;
BEGIN
    SELECT user_id INTO referrer_id
    FROM public.profile
    WHERE referral_code = ref_code;

    IF referrer_id IS NULL THEN
        RAISE EXCEPTION 'Referrer not found for referral code %', ref_code;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM public.referral
                   WHERE refereed_user_id = referee_id AND referrer_user_id = referrer_id) THEN

        -- No bonus: the referral row carries no transaction and no wallet is
        -- credited.
        INSERT INTO public.referral(referrer_user_id, refereed_user_id, transaction_id, is_completed)
        VALUES (referrer_id, referee_id, NULL, is_confirmed);

        -- Tell the referrer, unless the code was simply the default one given
        -- to people who did not use a referral code.
        SELECT text_value INTO master_code FROM system_configs.remote_config
        WHERE id = 'master_referral_code';

        IF master_code IS NULL OR master_code <> ref_code::text THEN
            INSERT INTO engagements.notification(user_id, title, body, data, type, channel)
            VALUES (
                referrer_id,
                'New referral',
                CONCAT(COALESCE(NULLIF(trim(full_name), ''), 'Someone'),
                       ' registered on TOWRIS using your referral code.'),
                jsonb_build_object('kind', 'referral', 'referee_id', referee_id),
                'other',
                'push'
            );
        END IF;
    END IF;
END;
$$;
ALTER FUNCTION "public"."handle_new_referral"("referee_id" "uuid", "ref_code" integer, "full_name" "text", "is_confirmed" boolean) OWNER TO "postgres";

-- 4. Available balance ignores deleted transactions ----------------------------
CREATE OR REPLACE FUNCTION "finances"."get_wallet_balance_by_type"("user_uuid" "uuid", "wallet_type_param" "text") RETURNS TABLE("wallet_id" integer, "wallet_type" "text", "available_balance" numeric, "total_balance" numeric)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        w.id AS wallet_id,
        w.type AS wallet_type,
        COALESCE(SUM(CASE WHEN t.vested = TRUE AND COALESCE(t.is_deleted, FALSE) = FALSE
                          THEN t.value ELSE 0 END), 0) AS available_balance,
        COALESCE(SUM(CASE WHEN COALESCE(t.is_deleted, FALSE) = FALSE THEN t.value ELSE 0 END), 0) AS total_balance
    FROM finances.wallet w
    LEFT JOIN finances.wallet_transaction wt ON w.id = wt.wallet_id
    LEFT JOIN finances.transaction t ON wt.transaction_id = t.id
    WHERE w.user_id = user_uuid
    AND w.type = wallet_type_param
    GROUP BY w.id, w.type;
END;
$$;
