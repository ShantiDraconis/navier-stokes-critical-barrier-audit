#!/usr/bin/env python3
"""Build a sanitized declaration-level provenance DAG from formal_history.jsonl.

This stage does not pretend that textual name similarity proves mathematical
dependence. It emits three edge classes only:

  FILE_IMPORT        source file imports/includes another module/file
  SAME_NAME_LINEAGE  same normalized declaration name reappears historically
  CROSS_LANGUAGE_CANDIDATE same normalized declaration name appears in distinct
                           languages and should be manually statement-compared

Mathematical implication/equivalence edges must be added by a reviewer after
statement normalization. This prevents the audit from turning translations or
shared names into false proof dependencies.
"""

from __future__ import annotations

import argparse
import csv
import json
import re
from collections import defaultdict
from pathlib import Path


def norm_name(s: str) -> str:
    return re.sub(r"[^a-z0-9]+", "_", s.lower()).strip("_")


def node_id(row: dict, decl: dict) -> str:
    return "::".join([
        row["repository_alias"], row["sha"], row["relative_path"],
        row["language"], norm_name(decl["name"]),
    ])


def status(row: dict, decl: dict) -> str:
    kind = decl.get("kind", "").lower()
    m = row.get("markers", {})
    if kind in {"axiom", "postulate", "parameter", "axiomatization"}:
        return "DECLARED_ASSUMPTION"
    if m.get("sorry", 0) or m.get("admit", 0) or m.get("admitted", 0):
        return "FILE_CONTAINS_PROOF_GAP"
    if m.get("axiom", 0) or m.get("postulate", 0) or m.get("parameter", 0):
        return "FILE_CONTAINS_ASSUMPTIONS"
    if row["language"] == "python":
        return "EXECUTABLE_MODEL_NOT_PROOF"
    if row["language"] in {"latex", "markdown"}:
        return "PAPER_STATEMENT_OR_ARGUMENT"
    return "FORMAL_DECLARATION_REQUIRES_BUILD_AUDIT"


def load_rows(path: Path) -> list[dict]:
    with path.open(encoding="utf-8") as f:
        return [json.loads(line) for line in f if line.strip()]


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("history", type=Path)
    ap.add_argument("--nodes", type=Path, required=True)
    ap.add_argument("--edges", type=Path, required=True)
    args = ap.parse_args()

    rows = load_rows(args.history)
    nodes = []
    by_name = defaultdict(list)
    by_file = defaultdict(list)

    for row in rows:
        for decl in row.get("declarations", []):
            nid = node_id(row, decl)
            n = {
                "node_id": nid,
                "repository": row["repository_alias"],
                "commit_sha": row["sha"],
                "author_date": row["author_date"],
                "committer_date": row["committer_date"],
                "tree_sha": row["tree_sha"],
                "path": row["relative_path"],
                "blob_sha": row["blob_sha"],
                "content_sha256": row["content_sha256"],
                "language": row["language"],
                "kind": decl.get("kind", ""),
                "name": decl["name"],
                "normalized_name": norm_name(decl["name"]),
                "status": status(row, decl),
            }
            nodes.append(n)
            by_name[n["normalized_name"]].append(n)
            by_file[(n["repository"], n["commit_sha"], n["path"])].append(n)

    edges = []
    seen = set()

    def add(src: str, dst: str, kind: str, confidence: str, note: str):
        key = (src, dst, kind)
        if src != dst and key not in seen:
            seen.add(key)
            edges.append({
                "source": src, "target": dst, "edge_kind": kind,
                "confidence": confidence, "note": note,
            })

    # Historical and cross-language candidate edges by exact normalized name.
    for name, group in by_name.items():
        group.sort(key=lambda n: (n["committer_date"], n["commit_sha"], n["path"]))
        for a, b in zip(group, group[1:]):
            if a["language"] == b["language"]:
                add(a["node_id"], b["node_id"], "SAME_NAME_LINEAGE", "MEDIUM",
                    "Same normalized declaration name; statement comparison still required.")
            else:
                add(a["node_id"], b["node_id"], "CROSS_LANGUAGE_CANDIDATE", "LOW",
                    "Same normalized name in different languages; do not infer equivalence without statement normalization.")

    args.nodes.parent.mkdir(parents=True, exist_ok=True)
    args.edges.parent.mkdir(parents=True, exist_ok=True)

    node_fields = list(nodes[0].keys()) if nodes else ["node_id"]
    with args.nodes.open("w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=node_fields)
        w.writeheader(); w.writerows(nodes)

    edge_fields = ["source", "target", "edge_kind", "confidence", "note"]
    with args.edges.open("w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=edge_fields)
        w.writeheader(); w.writerows(edges)

    print(f"nodes={len(nodes)} edges={len(edges)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
