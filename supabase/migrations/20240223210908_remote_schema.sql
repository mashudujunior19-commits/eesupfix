alter table "communities"."eesupool" add constraint "eesupool_parent_id_fkey" FOREIGN KEY (parent_id) REFERENCES communities.eesupool(id) ON DELETE SET NULL not valid;

alter table "communities"."eesupool" validate constraint "eesupool_parent_id_fkey";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION communities.get_user_eesupools_v2(id uuid, limit_to integer, pool_type communities.eesupool_type)
 RETURNS TABLE(eesupool_id integer, name text, description text, code integer, is_public boolean, address_id integer, type communities.eesupool_type, parent_id integer, level communities.eesupool_level, chat_enabled boolean, admin_fee numeric, receiving_fee numeric, collection_fee numeric, packaging_fee numeric, chat_tags text[], chat_tags_suggestions text[], member_id uuid, role communities.eesupool_member_role, is_censored boolean, num_members integer, unseen_messages integer, address jsonb)
 LANGUAGE plpgsql
AS $function$
BEGIN
RETURN QUERY
SELECT 
    e.id as eesupool_id, 
    e.name,
    e.description,
    e.code,
    e.is_public,
    e.address_id,
    e.type,
    e.parent_id,
    e.level,
    e.chat_enabled,
    e.admin_fee,
    e.receiving_fee,
    e.collection_fee,
    e.packaging_fee,
    e.chat_tags,
    e.chat_tags_suggestions,
    em.id as member_id,
    em.role,
    em.is_censored,
   CAST(COALESCE((SELECT COUNT(m.id) FROM communities.eesupool_member m WHERE m.eesupool_id = e.id), 0) AS integer) as num_members,
   CAST(COALESCE((SELECT count_unseen_messages FROM communities.count_unseen_messages(e.id, em.id)),0) AS integer) as unseen_messages,
   COALESCE((SELECT row_to_json(t)::jsonb 
            FROM (SELECT * FROM geolocations.get_address_by_id(e.address_id)) t), null) AS address
FROM 
    communities.eesupool e
JOIN 
    communities.eesupool_member em ON e.id = em.eesupool_id
WHERE  
    em.user_id = $1 AND
    e.type = $3
ORDER BY 
    e.id
LIMIT 
    $2;
END;
$function$
;

CREATE OR REPLACE FUNCTION communities.get_eesupool_messages(pool_id integer, approved boolean, limit_to integer)
 RETURNS TABLE(id integer, eesupool_id integer, author_id uuid, created_at timestamp with time zone, content text, reply_on_id integer, attachments jsonb[], author_full_name text, reply_message jsonb, reactions jsonb, is_approved boolean, hash_tags text[], is_deleted boolean, message_seens uuid[])
 LANGUAGE plpgsql
 STABLE
AS $function$
BEGIN
    RETURN QUERY
    SELECT 
        m.id,
        m.eesupool_id,
        m.author_id,
        m.created_at,
        m.content,
        m.reply_on_id,
        m.attachments,
        (SELECT CONCAT(p.first_name, ' ', p.last_name) 
         FROM profile p 
         JOIN communities.eesupool_member em ON p.user_id = em.user_id
         WHERE em.id = m.author_id) AS author_full_name,
        COALESCE((SELECT row_to_json(t)::jsonb 
                  FROM (SELECT * FROM communities.get_message_by_id(m.reply_on_id)) t), 'null'::jsonb) AS reply_message,
        COALESCE((SELECT jsonb_agg(t) 
                  FROM (SELECT * FROM communities.get_message_reactions(m.id)) t), 'null'::jsonb) AS reactions, 
        m.is_approved,
        m.hash_tags,
        m.is_deleted,
        ARRAY_AGG(ms.member_id) FILTER (WHERE ms.message_id = m.id) AS message_seens
    FROM 
        communities.message m
    LEFT JOIN communities.message_seen ms ON m.id = ms.message_id
    WHERE 
        m.eesupool_id = pool_id AND m.is_approved = approved
    GROUP BY 
        m.id, m.eesupool_id, m.author_id, m.created_at, m.content,
        m.reply_on_id, m.attachments, author_full_name, reply_message,
        reactions, m.is_approved, m.hash_tags, m.is_deleted
    ORDER BY 
        m.created_at DESC
    LIMIT 
        limit_to;
