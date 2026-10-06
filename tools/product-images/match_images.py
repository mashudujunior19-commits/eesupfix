"""Match product photos in a folder to rows in inventory.product by name.

Usage:
  SUPABASE_URL=https://<ref>.supabase.co SUPABASE_SERVICE_KEY=... \
    python match_images.py --images <folder> --out <folder>

Writes match.json ({product_id: [file, score]}) and needs_review.csv into --out.
Nothing is changed in the database.
"""
import argparse
import csv
import json
import os
import re
import unicodedata
import urllib.request

SIZE = re.compile(r"^\d+(\.\d+)?(kg|g|ml|l|s|m|cm|mm|pack|pk)$")
AUTO_ACCEPT = 0.8   # at or above this, the upload script links the image
MIN_SUGGEST = 0.6   # below this, no suggestion is made


def tokens(text, strip_multipack):
    s = unicodedata.normalize("NFKD", text).lower().replace("&", " and ")
    s = re.sub(r"(\d),(\d)", r"\1.\2", s)
    if strip_multipack:
        s = re.sub(r"\s+x\s?\d+\s*$", "", s)
    s = re.sub(r"(\d)\s+(kg|g|ml|l)\b", r"\1\2", s)
    return frozenset(w for w in re.sub(r"[^a-z0-9.]+", " ", s).split() if w)


def fetch_products(url, key):
    rows, offset = [], 0
    while True:
        req = urllib.request.Request(
            f"{url}/rest/v1/product?select=id,name&order=id&limit=1000&offset={offset}",
            headers={"apikey": key, "Authorization": f"Bearer {key}", "Accept-Profile": "inventory"},
        )
        page = json.load(urllib.request.urlopen(req, timeout=60))
        rows += page
        if len(page) < 1000:
            return rows
        offset += 1000


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--images", required=True)
    ap.add_argument("--out", required=True)
    args = ap.parse_args()
    url, key = os.environ["SUPABASE_URL"].rstrip("/"), os.environ["SUPABASE_SERVICE_KEY"]

    files = [f for f in os.listdir(args.images) if f.lower().endswith((".png", ".jpg", ".jpeg"))]
    best_file = {}  # token set -> largest file with that name
    for f in files:
        k = tokens(os.path.splitext(f)[0], False)
        if k not in best_file or os.path.getsize(os.path.join(args.images, f)) > os.path.getsize(
            os.path.join(args.images, best_file[k])
        ):
            best_file[k] = f
    candidates = [(k, f, frozenset(w for w in k if SIZE.match(w))) for k, f in best_file.items()]

    products = fetch_products(url, key)
    match, review = {}, []
    for p in products:
        t = tokens(p["name"], True)  # multipacks ("x10") share the single-unit photo
        sizes = frozenset(w for w in t if SIZE.match(w))
        scored = sorted(
            ((len(t & k) / len(t | k), f) for k, f, fs in candidates if fs == sizes),
            reverse=True,
        )
        scored = [c for c in scored if c[0] >= MIN_SUGGEST]
        if scored and (len(scored) == 1 or scored[0][0] - scored[1][0] >= 0.1):
            match[p["id"]] = [scored[0][1], scored[0][0]]
        else:
            review.append((p["id"], p["name"], "", ""))

    os.makedirs(args.out, exist_ok=True)
    json.dump({str(i): v for i, v in match.items()}, open(os.path.join(args.out, "match.json"), "w"))
    names = {p["id"]: p["name"] for p in products}
    with open(os.path.join(args.out, "needs_review.csv"), "w", newline="", encoding="utf-8") as fh:
        w = csv.writer(fh)
        w.writerow(["product_id", "product_name", "suggested_file", "score"])
        for i, v in match.items():
            if v[1] < AUTO_ACCEPT:
                w.writerow([i, names[i], v[0], round(v[1], 2)])
        for row in review:
            w.writerow(row)

    auto = sum(1 for v in match.values() if v[1] >= AUTO_ACCEPT)
    print(f"products={len(products)} auto_accept={auto} needs_review={len(products) - auto}")


if __name__ == "__main__":
    main()
