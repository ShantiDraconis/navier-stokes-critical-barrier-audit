"""Extract Lean declarations (def/structure/lemma/theorem/axiom) for comparison workflows.

Usage:
  python3 python/lean_object_extract.py --root /absolute/path --out /absolute/path/out.csv
"""

from __future__ import annotations

import argparse
import csv
import re
from pathlib import Path

PAT = re.compile(r"^\s*(def|structure|lemma|theorem|axiom)\s+([A-Za-z0-9_'.]+)")


def extract_from_file(path: Path):
    results = []
    for i, line in enumerate(path.read_text(errors="ignore").splitlines(), start=1):
        m = PAT.match(line)
        if m:
            results.append((m.group(1), m.group(2), str(path), i))
    return results


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--root", required=True, help="Absolute path to directory to scan")
    ap.add_argument("--out", required=True, help="Absolute output CSV path")
    args = ap.parse_args()

    root = Path(args.root)
    out = Path(args.out)
    if not root.is_absolute() or not out.is_absolute():
        raise SystemExit("Both --root and --out must be absolute paths")

    rows = []
    for f in sorted(root.rglob("*.lean")):
        rows.extend(extract_from_file(f))

    out.parent.mkdir(parents=True, exist_ok=True)
    with out.open("w", newline="") as fp:
        w = csv.writer(fp)
        w.writerow(["kind", "name", "file", "line"])
        for row in rows:
            w.writerow(row)

    print(f"lean_object_extract: wrote {len(rows)} rows to {out}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
