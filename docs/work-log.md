# Towris (formerly EESUp) – Work Log

Covers this working session on the customer app (`eesupfix`), the admin app (`eesup_admin`) and the Dev Supabase project. 20 entries.

## Stack and frameworks

| Area | Technology |
|---|---|
| Customer app | Flutter (Dart), flutter_bloc (bloc/cubit), auto_route, freezed + build_runner, Flutter web build |
| Admin app | Flutter (Dart) web, flutter_test |
| Backend | Supabase: Postgres (RPCs, RLS, SECURITY DEFINER functions, triggers, storage policies), PostgREST (custom `PTnnn` error codes), Storage, Management API for DDL |
| Tooling | Git / GitHub (main + `fix` remote), Flutter CLI (analyze, test, build web/apk), Python helper scripts, in-app browser for checks |

## Log

| # | Entry | What was done | Stack |
|---|---|---|---|
| 1 | Admin sign-in | Added admin sign-in to the admin app and `is_admin()` policies, so the admin queue loads for a signed-in admin instead of an empty anon view. | Flutter, Supabase RLS |
| 2 | Admin role incident repair | Restored the Admin role lost through accidental approvals; added a migration that stops an approval replacing an Admin's role. | Postgres, SQL migration |
| 3 | Make a user an admin | Promoted the requested user to Admin on Dev. | Supabase |
| 4 | Dev-only rule and migrations | Applied the pending migrations to Dev (`csbmvjcxpsmjjmzuwujz`) and checked every repo migration is recorded; production left untouched. | Supabase Management API, SQL |
| 5 | Private applicant documents | Found that private documents were readable by anon; made the `get_involved_documents` bucket private with a storage migration. | Supabase Storage, policies |
| 6 | Wallet investigation and fix | Explained how each wallet is calculated, turned the wealth credit back on and backfilled missing funds; applied the wallet action rules migration. | Postgres, SQL |
| 7 | Review pipeline (database) | Idempotent approve/reject RPCs with audit entries, applicant notifications and reconciliation functions. | Postgres RPCs, triggers |
| 8 | Admin review screens | Get Involved and partner-application screens with document viewing and audited review. | Flutter (admin), Supabase |
| 9 | Verdict validation | Read-back checks after each verdict, friendly error messages, and a Users screen showing account type and referral code. | Flutter, flutter_test |
| 10 | Notifications | Applicants are notified of approval or decline, with a status link that opens the live application status. | Flutter (customer), Supabase |
| 11 | Kasipromoter rule | Added `becomeKasipromoter` and an eligibility check. | Flutter, Supabase RPCs |
| 12 | Customer-app fixes | Back arrows, clipped-text and overflow fixes, PT error messages passed through to the user. | Flutter |
| 13 | Admin overflow fixes | Removed layout overflow in the admin screens and added a no-overflow test. | Flutter, flutter_test |
| 14 | Repo sync and pushes | Pushed customer and admin code to their repos (admin to the `fix` remote), merged and pulled main, kept the repos in sync. | Git, GitHub |
| 15 | Test runs | Ran the admin and customer test suites and analyzers on the repo versions (admin 123 tests passing). | flutter test, flutter analyze |
| 16 | Builds | Built and served the customer web app against Dev and ran the admin and Ops apps as dev servers. | Flutter web, flutter run |
| 17 | Raymond Reddington diagnosis | Found his approval predated the Corporate upgrade rule, which led to the switch-profile design instead of a role change. | Supabase queries |
| 18 | Switch Profile: database | Migration `20261109160000`: individual role memory, availability check, `get_profile_switch_state`, `switch_profile`; approval now only unlocks the business profile. Tested in rolled-back runs. | Postgres, SQL |
| 19 | Switch Profile: app | Data layer plus a Switch Profile screen and a menu tile shown only after approval; business mode follows the Corporate rules; approval wording updated. | Flutter, flutter_bloc, auto_route |
| 20 | Follow-up fixes and checks | Admin approval check and dialog text updated; menu re-checks Switch Profile per account and retries; Mefavey 882 diagnosed on Dev; Dev APK could not be built here (no Android SDK), so it is built on another machine. | Flutter, Supabase, Git |

## Open items

- Revoke the Supabase access token that was pasted into the chat.
- Build the APK from commit `f125fca` or newer (it points at Dev by default).
- The admin Users screen does not yet show which profile is active.
- A leaked service key sits commented out in the admin repo history and should be rotated.
