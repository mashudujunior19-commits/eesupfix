-- Hampers, phase 1: safe access.
--
-- * inventory.hamper and inventory.hamper_product were readable AND writable by
--   every signed-in user (policies for role "authenticated"). Writes and reads
--   are now admin only (public.is_admin()); service_role bypasses RLS.
-- * Customers read hampers through public.get_hampers(), a SECURITY DEFINER
--   function that returns only what a customer should see (name, price, image,
--   expiry, what is inside, saving). It never returns cost, profit,
--   total_sales or the profit allocation, and it hides hampers whose
--   user_role list does not include the caller's profile role.
-- * Banner entries now carry the hamper id, so the app opens a hamper by id and
--   not by matching image URLs. Existing entries are filled in below.
-- * The finalise trigger no longer adds a second banner entry when a hamper that
--   is already on the banner is saved again.
--
-- Run on Dev only until checked: csbmvjcxpsmjjmzuwujz.

-- 1. Admin-only access to the hamper tables ----------------------------------

DROP POLICY IF EXISTS "service key or authenticated can insert on hampers" ON "inventory"."hamper";
DROP POLICY IF EXISTS "service key or authenticated can select on hampers" ON "inventory"."hamper";
DROP POLICY IF EXISTS "service key or authenticated can update on hampers" ON "inventory"."hamper";
DROP POLICY IF EXISTS "service key or authenticated can insert on hampers products" ON "inventory"."hamper_product";
DROP POLICY IF EXISTS "service key or authenticated can select on hampers products" ON "inventory"."hamper_product";
DROP POLICY IF EXISTS "service key or authenticated can update on hampers products" ON "inventory"."hamper_product";

DROP POLICY IF EXISTS "hamper_admin_all" ON "inventory"."hamper";
CREATE POLICY "hamper_admin_all" ON "inventory"."hamper"
    FOR ALL TO "authenticated"
    USING (public.is_admin()) WITH CHECK (public.is_admin());

DROP POLICY IF EXISTS "hamper_product_admin_all" ON "inventory"."hamper_product";
CREATE POLICY "hamper_product_admin_all" ON "inventory"."hamper_product"
    FOR ALL TO "authenticated"
    USING (public.is_admin()) WITH CHECK (public.is_admin());

-- 2. Who may see a hamper -----------------------------------------------------
-- A hamper is visible to a customer when it is final, has started, has not
-- expired, and its user_role list is empty or contains the customer's role.
-- Admins see every role's hampers.

CREATE OR REPLACE FUNCTION "inventory"."hamper_visible_to_caller"(
    _user_role "public"."user_role"[],
    _is_final boolean,
    _start_date date,
    _expiry_date date
) RETURNS boolean
    LANGUAGE "plpgsql" STABLE SECURITY DEFINER
    SET search_path = public
    AS $$
DECLARE
    _role public.user_role;
BEGIN
    IF COALESCE(_is_final, false) = false THEN
        RETURN false;
    END IF;
    IF _start_date IS NOT NULL AND _start_date > CURRENT_DATE THEN
        RETURN false;
    END IF;
    IF _expiry_date IS NOT NULL AND _expiry_date < CURRENT_DATE THEN
        RETURN false;
    END IF;

    SELECT p.role INTO _role FROM public.profile p WHERE p.user_id = auth.uid();

    IF _role = 'Admin' THEN
        RETURN true;
    END IF;
    IF _user_role IS NULL OR cardinality(_user_role) = 0 THEN
        RETURN true;
    END IF;
    RETURN _role IS NOT NULL AND _role = ANY (_user_role);
END;
$$;

REVOKE ALL ON FUNCTION "inventory"."hamper_visible_to_caller"("public"."user_role"[], boolean, date, date) FROM PUBLIC, "anon";
GRANT EXECUTE ON FUNCTION "inventory"."hamper_visible_to_caller"("public"."user_role"[], boolean, date, date) TO "authenticated", "service_role";

-- 3. Customer-safe hampers ----------------------------------------------------
-- One call returns every visible hamper (or just one when _hamper_id is given)
-- with what is inside. "value" is the price the customer pays: the price on the
-- hamper's product row (what the cart charges), falling back to the hamper value.
-- "worth" is the sum of the items' own prices; "saving" is worth minus price.

