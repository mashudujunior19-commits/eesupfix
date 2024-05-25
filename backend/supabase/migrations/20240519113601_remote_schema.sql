
drop function if exists "communities"."get_eesupool_orders"(pool_id integer, limit_to integer);

drop function if exists "communities"."get_open_eesupool_order"(pool_id integer);

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION communities.add_or_delete_reaction(_message_id integer, _member_id uuid, _liked boolean)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION communities.broadcast_eesupool_message()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION communities.count_unseen_messages(_eesupool_id integer, _member_id uuid)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION communities.count_user_eesupools_by_type(_id uuid, _type communities.eesupool_type)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION communities.create_eesupool_invite_notification()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION communities.create_eesupool_member()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM communities.eesupool_member WHERE user_id = NEW.user_id AND eesupool_id = NEW.eesupool_id) THEN
    IF NEW.status = 'Accepted' THEN
      INSERT INTO communities.eesupool_member(user_id, eesupool_id)
      VALUES (NEW.user_id, NEW.eesupool_id);
    END IF;
  END IF;
  RETURN NEW;
END;
$function$
;

CREATE OR REPLACE FUNCTION communities.create_new_eesupool(admin_id uuid, name text, description text, parent_id integer, level communities.eesupool_level, type communities.eesupool_type)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION communities.generate_pool_order_secret_pin()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
declare
  pin int;
begin
  select num into pin 
  from generate_series(10000, 99999) as s(num)
  order by random() limit 1;

  new.secret_pin = pin;
  return new;
end;
$function$
;

CREATE OR REPLACE FUNCTION communities.get_eesupool_by_id(_user_id uuid, _pool_id integer)
 RETURNS TABLE(eesupool_id integer, name text, description text, code integer, is_public boolean, address_id integer, type communities.eesupool_type, parent_id integer, level communities.eesupool_level, chat_enabled boolean, admin_fee numeric, receiving_fee numeric, collection_fee numeric, packaging_fee numeric, chat_tags text[], chat_tags_suggestions text[], member_id uuid, role communities.eesupool_member_role, is_censored boolean, num_members integer, unseen_messages integer, address jsonb)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION communities.get_eesupool_descendants_by_level(parent_pool_id integer, children_level communities.eesupool_level)
 RETURNS TABLE(id integer)
 LANGUAGE sql
 STABLE
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION communities.get_eesupool_event_attendees(p_event_id uuid, p_pool_id integer)
 RETURNS TABLE(member_id uuid, user_id uuid, eesupool_id integer, created_at timestamp with time zone, role communities.eesupool_member_role, is_censored boolean, full_name text)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION communities.get_eesupool_events(pool_id integer)
 RETURNS TABLE(id uuid, eesupool_id integer, created_at timestamp with time zone, title text, notes text, remote_url text, address_id integer, start_at timestamp with time zone, end_at timestamp with time zone, attendees jsonb, attachments jsonb[])
 LANGUAGE plpgsql
AS $function$
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
END; $function$
;

CREATE OR REPLACE FUNCTION communities.get_eesupool_issues(pool_id integer, limit_to integer)
 RETURNS TABLE(issue_id uuid, created_at timestamp with time zone, description text, message jsonb, eesupool_id integer, attachments jsonb[], resolved_at timestamp with time zone, offender_member jsonb, reporter_member jsonb)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION communities.get_eesupool_member_by_id(membership_id uuid)
 RETURNS TABLE(member_id uuid, user_id uuid, eesupool_id integer, created_at timestamp with time zone, role communities.eesupool_member_role, is_censored boolean, full_name text)
 LANGUAGE plpgsql
AS $function$BEGIN
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
$function$
;

CREATE OR REPLACE FUNCTION communities.get_eesupool_members(pool_id integer, limit_to integer)
 RETURNS TABLE(member_id uuid, user_id uuid, eesupool_id integer, created_at timestamp with time zone, role communities.eesupool_member_role, is_censored boolean, full_name text)
 LANGUAGE plpgsql
AS $function$BEGIN
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
$function$
;

