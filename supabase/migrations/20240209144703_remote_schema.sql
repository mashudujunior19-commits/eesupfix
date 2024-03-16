
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

CREATE SCHEMA IF NOT EXISTS "sales";

ALTER SCHEMA "sales" OWNER TO "postgres";

CREATE SCHEMA IF NOT EXISTS "services";

ALTER SCHEMA "services" OWNER TO "postgres";

CREATE SCHEMA IF NOT EXISTS "supabase_migrations";

ALTER SCHEMA "supabase_migrations" OWNER TO "postgres";

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

CREATE TYPE "communities"."eesupool_level" AS ENUM (
    'National',
    'Regional',
    'Township',
    'Kasi',
    'Street'
);

ALTER TYPE "communities"."eesupool_level" OWNER TO "postgres";

CREATE TYPE "communities"."eesupool_member_role" AS ENUM (
    'Admin',
    'Member'
);

ALTER TYPE "communities"."eesupool_member_role" OWNER TO "postgres";

CREATE TYPE "communities"."eesupool_request_status" AS ENUM (
    'Pending',
    'Accepted',
    'Declined'
);

ALTER TYPE "communities"."eesupool_request_status" OWNER TO "postgres";

CREATE TYPE "communities"."eesupool_type" AS ENUM (
    'Trade',
    'Kasi Connect',
    'Interest Group',
    'Kasi'
);

ALTER TYPE "communities"."eesupool_type" OWNER TO "postgres";

CREATE TYPE "engagements"."survey_type" AS ENUM (
    'Test',
    'Survey',
    'Application'
);

ALTER TYPE "engagements"."survey_type" OWNER TO "postgres";

CREATE TYPE "finances"."payment_method" AS ENUM (
    'Retail wallet',
    'Ozow',
    'Split-Ozow & Retail wallet'
);

ALTER TYPE "finances"."payment_method" OWNER TO "postgres";

CREATE TYPE "inventory"."product_class" AS ENUM (
    'Food',
    'Crowdfund-voucher',
    'Airtime',
    'Mobile-data'
);

ALTER TYPE "inventory"."product_class" OWNER TO "postgres";

CREATE TYPE "public"."basket_type" AS ENUM (
    'Weekly',
    'Monthly',
    'Anually'
);

ALTER TYPE "public"."basket_type" OWNER TO "postgres";

CREATE TYPE "public"."eesupreneur_employee_role" AS ENUM (
    'Owner',
    'Employee'
);

ALTER TYPE "public"."eesupreneur_employee_role" OWNER TO "postgres";

CREATE TYPE "public"."notification_channel" AS ENUM (
    'push',
    'sms',
    'email',
    'all'
);

ALTER TYPE "public"."notification_channel" OWNER TO "postgres";

CREATE TYPE "public"."notification_type" AS ENUM (
    'order',
    'eesupool',
    'eesupool_invite',
    'other'
);

ALTER TYPE "public"."notification_type" OWNER TO "postgres";

CREATE TYPE "public"."service_type" AS ENUM (
    'EESUpreneur',
    'Driver'
);

ALTER TYPE "public"."service_type" OWNER TO "postgres";

CREATE TYPE "public"."user_class" AS ENUM (
    'Individual',
    'Organization',
    'Reseller',
    'Non-Profit Organization'
);

ALTER TYPE "public"."user_class" OWNER TO "postgres";

CREATE TYPE "public"."user_role" AS ENUM (
    'Ubuntunist',
    'EESUpreneur',
    'EESUpromoter',
    'Corporate',
    'EESUplift-Corporate',
    'Admin',
    'Driver',
    'Spaza',
    'Anonymous'
);

ALTER TYPE "public"."user_role" OWNER TO "postgres";

CREATE TYPE "sales"."order_status" AS ENUM (
    'Pending',
    'Placed',
    'Packaged',
    'Ready',
    'Collected',
    'Cancelled'
);

ALTER TYPE "sales"."order_status" OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."add_or_delete_reaction"(_message_id integer, _member_id uuid, _liked boolean) RETURNS void
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

ALTER FUNCTION "communities"."add_or_delete_reaction"(_message_id integer, _member_id uuid, _liked boolean) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."broadcast_eesupool_message"() RETURNS trigger
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

CREATE OR REPLACE FUNCTION "communities"."count_unseen_messages"(_eesupool_id integer, _member_id uuid) RETURNS integer
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

ALTER FUNCTION "communities"."count_unseen_messages"(_eesupool_id integer, _member_id uuid) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."count_user_eesupools_by_type"(_id uuid, _type communities.eesupool_type) RETURNS integer
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

ALTER FUNCTION "communities"."count_user_eesupools_by_type"(_id uuid, _type communities.eesupool_type) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."create_eesupool_invite_notification"() RETURNS trigger
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    eesupool_name TEXT;
BEGIN
    if new.type = 'Invite' then
    -- Retrieve the eesupool name from the communities.eesupool table
    SELECT name INTO eesupool_name FROM communities.eesupool WHERE id = NEW.eesupool_id;

   -- Insert a notification into the public.notification table
    INSERT INTO public.notification(user_id,title, body, data, type)
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

CREATE OR REPLACE FUNCTION "communities"."create_eesupool_member"() RETURNS trigger
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

CREATE OR REPLACE FUNCTION "communities"."create_new_eesupool"(admin_id uuid, name text, description text, parent_id integer, level communities.eesupool_level, type communities.eesupool_type) RETURNS integer
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

ALTER FUNCTION "communities"."create_new_eesupool"(admin_id uuid, name text, description text, parent_id integer, level communities.eesupool_level, type communities.eesupool_type) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_eesupool_by_id"(_user_id uuid, _pool_id integer) RETURNS TABLE(eesupool_id integer, name text, description text, code integer, is_public boolean, address_id integer, type communities.eesupool_type, parent_id integer, level communities.eesupool_level, chat_enabled boolean, admin_fee numeric, receiving_fee numeric, collection_fee numeric, packaging_fee numeric, chat_tags text[], chat_tags_suggestions text[], member_id uuid, role communities.eesupool_member_role, is_censored boolean, num_members integer, unseen_messages integer, address jsonb)
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

