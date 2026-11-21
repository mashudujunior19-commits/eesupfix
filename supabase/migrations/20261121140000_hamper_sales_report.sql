-- Hampers phase 3: real sales numbers for the admin app.
--
-- Until now the admin app showed the hand-typed `inventory.hamper.total_sales`.
-- `public.get_hamper_sales()` works the numbers out from the orders instead.
--
--   * An order line counts when its product is a hamper product
--     (`inventory.product.hamper_id`) and the order is not Pending or Cancelled.
--   * revenue  = sum(order line price x quantity), the price the customer paid.
--   * cost     = units sold x today's cost of the hamper's items
--                (quantity x cost_price, free items included).
--   * profit   = revenue - cost.
--   Cost uses current item cost prices, so profit for old orders is an estimate
--   if cost prices have changed since.
--
-- Admin only. Customers get an error, never numbers.
-- Needs public.is_admin() (migration 20261103150000).

CREATE OR REPLACE FUNCTION public.get_hamper_sales()
RETURNS jsonb
LANGUAGE plpgsql
STABLE
SECURITY DEFINER
SET search_path = public, inventory, sales
AS $$
DECLARE
    result jsonb;
BEGIN
    IF NOT public.is_admin() THEN
        RAISE EXCEPTION 'Only admins can see hamper sales'
            USING ERRCODE = '42501';
    END IF;

    WITH item_cost AS (
        SELECT hp.hamper_id,
               COALESCE(SUM(hp.quantity * p.cost_price), 0) AS unit_cost
        FROM inventory.hamper_product hp
        JOIN inventory.product p ON p.id = hp.product_id
        GROUP BY hp.hamper_id
    ),
    lines AS (
        SELECT pr.hamper_id,
               op.order_id,
               op.quantity,
               op.price,
               COALESCE(o.placed_at, o.created_at) AS sold_at
        FROM sales.order_product op
        JOIN inventory.product pr ON pr.id = op.product_id
        JOIN sales."order" o ON o.id = op.order_id
        WHERE pr.hamper_id IS NOT NULL
          AND o.status NOT IN ('Pending', 'Cancelled')
    ),
    sold AS (
        SELECT hamper_id,
               COUNT(DISTINCT order_id)                       AS orders,
               COALESCE(SUM(quantity), 0)                     AS units,
               COALESCE(SUM(quantity * price), 0)             AS revenue,
               COALESCE(SUM(quantity) FILTER (
                   WHERE sold_at >= now() - interval '30 days'), 0) AS units_30d,
               MAX(sold_at)                                   AS last_sold_at
        FROM lines
        GROUP BY hamper_id
    )
    SELECT COALESCE(jsonb_agg(jsonb_build_object(
               'hamper_id',    h.id,
               'code',         h.code,
               'type',         h.type,
               'price',        h.value,
               'is_final',     COALESCE(h.is_final, false),
               'expiry_date',  h.expiry_date,
               'orders',       COALESCE(s.orders, 0),
               'units_sold',   COALESCE(s.units, 0),
               'units_30d',    COALESCE(s.units_30d, 0),
               'revenue',      round(COALESCE(s.revenue, 0), 2),
               'cost',         round(COALESCE(s.units, 0) * COALESCE(c.unit_cost, 0), 2),
               'profit',       round(COALESCE(s.revenue, 0)
                                     - COALESCE(s.units, 0) * COALESCE(c.unit_cost, 0), 2),
               'last_sold_at', s.last_sold_at
           ) ORDER BY COALESCE(s.revenue, 0) DESC, h.code), '[]'::jsonb)
    INTO result
    FROM inventory.hamper h
    LEFT JOIN sold s ON s.hamper_id = h.id
    LEFT JOIN item_cost c ON c.hamper_id = h.id;

    RETURN result;
END;
$$;

REVOKE ALL ON FUNCTION public.get_hamper_sales() FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.get_hamper_sales() TO authenticated, service_role;
