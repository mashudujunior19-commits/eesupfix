-- Adds per-receiver role assignment (Receiver / Packer / Distributor) to
-- the KasiPool "Bulk Order Receivers" list, so the pool admin can record
-- and see who does what on an order.
--
-- Kept as a jsonb map (member_id -> role text) on the existing
-- communities.eesupool_order row rather than a new join table: it's small,
-- admin-only metadata co-located with the existing "receivers" uuid[]
-- column it annotates, and (matching this repo's house style for
-- fast-moving value sets, see services.get_involved_submissions) plain text
-- role values avoid needing a migration to add a future role.

ALTER TABLE "communities"."eesupool_order"
    ADD COLUMN IF NOT EXISTS "receiver_roles" "jsonb" DEFAULT '{}'::"jsonb" NOT NULL;

-- communities.get_eesupool_orders / get_open_eesupool_order (see
-- 20260205173025_remote_schema.sql) re-declared with receiver_roles added,
-- column-for-column identical otherwise, so a pool's order list/open-order
-- fetch returns the new column too.

-- Adding a column to a function's result set needs a drop first;
-- CREATE OR REPLACE can't change a function's return type.
DROP FUNCTION IF EXISTS "communities"."get_eesupool_orders"(integer, integer);

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
        COALESCE(
            CAST(
                (SELECT SUM(o.value) FROM sales.order o
                 WHERE o.eesupool_order_id = eo.id
                 AND o.placed_at IS NOT NULL
                 AND o.cancelled_at IS NULL) AS NUMERIC
            ),
            0.00
        ) AS current_amount
    FROM communities.eesupool_order eo
    WHERE eo.eesupool_id = pool_id
    ORDER BY eo.id DESC
    LIMIT limit_to;
END;
$$;

ALTER FUNCTION "communities"."get_eesupool_orders"("pool_id" integer, "limit_to" integer) OWNER TO "postgres";
GRANT ALL ON FUNCTION "communities"."get_eesupool_orders"("pool_id" integer, "limit_to" integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_eesupool_orders"("pool_id" integer, "limit_to" integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_eesupool_orders"("pool_id" integer, "limit_to" integer) TO "service_role";

-- Adding a column to a function's result set needs a drop first;
-- CREATE OR REPLACE can't change a function's return type.
DROP FUNCTION IF EXISTS "communities"."get_open_eesupool_order"(integer);

CREATE OR REPLACE FUNCTION "communities"."get_open_eesupool_order"("pool_id" integer) RETURNS TABLE("id" integer, "eesupool_id" integer, "created_at" timestamp with time zone, "schedule_for" timestamp with time zone, "delivered_at" timestamp with time zone, "closes_at" timestamp with time zone, "admin_fee" numeric, "packer_fee" numeric, "receiver_fee" numeric, "collection_fee" numeric, "address_id" integer, "eesupool_name" "text", "address" "jsonb", "orders_count" integer, "current_amount" numeric, "secret_pin" integer, "receivers" "uuid"[], "receiver_roles" "jsonb")
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
        (select ep.name from communities.eesupool ep where ep.id = eo.eesupool_id) as eesupool_name,
        COALESCE((SELECT row_to_json(t)::jsonb
                  FROM
                  (SELECT * FROM geolocations.get_address_by_id(eo.address_id)) t), null::jsonb) AS address,
        CAST((select count(*) from sales.order o where o.eesupool_order_id = eo.id
        AND o.placed_at is not null AND o.cancelled_at isnull) as integer) as orders_count,
        COALESCE(CAST((SELECT SUM(o.value) FROM sales.order o WHERE o.eesupool_order_id = eo.id
        AND o.placed_at is not null AND o.cancelled_at isnull) AS numeric),0.00) AS current_amount,
        eo.secret_pin,
        eo.receivers,
        eo.receiver_roles
    FROM communities.eesupool_order eo
    WHERE eo.closes_at > now() AND eo.eesupool_id = pool_id
    ORDER BY eo.created_at desc limit 1;
END;
$$;

ALTER FUNCTION "communities"."get_open_eesupool_order"("pool_id" integer) OWNER TO "postgres";
GRANT ALL ON FUNCTION "communities"."get_open_eesupool_order"("pool_id" integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_open_eesupool_order"("pool_id" integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_open_eesupool_order"("pool_id" integer) TO "service_role";

-- communities.get_eesupool_order_by_id (added in
-- 20260927120000_get_involved_extensions_and_order_lookup.sql) re-declared
-- with receiver_roles added, for the same reason.

-- Adding a column to a function's result set needs a drop first;
-- CREATE OR REPLACE can't change a function's return type.
DROP FUNCTION IF EXISTS "communities"."get_eesupool_order_by_id"(integer);

CREATE OR REPLACE FUNCTION "communities"."get_eesupool_order_by_id"("order_id" integer) RETURNS TABLE("id" integer, "eesupool_id" integer, "created_at" timestamp with time zone, "schedule_for" timestamp with time zone, "delivered_at" timestamp with time zone, "closes_at" timestamp with time zone, "admin_fee" numeric, "packer_fee" numeric, "receiver_fee" numeric, "collection_fee" numeric, "address_id" integer, "secret_pin" integer, "receivers" "uuid"[], "receiver_roles" "jsonb", "status" "public"."order_type", "minimun_order_value" numeric, "warehouse_order_id" integer, "consolidated" boolean, "received_at" "date", "order_extension_count" integer, "eesupool_name" "text", "address" "jsonb", "orders_count" integer, "current_amount" numeric)
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
        COALESCE(
            CAST(
                (SELECT SUM(o.value) FROM sales.order o
                 WHERE o.eesupool_order_id = eo.id
                 AND o.placed_at IS NOT NULL
                 AND o.cancelled_at IS NULL) AS NUMERIC
            ),
            0.00
        ) AS current_amount
    FROM communities.eesupool_order eo
    WHERE eo.id = order_id;
END;
$$;

ALTER FUNCTION "communities"."get_eesupool_order_by_id"("order_id" integer) OWNER TO "postgres";
GRANT ALL ON FUNCTION "communities"."get_eesupool_order_by_id"("order_id" integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_eesupool_order_by_id"("order_id" integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_eesupool_order_by_id"("order_id" integer) TO "service_role";
