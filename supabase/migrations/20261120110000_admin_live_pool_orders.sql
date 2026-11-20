-- Admin app: KasiPool orders appear (and change) live.
--
-- * communities.eesupool_order joins the supabase_realtime publication
--   (sales.order already is), so the admin app can refresh the moment a pool
--   order is closed, delivered or completed in the customer app.
-- * communities.admin_list_pool_orders(): every KasiPool order (or one pool's)
--   with its pool name and member-order counts, for app admins only. Statuses
--   are the ones the customer app and the database really write:
--     pool order  : Open / Closed (+ delivered_at)
--     member order: Pending, Placed, Packaged, Ready, Dispatched (+ collected_at
--                   = collected), Collected, Cancelled
-- Idempotent.

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_publication_tables
        WHERE pubname = 'supabase_realtime'
          AND schemaname = 'communities' AND tablename = 'eesupool_order'
    ) THEN
        ALTER PUBLICATION supabase_realtime ADD TABLE communities.eesupool_order;
    END IF;
END;
$$;

CREATE OR REPLACE FUNCTION communities.admin_list_pool_orders(
    _eesupool_id integer DEFAULT NULL,
    _limit integer DEFAULT 300
) RETURNS jsonb
    LANGUAGE plpgsql STABLE SECURITY DEFINER
    SET search_path TO 'public'
AS $$
BEGIN
    IF NOT public.is_admin() THEN
        RAISE EXCEPTION 'Only an admin can list KasiPool orders.';
    END IF;

    RETURN COALESCE((
        SELECT jsonb_agg(row_to_json(t) ORDER BY t.created_at DESC)
        FROM (
            SELECT
                eo.id,
                eo.eesupool_id,
                ep.name AS eesupool_name,
                eo.status::text AS status,
                eo.created_at,
                eo.closes_at,
                eo.schedule_for,
                eo.delivered_at,
                eo.consolidated_into,
                COUNT(o.id) FILTER (WHERE o.placed_at IS NOT NULL) AS placed_count,
                COUNT(o.id) FILTER (WHERE o.collected_at IS NOT NULL
                                     AND o.cancelled_at IS NULL) AS collected_count,
                COUNT(o.id) FILTER (WHERE o.cancelled_at IS NOT NULL
                                     OR o.status = 'Cancelled') AS cancelled_count,
                COALESCE(SUM(o.value) FILTER (WHERE o.placed_at IS NOT NULL
                                               AND o.cancelled_at IS NULL), 0) AS total_value
            FROM communities.eesupool_order eo
            JOIN communities.eesupool ep ON ep.id = eo.eesupool_id
            LEFT JOIN sales."order" o ON o.eesupool_order_id = eo.id
            WHERE _eesupool_id IS NULL OR eo.eesupool_id = _eesupool_id
            GROUP BY eo.id, ep.name
            ORDER BY eo.created_at DESC
            LIMIT GREATEST(COALESCE(_limit, 300), 1)
        ) t
    ), '[]'::jsonb);
END;
$$;

ALTER FUNCTION communities.admin_list_pool_orders(integer, integer) OWNER TO postgres;
REVOKE ALL ON FUNCTION communities.admin_list_pool_orders(integer, integer) FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION communities.admin_list_pool_orders(integer, integer) TO authenticated, service_role;
