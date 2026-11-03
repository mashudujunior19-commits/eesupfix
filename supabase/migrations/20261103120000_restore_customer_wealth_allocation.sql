-- Turn the customer Wealth Allocation (CWA) back on.
-- The live allocation function only credited foreign customers (to the master
-- wallet), so verified local customers never received their Wealth credit.
-- Part 1 restores the credit; part 2 backfills the dispatched orders paid since
-- 22 Oct 2026 that never got it (idempotent: skips any order that already has a
-- CWA transaction).

CREATE OR REPLACE FUNCTION sales.allocate_profit_earnings_for_eesupreneur_orders()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$DECLARE
    _order_earnings RECORD;
    _target_wallet integer;
    _app public.app_type;
    _retail_wallet_id integer;
    _referred_user_name text;
    _is_foreign bool;
    _is_verified bool;
     _is_referrer_verified bool; 
    _is_referrer_foreign bool; 
BEGIN
    IF NEW.collected_at IS NOT NULL AND NEW.status = 'Dispatched' THEN
        -- pay-once claim: the first paying update wins, later ones do nothing
        IF NOT finances.claim_order_allocation(NEW.id, 'eesupreneur', 'allocate_profit_earnings_for_eesupreneur_orders') THEN
            RETURN NEW;
        END IF;

        --Earnings
        SELECT * FROM sales.calculate_order_profit_splits(NEW.id)
        INTO _order_earnings;

        SELECT foreigner, is_verified INTO _is_referrer_foreign, _is_referrer_verified 
        FROM profile 
        WHERE user_id = (SELECT referrer_user_id FROM referral WHERE refereed_user_id = NEW.customer_id LIMIT 1);

        -- Option 1: If the referrer is NOT a foreigner, allocate referral commission
        IF COALESCE(_is_referrer_foreign, FALSE) = FALSE THEN
            -- If the referrer is verified, allocate commission
            IF COALESCE(_is_referrer_verified, FALSE) = TRUE THEN
                -- Allocate Customer Referral Commission to the referrer (verified)
                SELECT w.id INTO _target_wallet 
                FROM finances.wallet w 
                JOIN referral r ON w.user_id = r.referrer_user_id
                WHERE r.refereed_user_id = NEW.customer_id 
                AND w.type = 'income';

                SELECT p.first_name INTO _referred_user_name 
                FROM profile p 
                WHERE p.user_id = NEW.customer_id;

                PERFORM finances.create_wallet_transaction(
                    _target_wallet, 
                    'CRC', 
                    _order_earnings.crc_total,
                    true, 
                    concat(NEW.id, ' - Referral Fee ', _referred_user_name)
                );
            ELSE

                -- If the referrer is not verified, still allocate commission, but with false vested status
                SELECT w.id INTO _target_wallet 
                FROM finances.wallet w 
                JOIN referral r ON w.user_id = r.referrer_user_id
                WHERE r.refereed_user_id = NEW.customer_id 
                AND w.type = 'income';

                SELECT p.first_name INTO _referred_user_name 
                FROM profile p 
                WHERE p.user_id = NEW.customer_id;

                PERFORM finances.create_wallet_transaction(
                    _target_wallet, 
                    'CRC', 
                    _order_earnings.crc_total,
                    false,  -- False vested status due to referrer not being verified
                    concat(NEW.id, ' - Referral Fee ', _referred_user_name)
                );
            END IF;
        ELSE
            -- Option 2: If the referrer is a foreigner, allocate referral commission to the master wallet
            SELECT text_value::INTEGER INTO _target_wallet 
            FROM system_configs.remote_config 
            WHERE id = 'master_wallet_id';

            PERFORM finances.create_wallet_transaction(
                _target_wallet, 
                'CRC', 
                _order_earnings.crc_total,
                true, 
                concat(NEW.id, ' Foreign Referral Commission')
            );
        END IF;

      --#########-> FOR SOME ROLES THIS CIA MIGHT BE A DISCOUNT ON CHECKOUT SO WE ENSURE THAT WE DO NOT ALLOCATE IT AGAIN <-##########
        -- IF NOT EXISTS (
        --     SELECT 1 
        --     FROM public.profile p 
        --     WHERE p.user_id = NEW.customer_id AND p.role = 'EESUplift-Corporate'
        -- ) THEN

            -- Find the customer's retail wallet
            SELECT w.id INTO _retail_wallet_id  FROM finances.wallet w 
            WHERE w.user_id = NEW.customer_id AND w.type = 'retail';

            -- Create the CIA transaction
            PERFORM finances.create_wallet_transaction(_retail_wallet_id, 'CIA', _order_earnings.cia_total,
            true, concat(NEW.id, ' Cashback')); 

       -- END IF;

        --#####################################################################################################################
        -- Allocate Customer Wealth Allocation
        SELECT is_verified, foreigner INTO _is_verified, _is_foreign 
        FROM profile 
        WHERE user_id = NEW.customer_id;

        -- Allocate Customer Wealth Allocation if wallet exists
        SELECT w.id INTO _target_wallet 
        FROM finances.wallet w 
        WHERE w.user_id = NEW.customer_id AND w.type = 'wealth';

        IF _target_wallet IS NOT NULL THEN
          -- Create the transaction based on verification status
            -- PERFORM finances.create_wallet_transaction(
            --  _target_wallet, 
            -- 'CWA', 
            --  _order_earnings.cwa_total,
            -- COALESCE(_is_verified, FALSE),  
            -- CONCAT(NEW.id, ' Wealth Allocation')
            -- );

            IF NOT COALESCE(_is_foreign, FALSE) THEN
                -- Customer Wealth Allocation: vested only once the customer is verified
                IF COALESCE(_order_earnings.cwa_total, 0) > 0 THEN
                    PERFORM finances.create_wallet_transaction(
                        _target_wallet,
                        'CWA',
                        _order_earnings.cwa_total,
                        COALESCE(_is_verified, FALSE),
                        CONCAT(NEW.id, ' Wealth Allocation')
                    );
                END IF;
            ELSIF _is_foreign THEN
                SELECT text_value::INTEGER INTO _target_wallet 
                FROM system_configs.remote_config 
                WHERE id = 'master_wallet_id';

                PERFORM finances.create_wallet_transaction(
                    _target_wallet, 
                    'CWA',  -- Wealth Allocation
                    _order_earnings.cwa_total,  
                    true, 
                    concat(NEW.id, ' Foreign Wealth Allocation')
                );
            END IF;

            END IF;

            -- Allocate customer social income
            SELECT w.id into _target_wallet from finances.wallet w where w.user_id = NEW.customer_id AND w.type = 'social';
            PERFORM finances.create_wallet_transaction(_target_wallet, 'CSA', _order_earnings.csa_total,
            true, concat(NEW.id, ' Social Allocation'));


        ---###############################--->THESE ALLOCATIONS ARE NOT UNIQUE TO ANY APP <---##############################################
        SELECT text_value::INTEGER INTO _target_wallet FROM system_configs.remote_config
        WHERE id = 'master_wallet_id';
        PERFORM finances.create_wallet_transaction(_target_wallet, 'DAA', _order_earnings.daa_total,
        true, concat(NEW.id, ' TOWRIS Fee'));

        IF NEW.eesupreneur_id IS NOT NULL THEN
            SELECT w.id INTO _target_wallet FROM finances.wallet w JOIN services.eesupreneur e on w.user_id = e.owner_id
            WHERE e.id = NEW.eesupreneur_id AND w.type = 'income';
            PERFORM finances.create_wallet_transaction(_target_wallet, 'EIA', _order_earnings.eia_total,
            true, concat(NEW.id, ' KasiPreneur Fee'));

            --##############-> Allocate the delivary fee  if it is chosen by the customer <-#####################
            IF NEW.delivery_fee IS NOT NULL THEN
                PERFORM finances.create_wallet_transaction(_target_wallet, 'EIA', NEW.delivery_fee,
                true, concat(NEW.id, ' Delivery fee'));
            END IF;
        END IF;
    END IF;
    RETURN NEW;