END;
$function$
;

CREATE OR REPLACE FUNCTION communities.get_eesupool_orders(pool_id integer, limit_to integer)
 RETURNS TABLE(id integer, eesupool_id integer, receiver_id uuid, created_at timestamp with time zone, schedule_for timestamp with time zone, delivered_at timestamp with time zone, closes_at timestamp with time zone, admin_fee numeric, packer_fee numeric, receiver_fee numeric, collection_fee numeric, address_id integer, receiver jsonb, eesupool_name text, address jsonb, orders_count integer, current_amount numeric)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT 
        eo.id,
        eo.eesupool_id,
        eo.receiver_id,
        eo.created_at,
        eo.schedule_for,
        eo.delivered_at,
        eo.closes_at,
        eo.admin_fee,
        eo.packer_fee,
        eo.receiver_fee,
        eo.collection_fee,
        eo.address_id,
        COALESCE((SELECT row_to_json(t)::jsonb 
                  FROM 
                  (SELECT * FROM communities.get_eesupool_member_by_id(eo.receiver_id)) t), null::jsonb) AS receiver,
        (select ep.name from communities.eesupool ep where ep.id = eo.eesupool_id) as eesupool_name,
        COALESCE((SELECT row_to_json(t)::jsonb 
                  FROM 
                  (SELECT * FROM geolocations.get_address_by_id(eo.address_id)) t), null::jsonb) AS address,
        CAST((select count(*) from sales.order o where o.eesupool_order_id = eo.id) as integer) as orders_count,
        COALESCE(CAST((SELECT SUM(o.value) FROM sales.order o WHERE o.eesupool_order_id = eo.id AND (o.status <> 'Pending' AND o.status <> 'Cancelled')) AS numeric),0.00) AS current_amount            
    FROM communities.eesupool_order eo
    WHERE eo.eesupool_id = pool_id limit limit_to;
END;
$function$
;

CREATE OR REPLACE FUNCTION communities.get_message_by_id(m_id integer)
 RETURNS TABLE(id integer, eesupool_id integer, author_id uuid, created_at timestamp with time zone, content text, reply_on_id integer, attachments jsonb[], author_full_name text, reply_message jsonb, reactions jsonb, is_approved boolean, hash_tags text[], is_deleted boolean, message_seens uuid[])
 LANGUAGE plpgsql
 STABLE
AS $function$
BEGIN
    RETURN QUERY
    SELECT 
        m.id,
        m.eesupool_id,
        m.author_id,
        m.created_at,
        m.content,
        m.reply_on_id,
        m.attachments,
        (SELECT CONCAT(p.first_name, ' ', p.last_name) 
         FROM profile p 
         JOIN communities.eesupool_member em ON p.user_id = em.user_id
         WHERE em.id = m.author_id) AS author_full_name,
        COALESCE((SELECT row_to_json(t)::jsonb 
                  FROM (SELECT * FROM communities.get_message_by_id(m.reply_on_id)) t), 'null'::jsonb) AS reply_message,
        COALESCE((SELECT jsonb_agg(t) 
                  FROM (SELECT * FROM communities.get_message_reactions(m.id)) t), 'null'::jsonb) AS reactions,
        m.is_approved,
        m.hash_tags,
        m.is_deleted,
        ARRAY_AGG(ms.member_id) FILTER (WHERE ms.message_id = m.id) AS message_seens
    FROM 
        communities.message m
    LEFT JOIN communities.message_seen ms ON m.id = ms.message_id
    WHERE 
        m.id = m_id
    GROUP BY 
        m.id, m.eesupool_id, m.author_id, m.created_at, m.content, m.reply_on_id,
        m.attachments, author_full_name, m.is_approved, m.hash_tags, m.is_deleted
    LIMIT 1;
