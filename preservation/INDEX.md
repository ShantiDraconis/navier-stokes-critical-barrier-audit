# Branch Archive Index — Navier-Stokes Critical Barrier Audit

**Archive date:** 2026-09-13
**Total branches preserved:** 24
**Total files preserved:** 3202

All branches are preserved as lossless file-tree snapshots under
`preservation/branch-snapshots/`. No original branch was deleted or mutated.

---

## Branch Inventory

| Branch | Tip SHA | Snapshot Dir | File Count |
|--------|---------|-------------|------------|
| `origin` | `48259a1f1e3e` | `origin` | 15 |
| `audit/closure-target-tree-v56` | `02ab6d9042d2` | `audit_closure-target-tree-v56` | 48 |
| `audit/correct-provenance-attribution-20260912` | `0ef40f256e40` | `audit_correct-provenance-attribution-20260912` | 248 |
| `audit/final-two-stage-review-nsb2-20260912` | `5f7e4dad066f` | `audit_final-two-stage-review-nsb2-20260912` | 325 |
| `audit/g1-beta-multiprover-20260913` | `0bcfd41ccff9` | `audit_g1-beta-multiprover-20260913` | 357 |
| `audit/g1-dynamic-q-20260913` | `feee79e5b7be` | `audit_g1-dynamic-q-20260913` | 6 |
| `audit/g1-prize-standard-v4-20260913` | `61c11fccf0c2` | `audit_g1-prize-standard-v4-20260913` | 19 |
| `audit/millennium-multiprover-structure-20260913` | `c636c4b4e202` | `audit_millennium-multiprover-structure-20260913` | 347 |
| `copilot/add-lre-ns-framework` | `cd0446180e0c` | `copilot_add-lre-ns-framework` | 118 |
| `copilot/audit-search-terms` | `48b6d6d05576` | `copilot_audit-search-terms` | 95 |
| `copilot/claim-navier-stokes-git-evidence` | `d0a15924732e` | `copilot_claim-navier-stokes-git-evidence` | 97 |
| `copilot/compare-mathematical-formulas` | `1673a3ebe893` | `copilot_compare-mathematical-formulas` | 96 |
| `copilot/execute-multi-agent-audit` | `e4938615dc44` | `copilot_execute-multi-agent-audit` | 119 |
| `copilot/fix-doc-date-error` | `a375c04b6b5a` | `copilot_fix-doc-date-error` | 134 |
| `copilot/navier-stokes-critical-barrier-audit` | `0687fad11011` | `copilot_navier-stokes-critical-barrier-audit` | 98 |
| `copilot/navier-stokes-noncircular-implementation` | `0840b46215d5` | `copilot_navier-stokes-noncircular-implementation` | 98 |
| `copilot/registro-git-navier-stokes` | `15eea35ca8a7` | `copilot_registro-git-navier-stokes` | 106 |
| `copilot/revendo-arquivos-auditoria` | `7386a2f94852` | `copilot_revendo-arquivos-auditoria` | 122 |
| `copilot/shanti-0-0-default-history` | `8cf0b598284e` | `copilot_shanti-0-0-default-history` | 200 |
| `copilot/shanti-auditoria-ns` | `dbecca313806` | `copilot_shanti-auditoria-ns` | 98 |
| `copilot/target-extractor` | `fc3fbd2bc23f` | `copilot_target-extractor` | 122 |
| `copilot/task-219265797-1361927617-c6bfd6e0-3c0d-429b-a267-9cea34423468` | `e35f74d10ba4` | `copilot_task-219265797-1361927617-c6bfd6e0-3c0d-429b-a267-9cea34423468` | 202 |
| `copilot/update-reference-section` | `ab04ad5d580f` | `copilot_update-reference-section` | 117 |
| `main` | `48259a1f1e3e` | `main` | 15 |

---

## Directory Structure

```
preservation/
  BRANCHES_PRE_UNION.tsv      branch → tip-SHA mapping
  ALL_REFS_PRE_UNION.txt      all refs before consolidation
  SHA256SUMS.txt              file integrity hashes
  branch_file_manifest.json   per-file SHA-256 + metadata for all snapshots
  INDEX.md                    this file
  README.md                   restoration instructions
  branch-snapshots/
    <branch-slug>/            complete tree as of branch tip
  session-scratch-20260913/   workspace artifacts not yet on remote

audit/         current audit documents
formal/        Lean / Agda / Coq / Isabelle formal proofs
scripts/       test scripts
results/       numerical test outputs
  formal_test_run_2026-09-13/
    FORMAL_TEST_REPORT.md
    g1_componentwise_ch_results.json
    g1_joint_tail_diagnostic.json
```

---

## Test Status

| Test | Script | Status |
|------|--------|--------|
| G1 Componentwise CH | `scripts/g1_componentwise_ch_test.py` | ✅ PASS |
| G1★ Joint Tail Diag | `scripts/g1_joint_tail_diagnostic.py` | ✅ PASS |

Full results: `results/formal_test_run_2026-09-13/FORMAL_TEST_REPORT.md`

---

## Audit Files (current tree)

- `audit/16_G1_prize_standard_program.md`
- `audit/17_G1_attack_matrix.md`
- `audit/66_corrected_conditional_regularity_closure.md`
- `audit/67_componentwise_CH_numerical_test.md`
- `audit/68_g1star_v3_joint_tail_decomposition.md`
- `audit/69_critical_loop_signature_and_flexible_g1.md`

## Formal Proofs (current tree)

- `formal/G1/G1_PrizeStandard_Interface.lean`
- `formal/G1/HypothesesComplete_v2.lean`
- `formal/millennium/lean/MillenniumAudit/HypothesesComplete_v3.lean`

---

## Cross-Reference Statistics

| Metric | Count |
|--------|-------|
| Distinct file paths across all branches | 410 |
| Files unique to exactly one branch | 48 |
| Files shared across ≥2 branches | 362 |

### Branches with Unique-Only Files

| Branch | Unique Files |
|--------|-------------|
| `audit/closure-target-tree-v56` | 33 |
| `audit/g1-beta-multiprover-20260913` | 9 |
| `copilot/navier-stokes-critical-barrier-audit` | 3 |
| `audit/g1-prize-standard-v4-20260913` | 2 |
| `audit/g1-dynamic-q-20260913` | 1 |

Full per-file detail: `preservation/branch_file_manifest.json`
