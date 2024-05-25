
SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

CREATE SCHEMA IF NOT EXISTS "communities";

ALTER SCHEMA "communities" OWNER TO "postgres";

CREATE EXTENSION IF NOT EXISTS "pg_cron" WITH SCHEMA "extensions";

CREATE SCHEMA IF NOT EXISTS "engagements";

ALTER SCHEMA "engagements" OWNER TO "postgres";

CREATE SCHEMA IF NOT EXISTS "finances";

ALTER SCHEMA "finances" OWNER TO "postgres";

CREATE SCHEMA IF NOT EXISTS "geolocations";

ALTER SCHEMA "geolocations" OWNER TO "postgres";

CREATE SCHEMA IF NOT EXISTS "inventory";

ALTER SCHEMA "inventory" OWNER TO "postgres";

CREATE EXTENSION IF NOT EXISTS "pgsodium" WITH SCHEMA "pgsodium";

COMMENT ON SCHEMA "public" IS 'standard public schema';

CREATE SCHEMA IF NOT EXISTS "sales";

ALTER SCHEMA "sales" OWNER TO "postgres";

CREATE SCHEMA IF NOT EXISTS "services";

ALTER SCHEMA "services" OWNER TO "postgres";

CREATE SCHEMA IF NOT EXISTS "system_configs";

ALTER SCHEMA "system_configs" OWNER TO "postgres";

CREATE SCHEMA IF NOT EXISTS "warehousing";

ALTER SCHEMA "warehousing" OWNER TO "postgres";

CREATE EXTENSION IF NOT EXISTS "http" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";

CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "pgjwt" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";


-- CREATE TYPE "communities"."eesupool_level" AS ENUM (
--     'National',
--     'Regional',
--     'Township',
--     'Kasi',
--     'Street'
-- );

-- ALTER TYPE "communities"."eesupool_level" OWNER TO "postgres";

-- CREATE TYPE "communities"."eesupool_member_role" AS ENUM (
--     'Admin',
--     'Member'
-- );

-- ALTER TYPE "communities"."eesupool_member_role" OWNER TO "postgres";

-- CREATE TYPE "communities"."eesupool_request_status" AS ENUM (
--     'Pending',
--     'Accepted',
--     'Declined'
-- );

-- ALTER TYPE "communities"."eesupool_request_status" OWNER TO "postgres";

-- CREATE TYPE "communities"."eesupool_type" AS ENUM (
--     'Trade',
--     'Kasi Connect',
--     'Interest Group',
--     'Kasi'
-- );

-- ALTER TYPE "communities"."eesupool_type" OWNER TO "postgres";

-- CREATE TYPE "engagements"."survey_type" AS ENUM (
--     'Test',
--     'Survey',
--     'Application'
-- );

-- ALTER TYPE "engagements"."survey_type" OWNER TO "postgres";

-- CREATE TYPE "finances"."payment_method" AS ENUM (
--     'Retail wallet',
--     'Ozow',
--     'Split-Ozow',
--     'Split-Instapay',
--     'Yoco',
--     'Instapay',
--     'Split-Yoco'
-- );

-- ALTER TYPE "finances"."payment_method" OWNER TO "postgres";

CREATE TYPE "finances"."payment_status" AS ENUM (
    'Complete',
    'Pending',
    'Cancelled'
);

ALTER TYPE "finances"."payment_status" OWNER TO "postgres";

CREATE TYPE "finances"."payment_type" AS ENUM (
    'Order',
    'Voucher'
);

ALTER TYPE "finances"."payment_type" OWNER TO "postgres";

-- CREATE TYPE "finances"."voucher_cycle" AS ENUM (
--     'Weekly',
--     'Monthly',
--     'Once-off'
-- );

-- ALTER TYPE "finances"."voucher_cycle" OWNER TO "postgres";

-- CREATE TYPE "inventory"."product_class" AS ENUM (
--     'Food',
--     'Crowdfund-voucher',
--     'Airtime',
--     'Mobile-data'
-- );

-- ALTER TYPE "inventory"."product_class" OWNER TO "postgres";

CREATE TYPE "public"."app_type" AS ENUM (
    'EESUp',
    'MyKasiShop'
);

ALTER TYPE "public"."app_type" OWNER TO "postgres";

-- CREATE TYPE "public"."basket_type" AS ENUM (
--     'Weekly',
--     'Monthly',
--     'Anually'
-- );

-- ALTER TYPE "public"."basket_type" OWNER TO "postgres";

-- CREATE TYPE "public"."eesupreneur_employee_role" AS ENUM (
--     'Owner',
--     'Employee'
-- );

-- ALTER TYPE "public"."eesupreneur_employee_role" OWNER TO "postgres";

-- CREATE TYPE "public"."notification_channel" AS ENUM (
--     'push',
--     'sms',
--     'email',
--     'all'
-- );

-- ALTER TYPE "public"."notification_channel" OWNER TO "postgres";

-- CREATE TYPE "public"."notification_type" AS ENUM (
--     'order',
--     'eesupool',
--     'eesupool_invite',
--     'other'
-- );

-- ALTER TYPE "public"."notification_type" OWNER TO "postgres";

-- CREATE TYPE "public"."service_type" AS ENUM (
--     'EESUpreneur',
--     'Driver'
-- );

-- ALTER TYPE "public"."service_type" OWNER TO "postgres";

-- CREATE TYPE "public"."user_class" AS ENUM (
--     'Individual',
--     'Organization',
--     'Reseller',
--     'Non-Profit Organization'
-- );

-- ALTER TYPE "public"."user_class" OWNER TO "postgres";

-- CREATE TYPE "public"."user_role" AS ENUM (
--     'Ubuntunist',
--     'EESUpreneur',
--     'EESUpromoter',
--     'Corporate',
--     'EESUplift-Corporate',
--     'Admin',
--     'Driver',
--     'Spaza',
--     'Anonymous'
-- );

-- ALTER TYPE "public"."user_role" OWNER TO "postgres";

-- CREATE TYPE "sales"."order_edit_privilage" AS ENUM (
--     'Packer',
--     'Collector',
--     'Owner',
--     'All'
-- );

-- ALTER TYPE "sales"."order_edit_privilage" OWNER TO "postgres";

-- CREATE TYPE "sales"."order_status" AS ENUM (
--     'Pending',
--     'Placed',
--     'Packaged',
--     'Ready',
--     'Collected',
--     'Cancelled'
-- );

-- ALTER TYPE "sales"."order_status" OWNER TO "postgres";

-- CREATE TYPE "sales"."ticket_resolution_type" AS ENUM (
--     'Reorder',
--     'Refund'
-- );

-- ALTER TYPE "sales"."ticket_resolution_type" OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."add_or_delete_reaction"("_message_id" integer, "_member_id" "uuid", "_liked" boolean) RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
BEGIN

    -- Check if a reaction already exists for the given message_id and member_id
    IF EXISTS (SELECT 1 FROM communities.message_reaction WHERE message_id = _message_id AND member_id = _member_id) THEN
        -- Check if the existing reaction type is the same as the incoming type
        IF (SELECT liked FROM communities.message_reaction WHERE message_id = _message_id AND member_id = _member_id) = _liked THEN
            -- Delete the reaction if it's the same type
            DELETE FROM communities.message_reaction
            WHERE message_id = _message_id AND member_id = _member_id;
        ELSE
            -- Update the reaction if it's a different type
            UPDATE communities.message_reaction
            SET liked = _liked
            WHERE message_id = _message_id AND member_id = _member_id;
        END IF;
    ELSE
        -- Insert a new reaction if none exists
        INSERT INTO communities.message_reaction (message_id, member_id, liked)
        VALUES (_message_id, _member_id, _liked);
    END IF;
END;
$$;

ALTER FUNCTION "communities"."add_or_delete_reaction"("_message_id" integer, "_member_id" "uuid", "_liked" boolean) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."broadcast_eesupool_message"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    broadcast_level communities.eesupool_level;
    descendants_ids record;
BEGIN
    -- Check if broadcast_to is not null
    IF NEW.broadcast_to IS NOT NULL THEN
        -- Loop through all levels specified in broadcast_to
        FOREACH broadcast_level IN ARRAY NEW.broadcast_to LOOP
            -- Call the function to get the list of pool id for each level
            FOR descendants_ids IN SELECT id FROM communities.get_eesupool_descendants_by_level(NEW.eesupool_id, broadcast_level) LOOP
                -- Duplicate the message row for each descendant_id
                INSERT INTO communities.message(
                    eesupool_id, author_id, content, reply_on_id, attachments, hash_tags,
                    is_approved, is_deleted
                ) VALUES (
                    descendants_ids.id,
                    NEW.author_id,
                    NEW.content,
                    NEW.reply_on_id,
                    NEW.attachments,
                    NEW.hash_tags,
                    NEW.is_approved,
                    NEW.is_deleted
                );
            END LOOP;
        END LOOP;
    END IF;
    RETURN NEW;
END;
$$;

ALTER FUNCTION "communities"."broadcast_eesupool_message"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."count_unseen_messages"("_eesupool_id" integer, "_member_id" "uuid") RETURNS integer
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    unseen_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO unseen_count
    FROM communities.message AS m
    WHERE m.eesupool_id = _eesupool_id
      AND m.id NOT IN (
          SELECT ms.message_id
          FROM communities.message_seen AS ms
          WHERE ms.member_id = _member_id
      );

    RETURN unseen_count;
END;
$$;

ALTER FUNCTION "communities"."count_unseen_messages"("_eesupool_id" integer, "_member_id" "uuid") OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."count_user_eesupools_by_type"("_id" "uuid", "_type" "communities"."eesupool_type") RETURNS integer
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    result_count integer;
BEGIN
    SELECT 
       count(e.id)
    INTO result_count
    FROM 
        communities.eesupool e
    JOIN 
        communities.eesupool_member em ON e.id = em.eesupool_id
    WHERE  
        em.user_id = _id AND e.type = _type;

    RETURN result_count;
END;
$$;

ALTER FUNCTION "communities"."count_user_eesupools_by_type"("_id" "uuid", "_type" "communities"."eesupool_type") OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."create_eesupool_invite_notification"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    eesupool_name TEXT;
BEGIN
    if new.type = 'Invite' then
    -- Retrieve the eesupool name from the communities.eesupool table
    SELECT name INTO eesupool_name FROM communities.eesupool WHERE id = NEW.eesupool_id;

   -- Insert a notification into the public.notification table
    INSERT INTO engagements.notification(user_id,title, body, data, type)
    VALUES (
        new.user_id,
        CONCAT(eesupool_name, ' Invite'),
        CONCAT('You are invited to become a member of ', eesupool_name,'.'),
        json_build_object('user_id', NEW.user_id,'eesupool_id',new.eesupool_id)::jsonb,
        'eesupool_invite'
    );
    end if;
    -- Return the new record
    RETURN NEW;
END;
$$;

ALTER FUNCTION "communities"."create_eesupool_invite_notification"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."create_eesupool_member"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM communities.eesupool_member WHERE user_id = NEW.user_id AND eesupool_id = NEW.eesupool_id) THEN
    IF NEW.status = 'Accepted' THEN
      INSERT INTO communities.eesupool_member(user_id, eesupool_id)
      VALUES (NEW.user_id, NEW.eesupool_id);
    END IF;
  END IF;
  RETURN NEW;
END;
$$;

ALTER FUNCTION "communities"."create_eesupool_member"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."create_new_eesupool"("admin_id" "uuid", "name" "text", "description" "text", "parent_id" integer, "level" "communities"."eesupool_level", "type" "communities"."eesupool_type") RETURNS integer
    LANGUAGE "plpgsql"
    AS $$
DECLARE
  new_id integer;
BEGIN
  -- Create pool
  INSERT INTO communities.eesupool(name, description, parent_id, level, type)
  VALUES (name, description, parent_id, level, type)
  RETURNING id INTO new_id;
  
  -- Create default admin
  INSERT INTO communities.eesupool_member(user_id, eesupool_id, role) 
  VALUES (admin_id, new_id, 'Admin');

  RETURN new_id;
END;
$$;

ALTER FUNCTION "communities"."create_new_eesupool"("admin_id" "uuid", "name" "text", "description" "text", "parent_id" integer, "level" "communities"."eesupool_level", "type" "communities"."eesupool_type") OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."generate_pool_order_secret_pin"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
declare
  pin int;
begin
  select num into pin 
  from generate_series(10000, 99999) as s(num)
  order by random() limit 1;

  new.secret_pin = pin;
  return new;
end;
$$;

ALTER FUNCTION "communities"."generate_pool_order_secret_pin"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_eesupool_by_id"("_user_id" "uuid", "_pool_id" integer) RETURNS TABLE("eesupool_id" integer, "name" "text", "description" "text", "code" integer, "is_public" boolean, "address_id" integer, "type" "communities"."eesupool_type", "parent_id" integer, "level" "communities"."eesupool_level", "chat_enabled" boolean, "admin_fee" numeric, "receiving_fee" numeric, "collection_fee" numeric, "packaging_fee" numeric, "chat_tags" "text"[], "chat_tags_suggestions" "text"[], "member_id" "uuid", "role" "communities"."eesupool_member_role", "is_censored" boolean, "num_members" integer, "unseen_messages" integer, "address" "jsonb")
    LANGUAGE "plpgsql"
    AS $$
BEGIN
RETURN QUERY
SELECT 
    e.id as eesupool_id, 
    e.name,
    e.description,
    e.code,
    e.is_public,
    e.address_id,
    e.type,
    e.parent_id,
    e.level,
    e.chat_enabled,
    e.admin_fee,
    e.receiving_fee,
    e.collection_fee,
    e.packaging_fee,
    e.chat_tags,
    e.chat_tags_suggestions,
    em.id as member_id,
    em.role,
    em.is_censored,
   CAST(COALESCE((SELECT COUNT(m.id) FROM communities.eesupool_member m WHERE m.eesupool_id = e.id), 0) AS integer) as num_members,
   CAST(COALESCE((SELECT count_unseen_messages FROM communities.count_unseen_messages(e.id, em.id)),0) AS integer) as unseen_messages,
   COALESCE((SELECT row_to_json(t)::jsonb 
            FROM (SELECT * FROM geolocations.get_address_by_id(e.address_id)) t), null) AS address
FROM 
    communities.eesupool e
JOIN 
    communities.eesupool_member em ON e.id = em.eesupool_id
WHERE  
    em.user_id = _user_id AND e.id = _pool_id
ORDER BY 
    e.id
LIMIT 
    1;
END;
$$;

