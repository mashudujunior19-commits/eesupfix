-- Business profile: the details a person typed in when they registered their
-- business (Get Involved), kept on their account so the Business profile shows
-- real values, with its own unique referral code.

-- 1. Typed details collected by the Get Involved form (next to the uploads).
ALTER TABLE services.get_involved_submissions
    ADD COLUMN IF NOT EXISTS registration_number text,
    ADD COLUMN IF NOT EXISTS vat_number text,
    ADD COLUMN IF NOT EXISTS tax_number text;

-- 2. One business profile per account. The referral code comes from the same
--    sequence as personal referral codes, so it can never equal anyone's code.
CREATE TABLE IF NOT EXISTS public.business_profile (
    user_id uuid PRIMARY KEY REFERENCES public.profile(user_id) ON DELETE CASCADE,
    submission_id uuid,
    business_name text NOT NULL,
    referral_code integer NOT NULL DEFAULT nextval('public.profile_referral_code_seq1'),
    registration_number text,
    vat_number text,
    tax_number text,
    social_development_number text,
    industry_type text,
    business_type text,
    address text,
    province text,
    about_us text,
    submission_type text,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT business_profile_referral_code_key UNIQUE (referral_code)
);

ALTER TABLE public.business_profile ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "business_profile_select_own" ON public.business_profile;
CREATE POLICY "business_profile_select_own" ON public.business_profile
    FOR SELECT TO authenticated USING (user_id = auth.uid() OR public.is_admin());

-- Written only by the approval trigger below; nobody edits it directly.
REVOKE ALL ON public.business_profile FROM anon, authenticated;
GRANT SELECT ON public.business_profile TO authenticated;
GRANT ALL ON public.business_profile TO service_role;

-- 3. Approval copies the application's details into the business profile. A
--    later approval refreshes the details but never changes the referral code.
CREATE OR REPLACE FUNCTION services.sync_business_profile() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path = public
    AS $$
BEGIN
    IF NEW.status = 'approved' THEN
        INSERT INTO public.business_profile AS b (
            user_id, submission_id, business_name, registration_number, vat_number,
            tax_number, social_development_number, industry_type, business_type,
            address, province, about_us, submission_type)
        VALUES (
            NEW.user_id, NEW.id, NEW.organisation_name,
            COALESCE(NULLIF(NEW.registration_number, ''), NULLIF(NEW.social_development_number, '')),
            NULLIF(NEW.vat_number, ''), NULLIF(NEW.tax_number, ''),
            NULLIF(NEW.social_development_number, ''), NEW.industry_type, NEW.business_type,
            NEW.address, NEW.province, NEW.about_us, NEW.submission_type)
        ON CONFLICT (user_id) DO UPDATE SET
            submission_id = EXCLUDED.submission_id,
            business_name = EXCLUDED.business_name,
            registration_number = EXCLUDED.registration_number,
            vat_number = EXCLUDED.vat_number,
            tax_number = EXCLUDED.tax_number,
            social_development_number = EXCLUDED.social_development_number,
            industry_type = EXCLUDED.industry_type,
            business_type = EXCLUDED.business_type,
            address = EXCLUDED.address,
            province = EXCLUDED.province,
            about_us = EXCLUDED.about_us,
            submission_type = EXCLUDED.submission_type,
            updated_at = now();
    END IF;
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS sync_business_profile ON services.get_involved_submissions;
CREATE TRIGGER sync_business_profile
    AFTER INSERT OR UPDATE OF status ON services.get_involved_submissions
    FOR EACH ROW EXECUTE FUNCTION services.sync_business_profile();

-- 4. Everyone approved before this migration gets their business profile too,
--    from the most recent approved application.
INSERT INTO public.business_profile (
    user_id, submission_id, business_name, registration_number, vat_number,
    tax_number, social_development_number, industry_type, business_type,
    address, province, about_us, submission_type)
SELECT DISTINCT ON (s.user_id)
    s.user_id, s.id, s.organisation_name,
    COALESCE(NULLIF(s.registration_number, ''), NULLIF(s.social_development_number, '')),
    NULLIF(s.vat_number, ''), NULLIF(s.tax_number, ''),
    NULLIF(s.social_development_number, ''), s.industry_type, s.business_type,
    s.address, s.province, s.about_us, s.submission_type
FROM services.get_involved_submissions s
JOIN public.profile p ON p.user_id = s.user_id
WHERE s.status = 'approved'
ORDER BY s.user_id, s.reviewed_at DESC NULLS LAST
ON CONFLICT (user_id) DO NOTHING;

-- 5. What the app reads.
CREATE OR REPLACE FUNCTION public.get_business_profile()
RETURNS SETOF public.business_profile
    LANGUAGE sql STABLE SECURITY DEFINER
    SET search_path = public
    AS $$
    SELECT * FROM public.business_profile WHERE user_id = auth.uid()
$$;
REVOKE ALL ON FUNCTION public.get_business_profile() FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.get_business_profile() TO authenticated, service_role;
