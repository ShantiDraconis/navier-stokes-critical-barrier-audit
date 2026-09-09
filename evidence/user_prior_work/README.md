# User Prior Work

Store snapshots, archived exports, and signed metadata that document prior work chronology.

## Contents

| File | Description |
|------|-------------|
| `uel_commits.yaml` | Complete commit registry for `universal-emergent-logic-` (43 commits, 6 layers) |
| `uel_verification_table.md` | Per-SHA verification status table with canonical URLs and archival checklist |

## Archival instructions

To promote Tier 2 (reported) entries to Tier 1 (independently captured):

1. Export a git bundle from the source repository: `git bundle create uel.bundle --all`
2. Compute SHA-256 of the bundle: `sha256sum uel.bundle`
3. Archive key file snapshots: `git show SHA:path/to/file > snapshot.md`
4. Record hashes in `evidence/sha256_manifest.txt`
5. Update `verification` field in `uel_commits.yaml` from `reported_pending_archival` to `independently_captured`
6. Add the commit to `evidence/commits.yaml` with `verification: verified_valid`
