-- KasiPool memberships per profile (Individual / Business).
--
-- A person with an approved Get Involved application can switch between their
-- Individual profile and their Business profile (20261109160000). Until now
-- both profiles shared the same KasiPool memberships, so the business showed
-- up in every pool under the person's own name.
--
-- From here on a membership (and an invite or join request) belongs to one
-- profile: communities.eesupool_member.as_business and
-- communities.eesupool_request.as_business. The same person can be a member of
-- a pool as themselves and, separately, as their business.
--
-- * Existing memberships and requests stay with the Individual profile.
-- * Anything that looks up "my" membership uses the profile that is active now
--   (communities.business_mode).
-- * A new membership or request without an explicit as_business takes it from
--   the matching accepted request, otherwise from the active profile of the
--   person themselves (an invite sent to someone else defaults to their
--   Individual profile unless the inviter chose their business).
-- * Member lists, chat and order roles show the business name for business
--   memberships (communities.display_name).

-- ---------------------------------------------------------------------------
-- Helpers
-- ---------------------------------------------------------------------------

-- Is this user's Business profile the active one?
CREATE OR REPLACE FUNCTION communities.business_mode(_user_id uuid) RETURNS boolean
    LANGUAGE sql STABLE SECURITY DEFINER
    SET search_path = public
    AS $$
    SELECT COALESCE(
        (SELECT p.role = 'Corporate' AND p.individual_role IS NOT NULL
           FROM public.profile p WHERE p.user_id = _user_id),
        false)
$$;
REVOKE ALL ON FUNCTION communities.business_mode(uuid) FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION communities.business_mode(uuid) TO authenticated, service_role;

-- The name a membership is shown under.
CREATE OR REPLACE FUNCTION communities.display_name(_user_id uuid, _as_business boolean) RETURNS text
    LANGUAGE sql STABLE SECURITY DEFINER
    SET search_path = public
    AS $$
    SELECT CASE
        WHEN _as_business THEN COALESCE(NULLIF(btrim(bp.business_name), ''), NULLIF(btrim(p.corp_name), ''), 'Business')
        ELSE COALESCE(
            CASE WHEN p.first_name IS NOT NULL AND p.last_name IS NOT NULL
                 THEN p.first_name || ' ' || p.last_name END,
            NULLIF(btrim(p.corp_name), ''),
            'Unknown Name')
    END
    FROM public.profile p
    LEFT JOIN public.business_profile bp ON bp.user_id = p.user_id
    WHERE p.user_id = _user_id
$$;
REVOKE ALL ON FUNCTION communities.display_name(uuid, boolean) FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION communities.display_name(uuid, boolean) TO authenticated, service_role;

-- ---------------------------------------------------------------------------
-- Columns and uniqueness
-- ---------------------------------------------------------------------------

ALTER TABLE communities.eesupool_member ADD COLUMN IF NOT EXISTS as_business boolean;
UPDATE communities.eesupool_member SET as_business = false WHERE as_business IS NULL;
ALTER TABLE communities.eesupool_member ALTER COLUMN as_business SET NOT NULL;

ALTER TABLE communities.eesupool_request ADD COLUMN IF NOT EXISTS as_business boolean;
UPDATE communities.eesupool_request SET as_business = false WHERE as_business IS NULL;
ALTER TABLE communities.eesupool_request ALTER COLUMN as_business SET NOT NULL;

ALTER TABLE communities.eesupool_member DROP CONSTRAINT IF EXISTS unique_eesupool_member;
ALTER TABLE communities.eesupool_member
    ADD CONSTRAINT unique_eesupool_member UNIQUE (user_id, eesupool_id, as_business);

ALTER TABLE communities.eesupool_request DROP CONSTRAINT IF EXISTS unique_user_and_pool_ids;
ALTER TABLE communities.eesupool_request
    ADD CONSTRAINT unique_user_and_pool_ids UNIQUE (user_id, eesupool_id, as_business);

-- Fills as_business when the writer did not say which profile.
CREATE OR REPLACE FUNCTION communities.stamp_as_business() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path = public, communities
    AS $$
