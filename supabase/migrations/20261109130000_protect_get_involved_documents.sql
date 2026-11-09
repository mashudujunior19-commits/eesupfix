-- The applicant documents in the private `get_involved_documents` bucket (proof
-- of residence, CIPC, PBO, bank letters ...) could be listed and signed by anyone,
-- even signed-out visitors, because a blanket policy allowed reading EVERY object
-- in EVERY bucket:
--     "Allow public access"  FOR SELECT TO public  USING (true)
-- The same policy is narrowed to exclude only that bucket, so nothing else
-- changes (the public buckets keep working exactly as before).
--
-- Who can still read the documents:
--   * the applicant, their own folder  ("Users can view their own get involved documents")
--   * admins, all of them              ("Admins can view all get involved documents")

DROP POLICY IF EXISTS "Allow public access" ON "storage"."objects";
CREATE POLICY "Allow public access" ON "storage"."objects"
    FOR SELECT TO "public"
    USING (bucket_id <> 'get_involved_documents');
