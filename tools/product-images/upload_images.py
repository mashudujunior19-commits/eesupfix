"""Upload matched product photos to Supabase Storage and link them to products.

Usage:
  SUPABASE_URL=https://<ref>.supabase.co SUPABASE_SERVICE_KEY=... \
    python upload_images.py --images <folder> --match <match.json> [--min-score 0.8]

Uploads each unique file once to the public `inventory` bucket under products/,
then sets inventory.product.image_url for every product matched at or above
--min-score. Re-running is safe (uploads overwrite, links are re-set).
"""
import argparse
import hashlib
import json
import os
import re
import unicodedata
import urllib.request
from concurrent.futures import ThreadPoolExecutor

BUCKET = "inventory"


def storage_path(filename):
    base, ext = os.path.splitext(filename)
    ascii_name = unicodedata.normalize("NFKD", base).encode("ascii", "ignore").decode().lower()
    slug = re.sub(r"[^a-z0-9]+", "-", ascii_name).strip("-")[:80]
    return f"products/{slug}-{hashlib.md5(filename.encode()).hexdigest()[:6]}{ext.lower()}"


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--images", required=True)
    ap.add_argument("--match", required=True)
    ap.add_argument("--min-score", type=float, default=0.8)
    args = ap.parse_args()
    url, key = os.environ["SUPABASE_URL"].rstrip("/"), os.environ["SUPABASE_SERVICE_KEY"]
    auth = {"apikey": key, "Authorization": f"Bearer {key}"}

    selected = {int(i): v[0] for i, v in json.load(open(args.match)).items() if v[1] >= args.min_score}
    files = sorted(set(selected.values()))

    def upload(filename):
        with open(os.path.join(args.images, filename), "rb") as fh:
            data = fh.read()
        ctype = "image/jpeg" if filename.lower().endswith((".jpg", ".jpeg")) else "image/png"
        req = urllib.request.Request(
            f"{url}/storage/v1/object/{BUCKET}/{storage_path(filename)}",
            data=data,
            method="POST",
            headers={**auth, "Content-Type": ctype, "x-upsert": "true"},
        )
        for _ in range(3):
            try:
                urllib.request.urlopen(req, timeout=60).read()
                return filename, True
            except Exception:
                pass
        return filename, False

    with ThreadPoolExecutor(8) as pool:
        uploaded = {f for f, ok in pool.map(upload, files) if ok}
    print(f"uploaded {len(uploaded)}/{len(files)} files")

    def link(item):
        product_id, filename = item
        if filename not in uploaded:
            return False
        public_url = f"{url}/storage/v1/object/public/{BUCKET}/{storage_path(filename)}"
        req = urllib.request.Request(
            f"{url}/rest/v1/product?id=eq.{product_id}",
            data=json.dumps({"image_url": public_url}).encode(),
            method="PATCH",
            headers={**auth, "Content-Type": "application/json",
                     "Content-Profile": "inventory", "Prefer": "return=minimal"},
        )
        for _ in range(3):
            try:
                urllib.request.urlopen(req, timeout=30).read()
                return True
            except Exception:
                pass
        return False

    with ThreadPoolExecutor(8) as pool:
        linked = sum(pool.map(link, selected.items()))
    print(f"linked {linked}/{len(selected)} products")


if __name__ == "__main__":
    main()