BEGIN
    IF NEW.as_business IS NOT NULL THEN
        RETURN NEW;
    END IF;

    IF TG_TABLE_NAME = 'eesupool_member' THEN
        -- Joining through an accepted invite or request: that request's profile.
        SELECT r.as_business INTO NEW.as_business
        FROM communities.eesupool_request r
        WHERE r.user_id = NEW.user_id
          AND r.eesupool_id = NEW.eesupool_id
          AND r.status = 'Accepted'
          AND NOT EXISTS (SELECT 1 FROM communities.eesupool_member m
                          WHERE m.user_id = r.user_id
                            AND m.eesupool_id = r.eesupool_id
                            AND m.as_business = r.as_business)
        ORDER BY r.created_at DESC
        LIMIT 1;
    END IF;

    IF NEW.as_business IS NULL THEN
        -- The person acting for themselves: their active profile. Someone
        -- else (an admin inviting or adding them): their Individual profile.
        NEW.as_business := CASE
            WHEN auth.uid() IS NULL OR NEW.user_id = auth.uid()
                THEN communities.business_mode(NEW.user_id)
            ELSE false
        END;
    END IF;
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS a0_stamp_as_business_trigger ON communities.eesupool_member;
CREATE TRIGGER a0_stamp_as_business_trigger BEFORE INSERT ON communities.eesupool_member
    FOR EACH ROW EXECUTE FUNCTION communities.stamp_as_business();
DROP TRIGGER IF EXISTS a0_stamp_as_business_trigger ON communities.eesupool_request;
CREATE TRIGGER a0_stamp_as_business_trigger BEFORE INSERT ON communities.eesupool_request
    FOR EACH ROW EXECUTE FUNCTION communities.stamp_as_business();

-- An accepted request makes the membership for that same profile.
CREATE OR REPLACE FUNCTION communities.create_eesupool_member() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.status = 'Accepted' AND NOT EXISTS (
        SELECT 1 FROM communities.eesupool_member
        WHERE user_id = NEW.user_id AND eesupool_id = NEW.eesupool_id
          AND as_business = NEW.as_business) THEN
        INSERT INTO communities.eesupool_member(user_id, eesupool_id, as_business)
        VALUES (NEW.user_id, NEW.eesupool_id, NEW.as_business);
    END IF;
    RETURN NEW;
END;
$$;

-- ---------------------------------------------------------------------------
-- Targeted edits to the existing functions: every "my membership" lookup also
-- matches the active profile. Each edit must find its text, so a function that
-- has drifted from what this migration expects stops the migration.
-- ---------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION pg_temp.patch(_fn regprocedure, _from text, _to text) RETURNS void
    LANGUAGE plpgsql AS $$
DECLARE
    d text := pg_get_functiondef(_fn);
BEGIN
    IF position(_from IN d) = 0 THEN
        RAISE EXCEPTION 'kasipool_profile_memberships: "%" not found in %', _from, _fn;
    END IF;
    EXECUTE replace(d, _from, _to);
END;
$$;

DO $$
DECLARE
    me constant text := ' AND m.as_business = communities.business_mode(auth.uid())';
