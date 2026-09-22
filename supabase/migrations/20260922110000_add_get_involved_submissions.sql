-- Replaces the two prior "Get Involved" attempts with one unified schema
-- covering all four submission paths (Registered/Unregistered x NPO/Business)
-- and their required supporting documents.
--
-- Superseded by this migration:
--   * services.get_involved_application / services.get_involved_application_type
--     (20260921130000_add_get_involved_application.sql) -- the earlier,
--     document-less "Submit an Application" shortcut, since removed from the
--     app in favour of the fuller Register-an-Organisation flow below.
--   * services.organisation and its four enum types
--     (20260921120000_add_organisation.sql) -- replaced because it modelled
--     a much richer flow (address, VAT/PBO numbers, up to 3 contact persons)
--     than what's actually collected now (organisation name, industry type,
--     supporting documents), and was reportedly erroring on submission.
--
-- These DROPs are safe to run even if the prior tables were never populated;
-- if they do hold data in a live environment, back it up before applying.

DROP TABLE IF EXISTS "services"."get_involved_application";
DROP TYPE IF EXISTS "services"."get_involved_application_type";

DROP TABLE IF EXISTS "services"."organisation";
DROP TYPE IF EXISTS "services"."organisation_type";
DROP TYPE IF EXISTS "services"."organisation_registration_status";
DROP TYPE IF EXISTS "services"."organisation_contact_method";
DROP TYPE IF EXISTS "services"."organisation_review_status";

-- submission_type / document_type / status are kept as plain "text" (with a
-- CHECK constraint enforcing the known value set) rather than native Postgres
-- ENUM types, matching the schema spec given for this feature. This is a
-- deliberate deviation from this repo's usual convention of native ENUM types
-- for this kind of field (see services.organisation_type etc. above) -- ENUMs
-- require a migration to add a new value, which seemed like the wrong
-- trade-off for a field the frontend may need to extend without a schema
-- change (e.g. adding a new submission or document type).

CREATE TABLE IF NOT EXISTS "services"."get_involved_submissions" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "submission_type" "text" NOT NULL,
    "organisation_name" "text" NOT NULL,
    "industry_type" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "status" "text" DEFAULT 'pending' NOT NULL,
    CONSTRAINT "get_involved_submissions_submission_type_check" CHECK (
        "submission_type" IN (
            'registered_npo',
            'unregistered_npo',
            'registered_business',
            'unregistered_business'
        )
    ),
    CONSTRAINT "get_involved_submissions_status_check" CHECK (
        "status" IN ('pending', 'approved', 'rejected')
    )
);

ALTER TABLE "services"."get_involved_submissions" OWNER TO "postgres";

ALTER TABLE ONLY "services"."get_involved_submissions"
    ADD CONSTRAINT "get_involved_submissions_pkey" PRIMARY KEY ("id");

-- Deviation from the literal spec ("FK to auth.users"): every other
-- user-owned table in this repo FKs to "public"."profile"("user_id") instead
-- of "auth"."users"("id") directly -- and profile.user_id is itself an FK to
-- auth.users(id), so referential integrity to a real auth user still holds.
-- Following house convention here for consistency with the rest of the schema.
ALTER TABLE ONLY "services"."get_involved_submissions"
    ADD CONSTRAINT "get_involved_submissions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profile"("user_id") ON DELETE CASCADE;

CREATE INDEX "get_involved_submissions_user_id_idx" ON "services"."get_involved_submissions" USING "btree" ("user_id");

CREATE TABLE IF NOT EXISTS "services"."submission_documents" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "submission_id" "uuid" NOT NULL,
    "document_type" "text" NOT NULL,
    "file_path" "text" NOT NULL,
    "uploaded_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "submission_documents_document_type_check" CHECK (
        "document_type" IN (
            'business_registration',
            'proof_of_bank',
            'proof_of_residence',
            'pbo_certificate',
            'constitution',
            'cipc_document',
            'vat_document'
        )
    )
);

ALTER TABLE "services"."submission_documents" OWNER TO "postgres";

