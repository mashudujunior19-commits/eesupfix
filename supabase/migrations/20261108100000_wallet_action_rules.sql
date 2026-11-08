-- Wallet action rules, enforced in the database (the app only mirrors them).
--
--   Social wallet : no payouts. Transfers only to an approved KasiLift
--                   Organisation (credited to the organisation owner's Income wallet).
--   Wealth wallet : no payouts, no transfers. Funds can only be COMMITTED to an
--                   approved investment project that accepts funds, and only while
--                   the available balance is strictly more than R500.
--   Income/Retail : unchanged.
--
-- Not applied automatically: review, then run against the target project.
-- NOTE: the baseline RLS/grants are still permissive (see docs/audit). These
-- rules close the supported paths (transfer RPC, payout insert, commit RPC);
-- direct calls to finances.create_wallet_transaction or direct table writes
-- remain a separate, known risk.

-- ---------------------------------------------------------------------------
-- Constants (one place)
-- ---------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION finances.min_wealth_commit_balance() RETURNS numeric
    LANGUAGE sql IMMUTABLE
    AS $$ SELECT 500::numeric $$;

-- Vested, live balance of a wallet (what the app shows as "Available").
CREATE OR REPLACE FUNCTION finances.wallet_available_balance(_wallet_id integer) RETURNS numeric
    LANGUAGE sql STABLE SECURITY DEFINER
    SET search_path = finances, public
    AS $$
    SELECT COALESCE(SUM(t.value), 0)
    FROM finances.wallet_transaction wt
    JOIN finances.transaction t ON t.id = wt.transaction_id
    WHERE wt.wallet_id = _wallet_id
      AND t.vested = true
      AND t.is_deleted IS NOT TRUE
      AND t.cancelled_at IS NULL
$$;

-- ---------------------------------------------------------------------------
-- 1. No payouts from Social or Wealth wallets
-- ---------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION finances.block_restricted_payouts() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path = finances, public
    AS $$
DECLARE
    _type text;
BEGIN
    SELECT w.type INTO _type FROM finances.wallet w WHERE w.id = NEW.wallet_id;
    IF _type IN ('social', 'wealth') THEN
        RAISE EXCEPTION 'Payouts are not allowed from the % wallet.', initcap(_type);
    END IF;
    RETURN NEW;
END;
$$;

-- Named so it fires before on_payout_request_create_transaction.
DROP TRIGGER IF EXISTS a_block_restricted_payouts ON finances.payout_request;
CREATE TRIGGER a_block_restricted_payouts
    BEFORE INSERT ON finances.payout_request
    FOR EACH ROW EXECUTE FUNCTION finances.block_restricted_payouts();

-- ---------------------------------------------------------------------------
-- 2. KasiLift Organisations a Social wallet may send to
-- ---------------------------------------------------------------------------
-- Approved KasiLift organisations (owned by someone else) and the Income wallet
-- of their owner, which is where a transfer is credited.
CREATE OR REPLACE FUNCTION finances.get_kasilift_organisations()
RETURNS TABLE(organisation_id uuid, organisation_name text, province text, wallet_id integer)
    LANGUAGE sql STABLE SECURITY DEFINER
    SET search_path = finances, services, public
    AS $$
    SELECT s.id, s.organisation_name, s.province, w.id
    FROM services.get_involved_submissions s
    JOIN finances.wallet w ON w.user_id = s.user_id AND w.type = 'income'
    WHERE s.is_kasilift = true
      AND s.status = 'approved'
      AND s.user_id <> auth.uid()
    ORDER BY s.organisation_name
$$;

-- ---------------------------------------------------------------------------
-- 3. Transfers: ownership + wallet rules
-- ---------------------------------------------------------------------------
-- Same signature as before so existing callers keep working.
CREATE OR REPLACE FUNCTION finances.transfer_funds_wallet_to_wallet(
    "to_wallet_id" integer, "from_wallet_id" integer,
    "to_ref" text, "from_ref" text, "amount" numeric
) RETURNS integer
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path = finances, services, public
    AS $$
DECLARE
    _from finances.wallet%ROWTYPE;
    _to finances.wallet%ROWTYPE;
    trans_id_to integer;
    trans_id_from integer;
BEGIN
    IF amount IS NULL OR amount <= 0 THEN
        RAISE EXCEPTION 'The amount must be greater than zero.';
    END IF;

    -- Lock the source so two transfers cannot both pass the funds check.
    SELECT * INTO _from FROM finances.wallet WHERE id = from_wallet_id FOR UPDATE;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'The source wallet was not found.';
    END IF;

    -- Signed-in callers may only spend their own wallet. (No JWT at all means a
    -- direct database connection, e.g. an admin; service_role is trusted.)
    IF auth.role() IS NOT NULL AND auth.role() <> 'service_role'
       AND (auth.uid() IS NULL OR _from.user_id <> auth.uid()) THEN
        RAISE EXCEPTION 'You can only transfer from your own wallet.';
    END IF;

    SELECT * INTO _to FROM finances.wallet WHERE id = to_wallet_id;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'The recipient wallet was not found.';
    END IF;
    IF _to.id = _from.id THEN
        RAISE EXCEPTION 'You cannot transfer to the same wallet.';
    END IF;

    IF _from.type = 'wealth' THEN
        RAISE EXCEPTION 'Wealth wallet funds cannot be transferred. They can only be committed to an approved investment project.';
    END IF;

    IF _from.type = 'social' THEN
        -- Only to the Income wallet of someone else's approved KasiLift Organisation.
        IF _to.user_id = _from.user_id
           OR _to.type <> 'income'
           OR NOT EXISTS (
                SELECT 1 FROM services.get_involved_submissions s
                WHERE s.user_id = _to.user_id
                  AND s.is_kasilift = true
                  AND s.status = 'approved') THEN
            RAISE EXCEPTION 'Social wallet funds can only be transferred to a registered KasiLift Organisation.';
        END IF;
        IF amount > finances.wallet_available_balance(_from.id) THEN
            RAISE EXCEPTION 'Insufficient funds in your Social wallet.';
        END IF;
    END IF;

    -- Create a transaction for withdrawing from the from_wallet
    SELECT INTO trans_id_from finances.create_wallet_transaction(from_wallet_id, 'TRF', -amount, TRUE, from_ref);
    -- Create a transaction for depositing into the to_wallet
    SELECT INTO trans_id_to finances.create_wallet_transaction(to_wallet_id, 'TRF', amount, TRUE, to_ref);
    RETURN trans_id_to;
END;
$$;

-- ---------------------------------------------------------------------------
-- 4. Investment projects and commitments (Wealth wallet)
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS finances.investment_project (
    id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name text NOT NULL,
    description text,
    status text NOT NULL DEFAULT 'pending'
        CHECK (status IN ('pending', 'approved', 'rejected')),
    accepts_funds boolean NOT NULL DEFAULT false,
    created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS finances.project_commitment (
    id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    project_id integer NOT NULL REFERENCES finances.investment_project(id),
    wallet_id integer NOT NULL REFERENCES finances.wallet(id),
    user_id uuid NOT NULL,
    amount numeric NOT NULL CHECK (amount > 0),
    transaction_id integer,
    created_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE finances.investment_project ENABLE ROW LEVEL SECURITY;
ALTER TABLE finances.project_commitment ENABLE ROW LEVEL SECURITY;

-- Default privileges in this project grant anon everything; take it back.
REVOKE ALL ON finances.investment_project FROM anon, authenticated;
REVOKE ALL ON finances.project_commitment FROM anon, authenticated;
GRANT SELECT ON finances.investment_project TO authenticated;
GRANT SELECT ON finances.project_commitment TO authenticated;
GRANT ALL ON finances.investment_project TO service_role;
GRANT ALL ON finances.project_commitment TO service_role;

DROP POLICY IF EXISTS "Authenticated can view fundable projects" ON finances.investment_project;
CREATE POLICY "Authenticated can view fundable projects" ON finances.investment_project
    FOR SELECT TO authenticated
    USING (status = 'approved' AND accepts_funds);

DROP POLICY IF EXISTS "Users can view their own commitments" ON finances.project_commitment;
CREATE POLICY "Users can view their own commitments" ON finances.project_commitment
    FOR SELECT TO authenticated
    USING (user_id = auth.uid());

-- Projects are created/approved by admins directly in the database (service
-- role); there is deliberately no insert/update policy for app users.

CREATE OR REPLACE FUNCTION finances.commit_to_project(
    "_from_wallet_id" integer, "_project_id" integer, "_amount" numeric
) RETURNS integer
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path = finances, public
    AS $$
DECLARE
    _w finances.wallet%ROWTYPE;
    _p finances.investment_project%ROWTYPE;
    _available numeric;
    _min numeric := finances.min_wealth_commit_balance();
    _trans_id integer;
    _commitment_id integer;
BEGIN
    IF _amount IS NULL OR _amount <= 0 THEN
        RAISE EXCEPTION 'The amount must be greater than zero.';
    END IF;

    SELECT * INTO _w FROM finances.wallet WHERE id = _from_wallet_id FOR UPDATE;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'The wallet was not found.';
    END IF;

    IF auth.role() IS NOT NULL AND auth.role() <> 'service_role'
       AND (auth.uid() IS NULL OR _w.user_id <> auth.uid()) THEN
        RAISE EXCEPTION 'You can only commit funds from your own wallet.';
    END IF;

    IF _w.type <> 'wealth' THEN
        RAISE EXCEPTION 'Only Wealth wallet funds can be committed to investment projects.';
    END IF;

    SELECT * INTO _p FROM finances.investment_project WHERE id = _project_id;
    IF NOT FOUND OR _p.status <> 'approved' OR NOT _p.accepts_funds THEN
        RAISE EXCEPTION 'This project is not approved and open for funding.';
    END IF;

    _available := finances.wallet_available_balance(_w.id);
    IF _available <= _min THEN
        RAISE EXCEPTION 'You need more than R% in your Wealth wallet to commit to a project. Current available balance: R%.',
            to_char(_min, 'FM999999990'), to_char(_available, 'FM999999990.00');
    END IF;
    IF _amount > _available THEN
        RAISE EXCEPTION 'Insufficient funds. Available balance: R%.', to_char(_available, 'FM999999990.00');
    END IF;

    SELECT finances.create_wallet_transaction(_w.id, 'TRF', -_amount, TRUE, 'Committed to ' || _p.name)
    INTO _trans_id;

    INSERT INTO finances.project_commitment(project_id, wallet_id, user_id, amount, transaction_id)
    VALUES (_p.id, _w.id, _w.user_id, _amount, _trans_id)
    RETURNING id INTO _commitment_id;

    RETURN _commitment_id;
END;
$$;

-- ---------------------------------------------------------------------------
-- Grants: signed-in users and the service role only (never anon)
-- ---------------------------------------------------------------------------
REVOKE ALL ON FUNCTION finances.transfer_funds_wallet_to_wallet(integer, integer, text, text, numeric) FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION finances.transfer_funds_wallet_to_wallet(integer, integer, text, text, numeric) TO authenticated, service_role;

REVOKE ALL ON FUNCTION finances.get_kasilift_organisations() FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION finances.get_kasilift_organisations() TO authenticated, service_role;

REVOKE ALL ON FUNCTION finances.commit_to_project(integer, integer, numeric) FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION finances.commit_to_project(integer, integer, numeric) TO authenticated, service_role;

-- Internal helper: only the definer functions above call it. Not exposed, so
-- nobody can read another user's balance through it.
REVOKE ALL ON FUNCTION finances.wallet_available_balance(integer) FROM PUBLIC, anon, authenticated;
GRANT EXECUTE ON FUNCTION finances.wallet_available_balance(integer) TO service_role;

GRANT EXECUTE ON FUNCTION finances.min_wealth_commit_balance() TO authenticated, service_role;
