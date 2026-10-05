-- Roles & permissions rules for KasiPool order roles and referrals:
--
--  1. get_eesupool_members_by_id_array: its RETURNS TABLE was missing the
--     foreigner / is_verified columns its SELECT produces (a result-shape
--     mismatch at call time), and the app needs is_verified to stop
--     unverified members being given roles.
--  2. communities.set_order_assignments: saves a member order's role
--     assignments atomically. The app used to delete every assignment and
--     then re-insert, so one bad row (e.g. an unknown role) silently wiped
--     all of an order's roles. Also enforces, server-side, that:
--       - only a pool admin can change assignments,
--       - every assignee is verified,
--       - nobody packs their own order (Packer / All on their own order).
--  3. set_default_order_assignment: the default "All" assignment given to a
--     pool admin on each new member order now skips an admin who placed
--     that order themselves (or isn't verified), instead of assigning them
--     to pack their own order.
--  4. Bulk-order receiver roles (eesupool_order.receivers / receiver_roles)
--     may only be given to verified members.
--  5. A user whose 5th referral completes (the referred person becomes
--     verified) is automatically promoted from Ubuntunist to EESUpromoter.
--     Existing users who already qualify are backfilled.
--
-- KasiPool creators already become the pool's Admin inside
-- communities.create_new_eesupool, so no change is needed for that rule.


-- 1. ---------------------------------------------------------------------

DROP FUNCTION IF EXISTS "communities"."get_eesupool_members_by_id_array"("uuid"[]);

CREATE FUNCTION "communities"."get_eesupool_members_by_id_array"("members" "uuid"[]) RETURNS TABLE("member_id" "uuid", "user_id" "uuid", "eesupool_id" integer, "created_at" timestamp with time zone, "role" "communities"."eesupool_member_role", "is_censored" boolean, "foreigner" boolean, "is_verified" boolean, "full_name" "text")
    LANGUAGE "plpgsql"
    AS $$BEGIN
    RETURN QUERY
    SELECT
        m.id AS member_id,
        m.user_id,
        m.eesupool_id,
        m.created_at,
        m.role,
        COALESCE(m.is_censored::boolean, false) AS is_censored,
        COALESCE(p.foreigner::boolean, false) AS foreigner,
        COALESCE(p.is_verified::boolean, false) AS is_verified,
        COALESCE(
            CASE
                WHEN p.first_name IS NOT NULL AND p.last_name IS NOT NULL
                THEN CONCAT(p.first_name, ' ', p.last_name)
                ELSE p.corp_name
            END,
            'Unknown Name'
        ) AS full_name
    FROM
        communities.eesupool_member m
    LEFT JOIN
        public.profile p ON m.user_id = p.user_id
    WHERE
        m.id = ANY(members);
END;$$;

ALTER FUNCTION "communities"."get_eesupool_members_by_id_array"("members" "uuid"[]) OWNER TO "postgres";

GRANT ALL ON FUNCTION "communities"."get_eesupool_members_by_id_array"("members" "uuid"[]) TO "anon";
GRANT ALL ON FUNCTION "communities"."get_eesupool_members_by_id_array"("members" "uuid"[]) TO "authenticated";
GRANT ALL ON FUNCTION "communities"."get_eesupool_members_by_id_array"("members" "uuid"[]) TO "service_role";


-- 2. ---------------------------------------------------------------------

-- _assignments: jsonb array of {"member_id": uuid, "privilage": text}.
CREATE OR REPLACE FUNCTION "communities"."set_order_assignments"("_order_id" integer, "_assignments" "jsonb") RETURNS void
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    _pool_order_id integer;
    _pool_id integer;
    _customer_id uuid;
    _a record;
BEGIN
    SELECT o.eesupool_order_id, o.customer_id, eo.eesupool_id
    INTO _pool_order_id, _customer_id, _pool_id
    FROM sales.order o
    JOIN communities.eesupool_order eo ON eo.id = o.eesupool_order_id
    WHERE o.id = _order_id;

    IF _pool_order_id IS NULL THEN
        RAISE EXCEPTION 'Order % is not a KasiPool order', _order_id;
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM communities.eesupool_member
        WHERE eesupool_id = _pool_id AND user_id = auth.uid() AND role = 'Admin'
    ) THEN
        RAISE EXCEPTION 'Only a KasiPool admin can assign order roles';
    END IF;

    FOR _a IN
        SELECT
            (e->>'member_id')::uuid AS member_id,
            (e->>'privilage')::sales.order_edit_privilage AS privilage,
            m.user_id,
            COALESCE(p.is_verified, false) AS is_verified,
            COALESCE(
                NULLIF(TRIM(CONCAT(p.first_name, ' ', p.last_name)), ''),
                p.corp_name,
                'This member'
            ) AS full_name
        FROM jsonb_array_elements(_assignments) e
        LEFT JOIN communities.eesupool_member m ON m.id = (e->>'member_id')::uuid
        LEFT JOIN public.profile p ON p.user_id = m.user_id
    LOOP
        IF _a.user_id IS NULL THEN
            RAISE EXCEPTION 'Member % is not part of this KasiPool', _a.member_id;
        END IF;
        IF NOT _a.is_verified THEN
            RAISE EXCEPTION '% is not verified and cannot be assigned a role', _a.full_name;
        END IF;
        IF _a.user_id = _customer_id AND _a.privilage IN ('Packer', 'All') THEN
            RAISE EXCEPTION '% cannot pack their own order', _a.full_name;
        END IF;
    END LOOP;

    DELETE FROM communities.member_order_assignment WHERE order_id = _order_id;

    INSERT INTO communities.member_order_assignment(order_id, eesupool_ord_id, member_id, privilage)
    SELECT
        _order_id,
        _pool_order_id,
        (e->>'member_id')::uuid,
        (e->>'privilage')::sales.order_edit_privilage
    FROM jsonb_array_elements(_assignments) e;
