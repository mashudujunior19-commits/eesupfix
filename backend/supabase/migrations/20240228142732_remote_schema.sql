drop function if exists "communities"."get_eesupool_orders"(pool_id integer, limit_to integer);

drop function if exists "communities"."get_open_eesupool_order"(pool_id integer);

drop function if exists "communities"."get_open_eesupool_orders"(_user_id uuid, _eesupool_id integer, _limit_to integer);

alter table "communities"."eesupool_order" add column "secret_pin" integer not null default sales.generate_order_secret_pin();

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION communities.get_eesupool_orders(pool_id integer, limit_to integer)
 RETURNS TABLE(id integer, eesupool_id integer, receiver_id uuid, created_at timestamp with time zone, schedule_for timestamp with time zone, delivered_at timestamp with time zone, closes_at timestamp with time zone, admin_fee numeric, packer_fee numeric, receiver_fee numeric, collection_fee numeric, address_id integer, receiver jsonb, eesupool_name text, address jsonb, orders_count integer, current_amount numeric, secret_pin integer)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT 
        eo.id,
        eo.eesupool_id,
        eo.receiver_id,
        eo.created_at,
        eo.schedule_for,
        eo.delivered_at,
        eo.closes_at,
        eo.admin_fee,
        eo.packer_fee,
        eo.receiver_fee,
        eo.collection_fee,
        eo.address_id,
        COALESCE((SELECT row_to_json(t)::jsonb 
                  FROM 
                  (SELECT * FROM communities.get_eesupool_member_by_id(eo.receiver_id)) t), null::jsonb) AS receiver,
        (select ep.name from communities.eesupool ep where ep.id = eo.eesupool_id) as eesupool_name,
        COALESCE((SELECT row_to_json(t)::jsonb 
                  FROM 
                  (SELECT * FROM geolocations.get_address_by_id(eo.address_id)) t), null::jsonb) AS address,
        CAST((select count(*) from sales.order o where o.eesupool_order_id = eo.id) as integer) as orders_count,
        COALESCE(CAST((SELECT SUM(o.value) FROM sales.order o WHERE o.eesupool_order_id = eo.id AND (o.status <> 'Pending' AND o.status <> 'Cancelled')) AS numeric),0.00) AS current_amount,
        eo.secret_pin      
    FROM communities.eesupool_order eo
    WHERE eo.eesupool_id = pool_id limit limit_to;
END;
$function$
;

CREATE OR REPLACE FUNCTION communities.get_open_eesupool_order(pool_id integer)
 RETURNS TABLE(id integer, eesupool_id integer, receiver_id uuid, created_at timestamp with time zone, schedule_for timestamp with time zone, delivered_at timestamp with time zone, closes_at timestamp with time zone, admin_fee numeric, packer_fee numeric, receiver_fee numeric, collection_fee numeric, address_id integer, receiver jsonb, eesupool_name text, address jsonb, orders_count integer, current_amount numeric, secret_pin integer)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT 
        eo.id,
        eo.eesupool_id,
        eo.receiver_id,
        eo.created_at,
        eo.schedule_for,
        eo.delivered_at,
        eo.closes_at,
        eo.admin_fee,
        eo.packer_fee,
        eo.receiver_fee,
        eo.collection_fee,
        eo.address_id,
        COALESCE((SELECT row_to_json(t)::jsonb 
                  FROM 
                  (SELECT * FROM communities.get_eesupool_member_by_id(eo.receiver_id)) t), null::jsonb) AS receiver,
        (select ep.name from communities.eesupool ep where ep.id = eo.eesupool_id) as eesupool_name,
        COALESCE((SELECT row_to_json(t)::jsonb 
                  FROM 
                  (SELECT * FROM geolocations.get_address_by_id(eo.address_id)) t), null::jsonb) AS address,
        CAST((select count(*) from sales.order o where o.eesupool_order_id = eo.id) as integer) as orders_count,
        COALESCE(CAST((SELECT SUM(o.value) FROM sales.order o WHERE o.eesupool_order_id = eo.id AND (o.status <> 'Pending' AND o.status <> 'Cancelled')) AS numeric),0.00) AS current_amount,
        eo.secret_pin  
    FROM communities.eesupool_order eo
    WHERE eo.closes_at > now() AND eo.eesupool_id = pool_id
    ORDER BY eo.created_at desc limit 1;
END;
$function$
;

CREATE OR REPLACE FUNCTION communities.get_open_eesupool_orders(_user_id uuid, _eesupool_id integer, _limit_to integer)
 RETURNS TABLE(id integer, eesupool_id integer, receiver_id uuid, created_at timestamp with time zone, schedule_for timestamp with time zone, delivered_at timestamp with time zone, closes_at timestamp with time zone, admin_fee numeric, packer_fee numeric, receiver_fee numeric, collection_fee numeric, address_id integer, receiver jsonb, eesupool_name text, address jsonb, orders_count integer, current_amount numeric, secret_pin integer)
 LANGUAGE plpgsql
