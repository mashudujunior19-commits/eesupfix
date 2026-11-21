# Hampers: how they work today and how to improve them

Scope: the customer app (`packages/ui`, `packages/data`), the database
(`supabase/migrations`) and the admin app (`eesup_admin`, hamper pages). Based
on reading the code at commit `82e7a44`. Nothing was run against Dev, so
anything about live data is marked "not checked".

## 1. Short answer

Yes, hampers are implemented end to end: an admin builds a hamper, it appears
as a Home banner and in a Hampers list, a customer can open it, see what is
inside and add it to the cart. It works, but it is a first version. The
customer screens are plain, the data loading is slow and fragile, and the
customer can see internal profit numbers and the hamper tables are open to
any signed-in user (section 4).

## 2. How it works today

### 2.1 Data model (database)

| Table | What it holds |
|---|---|
| `inventory.hamper` | `id`, `code` (the name, e.g. "H12"), `value` (price), `type`, `expiry_date`, `start_date`, `is_final`, `img_url`, `hamper_gif_url1/2`, `profit`, `profit_percentage`, `total_cost`, `total_sales`, `profit_allocation_id`, `user_role[]` |
| `inventory.hamper_product` | `hamper_id`, `product_id`, `quantity`, `is_free` |
| `engagements.banner` | Home banner content: image, two GIF overlays, order number |
| `inventory.profit_allocation` | percentages that split a hamper's value (CIA, CWA, EIA, CRC, CSA, DAA) |

How a hamper becomes buyable: when an admin sets `is_final = true`, a trigger
(`on_hamper_finalize` -> `append_banner_urls`) copies the image and GIFs to the
banner. A function, `public.move_hampers_to_product()`, inserts a normal
`product` row named "Hamper <code>" in category 38 with `hamper_id` set. That
product row is what actually goes in the cart and on the order. The hamper's
contents are looked up by `hamper_id`.

### 2.2 Customer app

| Piece | File | What it does |
|---|---|---|
| Entry point 1: Home banners | `overview_tab.dart`, `overview_banner_carousel.dart`, `hamper_stack.dart` | Two carousels (top and bottom) show hamper images with the code and price in red text, the GIF overlays and a "% Profit" label. Tapping opens the hamper page, looked up by image URL. |
| Entry point 2: Menu | `menu_tab.dart:280` | "Hampers" opens the list. |
| List | `hamper_list.dart` | A plain list: code, "Type: x | Expires on: date", an arrow. No image, price or contents. |
| Detail page | `hamper_view.dart` | Header (code, type, value, expiry, image with GIFs), then two tabs: **Products** (each product with image, price, quantity, "Free" tag) and **Allocations**. Two app-bar buttons: add every product to a basket, and add the hamper to the cart. |
| State | `hamper_bloc.dart` | One bloc with eight events. |
| Cart match | `compare_hamper_to_cart.dart`, `cart_bloc.dart:110` | `CompareCartWithHampers` checks whether the cart matches a hamper exactly. The only result handling in the cart screen is the loading and error states; the old UI that used the result is commented out. |

Filtering in `fetchHampers` (`shopping_supabase_impl.dart:363`): only
`is_final = true` and not expired, newest first.

## 3. What is good

- The full journey exists: build, publish, browse, view contents, buy.
- Contents are shown with product images, prices and quantities, and free items are marked.
- Expired and non-final hampers are hidden from the list.
- Admin side has create, edit, copy and profit allocation.

## 4. Problems found

Ordered by importance.

### 4.1 Security and trust

1. **Any signed-in user can create, change and read hampers.** The policies on
   `inventory.hamper` and `inventory.hamper_product` allow `INSERT`, `UPDATE`
   and `SELECT` to every `authenticated` user (`20260205173025_remote_schema.sql:8100-8120`).
   A customer could change a hamper's price or contents with a direct API
   call. Note that the price is read from the `product` row, so the exposure
   is hamper contents, expiry and the profit fields, but it still should not
   be open. Whether the live Dev/Prod policies still match this file is not checked.
2. **Customers can see internal money fields.** The Allocations tab shows
   "Income Allocation", "Wealth Allocation", "Distribution Admin Allocation"
   and "Customer Referral Commission" in rands, and the banner shows
   "% Profit". `select('*')` also returns `profit`, `total_cost` and
   `total_sales` to the app. A customer should see price, contents and
   savings, not the company's profit split.
3. **`user_role` is not enforced.** Each hamper has the roles it is meant for,
   and the banner function returns them, but `fetchHampers` and the banner
   never filter by the user's role. A hamper meant for KasiPreneurs is shown
   to everyone.

