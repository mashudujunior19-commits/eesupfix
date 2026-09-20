-- Adds the "Register an Organisation" feature: organisations can be created by a
-- verified Individual profile, either as a Public Benefit (NPO) or a Business
-- (For-Profit), and either as a Registered or Unregistered entity.
--
-- This is intentionally a brand-new table rather than an extension of the
-- existing public.profile.corp_* columns, because:
--   * an organisation needs up to 3 contact persons (profile is 1 row per user)
--   * an organisation needs its own address, industry, PBO/social development
--     fields that don't exist on profile today
--   * existing Corporate accounts (profile.corp_* populated at sign-up) are left
--     untouched for backward compatibility -- see the accompanying migration notes.

CREATE TYPE "services"."organisation_type" AS ENUM (
    'Public Benefit',
    'Business'
);

CREATE TYPE "services"."organisation_registration_status" AS ENUM (
    'Registered',
    'Unregistered'
);

CREATE TYPE "services"."organisation_contact_method" AS ENUM (
    'Email',
    'Phone Number',
    'Cell Number'
);

CREATE TYPE "services"."organisation_review_status" AS ENUM (
    'Pending',
    'Approved',
    'Rejected'
);

CREATE TABLE IF NOT EXISTS "services"."organisation" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "owner_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "reviewed_at" timestamp with time zone,
    "organisation_type" "services"."organisation_type" NOT NULL,
    "registration_status" "services"."organisation_registration_status" NOT NULL,
    "review_status" "services"."organisation_review_status" DEFAULT 'Pending'::"services"."organisation_review_status" NOT NULL,
    "name" "text" NOT NULL,
    "surname" "text",
    "address_id" integer,
    "contact_person_1" "text",
    "contact_person_2" "text",
    "contact_person_3" "text",
    "contact_method" "services"."organisation_contact_method",
    "contact_value" "text",
    "company_registration_number" "text",
    "vat_number" "text",
    "industry_type" "text" NOT NULL,
    "pbo_number" "text",
    "social_development_number" "text",
    CONSTRAINT "organisation_registered_fields_check" CHECK (
        "registration_status" <> 'Registered'::"services"."organisation_registration_status"
        OR (
            "surname" IS NOT NULL
            AND "contact_person_1" IS NOT NULL
            AND "company_registration_number" IS NOT NULL
        )
    ),
    CONSTRAINT "organisation_unregistered_fields_check" CHECK (
        "registration_status" <> 'Unregistered'::"services"."organisation_registration_status"
        OR (
            "contact_person_1" IS NOT NULL
            AND "contact_method" IS NOT NULL
            AND "contact_value" IS NOT NULL
        )
    ),
    CONSTRAINT "organisation_npo_only_fields_check" CHECK (
        "organisation_type" = 'Public Benefit'::"services"."organisation_type"
        OR ("pbo_number" IS NULL AND "social_development_number" IS NULL)
    )
);

ALTER TABLE "services"."organisation" OWNER TO "postgres";

ALTER TABLE ONLY "services"."organisation"
    ADD CONSTRAINT "organisation_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "services"."organisation"
    ADD CONSTRAINT "organisation_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "public"."profile"("user_id") ON DELETE CASCADE;

ALTER TABLE ONLY "services"."organisation"
    ADD CONSTRAINT "organisation_address_id_fkey" FOREIGN KEY ("address_id") REFERENCES "geolocations"."address"("id") ON DELETE SET NULL;

CREATE INDEX "organisation_owner_id_idx" ON "services"."organisation" USING "btree" ("owner_id");

ALTER TABLE "services"."organisation" ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Enable access for authenticated users only" ON "services"."organisation" TO "authenticated" USING (true) WITH CHECK (true);

GRANT ALL ON TABLE "services"."organisation" TO "anon";
GRANT ALL ON TABLE "services"."organisation" TO "authenticated";
GRANT ALL ON TABLE "services"."organisation" TO "service_role";
