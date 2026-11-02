-- KasiPool / master order rules, enforced on the backend.
--
--  1. Minimum order: a KasiPool order (own, master or consolidated) can only
--     close when its total is >= communities.min_kasipool_order() (R10,000).
--     Applies to the manual close, direct status updates and the scheduled
--     close (communities.close_orders_at_time). Below the minimum the
--     scheduled job extends the order and tells the pool admins, who can
--     consolidate with another pool's below-minimum order.
--  2. Consolidation: communities.eesupool_order.consolidated_into links an
--     order to a "master" order. The master's total includes its children and
--     the children close when the master closes.
--  3. Receivers: added/removed atomically through RPCs, role is always
--     'receiver' (shown as "Bulk Order Receiver"), and nothing can change once
--     the order is closed or received.
--  4. Membership: only accepted members of a pool can place an order into one
--     of its orders, and the open-orders list only returns the caller's pools.
--  5. Join requests/invites: only Pending ones can be answered, only by the
--     right person, a decision is final, the requester is told the outcome and
--     the original notification records it.

-- 1. Single source of truth for the minimum --------------------------------
CREATE OR REPLACE FUNCTION communities.min_kasipool_order() RETURNS numeric
    LANGUAGE sql IMMUTABLE
    AS $$ SELECT 10000::numeric $$;

ALTER TABLE communities.eesupool_order
    ADD COLUMN IF NOT EXISTS consolidated_into integer
        REFERENCES communities.eesupool_order (id) ON DELETE SET NULL;
ALTER TABLE communities.eesupool_order
    DROP CONSTRAINT IF EXISTS eesupool_order_not_self_consolidated;
ALTER TABLE communities.eesupool_order
    ADD CONSTRAINT eesupool_order_not_self_consolidated
        CHECK (consolidated_into IS NULL OR consolidated_into <> id);
CREATE INDEX IF NOT EXISTS eesupool_order_consolidated_into_idx
    ON communities.eesupool_order (consolidated_into);

-- Total of the placed, non-cancelled member orders on an order plus any orders
-- consolidated into it.
CREATE OR REPLACE FUNCTION communities.order_total(p_order_id integer) RETURNS numeric
    LANGUAGE sql STABLE SECURITY DEFINER
    SET search_path = public, communities, sales
    AS $$
    SELECT COALESCE(SUM(o.value), 0)
    FROM sales."order" o
    WHERE o.placed_at IS NOT NULL
      AND o.cancelled_at IS NULL
      AND (o.eesupool_order_id = p_order_id
           OR o.eesupool_order_id IN (
               SELECT c.id FROM communities.eesupool_order c
               WHERE c.consolidated_into = p_order_id));
$$;

-- 2. Closing rule + next order ---------------------------------------------
-- Based on the function as it is deployed (it is called by a BEFORE UPDATE and
-- an AFTER UPDATE OF status trigger; the "no open order yet" check keeps the
-- next order from being created twice), plus the minimum-total guard.
CREATE OR REPLACE FUNCTION communities.handle_order_workflow() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_min numeric := communities.min_kasipool_order();
    v_total numeric;
    v_master_status public.order_type;
