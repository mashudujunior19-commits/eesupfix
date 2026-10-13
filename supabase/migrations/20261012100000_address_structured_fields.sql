-- Structured address fields so the address form can adapt to the building type
-- (House / Office / Townhouse / Flat). All columns are nullable: existing rows
-- keep working through street_address / building_name.
ALTER TABLE geolocations.address
    ADD COLUMN IF NOT EXISTS street_number text,
    ADD COLUMN IF NOT EXISTS street_name   text,
    ADD COLUMN IF NOT EXISTS suburb        text,
    ADD COLUMN IF NOT EXISTS city          text,
    ADD COLUMN IF NOT EXISTS postal_code   text,
    ADD COLUMN IF NOT EXISTS complex_name  text,
    ADD COLUMN IF NOT EXISTS unit_number   text,
    ADD COLUMN IF NOT EXISTS floor         text;
