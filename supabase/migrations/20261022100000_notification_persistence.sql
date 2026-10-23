-- Notifications persist after they are viewed (they are only flagged seen via
-- seen_at) and are purged only once they are older than 30 days.

-- 1. Revoking or deleting an invite/request used to DELETE the matching
--    notifications. Keep them instead: flag them seen and demote them to the
--    plain 'eesupool' type so the Accept/Decline actions are no longer offered.
CREATE OR REPLACE FUNCTION communities.on_invite_revoked_delete_notification() RETURNS trigger
    LANGUAGE plpgsql
    SECURITY DEFINER
    SET search_path = public, communities, engagements
    AS $$
BEGIN
    UPDATE engagements.notification
    SET type = 'eesupool',
        seen_at = COALESCE(seen_at, now())
    WHERE data ->> 'user_id' = cast(old.user_id AS text)
      AND data ->> 'eesupool_id' = cast(old.eesupool_id AS text)
      AND type IN ('eesupool_invite', 'eesupool_request');
    RETURN OLD;
END;
$$;

-- 2. Once an invite/request is answered its notification stays in the list but
--    can no longer be acted on.
CREATE OR REPLACE FUNCTION communities.resolve_request_notifications() RETURNS trigger
    LANGUAGE plpgsql
    SECURITY DEFINER
    SET search_path = public, communities, engagements
    AS $$
BEGIN
    IF NEW.status IN ('Accepted', 'Declined')
       AND OLD.status IS DISTINCT FROM NEW.status THEN
        UPDATE engagements.notification
        SET type = 'eesupool',
            seen_at = COALESCE(seen_at, now())
        WHERE data ->> 'user_id' = cast(NEW.user_id AS text)
          AND data ->> 'eesupool_id' = cast(NEW.eesupool_id AS text)
          AND type IN ('eesupool_invite', 'eesupool_request');
    END IF;
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS resolve_request_notifications_trigger ON communities.eesupool_request;
CREATE TRIGGER resolve_request_notifications_trigger
    AFTER UPDATE OF status ON communities.eesupool_request
    FOR EACH ROW EXECUTE FUNCTION communities.resolve_request_notifications();

-- 3. 30-day expiry.
CREATE OR REPLACE FUNCTION engagements.purge_expired_notifications() RETURNS integer
    LANGUAGE plpgsql
    SECURITY DEFINER
    SET search_path = public, engagements
    AS $$
DECLARE
    removed integer;
BEGIN
    DELETE FROM engagements.notification
    WHERE created_at < now() - interval '30 days';
    GET DIAGNOSTICS removed = ROW_COUNT;
    RETURN removed;
END;
$$;

REVOKE ALL ON FUNCTION engagements.purge_expired_notifications() FROM PUBLIC, anon, authenticated;
GRANT EXECUTE ON FUNCTION engagements.purge_expired_notifications() TO service_role;

-- Run it daily when pg_cron is available (Supabase: Database > Extensions).
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM pg_extension WHERE extname = 'pg_cron') THEN
        PERFORM cron.unschedule(jobid) FROM cron.job WHERE jobname = 'purge-expired-notifications';
        PERFORM cron.schedule('purge-expired-notifications', '15 2 * * *',
                              'SELECT engagements.purge_expired_notifications()');
    ELSE
        RAISE NOTICE 'pg_cron is not enabled: schedule engagements.purge_expired_notifications() manually.';
    END IF;
END $$;
