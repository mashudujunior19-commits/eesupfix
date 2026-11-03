-- Notifications were readable, editable and deletable by every signed-in user
-- (policy USING true), which exposed other people's verdicts and decline
-- reasons. Reading, marking seen and deleting are now limited to your own rows.
--
-- INSERT stays open for now: invites, role assignments, order updates and ticket
-- resolutions create notifications for OTHER users from functions that run with
-- the caller's rights. Once those four are SECURITY DEFINER, insert can be
-- restricted too (so nobody can post a fake notification to someone else).

DROP POLICY IF EXISTS "Enable access for authenticated users only" ON "engagements"."notification";
DROP POLICY IF EXISTS "notification_select_own" ON "engagements"."notification";
DROP POLICY IF EXISTS "notification_update_own" ON "engagements"."notification";
DROP POLICY IF EXISTS "notification_delete_own" ON "engagements"."notification";
DROP POLICY IF EXISTS "notification_insert_any" ON "engagements"."notification";

CREATE POLICY "notification_select_own" ON "engagements"."notification"
    FOR SELECT TO "authenticated" USING (user_id = auth.uid());
CREATE POLICY "notification_update_own" ON "engagements"."notification"
    FOR UPDATE TO "authenticated" USING (user_id = auth.uid()) WITH CHECK (user_id = auth.uid());
CREATE POLICY "notification_delete_own" ON "engagements"."notification"
    FOR DELETE TO "authenticated" USING (user_id = auth.uid());
CREATE POLICY "notification_insert_any" ON "engagements"."notification"
    FOR INSERT TO "authenticated" WITH CHECK (true);

-- Signed-out users have no business with notifications at all.
REVOKE ALL ON "engagements"."notification" FROM "anon";
