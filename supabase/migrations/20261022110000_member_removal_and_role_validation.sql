-- Guard rails for Kasi Pool membership and role assignment.
--
-- 1. A member cannot be removed from a pool while they hold a role on an order
--    that has not been delivered yet, or have an order in the pool that is not
--    complete (anything other than Collected / Cancelled).
-- 2. Receiver roles are validated on the server: only known roles, only members
--    of the pool that are listed as receivers of the order, one role each.

-- What stops [p_user_id] being removed from [p_pool_id]?
CREATE OR REPLACE FUNCTION communities.member_removal_blockers(p_pool_id integer, p_user_id uuid)
RETURNS jsonb
    LANGUAGE plpgsql
    STABLE
    SECURITY DEFINER
    SET search_path = public, communities, sales
    AS $$
DECLARE
    v_member_id uuid;
    v_role_orders integer;
    v_open_orders integer;
BEGIN
    SELECT m.id INTO v_member_id
    FROM communities.eesupool_member m
    WHERE m.eesupool_id = p_pool_id AND m.user_id = p_user_id;

    IF v_member_id IS NULL THEN
        RETURN jsonb_build_object('has_role', false, 'role_orders', 0, 'open_orders', 0);
    END IF;

    SELECT count(*) INTO v_role_orders
    FROM communities.eesupool_order eo
    WHERE eo.eesupool_id = p_pool_id
      AND eo.delivered_at IS NULL
      AND (v_member_id = ANY (COALESCE(eo.receivers, '{}'::uuid[]))
           OR COALESCE(eo.receiver_roles, '{}'::jsonb) ? v_member_id::text);

    SELECT count(*) INTO v_open_orders
    FROM sales.order o
    JOIN communities.eesupool_order eo ON eo.id = o.eesupool_order_id
    WHERE eo.eesupool_id = p_pool_id
      AND o.customer_id = p_user_id
      AND o.placed_at IS NOT NULL
      AND o.status NOT IN ('Collected', 'Cancelled');

    RETURN jsonb_build_object(
        'has_role', v_role_orders > 0,
        'role_orders', v_role_orders,
        'open_orders', v_open_orders
    );
END;
$$;

-- Removes a member (and any invite/request row) when the caller is a pool admin
-- and nothing blocks it. Returns {ok, reason}.
CREATE OR REPLACE FUNCTION communities.remove_pool_member(p_pool_id integer, p_user_id uuid)
RETURNS jsonb
    LANGUAGE plpgsql
    SECURITY DEFINER
    SET search_path = public, communities, sales
    AS $$
DECLARE
    blockers jsonb;
BEGIN
    IF NOT (communities.is_pool_admin(p_pool_id) OR communities.is_app_admin()) THEN
        RETURN jsonb_build_object('ok', false, 'reason', 'Only a pool admin can remove members.');
    END IF;
    IF p_user_id = auth.uid() THEN
        RETURN jsonb_build_object('ok', false, 'reason', 'You cannot remove yourself.');
    END IF;

    blockers := communities.member_removal_blockers(p_pool_id, p_user_id);
    IF (blockers ->> 'has_role')::boolean THEN
        RETURN jsonb_build_object('ok', false, 'reason',
            'This member has a role assigned on an order that is not finished. Remove their role first.');
    END IF;
    IF (blockers ->> 'open_orders')::integer > 0 THEN
        RETURN jsonb_build_object('ok', false, 'reason',
            'This member has an order that has not been completed. Wait until it is collected or cancelled.');
    END IF;

    DELETE FROM communities.eesupool_member WHERE eesupool_id = p_pool_id AND user_id = p_user_id;
    DELETE FROM communities.eesupool_request WHERE eesupool_id = p_pool_id AND user_id = p_user_id;
    RETURN jsonb_build_object('ok', true);
END;
$$;

-- Validated write of an order's receiver roles. [p_roles] maps member id -> role.
CREATE OR REPLACE FUNCTION communities.update_order_receiver_roles(p_order_id integer, p_roles jsonb)
RETURNS void
    LANGUAGE plpgsql
    SECURITY DEFINER
    SET search_path = public, communities
    AS $$
DECLARE
    v_pool integer;
    v_receivers uuid[];
    v_delivered timestamptz;
    k text;
    v text;
BEGIN
    SELECT eo.eesupool_id, COALESCE(eo.receivers, '{}'::uuid[]), eo.delivered_at
      INTO v_pool, v_receivers, v_delivered
    FROM communities.eesupool_order eo WHERE eo.id = p_order_id;

    IF v_pool IS NULL THEN
        RAISE EXCEPTION 'Order not found';
    END IF;
    IF NOT (communities.is_pool_admin(v_pool) OR communities.is_app_admin()) THEN
        RAISE EXCEPTION 'Only a pool admin can assign roles';
    END IF;
    IF v_delivered IS NOT NULL THEN
        RAISE EXCEPTION 'Roles cannot be changed once the order has been received';
    END IF;
    IF p_roles IS NULL OR jsonb_typeof(p_roles) <> 'object' THEN
        RAISE EXCEPTION 'Roles must be a member -> role map';
    END IF;

    FOR k, v IN SELECT key, value #>> '{}' FROM jsonb_each(p_roles) LOOP
        IF v NOT IN ('receiver', 'packer', 'distributor') THEN
            RAISE EXCEPTION 'Invalid role "%"', v;
        END IF;
        IF k !~ '^[0-9a-fA-F-]{36}$' OR NOT (k::uuid = ANY (v_receivers)) THEN
            RAISE EXCEPTION 'Member % is not a receiver of this order', k;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM communities.eesupool_member m
                       WHERE m.id = k::uuid AND m.eesupool_id = v_pool) THEN
            RAISE EXCEPTION 'Member % does not belong to this pool', k;
        END IF;
    END LOOP;

    UPDATE communities.eesupool_order SET receiver_roles = p_roles WHERE id = p_order_id;
END;
$$;

GRANT EXECUTE ON FUNCTION
    communities.member_removal_blockers(integer, uuid),
    communities.remove_pool_member(integer, uuid),
    communities.update_order_receiver_roles(integer, jsonb)
TO authenticated, service_role;
