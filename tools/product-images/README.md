# Product images

Links product photos to `inventory.product` and stores them in the public
`inventory` Supabase Storage bucket (under `products/`).

The photo files are large and are **not** kept in git. Keep the folder of
photos outside the repo.

## Run

Both scripts need only Python 3 (standard library) and these environment
variables. Use the project's service key and keep it out of the repo.

```
SUPABASE_URL=https://<project-ref>.supabase.co
SUPABASE_SERVICE_KEY=<service_role key>
```

1. Match photos to products (read-only, writes `match.json` and `needs_review.csv`):

   ```
   python match_images.py --images <photo folder> --out <output folder>
   ```

2. Review `needs_review.csv`: products with no photo, or only a low-confidence
   suggestion. Only matches scoring 0.8 or higher are linked automatically.

3. Upload and link (Dev first, then Production):

   ```
   python upload_images.py --images <photo folder> --match <output folder>/match.json
   ```

## How matching works

- Word order is ignored ("Ace Banana Instant Porridge" matches "Ace Instant Porridge Banana").
- Sizes must match exactly (`1kg`, `250ml`, `20s`), with `2,5kg` and `2.5kg` treated alike.
- A trailing multipack suffix (`x10`) is ignored, so multipacks reuse the single-unit photo.
- Several equally good candidates are treated as ambiguous and left for review.
- A generic photo can still be linked to a product with an extra variant word
  (for example a product name with "Fortigrow" using the plain product photo).

## Windows note

Run these from a short path such as `C:\pimg`. The photo file names are long
and Windows rejects paths over 260 characters.
