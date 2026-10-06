-- Adds a catch-all service area covering South Africa so any South African
-- address can be verified, and makes the address trigger prefer the smallest
-- (most specific) matching area.
--
-- NOTE: area_id also drives warehouse / delivery-team lookups. Addresses that
-- only match this catch-all area will verify, but orders from them will find
-- no warehouse until one is configured for this area.

-- Keep the identity sequence ahead of existing rows (it can lag behind when
-- rows were inserted with explicit ids).
SELECT setval(
    'geolocations.target_area_area_id_seq',
    GREATEST((SELECT COALESCE(MAX(id), 0) FROM geolocations.target_area), 1)
);

INSERT INTO geolocations.target_area
    (name, center_latitude, center_longitude, area_radius, center_full_address, is_active)
SELECT 'South Africa (all addresses)', -28.9, 24.7, 1000, 'South Africa', true
WHERE NOT EXISTS (
    SELECT 1 FROM geolocations.target_area WHERE name = 'South Africa (all addresses)'
);

-- Same logic as before, but areas are checked smallest radius first so the
-- catch-all can never win over a real local area.
CREATE OR REPLACE FUNCTION "geolocations"."verify_address"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    area RECORD;
    distance FLOAT;
BEGIN
    IF NEW.latitude IS NOT NULL AND NEW.longitude IS NOT NULL AND NEW.area_id IS NULL THEN
        FOR area IN SELECT ta.id, ta.center_latitude, ta.center_longitude, ta.area_radius
                    FROM geolocations.target_area ta
                    WHERE ta.is_active = true
                    ORDER BY ta.area_radius ASC, ta.id ASC
        LOOP
            SELECT geolocations.calculate_distance_between_2_locations(
                NEW.latitude, NEW.longitude,
                area.center_latitude, area.center_longitude
            ) INTO distance;

            IF distance <= area.area_radius THEN
                NEW.area_id = area.id;
                RETURN NEW;
            END IF;
        END LOOP;
    END IF;

    RETURN NEW;
END;
$$;
