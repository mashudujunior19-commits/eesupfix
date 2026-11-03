-- Admin sign-in: a signed-in profile with role 'Admin' can read every
-- application and the review audit log (the review function itself already
-- checks the role). Everyone else keeps seeing only their own rows.

CREATE OR REPLACE FUNCTION "public"."is_admin"() RETURNS boolean
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET search_path = public
    AS $$
    SELECT EXISTS (
        SELECT 1 FROM public.profile p
        WHERE p.user_id = auth.uid() AND p.role = 'Admin'
    );
$$;

REVOKE ALL ON FUNCTION "public"."is_admin"() FROM PUBLIC, "anon";
GRANT EXECUTE ON FUNCTION "public"."is_admin"() TO "authenticated", "service_role";

DROP POLICY IF EXISTS "partner_application_select_admin" ON "services"."partner_application";
CREATE POLICY "partner_application_select_admin" ON "services"."partner_application"
    FOR SELECT TO "authenticated" USING (public.is_admin());

GRANT SELECT ON "services"."partner_application_audit" TO "authenticated";
DROP POLICY IF EXISTS "partner_application_audit_select_admin" ON "services"."partner_application_audit";
CREATE POLICY "partner_application_audit_select_admin" ON "services"."partner_application_audit"
    FOR SELECT TO "authenticated" USING (public.is_admin());
