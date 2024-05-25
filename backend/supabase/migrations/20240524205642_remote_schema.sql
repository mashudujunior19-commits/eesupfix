drop function if exists "communities"."get_eesupool_messages"(pool_id integer, approved boolean, limit_to integer);

drop function if exists "communities"."get_eesupool_messages_by_hash_tag"(pool_id integer, hash_tag text, approved boolean, limit_to integer);

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION communities.get_eesupool_messages(pool_id integer, limit_to integer)
 RETURNS TABLE(id integer, eesupool_id integer, author_id uuid, created_at timestamp with time zone, content text, reply_on_id integer, attachments jsonb[], author_full_name text, reply_message jsonb, reactions jsonb, is_approved boolean, hash_tags text[], is_deleted boolean, message_seens uuid[])
 LANGUAGE plpgsql
 STABLE
AS $function$
BEGIN
    RETURN QUERY
    SELECT 
        m.id,
        m.eesupool_id,
        m.author_id,
        m.created_at,
        m.content,
        m.reply_on_id,
        m.attachments,
        (SELECT CONCAT(p.first_name, ' ', p.last_name) 
         FROM profile p 
         JOIN communities.eesupool_member em ON p.user_id = em.user_id
         WHERE em.id = m.author_id) AS author_full_name,
        COALESCE((SELECT row_to_json(t)::jsonb 
                  FROM (SELECT * FROM communities.get_message_by_id(m.reply_on_id)) t), 'null'::jsonb) AS reply_message,
        COALESCE((SELECT jsonb_agg(t) 
                  FROM (SELECT * FROM communities.get_message_reactions(m.id)) t), 'null'::jsonb) AS reactions, 
        m.is_approved,
        m.hash_tags,
        m.is_deleted,
        ARRAY_AGG(ms.member_id) FILTER (WHERE ms.message_id = m.id) AS message_seens
    FROM 
        communities.message m
    LEFT JOIN communities.message_seen ms ON m.id = ms.message_id
    WHERE 
        m.eesupool_id = pool_id
    GROUP BY 
        m.id, m.eesupool_id, m.author_id, m.created_at, m.content,
        m.reply_on_id, m.attachments, author_full_name, reply_message,
        reactions, m.is_approved, m.hash_tags, m.is_deleted
    ORDER BY 
        m.created_at DESC
    LIMIT 
        limit_to;
END;
$function$
;

CREATE OR REPLACE FUNCTION communities.get_eesupool_messages_by_hash_tag(pool_id integer, hash_tag text, limit_to integer)
 RETURNS TABLE(id integer, eesupool_id integer, author_id uuid, created_at timestamp with time zone, content text, reply_on_id integer, attachments jsonb[], author_full_name text, reply_message jsonb, reactions jsonb, is_approved boolean, hash_tags text[], is_deleted boolean, message_seens uuid[])
 LANGUAGE plpgsql
 STABLE
AS $function$
BEGIN
    RETURN QUERY
    SELECT 
        m.id,
        m.eesupool_id,
        m.author_id,
        m.created_at,
        m.content,
        m.reply_on_id,
        m.attachments,
        (SELECT CONCAT(p.first_name, ' ', p.last_name) 
         FROM profile p 
         JOIN communities.eesupool_member em ON p.user_id = em.user_id
         WHERE em.id = m.author_id) AS author_full_name,
        COALESCE((SELECT row_to_json(t)::jsonb 
                  FROM (SELECT * FROM communities.get_message_by_id(m.reply_on_id)) t), null::jsonb) AS reply_message,
        COALESCE((SELECT jsonb_agg(t) 
                  FROM (SELECT * FROM communities.get_message_reactions(m.id)) t), null::jsonb) AS reactions,
        m.is_approved,
        m.hash_tags,
        m.is_deleted,
        ARRAY_AGG(ms.member_id) FILTER (WHERE ms.message_id = m.id) AS message_seens
    FROM 
        communities.message m
    LEFT JOIN communities.message_seen ms ON m.id = ms.message_id
    WHERE 
        m.eesupool_id = pool_id AND hash_tag = ANY(m.hash_tags)
    GROUP BY 
        m.id, m.eesupool_id, m.author_id, m.created_at, m.content,
        m.reply_on_id, m.attachments, author_full_name, reply_message,
        reactions, m.is_approved, m.hash_tags, m.is_deleted
    ORDER BY 
        m.created_at DESC
    LIMIT 
        limit_to;
END;
$function$
;


alter table "finances"."payout_request" add column "acc_holder" text not null;

alter table "finances"."payout_request" add column "amount" numeric not null;

alter table "finances"."payout_request" add column "transaction_id" integer not null;

alter table "finances"."payout_request" add column "wallet_id" integer not null;