END;$function$;

DO $$
DECLARE
    _o RECORD;
BEGIN
    FOR _o IN
        SELECT p.order_id, o.customer_id, s.cwa_total, pr.is_verified, w.id AS wealth_wallet_id
        FROM (
            SELECT DISTINCT ON (order_id) (regexp_match(t.description, '^(\d+) Cashback'))[1]::int AS order_id, t.created_at
            FROM finances.transaction t
            WHERE t.type = 'CIA' AND t.description ~ '^\d+ Cashback' AND t.created_at >= '2026-10-22'
            ORDER BY order_id, t.created_at
        ) p
        JOIN sales."order" o ON o.id = p.order_id
        JOIN public.profile pr ON pr.user_id = o.customer_id
        JOIN finances.wallet w ON w.user_id = o.customer_id AND w.type = 'wealth'
        CROSS JOIN LATERAL sales.calculate_order_profit_splits(p.order_id) s
        WHERE COALESCE(pr.foreigner, FALSE) = FALSE
          AND COALESCE(s.cwa_total, 0) > 0
          AND NOT EXISTS (
              SELECT 1 FROM finances.transaction t
              WHERE t.type = 'CWA' AND t.description LIKE p.order_id || ' %'
          )
    LOOP
        PERFORM finances.create_wallet_transaction(
            _o.wealth_wallet_id, 'CWA', _o.cwa_total,
            COALESCE(_o.is_verified, FALSE), CONCAT(_o.order_id, ' Wealth Allocation')
        );
    END LOOP;
END;
$$;
