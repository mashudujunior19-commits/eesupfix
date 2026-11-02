-- READ-ONLY report: KasiPool orders that are Closed but never reached the
-- minimum (communities.min_kasipool_order(), R10,000), and member orders placed
-- by people who are not members of the pool. Run in the Supabase SQL editor
-- AFTER applying 20261102090000_kasipool_order_rules.sql. Changes nothing.

-- 1. Closed below the minimum (includes R0.00 / zero member orders).
SELECT eo.id AS order_id,
       eo.eesupool_id,
       ep.name AS pool_name,
       eo.status,
       eo.closes_at,
       eo.consolidated_into,
       (SELECT count(*) FROM sales."order" o
         WHERE o.eesupool_order_id = eo.id AND o.placed_at IS NOT NULL
           AND o.cancelled_at IS NULL) AS member_orders,
       communities.order_total(eo.id) AS total
FROM communities.eesupool_order eo
JOIN communities.eesupool ep ON ep.id = eo.eesupool_id
WHERE eo.status = 'Closed'
  AND eo.consolidated_into IS NULL
  AND communities.order_total(eo.id) < communities.min_kasipool_order()
ORDER BY eo.id;

-- 2. Member orders placed into a pool by someone who is not a member of it.
SELECT o.id AS member_order_id,
       o.customer_id,
       o.eesupool_order_id,
       eo.eesupool_id,
       o.value,
       o.placed_at
FROM sales."order" o
JOIN communities.eesupool_order eo ON eo.id = o.eesupool_order_id
WHERE NOT EXISTS (SELECT 1 FROM communities.eesupool_member m
                  WHERE m.eesupool_id = eo.eesupool_id AND m.user_id = o.customer_id)
ORDER BY o.id;