BEGIN
    -- Pools listed for a user.
    PERFORM pg_temp.patch('communities.count_user_eesupools_by_type(uuid, communities.eesupool_type)',
        'em.user_id = _id AND', 'em.user_id = _id AND em.as_business = communities.business_mode(_id) AND');
    PERFORM pg_temp.patch('communities.get_eesupool_by_id(uuid, integer)',
        'em.user_id = _user_id AND e.id', 'em.user_id = _user_id AND em.as_business = communities.business_mode(_user_id) AND e.id');
    PERFORM pg_temp.patch('communities.get_eesupool_info(uuid)',
        'WHERE em.user_id = user_uuid', 'WHERE em.user_id = user_uuid AND em.as_business = communities.business_mode(user_uuid)');
    PERFORM pg_temp.patch('communities.get_user_eesupools(uuid, integer)',
        'em.user_id = $1', 'em.user_id = $1 AND em.as_business = communities.business_mode($1)');
    PERFORM pg_temp.patch('communities.get_user_eesupools_v2(uuid, integer, communities.eesupool_type)',
        'em.user_id = $1', 'em.user_id = $1 AND em.as_business = communities.business_mode($1)');
    PERFORM pg_temp.patch('communities.get_eesupools_descendants(uuid, integer, integer)',
        'em.user_id = _user_id AND d.id', 'em.user_id = _user_id AND em.as_business = communities.business_mode(_user_id) AND d.id');
    PERFORM pg_temp.patch('communities.search_eesupools_descendants(uuid, integer, text, integer)',
        'em.user_id = _user_id AND d.id', 'em.user_id = _user_id AND em.as_business = communities.business_mode(_user_id) AND d.id');
    PERFORM pg_temp.patch('communities.search_user_eesupools(text, communities.eesupool_type, uuid, integer)',
        'em.user_id = _user_id AND e.type', 'em.user_id = _user_id AND em.as_business = communities.business_mode(_user_id) AND e.type');

    -- Membership / request status shown next to pools in search.
    PERFORM pg_temp.patch('communities.get_eesupools_descendants_streets_for_requests(uuid, integer, integer)',
        'm.user_id = _user_id AND m.eesupool_id', 'm.user_id = _user_id AND m.as_business = communities.business_mode(_user_id) AND m.eesupool_id');
    PERFORM pg_temp.patch('communities.get_eesupools_descendants_streets_for_requests(uuid, integer, integer)',
        'er.user_id = _user_id and er.eesupool_id', 'er.user_id = _user_id and er.as_business = communities.business_mode(_user_id) and er.eesupool_id');
    PERFORM pg_temp.patch('communities.get_sub_kases_for_search(integer, uuid)',
        'r.user_id = _user_id AND r.eesupool_id', 'r.user_id = _user_id AND r.as_business = communities.business_mode(_user_id) AND r.eesupool_id');
    PERFORM pg_temp.patch('communities.get_sub_kases_for_search(integer, uuid)',
        'em.user_id = _user_id AND em.eesupool_id', 'em.user_id = _user_id AND em.as_business = communities.business_mode(_user_id) AND em.eesupool_id');
    PERFORM pg_temp.patch('communities.search_for_eesupools_by_type(text, uuid, communities.eesupool_type, integer)',
        'r.user_id = _user_id AND r.eesupool_id', 'r.user_id = _user_id AND r.as_business = communities.business_mode(_user_id) AND r.eesupool_id');
    PERFORM pg_temp.patch('communities.search_for_eesupools_by_type(text, uuid, communities.eesupool_type, integer)',
        'em.user_id = _user_id AND em.eesupool_id', 'em.user_id = _user_id AND em.as_business = communities.business_mode(_user_id) AND em.eesupool_id');
    PERFORM pg_temp.patch('communities.search_for_trade_eesupools(text, uuid, double precision, double precision, integer)',
        'r.user_id = _user_id AND r.eesupool_id', 'r.user_id = _user_id AND r.as_business = communities.business_mode(_user_id) AND r.eesupool_id');
    PERFORM pg_temp.patch('communities.search_for_trade_eesupools(text, uuid, double precision, double precision, integer)',
        'em.user_id = _user_id AND em.eesupool_id', 'em.user_id = _user_id AND em.as_business = communities.business_mode(_user_id) AND em.eesupool_id');
    PERFORM pg_temp.patch('communities.search_kasi_pools(text, uuid, double precision, double precision, integer)',
        'r.user_id = _user_id AND r.eesupool_id', 'r.user_id = _user_id AND r.as_business = communities.business_mode(_user_id) AND r.eesupool_id');
    PERFORM pg_temp.patch('communities.search_kasi_pools(text, uuid, double precision, double precision, integer)',
        'em.user_id = _user_id AND em.eesupool_id', 'em.user_id = _user_id AND em.as_business = communities.business_mode(_user_id) AND em.eesupool_id');

    -- Checks on the signed-in user.
    PERFORM pg_temp.patch('communities.can_view_pool_order_progress(integer)', 'm.user_id = auth.uid()', 'm.user_id = auth.uid()' || me);
    PERFORM pg_temp.patch('communities.can_view_role_checklist(integer, integer)', 'm.user_id = auth.uid()', 'm.user_id = auth.uid()' || me);
    PERFORM pg_temp.patch('communities.get_my_role_assigned_orders()', 'm.user_id = auth.uid()', 'm.user_id = auth.uid()' || me);
    PERFORM pg_temp.patch('communities.is_bulk_receiver(integer)', 'm.user_id = auth.uid()', 'm.user_id = auth.uid()' || me);
    PERFORM pg_temp.patch('communities.is_pool_admin(integer)', 'm.user_id = auth.uid()', 'm.user_id = auth.uid()' || me);
    PERFORM pg_temp.patch('communities.is_pool_admin_of_order(integer)', 'm.user_id = auth.uid()', 'm.user_id = auth.uid()' || me);
    PERFORM pg_temp.patch('communities.send_chat_message(integer, uuid, text, text, integer, jsonb, text[], text[], boolean)',
        'm.user_id = auth.uid()', 'm.user_id = auth.uid()' || me);
    PERFORM pg_temp.patch('communities.set_order_assignments(integer, jsonb)',
        'AND user_id = auth.uid() AND role = ''Admin''',
        'AND user_id = auth.uid() AND as_business = communities.business_mode(auth.uid()) AND role = ''Admin''');
    PERFORM pg_temp.patch('communities.get_eesupool_messages(integer, integer)',
        'em.user_id = auth.uid()', 'em.user_id = auth.uid() AND em.as_business = communities.business_mode(auth.uid())');

    -- Orders: the customer must be a member with the profile they are using.
    PERFORM pg_temp.patch('communities.enforce_pool_membership_on_order()',
        'm.user_id = NEW.customer_id', 'm.user_id = NEW.customer_id AND m.as_business = communities.business_mode(NEW.customer_id)');
    PERFORM pg_temp.patch('communities.get_open_eesupool_orders(uuid, integer, integer)',
        'eem.user_id = _user_id)', 'eem.user_id = _user_id AND eem.as_business = communities.business_mode(_user_id))');
    PERFORM pg_temp.patch('communities.is_user_receiver(integer, uuid)',
        'WHERE user_id = p_user_id', 'WHERE user_id = p_user_id AND as_business = communities.business_mode(p_user_id)');
    PERFORM pg_temp.patch('communities.remove_admin(integer, uuid)',
        'AND user_id = p_user_id;', 'AND user_id = p_user_id AND as_business = communities.business_mode(p_user_id);');
    PERFORM pg_temp.patch('communities.update_member_count(integer, uuid, numeric)',
        'AND user_id = p_user_id;', 'AND user_id = p_user_id AND as_business = communities.business_mode(p_user_id);');

    -- A new pool's admin is the profile that created it.
    PERFORM pg_temp.patch('communities.create_new_eesupool(uuid, text, communities.eesupool_type, text, integer, communities.eesupool_level, integer)',
        'eesupool_member (user_id, eesupool_id, role)', 'eesupool_member (user_id, eesupool_id, role, as_business)');
    PERFORM pg_temp.patch('communities.create_new_eesupool(uuid, text, communities.eesupool_type, text, integer, communities.eesupool_level, integer)',
        'VALUES (admin_id, new_id, ''Admin'')', 'VALUES (admin_id, new_id, ''Admin'', communities.business_mode(admin_id))');

    -- Names: the business name for business memberships.
    PERFORM pg_temp.patch('communities.get_eesupool_messages(integer, integer)',
        '(SELECT CONCAT(p.first_name, '' '', p.last_name)', '(SELECT communities.display_name(em.user_id, em.as_business)');
    PERFORM pg_temp.patch('communities.get_message_by_id(integer)',
        '(SELECT CONCAT(p.first_name, '' '', p.last_name)', '(SELECT communities.display_name(em.user_id, em.as_business)');
    PERFORM pg_temp.patch('communities.get_message_reaction(integer)',
        'CONCAT(p.first_name, '' '', p.last_name) AS member_full_name', 'communities.display_name(em.user_id, em.as_business) AS member_full_name');
    PERFORM pg_temp.patch('communities.get_message_reactions(integer)',
        'CONCAT(p.first_name, '' '', p.last_name) AS member_full_name', 'communities.display_name(em.user_id, em.as_business) AS member_full_name');
    PERFORM pg_temp.patch('communities.get_order_assignments(integer)',
        'CONCAT(p.first_name, '' '', p.last_name) AS full_name', 'communities.display_name(em.user_id, em.as_business) AS full_name');
    PERFORM pg_temp.patch('communities.get_eesupool_event_attendees(uuid, integer)',
        '(SELECT CONCAT(p.first_name, '' '', p.last_name)', '(SELECT communities.display_name(m.user_id, m.as_business)');

    -- Invite / request notifications say which profile they are for.
    PERFORM pg_temp.patch('communities.create_eesupool_invite_notification()',
        'jsonb_build_object(''user_id'', NEW.user_id, ''eesupool_id'', NEW.eesupool_id)',
        'jsonb_build_object(''user_id'', NEW.user_id, ''eesupool_id'', NEW.eesupool_id, ''as_business'', NEW.as_business)');
    PERFORM pg_temp.patch('communities.create_eesupool_invite_notification()',
        'jsonb_build_object(''user_id'', new.user_id, ''eesupool_id'', NEW.eesupool_id)',
        'jsonb_build_object(''user_id'', new.user_id, ''eesupool_id'', NEW.eesupool_id, ''as_business'', NEW.as_business)');
    PERFORM pg_temp.patch('communities.create_eesupool_invite_notification()',
        'SELECT COALESCE(u.corp_name, CONCAT(u.first_name, '' '', u.last_name)) INTO user_fullname',
        'SELECT communities.display_name(u.user_id, NEW.as_business) INTO user_fullname');
