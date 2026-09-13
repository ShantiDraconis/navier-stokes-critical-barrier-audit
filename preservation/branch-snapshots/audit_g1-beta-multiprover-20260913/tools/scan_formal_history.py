#!/usr/bin/env python3
"""Sanitized formal-history scanner for provenance audits.

Run locally against Git clones you are authorized to inspect. The scanner emits
only Git metadata, repository-relative paths, object hashes, declaration names,
language labels, import/reference metadata and formal-gap counters. It does NOT
copy source bodies, absolute local paths, remotes containing credentials,
environment variables, notebooks, chat exports, tokens, or private URLs into the
public ledger.

Usage:
    python tools/scan_formal_history.py /path/to/repo1 /path/to/repo2 \
        --out evidence/formal_history.jsonl

For private repositories, review the JSONL before publishing it. A private repo
can instead be represented by a stable alias plus hashes in a separate mapping.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import re
import subprocess
from pathlib import Path
from typing import Iterable

FORMAL_EXTS = {".lean", ".v", ".thy", ".agda", ".py", ".tex", ".md"}
LANGUAGE_BY_EXT = {
    ".lean": "lean",
    ".v": "coq",
    ".thy": "isabelle",
    ".agda": "agda",
    ".py": "python",
    ".tex": "latex",
    ".md": "markdown",
}

DECL_PATTERNS = {
    "lean": re.compile(r"(?m)^\s*(theorem|lemma|axiom|opaque|def|abbrev|structure|class|inductive)\s+([A-Za-z0-9_'.-]+)"),
    "coq": re.compile(r"(?m)^\s*(Theorem|Lemma|Fact|Remark|Corollary|Proposition|Axiom|Parameter|Definition|Fixpoint|Inductive|Record)\s+([A-Za-z0-9_'.-]+)"),
    "isabelle": re.compile(r"(?m)^\s*(theorem|lemma|corollary|definition|fun|primrec|datatype|record)\s+([A-Za-z0-9_'.-]+)"),
    "agda": re.compile(r"(?m)^\s*(?:postulate\s*$\n\s*)?([A-Za-z0-9_'.-]+)\s*:\s*"),
    "python": re.compile(r"(?m)^\s*(class|def)\s+([A-Za-z_][A-Za-z0-9_]*)"),
    "latex": re.compile(r"(?ms)\\begin\{(theorem|lemma|proposition|corollary|definition|conjecture|axiom)\}(?:\[[^\]]*\])?.*?\\label\{([^}]+)\}"),
    "markdown": re.compile(r"(?mi)^\s*#{1,6}\s+(Theorem|Lemma|Proposition|Corollary|Definition|Conjecture|Axiom)\s*[:#-]?\s*([^\n#]+)"),
}

PATTERNS = {
    "sorry": re.compile(r"\bsorry\b", re.I),
    "admit": re.compile(r"\badmit\b", re.I),
    "admitted": re.compile(r"\bAdmitted\b"),
    "axiom": re.compile(r"\b(?:axiom|Axiom|axiomatization)\b"),
    "postulate": re.compile(r"\bpostulate\b", re.I),
    "opaque": re.compile(r"\bopaque\b", re.I),
    "parameter": re.compile(r"\b(?:Parameter|Parameters)\b"),
    "true_placeholder": re.compile(r"(?<![A-Za-z])True(?![A-Za-z])"),
    "ellipsis": re.compile(r"(?:\.\.\.|\\ldots|\\cdots)"),
    "todo": re.compile(r"\bTODO\b", re.I),
    "i_zero_over_zero": re.compile(r"(?:I|\\mathcal\{I\}|\\mathbb\{I\})\s*=\s*(?:\\frac\{0\}\{0\}|0\s*/\s*0)"),
    "nan": re.compile(r"\bNaN\b", re.I),
    "null_none": re.compile(r"\b(?:null|none)\b", re.I),
}

IMPORT_PATTERNS = {
    "lean": re.compile(r"(?m)^\s*import\s+([^\n]+)"),
    "coq": re.compile(r"(?m)^\s*(?:From\s+([^\s]+)\s+)?Require\s+Import\s+([^\.]+)\."),
    "isabelle": re.compile(r"(?ms)^\s*theory\s+[^\n]+\s+imports\s+(.+?)\s+begin"),
    "agda": re.compile(r"(?m)^\s*open\s+import\s+([^\s]+)"),
    "python": re.compile(r"(?m)^\s*(?:from\s+([A-Za-z0-9_\.]+)\s+import|import\s+([A-Za-z0-9_\.]+))"),
    "latex": re.compile(r"\\(?:input|include)\{([^}]+)\}"),
    "markdown": re.compile(r"\[[^\]]+\]\(([^)]+)\)"),
}


def git(repo: Path, *args: str, text: bool = True) -> str:
    p = subprocess.run(
        ["git", "-C", str(repo), *args], check=True,
        stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=text,
    )
    return p.stdout


def repo_alias(repo: Path) -> str:
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


def language_of(rel: str) -> str:
    return LANGUAGE_BY_EXT.get(Path(rel).suffix.lower(), "unknown")


def sanitize_declarations(text: str, language: str) -> list[dict]:
    rx = DECL_PATTERNS.get(language)
    if not rx:
        return []
    out = []
    for m in rx.finditer(text):
        groups = m.groups()
        if language == "agda":
            kind, name = "declaration", groups[0]
        else:
            kind, name = groups[0], groups[1].strip()
        out.append({"kind": kind, "name": name[:200]})
    # deterministic de-duplication
    seen = set()
    dedup = []
    for d in out:
        key = (d["kind"], d["name"])
        if key not in seen:
            seen.add(key)
            dedup.append(d)
    return dedup[:1000]


def sanitize_imports(text: str, language: str) -> list[str]:
    rx = IMPORT_PATTERNS.get(language)
    if not rx:
        return []
    out = []
    for m in rx.finditer(text):
        vals = [g.strip() for g in m.groups() if g and g.strip()]
        out.extend(vals)
    return sorted(set(out))[:500]


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
            language = language_of(rel)
            gap = counts(text)
            decls = sanitize_declarations(text, language)
            imports = sanitize_imports(text, language)
            if not decls and not any(gap.values()):
                continue
            yield {
                "repository_alias": alias,
                **c,
                "relative_path": rel,
                "language": language,
                "blob_sha": blob_sha(repo, c["sha"], rel),
                "content_sha256": digest_text(text),
                "declarations": decls,
                "imports": imports,
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
