-- Receiver workflow:
--
--  1. Anyone given a role on a KasiPool order (a bulk-order receiver role,
--     or a Packer / Collector / All assignment on a member's order) gets a
--     'role_assigned' notification (push + in-app). Its data carries the
--     order ids so the app can open that order's checklist.
--  2. communities.get_my_role_assigned_orders(): every KasiPool order the
--     signed-in user currently has a role on ("Role Assigned Orders").
--  3. communities.get_role_checklist(): the items bought on an order as a
--     checklist -- names, sizes and quantities only, never prices -- plus
--     whether the signed-in user has ticked each one. Only someone with a
--     role on the order (or a pool admin) can read it.
--  4. communities.set_role_checklist_item(): ticks / unticks an item. Ticks
--     are stored per user in communities.role_checklist_check.


-- Shared helper ----------------------------------------------------------

CREATE OR REPLACE FUNCTION "communities"."notify_role_assigned"("_user_id" "uuid", "_role" "text", "_eesupool_order_id" integer, "_order_id" integer) RETURNS void
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    _pool_id integer;
    _pool_name text;
BEGIN
    SELECT ep.id, ep.name INTO _pool_id, _pool_name
    FROM communities.eesupool_order eo
    JOIN communities.eesupool ep ON ep.id = eo.eesupool_id
    WHERE eo.id = _eesupool_order_id;

    INSERT INTO engagements.notification(user_id, title, body, data, type, channel)
    VALUES (
        _user_id,
        CONCAT('You''re a ', _role, ' for ', _pool_name),
        CASE WHEN _order_id IS NULL
            THEN CONCAT('You''ve been made a ', _role, ' on the ', _pool_name,
                        ' bulk order. Open your checklist to see the items.')
            ELSE CONCAT('You''ve been made a ', _role, ' on order ', _order_id,
                        ' in ', _pool_name, '. Open your checklist to see the items.')
        END,
        jsonb_build_object(
            'eesupool_id', _pool_id,
            'eesupool_order_id', _eesupool_order_id,
            'order_id', _order_id
        ),
        'role_assigned',
        'push'
    );
END;
$$;

ALTER FUNCTION "communities"."notify_role_assigned"("_user_id" "uuid", "_role" "text", "_eesupool_order_id" integer, "_order_id" integer) OWNER TO "postgres";
-- Runs as the caller (like the notification inserts elsewhere in this
-- schema, which engagements.notification's policy already allows).
REVOKE ALL ON FUNCTION "communities"."notify_role_assigned"("_user_id" "uuid", "_role" "text", "_eesupool_order_id" integer, "_order_id" integer) FROM PUBLIC, "anon";
GRANT ALL ON FUNCTION "communities"."notify_role_assigned"("_user_id" "uuid", "_role" "text", "_eesupool_order_id" integer, "_order_id" integer) TO "authenticated", "service_role";


-- 1a. Bulk-order receiver roles -------------------------------------------

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
        PERFORM communities.notify_role_assigned(
            _r.user_id, INITCAP(_r.role), NEW.id, NULL
        );
    END LOOP;
    RETURN NEW;
END;
$$;

ALTER FUNCTION "communities"."notify_receiver_roles_assigned"() OWNER TO "postgres";

DROP TRIGGER IF EXISTS "notify_receiver_roles_assigned_trigger" ON "communities"."eesupool_order";
CREATE TRIGGER "notify_receiver_roles_assigned_trigger"
    AFTER INSERT OR UPDATE OF "receiver_roles" ON "communities"."eesupool_order"
    FOR EACH ROW EXECUTE FUNCTION "communities"."notify_receiver_roles_assigned"();


-- 1b. Member-order assignments --------------------------------------------
-- Same as 20261004120000_roles_and_permissions.sql, plus notifying members
-- whose assignment is new or changed (not everyone on every save).

CREATE OR REPLACE FUNCTION "communities"."set_order_assignments"("_order_id" integer, "_assignments" "jsonb") RETURNS void
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    _pool_order_id integer;
    _pool_id integer;
    _customer_id uuid;
    _a record;
BEGIN
    SELECT o.eesupool_order_id, o.customer_id, eo.eesupool_id
    INTO _pool_order_id, _customer_id, _pool_id
    FROM sales.order o
    JOIN communities.eesupool_order eo ON eo.id = o.eesupool_order_id
    WHERE o.id = _order_id;

    IF _pool_order_id IS NULL THEN
        RAISE EXCEPTION 'Order % is not a KasiPool order', _order_id;
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM communities.eesupool_member
        WHERE eesupool_id = _pool_id AND user_id = auth.uid() AND role = 'Admin'
    ) THEN
        RAISE EXCEPTION 'Only a KasiPool admin can assign order roles';
    END IF;

    FOR _a IN
        SELECT
            (e->>'member_id')::uuid AS member_id,
            (e->>'privilage')::sales.order_edit_privilage AS privilage,
            m.user_id,
            COALESCE(p.is_verified, false) AS is_verified,
            COALESCE(
                NULLIF(TRIM(CONCAT(p.first_name, ' ', p.last_name)), ''),
                p.corp_name,
                'This member'
            ) AS full_name
        FROM jsonb_array_elements(_assignments) e
        LEFT JOIN communities.eesupool_member m ON m.id = (e->>'member_id')::uuid
        LEFT JOIN public.profile p ON p.user_id = m.user_id
    LOOP
        IF _a.user_id IS NULL THEN
            RAISE EXCEPTION 'Member % is not part of this KasiPool', _a.member_id;
        END IF;
        IF NOT _a.is_verified THEN
            RAISE EXCEPTION '% is not verified and cannot be assigned a role', _a.full_name;
        END IF;
        IF _a.user_id = _customer_id AND _a.privilage IN ('Packer', 'All') THEN
            RAISE EXCEPTION '% cannot pack their own order', _a.full_name;
        END IF;
    END LOOP;

    -- Notify before replacing rows, while the previous assignments are
    -- still there to compare against.
    FOR _a IN
        SELECT m.user_id, (e->>'privilage') AS privilage
        FROM jsonb_array_elements(_assignments) e
        JOIN communities.eesupool_member m ON m.id = (e->>'member_id')::uuid
        LEFT JOIN communities.member_order_assignment moa
            ON moa.order_id = _order_id AND moa.member_id = m.id
        WHERE moa.privilage::text IS DISTINCT FROM (e->>'privilage')
          AND (e->>'privilage') <> 'Owner'
          AND m.user_id <> auth.uid()
    LOOP
        PERFORM communities.notify_role_assigned(
            _a.user_id,
            CASE _a.privilage WHEN 'All' THEN 'Packer & Collector' ELSE _a.privilage END,
            _pool_order_id,
            _order_id
        );
    END LOOP;

    DELETE FROM communities.member_order_assignment WHERE order_id = _order_id;

    INSERT INTO communities.member_order_assignment(order_id, eesupool_ord_id, member_id, privilage)
    SELECT
        _order_id,
        _pool_order_id,
        (e->>'member_id')::uuid,
        (e->>'privilage')::sales.order_edit_privilage
    FROM jsonb_array_elements(_assignments) e;
END;
$$;


-- 2. ---------------------------------------------------------------------

CREATE OR REPLACE FUNCTION "communities"."get_my_role_assigned_orders"() RETURNS TABLE("kind" "text", "eesupool_id" integer, "eesupool_name" "text", "eesupool_order_id" integer, "order_id" integer, "role" "text", "customer_name" "text", "schedule_for" timestamp with time zone, "delivered_at" timestamp with time zone)
    LANGUAGE "plpgsql"
    -- Definer so other members' orders are visible to their assignee; rows
    -- are limited to the caller's own roles via auth.uid().
    SECURITY DEFINER
    SET search_path = public
    AS $$
BEGIN
    RETURN QUERY
    SELECT * FROM (
        -- Bulk orders the user is a receiver / packer / distributor on.
        SELECT
            'bulk'::text,
            eo.eesupool_id,
            ep.name,
            eo.id,
            NULL::integer,
            INITCAP(eo.receiver_roles ->> m.id::text),
            NULL::text,
            eo.schedule_for,
            eo.delivered_at
        FROM communities.eesupool_order eo
        JOIN communities.eesupool ep ON ep.id = eo.eesupool_id
        JOIN communities.eesupool_member m
            ON m.eesupool_id = eo.eesupool_id AND m.user_id = auth.uid()
        WHERE eo.receiver_roles ? m.id::text

        UNION ALL

        -- Other members' orders the user has been assigned to.
        SELECT
            'member'::text,
            eo.eesupool_id,
            ep.name,
            eo.id,
            o.id,
            CASE moa.privilage WHEN 'All' THEN 'Packer & Collector' ELSE moa.privilage::text END,
            COALESCE(
                NULLIF(TRIM(CONCAT(p.first_name, ' ', p.last_name)), ''),
                p.corp_name
            ),
            eo.schedule_for,
            eo.delivered_at
        FROM communities.member_order_assignment moa
        JOIN communities.eesupool_member m
            ON m.id = moa.member_id AND m.user_id = auth.uid()
        JOIN sales.order o ON o.id = moa.order_id
        JOIN communities.eesupool_order eo ON eo.id = moa.eesupool_ord_id
        JOIN communities.eesupool ep ON ep.id = eo.eesupool_id
        LEFT JOIN public.profile p ON p.user_id = o.customer_id
        WHERE o.customer_id <> auth.uid()
          AND o.placed_at IS NOT NULL
          AND o.cancelled_at IS NULL
          AND moa.privilage <> 'Owner'
    ) t
    ORDER BY 8 DESC;
END;
$$;

ALTER FUNCTION "communities"."get_my_role_assigned_orders"() OWNER TO "postgres";
GRANT ALL ON FUNCTION "communities"."get_my_role_assigned_orders"() TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_my_role_assigned_orders"() TO "service_role";


-- 3. & 4. ----------------------------------------------------------------

CREATE TABLE IF NOT EXISTS "communities"."role_checklist_check" (
    "user_id" "uuid" NOT NULL DEFAULT auth.uid(),
    "eesupool_order_id" integer NOT NULL REFERENCES "communities"."eesupool_order"("id") ON DELETE CASCADE,
    -- 0 for the bulk-order checklist, otherwise the member order's id.
    "order_id" integer NOT NULL DEFAULT 0,
    "product_id" integer NOT NULL,
    "checked_at" timestamp with time zone NOT NULL DEFAULT now(),
    PRIMARY KEY ("user_id", "eesupool_order_id", "order_id", "product_id")
);

ALTER TABLE "communities"."role_checklist_check" OWNER TO "postgres";
ALTER TABLE "communities"."role_checklist_check" ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users manage their own checklist ticks" ON "communities"."role_checklist_check";
CREATE POLICY "Users manage their own checklist ticks" ON "communities"."role_checklist_check"
    TO "authenticated" USING ("user_id" = auth.uid()) WITH CHECK ("user_id" = auth.uid());

GRANT ALL ON TABLE "communities"."role_checklist_check" TO "authenticated";
GRANT ALL ON TABLE "communities"."role_checklist_check" TO "service_role";


CREATE OR REPLACE FUNCTION "communities"."can_view_role_checklist"("_eesupool_order_id" integer, "_order_id" integer) RETURNS boolean
    LANGUAGE "sql"
    STABLE
    AS $$
    SELECT
        -- Pool admins can see every checklist in their pool.
        EXISTS (
            SELECT 1
            FROM communities.eesupool_order eo
            JOIN communities.eesupool_member m
                ON m.eesupool_id = eo.eesupool_id AND m.user_id = auth.uid()
            WHERE eo.id = _eesupool_order_id AND m.role = 'Admin'
        )
        -- Bulk receiver roles cover the whole bulk order.
        OR EXISTS (
            SELECT 1
            FROM communities.eesupool_order eo
            JOIN communities.eesupool_member m
                ON m.eesupool_id = eo.eesupool_id AND m.user_id = auth.uid()
            WHERE eo.id = _eesupool_order_id AND eo.receiver_roles ? m.id::text
        )
        -- A member-order assignment covers that one order.
        OR (_order_id IS NOT NULL AND EXISTS (
            SELECT 1
            FROM communities.member_order_assignment moa
            JOIN communities.eesupool_member m
                ON m.id = moa.member_id AND m.user_id = auth.uid()
            WHERE moa.order_id = _order_id
              AND moa.eesupool_ord_id = _eesupool_order_id
              AND moa.privilage <> 'Owner'
        ));
$$;

ALTER FUNCTION "communities"."can_view_role_checklist"("_eesupool_order_id" integer, "_order_id" integer) OWNER TO "postgres";


-- Deliberately returns no price columns: people with a role on an order
-- see what was bought, not what it cost.
CREATE OR REPLACE FUNCTION "communities"."get_role_checklist"("_eesupool_order_id" integer, "_order_id" integer DEFAULT NULL) RETURNS TABLE("product_id" integer, "name" "text", "size" "text", "image_url" "text", "category" "text", "quantity" integer, "is_checked" boolean)
    LANGUAGE "plpgsql"
    SECURITY DEFINER
    SET search_path = public
    AS $$
BEGIN
    IF NOT communities.can_view_role_checklist(_eesupool_order_id, _order_id) THEN
        RAISE EXCEPTION 'You don''t have a role on this order';
    END IF;

    RETURN QUERY
    SELECT
        p.id,
        p.name,
        p.size,
        p.image_url,
        c.name,
        CAST(SUM(op.quantity) AS integer),
        EXISTS (
            SELECT 1 FROM communities.role_checklist_check k
            WHERE k.user_id = auth.uid()
              AND k.eesupool_order_id = _eesupool_order_id
              AND k.order_id = COALESCE(_order_id, 0)
              AND k.product_id = p.id
        )
    FROM sales.order_product op
    JOIN sales.order o ON o.id = op.order_id
    JOIN inventory.product p ON p.id = op.product_id
    JOIN inventory.category c ON c.id = p.category_id
    WHERE o.eesupool_order_id = _eesupool_order_id
      AND o.placed_at IS NOT NULL
      AND o.cancelled_at IS NULL
      AND (_order_id IS NULL OR o.id = _order_id)
    GROUP BY p.id, p.name, p.size, p.image_url, c.name
    ORDER BY c.name, p.name;
END;
$$;

ALTER FUNCTION "communities"."get_role_checklist"("_eesupool_order_id" integer, "_order_id" integer) OWNER TO "postgres";
GRANT ALL ON FUNCTION "communities"."get_role_checklist"("_eesupool_order_id" integer, "_order_id" integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_role_checklist"("_eesupool_order_id" integer, "_order_id" integer) TO "service_role";


CREATE OR REPLACE FUNCTION "communities"."set_role_checklist_item"("_eesupool_order_id" integer, "_order_id" integer, "_product_id" integer, "_checked" boolean) RETURNS void
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF NOT communities.can_view_role_checklist(_eesupool_order_id, _order_id) THEN
        RAISE EXCEPTION 'You don''t have a role on this order';
    END IF;

    IF _checked THEN
        INSERT INTO communities.role_checklist_check(user_id, eesupool_order_id, order_id, product_id)
        VALUES (auth.uid(), _eesupool_order_id, COALESCE(_order_id, 0), _product_id)
        ON CONFLICT DO NOTHING;
    ELSE
        DELETE FROM communities.role_checklist_check
        WHERE user_id = auth.uid()
          AND eesupool_order_id = _eesupool_order_id
          AND order_id = COALESCE(_order_id, 0)
          AND product_id = _product_id;
    END IF;
END;
$$;

ALTER FUNCTION "communities"."set_role_checklist_item"("_eesupool_order_id" integer, "_order_id" integer, "_product_id" integer, "_checked" boolean) OWNER TO "postgres";
GRANT ALL ON FUNCTION "communities"."set_role_checklist_item"("_eesupool_order_id" integer, "_order_id" integer, "_product_id" integer, "_checked" boolean) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."set_role_checklist_item"("_eesupool_order_id" integer, "_order_id" integer, "_product_id" integer, "_checked" boolean) TO "service_role";