END;
$$;

-- Business invites mention the business.
DO $$
BEGIN
    PERFORM pg_temp.patch('communities.create_eesupool_invite_notification()',
        'CONCAT(''You are invited to become a member of '', eesupool_name, ''.'')',
        'CASE WHEN NEW.as_business THEN CONCAT(communities.display_name(NEW.user_id, true), '' is invited to become a member of '', eesupool_name, ''.'') ELSE CONCAT(''You are invited to become a member of '', eesupool_name, ''.'') END');
END;
$$;

-- ---------------------------------------------------------------------------
-- Functions rewritten in full (their results gain as_business)
-- ---------------------------------------------------------------------------

DROP FUNCTION IF EXISTS communities.get_eesupool_members(integer, integer);
CREATE FUNCTION communities.get_eesupool_members(pool_id integer, limit_to integer)
    RETURNS TABLE(member_id uuid, user_id uuid, eesupool_id integer, created_at timestamp with time zone,
                  role text, is_censored boolean, foreigner boolean, is_verified boolean, full_name text,
                  as_business boolean)
    LANGUAGE sql STABLE
    AS $$
    SELECT m.id, m.user_id, m.eesupool_id, m.created_at, m.role::text,
           COALESCE(m.is_censored, false),
           COALESCE(p.foreigner, false),
           COALESCE(p.is_verified, false),
           communities.display_name(m.user_id, m.as_business),
           m.as_business
    FROM communities.eesupool_member m
    JOIN public.profile p ON p.user_id = m.user_id
    WHERE m.eesupool_id = pool_id
    ORDER BY m.created_at
    LIMIT limit_to