AS $function$
DECLARE
    _referrer_user_id uuid;
BEGIN
    -- Get the user that referred this user so we can also get orders that they may have placed
    SELECT referrer_user_id INTO _referrer_user_id FROM referral WHERE refereed_user_id = _user_id;

    -- Get orders, including those from the referring user if applicable
    RETURN QUERY
    SELECT 
        eo.id,
        eo.eesupool_id,
        eo.receiver_id,
        eo.created_at,
        eo.schedule_for,
        eo.delivered_at,
        eo.closes_at,
        eo.admin_fee,
        eo.packer_fee,
        eo.receiver_fee,
        eo.collection_fee,
        eo.address_id,
        COALESCE((SELECT row_to_json(t)::jsonb 
                  FROM 
                  (SELECT * FROM communities.get_eesupool_member_by_id(eo.receiver_id)) t), null::jsonb) AS receiver,
        (SELECT ep.name FROM communities.eesupool ep WHERE ep.id = eo.eesupool_id) AS eesupool_name,
        COALESCE((SELECT row_to_json(t)::jsonb 
                  FROM (SELECT * FROM geolocations.get_address_by_id(eo.address_id)) t), 
                 null::jsonb) AS address,
        CAST((select count(*) from sales.order o where o.eesupool_order_id = eo.id) as integer) as orders_count,
        COALESCE(CAST((SELECT SUM(o.value) FROM sales.order o WHERE o.eesupool_order_id = eo.id AND (o.status <> 'Pending' AND o.status <> 'Cancelled')) AS numeric),0.00) AS current_amount,
        eo.secret_pin  
    FROM communities.eesupool_order eo 
    INNER JOIN communities.eesupool_member eem ON eo.eesupool_id = eem.eesupool_id
    WHERE eo.closes_at > now() AND
    ((eem.user_id = _user_id OR (_referrer_user_id IS NOT NULL AND eem.user_id = _referrer_user_id)) or eo.eesupool_id = _eesupool_id)
    ORDER BY eo.created_at desc
    LIMIT _limit_to;
END;
$function$
;


create type "finances"."voucher_cycle" as enum ('Weekly', 'Monthly', 'Once-off');

alter table "finances"."voucher" drop constraint "finances_voucher_user_id_fkey";

alter table "finances"."voucher_ledger" drop constraint "finances_voucher_ledger_transaction_id_fkey";

alter table "finances"."voucher" drop column "user_id";

alter table "finances"."voucher" add column "cancelled_at" timestamp with time zone;

alter table "finances"."voucher" add column "confirmed_at" timestamp with time zone;

alter table "finances"."voucher" add column "cycle" finances.voucher_cycle not null;

alter table "finances"."voucher" add column "end_date" timestamp with time zone not null;

alter table "finances"."voucher" add column "period" integer not null;

alter table "finances"."voucher" add column "wallet_id" integer not null;

alter table "finances"."voucher" alter column "balance" set default 36000.00;

alter table "finances"."voucher_ledger" alter column "opening_balance" drop not null;

alter table "finances"."voucher_ledger" alter column "payout" drop not null;

alter table "finances"."voucher_ledger" alter column "profit_share" drop not null;

alter table "finances"."voucher" add constraint "finances_voucher_wallet_id_fkey" FOREIGN KEY (wallet_id) REFERENCES finances.wallet(id) ON DELETE CASCADE not valid;

alter table "finances"."voucher" validate constraint "finances_voucher_wallet_id_fkey";

