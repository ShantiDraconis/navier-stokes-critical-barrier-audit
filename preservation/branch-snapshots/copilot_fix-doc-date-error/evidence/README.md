# Evidence

This folder stores provenance metadata and integrity manifests.

- `repositories.yaml`: canonical repository nodes (includes REPO:UEL)
- `commits.yaml`: commit-level records with UTC timestamps (includes all 43 UEL commits)
- `zenodo_records.yaml`: public Zenodo prior-art anchors and pending GitHub/SHA linkage fields
- `files.yaml`: manuscript/file evidence records
- `comparison_schema.yaml`: future forensic comparison schema
- `sha256_manifest.txt`: generated integrity lines for tracked files
- `historical_commits.md`: narrative index of all historical commit anchors with per-SHA URLs

Subdirectories:
- `historical/`: archived historical snapshots and exports
- `external/`: external publication references and metadata
- `external_publications/`: external publication event metadata (primary comparator: openai/NavierStokesAndEuler)
- `user_prior_work/`: snapshots, commit registries, and verification tables for Fagliari prior work
  - `uel_commits.yaml`: complete 43-commit registry for `universal-emergent-logic-`
  - `uel_verification_table.md`: per-SHA verification status and archival checklist
