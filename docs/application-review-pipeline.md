# Application review pipeline (main app -> admin -> verdict -> notification)

Applies to the four programmes, which already exist as `services.partner` rows:

| In the app | `partner_id` |
|---|---|
| Kasipreneur | `eesupreneur` |
| Kasi Spaza | `kasi_spaza` |
| Become a Vendor | `service_listing` |
| EESUplift (corporate) | `eesup_lift_corp` |

"Get Involved" is the sheet that lists these (plus business registration and KasiLift upgrade); it is not an application type of its own.

## 1. Summary

- One backend: the existing Supabase (Postgres) project. Both apps already talk to it, so there is no second API or webhook hop to keep in sync.
- Applications live in `services.partner_application`; status is derived (`pending` / `approved` / `declined`) and can only move pending -> approved or pending -> declined.
- The admin verdict is one server call, `services.review_partner_application`, which checks the caller, enforces the transition, requires a reason to decline, writes an audit row and updates the application in a single transaction.
- The verdict notification is created by a trigger in that same transaction, so it cannot be lost. The app reads it whenever it next opens; push is sent on top (existing `notify` edge function).
- Admin queue refreshes by polling every 30 s (simple, no inbound endpoint, fine for a review queue). Realtime is the upgrade path.
- Found and fixed: the old notification trigger was `FOR EACH STATEMENT`, so verdict notifications were never created; the old approve/reject was a bare `UPDATE`, repeatable and reversible; and any signed-in user could update (approve) any application.

## 2. Architecture

```
Main app --create_new_partner_application (RPC, RLS: own rows only)--> services.partner_application
                                                                          |  status = pending
Admin app --list (service key)--------------------------------------------+
Admin app --review_partner_application(id, approve|decline, reason)------> same transaction:
                                                                            1. check caller (admin / service role)
                                                                            2. lock row, enforce pending -> terminal
                                                                            3. update approved_at/rejected_at, reviewed_by/at, decline_reason
                                                                            4. insert partner_application_audit
                                                                            5. trigger inserts engagements.notification (data = application id, status, reason)
                                                                            6. notification insert trigger -> push edge function
Main app <-- notifications list / push; "my applications" reads own rows (status + reason)
```

## 3. API contract (Supabase RPC / PostgREST)

| Call | Role | Body | Success | Errors |
|---|---|---|---|---|
| `rpc services.create_new_partner_application(_user_id,_partner_id)` | applicant (own id only) | partner id | application id (returns the existing pending one if repeated; `0` if role not allowed) | `FORBIDDEN` (other user id), `DUPLICATE_PENDING`, eligibility message |
| `GET services.partner_application` (select) | applicant: own rows; admin: all (service key) | filters: `status`, `partner_id`, `created_at` | rows incl. `status`, `decline_reason`, `reviewed_at` | RLS hides others' rows |
| `rpc services.review_partner_application(_application_id,_decision,_reason,_admin_id)` | admin / service role | `_decision` approve\|decline; `_reason` required to decline (5-500 chars) | `{application_id,status,reviewed_at,already_applied}` | `FORBIDDEN` 42501, `NOT_FOUND` P0002, `INVALID_DECISION` 22023, `REASON_REQUIRED` 22023, `REASON_TOO_LONG` 22023, `INVALID_TRANSITION` 23514 |
| `GET engagements.notification` | applicant (own) | - | title, body, `data{kind,application_id,partner_id,application_type,status,reason,decided_at}` | - |
| mark read | applicant | `seen_at` | existing behaviour | - |

Same verdict twice is a no-op (`already_applied = true`, no second notification or audit row).

## 4. Data model and state machine

`partner_application`: `id`, `user_id`, `partner_id`, `survey_responses`, `created_at`, `approved_at`, `rejected_at`, plus new `decline_reason`, `reviewed_by`, `reviewed_at`, and generated `status`.
`partner_application_audit`: `application_id`, `admin_id`, `action`, `from_status`, `to_status`, `reason`, `created_at` (no user access).
`engagements.notification`: existing table; verdict rows use `type='other'`, `data.kind='partner_application'`.

```
pending --approve--> approved   (terminal)
pending --decline--> declined   (terminal; reason required)
```

## 5. Validation matrix