alter table "finances"."payout_request" add constraint "payout_request_transaction_id_fkey" FOREIGN KEY (transaction_id) REFERENCES finances.transaction(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "finances"."payout_request" validate constraint "payout_request_transaction_id_fkey";

alter table "finances"."payout_request" add constraint "payout_request_wallet_id_fkey" FOREIGN KEY (wallet_id) REFERENCES finances.wallet(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "finances"."payout_request" validate constraint "payout_request_wallet_id_fkey";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION finances.get_profit_allocation_by_role(role user_role)
 RETURNS TABLE(cia numeric, cwa numeric, eia numeric, crc numeric, csa numeric, daa numeric, id integer, cfv numeric)
 LANGUAGE plpgsql
AS $function$
BEGIN
  RETURN QUERY
  SELECT
    pa.cia,
     pa.cwa,
     pa.eia,
     pa.crc,
     pa.csa,
     pa.daa,
     pa.id,
     pa.cfv
  FROM
    finances.profit_allocation pa
  WHERE
    role = ANY(pa.roles);
END;
$function$
;

CREATE OR REPLACE FUNCTION finances.on_payout_request_create_transaction()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
declare
    transaction_id integer;
begin
    SELECT finances.create_wallet_transaction(NEW.wallet_id, 'TRF', NEW.amount, false, 'Cash withdrawal')
    INTO transaction_id;

    new.transaction_id = transaction_id;
    
    return new;
end;
$function$
;

create policy "Enable access for authenticated users only"
on "finances"."payout_request"
as permissive
for all
to authenticated
using (true)
with check (true);


CREATE TRIGGER on_payout_request_create_transaction_trigger BEFORE INSERT ON finances.payout_request FOR EACH ROW EXECUTE FUNCTION finances.on_payout_request_create_transaction();


set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.handle_new_referral(referee_id uuid, ref_code integer, full_name text, is_confirmed boolean)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    referrer_id UUID;
    wallet_id INTEGER;
    transaction_id INTEGER;
BEGIN
    -- Get referrer ID from profile using referral code
    SELECT user_id INTO referrer_id 
    FROM public.profile 
    WHERE referral_code = ref_code;

    IF NOT EXISTS (SELECT 1 FROM public.referral WHERE refereed_user_id = referee_id AND referrer_user_id = referrer_id) THEN

    -- Check if referrer_id was found
    IF referrer_id IS NULL THEN
        -- Handle the case where the referrer is not found, e.g., raise an exception or exit
        RAISE EXCEPTION 'Referrer not found for referral code %', ref_code;
    END IF;

    -- Get referrer's retail wallet ID
    SELECT id INTO wallet_id 
    FROM finances.wallet 
    WHERE user_id = referrer_id AND type = 'wealth';

    -- Create referral transaction
    SELECT finances.create_wallet_transaction(wallet_id, 'CRC', 1.00, is_confirmed, CONCAT('Referred ', full_name))
    INTO transaction_id;

    -- Insert into the referrals table
    INSERT INTO public.referral(referrer_user_id, refereed_user_id, transaction_id, is_completed) 
    VALUES (referrer_id, referee_id, transaction_id, is_confirmed);

    END IF;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.handle_new_user()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
DECLARE
  ref_name TEXT;
  master_referral_code text;
  is_confirmed BOOLEAN DEFAULT FALSE;
BEGIN
  -- Check if the new row has a 'confirmed_at' value
  IF NEW.confirmed_at IS NOT NULL THEN
    -- Check if the user profile does not exist in the 'public.profile' table
    IF NOT EXISTS (SELECT 1 FROM public.profile WHERE user_id = NEW.id) THEN
      -- Determine if the user is a corporate account or not
      IF (NEW.raw_user_meta_data->>'is_corp')::BOOLEAN THEN
        is_confirmed := TRUE;
        ref_name := NEW.raw_user_meta_data->>'corp_name';

        -- Insert corporate profile based on the 'type'
        INSERT INTO public.profile(user_id, email, phone, corp_name, corp_reg, npc_reg, role, is_approved)
        VALUES (NEW.id, NEW.email, NEW.phone, NEW.raw_user_meta_data->>'corp_name',
                NEW.raw_user_meta_data->>'corp_reg', NEW.raw_user_meta_data->>'npc_reg',
                CAST(NEW.raw_user_meta_data->>'type' AS public.user_role), FALSE);

      ELSE
        -- Insert new user profile for non-corporate accounts
        INSERT INTO public.profile(user_id, email, phone, first_name, last_name, rsa_id_number, role)
        VALUES (NEW.id, NEW.email, NEW.phone, NEW.raw_user_meta_data->>'first_name', NEW.raw_user_meta_data->>'last_name',
                NEW.raw_user_meta_data->>'id_number', 'Ubuntunist');

        ref_name := CONCAT(NEW.raw_user_meta_data->>'first_name', ' ', NEW.raw_user_meta_data->>'last_name');
      END IF;
    END IF;

    -- Handle referral if a profile exists for the user
    IF EXISTS (SELECT 1 FROM public.profile WHERE user_id = NEW.id) THEN
      IF NEW.raw_user_meta_data->>'referral_code' IS NOT NULL THEN
        PERFORM public.handle_new_referral(NEW.id, (NEW.raw_user_meta_data->>'referral_code')::INTEGER, ref_name, is_confirmed);
      ELSE

        SELECT text_value INTO master_referral_code FROM system_configs.remote_config
        WHERE id = 'master_referral_code';

        PERFORM public.handle_new_referral(NEW.id, master_referral_code::integer, ref_name, is_confirmed);
      END IF;
    END IF;

  END IF;

  RETURN NEW;
END;
$function$
;


