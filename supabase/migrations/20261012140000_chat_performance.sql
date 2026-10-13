-- Chat send latency.
--
-- Root causes found:
--  1. communities.message has AFTER INSERT triggers that call
--     engagements.send_one_signal_push_notification, which used the
--     synchronous `http` extension (http_post). The INSERT therefore waited for
--     the push provider's HTTP round trip before returning to the sender.
--  2. get_eesupool_messages (rewritten in the moderation migration) joined
--     message_seen for EVERY message in the pool before applying LIMIT, and
--     the tables had no indexes on the columns it filters/joins on. The app
--     re-runs it for every realtime event.
--
-- This migration fixes (1) by sending pushes asynchronously through pg_net
-- when it is available, and adds the missing indexes for (2).

-- Indexes -----------------------------------------------------------------
CREATE INDEX IF NOT EXISTS message_eesupool_created_idx
    ON communities.message (eesupool_id, created_at DESC);
CREATE INDEX IF NOT EXISTS message_seen_message_idx
    ON communities.message_seen (message_id);
CREATE INDEX IF NOT EXISTS message_reaction_message_idx
    ON communities.message_reaction (message_id);
CREATE INDEX IF NOT EXISTS eesupool_member_user_pool_idx
    ON communities.eesupool_member (user_id, eesupool_id);

-- Asynchronous push --------------------------------------------------------
-- pg_net queues the request and returns immediately. If the extension cannot
-- be enabled on this project, the old synchronous behaviour is kept so pushes
-- keep working (enable pg_net in Dashboard > Database > Extensions).
DO $$
BEGIN
    CREATE EXTENSION IF NOT EXISTS pg_net WITH SCHEMA extensions;
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'pg_net could not be enabled (%); pushes stay synchronous', SQLERRM;
END $$;

CREATE OR REPLACE FUNCTION engagements.send_one_signal_push_notification(
    title text, body text, campaign text, image_url text, data jsonb, recipients uuid[]
) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  _payload TEXT;
  _key TEXT;
  _url TEXT;
  _base_api_url text;
BEGIN
  SELECT key INTO _key FROM system_configs.api_key WHERE id = 'supabase' AND is_active = TRUE;
  SELECT text_value INTO _base_api_url FROM system_configs.remote_config WHERE id = 'eesup_api_base_url';

  _payload := json_build_object(
    'title', title,
    'body', body,
    'image_url', image_url,
    'campaign', campaign,
    'recipients', recipients,
    'data', data
  )::text;

  _url := concat(_base_api_url, '/notifications/send?', 'api_key=', _key);

  IF EXISTS (SELECT 1 FROM pg_extension WHERE extname = 'pg_net') THEN
    -- Non-blocking: queued and sent by the pg_net background worker.
    EXECUTE 'SELECT net.http_post(url := $1, body := $2::jsonb, headers := $3::jsonb)'
      USING _url, _payload, '{"Content-Type": "application/json"}';
  ELSE
    PERFORM http_post(_url, _payload, 'application/json');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    -- A failed push must never block or roll back the chat message itself.
    RAISE WARNING 'push notification failed: %', SQLERRM;
END;
$$;
