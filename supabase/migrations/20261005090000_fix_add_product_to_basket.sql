-- public.add_product_to_basket(uuid, integer) -- the overload the app calls
-- -- had been overwritten (on Dev at least) with the body of the
-- 3-argument version, so it referenced a non-existent _product_quantity
-- parameter. Every add of a new item failed with 42703 ("column
-- _product_quantity does not exist"), which the app shows as "A database
-- error occurred", and nothing was saved to any basket.
--
-- Restores the intended behaviour (see 20260205173025_remote_schema.sql):
-- add one of the product, or bump its quantity if it's already there.
-- Written as a single upsert on the (basket_id, product_id) primary key so
-- two quick taps can't race into a duplicate-key error.

CREATE OR REPLACE FUNCTION "public"."add_product_to_basket"("_basket_id" "uuid", "_product_id" integer) RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    INSERT INTO public.basket_product (basket_id, product_id, quantity)
    VALUES (_basket_id, _product_id, 1)
    ON CONFLICT (basket_id, product_id)
    DO UPDATE SET quantity = public.basket_product.quantity + 1;
END;
$$;

ALTER FUNCTION "public"."add_product_to_basket"("_basket_id" "uuid", "_product_id" integer) OWNER TO "postgres";
