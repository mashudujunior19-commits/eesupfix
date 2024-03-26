CREATE OR REPLACE FUNCTION sales.allocate_profit_earnings_for_eesupreneur_orders()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
DECLARE
    _order_earnings RECORD;
    _target_wallet integer;
BEGIN

    IF EXISTS (
            SELECT 1
            FROM sales.order_product op 
            JOIN inventory.product p ON op.product_id = p.id
            WHERE op.order_id = NEW.id 
            AND p.class <> 'Crowdfund-voucher'
    ) THEN

    IF NEW.collected_at IS NOT NULL AND NEW.status = 'Collected' THEN

    -- Get food earnings
    SELECT * FROM sales.get_order_summed_food_class_earnings(NEW.id)
    INTO _order_earnings;

    -- Allocate Customer Income Allocation
    SELECT w.id into _target_wallet from finances.wallet w where w.user_id = NEW.customer_id AND w.type = 'retail';
    -- Create the finances.transaction
    PERFORM finances.create_wallet_transaction(_target_wallet, 'CIA', _order_earnings.cia_total,
    true, concat('Order-# ', NEW.id, ' CIA'));

    -- Allocate customer social income
    SELECT w.id into _target_wallet from finances.wallet w where w.user_id = NEW.customer_id AND w.type = 'social';
    PERFORM finances.create_wallet_transaction(_target_wallet, 'CSA', _order_earnings.csa_total,
    true, concat('Order-# ', NEW.id, ' CSA'));

    -- Allocate Customer Wealth Allocation
    SELECT w.id into _target_wallet from finances.wallet w where w.user_id = NEW.customer_id AND w.type = 'wealth';
    -- Create the finances.transaction
    PERFORM finances.create_wallet_transaction(_target_wallet, 'CWA', _order_earnings.cwa_total,
    true, concat('Order-# ', NEW.id, ' CWA'));

    -- Allocate Customer Referral Commission
    SELECT w.id into _target_wallet from finances.wallet w JOIN referral r on w.user_id = r.referrer_user_id
    WHERE r.refereed_user_id = NEW.customer_id AND r.is_completed = TRUE AND w.type = 'wealth';

    PERFORM finances.create_wallet_transaction(_target_wallet, 'CRC', _order_earnings.crc_total,
    true, concat('Order-# ', NEW.id, ' CRC'));

    SELECT text_value::INTEGER INTO _target_wallet FROM system_configs.remote_config
    WHERE id = 'master_wallet_id';
    PERFORM finances.create_wallet_transaction(_target_wallet, 'DAA', _order_earnings.daa_total,
    true, concat('Order-# ', NEW.id, ' DAA'));

    IF NEW.eesupreneur_id IS NOT NULL THEN

    SELECT w.id INTO _target_wallet FROM finances.wallet w JOIN services.eesupreneur e on w.user_id = e.owner_id
    WHERE e.id = NEW.eesupreneur_id AND w.type = 'retail';

    PERFORM finances.create_wallet_transaction(_target_wallet, 'EIA', _order_earnings.eia_total,
    true, concat('Order-# ', NEW.id, ' EIA'));

    IF NEW.delivery_fee IS NOT NULL THEN

    PERFORM finances.create_wallet_transaction(_target_wallet, 'EIA', NEW.delivery_fee,
    true, concat('Order-# ', NEW.id, ' Delivery fee'));

    END IF;
    END IF;
    END IF;

    END IF;
    RETURN NEW;
END;
$function$
;



CREATE OR REPLACE FUNCTION sales.allocate_profit_earnings_for_eesupool_member_orders()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
DECLARE
    _collection_fee NUMERIC DEFAULT 0.00;
    _packaging_fee NUMERIC DEFAULT 0.00;
    _admin_fee NUMERIC DEFAULT 0.00;
    _pool_fees_rec RECORD;
    _order_earnings RECORD;
    _admin_wallet_id integer;
    _admins_count integer;
    _eesupool_id integer;
    _target_wallet_id integer;

    _assignments_privilage sales.order_edit_privilage;
BEGIN

    IF EXISTS (
            SELECT 1
            FROM sales.order_product op 
            JOIN inventory.product p ON op.product_id = p.id
            WHERE op.order_id = NEW.id 
            AND p.class <> 'Crowdfund-voucher'
    ) THEN

    IF NEW.collected_at IS NOT NULL AND NEW.status = 'Collected' AND NEW.eesupool_order_id IS NOT NULL THEN
        -- Select eesupool id
        SELECT eo.eesupool_id INTO _eesupool_id
        FROM communities.eesupool_order eo
        WHERE eo.id = NEW.eesupool_order_id;

        -- Fetch the pool fees for the associated eesupool order
        SELECT e.admin_fee, e.packaging_fee, e.collection_fee
        INTO _admin_fee, _packaging_fee, _collection_fee
        FROM communities.eesupool e
        WHERE e.id = _eesupool_id;

        -- Fetch order earnings
        SELECT * INTO _order_earnings FROM sales.get_order_summed_food_class_earnings(NEW.id);

        -- Calculate fees
        _admin_fee := (_order_earnings.eia_total * _admin_fee) / 100;
        _packaging_fee := (_order_earnings.eia_total * _packaging_fee) / 100;
        _collection_fee := (_order_earnings.eia_total * _collection_fee) / 100;

        -- Count the number of admins
        SELECT COUNT(em.id) INTO _admins_count
        FROM communities.eesupool_member em
        WHERE em.eesupool_id = _eesupool_id AND em.role = 'Admin';

        -- Loop over admin wallet IDs
        FOR _admin_wallet_id IN
            SELECT w.id FROM communities.eesupool_member em
            JOIN finances.wallet w ON em.user_id = w.user_id
            WHERE em.eesupool_id = _eesupool_id AND em.role = 'Admin'
            AND w.type = 'retail'
        LOOP
            PERFORM finances.create_wallet_transaction(_admin_wallet_id, 'EIA', _admin_fee / _admins_count,
            true, CONCAT('Order-# ', NEW.id, ' Admin Share'));
        END LOOP;

        -- Assignments
        FOR _target_wallet_id, _assignments_privilage IN
            SELECT w.id, moa.privilage
            FROM communities.member_order_assignment moa
            JOIN communities.eesupool_member em ON moa.member_id = em.id
            JOIN finances.wallet w ON em.user_id = w.user_id
            WHERE moa.order_id = NEW.id AND moa.eesupool_ord_id = NEW.eesupool_order_id AND w.type = 'retail'
        LOOP
            IF _assignments_privilage = 'Packer' THEN
                PERFORM finances.create_wallet_transaction(_target_wallet_id, 'EIA', _packaging_fee,
                true, CONCAT('Order-# ', NEW.id, ' Packaging Fee'));
            ELSIF _assignments_privilage = 'Collector' THEN
                PERFORM finances.create_wallet_transaction(_target_wallet_id, 'EIA', _collection_fee,
                true, CONCAT('Order-# ', NEW.id, ' Collection Fee'));
            ELSIF _assignments_privilage = 'All' THEN
                PERFORM finances.create_wallet_transaction(_target_wallet_id, 'EIA', _packaging_fee,
                true, CONCAT('Order-# ', NEW.id, ' Packaging Fee'));
                PERFORM finances.create_wallet_transaction(_target_wallet_id, 'EIA', _collection_fee,
                true, CONCAT('Order-# ', NEW.id, ' Collection Fee'));
            END IF;
        END LOOP;
    END IF;
    END IF;
    RETURN NEW;
END;
$function$
;