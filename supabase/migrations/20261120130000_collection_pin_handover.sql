-- Secret collection PIN for every member order in a KasiPool order.
--
-- When is a PIN issued? Once, for one member order, when ALL of these hold:
--   * the bulk order has been delivered to the KasiPool (eesupool_order.delivered_at),
--   * roles are assigned: someone is the order's Dispatcher (Dispatcher or All),
--   * the order's packing checklist is complete: the order's Packer (Packer or
--     All) has ticked every product of that order on their checklist.
-- Whichever of those happens last issues it (triggers on the checklist, the
-- delivery and the assignments). The order moves forward to Ready, and the
-- timeline gets "Packing checklist completed" and "Collection PIN issued".
-- The customer is notified that the PIN is ready (the PIN itself is never put
-- in a notification).
--
-- Who sees / uses it?
--   sales.get_my_collection_pin(order)  the ordering customer only.
--   sales.confirm_collection_with_pin(order, pin)  the order's Dispatcher only.
--     It only says right or wrong: the PIN is never returned to the Dispatcher.
--     5 wrong attempts lock the order's PIN for 15 minutes. A wrong PIN is
--     RETURNED ({ok:false, reason, attempts_left, locked}), not raised, so the
--     attempt counter is kept. The right PIN marks the order collected
--     (status Dispatched + collected_at, which the earnings triggers and the
--     apps already treat as collected) and the timeline logs who handed it over.
--   A KasiPool member order can no longer be marked collected any other way by
--   an app user (guard trigger), so an old app that writes status/collected_at
--   directly gets an error.
--
-- sales.order_collection_pin has RLS on and no policies or grants: only these
-- SECURITY DEFINER functions read it.
-- Idempotent.

-- 1. PIN store -------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS sales.order_collection_pin (
    order_id integer PRIMARY KEY REFERENCES sales."order"(id) ON DELETE CASCADE,
    pin text NOT NULL CHECK (pin ~ '^[0-9]{6}$'),
    issued_at timestamptz NOT NULL DEFAULT now(),
    failed_attempts integer NOT NULL DEFAULT 0,
    locked_until timestamptz,
    last_failed_at timestamptz,
    verified_at timestamptz,
    verified_by uuid
);

ALTER TABLE sales.order_collection_pin ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON sales.order_collection_pin FROM PUBLIC, anon, authenticated;
GRANT ALL ON sales.order_collection_pin TO service_role;

-- 2. Rules -----------------------------------------------------------------------------------

-- The user who completed the order's packing checklist (null if not complete).
CREATE OR REPLACE FUNCTION sales.order_packing_checklist_done_by(_order_id integer) RETURNS uuid
    LANGUAGE sql STABLE SECURITY DEFINER
    SET search_path TO 'public'
AS $$
    SELECT m.user_id
    FROM sales."order" o
    JOIN communities.member_order_assignment moa ON moa.order_id = o.id
    JOIN communities.eesupool_member m ON m.id = moa.member_id
    WHERE o.id = _order_id
      AND moa.privilage IN ('Packer', 'All')
      AND EXISTS (SELECT 1 FROM sales.order_product op
                  WHERE op.order_id = o.id AND COALESCE(op.quantity, 0) > 0)
      AND NOT EXISTS (
          SELECT 1 FROM sales.order_product op
          WHERE op.order_id = o.id
            AND COALESCE(op.quantity, 0) > 0
            AND NOT EXISTS (
                SELECT 1 FROM communities.role_checklist_check k
                WHERE k.user_id = m.user_id
                  AND k.eesupool_order_id = o.eesupool_order_id
                  AND k.order_id = o.id
                  AND k.product_id = op.product_id))
    LIMIT 1
$$;

CREATE OR REPLACE FUNCTION sales.new_collection_pin() RETURNS text
    LANGUAGE sql VOLATILE
    SET search_path TO 'public'
AS $$
    SELECT lpad(((('x' || encode(extensions.gen_random_bytes(4), 'hex'))::bit(32)::bigint)
                 % 1000000)::text, 6, '0')
$$;

-- Issues the order's PIN if every condition holds. Returns true when the order
-- has a PIN afterwards. Never raises (called from triggers).
CREATE OR REPLACE FUNCTION sales.issue_collection_pin_if_ready(_order_id integer) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
AS $$
DECLARE
    _o record;
    _packer uuid;
    _checked_at timestamptz;
    _pool_name text;
