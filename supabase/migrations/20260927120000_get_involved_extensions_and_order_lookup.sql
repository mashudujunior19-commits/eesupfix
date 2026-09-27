-- Extends services.get_involved_submissions / submission_contacts for the
-- Get Involved / organisation registration changes:
--   * province (Registered NPO only, collected alongside address)
--   * is_kasilift / about_us -- KasiLift Organisation opt-in. Documents are
--     only required once is_kasilift is true (enforced client-side, same as
--     the existing required-document set); about_us is required whenever
--     is_kasilift is true, enforced here with a CHECK.
--   * submission_contacts.name / role -- each contact person's name and
--     their role in the order workflow (Order Loader / Order Approver).
--
-- social_development_number is already nullable (no migration needed to
-- make it optional -- that was purely a client-side validation relaxation).

ALTER TABLE "services"."get_involved_submissions"
    ADD COLUMN IF NOT EXISTS "province" "text",
    ADD COLUMN IF NOT EXISTS "is_kasilift" boolean DEFAULT false NOT NULL,
    ADD COLUMN IF NOT EXISTS "about_us" "text";

ALTER TABLE "services"."get_involved_submissions"
    ADD CONSTRAINT "get_involved_submissions_kasilift_about_us_check" CHECK (
        "is_kasilift" = false OR (
            "about_us" IS NOT NULL AND length(btrim("about_us")) > 0
        )
    );

ALTER TABLE "services"."submission_contacts"
    ADD COLUMN IF NOT EXISTS "name" "text",
    ADD COLUMN IF NOT EXISTS "role" "text";

ALTER TABLE "services"."submission_contacts"
    ADD CONSTRAINT "submission_contacts_role_check" CHECK (
        "role" IS NULL OR "role" IN ('order_loader', 'order_approver')
    );

-- Lets an individual buyer's order-tracking screen show the delivery date
-- and progress of the KasiPool order it belongs to (Order.eesupool_order_id)
-- without needing the pool's id, mirroring the aggregation already done by
-- communities.get_eesupool_orders / get_open_eesupool_order.
CREATE OR REPLACE FUNCTION "communities"."get_eesupool_order_by_id"("order_id" integer) RETURNS TABLE("id" integer, "eesupool_id" integer, "created_at" timestamp with time zone, "schedule_for" timestamp with time zone, "delivered_at" timestamp with time zone, "closes_at" timestamp with time zone, "admin_fee" numeric, "packer_fee" numeric, "receiver_fee" numeric, "collection_fee" numeric, "address_id" integer, "secret_pin" integer, "receivers" "uuid"[], "status" "public"."order_type", "minimun_order_value" numeric, "warehouse_order_id" integer, "consolidated" boolean, "received_at" "date", "order_extension_count" integer, "eesupool_name" "text", "address" "jsonb", "orders_count" integer, "current_amount" numeric)
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

-- Wording change: the "Available Services" listing's "Service/Product
-- Listing" partnership option is renamed to "Become a Vendor" (matching the
-- "Become a Partner" -> "Become a Vendor" rename elsewhere in the app). This
-- is a content update, not a schema change -- services.partner rows are
-- managed data, not seeded by a migration, so this only takes effect for a
-- row with that exact existing title.
UPDATE "services"."partner"
SET "title" = 'Become a Vendor'
WHERE "title" = 'Service/Product Listing';
