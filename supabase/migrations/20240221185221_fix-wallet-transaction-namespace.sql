CREATE OR REPLACE FUNCTION "finances"."create_wallet_transaction"(_wallet_id integer, _type text, _value numeric, _vested boolean, _description text) RETURNS integer
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    _new_trans_id INTEGER;
BEGIN

    select * from finances.create_transaction(_type, _value,_vested,_description)
    into _new_trans_id;

    --insert to wallet finances.transaction bridge
    insert into finances.wallet_transaction(wallet_id, transaction_id)
    values(_wallet_id,_new_trans_id);


    IF _vested = true THEN
         update finances.transaction set vested = true, confirmed_at = NOW()
         where id =_new_trans_id;
    END IF;

    RETURN _new_trans_id;
END;
$$;