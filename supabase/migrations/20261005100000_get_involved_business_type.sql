-- TOWRIS Business registrations now pick one of 8 commercial verticals
-- (stored in the existing industry_type) and then a specific business type
-- within it, e.g. "Food, Grocery & Hospitality" / "Shisanyamas". The list
-- lives in the app (packages/ui/.../commercial_verticals.dart) so it can
-- change without a migration; plain text here, like industry_type.
--
-- NPO / Voluntary Association submissions leave it null.

ALTER TABLE "services"."get_involved_submissions"
    ADD COLUMN IF NOT EXISTS "business_type" "text";
