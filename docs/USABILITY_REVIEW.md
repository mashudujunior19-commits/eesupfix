# TOWRIS usability review (customer app and admin app)

Date: 2026-11-21 · Customer app build 16.6.47+247 · Admin app `eesup_admin` (feat/kasipool-live-orders-timeline)

Nothing was changed to write this. It is based on:

- **Using the customer app**: release web build, signed in as a KasiPool admin on the Dev project, at a small-phone width (284 px) and at 414 px. Home, product page, cart, notifications, menu, wallets, My Economy, a KasiPool, its order page and order tracking. No order, payment, payout or sign-up was submitted.
- **Reading the code of both apps** for every main flow (checkout, sign-up, KasiPools, wallets, tracking, admin screens), with file and line references.
- **The earlier audit** in `docs/audit/` (it covers correctness and security; this document covers ease of use).

Not covered: a real Android phone (device back button, push, camera, slow 3G), screen readers, and people who are not staff. A 30-minute test with 5 real customers on their own phones would find more than this document.

Paths: customer app paths are relative to `packages/ui/lib/src/` in `eesup-bloc-codebase`; admin paths are relative to `lib/` in `eesup-admin-fix`.

---

## 1. Honest verdict

**Customer app: usable for someone who is shown how, hard to work out alone.** The look is clean and consistent, the core shop → cart → checkout path works in about 8 taps, order tracking is 2 taps, and the newer KasiPool pieces (timeline, roles, packer checklist, pending earnings) explain themselves well. But:

