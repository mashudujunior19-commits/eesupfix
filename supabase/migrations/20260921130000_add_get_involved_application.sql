-- Adds the "Get Involved" application feature: any authenticated user can
-- submit a lightweight expression of interest as either a Registered or an
-- Unregistered business.
--
-- This is intentionally a separate, much simpler table from
-- "services"."organisation" (the full "Register an Organisation" wizard --
-- address, VAT/PBO numbers, up to 3 contact persons). This one only ever
-- collects a business name (registered) or a first/last name (unregistered)
-- plus a free-text business type, so it is modelled as its own table rather
-- than reusing/overloading the organisation schema.
--
-- RLS deliberately scopes rows to their owner via auth.uid() (rather than the
-- blanket "true" policy used elsewhere in this project), since these are
-- personal applications that should not be readable/writable by other users.

CREATE TYPE "services"."get_involved_application_type" AS ENUM (
    'registered',
    'unregistered'
);

CREATE TABLE IF NOT EXISTS "services"."get_involved_application" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "application_type" "services"."get_involved_application_type" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "business_name" "text",
    "business_type" "text" NOT NULL,
    "first_name" "text",
    "last_name" "text",
    CONSTRAINT "get_involved_application_registered_fields_check" CHECK (
        "application_type" <> 'registered'::"services"."get_involved_application_type"
        OR (
            "business_name" IS NOT NULL
            AND "first_name" IS NULL
            AND "last_name" IS NULL
        )
    ),
    CONSTRAINT "get_involved_application_unregistered_fields_check" CHECK (
        "application_type" <> 'unregistered'::"services"."get_involved_application_type"
        OR (
            "first_name" IS NOT NULL
            AND "last_name" IS NOT NULL
            AND "business_name" IS NULL
        )
    )
);

ALTER TABLE "services"."get_involved_application" OWNER TO "postgres";

ALTER TABLE ONLY "services"."get_involved_application"
    ADD CONSTRAINT "get_involved_application_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "services"."get_involved_application"
    ADD CONSTRAINT "get_involved_application_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profile"("user_id") ON DELETE CASCADE;

CREATE INDEX "get_involved_application_user_id_idx" ON "services"."get_involved_application" USING "btree" ("user_id");

ALTER TABLE "services"."get_involved_application" ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can insert their own get involved applications" ON "services"."get_involved_application" FOR INSERT TO "authenticated" WITH CHECK (("auth"."uid"() = "user_id"));

CREATE POLICY "Users can view their own get involved applications" ON "services"."get_involved_application" FOR SELECT TO "authenticated" USING (("auth"."uid"() = "user_id"));

GRANT ALL ON TABLE "services"."get_involved_application" TO "authenticated";
GRANT ALL ON TABLE "services"."get_involved_application" TO "service_role";
