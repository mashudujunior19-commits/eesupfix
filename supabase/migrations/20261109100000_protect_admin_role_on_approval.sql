-- Approving a partner application changes the applicant's role (Kasipreneur ->
-- EESUpreneur, EESUplift -> EESUplift-Corporate). That overwrote the role of an
-- Admin whose own application was approved, locking them out of the admin app.
-- An Admin's role is now never replaced by an approval; the approval itself,
-- the notification and the shop/wallets are unchanged.

CREATE OR REPLACE FUNCTION "services"."on_partner_application_approved"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    _type RECORD;
BEGIN
    -- only on the approval itself, not on later updates of an approved application
    IF TG_OP = 'UPDATE' THEN
        IF OLD.approved_at IS NOT NULL THEN
            RETURN NEW;
        END IF;
    END IF;

    IF NEW.approved_at IS NOT NULL AND NEW.rejected_at IS NULL THEN
        IF NEW.partner_id = 'eesup_lift_corp' THEN
            UPDATE profile SET role = 'EESUplift-Corporate'
            WHERE user_id = NEW.user_id AND role IS DISTINCT FROM 'Admin';

            FOR _type IN SELECT wt.id FROM finances.wallet_type wt
            WHERE 'EESUplift-Corporate' = ANY(wt.roles)
            LOOP
                IF NOT EXISTS (SELECT 1 FROM finances.wallet w WHERE w.type = _type.id AND w.user_id = NEW.user_id) THEN
                    INSERT INTO finances.wallet(type, user_id, balance)
                    VALUES (_type.id, NEW.user_id, 0.00);
                END IF;
            END LOOP;
        ELSIF NEW.partner_id = 'eesupreneur' THEN
            UPDATE profile SET role = 'EESUpreneur'
            WHERE user_id = NEW.user_id AND role IS DISTINCT FROM 'Admin';

            INSERT INTO services.eesupreneur(owner_id, name)
            VALUES (NEW.user_id, 'My Shop');
        END IF;
    END IF;

    RETURN NEW;
END;
$$;