- several things **silently do the wrong thing** (choosing delivery is ignored; a failed order throws away your checkout choices; Back after an order never leaves the app);
- the **most important actions are hidden or vague** (no clear "Add to cart" on the product page, joining a KasiPool is 5–6 taps and needs the pool's name, withdrawing money is behind a "Transact" pop-up);
- it is **heavy for low-end phones on prepaid data** (a ~5-second intro on every start, a 968 KB logo, six home requests one after another, 500 orders loaded when the screen says "Show 10");
- **words are inconsistent and full of jargon** (KasiPool / Kasipool / Kasi Pool, "My Economy" holding your orders, CIA/CWA/EIA/DAA, "privilages", "proccessing");
- it is **English only** with **9–10 pt text** in the main navigation.

Rough score for a first-time shopper on a cheap Android phone: **5.5 / 10**. Most of the fixes are small; the top 10 below would move it to about 8.

**Admin app: functional for the person who built it, risky for anyone else.** The Get Involved / application review screens are good (search, filters, confirm dialogs, reasons). The rest is a set of raw tables: the **Dashboard shows invented numbers**, several **delete and payout-approve buttons act on one click**, lists need a refresh button before showing anything, and many buttons do nothing. Score: **4 / 10** for day-to-day ops staff.

---

## 2. What already works well (keep it)

1. **Errors are mostly translated into plain words.** `packages/data/lib/utils/eesup_exception.dart` turns network, auth and database errors into readable messages, and the database's own rule messages ("An order can only close once it reaches R10000…") reach the user as written.
2. **Rules are explained where you hit them**: the disabled "Close order" says why, checkout explains why there is no KasiPool to pick, the wallet explains when pending money becomes usable.
3. **The packer checklist and the new PIN screens give instant feedback** and roll back cleanly on failure; the Dispatcher's PIN screen tells them exactly what to ask the customer.
4. **A reusable "Are you sure?" dialog with red destructive styling exists** (`core/extensions/context_alerts_ext.dart:21`) and is used well for removing receivers and transfers. In the admin app, approving or declining applications has proper confirm and reason dialogs.
5. **Visual consistency**: one green brand colour, rounded cards, clear empty states on the main lists ("Your cart is empty. Start shopping now!"), wallet history that says where every rand came from.

---

## 3. Top 10 fixes (do these first)

| # | Problem (what the user experiences) | Where | Fix | Effort |
|---|---|---|---|---|
| 1 | **Choosing "Yes" to delivery is ignored.** The dialog never returns the answer, so every order becomes a collection, even after the customer chose delivery. | `views/shop/checkout/ui/steps/collection_step.dart:247-270`, `core/extensions/context_alerts_ext.dart:84-99` (`Navigator.pop(context)` with no value) | Pop `true`/`false` from the dialog (or use `confirmAction`) and show "Delivery" or "Collection" on the Summary step. | 1 hour |
| 2 | **Product page has no "Add to cart" button**, only a small basket icon that is easy to confuse with "save to my basket list". Cards also show two similar icons (basket and cart). | `views/shop/browsing/` product view and `product_card.dart` | One big "Add to cart" button with a quantity stepper on the product page; one cart icon on cards. Show the cash-back ("You get R2.40 back") on the product page too. | Half a day |
| 3 | **After an order, Back never leaves the app and the screen stack grows**; Back from Home after sign-up returns to the sign-up form. Each extra Home re-shows the ID and address pop-ups. | `results_step.dart:87`, `checkout_screen.dart:55`, `auth/register/ui/register_screen.dart:55` (`pushAll`) | Use `replaceAll([const OverviewRoute()])` as sign-in already does (`sign_in_screen.dart:104`). | 30 min |
| 4 | **A failed order sends you back to step 1** and loses the address, pickup point and payment choice; a failed payment shows only an animation and "Finish", no reason and no retry. | `summary_step.dart:28-31`, `results_step.dart:30-53` | Stay on Summary, show the reason inline with "Try again"; on the result page show the reason, "Try payment again" and "Back to cart". | Half a day |
| 5 | **After a successful order there is no order number, pickup point or "Track order"**; the app jumps Home after 1.8 s. | `results_step.dart:61-88` | Show "Order #123 placed", where and when to collect, and buttons "Track order" / "Back to shop". No auto-jump. | 2 hours |
| 6 | **Error screens have no "Try again"**, the text is small and 40% transparent, and almost nothing supports pull-to-refresh. A failed Home load leaves a dead screen until the app is killed. | `core/widgets/fullscreen_error_widget.dart:58-77` (used ~120 times), `views/overview/ui/overview_tab.dart:61-64` | Add an `onRetry` button and full-opacity text; add pull-to-refresh to Home, My Orders, wallets and pool orders. | Half a day |
| 7 | **Checkout and sign-up steps can be skipped by swiping, and the phone's Back button throws away the whole form.** | `checkout_screen.dart:106` (TabBarView without `physics`), `register_screen.dart:71-79` | `physics: NeverScrollableScrollPhysics()`; `PopScope` that goes back one step. | 1 hour |
| 8 | **Slow, data-hungry start**: the intro video + logo (~5 s) plays on every start even when signed in; `logo.svg` is 968 KB; the Poppins font is downloaded at runtime; Home makes 6 requests one after another (one is never shown, one banner is fetched twice); My Orders loads 500 orders while the filter says "Show 10". | `views/auth/sign_in/ui/start_up_screen.dart:32-38`, `overview_tab.dart:47`, `core/themes/text_theme.dart:24`, `views/overview/bloc/overview_bloc.dart:94-121`, `views/orders/listing/ui/orders_tab.dart:27` | Intro only on first launch; optimise the logo; bundle the font; `Future.wait` the home calls and drop the unused one; load 20 orders at a time. | 1 day |
| 9 | **The cart is lost when the phone kills the app** (common on low-end phones, e.g. while switching to a banking app to pay). | `views/shop/cart/bloc/cart_bloc.dart:17` | Save the cart to `shared_preferences` (already a dependency) or use HydratedBloc. | 2 hours |
| 10 | **Admin Dashboard shows invented numbers** (150 users, 23 warehouse orders, a hard-coded name, sample rows) and a search box connected to nothing; **delete KasiPool / hamper / survey / warehouse and "approve payout" act on one click**. | admin `views/dashboard/ui/dashboard.dart:11-15, 39, 55-70, 192-235`; `views/kasipools/ui/kasipools.dart:186-192`; `views/hampers/ui/hamper_page.dart:155-162`; `views/surveys/ui/survey_list.dart:150-155`; `views/warehousing/orders/ui/warehouses.dart:51-53`; `views/financials/payouts/ui/payout_request.dart:67-73` | Replace the dashboard with real counts or a "Pending work" page (payouts, applications, open pool orders). Add a confirm dialog naming the item/amount to every delete and payout approval (copy the pattern in `views/applications/ui/partner_app.dart:63-82`). | 1 day |

---

## 4. Customer app: all findings

### High
- **Delivery choice ignored** (top 10 #1).
- **No clear Add to cart** (top 10 #2). Seen live: the product page shows image, name, price, a small basket icon and "People also liked". Products without a photo show a grey "!" instead of a placeholder image; product names show data typos like `Nando"s`.
- **Back-button traps and growing stack** (#3), **swipe-skippable steps** (#7).
- **Failed order loses choices; no next steps after success** (#4, #5).
- **No Retry on errors** (#6). Also: the pool screen goes **blank with no back button** if it fails to load (`views/eesupools/ui/eesupool_view_screen.dart:48-71`).
- **Joining a KasiPool is hard to discover**: Menu → My Community → Search → type a name or code → (View Streets) → small "Join Kasi Pool" link, and the search screen is empty until you type (`views/eesupools/ui/eesupool_search_screen.dart:176-186, 414-440`). After sending a request the card still says "Join" (`:346-353`). The empty My Community list says only "Oops!! nothing to show here". **Fix:** show nearby pools by default from the primary address, a real "Join" button that turns into a "Requested" chip, and a "Find a KasiPool" button on every empty state and on the checkout "not a member" message (`collection_step.dart:173`).
- **Ordinary pool members get an ORDERS tab that is a dead end** ("Only the KasiPool owner can view the pool order", after loading 500 orders) (`views/eesupools/ui/tabs/orders/ui/orders_tab.dart:25-41`). **Fix:** hide it, or show the member's own orders in that pool with "Shop for this pool".
- **Withdrawing money**: 5 taps (Menu → My Wallet → wallet → "Transact" → "Request payout"); bank, account type and branch code are free text; Submit sends with no review; typos "submited", "proccessed" (`views/finances/wallets/ui/screens/payout_screen.dart:50-138`). **Fix:** visible "Withdraw" and "Transfer" buttons on the wallet; bank dropdown that fills the universal branch code; Savings/Cheque selector; confirm sheet with amount, bank and last 4 digits.
- **Up to three pop-ups stack on every Home open** (RSA ID, primary address, one per new role) (`views/overview/ui/overview_screen.dart:61-170`, `views/role_assignments/ui/role_assigned_popup.dart:43-80`). **Fix:** one prompt per session; move ID/address reminders to a dismissible banner.
- **Buttons that do nothing**: "Open an issue" (`views/orders/tracking/ui/review_products_screen.dart:97`, and its dialog traps the back arrow), "Verify email" (`views/auth/profile/ui/edit_profile_screen.dart:228`), "Restrict Member" (`views/eesupools/ui/tabs/members/ui/member_settings.dart:152`). **Fix:** wire them up (an issue screen already exists) or hide them.
- **Slow start / data use** (#8) and **lost cart** (#9). The Menu tab also creates a new profile loader on every rebuild and flashes a full-screen shimmer (`views/menu/menu_tab.dart:141-143`); seen live: Menu sat on its placeholder for ~10 s.

### Medium
- **Tiny text and capped text size**: bottom navigation labels are 9 pt (`views/overview/ui/widgets/bottom_tab_bar.dart:29`), menu tiles 9.5 pt (`views/menu/menu_tab.dart:390`), pool member sub-tabs 9 pt light grey; 39 places use < 12 pt; the phone's text-size setting is capped at 1.2× (`app.dart:291-294`). **Fix:** at least 12 pt (14 pt for navigation), allow up to 1.5×–2×.
- **Small tap targets and unlabelled icons**: quantity +/– are 30×30, only 7 of 42 icon buttons have tooltips, address delete is 18 px, the collection tab bar is 26 px tall (`views/shop/browsing/ui/product_card.dart:248-300`, `views/geolocation/ui/widgets/address_card.dart:164-180`, `collection_step.dart:204-217`). **Fix:** 48×48 minimum, tooltip/semantic label on every icon.
- **No confirmation** for Clear cart, Delete address (even the verified primary one) and Sign out (`views/shop/cart/ui/cart_screen.dart:63-67`, `address_card.dart:166-173`, `menu_tab.dart:302-310`). Use the existing `confirmAction`.
- **Checkout Summary does not show what or where**: only payment method, subtotal, delivery fee and total; placeholder "No selected"; "Place order" can be double-tapped (`summary_step.dart:102-152`). A newly added address is not auto-selected (`address_selection_step.dart:49`). **Fix:** item count, address/pickup rows with "Change", disable the button while placing.
- **R200 minimum only appears after tapping Checkout** (`cart_screen.dart:145-150`). **Fix:** a progress line above the button: "R46.99 of R200 – add R153.01 more".
- **Collection PIN needs data at the pickup point** and is invisible while loading (`views/orders/tracking/ui/collection_pin_widgets.dart:67, 100`). **Fix:** loading placeholder + Retry; keep the last fetched PIN in secure storage so it shows offline. (This is from the new PIN feature.)
- **Naming and jargon**: KasiPool / Kasipool / Kasi Pool / Kasipools; Kasipreneur / KasiPreneur; "MYKASI TREE"; "MyBaskets" next to "My Wallet"; the bottom tab "**My Economy**" actually holds **orders** and **role jobs**; the cash-back explanation ("These are amounts are what you will get back… Customer income allocation…") only appears on long-press (`product_card.dart:127-131`); typos "privilages", "proccessing", "submited"; "Oops!!", "Insufficient funds!!!". **Fix:** a one-page glossary (KasiPool, Kasipreneur, Packer, Dispatcher, Receiver, Cash back) used everywhere; rename the tab to "Orders"; plain "You get R2.40 back" with a tap-to-explain sheet; fix the typos.
- **Sign-up validation** is one 7-second snackbar at a time; optional fields (referral code) are not marked; "I am a South African citizen?" (`views/auth/register/ui/individual_form.dart:76, 159-191`). **Fix:** inline field errors, "(optional)" labels.
- **English only** (no localisation set up). **Fix:** move strings to ARB files and start with isiZulu, Sesotho and Setswana for shop, checkout and PIN screens.
- **Home content** (seen live): the same "Weekly hamper pricing review in progress" banner appears twice and sounds like an internal status note; the referral-code box sits above the products; "Popular" is actually random products (`overview_tab.dart:192`). **Fix:** one banner with a customer message, referral below the products, rename "Popular" or back it with real data.
- **Notifications open fully expanded** with truncated titles, so only 2–3 fit on screen and there is no "mark all read" (seen live). **Fix:** collapsed by default, full title, "Mark all as read".
- **Pending earnings colour**: pending money is red (as requested for the KasiPool earnings). Red usually means "error / money lost"; consider amber with the word "Pending" if customers find it alarming. "Commit" on the wallet looks disabled but is tappable and then errors (`wallet_view_screen.dart:315-330`).
- **A raw technical message can reach users**: "Failed to fetch wallet balance: $e" (`packages/data/lib/finance/repository/wallets_repository.dart:180`).

### Low
- Hamper view from the Home banner can sit on a shimmer forever (`views/shop/hampers/ui/hamper_view.dart:132`); Kasipreneurs collection tab and Product Requests list have no empty-state text (also in `docs/audit`).
- The pickup-point address card does nothing on tap; open it in Maps (`views/eesupools/ui/tabs/orders/ui/order_details_tab.dart:387`).
- The snackbar "Ok" does nothing (`core/widgets/snack_bar.dart:40`); "Welcome!! 🎉🎉🎉" tone.
- Flutter web exposes nothing to screen readers unless semantics are enabled; matters only if the web build is used by customers.

---

## 5. Admin app: all findings

### High
- **Fake dashboard** and **one-click destructive / payout actions** (top 10 #10).
- **Payout table cannot be used for real payments**: no vertical scroll, raw `DateTime` text, no customer name, no Pending/Approved filter, no total, account numbers not selectable or copyable (so they must be retyped into the bank portal) (`views/financials/payouts/ui/payout_request.dart:35-56`). **Fix:** paginated table, formatted dates, Pending filter by default, name column, `SelectableText` or copy icons, Decline with reason.
- **KasiPools page is empty until you press refresh**, shows at most 30 pools with no search, and turns every error into "No data available" or a raw `'Failed to delete eesupool: $e'` (`main.dart:82-84`, `repository/kasipools/data_source/kasipool_supabase_impl.dart:16-25`, `views/kasipools/bloc/kasipool_bloc.dart`). **Fix:** load on open, name search, pagination, friendly errors. (The KasiPool *orders* screen was rebuilt in the KasiPool work and now loads live.)

### Medium
- **Navigation**: Surveys and FAQs share one icon and labels disappear below 700 px; "Upload Screen", "PayOut Request"; Applications (partner/vendor approvals) is hidden as a button inside Surveys; "Survey Answers" opens Create Survey; every page reloads and loses its filters when you switch (`main.dart:135-248`, `views/surveys/ui/survey_list.dart:56-77`). **Fix:** own menu item for Applications, distinct icons, plain labels ("Products", "Payouts"), keep pages alive with an `IndexedStack`.
- **Orders page**: three stacked title bars, search by exact numeric ID only with no way back to "all", customer shown as a UUID, value as a raw number, no tooltip on the tickets icon, no limit on loading, debug `print` calls left in (99 in the app) (`views/orders/ui/orders.dart:24-163`). **Fix:** one title bar, search by name/phone/ID with clear, customer name, "R x.xx", pagination, remove prints.
- **Warehousing**: "Add Warehouse", Edit and Delete do nothing; customer secret PINs are shown in plain text to every admin; "Recieve Order" typo (`views/warehousing/orders/ui/warehouses.dart:43-49, 99, 185`, `warehouse_orders.dart:106-170`). **Fix:** hide unfinished actions, mask PINs behind "Show".

### Low
- Hamper allocation fields use bare codes (CWA, EIA, CRC, CSA, DAA) and Create rounds differently from Edit, so one hamper can show two amounts (`views/hampers/ui/create_hamper.dart:332-340`, `update_hamper.dart:440-452`). **Fix:** spell the codes out with a help icon; one rounding helper.

---

## 6. How many taps the main jobs take today

| Job | Taps today | Target |
|---|---|---|
| Shop and check out | ~8 (Home → product → cart → Checkout → address → pickup → payment → Place order) | 6–7, with no way to skip a step |
| Join a KasiPool | 5–6 + typing a name you must already know | 3 (Home card "KasiPools near you" → pool → Join) |
| Place a KasiPool order | via normal checkout, Collection → Kasipools tab | same, plus "Shop for this pool" from the pool |
| Track an order | 2 (My Economy → order) | 2, and from the success screen |
| See my collection PIN | 2 + scroll + "Show" | 1 from the "PIN ready" notification (now added) |
| Withdraw money | 5 (Menu → My Wallet → wallet → Transact → Request payout) | 3 with a visible "Withdraw" button |
| Packer / Dispatcher work | 2–3 (pop-up or My Economy → Role Assigned Orders) | fine |
| Pool admin approves a join request | 5 (Menu → My Community → pool → Members → Requests) | 2 from the notification (Accept is already on the notification) |

---

## 7. Suggested plan

1. **This week (about 2 days)**: top 10 items 1, 3, 5, 6, 7 and the confirm dialogs (customer and admin). These remove the silent failures and traps.
2. **Next (about 1 week)**: Add-to-cart and product page, checkout failure handling and summary, KasiPool discovery and Join button, Withdraw button and payout form, start-up speed and data use, saved cart, admin payouts table and dashboard.
3. **Then**: text size and tap targets, glossary and copy clean-up, one pop-up per session, admin navigation, isiZulu / Sesotho / Setswana.
4. **Test with real users**: 5 customers and 2 pool admins on their own phones, one task each (buy something, join a pool, collect with a PIN, withdraw), watched without helping. Repeat after each round of fixes.