CREATE OR REPLACE FUNCTION "public"."get_hampers"(_hamper_id uuid DEFAULT NULL)
    RETURNS jsonb
    LANGUAGE "plpgsql" STABLE SECURITY DEFINER
    SET search_path = public
    AS $$
DECLARE
    _result jsonb;
BEGIN
    IF auth.uid() IS NULL THEN
        RETURN '[]'::jsonb;
    END IF;

    SELECT COALESCE(jsonb_agg(row_json ORDER BY created_at DESC), '[]'::jsonb)
    INTO _result
    FROM (
        SELECT
            h.created_at,
            jsonb_build_object(
                'id', h.id,
                'code', h.code,
                'type', COALESCE(h.type, ''),
                'value', COALESCE(hp.sale_price, h.value, 0),
                'expiry_date', h.expiry_date,
                'img_url', h.img_url,
                'hamper_gif_url1', h.hamper_gif_url1,
                'hamper_gif_url2', h.hamper_gif_url2,
                'product_id', hp.id,
                'product_name', hp.name,
                'product_image_url', hp.image_url,
                'worth', COALESCE(items.worth, 0),
                'saving', GREATEST(COALESCE(items.worth, 0) - COALESCE(hp.sale_price, h.value, 0), 0),
                'item_count', COALESCE(items.item_count, 0),
                'available', (
                    hp.id IS NOT NULL
                    AND hp.is_active AND hp.sellable
                    AND COALESCE(items.item_count, 0) > 0
                    AND COALESCE(items.all_active, false)
                ),
                'items', COALESCE(items.list, '[]'::jsonb)
            ) AS row_json
        FROM inventory.hamper h
        LEFT JOIN LATERAL (
            SELECT p.id, p.name, p.image_url, p.sale_price, p.is_active, p.sellable
            FROM inventory.product p
            WHERE p.hamper_id = h.id
            ORDER BY p.id
            LIMIT 1
        ) hp ON true
        LEFT JOIN LATERAL (
            SELECT
                SUM(ip.sale_price * i.quantity) AS worth,
                COUNT(*) AS item_count,
                BOOL_AND(ip.is_active) AS all_active,
                jsonb_agg(
                    jsonb_build_object(
                        'product_id', ip.id,
                        'name', ip.name,
                        'image_url', ip.image_url,
                        'quantity', i.quantity,
                        'is_free', COALESCE(i.is_free, false),
                        'price', ip.sale_price,
                        'is_active', ip.is_active
                    )
                    ORDER BY COALESCE(i.is_free, false) DESC, lower(ip.name)
                ) AS list
            FROM inventory.hamper_product i
            JOIN inventory.product ip ON ip.id = i.product_id
            WHERE i.hamper_id = h.id
        ) items ON true
        WHERE (_hamper_id IS NULL OR h.id = _hamper_id)
          AND inventory.hamper_visible_to_caller(h.user_role, h.is_final, h.start_date, h.expiry_date)
    ) t;

    RETURN _result;
END;
$$;

REVOKE ALL ON FUNCTION "public"."get_hampers"(uuid) FROM PUBLIC, "anon";
GRANT EXECUTE ON FUNCTION "public"."get_hampers"(uuid) TO "authenticated", "service_role";

-- 4. Banner: carry the hamper id ----------------------------------------------

CREATE OR REPLACE FUNCTION "public"."append_banner_urls"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
  base_image_url TEXT;
  gif1_url TEXT;
  gif2_url TEXT;
  last_order_number INT;
BEGIN
  SELECT img_url, hamper_gif_url1, hamper_gif_url2
  INTO base_image_url, gif1_url, gif2_url
  FROM inventory.hamper
  WHERE id = NEW.id AND is_final = true
  LIMIT 1;

  IF base_image_url IS NULL THEN
    RAISE EXCEPTION 'No final hamper found for ID %', NEW.id;
  END IF;

  -- Already on the banner (saved again): do not add a second entry.
  IF EXISTS (
    SELECT 1 FROM engagements.banner b, unnest(b.content) AS elem
    WHERE b.id = 3 AND elem->>'hamper_id' = NEW.id::text
  ) THEN
    RETURN NEW;
  END IF;

  SELECT COALESCE(MAX((elem->>'order_number')::INT), 0)
  INTO last_order_number
  FROM engagements.banner,
       unnest(content) AS elem
  WHERE id = 3;

  UPDATE engagements.banner
  SET content = COALESCE(content, '{}'::jsonb[]) ||
                ARRAY[
                  jsonb_build_object(
                    'type', 'image',
                    'order_number', last_order_number + 1,
                    'hamper_id', NEW.id,
                    'base_image', base_image_url,
                    'gif1', gif1_url,
                    'gif2', gif2_url
                  )
                ]
  WHERE id = 3;

  RETURN NEW;