CREATE OR REPLACE FUNCTION communities.get_eesupool_members_by_id_array(members uuid[])
 RETURNS TABLE(member_id uuid, user_id uuid, eesupool_id integer, created_at timestamp with time zone, role communities.eesupool_member_role, is_censored boolean, full_name text)
 LANGUAGE plpgsql
AS $function$
BEGIN
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
        m.id = ANY(members);
END;
$function$
;

CREATE OR REPLACE FUNCTION communities.get_eesupool_messages(pool_id integer, approved boolean, limit_to integer)
 RETURNS TABLE(id integer, eesupool_id integer, author_id uuid, created_at timestamp with time zone, content text, reply_on_id integer, attachments jsonb[], author_full_name text, reply_message jsonb, reactions jsonb, is_approved boolean, hash_tags text[], is_deleted boolean, message_seens uuid[])
 LANGUAGE plpgsql
 STABLE
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION communities.get_eesupool_messages_by_hash_tag(pool_id integer, hash_tag text, approved boolean, limit_to integer)
 RETURNS TABLE(id integer, eesupool_id integer, author_id uuid, created_at timestamp with time zone, content text, reply_on_id integer, attachments jsonb[], author_full_name text, reply_message jsonb, reactions jsonb, is_approved boolean, hash_tags text[], is_deleted boolean, message_seens uuid[])
 LANGUAGE plpgsql
 STABLE
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION communities.get_eesupool_orders(pool_id integer, limit_to integer)
 RETURNS TABLE(id integer, eesupool_id integer, created_at timestamp with time zone, schedule_for timestamp with time zone, delivered_at timestamp with time zone, closes_at timestamp with time zone, admin_fee numeric, packer_fee numeric, receiver_fee numeric, collection_fee numeric, address_id integer, eesupool_name text, address jsonb, orders_count integer, current_amount numeric, secret_pin integer, receivers uuid[])
 LANGUAGE plpgsql
AS $function$
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
        eo.secret_pin,
        eo.receivers    
    FROM communities.eesupool_order eo
    WHERE eo.eesupool_id = pool_id limit limit_to;
END;
$function$
;

CREATE OR REPLACE FUNCTION communities.get_eesupool_requests(_pool_id integer, _user_id uuid, _type text, limit_to integer)
 RETURNS TABLE(user_id uuid, created_at timestamp with time zone, eesupool_id integer, type text, status communities.eesupool_request_status, eesupool_name text, full_name text, corporate_name text, role user_role)
 LANGUAGE plpgsql
AS $function$
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
END; $function$
;

CREATE OR REPLACE FUNCTION communities.get_eesupool_requests_and_invites(pool_id integer, p_user_id uuid, p_type text, limit_to integer)
 RETURNS TABLE(user_id uuid, created_at timestamp with time zone, eesupool_id integer, request_type text, status communities.eesupool_request_status, eesupool_name text, full_name text, corporate_name text, role user_role)
 LANGUAGE plpgsql
AS $function$
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
END; $function$
;

CREATE OR REPLACE FUNCTION communities.get_eesupools_descendants(_user_id uuid, parent_pool_id integer, limit_to integer)
 RETURNS TABLE(eesupool_id integer, name text, description text, code integer, is_public boolean, address_id integer, type communities.eesupool_type, parent_id integer, level communities.eesupool_level, chat_enabled boolean, admin_fee numeric, receiving_fee numeric, collection_fee numeric, packaging_fee numeric, chat_tags text[], chat_tags_suggestions text[], member_id uuid, role communities.eesupool_member_role, is_censored boolean, num_members integer, unseen_messages integer, address jsonb)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION communities.get_eesupools_descendants_streets_for_requests(_user_id uuid, parent_pool_id integer, limit_to integer)
 RETURNS TABLE(id integer, name text, description text, code integer, type communities.eesupool_type, level communities.eesupool_level, membership_id uuid, invite_status communities.eesupool_request_status)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION communities.get_message_by_id(m_id integer)
 RETURNS TABLE(id integer, eesupool_id integer, author_id uuid, created_at timestamp with time zone, content text, reply_on_id integer, attachments jsonb[], author_full_name text, reply_message jsonb, reactions jsonb, is_approved boolean, hash_tags text[], is_deleted boolean, message_seens uuid[])
 LANGUAGE plpgsql
 STABLE
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION communities.get_message_reaction(m_id integer)
 RETURNS TABLE(message_id integer, member_id uuid, created_at timestamp with time zone, liked boolean, member_full_name text)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION communities.get_message_reactions(m_id integer)
 RETURNS TABLE(message_id integer, member_id uuid, created_at timestamp with time zone, liked boolean, member_full_name text)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION communities.get_open_eesupool_order(pool_id integer)
 RETURNS TABLE(id integer, eesupool_id integer, created_at timestamp with time zone, schedule_for timestamp with time zone, delivered_at timestamp with time zone, closes_at timestamp with time zone, admin_fee numeric, packer_fee numeric, receiver_fee numeric, collection_fee numeric, address_id integer, eesupool_name text, address jsonb, orders_count integer, current_amount numeric, secret_pin integer, receivers uuid[])
 LANGUAGE plpgsql
