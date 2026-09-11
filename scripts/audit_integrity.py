#!/usr/bin/env python3
"""Static integrity scanner for the audit repository.

Run from repository root:
    python scripts/audit_integrity.py

Exit status is non-zero only for hard audit-package failures. Historical/source
citations containing words such as `sorry` are reported, not automatically
rejected, because documenting placeholders is itself part of the audit.
"""

from __future__ import annotations

import hashlib
import json
import pathlib
import re
import sys

ROOT = pathlib.Path(__file__).resolve().parents[1]
TEXT_EXT = {".md", ".txt", ".py", ".tex", ".lean", ".v", ".thy", ".json", ".jsonl", ".csv", ".cff", ".yml", ".yaml"}
MARKERS = {
    "lean_sorry": re.compile(r"\bsorry\b", re.I),
    "lean_axiom": re.compile(r"\baxiom\b", re.I),
    "coq_admitted": re.compile(r"\bAdmitted\b"),
    "generic_admit": re.compile(r"\badmit\b", re.I),
    "isabelle_oops": re.compile(r"\boops\b", re.I),
    "vacuous_true": re.compile(r"\bTrue\b"),
    "false_elim": re.compile(r"False\.elim"),
    "todo_fixme": re.compile(r"\b(?:TODO|FIXME)\b"),
}

REQUIRED = [
    "CITATION.cff", "CLAIMS.md", "LIMITATIONS.md", "METHODOLOGY.md",
    "PRIORITY.md", "STATUS.md", "TIMELINE.md",
    "audit/18_master_error_framework_provenance.md",
    "audit/19_remote_unmerged_commit_inventory.md",
    "audit/20_zenodo_22180836_evidence.md",
    "audit/21_citation_and_evidence_guide.md",
    "proofs/audit_bridge_lemmas.md",
    "tests/test_audit_invariants.py",
]


def sha256(path: pathlib.Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()


def main() -> int:
    missing = [p for p in REQUIRED if not (ROOT / p).exists()]
    findings = []
    manifest = []

    for path in sorted(ROOT.rglob("*")):
        if not path.is_file() or ".git" in path.parts:
            continue
        rel = path.relative_to(ROOT).as_posix()
        manifest.append({"path": rel, "bytes": path.stat().st_size, "sha256": sha256(path)})
        if path.suffix.lower() not in TEXT_EXT:
            continue
        try:
            text = path.read_text(encoding="utf-8")
        except UnicodeDecodeError:
            continue
        for name, rx in MARKERS.items():
            count = len(rx.findall(text))
            if count:
                findings.append({"path": rel, "marker": name, "count": count})

    report = {
        "schema": "audit-integrity-v1",
        "required_missing": missing,
        "marker_findings": findings,
        "manifest_entries": len(manifest),
        "status": "FAIL" if missing else "PASS_WITH_REPORTED_MARKERS" if findings else "PASS",
    }
    print(json.dumps(report, indent=2, ensure_ascii=False))
    print("\n# SHA-256 manifest")
    for item in manifest:
        print(f"{item['sha256']}  {item['path']}")
    return 1 if missing else 0


if __name__ == "__main__":
    sys.exit(main())