### 4.2 Correctness and reliability

4. **Errors are hidden, so the page can sit on a shimmer forever.** Almost
   every data call catches all errors and returns an empty list (`fetchHampers`,
   `fetchHamperProducts`, `fetchHamperProductDetails`). The detail page only
   renders when all four loads finish (`hamper`, `products`, `hamper product`,
   `allocations`). If one returns nothing, the page just keeps loading. The
   usability review (`docs/USABILITY_REVIEW.md`) already lists this.
5. **Banner to hamper link is a text match on the image URL.** The banner
   function joins banner and hamper by comparing lower-cased image URLs with
   the query string removed, and the app finds the hamper again by image URL
   when you tap. Re-uploading or renaming an image, or two hampers sharing an
   image, breaks or mixes them up. The banner should store the `hamper_id`.
6. **Many round trips.** For a list of N hampers the app makes 2N extra
   queries (product IDs and quantities for each), and the detail page makes
   one query per product. This is slow on mobile data and gets worse as
   hampers grow. A single database function that returns the hamper with its
   items in one call fixes this. Some of this already exists
   (`inventory.get_hamper_details`, `get_hamper_product_details`) but is only
   used by the admin app.
7. **Stock is not checked.** Nothing tells the customer if an item inside the
   hamper is out of stock or inactive. Not verified whether checkout blocks it.
8. **Rounding differs between admin screens.** Create and Edit round the
   allocation amounts differently, so one hamper can show two amounts
   (also in the usability review). The customer view uses `floor()`.
9. **Duplicate code and debug output.** The cart match and hamper stack
   contain `print()` calls and large blocks of commented-out code. Two
   different ways of adding a hamper to the cart (stack and detail page),
   and the "add all to basket then ask about the cart" flow is confusing.

### 4.3 Design and usability

10. **The list is just text.** No picture, price, saving or "what is inside",
    so customers must open each hamper to learn anything.
11. **Home banner reads like an ad, not a product.** Red text over an image,
    no clear price badge or "Add" button; the cart icon only appears once a
    background lookup finishes.
12. **Two near-identical add buttons in the app bar** (basket icon and bag
    icon) with no labels. A customer cannot tell which one buys the hamper.
13. **The big tabbed block is a fixed 400 px tall box inside a scroll view**,
    so long hampers scroll inside a scroll, and the price is formatted
    differently in different places.
14. **No quantity picker, no "ends in", no sharing, no favourites.** Always
    quantity 1 (the cart can change it after).
15. **Expiry shown as a raw date**, not "ends in 3 days".
16. **No empty or error guidance.** "No hampers available" is the only
    message; nothing suggests what to do.
17. **Accessibility.** Images have no descriptions, free and price info rely
    on colour alone, small touch targets in the app bar.

## 5. How to improve

### Phase 1: make it safe and dependable (about 2-3 days)

| # | Change | Where |
|---|---|---|
| 1 | Restrict `hamper` and `hamper_product` writes to admins (`is_admin()`), keep read for customers | new migration |
| 2 | Add a customer-safe function `public.get_hampers(p_role)` returning only: id, name, price, image, expiry, items (name, image, qty, is_free), "you save" amount. No cost, profit or allocation | new migration + `shopping_supabase_impl.dart` |
| 3 | Filter by the user's role inside that function using `user_role` | same function |
| 4 | Replace the N+1 queries with that single call; one bloc state instead of four listeners | `hamper_bloc.dart`, `hamper_view.dart` |
| 5 | Show real error and retry states instead of an endless shimmer | `hamper_view.dart` |
| 6 | Store `hamper_id` on the banner; open the detail page by id, not image URL | migration, `overview_banner_carousel.dart` |
| 7 | Remove the Allocations tab and the "% Profit" label from the customer app (keep them in the admin app) | `hamper_view.dart`, `hamper_stack.dart` |

### Phase 2: modern, friendly screens (about 1 week)

**Hampers list**
- Card grid (two columns on phones) with a photo, name, price, a "Save R__" or
  "% off" chip, "Ends in 3 days" and a one-tap **Add**.
- Filter chips: All, Groceries, Family, Starter (from `type`); sort by price or ending soon.
- Pull to refresh, proper empty state with a link back to the shop.

**Hamper detail**
- Large photo header (swipe through the image and GIF overlays), name, price,
  strikethrough "worth R__ if bought separately" and the saving.
- "What's inside" as a clean list with item photo, quantity and a "Free" badge;
  a short summary line ("12 items, 4 free").