| Field / rule | Client (apps) | Server | Admin side | Message |
|---|---|---|---|---|
| Eligibility (Spaza needs Kasipreneur; Kasipreneur needs public pool admin > 25) | checked on tap | trigger on insert | - | the eligibility reason |
| Applying for someone else | - | RLS + RPC check | - | `FORBIDDEN: you can only apply for yourself` |
| Second pending application, same programme | - | idempotent create + trigger | - | existing one is reused / `DUPLICATE_PENDING` |
| Edit answers after a verdict | - | RLS: pending rows only | - | row not updatable |
| Change approved_at / rejected_at / reason | - | guard trigger (users) | - | `FORBIDDEN` |
| Who may review | - | RPC: admin profile or service role | - | `FORBIDDEN: only an admin can review` |
| Only pending can be actioned | - | RPC row lock | buttons disabled | `INVALID_TRANSITION` |
| Decline reason 5-500 chars | - | RPC | dialog | `REASON_REQUIRED` / `REASON_TOO_LONG` |
| Decision value | - | RPC | fixed buttons | `INVALID_DECISION` |
| Repeat verdict | - | idempotent | confirmation dialog | no-op |

Reasons are stored as typed and shown in the main app as plain text (Flutter `Text` does not interpret markup), so they are not an injection risk there.

## 6. Notification reliability

- Outbox by construction: the notification row is written in the verdict transaction. If the transaction fails nothing is sent; if it commits the notification exists whether or not the phone is online.
- The app lists notifications from the database on open; push (edge function on insert) is best-effort on top.
- Retry: if the push webhook fails, the in-app notification still exists. A background retry of push is a possible later addition.

## 7. Admin app integration points (`eesup_admin`)

- `repository/applications`: `approveApplication(id)` / `rejectApplication(id, reason)` now call the review RPC and return an error message or null; model gains `status`, `declineReason`, `reviewedAt`, type labels.
- `views/applications`: filters (status, type), status badge, approve confirmation, decline dialog with required reason, reviewed history, 30 s auto-refresh, errors shown as messages. Delete was removed from the screen so history is kept.

## 8. Main app integration points

- `PartnerApplication` model: `rejected_at`, `decline_reason`, `isApproved/isDeclined/isPending`, `statusLabel`.
- `partner_apps_screen.dart` / `edit_application.dart`: Pending / Approved / Declined badge, decline reason shown.
- Notifications screen already shows title and body; the body carries the programme, application id, verdict and reason.

## 9. Plan (as delivered)

1. Intake hardening: own-rows access, duplicate protection, status column.
2. Review RPC + audit + transition rules.
3. Verdict notification (trigger fixed, includes reason).
4. Admin screen; main app status + reason.
5. Admin sign-in and read access: done. Still to do: deep link from the notification to the application; push retry.

## 10. Acceptance checklist

- [x] New submission appears in the admin queue (poll, 30 s).
- [x] Approve works; second approve is a no-op.
- [x] Decline requires a reason; reason is stored and shown to the applicant.
- [x] Approved -> declined (or the reverse) is refused.
- [x] Applicant cannot approve their own application or see others'.
- [x] Verdict notification created in the same transaction (tested on Dev, rolled back).
- [x] Admin tests: queue, history, confirm, reason validation, server refusal.
- [ ] Notification tap opens the application (not built).
- [x] Verified end to end on Dev in the browser: apply, admin decline with reason, notification and Declined status in the app, admin approve.
- [ ] Verified on a physical device.

## Admin access

The admin app signs in with a real admin account (email + password). After sign-in it checks the account's profile role is `Admin`, and the database enforces the same: `public.is_admin()` lets an Admin read all applications and the audit log, and `review_partner_application` only runs for an Admin (or a service key). Everyone else sees only their own rows, and signed-out visitors see nothing. The review is recorded under the admin's own id.

The app's active key is the project's anonymous key, which is public by design; what the user can do comes from the signed-in account, not the key. All screens share one signed-in session (`lib/supabase_client.dart`).

## Findings still open

- `lib/env.dart` in the admin app contains a commented-out **production service-role key**. It sits in the repository history, so rotate that key.
- `public.profile` is readable by anyone, signed in or not (ID numbers, phone numbers). It needs restricting, carefully, because the main app reads profiles.
- `engagements.notification` still allows any signed-in user to insert a notification for someone else, because four functions that notify other users run with the caller's rights. Make them `SECURITY DEFINER`, then restrict inserts.
- The admin session is not saved, so an admin signs in again after a page reload.