$$;
GRANT EXECUTE ON FUNCTION communities.get_eesupool_members(integer, integer) TO authenticated, service_role;

DROP FUNCTION IF EXISTS communities.get_eesupool_members_by_ids(uuid[]);
CREATE FUNCTION communities.get_eesupool_members_by_ids(members uuid[])
    RETURNS TABLE(member_id uuid, user_id uuid, eesupool_id integer, created_at timestamp with time zone,
                  role text, is_censored boolean, foreigner boolean, is_verified boolean, full_name text,
                  as_business boolean)
    LANGUAGE sql STABLE
    AS $$
    SELECT m.id, m.user_id, m.eesupool_id, m.created_at, m.role::text,
           COALESCE(m.is_censored, false),
           COALESCE(p.foreigner, false),
           COALESCE(p.is_verified, false),
           communities.display_name(m.user_id, m.as_business),
           m.as_business
    FROM communities.eesupool_member m
    LEFT JOIN public.profile p ON p.user_id = m.user_id
    WHERE m.id = ANY(members)
$$;
GRANT EXECUTE ON FUNCTION communities.get_eesupool_members_by_ids(uuid[]) TO authenticated, service_role;

DROP FUNCTION IF EXISTS communities.get_eesupool_members_by_id_array(uuid[]);
CREATE FUNCTION communities.get_eesupool_members_by_id_array(members uuid[])
    RETURNS TABLE(member_id uuid, user_id uuid, eesupool_id integer, created_at timestamp with time zone,
                  role communities.eesupool_member_role, is_censored boolean, foreigner boolean,
                  is_verified boolean, full_name text, as_business boolean)
    LANGUAGE sql STABLE
    AS $$
    SELECT m.id, m.user_id, m.eesupool_id, m.created_at, m.role,
           COALESCE(m.is_censored, false),
           COALESCE(p.foreigner, false),
           COALESCE(p.is_verified, false),
           communities.display_name(m.user_id, m.as_business),
           m.as_business
    FROM communities.eesupool_member m
    LEFT JOIN public.profile p ON p.user_id = m.user_id
    WHERE m.id = ANY(members)