ALTER TABLE ONLY "services"."submission_documents"
    ADD CONSTRAINT "submission_documents_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "services"."submission_documents"
    ADD CONSTRAINT "submission_documents_submission_id_fkey" FOREIGN KEY ("submission_id") REFERENCES "services"."get_involved_submissions"("id") ON DELETE CASCADE;

CREATE INDEX "submission_documents_submission_id_idx" ON "services"."submission_documents" USING "btree" ("submission_id");

ALTER TABLE "services"."get_involved_submissions" ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can insert their own submissions" ON "services"."get_involved_submissions" FOR INSERT TO "authenticated" WITH CHECK (("auth"."uid"() = "user_id"));
CREATE POLICY "Users can view their own submissions" ON "services"."get_involved_submissions" FOR SELECT TO "authenticated" USING (("auth"."uid"() = "user_id"));
CREATE POLICY "Users can update their own submissions" ON "services"."get_involved_submissions" FOR UPDATE TO "authenticated" USING (("auth"."uid"() = "user_id")) WITH CHECK (("auth"."uid"() = "user_id"));

ALTER TABLE "services"."submission_documents" ENABLE ROW LEVEL SECURITY;

-- Documents inherit access from their parent submission: a user may
-- insert/select a document row only if they own the submission it belongs to.
CREATE POLICY "Users can insert documents for their own submissions" ON "services"."submission_documents" FOR INSERT TO "authenticated" WITH CHECK (
    EXISTS (
        SELECT 1 FROM "services"."get_involved_submissions" s
        WHERE s."id" = "submission_documents"."submission_id"
        AND s."user_id" = "auth"."uid"()
    )
);
CREATE POLICY "Users can view documents for their own submissions" ON "services"."submission_documents" FOR SELECT TO "authenticated" USING (
    EXISTS (
        SELECT 1 FROM "services"."get_involved_submissions" s
        WHERE s."id" = "submission_documents"."submission_id"
        AND s."user_id" = "auth"."uid"()
    )
);

GRANT ALL ON TABLE "services"."get_involved_submissions" TO "authenticated";
GRANT ALL ON TABLE "services"."get_involved_submissions" TO "service_role";
GRANT ALL ON TABLE "services"."submission_documents" TO "authenticated";
GRANT ALL ON TABLE "services"."submission_documents" TO "service_role";

-- Storage: a private bucket for the uploaded documents. Objects are stored at
-- "<user_id>/<submission_id>/<document_type>_<timestamp>.<ext>", so RLS scopes
-- access by the first path segment matching the caller's own auth.uid().
-- The bucket is NOT public -- these are identity/financial verification
-- documents, so file_path is a private storage path (not a public URL); the
-- app must request a signed URL to actually view/download a document.

INSERT INTO "storage"."buckets" ("id", "name", "public")
VALUES ('get_involved_documents', 'get_involved_documents', false)
ON CONFLICT ("id") DO NOTHING;

CREATE POLICY "Users can upload their own get involved documents" ON "storage"."objects" FOR INSERT TO "authenticated" WITH CHECK (
    "bucket_id" = 'get_involved_documents'
    AND ("storage"."foldername"("name"))[1] = ("auth"."uid"())::"text"
);
CREATE POLICY "Users can view their own get involved documents" ON "storage"."objects" FOR SELECT TO "authenticated" USING (
    "bucket_id" = 'get_involved_documents'
    AND ("storage"."foldername"("name"))[1] = ("auth"."uid"())::"text"
);

-- Frontend insert pattern (see packages/data/lib/get_involved/repository/
-- get_involved_repository.dart for the actual Dart implementation):
--
--   1. Create the submission (user_id stamped from the session, not client-
--      supplied):
--        insert into services.get_involved_submissions
--          (user_id, submission_type, organisation_name, industry_type)
--        values ($1, $2, $3, $4)
--        returning *;
--
--   2. Upload each picked file to Storage bucket "get_involved_documents" at
--      path "<user_id>/<submission_id>/<document_type>_<timestamp>.<ext>".
--
--   3. Record each uploaded file:
--        insert into services.submission_documents
--          (submission_id, document_type, file_path)
--        values ($1, $2, $3)
--        returning *;
