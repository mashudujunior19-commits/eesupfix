-- Rename the KasiPool member-order role "Collector" to "Dispatcher".
--
-- sales.order_edit_privilage already has both values ('Dispatcher' was added
-- earlier but nothing paid or showed it). Postgres cannot drop an enum value
-- that rows may still use, so 'Collector' stays in the type as a legacy
-- spelling only:
--   * every existing 'Collector' assignment becomes 'Dispatcher';
--   * a trigger turns any new 'Collector' write (older app versions) into
--     'Dispatcher', so orders keep working whatever app wrote them;
--   * the earnings trigger pays the dispatch fee to 'Dispatcher' (and still to
--     a legacy 'Collector', in case one slips through);
--   * labels say "Packer & Dispatcher" and old notification texts are updated.
-- Idempotent.

CREATE OR REPLACE FUNCTION pg_temp.patch(_fn regprocedure, _from text, _to text) RETURNS void
    LANGUAGE plpgsql AS $$
DECLARE
    d text := pg_get_functiondef(_fn);
BEGIN
    IF position(_to IN d) > 0 AND position(_from IN d) = 0 THEN
        RETURN; -- already applied
    END IF;
    IF position(_from IN d) = 0 THEN
        RAISE EXCEPTION 'collector_to_dispatcher: "%" not found in %', _from, _fn;
    END IF;
    EXECUTE replace(d, _from, _to);
END;
$$;

-- 1. Normalise new writes ------------------------------------------------------------------

CREATE OR REPLACE FUNCTION communities.normalise_collector_privilage() RETURNS trigger
    LANGUAGE plpgsql AS $$
BEGIN
    IF NEW.privilage::text = 'Collector' THEN
        NEW.privilage := 'Dispatcher'::sales.order_edit_privilage;
    END IF;
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS a_normalise_collector_privilage_trigger ON communities.member_order_assignment;
CREATE TRIGGER a_normalise_collector_privilage_trigger
    BEFORE INSERT OR UPDATE OF privilage ON communities.member_order_assignment
    FOR EACH ROW EXECUTE FUNCTION communities.normalise_collector_privilage();

-- 2. Existing rows ------------------------------------------------------------------------

UPDATE communities.member_order_assignment
SET privilage = 'Dispatcher'
WHERE privilage::text = 'Collector';

-- 3. Functions ----------------------------------------------------------------------------

SELECT pg_temp.patch('communities.get_my_role_assigned_orders()',
    'WHEN ''All'' THEN ''Packer & Collector''',
    'WHEN ''All'' THEN ''Packer & Dispatcher''');

SELECT pg_temp.patch('communities.set_order_assignments(integer, jsonb)',
    'WHEN ''All'' THEN ''Packer & Collector''',
    'WHEN ''All'' THEN ''Packer & Dispatcher''');

SELECT pg_temp.patch('sales.allocate_profit_earnings_for_eesupool_member_orders()',
    'ELSIF _assignments_privilage = ''Collector'' THEN',
    'ELSIF _assignments_privilage IN (''Dispatcher'', ''Collector'') THEN');

-- 4. Notifications already sent ----------------------------------------------------------

UPDATE engagements.notification
SET title = replace(title, 'Collector', 'Dispatcher'),
    body  = replace(body, 'Collector', 'Dispatcher')
WHERE title LIKE '%Collector%' OR body LIKE '%Collector%';