BEGIN
    IF TG_OP <> 'UPDATE' THEN
        RETURN NEW;
    END IF;

    -- Moving the closing date to now/today (the app's "Close order") on an
    -- open order is a close request: refuse it below the minimum. The nightly
    -- job (close_orders_at_time) does the actual closing.
    IF NEW.closes_at IS DISTINCT FROM OLD.closes_at
       AND NEW.status = 'Open'
       AND NEW.consolidated_into IS NULL
       AND (NEW.closes_at::date = CURRENT_DATE OR NEW.closes_at <= now()) THEN
        v_total := communities.order_total(NEW.id);
        IF v_total < v_min THEN
            RAISE EXCEPTION 'Order #% cannot close: its total (R%) is below the R% minimum.',
                NEW.id, round(v_total, 2), v_min;
        END IF;
    END IF;

    IF NEW.status = 'Closed' AND OLD.status IS DISTINCT FROM NEW.status THEN
        IF NEW.consolidated_into IS NOT NULL THEN
            SELECT m.status INTO v_master_status
            FROM communities.eesupool_order m WHERE m.id = NEW.consolidated_into;
            IF v_master_status IS DISTINCT FROM 'Closed' THEN
                RAISE EXCEPTION 'Order #% is consolidated into order #% and closes together with it.',
                    NEW.id, NEW.consolidated_into;
            END IF;
        ELSE
            v_total := communities.order_total(NEW.id);
            IF v_total < v_min THEN
                RAISE EXCEPTION 'Order #% cannot close: its total (R%) is below the R% minimum.',
                    NEW.id, round(v_total, 2), v_min;
            END IF;
        END IF;

        IF NOT EXISTS (
            SELECT 1 FROM communities.eesupool_order
            WHERE eesupool_id = NEW.eesupool_id AND status = 'Open'
        ) THEN
            INSERT INTO communities.eesupool_order (
                eesupool_id, created_at, schedule_for, closes_at, admin_fee, packer_fee,
                receiver_fee, collection_fee, address_id, receivers, consolidated,
                status, minimun_order_value
            ) VALUES (
                NEW.eesupool_id,
                now() AT TIME ZONE 'utc',
                now() AT TIME ZONE 'utc' + INTERVAL '6 days',
                now() AT TIME ZONE 'utc' + INTERVAL '3 days',
                NEW.admin_fee, NEW.packer_fee, NEW.receiver_fee, NEW.collection_fee,
                NEW.address_id, NEW.receivers, NEW.consolidated,
                'Open', NEW.minimun_order_value
            );
        END IF;
    END IF;

    RETURN NEW;
END;
$$;

-- Make sure a trigger runs the function (databases built from the migrations
-- alone have none); deployed databases already have two, so nothing is added.
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_trigger t
        WHERE t.tgrelid = 'communities.eesupool_order'::regclass
          AND t.tgfoid = 'communities.handle_order_workflow()'::regprocedure
          AND NOT t.tgisinternal
    ) THEN
        CREATE TRIGGER handle_order_workflow_trigger
            BEFORE UPDATE ON communities.eesupool_order
            FOR EACH ROW EXECUTE FUNCTION communities.handle_order_workflow();
    END IF;
END $$;