END;
$function$
;

CREATE OR REPLACE FUNCTION communities.get_open_eesupool_order(pool_id integer)
 RETURNS TABLE(id integer, eesupool_id integer, receiver_id uuid, created_at timestamp with time zone, schedule_for timestamp with time zone, delivered_at timestamp with time zone, closes_at timestamp with time zone, admin_fee numeric, packer_fee numeric, receiver_fee numeric, collection_fee numeric, address_id integer, receiver jsonb, eesupool_name text, address jsonb, orders_count integer, current_amount numeric)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT 
        eo.id,
        eo.eesupool_id,
        eo.receiver_id,
        eo.created_at,
        eo.schedule_for,
        eo.delivered_at,
        eo.closes_at,
        eo.admin_fee,
        eo.packer_fee,
        eo.receiver_fee,
        eo.collection_fee,
        eo.address_id,
        COALESCE((SELECT row_to_json(t)::jsonb 
                  FROM 
                  (SELECT * FROM communities.get_eesupool_member_by_id(eo.receiver_id)) t), null::jsonb) AS receiver,
        (select ep.name from communities.eesupool ep where ep.id = eo.eesupool_id) as eesupool_name,
        COALESCE((SELECT row_to_json(t)::jsonb 
                  FROM 
                  (SELECT * FROM geolocations.get_address_by_id(eo.address_id)) t), null::jsonb) AS address,
        CAST((select count(*) from sales.order o where o.eesupool_order_id = eo.id) as integer) as orders_count,
        COALESCE(CAST((SELECT SUM(o.value) FROM sales.order o WHERE o.eesupool_order_id = eo.id AND (o.status <> 'Pending' AND o.status <> 'Cancelled')) AS numeric),0.00) AS current_amount  
    FROM communities.eesupool_order eo
    WHERE eo.closes_at > now() AND eo.eesupool_id = pool_id
    ORDER BY eo.created_at desc limit 1;
END;
$function$
;

CREATE OR REPLACE FUNCTION communities.get_open_eesupool_orders(_user_id uuid, _eesupool_id integer, _limit_to integer)
 RETURNS TABLE(id integer, eesupool_id integer, receiver_id uuid, created_at timestamp with time zone, schedule_for timestamp with time zone, delivered_at timestamp with time zone, closes_at timestamp with time zone, admin_fee numeric, packer_fee numeric, receiver_fee numeric, collection_fee numeric, address_id integer, receiver jsonb, eesupool_name text, address jsonb, orders_count integer, current_amount numeric)
 LANGUAGE plpgsql
AS $function$
DECLARE
    _referrer_user_id uuid;
BEGIN
    -- Get the user that referred this user so we can also get orders that they may have placed
    SELECT referrer_user_id INTO _referrer_user_id FROM referral WHERE refereed_user_id = _user_id;

    -- Get orders, including those from the referring user if applicable
    RETURN QUERY
    SELECT 
        eo.id,
        eo.eesupool_id,
        eo.receiver_id,
        eo.created_at,
        eo.schedule_for,
        eo.delivered_at,
        eo.closes_at,
        eo.admin_fee,
        eo.packer_fee,
        eo.receiver_fee,
        eo.collection_fee,
        eo.address_id,
        COALESCE((SELECT row_to_json(t)::jsonb 
                  FROM 
                  (SELECT * FROM communities.get_eesupool_member_by_id(eo.receiver_id)) t), null::jsonb) AS receiver,
        (SELECT ep.name FROM communities.eesupool ep WHERE ep.id = eo.eesupool_id) AS eesupool_name,
        COALESCE((SELECT row_to_json(t)::jsonb 
                  FROM (SELECT * FROM geolocations.get_address_by_id(eo.address_id)) t), 
                 null::jsonb) AS address,
        CAST((select count(*) from sales.order o where o.eesupool_order_id = eo.id) as integer) as orders_count,
        COALESCE(CAST((SELECT SUM(o.value) FROM sales.order o WHERE o.eesupool_order_id = eo.id AND (o.status <> 'Pending' AND o.status <> 'Cancelled')) AS numeric),0.00) AS current_amount  
    FROM communities.eesupool_order eo 
    INNER JOIN communities.eesupool_member eem ON eo.eesupool_id = eem.eesupool_id
    WHERE eo.closes_at > now() AND
    ((eem.user_id = _user_id OR (_referrer_user_id IS NOT NULL AND eem.user_id = _referrer_user_id)) or eo.eesupool_id = _eesupool_id)
    ORDER BY eo.created_at desc
    LIMIT _limit_to;