ALTER FUNCTION "communities"."get_eesupool_by_id"(_user_id uuid, _pool_id integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_eesupool_descendants_by_level"(parent_pool_id integer, children_level communities.eesupool_level) RETURNS TABLE(id integer)
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

ALTER FUNCTION "communities"."get_eesupool_descendants_by_level"(parent_pool_id integer, children_level communities.eesupool_level) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_eesupool_event_attendees"(p_event_id uuid, p_pool_id integer) RETURNS TABLE(member_id uuid, user_id uuid, eesupool_id integer, created_at timestamp with time zone, role communities.eesupool_member_role, is_censored boolean, full_name text)
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

ALTER FUNCTION "communities"."get_eesupool_event_attendees"(p_event_id uuid, p_pool_id integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_eesupool_events"(pool_id integer) RETURNS TABLE(id uuid, eesupool_id integer, created_at timestamp with time zone, title text, notes text, remote_url text, address_id integer, start_at timestamp with time zone, end_at timestamp with time zone, attendees jsonb, attachments jsonb[])
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

ALTER FUNCTION "communities"."get_eesupool_events"(pool_id integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_eesupool_issues"(pool_id integer, limit_to integer) RETURNS TABLE(issue_id uuid, created_at timestamp with time zone, description text, message jsonb, eesupool_id integer, attachments jsonb[], resolved_at timestamp with time zone, offender_member jsonb, reporter_member jsonb)
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

ALTER FUNCTION "communities"."get_eesupool_issues"(pool_id integer, limit_to integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_eesupool_member_by_id"(membership_id uuid) RETURNS TABLE(member_id uuid, user_id uuid, eesupool_id integer, created_at timestamp with time zone, role communities.eesupool_member_role, is_censored boolean, full_name text)
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

ALTER FUNCTION "communities"."get_eesupool_member_by_id"(membership_id uuid) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_eesupool_members"(pool_id integer, limit_to integer) RETURNS TABLE(member_id uuid, user_id uuid, eesupool_id integer, created_at timestamp with time zone, role communities.eesupool_member_role, is_censored boolean, full_name text)
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

ALTER FUNCTION "communities"."get_eesupool_members"(pool_id integer, limit_to integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_eesupool_messages"(pool_id integer, approved boolean, limit_to integer) RETURNS TABLE(id integer, eesupool_id integer, author_id uuid, created_at timestamp with time zone, content text, reply_on_id integer, attachments jsonb[], author_full_name text, reply_message jsonb, reactions jsonb, is_approved boolean, hash_tags text[], is_deleted boolean, message_seens uuid[])
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

ALTER FUNCTION "communities"."get_eesupool_messages"(pool_id integer, approved boolean, limit_to integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_eesupool_messages_by_hash_tag"(pool_id integer, hash_tag text, approved boolean, limit_to integer) RETURNS TABLE(id integer, eesupool_id integer, author_id uuid, created_at timestamp with time zone, content text, reply_on_id integer, attachments jsonb[], author_full_name text, reply_message jsonb, reactions jsonb, is_approved boolean, hash_tags text[], is_deleted boolean, message_seens uuid[])
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

ALTER FUNCTION "communities"."get_eesupool_messages_by_hash_tag"(pool_id integer, hash_tag text, approved boolean, limit_to integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_eesupool_orders"(pool_id integer, limit_to integer) RETURNS TABLE(id integer, eesupool_id integer, receiver_id uuid, created_at timestamp with time zone, schedule_for timestamp with time zone, delivered_at timestamp with time zone, closes_at timestamp with time zone, admin_fee numeric, packer_fee numeric, receiver_fee numeric, collection_fee numeric, address_id integer, receiver jsonb, eesupool_name text, address jsonb, orders_count integer, current_amount numeric)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        eo.id,
        eo.eesupool_id,
        eo.receiver_id,
        eo.created_at,
        eo.schedule_for,
        eo.delivered_at,
        eo.closes_at,
        eo.admin_fee,
        eo.packer_fee,
        eo.receiver_fee,
        eo.collection_fee,
        eo.address_id,
        COALESCE((SELECT row_to_json(t)::jsonb 
                  FROM 
                  (SELECT * FROM communities.get_eesupool_member_by_id(eo.receiver_id)) t), null::jsonb) AS receiver,
        (select ep.name from communities.eesupool ep where ep.id = eo.eesupool_id) as eesupool_name,
        COALESCE((SELECT row_to_json(t)::jsonb 
                  FROM 
                  (SELECT * FROM geolocations.get_address_by_id(eo.address_id)) t), null::jsonb) AS address,
        CAST((select count(*) from sales.order o where o.eesupool_order_id = eo.id) as integer) as orders_count,
        CAST((select sum(o.value) from sales.order o where o.eesupool_order_id = eo.id) as numeric) as current_amount
                  
    FROM communities.eesupool_order eo
    WHERE eo.eesupool_id = pool_id limit limit_to;
END;
$$;

ALTER FUNCTION "communities"."get_eesupool_orders"(pool_id integer, limit_to integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_eesupool_requests"(_pool_id integer, _user_id uuid, _type text, limit_to integer) RETURNS TABLE(user_id uuid, created_at timestamp with time zone, eesupool_id integer, type text, status communities.eesupool_request_status, eesupool_name text, full_name text, corporate_name text, role public.user_role)
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

ALTER FUNCTION "communities"."get_eesupool_requests"(_pool_id integer, _user_id uuid, _type text, limit_to integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_eesupool_requests_and_invites"(pool_id integer, p_user_id uuid, p_type text, limit_to integer) RETURNS TABLE(user_id uuid, created_at timestamp with time zone, eesupool_id integer, request_type text, status communities.eesupool_request_status, eesupool_name text, full_name text, corporate_name text, role public.user_role)
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

ALTER FUNCTION "communities"."get_eesupool_requests_and_invites"(pool_id integer, p_user_id uuid, p_type text, limit_to integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_eesupools_descendants"(_user_id uuid, parent_pool_id integer, limit_to integer) RETURNS TABLE(eesupool_id integer, name text, description text, code integer, is_public boolean, address_id integer, type communities.eesupool_type, parent_id integer, level communities.eesupool_level, chat_enabled boolean, admin_fee numeric, receiving_fee numeric, collection_fee numeric, packaging_fee numeric, chat_tags text[], chat_tags_suggestions text[], member_id uuid, role communities.eesupool_member_role, is_censored boolean, num_members integer, unseen_messages integer, address jsonb)
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

ALTER FUNCTION "communities"."get_eesupools_descendants"(_user_id uuid, parent_pool_id integer, limit_to integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_eesupools_descendants_streets_for_requests"(_user_id uuid, parent_pool_id integer, limit_to integer) RETURNS TABLE(id integer, name text, description text, code integer, type communities.eesupool_type, level communities.eesupool_level, membership_id uuid, invite_status communities.eesupool_request_status)
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

ALTER FUNCTION "communities"."get_eesupools_descendants_streets_for_requests"(_user_id uuid, parent_pool_id integer, limit_to integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_message_by_id"(m_id integer) RETURNS TABLE(id integer, eesupool_id integer, author_id uuid, created_at timestamp with time zone, content text, reply_on_id integer, attachments jsonb[], author_full_name text, reply_message jsonb, reactions jsonb, is_approved boolean, hash_tags text[], is_deleted boolean, message_seens uuid[])
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
                  FROM (SELECT * FROM communities.get_message_by_id(m.reply_on_id)) t), '[]'::jsonb) AS reply_message,
        COALESCE((SELECT jsonb_agg(t) 
                  FROM (SELECT * FROM communities.get_message_reactions(m.id)) t), '[]'::jsonb) AS reactions,
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

ALTER FUNCTION "communities"."get_message_by_id"(m_id integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_message_reaction"(m_id integer) RETURNS TABLE(message_id integer, member_id uuid, created_at timestamp with time zone, liked boolean, member_full_name text)
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

ALTER FUNCTION "communities"."get_message_reaction"(m_id integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_message_reactions"(m_id integer) RETURNS TABLE(message_id integer, member_id uuid, created_at timestamp with time zone, liked boolean, member_full_name text)
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

ALTER FUNCTION "communities"."get_message_reactions"(m_id integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_open_eesupool_orders"(_user_id uuid, _eesupool_id integer, _limit_to integer) RETURNS TABLE(id integer, eesupool_id integer, receiver_id uuid, created_at timestamp with time zone, schedule_for timestamp with time zone, delivered_at timestamp with time zone, closes_at timestamp with time zone, admin_fee numeric, packer_fee numeric, receiver_fee numeric, collection_fee numeric, address_id integer, receiver jsonb, eesupool_name text, address jsonb, orders_count integer, current_amount numeric)
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
        eo.receiver_id,
        eo.created_at,
        eo.schedule_for,
        eo.delivered_at,
        eo.closes_at,
        eo.admin_fee,
        eo.packer_fee,
        eo.receiver_fee,
        eo.collection_fee,
        eo.address_id,
        COALESCE((SELECT row_to_json(t)::jsonb 
                  FROM 
                  (SELECT * FROM communities.get_eesupool_member_by_id(eo.receiver_id)) t), null::jsonb) AS receiver,
        (SELECT ep.name FROM communities.eesupool ep WHERE ep.id = eo.eesupool_id) AS eesupool_name,
        COALESCE((SELECT row_to_json(t)::jsonb 
                  FROM (SELECT * FROM geolocations.get_address_by_id(eo.address_id)) t), 
                 null::jsonb) AS address,
        CAST((select count(*) from sales.order o where o.eesupool_order_id = eo.id) as integer) as orders_count,
        CAST((select sum(o.value) from sales.order o where o.eesupool_order_id = eo.id) as numeric) as current_amount
    FROM communities.eesupool_order eo 
    INNER JOIN communities.eesupool_member eem ON eo.eesupool_id = eem.eesupool_id
    WHERE eo.closes_at > now() AND
    ((eem.user_id = _user_id OR (_referrer_user_id IS NOT NULL AND eem.user_id = _referrer_user_id)) or eo.eesupool_id = _eesupool_id)
    ORDER BY eo.created_at desc
    LIMIT _limit_to;
END;
$$;

ALTER FUNCTION "communities"."get_open_eesupool_orders"(_user_id uuid, _eesupool_id integer, _limit_to integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_sub_kases_for_search"(_parent_id integer, _user_id uuid) RETURNS TABLE(id integer, name text, level communities.eesupool_level, invite_status communities.eesupool_request_status, membership_id uuid)
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

ALTER FUNCTION "communities"."get_sub_kases_for_search"(_parent_id integer, _user_id uuid) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."get_user_eesupools"(id uuid, limit_to integer) RETURNS TABLE(eesupool_id integer, name text, description text, code integer, is_public boolean, address_id integer, type communities.eesupool_type, parent_id integer, level communities.eesupool_level, chat_enabled boolean, admin_fee numeric, receiving_fee numeric, collection_fee numeric, packaging_fee numeric, chat_tags text[], chat_tags_suggestions text[], member_id uuid, role communities.eesupool_member_role, is_censored boolean, num_members integer, unseen_messages integer, address jsonb)
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

ALTER FUNCTION "communities"."get_user_eesupools"(id uuid, limit_to integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."notify_eesupool_members"() RETURNS trigger
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
    PERFORM engagements.send_push_notification(
        author_name,
        NEW.content,
        'EESUPOOL_CHAT',
        NULL,
        JSON_BUILD_OBJECT('eesupool_id', NEW.eesupool_id)::jsonb,
        recipients
    );
    END IF;

    RETURN NEW;
END;
$$;

ALTER FUNCTION "communities"."notify_eesupool_members"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."on_invite_revoked_delete_notification"() RETURNS trigger
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    delete from public.notification where data ->>'user_id' = cast(old.user_id as text)
    AND data ->>'eesupool_id' = cast(old.eesupool_id as text);
    RETURN NEW;
END;
$$;

ALTER FUNCTION "communities"."on_invite_revoked_delete_notification"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."search_eesupools_descendants"(_user_id uuid, parent_pool_id integer, query_str text, limit_to integer) RETURNS TABLE(eesupool_id integer, name text, description text, code integer, is_public boolean, address_id integer, type communities.eesupool_type, parent_id integer, level communities.eesupool_level, chat_enabled boolean, admin_fee numeric, receiving_fee numeric, collection_fee numeric, packaging_fee numeric, chat_tags text[], chat_tags_suggestions text[], member_id uuid, role communities.eesupool_member_role, is_censored boolean, num_members integer, unseen_messages integer, address jsonb)
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

ALTER FUNCTION "communities"."search_eesupools_descendants"(_user_id uuid, parent_pool_id integer, query_str text, limit_to integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."search_for_eesupools_by_type"(query_str text, _user_id uuid, _type communities.eesupool_type, limit_to integer) RETURNS TABLE(id integer, name text, level communities.eesupool_level, invite_status communities.eesupool_request_status, membership_id uuid, sub_eesupools jsonb, parent_name text)
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

ALTER FUNCTION "communities"."search_for_eesupools_by_type"(query_str text, _user_id uuid, _type communities.eesupool_type, limit_to integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."search_for_trade_eesupools"(query_str text, _user_id uuid, lat double precision, lng double precision, limit_to integer) RETURNS TABLE(id integer, name text, distance double precision, invite_status communities.eesupool_request_status, membership_id uuid)
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

ALTER FUNCTION "communities"."search_for_trade_eesupools"(query_str text, _user_id uuid, lat double precision, lng double precision, limit_to integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."search_profiles_for_eesupool_invites"(query_str text, pool_id integer, limit_to integer) RETURNS TABLE(full_name text, corporate_name text, user_id uuid, role public.user_role, membership_id uuid, status communities.eesupool_request_status)
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

ALTER FUNCTION "communities"."search_profiles_for_eesupool_invites"(query_str text, pool_id integer, limit_to integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "communities"."search_user_eesupools"(query_str text, _type communities.eesupool_type, _user_id uuid, limit_to integer) RETURNS TABLE(eesupool_id integer, name text, description text, code integer, is_public boolean, address_id integer, type communities.eesupool_type, parent_id integer, level communities.eesupool_level, chat_enabled boolean, admin_fee numeric, receiving_fee numeric, collection_fee numeric, packaging_fee numeric, chat_tags text[], chat_tags_suggestions text[], member_id uuid, role communities.eesupool_member_role, is_censored boolean, num_members integer, unseen_messages integer, address jsonb)
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

ALTER FUNCTION "communities"."search_user_eesupools"(query_str text, _type communities.eesupool_type, _user_id uuid, limit_to integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "engagements"."get_survey_by_id"(_survey_id uuid, _user_id uuid) RETURNS TABLE(id uuid, created_at timestamp with time zone, title text, description text, type engagements.survey_type, questions jsonb, max_responses integer, image_url text, video_url text, reward_amount numeric, duration integer, points integer, pass_percentage numeric, enable_scoring boolean, require_all boolean, enforce_time_limit boolean, pre_survey jsonb, passed boolean, score integer, responded_at timestamp with time zone)
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

ALTER FUNCTION "engagements"."get_survey_by_id"(_survey_id uuid, _user_id uuid) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "engagements"."get_user_avail_surveys"(_user_id uuid, _type engagements.survey_type) RETURNS TABLE(id uuid, created_at timestamp with time zone, title text, description text, type engagements.survey_type, questions jsonb, max_responses integer, image_url text, video_url text, reward_amount numeric, duration integer, points integer, pass_percentage numeric, enable_scoring boolean, require_all boolean, enforce_time_limit boolean, pre_survey jsonb, passed boolean, score integer, responded_at timestamp with time zone)
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

ALTER FUNCTION "engagements"."get_user_avail_surveys"(_user_id uuid, _type engagements.survey_type) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "engagements"."send_one_signal_push_notification"(title text, body text, campaign text, image_url text, data jsonb, recipients uuid[]) RETURNS void
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

ALTER FUNCTION "engagements"."send_one_signal_push_notification"(title text, body text, campaign text, image_url text, data jsonb, recipients uuid[]) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "engagements"."send_push_notication"(title text, body text, campaign text, image_url text, data jsonb, recipients uuid[]) RETURNS void
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

  select text_value into _base_api_url from system_configs.remote_config where id = 'eesup_api_base_url';

  -- Construct the payload
  _payload := json_build_object(
    'title', title,
    'body', body,
    'image_url', image_url,
    'campaign', campaign,
    'recipients', recipients,
    'data',data
  )::text;

  _url := concat(_base_api_url,'/notifications/send?','api_key=',_key);

  PERFORM  http_post(
    _url,
    _payload,
    'application/json'
  );
END;
$$;

ALTER FUNCTION "engagements"."send_push_notication"(title text, body text, campaign text, image_url text, data jsonb, recipients uuid[]) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "finances"."balance_wallet_transactions"() RETURNS void
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

CREATE OR REPLACE FUNCTION "finances"."create_order_transaction"(_order_id integer, _trans_id integer) RETURNS void
    LANGUAGE "plpgsql"
    AS $$
BEGIN
 insert into sales.order_transaction(order_id, transaction_id)
 values(_order_id,_trans_id);
END;
$$;

ALTER FUNCTION "finances"."create_order_transaction"(_order_id integer, _trans_id integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "finances"."create_transaction"(_type text, _value numeric, _vested boolean, _description text) RETURNS integer
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    _new_trans_id INTEGER;
BEGIN
    IF _vested = TRUE THEN
        INSERT INTO finances.transaction(type, value, vested, description, confirmed_at)
        VALUES(_type, _value, _vested, _description, NOW()) RETURNING id INTO _new_trans_id;
    ELSE
        INSERT INTO finances.transaction(type, value, vested, description)
        VALUES(_type, _value, _vested, _description) RETURNING id INTO _new_trans_id;
    END IF;

    RETURN _new_trans_id;
END;
$$;

ALTER FUNCTION "finances"."create_transaction"(_type text, _value numeric, _vested boolean, _description text) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "finances"."create_user_wallets"() RETURNS trigger
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

CREATE OR REPLACE FUNCTION "finances"."create_wallet_transaction"(_wallet_id integer, _type text, _value numeric, _vested boolean, _description text) RETURNS integer
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

ALTER FUNCTION "finances"."create_wallet_transaction"(_wallet_id integer, _type text, _value numeric, _vested boolean, _description text) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "finances"."generate_transaction_doc_ref"() RETURNS trigger
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

CREATE OR REPLACE FUNCTION "finances"."get_user_wallets"(_user_id uuid) RETURNS TABLE(id integer, user_id uuid, balance numeric, type_id text, description text, created_at timestamp with time zone, type_created_at timestamp with time zone, withdrawals boolean, deposits boolean, transfers boolean, shopping boolean, is_active boolean, require_rsa_id boolean, sort_num integer)
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

ALTER FUNCTION "finances"."get_user_wallets"(_user_id uuid) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "finances"."get_wallet_transactions"(_wallet_id integer, limit_to integer) RETURNS TABLE(type text, doc_ref integer, value numeric, vested boolean, description text, created_at timestamp with time zone, confirmed_at timestamp with time zone, cancelled_at timestamp with time zone, id integer)
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
        finances.wallet_transaction wt 
    ON 
        t.id = wt.transaction_id
    WHERE 
        wt.wallet_id = _wallet_id AND t.is_deleted IS NOT TRUE AND t.confirmed_at is not null
    limit limit_to;
END; 
$$;

ALTER FUNCTION "finances"."get_wallet_transactions"(_wallet_id integer, limit_to integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "finances"."update_wallet_balance_on_txn_confirmed"() RETURNS trigger
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    _wallet_id INTEGER;
BEGIN
    IF NEW.vested = TRUE AND NEW.confirmed_at IS NOT NULL THEN
        SELECT wtxn.wallet_id INTO _wallet_id 
        FROM finances.wallet_transaction wtxn 
        WHERE wtxn.transaction_id = NEW.id;

        IF _wallet_id IS NOT NULL THEN
            UPDATE finances.wallet w 
            SET balance = w.balance + NEW.value
            WHERE w.id = _wallet_id;
        END IF;
    END IF;
    RETURN NEW;
END;
$$;

ALTER FUNCTION "finances"."update_wallet_balance_on_txn_confirmed"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "geolocations"."calculate_distance_between_2_locations"(lat1 double precision, lon1 double precision, lat2 double precision, lon2 double precision) RETURNS double precision
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

ALTER FUNCTION "geolocations"."calculate_distance_between_2_locations"(lat1 double precision, lon1 double precision, lat2 double precision, lon2 double precision) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "geolocations"."get_address_by_id"(address_id integer) RETURNS TABLE(area_id integer, user_id uuid, recipient_name text, recipient_phone text, street_address text, building_name text, type text, province text, latitude numeric, longitude numeric, created_at timestamp with time zone, is_primary boolean, id integer)
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

ALTER FUNCTION "geolocations"."get_address_by_id"(address_id integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "geolocations"."verify_address"() RETURNS trigger
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

CREATE OR REPLACE FUNCTION "inventory"."get_all_categories"() RETURNS TABLE(id integer, name text, image_url text, parent_id integer, products integer)
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

CREATE OR REPLACE FUNCTION "inventory"."get_category_descendants"(p_cat_id integer) RETURNS TABLE(id integer, name text, image_url text, parent_id integer, products integer)
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

ALTER FUNCTION "inventory"."get_category_descendants"(p_cat_id integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "inventory"."get_products_by_category"(cat_id integer, role public.user_role, limit_to integer) RETURNS TABLE(id integer, category_id integer, name text, description text, image_url text, size text, brand text, type text, uom text, unit_pack_size text, flavour text, sale_price numeric, cost_price numeric, vaa numeric, vat numeric, order_max integer, child_id integer, child_break_qty integer, bar_code text, kit_kat_ref text, vat_claimable boolean, vat_able boolean, class inventory.product_class, category_name text, category_image_url text)
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
        c.image_url AS category_image_url
    FROM
        inventory.product p
    INNER JOIN all_categories ac ON p.category_id = ac.ac_category_id
    INNER JOIN inventory.category c ON p.category_id = c.id
    WHERE
        p.is_active = true AND role = ANY(p.roles) AND p.sale_price > 0
    LIMIT limit_to;
END; $$;

ALTER FUNCTION "inventory"."get_products_by_category"(cat_id integer, role public.user_role, limit_to integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "inventory"."get_random_category"() RETURNS TABLE(id integer, parent_id integer, name text, image_url text)
    LANGUAGE "sql"
    AS $$
SELECT id, parent_id, name, image_url FROM inventory.category
ORDER BY random()
LIMIT 1;
$$;

ALTER FUNCTION "inventory"."get_random_category"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "inventory"."get_random_products"(role public.user_role, limit_to integer) RETURNS TABLE(id integer, category_id integer, name text, description text, image_url text, size text, brand text, type text, uom text, unit_pack_size text, flavour text, sale_price numeric, cost_price numeric, vaa numeric, vat numeric, order_max integer, child_id integer, child_break_qty integer, bar_code text, kit_kat_ref text, vat_claimable boolean, vat_able boolean, class inventory.product_class, category_name text, category_image_url text)
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
        c.image_url AS category_image_url
    FROM inventory.product p
    INNER JOIN inventory.category c ON p.category_id = c.id
    WHERE  p.is_active = true AND role = ANY(p.roles) AND p.sale_price > 0
    ORDER BY random()
    LIMIT limit_to;
END; $$;

ALTER FUNCTION "inventory"."get_random_products"(role public.user_role, limit_to integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "inventory"."search_categories"(query_str text) RETURNS TABLE(id integer, name text, image_url text, parent_id integer, products integer)
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

ALTER FUNCTION "inventory"."search_categories"(query_str text) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "inventory"."search_products"(query_str text, role public.user_role, limit_to integer) RETURNS TABLE(id integer, category_id integer, name text, description text, image_url text, size text, brand text, type text, uom text, unit_pack_size text, flavour text, sale_price numeric, cost_price numeric, vaa numeric, vat numeric, order_max integer, child_id integer, child_break_qty integer, bar_code text, kit_kat_ref text, vat_claimable boolean, vat_able boolean, class inventory.product_class, category_name text, category_image_url text)
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
        c.image_url AS category_image_url
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

ALTER FUNCTION "inventory"."search_products"(query_str text, role public.user_role, limit_to integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "inventory"."search_products_and_categories"(query_str text, role public.user_role, limit_to integer) RETURNS TABLE(products jsonb, categories jsonb)
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

ALTER FUNCTION "inventory"."search_products_and_categories"(query_str text, role public.user_role, limit_to integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."add_product_to_basket"(_basket_id uuid, _product_id integer) RETURNS void
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

ALTER FUNCTION "public"."add_product_to_basket"(_basket_id uuid, _product_id integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."change_referral"(old_referrer_user_id uuid, new_referrer_user_id uuid, referred_user_id uuid) RETURNS void
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

ALTER FUNCTION "public"."change_referral"(old_referrer_user_id uuid, new_referrer_user_id uuid, referred_user_id uuid) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."check_if_referral_is_complete"() RETURNS trigger
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

CREATE OR REPLACE FUNCTION "public"."create_user_default_basket"() RETURNS trigger
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    INSERT INTO public.basket(user_id,name,type)
    VALUES(new.user_id,'My Basket','Monthly');
    RETURN NEW;
END;
$$;

ALTER FUNCTION "public"."create_user_default_basket"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."get_basket_products"(_basket_id uuid) RETURNS TABLE(basket_id uuid, product_id integer, image_url text, category text, name text, quantity integer, price numeric, size text, class inventory.product_class)
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

ALTER FUNCTION "public"."get_basket_products"(_basket_id uuid) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."get_referrals_by_referrer"(_user_id uuid, _limit_to integer) RETURNS TABLE(referrer_user_id uuid, refereed_user_id uuid, refereed_full_name text, created_at timestamp with time zone, transaction_id integer, is_completed boolean)
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

ALTER FUNCTION "public"."get_referrals_by_referrer"(_user_id uuid, _limit_to integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."handle_new_referral"(referee_id uuid, ref_code integer, full_name text, is_confirmed boolean) RETURNS void
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
        -- Handle the case where the wallet is not found, e.g., raise an exception or exit
        RAISE EXCEPTION 'Wallet not found for referrer ID %', referrer_id;
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

ALTER FUNCTION "public"."handle_new_referral"(referee_id uuid, ref_code integer, full_name text, is_confirmed boolean) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."handle_new_user"() RETURNS trigger
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
DECLARE
  ref_name TEXT;
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
        PERFORM public.handle_new_referral(NEW.id, 10775, ref_name, is_confirmed);
      END IF;
    END IF;
  END IF;

  RETURN NEW;
END;
$$;

ALTER FUNCTION "public"."handle_new_user"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."remove_product_from_basket"(_basket_id uuid, _product_id integer) RETURNS void
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

ALTER FUNCTION "public"."remove_product_from_basket"(_basket_id uuid, _product_id integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."send_push_notification"() RETURNS trigger
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

ALTER FUNCTION "public"."send_push_notification"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "sales"."create_order"(_customer_id uuid, _eesupreneur_id uuid, _eesupool_order_id integer, _wallet_id integer, _total_amount numeric, _payment_method finances.payment_method, _address_id integer, _delivery_fee numeric, _products jsonb[]) RETURNS record
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    trans_id INTEGER;
    _ord_id INTEGER;
    product RECORD;
    _outstanding_amount numeric;
    wallet_balance numeric;
BEGIN
    -- Create sales.order
    INSERT INTO sales.order (customer_id, eesupreneur_id, eesupool_order_id, payment_method, delivery_address_id, delivery_fee,value)
    VALUES (_customer_id, _eesupreneur_id, _eesupool_order_id, _payment_method, _address_id, _delivery_fee,_total_amount)
    RETURNING id INTO _ord_id;

    PERFORM sales.insert_order_products(_ord_id, _products);

    -- Process based on payment method
    IF _payment_method = 'Ozow' THEN
        -- Ozow specific logic
        SELECT * INTO trans_id
        FROM finances.create_wallet_transaction(_wallet_id, 'DEP', _total_amount, false, CONCAT(_ord_id, '- Deposit(OZOW eft)'));
        
        PERFORM finances.create_order_transaction(_ord_id, trans_id);

        SELECT * INTO trans_id
        FROM finances.create_wallet_transaction(_wallet_id, 'ORD', -_total_amount, false, CONCAT(_ord_id, '- ORD Payment'));

        PERFORM finances.create_order_transaction(_ord_id, trans_id);

        _outstanding_amount := _total_amount;

    ELSIF _payment_method = 'Split-Ozow & Retail wallet' THEN

        -- Split-Ozow & Retail wallet specific logic
        SELECT balance INTO wallet_balance FROM finances.wallet WHERE id = _wallet_id;

        SELECT * INTO trans_id
        FROM finances.create_wallet_transaction(_wallet_id, 'ORD',-wallet_balance, false, CONCAT(_ord_id, '- ORD Payment'));

        PERFORM finances.create_order_transaction(_ord_id, trans_id);

        _outstanding_amount := _total_amount - wallet_balance;

        SELECT * INTO trans_id
        FROM finances.create_wallet_transaction(_wallet_id, 'DEP', _outstanding_amount, false, CONCAT(_ord_id, '- Deposit(OZOW eft)'));

        PERFORM finances.create_order_transaction(_ord_id, trans_id);

        SELECT * INTO trans_id
        FROM finances.create_wallet_transaction(_wallet_id, 'ORD', -_outstanding_amount, false, CONCAT(_ord_id, '- ORD Payment'));

        PERFORM finances.create_order_transaction(_ord_id, trans_id);

    ELSIF _payment_method = 'Retail wallet' THEN
        -- Retail payment logic
        SELECT * INTO trans_id
        FROM finances.create_wallet_transaction(_wallet_id, 'ORD', -_total_amount, false, CONCAT(_ord_id, '- ORD Payment'));

        PERFORM finances.create_order_transaction(_ord_id, trans_id);

        perform sales.place_confirmed_order(_ord_id,true);

        _outstanding_amount := 0.00;
        
    END IF;

    RETURN (_ord_id, _outstanding_amount);
END;
$$;

ALTER FUNCTION "sales"."create_order"(_customer_id uuid, _eesupreneur_id uuid, _eesupool_order_id integer, _wallet_id integer, _total_amount numeric, _payment_method finances.payment_method, _address_id integer, _delivery_fee numeric, _products jsonb[]) OWNER TO "postgres";

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

CREATE OR REPLACE FUNCTION "sales"."get_customer_orders"(_user_id uuid, _eesupreneur_id uuid, _eesupool_ord_id integer, _status sales.order_status) RETURNS TABLE(id integer, customer_id uuid, eesupreneur_id uuid, eesupool_order_id integer, created_at timestamp with time zone, placed_at timestamp with time zone, packaged_at timestamp with time zone, ready_at timestamp with time zone, collected_at timestamp with time zone, cancelled_at timestamp with time zone, payment_method finances.payment_method, secret_pin integer, delivery_address_id integer, delivery_fee numeric, status sales.order_status, full_name text, corp_name text, products jsonb, address jsonb, value numeric)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
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
        ord.value

    FROM 
        sales.order ord
        left join profile pro on ord.customer_id = pro.user_id
    WHERE 
        (ord.customer_id = _user_id or ord.eesupreneur_id = _eesupreneur_id 
        or ord.eesupool_order_id = _eesupool_ord_id) AND ord.status = _status;
END;
$$;

ALTER FUNCTION "sales"."get_customer_orders"(_user_id uuid, _eesupreneur_id uuid, _eesupool_ord_id integer, _status sales.order_status) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "sales"."get_order_products"(ord_id integer) RETURNS TABLE(order_id integer, product_id integer, image_url text, category text, name text, quantity integer, price numeric, size text, class inventory.product_class)
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

ALTER FUNCTION "sales"."get_order_products"(ord_id integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "sales"."insert_order_products"(_order_id integer, _products jsonb[]) RETURNS void
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
            (jsonb_array_elements(products)->>'price')::NUMERIC as price
        FROM aggregated_products
    )
    INSERT INTO sales.order_product (product_id, order_id, quantity, price)
    SELECT product_id, _order_id, quantity, price FROM inserted_products;
end; $$;

ALTER FUNCTION "sales"."insert_order_products"(_order_id integer, _products jsonb[]) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "sales"."place_confirmed_order"(_order_id integer, _is_confirmed boolean) RETURNS void
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

ALTER FUNCTION "sales"."place_confirmed_order"(_order_id integer, _is_confirmed boolean) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "services"."get_closest_eesupreneurs"(lat double precision, lng double precision, limit_to integer) RETURNS TABLE(id uuid, owner_id uuid, owner_name text, name text, description text, created_at timestamp with time zone, delivery_fee numeric, schedule jsonb, address jsonb, distance double precision)
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

ALTER FUNCTION "services"."get_closest_eesupreneurs"(lat double precision, lng double precision, limit_to integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "services"."get_eesupreneurs"(lat double precision, lng double precision) RETURNS TABLE(id uuid, owner_id uuid, owner_name text, name text, description text, created_at timestamp with time zone, delivery_fee numeric, schedule jsonb, address jsonb, distance double precision)
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

ALTER FUNCTION "services"."get_eesupreneurs"(lat double precision, lng double precision) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "services"."get_partnership_surveys"(_user_id uuid, _surveys uuid[]) RETURNS TABLE(id uuid, created_at timestamp with time zone, title text, description text, type engagements.survey_type, questions jsonb, max_responses integer, image_url text, video_url text, reward_amount numeric, duration integer, points integer, pass_percentage numeric, enable_scoring boolean, require_all boolean, enforce_time_limit boolean, pre_survey jsonb, passed boolean, score integer, responded_at timestamp with time zone)
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

ALTER FUNCTION "services"."get_partnership_surveys"(_user_id uuid, _surveys uuid[]) OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";

CREATE TABLE IF NOT EXISTS "communities"."eesupool" (
    "created_at" timestamp with time zone DEFAULT now(),
    "name" text NOT NULL,
    "description" text,
    "admin_fee" numeric DEFAULT 10.00,
    "receiving_fee" numeric DEFAULT 10.00,
    "collection_fee" numeric DEFAULT 15.00,
    "packaging_fee" numeric DEFAULT 65.00,
    "is_public" boolean DEFAULT false,
    "chat_enabled" boolean DEFAULT false NOT NULL,
    "address_id" integer,
    "parent_id" integer,
    "box_code" text,
    "street_code" text,
    "chat_tags_suggestions" text[] DEFAULT '{}'::text[] NOT NULL,
    "chat_tags" text[] DEFAULT '{}'::text[] NOT NULL,
    "id" integer NOT NULL,
    "level" communities.eesupool_level,
    "type" communities.eesupool_type NOT NULL,
    "code" integer NOT NULL
);

ALTER TABLE "communities"."eesupool" OWNER TO "postgres";

ALTER TABLE "communities"."eesupool" ALTER COLUMN "code" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "communities"."eesupool_code_seq1"
    START WITH 53940
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE "communities"."eesupool" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "communities"."eesupool_id_seq"
    START WITH 1576921
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "communities"."eesupool_issue" (
    "id" uuid DEFAULT gen_random_uuid() NOT NULL,
    "created_at" timestamp with time zone DEFAULT now() NOT NULL,
    "reporter_id" uuid,
    "offender_id" uuid,
    "description" text NOT NULL,
    "message_id" integer,
    "eesupool_id" integer NOT NULL,
    "attachments" jsonb[],
    "resolved_at" timestamp with time zone,
    "parent_pool_id" integer
);

ALTER TABLE "communities"."eesupool_issue" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "communities"."eesupool_member" (
    "user_id" uuid NOT NULL,
    "eesupool_id" integer NOT NULL,
    "is_censored" boolean DEFAULT false NOT NULL,
    "id" uuid DEFAULT gen_random_uuid() NOT NULL,
    "created_at" timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL,
    "role" communities.eesupool_member_role DEFAULT 'Member'::communities.eesupool_member_role NOT NULL
);

ALTER TABLE "communities"."eesupool_member" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "communities"."eesupool_order" (
    "id" integer NOT NULL,
    "eesupool_id" integer NOT NULL,
    "receiver_id" uuid,
    "created_at" timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL,
    "schedule_for" timestamp with time zone NOT NULL,
    "delivered_at" timestamp with time zone,
    "closes_at" timestamp with time zone NOT NULL,
    "admin_fee" numeric,
    "packer_fee" numeric,
    "receiver_fee" numeric,
    "collection_fee" numeric,
    "address_id" integer
);

ALTER TABLE "communities"."eesupool_order" OWNER TO "postgres";

ALTER TABLE "communities"."eesupool_order" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "communities"."eesupool_order_id_seq"
    START WITH 1503000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "communities"."eesupool_request" (
    "user_id" uuid NOT NULL,
    "created_at" timestamp with time zone DEFAULT now() NOT NULL,
    "eesupool_id" integer NOT NULL,
    "type" text DEFAULT 'invite'::text NOT NULL,
    "status" communities.eesupool_request_status DEFAULT 'Pending'::communities.eesupool_request_status NOT NULL
);

ALTER TABLE "communities"."eesupool_request" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "communities"."event" (
    "eesupool_id" integer,
    "created_at" timestamp with time zone DEFAULT now() NOT NULL,
    "title" text NOT NULL,
    "notes" text,
    "address_id" integer,
    "start_at" timestamp with time zone NOT NULL,
    "end_at" timestamp with time zone NOT NULL,
    "id" uuid DEFAULT gen_random_uuid() NOT NULL,
    "remote_url" text,
    "attachments" jsonb[]
);

ALTER TABLE "communities"."event" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "communities"."event_attendee" (
    "event_id" uuid NOT NULL,
    "member_id" uuid NOT NULL,
    "created_at" timestamp with time zone DEFAULT now() NOT NULL
);

ALTER TABLE "communities"."event_attendee" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "communities"."member_order_assigment" (
    "order_id" integer NOT NULL,
    "packer" uuid,
    "collector" uuid
);

ALTER TABLE "communities"."member_order_assigment" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "communities"."message" (
    "eesupool_id" integer NOT NULL,
    "author_id" uuid NOT NULL,
    "created_at" timestamp with time zone DEFAULT now() NOT NULL,
    "content" text,
    "reply_on_id" integer,
    "attachments" jsonb[],
    "hash_tags" text[],
    "is_approved" boolean DEFAULT true NOT NULL,
    "is_deleted" boolean DEFAULT false NOT NULL,
    "id" integer NOT NULL,
    "broadcast_to" communities.eesupool_level[]
);

ALTER TABLE "communities"."message" OWNER TO "postgres";

ALTER TABLE "communities"."message" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "communities"."message_id_seq"
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "communities"."message_reaction" (
    "member_id" uuid NOT NULL,
    "created_at" timestamp with time zone DEFAULT now() NOT NULL,
    "message_id" integer NOT NULL,
    "liked" boolean DEFAULT true NOT NULL
);

ALTER TABLE "communities"."message_reaction" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "communities"."message_seen" (
    "member_id" uuid NOT NULL,
    "message_id" integer NOT NULL,
    "created_at" timestamp with time zone DEFAULT now() NOT NULL
);

ALTER TABLE "communities"."message_seen" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "engagements"."banner" (
    "id" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT now() NOT NULL,
    "content" jsonb[] NOT NULL
);

ALTER TABLE "engagements"."banner" OWNER TO "postgres";

ALTER TABLE "engagements"."banner" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "engagements"."banner_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "engagements"."response" (
    "created_at" timestamp with time zone DEFAULT now() NOT NULL,
    "user_id" uuid NOT NULL,
    "passed" boolean,
    "score" integer,
    "answers" jsonb NOT NULL,
    "survey_id" uuid NOT NULL
);

ALTER TABLE "engagements"."response" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "engagements"."survey" (
    "id" uuid DEFAULT gen_random_uuid() NOT NULL,
    "created_at" timestamp with time zone DEFAULT now() NOT NULL,
    "title" text NOT NULL,
    "description" text,
    "questions" jsonb NOT NULL,
    "wallet" text,
    "max_responses" integer,
    "image_url" text,
    "video_url" text,
    "reward_amount" numeric,
    "duration" integer,
    "points" integer,
    "pass_percentage" numeric,
    "enable_scoring" boolean DEFAULT false,
    "require_all" boolean DEFAULT false,
    "enforce_time_limit" boolean DEFAULT false,
    "is_public" boolean DEFAULT false NOT NULL,
    "roles" public.user_role[] NOT NULL,
    "pre_id" uuid,
    "is_private" boolean DEFAULT false NOT NULL,
    "can_delete" boolean DEFAULT true NOT NULL,
    "type" engagements.survey_type NOT NULL
);

ALTER TABLE "engagements"."survey" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "finances"."transaction" (
    "type" text NOT NULL,
    "doc_ref" integer NOT NULL,
    "value" numeric DEFAULT 0.00 NOT NULL,
    "vested" boolean NOT NULL,
    "description" text NOT NULL,
    "created_at" timestamp with time zone DEFAULT now() NOT NULL,
    "confirmed_at" timestamp with time zone,
    "cancelled_at" timestamp with time zone,
    "is_deleted" boolean DEFAULT false,
    "id" integer NOT NULL
);

ALTER TABLE "finances"."transaction" OWNER TO "postgres";

ALTER TABLE "finances"."transaction" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "finances"."transaction_id_seq"
    START WITH 2601375
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "finances"."transaction_type" (
    "id" text NOT NULL,
    "label" text NOT NULL,
    "inventory" boolean DEFAULT false NOT NULL,
    "created_at" timestamp with time zone DEFAULT now() NOT NULL
);

ALTER TABLE "finances"."transaction_type" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "finances"."wallet" (
    "user_id" uuid NOT NULL,
    "created_at" timestamp with time zone DEFAULT now(),
    "type" text NOT NULL,
    "balance" numeric NOT NULL,
    "id" integer NOT NULL
);

ALTER TABLE "finances"."wallet" OWNER TO "postgres";

ALTER TABLE "finances"."wallet" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "finances"."wallet_id_seq"
    START WITH 150002600
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "finances"."wallet_transaction" (
    "wallet_id" integer NOT NULL,
    "transaction_id" integer NOT NULL
);

ALTER TABLE "finances"."wallet_transaction" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "finances"."wallet_type" (
    "description" text NOT NULL,
    "created_at" timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL,
    "withdrawls" boolean DEFAULT false NOT NULL,
    "deposits" boolean DEFAULT false NOT NULL,
    "transfers" boolean DEFAULT false NOT NULL,
    "shopping" boolean DEFAULT false NOT NULL,
    "is_active" boolean DEFAULT false NOT NULL,
    "require_rsa_id" boolean DEFAULT false NOT NULL,
    "sort_num" integer DEFAULT 1 NOT NULL,
    "id" text DEFAULT ''::text NOT NULL,
    "roles" public.user_role[] NOT NULL
);

ALTER TABLE "finances"."wallet_type" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "geolocations"."address" (
    "area_id" integer,
    "user_id" uuid,
    "recipient_name" text NOT NULL,
    "recipient_phone" text NOT NULL,
    "street_address" text NOT NULL,
    "building_name" text,
    "type" text NOT NULL,
    "province" text NOT NULL,
    "latitude" numeric,
    "longitude" numeric,
    "created_at" timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL,
    "is_primary" boolean DEFAULT false NOT NULL,
    "id" integer NOT NULL
);

ALTER TABLE "geolocations"."address" OWNER TO "postgres";

ALTER TABLE "geolocations"."address" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "geolocations"."address_id_seq"
    START WITH 10185
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "geolocations"."target_area" (
    "id" integer NOT NULL,
    "name" text NOT NULL,
    "center_latitude" numeric NOT NULL,
    "center_longitude" numeric NOT NULL,
    "area_radius" numeric NOT NULL,
    "center_full_address" text NOT NULL,
    "is_active" boolean DEFAULT true NOT NULL
);

ALTER TABLE "geolocations"."target_area" OWNER TO "postgres";

ALTER TABLE "geolocations"."target_area" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "geolocations"."target_area_area_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "inventory"."category" (
    "id" integer NOT NULL,
    "created_at" timestamp with time zone DEFAULT now() NOT NULL,
    "name" text NOT NULL,
    "image_url" text,
    "parent_id" integer,
    "is_active" boolean DEFAULT false NOT NULL
);

ALTER TABLE "inventory"."category" OWNER TO "postgres";

ALTER TABLE "inventory"."category" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "inventory"."category_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "inventory"."product" (
    "id" integer NOT NULL,
    "category_id" integer NOT NULL,
    "name" text NOT NULL,
    "description" text NOT NULL,
    "image_url" text,
    "size" text,
    "brand" text,
    "type" text,
    "uom" text,
    "unit_pack_size" text,
    "flavour" text,
    "sale_price" numeric DEFAULT 0.00 NOT NULL,
    "cost_price" numeric DEFAULT 0.00 NOT NULL,
    "vaa" numeric DEFAULT 0.00 NOT NULL,
    "vat" numeric DEFAULT 0.00 NOT NULL,
    "order_max" integer,
    "stock_break_enabled" boolean DEFAULT false NOT NULL,
    "is_active" boolean DEFAULT true NOT NULL,
    "child_id" integer,
    "child_break_qty" integer,
    "bar_code" text,
    "kit_kat_ref" text,
    "sp_ref" integer,
    "sp_factor" numeric,
    "vat_claimable" boolean DEFAULT false NOT NULL,
    "vat_able" boolean DEFAULT false NOT NULL,
    "rel_id" integer,
    "gpper" numeric,
    "bar_code_verified" boolean DEFAULT false NOT NULL,
    "kit_kat_ref_verified" boolean DEFAULT false NOT NULL,
    "class" inventory.product_class DEFAULT 'Food'::inventory.product_class NOT NULL,
    "marup" numeric,
    "roles" public.user_role[]
);

ALTER TABLE "inventory"."product" OWNER TO "postgres";

ALTER TABLE "inventory"."product" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "inventory"."product_id_seq"
    START WITH 4011
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "inventory"."product_request" (
    "id" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT now() NOT NULL,
    "user_id" uuid NOT NULL,
    "product_id" integer,
    "type" text NOT NULL,
    "brand" text NOT NULL,
    "pack_size" text NOT NULL,
    "variant" text
);

ALTER TABLE "inventory"."product_request" OWNER TO "postgres";

ALTER TABLE "inventory"."product_request" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "inventory"."product_request_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "inventory"."scraped_product" (
    "id" integer NOT NULL,
    "bar_code" text,
    "kit_kat_ref" text,
    "source" text NOT NULL,
    "scrape_date" timestamp with time zone,
    "price_category" text,
    "original_price" numeric,
    "offer_price" text,
    "source_code" text,
    "name" text,
    "description" text,
    "category" text,
    "additional1" text,
    "ingredients" text,
    "usage" text,
    "features" text,
    "affiliation" text,
    "promotion" boolean,
    "url" text,
    "region" text,
    "brand" text,
    "keyword" text
);

ALTER TABLE "inventory"."scraped_product" OWNER TO "postgres";

ALTER TABLE "inventory"."scraped_product" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "inventory"."scraped_product_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "public"."basket" (
    "id" uuid DEFAULT gen_random_uuid() NOT NULL,
    "user_id" uuid NOT NULL,
    "created_at" timestamp with time zone DEFAULT now() NOT NULL,
    "name" text NOT NULL,
    "type" public.basket_type
);

ALTER TABLE "public"."basket" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."basket_product" (
    "basket_id" uuid NOT NULL,
    "product_id" integer NOT NULL,
    "quantity" integer DEFAULT 1 NOT NULL
);

ALTER TABLE "public"."basket_product" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."notification" (
    "id" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT now() NOT NULL,
    "title" text NOT NULL,
    "body" text,
    "data" jsonb,
    "seen_at" timestamp with time zone,
    "type" public.notification_type DEFAULT 'other'::public.notification_type NOT NULL,
    "user_id" uuid,
    "channel" public.notification_channel DEFAULT 'push'::public.notification_channel NOT NULL
);

ALTER TABLE "public"."notification" OWNER TO "postgres";

ALTER TABLE "public"."notification" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."notification_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "public"."profile" (
    "user_id" uuid NOT NULL,
    "rsa_id_number" text,
    "first_name" text,
    "last_name" text,
    "email" text,
    "phone" text,
    "is_active" boolean DEFAULT true,
    "deactivated_on" timestamp with time zone,
    "accepted_ts_and_cs" boolean DEFAULT true NOT NULL,
    "role" public.user_role DEFAULT 'Ubuntunist'::public.user_role NOT NULL,
    "corp_name" text,
    "npc_reg" text,
    "corp_reg" text,
    "corp_address_id" integer,
    "corp_vat_no" text,
    "is_approved" boolean DEFAULT true NOT NULL,
    "created_at" timestamp with time zone DEFAULT now(),
    "referral_code" integer NOT NULL,
    "class" public.user_class
);

ALTER TABLE "public"."profile" OWNER TO "postgres";

ALTER TABLE "public"."profile" ALTER COLUMN "referral_code" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."profile_referral_code_seq1"
    START WITH 14750
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "public"."referral" (
    "referrer_user_id" uuid NOT NULL,
    "refereed_user_id" uuid NOT NULL,
    "created_at" timestamp with time zone DEFAULT now() NOT NULL,
    "transaction_id" integer NOT NULL,
    "is_completed" boolean DEFAULT false NOT NULL
);

ALTER TABLE "public"."referral" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "sales"."order" (
    "id" integer NOT NULL,
    "customer_id" uuid NOT NULL,
    "eesupreneur_id" uuid,
    "created_at" timestamp with time zone DEFAULT now(),
    "placed_at" timestamp with time zone,
    "packaged_at" timestamp with time zone,
    "ready_at" timestamp with time zone,
    "collected_at" timestamp with time zone,
    "cancelled_at" timestamp with time zone,
    "payment_method" finances.payment_method NOT NULL,
    "secret_pin" integer DEFAULT sales.generate_order_secret_pin() NOT NULL,
    "delivery_address_id" integer,
    "delivery_fee" numeric,
    "status" sales.order_status DEFAULT 'Pending'::sales.order_status NOT NULL,
    "eesupool_order_id" integer,
    "value" numeric
);

ALTER TABLE "sales"."order" OWNER TO "postgres";

ALTER TABLE "sales"."order" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "sales"."order_id_seq"
    START WITH 101883
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

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
    "price" numeric DEFAULT 0.00 NOT NULL
);

ALTER TABLE "sales"."order_product" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "sales"."order_transaction" (
    "order_id" integer NOT NULL,
    "transaction_id" integer NOT NULL
);

ALTER TABLE "sales"."order_transaction" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "services"."eesupreneur" (
    "id" uuid DEFAULT gen_random_uuid() NOT NULL,
    "owner_id" uuid NOT NULL,
    "name" text NOT NULL,
    "description" text,
    "address_id" integer NOT NULL,
    "created_at" timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL,
    "is_hidden" boolean DEFAULT false NOT NULL,
    "is_active" boolean DEFAULT false NOT NULL,
    "delivery_fee" numeric DEFAULT 0.00 NOT NULL,
    "schedule" jsonb DEFAULT '{"days": [{"day": "Friday", "open": "08:00", "close": "18:00", "index": 5, "is_closed": false}, {"day": "Monday", "open": "08:00", "close": "18:00", "index": 1, "is_closed": false}, {"day": "Sunday", "open": "08:00", "close": "18:00", "index": 7, "is_closed": false}, {"day": "Tuesday", "open": "08:00", "close": "18:00", "index": 2, "is_closed": false}, {"day": "Saturday", "open": "08:00", "close": "18:00", "index": 6, "is_closed": false}, {"day": "Thursday", "open": "08:00", "close": "18:00", "index": 4, "is_closed": false}, {"day": "Wednesday", "open": "08:00", "close": "18:00", "index": 3, "is_closed": false}]}'::jsonb NOT NULL
);

ALTER TABLE "services"."eesupreneur" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "services"."eesupreneur_employee" (
    "user_id" uuid NOT NULL,
    "created_at" timestamp with time zone DEFAULT now() NOT NULL,
    "eesupreneur_id" uuid NOT NULL,
    "role" public.eesupreneur_employee_role NOT NULL
);

ALTER TABLE "services"."eesupreneur_employee" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "services"."partner" (
    "created_at" timestamp with time zone DEFAULT now() NOT NULL,
    "id" uuid DEFAULT gen_random_uuid() NOT NULL,
    "title" text NOT NULL,
    "description" text NOT NULL,
    "surveys" jsonb[],
    "is_open" boolean DEFAULT false NOT NULL,
    "max_apps" integer DEFAULT 1 NOT NULL,
    "requirements" jsonb
);

ALTER TABLE "services"."partner" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "services"."partner_application" (
    "partner_id" uuid NOT NULL,
    "user_id" uuid NOT NULL,
    "created_at" timestamp with time zone DEFAULT now() NOT NULL,
    "survey_responses" jsonb[] NOT NULL,
    "id" integer NOT NULL,
    "approved_at" timestamp with time zone
);

ALTER TABLE "services"."partner_application" OWNER TO "postgres";

ALTER TABLE "services"."partner_application" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "services"."partner_application_id_seq"
    START WITH 13230
    INCREMENT BY 3
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

-- CREATE TABLE IF NOT EXISTS "supabase_migrations"."schema_migrations" (
--     "version" text NOT NULL,
--     "statements" text[],
--     "name" text
-- );

-- ALTER TABLE "supabase_migrations"."schema_migrations" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "system_configs"."api_key" (
    "id" text NOT NULL,
    "created_at" timestamp with time zone DEFAULT now() NOT NULL,
    "key" text NOT NULL,
    "is_active" boolean NOT NULL
);

ALTER TABLE "system_configs"."api_key" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "system_configs"."remote_config" (
    "id" text NOT NULL,
    "text_value" text,
    "num_value" numeric,
    "json_value" jsonb
);

ALTER TABLE "system_configs"."remote_config" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "warehousing"."distribution_centre" (
    "id" uuid DEFAULT gen_random_uuid() NOT NULL,
    "created_at" timestamp with time zone DEFAULT now() NOT NULL,
    "name" text NOT NULL,
    "address_id" integer
);

ALTER TABLE "warehousing"."distribution_centre" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "warehousing"."supplier" (
    "id" uuid DEFAULT gen_random_uuid() NOT NULL,
    "created_at" timestamp with time zone DEFAULT now() NOT NULL,
    "name" text NOT NULL
);

ALTER TABLE "warehousing"."supplier" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "warehousing"."warehouse" (
    "id" uuid DEFAULT gen_random_uuid() NOT NULL,
    "created_at" timestamp with time zone DEFAULT now() NOT NULL,
    "name" text NOT NULL,
    "address_id" integer
);

ALTER TABLE "warehousing"."warehouse" OWNER TO "postgres";

ALTER TABLE ONLY "communities"."eesupool_issue"
    ADD CONSTRAINT "eesupool_issue_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "communities"."eesupool_member"
    ADD CONSTRAINT "eesupool_member_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "communities"."eesupool_order"
    ADD CONSTRAINT "eesupool_order_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "communities"."eesupool"
    ADD CONSTRAINT "eesupool_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "communities"."eesupool_request"
    ADD CONSTRAINT "eesupool_request_pkey" PRIMARY KEY ("user_id", "eesupool_id");

ALTER TABLE ONLY "communities"."event_attendee"
    ADD CONSTRAINT "event_attandee_pkey" PRIMARY KEY ("event_id", "member_id");

ALTER TABLE ONLY "communities"."event"
    ADD CONSTRAINT "event_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "communities"."member_order_assigment"
    ADD CONSTRAINT "member_order_pkey" PRIMARY KEY ("order_id");

ALTER TABLE ONLY "communities"."message"
    ADD CONSTRAINT "message_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "communities"."message_reaction"
    ADD CONSTRAINT "message_reaction_pkey" PRIMARY KEY ("member_id", "message_id");

ALTER TABLE ONLY "communities"."message_seen"
    ADD CONSTRAINT "message_read_pkey" PRIMARY KEY ("member_id", "message_id");

ALTER TABLE ONLY "communities"."eesupool"
    ADD CONSTRAINT "stokvel_name_key" UNIQUE ("name");

ALTER TABLE ONLY "communities"."eesupool_member"
    ADD CONSTRAINT "unique_eesupool_member" UNIQUE ("user_id", "eesupool_id");

ALTER TABLE ONLY "communities"."eesupool_request"
    ADD CONSTRAINT "unique_user_and_pool_ids" UNIQUE ("user_id", "eesupool_id");

ALTER TABLE ONLY "engagements"."banner"
    ADD CONSTRAINT "banner_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "engagements"."response"
    ADD CONSTRAINT "response_pkey" PRIMARY KEY ("user_id", "survey_id");

ALTER TABLE ONLY "engagements"."survey"
    ADD CONSTRAINT "survey_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "finances"."transaction"
    ADD CONSTRAINT "transaction_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "finances"."transaction_type"
    ADD CONSTRAINT "transaction_type_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "finances"."wallet"
    ADD CONSTRAINT "wallet_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "finances"."wallet_transaction"
    ADD CONSTRAINT "wallet_transaction_pkey" PRIMARY KEY ("wallet_id", "transaction_id");

ALTER TABLE ONLY "finances"."wallet_type"
    ADD CONSTRAINT "wallet_type_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "geolocations"."address"
    ADD CONSTRAINT "address_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "geolocations"."target_area"
    ADD CONSTRAINT "target_area_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "inventory"."category"
    ADD CONSTRAINT "category_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "inventory"."product"
    ADD CONSTRAINT "product_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "inventory"."product_request"
    ADD CONSTRAINT "product_request_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "inventory"."scraped_product"
    ADD CONSTRAINT "scraped_product_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."basket_product"
    ADD CONSTRAINT "basket_product_pkey" PRIMARY KEY ("basket_id", "product_id");

ALTER TABLE ONLY "public"."notification"
    ADD CONSTRAINT "notification_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."profile"
    ADD CONSTRAINT "profile_email_key" UNIQUE ("email");

ALTER TABLE ONLY "public"."profile"
    ADD CONSTRAINT "profile_phone_key" UNIQUE ("phone");

ALTER TABLE ONLY "public"."referral"
    ADD CONSTRAINT "referral_pkey" PRIMARY KEY ("referrer_user_id", "refereed_user_id");

ALTER TABLE ONLY "public"."profile"
    ADD CONSTRAINT "users_pkey" PRIMARY KEY ("user_id");

ALTER TABLE ONLY "public"."profile"
    ADD CONSTRAINT "users_rsa_id_number_key" UNIQUE ("rsa_id_number");

ALTER TABLE ONLY "public"."basket"
    ADD CONSTRAINT "wishlist_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "sales"."order"
    ADD CONSTRAINT "order_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "sales"."order_product"
    ADD CONSTRAINT "order_product_pkey" PRIMARY KEY ("product_id", "order_id");

ALTER TABLE ONLY "sales"."order_transaction"
    ADD CONSTRAINT "order_transaction_pkey" PRIMARY KEY ("order_id", "transaction_id");

ALTER TABLE ONLY "services"."eesupreneur_employee"
    ADD CONSTRAINT "eesupreneur_employee_pkey" PRIMARY KEY ("user_id", "eesupreneur_id");

ALTER TABLE ONLY "services"."eesupreneur"
    ADD CONSTRAINT "eesupreneur_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "services"."partner_application"
    ADD CONSTRAINT "partner_application_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "services"."partner"
    ADD CONSTRAINT "service_pkey" PRIMARY KEY ("id");

-- ALTER TABLE ONLY "supabase_migrations"."schema_migrations"
--     ADD CONSTRAINT "schema_migrations_pkey" PRIMARY KEY ("version");

ALTER TABLE ONLY "system_configs"."api_key"
    ADD CONSTRAINT "api_key_key_key" UNIQUE ("key");

ALTER TABLE ONLY "system_configs"."api_key"
    ADD CONSTRAINT "api_key_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "system_configs"."remote_config"
    ADD CONSTRAINT "remote_config_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "warehousing"."distribution_centre"
    ADD CONSTRAINT "distribution_centre_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "warehousing"."supplier"
    ADD CONSTRAINT "supplier_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "warehousing"."warehouse"
    ADD CONSTRAINT "warehouse_pkey" PRIMARY KEY ("id");

CREATE TRIGGER broadcast_eesupool_message_trigger AFTER INSERT ON communities.message FOR EACH ROW EXECUTE FUNCTION communities.broadcast_eesupool_message();

CREATE TRIGGER create_eesupool_invite_notification_triggere AFTER INSERT ON communities.eesupool_request FOR EACH ROW EXECUTE FUNCTION communities.create_eesupool_invite_notification();

CREATE TRIGGER create_eesupool_member_trigger AFTER INSERT OR UPDATE ON communities.eesupool_request FOR EACH ROW EXECUTE FUNCTION communities.create_eesupool_member();

CREATE TRIGGER create_eesupool_message_notification_trigger AFTER INSERT ON communities.message FOR EACH ROW EXECUTE FUNCTION communities.notify_eesupool_members();

CREATE TRIGGER on_invite_revoked_delete_notification_trigger AFTER DELETE ON communities.eesupool_request FOR EACH ROW EXECUTE FUNCTION communities.on_invite_revoked_delete_notification();

CREATE TRIGGER generate_transaction_doc_ref_trigger BEFORE INSERT ON finances.transaction FOR EACH ROW EXECUTE FUNCTION finances.generate_transaction_doc_ref();

CREATE TRIGGER update_wallet_balance_on_txn_confirmed_trigger AFTER INSERT OR UPDATE ON finances.transaction FOR EACH ROW EXECUTE FUNCTION finances.update_wallet_balance_on_txn_confirmed();

CREATE TRIGGER check_if_referral_is_complete_trigger AFTER INSERT ON geolocations.address FOR EACH ROW EXECUTE FUNCTION public.check_if_referral_is_complete();

CREATE TRIGGER verify_addres_trigger BEFORE INSERT OR UPDATE ON geolocations.address FOR EACH ROW EXECUTE FUNCTION geolocations.verify_address();

CREATE TRIGGER check_if_referral_is_complete_trigger AFTER UPDATE ON public.profile FOR EACH ROW EXECUTE FUNCTION public.check_if_referral_is_complete();

CREATE TRIGGER create_user_default_basket_trigger AFTER INSERT ON public.profile FOR EACH ROW EXECUTE FUNCTION public.create_user_default_basket();

CREATE TRIGGER create_user_wallets_trigger AFTER INSERT ON public.profile FOR EACH ROW EXECUTE FUNCTION finances.create_user_wallets();

CREATE TRIGGER send_push_notification_trigger AFTER INSERT ON public.notification FOR EACH ROW EXECUTE FUNCTION public.send_push_notification();

ALTER TABLE ONLY "communities"."eesupool"
    ADD CONSTRAINT "eesupool_address_id_fkey" FOREIGN KEY (address_id) REFERENCES geolocations.address(id) ON DELETE SET NULL;

ALTER TABLE ONLY "communities"."eesupool_issue"
    ADD CONSTRAINT "eesupool_issue_eesupool_id_fkey" FOREIGN KEY (eesupool_id) REFERENCES communities.eesupool(id) ON DELETE CASCADE;

ALTER TABLE ONLY "communities"."eesupool_issue"
    ADD CONSTRAINT "eesupool_issue_message_id_fkey" FOREIGN KEY (message_id) REFERENCES communities.message(id) ON DELETE CASCADE;

ALTER TABLE ONLY "communities"."eesupool_issue"
    ADD CONSTRAINT "eesupool_issue_offender_id_fkey" FOREIGN KEY (offender_id) REFERENCES communities.eesupool_member(id) ON DELETE SET NULL;

ALTER TABLE ONLY "communities"."eesupool_issue"
    ADD CONSTRAINT "eesupool_issue_parent_pool_id_fkey" FOREIGN KEY (parent_pool_id) REFERENCES communities.eesupool(id) ON DELETE SET NULL;

ALTER TABLE ONLY "communities"."eesupool_issue"
    ADD CONSTRAINT "eesupool_issue_reporter_id_fkey" FOREIGN KEY (reporter_id) REFERENCES communities.eesupool_member(id) ON DELETE SET NULL;

ALTER TABLE ONLY "communities"."eesupool_member"
    ADD CONSTRAINT "eesupool_member_eesupool_id_fkey" FOREIGN KEY (eesupool_id) REFERENCES communities.eesupool(id) ON DELETE CASCADE;

ALTER TABLE ONLY "communities"."eesupool_member"
    ADD CONSTRAINT "eesupool_member_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.profile(user_id) ON DELETE CASCADE;

ALTER TABLE ONLY "communities"."eesupool_order"
    ADD CONSTRAINT "eesupool_order_address_id_fkey" FOREIGN KEY (address_id) REFERENCES geolocations.address(id) ON DELETE CASCADE;

ALTER TABLE ONLY "communities"."eesupool_order"
    ADD CONSTRAINT "eesupool_order_eesupool_id_fkey" FOREIGN KEY (eesupool_id) REFERENCES communities.eesupool(id) ON DELETE CASCADE;

ALTER TABLE ONLY "communities"."eesupool_order"
    ADD CONSTRAINT "eesupool_order_receiver_id_fkey" FOREIGN KEY (receiver_id) REFERENCES communities.eesupool_member(id) ON DELETE SET NULL;

ALTER TABLE ONLY "communities"."eesupool"
    ADD CONSTRAINT "eesupool_parent_id_fkey" FOREIGN KEY (parent_id) REFERENCES communities.eesupool(id) ON DELETE SET NULL;

ALTER TABLE ONLY "communities"."eesupool_request"
    ADD CONSTRAINT "eesupool_request_eesupool_id_fkey" FOREIGN KEY (eesupool_id) REFERENCES communities.eesupool(id) ON DELETE CASCADE;

ALTER TABLE ONLY "communities"."eesupool_request"
    ADD CONSTRAINT "eesupool_request_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.profile(user_id) ON DELETE CASCADE;

ALTER TABLE ONLY "communities"."event"
    ADD CONSTRAINT "event_address_id_fkey" FOREIGN KEY (address_id) REFERENCES geolocations.address(id) ON DELETE SET NULL;

ALTER TABLE ONLY "communities"."event_attendee"
    ADD CONSTRAINT "event_attendee_event_id_fkey" FOREIGN KEY (event_id) REFERENCES communities.event(id) ON DELETE CASCADE;

ALTER TABLE ONLY "communities"."event_attendee"
    ADD CONSTRAINT "event_attendee_member_id_fkey" FOREIGN KEY (member_id) REFERENCES communities.eesupool_member(id) ON DELETE CASCADE;

ALTER TABLE ONLY "communities"."event"
    ADD CONSTRAINT "event_eesupool_id_fkey" FOREIGN KEY (eesupool_id) REFERENCES communities.eesupool(id) ON DELETE CASCADE;

ALTER TABLE ONLY "communities"."member_order_assigment"
    ADD CONSTRAINT "member_order_assigment_collector_fkey" FOREIGN KEY (collector) REFERENCES communities.eesupool_member(id) ON DELETE SET NULL;

ALTER TABLE ONLY "communities"."member_order_assigment"
    ADD CONSTRAINT "member_order_assigment_order_id_fkey" FOREIGN KEY (order_id) REFERENCES sales."order"(id) ON DELETE CASCADE;

ALTER TABLE ONLY "communities"."member_order_assigment"
    ADD CONSTRAINT "member_order_assigment_packer_fkey" FOREIGN KEY (packer) REFERENCES communities.eesupool_member(id) ON DELETE SET NULL;

ALTER TABLE ONLY "communities"."message"
    ADD CONSTRAINT "message_author_id_fkey" FOREIGN KEY (author_id) REFERENCES communities.eesupool_member(id) ON DELETE SET NULL;

ALTER TABLE ONLY "communities"."message"
    ADD CONSTRAINT "message_eesupool_id_fkey" FOREIGN KEY (eesupool_id) REFERENCES communities.eesupool(id) ON DELETE CASCADE;

ALTER TABLE ONLY "communities"."message_reaction"
    ADD CONSTRAINT "message_reaction_member_id_fkey" FOREIGN KEY (member_id) REFERENCES communities.eesupool_member(id) ON DELETE CASCADE;

ALTER TABLE ONLY "communities"."message_reaction"
    ADD CONSTRAINT "message_reaction_message_id_fkey" FOREIGN KEY (message_id) REFERENCES communities.message(id) ON DELETE CASCADE;

ALTER TABLE ONLY "communities"."message_seen"
    ADD CONSTRAINT "message_seen_member_id_fkey" FOREIGN KEY (member_id) REFERENCES communities.eesupool_member(id) ON DELETE CASCADE;

ALTER TABLE ONLY "communities"."message_seen"
    ADD CONSTRAINT "message_seen_message_id_fkey" FOREIGN KEY (message_id) REFERENCES communities.message(id) ON DELETE CASCADE;

ALTER TABLE ONLY "engagements"."response"
    ADD CONSTRAINT "response_survey_id_fkey" FOREIGN KEY (survey_id) REFERENCES engagements.survey(id) ON DELETE CASCADE;

ALTER TABLE ONLY "engagements"."response"
    ADD CONSTRAINT "response_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.profile(user_id) ON DELETE CASCADE;

ALTER TABLE ONLY "engagements"."survey"
    ADD CONSTRAINT "survey_pre_id_fkey" FOREIGN KEY (pre_id) REFERENCES engagements.survey(id) ON DELETE SET NULL;

ALTER TABLE ONLY "engagements"."survey"
    ADD CONSTRAINT "survey_wallet_fkey" FOREIGN KEY (wallet) REFERENCES finances.wallet_type(id) ON DELETE SET NULL;

ALTER TABLE ONLY "finances"."transaction"
    ADD CONSTRAINT "transaction_type_fkey" FOREIGN KEY (type) REFERENCES finances.transaction_type(id) ON DELETE SET NULL;

ALTER TABLE ONLY "finances"."wallet_transaction"
    ADD CONSTRAINT "wallet_transaction_transaction_id_fkey" FOREIGN KEY (transaction_id) REFERENCES finances.transaction(id) ON DELETE CASCADE;

ALTER TABLE ONLY "finances"."wallet_transaction"
    ADD CONSTRAINT "wallet_transaction_wallet_id_fkey" FOREIGN KEY (wallet_id) REFERENCES finances.wallet(id) ON DELETE CASCADE;

ALTER TABLE ONLY "finances"."wallet"
    ADD CONSTRAINT "wallet_type_fkey" FOREIGN KEY (type) REFERENCES finances.wallet_type(id) ON DELETE RESTRICT;

ALTER TABLE ONLY "finances"."wallet"
    ADD CONSTRAINT "wallet_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.profile(user_id) ON DELETE CASCADE;

ALTER TABLE ONLY "geolocations"."address"
    ADD CONSTRAINT "address_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.profile(user_id) ON DELETE CASCADE;

ALTER TABLE ONLY "inventory"."category"
    ADD CONSTRAINT "category_parent_id_fkey" FOREIGN KEY (parent_id) REFERENCES inventory.category(id) ON DELETE SET NULL;

ALTER TABLE ONLY "inventory"."product"
    ADD CONSTRAINT "product_category_id_fkey" FOREIGN KEY (category_id) REFERENCES inventory.category(id) ON DELETE RESTRICT;

ALTER TABLE ONLY "inventory"."product_request"
    ADD CONSTRAINT "product_request_product_id_fkey" FOREIGN KEY (product_id) REFERENCES inventory.product(id) ON DELETE SET NULL;

ALTER TABLE ONLY "inventory"."product_request"
    ADD CONSTRAINT "product_request_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.profile(user_id) ON DELETE CASCADE;

ALTER TABLE ONLY "public"."basket_product"
    ADD CONSTRAINT "basket_product_basket_id_fkey" FOREIGN KEY (basket_id) REFERENCES public.basket(id) ON DELETE CASCADE;

ALTER TABLE ONLY "public"."basket_product"
    ADD CONSTRAINT "basket_product_product_id_fkey" FOREIGN KEY (product_id) REFERENCES inventory.product(id) ON DELETE CASCADE;

ALTER TABLE ONLY "public"."notification"
    ADD CONSTRAINT "notification_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.profile(user_id) ON DELETE CASCADE;

ALTER TABLE ONLY "public"."profile"
    ADD CONSTRAINT "profile_new_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;

ALTER TABLE ONLY "public"."profile"
    ADD CONSTRAINT "profile_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;

ALTER TABLE ONLY "public"."referral"
    ADD CONSTRAINT "referral_refereed_user_id_fkey" FOREIGN KEY (refereed_user_id) REFERENCES public.profile(user_id) ON DELETE CASCADE;

ALTER TABLE ONLY "public"."referral"
    ADD CONSTRAINT "referral_referrer_user_id_fkey" FOREIGN KEY (referrer_user_id) REFERENCES public.profile(user_id) ON DELETE CASCADE;

ALTER TABLE ONLY "public"."referral"
    ADD CONSTRAINT "referral_transaction_id_fkey" FOREIGN KEY (transaction_id) REFERENCES finances.transaction(id) ON DELETE RESTRICT;

ALTER TABLE ONLY "public"."basket"
    ADD CONSTRAINT "wishlist_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.profile(user_id) ON DELETE CASCADE;

ALTER TABLE ONLY "sales"."order"
    ADD CONSTRAINT "order_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES public.profile(user_id) ON DELETE CASCADE;

ALTER TABLE ONLY "sales"."order"
    ADD CONSTRAINT "order_delivery_address_id_fkey" FOREIGN KEY (delivery_address_id) REFERENCES geolocations.address(id) ON DELETE RESTRICT;

ALTER TABLE ONLY "sales"."order"
    ADD CONSTRAINT "order_eesupool_order_id_fkey" FOREIGN KEY (eesupool_order_id) REFERENCES communities.eesupool_order(id) ON DELETE RESTRICT;

ALTER TABLE ONLY "sales"."order"
    ADD CONSTRAINT "order_eesupreneur_id_fkey" FOREIGN KEY (eesupreneur_id) REFERENCES services.eesupreneur(id) ON DELETE RESTRICT;

ALTER TABLE ONLY "sales"."order_product"
    ADD CONSTRAINT "order_product_order_id_fkey" FOREIGN KEY (order_id) REFERENCES sales."order"(id) ON DELETE CASCADE;

ALTER TABLE ONLY "sales"."order_product"
    ADD CONSTRAINT "order_product_product_id_fkey" FOREIGN KEY (product_id) REFERENCES inventory.product(id) ON DELETE RESTRICT;

ALTER TABLE ONLY "sales"."order_transaction"
    ADD CONSTRAINT "order_transaction_order_id_fkey" FOREIGN KEY (order_id) REFERENCES sales."order"(id) ON DELETE CASCADE;

ALTER TABLE ONLY "sales"."order_transaction"
    ADD CONSTRAINT "order_transaction_transaction_id_fkey" FOREIGN KEY (transaction_id) REFERENCES finances.transaction(id) ON DELETE CASCADE;

ALTER TABLE ONLY "services"."eesupreneur"
    ADD CONSTRAINT "eesupreneur_address_id_fkey" FOREIGN KEY (address_id) REFERENCES geolocations.address(id) ON DELETE CASCADE;

ALTER TABLE ONLY "services"."eesupreneur_employee"
    ADD CONSTRAINT "eesupreneur_employee_eesupreneur_id_fkey" FOREIGN KEY (eesupreneur_id) REFERENCES services.eesupreneur(id) ON DELETE CASCADE;

ALTER TABLE ONLY "services"."eesupreneur_employee"
    ADD CONSTRAINT "eesupreneur_employee_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.profile(user_id) ON DELETE CASCADE;

ALTER TABLE ONLY "services"."eesupreneur"
    ADD CONSTRAINT "eesupreneur_owner_id_fkey" FOREIGN KEY (owner_id) REFERENCES public.profile(user_id) ON DELETE CASCADE;

ALTER TABLE ONLY "services"."partner_application"
    ADD CONSTRAINT "partner_application_partner_id_fkey" FOREIGN KEY (partner_id) REFERENCES services.partner(id) ON DELETE CASCADE;

ALTER TABLE ONLY "services"."partner_application"
    ADD CONSTRAINT "partner_application_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.profile(user_id) ON DELETE CASCADE;

ALTER TABLE ONLY "warehousing"."distribution_centre"
    ADD CONSTRAINT "distribution_centre_address_id_fkey" FOREIGN KEY (address_id) REFERENCES geolocations.address(id) ON DELETE SET NULL;

ALTER TABLE ONLY "warehousing"."warehouse"
    ADD CONSTRAINT "warehouse_address_id_fkey" FOREIGN KEY (address_id) REFERENCES geolocations.address(id) ON DELETE SET NULL;

CREATE POLICY "Enable access for authenticated users only" ON "communities"."eesupool_request" TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "Enable access for authenticated users only" ON "communities"."member_order_assigment" TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "Enable access to Authenticated Users only" ON "communities"."eesupool" TO authenticated USING (true);

CREATE POLICY "Enable access to Authenticated Users only" ON "communities"."eesupool_issue" TO authenticated USING (true);

CREATE POLICY "Enable access to Authenticated Users only" ON "communities"."eesupool_member" TO authenticated USING (true);

CREATE POLICY "Enable access to Authenticated Users only" ON "communities"."eesupool_order" TO authenticated USING (true);

CREATE POLICY "Enable access to Authenticated Users only" ON "communities"."event" TO authenticated USING (true);

CREATE POLICY "Enable access to Authenticated Users only" ON "communities"."event_attendee" TO authenticated USING (true);

CREATE POLICY "Enable access to Authenticated Users only" ON "communities"."message" TO authenticated USING (true);

CREATE POLICY "Enable access to Authenticated Users only" ON "communities"."message_reaction" TO authenticated USING (true);

CREATE POLICY "Enable access to Authenticated Users only" ON "communities"."message_seen" TO authenticated USING (true);

ALTER TABLE "communities"."eesupool" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "communities"."eesupool_issue" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "communities"."eesupool_member" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "communities"."eesupool_order" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "communities"."eesupool_request" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "communities"."event" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "communities"."event_attendee" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "communities"."member_order_assigment" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "communities"."message" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "communities"."message_reaction" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "communities"."message_seen" ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Enable access for authenticated users only" ON "engagements"."banner" TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "Enable access to Authenticated Users only" ON "engagements"."response" TO authenticated USING (true);

CREATE POLICY "Enable access to Authenticated Users only" ON "engagements"."survey" TO authenticated USING (true);

ALTER TABLE "engagements"."banner" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "engagements"."response" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "engagements"."survey" ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Enable access to Authenticated Users only" ON "finances"."transaction" TO authenticated USING (true);

CREATE POLICY "Enable access to Authenticated Users only" ON "finances"."transaction_type" TO authenticated USING (true);

CREATE POLICY "Enable access to Authenticated Users only" ON "finances"."wallet" TO authenticated USING (true);

CREATE POLICY "Enable access to Authenticated Users only" ON "finances"."wallet_transaction" TO authenticated USING (true);

CREATE POLICY "Enable access to Authenticated Users only" ON "finances"."wallet_type" TO authenticated USING (true);

ALTER TABLE "finances"."transaction" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "finances"."transaction_type" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "finances"."wallet" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "finances"."wallet_transaction" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "finances"."wallet_type" ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Enable access for authenticated users only" ON "geolocations"."address" TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "Enable access for authenticated users only" ON "geolocations"."target_area" TO authenticated USING (true) WITH CHECK (true);

ALTER TABLE "geolocations"."address" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "geolocations"."target_area" ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Enable access for authenticated users only" ON "inventory"."product_request" TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "Enable access to Authenticated Users only" ON "inventory"."category" TO authenticated USING (true);

CREATE POLICY "Enable access to Authenticated Users only" ON "inventory"."product" TO authenticated USING (true);

ALTER TABLE "inventory"."category" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "inventory"."product" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "inventory"."product_request" ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Enable access for authenticated users only" ON "public"."notification" TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "Enable access for authenticated users only" ON "public"."profile" TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "Enable access to Authenticated Users only" ON "public"."basket" TO authenticated USING (true);

CREATE POLICY "Enable access to Authenticated Users only" ON "public"."basket_product" TO authenticated USING (true);

CREATE POLICY "Enable access to Authenticated Users only" ON "public"."referral" TO authenticated USING (true);

CREATE POLICY "Enable read access for all users" ON "public"."profile" FOR SELECT USING (true);

ALTER TABLE "public"."basket" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."basket_product" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."notification" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."profile" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."referral" ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Enable access for authenticated users only" ON "sales"."order_transaction" TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "Enable access to Authenticated Users only" ON "sales"."order" TO authenticated USING (true);

CREATE POLICY "Enable access to Authenticated Users only" ON "sales"."order_product" TO authenticated USING (true);

ALTER TABLE "sales"."order" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "sales"."order_product" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "sales"."order_transaction" ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Enable access for authenticated users only" ON "services"."eesupreneur_employee" TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "Enable access for authenticated users only" ON "services"."partner" TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "Enable access for authenticated users only" ON "services"."partner_application" TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "Enable access to Authenticated Users only" ON "services"."eesupreneur" TO authenticated USING (true);

ALTER TABLE "services"."eesupreneur" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "services"."eesupreneur_employee" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "services"."partner" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "services"."partner_application" ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Enable access for authenticated users only" ON "system_configs"."api_key" TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "Enable access for authenticated users only" ON "system_configs"."remote_config" TO authenticated USING (true) WITH CHECK (true);

ALTER TABLE "system_configs"."api_key" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "system_configs"."remote_config" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "warehousing"."distribution_centre" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "warehousing"."supplier" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "warehousing"."warehouse" ENABLE ROW LEVEL SECURITY;

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

GRANT ALL ON FUNCTION "communities"."add_or_delete_reaction"(_message_id integer, _member_id uuid, _liked boolean) TO "anon";
GRANT ALL ON FUNCTION "communities"."add_or_delete_reaction"(_message_id integer, _member_id uuid, _liked boolean) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."add_or_delete_reaction"(_message_id integer, _member_id uuid, _liked boolean) TO "service_role";

GRANT ALL ON FUNCTION "communities"."broadcast_eesupool_message"() TO "anon";
GRANT ALL ON FUNCTION "communities"."broadcast_eesupool_message"() TO "authenticated";
GRANT ALL ON FUNCTION "communities"."broadcast_eesupool_message"() TO "service_role";

GRANT ALL ON FUNCTION "communities"."count_unseen_messages"(_eesupool_id integer, _member_id uuid) TO "anon";
GRANT ALL ON FUNCTION "communities"."count_unseen_messages"(_eesupool_id integer, _member_id uuid) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."count_unseen_messages"(_eesupool_id integer, _member_id uuid) TO "service_role";

GRANT ALL ON FUNCTION "communities"."count_user_eesupools_by_type"(_id uuid, _type communities.eesupool_type) TO "anon";
GRANT ALL ON FUNCTION "communities"."count_user_eesupools_by_type"(_id uuid, _type communities.eesupool_type) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."count_user_eesupools_by_type"(_id uuid, _type communities.eesupool_type) TO "service_role";

GRANT ALL ON FUNCTION "communities"."create_eesupool_invite_notification"() TO "anon";
GRANT ALL ON FUNCTION "communities"."create_eesupool_invite_notification"() TO "authenticated";
GRANT ALL ON FUNCTION "communities"."create_eesupool_invite_notification"() TO "service_role";

GRANT ALL ON FUNCTION "communities"."create_eesupool_member"() TO "anon";
GRANT ALL ON FUNCTION "communities"."create_eesupool_member"() TO "authenticated";
GRANT ALL ON FUNCTION "communities"."create_eesupool_member"() TO "service_role";

GRANT ALL ON FUNCTION "communities"."create_new_eesupool"(admin_id uuid, name text, description text, parent_id integer, level communities.eesupool_level, type communities.eesupool_type) TO "anon";
GRANT ALL ON FUNCTION "communities"."create_new_eesupool"(admin_id uuid, name text, description text, parent_id integer, level communities.eesupool_level, type communities.eesupool_type) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."create_new_eesupool"(admin_id uuid, name text, description text, parent_id integer, level communities.eesupool_level, type communities.eesupool_type) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_eesupool_by_id"(_user_id uuid, _pool_id integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_eesupool_by_id"(_user_id uuid, _pool_id integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_eesupool_by_id"(_user_id uuid, _pool_id integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_eesupool_descendants_by_level"(parent_pool_id integer, children_level communities.eesupool_level) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_eesupool_descendants_by_level"(parent_pool_id integer, children_level communities.eesupool_level) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_eesupool_descendants_by_level"(parent_pool_id integer, children_level communities.eesupool_level) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_eesupool_event_attendees"(p_event_id uuid, p_pool_id integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_eesupool_event_attendees"(p_event_id uuid, p_pool_id integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_eesupool_event_attendees"(p_event_id uuid, p_pool_id integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_eesupool_events"(pool_id integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_eesupool_events"(pool_id integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_eesupool_events"(pool_id integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_eesupool_issues"(pool_id integer, limit_to integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_eesupool_issues"(pool_id integer, limit_to integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_eesupool_issues"(pool_id integer, limit_to integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_eesupool_member_by_id"(membership_id uuid) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_eesupool_member_by_id"(membership_id uuid) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_eesupool_member_by_id"(membership_id uuid) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_eesupool_members"(pool_id integer, limit_to integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_eesupool_members"(pool_id integer, limit_to integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_eesupool_members"(pool_id integer, limit_to integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_eesupool_messages"(pool_id integer, approved boolean, limit_to integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_eesupool_messages"(pool_id integer, approved boolean, limit_to integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_eesupool_messages"(pool_id integer, approved boolean, limit_to integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_eesupool_messages_by_hash_tag"(pool_id integer, hash_tag text, approved boolean, limit_to integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_eesupool_messages_by_hash_tag"(pool_id integer, hash_tag text, approved boolean, limit_to integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_eesupool_messages_by_hash_tag"(pool_id integer, hash_tag text, approved boolean, limit_to integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_eesupool_orders"(pool_id integer, limit_to integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_eesupool_orders"(pool_id integer, limit_to integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_eesupool_orders"(pool_id integer, limit_to integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_eesupool_requests"(_pool_id integer, _user_id uuid, _type text, limit_to integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_eesupool_requests"(_pool_id integer, _user_id uuid, _type text, limit_to integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_eesupool_requests"(_pool_id integer, _user_id uuid, _type text, limit_to integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_eesupool_requests_and_invites"(pool_id integer, p_user_id uuid, p_type text, limit_to integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_eesupool_requests_and_invites"(pool_id integer, p_user_id uuid, p_type text, limit_to integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_eesupool_requests_and_invites"(pool_id integer, p_user_id uuid, p_type text, limit_to integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_eesupools_descendants"(_user_id uuid, parent_pool_id integer, limit_to integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_eesupools_descendants"(_user_id uuid, parent_pool_id integer, limit_to integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_eesupools_descendants"(_user_id uuid, parent_pool_id integer, limit_to integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_eesupools_descendants_streets_for_requests"(_user_id uuid, parent_pool_id integer, limit_to integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_eesupools_descendants_streets_for_requests"(_user_id uuid, parent_pool_id integer, limit_to integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_eesupools_descendants_streets_for_requests"(_user_id uuid, parent_pool_id integer, limit_to integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_message_by_id"(m_id integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_message_by_id"(m_id integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_message_by_id"(m_id integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_message_reaction"(m_id integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_message_reaction"(m_id integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_message_reaction"(m_id integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_message_reactions"(m_id integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_message_reactions"(m_id integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_message_reactions"(m_id integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_open_eesupool_orders"(_user_id uuid, _eesupool_id integer, _limit_to integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_open_eesupool_orders"(_user_id uuid, _eesupool_id integer, _limit_to integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_open_eesupool_orders"(_user_id uuid, _eesupool_id integer, _limit_to integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_sub_kases_for_search"(_parent_id integer, _user_id uuid) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_sub_kases_for_search"(_parent_id integer, _user_id uuid) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_sub_kases_for_search"(_parent_id integer, _user_id uuid) TO "service_role";

GRANT ALL ON FUNCTION "communities"."get_user_eesupools"(id uuid, limit_to integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_user_eesupools"(id uuid, limit_to integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_user_eesupools"(id uuid, limit_to integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."notify_eesupool_members"() TO "anon";
GRANT ALL ON FUNCTION "communities"."notify_eesupool_members"() TO "authenticated";
GRANT ALL ON FUNCTION "communities"."notify_eesupool_members"() TO "service_role";

GRANT ALL ON FUNCTION "communities"."on_invite_revoked_delete_notification"() TO "anon";
GRANT ALL ON FUNCTION "communities"."on_invite_revoked_delete_notification"() TO "authenticated";
GRANT ALL ON FUNCTION "communities"."on_invite_revoked_delete_notification"() TO "service_role";

GRANT ALL ON FUNCTION "communities"."search_eesupools_descendants"(_user_id uuid, parent_pool_id integer, query_str text, limit_to integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."search_eesupools_descendants"(_user_id uuid, parent_pool_id integer, query_str text, limit_to integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."search_eesupools_descendants"(_user_id uuid, parent_pool_id integer, query_str text, limit_to integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."search_for_eesupools_by_type"(query_str text, _user_id uuid, _type communities.eesupool_type, limit_to integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."search_for_eesupools_by_type"(query_str text, _user_id uuid, _type communities.eesupool_type, limit_to integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."search_for_eesupools_by_type"(query_str text, _user_id uuid, _type communities.eesupool_type, limit_to integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."search_for_trade_eesupools"(query_str text, _user_id uuid, lat double precision, lng double precision, limit_to integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."search_for_trade_eesupools"(query_str text, _user_id uuid, lat double precision, lng double precision, limit_to integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."search_for_trade_eesupools"(query_str text, _user_id uuid, lat double precision, lng double precision, limit_to integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."search_profiles_for_eesupool_invites"(query_str text, pool_id integer, limit_to integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."search_profiles_for_eesupool_invites"(query_str text, pool_id integer, limit_to integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."search_profiles_for_eesupool_invites"(query_str text, pool_id integer, limit_to integer) TO "service_role";

GRANT ALL ON FUNCTION "communities"."search_user_eesupools"(query_str text, _type communities.eesupool_type, _user_id uuid, limit_to integer) TO "anon";
GRANT ALL ON FUNCTION "communities"."search_user_eesupools"(query_str text, _type communities.eesupool_type, _user_id uuid, limit_to integer) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."search_user_eesupools"(query_str text, _type communities.eesupool_type, _user_id uuid, limit_to integer) TO "service_role";

GRANT ALL ON FUNCTION "engagements"."get_survey_by_id"(_survey_id uuid, _user_id uuid) TO "anon";
GRANT ALL ON FUNCTION "engagements"."get_survey_by_id"(_survey_id uuid, _user_id uuid) TO "authenticated";
GRANT ALL ON FUNCTION "engagements"."get_survey_by_id"(_survey_id uuid, _user_id uuid) TO "service_role";

GRANT ALL ON FUNCTION "engagements"."get_user_avail_surveys"(_user_id uuid, _type engagements.survey_type) TO "anon";
GRANT ALL ON FUNCTION "engagements"."get_user_avail_surveys"(_user_id uuid, _type engagements.survey_type) TO "authenticated";
GRANT ALL ON FUNCTION "engagements"."get_user_avail_surveys"(_user_id uuid, _type engagements.survey_type) TO "service_role";

GRANT ALL ON FUNCTION "engagements"."send_one_signal_push_notification"(title text, body text, campaign text, image_url text, data jsonb, recipients uuid[]) TO "anon";
GRANT ALL ON FUNCTION "engagements"."send_one_signal_push_notification"(title text, body text, campaign text, image_url text, data jsonb, recipients uuid[]) TO "authenticated";
GRANT ALL ON FUNCTION "engagements"."send_one_signal_push_notification"(title text, body text, campaign text, image_url text, data jsonb, recipients uuid[]) TO "service_role";

GRANT ALL ON FUNCTION "engagements"."send_push_notication"(title text, body text, campaign text, image_url text, data jsonb, recipients uuid[]) TO "anon";
GRANT ALL ON FUNCTION "engagements"."send_push_notication"(title text, body text, campaign text, image_url text, data jsonb, recipients uuid[]) TO "authenticated";
GRANT ALL ON FUNCTION "engagements"."send_push_notication"(title text, body text, campaign text, image_url text, data jsonb, recipients uuid[]) TO "service_role";

GRANT ALL ON FUNCTION "finances"."balance_wallet_transactions"() TO "anon";
GRANT ALL ON FUNCTION "finances"."balance_wallet_transactions"() TO "authenticated";
GRANT ALL ON FUNCTION "finances"."balance_wallet_transactions"() TO "service_role";

GRANT ALL ON FUNCTION "finances"."create_order_transaction"(_order_id integer, _trans_id integer) TO "anon";
GRANT ALL ON FUNCTION "finances"."create_order_transaction"(_order_id integer, _trans_id integer) TO "authenticated";
GRANT ALL ON FUNCTION "finances"."create_order_transaction"(_order_id integer, _trans_id integer) TO "service_role";

GRANT ALL ON FUNCTION "finances"."create_transaction"(_type text, _value numeric, _vested boolean, _description text) TO "anon";
GRANT ALL ON FUNCTION "finances"."create_transaction"(_type text, _value numeric, _vested boolean, _description text) TO "authenticated";
GRANT ALL ON FUNCTION "finances"."create_transaction"(_type text, _value numeric, _vested boolean, _description text) TO "service_role";

GRANT ALL ON FUNCTION "finances"."create_user_wallets"() TO "anon";
GRANT ALL ON FUNCTION "finances"."create_user_wallets"() TO "authenticated";
GRANT ALL ON FUNCTION "finances"."create_user_wallets"() TO "service_role";

GRANT ALL ON FUNCTION "finances"."create_wallet_transaction"(_wallet_id integer, _type text, _value numeric, _vested boolean, _description text) TO "anon";
GRANT ALL ON FUNCTION "finances"."create_wallet_transaction"(_wallet_id integer, _type text, _value numeric, _vested boolean, _description text) TO "authenticated";
GRANT ALL ON FUNCTION "finances"."create_wallet_transaction"(_wallet_id integer, _type text, _value numeric, _vested boolean, _description text) TO "service_role";

GRANT ALL ON FUNCTION "finances"."generate_transaction_doc_ref"() TO "anon";
GRANT ALL ON FUNCTION "finances"."generate_transaction_doc_ref"() TO "authenticated";
GRANT ALL ON FUNCTION "finances"."generate_transaction_doc_ref"() TO "service_role";

GRANT ALL ON FUNCTION "finances"."get_user_wallets"(_user_id uuid) TO "anon";
GRANT ALL ON FUNCTION "finances"."get_user_wallets"(_user_id uuid) TO "authenticated";
GRANT ALL ON FUNCTION "finances"."get_user_wallets"(_user_id uuid) TO "service_role";

GRANT ALL ON FUNCTION "finances"."get_wallet_transactions"(_wallet_id integer, limit_to integer) TO "anon";
GRANT ALL ON FUNCTION "finances"."get_wallet_transactions"(_wallet_id integer, limit_to integer) TO "authenticated";
GRANT ALL ON FUNCTION "finances"."get_wallet_transactions"(_wallet_id integer, limit_to integer) TO "service_role";

GRANT ALL ON FUNCTION "finances"."update_wallet_balance_on_txn_confirmed"() TO "anon";
GRANT ALL ON FUNCTION "finances"."update_wallet_balance_on_txn_confirmed"() TO "authenticated";
GRANT ALL ON FUNCTION "finances"."update_wallet_balance_on_txn_confirmed"() TO "service_role";

GRANT ALL ON FUNCTION "geolocations"."calculate_distance_between_2_locations"(lat1 double precision, lon1 double precision, lat2 double precision, lon2 double precision) TO "anon";
GRANT ALL ON FUNCTION "geolocations"."calculate_distance_between_2_locations"(lat1 double precision, lon1 double precision, lat2 double precision, lon2 double precision) TO "authenticated";
GRANT ALL ON FUNCTION "geolocations"."calculate_distance_between_2_locations"(lat1 double precision, lon1 double precision, lat2 double precision, lon2 double precision) TO "service_role";

GRANT ALL ON FUNCTION "geolocations"."get_address_by_id"(address_id integer) TO "anon";
GRANT ALL ON FUNCTION "geolocations"."get_address_by_id"(address_id integer) TO "authenticated";
GRANT ALL ON FUNCTION "geolocations"."get_address_by_id"(address_id integer) TO "service_role";

GRANT ALL ON FUNCTION "geolocations"."verify_address"() TO "anon";
GRANT ALL ON FUNCTION "geolocations"."verify_address"() TO "authenticated";
GRANT ALL ON FUNCTION "geolocations"."verify_address"() TO "service_role";

GRANT ALL ON FUNCTION "inventory"."get_all_categories"() TO "anon";
GRANT ALL ON FUNCTION "inventory"."get_all_categories"() TO "authenticated";
GRANT ALL ON FUNCTION "inventory"."get_all_categories"() TO "service_role";

GRANT ALL ON FUNCTION "inventory"."get_category_descendants"(p_cat_id integer) TO "anon";
GRANT ALL ON FUNCTION "inventory"."get_category_descendants"(p_cat_id integer) TO "authenticated";
GRANT ALL ON FUNCTION "inventory"."get_category_descendants"(p_cat_id integer) TO "service_role";

GRANT ALL ON FUNCTION "inventory"."get_products_by_category"(cat_id integer, role public.user_role, limit_to integer) TO "anon";
GRANT ALL ON FUNCTION "inventory"."get_products_by_category"(cat_id integer, role public.user_role, limit_to integer) TO "authenticated";
GRANT ALL ON FUNCTION "inventory"."get_products_by_category"(cat_id integer, role public.user_role, limit_to integer) TO "service_role";

GRANT ALL ON FUNCTION "inventory"."get_random_category"() TO "anon";
GRANT ALL ON FUNCTION "inventory"."get_random_category"() TO "authenticated";
GRANT ALL ON FUNCTION "inventory"."get_random_category"() TO "service_role";

GRANT ALL ON FUNCTION "inventory"."get_random_products"(role public.user_role, limit_to integer) TO "anon";
GRANT ALL ON FUNCTION "inventory"."get_random_products"(role public.user_role, limit_to integer) TO "authenticated";
GRANT ALL ON FUNCTION "inventory"."get_random_products"(role public.user_role, limit_to integer) TO "service_role";

GRANT ALL ON FUNCTION "inventory"."search_categories"(query_str text) TO "anon";
GRANT ALL ON FUNCTION "inventory"."search_categories"(query_str text) TO "authenticated";
GRANT ALL ON FUNCTION "inventory"."search_categories"(query_str text) TO "service_role";

GRANT ALL ON FUNCTION "inventory"."search_products"(query_str text, role public.user_role, limit_to integer) TO "anon";
GRANT ALL ON FUNCTION "inventory"."search_products"(query_str text, role public.user_role, limit_to integer) TO "authenticated";
GRANT ALL ON FUNCTION "inventory"."search_products"(query_str text, role public.user_role, limit_to integer) TO "service_role";

GRANT ALL ON FUNCTION "inventory"."search_products_and_categories"(query_str text, role public.user_role, limit_to integer) TO "anon";
GRANT ALL ON FUNCTION "inventory"."search_products_and_categories"(query_str text, role public.user_role, limit_to integer) TO "authenticated";
GRANT ALL ON FUNCTION "inventory"."search_products_and_categories"(query_str text, role public.user_role, limit_to integer) TO "service_role";

GRANT ALL ON FUNCTION "public"."add_product_to_basket"(_basket_id uuid, _product_id integer) TO "anon";
GRANT ALL ON FUNCTION "public"."add_product_to_basket"(_basket_id uuid, _product_id integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."add_product_to_basket"(_basket_id uuid, _product_id integer) TO "service_role";

GRANT ALL ON FUNCTION "public"."change_referral"(old_referrer_user_id uuid, new_referrer_user_id uuid, referred_user_id uuid) TO "anon";
GRANT ALL ON FUNCTION "public"."change_referral"(old_referrer_user_id uuid, new_referrer_user_id uuid, referred_user_id uuid) TO "authenticated";
GRANT ALL ON FUNCTION "public"."change_referral"(old_referrer_user_id uuid, new_referrer_user_id uuid, referred_user_id uuid) TO "service_role";

GRANT ALL ON FUNCTION "public"."check_if_referral_is_complete"() TO "anon";
GRANT ALL ON FUNCTION "public"."check_if_referral_is_complete"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."check_if_referral_is_complete"() TO "service_role";

GRANT ALL ON FUNCTION "public"."create_user_default_basket"() TO "anon";
GRANT ALL ON FUNCTION "public"."create_user_default_basket"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."create_user_default_basket"() TO "service_role";

GRANT ALL ON FUNCTION "public"."get_basket_products"(_basket_id uuid) TO "anon";
GRANT ALL ON FUNCTION "public"."get_basket_products"(_basket_id uuid) TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_basket_products"(_basket_id uuid) TO "service_role";

GRANT ALL ON FUNCTION "public"."get_referrals_by_referrer"(_user_id uuid, _limit_to integer) TO "anon";
GRANT ALL ON FUNCTION "public"."get_referrals_by_referrer"(_user_id uuid, _limit_to integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_referrals_by_referrer"(_user_id uuid, _limit_to integer) TO "service_role";

GRANT ALL ON FUNCTION "public"."handle_new_referral"(referee_id uuid, ref_code integer, full_name text, is_confirmed boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."handle_new_referral"(referee_id uuid, ref_code integer, full_name text, is_confirmed boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_new_referral"(referee_id uuid, ref_code integer, full_name text, is_confirmed boolean) TO "service_role";

GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "service_role";

GRANT ALL ON FUNCTION "public"."remove_product_from_basket"(_basket_id uuid, _product_id integer) TO "anon";
GRANT ALL ON FUNCTION "public"."remove_product_from_basket"(_basket_id uuid, _product_id integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."remove_product_from_basket"(_basket_id uuid, _product_id integer) TO "service_role";

GRANT ALL ON FUNCTION "public"."send_push_notification"() TO "anon";
GRANT ALL ON FUNCTION "public"."send_push_notification"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."send_push_notification"() TO "service_role";

GRANT ALL ON FUNCTION "sales"."create_order"(_customer_id uuid, _eesupreneur_id uuid, _eesupool_order_id integer, _wallet_id integer, _total_amount numeric, _payment_method finances.payment_method, _address_id integer, _delivery_fee numeric, _products jsonb[]) TO "anon";
GRANT ALL ON FUNCTION "sales"."create_order"(_customer_id uuid, _eesupreneur_id uuid, _eesupool_order_id integer, _wallet_id integer, _total_amount numeric, _payment_method finances.payment_method, _address_id integer, _delivery_fee numeric, _products jsonb[]) TO "authenticated";
GRANT ALL ON FUNCTION "sales"."create_order"(_customer_id uuid, _eesupreneur_id uuid, _eesupool_order_id integer, _wallet_id integer, _total_amount numeric, _payment_method finances.payment_method, _address_id integer, _delivery_fee numeric, _products jsonb[]) TO "service_role";

GRANT ALL ON FUNCTION "sales"."generate_order_secret_pin"() TO "anon";
GRANT ALL ON FUNCTION "sales"."generate_order_secret_pin"() TO "authenticated";
GRANT ALL ON FUNCTION "sales"."generate_order_secret_pin"() TO "service_role";

GRANT ALL ON FUNCTION "sales"."get_customer_orders"(_user_id uuid, _eesupreneur_id uuid, _eesupool_ord_id integer, _status sales.order_status) TO "anon";
GRANT ALL ON FUNCTION "sales"."get_customer_orders"(_user_id uuid, _eesupreneur_id uuid, _eesupool_ord_id integer, _status sales.order_status) TO "authenticated";
GRANT ALL ON FUNCTION "sales"."get_customer_orders"(_user_id uuid, _eesupreneur_id uuid, _eesupool_ord_id integer, _status sales.order_status) TO "service_role";

GRANT ALL ON FUNCTION "sales"."get_order_products"(ord_id integer) TO "anon";
GRANT ALL ON FUNCTION "sales"."get_order_products"(ord_id integer) TO "authenticated";
GRANT ALL ON FUNCTION "sales"."get_order_products"(ord_id integer) TO "service_role";

GRANT ALL ON FUNCTION "sales"."insert_order_products"(_order_id integer, _products jsonb[]) TO "anon";
GRANT ALL ON FUNCTION "sales"."insert_order_products"(_order_id integer, _products jsonb[]) TO "authenticated";
GRANT ALL ON FUNCTION "sales"."insert_order_products"(_order_id integer, _products jsonb[]) TO "service_role";

GRANT ALL ON FUNCTION "sales"."place_confirmed_order"(_order_id integer, _is_confirmed boolean) TO "anon";
GRANT ALL ON FUNCTION "sales"."place_confirmed_order"(_order_id integer, _is_confirmed boolean) TO "authenticated";
GRANT ALL ON FUNCTION "sales"."place_confirmed_order"(_order_id integer, _is_confirmed boolean) TO "service_role";

GRANT ALL ON FUNCTION "services"."get_closest_eesupreneurs"(lat double precision, lng double precision, limit_to integer) TO "anon";
GRANT ALL ON FUNCTION "services"."get_closest_eesupreneurs"(lat double precision, lng double precision, limit_to integer) TO "authenticated";
GRANT ALL ON FUNCTION "services"."get_closest_eesupreneurs"(lat double precision, lng double precision, limit_to integer) TO "service_role";

GRANT ALL ON FUNCTION "services"."get_eesupreneurs"(lat double precision, lng double precision) TO "anon";
GRANT ALL ON FUNCTION "services"."get_eesupreneurs"(lat double precision, lng double precision) TO "authenticated";
GRANT ALL ON FUNCTION "services"."get_eesupreneurs"(lat double precision, lng double precision) TO "service_role";

GRANT ALL ON FUNCTION "services"."get_partnership_surveys"(_user_id uuid, _surveys uuid[]) TO "anon";
GRANT ALL ON FUNCTION "services"."get_partnership_surveys"(_user_id uuid, _surveys uuid[]) TO "authenticated";
GRANT ALL ON FUNCTION "services"."get_partnership_surveys"(_user_id uuid, _surveys uuid[]) TO "service_role";

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

GRANT ALL ON TABLE "communities"."member_order_assigment" TO "anon";
GRANT ALL ON TABLE "communities"."member_order_assigment" TO "authenticated";
GRANT ALL ON TABLE "communities"."member_order_assigment" TO "service_role";

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

GRANT ALL ON TABLE "engagements"."response" TO "anon";
GRANT ALL ON TABLE "engagements"."response" TO "authenticated";
GRANT ALL ON TABLE "engagements"."response" TO "service_role";

GRANT ALL ON TABLE "engagements"."survey" TO "anon";
GRANT ALL ON TABLE "engagements"."survey" TO "authenticated";
GRANT ALL ON TABLE "engagements"."survey" TO "service_role";

GRANT ALL ON TABLE "finances"."transaction" TO "anon";
GRANT ALL ON TABLE "finances"."transaction" TO "authenticated";
GRANT ALL ON TABLE "finances"."transaction" TO "service_role";

GRANT ALL ON SEQUENCE "finances"."transaction_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "finances"."transaction_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "finances"."transaction_id_seq" TO "service_role";

GRANT ALL ON TABLE "finances"."transaction_type" TO "anon";
GRANT ALL ON TABLE "finances"."transaction_type" TO "authenticated";
GRANT ALL ON TABLE "finances"."transaction_type" TO "service_role";

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

GRANT ALL ON TABLE "public"."notification" TO "anon";
GRANT ALL ON TABLE "public"."notification" TO "authenticated";
GRANT ALL ON TABLE "public"."notification" TO "service_role";

GRANT ALL ON SEQUENCE "public"."notification_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."notification_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."notification_id_seq" TO "service_role";

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

RESET ALL;