BEGIN
    IF EXISTS (SELECT 1 FROM sales.order_collection_pin WHERE order_id = _order_id) THEN
        RETURN true;
    END IF;

    SELECT o.*, eo.delivered_at AS pool_delivered_at, eo.eesupool_id
    INTO _o
    FROM sales."order" o
    JOIN communities.eesupool_order eo ON eo.id = o.eesupool_order_id
    WHERE o.id = _order_id;

    IF NOT FOUND
       OR _o.placed_at IS NULL
       OR _o.cancelled_at IS NOT NULL OR _o.status = 'Cancelled'
       OR _o.collected_at IS NOT NULL
       OR _o.pool_delivered_at IS NULL THEN
        RETURN false;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM communities.member_order_assignment
                   WHERE order_id = _order_id AND privilage IN ('Dispatcher', 'All', 'Collector')) THEN
        RETURN false;
    END IF;

    _packer := sales.order_packing_checklist_done_by(_order_id);
    IF _packer IS NULL THEN
        RETURN false;
    END IF;

    SELECT MAX(k.checked_at) INTO _checked_at
    FROM communities.role_checklist_check k
    WHERE k.user_id = _packer AND k.order_id = _order_id;

    INSERT INTO sales.order_collection_pin (order_id, pin)
    VALUES (_order_id, sales.new_collection_pin())
    ON CONFLICT (order_id) DO NOTHING;

    -- Packed and ready for collection (forward only).
    UPDATE sales."order"
    SET status = 'Ready',
        packaged_at = COALESCE(packaged_at, now()),
        ready_at = COALESCE(ready_at, now())
    WHERE id = _order_id AND status IN ('Placed', 'Packaged');

    PERFORM communities.log_pool_order_event(
        _o.eesupool_order_id, _order_id, 'packing_checklist_completed', _packer,
        CONCAT('Order #', _order_id), LEAST(COALESCE(_checked_at, now()), now()));
    PERFORM communities.log_pool_order_event(
        _o.eesupool_order_id, _order_id, 'pin_issued', NULL,
        'Only the customer can see it.', now());

    SELECT name INTO _pool_name FROM communities.eesupool WHERE id = _o.eesupool_id;
    BEGIN
        INSERT INTO engagements.notification (user_id, title, body, data, type, channel)
        VALUES (
            _o.customer_id,
            'Your collection PIN is ready',
            CONCAT('Order #', _order_id, ' in ', COALESCE(_pool_name, 'your KasiPool'),
                   ' is packed. Open the order to see your collection PIN and give it to the Dispatcher when you collect.'),
            jsonb_build_object('order_id', _order_id, 'eesupool_order_id', _o.eesupool_order_id,
                               'eesupool_id', _o.eesupool_id, 'kind', 'collection_pin'),
            'order', 'push');
    EXCEPTION WHEN OTHERS THEN
        RAISE WARNING 'collection PIN notification for order % failed: %', _order_id, SQLERRM;
    END;

    RETURN true;
EXCEPTION WHEN OTHERS THEN
    RAISE WARNING 'issue_collection_pin_if_ready(%) failed: %', _order_id, SQLERRM;
    RETURN false;
END;
$$;

REVOKE ALL ON FUNCTION sales.order_packing_checklist_done_by(integer) FROM PUBLIC, anon, authenticated;
REVOKE ALL ON FUNCTION sales.new_collection_pin() FROM PUBLIC, anon, authenticated;
REVOKE ALL ON FUNCTION sales.issue_collection_pin_if_ready(integer) FROM PUBLIC, anon, authenticated;
GRANT EXECUTE ON FUNCTION sales.order_packing_checklist_done_by(integer) TO service_role;
GRANT EXECUTE ON FUNCTION sales.issue_collection_pin_if_ready(integer) TO service_role;

-- 3. When to try ---------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION sales.pin_on_checklist_tick() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
AS $$
BEGIN
    IF NEW.order_id IS NOT NULL AND NEW.order_id <> 0 THEN
        PERFORM sales.issue_collection_pin_if_ready(NEW.order_id);
    END IF;
    RETURN NULL;
END;
$$;

DROP TRIGGER IF EXISTS pin_on_checklist_tick_trigger ON communities.role_checklist_check;
CREATE TRIGGER pin_on_checklist_tick_trigger
    AFTER INSERT ON communities.role_checklist_check
    FOR EACH ROW EXECUTE FUNCTION sales.pin_on_checklist_tick();

CREATE OR REPLACE FUNCTION sales.pin_on_pool_delivered() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
AS $$
DECLARE
    _id integer;
BEGIN
    IF NEW.delivered_at IS NOT NULL AND OLD.delivered_at IS NULL THEN
        FOR _id IN SELECT id FROM sales."order" WHERE eesupool_order_id = NEW.id LOOP
            PERFORM sales.issue_collection_pin_if_ready(_id);
        END LOOP;
    END IF;
    RETURN NULL;