-- When a master order closes, its consolidated orders close with it (each one
-- then creates its own pool's next open order through the trigger above).
CREATE OR REPLACE FUNCTION communities.close_consolidated_children() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE communities.eesupool_order
    SET status = 'Closed'
    WHERE consolidated_into = NEW.id AND status IS DISTINCT FROM 'Closed';
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS close_consolidated_children_trigger ON communities.eesupool_order;
CREATE TRIGGER close_consolidated_children_trigger
    AFTER UPDATE OF status ON communities.eesupool_order
    FOR EACH ROW
    WHEN (NEW.status = 'Closed' AND OLD.status IS DISTINCT FROM 'Closed')
    EXECUTE FUNCTION communities.close_consolidated_children();

-- Scheduled close: close what reached the minimum, extend (and tell the pool
-- admins about) what did not. Signature unchanged, so the existing schedule
-- keeps working.
CREATE OR REPLACE FUNCTION communities.close_orders_at_time() RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path = public, communities, engagements
    AS $$
DECLARE
    r record;
    v_min numeric := communities.min_kasipool_order();
    v_total numeric;
BEGIN
    FOR r IN
        SELECT eo.id, eo.eesupool_id, eo.closes_at, eo.schedule_for, eo.order_extension_count
        FROM communities.eesupool_order eo
        WHERE eo.status = 'Open'
          AND eo.consolidated_into IS NULL
          AND eo.closes_at::date <= current_date
          AND (now() AT TIME ZONE 'utc') >= (eo.closes_at::date + time '10:00:00')
    LOOP
        BEGIN
            v_total := communities.order_total(r.id);
            IF v_total >= v_min THEN
                UPDATE communities.eesupool_order SET status = 'Closed' WHERE id = r.id;
            ELSE
                UPDATE communities.eesupool_order
                SET closes_at = GREATEST(r.closes_at, now()) + INTERVAL '3 days',
                    schedule_for = GREATEST(r.schedule_for, now() + INTERVAL '3 days') + INTERVAL '3 days',
                    order_extension_count = COALESCE(r.order_extension_count, 0) + 1
                WHERE id = r.id;

                INSERT INTO engagements.notification(user_id, title, body, data, type, channel)
                SELECT m.user_id,
                       'Order not closed',
                       format('Order #%s has not reached the R%s minimum (currently R%s), so it was extended by 3 days. '
                              'You can consolidate it with another KasiPool order that is also below the minimum.',
                              r.id, v_min, round(v_total, 2)),
                       jsonb_build_object('eesupool_id', r.eesupool_id, 'eesupool_order_id', r.id,
                                          'action', 'consolidate'),
                       'eesupool',
                       'push'
                FROM communities.eesupool_member m
                WHERE m.eesupool_id = r.eesupool_id AND m.role = 'Admin';
            END IF;
        EXCEPTION WHEN OTHERS THEN
            RAISE WARNING 'close_orders_at_time: order % skipped: %', r.id, SQLERRM;
        END;
    END LOOP;
END;
$$;

-- The deployed schedule runs an inline copy of the old rule (it also counted
-- unplaced and cancelled orders). Point it at the function instead.
DO $$
DECLARE
    v_job bigint;
BEGIN
    IF EXISTS (SELECT 1 FROM pg_extension WHERE extname = 'pg_cron') THEN
        SELECT jobid INTO v_job FROM cron.job WHERE jobname = 'close_orders_at_time';
        IF v_job IS NOT NULL THEN
            PERFORM cron.alter_job(v_job, command := 'SELECT communities.close_orders_at_time()');
        ELSE
            PERFORM cron.schedule('close_orders_at_time', '45 15 * * *',
                                  'SELECT communities.close_orders_at_time()');
        END IF;
    ELSE
        RAISE NOTICE 'pg_cron is not enabled: schedule communities.close_orders_at_time() manually.';
    END IF;
END $$;

-- Other pools' open orders that are also below the minimum and can be joined.
CREATE OR REPLACE FUNCTION communities.get_consolidation_candidates(p_order_id integer)
RETURNS TABLE (order_id integer, eesupool_id integer, pool_name text,
               current_amount numeric, closes_at timestamptz)
    LANGUAGE plpgsql STABLE SECURITY DEFINER
    SET search_path = public, communities, sales
    AS $$
DECLARE
    v_pool integer;
BEGIN
    SELECT eo.eesupool_id INTO v_pool FROM communities.eesupool_order eo WHERE eo.id = p_order_id;
    IF v_pool IS NULL THEN
        RAISE EXCEPTION 'Order not found.';
    END IF;
    IF NOT (communities.is_pool_admin(v_pool) OR communities.is_app_admin()) THEN
        RAISE EXCEPTION 'Only a KasiPool admin can consolidate orders.';
    END IF;

    RETURN QUERY
    SELECT eo.id, eo.eesupool_id, ep.name, communities.order_total(eo.id), eo.closes_at
    FROM communities.eesupool_order eo
    JOIN communities.eesupool ep ON ep.id = eo.eesupool_id
    WHERE eo.status = 'Open'
      AND eo.eesupool_id <> v_pool
      AND eo.consolidated_into IS NULL
      AND communities.order_total(eo.id) < communities.min_kasipool_order()
    ORDER BY eo.closes_at;
END;
$$;

-- Join this order to another pool's order (the master). Combined totals decide
-- when the master can close.
CREATE OR REPLACE FUNCTION communities.consolidate_orders(p_order_id integer, p_target_order_id integer)
RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path = public, communities, engagements
    AS $$
DECLARE
    v_order communities.eesupool_order;
    v_target communities.eesupool_order;
    v_min numeric := communities.min_kasipool_order();
    v_pool_name text;
BEGIN
    SELECT * INTO v_order FROM communities.eesupool_order WHERE id = p_order_id FOR UPDATE;
    SELECT * INTO v_target FROM communities.eesupool_order WHERE id = p_target_order_id FOR UPDATE;
    IF v_order.id IS NULL OR v_target.id IS NULL THEN
        RAISE EXCEPTION 'Order not found.';
    END IF;
    IF NOT (communities.is_pool_admin(v_order.eesupool_id) OR communities.is_app_admin()) THEN
        RAISE EXCEPTION 'Only a KasiPool admin can consolidate orders.';
    END IF;
    IF v_order.eesupool_id = v_target.eesupool_id THEN
        RAISE EXCEPTION 'Pick an order from a different KasiPool.';
    END IF;
    IF v_order.status IS DISTINCT FROM 'Open' OR v_target.status IS DISTINCT FROM 'Open' THEN
        RAISE EXCEPTION 'Only open orders can be consolidated.';
    END IF;
    IF v_order.consolidated_into IS NOT NULL OR v_target.consolidated_into IS NOT NULL THEN
        RAISE EXCEPTION 'One of these orders is already consolidated.';
    END IF;
    IF EXISTS (SELECT 1 FROM communities.eesupool_order c WHERE c.consolidated_into = v_order.id) THEN
        RAISE EXCEPTION 'Other orders are already consolidated into this order.';
    END IF;
    IF communities.order_total(v_order.id) >= v_min OR communities.order_total(v_target.id) >= v_min THEN
        RAISE EXCEPTION 'Only orders that are below the R% minimum can be consolidated.', v_min;
    END IF;

    UPDATE communities.eesupool_order SET consolidated_into = v_target.id WHERE id = v_order.id;

    SELECT name INTO v_pool_name FROM communities.eesupool WHERE id = v_order.eesupool_id;
    INSERT INTO engagements.notification(user_id, title, body, data, type)
    SELECT m.user_id,
           'Order consolidated',
           format('%s joined order #%s. The combined total decides when it can close (minimum R%s).',
                  COALESCE(v_pool_name, 'A KasiPool'), v_target.id, v_min),
           jsonb_build_object('eesupool_id', v_target.eesupool_id, 'eesupool_order_id', v_target.id),
           'eesupool'
    FROM communities.eesupool_member m
    WHERE m.eesupool_id = v_target.eesupool_id AND m.role = 'Admin';
END;
$$;

-- Pool order list: Amount now includes consolidated orders, so a master can be
-- seen reaching the minimum. Otherwise identical to the previous definition.
CREATE OR REPLACE FUNCTION "communities"."get_eesupool_orders"("pool_id" integer, "limit_to" integer) RETURNS TABLE("id" integer, "eesupool_id" integer, "created_at" timestamp with time zone, "schedule_for" timestamp with time zone, "delivered_at" timestamp with time zone, "closes_at" timestamp with time zone, "admin_fee" numeric, "packer_fee" numeric, "receiver_fee" numeric, "collection_fee" numeric, "address_id" integer, "secret_pin" integer, "receivers" "uuid"[], "receiver_roles" "jsonb", "status" "public"."order_type", "minimun_order_value" numeric, "warehouse_order_id" integer, "consolidated" boolean, "received_at" "date", "order_extension_count" integer, "eesupool_name" "text", "address" "jsonb", "orders_count" integer, "current_amount" numeric)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        eo.id,
        eo.eesupool_id,
        eo.created_at,
        eo.schedule_for,
        eo.delivered_at,
        eo.closes_at,
        eo.admin_fee,
        eo.packer_fee,
        eo.receiver_fee,
        eo.collection_fee,
        eo.address_id,
        eo.secret_pin,
        eo.receivers,
        eo.receiver_roles,
        COALESCE(eo.status, 'Closed'::public.order_type) AS status,
        eo.minimun_order_value,
        eo.warehouse_order_id,
        eo.consolidated,
        eo.received_at,
        eo.order_extension_count,
        (SELECT ep.name FROM communities.eesupool ep WHERE ep.id = eo.eesupool_id) AS eesupool_name,
        COALESCE(
            (SELECT row_to_json(t)::jsonb
             FROM (SELECT * FROM geolocations.get_address_by_id(eo.address_id)) t),
            NULL::jsonb
        ) AS address,
        CAST(
            (SELECT COUNT(*) FROM sales.order o
             WHERE o.eesupool_order_id = eo.id
             AND o.placed_at IS NOT NULL
             AND o.cancelled_at IS NULL) AS INTEGER
        ) AS orders_count,
        communities.order_total(eo.id) AS current_amount
    FROM communities.eesupool_order eo
    WHERE eo.eesupool_id = pool_id
    ORDER BY eo.id DESC
    LIMIT limit_to;
END;
$$;

GRANT EXECUTE ON FUNCTION
    communities.min_kasipool_order(),
    communities.order_total(integer),
    communities.get_consolidation_candidates(integer),
    communities.consolidate_orders(integer, integer)
TO authenticated, service_role;

-- 3. Receivers -------------------------------------------------------------
-- Nothing about receivers/roles may change once the order is closed/received.
CREATE OR REPLACE FUNCTION communities.reject_receiver_change_when_closed() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF (OLD.status = 'Closed' OR OLD.delivered_at IS NOT NULL)
       AND (NEW.receivers IS DISTINCT FROM OLD.receivers
            OR NEW.receiver_roles IS DISTINCT FROM OLD.receiver_roles) THEN
        RAISE EXCEPTION 'Receivers cannot be assigned or changed once the order is closed.';
    END IF;
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS reject_receiver_change_when_closed_trigger ON communities.eesupool_order;
CREATE TRIGGER reject_receiver_change_when_closed_trigger
    BEFORE UPDATE OF receivers, receiver_roles ON communities.eesupool_order
    FOR EACH ROW EXECUTE FUNCTION communities.reject_receiver_change_when_closed();

-- A failing notification must never block assigning a receiver.
CREATE OR REPLACE FUNCTION "communities"."notify_receiver_roles_assigned"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    _r record;
BEGIN
    FOR _r IN
        SELECT m.user_id, n.value AS role
        FROM jsonb_each_text(COALESCE(NEW.receiver_roles, '{}'::jsonb)) n
        JOIN communities.eesupool_member m ON m.id::text = n.key
        WHERE TG_OP = 'INSERT'
           OR (OLD.receiver_roles ->> n.key) IS DISTINCT FROM n.value
    LOOP
        BEGIN
            PERFORM communities.notify_role_assigned(
                _r.user_id,
                CASE WHEN _r.role = 'receiver' THEN 'Bulk Order Receiver' ELSE INITCAP(_r.role) END,
                NEW.id, NULL
            );
        EXCEPTION WHEN OTHERS THEN
            RAISE WARNING 'notify_receiver_roles_assigned: %', SQLERRM;
        END;
    END LOOP;
    RETURN NEW;
END;
$$;

-- Adds a receiver with the Bulk Order Receiver role (stored as 'receiver') in
-- one statement, so receivers and roles can never disagree.
CREATE OR REPLACE FUNCTION communities.add_order_receiver(p_order_id integer, p_member_id uuid)
RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path = public, communities
    AS $$
DECLARE
    v_order communities.eesupool_order;
BEGIN
    SELECT * INTO v_order FROM communities.eesupool_order WHERE id = p_order_id FOR UPDATE;
    IF v_order.id IS NULL THEN
        RAISE EXCEPTION 'Order not found.';
    END IF;
    IF NOT (communities.is_pool_admin(v_order.eesupool_id) OR communities.is_app_admin()) THEN
        RAISE EXCEPTION 'Only a KasiPool admin can assign receivers.';
    END IF;
    IF v_order.status = 'Closed' OR v_order.delivered_at IS NOT NULL THEN
        RAISE EXCEPTION 'Receivers cannot be assigned or changed once the order is closed.';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM communities.eesupool_member m
                   WHERE m.id = p_member_id AND m.eesupool_id = v_order.eesupool_id) THEN
        RAISE EXCEPTION 'That member does not belong to this KasiPool.';
    END IF;
    IF p_member_id = ANY (COALESCE(v_order.receivers, '{}'::uuid[])) THEN
        RAISE EXCEPTION 'This member is already a receiver on this order.';
    END IF;

    UPDATE communities.eesupool_order
    SET receivers = COALESCE(receivers, '{}'::uuid[]) || p_member_id,
        receiver_roles = COALESCE(receiver_roles, '{}'::jsonb)
                         || jsonb_build_object(p_member_id::text, 'receiver')
    WHERE id = p_order_id;