END;
$function$
;


drop function if exists "inventory"."get_product"(_id integer);

drop function if exists "inventory"."get_products_by_category"(cat_id integer, role user_role, limit_to integer);

drop function if exists "inventory"."get_random_products"(role user_role, limit_to integer);

drop function if exists "inventory"."search_products"(query_str text, role user_role, limit_to integer);

alter table "inventory"."product" add column "sellable" boolean not null default true;

alter table "inventory"."product" alter column "roles" set not null;

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION inventory.get_product(_id integer)
 RETURNS TABLE(id integer, category_id integer, name text, description text, image_url text, size text, brand text, type text, uom text, unit_pack_size text, flavour text, sale_price numeric, cost_price numeric, vaa numeric, vat numeric, order_max integer, child_id integer, child_break_qty integer, bar_code text, kit_kat_ref text, vat_claimable boolean, vat_able boolean, class inventory.product_class, category_name text, category_image_url text, sellable boolean)
 LANGUAGE plpgsql
AS $function$
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
        c.image_url AS category_image_url,
        p.sellable
    FROM inventory.product p
    INNER JOIN inventory.category c ON p.category_id = c.id
    WHERE  p.id = _id
    LIMIT 1;
END; $function$
;

CREATE OR REPLACE FUNCTION inventory.get_products_by_category(cat_id integer, role user_role, limit_to integer)
 RETURNS TABLE(id integer, category_id integer, name text, description text, image_url text, size text, brand text, type text, uom text, unit_pack_size text, flavour text, sale_price numeric, cost_price numeric, vaa numeric, vat numeric, order_max integer, child_id integer, child_break_qty integer, bar_code text, kit_kat_ref text, vat_claimable boolean, vat_able boolean, class inventory.product_class, category_name text, category_image_url text, sellable boolean)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY WITH RECURSIVE all_categories AS (
        SELECT c.id AS ac_category_id, c.name AS ac_category_name FROM inventory.category c WHERE c.id = cat_id
        UNION ALL
        SELECT c.id AS ac_category_id, c.name AS ac_category_name FROM inventory.category c
        INNER JOIN all_categories ac ON c.parent_id = ac.ac_category_id
    )
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
        ac.ac_category_name,
        c.image_url AS category_image_url,
        p.sellable
    FROM
        inventory.product p
    INNER JOIN all_categories ac ON p.category_id = ac.ac_category_id
    INNER JOIN inventory.category c ON p.category_id = c.id
    WHERE
        p.is_active = true AND role = ANY(p.roles) AND p.sale_price > 0
    LIMIT limit_to;
END; $function$
;

CREATE OR REPLACE FUNCTION inventory.get_random_products(role user_role, limit_to integer)
 RETURNS TABLE(id integer, category_id integer, name text, description text, image_url text, size text, brand text, type text, uom text, unit_pack_size text, flavour text, sale_price numeric, cost_price numeric, vaa numeric, vat numeric, order_max integer, child_id integer, child_break_qty integer, bar_code text, kit_kat_ref text, vat_claimable boolean, vat_able boolean, class inventory.product_class, category_name text, category_image_url text, sellable boolean)
 LANGUAGE plpgsql
