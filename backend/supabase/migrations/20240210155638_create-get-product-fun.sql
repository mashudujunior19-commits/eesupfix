CREATE OR REPLACE FUNCTION "inventory"."get_product"(_id integer)
RETURNS TABLE(id integer, category_id integer, name text, description text, image_url text, size text, brand text, type text, uom text, unit_pack_size text, flavour text, sale_price numeric, cost_price numeric, vaa numeric, vat numeric, order_max integer, child_id integer, child_break_qty integer, bar_code text, kit_kat_ref text, vat_claimable boolean, vat_able boolean, class inventory.product_class, category_name text, category_image_url text)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY 
    SELECT
        p.id,
        p.category_id,
        p.name,
        p.description,
        p.image_url,
        p.size,
        p.brand,
        p.type,
        p.uom,
        p.unit_pack_size,
        p.flavour,
        p.sale_price,
        p.cost_price,
        p.vaa,
        p.vat,
        p.order_max,
        p.child_id,
        p.child_break_qty,
        p.bar_code,
        p.kit_kat_ref,
        p.vat_claimable,
        p.vat_able,
        p.class,
        c.name,
        c.image_url AS category_image_url
    FROM inventory.product p
    INNER JOIN inventory.category c ON p.category_id = c.id
    WHERE  p.id = _id
    LIMIT 1;
END; $$;