AS $function$
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
        eo.secret_pin,
        eo.receivers  
    FROM communities.eesupool_order eo
    WHERE eo.closes_at > now() AND eo.eesupool_id = pool_id
    ORDER BY eo.created_at desc limit 1;
END;
$function$
;

CREATE OR REPLACE FUNCTION communities.get_open_eesupool_orders(_user_id uuid, _eesupool_id integer, _limit_to integer)
 RETURNS TABLE(id integer, eesupool_id integer, created_at timestamp with time zone, schedule_for timestamp with time zone, delivered_at timestamp with time zone, closes_at timestamp with time zone, admin_fee numeric, packer_fee numeric, receiver_fee numeric, collection_fee numeric, address_id integer, eesupool_name text, address jsonb, orders_count integer, current_amount numeric, secret_pin integer)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION communities.get_order_assignments(_order_id integer)
 RETURNS TABLE(full_name text, corp_name text, privilage sales.order_edit_privilage, member_id uuid, order_id integer, eesupool_ord_id integer)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION communities.get_sub_kases_for_search(_parent_id integer, _user_id uuid)
 RETURNS TABLE(id integer, name text, level communities.eesupool_level, invite_status communities.eesupool_request_status, membership_id uuid)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION communities.get_user_eesupools(id uuid, limit_to integer)
 RETURNS TABLE(eesupool_id integer, name text, description text, code integer, is_public boolean, address_id integer, type communities.eesupool_type, parent_id integer, level communities.eesupool_level, chat_enabled boolean, admin_fee numeric, receiving_fee numeric, collection_fee numeric, packaging_fee numeric, chat_tags text[], chat_tags_suggestions text[], member_id uuid, role communities.eesupool_member_role, is_censored boolean, num_members integer, unseen_messages integer, address jsonb)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION communities.get_user_eesupools_v2(id uuid, limit_to integer, pool_type communities.eesupool_type)
 RETURNS TABLE(eesupool_id integer, name text, description text, code integer, is_public boolean, address_id integer, type communities.eesupool_type, parent_id integer, level communities.eesupool_level, chat_enabled boolean, admin_fee numeric, receiving_fee numeric, collection_fee numeric, packaging_fee numeric, chat_tags text[], chat_tags_suggestions text[], member_id uuid, role communities.eesupool_member_role, is_censored boolean, num_members integer, unseen_messages integer, address jsonb)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION communities.notify_eesupool_members()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION communities.on_invite_revoked_delete_notification()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
    delete from engagements.notification where data ->>'user_id' = cast(old.user_id as text)
    AND data ->>'eesupool_id' = cast(old.eesupool_id as text);
    RETURN NEW;
END;
$function$
;