$$;
GRANT EXECUTE ON FUNCTION communities.get_eesupool_members_by_id_array(uuid[]) TO authenticated, service_role;

DROP FUNCTION IF EXISTS communities.get_eesupool_member_by_id(uuid);
CREATE FUNCTION communities.get_eesupool_member_by_id(membership_id uuid)
    RETURNS TABLE(member_id uuid, user_id uuid, eesupool_id integer, created_at timestamp with time zone,
                  role communities.eesupool_member_role, is_censored boolean, full_name text,
                  as_business boolean)
    LANGUAGE sql STABLE
    AS $$
    SELECT m.id, m.user_id, m.eesupool_id, m.created_at, m.role, m.is_censored,
           communities.display_name(m.user_id, m.as_business),
           m.as_business
    FROM communities.eesupool_member m
    WHERE m.id = membership_id
$$;
GRANT EXECUTE ON FUNCTION communities.get_eesupool_member_by_id(uuid) TO authenticated, service_role;

-- Requests and invites: a pool's admins see all of them; a person sees the
-- ones for the profile they are using.
DROP FUNCTION IF EXISTS communities.get_eesupool_requests(integer, uuid, text, integer);
CREATE FUNCTION communities.get_eesupool_requests(_pool_id integer, _user_id uuid, _type text, limit_to integer)
    RETURNS TABLE(user_id uuid, created_at timestamp with time zone, eesupool_id integer, type text,
                  status communities.eesupool_request_status, eesupool_name text, full_name text,
                  corporate_name text, role user_role, as_business boolean)
    LANGUAGE sql STABLE
    AS $$
    SELECT er.user_id, er.created_at, er.eesupool_id, er.type, er.status, e.name,
           communities.display_name(er.user_id, er.as_business),
           CASE WHEN er.as_business THEN communities.display_name(er.user_id, true) ELSE p.corp_name END,
           CASE WHEN er.as_business THEN 'Corporate'::user_role ELSE p.role END,
           er.as_business
    FROM communities.eesupool_request er
    JOIN communities.eesupool e ON e.id = er.eesupool_id
    JOIN public.profile p ON p.user_id = er.user_id
    WHERE (er.eesupool_id = _pool_id
           OR (er.user_id = _user_id AND er.as_business = communities.business_mode(_user_id)))
      AND er.type = _type
    LIMIT limit_to
$$;
GRANT EXECUTE ON FUNCTION communities.get_eesupool_requests(integer, uuid, text, integer) TO authenticated, service_role;

