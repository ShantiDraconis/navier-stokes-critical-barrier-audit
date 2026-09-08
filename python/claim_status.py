"""Validate claim status entries and required references."""

from __future__ import annotations

from pathlib import Path
import re

ALLOWED = {
    "CLASSICAL",
    "PROVED_IN_REPOSITORY",
    "FORMALIZED",
    "DERIVED",
    "NUMERICALLY_SUPPORTED",
    "CONJECTURAL",
    "TARGET",
    "UNRESOLVED",
    "FALSE",
    "REFUTED",
    "NOT_APPLICABLE",
}


def parse_claim_lines(path: Path):
    lines = path.read_text().splitlines()
    claims = []
    for ln in lines:
        m = re.match(r"^\|\s*([^|]+)\|\s*([^|]+)\|\s*([^|]+)\|\s*([^|]+)\|", ln)
        if m and m.group(1).strip().startswith("CLAIM-"):
            claims.append({
                "id": m.group(1).strip(),
                "statement": m.group(2).strip(),
                "status": m.group(3).strip(),
                "reference": m.group(4).strip(),
            })
    return claims


def validate_claims(claims):
    bad = 0
    for c in claims:
        if c["status"] not in ALLOWED:
            print(f"INVALID_STATUS {c['id']}: {c['status']}")
            bad += 1

        low = c["status"].lower()
        ref = c["reference"]

        if low == "proved_in_repository" and ref in {"", "UNKNOWN", "-"}:
            print(f"REJECT_PROVED_WITHOUT_REFERENCE {c['id']}")
            bad += 1

        if low == "refuted" and "contradiction" not in ref.lower():
            print(f"REJECT_REFUTED_WITHOUT_CONTRADICTION_PROOF {c['id']}")
            bad += 1

        if "priority" in c["statement"].lower() and ("timestamp" not in ref.lower() and "commit" not in ref.lower()):
            print(f"REJECT_PRIORITY_WITHOUT_TIMESTAMPED_EVIDENCE {c['id']}")
            bad += 1

        if "derived_from" in ref and "evidence:" not in ref.lower():
            print(f"REJECT_DERIVED_FROM_WITHOUT_EXPLICIT_EVIDENCE {c['id']}")
            bad += 1

    return bad


def main() -> int:
    repo = Path(__file__).resolve().parents[1]
    claims = parse_claim_lines(repo / "CLAIMS.md")
    if not claims:
        print("No claim rows found in CLAIMS.md")
        return 1
    bad = validate_claims(claims)
    if bad:
        print("claim_status: FAIL")
        return 1
    print("claim_status: OK")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