alter table "finances"."voucher_ledger" add constraint "finances_voucher_ledger_transaction_id_fkey" FOREIGN KEY (transaction_id) REFERENCES finances.transaction(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "finances"."voucher_ledger" validate constraint "finances_voucher_ledger_transaction_id_fkey";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION finances.calculate_voucher_profits_and_withdrawal()
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    vouchers RECORD;
BEGIN
    FOR vouchers IN (
        SELECT v.id, v.balance, v.cycle, v.value, (v.period * 4) AS period_in_weeks, vp.interest, v.wallet_id 
        FROM finances.voucher v
        JOIN finances.voucher_parameter vp ON v.parameter_id = vp.id
        WHERE v.balance > 0 AND v.confirmed_at is not null
    )
    LOOP    
        PERFORM finances.calculate_profit_share_and_withdrawal(vouchers.id, vouchers.wallet_id, vouchers.balance,
        vouchers.interest, vouchers.value, vouchers.period_in_weeks);
    END LOOP;
END;
$function$
;

CREATE OR REPLACE FUNCTION finances.confirm_voucher_eft(reference integer, is_confirmed boolean)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
declare
trans_id record;
BEGIN
    IF is_confirmed THEN
        UPDATE finances.voucher SET confirmed_at = now(), cancelled_at = NULL WHERE id = reference;
        
        FOR trans_id IN 
            SELECT t.id 
            FROM finances.transaction t
            JOIN finances.voucher_ledger vl ON t.id = vl.transaction_id
            WHERE vl.voucher_id = reference
        LOOP
            UPDATE finances.transaction SET vested = TRUE, confirmed_at = now() WHERE id = trans_id.id;
        END LOOP;
        
    ELSIF NOT is_confirmed THEN
        UPDATE finances.voucher SET cancelled_at = now(), confirmed_at = NULL WHERE id = reference;
        
        FOR trans_id IN 
            SELECT t.id 
            FROM finances.transaction t
            JOIN finances.voucher_ledger vl ON t.id = vl.transaction_id
            WHERE vl.voucher_id = reference
        LOOP
            UPDATE finances.transaction SET vested = FALSE, cancelled_at = NULL WHERE id = trans_id.di;
        END LOOP;
    END IF;
END;
$function$
;

CREATE OR REPLACE FUNCTION finances.create_crowdfunding_voucher(_user_id uuid, _parameter_id uuid, _value numeric, _cycle finances.voucher_cycle, _period integer, _end_date timestamp with time zone)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
DECLARE
    voucher_id integer;
    user_retail_wallet integer;
    user_crowdfund_wallet integer;
    trans_id integer;
BEGIN
    -- Find user's retail wallet ID
    SELECT id INTO user_retail_wallet FROM finances.wallet WHERE user_id = _user_id AND type='retail';

    -- Find user's crowdfund wallet ID
    SELECT id INTO user_crowdfund_wallet FROM finances.wallet WHERE user_id = _user_id AND type='crowdfund';

    -- Insert into voucher and return the new voucher ID
    INSERT INTO finances.voucher (
        wallet_id, parameter_id, balance, value, cycle, period, end_date
    ) VALUES (
        user_crowdfund_wallet, _parameter_id, _value, _value, _cycle, _period, _end_date
    ) RETURNING id INTO voucher_id;

    -- Create a wallet transaction for crowdfund voucher payment
    SELECT finances.create_wallet_transaction(user_crowdfund_wallet, 'CFV', _value, false, concat('Crowdfund Voucher Payment #-', voucher_id))
    INTO trans_id;

    PERFORM finances.create_voucher_ledger_transaction(voucher_id, trans_id, NULL, NULL, NULL, _value);

    RETURN voucher_id;
END;
$function$
;

CREATE OR REPLACE FUNCTION finances.create_voucher_ledger_transaction(_voucher_id integer, _transaction_id integer, _opening_balance numeric, _payout numeric, _profit_share numeric, _closing_balance numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO finances.voucher_ledger (
        voucher_id,
        transaction_id,
        opening_balance,
        payout,
        profit_share,
        closing_balance
    ) VALUES (
        _voucher_id,
        _transaction_id,
        _opening_balance,
        _payout,
        _profit_share,
        _closing_balance
    );
END;
$function$
;

CREATE OR REPLACE FUNCTION finances.get_voucher_transactions(_voucher_id integer, limit_to integer)
 RETURNS TABLE(type text, doc_ref integer, value numeric, vested boolean, description text, created_at timestamp with time zone, confirmed_at timestamp with time zone, cancelled_at timestamp with time zone, id integer)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT 
        t.type, 
        t.doc_ref, 
        t.value, 
        t.vested, 
        t.description, 
        t.created_at, 
        t.confirmed_at, 
        t.cancelled_at,
        t.id
    FROM 
        finances.transaction t
    INNER JOIN 
        finances.voucher_ledger vl on t.id = vl.transaction_id
    WHERE 
        vl.voucher_id = _voucher_id AND t.is_deleted IS NOT TRUE AND t.confirmed_at is not null
    limit limit_to;
END; 
$function$
;

create policy "Enable access for authenticated users only"
on "finances"."voucher"
as permissive
for all
to authenticated
using (true)
with check (true);


create policy "Enable access for authenticated users only"
on "finances"."voucher_ledger"
as permissive
for all
to authenticated
using (true)
with check (true);



alter table "geolocations"."address" add constraint "geolocations_address_area_id_fkey" FOREIGN KEY (area_id) REFERENCES geolocations.target_area(id) ON DELETE SET NULL not valid;

alter table "geolocations"."address" validate constraint "geolocations_address_area_id_fkey";


alter table "inventory"."product_request" add column "quantity" integer;


drop trigger if exists "handle_crowd_fund_voucher_on_order_placed_trigger" on "sales"."order";