CREATE OR REPLACE FUNCTION communities.search_eesupools_descendants(_user_id uuid, parent_pool_id integer, query_str text, limit_to integer)
 RETURNS TABLE(eesupool_id integer, name text, description text, code integer, is_public boolean, address_id integer, type communities.eesupool_type, parent_id integer, level communities.eesupool_level, chat_enabled boolean, admin_fee numeric, receiving_fee numeric, collection_fee numeric, packaging_fee numeric, chat_tags text[], chat_tags_suggestions text[], member_id uuid, role communities.eesupool_member_role, is_censored boolean, num_members integer, unseen_messages integer, address jsonb)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION communities.search_for_eesupools_by_type(query_str text, _user_id uuid, _type communities.eesupool_type, limit_to integer)
 RETURNS TABLE(id integer, name text, level communities.eesupool_level, invite_status communities.eesupool_request_status, membership_id uuid, sub_eesupools jsonb, parent_name text)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION communities.search_for_trade_eesupools(query_str text, _user_id uuid, lat double precision, lng double precision, limit_to integer)
 RETURNS TABLE(id integer, name text, distance double precision, invite_status communities.eesupool_request_status, membership_id uuid)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION communities.search_profiles_for_eesupool_invites(query_str text, pool_id integer, limit_to integer)
 RETURNS TABLE(full_name text, corporate_name text, user_id uuid, role user_role, membership_id uuid, status communities.eesupool_request_status)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION communities.search_user_eesupools(query_str text, _type communities.eesupool_type, _user_id uuid, limit_to integer)
 RETURNS TABLE(eesupool_id integer, name text, description text, code integer, is_public boolean, address_id integer, type communities.eesupool_type, parent_id integer, level communities.eesupool_level, chat_enabled boolean, admin_fee numeric, receiving_fee numeric, collection_fee numeric, packaging_fee numeric, chat_tags text[], chat_tags_suggestions text[], member_id uuid, role communities.eesupool_member_role, is_censored boolean, num_members integer, unseen_messages integer, address jsonb)
 LANGUAGE plpgsql
AS $function$
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
END; $function$
;

CREATE OR REPLACE FUNCTION communities.set_default_order_assignment()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
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
$function$
;


set check_function_bodies = off;

CREATE OR REPLACE FUNCTION engagements.get_survey_by_id(_survey_id uuid, _user_id uuid)
 RETURNS TABLE(id uuid, created_at timestamp with time zone, title text, description text, type engagements.survey_type, questions jsonb, max_responses integer, image_url text, video_url text, reward_amount numeric, duration integer, points integer, pass_percentage numeric, enable_scoring boolean, require_all boolean, enforce_time_limit boolean, pre_survey jsonb, passed boolean, score integer, responded_at timestamp with time zone)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION engagements.get_user_avail_surveys(_user_id uuid, _type engagements.survey_type)
 RETURNS TABLE(id uuid, created_at timestamp with time zone, title text, description text, type engagements.survey_type, questions jsonb, max_responses integer, image_url text, video_url text, reward_amount numeric, duration integer, points integer, pass_percentage numeric, enable_scoring boolean, require_all boolean, enforce_time_limit boolean, pre_survey jsonb, passed boolean, score integer, responded_at timestamp with time zone)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION engagements.send_one_signal_push_notification(title text, body text, campaign text, image_url text, data jsonb, recipients uuid[])
 RETURNS void
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION engagements.send_order_update_notification()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION engagements.send_push_notification_on_insert()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
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
$function$
;


set check_function_bodies = off;

