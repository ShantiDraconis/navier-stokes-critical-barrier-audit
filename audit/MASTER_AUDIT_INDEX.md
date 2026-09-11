# MASTER AUDIT INDEX

This is the navigation entry-point for the complete audit package.

## 1. What this audit is trying to establish

The audit separates four logically independent questions:

1. **Chronology / provenance** — what mathematical objects existed, in which repository, at which commit, and on which date.
2. **Derivation history** — how the research program evolved from analytic residual/error language into critical parameters, error coordinates, percentage decompositions, phase models, and the Navier–Stokes critical-barrier program.
3. **Mathematical validity** — which claims are classical, which are proved from definitions, which depend on assumptions, which are computational evidence, and which remain open bridges.
4. **External archival support** — Git objects, PR-only commits, Zenodo records, DOI records, file hashes, and reproducibility checks.

Chronology is not used as a substitute for proof. Mathematical similarity is not used as evidence of copying or causal derivation.

---

## 2. Core documents

### Existing audit baseline

- `README.md` — repository purpose and scope split.
- `METHODOLOGY.md` — contradiction discipline and forensic method.
- `PRIORITY.md` — limits of chronology claims.
- `CLAIMS.md` — claim registry.
- `STATUS.md` — current scientific status.
- `TIMELINE.md` — historical chronology.
- `LIMITATIONS.md` — limitations.
- `CITATION.cff` — citation metadata.

### Provenance and global search

- `audit/13_cross_repository_forensic_index.md`
- `audit/14_openai_formula_provenance.md`
- `audit/15_git_provenance_full.md`
- `audit/15_projection_chain_audit_map.md`
- `audit/15_uel_structural_analysis.md`
- `audit/16_uel_formula_index.md`
- `audit/17_audit_scope.md`
- `audit/18_master_error_framework_provenance.md`
- `audit/19_remote_unmerged_commit_inventory.md`
- `audit/20_zenodo_22180836_evidence.md`
- `audit/21_citation_and_evidence_guide.md`
- `audit/22_global_repository_gap_scan.md`

### Exact reconstruction of the research path

- `audit/23_derivation_history_exact_path.md` — chronological derivation from the earliest currently linked NS records through the error/parameter/phase architecture.
- `audit/24_claim_evidence_matrix.md` — claim → source → SHA → date → status mapping.
- `audit/25_theorem_status_matrix.md` — theorem-level and model-level proof status.
- `audit/26_bridge_obligations.md` — exact statements that still have to be proved before a classical Navier–Stokes theorem can be claimed.
- `audit/27_reproducibility_protocol.md` — independent reproduction procedure.
- `audit/28_audit_file_tree.md` — canonical file tree and purpose of each artifact.
- `audit/29_test_and_ci_record.md` — executable-test and CI evidence.

### Rigorous audit-only proofs

- `proofs/audit_bridge_lemmas.md` — algebraic/analytic lemmas that follow from the audit definitions and are actually proved.

### Machine-readable provenance

- `evidence/repositories.yaml`
- `evidence/commits.yaml`
- `evidence/forensic_first_occurrence.csv`
- `evidence/provenance_chain.md`
- `data/chronology.csv`
- `data/provenance_edges.csv`

### Executable integrity layer

- `tests/test_audit_invariants.py`
- `tests/test_provenance_tables.py`
- `scripts/audit_integrity.py`
- `.github/workflows/audit-integrity.yml`

---

## 3. High-level derivation graph

```text
Navier–Stokes collapse / regularity framework (Nov 2025)
        ↓
classical + functional-space + multiprover formalization
        ↓
local→global / blow-up profile / critical-space program
        ↓
projection → residual → closure obstruction
        ↓
LRE residual stability / coupling / correction architecture
        ↓
error as universal organizing quantity
        ↓
critical / missing parameters and measurable gaps
        ↓
unified parameter spaces / stability coordinates
        ↓
weighted error decomposition
        ↓
Π = (π, ε): error becomes intrinsic to the parameter object
        ↓
sensitivity-based contribution model
        ↓
ε(P) ∈ R_+^n: geometric error-coordinate state
        ↓
error-reduction trajectory
        ↓
convergence / threshold layer
        ↓
real + imaginary phase-error decomposition
        ↓
phase / stochastic extensions
        ↓
2026 critical-L3 / noncircular / audit program
```

This graph is a provenance reconstruction. Every arrow is classified in `data/provenance_edges.csv` as one of: `PRECEDES`, `DERIVED_FROM`, `REFINES`, `GENERALIZES`, `SPECIALIZES`, `FORMALIZES`, `RELATED_TO`, or `OPEN_BRIDGE`.

---

## 4. Strongest currently supported provenance statements

The repository currently supports the following narrowly framed claims:

- Navier–Stokes-specific mathematical work is recorded in Git history by November 2025.
- A projection/residual/closure-obstruction line is recorded by December 2025.
- An explicit error-as-parameter / percentage / error-coordinate research program is recorded by December 2025–January 2026.
- Later specialized Navier–Stokes repositories continue critical-space and noncircular analysis before September 2026.
- Multiple proof assistants and formalization frameworks occur in the corpus, but proof status is heterogeneous and must be audited theorem-by-theorem.
- Git chronology establishes existence of repository objects at recorded commits; it does not establish worldwide novelty, causal access by third parties, or correctness of an unsolved theorem.

---

## 5. Current proof boundary

The audit proves several internal identities, including normalization of declared contribution percentages, monotonicity of a norm-based progress functional, and exact cancellation of a whole-period non-zero Fourier mode. See `proofs/audit_bridge_lemmas.md`.

The audit does **not** currently prove the decisive bridge

```text
repository-defined error/phase state reaches zero
            ⇒
classical 3D Navier–Stokes global smoothness or a valid finite-time singularity construction.
```

That implication is explicitly tracked as an `OPEN_BRIDGE`, not hidden inside terminology.

---

## 6. Audit integrity status

GitHub Actions workflow `Audit integrity` is installed. Run `34636992823`, against commit `cdbe509ed011584484cfaa4085b9e46f3bf5a23c`, completed successfully on 2026-09-11. Subsequent commits trigger the same workflow automatically.

A green audit-integrity workflow establishes that the audit package and its declared invariant tests pass; it does **not** certify the Millennium theorem.
