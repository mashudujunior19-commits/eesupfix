-- Kasipool search: match by name (case-insensitive, partial) or by code, across
-- ALL Kasi pools regardless of where the user is. When the caller passes a
-- location, pools with a known address are ordered nearest-first and the
-- distance is returned so the UI can highlight nearby pools; pools without an
-- address (or callers without a location) are still returned.
CREATE OR REPLACE FUNCTION communities.search_kasi_pools(
    query_str text,
    _user_id uuid,
    lat double precision DEFAULT NULL,
    lng double precision DEFAULT NULL,
    limit_to integer DEFAULT 50
)
RETURNS TABLE (
    id integer,
    name text,
    code integer,
    level communities.eesupool_level,
    invite_status communities.eesupool_request_status,
    membership_id uuid,
    parent_name text,
    distance double precision
)
    LANGUAGE plpgsql
    STABLE
    AS $$
DECLARE
    q text := btrim(COALESCE(query_str, ''));
    -- escape LIKE wildcards typed by the user so they match literally
    pattern text := '%' || replace(replace(replace(btrim(COALESCE(query_str, '')), '\', '\\'), '%', '\%'), '_', '\_') || '%';
BEGIN
    IF q = '' THEN
        RETURN;
    END IF;

    RETURN QUERY
    SELECT
        pool.id,
        pool.name,
        pool.code,
        pool.level,
        req.status AS invite_status,
        mem.id AS membership_id,
        (SELECT par.name FROM communities.eesupool par WHERE par.id = pool.parent_id) AS parent_name,
        CASE
            WHEN lat IS NOT NULL AND lng IS NOT NULL
                 AND adr.latitude IS NOT NULL AND adr.longitude IS NOT NULL
            THEN geolocations.calculate_distance_between_2_locations(
                lat, lng, adr.latitude::double precision, adr.longitude::double precision
            )::double precision
            ELSE NULL
        END AS distance
    FROM communities.eesupool pool
        LEFT JOIN geolocations.address adr ON adr.id = pool.address_id
        LEFT JOIN LATERAL (
            SELECT r.status
            FROM communities.eesupool_request r
            WHERE r.user_id = _user_id AND r.eesupool_id = pool.id
            LIMIT 1
        ) req ON TRUE
        LEFT JOIN LATERAL (
            SELECT em.id
            FROM communities.eesupool_member em
            WHERE em.user_id = _user_id AND em.eesupool_id = pool.id
            LIMIT 1
        ) mem ON TRUE
    WHERE pool.type = 'Kasi'
      AND (
            pool.name ILIKE pattern
         OR pool.code::text = q
         OR pool.code::text ILIKE pattern
         OR pool.box_code ILIKE pattern
         OR pool.street_code ILIKE pattern
      )
    -- positional: output column names (name, distance, ...) would be ambiguous
    ORDER BY 8 ASC NULLS LAST, 2 ASC
    LIMIT limit_to;
END;
$$;

ALTER FUNCTION communities.search_kasi_pools(text, uuid, double precision, double precision, integer) OWNER TO postgres;
GRANT EXECUTE ON FUNCTION communities.search_kasi_pools(text, uuid, double precision, double precision, integer) TO authenticated, service_role;