END;
$$;

ALTER FUNCTION "communities"."set_order_assignments"("_order_id" integer, "_assignments" "jsonb") OWNER TO "postgres";

GRANT ALL ON FUNCTION "communities"."set_order_assignments"("_order_id" integer, "_assignments" "jsonb") TO "authenticated";
GRANT ALL ON FUNCTION "communities"."set_order_assignments"("_order_id" integer, "_assignments" "jsonb") TO "service_role";


-- 3. ---------------------------------------------------------------------

CREATE OR REPLACE FUNCTION "communities"."set_default_order_assignment"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    admin_member_id UUID;
BEGIN
    IF NEW.eesupool_order_id IS NOT NULL THEN
        SELECT m.id INTO admin_member_id
        FROM communities.eesupool_member m
        JOIN communities.eesupool_order eo ON m.eesupool_id = eo.eesupool_id
        JOIN public.profile p ON p.user_id = m.user_id
        WHERE eo.id = NEW.eesupool_order_id
          AND m.role = 'Admin'
          AND m.user_id <> NEW.customer_id
          AND p.is_verified = true
        LIMIT 1;

        -- No eligible admin: leave the order unassigned for an admin to
        -- assign manually, rather than have someone pack their own order.
        IF admin_member_id IS NOT NULL THEN
            INSERT INTO communities.member_order_assignment(order_id, eesupool_ord_id, member_id)
            VALUES (NEW.id, NEW.eesupool_order_id, admin_member_id);
        END IF;
    END IF;
    RETURN NEW;
END;
$$;


-- 4. ---------------------------------------------------------------------

CREATE OR REPLACE FUNCTION "communities"."validate_receivers_verified"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    _unverified text;
BEGIN
    IF TG_OP = 'UPDATE'
       AND NEW.receivers IS NOT DISTINCT FROM OLD.receivers
       AND NEW.receiver_roles IS NOT DISTINCT FROM OLD.receiver_roles THEN
        RETURN NEW;
    END IF;

    SELECT COALESCE(
               NULLIF(TRIM(CONCAT(p.first_name, ' ', p.last_name)), ''),
               p.corp_name,
               'A member'
           )
    INTO _unverified
    FROM communities.eesupool_member m
    LEFT JOIN public.profile p ON p.user_id = m.user_id
    WHERE (
            m.id = ANY(COALESCE(NEW.receivers, '{}'::uuid[]))
            OR m.id::text IN (SELECT jsonb_object_keys(COALESCE(NEW.receiver_roles, '{}'::jsonb)))
          )
      AND COALESCE(p.is_verified, false) = false
    LIMIT 1;

    IF _unverified IS NOT NULL THEN
        RAISE EXCEPTION '% is not verified and cannot be assigned a role', _unverified;
    END IF;

    RETURN NEW;
END;
$$;

ALTER FUNCTION "communities"."validate_receivers_verified"() OWNER TO "postgres";

DROP TRIGGER IF EXISTS "validate_receivers_verified_trigger" ON "communities"."eesupool_order";
CREATE TRIGGER "validate_receivers_verified_trigger"
    BEFORE INSERT OR UPDATE OF "receivers", "receiver_roles" ON "communities"."eesupool_order"
    FOR EACH ROW EXECUTE FUNCTION "communities"."validate_receivers_verified"();


-- 5. ---------------------------------------------------------------------

CREATE OR REPLACE FUNCTION "public"."promote_referrer_after_five_referrals"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    SECURITY DEFINER
    SET search_path = public
    AS $$
BEGIN
    IF NEW.is_completed AND NOT COALESCE(OLD.is_completed, false) THEN
        UPDATE public.profile p
        SET role = 'EESUpromoter'
        WHERE p.user_id = NEW.referrer_user_id
          AND p.role = 'Ubuntunist'
          AND (
              SELECT COUNT(*) FROM public.referral r
              WHERE r.referrer_user_id = NEW.referrer_user_id AND r.is_completed
          ) >= 5;
    END IF;
    RETURN NEW;
END;
$$;

ALTER FUNCTION "public"."promote_referrer_after_five_referrals"() OWNER TO "postgres";

DROP TRIGGER IF EXISTS "promote_referrer_after_five_referrals_trigger" ON "public"."referral";
CREATE TRIGGER "promote_referrer_after_five_referrals_trigger"
    AFTER UPDATE OF "is_completed" ON "public"."referral"
    FOR EACH ROW EXECUTE FUNCTION "public"."promote_referrer_after_five_referrals"();

-- Backfill: individuals who already have 5+ completed referrals.
UPDATE public.profile p
SET role = 'EESUpromoter'
WHERE p.role = 'Ubuntunist'
  AND (
      SELECT COUNT(*) FROM public.referral r
      WHERE r.referrer_user_id = p.user_id AND r.is_completed
  ) >= 5;