DROP FUNCTION IF EXISTS communities.get_eesupool_requests_and_invites(integer, uuid, text, integer);
CREATE FUNCTION communities.get_eesupool_requests_and_invites(pool_id integer, p_user_id uuid, p_type text, limit_to integer)
    RETURNS TABLE(user_id uuid, created_at timestamp with time zone, eesupool_id integer, request_type text,
                  status communities.eesupool_request_status, eesupool_name text, full_name text,
                  corporate_name text, role user_role, as_business boolean)
    LANGUAGE sql STABLE
    AS $$
    SELECT er.user_id, er.created_at, er.eesupool_id, er.type, er.status, e.name,
           communities.display_name(er.user_id, er.as_business),
           CASE WHEN er.as_business THEN communities.display_name(er.user_id, true) ELSE p.corp_name END,
           CASE WHEN er.as_business THEN 'Corporate'::user_role ELSE p.role END,
           er.as_business
    FROM communities.eesupool_request er
    JOIN public.profile p ON p.user_id = er.user_id
    JOIN communities.eesupool e ON e.id = er.eesupool_id
    WHERE er.type = p_type
      AND ((er.user_id = p_user_id AND er.as_business = communities.business_mode(p_user_id))
           OR er.eesupool_id = pool_id)
    LIMIT limit_to
$$;
GRANT EXECUTE ON FUNCTION communities.get_eesupool_requests_and_invites(integer, uuid, text, integer) TO authenticated, service_role;

-- People to invite: each person, and separately each approved business.
DROP FUNCTION IF EXISTS communities.search_profiles_for_eesupool_invites(text, integer, integer);
CREATE FUNCTION communities.search_profiles_for_eesupool_invites(query_str text, pool_id integer, limit_to integer)
    RETURNS TABLE(full_name text, corporate_name text, user_id uuid, role user_role, membership_id uuid,
                  status communities.eesupool_request_status, as_business boolean)
    LANGUAGE sql STABLE SECURITY DEFINER
    SET search_path = public, communities
    AS $$
    SELECT * FROM (
        SELECT concat(p.first_name, ' ', p.last_name), p.corp_name, p.user_id, p.role,
               (SELECT em.id FROM communities.eesupool_member em
                 WHERE em.user_id = p.user_id AND em.eesupool_id = pool_id AND NOT em.as_business),
               (SELECT er.status FROM communities.eesupool_request er
                 WHERE er.user_id = p.user_id AND er.eesupool_id = pool_id AND NOT er.as_business),
               false
        FROM public.profile p
        WHERE p.first_name ILIKE '%' || query_str || '%'
           OR p.last_name ILIKE '%' || query_str || '%'
           OR CAST(p.referral_code AS TEXT) ILIKE '%' || query_str || '%'
        UNION ALL
        SELECT bp.business_name, bp.business_name, bp.user_id, 'Corporate'::user_role,
               (SELECT em.id FROM communities.eesupool_member em
                 WHERE em.user_id = bp.user_id AND em.eesupool_id = pool_id AND em.as_business),
               (SELECT er.status FROM communities.eesupool_request er
                 WHERE er.user_id = bp.user_id AND er.eesupool_id = pool_id AND er.as_business),
               true
        FROM public.business_profile bp
        WHERE public.has_approved_business_profile(bp.user_id)
          AND (bp.business_name ILIKE '%' || query_str || '%'
               OR CAST(bp.referral_code AS TEXT) ILIKE '%' || query_str || '%')
    ) t
    LIMIT limit_to
$$;
REVOKE ALL ON FUNCTION communities.search_profiles_for_eesupool_invites(text, integer, integer) FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION communities.search_profiles_for_eesupool_invites(text, integer, integer) TO authenticated, service_role;

-- Chat push notifications: the author's display name, each person once.
CREATE OR REPLACE FUNCTION communities.notify_eesupool_members() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    author_name text;
    recipients uuid[];
BEGIN
    IF NEW.is_approved = true THEN
        SELECT ARRAY_AGG(DISTINCT m.user_id) INTO recipients
        FROM communities.eesupool_member m
        WHERE m.eesupool_id = NEW.eesupool_id;

        SELECT communities.display_name(em.user_id, em.as_business) INTO author_name
        FROM communities.eesupool_member em
        WHERE em.id = NEW.author_id;

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

-- Removing a member: say which of the person's profiles (defaults to the one
-- they are using).
DROP FUNCTION IF EXISTS communities.remove_pool_member(integer, uuid);
DROP FUNCTION IF EXISTS communities.member_removal_blockers(integer, uuid);