END;
$$;

CREATE OR REPLACE FUNCTION communities.remove_order_receiver(p_order_id integer, p_member_id uuid)
RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path = public, communities
    AS $$
DECLARE
    v_order communities.eesupool_order;
BEGIN
    SELECT * INTO v_order FROM communities.eesupool_order WHERE id = p_order_id FOR UPDATE;
    IF v_order.id IS NULL THEN
        RAISE EXCEPTION 'Order not found.';
    END IF;
    IF NOT (communities.is_pool_admin(v_order.eesupool_id) OR communities.is_app_admin()) THEN
        RAISE EXCEPTION 'Only a KasiPool admin can remove receivers.';
    END IF;
    IF v_order.status = 'Closed' OR v_order.delivered_at IS NOT NULL THEN
        RAISE EXCEPTION 'Receivers cannot be assigned or changed once the order is closed.';
    END IF;

    UPDATE communities.eesupool_order
    SET receivers = array_remove(COALESCE(receivers, '{}'::uuid[]), p_member_id),
        receiver_roles = COALESCE(receiver_roles, '{}'::jsonb) - p_member_id::text
    WHERE id = p_order_id;
END;
$$;

GRANT EXECUTE ON FUNCTION
    communities.add_order_receiver(integer, uuid),
    communities.remove_order_receiver(integer, uuid)