CREATE OR REPLACE FUNCTION finances.balance_wallet_transactions()
 RETURNS void
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION finances.calculate_profit_share_and_withdrawal(voucher_id integer, wallet_id integer, voucher_balance numeric, interest_rate numeric, voucher_value numeric, period_weeks integer, cycle finances.voucher_cycle)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION finances.check_voucher_payouts_cron_job_fun()
 RETURNS void
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION finances.confirm_voucher_eft(reference integer, is_confirmed boolean)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION finances.create_crowdfunding_voucher(_user_id uuid, _parameter_id uuid, _value numeric, _cycle finances.voucher_cycle, _period integer, _end_date timestamp with time zone)
 RETURNS record
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION finances.create_order_transaction(_order_id integer, _trans_id integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
 insert into sales.order_transaction(order_id, transaction_id)
 values(_order_id,_trans_id);
END;
$function$
;

CREATE OR REPLACE FUNCTION finances.create_transaction(_type text, _value numeric, _vested boolean, _description text)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
DECLARE
    _new_trans_id INTEGER;
BEGIN
        INSERT INTO finances.transaction(type, value, vested, description)
        VALUES(_type, _value, _vested, _description) RETURNING id INTO _new_trans_id;

    RETURN _new_trans_id;
END;
$function$
;

CREATE OR REPLACE FUNCTION finances.create_user_wallets()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION finances.create_voucher_ledger_transaction(_voucher_id integer, _transaction_id integer, _opening_balance numeric, _payout numeric, _profit_share numeric, _closing_balance numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION finances.create_wallet_transaction(_wallet_id integer, _type text, _value numeric, _vested boolean, _description text)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
DECLARE
    _new_trans_id INTEGER;
BEGIN

  IF _wallet_id IS NOT NULL THEN

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
  END IF;
  RETURN NULL;
END;
$function$
;

CREATE OR REPLACE FUNCTION finances.generate_payment_secondary_id()
 RETURNS text
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION finances.generate_random_string(length integer)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION finances.generate_transaction_doc_ref()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION finances.get_user_wallets(_user_id uuid)
 RETURNS TABLE(id integer, user_id uuid, balance numeric, type_id text, description text, created_at timestamp with time zone, type_created_at timestamp with time zone, withdrawals boolean, deposits boolean, transfers boolean, shopping boolean, is_active boolean, require_rsa_id boolean, sort_num integer)
 LANGUAGE plpgsql
AS $function$
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
END; $function$
;

CREATE OR REPLACE FUNCTION finances.get_voucher_transactions(_voucher_id integer, limit_to integer)
 RETURNS TABLE(type text, doc_ref integer, value numeric, vested boolean, description text, created_at timestamp with time zone, confirmed_at timestamp with time zone, cancelled_at timestamp with time zone, id integer)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION finances.get_wallet_transactions(_wallet_id integer, limit_to integer)
 RETURNS TABLE(type text, doc_ref integer, value numeric, vested boolean, description text, created_at timestamp with time zone, confirmed_at timestamp with time zone, cancelled_at timestamp with time zone, id integer)
 LANGUAGE plpgsql
AS $function$BEGIN
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
END;$function$
;

CREATE OR REPLACE FUNCTION finances.on_payment_confirmed()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION finances.on_unverified_prevent_income_wallet_txn_confirmations()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION finances.process_voucher_transactions(voucher_id integer, crowd_fund_wallet_id integer, withdrawal_amount numeric, opening_balance numeric, profit_share numeric, closing_balance numeric)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION finances.search_transfer_beneficiary(query_str text, wallet_type text)
 RETURNS TABLE(user_id uuid, description text, full_name text, corp_name text, wallet_id integer)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION finances.transfer_funds_wallet_to_wallet(to_wallet_id integer, from_wallet_id integer, to_ref text, from_ref text, amount numeric)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION finances.update_wallet_balance_on_txn_confirmed()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
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
    END IF;

    RETURN NEW;
END;
$function$
;


set check_function_bodies = off;

CREATE OR REPLACE FUNCTION geolocations.calculate_distance_between_2_locations(lat1 double precision, lon1 double precision, lat2 double precision, lon2 double precision)
 RETURNS double precision
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION geolocations.get_address_by_id(address_id integer)
 RETURNS TABLE(area_id integer, user_id uuid, recipient_name text, recipient_phone text, street_address text, building_name text, type text, province text, latitude numeric, longitude numeric, created_at timestamp with time zone, is_primary boolean, id integer)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION geolocations.verify_address()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
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
$function$
;


set check_function_bodies = off;

CREATE OR REPLACE FUNCTION inventory.get_all_categories()
 RETURNS TABLE(id integer, name text, image_url text, parent_id integer, products integer)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION inventory.get_category_descendants(p_cat_id integer)
 RETURNS TABLE(id integer, name text, image_url text, parent_id integer, products integer)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION inventory.get_product(_id integer)
 RETURNS TABLE(id integer, category_id integer, name text, description text, image_url text, size text, brand text, type text, uom text, unit_pack_size text, flavour text, sale_price numeric, cost_price numeric, vaa numeric, vat numeric, order_max integer, child_id integer, child_break_qty integer, bar_code text, kit_kat_ref text, vat_claimable boolean, vat_able boolean, class inventory.product_class, category_name text, category_image_url text, sellable boolean)
 LANGUAGE plpgsql
AS $function$
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
END; $function$
;

CREATE OR REPLACE FUNCTION inventory.get_products_by_category(cat_id integer, role user_role, limit_to integer)
 RETURNS TABLE(id integer, category_id integer, name text, description text, image_url text, size text, brand text, type text, uom text, unit_pack_size text, flavour text, sale_price numeric, cost_price numeric, vaa numeric, vat numeric, order_max integer, child_id integer, child_break_qty integer, bar_code text, kit_kat_ref text, vat_claimable boolean, vat_able boolean, class inventory.product_class, category_name text, category_image_url text, sellable boolean)
 LANGUAGE plpgsql
AS $function$
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
END; $function$
;

CREATE OR REPLACE FUNCTION inventory.get_random_category()
 RETURNS TABLE(id integer, parent_id integer, name text, image_url text)
 LANGUAGE sql
AS $function$
SELECT id, parent_id, name, image_url FROM inventory.category
ORDER BY random()
LIMIT 1;
$function$
;

CREATE OR REPLACE FUNCTION inventory.get_random_products(role user_role, limit_to integer)
 RETURNS TABLE(id integer, category_id integer, name text, description text, image_url text, size text, brand text, type text, uom text, unit_pack_size text, flavour text, sale_price numeric, cost_price numeric, vaa numeric, vat numeric, order_max integer, child_id integer, child_break_qty integer, bar_code text, kit_kat_ref text, vat_claimable boolean, vat_able boolean, class inventory.product_class, category_name text, category_image_url text, sellable boolean)
 LANGUAGE plpgsql
AS $function$
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
END; $function$
;

CREATE OR REPLACE FUNCTION inventory.search_categories(query_str text)
 RETURNS TABLE(id integer, name text, image_url text, parent_id integer, products integer)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION inventory.search_products(query_str text, role user_role, limit_to integer)
 RETURNS TABLE(id integer, category_id integer, name text, description text, image_url text, size text, brand text, type text, uom text, unit_pack_size text, flavour text, sale_price numeric, cost_price numeric, vaa numeric, vat numeric, order_max integer, child_id integer, child_break_qty integer, bar_code text, kit_kat_ref text, vat_claimable boolean, vat_able boolean, class inventory.product_class, category_name text, category_image_url text, sellable boolean)
 LANGUAGE plpgsql
AS $function$
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
END; $function$
;

CREATE OR REPLACE FUNCTION inventory.search_products_and_categories(query_str text, role user_role, limit_to integer)
 RETURNS TABLE(products jsonb, categories jsonb)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY SELECT  
        COALESCE((SELECT jsonb_agg(t) 
                  FROM (SELECT * FROM inventory.search_products(query_str, role, limit_to)
                  ) t), '[]'::jsonb) AS products,
        COALESCE((SELECT jsonb_agg(t) 
                  FROM (SELECT * FROM inventory.search_categories(query_str)
                  ) t), '[]'::jsonb) AS categories;
END;
$function$
;


set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.search_basket_products(query_text text, user_id_uuid uuid, limit_to integer)
 RETURNS TABLE(product_id integer, category_id integer, product_name text, description text, image_url text, size text, brand text, product_type text, uom text, unit_pack_size text, flavour text, retail_price numeric, cost_price numeric, product_class text, category_name text)
 LANGUAGE plpgsql
AS $function$BEGIN
    RETURN QUERY 
    SELECT
        p.product_id,
        p.category_id,
        p.product_name,
        p.description,
        p.image_url,
        p.size,
        p.brand,
        p.product_type,
        p.uom,
        p.unit_pack_size,
        p.flavour,
        p.retail_price,
        p.cost_price,
        p.product_class,
        pc.category_name
    FROM
        inventory.product p
        INNER JOIN inventory.category pc ON p.category_id = pc.category_id
        INNER JOIN public.basket_product bp ON p.product_id = bp.product_id
        INNER JOIN public.basket b ON bp.basket_id = b.id
    WHERE (
            p.product_name ILIKE concat('%', query_text, '%')
            or p.description ILIKE concat('%', query_text, '%')
            or p.brand ILIKE concat('%', query_text, '%')
            or p.product_type ILIKE concat('%', query_text, '%')
            or p.flavour ILIKE concat('%', query_text, '%')
            or pc.category_name ILIKE concat('%', query_text, '%')
        )
        and p.retail_price > 0
        and p.is_active = true
        and b.user_id = user_id_uuid
    LIMIT limit_to;
END;$function$
;

CREATE OR REPLACE FUNCTION public.update_product_quantity(_basket_id uuid, _product_id integer, _new_quantity integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$BEGIN
    IF _new_quantity IS NULL THEN
        RETURN;
    ELSIF _new_quantity <= 0 THEN
        DELETE FROM public.basket_product WHERE basket_id = _basket_id AND product_id = _product_id;
    ELSE
        UPDATE public.basket_product
        SET quantity = _new_quantity
        WHERE basket_id = _basket_id AND product_id = _product_id;
    END IF;
END;$function$
;

CREATE OR REPLACE FUNCTION public.add_product_to_basket(_basket_id uuid, _product_id integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.change_referral(old_referrer_user_id uuid, new_referrer_user_id uuid, referred_user_id uuid)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.check_and_update_verification()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.check_if_referral_is_complete()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.create_user_default_basket()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO public.basket(user_id,name,type)
    VALUES(new.user_id,'My Basket','Monthly');
    RETURN NEW;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.get_basket_products(_basket_id uuid)
 RETURNS TABLE(basket_id uuid, product_id integer, image_url text, category text, name text, quantity integer, price numeric, size text, class inventory.product_class)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.get_basket_products_v2(_basket_id uuid)
 RETURNS TABLE(basket_id uuid, product_id integer, image_url text, category text, name text, quantity integer, price numeric, size text, class inventory.product_class, substitute_brand boolean, substitute_variant boolean, sellable boolean)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.get_referrals_by_referrer(_user_id uuid, _limit_to integer)
 RETURNS TABLE(referrer_user_id uuid, refereed_user_id uuid, refereed_full_name text, created_at timestamp with time zone, transaction_id integer, is_completed boolean)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.handle_new_referral(referee_id uuid, ref_code integer, full_name text, is_confirmed boolean)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.handle_new_user()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.on_profile_verified_complete_referral()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
DECLARE
    _trans_id integer;
BEGIN
-- Check if there's an incomplete referral for the user
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
$function$
;

CREATE OR REPLACE FUNCTION public.on_profile_verified_update_confirm_income_txns()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.remove_product_from_basket(_basket_id uuid, _product_id integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
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
$function$
;


alter table "sales"."order_product" alter column "cfv" drop not null;

alter table "sales"."order_product" alter column "cia" drop not null;

alter table "sales"."order_product" alter column "crc" drop not null;

alter table "sales"."order_product" alter column "csa" drop not null;

alter table "sales"."order_product" alter column "cwa" drop not null;

alter table "sales"."order_product" alter column "daa" drop not null;

alter table "sales"."order_product" alter column "eia" drop not null;

alter table "sales"."order_product" alter column "vaa" drop not null;

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION sales.get_order_by_id(_order_id integer)
 RETURNS TABLE(id integer, customer_id uuid, eesupreneur_id uuid, eesupool_order_id integer, created_at timestamp with time zone, placed_at timestamp with time zone, packaged_at timestamp with time zone, ready_at timestamp with time zone, collected_at timestamp with time zone, cancelled_at timestamp with time zone, payment_method finances.payment_method, secret_pin integer, delivery_address_id integer, delivery_fee numeric, status sales.order_status, full_name text, corp_name text, products jsonb, address jsonb, value numeric, assignments jsonb)
 LANGUAGE plpgsql
AS $function$BEGIN
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
    WHERE ord.id = _order_id
    limit 1;
END;$function$
;

CREATE OR REPLACE FUNCTION sales.allocate_profit_earnings_for_eesupool_member_orders()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
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
    END IF;
    RETURN NEW;
END;
$function$
;

CREATE OR REPLACE FUNCTION sales.allocate_profit_earnings_for_eesupreneur_orders()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION sales.calculate_order_profit_splits(_order_id integer)
 RETURNS TABLE(cia_total numeric, cwa_total numeric, eia_total numeric, crc_total numeric, csa_total numeric, daa_total numeric, cfv_total numeric)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION sales.create_order(_customer_id uuid, _eesupreneur_id uuid, _eesupool_order_id integer, _wallet_id integer, _total_amount numeric, _payment_method finances.payment_method, _address_id integer, _delivery_fee numeric, _card_fee numeric, _pay_fees_with_retail boolean, _products jsonb[])
 RETURNS record
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION sales.generate_order_secret_pin()
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
declare
  pin int;
begin
  select num into pin 
  from generate_series(10000, 99999) as s(num)
  order by random() limit 1;
  return pin;
end;
$function$
;

CREATE OR REPLACE FUNCTION sales.get_customer_orders(_user_id uuid, _eesupreneur_id uuid, _eesupool_ord_id integer, _status sales.order_status[], _limit integer)
 RETURNS TABLE(id integer, customer_id uuid, eesupreneur_id uuid, eesupool_order_id integer, created_at timestamp with time zone, placed_at timestamp with time zone, packaged_at timestamp with time zone, ready_at timestamp with time zone, collected_at timestamp with time zone, cancelled_at timestamp with time zone, payment_method finances.payment_method, secret_pin integer, delivery_address_id integer, delivery_fee numeric, status sales.order_status, full_name text, corp_name text, products jsonb, address jsonb, value numeric, assignments jsonb)
 LANGUAGE plpgsql
AS $function$BEGIN
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
END;$function$
;

CREATE OR REPLACE FUNCTION sales.get_order_products(ord_id integer)
 RETURNS TABLE(order_id integer, product_id integer, image_url text, category text, name text, quantity integer, customer_accepted_qty integer, eesupreneur_accepted_qty integer, price numeric, size text, class inventory.product_class)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION sales.insert_order_products(_order_id integer, _products jsonb[])
 RETURNS void
 LANGUAGE plpgsql
AS $function$
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
end; $function$
;

CREATE OR REPLACE FUNCTION sales.place_confirmed_order(_order_id integer, _is_confirmed boolean)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION sales.update_product_allocations_on_new_order_product()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
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
    WHERE _customer_role = ANY (roles);

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
$function$
;


set check_function_bodies = off;

CREATE OR REPLACE FUNCTION services.create_new_partner_application(_user_id uuid, _partner_id text)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION services.get_all_user_eesupreneurs(_user_id uuid)
 RETURNS TABLE(id uuid, owner_id uuid, name text, description text, created_at timestamp with time zone, is_hidden boolean, is_active boolean, delivery_fee numeric, schedule jsonb, address jsonb)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION services.get_available_partnerships(role user_role)
 RETURNS TABLE(created_at timestamp with time zone, id text, title text, description text, surveys jsonb[], is_open boolean, max_apps integer, requirements jsonb, roles user_role[])
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY SELECT p.* FROM services.partner p
    WHERE p.is_open = true and role = Any(p.roles);
END;
$function$
;

CREATE OR REPLACE FUNCTION services.get_closest_eesupreneurs(lat double precision, lng double precision, limit_to integer)
 RETURNS TABLE(id uuid, owner_id uuid, owner_name text, name text, description text, created_at timestamp with time zone, delivery_fee numeric, schedule jsonb, address jsonb, distance double precision)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION services.get_eesupreneurs(lat double precision, lng double precision)
 RETURNS TABLE(id uuid, owner_id uuid, owner_name text, name text, description text, created_at timestamp with time zone, delivery_fee numeric, schedule jsonb, address jsonb, distance double precision)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION services.get_partnership_surveys(_user_id uuid, _surveys uuid[])
 RETURNS TABLE(id uuid, created_at timestamp with time zone, title text, description text, type engagements.survey_type, questions jsonb, max_responses integer, image_url text, video_url text, reward_amount numeric, duration integer, points integer, pass_percentage numeric, enable_scoring boolean, require_all boolean, enforce_time_limit boolean, pre_survey jsonb, passed boolean, score integer, responded_at timestamp with time zone)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION services.notify_applicant_on_application_update()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION services.on_partner_application_approved()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION services.prevent_editing_of_the_partner_id_value()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
    -- Check if the protected column is being updated
    IF OLD.id IS DISTINCT FROM NEW.id THEN
        RAISE EXCEPTION 'Updating this id is not allowed because there are functions(rpc,triggers)
        which are due to the proccessing of the applications';
    END IF;
    RETURN NEW;
END;
$function$
;


