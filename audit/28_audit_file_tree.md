# 28 — Canonical Audit Artifact Tree

This file defines where every evidence class belongs.

```text
navier-stokes-critical-barrier-audit/
├── README.md
├── CITATION.cff
├── CLAIMS.md
├── LIMITATIONS.md
├── METHODOLOGY.md
├── PRIORITY.md
├── STATUS.md
├── TIMELINE.md
│
├── audit/
│   ├── MASTER_AUDIT_INDEX.md
│   ├── 01_external_claims.md ... 12_open_questions.md
│   ├── 13_cross_repository_forensic_index.md
│   ├── 14_openai_formula_provenance.md
│   ├── 15_git_provenance_full.md
│   ├── 15_projection_chain_audit_map.md
│   ├── 15_uel_structural_analysis.md
│   ├── 16_uel_formula_index.md
│   ├── 17_audit_scope.md
│   ├── 18_master_error_framework_provenance.md
│   ├── 19_remote_unmerged_commit_inventory.md
│   ├── 20_zenodo_22180836_evidence.md
│   ├── 21_citation_and_evidence_guide.md
│   ├── 22_global_repository_gap_scan.md
│   ├── 23_derivation_history_exact_path.md
│   ├── 24_claim_evidence_matrix.md
│   ├── 25_theorem_status_matrix.md
│   ├── 26_bridge_obligations.md
│   ├── 27_reproducibility_protocol.md
│   ├── 28_audit_file_tree.md
│   └── 29_test_and_ci_record.md
│
├── evidence/
│   ├── repositories.yaml
│   ├── commits.yaml
│   ├── forensic_first_occurrence.csv
│   └── provenance_chain.md
│
├── data/
│   ├── chronology.csv
│   └── provenance_edges.csv
│
├── proofs/
│   └── audit_bridge_lemmas.md
│
├── tests/
│   ├── test_audit_invariants.py
│   └── test_provenance_tables.py
│
├── scripts/
│   └── audit_integrity.py
│
└── .github/workflows/
    └── audit-integrity.yml
```

## Artifact semantics

### `audit/`
Human-readable forensic reasoning. It may interpret evidence but must identify the evidence object supporting each important assertion.

### `evidence/`
Primary structured ledger of repositories, commits and first-occurrence claims. Unknown values remain `UNKNOWN`; they are never guessed.

### `data/`
Machine-readable normalized chronology and provenance graph. Intended for independent graphing/querying.

### `proofs/`
Only mathematical derivations actually established by the audit. Open Millennium bridges do not belong here unless proved.

### `tests/`
Executable checks of internal invariants and data integrity. Passing tests are not synonymous with proving Navier–Stokes.

### `scripts/`
Reproducibility/integrity tooling.

## Future required directories

As the complete-history pass proceeds, add:

```text
audit/evidence/<repository>/<full-commit-sha>.json
audit/claims/<claim-id>/claim.json
audit/claims/<claim-id>/sources.csv
audit/claims/<claim-id>/hashes.sha256
audit/latex/original/
audit/latex/reconstructed/
audit/latex/canonical/
audit/hashes/SHA256SUMS
```

Do not create reconstructed LaTeX under `original/`. Historical bytes and generated reconstructions must remain distinguishable.