CREATE FUNCTION communities.member_removal_blockers(p_pool_id integer, p_user_id uuid, p_as_business boolean DEFAULT NULL)
    RETURNS jsonb
    LANGUAGE plpgsql STABLE SECURITY DEFINER
    SET search_path TO 'public', 'communities', 'sales'
    AS $$
DECLARE
    v_business boolean := COALESCE(p_as_business, communities.business_mode(p_user_id));
    v_member_id uuid;
    v_role_orders integer;
    v_open_orders integer;
BEGIN
    SELECT m.id INTO v_member_id
    FROM communities.eesupool_member m
    WHERE m.eesupool_id = p_pool_id AND m.user_id = p_user_id AND m.as_business = v_business;

    IF v_member_id IS NULL THEN
        RETURN jsonb_build_object('has_role', false, 'role_orders', 0, 'open_orders', 0);
    END IF;

    SELECT count(*) INTO v_role_orders
    FROM communities.eesupool_order eo
    WHERE eo.eesupool_id = p_pool_id
      AND eo.delivered_at IS NULL
      AND (v_member_id = ANY (COALESCE(eo.receivers, '{}'::uuid[]))
           OR COALESCE(eo.receiver_roles, '{}'::jsonb) ? v_member_id::text);

    -- Orders are the person's, whichever profile placed them.
    SELECT count(*) INTO v_open_orders
    FROM sales.order o
    JOIN communities.eesupool_order eo ON eo.id = o.eesupool_order_id
    WHERE eo.eesupool_id = p_pool_id
      AND o.customer_id = p_user_id
      AND o.placed_at IS NOT NULL
      AND o.status NOT IN ('Collected', 'Cancelled');

    RETURN jsonb_build_object(
        'has_role', v_role_orders > 0,
        'role_orders', v_role_orders,
        'open_orders', v_open_orders
    );
END;
$$;
GRANT EXECUTE ON FUNCTION communities.member_removal_blockers(integer, uuid, boolean) TO authenticated, service_role;

CREATE FUNCTION communities.remove_pool_member(p_pool_id integer, p_user_id uuid, p_as_business boolean DEFAULT NULL)
    RETURNS jsonb
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public', 'communities', 'sales'
    AS $$
DECLARE
    v_business boolean := COALESCE(p_as_business, communities.business_mode(p_user_id));
    blockers jsonb;
BEGIN
    IF NOT (communities.is_pool_admin(p_pool_id) OR communities.is_app_admin()) THEN
        RETURN jsonb_build_object('ok', false, 'reason', 'Only a pool admin can remove members.');
    END IF;
    IF p_user_id = auth.uid() AND v_business = communities.business_mode(auth.uid()) THEN
        RETURN jsonb_build_object('ok', false, 'reason', 'You cannot remove yourself.');
    END IF;

    blockers := communities.member_removal_blockers(p_pool_id, p_user_id, v_business);
    IF (blockers ->> 'has_role')::boolean THEN
        RETURN jsonb_build_object('ok', false, 'reason',
            'This member has a role assigned on an order that is not finished. Remove their role first.');
    END IF;
    IF (blockers ->> 'open_orders')::integer > 0 THEN
        RETURN jsonb_build_object('ok', false, 'reason',
            'This member has an order that has not been completed. Wait until it is collected or cancelled.');
    END IF;

    DELETE FROM communities.eesupool_member
     WHERE eesupool_id = p_pool_id AND user_id = p_user_id AND as_business = v_business;
    DELETE FROM communities.eesupool_request
     WHERE eesupool_id = p_pool_id AND user_id = p_user_id AND as_business = v_business;
    RETURN jsonb_build_object('ok', true);
END;
$$;
GRANT EXECUTE ON FUNCTION communities.remove_pool_member(integer, uuid, boolean) TO authenticated, service_role;

-- The app asks which profile is active before acting for the signed-in user.
CREATE OR REPLACE FUNCTION communities.my_business_mode() RETURNS boolean
    LANGUAGE sql STABLE
    AS $$ SELECT communities.business_mode(auth.uid()) $$;
REVOKE ALL ON FUNCTION communities.my_business_mode() FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION communities.my_business_mode() TO authenticated, service_role;
