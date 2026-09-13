# Lossless branch preservation

This directory preserves the repository state before the 2026-09-13 consolidation.

## Guarantees

- No historical branch was deleted or force-updated.
- The preservation merge has every named historical branch tip as a parent.
- `branch-snapshots/` contains a complete checkout of every named branch, each in
  its own directory, so conflicting paths cannot overwrite one another.
- `session-scratch-20260913/` contains relevant artifacts recovered from the
  active workspace that were not yet part of the remote repository.
- `ALL_REFS_PRE_UNION.txt` records the exact pre-union refs and object IDs.
- `SHA256SUMS.txt` authenticates every preserved regular file in this directory,
  excluding the checksum file itself.

## Naming

Branch slashes are replaced by underscores in snapshot directory names. The
exact branch-to-SHA mapping is recorded in `BRANCHES_PRE_UNION.tsv`.

## Restore

For history, use the original branch ref or the corresponding parent of the
preservation merge. For files, copy from the matching snapshot directory. A
complete Git bundle was also created and verified before remote mutation; it is
kept outside the repository because it contains the repository itself.

This is an audit archive. Snapshot files are not claims that every mathematical
statement is established; their original status labels remain authoritative.
