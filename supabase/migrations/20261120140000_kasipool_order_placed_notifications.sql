-- Notifications when an order is placed in a KasiPool.
--
-- When a member order becomes Placed (placed_at set; for EFT payments that is
-- when the payment is confirmed):
--   * the customer (Ubuntunist, Corporate or a business account) gets
--     "Order placed in <KasiPool>": "You placed order #<id> in the <KasiPool> KasiPool."
--   * every admin of that KasiPool (except the customer) gets
--     "New order in <KasiPool>": "<customer name> has placed an order."
-- type 'order', channel 'push' (push goes out like every other notification row).
-- data: {order_id, eesupool_order_id, eesupool_id, kind}; kind is 'order_placed'
-- for the customer and 'member_order_placed' for the admins.
-- A notification failure never blocks the order. Idempotent.
--
-- Fix: engagements.send_order_update_notification_trigger (AFTER INSERT on
-- engagements.notification) inserted another 'order' notification for every
-- 'order' notification, which re-fired itself until "stack depth limit
-- exceeded". So no 'order' notification could ever be saved. The trigger is
-- dropped (the function is left in place, unused).

DROP TRIGGER IF EXISTS send_order_update_notification_trigger ON engagements.notification;

CREATE OR REPLACE FUNCTION communities.notify_pool_order_placed() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
AS $$
DECLARE
    _pool_id integer;
    _pool_name text;
    _name text;
    _data jsonb;
BEGIN
    IF NEW.eesupool_order_id IS NULL OR NEW.placed_at IS NULL
       OR (TG_OP = 'UPDATE' AND OLD.placed_at IS NOT NULL) THEN
        RETURN NULL;
    END IF;

    SELECT ep.id, ep.name INTO _pool_id, _pool_name
    FROM communities.eesupool_order eo
    JOIN communities.eesupool ep ON ep.id = eo.eesupool_id
    WHERE eo.id = NEW.eesupool_order_id;

    _name := communities.person_name(NEW.customer_id);
    _data := jsonb_build_object(
        'order_id', NEW.id,
        'eesupool_order_id', NEW.eesupool_order_id,
        'eesupool_id', _pool_id,
        'kind', 'order_placed');

    BEGIN
        INSERT INTO engagements.notification (user_id, title, body, data, type, channel)
        VALUES (
            NEW.customer_id,
            CONCAT('Order placed in ', _pool_name),
            CONCAT('You placed order #', NEW.id, ' in the ', _pool_name, ' KasiPool.'),
            _data, 'order', 'push');

        INSERT INTO engagements.notification (user_id, title, body, data, type, channel)
        SELECT DISTINCT m.user_id,
            CONCAT('New order in ', _pool_name),
            CONCAT(_name, ' has placed an order.'),
            _data || jsonb_build_object('kind', 'member_order_placed'),
            'order'::public.notification_type, 'push'::public.notification_channel
        FROM communities.eesupool_member m
        WHERE m.eesupool_id = _pool_id
          AND m.role = 'Admin'
          AND m.user_id <> NEW.customer_id;
    EXCEPTION WHEN OTHERS THEN
        RAISE WARNING 'order placed notifications for order % failed: %', NEW.id, SQLERRM;
    END;

    RETURN NULL;
END;
$$;

REVOKE ALL ON FUNCTION communities.notify_pool_order_placed() FROM PUBLIC, anon, authenticated;

DROP TRIGGER IF EXISTS notify_pool_order_placed_trigger ON sales."order";
CREATE TRIGGER notify_pool_order_placed_trigger
    AFTER INSERT OR UPDATE OF placed_at ON sales."order"
    FOR EACH ROW EXECUTE FUNCTION communities.notify_pool_order_placed();