END;
$$;

-- Fill hamper_id into banner entries that only know the image URL.
UPDATE engagements.banner b
SET content = ARRAY(
    SELECT CASE
             WHEN elem ? 'hamper_id' THEN elem
             WHEN m.id IS NOT NULL THEN elem || jsonb_build_object('hamper_id', m.id)
             ELSE elem
           END
    FROM unnest(b.content) WITH ORDINALITY AS u(elem, ord)
    LEFT JOIN LATERAL (
        SELECT h.id
        FROM inventory.hamper h
        WHERE h.is_final = true
          AND trim(lower(replace(split_part(h.img_url, '?', 1), '//', '/'))) =
              trim(lower(replace(split_part(u.elem->>'base_image', '?', 1), '//', '/')))
        ORDER BY h.created_at
        LIMIT 1
    ) m ON true
    ORDER BY u.ord
);

-- Banner details for the Home carousels. Hamper entries are matched by id (the
-- image URL is only a fallback for entries that could not be filled in), hidden
-- when expired or not meant for the caller's role, and carry no cost or profit.
-- Plain banner images (no hamper) are kept as before.

CREATE OR REPLACE FUNCTION "engagements"."get_hamper_banner_details"("banner_id" bigint) RETURNS "json"
    LANGUAGE "plpgsql" STABLE SECURITY DEFINER
    SET search_path = public
    AS $$
DECLARE
    result JSON;
BEGIN
    SELECT COALESCE(json_agg(entry ORDER BY order_number), '[]'::json)
    INTO result
    FROM (
        SELECT
            (content_item->>'order_number')::int AS order_number,
            jsonb_build_object(
                'hamper_id', h.id,
                'base_image', content_item->>'base_image',
                'order_number', (content_item->>'order_number')::int,
                'gif1', content_item->>'gif1',
                'gif2', content_item->>'gif2',
                'code', h.code,
                'type', h.type,
                'value', COALESCE(hp.sale_price, h.value),
                'saving', GREATEST(COALESCE(items.worth, 0) - COALESCE(hp.sale_price, h.value, 0), 0),
                'expiry_date', h.expiry_date
            ) AS entry
        FROM engagements.banner b
        CROSS JOIN LATERAL jsonb_array_elements(array_to_json(b.content)::jsonb) AS content_item
        LEFT JOIN inventory.hamper h
          ON (
               (content_item ? 'hamper_id' AND h.id = (content_item->>'hamper_id')::uuid)
               OR (
                    NOT (content_item ? 'hamper_id')
                    AND h.is_final = TRUE
                    AND trim(lower(replace(split_part(h.img_url, '?', 1), '//', '/'))) =
                        trim(lower(replace(split_part(content_item->>'base_image', '?', 1), '//', '/')))
                  )
             )
        LEFT JOIN LATERAL (
            SELECT p.sale_price
            FROM inventory.product p
            WHERE p.hamper_id = h.id
            ORDER BY p.id
            LIMIT 1
        ) hp ON true
        LEFT JOIN LATERAL (
            SELECT SUM(ip.sale_price * i.quantity) AS worth
            FROM inventory.hamper_product i
            JOIN inventory.product ip ON ip.id = i.product_id
            WHERE i.hamper_id = h.id
        ) items ON true
        WHERE b.id = banner_id
          AND (
                h.id IS NULL
                OR inventory.hamper_visible_to_caller(h.user_role, h.is_final, h.start_date, h.expiry_date)
              )
    ) t;

    RETURN result;
END;
$$;

ALTER FUNCTION "engagements"."get_hamper_banner_details"("banner_id" bigint) OWNER TO "postgres";
