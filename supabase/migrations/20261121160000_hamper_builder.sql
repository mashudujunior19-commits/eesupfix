-- Hampers phase 3: build-your-own hamper.
--
-- An admin chooses which products customers may put in their own hamper
-- (`inventory.hamper_builder_item`) and the most of each one allowed. Customers
-- read that list through `public.get_hamper_builder()`, which returns only
-- products that are active, sellable and meant for the caller's role, with
-- today's price. Customers cannot read or change the table itself.
--
-- The app adds the chosen items to the cart as ordinary product lines, so the
-- price is each product's own sale price and no hamper discount is applied.
-- (A discount needs checkout to price the lines itself, which is a separate
-- change: `sales.create_order` currently takes the total from the app.)
--
-- Needs public.is_admin() (migration 20261103150000).
-- Run on Dev only until checked: csbmvjcxpsmjjmzuwujz.

CREATE TABLE IF NOT EXISTS "inventory"."hamper_builder_item" (
    "product_id" integer PRIMARY KEY
        REFERENCES "inventory"."product" ("id") ON DELETE CASCADE,
    "max_quantity" integer NOT NULL DEFAULT 5 CHECK ("max_quantity" BETWEEN 1 AND 50),
    "sort_order" integer NOT NULL DEFAULT 0,
    "is_active" boolean NOT NULL DEFAULT true,
    "created_at" timestamp with time zone NOT NULL DEFAULT now()
);

ALTER TABLE "inventory"."hamper_builder_item" OWNER TO "postgres";
ALTER TABLE "inventory"."hamper_builder_item" ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "hamper_builder_item_admin_all" ON "inventory"."hamper_builder_item";
CREATE POLICY "hamper_builder_item_admin_all" ON "inventory"."hamper_builder_item"
    FOR ALL TO "authenticated"
    USING (public.is_admin()) WITH CHECK (public.is_admin());

REVOKE ALL ON TABLE "inventory"."hamper_builder_item" FROM "anon";
GRANT ALL ON TABLE "inventory"."hamper_builder_item" TO "authenticated", "service_role";

-- What a customer may choose from.
CREATE OR REPLACE FUNCTION "public"."get_hamper_builder"()
    RETURNS jsonb
    LANGUAGE "plpgsql" STABLE SECURITY DEFINER
    SET search_path = public
    AS $$
DECLARE
    _role public.user_role;
    _result jsonb;
BEGIN
    IF auth.uid() IS NULL THEN
        RETURN '[]'::jsonb;
    END IF;

    SELECT p.role INTO _role FROM public.profile p WHERE p.user_id = auth.uid();

    SELECT COALESCE(jsonb_agg(
        jsonb_build_object(
            'product_id', p.id,
            'name', p.name,
            'brand', p.brand,
            'size', p.size,
            'image_url', p.image_url,
            'price', p.sale_price,
            'max_quantity', b.max_quantity
        ) ORDER BY b.sort_order, p.name
    ), '[]'::jsonb)
    INTO _result
    FROM inventory.hamper_builder_item b
    JOIN inventory.product p ON p.id = b.product_id
    WHERE b.is_active
      AND p.is_active
      AND p.sellable
      AND p.hamper_id IS NULL
      AND (
          _role = 'Admin'
          OR p.roles IS NULL
          OR cardinality(p.roles) = 0
          OR (_role IS NOT NULL AND _role = ANY (p.roles))
      );

    RETURN _result;
END;
$$;

REVOKE ALL ON FUNCTION "public"."get_hamper_builder"() FROM PUBLIC, "anon";
GRANT EXECUTE ON FUNCTION "public"."get_hamper_builder"() TO "authenticated", "service_role";
