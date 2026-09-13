# Root reconstruction — 2026-09-13

This directory records the lossless reconstruction of the repository's
operational root from all preserved historical branches.

## Safety policy

1. The existing `main` file always wins at its original path.
2. A historical file is restored to the root only when that path is absent.
3. Later sources never overwrite a path restored from an earlier source.
4. Every restored path, source snapshot and SHA-256 digest is recorded in
   `ROOT_UNION_PROVENANCE.tsv`.
5. Every differing historical variant is recorded in
   `ROOT_UNION_CONFLICTS.tsv` and remains available under
   `preservation/branch-snapshots/`.
6. No historical branch is deleted or force-updated.

## Source precedence

The reconstruction prefers the existing `main`, followed by the most complete
audit closure snapshot, the G1 audit branches, the multiprover branches, the
remaining audit branches, the Copilot branches and finally the recovered
session artifacts. This ordering selects an operational root; it does not erase
or reclassify alternative versions.

## TSV formats

- `ROOT_UNION_PROVENANCE.tsv`: `path`, `source`, `selected_sha256`.
- `ROOT_UNION_CONFLICTS.tsv`: `path`, `alternative_source`,
  `selected_sha256`, `alternative_sha256`.

The mathematical status embedded in each source remains authoritative. Merely
restoring a file does not promote an open bridge, hypothesis, simulation or
conditional theorem to an established result.
