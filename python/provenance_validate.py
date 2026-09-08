"""Validate provenance tables and optionally generate integrity manifest lines."""

from __future__ import annotations

from pathlib import Path
from datetime import datetime, timezone
import argparse
import hashlib
import subprocess
import yaml


def validate_commits(commits_path: Path) -> int:
    data = yaml.safe_load(commits_path.read_text())
    required = {"id", "repo", "sha", "timestamp_utc"}
    bad = 0
    for c in data.get("commits", []):
        missing = sorted(required - set(c))
        if missing:
            print(f"MISSING_FIELDS {c.get('id','UNKNOWN')}: {missing}")
            bad += 1
    if bad == 0:
        print("provenance_validate: commits table OK")
    return bad


def git_blob_sha(repo: Path, path: Path) -> str:
    rel = str(path.relative_to(repo))
    cp = subprocess.run(["git", "hash-object", rel], cwd=repo, capture_output=True, text=True)
    if cp.returncode != 0:
        return "UNKNOWN"
    return cp.stdout.strip() or "UNKNOWN"


def generate_manifest(repo: Path, out_path: Path) -> None:
    lines = ["# SHA-256 manifest", "# Format: sha256,size_bytes,path,git_blob_sha,commit_sha,timestamp_utc"]
    head = subprocess.run(["git", "rev-parse", "HEAD"], cwd=repo, capture_output=True, text=True)
    commit_sha = head.stdout.strip() if head.returncode == 0 else "UNKNOWN"
    ts = datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")

    for p in sorted((repo / "evidence").glob("*.yaml")):
        b = p.read_bytes()
        sha256 = hashlib.sha256(b).hexdigest()
        size = len(b)
        rel = p.relative_to(repo)
        blob = git_blob_sha(repo, p)
        lines.append(f"{sha256},{size},{rel},{blob},{commit_sha},{ts}")

    out_path.write_text("\n".join(lines) + "\n")
    print(f"wrote {out_path}")


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--manifest", action="store_true")
    args = parser.parse_args()

    repo = Path(__file__).resolve().parents[1]
    bad = validate_commits(repo / "evidence" / "commits.yaml")

    if args.manifest:
        generate_manifest(repo, repo / "evidence" / "sha256_manifest.txt")

    return 1 if bad else 0


if __name__ == "__main__":
    raise SystemExit(main())
