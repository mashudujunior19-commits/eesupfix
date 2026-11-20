-- Pending order earnings, the KasiLift income wallet, and no payment fees.
--
-- 1. No payment fees. sales.create_order ignores _card_fee (treated as 0): no
--    "Payment Fee" transaction is created and nothing is added to the amount
--    to pay. The delivery fee is unchanged.
--
-- 2. Potential earnings appear the moment an order is placed, as PENDING
--    (vested = false) transactions in each relevant wallet:
--      KasiPool order:  Packer (packer_fee), Dispatcher (collection_fee),
--                       bulk receivers (receiver_fee), the KasiPool admins
--                       (admin_fee = the KasiPool's share), each a % of the
--                       order's EIA pot, worked out exactly as before;
--      every order:     the KasiLift organisation (kasilift_daa_share_percent
--                       of the order's DAA platform share).
--    Pending money is not in the wallet balance, so it cannot be spent or
--    withdrawn (balance and available balance only count vested money).
--    finances.order_pending_earning records which transactions they are.
--    They are kept up to date while pending: a role, receiver or fee change
--    cancels the old pending line and adds the new one; a cancelled order
--    cancels all its pending lines (cancelled_at, so they show as Cancelled).
--
-- 3. Release (vesting). KasiPool order: when the pool order is closed and every
--    member order is collected or cancelled (communities.check_pool_order_completed),
--    all its pending lines are recalculated (received quantities may have
--    changed) and vested at once. Other orders (EESUpreneur): when that order
--    is collected. Vesting updates the wallet balance through the existing
--    finances.update_wallet_balance_on_txn_confirmed trigger. An unverified
--    member's income stays pending (existing rule, unchanged).
--
-- 4. The old pay-on-collection pool trigger
--    (sales.allocate_profit_earnings_for_eesupool_member_orders) no longer
--    pays; orders it already paid (finances.allocation_run kind 'pool') get no
--    pending lines, so nothing is paid twice. The platform's DAA payment to the
--    master wallet is reduced by the KasiLift share.
--
-- 5. KasiLift settings (system_configs.remote_config):
--      kasilift_income_wallet_id   income wallet of the KasiLift organisation
--      kasilift_daa_share_percent  % of each order's DAA (10)
--    On Dev the wallet is the approved "[TEST] KasiLift Organisation". Where
--    that organisation does not exist the setting is left empty and no KasiLift
--    share is recorded until it is set.
--
-- finances.get_my_pending_earnings() gives the signed-in user's pending total
-- per wallet for the wallet screens. Idempotent.

CREATE OR REPLACE FUNCTION pg_temp.patch(_fn regprocedure, _from text, _to text) RETURNS void
    LANGUAGE plpgsql AS $$
DECLARE
    d text := pg_get_functiondef(_fn);
BEGIN
    IF position(_to IN d) > 0 THEN
        RETURN; -- already applied
    END IF;
    IF position(_from IN d) = 0 THEN
        RAISE EXCEPTION 'pending_earnings: "%" not found in %', _from, _fn;
    END IF;
    EXECUTE replace(d, _from, _to);
END;
$$;

-- 1. No payment fees ---------------------------------------------------------------------------

SELECT pg_temp.patch(
    'sales.create_order(uuid, uuid, integer, integer, numeric, finances.payment_method, integer, numeric, numeric, boolean, jsonb[])',
    '    -- Create sales.order',
    '    -- Payment (card) fees are no longer charged or shown.
    _card_fee := 0;

    -- Create sales.order');

SELECT pg_temp.patch(
    'sales.create_order(uuid, uuid, integer, integer, numeric, finances.payment_method, integer, numeric, numeric, boolean, jsonb[])',
    'IF _card_fee IS NOT NULL THEN',
    'IF _card_fee IS NOT NULL AND _card_fee <> 0 THEN');

-- 2. Settings ----------------------------------------------------------------------------------

INSERT INTO finances.transaction_type (id, label, inventory)
VALUES ('KLA', 'KasiLift income allocation', false)
ON CONFLICT (id) DO NOTHING;

INSERT INTO system_configs.remote_config (id, num_value)
VALUES ('kasilift_daa_share_percent', 10)
ON CONFLICT (id) DO NOTHING;

INSERT INTO system_configs.remote_config (id, text_value)
SELECT 'kasilift_income_wallet_id', (
    SELECT w.id::text
    FROM services.get_involved_submissions s
    JOIN finances.wallet w ON w.user_id = s.user_id AND w.type = 'income'
    WHERE s.is_kasilift AND s.status = 'approved'
      AND s.organisation_name = '[TEST] KasiLift Organisation'
    LIMIT 1)
ON CONFLICT (id) DO NOTHING;

CREATE OR REPLACE FUNCTION finances.kasilift_income_wallet_id() RETURNS integer
    LANGUAGE sql STABLE SECURITY DEFINER
    SET search_path TO 'public'
AS $$
    SELECT NULLIF(text_value, '')::integer
    FROM system_configs.remote_config WHERE id = 'kasilift_income_wallet_id'
$$;

CREATE OR REPLACE FUNCTION finances.kasilift_daa_share_percent() RETURNS numeric
    LANGUAGE sql STABLE SECURITY DEFINER
    SET search_path TO 'public'
AS $$
    SELECT COALESCE((SELECT COALESCE(num_value, NULLIF(text_value, '')::numeric)
                     FROM system_configs.remote_config
                     WHERE id = 'kasilift_daa_share_percent'), 0)
$$;

-- 3. Pending lines --------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS finances.order_pending_earning (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    order_id integer NOT NULL REFERENCES sales."order"(id) ON DELETE CASCADE,
    eesupool_order_id integer,
    kind text NOT NULL CHECK (kind IN ('packer', 'dispatcher', 'receiver', 'kasipool_admin', 'kasilift')),
    wallet_id integer NOT NULL REFERENCES finances.wallet(id),
    amount numeric NOT NULL,
    transaction_id integer NOT NULL REFERENCES finances.transaction(id) ON DELETE CASCADE,
    created_at timestamptz NOT NULL DEFAULT now(),
    released_at timestamptz,
    cancelled_at timestamptz
);
CREATE INDEX IF NOT EXISTS order_pending_earning_order_idx ON finances.order_pending_earning (order_id);
CREATE INDEX IF NOT EXISTS order_pending_earning_pool_idx ON finances.order_pending_earning (eesupool_order_id);
CREATE INDEX IF NOT EXISTS order_pending_earning_wallet_idx ON finances.order_pending_earning (wallet_id)
    WHERE released_at IS NULL AND cancelled_at IS NULL;

ALTER TABLE finances.order_pending_earning ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON finances.order_pending_earning FROM PUBLIC, anon;
REVOKE INSERT, UPDATE, DELETE ON finances.order_pending_earning FROM authenticated;
GRANT SELECT ON finances.order_pending_earning TO authenticated;
GRANT ALL ON finances.order_pending_earning TO service_role;

DROP POLICY IF EXISTS order_pending_earning_own ON finances.order_pending_earning;
CREATE POLICY order_pending_earning_own ON finances.order_pending_earning
    FOR SELECT TO authenticated
    USING (public.is_admin() OR EXISTS (
        SELECT 1 FROM finances.wallet w WHERE w.id = wallet_id AND w.user_id = auth.uid()));

-- What each wallet should get from an order right now.
CREATE OR REPLACE FUNCTION finances.order_earnings_due(_order_id integer)
RETURNS TABLE (kind text, wallet_id integer, amount numeric, txn_type text, description text)
    LANGUAGE plpgsql STABLE SECURITY DEFINER
    SET search_path TO 'public'
AS $$
DECLARE
    _o record;
    _e record;
    _f record;
    _admin_total numeric;
    _receiving_total numeric;
    _packing numeric;
    _dispatch numeric;
    _admins integer;
    _receivers integer;
    _daa numeric;
    _kl_wallet integer := finances.kasilift_income_wallet_id();
    _kl_pct numeric := finances.kasilift_daa_share_percent();
BEGIN
    SELECT * INTO _o FROM sales."order" WHERE id = _order_id;
    IF NOT FOUND THEN
        RETURN;
    END IF;

    -- Vouchers earn nothing (same rule as the allocation triggers).
    IF NOT EXISTS (
        SELECT 1 FROM sales.order_product op
        JOIN inventory.product p ON p.id = op.product_id
        WHERE op.order_id = _order_id AND p.class <> 'Crowdfund-voucher'
    ) THEN
        RETURN;
    END IF;

    -- KasiPool roles: not for orders the old pay-on-collection trigger already
    -- paid (claimed, and no pending role line was ever recorded).
    IF _o.eesupool_order_id IS NOT NULL AND NOT (
        EXISTS (SELECT 1 FROM finances.allocation_run ar
                WHERE ar.order_id = _order_id AND ar.kind = 'pool')
        AND NOT EXISTS (SELECT 1 FROM finances.order_pending_earning pe
                        WHERE pe.order_id = _order_id AND pe.kind <> 'kasilift'
                          AND pe.cancelled_at IS NULL)
    ) THEN
        SELECT * INTO _e FROM sales.get_order_summed_food_class_earnings(_order_id);
        SELECT eo.admin_fee, eo.packer_fee, eo.receiver_fee, eo.collection_fee,
               eo.eesupool_id, eo.receivers
        INTO _f
        FROM communities.eesupool_order eo WHERE eo.id = _o.eesupool_order_id;

        _admin_total := FLOOR(COALESCE(_e.eia_total, 0) * COALESCE(_f.admin_fee, 0) / 100.0);
        _receiving_total := FLOOR(COALESCE(_e.eia_total, 0) * COALESCE(_f.receiver_fee, 0) / 100.0);
        _packing := FLOOR(COALESCE(_e.eia_total, 0) * COALESCE(_f.packer_fee, 0) / 100.0);
        _dispatch := FLOOR(COALESCE(_e.eia_total, 0) * COALESCE(_f.collection_fee, 0) / 100.0);

        -- The KasiPool's share: split between its admins.
        SELECT COUNT(*) INTO _admins FROM communities.eesupool_member
        WHERE eesupool_id = _f.eesupool_id AND role = 'Admin';
        IF _admins > 0 AND _admin_total > 0 THEN
            RETURN QUERY
            SELECT 'kasipool_admin'::text, w.id, ROUND(_admin_total / _admins, 2), 'EIA'::text,
                   CONCAT(_order_id, ' - KasiPool Admin Share')
            FROM communities.eesupool_member m
            JOIN finances.wallet w ON w.user_id = m.user_id AND w.type = 'income'
            WHERE m.eesupool_id = _f.eesupool_id AND m.role = 'Admin';
        END IF;

        _receivers := COALESCE(array_length(_f.receivers, 1), 0);
        IF _receivers > 0 AND _receiving_total > 0 THEN
            RETURN QUERY
            SELECT 'receiver'::text, w.id, ROUND(_receiving_total / _receivers, 2), 'EIA'::text,
                   CONCAT(_order_id, ' - Bulk Receiving Share')
            FROM unnest(_f.receivers) r(member_id)
            JOIN communities.eesupool_member m ON m.id = r.member_id
            JOIN finances.wallet w ON w.user_id = m.user_id AND w.type = 'income';
        END IF;

        IF _packing > 0 THEN
            RETURN QUERY
            SELECT 'packer'::text, w.id, _packing, 'EIA'::text, CONCAT(_order_id, ' - Packing Fee')
            FROM communities.member_order_assignment moa
            JOIN communities.eesupool_member m ON m.id = moa.member_id
            JOIN finances.wallet w ON w.user_id = m.user_id AND w.type = 'income'
            WHERE moa.order_id = _order_id AND moa.privilage IN ('Packer', 'All');
        END IF;

        IF _dispatch > 0 THEN
            RETURN QUERY
            SELECT 'dispatcher'::text, w.id, _dispatch, 'EIA'::text, CONCAT(_order_id, ' - Dispatch Fee')
            FROM communities.member_order_assignment moa
            JOIN communities.eesupool_member m ON m.id = moa.member_id
            JOIN finances.wallet w ON w.user_id = m.user_id AND w.type = 'income'
            WHERE moa.order_id = _order_id AND moa.privilage IN ('Dispatcher', 'Collector', 'All');
        END IF;
    END IF;

    -- KasiLift: a share of the platform's DAA, unless the platform share was
    -- paid in full before this existed (claimed, and no KasiLift line was ever
    -- recorded for the order). New orders get their line at placement, before
    -- the platform share is paid at collection.
    IF _kl_wallet IS NOT NULL AND _kl_pct > 0 AND NOT (
        EXISTS (SELECT 1 FROM finances.allocation_run ar
                WHERE ar.order_id = _order_id AND ar.kind = 'eesupreneur')
        AND NOT EXISTS (SELECT 1 FROM finances.order_pending_earning pe
                        WHERE pe.order_id = _order_id AND pe.kind = 'kasilift'
                          AND pe.cancelled_at IS NULL)
    ) THEN
        SELECT s.daa_total INTO _daa FROM sales.calculate_order_profit_splits(_order_id) s;
        IF COALESCE(_daa, 0) > 0 THEN
            RETURN QUERY
            SELECT 'kasilift'::text, _kl_wallet, ROUND(FLOOR(_daa * _kl_pct) / 100.0, 2), 'KLA'::text,
                   CONCAT(_order_id, ' - KasiLift Share');
        END IF;
    END IF;
END;
$$;

-- Brings an order's pending lines in line with what is due. Lines already
-- released are never touched.
CREATE OR REPLACE FUNCTION finances.sync_order_pending_earnings(_order_id integer) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
AS $$
DECLARE
    _o record;
    _due jsonb := '[]'::jsonb;
    _r record;
    _txn integer;
BEGIN
    PERFORM pg_advisory_xact_lock(hashtext('order_pending_earning'), _order_id);

    SELECT * INTO _o FROM sales."order" WHERE id = _order_id;
    IF NOT FOUND THEN
        RETURN;
    END IF;

    IF EXISTS (SELECT 1 FROM finances.order_pending_earning
               WHERE order_id = _order_id AND released_at IS NOT NULL) THEN
        RETURN;
    END IF;

    IF _o.placed_at IS NOT NULL AND _o.cancelled_at IS NULL AND _o.status <> 'Cancelled' THEN
        SELECT COALESCE(jsonb_agg(to_jsonb(d)), '[]'::jsonb) INTO _due
        FROM finances.order_earnings_due(_order_id) d
        WHERE d.amount > 0 AND d.wallet_id IS NOT NULL;
    END IF;

    -- Cancel lines that are no longer due.
    FOR _r IN
        WITH a AS (
            SELECT pe.id, pe.transaction_id, pe.kind, pe.wallet_id, pe.amount,
                   row_number() OVER (PARTITION BY pe.kind, pe.wallet_id, pe.amount ORDER BY pe.id) rn
            FROM finances.order_pending_earning pe
            WHERE pe.order_id = _order_id AND pe.cancelled_at IS NULL AND pe.released_at IS NULL
        ), d AS (
            SELECT x.kind, x.wallet_id, x.amount,
                   row_number() OVER (PARTITION BY x.kind, x.wallet_id, x.amount) rn
            FROM jsonb_to_recordset(_due) x(kind text, wallet_id integer, amount numeric)
        )
        SELECT a.* FROM a
        WHERE NOT EXISTS (SELECT 1 FROM d WHERE d.kind = a.kind AND d.wallet_id = a.wallet_id
                          AND d.amount = a.amount AND d.rn = a.rn)
    LOOP
        UPDATE finances.transaction SET cancelled_at = now()
        WHERE id = _r.transaction_id AND vested IS NOT TRUE;
        UPDATE finances.order_pending_earning SET cancelled_at = now() WHERE id = _r.id;
    END LOOP;

    -- Add lines that are due and missing.
    FOR _r IN
        WITH a AS (
            SELECT pe.kind, pe.wallet_id, pe.amount,
                   row_number() OVER (PARTITION BY pe.kind, pe.wallet_id, pe.amount ORDER BY pe.id) rn
            FROM finances.order_pending_earning pe
            WHERE pe.order_id = _order_id AND pe.cancelled_at IS NULL AND pe.released_at IS NULL
        ), d AS (
            SELECT x.*, row_number() OVER (PARTITION BY x.kind, x.wallet_id, x.amount) rn
            FROM jsonb_to_recordset(_due)
                 x(kind text, wallet_id integer, amount numeric, txn_type text, description text)
        )
        SELECT d.* FROM d
        WHERE NOT EXISTS (SELECT 1 FROM a WHERE a.kind = d.kind AND a.wallet_id = d.wallet_id
                          AND a.amount = d.amount AND a.rn = d.rn)
    LOOP
        _txn := finances.create_wallet_transaction(_r.wallet_id, _r.txn_type, _r.amount, false, _r.description);
        INSERT INTO finances.order_pending_earning
            (order_id, eesupool_order_id, kind, wallet_id, amount, transaction_id)
        VALUES (_order_id, _o.eesupool_order_id, _r.kind, _r.wallet_id, _r.amount, _txn);
    END LOOP;
END;
$$;

-- Vests an order's pending lines (after a final recalculation).
CREATE OR REPLACE FUNCTION finances.release_order_earnings(_order_id integer) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
AS $$
DECLARE
    _r record;
BEGIN
    PERFORM finances.sync_order_pending_earnings(_order_id);

    FOR _r IN
        SELECT pe.id, pe.transaction_id FROM finances.order_pending_earning pe
        WHERE pe.order_id = _order_id AND pe.cancelled_at IS NULL AND pe.released_at IS NULL
    LOOP
        UPDATE finances.transaction
        SET vested = true, confirmed_at = now()
        WHERE id = _r.transaction_id AND vested IS NOT TRUE AND cancelled_at IS NULL;
        UPDATE finances.order_pending_earning SET released_at = now() WHERE id = _r.id;
    END LOOP;
END;
$$;

CREATE OR REPLACE FUNCTION finances.release_pool_order_earnings(_eesupool_order_id integer) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
AS $$
DECLARE
    _id integer;
BEGIN
    FOR _id IN
        SELECT o.id FROM sales."order" o
        WHERE o.eesupool_order_id = _eesupool_order_id
          AND o.placed_at IS NOT NULL AND o.cancelled_at IS NULL AND o.status <> 'Cancelled'
    LOOP
        PERFORM finances.release_order_earnings(_id);
    END LOOP;
END;
$$;

-- Platform share minus the KasiLift share already set aside for the order.
CREATE OR REPLACE FUNCTION finances.order_kasilift_share(_order_id integer) RETURNS numeric
    LANGUAGE sql STABLE SECURITY DEFINER
    SET search_path TO 'public'
AS $$
    SELECT COALESCE(SUM(amount), 0) FROM finances.order_pending_earning
    WHERE order_id = _order_id AND kind = 'kasilift' AND cancelled_at IS NULL
$$;

REVOKE ALL ON FUNCTION finances.order_earnings_due(integer) FROM PUBLIC, anon, authenticated;
REVOKE ALL ON FUNCTION finances.sync_order_pending_earnings(integer) FROM PUBLIC, anon, authenticated;
REVOKE ALL ON FUNCTION finances.release_order_earnings(integer) FROM PUBLIC, anon, authenticated;
REVOKE ALL ON FUNCTION finances.release_pool_order_earnings(integer) FROM PUBLIC, anon, authenticated;
REVOKE ALL ON FUNCTION finances.order_kasilift_share(integer) FROM PUBLIC, anon, authenticated;
REVOKE ALL ON FUNCTION finances.kasilift_income_wallet_id() FROM PUBLIC, anon, authenticated;
REVOKE ALL ON FUNCTION finances.kasilift_daa_share_percent() FROM PUBLIC, anon, authenticated;

-- 4. When to recalculate / release ----------------------------------------------------------------

CREATE OR REPLACE FUNCTION finances.earnings_on_member_order() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
AS $$
BEGIN
    IF NEW.placed_at IS NULL THEN
        RETURN NULL;
    END IF;

    IF TG_OP = 'INSERT'
       OR OLD.placed_at IS NULL
       OR NEW.cancelled_at IS DISTINCT FROM OLD.cancelled_at
       OR (NEW.status = 'Cancelled' AND OLD.status IS DISTINCT FROM 'Cancelled') THEN
        PERFORM finances.sync_order_pending_earnings(NEW.id);
    END IF;

    -- EESUpreneur (non-pool) orders release when collected. Pool orders
    -- release together in communities.check_pool_order_completed.
    IF NEW.eesupool_order_id IS NULL AND NEW.collected_at IS NOT NULL
       AND (TG_OP = 'INSERT' OR OLD.collected_at IS NULL) THEN
        PERFORM finances.release_order_earnings(NEW.id);
    END IF;
    RETURN NULL;
END;
$$;

-- Named to run before the existing allocate_* and timeline_* AFTER triggers.
DROP TRIGGER IF EXISTS a_earnings_on_member_order_trigger ON sales."order";
CREATE TRIGGER a_earnings_on_member_order_trigger
    AFTER INSERT OR UPDATE OF placed_at, cancelled_at, status, collected_at ON sales."order"
    FOR EACH ROW EXECUTE FUNCTION finances.earnings_on_member_order();

CREATE OR REPLACE FUNCTION finances.earnings_on_assignment() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
AS $$
BEGIN
    PERFORM finances.sync_order_pending_earnings(COALESCE(NEW.order_id, OLD.order_id));
    RETURN NULL;
END;
$$;

DROP TRIGGER IF EXISTS earnings_on_assignment_trigger ON communities.member_order_assignment;
CREATE TRIGGER earnings_on_assignment_trigger
    AFTER INSERT OR UPDATE OR DELETE ON communities.member_order_assignment
    FOR EACH ROW EXECUTE FUNCTION finances.earnings_on_assignment();

CREATE OR REPLACE FUNCTION finances.earnings_on_pool_order() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
AS $$
DECLARE
    _id integer;
BEGIN
    IF NEW.receivers IS DISTINCT FROM OLD.receivers
       OR NEW.admin_fee IS DISTINCT FROM OLD.admin_fee
       OR NEW.packer_fee IS DISTINCT FROM OLD.packer_fee
       OR NEW.receiver_fee IS DISTINCT FROM OLD.receiver_fee
       OR NEW.collection_fee IS DISTINCT FROM OLD.collection_fee THEN
        FOR _id IN SELECT id FROM sales."order"
                   WHERE eesupool_order_id = NEW.id AND placed_at IS NOT NULL LOOP
            PERFORM finances.sync_order_pending_earnings(_id);
        END LOOP;
    END IF;
    RETURN NULL;
END;
$$;

DROP TRIGGER IF EXISTS earnings_on_pool_order_trigger ON communities.eesupool_order;
CREATE TRIGGER earnings_on_pool_order_trigger
    AFTER UPDATE OF receivers, admin_fee, packer_fee, receiver_fee, collection_fee ON communities.eesupool_order
    FOR EACH ROW EXECUTE FUNCTION finances.earnings_on_pool_order();

-- Completion now also releases the pool order's pending earnings.
CREATE OR REPLACE FUNCTION communities.check_pool_order_completed(_eesupool_order_id integer) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
AS $$
DECLARE
    _done boolean;
    _at timestamptz;
BEGIN
    SELECT eo.status = 'Closed'
       AND EXISTS (SELECT 1 FROM sales."order" o
                   WHERE o.eesupool_order_id = eo.id AND o.placed_at IS NOT NULL)
       AND NOT EXISTS (SELECT 1 FROM sales."order" o
                       WHERE o.eesupool_order_id = eo.id
                         AND o.placed_at IS NOT NULL
                         AND o.cancelled_at IS NULL
                         AND o.status <> 'Cancelled'
                         AND o.collected_at IS NULL)
    INTO _done
    FROM communities.eesupool_order eo
    WHERE eo.id = _eesupool_order_id;

    IF NOT COALESCE(_done, false) THEN
        RETURN false;
    END IF;

    SELECT GREATEST(MAX(o.collected_at), MAX(o.cancelled_at)) INTO _at
    FROM sales."order" o WHERE o.eesupool_order_id = _eesupool_order_id;

    PERFORM communities.log_pool_order_event(
        _eesupool_order_id, NULL, 'pool_order_completed', NULL,
        'Every order was collected or cancelled.', COALESCE(_at, now()));

    PERFORM finances.release_pool_order_earnings(_eesupool_order_id);
    RETURN true;
END;
$$;

-- 5. The old pool trigger stops paying; DAA leaves room for KasiLift ----------------------------------

CREATE OR REPLACE FUNCTION sales.allocate_profit_earnings_for_eesupool_member_orders() RETURNS trigger
    LANGUAGE plpgsql
AS $$
BEGIN
    -- KasiPool role earnings (admin, receivers, Packer, Dispatcher) are now
    -- recorded as pending when the order is placed and vested when the whole
    -- KasiPool order is completed: see finances.sync_order_pending_earnings
    -- and communities.check_pool_order_completed
    -- (20261120150000_kasipool_pending_earnings.sql).
    RETURN NEW;
END;
$$;

SELECT pg_temp.patch('sales.allocate_profit_earnings_for_eesupreneur_orders()',
    'PERFORM finances.create_wallet_transaction(_target_wallet, ''DAA'', _order_earnings.daa_total,',
    'PERFORM finances.create_wallet_transaction(_target_wallet, ''DAA'', _order_earnings.daa_total - finances.order_kasilift_share(NEW.id),');

-- 6. Wallet screens: pending total per wallet ---------------------------------------------------------

CREATE OR REPLACE FUNCTION finances.get_my_pending_earnings()
RETURNS TABLE (wallet_id integer, pending numeric, lines integer)
    LANGUAGE sql STABLE SECURITY DEFINER
    SET search_path TO 'public'
AS $$
    SELECT w.id,
           COALESCE(SUM(t.value), 0),
           COUNT(t.id)::integer
    FROM finances.wallet w
    JOIN finances.wallet_transaction wt ON wt.wallet_id = w.id
    JOIN finances.transaction t ON t.id = wt.transaction_id
    WHERE w.user_id = auth.uid()
      AND t.vested IS NOT TRUE
      AND t.cancelled_at IS NULL
      AND t.is_deleted IS NOT TRUE
      AND t.value > 0
      AND EXISTS (SELECT 1 FROM finances.order_pending_earning pe WHERE pe.transaction_id = t.id)
    GROUP BY w.id
$$;
REVOKE ALL ON FUNCTION finances.get_my_pending_earnings() FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION finances.get_my_pending_earnings() TO authenticated, service_role;

-- 7. Orders already placed and still open get their pending lines now ---------------------------------

DO $$
DECLARE _id integer;
BEGIN
    FOR _id IN
        SELECT o.id FROM sales."order" o
        WHERE o.placed_at IS NOT NULL
          AND o.cancelled_at IS NULL AND o.status <> 'Cancelled'
          AND o.collected_at IS NULL
          AND o.created_at > now() - interval '120 days'
    LOOP
        PERFORM finances.sync_order_pending_earnings(_id);
    END LOOP;
END;
$$;
