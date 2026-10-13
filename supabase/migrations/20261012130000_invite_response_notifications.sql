-- Invites: remember who sent each invite, notify them when it is accepted or
-- declined, and publish the table for realtime so the sender's list updates
-- without a refresh.

-- 1. Who sent the invite. auth.uid() is the inviter at insert time. Rows created
--    before this migration have NULL and fall back to notifying pool admins.
ALTER TABLE communities.eesupool_request
    ADD COLUMN IF NOT EXISTS invited_by uuid DEFAULT auth.uid();

-- 2. Notify the sender when the invitee responds.
CREATE OR REPLACE FUNCTION communities.notify_invite_response() RETURNS trigger
    LANGUAGE plpgsql
    SECURITY DEFINER
    SET search_path = public, communities, engagements
    AS $$
DECLARE
    pool_name text;
    invitee_name text;
    verb text;
    recipient uuid;
BEGIN
    IF NEW.type <> 'Invite'
       OR OLD.status IS NOT DISTINCT FROM NEW.status
       OR NEW.status NOT IN ('Accepted', 'Declined') THEN
        RETURN NEW;
    END IF;

    SELECT name INTO pool_name FROM communities.eesupool WHERE id = NEW.eesupool_id;
    SELECT COALESCE(NULLIF(btrim(CONCAT(p.first_name, ' ', p.last_name)), ''), p.corp_name, 'Someone')
      INTO invitee_name
    FROM public.profile p WHERE p.user_id = NEW.user_id;

    verb := CASE WHEN NEW.status = 'Accepted' THEN 'accepted' ELSE 'declined' END;

    -- The inviter, or every pool admin when the inviter is unknown (old rows).
    FOR recipient IN
        SELECT NEW.invited_by WHERE NEW.invited_by IS NOT NULL
        UNION
        SELECT m.user_id FROM communities.eesupool_member m
        WHERE NEW.invited_by IS NULL AND m.eesupool_id = NEW.eesupool_id AND m.role = 'Admin'
    LOOP
        INSERT INTO engagements.notification(user_id, title, body, data, type)
        VALUES (
            recipient,
            CONCAT(invitee_name, ' ', verb, ' your invite'),
            CONCAT(invitee_name, ' ', verb, ' your invite to join ', COALESCE(pool_name, 'the pool'), '.'),
            -- invitee_id (not user_id) so the invite-revoked cleanup trigger,
            -- which matches on data->>'user_id', leaves this notification alone.
            jsonb_build_object('eesupool_id', NEW.eesupool_id, 'invitee_id', NEW.user_id, 'status', NEW.status),
            'eesupool'
        );
    END LOOP;

    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS notify_invite_response_trigger ON communities.eesupool_request;
CREATE TRIGGER notify_invite_response_trigger
    AFTER UPDATE OF status ON communities.eesupool_request
    FOR EACH ROW EXECUTE FUNCTION communities.notify_invite_response();

-- 3. Realtime: invite lists and notifications update live.
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_publication_tables
                   WHERE pubname = 'supabase_realtime' AND schemaname = 'communities' AND tablename = 'eesupool_request') THEN
        ALTER PUBLICATION supabase_realtime ADD TABLE communities.eesupool_request;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_publication_tables
                   WHERE pubname = 'supabase_realtime' AND schemaname = 'engagements' AND tablename = 'notification') THEN
        ALTER PUBLICATION supabase_realtime ADD TABLE engagements.notification;
    END IF;
END $$;
