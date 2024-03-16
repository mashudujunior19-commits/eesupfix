
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