TO authenticated, service_role;

-- 4. Membership ------------------------------------------------------------
-- Membership rows are only created when a request/invite is Accepted (see
-- create_eesupool_member), so "is a member" means "accepted member".
CREATE OR REPLACE FUNCTION communities.enforce_pool_membership_on_order() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path = public, communities, sales
    AS $$
BEGIN
    IF NEW.eesupool_order_id IS NULL THEN
        RETURN NEW;
    END IF;
    IF TG_OP = 'UPDATE' AND NEW.eesupool_order_id IS NOT DISTINCT FROM OLD.eesupool_order_id THEN
        RETURN NEW;
    END IF;
    IF NOT EXISTS (
        SELECT 1
        FROM communities.eesupool_order eo
        JOIN communities.eesupool_member m ON m.eesupool_id = eo.eesupool_id
        WHERE eo.id = NEW.eesupool_order_id AND m.user_id = NEW.customer_id
    ) THEN
        RAISE EXCEPTION 'You can only place an order in a KasiPool you are a member of.';
    END IF;
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS enforce_pool_membership_on_order_trigger ON sales."order";
CREATE TRIGGER enforce_pool_membership_on_order_trigger
    BEFORE INSERT OR UPDATE OF eesupool_order_id ON sales."order"
    FOR EACH ROW EXECUTE FUNCTION communities.enforce_pool_membership_on_order();