ALTER FUNCTION "communities"."get_eesupool_by_id"("_user_id" "uuid", "_pool_id" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_eesupool_descendants_by_level"("parent_pool_id" integer, "children_level" "communities"."eesupool_level") RETURNS TABLE("id" integer)
    LANGUAGE "sql" STABLE
    AS $$
WITH RECURSIVE ancestry AS (
    SELECT
        pool.id,
        pool.level
    FROM
        communities.eesupool pool
    WHERE
        pool.parent_id = parent_pool_id
    UNION ALL
    SELECT
        pool.id,
        pool.level
    FROM
        communities.eesupool pool
    INNER JOIN ancestry a ON a.id = pool.parent_id
)
SELECT
    id
FROM
    ancestry
WHERE
    level = children_level;
$$;

ALTER FUNCTION "communities"."get_eesupool_descendants_by_level"("parent_pool_id" integer, "children_level" "communities"."eesupool_level") OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_eesupool_event_attendees"("p_event_id" "uuid", "p_pool_id" integer) RETURNS TABLE("member_id" "uuid", "user_id" "uuid", "eesupool_id" integer, "created_at" timestamp with time zone, "role" "communities"."eesupool_member_role", "is_censored" boolean, "full_name" "text")
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        m.id AS member_id,
        m.user_id, 
        m.eesupool_id, 
        m.created_at, 
        m.role, 
        m.is_censored, 
        (SELECT CONCAT(p.first_name, ' ', p.last_name) 
         FROM profile p
         WHERE m.user_id = p.user_id) AS full_name
    FROM 
        communities.event_attendee ea
    JOIN 
        communities.eesupool_member m ON ea.member_id = m.id
    WHERE 
        ea.event_id = p_event_id AND m.eesupool_id = p_pool_id;
END;
$$;

ALTER FUNCTION "communities"."get_eesupool_event_attendees"("p_event_id" "uuid", "p_pool_id" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_eesupool_events"("pool_id" integer) RETURNS TABLE("id" "uuid", "eesupool_id" integer, "created_at" timestamp with time zone, "title" "text", "notes" "text", "remote_url" "text", "address_id" integer, "start_at" timestamp with time zone, "end_at" timestamp with time zone, "attendees" "jsonb", "attachments" "jsonb"[])
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  RETURN QUERY
  SELECT
    e.id,
    e.eesupool_id,
    e.created_at,
    e.title,
    e.notes,
    e.remote_url,
    e.address_id,
    e.start_at,
    e.end_at,
    COALESCE(
            (SELECT jsonb_agg(t) FROM (SELECT * FROM communities.get_eesupool_event_attendees(e.id, e.eesupool_id)) t),
            '[]'::jsonb
        ) AS attendees,
    e.attachments
  FROM communities.event e
  WHERE e.eesupool_id = pool_id
  ORDER BY e.created_at DESC;
END; $$;

ALTER FUNCTION "communities"."get_eesupool_events"("pool_id" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_eesupool_issues"("pool_id" integer, "limit_to" integer) RETURNS TABLE("issue_id" "uuid", "created_at" timestamp with time zone, "description" "text", "message" "jsonb", "eesupool_id" integer, "attachments" "jsonb"[], "resolved_at" timestamp with time zone, "offender_member" "jsonb", "reporter_member" "jsonb")
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        ei.id AS issue_id,
        ei.created_at,
        ei.description,
        COALESCE((SELECT row_to_json(t)::jsonb FROM (SELECT * FROM communities.get_message_by_id(ei.message_id)) t), null::jsonb) AS message,
        ei.eesupool_id,
        ei.attachments,
        ei.resolved_at,
        COALESCE((SELECT row_to_json(t)::jsonb FROM (SELECT * FROM communities.get_eesupool_member_by_id(ei.offender_id)) t), null::jsonb) AS offender_member,
        COALESCE((SELECT row_to_json(t)::jsonb FROM (SELECT * FROM communities.get_eesupool_member_by_id(ei.reporter_id)) t), null::jsonb) AS reporter_member
    FROM
        communities.eesupool_issue ei
    WHERE
        (ei.eesupool_id = pool_id OR ei.parent_pool_id = pool_id) AND ei.resolved_at IS NULL
    ORDER BY
        ei.created_at DESC
    LIMIT
        limit_to;
END;
$$;

ALTER FUNCTION "communities"."get_eesupool_issues"("pool_id" integer, "limit_to" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_eesupool_member_by_id"("membership_id" "uuid") RETURNS TABLE("member_id" "uuid", "user_id" "uuid", "eesupool_id" integer, "created_at" timestamp with time zone, "role" "communities"."eesupool_member_role", "is_censored" boolean, "full_name" "text")
    LANGUAGE "plpgsql"
    AS $$BEGIN
    RETURN QUERY
    SELECT
        m.id as member_id,
        m.user_id, 
        m.eesupool_id, 
        m.created_at, 
        m.role, 
        m.is_censored, 
        (
            SELECT 
                COALESCE(
                    CASE 
                        WHEN p.first_name IS NOT NULL AND p.last_name IS NOT NULL THEN CONCAT(p.first_name, ' ', p.last_name)
                        ELSE p.corp_name
                    END,
                    'Unknown Name'
                )
            FROM profile p
            WHERE m.user_id = p.user_id
        ) AS full_name
    FROM 
        communities.eesupool_member m
    WHERE 
        m.id = membership_id
    LIMIT 1;
END;
$$;

ALTER FUNCTION "communities"."get_eesupool_member_by_id"("membership_id" "uuid") OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_eesupool_members"("pool_id" integer, "limit_to" integer) RETURNS TABLE("member_id" "uuid", "user_id" "uuid", "eesupool_id" integer, "created_at" timestamp with time zone, "role" "communities"."eesupool_member_role", "is_censored" boolean, "full_name" "text")
    LANGUAGE "plpgsql"
    AS $$BEGIN
    RETURN QUERY
    SELECT
        m.id as member_id,
        m.user_id, 
        m.eesupool_id, 
        m.created_at, 
        m.role, 
        m.is_censored, 
        (
            SELECT 
                COALESCE(
                    CASE 
                        WHEN p.first_name IS NOT NULL AND p.last_name IS NOT NULL THEN CONCAT(p.first_name, ' ', p.last_name)
                        ELSE p.corp_name
                    END,
                    'Unknown Name'
                )
            FROM profile p
            WHERE m.user_id = p.user_id
        ) AS full_name
    FROM 
        communities.eesupool_member m
    WHERE 
        m.eesupool_id = pool_id 
    LIMIT 
        limit_to;
END;
$$;

ALTER FUNCTION "communities"."get_eesupool_members"("pool_id" integer, "limit_to" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_eesupool_members_by_id_array"("members" "uuid"[]) RETURNS TABLE("member_id" "uuid", "user_id" "uuid", "eesupool_id" integer, "created_at" timestamp with time zone, "role" "communities"."eesupool_member_role", "is_censored" boolean, "full_name" "text")
    LANGUAGE "plpgsql"
    AS $$BEGIN
    RETURN QUERY
    SELECT
        m.id as member_id,
        m.user_id, 
        m.eesupool_id, 
        m.created_at, 
        m.role, 
        m.is_censored, 
        (
            SELECT 
                COALESCE(
                    CASE 
                        WHEN p.first_name IS NOT NULL AND p.last_name IS NOT NULL THEN CONCAT(p.first_name, ' ', p.last_name)
                        ELSE p.corp_name
                    END,
                    'Unknown Name'
                )
            FROM profile p
            WHERE m.user_id = p.user_id
        ) AS full_name
    FROM 
        communities.eesupool_member m
    WHERE 
        m.id in (members);
END;
$$;

ALTER FUNCTION "communities"."get_eesupool_members_by_id_array"("members" "uuid"[]) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_eesupool_messages"("pool_id" integer, "approved" boolean, "limit_to" integer) RETURNS TABLE("id" integer, "eesupool_id" integer, "author_id" "uuid", "created_at" timestamp with time zone, "content" "text", "reply_on_id" integer, "attachments" "jsonb"[], "author_full_name" "text", "reply_message" "jsonb", "reactions" "jsonb", "is_approved" boolean, "hash_tags" "text"[], "is_deleted" boolean, "message_seens" "uuid"[])
    LANGUAGE "plpgsql" STABLE
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        m.id,
        m.eesupool_id,
        m.author_id,
        m.created_at,
        m.content,
        m.reply_on_id,
        m.attachments,
        (SELECT CONCAT(p.first_name, ' ', p.last_name) 
         FROM profile p 
         JOIN communities.eesupool_member em ON p.user_id = em.user_id
         WHERE em.id = m.author_id) AS author_full_name,
        COALESCE((SELECT row_to_json(t)::jsonb 
                  FROM (SELECT * FROM communities.get_message_by_id(m.reply_on_id)) t), 'null'::jsonb) AS reply_message,
        COALESCE((SELECT jsonb_agg(t) 
                  FROM (SELECT * FROM communities.get_message_reactions(m.id)) t), 'null'::jsonb) AS reactions, 
        m.is_approved,
        m.hash_tags,
        m.is_deleted,
        ARRAY_AGG(ms.member_id) FILTER (WHERE ms.message_id = m.id) AS message_seens
    FROM 
        communities.message m
    LEFT JOIN communities.message_seen ms ON m.id = ms.message_id
    WHERE 
        m.eesupool_id = pool_id AND m.is_approved = approved
    GROUP BY 
        m.id, m.eesupool_id, m.author_id, m.created_at, m.content,
        m.reply_on_id, m.attachments, author_full_name, reply_message,
        reactions, m.is_approved, m.hash_tags, m.is_deleted
    ORDER BY 
        m.created_at DESC
    LIMIT 
        limit_to;
END;
$$;

ALTER FUNCTION "communities"."get_eesupool_messages"("pool_id" integer, "approved" boolean, "limit_to" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_eesupool_messages_by_hash_tag"("pool_id" integer, "hash_tag" "text", "approved" boolean, "limit_to" integer) RETURNS TABLE("id" integer, "eesupool_id" integer, "author_id" "uuid", "created_at" timestamp with time zone, "content" "text", "reply_on_id" integer, "attachments" "jsonb"[], "author_full_name" "text", "reply_message" "jsonb", "reactions" "jsonb", "is_approved" boolean, "hash_tags" "text"[], "is_deleted" boolean, "message_seens" "uuid"[])
    LANGUAGE "plpgsql" STABLE
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        m.id,
        m.eesupool_id,
        m.author_id,
        m.created_at,
        m.content,
        m.reply_on_id,
        m.attachments,
        (SELECT CONCAT(p.first_name, ' ', p.last_name) 
         FROM profile p 
         JOIN communities.eesupool_member em ON p.user_id = em.user_id
         WHERE em.id = m.author_id) AS author_full_name,
        COALESCE((SELECT row_to_json(t)::jsonb 
                  FROM (SELECT * FROM communities.get_message_by_id(m.reply_on_id)) t), null::jsonb) AS reply_message,
        COALESCE((SELECT jsonb_agg(t) 
                  FROM (SELECT * FROM communities.get_message_reactions(m.id)) t), null::jsonb) AS reactions,
        m.is_approved,
        m.hash_tags,
        m.is_deleted,
        ARRAY_AGG(ms.member_id) FILTER (WHERE ms.message_id = m.id) AS message_seens
    FROM 
        communities.message m
    LEFT JOIN communities.message_seen ms ON m.id = ms.message_id
    WHERE 
        m.eesupool_id = pool_id AND m.is_approved = approved
        AND hash_tag = ANY(m.hash_tags)
    GROUP BY 
        m.id, m.eesupool_id, m.author_id, m.created_at, m.content,
        m.reply_on_id, m.attachments, author_full_name, reply_message,
        reactions, m.is_approved, m.hash_tags, m.is_deleted
    ORDER BY 
        m.created_at DESC
    LIMIT 
        limit_to;
END;
$$;

ALTER FUNCTION "communities"."get_eesupool_messages_by_hash_tag"("pool_id" integer, "hash_tag" "text", "approved" boolean, "limit_to" integer) OWNER TO "postgres";

drop function "communities"."get_eesupool_orders"("pool_id" integer, "limit_to" integer);

CREATE OR REPLACE FUNCTION "communities"."get_eesupool_orders"("pool_id" integer, "limit_to" integer) RETURNS TABLE("id" integer, "eesupool_id" integer, "created_at" timestamp with time zone, "schedule_for" timestamp with time zone, "delivered_at" timestamp with time zone, "closes_at" timestamp with time zone, "admin_fee" numeric, "packer_fee" numeric, "receiver_fee" numeric, "collection_fee" numeric, "address_id" integer, "eesupool_name" "text", "address" "jsonb", "orders_count" integer, "current_amount" numeric, "secret_pin" integer)
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
        (select ep.name from communities.eesupool ep where ep.id = eo.eesupool_id) as eesupool_name,
        COALESCE((SELECT row_to_json(t)::jsonb 
                  FROM 
                  (SELECT * FROM geolocations.get_address_by_id(eo.address_id)) t), null::jsonb) AS address,
        CAST((select count(*) from sales.order o where o.eesupool_order_id = eo.id) as integer) as orders_count,
        COALESCE(CAST((SELECT SUM(o.value) FROM sales.order o WHERE o.eesupool_order_id = eo.id AND (o.status <> 'Pending' AND o.status <> 'Cancelled')) AS numeric),0.00) AS current_amount,
        eo.secret_pin      
    FROM communities.eesupool_order eo
    WHERE eo.eesupool_id = pool_id limit limit_to;
END;
$$;

ALTER FUNCTION "communities"."get_eesupool_orders"("pool_id" integer, "limit_to" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_eesupool_requests"("_pool_id" integer, "_user_id" "uuid", "_type" "text", "limit_to" integer) RETURNS TABLE("user_id" "uuid", "created_at" timestamp with time zone, "eesupool_id" integer, "type" "text", "status" "communities"."eesupool_request_status", "eesupool_name" "text", "full_name" "text", "corporate_name" "text", "role" "public"."user_role")
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  RETURN QUERY 
  SELECT 
    er.user_id,
    er.created_at,
    er.eesupool_id,
    er.type,
    er.status,
    e.name AS eesupool_name,
    COALESCE((p.first_name || ' ' || p.last_name),null) AS full_name,
    COALESCE(p.corp_name, null) AS corporate_name,
    p.role
  FROM 
    communities.eesupool_request er
  JOIN 
    communities.eesupool e ON er.eesupool_id = e.id
  JOIN 
    public.profile p ON er.user_id = p.user_id
  WHERE
    (er.eesupool_id = _pool_id or er.user_id = _user_id)
    AND er.type = _type
  LIMIT
    limit_to;
END; $$;

ALTER FUNCTION "communities"."get_eesupool_requests"("_pool_id" integer, "_user_id" "uuid", "_type" "text", "limit_to" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_eesupool_requests_and_invites"("pool_id" integer, "p_user_id" "uuid", "p_type" "text", "limit_to" integer) RETURNS TABLE("user_id" "uuid", "created_at" timestamp with time zone, "eesupool_id" integer, "request_type" "text", "status" "communities"."eesupool_request_status", "eesupool_name" "text", "full_name" "text", "corporate_name" "text", "role" "public"."user_role")
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY 
    SELECT 
        er.user_id,
        er.created_at,
        er.eesupool_id,
        er.type,
        er.status,
        e.name AS eesupool_name,
        (p.first_name || ' ' || p.last_name) AS full_name,
        p.corp_name AS corporate_name,
        p.role
    FROM 
        communities.eesupool_request er
        JOIN profile p ON er.user_id = p.user_id
        JOIN communities.eesupool e ON er.eesupool_id = e.id
    WHERE er.type = p_type AND (er.user_id = p_user_id or er.eesupool_id = pool_id)
    limit limit_to;
END; $$;

ALTER FUNCTION "communities"."get_eesupool_requests_and_invites"("pool_id" integer, "p_user_id" "uuid", "p_type" "text", "limit_to" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_eesupools_descendants"("_user_id" "uuid", "parent_pool_id" integer, "limit_to" integer) RETURNS TABLE("eesupool_id" integer, "name" "text", "description" "text", "code" integer, "is_public" boolean, "address_id" integer, "type" "communities"."eesupool_type", "parent_id" integer, "level" "communities"."eesupool_level", "chat_enabled" boolean, "admin_fee" numeric, "receiving_fee" numeric, "collection_fee" numeric, "packaging_fee" numeric, "chat_tags" "text"[], "chat_tags_suggestions" "text"[], "member_id" "uuid", "role" "communities"."eesupool_member_role", "is_censored" boolean, "num_members" integer, "unseen_messages" integer, "address" "jsonb")
    LANGUAGE "plpgsql"
    AS $$
BEGIN
RETURN QUERY
WITH RECURSIVE descendants AS (
    SELECT 
        e.*
    FROM 
        communities.eesupool e
    WHERE 
        e.id = parent_pool_id
    UNION ALL
    SELECT 
        e.*
    FROM 
        communities.eesupool e
    INNER JOIN 
        descendants d ON e.parent_id = d.id
)
SELECT 
    d.id as eesupool_id, 
    d.name,
    d.description,
    d.code,
    d.is_public,
    d.address_id,
    d.type,
    d.parent_id,
    d.level,
    d.chat_enabled,
    d.admin_fee,
    d.receiving_fee,
    d.collection_fee,
    d.packaging_fee,
    d.chat_tags,
    d.chat_tags_suggestions,
    em.id as member_id,
    em.role,
    em.is_censored,
    CAST(COALESCE((SELECT COUNT(m.id) FROM communities.eesupool_member m WHERE m.eesupool_id = d.id), 0) AS integer) as num_members,
    CAST(COALESCE((SELECT count_unseen_messages FROM communities.count_unseen_messages(d.id, em.id)),0) AS integer) as unseen_messages,
    COALESCE((SELECT row_to_json(t)::jsonb 
             FROM (SELECT * FROM geolocations.get_address_by_id(d.address_id)) t), null) AS address
FROM 
    descendants d
JOIN 
    communities.eesupool_member em ON d.id = em.eesupool_id
WHERE  
    em.user_id = _user_id AND d.id <> parent_pool_id AND em.role = 'Admin'
ORDER BY 
    d.id
LIMIT 
    limit_to;
END;
$$;

ALTER FUNCTION "communities"."get_eesupools_descendants"("_user_id" "uuid", "parent_pool_id" integer, "limit_to" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_eesupools_descendants_streets_for_requests"("_user_id" "uuid", "parent_pool_id" integer, "limit_to" integer) RETURNS TABLE("id" integer, "name" "text", "description" "text", "code" integer, "type" "communities"."eesupool_type", "level" "communities"."eesupool_level", "membership_id" "uuid", "invite_status" "communities"."eesupool_request_status")
    LANGUAGE "plpgsql"
    AS $$
BEGIN
RETURN QUERY
WITH RECURSIVE descendants AS (
    SELECT 
        e.*
    FROM 
        communities.eesupool e
    WHERE 
        e.id = parent_pool_id 
    UNION ALL
    SELECT 
        e.*
    FROM 
        communities.eesupool e
    INNER JOIN 
        descendants d ON e.parent_id = d.id
)
SELECT 
    d.id, 
    d.name,
    d.description,
    d.code,
    d.type,
    d.level,
    (select m.id from communities.eesupool_member m where m.user_id = _user_id AND m.eesupool_id = d.id) as membership_id,
    (select er.status from communities.eesupool_request er where er.user_id = _user_id and er.eesupool_id = d.id) as invite_status
FROM 
    descendants d
WHERE
    d.level = 'Street'
ORDER BY 
    d.id
LIMIT 
    limit_to;
END;
$$;

ALTER FUNCTION "communities"."get_eesupools_descendants_streets_for_requests"("_user_id" "uuid", "parent_pool_id" integer, "limit_to" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_message_by_id"("m_id" integer) RETURNS TABLE("id" integer, "eesupool_id" integer, "author_id" "uuid", "created_at" timestamp with time zone, "content" "text", "reply_on_id" integer, "attachments" "jsonb"[], "author_full_name" "text", "reply_message" "jsonb", "reactions" "jsonb", "is_approved" boolean, "hash_tags" "text"[], "is_deleted" boolean, "message_seens" "uuid"[])
    LANGUAGE "plpgsql" STABLE
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        m.id,
        m.eesupool_id,
        m.author_id,
        m.created_at,
        m.content,
        m.reply_on_id,
        m.attachments,
        (SELECT CONCAT(p.first_name, ' ', p.last_name) 
         FROM profile p 
         JOIN communities.eesupool_member em ON p.user_id = em.user_id
         WHERE em.id = m.author_id) AS author_full_name,
        COALESCE((SELECT row_to_json(t)::jsonb 
                  FROM (SELECT * FROM communities.get_message_by_id(m.reply_on_id)) t), 'null'::jsonb) AS reply_message,
        COALESCE((SELECT jsonb_agg(t) 
                  FROM (SELECT * FROM communities.get_message_reactions(m.id)) t), 'null'::jsonb) AS reactions,
        m.is_approved,
        m.hash_tags,
        m.is_deleted,
        ARRAY_AGG(ms.member_id) FILTER (WHERE ms.message_id = m.id) AS message_seens
    FROM 
        communities.message m
    LEFT JOIN communities.message_seen ms ON m.id = ms.message_id
    WHERE 
        m.id = m_id
    GROUP BY 
        m.id, m.eesupool_id, m.author_id, m.created_at, m.content, m.reply_on_id,
        m.attachments, author_full_name, m.is_approved, m.hash_tags, m.is_deleted
    LIMIT 1;
END;
$$;

ALTER FUNCTION "communities"."get_message_by_id"("m_id" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_message_reaction"("m_id" integer) RETURNS TABLE("message_id" integer, "member_id" "uuid", "created_at" timestamp with time zone, "liked" boolean, "member_full_name" "text")
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY SELECT 
        mr.message_id, 
        mr.member_id, 
        mr.created_at, 
        mr.liked, 
        CONCAT(p.first_name, ' ', p.last_name) AS member_full_name
    FROM 
        communities.message_reaction mr 
    JOIN 
        communities.eesupool_member em on mr.member_id = em.id
    JOIN
        profile p ON em.user_id = p.user_id
    WHERE 
        mr.message_id = m_id;
END;
$$;

ALTER FUNCTION "communities"."get_message_reaction"("m_id" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_message_reactions"("m_id" integer) RETURNS TABLE("message_id" integer, "member_id" "uuid", "created_at" timestamp with time zone, "liked" boolean, "member_full_name" "text")
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY 
    SELECT 
        mr.message_id, 
        mr.member_id, 
        mr.created_at, 
        mr.liked, 
        CONCAT(p.first_name, ' ', p.last_name) AS member_full_name
    FROM 
        communities.message_reaction mr 
    JOIN 
        communities.eesupool_member em ON mr.member_id = em.id
    JOIN 
        profile p ON em.user_id = p.user_id
    WHERE 
        mr.message_id = m_id;
END;
$$;

ALTER FUNCTION "communities"."get_message_reactions"("m_id" integer) OWNER TO "postgres";

drop FUNCTION "communities"."get_open_eesupool_order"("pool_id" integer);

CREATE OR REPLACE FUNCTION "communities"."get_open_eesupool_order"("pool_id" integer) RETURNS TABLE("id" integer, "eesupool_id" integer, "created_at" timestamp with time zone, "schedule_for" timestamp with time zone, "delivered_at" timestamp with time zone, "closes_at" timestamp with time zone, "admin_fee" numeric, "packer_fee" numeric, "receiver_fee" numeric, "collection_fee" numeric, "address_id" integer, "eesupool_name" "text", "address" "jsonb", "orders_count" integer, "current_amount" numeric, "secret_pin" integer)
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
        (select ep.name from communities.eesupool ep where ep.id = eo.eesupool_id) as eesupool_name,
        COALESCE((SELECT row_to_json(t)::jsonb 
                  FROM 
                  (SELECT * FROM geolocations.get_address_by_id(eo.address_id)) t), null::jsonb) AS address,
        CAST((select count(*) from sales.order o where o.eesupool_order_id = eo.id) as integer) as orders_count,
        COALESCE(CAST((SELECT SUM(o.value) FROM sales.order o WHERE o.eesupool_order_id = eo.id AND (o.status <> 'Pending' AND o.status <> 'Cancelled')) AS numeric),0.00) AS current_amount,
        eo.secret_pin  
    FROM communities.eesupool_order eo
    WHERE eo.closes_at > now() AND eo.eesupool_id = pool_id
    ORDER BY eo.created_at desc limit 1;
END;
$$;

ALTER FUNCTION "communities"."get_open_eesupool_order"("pool_id" integer) OWNER TO "postgres";
drop FUNCTION "communities"."get_open_eesupool_orders"("_user_id" "uuid", "_eesupool_id" integer, "_limit_to" integer);

CREATE OR REPLACE FUNCTION "communities"."get_open_eesupool_orders"("_user_id" "uuid", "_eesupool_id" integer, "_limit_to" integer) RETURNS TABLE("id" integer, "eesupool_id" integer, "created_at" timestamp with time zone, "schedule_for" timestamp with time zone, "delivered_at" timestamp with time zone, "closes_at" timestamp with time zone, "admin_fee" numeric, "packer_fee" numeric, "receiver_fee" numeric, "collection_fee" numeric, "address_id" integer, "eesupool_name" "text", "address" "jsonb", "orders_count" integer, "current_amount" numeric, "secret_pin" integer)
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    _referrer_user_id uuid;
BEGIN
    -- Get the user that referred this user so we can also get orders that they may have placed
    SELECT referrer_user_id INTO _referrer_user_id FROM referral WHERE refereed_user_id = _user_id;

    -- Get orders, including those from the referring user if applicable
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
        (SELECT ep.name FROM communities.eesupool ep WHERE ep.id = eo.eesupool_id) AS eesupool_name,
        COALESCE((SELECT row_to_json(t)::jsonb 
                  FROM (SELECT * FROM geolocations.get_address_by_id(eo.address_id)) t), 
                 null::jsonb) AS address,
        CAST((select count(*) from sales.order o where o.eesupool_order_id = eo.id) as integer) as orders_count,
        COALESCE(CAST((SELECT SUM(o.value) FROM sales.order o WHERE o.eesupool_order_id = eo.id AND (o.status <> 'Pending' AND o.status <> 'Cancelled')) AS numeric),0.00) AS current_amount,
        eo.secret_pin  
    FROM communities.eesupool_order eo 
    INNER JOIN communities.eesupool_member eem ON eo.eesupool_id = eem.eesupool_id
    WHERE eo.closes_at > now() AND
    ((eem.user_id = _user_id OR (_referrer_user_id IS NOT NULL AND eem.user_id = _referrer_user_id)) or eo.eesupool_id = _eesupool_id)
    ORDER BY eo.created_at desc
    LIMIT _limit_to;
END;
$$;

ALTER FUNCTION "communities"."get_open_eesupool_orders"("_user_id" "uuid", "_eesupool_id" integer, "_limit_to" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_order_assignments"("_order_id" integer) RETURNS TABLE("full_name" "text", "corp_name" "text", "privilage" "sales"."order_edit_privilage", "member_id" "uuid", "order_id" integer, "eesupool_ord_id" integer)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY 
    SELECT 
        CONCAT(p.first_name, ' ', p.last_name) AS full_name,
        p.corp_name,
        moa.privilage,
        moa.member_id,
        moa.order_id,
        moa.eesupool_ord_id
    FROM communities.member_order_assignment moa
    JOIN communities.eesupool_member em ON moa.member_id = em.id
    JOIN profile p ON em.user_id = p.user_id
    WHERE moa.order_id = _order_id;
END;
$$;

ALTER FUNCTION "communities"."get_order_assignments"("_order_id" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_sub_kases_for_search"("_parent_id" integer, "_user_id" "uuid") RETURNS TABLE("id" integer, "name" "text", "level" "communities"."eesupool_level", "invite_status" "communities"."eesupool_request_status", "membership_id" "uuid")
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        pool.id,
        pool.name,
        pool.level,
        req.status AS invite_status,
        mem.id AS membership_id
    FROM 
        communities.eesupool pool
        LEFT JOIN LATERAL (
            SELECT r.status 
            FROM communities.eesupool_request r 
            WHERE r.user_id = _user_id AND r.eesupool_id = pool.id
        ) req ON TRUE
        LEFT JOIN LATERAL (
            SELECT em.id 
            FROM communities.eesupool_member em 
            WHERE em.user_id = _user_id AND em.eesupool_id = pool.id
        ) mem ON TRUE
    WHERE 
        pool.parent_id = _parent_id;
END;
$$;

ALTER FUNCTION "communities"."get_sub_kases_for_search"("_parent_id" integer, "_user_id" "uuid") OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_user_eesupools"("id" "uuid", "limit_to" integer) RETURNS TABLE("eesupool_id" integer, "name" "text", "description" "text", "code" integer, "is_public" boolean, "address_id" integer, "type" "communities"."eesupool_type", "parent_id" integer, "level" "communities"."eesupool_level", "chat_enabled" boolean, "admin_fee" numeric, "receiving_fee" numeric, "collection_fee" numeric, "packaging_fee" numeric, "chat_tags" "text"[], "chat_tags_suggestions" "text"[], "member_id" "uuid", "role" "communities"."eesupool_member_role", "is_censored" boolean, "num_members" integer, "unseen_messages" integer, "address" "jsonb")
    LANGUAGE "plpgsql"
    AS $_$
BEGIN
RETURN QUERY
SELECT 
    e.id as eesupool_id, 
    e.name,
    e.description,
    e.code,
    e.is_public,
    e.address_id,
    e.type,
    e.parent_id,
    e.level,
    e.chat_enabled,
    e.admin_fee,
    e.receiving_fee,
    e.collection_fee,
    e.packaging_fee,
    e.chat_tags,
    e.chat_tags_suggestions,
    em.id as member_id,
    em.role,
    em.is_censored,
   CAST(COALESCE((SELECT COUNT(m.id) FROM communities.eesupool_member m WHERE m.eesupool_id = e.id), 0) AS integer) as num_members,
   CAST(COALESCE((SELECT count_unseen_messages FROM communities.count_unseen_messages(e.id, em.id)),0) AS integer) as unseen_messages,
   COALESCE((SELECT row_to_json(t)::jsonb 
            FROM (SELECT * FROM geolocations.get_address_by_id(e.address_id)) t), null) AS address
FROM 
    communities.eesupool e
JOIN 
    communities.eesupool_member em ON e.id = em.eesupool_id
WHERE  
    em.user_id = $1
ORDER BY 
    e.id
LIMIT 
    $2;
END;
$_$;

ALTER FUNCTION "communities"."get_user_eesupools"("id" "uuid", "limit_to" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_user_eesupools_v2"("id" "uuid", "limit_to" integer, "pool_type" "communities"."eesupool_type") RETURNS TABLE("eesupool_id" integer, "name" "text", "description" "text", "code" integer, "is_public" boolean, "address_id" integer, "type" "communities"."eesupool_type", "parent_id" integer, "level" "communities"."eesupool_level", "chat_enabled" boolean, "admin_fee" numeric, "receiving_fee" numeric, "collection_fee" numeric, "packaging_fee" numeric, "chat_tags" "text"[], "chat_tags_suggestions" "text"[], "member_id" "uuid", "role" "communities"."eesupool_member_role", "is_censored" boolean, "num_members" integer, "unseen_messages" integer, "address" "jsonb")
    LANGUAGE "plpgsql"
    AS $_$
BEGIN
RETURN QUERY
SELECT 
    e.id as eesupool_id, 
    e.name,
    e.description,
    e.code,
    e.is_public,
    e.address_id,
    e.type,
    e.parent_id,
    e.level,
    e.chat_enabled,
    e.admin_fee,
    e.receiving_fee,
    e.collection_fee,
    e.packaging_fee,
    e.chat_tags,
    e.chat_tags_suggestions,
    em.id as member_id,
    em.role,
    em.is_censored,
   CAST(COALESCE((SELECT COUNT(m.id) FROM communities.eesupool_member m WHERE m.eesupool_id = e.id), 0) AS integer) as num_members,
   CAST(COALESCE((SELECT count_unseen_messages FROM communities.count_unseen_messages(e.id, em.id)),0) AS integer) as unseen_messages,
   COALESCE((SELECT row_to_json(t)::jsonb 
            FROM (SELECT * FROM geolocations.get_address_by_id(e.address_id)) t), null) AS address
FROM 
    communities.eesupool e
JOIN 
    communities.eesupool_member em ON e.id = em.eesupool_id
WHERE  
    em.user_id = $1 AND
    e.type = $3
ORDER BY 
    e.id
LIMIT 
    $2;
END;
$_$;

ALTER FUNCTION "communities"."get_user_eesupools_v2"("id" "uuid", "limit_to" integer, "pool_type" "communities"."eesupool_type") OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."notify_eesupool_members"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    author_name TEXT;
    recipients UUID[];
BEGIN
    IF NEW.is_approved = True THEN
    -- Get all the eesupool members
    SELECT ARRAY_AGG(user_id) INTO recipients
    FROM communities.eesupool_member 
    WHERE eesupool_id = NEW.eesupool_id;

    -- Get the author's name
    SELECT CONCAT(p.first_name, ' ', p.last_name) INTO author_name
    FROM communities.eesupool_member em
    JOIN profile p ON em.user_id = p.user_id
    WHERE em.eesupool_id = NEW.eesupool_id AND em.user_id = NEW.author_id;

    -- Send push notification
    PERFORM engagements.send_one_signal_push_notification(
        author_name::text,
        NEW.content::text,
        'EESUPOOL_CHAT'::text,
        NULL,
        JSON_BUILD_OBJECT('eesupool_id', NEW.eesupool_id)::jsonb,
        recipients
    );
    END IF;

    RETURN NEW;
END;
$$;

ALTER FUNCTION "communities"."notify_eesupool_members"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."on_invite_revoked_delete_notification"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    delete from engagements.notification where data ->>'user_id' = cast(old.user_id as text)
    AND data ->>'eesupool_id' = cast(old.eesupool_id as text);
    RETURN NEW;
END;
$$;

ALTER FUNCTION "communities"."on_invite_revoked_delete_notification"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."search_eesupools_descendants"("_user_id" "uuid", "parent_pool_id" integer, "query_str" "text", "limit_to" integer) RETURNS TABLE("eesupool_id" integer, "name" "text", "description" "text", "code" integer, "is_public" boolean, "address_id" integer, "type" "communities"."eesupool_type", "parent_id" integer, "level" "communities"."eesupool_level", "chat_enabled" boolean, "admin_fee" numeric, "receiving_fee" numeric, "collection_fee" numeric, "packaging_fee" numeric, "chat_tags" "text"[], "chat_tags_suggestions" "text"[], "member_id" "uuid", "role" "communities"."eesupool_member_role", "is_censored" boolean, "num_members" integer, "unseen_messages" integer, "address" "jsonb")
    LANGUAGE "plpgsql"
    AS $$
BEGIN
RETURN QUERY
WITH RECURSIVE descendants AS (
    SELECT 
        e.*
    FROM 
        communities.eesupool e
    WHERE 
        e.id = parent_pool_id
    UNION ALL
    SELECT 
        e.*
    FROM 
        communities.eesupool e
    INNER JOIN 
        descendants d ON e.parent_id = d.id
)
SELECT 
    d.id as eesupool_id, 
    d.name,
    d.description,
    d.code,
    d.is_public,
    d.address_id,
    d.type,
    d.parent_id,
    d.level,
    d.chat_enabled,
    d.admin_fee,
    d.receiving_fee,
    d.collection_fee,
    d.packaging_fee,
    d.chat_tags,
    d.chat_tags_suggestions,
    em.id as member_id,
    em.role,
    em.is_censored,
    CAST(COALESCE((SELECT COUNT(m.id) FROM communities.eesupool_member m WHERE m.eesupool_id = d.id), 0) AS integer) as num_members,
    CAST(COALESCE((SELECT count_unseen_messages FROM communities.count_unseen_messages(d.id, em.id)),0) AS integer) as unseen_messages,
    COALESCE((SELECT row_to_json(t)::jsonb 
             FROM (SELECT * FROM geolocations.get_address_by_id(d.address_id)) t), null) AS address
FROM 
    descendants d
JOIN 
    communities.eesupool_member em ON d.id = em.eesupool_id
WHERE  
    em.user_id = _user_id AND d.id <> parent_pool_id AND em.role = 'Admin'
    AND (d.name ILIKE '%' || query_str || '%' OR CAST(d.code AS TEXT) ILIKE '%' || query_str || '%' 
    OR CAST(d.box_code AS TEXT) ILIKE '%' || query_str || '%' OR CAST(d.street_code AS TEXT) ILIKE '%' || query_str || '%')
ORDER BY 
    d.id
LIMIT 
    limit_to;
END;
$$;

ALTER FUNCTION "communities"."search_eesupools_descendants"("_user_id" "uuid", "parent_pool_id" integer, "query_str" "text", "limit_to" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."search_for_eesupools_by_type"("query_str" "text", "_user_id" "uuid", "_type" "communities"."eesupool_type", "limit_to" integer) RETURNS TABLE("id" integer, "name" "text", "level" "communities"."eesupool_level", "invite_status" "communities"."eesupool_request_status", "membership_id" "uuid", "sub_eesupools" "jsonb", "parent_name" "text")
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        pool.id,
        pool.name,
        pool.level,
        req.status AS invite_status,
        mem.id AS membership_id,
        COALESCE((SELECT jsonb_agg(t) 
                  FROM (SELECT * FROM communities.get_sub_kases_for_search(pool.id,_user_id)
                  ) t), '[]'::jsonb) AS sub_eesupools,
        (select par.name from communities.eesupool par where par.id = pool.parent_id) as parent_name
    FROM 
        communities.eesupool pool
        LEFT JOIN LATERAL (
            SELECT r.status 
            FROM communities.eesupool_request r 
            WHERE r.user_id = _user_id AND r.eesupool_id = pool.id
        ) req ON TRUE
        LEFT JOIN LATERAL (
            SELECT em.id 
            FROM communities.eesupool_member em 
            WHERE em.user_id = _user_id AND em.eesupool_id = pool.id
        ) mem ON TRUE
    WHERE 
        (pool.name ILIKE '%' || query_str || '%' OR
         pool.code::text ILIKE '%' || query_str || '%' OR CAST(pool.box_code AS TEXT) ILIKE '%' || query_str || '%' 
         OR CAST(pool.street_code AS TEXT) ILIKE '%' || query_str || '%') 
        AND pool.type = _type   
    LIMIT
        limit_to;
END;
$$;

ALTER FUNCTION "communities"."search_for_eesupools_by_type"("query_str" "text", "_user_id" "uuid", "_type" "communities"."eesupool_type", "limit_to" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."search_for_trade_eesupools"("query_str" "text", "_user_id" "uuid", "lat" double precision, "lng" double precision, "limit_to" integer) RETURNS TABLE("id" integer, "name" "text", "distance" double precision, "invite_status" "communities"."eesupool_request_status", "membership_id" "uuid")
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        pool.id,
        pool.name,
       geolocations.calculate_distance_between_2_locations(lat, lng, adr.latitude, adr.longitude) AS distance,
        req.status AS invite_status,
        mem.id AS membership_id
    FROM 
        communities.eesupool pool
        LEFT JOIN geolocations.address adr ON pool.address_id = adr.id
        LEFT JOIN LATERAL (
            SELECT r.status 
            FROM communities.eesupool_request r 
            WHERE r.user_id = _user_id AND r.eesupool_id = pool.id
        ) req ON TRUE
        LEFT JOIN LATERAL (
            SELECT em.id 
            FROM communities.eesupool_member em 
            WHERE em.user_id = _user_id AND em.eesupool_id = pool.id
        ) mem ON TRUE
    WHERE 
        (pool.name ILIKE '%' || query_str || '%' OR
         pool.code::text ILIKE '%' || query_str || '%'  OR CAST(pool.box_code AS TEXT) ILIKE '%' || query_str || '%' 
         OR CAST(pool.street_code AS TEXT) ILIKE '%' || query_str || '%')
        AND pool.is_public AND pool.address_id is not null      
    LIMIT
        limit_to;
END;
$$;

ALTER FUNCTION "communities"."search_for_trade_eesupools"("query_str" "text", "_user_id" "uuid", "lat" double precision, "lng" double precision, "limit_to" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."search_profiles_for_eesupool_invites"("query_str" "text", "pool_id" integer, "limit_to" integer) RETURNS TABLE("full_name" "text", "corporate_name" "text", "user_id" "uuid", "role" "public"."user_role", "membership_id" "uuid", "status" "communities"."eesupool_request_status")
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        concat(p.first_name,' ',p.last_name) AS full_name,
        p.corp_name AS corporate_name,
        p.user_id,
        p.role,
        COALESCE(
            (SELECT em.id FROM communities.eesupool_member em WHERE em.user_id = p.user_id AND em.eesupool_id = pool_id),
            NULL
        ) AS membership_id,
        COALESCE(
            (SELECT er.status FROM communities.eesupool_request er WHERE er.user_id = p.user_id AND er.eesupool_id = pool_id),
            NULL
        ) AS status
    FROM 
        public.profile p
    WHERE 
        p.first_name ILIKE '%' || query_str || '%'
        OR p.last_name ILIKE '%' || query_str || '%'
        OR CAST(p.referral_code AS TEXT) ILIKE '%' || query_str || '%'
    LIMIT
        limit_to;
END;
$$;

ALTER FUNCTION "communities"."search_profiles_for_eesupool_invites"("query_str" "text", "pool_id" integer, "limit_to" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."search_user_eesupools"("query_str" "text", "_type" "communities"."eesupool_type", "_user_id" "uuid", "limit_to" integer) RETURNS TABLE("eesupool_id" integer, "name" "text", "description" "text", "code" integer, "is_public" boolean, "address_id" integer, "type" "communities"."eesupool_type", "parent_id" integer, "level" "communities"."eesupool_level", "chat_enabled" boolean, "admin_fee" numeric, "receiving_fee" numeric, "collection_fee" numeric, "packaging_fee" numeric, "chat_tags" "text"[], "chat_tags_suggestions" "text"[], "member_id" "uuid", "role" "communities"."eesupool_member_role", "is_censored" boolean, "num_members" integer, "unseen_messages" integer, "address" "jsonb")
    LANGUAGE "plpgsql"
    AS $$
BEGIN
RETURN QUERY
SELECT 
    e.id as eesupool_id, 
    e.name,
    e.description,
    e.code,
    e.is_public,
    e.address_id,
    e.type,
    e.parent_id,
    e.level,
    e.chat_enabled,
    e.admin_fee,
    e.receiving_fee,
    e.collection_fee,
    e.packaging_fee,
    e.chat_tags,
    e.chat_tags_suggestions,
    em.id as member_id,
    em.role,
    em.is_censored,
    CAST(COALESCE((SELECT COUNT(m.id) FROM communities.eesupool_member m WHERE m.eesupool_id = e.id), 0) AS integer) as num_members,
    CAST(COALESCE((SELECT count_unseen_messages FROM communities.count_unseen_messages(e.id, em.id)),0) AS integer) as unseen_messages,
    COALESCE((SELECT row_to_json(t)::jsonb 
            FROM (SELECT * FROM geolocations.get_address_by_id(e.address_id)) t), null) AS address
FROM 
    communities.eesupool e
JOIN 
    communities.eesupool_member em ON e.id = em.eesupool_id
WHERE  
    em.user_id = _user_id AND e.type = _type AND
    (e.name ILIKE '%' || query_str || '%' OR 
     e.code::text ILIKE '%' || query_str || '%' OR 
     e.street_code::text ILIKE '%' || query_str || '%' OR 
     e.box_code::text ILIKE '%' || query_str || '%')
ORDER BY 
    e.id
LIMIT 
    limit_to;
END; $$;

ALTER FUNCTION "communities"."search_user_eesupools"("query_str" "text", "_type" "communities"."eesupool_type", "_user_id" "uuid", "limit_to" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."set_default_order_assignment"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    pool_id INTEGER;
    admin_member_id UUID;
BEGIN

    IF NEW.eesupool_order_id IS NOT NULL THEN
    SELECT m.id INTO admin_member_id 
    FROM communities.eesupool_member m
    JOIN communities.eesupool_order eo ON m.eesupool_id = eo.eesupool_id
    WHERE eo.id = NEW.eesupool_order_id AND m.role = 'Admin'
    LIMIT 1;

    INSERT INTO communities.member_order_assignment(order_id, eesupool_ord_id, member_id)
    VALUES (NEW.id, NEW.eesupool_order_id, admin_member_id);

    END IF;
    RETURN NEW;
END;
$$;

ALTER FUNCTION "communities"."set_default_order_assignment"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "engagements"."get_survey_by_id"("_survey_id" "uuid", "_user_id" "uuid") RETURNS TABLE("id" "uuid", "created_at" timestamp with time zone, "title" "text", "description" "text", "type" "engagements"."survey_type", "questions" "jsonb", "max_responses" integer, "image_url" "text", "video_url" "text", "reward_amount" numeric, "duration" integer, "points" integer, "pass_percentage" numeric, "enable_scoring" boolean, "require_all" boolean, "enforce_time_limit" boolean, "pre_survey" "jsonb", "passed" boolean, "score" integer, "responded_at" timestamp with time zone)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY SELECT 
        s.id,
        s.created_at,
        s.title,
        s.description,
        s.type,
        s.questions,
        s.max_responses,
        s.image_url,
        s.video_url,
        s.reward_amount,
        s.duration,
        s.points,
        s.pass_percentage,
        s.enable_scoring,
        s.require_all,
        s.enforce_time_limit,
        COALESCE((SELECT row_to_json(t)::jsonb 
                  FROM (SELECT * FROM engagements.get_survey_by_id(s.pre_id,_user_id)) t), null) AS pre_survey,
        r.passed,
        r.score,
        r.created_at as responded_at
    FROM engagements.survey s
    LEFT JOIN engagements.response r ON s.id = r.survey_id AND r.user_id = _user_id
    WHERE s.id=_survey_id;
END;
$$;

ALTER FUNCTION "engagements"."get_survey_by_id"("_survey_id" "uuid", "_user_id" "uuid") OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "engagements"."get_user_avail_surveys"("_user_id" "uuid", "_type" "engagements"."survey_type") RETURNS TABLE("id" "uuid", "created_at" timestamp with time zone, "title" "text", "description" "text", "type" "engagements"."survey_type", "questions" "jsonb", "max_responses" integer, "image_url" "text", "video_url" "text", "reward_amount" numeric, "duration" integer, "points" integer, "pass_percentage" numeric, "enable_scoring" boolean, "require_all" boolean, "enforce_time_limit" boolean, "pre_survey" "jsonb", "passed" boolean, "score" integer, "responded_at" timestamp with time zone)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY SELECT 
        s.id,
        s.created_at,
        s.title,
        s.description,
        s.type,
        s.questions,
        s.max_responses,
        s.image_url,
        s.video_url,
        s.reward_amount,
        s.duration,
        s.points,
        s.pass_percentage,
        s.enable_scoring,
        s.require_all,
        s.enforce_time_limit,
        COALESCE((SELECT row_to_json(t)::jsonb 
                  FROM (SELECT * FROM engagements.get_survey_by_id(s.pre_id,_user_id)) t), null) AS pre_survey,
        r.passed,
        r.score,
        r.created_at as responded_at
    FROM engagements.survey s
    LEFT JOIN engagements.response r ON s.id = r.survey_id AND r.user_id = _user_id
    WHERE r.survey_id ISNULL AND s.is_public=true  AND s.type = _type;
END;
$$;

ALTER FUNCTION "engagements"."get_user_avail_surveys"("_user_id" "uuid", "_type" "engagements"."survey_type") OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "engagements"."send_one_signal_push_notification"("title" "text", "body" "text", "campaign" "text", "image_url" "text", "data" "jsonb", "recipients" "uuid"[]) RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
DECLARE
  _payload TEXT;
  _key TEXT;
  _url TEXT;
  _base_api_url text;
BEGIN
  -- Retrieve the API key
  SELECT key INTO _key FROM system_configs.api_key WHERE id = 'supabase' AND is_active = TRUE;

  SELECT text_value INTO _base_api_url FROM system_configs.remote_config WHERE id = 'eesup_api_base_url';

  -- Construct the payload
  _payload := json_build_object(
    'title', title,
    'body', body,
    'image_url', image_url,
    'campaign', campaign,
    'recipients', recipients,
    'data', data
  )::text;

  _url := concat(_base_api_url,'/notifications/send?','api_key=',_key);

  PERFORM http_post(
    _url,
    _payload,
    'application/json'
  );
EXCEPTION
  WHEN OTHERS THEN
    -- Handle errors appropriately
    RAISE;
END;
$$;

ALTER FUNCTION "engagements"."send_one_signal_push_notification"("title" "text", "body" "text", "campaign" "text", "image_url" "text", "data" "jsonb", "recipients" "uuid"[]) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "engagements"."send_order_update_notification"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    if new.type = 'order' then
    INSERT INTO engagements.notification(title, type, channel, body, user_id)
    VALUES (
        CONCAT('Order ', NEW.id, ' Update'), -- Title
        'order'::notification_type,          -- Type, assuming 'order' is a valid enum value
        'push',                              -- Channel
        CONCAT('Your order ', NEW.id, ' has been updated.'), -- Body, providing a more meaningful message
        NEW.customer_id                      -- User ID, assuming customer_id maps to the user who should receive the notification
    );
    end if;
    RETURN NEW;
END;
$$;

ALTER FUNCTION "engagements"."send_order_update_notification"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "engagements"."send_push_notification_on_insert"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF new.channel = 'push' THEN

    -- Send push notification
    PERFORM engagements.send_one_signal_push_notification(
        new.title,
        NEW.body,
        'EESUPOOLS',
        NULL,
        JSON_BUILD_OBJECT('eesupool_id', NEW.data ->>'eesupool_id')::jsonb,
        ARRAY_AGG(new.user_id)
    );

    END IF;

    RETURN NEW;
END;
$$;

ALTER FUNCTION "engagements"."send_push_notification_on_insert"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "finances"."balance_wallet_transactions"() RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
UPDATE finances.wallet
SET balance = COALESCE(
    (
        SELECT SUM(t.value)
        FROM finances.transaction t
        JOIN finances.wallet_transaction wt ON wt.transaction_id = t.id
        WHERE wt.wallet_id = finances.wallet.id
          AND t.is_deleted = false -- only consider transactions that are not deleted
          AND t.confirmed_at IS NOT NULL -- only consider confirmed transactions
          AND t.cancelled_at IS NULL -- exclude cancelled transactions
    ), 
    0 -- default to 0 if there are no transactions
);
END;
$$;

ALTER FUNCTION "finances"."balance_wallet_transactions"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "finances"."calculate_profit_share_and_withdrawal"("voucher_id" integer, "wallet_id" integer, "voucher_balance" numeric, "interest_rate" numeric, "voucher_value" numeric, "period_weeks" integer, "cycle" "finances"."voucher_cycle") RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    profit_share NUMERIC;
    withdrawal NUMERIC;
    closing_balance NUMERIC;
BEGIN

    IF cycle = 'Weekly' THEN
    
        profit_share := ROUND(voucher_balance * (interest_rate / 100), 2);
        withdrawal := ROUND((voucher_value / period_weeks), 2);
        closing_balance := ROUND((voucher_balance - withdrawal + profit_share), 2);

        IF withdrawal <= closing_balance THEN
            PERFORM finances.process_voucher_transactions(voucher_id, wallet_id,
            withdrawal, voucher_balance, profit_share, closing_balance);
        ELSE        
            PERFORM finances.process_voucher_transactions(voucher_id, wallet_id,
            closing_balance + withdrawal, voucher_balance, profit_share, 0.00);
        END IF;

    ELSIF cycle = 'Monthly' THEN

        profit_share := ROUND((voucher_balance * (interest_rate / 100)) * 4, 2);
        --because this is monthly the withdrawal  is counted in months period
        withdrawal := ROUND((voucher_value / (period_weeks/4)), 2);
        closing_balance := ROUND((voucher_balance - withdrawal + profit_share), 2);

        IF withdrawal <= closing_balance THEN
            PERFORM finances.process_voucher_transactions(voucher_id, wallet_id,
            withdrawal, voucher_balance, profit_share, closing_balance);
        ELSE     
            PERFORM finances.process_voucher_transactions(voucher_id, wallet_id,
            closing_balance + withdrawal, voucher_balance, profit_share, 0.00);
        END IF;

    ELSIF cycle ='Once-off' THEN

        profit_share := ROUND((voucher_balance * (interest_rate / 100)) * period_weeks, 2);
        withdrawal := voucher_balance + profit_share;
        closing_balance := 0.00;

        PERFORM finances.process_voucher_transactions(voucher_id, wallet_id,
        withdrawal, voucher_balance, profit_share, closing_balance);

    END IF;
END;
$$;

ALTER FUNCTION "finances"."calculate_profit_share_and_withdrawal"("voucher_id" integer, "wallet_id" integer, "voucher_balance" numeric, "interest_rate" numeric, "voucher_value" numeric, "period_weeks" integer, "cycle" "finances"."voucher_cycle") OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "finances"."check_voucher_payouts_cron_job_fun"() RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    vouchers RECORD;
    days_passed INTEGER;
BEGIN
    FOR vouchers IN (
        SELECT v.id, v.balance, v.cycle, v.value, (v.period * 4) AS period_in_weeks,
        vp.interest, v.wallet_id, v.confirmed_at, v.end_date
        FROM finances.voucher v
        JOIN finances.voucher_parameter vp ON v.parameter_id = vp.id
        WHERE v.balance > 0 AND v.confirmed_at IS NOT NULL
    )
    LOOP
        insert into public.test_table(value) values(concat('voucher ',vouchers.id));
        -- Calculate days passed since the voucher was confirmed
        days_passed := DATE_PART('day', CURRENT_DATE - vouchers.confirmed_at)::INTEGER;
        
        IF vouchers.cycle = 'Weekly' AND days_passed % 7 = 0 THEN
            -- Execute every 7 days
            PERFORM finances.calculate_profit_share_and_withdrawal(vouchers.id, vouchers.wallet_id, vouchers.balance,
            vouchers.interest, vouchers.value, vouchers.period_in_weeks,vouchers.cycle);

        ELSIF vouchers.cycle = 'Monthly' AND days_passed % 28 = 0 THEN
            -- Execute every 28 days
            PERFORM finances.calculate_profit_share_and_withdrawal(vouchers.id, vouchers.wallet_id, vouchers.balance,
            vouchers.interest, vouchers.value, vouchers.period_in_weeks,vouchers.cycle);

        ELSIF vouchers.cycle = 'Once-off' AND (vouchers.end_date <= CURRENT_DATE) THEN
            
            -- Execute when the end date is equal to now or has passed
            PERFORM finances.calculate_profit_share_and_withdrawal(vouchers.id, vouchers.wallet_id, vouchers.balance,
            vouchers.interest, vouchers.value, vouchers.period_in_weeks,vouchers.cycle);
       END IF;
    END LOOP;
END;
$$;

ALTER FUNCTION "finances"."check_voucher_payouts_cron_job_fun"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "finances"."confirm_voucher_eft"("reference" integer, "is_confirmed" boolean) RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
declare
trans_id record;
BEGIN
    IF is_confirmed THEN
        UPDATE finances.voucher SET confirmed_at = now(), cancelled_at = NULL WHERE id = reference;
        
        FOR trans_id IN 
            SELECT t.id 
            FROM finances.transaction t
            JOIN finances.voucher_ledger vl ON t.id = vl.transaction_id
            WHERE vl.voucher_id = reference
        LOOP
            UPDATE finances.transaction SET vested = TRUE, confirmed_at = now() WHERE id = trans_id.id;
        END LOOP;
        
    ELSIF NOT is_confirmed THEN
        UPDATE finances.voucher SET cancelled_at = now(), confirmed_at = NULL WHERE id = reference;
        
        FOR trans_id IN 
            SELECT t.id 
            FROM finances.transaction t
            JOIN finances.voucher_ledger vl ON t.id = vl.transaction_id
            WHERE vl.voucher_id = reference
        LOOP
            UPDATE finances.transaction SET vested = FALSE, cancelled_at = NULL WHERE id = trans_id.di;
        END LOOP;
    END IF;
END;
$$;

ALTER FUNCTION "finances"."confirm_voucher_eft"("reference" integer, "is_confirmed" boolean) OWNER TO "postgres";
drop FUNCTION "finances"."create_crowdfunding_voucher"("_user_id" "uuid", "_parameter_id" "uuid", "_value" numeric, "_cycle" "finances"."voucher_cycle", "_period" integer, "_end_date" timestamp with time zone);
CREATE OR REPLACE FUNCTION "finances"."create_crowdfunding_voucher"("_user_id" "uuid", "_parameter_id" "uuid", "_value" numeric, "_cycle" "finances"."voucher_cycle", "_period" integer, "_end_date" timestamp with time zone) RETURNS "record"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    voucher_id integer;
    user_retail_wallet integer;
    user_crowdfund_wallet integer;
    trans_id integer;
    _payment record;
BEGIN
    -- Find user's retail wallet ID
    SELECT id INTO user_retail_wallet FROM finances.wallet WHERE user_id = _user_id AND type='retail';

    -- Find user's crowdfund wallet ID
    SELECT id INTO user_crowdfund_wallet FROM finances.wallet WHERE user_id = _user_id AND type='crowdfund';

    -- Insert into voucher and return the new voucher ID
    INSERT INTO finances.voucher (
        wallet_id, parameter_id, balance, value, cycle, period, end_date
    ) VALUES (
        user_crowdfund_wallet, _parameter_id, _value, _value, _cycle, _period, _end_date
    ) RETURNING id INTO voucher_id;

    -- Create a wallet transaction for crowdfund voucher payment
    SELECT finances.create_wallet_transaction(user_crowdfund_wallet, 'CFV', _value, false, concat('Crowdfund Voucher Payment #-', voucher_id))
    INTO trans_id;

    PERFORM finances.create_voucher_ledger_transaction(voucher_id, trans_id, NULL, NULL, NULL, _value);

    --create payment row
    INSERT INTO finances.online_payment(reference_id,amount,user_id,type)
    values(voucher_id, _value, _user_id, 'Voucher')
    returning payment_id, secondary_id INTO _payment;

    return (voucher_id, _value, _payment.payment_id, _payment.secondary_id);
END;
$$;

ALTER FUNCTION "finances"."create_crowdfunding_voucher"("_user_id" "uuid", "_parameter_id" "uuid", "_value" numeric, "_cycle" "finances"."voucher_cycle", "_period" integer, "_end_date" timestamp with time zone) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "finances"."create_order_transaction"("_order_id" integer, "_trans_id" integer) RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
 insert into sales.order_transaction(order_id, transaction_id)
 values(_order_id,_trans_id);
END;
$$;

ALTER FUNCTION "finances"."create_order_transaction"("_order_id" integer, "_trans_id" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "finances"."create_transaction"("_type" "text", "_value" numeric, "_vested" boolean, "_description" "text") RETURNS integer
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    _new_trans_id INTEGER;
BEGIN
        INSERT INTO finances.transaction(type, value, vested, description)
        VALUES(_type, _value, _vested, _description) RETURNING id INTO _new_trans_id;

    RETURN _new_trans_id;
END;
$$;

ALTER FUNCTION "finances"."create_transaction"("_type" "text", "_value" numeric, "_vested" boolean, "_description" "text") OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "finances"."create_user_wallets"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    _type text;
BEGIN
    FOR _type IN SELECT wt.id FROM finances.wallet_type wt
    WHERE new.role = ANY(wt.roles)
    LOOP
        INSERT INTO finances.wallet(type, user_id, balance)
        VALUES (_type, NEW.user_id, 0.00);
    END LOOP;

    RETURN NEW;
END;
$$;

ALTER FUNCTION "finances"."create_user_wallets"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "finances"."create_voucher_ledger_transaction"("_voucher_id" integer, "_transaction_id" integer, "_opening_balance" numeric, "_payout" numeric, "_profit_share" numeric, "_closing_balance" numeric) RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    INSERT INTO finances.voucher_ledger (
        voucher_id,
        transaction_id,
        opening_balance,
        payout,
        profit_share,
        closing_balance
    ) VALUES (
        _voucher_id,
        _transaction_id,
        _opening_balance,
        _payout,
        _profit_share,
        _closing_balance
    );
END;
$$;

ALTER FUNCTION "finances"."create_voucher_ledger_transaction"("_voucher_id" integer, "_transaction_id" integer, "_opening_balance" numeric, "_payout" numeric, "_profit_share" numeric, "_closing_balance" numeric) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "finances"."create_wallet_transaction"("_wallet_id" integer, "_type" "text", "_value" numeric, "_vested" boolean, "_description" "text") RETURNS integer
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    _new_trans_id INTEGER;
BEGIN

    select * from finances.create_transaction(_type, _value,_vested,_description)
    into _new_trans_id;

    --insert to wallet finances.transaction bridge
    insert into finances.wallet_transaction(wallet_id, transaction_id)
    values(_wallet_id,_new_trans_id);

    IF _vested = true THEN
         update finances.transaction set vested = true, confirmed_at = NOW()
         where id =_new_trans_id;
    END IF;

    RETURN _new_trans_id;
END;
$$;

ALTER FUNCTION "finances"."create_wallet_transaction"("_wallet_id" integer, "_type" "text", "_value" numeric, "_vested" boolean, "_description" "text") OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "finances"."generate_payment_secondary_id"() RETURNS "text"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
  id text;
  new_id text;
  max_recursion_depth INTEGER := 50;
  recursion_count INTEGER := 0; 
BEGIN
  SELECT finances.generate_random_string(17) INTO id; 
  new_id := concat('EES', id);

  LOOP
    IF EXISTS (SELECT 1 FROM finances.online_payment WHERE secondary_id = new_id) THEN
      recursion_count := recursion_count + 1;

      IF recursion_count > max_recursion_depth THEN
         RAISE EXCEPTION 'Maximum recursion depth exceeded when generating secondary ID'; 
      END IF;

      new_id := finances.generate_payment_secondary_id();  
    ELSE
      EXIT;
    END IF;
  END LOOP;

  RETURN new_id; 
END;
$$;

ALTER FUNCTION "finances"."generate_payment_secondary_id"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "finances"."generate_random_string"("length" integer) RETURNS "text"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
  characters TEXT := 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  random_string TEXT := '';
  i INT;
BEGIN
  FOR i IN 1..length LOOP
   random_string := random_string || substring(characters FROM floor(random() * 62 + 1)::int FOR 1);
  END LOOP;

  RETURN random_string;
END;
$$;

ALTER FUNCTION "finances"."generate_random_string"("length" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "finances"."generate_transaction_doc_ref"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  DECLARE
    max_ref INT;
    new_ref INT;
  BEGIN
    -- Initialize
    max_ref := 0;
    -- Get the max doc_ref for the current transaction type
    SELECT COALESCE(MAX(doc_ref), 0) INTO max_ref FROM finances.transaction WHERE type = NEW.type;

    -- Increment the max_ref to get new reference
    new_ref := max_ref + 1;

    -- Set the new reference to new row
    NEW.doc_ref := new_ref;

    -- Return the modified row
    RETURN NEW;
  END;
END;
$$;

ALTER FUNCTION "finances"."generate_transaction_doc_ref"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "finances"."get_user_wallets"("_user_id" "uuid") RETURNS TABLE("id" integer, "user_id" "uuid", "balance" numeric, "type_id" "text", "description" "text", "created_at" timestamp with time zone, "type_created_at" timestamp with time zone, "withdrawals" boolean, "deposits" boolean, "transfers" boolean, "shopping" boolean, "is_active" boolean, "require_rsa_id" boolean, "sort_num" integer)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY 
    SELECT 
        w.id,
        w.user_id,
        w.balance,
        wt.id,
        wt.description,
        w.created_at,
        wt.created_at,
        wt.withdrawls,
        wt.deposits,
        wt.transfers,
        wt.shopping,
        wt.is_active,
        wt.require_rsa_id,
        wt.sort_num
    FROM 
        finances.wallet w
    JOIN 
        finances.wallet_type wt
    ON 
        w.type = wt.id
    WHERE 
        w.user_id = _user_id AND wt.is_active;
END; $$;

ALTER FUNCTION "finances"."get_user_wallets"("_user_id" "uuid") OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "finances"."get_voucher_transactions"("_voucher_id" integer, "limit_to" integer) RETURNS TABLE("type" "text", "doc_ref" integer, "value" numeric, "vested" boolean, "description" "text", "created_at" timestamp with time zone, "confirmed_at" timestamp with time zone, "cancelled_at" timestamp with time zone, "id" integer)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        t.type, 
        t.doc_ref, 
        t.value, 
        t.vested, 
        t.description, 
        t.created_at, 
        t.confirmed_at, 
        t.cancelled_at,
        t.id
    FROM 
        finances.transaction t
    INNER JOIN 
        finances.voucher_ledger vl on t.id = vl.transaction_id
    WHERE 
        vl.voucher_id = _voucher_id AND t.is_deleted IS NOT TRUE AND t.confirmed_at is not null
    limit limit_to;
END; 
$$;

ALTER FUNCTION "finances"."get_voucher_transactions"("_voucher_id" integer, "limit_to" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "finances"."get_wallet_transactions"("_wallet_id" integer, "limit_to" integer) RETURNS TABLE("type" "text", "doc_ref" integer, "value" numeric, "vested" boolean, "description" "text", "created_at" timestamp with time zone, "confirmed_at" timestamp with time zone, "cancelled_at" timestamp with time zone, "id" integer)
    LANGUAGE "plpgsql"
    AS $$BEGIN
    RETURN QUERY
    SELECT 
        t.type, 
        t.doc_ref, 
        t.value, 
        t.vested, 
        t.description, 
        t.created_at, 
        t.confirmed_at, 
        t.cancelled_at,
        t.id
    FROM 
        finances.transaction t
    INNER JOIN 
        finances.wallet_transaction wt 
    ON 
        t.id = wt.transaction_id
    WHERE 
        wt.wallet_id = _wallet_id AND t.is_deleted IS NOT TRUE
    ORDER BY t.created_at DESC
    limit limit_to;
END;$$;

ALTER FUNCTION "finances"."get_wallet_transactions"("_wallet_id" integer, "limit_to" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "finances"."on_payment_confirmed"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
begin
IF new.status = 'Complete' AND new.confirmed_at IS NOT NULL THEN
  IF new.type = 'Order' THEN
    PERFORM sales.place_confirmed_order(new.reference_id, true);
  ELSIF new.type = 'Voucher' THEN
    PERFORM finances.confirm_voucher_eft(new.reference_id, true);
  END IF;
END IF;
return NEW;
END;
$$;

ALTER FUNCTION "finances"."on_payment_confirmed"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "finances"."on_unverified_prevent_income_wallet_txn_confirmations"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN

  --make sure that the use is verified before confirming any
  --transactions on the wealth wallet
  IF EXISTS (
    SELECT 1
    FROM public.profile p
    JOIN finances.wallet w ON p.user_id = w.user_id
    JOIN finances.wallet_transaction wt ON w.id = wt.wallet_id
    WHERE wt.transaction_id = NEW.id AND p.is_verified = false AND w.type = 'income'
  ) THEN
    NEW.vested := false;
    NEW.confirmed_at := null;
  END IF;

  RETURN NEW;
END;
$$;

ALTER FUNCTION "finances"."on_unverified_prevent_income_wallet_txn_confirmations"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "finances"."process_voucher_transactions"("voucher_id" integer, "crowd_fund_wallet_id" integer, "withdrawal_amount" numeric, "opening_balance" numeric, "profit_share" numeric, "closing_balance" numeric) RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    transaction_id INTEGER;
    retail_wallet INTEGER;
BEGIN

    SELECT w2.id INTO retail_wallet FROM finances.wallet w1 
    JOIN finances.wallet w2 ON w1.user_id = w2.user_id WHERE w1.id = crowd_fund_wallet_id
    AND w2.type='retail';

    --transfer the withdrawal to the retail wallet
    SELECT * FROM finances.create_wallet_transaction(
        retail_wallet, 'CFV', withdrawal_amount, true, concat('Voucher ', voucher_id,' withdrawal')
    ) INTO transaction_id;

    --create ledger transaction
    PERFORM finances.create_voucher_ledger_transaction(
        voucher_id,
        transaction_id,
        opening_balance,
        -withdrawal_amount,
        profit_share,
        closing_balance
    );

    --set new voucher balance
    UPDATE finances.voucher SET balance = closing_balance WHERE id = voucher_id;

    --update the voucher wallet balance
    UPDATE finances.wallet SET balance = closing_balance WHERE id = crowd_fund_wallet_id;

END;
$$;

ALTER FUNCTION "finances"."process_voucher_transactions"("voucher_id" integer, "crowd_fund_wallet_id" integer, "withdrawal_amount" numeric, "opening_balance" numeric, "profit_share" numeric, "closing_balance" numeric) OWNER TO "postgres";


drop FUNCTION "finances"."search_transfer_beneficiary"("query_str" "text", "wallet_type" "text");

CREATE OR REPLACE FUNCTION "finances"."search_transfer_beneficiary"("query_str" "text", "wallet_type" "text") RETURNS TABLE("user_id" "uuid", "description" "text", "full_name" "text", "corp_name" "text", "wallet_id" integer)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        p.user_id,
        wt.description,
        (p.first_name || ' ' || p.last_name) AS full_name,
        p.corp_name,
        w.id AS wallet_id
    FROM
        public.profile p
    JOIN
        finances.wallet w ON p.user_id = w.user_id
    JOIN
        finances.wallet_type wt ON w.type = wt.id
    WHERE
        (p.first_name ILIKE '%' || query_str || '%'
        OR p.last_name ILIKE '%' || query_str || '%'
        OR p.corp_name ILIKE '%' || query_str || '%'
        OR p.referral_code::text ILIKE '%' || query_str || '%') AND
    w.type = wallet_type;
END;
$$;

ALTER FUNCTION "finances"."search_transfer_beneficiary"("query_str" "text", "wallet_type" "text") OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "finances"."transfer_funds_wallet_to_wallet"("to_wallet_id" integer, "from_wallet_id" integer, "to_ref" "text", "from_ref" "text", "amount" numeric) RETURNS integer
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    trans_id_to INTEGER;
    trans_id_from INTEGER;
BEGIN
        -- Create a transaction for withdrawing from the from_wallet
        SELECT INTO trans_id_from finances.create_wallet_transaction(from_wallet_id, 'TRF', -amount, TRUE, from_ref);

        -- Create a transaction for depositing into the to_wallet
        SELECT INTO trans_id_to finances.create_wallet_transaction(to_wallet_id, 'TRF', amount, TRUE, to_ref);
    RETURN trans_id_to;
END;
$$;

ALTER FUNCTION "finances"."transfer_funds_wallet_to_wallet"("to_wallet_id" integer, "from_wallet_id" integer, "to_ref" "text", "from_ref" "text", "amount" numeric) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "finances"."update_wallet_balance_on_txn_confirmed"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    _wallet_id INTEGER;
    _balance numeric;
    _new_balance  numeric;
BEGIN

    SELECT wallet_id INTO _wallet_id
    FROM finances.wallet_transaction wtxn 
    WHERE wtxn.transaction_id = NEW.id;
    

    IF _wallet_id IS NOT NULL THEN

    IF NEW.vested = TRUE AND NEW.confirmed_at IS NOT NULL
    AND NEW.cancelled_at IS NULL AND NEW.is_deleted = false THEN
          
        SELECT balance into _balance from finances.wallet
        WHERE id = _wallet_id;

        _new_balance := _balance + NEW.value;

        -- Update statement as before
        UPDATE finances.wallet
        SET balance = _new_balance
        WHERE id = _wallet_id;

    END IF;

    RETURN NEW;
END;
$$;

ALTER FUNCTION "finances"."update_wallet_balance_on_txn_confirmed"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "geolocations"."calculate_distance_between_2_locations"("lat1" double precision, "lon1" double precision, "lat2" double precision, "lon2" double precision) RETURNS double precision
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    r FLOAT := 6371; -- Earth radius in kilometers
    phi1 FLOAT;
    phi2 FLOAT;
    delta_phi FLOAT;
    delta_lambda FLOAT;
    a FLOAT;
    c FLOAT;
BEGIN
    -- Convert latitude and longitude from degrees to radians
    phi1 := radians(lat1);
    phi2 := radians(lat2);
    delta_phi := radians(lat2 - lat1);
    delta_lambda := radians(lon2 - lon1);

    -- Haversine formula
    a := sin(delta_phi / 2) * sin(delta_phi / 2) +
         cos(phi1) * cos(phi2) *
         sin(delta_lambda / 2) * sin(delta_lambda / 2);
    c := 2 * atan2(sqrt(a), sqrt(1 - a));

    -- Distance in kilometers
    RETURN r * c;
END;
$$;

ALTER FUNCTION "geolocations"."calculate_distance_between_2_locations"("lat1" double precision, "lon1" double precision, "lat2" double precision, "lon2" double precision) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "geolocations"."get_address_by_id"("address_id" integer) RETURNS TABLE("area_id" integer, "user_id" "uuid", "recipient_name" "text", "recipient_phone" "text", "street_address" "text", "building_name" "text", "type" "text", "province" "text", "latitude" numeric, "longitude" numeric, "created_at" timestamp with time zone, "is_primary" boolean, "id" integer)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        a.area_id,
         a.user_id,
         a.recipient_name,
         a.recipient_phone,
         a.street_address,
         a.building_name,
         a.type,
         a.province,
         a.latitude,
         a.longitude,
         a.created_at,
         a.is_primary,
         a.id
    FROM geolocations.address a
    WHERE a.id = address_id;
END;
$$;

ALTER FUNCTION "geolocations"."get_address_by_id"("address_id" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "geolocations"."verify_address"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    area RECORD;
    distance FLOAT;
BEGIN
    IF  NEW.latitude is not null AND NEW.longitude is not null  AND NEW.area_id isnull THEN
    -- Loop through each target area
    FOR area IN SELECT ta.id, ta.center_latitude, ta.center_longitude, ta.area_radius
                FROM geolocations.target_area ta where ta.is_active = true
    LOOP
        -- Calculate the distance
        SELECT geolocations.calculate_distance_between_2_locations(
            NEW.latitude, NEW.longitude,
            area.center_latitude, area.center_longitude
        ) INTO distance;

        -- Check if the distance is within the area radius
        IF distance <= area.area_radius THEN
        --update the area column before the action
            new.area_id = area.id;
         RETURN NEW;
        END IF;
    END LOOP;

    END IF;

    -- Return the new record if no update is made
    RETURN NEW;
END;
$$;

ALTER FUNCTION "geolocations"."verify_address"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "inventory"."get_all_categories"() RETURNS TABLE("id" integer, "name" "text", "image_url" "text", "parent_id" integer, "products" integer)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY 
    SELECT 
        c.id, 
        c.name, 
        c.image_url, 
        c.parent_id,
        CAST(COUNT(p.id) AS integer) AS products
    FROM inventory.category c
    LEFT JOIN inventory.product p ON c.id = p.category_id
    WHERE c.is_active = true AND c.parent_id isnull
    GROUP BY c.id, c.name, c.image_url, c.parent_id;
END;
$$;

ALTER FUNCTION "inventory"."get_all_categories"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "inventory"."get_category_descendants"("p_cat_id" integer) RETURNS TABLE("id" integer, "name" "text", "image_url" "text", "parent_id" integer, "products" integer)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY WITH RECURSIVE all_categories AS (
        SELECT pc.id, pc.name, pc.image_url, pc.parent_id
        FROM inventory.category pc
        WHERE pc.id = p_cat_id
        UNION ALL
        SELECT c.id, c.name, c.image_url, c.parent_id
        FROM inventory.category c
        INNER JOIN all_categories ac ON c.parent_id = ac.id
    )
    SELECT 
        ac.id,
        ac.name,
        ac.image_url,
        ac.parent_id,
        CAST(COUNT(p.id) AS integer) AS products
    FROM all_categories ac
    LEFT JOIN inventory.product p ON ac.id = p.category_id
    WHERE ac.id != p_cat_id
    GROUP BY ac.id, ac.name, ac.image_url, ac.parent_id;
END;
$$;

ALTER FUNCTION "inventory"."get_category_descendants"("p_cat_id" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "inventory"."get_product"("_id" integer) RETURNS TABLE("id" integer, "category_id" integer, "name" "text", "description" "text", "image_url" "text", "size" "text", "brand" "text", "type" "text", "uom" "text", "unit_pack_size" "text", "flavour" "text", "sale_price" numeric, "cost_price" numeric, "vaa" numeric, "vat" numeric, "order_max" integer, "child_id" integer, "child_break_qty" integer, "bar_code" "text", "kit_kat_ref" "text", "vat_claimable" boolean, "vat_able" boolean, "class" "inventory"."product_class", "category_name" "text", "category_image_url" "text", "sellable" boolean)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY 
    SELECT
        p.id,
        p.category_id,
        p.name,
        p.description,
        p.image_url,
        p.size,
        p.brand,
        p.type,
        p.uom,
        p.unit_pack_size,
        p.flavour,
        p.sale_price,
        p.cost_price,
        p.vaa,
        p.vat,
        p.order_max,
        p.child_id,
        p.child_break_qty,
        p.bar_code,
        p.kit_kat_ref,
        p.vat_claimable,
        p.vat_able,
        p.class,
        c.name,
        c.image_url AS category_image_url,
        p.sellable
    FROM inventory.product p
    INNER JOIN inventory.category c ON p.category_id = c.id
    WHERE  p.id = _id
    LIMIT 1;
END; $$;

ALTER FUNCTION "inventory"."get_product"("_id" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "inventory"."get_products_by_category"("cat_id" integer, "role" "public"."user_role", "limit_to" integer) RETURNS TABLE("id" integer, "category_id" integer, "name" "text", "description" "text", "image_url" "text", "size" "text", "brand" "text", "type" "text", "uom" "text", "unit_pack_size" "text", "flavour" "text", "sale_price" numeric, "cost_price" numeric, "vaa" numeric, "vat" numeric, "order_max" integer, "child_id" integer, "child_break_qty" integer, "bar_code" "text", "kit_kat_ref" "text", "vat_claimable" boolean, "vat_able" boolean, "class" "inventory"."product_class", "category_name" "text", "category_image_url" "text", "sellable" boolean)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY WITH RECURSIVE all_categories AS (
        SELECT c.id AS ac_category_id, c.name AS ac_category_name FROM inventory.category c WHERE c.id = cat_id
        UNION ALL
        SELECT c.id AS ac_category_id, c.name AS ac_category_name FROM inventory.category c
        INNER JOIN all_categories ac ON c.parent_id = ac.ac_category_id
    )
    SELECT
        p.id,
        p.category_id,
        p.name,
        p.description,
        p.image_url,
        p.size,
        p.brand,
        p.type,
        p.uom,
        p.unit_pack_size,
        p.flavour,
        p.sale_price,
        p.cost_price,
        p.vaa,
        p.vat,
        p.order_max,
        p.child_id,
        p.child_break_qty,
        p.bar_code,
        p.kit_kat_ref,
        p.vat_claimable,
        p.vat_able,
        p.class,
        ac.ac_category_name,
        c.image_url AS category_image_url,
        p.sellable
    FROM
        inventory.product p
    INNER JOIN all_categories ac ON p.category_id = ac.ac_category_id
    INNER JOIN inventory.category c ON p.category_id = c.id
    WHERE
        p.is_active = true AND role = ANY(p.roles) AND p.sale_price > 0
    LIMIT limit_to;
END; $$;

ALTER FUNCTION "inventory"."get_products_by_category"("cat_id" integer, "role" "public"."user_role", "limit_to" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "inventory"."get_random_category"() RETURNS TABLE("id" integer, "parent_id" integer, "name" "text", "image_url" "text")
    LANGUAGE "sql"
    AS $$
SELECT id, parent_id, name, image_url FROM inventory.category
ORDER BY random()
LIMIT 1;
$$;

ALTER FUNCTION "inventory"."get_random_category"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "inventory"."get_random_products"("role" "public"."user_role", "limit_to" integer) RETURNS TABLE("id" integer, "category_id" integer, "name" "text", "description" "text", "image_url" "text", "size" "text", "brand" "text", "type" "text", "uom" "text", "unit_pack_size" "text", "flavour" "text", "sale_price" numeric, "cost_price" numeric, "vaa" numeric, "vat" numeric, "order_max" integer, "child_id" integer, "child_break_qty" integer, "bar_code" "text", "kit_kat_ref" "text", "vat_claimable" boolean, "vat_able" boolean, "class" "inventory"."product_class", "category_name" "text", "category_image_url" "text", "sellable" boolean)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY 
    SELECT
        p.id,
        p.category_id,
        p.name,
        p.description,
        p.image_url,
        p.size,
        p.brand,
        p.type,
        p.uom,
        p.unit_pack_size,
        p.flavour,
        p.sale_price,
        p.cost_price,
        p.vaa,
        p.vat,
        p.order_max,
        p.child_id,
        p.child_break_qty,
        p.bar_code,
        p.kit_kat_ref,
        p.vat_claimable,
        p.vat_able,
        p.class,
        c.name,
        c.image_url AS category_image_url,
        p.sellable
    FROM inventory.product p
    INNER JOIN inventory.category c ON p.category_id = c.id
    WHERE  p.is_active = true AND role = ANY(p.roles) AND p.sale_price > 0
    ORDER BY random()
    LIMIT limit_to;
END; $$;

ALTER FUNCTION "inventory"."get_random_products"("role" "public"."user_role", "limit_to" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "inventory"."search_categories"("query_str" "text") RETURNS TABLE("id" integer, "name" "text", "image_url" "text", "parent_id" integer, "products" integer)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY 
    SELECT 
        c.id, 
        c.name, 
        c.image_url, 
        c.parent_id,
        CAST(COUNT(p.id) AS integer) AS products
    FROM inventory.category c
    LEFT JOIN inventory.product p ON c.id = p.category_id
    WHERE c.name ILIKE '%' || query_str || '%'
    GROUP BY c.id, c.name, c.image_url, c.parent_id;
END;
$$;

ALTER FUNCTION "inventory"."search_categories"("query_str" "text") OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "inventory"."search_products"("query_str" "text", "role" "public"."user_role", "limit_to" integer) RETURNS TABLE("id" integer, "category_id" integer, "name" "text", "description" "text", "image_url" "text", "size" "text", "brand" "text", "type" "text", "uom" "text", "unit_pack_size" "text", "flavour" "text", "sale_price" numeric, "cost_price" numeric, "vaa" numeric, "vat" numeric, "order_max" integer, "child_id" integer, "child_break_qty" integer, "bar_code" "text", "kit_kat_ref" "text", "vat_claimable" boolean, "vat_able" boolean, "class" "inventory"."product_class", "category_name" "text", "category_image_url" "text", "sellable" boolean)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        p.id,
        p.category_id,
        p.name,
        p.description,
        p.image_url,
        p.size,
        p.brand,
        p.type,
        p.uom,
        p.unit_pack_size,
        p.flavour,
        p.sale_price,
        p.cost_price,
        p.vaa,
        p.vat,
        p.order_max,
        p.child_id,
        p.child_break_qty,
        p.bar_code,
        p.kit_kat_ref,
        p.vat_claimable,
        p.vat_able,
        p.class,
        c.name AS category_name,
        c.image_url AS category_image_url,
        p.sellable
    FROM
        inventory.product p
    INNER JOIN inventory.category c ON p.category_id = c.id
    WHERE
       p.is_active = true AND role = ANY(p.roles) AND
        (
            p.name ILIKE '%' || query_str || '%' OR
            p.description ILIKE '%' || query_str || '%' OR
            p.brand ILIKE '%' || query_str || '%' OR
            p.flavour ILIKE '%' || query_str || '%' OR
            p.size ILIKE '%' || query_str || '%' OR
            p.class::text ILIKE '%' || query_str || '%' OR
            p.type ILIKE '%' || query_str || '%' OR
            c.name ILIKE '%' || query_str || '%'
        )
    Limit limit_to;
END; $$;

ALTER FUNCTION "inventory"."search_products"("query_str" "text", "role" "public"."user_role", "limit_to" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "inventory"."search_products_and_categories"("query_str" "text", "role" "public"."user_role", "limit_to" integer) RETURNS TABLE("products" "jsonb", "categories" "jsonb")
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY SELECT  
        COALESCE((SELECT jsonb_agg(t) 
                  FROM (SELECT * FROM inventory.search_products(query_str, role, limit_to)
                  ) t), '[]'::jsonb) AS products,
        COALESCE((SELECT jsonb_agg(t) 
                  FROM (SELECT * FROM inventory.search_categories(query_str)
                  ) t), '[]'::jsonb) AS categories;
END;
$$;

ALTER FUNCTION "inventory"."search_products_and_categories"("query_str" "text", "role" "public"."user_role", "limit_to" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."add_product_to_basket"("_basket_id" "uuid", "_product_id" integer) RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM public.basket_product WHERE basket_id = _basket_id AND product_id = _product_id) THEN
        UPDATE public.basket_product
        SET quantity = quantity + 1
        WHERE basket_id = _basket_id AND product_id = _product_id;
    ELSE
        INSERT INTO public.basket_product(basket_id, product_id, quantity)
        VALUES (_basket_id, _product_id, 1);
    END IF;
END;
$$;

ALTER FUNCTION "public"."add_product_to_basket"("_basket_id" "uuid", "_product_id" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."change_referral"("old_referrer_user_id" "uuid", "new_referrer_user_id" "uuid", "referred_user_id" "uuid") RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    referral_rec RECORD;
    new_wallet_id INTEGER;
    old_wallet_id INTEGER;
    transaction_amount NUMERIC;
BEGIN
    -- Step 1: Update the referral
    UPDATE public.referral
    SET referrer_user_id = new_referrer_user_id
    WHERE referrer_user_id = old_referrer_user_id AND refereed_user_id = referred_user_id;

    -- Step 2: Identify the transaction_id and completion status associated with the updated referral
    -- Ensure the SELECT ... INTO is correctly fetching a row into the record variable
    SELECT transaction_id, is_completed INTO referral_rec FROM public.referral
    WHERE referrer_user_id = new_referrer_user_id AND refereed_user_id = referred_user_id;

    -- Step 3: Get old and new referrer's wallet ID, assuming each user has one 'wealth' type wallet
    SELECT id INTO old_wallet_id FROM finances.wallet WHERE user_id = old_referrer_user_id AND type = 'wealth';
    SELECT id INTO new_wallet_id FROM finances.wallet WHERE user_id = new_referrer_user_id AND type = 'wealth';

    -- Step 4: Update the wallet_transaction to reflect the new referrer
    UPDATE finances.wallet_transaction
    SET wallet_id = new_wallet_id
    WHERE transaction_id = referral_rec.transaction_id AND wallet_id = old_wallet_id;

    -- Step 5: Assuming transaction amount needs to be transferred from old to new referrer's wallet
    -- Get the transaction amount
    SELECT value INTO transaction_amount FROM finances.transaction WHERE id = referral_rec.transaction_id;

    -- Step 6: If the referral is marked as completed, transfer the amount
    IF referral_rec.is_completed THEN
        -- Deduct the amount from the old referrer's wallet
        UPDATE finances.wallet
        SET balance = balance - transaction_amount
        WHERE id = old_wallet_id;

        -- Add the amount to the new referrer's wallet
        UPDATE finances.wallet
        SET balance = balance + transaction_amount
        WHERE id = new_wallet_id;
    END IF;
END;
$$;

ALTER FUNCTION "public"."change_referral"("old_referrer_user_id" "uuid", "new_referrer_user_id" "uuid", "referred_user_id" "uuid") OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."check_and_update_verification"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    -- Check if the user's RSA ID number is null in 'profile'
    IF EXISTS (
            SELECT 1
            FROM public.profile p 
            WHERE p.user_id = NEW.user_id 
            AND p.rsa_id_number IS NOT NULL
            AND  is_verified = FALSE
        ) THEN
    -- Check if the user has a primary address in 'geolocations.address'
    IF EXISTS (
        SELECT 1 
        FROM geolocations.address a 
        WHERE a.user_id = NEW.user_id 
        AND a.area_id IS NOT NULL 
        AND a.is_primary = TRUE
    ) THEN
            -- Update 'profile' to set 'is_verified' = true if conditions are met
            UPDATE public.profile 
            SET is_verified = TRUE 
            WHERE user_id = NEW.user_id;
        END IF;
    END IF;

    RETURN NEW;
END;
$$;

ALTER FUNCTION "public"."check_and_update_verification"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."check_if_referral_is_complete"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    _trans_id integer;
    _is_completed boolean;
BEGIN
    -- Retrieve the 'is_completed' status for the referral
    SELECT is_completed INTO _is_completed FROM referral
    WHERE refereed_user_id = NEW.user_id;

    -- Proceed only if the referral is not already marked as completed
    IF _is_completed = false THEN
        -- Check if the user has an address in 'geolocations.address'
        IF EXISTS (SELECT 1 FROM geolocations.address a WHERE
         a.user_id = NEW.user_id AND a.area_id is not null AND a.is_primary = true) THEN
            -- Check if the user's RSA ID number is null in 'profile'
            IF EXISTS (SELECT 1 FROM profile p WHERE p.user_id = NEW.user_id AND p.rsa_id_number IS NULL) THEN
                -- Retrieve the transaction ID for the referral
                SELECT transaction_id INTO _trans_id FROM referral WHERE refereed_user_id = NEW.user_id;

                -- Update the transaction as vested
                UPDATE finances.transaction SET vested = true, confirmed_at = now() WHERE id = _trans_id;
                
                -- Mark the referral as completed
                UPDATE referral SET is_completed = true WHERE refereed_user_id = NEW.user_id;
            END IF;
        END IF;
    END IF;

    RETURN NULL; -- Since it's a trigger function
END;
$$;

ALTER FUNCTION "public"."check_if_referral_is_complete"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."create_user_default_basket"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    INSERT INTO public.basket(user_id,name,type)
    VALUES(new.user_id,'My Basket','Monthly');
    RETURN NEW;
END;
$$;

ALTER FUNCTION "public"."create_user_default_basket"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."get_basket_products"("_basket_id" "uuid") RETURNS TABLE("basket_id" "uuid", "product_id" integer, "image_url" "text", "category" "text", "name" "text", "quantity" integer, "price" numeric, "size" "text", "class" "inventory"."product_class")
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY 
    SELECT
        bp.basket_id,
        bp.product_id,
        p.image_url,
        c.name AS category,
        p.name,
        bp.quantity,
        p.sale_price AS price,
        p.size,
        p.class
    FROM
        public.basket_product AS bp
        JOIN inventory.product AS p ON bp.product_id = p.id
        JOIN inventory.category AS c ON p.category_id = c.id
    WHERE
        bp.basket_id = _basket_id;
END;
$$;

ALTER FUNCTION "public"."get_basket_products"("_basket_id" "uuid") OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."get_basket_products_v2"("_basket_id" "uuid") RETURNS TABLE("basket_id" "uuid", "product_id" integer, "image_url" "text", "category" "text", "name" "text", "quantity" integer, "price" numeric, "size" "text", "class" "inventory"."product_class", "substitute_brand" boolean, "substitute_variant" boolean, "sellable" boolean)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY 
    SELECT
        bp.basket_id,
        bp.product_id,
        p.image_url,
        c.name AS category,
        p.name,
        bp.quantity,
        p.sale_price AS price,
        p.size,
        p.class,
        bp.substitute_brand,
        bp.substitute_variant,
        p.sellable
    FROM
        public.basket_product AS bp
        JOIN inventory.product AS p ON bp.product_id = p.id
        JOIN inventory.category AS c ON p.category_id = c.id
    WHERE
        bp.basket_id = _basket_id;
END;
$$;

ALTER FUNCTION "public"."get_basket_products_v2"("_basket_id" "uuid") OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."get_referrals_by_referrer"("_user_id" "uuid", "_limit_to" integer) RETURNS TABLE("referrer_user_id" "uuid", "refereed_user_id" "uuid", "refereed_full_name" "text", "created_at" timestamp with time zone, "transaction_id" integer, "is_completed" boolean)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY 
    SELECT 
        r.referrer_user_id,
        r.refereed_user_id,
        COALESCE(
            CASE 
                WHEN p.first_name IS NOT NULL AND p.last_name IS NOT NULL THEN p.first_name || ' ' || p.last_name
                ELSE p.corp_name
            END,
            'Unknown Name'
        ) AS refereed_full_name,
        r.created_at,
        r.transaction_id,
        r.is_completed
    FROM 
        public.referral r
    JOIN 
        public.profile p ON r.refereed_user_id = p.user_id
    WHERE 
        r.referrer_user_id = _user_id
    LIMIT _limit_to;
END;
$$;

ALTER FUNCTION "public"."get_referrals_by_referrer"("_user_id" "uuid", "_limit_to" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."handle_new_referral"("referee_id" "uuid", "ref_code" integer, "full_name" "text", "is_confirmed" boolean) RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    referrer_id UUID;
    wallet_id INTEGER;
    transaction_id INTEGER;
BEGIN
    -- Get referrer ID from profile using referral code
    SELECT user_id INTO referrer_id 
    FROM public.profile 
    WHERE referral_code = ref_code;

    IF NOT EXISTS (SELECT 1 FROM public.referral WHERE refereed_user_id = referee_id AND referrer_user_id = referrer_id) THEN

    -- Check if referrer_id was found
    IF referrer_id IS NULL THEN
        -- Handle the case where the referrer is not found, e.g., raise an exception or exit
        RAISE EXCEPTION 'Referrer not found for referral code %', ref_code;
    END IF;

    -- Get referrer's retail wallet ID
    SELECT id INTO wallet_id 
    FROM finances.wallet 
    WHERE user_id = referrer_id AND type = 'wealth';

    -- Check if wallet_id was found
    IF wallet_id IS NULL THEN
        SELECT text_value::INTEGER INTO wallet_id FROM system_configs.remote_config
        WHERE id = 'master_referral_wallet_id';
    END IF;

    -- Create referral transaction
    SELECT finances.create_wallet_transaction(wallet_id, 'CRC', 1.00, is_confirmed, CONCAT('Referred ', full_name))
    INTO transaction_id;

    -- Insert into the referrals table
    INSERT INTO public.referral(referrer_user_id, refereed_user_id, transaction_id, is_completed) 
    VALUES (referrer_id, referee_id, transaction_id, is_confirmed);

    END IF;
END;
$$;

ALTER FUNCTION "public"."handle_new_referral"("referee_id" "uuid", "ref_code" integer, "full_name" "text", "is_confirmed" boolean) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."handle_new_user"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
DECLARE
  ref_name TEXT;
  master_referral_code text;
  is_confirmed BOOLEAN DEFAULT FALSE;
BEGIN
  -- Check if the new row has a 'confirmed_at' value
  IF NEW.confirmed_at IS NOT NULL THEN
    -- Check if the user profile does not exist in the 'public.profile' table
    IF NOT EXISTS (SELECT 1 FROM public.profile WHERE user_id = NEW.id) THEN
      -- Determine if the user is a corporate account or not
      IF (NEW.raw_user_meta_data->>'is_corp')::BOOLEAN THEN
        is_confirmed := TRUE;
        ref_name := NEW.raw_user_meta_data->>'corp_name';

        -- Insert corporate profile based on the 'type'
        INSERT INTO public.profile(user_id, email, phone, corp_name, corp_reg, npc_reg, role, is_approved)
        VALUES (NEW.id, NEW.email, NEW.phone, NEW.raw_user_meta_data->>'corp_name',
                NEW.raw_user_meta_data->>'corp_reg', NEW.raw_user_meta_data->>'npc_reg',
                CAST(NEW.raw_user_meta_data->>'type' AS public.user_role), FALSE);

      ELSE
        -- Insert new user profile for non-corporate accounts
        INSERT INTO public.profile(user_id, email, phone, first_name, last_name, rsa_id_number, role)
        VALUES (NEW.id, NEW.email, NEW.phone, NEW.raw_user_meta_data->>'first_name', NEW.raw_user_meta_data->>'last_name',
                NEW.raw_user_meta_data->>'id_number', 'Ubuntunist');

        ref_name := CONCAT(NEW.raw_user_meta_data->>'first_name', ' ', NEW.raw_user_meta_data->>'last_name');
      END IF;
    END IF;

    -- Handle referral if a profile exists for the user
    IF EXISTS (SELECT 1 FROM public.profile WHERE user_id = NEW.id) THEN
      IF NEW.raw_user_meta_data->>'referral_code' IS NOT NULL THEN
        PERFORM public.handle_new_referral(NEW.id, (NEW.raw_user_meta_data->>'referral_code')::INTEGER, ref_name, is_confirmed);
      ELSE

        SELECT text_value INTO master_referral_code FROM system_configs.remote_config
        WHERE id = 'master_referral_code';

        PERFORM public.handle_new_referral(NEW.id, master_referral_code::integer, ref_name, is_confirmed);
      END IF;
    END IF;
  END IF;

  RETURN NEW;
END;
$$;

ALTER FUNCTION "public"."handle_new_user"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."on_profile_verified_complete_referral"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    _trans_id integer;
BEGIN
IF EXISTS (
       SELECT 1 FROM public.referral
            WHERE refereed_user_id = NEW.user_id AND is_completed = false
        ) THEN
        
    -- Check if the user's profile is verified
    IF EXISTS (
        SELECT 1 
        FROM profile p 
        WHERE p.user_id = NEW.user_id 
        AND p.is_verified = TRUE
    ) THEN
            -- Retrieve the transaction ID for the referral
            SELECT transaction_id INTO _trans_id FROM public.referral 
            WHERE refereed_user_id = NEW.user_id AND is_completed = false;

            -- Update the transaction as vested
            UPDATE finances.transaction 
            SET vested = true, confirmed_at = now() 
            WHERE id = _trans_id;

            -- Mark the referral as completed
            UPDATE public.referral 
            SET is_completed = true 
            WHERE refereed_user_id = NEW.user_id AND is_completed = false;
        END IF;
    END IF;
    RETURN NEW;
END;
$$;

ALTER FUNCTION "public"."on_profile_verified_complete_referral"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."on_profile_verified_update_confirm_income_txns"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    unvested_transaction RECORD;
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM profile p 
        WHERE p.user_id = NEW.user_id 
        AND p.is_verified = TRUE
    ) THEN
        FOR unvested_transaction IN 
            SELECT t.id 
            FROM finances.transaction t
            JOIN finances.wallet_transaction wt ON t.id = wt.transaction_id 
            JOIN finances.wallet w ON wt.wallet_id = w.id 
            JOIN public.profile p ON w.user_id = p.user_id
            WHERE t.vested = false 
            AND w.type = 'income' 
            AND t.confirmed_at IS NULL
            AND p.user_id = NEW.user_id
        LOOP
            UPDATE finances.transaction 
            SET vested = true, confirmed_at = NOW()
            WHERE id = unvested_transaction.id;
        END LOOP;
    END IF;
    RETURN NEW;
END;
$$;

ALTER FUNCTION "public"."on_profile_verified_update_confirm_income_txns"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."remove_product_from_basket"("_basket_id" "uuid", "_product_id" integer) RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM public.basket_product WHERE basket_id = _basket_id AND product_id = _product_id AND quantity > 1) THEN
        UPDATE public.basket_product
        SET quantity = quantity - 1
        WHERE basket_id = _basket_id AND product_id = _product_id;
    ELSE
        DELETE FROM public.basket_product
        WHERE basket_id = _basket_id AND product_id = _product_id;
    END IF;
END;
$$;

ALTER FUNCTION "public"."remove_product_from_basket"("_basket_id" "uuid", "_product_id" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "sales"."allocate_profit_earnings_for_eesupool_member_orders"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    _collection_fee NUMERIC DEFAULT 0.00;
    _packaging_fee NUMERIC DEFAULT 0.00;
    _admin_fee NUMERIC DEFAULT 0.00;
    _receiving_fee NUMERIC DEFAULT 0.00;
    _pool_fees_rec RECORD;
    _order_earnings RECORD;
    _admin_wallet_id integer;
    _admins_count integer;
    _eesupool_id integer;
    _target_wallet_id integer;
    _receivers uuid[];
    _receivers_count integer;
    _assignments_privilage sales.order_edit_privilage;
BEGIN

    IF EXISTS (
            SELECT 1
            FROM sales.order_product op 
            JOIN inventory.product p ON op.product_id = p.id
            WHERE op.order_id = NEW.id 
            AND p.class <> 'Crowdfund-voucher'
    ) THEN

    IF NEW.collected_at IS NOT NULL AND NEW.status = 'Collected' AND NEW.eesupool_order_id IS NOT NULL THEN
        -- Select eesupool id
        SELECT eo.eesupool_id INTO _eesupool_id
        FROM communities.eesupool_order eo
        WHERE eo.id = NEW.eesupool_order_id;

        -- Fetch the pool fees for the associated eesupool order
        SELECT e.admin_fee, e.packaging_fee, e.collection_fee, e.receiver_fee
        INTO _pool_fees_rec
        FROM communities.eesupool e
        WHERE e.id = _eesupool_id;

        -- Fetch order earnings
        SELECT * INTO _order_earnings FROM sales.get_order_summed_food_class_earnings(NEW.id);

        -- Calculate fees
        _admin_fee := (_order_earnings.eia_total * _pool_fees_rec.admin_fee) / 100;
        _receiving_fee := (_order_earnings.eia_total * _pool_fees_rec.receiver_fee) / 100;
        _packaging_fee := (_order_earnings.eia_total * _pool_fees_rec.packaging_fee) / 100;
        _collection_fee := (_order_earnings.eia_total * _pool_fees_rec.collection_fee) / 100;

        -- Count the number of admins
        SELECT COUNT(em.id) INTO _admins_count
        FROM communities.eesupool_member em
        WHERE em.eesupool_id = _eesupool_id AND em.role = 'Admin';

        -- Loop over admin wallet IDs
        FOR _admin_wallet_id IN
            SELECT w.id FROM communities.eesupool_member em
            JOIN finances.wallet w ON em.user_id = w.user_id
            WHERE em.eesupool_id = _eesupool_id AND em.role = 'Admin'
            AND w.type = 'retail'
        LOOP
            PERFORM finances.create_wallet_transaction(_admin_wallet_id, 'EIA', _admin_fee / _admins_count,
            true, CONCAT('Order-# ', NEW.id, ' Admin Share'));
        END LOOP;

        SELECT eo.receivers INTO _receivers FROM communities.eesupool_order eo
        WHERE eo.id = new.eesupool_order_id;

        _receivers_count := array_length(_receivers, 1);
        -- Loop through each element of the array
        FOR i IN 1.._receivers_count LOOP
            FOR _admin_wallet_id IN
                SELECT w.id FROM communities.eesupool_member em
                JOIN finances.wallet w ON em.user_id = w.user_id
                WHERE em.id =_receivers[i] AND w.type = 'retail'
            LOOP
                PERFORM finances.create_wallet_transaction(_admin_wallet_id, 'EIA', _receiving_fee / _receivers_count,
                true, CONCAT('Order-# ', NEW.id, ' Order Receiving Share'));
            END LOOP;
        END LOOP;

        -- Assignments
        FOR _target_wallet_id, _assignments_privilage IN
            SELECT w.id, moa.privilage
            FROM communities.member_order_assignment moa
            JOIN communities.eesupool_member em ON moa.member_id = em.id
            JOIN finances.wallet w ON em.user_id = w.user_id
            WHERE moa.order_id = NEW.id AND moa.eesupool_ord_id = NEW.eesupool_order_id AND w.type = 'retail'
        LOOP
            IF _assignments_privilage = 'Packer' THEN
                PERFORM finances.create_wallet_transaction(_target_wallet_id, 'EIA', _packaging_fee,
                true, CONCAT('Order-# ', NEW.id, ' Packaging Fee'));
            ELSIF _assignments_privilage = 'Collector' THEN
                PERFORM finances.create_wallet_transaction(_target_wallet_id, 'EIA', _collection_fee,
                true, CONCAT('Order-# ', NEW.id, ' Collection Fee'));
            ELSIF _assignments_privilage = 'All' THEN
                PERFORM finances.create_wallet_transaction(_target_wallet_id, 'EIA', _packaging_fee,
                true, CONCAT('Order-# ', NEW.id, ' Packaging Fee'));
                PERFORM finances.create_wallet_transaction(_target_wallet_id, 'EIA', _collection_fee,
                true, CONCAT('Order-# ', NEW.id, ' Collection Fee'));
            END IF;
        END LOOP;
    END IF;
    RETURN NEW;
END;
$$;

ALTER FUNCTION "sales"."allocate_profit_earnings_for_eesupool_member_orders"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "sales"."allocate_profit_earnings_for_eesupreneur_orders"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    _order_earnings RECORD;
    _target_wallet integer;
    _app public.app_type;
    _retail_wallet_id integer;
BEGIN
    IF NEW.collected_at IS NOT NULL AND NEW.status = 'Collected' THEN
        --Earnings
        SELECT * FROM sales.calculate_order_profit_splits(NEW.id)
        INTO _order_earnings;

        -- Allocate Customer Referral Commission
        SELECT w.id into _target_wallet from finances.wallet w JOIN referral r on w.user_id = r.referrer_user_id
        WHERE r.refereed_user_id = NEW.customer_id AND r.is_completed = TRUE AND w.type = 'wealth';

        PERFORM finances.create_wallet_transaction(_target_wallet, 'CRC', _order_earnings.crc_total,
        true, concat('Order-# ', NEW.id, ' CRC'));

      --#########-> FOR SOME ROLES THIS CIA MIGHT BE A DISCOUNT ON CHECKOUT SO WE ENSURE THAT WE DO NOT ALLOCATE IT AGAIN <-##########
        IF NOT EXISTS (
            SELECT 1 
            FROM public.profile p 
            WHERE p.user_id = NEW.customer_id AND p.role = 'EESUplift-Corporate'
        ) THEN

            -- Find the customer's retail wallet
            SELECT w.id INTO _retail_wallet_id  FROM finances.wallet w 
            WHERE w.user_id = NEW.customer_id AND w.type = 'retail';

            -- Create the CIA transaction
            PERFORM finances.create_wallet_transaction(_retail_wallet_id, 'CIA', _order_earnings.cia_total,
            true, concat('Order-# ', NEW.id, ' CIA')); 

        END IF;

        --#####################################################################################################################

        --After allocating the other profit shares, now we will do the ones that are unique to the apps
        --By apps i mean EESUp or MyKasiShop, this is to help keep the same code base for the apps
        SELECT app INTO _app FROM system_configs.remote_config WHERE id = 'current_app';

        IF _app = 'EESUp' THEN

            -- Allocate Customer Wealth Allocation
            SELECT w.id into _target_wallet from finances.wallet w where w.user_id = NEW.customer_id AND w.type = 'wealth';
            -- Create the finances.transaction
            PERFORM finances.create_wallet_transaction(_target_wallet, 'CWA', _order_earnings.cwa_total,
            true, concat('Order-# ', NEW.id, ' CWA'));

            -- Allocate customer social income
            SELECT w.id into _target_wallet from finances.wallet w where w.user_id = NEW.customer_id AND w.type = 'social';
            PERFORM finances.create_wallet_transaction(_target_wallet, 'CSA', _order_earnings.csa_total,
            true, concat('Order-# ', NEW.id, ' CSA'));

        ELSIF _app = 'MyKasiShop' THEN

        END IF;

        ---###############################--->THESE ALLOCATIONS ARE NOT UNIQUE TO ANY APP <---##############################################
        SELECT text_value::INTEGER INTO _target_wallet FROM system_configs.remote_config
        WHERE id = 'master_wallet_id';
        PERFORM finances.create_wallet_transaction(_target_wallet, 'DAA', _order_earnings.daa_total,
        true, concat('Order-# ', NEW.id, ' DAA'));

        IF NEW.eesupreneur_id IS NOT NULL THEN
            SELECT w.id INTO _target_wallet FROM finances.wallet w JOIN services.eesupreneur e on w.user_id = e.owner_id
            WHERE e.id = NEW.eesupreneur_id AND w.type = 'retail';
            PERFORM finances.create_wallet_transaction(_target_wallet, 'EIA', _order_earnings.eia_total,
            true, concat('Order-# ', NEW.id, ' EIA'));

            --##############-> Allocate the delivary fee  if it is chosen by the customer <-#####################
            IF NEW.delivery_fee IS NOT NULL THEN
                PERFORM finances.create_wallet_transaction(_target_wallet, 'EIA', NEW.delivery_fee,
                true, concat('Order-# ', NEW.id, ' Delivery fee'));
            END IF;
        END IF;
    END IF;
    RETURN NEW;
END;
$$;

ALTER FUNCTION "sales"."allocate_profit_earnings_for_eesupreneur_orders"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "sales"."calculate_order_profit_splits"("_order_id" integer) RETURNS TABLE("cia_total" numeric, "cwa_total" numeric, "eia_total" numeric, "crc_total" numeric, "csa_total" numeric, "daa_total" numeric, "cfv_total" numeric)
    LANGUAGE "plpgsql"
    AS $$
begin
RETURN QUERY SELECT
        SUM(op.cia * op.quantity) AS cia_total,
        SUM(op.cwa * op.quantity) AS cwa_total,
        SUM(op.eia * op.quantity) AS eia_total,
        SUM(op.crc * op.quantity) AS crc_total,
        SUM(op.csa * op.quantity) AS csa_total,
        SUM(op.daa * op.quantity) AS daa_total,
        SUM(op.cfv * op.quantity) AS cfv_total
FROM sales.order_product op
JOIN inventory.product p on op.product_id = p.id
WHERE op.order_id = _order_id AND p.class = 'Food';
end;
$$;

ALTER FUNCTION "sales"."calculate_order_profit_splits"("_order_id" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "sales"."create_order"("_customer_id" "uuid", "_eesupreneur_id" "uuid", "_eesupool_order_id" integer, "_wallet_id" integer, "_total_amount" numeric, "_payment_method" "finances"."payment_method", "_address_id" integer, "_delivery_fee" numeric, "_card_fee" numeric, "_pay_fees_with_retail" boolean, "_products" "jsonb"[]) RETURNS "record"
    LANGUAGE "plpgsql"
    AS $$
DECLARE

    _transaction_id INTEGER;
    _order_id INTEGER;
    _outstanding_amount numeric;
    _wallet_balance numeric;
    _payment record;

BEGIN
    -- Create sales.order
    INSERT INTO sales.order (customer_id, eesupreneur_id, eesupool_order_id, payment_method,
     delivery_address_id, delivery_fee,value,card_fee)
    VALUES (_customer_id, _eesupreneur_id, _eesupool_order_id,
    _payment_method, _address_id, _delivery_fee,_total_amount,ROUND(_card_fee,2))
    RETURNING id INTO _order_id;

    PERFORM sales.INSERT_order_products(_order_id, _products);

    --initialize the outstanding amount to the total
    _outstanding_amount :=_total_amount;

    --IF the delivery is chosen the add it to the outstanding amount
    IF  _delivery_fee IS NOT NULL THEN
        _outstanding_amount := _outstanding_amount + _delivery_fee;
    END IF;

    --If the Pay with retail wallet toggle is true 
    --then deduct it from the retail wallet else add it to the outstanding
    IF _card_fee IS NOT NULL THEN
        IF  _pay_fees_with_retail  IS TRUE  THEN
            SELECT * INTO _transaction_id
            FROM finances.create_wallet_transaction(_wallet_id, 'ORD', -_card_fee, false, CONCAT(_order_id, '- ORD Card Fee'));
            PERFORM finances.create_order_transaction(_order_id, _transaction_id);
        ELSE        
            _outstanding_amount := _outstanding_amount + _card_fee;
        END IF;
    END IF;

    -- Process based on payment method
    IF _payment_method IN ('Ozow', 'Instapay', 'Yoco') THEN

        --EFT
        SELECT * INTO _transaction_id
        FROM finances.create_wallet_transaction(_wallet_id, 'DEP', _outstanding_amount,
        false, CONCAT(_order_id, '- Deposit(eft)'));
        
        PERFORM finances.create_order_transaction(_order_id, _transaction_id);

        SELECT * INTO _transaction_id
        FROM finances.create_wallet_transaction(_wallet_id, 'ORD', -_outstanding_amount,
        false, CONCAT(_order_id, '- ORD Payment'));

        PERFORM finances.create_order_transaction(_order_id, _transaction_id);

        --create payment row
        INSERT INTO finances.online_payment(reference_id,amount,user_id,type)
        values(_order_id, _outstanding_amount, _customer_id, 'Order')
        returning payment_id, secondary_id INTO _payment;

        return (_order_id, _outstanding_amount, _payment.payment_id, _payment.secondary_id);

    ELSIF _payment_method IN ('Split-Ozow' ,'Split-Instapay', 'Split-Yoco') THEN

        -- Split-Ozow & Retail wallet specific logic
        SELECT balance INTO _wallet_balance FROM finances.wallet WHERE id = _wallet_id;

        SELECT * INTO _transaction_id
        FROM finances.create_wallet_transaction(_wallet_id, 'ORD',-_wallet_balance, false, CONCAT(_order_id, '- ORD Payment'));

        PERFORM finances.create_order_transaction(_order_id, _transaction_id);

        _outstanding_amount := _outstanding_amount - _wallet_balance;

        SELECT * INTO _transaction_id
        FROM finances.create_wallet_transaction(_wallet_id, 'DEP', _outstanding_amount, false, CONCAT(_order_id, '- Deposit(eft)'));

        PERFORM finances.create_order_transaction(_order_id, _transaction_id);

        SELECT * INTO _transaction_id
        FROM finances.create_wallet_transaction(_wallet_id, 'ORD', -_outstanding_amount, false, CONCAT(_order_id, '- ORD Payment'));

        PERFORM finances.create_order_transaction(_order_id, _transaction_id);

        --create payment row
        INSERT INTO finances.online_payment(reference_id,amount,user_id,type)
        values(_order_id, _outstanding_amount, _customer_id, 'Order')
        returning id, secondary_id INTO _payment;

        return (_order_id, _outstanding_amount, _payment.payment_id, _payment.secondary_id);

    ELSIF _payment_method = 'Retail wallet' THEN
        -- Retail payment logic
        SELECT * INTO _transaction_id
        FROM finances.create_wallet_transaction(_wallet_id, 'ORD', -_outstanding_amount, false, CONCAT(_order_id, '- ORD Payment'));

        PERFORM finances.create_order_transaction(_order_id, _transaction_id);

        --CONFIRM THE ORDER NOW
        perform sales.place_confirmed_order(_order_id,true);

        _outstanding_amount := 0.00;

        RETURN (_order_id, _outstanding_amount);        
    END IF;
END;
$$;

ALTER FUNCTION "sales"."create_order"("_customer_id" "uuid", "_eesupreneur_id" "uuid", "_eesupool_order_id" integer, "_wallet_id" integer, "_total_amount" numeric, "_payment_method" "finances"."payment_method", "_address_id" integer, "_delivery_fee" numeric, "_card_fee" numeric, "_pay_fees_with_retail" boolean, "_products" "jsonb"[]) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "sales"."generate_order_secret_pin"() RETURNS integer
    LANGUAGE "plpgsql"
    AS $$
declare
  pin int;
begin
  select num into pin 
  from generate_series(10000, 99999) as s(num)
  order by random() limit 1;
  return pin;
end;
$$;

ALTER FUNCTION "sales"."generate_order_secret_pin"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "sales"."get_customer_orders"("_user_id" "uuid", "_eesupreneur_id" "uuid", "_eesupool_ord_id" integer, "_status" "sales"."order_status"[], "_limit" integer) RETURNS TABLE("id" integer, "customer_id" "uuid", "eesupreneur_id" "uuid", "eesupool_order_id" integer, "created_at" timestamp with time zone, "placed_at" timestamp with time zone, "packaged_at" timestamp with time zone, "ready_at" timestamp with time zone, "collected_at" timestamp with time zone, "cancelled_at" timestamp with time zone, "payment_method" "finances"."payment_method", "secret_pin" integer, "delivery_address_id" integer, "delivery_fee" numeric, "status" "sales"."order_status", "full_name" "text", "corp_name" "text", "products" "jsonb", "address" "jsonb", "value" numeric, "assignments" "jsonb")
    LANGUAGE "plpgsql"
    AS $$BEGIN
    RETURN QUERY 
    SELECT 
        ord.id,
        ord.customer_id,
        ord.eesupreneur_id,
        ord.eesupool_order_id,
        ord.created_at, 
        ord.placed_at, 
        ord.packaged_at, 
        ord.ready_at, 
        ord.collected_at, 
        ord.cancelled_at, 
        ord.payment_method, 
        ord.secret_pin, 
        ord.delivery_address_id, 
        ord.delivery_fee, 
        ord.status, 
        concat(pro.first_name,' ',pro.last_name) as full_name,
        pro.corp_name,
        COALESCE(
                (SELECT jsonb_agg(t) FROM (SELECT * FROM sales.get_order_products(ord.id)) t),
                '[]'::jsonb
            ) AS products,
        COALESCE((SELECT row_to_json(t)::jsonb 
                    FROM (SELECT * FROM geolocations.get_address_by_id(ord.delivery_address_id)) t), null) AS address,
        ord.value,
        COALESCE((SELECT jsonb_agg(t) FROM (SELECT * FROM communities.get_order_assignments(ord.id)) t),'[]'::jsonb) AS assignments
    FROM 
        sales.order ord
        left join profile pro on ord.customer_id = pro.user_id
    WHERE 
        (ord.customer_id = _user_id or ord.eesupreneur_id = _eesupreneur_id 
        or ord.eesupool_order_id = _eesupool_ord_id) AND ord.status = Any(_status)
    ORDER BY id desc
    limit _limit;
END;$$;

ALTER FUNCTION "sales"."get_customer_orders"("_user_id" "uuid", "_eesupreneur_id" "uuid", "_eesupool_ord_id" integer, "_status" "sales"."order_status"[], "_limit" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "sales"."get_order_products"("ord_id" integer) RETURNS TABLE("order_id" integer, "product_id" integer, "image_url" "text", "category" "text", "name" "text", "quantity" integer, "customer_accepted_qty" integer, "eesupreneur_accepted_qty" integer, "price" numeric, "size" "text", "class" "inventory"."product_class")
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY 
    SELECT
        op.order_id,
        op.product_id,
        p.image_url,
        c.name AS category,
        p.name,
        op.quantity,
        op.customer_accepted_qty,
        op.eesupreneur_accepted_qty,
        op.price,
        p.size,
        p.class
    FROM
        sales.order_product AS op
        JOIN inventory.product AS p ON op.product_id = p.id
        JOIN inventory.category AS c ON p.category_id = c.id
    WHERE
        op.order_id = ord_id;
END;
$$;

ALTER FUNCTION "sales"."get_order_products"("ord_id" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "sales"."insert_order_products"("_order_id" integer, "_products" "jsonb"[]) RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
begin

    -- Aggregate JSONB array into a single JSONB array
    WITH aggregated_products AS (
        SELECT jsonb_agg(prod) AS products
        FROM unnest(_products) as prod
    )
    -- Insert products
    , inserted_products AS (
        SELECT 
            (jsonb_array_elements(products)->>'product_id')::INTEGER as product_id,
            (jsonb_array_elements(products)->>'quantity')::INTEGER as quantity,
            (jsonb_array_elements(products)->>'price')::NUMERIC as price,
            (jsonb_array_elements(products)->>'substitute_brand')::boolean as substitute_brand_,
            (jsonb_array_elements(products)->>'substitute_variant')::boolean as substitute_variant_
        FROM aggregated_products
    )
    INSERT INTO sales.order_product (product_id, order_id, quantity, price,customer_accepted_qty, eesupreneur_accepted_qty, substitute_brand,
    substitute_variant)
    SELECT product_id, _order_id, quantity, price,quantity, quantity,substitute_brand_,substitute_variant_ FROM inserted_products;
end; $$;

ALTER FUNCTION "sales"."insert_order_products"("_order_id" integer, "_products" "jsonb"[]) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "sales"."place_confirmed_order"("_order_id" integer, "_is_confirmed" boolean) RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    transaction_id integer;
BEGIN
    IF _is_confirmed THEN
        -- Update the order to placed
        UPDATE sales.order
        SET placed_at = now(), status = 'Placed'
        WHERE id = _order_id;

        -- Update all related transactions
        FOR transaction_id IN
            SELECT ot.transaction_id
            FROM sales.order_transaction ot 
            WHERE ot.order_id = _order_id
        LOOP
            UPDATE finances.transaction
            SET confirmed_at = now(), vested = true
            WHERE id = transaction_id;
        END LOOP;
    ELSE
        -- Update the order to cancelled
        UPDATE sales.order
        SET cancelled_at = now(), status = 'Cancelled'
        WHERE id = _order_id;

        -- Update all related transactions
        FOR transaction_id IN
            SELECT ot.transaction_id
            FROM sales.order_transaction ot 
            WHERE ot.order_id = _order_id
        LOOP
            UPDATE finances.transaction
            SET cancelled_at = now(), vested = false
            WHERE id = transaction_id;
        END LOOP;
    END IF;
END;
$$;

ALTER FUNCTION "sales"."place_confirmed_order"("_order_id" integer, "_is_confirmed" boolean) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "sales"."update_product_allocations_on_new_order_product"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    _profit NUMERIC;
    _customer_role user_role;
    _allocations RECORD;
    _product RECORD;
BEGIN
    -- Retrieve product details
    SELECT p.vaa, p.vat, p.class, p.cost_price INTO _product FROM inventory.product p WHERE id = NEW.product_id;
    
    IF _product.class = 'Food' THEN
    -- Determine the customer's role
    SELECT DISTINCT p.role INTO _customer_role
    FROM profile p join sales.order o on p.user_id = o.customer_id
    WHERE o.id = new.order_id;

    -- Calculate profit
    _profit := NEW.price - _product.cost_price;

    -- Get profit allocations based on customer role
    SELECT * INTO _allocations
    FROM finances.profit_allocation
    WHERE create_wallet_transaction = ANY (roles);

    -- Set allocations on NEW record
    NEW.cia := ROUND((_profit * _allocations.cia) / 100, 2);
    NEW.cwa := ROUND((_profit * _allocations.cwa) / 100, 2);
    NEW.eia := ROUND((_profit * _allocations.eia) / 100, 2);
    NEW.crc := ROUND((_profit * _allocations.crc) / 100, 2);
    NEW.csa := ROUND((_profit * _allocations.csa) / 100, 2);
    NEW.daa := ROUND((_profit * _allocations.daa) / 100, 2);
    NEW.cfv := ROUND((_profit * _allocations.cfv) / 100, 2);

    ELSIF _product.class = 'Crowdfund-voucher' THEN

    NEW.vaa := _product.vaa;

    END IF;

    NEW.vat := _product.vat;
    
    RETURN NEW;
END;
$$;

ALTER FUNCTION "sales"."update_product_allocations_on_new_order_product"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "services"."create_new_partner_application"("_user_id" "uuid", "_partner_id" "text") RETURNS integer
    LANGUAGE "plpgsql"
    AS $$
DECLARE
  _id integer;
  _current_role user_role;
  _partner_roles user_role[];
BEGIN
  -- Fetch the current role of the user
  SELECT role INTO _current_role FROM profile WHERE user_id = _user_id;

  -- Fetch the roles associated with the partner
  SELECT roles INTO _partner_roles FROM services.partner WHERE id = _partner_id;

  -- Check if the user's current role is among the partner's roles
  IF _current_role = ANY(_partner_roles) THEN
    -- Insert the new partner application and return the generated id
    INSERT INTO services.partner_application(user_id, partner_id,survey_responses)
    VALUES (_user_id, _partner_id,'{}')
    RETURNING id INTO _id;
  ELSE
    _id := 0;
  END IF;

  RETURN _id;
END;
$$;

ALTER FUNCTION "services"."create_new_partner_application"("_user_id" "uuid", "_partner_id" "text") OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "services"."get_all_user_eesupreneurs"("_user_id" "uuid") RETURNS TABLE("id" "uuid", "owner_id" "uuid", "name" "text", "description" "text", "created_at" timestamp with time zone, "is_hidden" boolean, "is_active" boolean, "delivery_fee" numeric, "schedule" "jsonb", "address" "jsonb")
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY SELECT
        e.id,
        e.owner_id,
        e.name,
        e.description,
        e.created_at,
        e.is_hidden,
        e.is_active,
        e.delivery_fee,
        e.schedule,
        COALESCE((SELECT row_to_json(t)::jsonb 
            FROM (SELECT * FROM geolocations.get_address_by_id(e.address_id)) t), null) AS address
    FROM services.eesupreneur e
    WHERE  e.owner_id = _user_id;
END;
$$;

ALTER FUNCTION "services"."get_all_user_eesupreneurs"("_user_id" "uuid") OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "services"."get_available_partnerships"("role" "public"."user_role") RETURNS TABLE("created_at" timestamp with time zone, "id" "text", "title" "text", "description" "text", "surveys" "jsonb"[], "is_open" boolean, "max_apps" integer, "requirements" "jsonb", "roles" "public"."user_role"[])
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY SELECT p.* FROM services.partner p
    WHERE p.is_open = true and role = Any(p.roles);
END;
$$;

ALTER FUNCTION "services"."get_available_partnerships"("role" "public"."user_role") OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "services"."get_closest_eesupreneurs"("lat" double precision, "lng" double precision, "limit_to" integer) RETURNS TABLE("id" "uuid", "owner_id" "uuid", "owner_name" "text", "name" "text", "description" "text", "created_at" timestamp with time zone, "delivery_fee" numeric, "schedule" "jsonb", "address" "jsonb", "distance" double precision)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY 
    SELECT e.id, e.owner_id,
    (select concat(p.first_name,' ', p.last_name) from profile p where p.user_id = e.owner_id) as owner_name,
    e.name, e.description, e.created_at,
    e.delivery_fee, e.schedule,
    COALESCE((SELECT row_to_json(t)::jsonb 
            FROM (SELECT * FROM geolocations.get_address_by_id(e.address_id)) t), null) AS address,     
    geolocations.calculate_distance_between_2_locations(lat, lng, a.latitude, a.longitude) AS distance
    FROM services.eesupreneur e
    INNER JOIN geolocations.address a ON e.address_id = a.id
    WHERE e.is_active = true and e.is_hidden = false AND e.address_id is not null
    ORDER BY distance ASC
    LIMIT limit_to;
END;
$$;

ALTER FUNCTION "services"."get_closest_eesupreneurs"("lat" double precision, "lng" double precision, "limit_to" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "services"."get_eesupreneurs"("lat" double precision, "lng" double precision) RETURNS TABLE("id" "uuid", "owner_id" "uuid", "owner_name" "text", "name" "text", "description" "text", "created_at" timestamp with time zone, "delivery_fee" numeric, "schedule" "jsonb", "address" "jsonb", "distance" double precision)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY 
    SELECT e.id, e.owner_id,
    (select concat(p.first_name,' ', p.last_name) from profile p where p.user_id = e.owner_id) as owner_name,
    e.name, e.description, e.created_at,
    e.delivery_fee, e.schedule,
    COALESCE((SELECT row_to_json(t)::jsonb 
            FROM (SELECT * FROM geolocations.get_address_by_id(e.address_id)) t), null) AS address,     
    geolocations.calculate_distance_between_2_locations(lat, lng, a.latitude, a.longitude) AS distance
    FROM services.eesupreneur e
    INNER JOIN geolocations.address a ON e.address_id = a.id
    WHERE e.is_active = true and e.is_hidden = false AND e.address_id is not null
    ORDER BY distance ASC
    LIMIT 20;
END;
$$;

ALTER FUNCTION "services"."get_eesupreneurs"("lat" double precision, "lng" double precision) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "services"."get_partnership_surveys"("_user_id" "uuid", "_surveys" "uuid"[]) RETURNS TABLE("id" "uuid", "created_at" timestamp with time zone, "title" "text", "description" "text", "type" "engagements"."survey_type", "questions" "jsonb", "max_responses" integer, "image_url" "text", "video_url" "text", "reward_amount" numeric, "duration" integer, "points" integer, "pass_percentage" numeric, "enable_scoring" boolean, "require_all" boolean, "enforce_time_limit" boolean, "pre_survey" "jsonb", "passed" boolean, "score" integer, "responded_at" timestamp with time zone)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY SELECT 
        s.id,
        s.created_at,
        s.title,
        s.description,
        s.type,
        s.questions,
        s.max_responses,
        s.image_url,
        s.video_url,
        s.reward_amount,
        s.duration,
        s.points,
        s.pass_percentage,
        s.enable_scoring,
        s.require_all,
        s.enforce_time_limit,
        COALESCE((SELECT row_to_json(t)::jsonb 
                  FROM (SELECT * FROM engagements.get_survey_by_id(s.pre_id,_user_id)) t), null) AS pre_survey,
        r.passed,
        r.score,
        r.created_at as responded_at
    FROM engagements.survey s
    LEFT JOIN engagements.response r ON s.id = r.survey_id AND r.user_id = _user_id
    WHERE s.id = ANY(_surveys);
END;
$$;

ALTER FUNCTION "services"."get_partnership_surveys"("_user_id" "uuid", "_surveys" "uuid"[]) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "services"."notify_applicant_on_application_update"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    _title TEXT;
BEGIN
    -- Correctly fetching the title from services.partner into the variable _title
    SELECT title INTO _title FROM services.partner WHERE id = NEW.partner_id;

    -- Checking if approved_at is NOT NULL and rejected_at IS NULL
    IF NEW.approved_at IS NOT NULL THEN
        INSERT INTO engagements.notification(title, body, type, channel,user_id)
        VALUES ('_title', 'Great news!! Your application has been approved.', 'other', 'push',NEW.user_id);
    -- Checking if approved_at IS NULL and rejected_at is NOT NULL
    ELSIF NEW.rejected_at IS NOT NULL THEN
        INSERT INTO engagements.notification(title, body, type, channel,user_id)
        VALUES (_title, 'After a thorough review of your submission, we regret to inform you that we are unable to proceed with approval at this time.', 'other', 'push', NEW.user_id);
    END IF;

    RETURN NEW;
END;
$$;

ALTER FUNCTION "services"."notify_applicant_on_application_update"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "services"."on_partner_application_approved"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
_type RECORD;
BEGIN
  IF NEW.approved_at IS NOT NULL AND NEW.rejected_at ISNULL THEN
    -- FOR EESUplift corp
    IF NEW.partner_id = 'eesup_lift_corp' THEN
      -- Update the user_role of this profile
      UPDATE profile 
      SET role = 'EESUplift-Corporate' 
      WHERE user_id = NEW.user_id;
      
      -- Because this account is from a corporate account, it may miss other wallets
      -- That are for an eesup-lift, so we need to create them
      FOR _type IN SELECT wt.id FROM finances.wallet_type wt
      WHERE 'EESUplift-Corporate' = ANY(wt.roles)
      LOOP    
        IF NOT EXISTS (SELECT 1 FROM finances.wallet w WHERE w.type = _type.id AND w.user_id = NEW.user_id) THEN
          INSERT INTO finances.wallet(type, user_id, balance)
          VALUES (_type.id, NEW.user_id, 0.00);
        END IF;
      END LOOP;
    -- FOR EESUpreneur
    ELSIF NEW.partner_id = 'eesupreneur' THEN
      -- Update the user_role of this profile
      UPDATE profile 
      SET role = 'EESUpreneur' 
      WHERE user_id = NEW.user_id;

      INSERT INTO services.eesupreneur(owner_id, name)
      VALUES(NEW.user_id, 'My Shop');
    END IF;
    
  END IF;

  RETURN NEW;
END;
$$;

ALTER FUNCTION "services"."on_partner_application_approved"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "services"."prevent_editing_of_the_partner_id_value"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    -- Check if the protected column is being updated
    IF OLD.id IS DISTINCT FROM NEW.id THEN
        RAISE EXCEPTION 'Updating this id is not allowed because there are functions(rpc,triggers)
        which are due to the proccessing of the applications';
    END IF;
    RETURN NEW;
END;
$$;

ALTER FUNCTION "services"."prevent_editing_of_the_partner_id_value"() OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";

CREATE TABLE IF NOT EXISTS "communities"."eesupool" (
    "created_at" timestamp with time zone DEFAULT "now"(),
    "name" "text" NOT NULL,
    "description" "text",
    "admin_fee" numeric DEFAULT 10.00,
    "receiving_fee" numeric DEFAULT 10.00,
    "collection_fee" numeric DEFAULT 15.00,
    "packaging_fee" numeric DEFAULT 65.00,
    "is_public" boolean DEFAULT false,
    "chat_enabled" boolean DEFAULT false NOT NULL,
    "address_id" integer,
    "parent_id" integer,
    "box_code" "text",
    "street_code" "text",
    "chat_tags_suggestions" "text"[] DEFAULT '{}'::"text"[] NOT NULL,
    "chat_tags" "text"[] DEFAULT '{}'::"text"[] NOT NULL,
    "id" integer NOT NULL,
    "level" "communities"."eesupool_level",
    "type" "communities"."eesupool_type" NOT NULL,
    "code" integer NOT NULL
);

ALTER TABLE "communities"."eesupool" OWNER TO "postgres";

-- ALTER TABLE "communities"."eesupool" ALTER COLUMN "code" ADD GENERATED BY DEFAULT AS IDENTITY (
--     SEQUENCE NAME "communities"."eesupool_code_seq1"
--     START WITH 53940
--     INCREMENT BY 1
--     NO MINVALUE
--     NO MAXVALUE
--     CACHE 1
-- );

-- ALTER TABLE "communities"."eesupool" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
--     SEQUENCE NAME "communities"."eesupool_id_seq"
--     START WITH 1576921
--     INCREMENT BY 1
--     NO MINVALUE
--     NO MAXVALUE
--     CACHE 1
-- );

CREATE TABLE IF NOT EXISTS "communities"."eesupool_issue" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "reporter_id" "uuid",
    "offender_id" "uuid",
    "description" "text" NOT NULL,
    "message_id" integer,
    "eesupool_id" integer NOT NULL,
    "attachments" "jsonb"[],
    "resolved_at" timestamp with time zone,
    "parent_pool_id" integer
);

ALTER TABLE "communities"."eesupool_issue" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "communities"."eesupool_member" (
    "user_id" "uuid" NOT NULL,
    "eesupool_id" integer NOT NULL,
    "is_censored" boolean DEFAULT false NOT NULL,
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT ("now"() AT TIME ZONE 'utc'::"text") NOT NULL,
    "role" "communities"."eesupool_member_role" DEFAULT 'Member'::"communities"."eesupool_member_role" NOT NULL
);

ALTER TABLE "communities"."eesupool_member" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "communities"."eesupool_order" (
    "id" integer NOT NULL,
    "eesupool_id" integer NOT NULL,
    "created_at" timestamp with time zone DEFAULT ("now"() AT TIME ZONE 'utc'::"text") NOT NULL,
    "schedule_for" timestamp with time zone NOT NULL,
    "delivered_at" timestamp with time zone,
    "closes_at" timestamp with time zone NOT NULL,
    "admin_fee" numeric,
    "packer_fee" numeric,
    "receiver_fee" numeric,
    "collection_fee" numeric,
    "address_id" integer,
    "secret_pin" integer,
    "receivers" "uuid"[]
);

ALTER TABLE "communities"."eesupool_order" OWNER TO "postgres";

-- ALTER TABLE "communities"."eesupool_order" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
--     SEQUENCE NAME "communities"."eesupool_order_id_seq"
--     START WITH 1503000
--     INCREMENT BY 1
--     NO MINVALUE
--     NO MAXVALUE
--     CACHE 1
-- );

CREATE TABLE IF NOT EXISTS "communities"."eesupool_request" (
    "user_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "eesupool_id" integer NOT NULL,
    "type" "text" DEFAULT 'invite'::"text" NOT NULL,
    "status" "communities"."eesupool_request_status" DEFAULT 'Pending'::"communities"."eesupool_request_status" NOT NULL
);

ALTER TABLE "communities"."eesupool_request" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "communities"."event" (
    "eesupool_id" integer,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "title" "text" NOT NULL,
    "notes" "text",
    "address_id" integer,
    "start_at" timestamp with time zone NOT NULL,
    "end_at" timestamp with time zone NOT NULL,
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "remote_url" "text",
    "attachments" "jsonb"[]
);

ALTER TABLE "communities"."event" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "communities"."event_attendee" (
    "event_id" "uuid" NOT NULL,
    "member_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);

ALTER TABLE "communities"."event_attendee" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "communities"."member_order_assignment" (
    "order_id" integer NOT NULL,
    "eesupool_ord_id" integer NOT NULL,
    "member_id" "uuid" NOT NULL,
    "privilage" "sales"."order_edit_privilage" DEFAULT 'All'::"sales"."order_edit_privilage" NOT NULL
);

ALTER TABLE "communities"."member_order_assignment" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "communities"."message" (
    "eesupool_id" integer NOT NULL,
    "author_id" "uuid",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "content" "text",
    "reply_on_id" integer,
    "attachments" "jsonb"[],
    "hash_tags" "text"[],
    "is_approved" boolean DEFAULT true NOT NULL,
    "is_deleted" boolean DEFAULT false NOT NULL,
    "id" integer NOT NULL,
    "broadcast_to" "communities"."eesupool_level"[]
);

ALTER TABLE "communities"."message" OWNER TO "postgres";

-- ALTER TABLE "communities"."message" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
--     SEQUENCE NAME "communities"."message_id_seq"
--     START WITH 1000
--     INCREMENT BY 1
--     NO MINVALUE
--     NO MAXVALUE
--     CACHE 1
-- );

CREATE TABLE IF NOT EXISTS "communities"."message_reaction" (
    "member_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "message_id" integer NOT NULL,
    "liked" boolean DEFAULT true NOT NULL
);

ALTER TABLE "communities"."message_reaction" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "communities"."message_seen" (
    "member_id" "uuid" NOT NULL,
    "message_id" integer NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);

ALTER TABLE "communities"."message_seen" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "engagements"."banner" (
    "id" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "content" "jsonb"[] NOT NULL
);

ALTER TABLE "engagements"."banner" OWNER TO "postgres";

-- ALTER TABLE "engagements"."banner" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
--     SEQUENCE NAME "engagements"."banner_id_seq"
--     START WITH 1
--     INCREMENT BY 1
--     NO MINVALUE
--     NO MAXVALUE
--     CACHE 1
-- );

CREATE TABLE IF NOT EXISTS "engagements"."notification" (
    "id" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "title" "text" NOT NULL,
    "body" "text",
    "data" "jsonb",
    "seen_at" timestamp with time zone,
    "type" "public"."notification_type" DEFAULT 'other'::"public"."notification_type" NOT NULL,
    "user_id" "uuid",
    "channel" "public"."notification_channel" DEFAULT 'push'::"public"."notification_channel" NOT NULL
);

ALTER TABLE "engagements"."notification" OWNER TO "postgres";

-- ALTER TABLE "engagements"."notification" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
--     SEQUENCE NAME "engagements"."notification_id_seq"
--     START WITH 1
--     INCREMENT BY 1
--     NO MINVALUE
--     NO MAXVALUE
--     CACHE 1
-- );

CREATE TABLE IF NOT EXISTS "engagements"."response" (
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "passed" boolean,
    "score" integer,
    "answers" "jsonb" NOT NULL,
    "survey_id" "uuid" NOT NULL,
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL
);

ALTER TABLE "engagements"."response" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "engagements"."survey" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "title" "text" NOT NULL,
    "description" "text",
    "questions" "jsonb" NOT NULL,
    "wallet" "text",
    "max_responses" integer,
    "image_url" "text",
    "video_url" "text",
    "reward_amount" numeric,
    "duration" integer,
    "points" integer,
    "pass_percentage" numeric,
    "enable_scoring" boolean DEFAULT false,
    "require_all" boolean DEFAULT false,
    "enforce_time_limit" boolean DEFAULT false,
    "is_public" boolean DEFAULT false NOT NULL,
    "roles" "public"."user_role"[] NOT NULL,
    "pre_id" "uuid",
    "is_private" boolean DEFAULT false NOT NULL,
    "can_delete" boolean DEFAULT true NOT NULL,
    "type" "engagements"."survey_type" NOT NULL
);

ALTER TABLE "engagements"."survey" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "finances"."online_payment" (
    "payment_id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "reference_id" integer NOT NULL,
    "amount" numeric NOT NULL,
    "user_id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "status" "finances"."payment_status" DEFAULT 'Pending'::"finances"."payment_status" NOT NULL,
    "type" "finances"."payment_type" NOT NULL,
    "secondary_id" "text" DEFAULT "finances"."generate_payment_secondary_id"() NOT NULL,
    "confirmed_at" timestamp with time zone
);

ALTER TABLE "finances"."online_payment" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "finances"."payment_gateway" (
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "fee" numeric NOT NULL,
    "is_active" boolean NOT NULL,
    "id" "finances"."payment_method" NOT NULL
);

ALTER TABLE "finances"."payment_gateway" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "finances"."payout_request" (
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "bank" "text" NOT NULL,
    "acc_number" "text" NOT NULL,
    "acc_name" "text" NOT NULL,
    "branch_code" "text" NOT NULL,
    "approved_at" timestamp with time zone,
    "id" integer NOT NULL
);

ALTER TABLE "finances"."payout_request" OWNER TO "postgres";

ALTER TABLE "finances"."payout_request" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "finances"."payout_request_id_seq"
    START WITH 153000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "finances"."profit_allocation" (
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "cia" numeric DEFAULT 0.00 NOT NULL,
    "cwa" numeric DEFAULT 0.00 NOT NULL,
    "eia" numeric DEFAULT 0.00 NOT NULL,
    "crc" numeric DEFAULT 0.00 NOT NULL,
    "csa" numeric DEFAULT 0.00 NOT NULL,
    "daa" numeric DEFAULT 0.00 NOT NULL,
    "roles" "public"."user_role"[] NOT NULL,
    "id" integer NOT NULL,
    "cfv" numeric DEFAULT '0'::numeric NOT NULL
);

ALTER TABLE "finances"."profit_allocation" OWNER TO "postgres";

-- ALTER TABLE "finances"."profit_allocation" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
--     SEQUENCE NAME "finances"."profit_allocation_id_seq"
--     START WITH 1
--     INCREMENT BY 1
--     NO MINVALUE
--     NO MAXVALUE
--     CACHE 1
-- );

CREATE TABLE IF NOT EXISTS "finances"."transaction" (
    "type" "text" NOT NULL,
    "doc_ref" integer NOT NULL,
    "value" numeric DEFAULT 0.00 NOT NULL,
    "vested" boolean NOT NULL,
    "description" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "confirmed_at" timestamp with time zone,
    "cancelled_at" timestamp with time zone,
    "is_deleted" boolean DEFAULT false,
    "id" integer NOT NULL,
    "txt_id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL
);

ALTER TABLE "finances"."transaction" OWNER TO "postgres";

-- ALTER TABLE "finances"."transaction" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
--     SEQUENCE NAME "finances"."transaction_id_seq"
--     START WITH 2601375
--     INCREMENT BY 1
--     NO MINVALUE
--     NO MAXVALUE
--     CACHE 1
-- );

CREATE TABLE IF NOT EXISTS "finances"."transaction_type" (
    "id" "text" NOT NULL,
    "label" "text" NOT NULL,
    "inventory" boolean DEFAULT false NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);

ALTER TABLE "finances"."transaction_type" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "finances"."voucher" (
    "parameter_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "value" numeric NOT NULL,
    "cycle" "finances"."voucher_cycle" NOT NULL,
    "period" integer NOT NULL,
    "end_date" timestamp with time zone NOT NULL,
    "id" integer NOT NULL,
    "confirmed_at" timestamp with time zone,
    "cancelled_at" timestamp with time zone,
    "balance" numeric DEFAULT 36000.00 NOT NULL,
    "wallet_id" integer NOT NULL
);

ALTER TABLE "finances"."voucher" OWNER TO "postgres";

-- ALTER TABLE "finances"."voucher" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
--     SEQUENCE NAME "finances"."voucher_id_seq1"
--     START WITH 150000
--     INCREMENT BY 1
--     NO MINVALUE
--     NO MAXVALUE
--     CACHE 1
-- );

CREATE TABLE IF NOT EXISTS "finances"."voucher_ledger" (
    "voucher_id" integer NOT NULL,
    "transaction_id" integer NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "opening_balance" numeric,
    "payout" numeric,
    "profit_share" numeric,
    "closing_balance" numeric NOT NULL
);

ALTER TABLE "finances"."voucher_ledger" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "finances"."voucher_parameter" (
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "period" integer NOT NULL,
    "interest" numeric NOT NULL,
    "minimum_value" numeric NOT NULL,
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL
);

ALTER TABLE "finances"."voucher_parameter" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "finances"."wallet" (
    "user_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "type" "text" NOT NULL,
    "balance" numeric NOT NULL,
    "id" integer NOT NULL
);

ALTER TABLE "finances"."wallet" OWNER TO "postgres";

-- ALTER TABLE "finances"."wallet" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
--     SEQUENCE NAME "finances"."wallet_id_seq"
--     START WITH 150002600
--     INCREMENT BY 1
--     NO MINVALUE
--     NO MAXVALUE
--     CACHE 1
-- );

CREATE TABLE IF NOT EXISTS "finances"."wallet_transaction" (
    "wallet_id" integer NOT NULL,
    "transaction_id" integer NOT NULL
);

ALTER TABLE "finances"."wallet_transaction" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "finances"."wallet_type" (
    "description" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT ("now"() AT TIME ZONE 'utc'::"text") NOT NULL,
    "withdrawls" boolean DEFAULT false NOT NULL,
    "deposits" boolean DEFAULT false NOT NULL,
    "transfers" boolean DEFAULT false NOT NULL,
    "shopping" boolean DEFAULT false NOT NULL,
    "is_active" boolean DEFAULT false NOT NULL,
    "require_rsa_id" boolean DEFAULT false NOT NULL,
    "sort_num" integer DEFAULT 1 NOT NULL,
    "id" "text" DEFAULT ''::"text" NOT NULL,
    "roles" "public"."user_role"[] NOT NULL
);

ALTER TABLE "finances"."wallet_type" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "geolocations"."address" (
    "area_id" integer,
    "user_id" "uuid",
    "recipient_name" "text" NOT NULL,
    "recipient_phone" "text" NOT NULL,
    "street_address" "text" NOT NULL,
    "building_name" "text",
    "type" "text" NOT NULL,
    "province" "text" NOT NULL,
    "latitude" numeric,
    "longitude" numeric,
    "created_at" timestamp with time zone DEFAULT ("now"() AT TIME ZONE 'utc'::"text") NOT NULL,
    "is_primary" boolean DEFAULT false NOT NULL,
    "id" integer NOT NULL
);

ALTER TABLE "geolocations"."address" OWNER TO "postgres";

-- ALTER TABLE "geolocations"."address" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
--     SEQUENCE NAME "geolocations"."address_id_seq"
--     START WITH 10185
--     INCREMENT BY 1
--     NO MINVALUE
--     NO MAXVALUE
--     CACHE 1
-- );

CREATE TABLE IF NOT EXISTS "geolocations"."target_area" (
    "id" integer NOT NULL,
    "name" "text" NOT NULL,
    "center_latitude" numeric NOT NULL,
    "center_longitude" numeric NOT NULL,
    "area_radius" numeric NOT NULL,
    "center_full_address" "text" NOT NULL,
    "is_active" boolean DEFAULT true NOT NULL
);

ALTER TABLE "geolocations"."target_area" OWNER TO "postgres";

-- ALTER TABLE "geolocations"."target_area" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
--     SEQUENCE NAME "geolocations"."target_area_area_id_seq"
--     START WITH 1
--     INCREMENT BY 1
--     NO MINVALUE
--     NO MAXVALUE
--     CACHE 1
-- );

CREATE TABLE IF NOT EXISTS "inventory"."category" (
    "id" integer NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "name" "text" NOT NULL,
    "image_url" "text",
    "parent_id" integer,
    "is_active" boolean DEFAULT false NOT NULL
);

ALTER TABLE "inventory"."category" OWNER TO "postgres";

-- ALTER TABLE "inventory"."category" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
--     SEQUENCE NAME "inventory"."category_id_seq"
--     START WITH 1
--     INCREMENT BY 1
--     NO MINVALUE
--     NO MAXVALUE
--     CACHE 1
-- );

CREATE TABLE IF NOT EXISTS "inventory"."product" (
    "id" integer NOT NULL,
    "category_id" integer NOT NULL,
    "name" "text" NOT NULL,
    "description" "text" NOT NULL,
    "image_url" "text",
    "size" "text",
    "brand" "text",
    "type" "text",
    "uom" "text",
    "unit_pack_size" "text",
    "flavour" "text",
    "sale_price" numeric DEFAULT 0.00 NOT NULL,
    "cost_price" numeric DEFAULT 0.00 NOT NULL,
    "vaa" numeric DEFAULT 0.00 NOT NULL,
    "vat" numeric DEFAULT 0.00 NOT NULL,
    "order_max" integer,
    "stock_break_enabled" boolean DEFAULT false NOT NULL,
    "is_active" boolean DEFAULT true NOT NULL,
    "child_id" integer,
    "child_break_qty" integer,
    "bar_code" "text",
    "kit_kat_ref" "text",
    "sp_ref" integer,
    "sp_factor" numeric,
    "vat_claimable" boolean DEFAULT false NOT NULL,
    "vat_able" boolean DEFAULT false NOT NULL,
    "rel_id" integer,
    "gpper" numeric,
    "bar_code_verified" boolean DEFAULT false NOT NULL,
    "kit_kat_ref_verified" boolean DEFAULT false NOT NULL,
    "class" "inventory"."product_class" DEFAULT 'Food'::"inventory"."product_class" NOT NULL,
    "marup" numeric,
    "roles" "public"."user_role"[] NOT NULL,
    "sellable" boolean DEFAULT true NOT NULL
);

ALTER TABLE "inventory"."product" OWNER TO "postgres";

-- ALTER TABLE "inventory"."product" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
--     SEQUENCE NAME "inventory"."product_id_seq"
--     START WITH 4011
--     INCREMENT BY 1
--     NO MINVALUE
--     NO MAXVALUE
--     CACHE 1
-- );

CREATE TABLE IF NOT EXISTS "inventory"."product_request" (
    "id" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "product_id" integer,
    "type" "text" NOT NULL,
    "brand" "text" NOT NULL,
    "pack_size" "text" NOT NULL,
    "variant" "text",
    "quantity" integer
);

ALTER TABLE "inventory"."product_request" OWNER TO "postgres";

-- ALTER TABLE "inventory"."product_request" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
--     SEQUENCE NAME "inventory"."product_request_id_seq"
--     START WITH 1
--     INCREMENT BY 1
--     NO MINVALUE
--     NO MAXVALUE
--     CACHE 1
-- );

CREATE TABLE IF NOT EXISTS "inventory"."scraped_product" (
    "id" integer NOT NULL,
    "bar_code" "text",
    "kit_kat_ref" "text",
    "source" "text" NOT NULL,
    "scrape_date" timestamp with time zone,
    "price_category" "text",
    "original_price" numeric,
    "offer_price" "text",
    "source_code" "text",
    "name" "text",
    "description" "text",
    "category" "text",
    "additional1" "text",
    "ingredients" "text",
    "usage" "text",
    "features" "text",
    "affiliation" "text",
    "promotion" boolean,
    "url" "text",
    "region" "text",
    "brand" "text",
    "keyword" "text"
);

ALTER TABLE "inventory"."scraped_product" OWNER TO "postgres";

-- ALTER TABLE "inventory"."scraped_product" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
--     SEQUENCE NAME "inventory"."scraped_product_id_seq"
--     START WITH 1
--     INCREMENT BY 1
--     NO MINVALUE
--     NO MAXVALUE
--     CACHE 1
-- );

CREATE TABLE IF NOT EXISTS "public"."basket" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "name" "text" NOT NULL,
    "type" "public"."basket_type"
);

ALTER TABLE "public"."basket" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."basket_product" (
    "basket_id" "uuid" NOT NULL,
    "product_id" integer NOT NULL,
    "quantity" integer DEFAULT 1 NOT NULL,
    "substitute_brand" boolean DEFAULT false NOT NULL,
    "substitute_variant" boolean DEFAULT false NOT NULL
);

ALTER TABLE "public"."basket_product" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."profile" (
    "user_id" "uuid" NOT NULL,
    "rsa_id_number" "text",
    "first_name" "text",
    "last_name" "text",
    "email" "text",
    "phone" "text",
    "is_active" boolean DEFAULT true,
    "deactivated_on" timestamp with time zone,
    "accepted_ts_and_cs" boolean DEFAULT true NOT NULL,
    "role" "public"."user_role" DEFAULT 'Ubuntunist'::"public"."user_role" NOT NULL,
    "corp_name" "text",
    "npc_reg" "text",
    "corp_reg" "text",
    "corp_address_id" integer,
    "corp_vat_no" "text",
    "is_approved" boolean DEFAULT true NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "referral_code" integer NOT NULL,
    "class" "public"."user_class",
    "is_verified" boolean DEFAULT false NOT NULL
);

ALTER TABLE "public"."profile" OWNER TO "postgres";

-- ALTER TABLE "public"."profile" ALTER COLUMN "referral_code" ADD GENERATED BY DEFAULT AS IDENTITY (
--     SEQUENCE NAME "public"."profile_referral_code_seq1"
--     START WITH 14750
--     INCREMENT BY 1
--     NO MINVALUE
--     NO MAXVALUE
--     CACHE 1
-- );

CREATE TABLE IF NOT EXISTS "public"."referral" (
    "referrer_user_id" "uuid" NOT NULL,
    "refereed_user_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "transaction_id" integer NOT NULL,
    "is_completed" boolean DEFAULT false NOT NULL
);

ALTER TABLE "public"."referral" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "sales"."order" (
    "id" integer NOT NULL,
    "customer_id" "uuid" NOT NULL,
    "eesupreneur_id" "uuid",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "placed_at" timestamp with time zone,
    "packaged_at" timestamp with time zone,
    "ready_at" timestamp with time zone,
    "collected_at" timestamp with time zone,
    "cancelled_at" timestamp with time zone,
    "payment_method" "finances"."payment_method" NOT NULL,
    "secret_pin" integer DEFAULT "sales"."generate_order_secret_pin"() NOT NULL,
    "delivery_address_id" integer,
    "delivery_fee" numeric,
    "status" "sales"."order_status" DEFAULT 'Pending'::"sales"."order_status" NOT NULL,
    "eesupool_order_id" integer,
    "value" numeric,
    "card_fee" numeric
);

ALTER TABLE "sales"."order" OWNER TO "postgres";

-- ALTER TABLE "sales"."order" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
--     SEQUENCE NAME "sales"."order_id_seq"
--     START WITH 101883
--     INCREMENT BY 1
--     NO MINVALUE
--     NO MAXVALUE
--     CACHE 1
-- );

CREATE TABLE IF NOT EXISTS "sales"."order_product" (
    "product_id" integer NOT NULL,
    "order_id" integer NOT NULL,
    "vat" numeric DEFAULT 0.00 NOT NULL,
    "cia" numeric DEFAULT 0.00 NOT NULL,
    "cwa" numeric DEFAULT 0.00 NOT NULL,
    "eia" numeric DEFAULT 0.00 NOT NULL,
    "crc" numeric DEFAULT 0.00 NOT NULL,
    "csa" numeric DEFAULT 0.00 NOT NULL,
    "daa" numeric DEFAULT 0.00 NOT NULL,
    "vaa" numeric DEFAULT 0.00 NOT NULL,
    "quantity" integer NOT NULL,
    "voucher_allocated" boolean,
    "price" numeric DEFAULT 0.00 NOT NULL,
    "customer_accepted_qty" integer DEFAULT 0 NOT NULL,
    "eesupreneur_accepted_qty" integer DEFAULT 0 NOT NULL,
    "substitute_brand" boolean DEFAULT false NOT NULL,
    "substitute_variant" boolean DEFAULT false NOT NULL,
    "cfv" numeric DEFAULT 0.00 NOT NULL
);

ALTER TABLE "sales"."order_product" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "sales"."order_ticket" (
    "id" bigint NOT NULL,
    "order_id" integer NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "customer_comment" "text",
    "eesupreneur_comment" "text",
    "products" "jsonb"[] NOT NULL,
    "attachments" "jsonb"[] DEFAULT '{}'::"jsonb"[] NOT NULL,
    "resolution" "sales"."ticket_resolution_type" NOT NULL,
    "eesupreneur_confirmed_at" timestamp with time zone,
    "customer_confirmed_at" timestamp with time zone,
    "eesup_confirmed_at" timestamp with time zone,
    "items_missing" boolean NOT NULL
);

ALTER TABLE "sales"."order_ticket" OWNER TO "postgres";

-- ALTER TABLE "sales"."order_ticket" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
--     SEQUENCE NAME "sales"."order_ticket_id_seq"
--     START WITH 1
--     INCREMENT BY 1
--     NO MINVALUE
--     NO MAXVALUE
--     CACHE 1
-- );

CREATE TABLE IF NOT EXISTS "sales"."order_transaction" (
    "order_id" integer NOT NULL,
    "transaction_id" integer NOT NULL
);

ALTER TABLE "sales"."order_transaction" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "services"."eesupreneur" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "owner_id" "uuid" NOT NULL,
    "name" "text" NOT NULL,
    "description" "text",
    "address_id" integer,
    "created_at" timestamp with time zone DEFAULT ("now"() AT TIME ZONE 'utc'::"text") NOT NULL,
    "is_hidden" boolean DEFAULT false NOT NULL,
    "is_active" boolean DEFAULT true NOT NULL,
    "delivery_fee" numeric DEFAULT 0.00 NOT NULL,
    "schedule" "jsonb" DEFAULT '{"days": [{"day": "Friday", "open": "08:00", "close": "18:00", "index": 5, "is_closed": false}, {"day": "Monday", "open": "08:00", "close": "18:00", "index": 1, "is_closed": false}, {"day": "Sunday", "open": "08:00", "close": "18:00", "index": 7, "is_closed": false}, {"day": "Tuesday", "open": "08:00", "close": "18:00", "index": 2, "is_closed": false}, {"day": "Saturday", "open": "08:00", "close": "18:00", "index": 6, "is_closed": false}, {"day": "Thursday", "open": "08:00", "close": "18:00", "index": 4, "is_closed": false}, {"day": "Wednesday", "open": "08:00", "close": "18:00", "index": 3, "is_closed": false}]}'::"jsonb" NOT NULL
);

ALTER TABLE "services"."eesupreneur" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "services"."eesupreneur_employee" (
    "user_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "eesupreneur_id" "uuid" NOT NULL,
    "role" "public"."eesupreneur_employee_role" NOT NULL
);

ALTER TABLE "services"."eesupreneur_employee" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "services"."partner" (
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "id" "text" NOT NULL,
    "title" "text" NOT NULL,
    "description" "text" NOT NULL,
    "surveys" "jsonb"[],
    "is_open" boolean DEFAULT false NOT NULL,
    "max_apps" integer DEFAULT 1 NOT NULL,
    "requirements" "jsonb",
    "roles" "public"."user_role"[] NOT NULL
);

ALTER TABLE "services"."partner" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "services"."partner_application" (
    "partner_id" "text" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "survey_responses" "jsonb"[] NOT NULL,
    "id" integer NOT NULL,
    "approved_at" timestamp with time zone,
    "rejected_at" timestamp with time zone
);

ALTER TABLE "services"."partner_application" OWNER TO "postgres";

-- ALTER TABLE "services"."partner_application" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
--     SEQUENCE NAME "services"."partner_application_id_seq"
--     START WITH 13230
--     INCREMENT BY 3
--     NO MINVALUE
--     NO MAXVALUE
--     CACHE 1
-- );

CREATE TABLE IF NOT EXISTS "system_configs"."api_key" (
    "id" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "key" "text" NOT NULL,
    "is_active" boolean NOT NULL
);

ALTER TABLE "system_configs"."api_key" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "system_configs"."remote_config" (
    "id" "text" NOT NULL,
    "text_value" "text",
    "num_value" numeric,
    "json_value" "jsonb",
    "app" "public"."app_type"
);

ALTER TABLE "system_configs"."remote_config" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "warehousing"."distribution_centre" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "name" "text" NOT NULL,
    "address_id" integer
);

ALTER TABLE "warehousing"."distribution_centre" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "warehousing"."supplier" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "name" "text" NOT NULL
);

ALTER TABLE "warehousing"."supplier" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "warehousing"."warehouse" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "name" "text" NOT NULL,
    "address_id" integer
);

ALTER TABLE "warehousing"."warehouse" OWNER TO "postgres";

-- ALTER TABLE ONLY "communities"."eesupool_issue"
--     ADD CONSTRAINT "eesupool_issue_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "communities"."eesupool_member"
--     ADD CONSTRAINT "eesupool_member_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "communities"."eesupool_order"
--     ADD CONSTRAINT "eesupool_order_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "communities"."eesupool"
--     ADD CONSTRAINT "eesupool_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "communities"."eesupool_request"
--     ADD CONSTRAINT "eesupool_request_pkey" PRIMARY KEY ("user_id", "eesupool_id");

-- ALTER TABLE ONLY "communities"."event_attendee"
--     ADD CONSTRAINT "event_attandee_pkey" PRIMARY KEY ("event_id", "member_id");

-- ALTER TABLE ONLY "communities"."event"
--     ADD CONSTRAINT "event_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "communities"."member_order_assignment"
--     ADD CONSTRAINT "member_order_assignment_pkey" PRIMARY KEY ("order_id", "eesupool_ord_id", "member_id");

-- ALTER TABLE ONLY "communities"."message"
--     ADD CONSTRAINT "message_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "communities"."message_reaction"
--     ADD CONSTRAINT "message_reaction_pkey" PRIMARY KEY ("member_id", "message_id");

-- ALTER TABLE ONLY "communities"."message_seen"
--     ADD CONSTRAINT "message_read_pkey" PRIMARY KEY ("member_id", "message_id");

-- ALTER TABLE ONLY "communities"."eesupool"
--     ADD CONSTRAINT "stokvel_name_key" UNIQUE ("name");

-- ALTER TABLE ONLY "communities"."eesupool_member"
--     ADD CONSTRAINT "unique_eesupool_member" UNIQUE ("user_id", "eesupool_id");

-- ALTER TABLE ONLY "communities"."eesupool_request"
--     ADD CONSTRAINT "unique_user_and_pool_ids" UNIQUE ("user_id", "eesupool_id");

-- ALTER TABLE ONLY "engagements"."banner"
--     ADD CONSTRAINT "banner_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "engagements"."response"
--     ADD CONSTRAINT "limit_user_to_one_response" UNIQUE ("user_id", "survey_id");

-- ALTER TABLE ONLY "engagements"."notification"
--     ADD CONSTRAINT "notification_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "engagements"."response"
--     ADD CONSTRAINT "response_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "engagements"."survey"
--     ADD CONSTRAINT "survey_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "finances"."online_payment"
--     ADD CONSTRAINT "online_payment_pkey" PRIMARY KEY ("payment_id");

-- ALTER TABLE ONLY "finances"."online_payment"
--     ADD CONSTRAINT "online_payment_secondary_id_key" UNIQUE ("secondary_id");

-- ALTER TABLE ONLY "finances"."payment_gateway"
--     ADD CONSTRAINT "payment_gateway_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "finances"."payout_request"
--     ADD CONSTRAINT "payout_request_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "finances"."profit_allocation"
--     ADD CONSTRAINT "profit_allocation_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "finances"."transaction"
--     ADD CONSTRAINT "transaction_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "finances"."transaction_type"
--     ADD CONSTRAINT "transaction_type_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "finances"."voucher_ledger"
--     ADD CONSTRAINT "voucher_ledger_pkey" PRIMARY KEY ("voucher_id", "transaction_id");

-- ALTER TABLE ONLY "finances"."voucher_parameter"
--     ADD CONSTRAINT "voucher_parameter_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "finances"."voucher"
--     ADD CONSTRAINT "voucher_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "finances"."wallet"
--     ADD CONSTRAINT "wallet_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "finances"."wallet_transaction"
--     ADD CONSTRAINT "wallet_transaction_pkey" PRIMARY KEY ("wallet_id", "transaction_id");

-- ALTER TABLE ONLY "finances"."wallet_type"
--     ADD CONSTRAINT "wallet_type_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "geolocations"."address"
--     ADD CONSTRAINT "address_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "geolocations"."target_area"
--     ADD CONSTRAINT "target_area_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "inventory"."category"
--     ADD CONSTRAINT "category_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "inventory"."product"
--     ADD CONSTRAINT "product_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "inventory"."product_request"
--     ADD CONSTRAINT "product_request_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "inventory"."scraped_product"
--     ADD CONSTRAINT "scraped_product_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "public"."basket_product"
--     ADD CONSTRAINT "basket_product_pkey" PRIMARY KEY ("basket_id", "product_id");

-- ALTER TABLE ONLY "public"."profile"
--     ADD CONSTRAINT "profile_email_key" UNIQUE ("email");

-- ALTER TABLE ONLY "public"."profile"
--     ADD CONSTRAINT "profile_phone_key" UNIQUE ("phone");

-- ALTER TABLE ONLY "public"."referral"
--     ADD CONSTRAINT "referral_pkey" PRIMARY KEY ("referrer_user_id", "refereed_user_id");

-- ALTER TABLE ONLY "public"."profile"
--     ADD CONSTRAINT "users_pkey" PRIMARY KEY ("user_id");

-- ALTER TABLE ONLY "public"."profile"
--     ADD CONSTRAINT "users_rsa_id_number_key" UNIQUE ("rsa_id_number");

-- ALTER TABLE ONLY "public"."basket"
--     ADD CONSTRAINT "wishlist_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "sales"."order"
--     ADD CONSTRAINT "order_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "sales"."order_product"
--     ADD CONSTRAINT "order_product_pkey" PRIMARY KEY ("product_id", "order_id");

-- ALTER TABLE ONLY "sales"."order_ticket"
--     ADD CONSTRAINT "order_ticket_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "sales"."order_transaction"
--     ADD CONSTRAINT "order_transaction_pkey" PRIMARY KEY ("order_id", "transaction_id");

-- ALTER TABLE ONLY "services"."eesupreneur_employee"
--     ADD CONSTRAINT "eesupreneur_employee_pkey" PRIMARY KEY ("user_id", "eesupreneur_id");

-- ALTER TABLE ONLY "services"."eesupreneur"
--     ADD CONSTRAINT "eesupreneur_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "services"."partner_application"
--     ADD CONSTRAINT "partner_application_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "services"."partner"
--     ADD CONSTRAINT "service_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "system_configs"."api_key"
--     ADD CONSTRAINT "api_key_key_key" UNIQUE ("key");

-- ALTER TABLE ONLY "system_configs"."api_key"
--     ADD CONSTRAINT "api_key_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "system_configs"."remote_config"
--     ADD CONSTRAINT "remote_config_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "warehousing"."distribution_centre"
--     ADD CONSTRAINT "distribution_centre_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "warehousing"."supplier"
--     ADD CONSTRAINT "supplier_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "warehousing"."warehouse"
--     ADD CONSTRAINT "warehouse_pkey" PRIMARY KEY ("id");

CREATE OR REPLACE TRIGGER "broadcast_eesupool_message_trigger" AFTER INSERT ON "communities"."message" FOR EACH ROW EXECUTE FUNCTION "communities"."broadcast_eesupool_message"();

CREATE OR REPLACE TRIGGER "create_eesupool_invite_notification_triggere" AFTER INSERT ON "communities"."eesupool_request" FOR EACH ROW EXECUTE FUNCTION "communities"."create_eesupool_invite_notification"();

CREATE OR REPLACE TRIGGER "create_eesupool_member_trigger" AFTER INSERT OR UPDATE ON "communities"."eesupool_request" FOR EACH ROW EXECUTE FUNCTION "communities"."create_eesupool_member"();

CREATE OR REPLACE TRIGGER "create_eesupool_message_notification_trigger" AFTER INSERT ON "communities"."message" FOR EACH ROW EXECUTE FUNCTION "communities"."notify_eesupool_members"();

CREATE OR REPLACE TRIGGER "generate_pool_order_secret_pin_trigger" BEFORE INSERT ON "communities"."eesupool_order" FOR EACH ROW EXECUTE FUNCTION "communities"."generate_pool_order_secret_pin"();

CREATE OR REPLACE TRIGGER "on_invite_revoked_delete_notification_trigger" AFTER DELETE ON "communities"."eesupool_request" FOR EACH ROW EXECUTE FUNCTION "communities"."on_invite_revoked_delete_notification"();

CREATE OR REPLACE TRIGGER "send_order_update_notification_trigger" AFTER INSERT ON "engagements"."notification" FOR EACH ROW EXECUTE FUNCTION "engagements"."send_order_update_notification"();

CREATE OR REPLACE TRIGGER "send_push_notification_trigger" AFTER INSERT ON "engagements"."notification" FOR EACH ROW EXECUTE FUNCTION "engagements"."send_push_notification_on_insert"();

CREATE OR REPLACE TRIGGER "generate_transaction_doc_ref_trigger" BEFORE INSERT ON "finances"."transaction" FOR EACH ROW EXECUTE FUNCTION "finances"."generate_transaction_doc_ref"();

CREATE OR REPLACE TRIGGER "on_payment_confirmed_trigger" AFTER INSERT OR UPDATE ON "finances"."online_payment" FOR EACH ROW EXECUTE FUNCTION "finances"."on_payment_confirmed"();

CREATE OR REPLACE TRIGGER "update_wallet_balance_on_txn_confirmed_trigger" AFTER UPDATE ON "finances"."transaction" FOR EACH ROW EXECUTE FUNCTION "finances"."update_wallet_balance_on_txn_confirmed"();

CREATE OR REPLACE TRIGGER "check_and_update_verification_trigger" AFTER INSERT OR UPDATE ON "geolocations"."address" FOR EACH ROW EXECUTE FUNCTION "public"."check_and_update_verification"();

CREATE OR REPLACE TRIGGER "verify_address_trigger" BEFORE INSERT OR UPDATE ON "geolocations"."address" FOR EACH ROW EXECUTE FUNCTION "geolocations"."verify_address"();

CREATE OR REPLACE TRIGGER "check_and_update_verification_trgigger" AFTER UPDATE ON "public"."profile" FOR EACH ROW EXECUTE FUNCTION "public"."check_and_update_verification"();

CREATE OR REPLACE TRIGGER "create_user_default_basket_trigger" AFTER INSERT ON "public"."profile" FOR EACH ROW EXECUTE FUNCTION "public"."create_user_default_basket"();

CREATE OR REPLACE TRIGGER "create_user_wallets_trigger" AFTER INSERT ON "public"."profile" FOR EACH ROW EXECUTE FUNCTION "finances"."create_user_wallets"();

CREATE OR REPLACE TRIGGER "on_profile_verified_complete_referral_trigger" AFTER UPDATE ON "public"."profile" FOR EACH ROW EXECUTE FUNCTION "public"."on_profile_verified_complete_referral"();

CREATE OR REPLACE TRIGGER "allocate_profit_earnings_for_eesupreneur_orders_trigger" AFTER UPDATE ON "sales"."order" FOR EACH ROW EXECUTE FUNCTION "sales"."allocate_profit_earnings_for_eesupreneur_orders"();

CREATE OR REPLACE TRIGGER "set_default_order_assignment_trigger" AFTER INSERT ON "sales"."order" FOR EACH ROW EXECUTE FUNCTION "communities"."set_default_order_assignment"();

CREATE OR REPLACE TRIGGER "update_product_allocations_on_new_order_product_trigger" BEFORE INSERT ON "sales"."order_product" FOR EACH ROW EXECUTE FUNCTION "sales"."update_product_allocations_on_new_order_product"();

CREATE OR REPLACE TRIGGER "notify_applicant_on_application_update_trigger" AFTER UPDATE ON "services"."partner_application" FOR EACH STATEMENT EXECUTE FUNCTION "services"."notify_applicant_on_application_update"();

CREATE OR REPLACE TRIGGER "on_partner_application_approved_trigger" AFTER INSERT OR UPDATE ON "services"."partner_application" FOR EACH ROW EXECUTE FUNCTION "services"."on_partner_application_approved"();

CREATE OR REPLACE TRIGGER "prevent_editing_of_the_partner_id_value_trigger" BEFORE UPDATE ON "services"."partner" FOR EACH ROW EXECUTE FUNCTION "services"."prevent_editing_of_the_partner_id_value"();

-- ALTER TABLE ONLY "communities"."eesupool"
--     ADD CONSTRAINT "eesupool_address_id_fkey" FOREIGN KEY ("address_id") REFERENCES "geolocations"."address"("id") ON DELETE SET NULL;

-- ALTER TABLE ONLY "communities"."eesupool_issue"
--     ADD CONSTRAINT "eesupool_issue_eesupool_id_fkey" FOREIGN KEY ("eesupool_id") REFERENCES "communities"."eesupool"("id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "communities"."eesupool_issue"
--     ADD CONSTRAINT "eesupool_issue_message_id_fkey" FOREIGN KEY ("message_id") REFERENCES "communities"."message"("id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "communities"."eesupool_issue"
--     ADD CONSTRAINT "eesupool_issue_offender_id_fkey" FOREIGN KEY ("offender_id") REFERENCES "communities"."eesupool_member"("id") ON DELETE SET NULL;

-- ALTER TABLE ONLY "communities"."eesupool_issue"
--     ADD CONSTRAINT "eesupool_issue_parent_pool_id_fkey" FOREIGN KEY ("parent_pool_id") REFERENCES "communities"."eesupool"("id") ON DELETE SET NULL;

-- ALTER TABLE ONLY "communities"."eesupool_issue"
--     ADD CONSTRAINT "eesupool_issue_reporter_id_fkey" FOREIGN KEY ("reporter_id") REFERENCES "communities"."eesupool_member"("id") ON DELETE SET NULL;

-- ALTER TABLE ONLY "communities"."eesupool_member"
--     ADD CONSTRAINT "eesupool_member_eesupool_id_fkey" FOREIGN KEY ("eesupool_id") REFERENCES "communities"."eesupool"("id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "communities"."eesupool_member"
--     ADD CONSTRAINT "eesupool_member_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profile"("user_id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "communities"."eesupool_order"
--     ADD CONSTRAINT "eesupool_order_address_id_fkey" FOREIGN KEY ("address_id") REFERENCES "geolocations"."address"("id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "communities"."eesupool_order"
--     ADD CONSTRAINT "eesupool_order_eesupool_id_fkey" FOREIGN KEY ("eesupool_id") REFERENCES "communities"."eesupool"("id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "communities"."eesupool"
--     ADD CONSTRAINT "eesupool_parent_id_fkey" FOREIGN KEY ("parent_id") REFERENCES "communities"."eesupool"("id") ON DELETE SET NULL;

-- ALTER TABLE ONLY "communities"."eesupool_request"
--     ADD CONSTRAINT "eesupool_request_eesupool_id_fkey" FOREIGN KEY ("eesupool_id") REFERENCES "communities"."eesupool"("id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "communities"."eesupool_request"
--     ADD CONSTRAINT "eesupool_request_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profile"("user_id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "communities"."event"
--     ADD CONSTRAINT "event_address_id_fkey" FOREIGN KEY ("address_id") REFERENCES "geolocations"."address"("id") ON DELETE SET NULL;

-- ALTER TABLE ONLY "communities"."event_attendee"
--     ADD CONSTRAINT "event_attendee_event_id_fkey" FOREIGN KEY ("event_id") REFERENCES "communities"."event"("id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "communities"."event_attendee"
--     ADD CONSTRAINT "event_attendee_member_id_fkey" FOREIGN KEY ("member_id") REFERENCES "communities"."eesupool_member"("id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "communities"."event"
--     ADD CONSTRAINT "event_eesupool_id_fkey" FOREIGN KEY ("eesupool_id") REFERENCES "communities"."eesupool"("id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "communities"."member_order_assignment"
--     ADD CONSTRAINT "member_order_assignment_eesupool_ord_id_fkey" FOREIGN KEY ("eesupool_ord_id") REFERENCES "communities"."eesupool_order"("id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "communities"."member_order_assignment"
--     ADD CONSTRAINT "member_order_assignment_member_id_fkey" FOREIGN KEY ("member_id") REFERENCES "communities"."eesupool_member"("id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "communities"."member_order_assignment"
--     ADD CONSTRAINT "member_order_assignment_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "sales"."order"("id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "communities"."message"
--     ADD CONSTRAINT "message_author_id_fkey" FOREIGN KEY ("author_id") REFERENCES "communities"."eesupool_member"("id") ON DELETE SET NULL;

-- ALTER TABLE ONLY "communities"."message"
--     ADD CONSTRAINT "message_eesupool_id_fkey" FOREIGN KEY ("eesupool_id") REFERENCES "communities"."eesupool"("id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "communities"."message_reaction"
--     ADD CONSTRAINT "message_reaction_member_id_fkey" FOREIGN KEY ("member_id") REFERENCES "communities"."eesupool_member"("id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "communities"."message_reaction"
--     ADD CONSTRAINT "message_reaction_message_id_fkey" FOREIGN KEY ("message_id") REFERENCES "communities"."message"("id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "communities"."message_seen"
--     ADD CONSTRAINT "message_seen_member_id_fkey" FOREIGN KEY ("member_id") REFERENCES "communities"."eesupool_member"("id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "communities"."message_seen"
--     ADD CONSTRAINT "message_seen_message_id_fkey" FOREIGN KEY ("message_id") REFERENCES "communities"."message"("id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "engagements"."notification"
--     ADD CONSTRAINT "notification_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profile"("user_id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "engagements"."response"
--     ADD CONSTRAINT "response_survey_id_fkey" FOREIGN KEY ("survey_id") REFERENCES "engagements"."survey"("id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "engagements"."response"
--     ADD CONSTRAINT "response_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profile"("user_id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "engagements"."survey"
--     ADD CONSTRAINT "survey_pre_id_fkey" FOREIGN KEY ("pre_id") REFERENCES "engagements"."survey"("id") ON DELETE SET NULL;

-- ALTER TABLE ONLY "engagements"."survey"
--     ADD CONSTRAINT "survey_wallet_fkey" FOREIGN KEY ("wallet") REFERENCES "finances"."wallet_type"("id") ON DELETE SET NULL;

-- ALTER TABLE ONLY "finances"."online_payment"
--     ADD CONSTRAINT "finances_online_payment_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profile"("user_id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "finances"."voucher_ledger"
--     ADD CONSTRAINT "finances_voucher_ledger_transaction_id_fkey" FOREIGN KEY ("transaction_id") REFERENCES "finances"."transaction"("id") ON UPDATE CASCADE ON DELETE CASCADE;

-- ALTER TABLE ONLY "finances"."voucher_ledger"
--     ADD CONSTRAINT "finances_voucher_ledger_voucher_id_fkey" FOREIGN KEY ("voucher_id") REFERENCES "finances"."voucher"("id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "finances"."voucher"
--     ADD CONSTRAINT "finances_voucher_parameter_id_fkey" FOREIGN KEY ("parameter_id") REFERENCES "finances"."voucher_parameter"("id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "finances"."voucher"
--     ADD CONSTRAINT "finances_voucher_wallet_id_fkey" FOREIGN KEY ("wallet_id") REFERENCES "finances"."wallet"("id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "finances"."transaction"
--     ADD CONSTRAINT "transaction_type_fkey" FOREIGN KEY ("type") REFERENCES "finances"."transaction_type"("id") ON DELETE SET NULL;

-- ALTER TABLE ONLY "finances"."wallet_transaction"
--     ADD CONSTRAINT "wallet_transaction_transaction_id_fkey" FOREIGN KEY ("transaction_id") REFERENCES "finances"."transaction"("id") ON UPDATE CASCADE ON DELETE CASCADE;

-- ALTER TABLE ONLY "finances"."wallet_transaction"
--     ADD CONSTRAINT "wallet_transaction_wallet_id_fkey" FOREIGN KEY ("wallet_id") REFERENCES "finances"."wallet"("id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "finances"."wallet"
--     ADD CONSTRAINT "wallet_type_fkey" FOREIGN KEY ("type") REFERENCES "finances"."wallet_type"("id") ON DELETE RESTRICT;

-- ALTER TABLE ONLY "finances"."wallet"
--     ADD CONSTRAINT "wallet_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profile"("user_id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "geolocations"."address"
--     ADD CONSTRAINT "address_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profile"("user_id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "geolocations"."address"
--     ADD CONSTRAINT "geolocations_address_area_id_fkey" FOREIGN KEY ("area_id") REFERENCES "geolocations"."target_area"("id") ON DELETE SET NULL;

-- ALTER TABLE ONLY "inventory"."category"
--     ADD CONSTRAINT "category_parent_id_fkey" FOREIGN KEY ("parent_id") REFERENCES "inventory"."category"("id") ON DELETE SET NULL;

-- ALTER TABLE ONLY "inventory"."product"
--     ADD CONSTRAINT "product_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "inventory"."category"("id") ON DELETE RESTRICT;

-- ALTER TABLE ONLY "inventory"."product_request"
--     ADD CONSTRAINT "product_request_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profile"("user_id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "public"."basket_product"
--     ADD CONSTRAINT "basket_product_basket_id_fkey" FOREIGN KEY ("basket_id") REFERENCES "public"."basket"("id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "public"."profile"
--     ADD CONSTRAINT "profile_new_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "public"."profile"
--     ADD CONSTRAINT "profile_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "public"."referral"
--     ADD CONSTRAINT "referral_refereed_user_id_fkey" FOREIGN KEY ("refereed_user_id") REFERENCES "public"."profile"("user_id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "public"."referral"
--     ADD CONSTRAINT "referral_referrer_user_id_fkey" FOREIGN KEY ("referrer_user_id") REFERENCES "public"."profile"("user_id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "public"."referral"
--     ADD CONSTRAINT "referral_transaction_id_fkey" FOREIGN KEY ("transaction_id") REFERENCES "finances"."transaction"("id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "public"."basket"
--     ADD CONSTRAINT "wishlist_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profile"("user_id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "sales"."order"
--     ADD CONSTRAINT "order_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "public"."profile"("user_id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "sales"."order"
--     ADD CONSTRAINT "order_delivery_address_id_fkey" FOREIGN KEY ("delivery_address_id") REFERENCES "geolocations"."address"("id") ON DELETE RESTRICT;

-- ALTER TABLE ONLY "sales"."order"
--     ADD CONSTRAINT "order_eesupool_order_id_fkey" FOREIGN KEY ("eesupool_order_id") REFERENCES "communities"."eesupool_order"("id") ON DELETE RESTRICT;

-- ALTER TABLE ONLY "sales"."order"
--     ADD CONSTRAINT "order_eesupreneur_id_fkey" FOREIGN KEY ("eesupreneur_id") REFERENCES "services"."eesupreneur"("id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "sales"."order_product"
--     ADD CONSTRAINT "order_product_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "sales"."order"("id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "sales"."order_ticket"
--     ADD CONSTRAINT "order_ticket_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "sales"."order"("id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "sales"."order_transaction"
--     ADD CONSTRAINT "order_transaction_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "sales"."order"("id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "sales"."order_transaction"
--     ADD CONSTRAINT "order_transaction_transaction_id_fkey" FOREIGN KEY ("transaction_id") REFERENCES "finances"."transaction"("id") ON UPDATE CASCADE ON DELETE CASCADE;

-- ALTER TABLE ONLY "services"."eesupreneur"
--     ADD CONSTRAINT "eesupreneur_address_id_fkey" FOREIGN KEY ("address_id") REFERENCES "geolocations"."address"("id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "services"."eesupreneur_employee"
--     ADD CONSTRAINT "eesupreneur_employee_eesupreneur_id_fkey" FOREIGN KEY ("eesupreneur_id") REFERENCES "services"."eesupreneur"("id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "services"."eesupreneur_employee"
--     ADD CONSTRAINT "eesupreneur_employee_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profile"("user_id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "services"."eesupreneur"
--     ADD CONSTRAINT "eesupreneur_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "public"."profile"("user_id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "services"."partner_application"
--     ADD CONSTRAINT "partner_application_partner_id_fkey" FOREIGN KEY ("partner_id") REFERENCES "services"."partner"("id") ON DELETE RESTRICT;

-- ALTER TABLE ONLY "services"."partner_application"
--     ADD CONSTRAINT "partner_application_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profile"("user_id") ON DELETE CASCADE;

-- ALTER TABLE ONLY "warehousing"."distribution_centre"
--     ADD CONSTRAINT "distribution_centre_address_id_fkey" FOREIGN KEY ("address_id") REFERENCES "geolocations"."address"("id") ON DELETE SET NULL;

-- ALTER TABLE ONLY "warehousing"."warehouse"
--     ADD CONSTRAINT "warehouse_address_id_fkey" FOREIGN KEY ("address_id") REFERENCES "geolocations"."address"("id") ON DELETE SET NULL;

-- CREATE POLICY "Enable access for authenticated users only" ON "communities"."eesupool_request" TO "authenticated" USING (true) WITH CHECK (true);

-- CREATE POLICY "Enable access for authenticated users only" ON "communities"."member_order_assignment" TO "authenticated" USING (true) WITH CHECK (true);

-- CREATE POLICY "Enable access to Authenticated Users only" ON "communities"."eesupool" TO "authenticated" USING (true);

-- CREATE POLICY "Enable access to Authenticated Users only" ON "communities"."eesupool_issue" TO "authenticated" USING (true);

-- CREATE POLICY "Enable access to Authenticated Users only" ON "communities"."eesupool_member" TO "authenticated" USING (true);

-- CREATE POLICY "Enable access to Authenticated Users only" ON "communities"."eesupool_order" TO "authenticated" USING (true);

-- CREATE POLICY "Enable access to Authenticated Users only" ON "communities"."event" TO "authenticated" USING (true);

-- CREATE POLICY "Enable access to Authenticated Users only" ON "communities"."event_attendee" TO "authenticated" USING (true);

-- CREATE POLICY "Enable access to Authenticated Users only" ON "communities"."message" TO "authenticated" USING (true);

-- CREATE POLICY "Enable access to Authenticated Users only" ON "communities"."message_reaction" TO "authenticated" USING (true);

-- CREATE POLICY "Enable access to Authenticated Users only" ON "communities"."message_seen" TO "authenticated" USING (true);

ALTER TABLE "communities"."eesupool" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "communities"."eesupool_issue" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "communities"."eesupool_member" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "communities"."eesupool_order" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "communities"."eesupool_request" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "communities"."event" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "communities"."event_attendee" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "communities"."member_order_assignment" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "communities"."message" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "communities"."message_reaction" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "communities"."message_seen" ENABLE ROW LEVEL SECURITY;

-- CREATE POLICY "Enable access for authenticated users only" ON "engagements"."banner" TO "authenticated" USING (true) WITH CHECK (true);

-- CREATE POLICY "Enable access for authenticated users only" ON "engagements"."notification" TO "authenticated" USING (true) WITH CHECK (true);

-- CREATE POLICY "Enable access to Authenticated Users only" ON "engagements"."response" TO "authenticated" USING (true);

-- CREATE POLICY "Enable access to Authenticated Users only" ON "engagements"."survey" TO "authenticated" USING (true);

ALTER TABLE "engagements"."banner" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "engagements"."notification" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "engagements"."response" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "engagements"."survey" ENABLE ROW LEVEL SECURITY;

-- CREATE POLICY "Enable access for authenticated users only" ON "finances"."online_payment" TO "authenticated" USING (true) WITH CHECK (true);

-- CREATE POLICY "Enable access for authenticated users only" ON "finances"."payment_gateway" TO "authenticated" USING (true) WITH CHECK (true);

-- CREATE POLICY "Enable access for authenticated users only" ON "finances"."profit_allocation" TO "authenticated" USING (true) WITH CHECK (true);

-- CREATE POLICY "Enable access for authenticated users only" ON "finances"."voucher" TO "authenticated" USING (true) WITH CHECK (true);

-- CREATE POLICY "Enable access for authenticated users only" ON "finances"."voucher_ledger" TO "authenticated" USING (true) WITH CHECK (true);

-- CREATE POLICY "Enable access for authenticated users only" ON "finances"."voucher_parameter" TO "authenticated" USING (true) WITH CHECK (true);

-- CREATE POLICY "Enable access to Authenticated Users only" ON "finances"."transaction" TO "authenticated" USING (true) WITH CHECK (true);

-- CREATE POLICY "Enable access to Authenticated Users only" ON "finances"."transaction_type" TO "authenticated" USING (true);

-- CREATE POLICY "Enable access to Authenticated Users only" ON "finances"."wallet" TO "authenticated" USING (true);

-- CREATE POLICY "Enable access to Authenticated Users only" ON "finances"."wallet_transaction" TO "authenticated" USING (true) WITH CHECK (true);

-- CREATE POLICY "Enable access to Authenticated Users only" ON "finances"."wallet_type" TO "authenticated" USING (true);

ALTER TABLE "finances"."online_payment" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "finances"."payment_gateway" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "finances"."payout_request" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "finances"."profit_allocation" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "finances"."transaction" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "finances"."transaction_type" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "finances"."voucher" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "finances"."voucher_ledger" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "finances"."voucher_parameter" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "finances"."wallet" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "finances"."wallet_transaction" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "finances"."wallet_type" ENABLE ROW LEVEL SECURITY;

-- CREATE POLICY "Enable access for authenticated users only" ON "geolocations"."address" TO "authenticated" USING (true) WITH CHECK (true);

-- CREATE POLICY "Enable access for authenticated users only" ON "geolocations"."target_area" TO "authenticated" USING (true) WITH CHECK (true);

ALTER TABLE "geolocations"."address" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "geolocations"."target_area" ENABLE ROW LEVEL SECURITY;

-- CREATE POLICY "Enable access for authenticated users only" ON "inventory"."product_request" TO "authenticated" USING (true) WITH CHECK (true);

-- CREATE POLICY "Enable access to Authenticated Users only" ON "inventory"."category" TO "authenticated" USING (true);

-- CREATE POLICY "Enable access to Authenticated Users only" ON "inventory"."product" TO "authenticated" USING (true);

ALTER TABLE "inventory"."category" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "inventory"."product" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "inventory"."product_request" ENABLE ROW LEVEL SECURITY;

-- CREATE POLICY "Enable access for authenticated users only" ON "public"."profile" TO "authenticated" USING (true) WITH CHECK (true);

-- CREATE POLICY "Enable access to Authenticated Users only" ON "public"."basket" TO "authenticated" USING (true);

-- CREATE POLICY "Enable access to Authenticated Users only" ON "public"."basket_product" TO "authenticated" USING (true);

-- CREATE POLICY "Enable access to Authenticated Users only" ON "public"."referral" TO "authenticated" USING (true);

-- CREATE POLICY "Enable read access for all users" ON "public"."profile" FOR SELECT USING (true);

ALTER TABLE "public"."basket" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."basket_product" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."profile" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."referral" ENABLE ROW LEVEL SECURITY;

-- CREATE POLICY "Enable access for authenticated users only" ON "sales"."order_transaction" TO "authenticated" USING (true) WITH CHECK (true);

-- CREATE POLICY "Enable access to Authenticated Users only" ON "sales"."order" TO "authenticated" USING (true);

-- CREATE POLICY "Enable access to Authenticated Users only" ON "sales"."order_product" TO "authenticated" USING (true);

-- CREATE POLICY "Enable for authenticated users only" ON "sales"."order_ticket" TO "authenticated" USING (true) WITH CHECK (true);

ALTER TABLE "sales"."order" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "sales"."order_product" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "sales"."order_ticket" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "sales"."order_transaction" ENABLE ROW LEVEL SECURITY;

-- CREATE POLICY "Enable access for authenticated users only" ON "services"."eesupreneur_employee" TO "authenticated" USING (true) WITH CHECK (true);

-- CREATE POLICY "Enable access for authenticated users only" ON "services"."partner" TO "authenticated" USING (true) WITH CHECK (true);

-- CREATE POLICY "Enable access for authenticated users only" ON "services"."partner_application" TO "authenticated" USING (true) WITH CHECK (true);

-- CREATE POLICY "Enable access to Authenticated Users only" ON "services"."eesupreneur" TO "authenticated" USING (true);

ALTER TABLE "services"."eesupreneur" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "services"."eesupreneur_employee" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "services"."partner" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "services"."partner_application" ENABLE ROW LEVEL SECURITY;

-- CREATE POLICY "Enable access for authenticated users only" ON "system_configs"."api_key" TO "authenticated" USING (true) WITH CHECK (true);

-- CREATE POLICY "Enable access for authenticated users only" ON "system_configs"."remote_config" TO "authenticated" USING (true) WITH CHECK (true);

ALTER TABLE "system_configs"."api_key" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "system_configs"."remote_config" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "warehousing"."distribution_centre" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "warehousing"."supplier" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "warehousing"."warehouse" ENABLE ROW LEVEL SECURITY;

ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";

-- ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "communities"."message";

-- ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "communities"."message_reaction";

-- ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "engagements"."notification";

-- ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "sales"."order";

GRANT USAGE ON SCHEMA "communities" TO "anon";
GRANT USAGE ON SCHEMA "communities" TO "authenticated";
GRANT USAGE ON SCHEMA "communities" TO "service_role";

GRANT USAGE ON SCHEMA "engagements" TO "anon";
GRANT USAGE ON SCHEMA "engagements" TO "authenticated";
GRANT USAGE ON SCHEMA "engagements" TO "service_role";

GRANT USAGE ON SCHEMA "finances" TO "anon";
GRANT USAGE ON SCHEMA "finances" TO "authenticated";
GRANT USAGE ON SCHEMA "finances" TO "service_role";

GRANT USAGE ON SCHEMA "geolocations" TO "anon";
GRANT USAGE ON SCHEMA "geolocations" TO "authenticated";
GRANT USAGE ON SCHEMA "geolocations" TO "service_role";

GRANT USAGE ON SCHEMA "inventory" TO "anon";
GRANT USAGE ON SCHEMA "inventory" TO "authenticated";
GRANT USAGE ON SCHEMA "inventory" TO "service_role";

GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";

GRANT USAGE ON SCHEMA "sales" TO "anon";
GRANT USAGE ON SCHEMA "sales" TO "authenticated";
GRANT USAGE ON SCHEMA "sales" TO "service_role";

GRANT USAGE ON SCHEMA "services" TO "anon";
GRANT USAGE ON SCHEMA "services" TO "authenticated";
GRANT USAGE ON SCHEMA "services" TO "service_role";

GRANT USAGE ON SCHEMA "system_configs" TO "anon";
GRANT USAGE ON SCHEMA "system_configs" TO "authenticated";
GRANT USAGE ON SCHEMA "system_configs" TO "service_role";

GRANT USAGE ON SCHEMA "warehousing" TO "anon";
GRANT USAGE ON SCHEMA "warehousing" TO "authenticated";
GRANT USAGE ON SCHEMA "warehousing" TO "service_role";

GRANT ALL ON FUNCTION "communities"."add_or_delete_reaction"("_message_id" integer, "_member_id" "uuid", "_liked" boolean) TO "anon";
GRANT ALL ON FUNCTION "communities"."add_or_delete_reaction"("_message_id" integer, "_member_id" "uuid", "_liked" boolean) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."add_or_delete_reaction"("_message_id" integer, "_member_id" "uuid", "_liked" boolean) TO "service_role";

GRANT ALL ON FUNCTION "communities"."broadcast_eesupool_message"() TO "anon";
GRANT ALL ON FUNCTION "communities"."broadcast_eesupool_message"() TO "authenticated";
GRANT ALL ON FUNCTION "communities"."broadcast_eesupool_message"() TO "service_role";

GRANT ALL ON FUNCTION "communities"."count_unseen_messages"("_eesupool_id" integer, "_member_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "communities"."count_unseen_messages"("_eesupool_id" integer, "_member_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "communities"."count_unseen_messages"("_eesupool_id" integer, "_member_id" "uuid") TO "service_role";

GRANT ALL ON FUNCTION "communities"."count_user_eesupools_by_type"("_id" "uuid", "_type" "communities"."eesupool_type") TO "anon";
GRANT ALL ON FUNCTION "communities"."count_user_eesupools_by_type"("_id" "uuid", "_type" "communities"."eesupool_type") TO "authenticated";
GRANT ALL ON FUNCTION "communities"."count_user_eesupools_by_type"("_id" "uuid", "_type" "communities"."eesupool_type") TO "service_role";

GRANT ALL ON FUNCTION "communities"."create_eesupool_invite_notification"() TO "anon";
GRANT ALL ON FUNCTION "communities"."create_eesupool_invite_notification"() TO "authenticated";
GRANT ALL ON FUNCTION "communities"."create_eesupool_invite_notification"() TO "service_role";

GRANT ALL ON FUNCTION "communities"."create_eesupool_member"() TO "anon";
GRANT ALL ON FUNCTION "communities"."create_eesupool_member"() TO "authenticated";
GRANT ALL ON FUNCTION "communities"."create_eesupool_member"() TO "service_role";

GRANT ALL ON FUNCTION "communities"."create_new_eesupool"("admin_id" "uuid", "name" "text", "description" "text", "parent_id" integer, "level" "communities"."eesupool_level", "type" "communities"."eesupool_type") TO "anon";
GRANT ALL ON FUNCTION "communities"."create_new_eesupool"("admin_id" "uuid", "name" "text", "description" "text", "parent_id" integer, "level" "communities"."eesupool_level", "type" "communities"."eesupool_type") TO "authenticated";
GRANT ALL ON FUNCTION "communities"."create_new_eesupool"("admin_id" "uuid", "name" "text", "description" "text", "parent_id" integer, "level" "communities"."eesupool_level", "type" "communities"."eesupool_type") TO "service_role";

GRANT ALL ON FUNCTION "communities"."generate_pool_order_secret_pin"() TO "anon";
GRANT ALL ON FUNCTION "communities"."generate_pool_order_secret_pin"() TO "authenticated";
GRANT ALL ON FUNCTION "communities"."generate_pool_order_secret_pin"() TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_eesupool_by_id"("_user_id" "uuid", "_pool_id" integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_eesupool_by_id"("_user_id" "uuid", "_pool_id" integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_eesupool_by_id"("_user_id" "uuid", "_pool_id" integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_eesupool_descendants_by_level"("parent_pool_id" integer, "children_level" "communities"."eesupool_level") TO "anon";
GRANT ALL ON FUNCTION "communities"."get_eesupool_descendants_by_level"("parent_pool_id" integer, "children_level" "communities"."eesupool_level") TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_eesupool_descendants_by_level"("parent_pool_id" integer, "children_level" "communities"."eesupool_level") TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_eesupool_event_attendees"("p_event_id" "uuid", "p_pool_id" integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_eesupool_event_attendees"("p_event_id" "uuid", "p_pool_id" integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_eesupool_event_attendees"("p_event_id" "uuid", "p_pool_id" integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_eesupool_events"("pool_id" integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_eesupool_events"("pool_id" integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_eesupool_events"("pool_id" integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_eesupool_issues"("pool_id" integer, "limit_to" integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_eesupool_issues"("pool_id" integer, "limit_to" integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_eesupool_issues"("pool_id" integer, "limit_to" integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_eesupool_member_by_id"("membership_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "communities"."get_eesupool_member_by_id"("membership_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_eesupool_member_by_id"("membership_id" "uuid") TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_eesupool_members"("pool_id" integer, "limit_to" integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_eesupool_members"("pool_id" integer, "limit_to" integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_eesupool_members"("pool_id" integer, "limit_to" integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_eesupool_members_by_id_array"("members" "uuid"[]) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_eesupool_members_by_id_array"("members" "uuid"[]) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_eesupool_members_by_id_array"("members" "uuid"[]) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_eesupool_messages"("pool_id" integer, "approved" boolean, "limit_to" integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_eesupool_messages"("pool_id" integer, "approved" boolean, "limit_to" integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_eesupool_messages"("pool_id" integer, "approved" boolean, "limit_to" integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_eesupool_messages_by_hash_tag"("pool_id" integer, "hash_tag" "text", "approved" boolean, "limit_to" integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_eesupool_messages_by_hash_tag"("pool_id" integer, "hash_tag" "text", "approved" boolean, "limit_to" integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_eesupool_messages_by_hash_tag"("pool_id" integer, "hash_tag" "text", "approved" boolean, "limit_to" integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_eesupool_orders"("pool_id" integer, "limit_to" integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_eesupool_orders"("pool_id" integer, "limit_to" integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_eesupool_orders"("pool_id" integer, "limit_to" integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_eesupool_requests"("_pool_id" integer, "_user_id" "uuid", "_type" "text", "limit_to" integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_eesupool_requests"("_pool_id" integer, "_user_id" "uuid", "_type" "text", "limit_to" integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_eesupool_requests"("_pool_id" integer, "_user_id" "uuid", "_type" "text", "limit_to" integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_eesupool_requests_and_invites"("pool_id" integer, "p_user_id" "uuid", "p_type" "text", "limit_to" integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_eesupool_requests_and_invites"("pool_id" integer, "p_user_id" "uuid", "p_type" "text", "limit_to" integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_eesupool_requests_and_invites"("pool_id" integer, "p_user_id" "uuid", "p_type" "text", "limit_to" integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_eesupools_descendants"("_user_id" "uuid", "parent_pool_id" integer, "limit_to" integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_eesupools_descendants"("_user_id" "uuid", "parent_pool_id" integer, "limit_to" integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_eesupools_descendants"("_user_id" "uuid", "parent_pool_id" integer, "limit_to" integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_eesupools_descendants_streets_for_requests"("_user_id" "uuid", "parent_pool_id" integer, "limit_to" integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_eesupools_descendants_streets_for_requests"("_user_id" "uuid", "parent_pool_id" integer, "limit_to" integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_eesupools_descendants_streets_for_requests"("_user_id" "uuid", "parent_pool_id" integer, "limit_to" integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_message_by_id"("m_id" integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_message_by_id"("m_id" integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_message_by_id"("m_id" integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_message_reaction"("m_id" integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_message_reaction"("m_id" integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_message_reaction"("m_id" integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_message_reactions"("m_id" integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_message_reactions"("m_id" integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_message_reactions"("m_id" integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_open_eesupool_order"("pool_id" integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_open_eesupool_order"("pool_id" integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_open_eesupool_order"("pool_id" integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_open_eesupool_orders"("_user_id" "uuid", "_eesupool_id" integer, "_limit_to" integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_open_eesupool_orders"("_user_id" "uuid", "_eesupool_id" integer, "_limit_to" integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_open_eesupool_orders"("_user_id" "uuid", "_eesupool_id" integer, "_limit_to" integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_order_assignments"("_order_id" integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_order_assignments"("_order_id" integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_order_assignments"("_order_id" integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_sub_kases_for_search"("_parent_id" integer, "_user_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "communities"."get_sub_kases_for_search"("_parent_id" integer, "_user_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_sub_kases_for_search"("_parent_id" integer, "_user_id" "uuid") TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_user_eesupools"("id" "uuid", "limit_to" integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_user_eesupools"("id" "uuid", "limit_to" integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_user_eesupools"("id" "uuid", "limit_to" integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_user_eesupools_v2"("id" "uuid", "limit_to" integer, "pool_type" "communities"."eesupool_type") TO "anon";
GRANT ALL ON FUNCTION "communities"."get_user_eesupools_v2"("id" "uuid", "limit_to" integer, "pool_type" "communities"."eesupool_type") TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_user_eesupools_v2"("id" "uuid", "limit_to" integer, "pool_type" "communities"."eesupool_type") TO "service_role";

GRANT ALL ON FUNCTION "communities"."notify_eesupool_members"() TO "anon";
GRANT ALL ON FUNCTION "communities"."notify_eesupool_members"() TO "authenticated";
GRANT ALL ON FUNCTION "communities"."notify_eesupool_members"() TO "service_role";

GRANT ALL ON FUNCTION "communities"."on_invite_revoked_delete_notification"() TO "anon";
GRANT ALL ON FUNCTION "communities"."on_invite_revoked_delete_notification"() TO "authenticated";
GRANT ALL ON FUNCTION "communities"."on_invite_revoked_delete_notification"() TO "service_role";

GRANT ALL ON FUNCTION "communities"."search_eesupools_descendants"("_user_id" "uuid", "parent_pool_id" integer, "query_str" "text", "limit_to" integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."search_eesupools_descendants"("_user_id" "uuid", "parent_pool_id" integer, "query_str" "text", "limit_to" integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."search_eesupools_descendants"("_user_id" "uuid", "parent_pool_id" integer, "query_str" "text", "limit_to" integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."search_for_eesupools_by_type"("query_str" "text", "_user_id" "uuid", "_type" "communities"."eesupool_type", "limit_to" integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."search_for_eesupools_by_type"("query_str" "text", "_user_id" "uuid", "_type" "communities"."eesupool_type", "limit_to" integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."search_for_eesupools_by_type"("query_str" "text", "_user_id" "uuid", "_type" "communities"."eesupool_type", "limit_to" integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."search_for_trade_eesupools"("query_str" "text", "_user_id" "uuid", "lat" double precision, "lng" double precision, "limit_to" integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."search_for_trade_eesupools"("query_str" "text", "_user_id" "uuid", "lat" double precision, "lng" double precision, "limit_to" integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."search_for_trade_eesupools"("query_str" "text", "_user_id" "uuid", "lat" double precision, "lng" double precision, "limit_to" integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."search_profiles_for_eesupool_invites"("query_str" "text", "pool_id" integer, "limit_to" integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."search_profiles_for_eesupool_invites"("query_str" "text", "pool_id" integer, "limit_to" integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."search_profiles_for_eesupool_invites"("query_str" "text", "pool_id" integer, "limit_to" integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."search_user_eesupools"("query_str" "text", "_type" "communities"."eesupool_type", "_user_id" "uuid", "limit_to" integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."search_user_eesupools"("query_str" "text", "_type" "communities"."eesupool_type", "_user_id" "uuid", "limit_to" integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."search_user_eesupools"("query_str" "text", "_type" "communities"."eesupool_type", "_user_id" "uuid", "limit_to" integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."set_default_order_assignment"() TO "anon";
GRANT ALL ON FUNCTION "communities"."set_default_order_assignment"() TO "authenticated";
GRANT ALL ON FUNCTION "communities"."set_default_order_assignment"() TO "service_role";

GRANT ALL ON FUNCTION "engagements"."get_survey_by_id"("_survey_id" "uuid", "_user_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "engagements"."get_survey_by_id"("_survey_id" "uuid", "_user_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "engagements"."get_survey_by_id"("_survey_id" "uuid", "_user_id" "uuid") TO "service_role";

GRANT ALL ON FUNCTION "engagements"."get_user_avail_surveys"("_user_id" "uuid", "_type" "engagements"."survey_type") TO "anon";
GRANT ALL ON FUNCTION "engagements"."get_user_avail_surveys"("_user_id" "uuid", "_type" "engagements"."survey_type") TO "authenticated";
GRANT ALL ON FUNCTION "engagements"."get_user_avail_surveys"("_user_id" "uuid", "_type" "engagements"."survey_type") TO "service_role";

GRANT ALL ON FUNCTION "engagements"."send_one_signal_push_notification"("title" "text", "body" "text", "campaign" "text", "image_url" "text", "data" "jsonb", "recipients" "uuid"[]) TO "anon";
GRANT ALL ON FUNCTION "engagements"."send_one_signal_push_notification"("title" "text", "body" "text", "campaign" "text", "image_url" "text", "data" "jsonb", "recipients" "uuid"[]) TO "authenticated";
GRANT ALL ON FUNCTION "engagements"."send_one_signal_push_notification"("title" "text", "body" "text", "campaign" "text", "image_url" "text", "data" "jsonb", "recipients" "uuid"[]) TO "service_role";

GRANT ALL ON FUNCTION "engagements"."send_order_update_notification"() TO "anon";
GRANT ALL ON FUNCTION "engagements"."send_order_update_notification"() TO "authenticated";
GRANT ALL ON FUNCTION "engagements"."send_order_update_notification"() TO "service_role";

GRANT ALL ON FUNCTION "engagements"."send_push_notification_on_insert"() TO "anon";
GRANT ALL ON FUNCTION "engagements"."send_push_notification_on_insert"() TO "authenticated";
GRANT ALL ON FUNCTION "engagements"."send_push_notification_on_insert"() TO "service_role";

GRANT ALL ON FUNCTION "finances"."balance_wallet_transactions"() TO "anon";
GRANT ALL ON FUNCTION "finances"."balance_wallet_transactions"() TO "authenticated";
GRANT ALL ON FUNCTION "finances"."balance_wallet_transactions"() TO "service_role";

GRANT ALL ON FUNCTION "finances"."calculate_profit_share_and_withdrawal"("voucher_id" integer, "wallet_id" integer, "voucher_balance" numeric, "interest_rate" numeric, "voucher_value" numeric, "period_weeks" integer, "cycle" "finances"."voucher_cycle") TO "anon";
GRANT ALL ON FUNCTION "finances"."calculate_profit_share_and_withdrawal"("voucher_id" integer, "wallet_id" integer, "voucher_balance" numeric, "interest_rate" numeric, "voucher_value" numeric, "period_weeks" integer, "cycle" "finances"."voucher_cycle") TO "authenticated";
GRANT ALL ON FUNCTION "finances"."calculate_profit_share_and_withdrawal"("voucher_id" integer, "wallet_id" integer, "voucher_balance" numeric, "interest_rate" numeric, "voucher_value" numeric, "period_weeks" integer, "cycle" "finances"."voucher_cycle") TO "service_role";

GRANT ALL ON FUNCTION "finances"."check_voucher_payouts_cron_job_fun"() TO "anon";
GRANT ALL ON FUNCTION "finances"."check_voucher_payouts_cron_job_fun"() TO "authenticated";
GRANT ALL ON FUNCTION "finances"."check_voucher_payouts_cron_job_fun"() TO "service_role";

GRANT ALL ON FUNCTION "finances"."confirm_voucher_eft"("reference" integer, "is_confirmed" boolean) TO "anon";
GRANT ALL ON FUNCTION "finances"."confirm_voucher_eft"("reference" integer, "is_confirmed" boolean) TO "authenticated";
GRANT ALL ON FUNCTION "finances"."confirm_voucher_eft"("reference" integer, "is_confirmed" boolean) TO "service_role";

GRANT ALL ON FUNCTION "finances"."create_crowdfunding_voucher"("_user_id" "uuid", "_parameter_id" "uuid", "_value" numeric, "_cycle" "finances"."voucher_cycle", "_period" integer, "_end_date" timestamp with time zone) TO "anon";
GRANT ALL ON FUNCTION "finances"."create_crowdfunding_voucher"("_user_id" "uuid", "_parameter_id" "uuid", "_value" numeric, "_cycle" "finances"."voucher_cycle", "_period" integer, "_end_date" timestamp with time zone) TO "authenticated";
GRANT ALL ON FUNCTION "finances"."create_crowdfunding_voucher"("_user_id" "uuid", "_parameter_id" "uuid", "_value" numeric, "_cycle" "finances"."voucher_cycle", "_period" integer, "_end_date" timestamp with time zone) TO "service_role";

GRANT ALL ON FUNCTION "finances"."create_order_transaction"("_order_id" integer, "_trans_id" integer) TO "anon";
GRANT ALL ON FUNCTION "finances"."create_order_transaction"("_order_id" integer, "_trans_id" integer) TO "authenticated";
GRANT ALL ON FUNCTION "finances"."create_order_transaction"("_order_id" integer, "_trans_id" integer) TO "service_role";

GRANT ALL ON FUNCTION "finances"."create_transaction"("_type" "text", "_value" numeric, "_vested" boolean, "_description" "text") TO "anon";
GRANT ALL ON FUNCTION "finances"."create_transaction"("_type" "text", "_value" numeric, "_vested" boolean, "_description" "text") TO "authenticated";
GRANT ALL ON FUNCTION "finances"."create_transaction"("_type" "text", "_value" numeric, "_vested" boolean, "_description" "text") TO "service_role";

GRANT ALL ON FUNCTION "finances"."create_user_wallets"() TO "anon";
GRANT ALL ON FUNCTION "finances"."create_user_wallets"() TO "authenticated";
GRANT ALL ON FUNCTION "finances"."create_user_wallets"() TO "service_role";

GRANT ALL ON FUNCTION "finances"."create_voucher_ledger_transaction"("_voucher_id" integer, "_transaction_id" integer, "_opening_balance" numeric, "_payout" numeric, "_profit_share" numeric, "_closing_balance" numeric) TO "anon";
GRANT ALL ON FUNCTION "finances"."create_voucher_ledger_transaction"("_voucher_id" integer, "_transaction_id" integer, "_opening_balance" numeric, "_payout" numeric, "_profit_share" numeric, "_closing_balance" numeric) TO "authenticated";
GRANT ALL ON FUNCTION "finances"."create_voucher_ledger_transaction"("_voucher_id" integer, "_transaction_id" integer, "_opening_balance" numeric, "_payout" numeric, "_profit_share" numeric, "_closing_balance" numeric) TO "service_role";

GRANT ALL ON FUNCTION "finances"."create_wallet_transaction"("_wallet_id" integer, "_type" "text", "_value" numeric, "_vested" boolean, "_description" "text") TO "anon";
GRANT ALL ON FUNCTION "finances"."create_wallet_transaction"("_wallet_id" integer, "_type" "text", "_value" numeric, "_vested" boolean, "_description" "text") TO "authenticated";
GRANT ALL ON FUNCTION "finances"."create_wallet_transaction"("_wallet_id" integer, "_type" "text", "_value" numeric, "_vested" boolean, "_description" "text") TO "service_role";

GRANT ALL ON FUNCTION "finances"."generate_payment_secondary_id"() TO "anon";
GRANT ALL ON FUNCTION "finances"."generate_payment_secondary_id"() TO "authenticated";
GRANT ALL ON FUNCTION "finances"."generate_payment_secondary_id"() TO "service_role";

GRANT ALL ON FUNCTION "finances"."generate_random_string"("length" integer) TO "anon";
GRANT ALL ON FUNCTION "finances"."generate_random_string"("length" integer) TO "authenticated";
GRANT ALL ON FUNCTION "finances"."generate_random_string"("length" integer) TO "service_role";

GRANT ALL ON FUNCTION "finances"."generate_transaction_doc_ref"() TO "anon";
GRANT ALL ON FUNCTION "finances"."generate_transaction_doc_ref"() TO "authenticated";
GRANT ALL ON FUNCTION "finances"."generate_transaction_doc_ref"() TO "service_role";

GRANT ALL ON FUNCTION "finances"."get_user_wallets"("_user_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "finances"."get_user_wallets"("_user_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "finances"."get_user_wallets"("_user_id" "uuid") TO "service_role";

GRANT ALL ON FUNCTION "finances"."get_voucher_transactions"("_voucher_id" integer, "limit_to" integer) TO "anon";
GRANT ALL ON FUNCTION "finances"."get_voucher_transactions"("_voucher_id" integer, "limit_to" integer) TO "authenticated";
GRANT ALL ON FUNCTION "finances"."get_voucher_transactions"("_voucher_id" integer, "limit_to" integer) TO "service_role";

GRANT ALL ON FUNCTION "finances"."get_wallet_transactions"("_wallet_id" integer, "limit_to" integer) TO "anon";
GRANT ALL ON FUNCTION "finances"."get_wallet_transactions"("_wallet_id" integer, "limit_to" integer) TO "authenticated";
GRANT ALL ON FUNCTION "finances"."get_wallet_transactions"("_wallet_id" integer, "limit_to" integer) TO "service_role";

GRANT ALL ON FUNCTION "finances"."on_payment_confirmed"() TO "anon";
GRANT ALL ON FUNCTION "finances"."on_payment_confirmed"() TO "authenticated";
GRANT ALL ON FUNCTION "finances"."on_payment_confirmed"() TO "service_role";

GRANT ALL ON FUNCTION "finances"."on_unverified_prevent_income_wallet_txn_confirmations"() TO "anon";
GRANT ALL ON FUNCTION "finances"."on_unverified_prevent_income_wallet_txn_confirmations"() TO "authenticated";
GRANT ALL ON FUNCTION "finances"."on_unverified_prevent_income_wallet_txn_confirmations"() TO "service_role";

GRANT ALL ON FUNCTION "finances"."process_voucher_transactions"("voucher_id" integer, "crowd_fund_wallet_id" integer, "withdrawal_amount" numeric, "opening_balance" numeric, "profit_share" numeric, "closing_balance" numeric) TO "anon";
GRANT ALL ON FUNCTION "finances"."process_voucher_transactions"("voucher_id" integer, "crowd_fund_wallet_id" integer, "withdrawal_amount" numeric, "opening_balance" numeric, "profit_share" numeric, "closing_balance" numeric) TO "authenticated";
GRANT ALL ON FUNCTION "finances"."process_voucher_transactions"("voucher_id" integer, "crowd_fund_wallet_id" integer, "withdrawal_amount" numeric, "opening_balance" numeric, "profit_share" numeric, "closing_balance" numeric) TO "service_role";

GRANT ALL ON FUNCTION "finances"."search_transfer_beneficiary"("query_str" "text", "wallet_type" "text") TO "anon";
GRANT ALL ON FUNCTION "finances"."search_transfer_beneficiary"("query_str" "text", "wallet_type" "text") TO "authenticated";
GRANT ALL ON FUNCTION "finances"."search_transfer_beneficiary"("query_str" "text", "wallet_type" "text") TO "service_role";

GRANT ALL ON FUNCTION "finances"."transfer_funds_wallet_to_wallet"("to_wallet_id" integer, "from_wallet_id" integer, "to_ref" "text", "from_ref" "text", "amount" numeric) TO "anon";
GRANT ALL ON FUNCTION "finances"."transfer_funds_wallet_to_wallet"("to_wallet_id" integer, "from_wallet_id" integer, "to_ref" "text", "from_ref" "text", "amount" numeric) TO "authenticated";
GRANT ALL ON FUNCTION "finances"."transfer_funds_wallet_to_wallet"("to_wallet_id" integer, "from_wallet_id" integer, "to_ref" "text", "from_ref" "text", "amount" numeric) TO "service_role";

GRANT ALL ON FUNCTION "finances"."update_wallet_balance_on_txn_confirmed"() TO "anon";
GRANT ALL ON FUNCTION "finances"."update_wallet_balance_on_txn_confirmed"() TO "authenticated";
GRANT ALL ON FUNCTION "finances"."update_wallet_balance_on_txn_confirmed"() TO "service_role";

GRANT ALL ON FUNCTION "geolocations"."calculate_distance_between_2_locations"("lat1" double precision, "lon1" double precision, "lat2" double precision, "lon2" double precision) TO "anon";
GRANT ALL ON FUNCTION "geolocations"."calculate_distance_between_2_locations"("lat1" double precision, "lon1" double precision, "lat2" double precision, "lon2" double precision) TO "authenticated";
GRANT ALL ON FUNCTION "geolocations"."calculate_distance_between_2_locations"("lat1" double precision, "lon1" double precision, "lat2" double precision, "lon2" double precision) TO "service_role";

GRANT ALL ON FUNCTION "geolocations"."get_address_by_id"("address_id" integer) TO "anon";
GRANT ALL ON FUNCTION "geolocations"."get_address_by_id"("address_id" integer) TO "authenticated";
GRANT ALL ON FUNCTION "geolocations"."get_address_by_id"("address_id" integer) TO "service_role";

GRANT ALL ON FUNCTION "geolocations"."verify_address"() TO "anon";
GRANT ALL ON FUNCTION "geolocations"."verify_address"() TO "authenticated";
GRANT ALL ON FUNCTION "geolocations"."verify_address"() TO "service_role";

GRANT ALL ON FUNCTION "inventory"."get_all_categories"() TO "anon";
GRANT ALL ON FUNCTION "inventory"."get_all_categories"() TO "authenticated";
GRANT ALL ON FUNCTION "inventory"."get_all_categories"() TO "service_role";

GRANT ALL ON FUNCTION "inventory"."get_category_descendants"("p_cat_id" integer) TO "anon";
GRANT ALL ON FUNCTION "inventory"."get_category_descendants"("p_cat_id" integer) TO "authenticated";
GRANT ALL ON FUNCTION "inventory"."get_category_descendants"("p_cat_id" integer) TO "service_role";

GRANT ALL ON FUNCTION "inventory"."get_product"("_id" integer) TO "anon";
GRANT ALL ON FUNCTION "inventory"."get_product"("_id" integer) TO "authenticated";
GRANT ALL ON FUNCTION "inventory"."get_product"("_id" integer) TO "service_role";

GRANT ALL ON FUNCTION "inventory"."get_products_by_category"("cat_id" integer, "role" "public"."user_role", "limit_to" integer) TO "anon";
GRANT ALL ON FUNCTION "inventory"."get_products_by_category"("cat_id" integer, "role" "public"."user_role", "limit_to" integer) TO "authenticated";
GRANT ALL ON FUNCTION "inventory"."get_products_by_category"("cat_id" integer, "role" "public"."user_role", "limit_to" integer) TO "service_role";

GRANT ALL ON FUNCTION "inventory"."get_random_category"() TO "anon";
GRANT ALL ON FUNCTION "inventory"."get_random_category"() TO "authenticated";
GRANT ALL ON FUNCTION "inventory"."get_random_category"() TO "service_role";

GRANT ALL ON FUNCTION "inventory"."get_random_products"("role" "public"."user_role", "limit_to" integer) TO "anon";
GRANT ALL ON FUNCTION "inventory"."get_random_products"("role" "public"."user_role", "limit_to" integer) TO "authenticated";
GRANT ALL ON FUNCTION "inventory"."get_random_products"("role" "public"."user_role", "limit_to" integer) TO "service_role";

GRANT ALL ON FUNCTION "inventory"."search_categories"("query_str" "text") TO "anon";
GRANT ALL ON FUNCTION "inventory"."search_categories"("query_str" "text") TO "authenticated";
GRANT ALL ON FUNCTION "inventory"."search_categories"("query_str" "text") TO "service_role";

GRANT ALL ON FUNCTION "inventory"."search_products"("query_str" "text", "role" "public"."user_role", "limit_to" integer) TO "anon";
GRANT ALL ON FUNCTION "inventory"."search_products"("query_str" "text", "role" "public"."user_role", "limit_to" integer) TO "authenticated";
GRANT ALL ON FUNCTION "inventory"."search_products"("query_str" "text", "role" "public"."user_role", "limit_to" integer) TO "service_role";

GRANT ALL ON FUNCTION "inventory"."search_products_and_categories"("query_str" "text", "role" "public"."user_role", "limit_to" integer) TO "anon";
GRANT ALL ON FUNCTION "inventory"."search_products_and_categories"("query_str" "text", "role" "public"."user_role", "limit_to" integer) TO "authenticated";
GRANT ALL ON FUNCTION "inventory"."search_products_and_categories"("query_str" "text", "role" "public"."user_role", "limit_to" integer) TO "service_role";

GRANT ALL ON FUNCTION "public"."add_product_to_basket"("_basket_id" "uuid", "_product_id" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."add_product_to_basket"("_basket_id" "uuid", "_product_id" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."add_product_to_basket"("_basket_id" "uuid", "_product_id" integer) TO "service_role";

GRANT ALL ON FUNCTION "public"."change_referral"("old_referrer_user_id" "uuid", "new_referrer_user_id" "uuid", "referred_user_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."change_referral"("old_referrer_user_id" "uuid", "new_referrer_user_id" "uuid", "referred_user_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."change_referral"("old_referrer_user_id" "uuid", "new_referrer_user_id" "uuid", "referred_user_id" "uuid") TO "service_role";

GRANT ALL ON FUNCTION "public"."check_and_update_verification"() TO "anon";
GRANT ALL ON FUNCTION "public"."check_and_update_verification"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."check_and_update_verification"() TO "service_role";

GRANT ALL ON FUNCTION "public"."check_if_referral_is_complete"() TO "anon";
GRANT ALL ON FUNCTION "public"."check_if_referral_is_complete"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."check_if_referral_is_complete"() TO "service_role";

GRANT ALL ON FUNCTION "public"."create_user_default_basket"() TO "anon";
GRANT ALL ON FUNCTION "public"."create_user_default_basket"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."create_user_default_basket"() TO "service_role";

GRANT ALL ON FUNCTION "public"."get_basket_products"("_basket_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_basket_products"("_basket_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_basket_products"("_basket_id" "uuid") TO "service_role";

GRANT ALL ON FUNCTION "public"."get_basket_products_v2"("_basket_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_basket_products_v2"("_basket_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_basket_products_v2"("_basket_id" "uuid") TO "service_role";

GRANT ALL ON FUNCTION "public"."get_referrals_by_referrer"("_user_id" "uuid", "_limit_to" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."get_referrals_by_referrer"("_user_id" "uuid", "_limit_to" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_referrals_by_referrer"("_user_id" "uuid", "_limit_to" integer) TO "service_role";

GRANT ALL ON FUNCTION "public"."handle_new_referral"("referee_id" "uuid", "ref_code" integer, "full_name" "text", "is_confirmed" boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."handle_new_referral"("referee_id" "uuid", "ref_code" integer, "full_name" "text", "is_confirmed" boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_new_referral"("referee_id" "uuid", "ref_code" integer, "full_name" "text", "is_confirmed" boolean) TO "service_role";

GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "service_role";

GRANT ALL ON FUNCTION "public"."on_profile_verified_complete_referral"() TO "anon";
GRANT ALL ON FUNCTION "public"."on_profile_verified_complete_referral"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."on_profile_verified_complete_referral"() TO "service_role";

GRANT ALL ON FUNCTION "public"."on_profile_verified_update_confirm_income_txns"() TO "anon";
GRANT ALL ON FUNCTION "public"."on_profile_verified_update_confirm_income_txns"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."on_profile_verified_update_confirm_income_txns"() TO "service_role";

GRANT ALL ON FUNCTION "public"."remove_product_from_basket"("_basket_id" "uuid", "_product_id" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."remove_product_from_basket"("_basket_id" "uuid", "_product_id" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."remove_product_from_basket"("_basket_id" "uuid", "_product_id" integer) TO "service_role";

GRANT ALL ON FUNCTION "sales"."allocate_profit_earnings_for_eesupool_member_orders"() TO "anon";
GRANT ALL ON FUNCTION "sales"."allocate_profit_earnings_for_eesupool_member_orders"() TO "authenticated";
GRANT ALL ON FUNCTION "sales"."allocate_profit_earnings_for_eesupool_member_orders"() TO "service_role";

GRANT ALL ON FUNCTION "sales"."allocate_profit_earnings_for_eesupreneur_orders"() TO "anon";
GRANT ALL ON FUNCTION "sales"."allocate_profit_earnings_for_eesupreneur_orders"() TO "authenticated";
GRANT ALL ON FUNCTION "sales"."allocate_profit_earnings_for_eesupreneur_orders"() TO "service_role";

GRANT ALL ON FUNCTION "sales"."calculate_order_profit_splits"("_order_id" integer) TO "anon";
GRANT ALL ON FUNCTION "sales"."calculate_order_profit_splits"("_order_id" integer) TO "authenticated";
GRANT ALL ON FUNCTION "sales"."calculate_order_profit_splits"("_order_id" integer) TO "service_role";

GRANT ALL ON FUNCTION "sales"."create_order"("_customer_id" "uuid", "_eesupreneur_id" "uuid", "_eesupool_order_id" integer, "_wallet_id" integer, "_total_amount" numeric, "_payment_method" "finances"."payment_method", "_address_id" integer, "_delivery_fee" numeric, "_card_fee" numeric, "_pay_fees_with_retail" boolean, "_products" "jsonb"[]) TO "anon";
GRANT ALL ON FUNCTION "sales"."create_order"("_customer_id" "uuid", "_eesupreneur_id" "uuid", "_eesupool_order_id" integer, "_wallet_id" integer, "_total_amount" numeric, "_payment_method" "finances"."payment_method", "_address_id" integer, "_delivery_fee" numeric, "_card_fee" numeric, "_pay_fees_with_retail" boolean, "_products" "jsonb"[]) TO "authenticated";
GRANT ALL ON FUNCTION "sales"."create_order"("_customer_id" "uuid", "_eesupreneur_id" "uuid", "_eesupool_order_id" integer, "_wallet_id" integer, "_total_amount" numeric, "_payment_method" "finances"."payment_method", "_address_id" integer, "_delivery_fee" numeric, "_card_fee" numeric, "_pay_fees_with_retail" boolean, "_products" "jsonb"[]) TO "service_role";

GRANT ALL ON FUNCTION "sales"."generate_order_secret_pin"() TO "anon";
GRANT ALL ON FUNCTION "sales"."generate_order_secret_pin"() TO "authenticated";
GRANT ALL ON FUNCTION "sales"."generate_order_secret_pin"() TO "service_role";

GRANT ALL ON FUNCTION "sales"."get_customer_orders"("_user_id" "uuid", "_eesupreneur_id" "uuid", "_eesupool_ord_id" integer, "_status" "sales"."order_status"[], "_limit" integer) TO "anon";
GRANT ALL ON FUNCTION "sales"."get_customer_orders"("_user_id" "uuid", "_eesupreneur_id" "uuid", "_eesupool_ord_id" integer, "_status" "sales"."order_status"[], "_limit" integer) TO "authenticated";
GRANT ALL ON FUNCTION "sales"."get_customer_orders"("_user_id" "uuid", "_eesupreneur_id" "uuid", "_eesupool_ord_id" integer, "_status" "sales"."order_status"[], "_limit" integer) TO "service_role";

GRANT ALL ON FUNCTION "sales"."get_order_products"("ord_id" integer) TO "anon";
GRANT ALL ON FUNCTION "sales"."get_order_products"("ord_id" integer) TO "authenticated";
GRANT ALL ON FUNCTION "sales"."get_order_products"("ord_id" integer) TO "service_role";

GRANT ALL ON FUNCTION "sales"."insert_order_products"("_order_id" integer, "_products" "jsonb"[]) TO "anon";
GRANT ALL ON FUNCTION "sales"."insert_order_products"("_order_id" integer, "_products" "jsonb"[]) TO "authenticated";
GRANT ALL ON FUNCTION "sales"."insert_order_products"("_order_id" integer, "_products" "jsonb"[]) TO "service_role";

GRANT ALL ON FUNCTION "sales"."place_confirmed_order"("_order_id" integer, "_is_confirmed" boolean) TO "anon";
GRANT ALL ON FUNCTION "sales"."place_confirmed_order"("_order_id" integer, "_is_confirmed" boolean) TO "authenticated";
GRANT ALL ON FUNCTION "sales"."place_confirmed_order"("_order_id" integer, "_is_confirmed" boolean) TO "service_role";

GRANT ALL ON FUNCTION "sales"."update_product_allocations_on_new_order_product"() TO "anon";
GRANT ALL ON FUNCTION "sales"."update_product_allocations_on_new_order_product"() TO "authenticated";
GRANT ALL ON FUNCTION "sales"."update_product_allocations_on_new_order_product"() TO "service_role";

GRANT ALL ON FUNCTION "services"."create_new_partner_application"("_user_id" "uuid", "_partner_id" "text") TO "anon";
GRANT ALL ON FUNCTION "services"."create_new_partner_application"("_user_id" "uuid", "_partner_id" "text") TO "authenticated";
GRANT ALL ON FUNCTION "services"."create_new_partner_application"("_user_id" "uuid", "_partner_id" "text") TO "service_role";

GRANT ALL ON FUNCTION "services"."get_all_user_eesupreneurs"("_user_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "services"."get_all_user_eesupreneurs"("_user_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "services"."get_all_user_eesupreneurs"("_user_id" "uuid") TO "service_role";

GRANT ALL ON FUNCTION "services"."get_available_partnerships"("role" "public"."user_role") TO "anon";
GRANT ALL ON FUNCTION "services"."get_available_partnerships"("role" "public"."user_role") TO "authenticated";
GRANT ALL ON FUNCTION "services"."get_available_partnerships"("role" "public"."user_role") TO "service_role";

GRANT ALL ON FUNCTION "services"."get_closest_eesupreneurs"("lat" double precision, "lng" double precision, "limit_to" integer) TO "anon";
GRANT ALL ON FUNCTION "services"."get_closest_eesupreneurs"("lat" double precision, "lng" double precision, "limit_to" integer) TO "authenticated";
GRANT ALL ON FUNCTION "services"."get_closest_eesupreneurs"("lat" double precision, "lng" double precision, "limit_to" integer) TO "service_role";

GRANT ALL ON FUNCTION "services"."get_eesupreneurs"("lat" double precision, "lng" double precision) TO "anon";
GRANT ALL ON FUNCTION "services"."get_eesupreneurs"("lat" double precision, "lng" double precision) TO "authenticated";
GRANT ALL ON FUNCTION "services"."get_eesupreneurs"("lat" double precision, "lng" double precision) TO "service_role";

GRANT ALL ON FUNCTION "services"."get_partnership_surveys"("_user_id" "uuid", "_surveys" "uuid"[]) TO "anon";
GRANT ALL ON FUNCTION "services"."get_partnership_surveys"("_user_id" "uuid", "_surveys" "uuid"[]) TO "authenticated";
GRANT ALL ON FUNCTION "services"."get_partnership_surveys"("_user_id" "uuid", "_surveys" "uuid"[]) TO "service_role";

GRANT ALL ON FUNCTION "services"."notify_applicant_on_application_update"() TO "anon";
GRANT ALL ON FUNCTION "services"."notify_applicant_on_application_update"() TO "authenticated";
GRANT ALL ON FUNCTION "services"."notify_applicant_on_application_update"() TO "service_role";

GRANT ALL ON FUNCTION "services"."on_partner_application_approved"() TO "anon";
GRANT ALL ON FUNCTION "services"."on_partner_application_approved"() TO "authenticated";
GRANT ALL ON FUNCTION "services"."on_partner_application_approved"() TO "service_role";

GRANT ALL ON FUNCTION "services"."prevent_editing_of_the_partner_id_value"() TO "anon";
GRANT ALL ON FUNCTION "services"."prevent_editing_of_the_partner_id_value"() TO "authenticated";
GRANT ALL ON FUNCTION "services"."prevent_editing_of_the_partner_id_value"() TO "service_role";

GRANT ALL ON TABLE "communities"."eesupool" TO "anon";
GRANT ALL ON TABLE "communities"."eesupool" TO "authenticated";
GRANT ALL ON TABLE "communities"."eesupool" TO "service_role";

GRANT ALL ON SEQUENCE "communities"."eesupool_code_seq1" TO "anon";
GRANT ALL ON SEQUENCE "communities"."eesupool_code_seq1" TO "authenticated";
GRANT ALL ON SEQUENCE "communities"."eesupool_code_seq1" TO "service_role";

GRANT ALL ON SEQUENCE "communities"."eesupool_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "communities"."eesupool_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "communities"."eesupool_id_seq" TO "service_role";

GRANT ALL ON TABLE "communities"."eesupool_issue" TO "anon";
GRANT ALL ON TABLE "communities"."eesupool_issue" TO "authenticated";
GRANT ALL ON TABLE "communities"."eesupool_issue" TO "service_role";

GRANT ALL ON TABLE "communities"."eesupool_member" TO "anon";
GRANT ALL ON TABLE "communities"."eesupool_member" TO "authenticated";
GRANT ALL ON TABLE "communities"."eesupool_member" TO "service_role";

GRANT ALL ON TABLE "communities"."eesupool_order" TO "anon";
GRANT ALL ON TABLE "communities"."eesupool_order" TO "authenticated";
GRANT ALL ON TABLE "communities"."eesupool_order" TO "service_role";

GRANT ALL ON SEQUENCE "communities"."eesupool_order_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "communities"."eesupool_order_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "communities"."eesupool_order_id_seq" TO "service_role";

GRANT ALL ON TABLE "communities"."eesupool_request" TO "anon";
GRANT ALL ON TABLE "communities"."eesupool_request" TO "authenticated";
GRANT ALL ON TABLE "communities"."eesupool_request" TO "service_role";

GRANT ALL ON TABLE "communities"."event" TO "anon";
GRANT ALL ON TABLE "communities"."event" TO "authenticated";
GRANT ALL ON TABLE "communities"."event" TO "service_role";

GRANT ALL ON TABLE "communities"."event_attendee" TO "anon";
GRANT ALL ON TABLE "communities"."event_attendee" TO "authenticated";
GRANT ALL ON TABLE "communities"."event_attendee" TO "service_role";

GRANT ALL ON TABLE "communities"."member_order_assignment" TO "anon";
GRANT ALL ON TABLE "communities"."member_order_assignment" TO "authenticated";
GRANT ALL ON TABLE "communities"."member_order_assignment" TO "service_role";

GRANT ALL ON TABLE "communities"."message" TO "anon";
GRANT ALL ON TABLE "communities"."message" TO "authenticated";
GRANT ALL ON TABLE "communities"."message" TO "service_role";

GRANT ALL ON SEQUENCE "communities"."message_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "communities"."message_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "communities"."message_id_seq" TO "service_role";

GRANT ALL ON TABLE "communities"."message_reaction" TO "anon";
GRANT ALL ON TABLE "communities"."message_reaction" TO "authenticated";
GRANT ALL ON TABLE "communities"."message_reaction" TO "service_role";

GRANT ALL ON TABLE "communities"."message_seen" TO "anon";
GRANT ALL ON TABLE "communities"."message_seen" TO "authenticated";
GRANT ALL ON TABLE "communities"."message_seen" TO "service_role";

GRANT ALL ON TABLE "engagements"."banner" TO "anon";
GRANT ALL ON TABLE "engagements"."banner" TO "authenticated";
GRANT ALL ON TABLE "engagements"."banner" TO "service_role";

GRANT ALL ON SEQUENCE "engagements"."banner_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "engagements"."banner_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "engagements"."banner_id_seq" TO "service_role";

GRANT ALL ON TABLE "engagements"."notification" TO "anon";
GRANT ALL ON TABLE "engagements"."notification" TO "authenticated";
GRANT ALL ON TABLE "engagements"."notification" TO "service_role";

GRANT ALL ON SEQUENCE "engagements"."notification_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "engagements"."notification_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "engagements"."notification_id_seq" TO "service_role";

GRANT ALL ON TABLE "engagements"."response" TO "anon";
GRANT ALL ON TABLE "engagements"."response" TO "authenticated";
GRANT ALL ON TABLE "engagements"."response" TO "service_role";

GRANT ALL ON TABLE "engagements"."survey" TO "anon";
GRANT ALL ON TABLE "engagements"."survey" TO "authenticated";
GRANT ALL ON TABLE "engagements"."survey" TO "service_role";

GRANT ALL ON TABLE "finances"."online_payment" TO "anon";
GRANT ALL ON TABLE "finances"."online_payment" TO "authenticated";
GRANT ALL ON TABLE "finances"."online_payment" TO "service_role";

GRANT ALL ON TABLE "finances"."payment_gateway" TO "anon";
GRANT ALL ON TABLE "finances"."payment_gateway" TO "authenticated";
GRANT ALL ON TABLE "finances"."payment_gateway" TO "service_role";

GRANT ALL ON TABLE "finances"."payout_request" TO "anon";
GRANT ALL ON TABLE "finances"."payout_request" TO "authenticated";
GRANT ALL ON TABLE "finances"."payout_request" TO "service_role";

GRANT ALL ON SEQUENCE "finances"."payout_request_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "finances"."payout_request_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "finances"."payout_request_id_seq" TO "service_role";

GRANT ALL ON TABLE "finances"."profit_allocation" TO "anon";
GRANT ALL ON TABLE "finances"."profit_allocation" TO "authenticated";
GRANT ALL ON TABLE "finances"."profit_allocation" TO "service_role";

GRANT ALL ON SEQUENCE "finances"."profit_allocation_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "finances"."profit_allocation_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "finances"."profit_allocation_id_seq" TO "service_role";

GRANT ALL ON TABLE "finances"."transaction" TO "anon";
GRANT ALL ON TABLE "finances"."transaction" TO "authenticated";
GRANT ALL ON TABLE "finances"."transaction" TO "service_role";

GRANT ALL ON SEQUENCE "finances"."transaction_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "finances"."transaction_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "finances"."transaction_id_seq" TO "service_role";

GRANT ALL ON TABLE "finances"."transaction_type" TO "anon";
GRANT ALL ON TABLE "finances"."transaction_type" TO "authenticated";
GRANT ALL ON TABLE "finances"."transaction_type" TO "service_role";

GRANT ALL ON TABLE "finances"."voucher" TO "anon";
GRANT ALL ON TABLE "finances"."voucher" TO "authenticated";
GRANT ALL ON TABLE "finances"."voucher" TO "service_role";

-- GRANT ALL ON SEQUENCE "finances"."voucher_id_seq1" TO "anon";
-- GRANT ALL ON SEQUENCE "finances"."voucher_id_seq1" TO "authenticated";
-- GRANT ALL ON SEQUENCE "finances"."voucher_id_seq1" TO "service_role";

GRANT ALL ON TABLE "finances"."voucher_ledger" TO "anon";
GRANT ALL ON TABLE "finances"."voucher_ledger" TO "authenticated";
GRANT ALL ON TABLE "finances"."voucher_ledger" TO "service_role";

GRANT ALL ON TABLE "finances"."voucher_parameter" TO "anon";
GRANT ALL ON TABLE "finances"."voucher_parameter" TO "authenticated";
GRANT ALL ON TABLE "finances"."voucher_parameter" TO "service_role";

GRANT ALL ON TABLE "finances"."wallet" TO "anon";
GRANT ALL ON TABLE "finances"."wallet" TO "authenticated";
GRANT ALL ON TABLE "finances"."wallet" TO "service_role";

GRANT ALL ON SEQUENCE "finances"."wallet_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "finances"."wallet_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "finances"."wallet_id_seq" TO "service_role";

GRANT ALL ON TABLE "finances"."wallet_transaction" TO "anon";
GRANT ALL ON TABLE "finances"."wallet_transaction" TO "authenticated";
GRANT ALL ON TABLE "finances"."wallet_transaction" TO "service_role";

GRANT ALL ON TABLE "finances"."wallet_type" TO "anon";
GRANT ALL ON TABLE "finances"."wallet_type" TO "authenticated";
GRANT ALL ON TABLE "finances"."wallet_type" TO "service_role";

GRANT ALL ON TABLE "geolocations"."address" TO "anon";
GRANT ALL ON TABLE "geolocations"."address" TO "authenticated";
GRANT ALL ON TABLE "geolocations"."address" TO "service_role";

GRANT ALL ON SEQUENCE "geolocations"."address_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "geolocations"."address_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "geolocations"."address_id_seq" TO "service_role";

GRANT ALL ON TABLE "geolocations"."target_area" TO "anon";
GRANT ALL ON TABLE "geolocations"."target_area" TO "authenticated";
GRANT ALL ON TABLE "geolocations"."target_area" TO "service_role";

GRANT ALL ON SEQUENCE "geolocations"."target_area_area_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "geolocations"."target_area_area_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "geolocations"."target_area_area_id_seq" TO "service_role";

GRANT ALL ON TABLE "inventory"."category" TO "anon";
GRANT ALL ON TABLE "inventory"."category" TO "authenticated";
GRANT ALL ON TABLE "inventory"."category" TO "service_role";

GRANT ALL ON SEQUENCE "inventory"."category_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "inventory"."category_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "inventory"."category_id_seq" TO "service_role";

GRANT ALL ON TABLE "inventory"."product" TO "anon";
GRANT ALL ON TABLE "inventory"."product" TO "authenticated";
GRANT ALL ON TABLE "inventory"."product" TO "service_role";

GRANT ALL ON SEQUENCE "inventory"."product_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "inventory"."product_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "inventory"."product_id_seq" TO "service_role";

GRANT ALL ON TABLE "inventory"."product_request" TO "anon";
GRANT ALL ON TABLE "inventory"."product_request" TO "authenticated";
GRANT ALL ON TABLE "inventory"."product_request" TO "service_role";

GRANT ALL ON SEQUENCE "inventory"."product_request_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "inventory"."product_request_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "inventory"."product_request_id_seq" TO "service_role";

GRANT ALL ON TABLE "inventory"."scraped_product" TO "anon";
GRANT ALL ON TABLE "inventory"."scraped_product" TO "authenticated";
GRANT ALL ON TABLE "inventory"."scraped_product" TO "service_role";

GRANT ALL ON SEQUENCE "inventory"."scraped_product_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "inventory"."scraped_product_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "inventory"."scraped_product_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."basket" TO "anon";
GRANT ALL ON TABLE "public"."basket" TO "authenticated";
GRANT ALL ON TABLE "public"."basket" TO "service_role";

GRANT ALL ON TABLE "public"."basket_product" TO "anon";
GRANT ALL ON TABLE "public"."basket_product" TO "authenticated";
GRANT ALL ON TABLE "public"."basket_product" TO "service_role";

GRANT ALL ON TABLE "public"."profile" TO "anon";
GRANT ALL ON TABLE "public"."profile" TO "authenticated";
GRANT ALL ON TABLE "public"."profile" TO "service_role";

GRANT ALL ON SEQUENCE "public"."profile_referral_code_seq1" TO "anon";
GRANT ALL ON SEQUENCE "public"."profile_referral_code_seq1" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."profile_referral_code_seq1" TO "service_role";

GRANT ALL ON TABLE "public"."referral" TO "anon";
GRANT ALL ON TABLE "public"."referral" TO "authenticated";
GRANT ALL ON TABLE "public"."referral" TO "service_role";

GRANT ALL ON TABLE "sales"."order" TO "anon";
GRANT ALL ON TABLE "sales"."order" TO "authenticated";
GRANT ALL ON TABLE "sales"."order" TO "service_role";

GRANT ALL ON SEQUENCE "sales"."order_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "sales"."order_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "sales"."order_id_seq" TO "service_role";

GRANT ALL ON TABLE "sales"."order_product" TO "anon";
GRANT ALL ON TABLE "sales"."order_product" TO "authenticated";
GRANT ALL ON TABLE "sales"."order_product" TO "service_role";

GRANT ALL ON TABLE "sales"."order_ticket" TO "anon";
GRANT ALL ON TABLE "sales"."order_ticket" TO "authenticated";
GRANT ALL ON TABLE "sales"."order_ticket" TO "service_role";

GRANT ALL ON SEQUENCE "sales"."order_ticket_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "sales"."order_ticket_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "sales"."order_ticket_id_seq" TO "service_role";

GRANT ALL ON TABLE "sales"."order_transaction" TO "anon";
GRANT ALL ON TABLE "sales"."order_transaction" TO "authenticated";
GRANT ALL ON TABLE "sales"."order_transaction" TO "service_role";

GRANT ALL ON TABLE "services"."eesupreneur" TO "anon";
GRANT ALL ON TABLE "services"."eesupreneur" TO "authenticated";
GRANT ALL ON TABLE "services"."eesupreneur" TO "service_role";

GRANT ALL ON TABLE "services"."eesupreneur_employee" TO "anon";
GRANT ALL ON TABLE "services"."eesupreneur_employee" TO "authenticated";
GRANT ALL ON TABLE "services"."eesupreneur_employee" TO "service_role";

GRANT ALL ON TABLE "services"."partner" TO "anon";
GRANT ALL ON TABLE "services"."partner" TO "authenticated";
GRANT ALL ON TABLE "services"."partner" TO "service_role";

GRANT ALL ON TABLE "services"."partner_application" TO "anon";
GRANT ALL ON TABLE "services"."partner_application" TO "authenticated";
GRANT ALL ON TABLE "services"."partner_application" TO "service_role";

GRANT ALL ON SEQUENCE "services"."partner_application_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "services"."partner_application_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "services"."partner_application_id_seq" TO "service_role";

GRANT ALL ON TABLE "system_configs"."api_key" TO "anon";
GRANT ALL ON TABLE "system_configs"."api_key" TO "authenticated";
GRANT ALL ON TABLE "system_configs"."api_key" TO "service_role";

GRANT ALL ON TABLE "system_configs"."remote_config" TO "anon";
GRANT ALL ON TABLE "system_configs"."remote_config" TO "authenticated";
GRANT ALL ON TABLE "system_configs"."remote_config" TO "service_role";

GRANT ALL ON TABLE "warehousing"."distribution_centre" TO "anon";
GRANT ALL ON TABLE "warehousing"."distribution_centre" TO "authenticated";
GRANT ALL ON TABLE "warehousing"."distribution_centre" TO "service_role";

GRANT ALL ON TABLE "warehousing"."supplier" TO "anon";
GRANT ALL ON TABLE "warehousing"."supplier" TO "authenticated";
GRANT ALL ON TABLE "warehousing"."supplier" TO "service_role";

GRANT ALL ON TABLE "warehousing"."warehouse" TO "anon";
GRANT ALL ON TABLE "warehousing"."warehouse" TO "authenticated";
GRANT ALL ON TABLE "warehousing"."warehouse" TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "communities" GRANT ALL ON SEQUENCES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "communities" GRANT ALL ON SEQUENCES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "communities" GRANT ALL ON SEQUENCES  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "communities" GRANT ALL ON FUNCTIONS  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "communities" GRANT ALL ON FUNCTIONS  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "communities" GRANT ALL ON FUNCTIONS  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "communities" GRANT ALL ON TABLES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "communities" GRANT ALL ON TABLES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "communities" GRANT ALL ON TABLES  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "engagements" GRANT ALL ON SEQUENCES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "engagements" GRANT ALL ON SEQUENCES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "engagements" GRANT ALL ON SEQUENCES  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "engagements" GRANT ALL ON FUNCTIONS  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "engagements" GRANT ALL ON FUNCTIONS  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "engagements" GRANT ALL ON FUNCTIONS  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "engagements" GRANT ALL ON TABLES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "engagements" GRANT ALL ON TABLES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "engagements" GRANT ALL ON TABLES  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "finances" GRANT ALL ON SEQUENCES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "finances" GRANT ALL ON SEQUENCES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "finances" GRANT ALL ON SEQUENCES  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "finances" GRANT ALL ON FUNCTIONS  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "finances" GRANT ALL ON FUNCTIONS  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "finances" GRANT ALL ON FUNCTIONS  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "finances" GRANT ALL ON TABLES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "finances" GRANT ALL ON TABLES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "finances" GRANT ALL ON TABLES  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "geolocations" GRANT ALL ON SEQUENCES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "geolocations" GRANT ALL ON SEQUENCES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "geolocations" GRANT ALL ON SEQUENCES  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "geolocations" GRANT ALL ON FUNCTIONS  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "geolocations" GRANT ALL ON FUNCTIONS  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "geolocations" GRANT ALL ON FUNCTIONS  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "geolocations" GRANT ALL ON TABLES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "geolocations" GRANT ALL ON TABLES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "geolocations" GRANT ALL ON TABLES  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "inventory" GRANT ALL ON SEQUENCES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "inventory" GRANT ALL ON SEQUENCES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "inventory" GRANT ALL ON SEQUENCES  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "inventory" GRANT ALL ON FUNCTIONS  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "inventory" GRANT ALL ON FUNCTIONS  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "inventory" GRANT ALL ON FUNCTIONS  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "inventory" GRANT ALL ON TABLES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "inventory" GRANT ALL ON TABLES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "inventory" GRANT ALL ON TABLES  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "sales" GRANT ALL ON SEQUENCES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "sales" GRANT ALL ON SEQUENCES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "sales" GRANT ALL ON SEQUENCES  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "sales" GRANT ALL ON FUNCTIONS  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "sales" GRANT ALL ON FUNCTIONS  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "sales" GRANT ALL ON FUNCTIONS  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "sales" GRANT ALL ON TABLES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "sales" GRANT ALL ON TABLES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "sales" GRANT ALL ON TABLES  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "services" GRANT ALL ON SEQUENCES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "services" GRANT ALL ON SEQUENCES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "services" GRANT ALL ON SEQUENCES  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "services" GRANT ALL ON FUNCTIONS  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "services" GRANT ALL ON FUNCTIONS  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "services" GRANT ALL ON FUNCTIONS  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "services" GRANT ALL ON TABLES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "services" GRANT ALL ON TABLES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "services" GRANT ALL ON TABLES  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "system_configs" GRANT ALL ON SEQUENCES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "system_configs" GRANT ALL ON SEQUENCES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "system_configs" GRANT ALL ON SEQUENCES  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "system_configs" GRANT ALL ON FUNCTIONS  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "system_configs" GRANT ALL ON FUNCTIONS  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "system_configs" GRANT ALL ON FUNCTIONS  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "system_configs" GRANT ALL ON TABLES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "system_configs" GRANT ALL ON TABLES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "system_configs" GRANT ALL ON TABLES  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "warehousing" GRANT ALL ON SEQUENCES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "warehousing" GRANT ALL ON SEQUENCES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "warehousing" GRANT ALL ON SEQUENCES  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "warehousing" GRANT ALL ON FUNCTIONS  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "warehousing" GRANT ALL ON FUNCTIONS  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "warehousing" GRANT ALL ON FUNCTIONS  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "warehousing" GRANT ALL ON TABLES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "warehousing" GRANT ALL ON TABLES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "warehousing" GRANT ALL ON TABLES  TO "service_role";

RESET ALL;
