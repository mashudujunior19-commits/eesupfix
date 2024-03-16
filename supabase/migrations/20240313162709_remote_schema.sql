alter table "communities"."eesupool_order" alter column "secret_pin" drop not null;


drop function if exists "finances"."calculate_voucher_profits_and_withdrawal"();

alter table "finances"."transaction" add column "uuid_ref" uuid not null default gen_random_uuid();

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION finances.calculate_profit_share_and_withdrawal(voucher_id integer, wallet_id integer, voucher_balance numeric, interest_rate numeric, voucher_value numeric, period_weeks integer, cycle finances.voucher_cycle)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    profit_share NUMERIC;
    withdrawal NUMERIC;
    closing_balance NUMERIC;
BEGIN

    IF cycle = 'Weekly' THEN
    
        profit_share := ROUND(voucher_balance * (interest_rate / 100), 2);
        withdrawal := ROUND((voucher_value / period_weeks), 2);
        closing_balance := ROUND((voucher_balance - withdrawal + profit_share), 2);


        IF withdrawal <= closing_balance THEN
            PERFORM finances.process_voucher_transactions(voucher_id, wallet_id,
            withdrawal, voucher_balance, profit_share, closing_balance);
        ELSE        
            PERFORM finances.process_voucher_transactions(voucher_id, wallet_id,
            closing_balance + withdrawal, voucher_balance, profit_share, 0.00);
        END IF;

    ELSIF cycle = 'Monthly' THEN

        profit_share := ROUND((voucher_balance * (interest_rate / 100)) * 4, 2);
        --because this is monthly the withdrawal  is counted in months period
        withdrawal := ROUND((voucher_value / (period_weeks/4)), 2);
        closing_balance := ROUND((voucher_balance - withdrawal + profit_share), 2);


        IF withdrawal <= closing_balance THEN
            PERFORM finances.process_voucher_transactions(voucher_id, wallet_id,
            withdrawal, voucher_balance, profit_share, closing_balance);
        ELSE     
            PERFORM finances.process_voucher_transactions(voucher_id, wallet_id,
            closing_balance + withdrawal, voucher_balance, profit_share, 0.00);
        END IF;

    ELSIF cycle ='Once-off' THEN

        profit_share := ROUND((voucher_balance * (interest_rate / 100)) * period_weeks, 2);
        withdrawal := voucher_balance + profit_share;
        closing_balance := 0.00;

        PERFORM finances.process_voucher_transactions(voucher_id, wallet_id,
        withdrawal, voucher_balance, profit_share, closing_balance);

    END IF;
END;
$function$
;

CREATE OR REPLACE FUNCTION finances.check_voucher_payouts_cron_job_fun()
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    vouchers RECORD;
    days_passed INTEGER;
BEGIN
    FOR vouchers IN (
        SELECT v.id, v.balance, v.cycle, v.value, (v.period * 4) AS period_in_weeks,
        vp.interest, v.wallet_id, v.confirmed_at, v.end_date
        FROM finances.voucher v
        JOIN finances.voucher_parameter vp ON v.parameter_id = vp.id
        WHERE v.balance > 0 AND v.confirmed_at IS NOT NULL
    )
    LOOP
        insert into public.test_table(value) values(concat('voucher ',vouchers.id));
        -- Calculate days passed since the voucher was confirmed
        days_passed := DATE_PART('day', CURRENT_DATE - vouchers.confirmed_at)::INTEGER;
        
        IF vouchers.cycle = 'Weekly' AND days_passed % 7 = 0 THEN
            -- Execute every 7 days
            PERFORM finances.calculate_profit_share_and_withdrawal(vouchers.id, vouchers.wallet_id, vouchers.balance,
            vouchers.interest, vouchers.value, vouchers.period_in_weeks,vouchers.cycle);

        ELSIF vouchers.cycle = 'Monthly' AND days_passed % 28 = 0 THEN
            -- Execute every 28 days
            PERFORM finances.calculate_profit_share_and_withdrawal(vouchers.id, vouchers.wallet_id, vouchers.balance,
            vouchers.interest, vouchers.value, vouchers.period_in_weeks,vouchers.cycle);

        ELSIF vouchers.cycle = 'Once-off' AND (vouchers.end_date <= CURRENT_DATE) THEN
            
            -- Execute when the end date is equal to now or has passed
            PERFORM finances.calculate_profit_share_and_withdrawal(vouchers.id, vouchers.wallet_id, vouchers.balance,
            vouchers.interest, vouchers.value, vouchers.period_in_weeks,vouchers.cycle);
       END IF;
    END LOOP;
END;
$function$
;

CREATE OR REPLACE FUNCTION finances.process_voucher_transactions(voucher_id integer, crowd_fund_wallet_id integer, withdrawal_amount numeric, opening_balance numeric, profit_share numeric, closing_balance numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    transaction_id INTEGER;
    retail_wallet INTEGER;
BEGIN

    SELECT w2.id INTO retail_wallet FROM finances.wallet w1 
    JOIN finances.wallet w2 ON w1.user_id = w2.user_id WHERE w1.id = crowd_fund_wallet_id
    AND w2.type='retail';

    --transfer the withdrawal to the retail wallet
    SELECT * FROM finances.create_wallet_transaction(
        retail_wallet, 'CFV', withdrawal_amount, true, concat('Voucher ', voucher_id,' withdrawal')
    ) INTO transaction_id;

    --create ledger transaction
    PERFORM finances.create_voucher_ledger_transaction(
        voucher_id,
        transaction_id,
        opening_balance,
        -withdrawal_amount,
        profit_share,
        closing_balance
    );

    --set new voucher balance
    UPDATE finances.voucher SET balance = closing_balance WHERE id = voucher_id;

    --update the voucher wallet balance
    UPDATE finances.wallet SET balance = closing_balance WHERE id = crowd_fund_wallet_id;

END;
$function$
;