-- Open orders a user can order into: only pools they are a member of (the
-- previous version also returned the referrer's pools and any pool id passed).
CREATE OR REPLACE FUNCTION "communities"."get_open_eesupool_orders"("_user_id" "uuid", "_eesupool_id" integer, "_limit_to" integer) RETURNS TABLE("id" integer, "eesupool_id" integer, "created_at" timestamp with time zone, "schedule_for" timestamp with time zone, "delivered_at" timestamp with time zone, "closes_at" timestamp with time zone, "admin_fee" numeric, "packer_fee" numeric, "receiver_fee" numeric, "collection_fee" numeric, "address_id" integer, "eesupool_name" "text", "address" "jsonb", "orders_count" integer, "current_amount" numeric, "secret_pin" integer, "status" "public"."order_type")
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        eo.id,
        eo.eesupool_id,
        eo.created_at,
        eo.schedule_for,
        eo.delivered_at,
        eo.closes_at,
        eo.admin_fee,
        eo.packer_fee,
        eo.receiver_fee,
        eo.collection_fee,
        eo.address_id,
        (SELECT ep.name FROM communities.eesupool ep WHERE ep.id = eo.eesupool_id) AS eesupool_name,
        COALESCE((SELECT row_to_json(t)::jsonb
                  FROM (SELECT * FROM geolocations.get_address_by_id(eo.address_id)) t),
                 null::jsonb) AS address,
        CAST((select count(*) from sales.order o where o.eesupool_order_id = eo.id AND
        o.placed_at is not null AND o.cancelled_at isnull) as integer) as orders_count,
        communities.order_total(eo.id) AS current_amount,
        eo.secret_pin,
        eo.status
    FROM communities.eesupool_order eo
    WHERE eo.closes_at > now()
      AND eo.status = 'Open'
      AND (_eesupool_id IS NULL OR eo.eesupool_id = _eesupool_id)
      AND EXISTS (SELECT 1 FROM communities.eesupool_member eem
                  WHERE eem.eesupool_id = eo.eesupool_id AND eem.user_id = _user_id)
    ORDER BY eo.created_at desc
    LIMIT _limit_to;
END;
$$;

-- 5. Join requests and invites ---------------------------------------------
-- Runs before the row is written, so it also covers direct table updates.
CREATE OR REPLACE FUNCTION communities.guard_request_status() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path = public, communities
    AS $$
BEGIN
    IF NEW.status IS NOT DISTINCT FROM OLD.status THEN
        RETURN NEW;
    END IF;
    IF OLD.status <> 'Pending' THEN
        RAISE EXCEPTION 'This request was already % and cannot be changed.', lower(OLD.status::text);
    END IF;
    IF NEW.status NOT IN ('Accepted', 'Declined') THEN
        RAISE EXCEPTION 'A request can only be accepted or declined.';
    END IF;
    -- auth.uid() is NULL for service-role / internal calls.
    IF auth.uid() IS NOT NULL THEN
        IF lower(OLD.type) = 'invite' THEN
            IF auth.uid() <> OLD.user_id THEN
                RAISE EXCEPTION 'Only the invited person can respond to this invite.';
            END IF;
        ELSIF NOT (communities.is_pool_admin(OLD.eesupool_id) OR communities.is_app_admin()) THEN
            RAISE EXCEPTION 'Only a KasiPool admin can respond to a join request.';
        END IF;
    END IF;
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS a_guard_request_status_trigger ON communities.eesupool_request;
CREATE TRIGGER a_guard_request_status_trigger
    BEFORE UPDATE OF status ON communities.eesupool_request
    FOR EACH ROW EXECUTE FUNCTION communities.guard_request_status();

-- Tell the person who asked to join how it went.
CREATE OR REPLACE FUNCTION communities.notify_join_request_response() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path = public, communities, engagements
    AS $$
DECLARE
    pool_name text;
BEGIN
    IF lower(NEW.type) = 'invite'
       OR OLD.status IS NOT DISTINCT FROM NEW.status
       OR NEW.status NOT IN ('Accepted', 'Declined') THEN
        RETURN NEW;
    END IF;

    SELECT name INTO pool_name FROM communities.eesupool WHERE id = NEW.eesupool_id;

    INSERT INTO engagements.notification(user_id, title, body, data, type)
    VALUES (
        NEW.user_id,
        CASE WHEN NEW.status = 'Accepted' THEN 'Request accepted' ELSE 'Request declined' END,
        CONCAT('Your request to join ', COALESCE(pool_name, 'the KasiPool'), ' was ',
               lower(NEW.status::text), '.'),
        jsonb_build_object('eesupool_id', NEW.eesupool_id, 'response', NEW.status),
        'eesupool'
    );
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS notify_join_request_response_trigger ON communities.eesupool_request;
CREATE TRIGGER notify_join_request_response_trigger
    AFTER UPDATE OF status ON communities.eesupool_request
    FOR EACH ROW EXECUTE FUNCTION communities.notify_join_request_response();

-- The original Accept/Decline notification keeps its type and records the
-- outcome in data.response, so the app can grey it out and show the result.
CREATE OR REPLACE FUNCTION communities.resolve_request_notifications() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path = public, communities, engagements
    AS $$
BEGIN
    IF NEW.status IN ('Accepted', 'Declined')
       AND OLD.status IS DISTINCT FROM NEW.status THEN
        UPDATE engagements.notification
        SET data = data || jsonb_build_object('response', NEW.status),
            seen_at = COALESCE(seen_at, now())
        WHERE data ->> 'user_id' = cast(NEW.user_id AS text)
          AND data ->> 'eesupool_id' = cast(NEW.eesupool_id AS text)
          AND type IN ('eesupool_invite', 'eesupool_request');
    END IF;
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS resolve_request_notifications_trigger ON communities.eesupool_request;
CREATE TRIGGER resolve_request_notifications_trigger
    AFTER UPDATE OF status ON communities.eesupool_request
    FOR EACH ROW EXECUTE FUNCTION communities.resolve_request_notifications();

-- Backfill the outcome onto notifications answered before this migration.
UPDATE engagements.notification n
SET data = n.data || jsonb_build_object('response', r.status)
FROM communities.eesupool_request r
WHERE n.type IN ('eesupool_invite', 'eesupool_request')
  AND n.data ->> 'user_id' = r.user_id::text
  AND n.data ->> 'eesupool_id' = r.eesupool_id::text
  AND r.status <> 'Pending'
  AND NOT (n.data ? 'response');
