-- Referral status should reflect whether the referred person's account is
-- actually verified (profile.is_verified), not the referral.is_completed flag,
-- which is only a payout marker and can lag behind. is_completed is still
-- returned for anything that relies on it.
DROP FUNCTION IF EXISTS public.get_referrals_by_referrer(uuid, integer);

CREATE FUNCTION public.get_referrals_by_referrer(_user_id uuid, _limit_to integer)
RETURNS TABLE (
    referrer_user_id uuid,
    refereed_user_id uuid,
    refereed_full_name text,
    created_at timestamptz,
    transaction_id integer,
    is_completed boolean,
    is_verified boolean
)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        r.referrer_user_id,
        r.refereed_user_id,
        COALESCE(
            CASE
                WHEN p.first_name IS NOT NULL AND p.last_name IS NOT NULL THEN p.first_name || ' ' || p.last_name
                ELSE p.corp_name
            END,
            'Unknown Name'
        ) AS refereed_full_name,
        r.created_at,
        r.transaction_id,
        r.is_completed,
        COALESCE(p.is_verified, false) AS is_verified
    FROM public.referral r
    JOIN public.profile p ON r.refereed_user_id = p.user_id
    WHERE r.referrer_user_id = _user_id
    ORDER BY r.created_at DESC
    LIMIT _limit_to;
END;
$$;

ALTER FUNCTION public.get_referrals_by_referrer(uuid, integer) OWNER TO postgres;
GRANT EXECUTE ON FUNCTION public.get_referrals_by_referrer(uuid, integer) TO authenticated;
GRANT EXECUTE ON FUNCTION public.get_referrals_by_referrer(uuid, integer) TO service_role;