END;
$$;

DROP TRIGGER IF EXISTS pin_on_pool_delivered_trigger ON communities.eesupool_order;
CREATE TRIGGER pin_on_pool_delivered_trigger
    AFTER UPDATE OF delivered_at ON communities.eesupool_order
    FOR EACH ROW EXECUTE FUNCTION sales.pin_on_pool_delivered();

CREATE OR REPLACE FUNCTION sales.pin_on_assignment() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
AS $$
BEGIN
    PERFORM sales.issue_collection_pin_if_ready(NEW.order_id);
    RETURN NULL;
END;
$$;

DROP TRIGGER IF EXISTS pin_on_assignment_trigger ON communities.member_order_assignment;
CREATE TRIGGER pin_on_assignment_trigger
    AFTER INSERT OR UPDATE ON communities.member_order_assignment
    FOR EACH ROW EXECUTE FUNCTION sales.pin_on_assignment();

-- 4. Customer: my PIN ------------------------------------------------------------------------

-- {state, pin, issued_at, message}. state: not_pool_order | waiting | ready |
-- collected | cancelled. pin only when state = ready and the caller placed the order.
CREATE OR REPLACE FUNCTION sales.get_my_collection_pin(_order_id integer) RETURNS jsonb
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
AS $$
DECLARE
    _o record;
    _p record;
BEGIN
    SELECT o.*, eo.delivered_at AS pool_delivered_at INTO _o
    FROM sales."order" o
    LEFT JOIN communities.eesupool_order eo ON eo.id = o.eesupool_order_id
    WHERE o.id = _order_id;

    IF NOT FOUND OR _o.customer_id IS DISTINCT FROM auth.uid() THEN
        RAISE EXCEPTION 'Only the customer who placed this order can see its collection PIN.';
    END IF;

    IF _o.eesupool_order_id IS NULL THEN
        RETURN jsonb_build_object('state', 'not_pool_order');
    END IF;
    IF _o.cancelled_at IS NOT NULL OR _o.status = 'Cancelled' THEN
        RETURN jsonb_build_object('state', 'cancelled', 'message', 'This order was cancelled.');
    END IF;

    -- In case the last condition was met without a trigger (e.g. an older order).
    PERFORM sales.issue_collection_pin_if_ready(_order_id);

    SELECT * INTO _p FROM sales.order_collection_pin WHERE order_id = _order_id;

    IF _o.collected_at IS NOT NULL THEN
        RETURN jsonb_build_object('state', 'collected', 'collected_at', _o.collected_at,
            'message', 'You have collected this order.');
    END IF;

    IF _p.order_id IS NULL THEN
        RETURN jsonb_build_object('state', 'waiting',
            'message', CASE
                WHEN _o.pool_delivered_at IS NULL
                    THEN 'Your PIN will appear once the order has been delivered to your KasiPool and packed.'
                ELSE 'Your PIN will appear once the Packer has finished packing your order.' END);
    END IF;

    RETURN jsonb_build_object(
        'state', 'ready',
        'pin', _p.pin,
        'issued_at', _p.issued_at,
        'message', 'Give this PIN to the Dispatcher when you collect your order. Do not share it with anyone else.');
END;
$$;

REVOKE ALL ON FUNCTION sales.get_my_collection_pin(integer) FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION sales.get_my_collection_pin(integer) TO authenticated, service_role;

-- 5. Dispatcher: confirm the handover ------------------------------------------------------------

CREATE OR REPLACE FUNCTION sales.confirm_collection_with_pin(_order_id integer, _pin text) RETURNS jsonb
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
AS $$
DECLARE
    _max_attempts constant integer := 5;
    _lock constant interval := interval '15 minutes';
    _o record;
    _p record;
    _left integer;