AS $function$
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
        c.image_url AS category_image_url,
        p.sellable
    FROM inventory.product p
    INNER JOIN inventory.category c ON p.category_id = c.id
    WHERE  p.is_active = true AND role = ANY(p.roles) AND p.sale_price > 0
    ORDER BY random()
    LIMIT limit_to;
END; $function$
;

CREATE OR REPLACE FUNCTION inventory.search_products(query_str text, role user_role, limit_to integer)
 RETURNS TABLE(id integer, category_id integer, name text, description text, image_url text, size text, brand text, type text, uom text, unit_pack_size text, flavour text, sale_price numeric, cost_price numeric, vaa numeric, vat numeric, order_max integer, child_id integer, child_break_qty integer, bar_code text, kit_kat_ref text, vat_claimable boolean, vat_able boolean, class inventory.product_class, category_name text, category_image_url text, sellable boolean)
 LANGUAGE plpgsql
AS $function$
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
        c.name AS category_name,
        c.image_url AS category_image_url,
        p.sellable
    FROM
        inventory.product p
    INNER JOIN inventory.category c ON p.category_id = c.id
    WHERE
       p.is_active = true AND role = ANY(p.roles) AND
        (
            p.name ILIKE '%' || query_str || '%' OR
            p.description ILIKE '%' || query_str || '%' OR
            p.brand ILIKE '%' || query_str || '%' OR
            p.flavour ILIKE '%' || query_str || '%' OR
            p.size ILIKE '%' || query_str || '%' OR
            p.class::text ILIKE '%' || query_str || '%' OR
            p.type ILIKE '%' || query_str || '%' OR
            c.name ILIKE '%' || query_str || '%'
        )
    Limit limit_to;
END; $function$
;


alter table "public"."basket_product" add column "substitute_brand" boolean not null default false;

alter table "public"."basket_product" add column "substitute_variant" boolean not null default false;

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.get_basket_products_v2(_basket_id uuid)
 RETURNS TABLE(basket_id uuid, product_id integer, image_url text, category text, name text, quantity integer, price numeric, size text, class inventory.product_class, substitute_brand boolean, substitute_variant boolean, sellable boolean)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY 
    SELECT
        bp.basket_id,
        bp.product_id,
        p.image_url,
        c.name AS category,
        p.name,
        bp.quantity,
        p.sale_price AS price,
        p.size,
        p.class,
        bp.substitute_brand,
        bp.substitute_variant,
        p.sellable
    FROM
        public.basket_product AS bp
        JOIN inventory.product AS p ON bp.product_id = p.id
        JOIN inventory.category AS c ON p.category_id = c.id
    WHERE
        bp.basket_id = _basket_id;
END;
$function$
;


alter table "sales"."order_product" add column "substitute_brand" boolean not null default false;

alter table "sales"."order_product" add column "substitute_variant" boolean not null default false;

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION sales.insert_order_products(_order_id integer, _products jsonb[])
 RETURNS void
 LANGUAGE plpgsql
AS $function$
begin

    -- Aggregate JSONB array into a single JSONB array
    WITH aggregated_products AS (
        SELECT jsonb_agg(prod) AS products
        FROM unnest(_products) as prod
    )
    -- Insert products
    , inserted_products AS (
        SELECT 
            (jsonb_array_elements(products)->>'product_id')::INTEGER as product_id,
            (jsonb_array_elements(products)->>'quantity')::INTEGER as quantity,
            (jsonb_array_elements(products)->>'price')::NUMERIC as price,
            (jsonb_array_elements(products)->>'substitute_brand')::boolean as substitute_brand_,
            (jsonb_array_elements(products)->>'substitute_variant')::boolean as substitute_variant_
        FROM aggregated_products
    )
    INSERT INTO sales.order_product (product_id, order_id, quantity, price,customer_accepted_qty, eesupreneur_accepted_qty, substitute_brand,
    substitute_variant)
    SELECT product_id, _order_id, quantity, price,quantity, quantity,substitute_brand_,substitute_variant_ FROM inserted_products;
end; $function$
;


