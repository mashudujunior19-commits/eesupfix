alter type "finances"."payment_method" rename to "payment_method__old_version_to_be_dropped";

create type "finances"."payment_method" as enum ('Retail wallet', 'Ozow', 'Split-Ozow & Retail wallet', 'Split-Instapay & Retail wallet', 'Instapay');

drop type "finances"."payment_method__old_version_to_be_dropped";

alter table "finances"."transaction" drop column "uuid_ref";

alter table "finances"."transaction" add column "txt_id" uuid not null default gen_random_uuid();


alter table "sales"."order" alter column payment_method type "finances"."payment_method" using payment_method::text::"finances"."payment_method";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION sales.create_order(_customer_id uuid, _eesupreneur_id uuid, _eesupool_order_id integer, _wallet_id integer, _total_amount numeric, _payment_method finances.payment_method, _address_id integer, _delivery_fee numeric, _products jsonb[])
 RETURNS record
 LANGUAGE plpgsql
AS $function$
DECLARE
    trans_id INTEGER;
    _ord_id INTEGER;
    product RECORD;
    _outstanding_amount numeric;
    wallet_balance numeric;
BEGIN
    -- Create sales.order
    INSERT INTO sales.order (customer_id, eesupreneur_id, eesupool_order_id, payment_method, delivery_address_id, delivery_fee,value)
    VALUES (_customer_id, _eesupreneur_id, _eesupool_order_id, _payment_method, _address_id, _delivery_fee,_total_amount)
    RETURNING id INTO _ord_id;

    PERFORM sales.insert_order_products(_ord_id, _products);

    -- Process based on payment method
    IF _payment_method = 'Ozow' OR _payment_method='Instapay' THEN
        -- Ozow specific logic
        SELECT * INTO trans_id
        FROM finances.create_wallet_transaction(_wallet_id, 'DEP', _total_amount, false, CONCAT(_ord_id, '- Deposit(eft)'));
        
        PERFORM finances.create_order_transaction(_ord_id, trans_id);

        SELECT * INTO trans_id
        FROM finances.create_wallet_transaction(_wallet_id, 'ORD', -_total_amount, false, CONCAT(_ord_id, '- ORD Payment'));

        PERFORM finances.create_order_transaction(_ord_id, trans_id);

        _outstanding_amount := _total_amount;

    ELSIF _payment_method = 'Split-Ozow & Retail wallet' OR _payment_method = 'Split-Instapay & Retail wallet' THEN

        -- Split-Ozow & Retail wallet specific logic
        SELECT balance INTO wallet_balance FROM finances.wallet WHERE id = _wallet_id;

        SELECT * INTO trans_id
        FROM finances.create_wallet_transaction(_wallet_id, 'ORD',-wallet_balance, false, CONCAT(_ord_id, '- ORD Payment'));

        PERFORM finances.create_order_transaction(_ord_id, trans_id);

        _outstanding_amount := _total_amount - wallet_balance;

        SELECT * INTO trans_id
        FROM finances.create_wallet_transaction(_wallet_id, 'DEP', _outstanding_amount, false, CONCAT(_ord_id, '- Deposit(eft)'));

        PERFORM finances.create_order_transaction(_ord_id, trans_id);

        SELECT * INTO trans_id
        FROM finances.create_wallet_transaction(_wallet_id, 'ORD', -_outstanding_amount, false, CONCAT(_ord_id, '- ORD Payment'));

        PERFORM finances.create_order_transaction(_ord_id, trans_id);

    ELSIF _payment_method = 'Retail wallet' THEN
        -- Retail payment logic
        SELECT * INTO trans_id
        FROM finances.create_wallet_transaction(_wallet_id, 'ORD', -_total_amount, false, CONCAT(_ord_id, '- ORD Payment'));

        PERFORM finances.create_order_transaction(_ord_id, trans_id);

        perform sales.place_confirmed_order(_ord_id,true);

        _outstanding_amount := 0.00;
        
    END IF;

    RETURN (_ord_id, _outstanding_amount);
END;
$function$
;