BEGIN
    SELECT o.* INTO _o FROM sales."order" o WHERE o.id = _order_id FOR UPDATE;
    IF NOT FOUND OR _o.eesupool_order_id IS NULL THEN
        RAISE EXCEPTION 'This is not a KasiPool order.';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM communities.member_order_assignment moa
        JOIN communities.eesupool_member m ON m.id = moa.member_id
        WHERE moa.order_id = _order_id
          AND moa.privilage IN ('Dispatcher', 'All', 'Collector')
          AND m.user_id = auth.uid()
    ) THEN
        RAISE EXCEPTION 'Only the Dispatcher of this order can confirm its collection.';
    END IF;

    IF _o.cancelled_at IS NOT NULL OR _o.status = 'Cancelled' THEN
        RETURN jsonb_build_object('ok', false, 'reason', 'cancelled',
            'message', 'This order was cancelled.');
    END IF;
    IF _o.collected_at IS NOT NULL THEN
        RETURN jsonb_build_object('ok', true, 'already_collected', true,
            'message', 'This order was already collected.');
    END IF;

    SELECT * INTO _p FROM sales.order_collection_pin WHERE order_id = _order_id FOR UPDATE;
    IF NOT FOUND THEN
        RETURN jsonb_build_object('ok', false, 'reason', 'not_issued',
            'message', 'There is no collection PIN yet. The order must be delivered and its packing checklist completed first.');
    END IF;

    IF _p.locked_until IS NOT NULL AND _p.locked_until > now() THEN
        RETURN jsonb_build_object('ok', false, 'reason', 'locked', 'locked', true,
            'attempts_left', 0, 'locked_until', _p.locked_until,
            'message', 'Too many wrong PINs. Try again after ' || to_char(_p.locked_until AT TIME ZONE 'Africa/Johannesburg', 'HH24:MI') || '.');
    END IF;

    -- A lock that has run out starts a fresh set of attempts.
    IF _p.locked_until IS NOT NULL AND _p.locked_until <= now() THEN
        UPDATE sales.order_collection_pin SET failed_attempts = 0, locked_until = NULL
        WHERE order_id = _order_id;
        _p.failed_attempts := 0;
    END IF;

    IF COALESCE(btrim(_pin), '') <> _p.pin THEN
        _left := GREATEST(_max_attempts - (_p.failed_attempts + 1), 0);
        UPDATE sales.order_collection_pin
        SET failed_attempts = failed_attempts + 1,
            last_failed_at = now(),
            locked_until = CASE WHEN _left = 0 THEN now() + _lock ELSE NULL END
        WHERE order_id = _order_id;
        RETURN jsonb_build_object('ok', false,
            'reason', CASE WHEN _left = 0 THEN 'locked' ELSE 'wrong' END,
            'locked', _left = 0, 'attempts_left', _left,
            'message', CASE WHEN _left = 0
                THEN 'Wrong PIN. Too many wrong attempts: collection is locked for 15 minutes.'
                ELSE 'Wrong PIN. ' || _left || CASE WHEN _left = 1 THEN ' attempt' ELSE ' attempts' END || ' left.' END);
    END IF;

    UPDATE sales.order_collection_pin
    SET verified_at = now(), verified_by = auth.uid(), failed_attempts = 0, locked_until = NULL
    WHERE order_id = _order_id;

    -- Collected. Runs as the function owner, which the guard below allows.
    UPDATE sales."order"
    SET status = 'Dispatched',
        packaged_at = COALESCE(packaged_at, now()),
        ready_at = COALESCE(ready_at, now()),
        collected_at = now()
    WHERE id = _order_id;

    RETURN jsonb_build_object('ok', true, 'collected_at', now(),
        'message', 'PIN confirmed. Order #' || _order_id || ' has been handed over.');
END;
$$;

REVOKE ALL ON FUNCTION sales.confirm_collection_with_pin(integer, text) FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION sales.confirm_collection_with_pin(integer, text) TO authenticated, service_role;

-- 6. Only the PIN can mark a KasiPool order collected ------------------------------------------

CREATE OR REPLACE FUNCTION sales.guard_pool_order_collection() RETURNS trigger
    LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.eesupool_order_id IS NOT NULL
       AND current_user IN ('authenticated', 'anon')
       AND (
            (NEW.collected_at IS NOT NULL AND OLD.collected_at IS NULL)
         OR (NEW.status IN ('Dispatched', 'Collected') AND OLD.status IS DISTINCT FROM NEW.status)
       ) THEN
        RAISE EXCEPTION 'A KasiPool order can only be marked collected when the Dispatcher enters the customer''s collection PIN.'
            USING ERRCODE = 'P0001';
    END IF;
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS a_guard_pool_order_collection_trigger ON sales."order";
CREATE TRIGGER a_guard_pool_order_collection_trigger
    BEFORE UPDATE OF status, collected_at ON sales."order"
    FOR EACH ROW EXECUTE FUNCTION sales.guard_pool_order_collection();

-- 7. Orders already waiting for collection -------------------------------------------------------

DO $$
DECLARE _id integer;
BEGIN
    FOR _id IN
        SELECT o.id FROM sales."order" o
        JOIN communities.eesupool_order eo ON eo.id = o.eesupool_order_id
        WHERE eo.delivered_at IS NOT NULL AND o.placed_at IS NOT NULL
          AND o.collected_at IS NULL AND o.cancelled_at IS NULL
    LOOP
        PERFORM sales.issue_collection_pin_if_ready(_id);
    END LOOP;
END;
$$;
