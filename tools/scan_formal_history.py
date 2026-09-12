#!/usr/bin/env python3
"""Sanitized formal-history scanner for provenance audits.

Run locally against clones you are authorized to inspect. The scanner emits only
Git metadata, repository-relative paths, object hashes, declaration names and
formal-gap counters. It deliberately does NOT copy source bodies, absolute local
paths, remotes containing credentials, environment variables, notebooks, chat
exports, tokens, or private URLs into the public ledger.

Usage:
    python tools/scan_formal_history.py /path/to/repo1 /path/to/repo2 \
        --out evidence/formal_history.jsonl

For private repositories, review the JSONL before publishing it. A private
repository can instead be represented by a stable alias plus hashes in a
separate private/public mapping.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import re
import subprocess
from pathlib import Path
from typing import Iterable

FORMAL_EXTS = {".lean", ".v", ".thy", ".agda", ".tex", ".md"}
DECL_RE = re.compile(
    r"(?m)^\s*(?:theorem|lemma|axiom|def|definition|postulate|Theorem|Lemma|Axiom)\s+([A-Za-z0-9_'.-]+)"
)
PATTERNS = {
    "sorry": re.compile(r"\bsorry\b", re.I),
    "admit": re.compile(r"\badmit\b", re.I),
    "admitted": re.compile(r"\bAdmitted\b"),
    "axiom": re.compile(r"\baxiom\b", re.I),
    "postulate": re.compile(r"\bpostulate\b", re.I),
    "true_placeholder": re.compile(r"(?<![A-Za-z])True(?![A-Za-z])"),
    "i_zero_over_zero": re.compile(r"(?:I|\\mathcal\{I\}|\\mathbb\{I\})\s*=\s*(?:\\frac\{0\}\{0\}|0\s*/\s*0)"),
    "nan": re.compile(r"\bNaN\b", re.I),
    "null_none": re.compile(r"\b(?:null|none)\b", re.I),
}


def git(repo: Path, *args: str, text: bool = True) -> str:
    p = subprocess.run(
        ["git", "-C", str(repo), *args],
        check=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=text,
    )
    return p.stdout


def repo_alias(repo: Path) -> str:
    """Use directory basename only; never emit absolute paths or remote URLs."""
    return repo.name


def commits(repo: Path) -> Iterable[dict]:
    fmt = "%H%x1f%P%x1f%aI%x1f%cI%x1f%T%x1f%G?%x1f%s%x1e"
    raw = git(repo, "log", "--all", "--reverse", f"--format={fmt}")
    for rec in raw.split("\x1e"):
        rec = rec.strip("\n")
        if not rec.strip():
            continue
        parts = rec.split("\x1f")
        if len(parts) != 7:
            continue
        sha, parents, adate, cdate, tree, sig, subject = parts
        yield {
            "sha": sha,
            "parents": parents.split() if parents else [],
            "author_date": adate,
            "committer_date": cdate,
            "tree_sha": tree,
            "signature_status": sig,
            "subject": subject,
        }


def files_at(repo: Path, sha: str) -> list[str]:
    raw = git(repo, "ls-tree", "-r", "--name-only", sha)
    return [p for p in raw.splitlines() if Path(p).suffix.lower() in FORMAL_EXTS]


def blob_sha(repo: Path, sha: str, rel: str) -> str:
    return git(repo, "rev-parse", f"{sha}:{rel}").strip()


def content_at(repo: Path, sha: str, rel: str) -> str | None:
    try:
        return git(repo, "show", f"{sha}:{rel}")
    except subprocess.CalledProcessError:
        return None


def sanitize_declarations(text: str) -> list[str]:
    # Declaration names are public-safe metadata; statements/bodies are omitted.
    return sorted(set(DECL_RE.findall(text)))[:500]


def counts(text: str) -> dict[str, int]:
    return {name: len(rx.findall(text)) for name, rx in PATTERNS.items()}


def digest_text(text: str) -> str:
    return hashlib.sha256(text.encode("utf-8", errors="replace")).hexdigest()


def scan_repo(repo: Path):
    alias = repo_alias(repo)
    for c in commits(repo):
        for rel in files_at(repo, c["sha"]):
            text = content_at(repo, c["sha"], rel)
            if text is None:
                continue
            gap = counts(text)
            decls = sanitize_declarations(text)
            # Keep only files with formal declarations or relevant gap/meta markers.
            if not decls and not any(gap.values()):
                continue
            yield {
                "repository_alias": alias,
                **c,
                "relative_path": rel,
                "blob_sha": blob_sha(repo, c["sha"], rel),
                "content_sha256": digest_text(text),
                "declarations": decls,
                "markers": gap,
            }


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("repos", nargs="+", type=Path)
    ap.add_argument("--out", required=True, type=Path)
    args = ap.parse_args()

    args.out.parent.mkdir(parents=True, exist_ok=True)
    total = 0
    with args.out.open("w", encoding="utf-8") as f:
        for repo in args.repos:
            if not (repo / ".git").exists():
                raise SystemExit(f"Not a Git clone: {repo.name}")
            for row in scan_repo(repo):
                f.write(json.dumps(row, ensure_ascii=False, sort_keys=True) + "\n")
                total += 1

    print(f"wrote {total} sanitized historical file-records to {args.out}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