- One sticky bottom bar: price, quantity stepper and **Add to cart**. Remove
  the two unlabelled app-bar icons.
- "Customise" is a separate secondary action (the current "add all to basket")
  with clear wording: "Add items to a basket".
- Show an "Out of stock" or "Unavailable" note per item and block the add button when an item is out.
- Share button (link or WhatsApp message) and a favourite heart.

**Home banner**
- A single clear card: photo, name, price chip and **Add**; drop the
  red overlay text. Dots for position, auto-advance that pauses on touch.

**Cart**
- If the cart contents match a hamper, offer "Switch to hamper and save R__".
  (The cart match logic already exists; its UI was commented out.)

**Polish**
- Cached images (`cached_network_image` is already in the project) with
  placeholders, skeleton loaders, semantic labels, 48 px touch targets,
  light and dark theme, formatted rand amounts through one helper.

### Phase 3: growth features (later)

- Build-your-own hamper: pick items from an allowed list with a live price and saving.
- Hamper subscriptions or repeat orders (monthly groceries).
- Gift hampers: send to a phone number or address with a message.
- KasiPool group buying for hampers: pool members share one hamper order.
- Real sales numbers in the admin app: units sold per hamper, stock left,
  profit per sale, replacing the manual `total_sales` field.
- Notifications: new hamper, ending soon, back in stock.

## 6. Suggested order of work

1. Phase 1 items 1-3 (security, one migration) - do first.
2. Phase 1 items 4-7 (one reliable data call, error states, banner id).
3. Phase 2 list and detail screens.
4. Phase 2 home banner and cart suggestion.
5. Phase 3 as the business decides.

## 7. Not checked

- The live Dev and Prod database: policies, data and which hampers exist.
- Whether checkout reads the hamper's contents when fulfilling an order, or
  only treats the hamper as one product line. This decides how warehouse
  picking works and should be confirmed before changing the data model.
- How the admin app's create and copy flows set `user_role`.

## 8. Phase 1 status (built, not applied to Dev)

| # | Item | Status |
|---|---|---|
| 1 | Hamper tables admin-only | Done in `supabase/migrations/20261121100000_hamper_safe_access.sql` (policies replaced by `hamper_admin_all` and `hamper_product_admin_all`) |
| 2 | Customer-safe `public.get_hampers(_hamper_id)` | Done: price, image, expiry, items, worth, saving, availability. No cost, profit or allocation |
| 3 | Role filter | Done: `inventory.hamper_visible_to_caller()` (final, started, not expired, role in `user_role` or list empty; admins see all) |
| 4 | One call instead of N+1 | Done: `HamperOffer`, `HamperBloc` with `LoadHampers` / `LoadHamper`, repository `fetchHamperOffers` / `fetchHamperOffer` |
| 5 | Error and retry states | Done on list and detail; not-found state added; Home banner no longer crashes or spins when empty |
| 6 | Banner links by hamper id | Done: trigger writes `hamper_id`, existing entries backfilled, `get_hamper_banner_details` matches by id (URL only as fallback), duplicate banner entries on re-save prevented |
| 7 | No profit or allocations for customers | Done: Allocations tab, "% Profit" label and the profit allocation fetch removed from the customer app |

Also: unused old models and data calls removed, the cart "matches a hamper"
check now uses the same data, and the banner no longer makes its own queries.
Tests: `packages/ui/test/hampers/hamper_offer_test.dart` (13 tests); the full
`ui` suite passes (59).

Assumptions to confirm: "worth" counts every item at its own price including
free ones; the price shown is the hamper's product price (what the cart
charges), falling back to the hamper value; an empty `user_role` list means
"everyone".

Needs the migration applied on Dev before the app can load hampers: the app now
calls `get_hampers`, and direct reads of the hamper tables are blocked for
customers.

## 9. Phase 2 status (built and pushed, not applied to Dev)

| Item | Status |
|---|---|
| Hampers list as a two-column card grid, with price, "Save R__", "Ends in", one-tap **Add** | Done |
| Filter chips by type, sort (recommended, price, biggest saving, ending soon), pull to refresh, friendlier empty state | Done |
| Detail page: quantity stepper, total follows quantity, share, favourite heart | Done |
| Cart: "These items make up hamper X. Switch and save R__" (only when it saves money; hidden on any error) | Done |
| Cached images, 48 px touch targets, semantic labels | Already in place or added on new controls |
| Home banner "Add" button, swipe through GIF overlays, out-of-stock per item, dark theme | Not done |

Favourites are kept on the device only (`shared_preferences`), not in the database.
Tests: `hamper_browse_test.dart`; the full `ui` suite passes (64).
