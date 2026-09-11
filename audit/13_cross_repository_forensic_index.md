# Cross-Repository Forensic Index — Verified Evidence Pack 001

Generated from authenticated GitHub reads. This file records only evidence directly verified from repository objects or explicitly preserved from the prior audit checkpoint. It does **not** claim mathematical correctness, publication priority, or a solved Millennium problem.

## Audit destination

- Repository: `ShantiDraconis/navier-stokes-critical-barrier-audit`
- Branch: `main`
- Purpose: immutable cross-repository provenance index for the wider Millennium formalization program.

## Directly verified repositories

### 1. `ShantiDraconis/millennium-riemann-I`

Repository metadata verified through authenticated GitHub access:

- Repository ID: `1102198067`
- Visibility: private
- Default branch: `main`
- Administrative access available to repository owner.

Verified historical commit:

- Full SHA: `d4e57156d12a4aa0ea839835aacd39d2cb3008e8`
- Commit message: `Merge pull request #9 from ShantiDraconis/copilot/add-nova-classe-numerica` / `[WIP] Add rules for new numerical classes based on proof refutation`
- Immutable commit URL: `https://github.com/ShantiDraconis/millennium-riemann-I/commit/d4e57156d12a4aa0ea839835aacd39d2cb3008e8`

Verified LaTeX files visible at this commit include:

- `latex/millennium-riemann-I.tex`
- `latex/rh-i-symbolic.tex`
- `latex/i-collapse-proof.tex`
- `cross/latex/anomalous_zeros.tex`
- `cross/latex/anomalous-numbers.tex`

#### `latex/millennium-riemann-I.tex`

- Commit SHA: `d4e57156d12a4aa0ea839835aacd39d2cb3008e8`
- Git blob SHA: `6b9829a035c6f7c4ca3b9570ea9222fa1a571ec6`
- Immutable file URL: `https://github.com/ShantiDraconis/millennium-riemann-I/blob/d4e57156d12a4aa0ea839835aacd39d2cb3008e8/latex/millennium-riemann-I.tex`
- Document title: `Symbolic Formalization of the Riemann Hypothesis via CollapseComplex Number System`
- Explicit status in the document: symbolic, experimental, non-standard formalization; the document explicitly says **this is NOT a proof of the classical Riemann Hypothesis**.
- Framework explicitly introduces the symbolic object `I = 0/0` and states that it is treated axiomatically/non-classically.

Forensic classification:

- `DOCUMENT_TYPE = LATEX_FORMALIZATION`
- `PROOF_STATUS = SYMBOLIC_EXPERIMENTAL / NOT_CLASSICAL_RH_PROOF`
- `EVIDENCE_LEVEL = IMMUTABLE_GIT_OBJECT + FULL_SHA + BLOB_SHA`

This document is therefore important as historical provenance of the symbolic RH program, but it must not be conflated with a later classical Lean/Coq/LaTeX formalization.

---

### 2. `ShantiDraconis/0-0-FORMAL-SUITE`

Repository metadata verified through authenticated GitHub access:

- Repository ID: `1103583643`
- Visibility: private
- Default branch: `main`

Verified historical commit:

- Full SHA: `c8e0e6a0ae1fef1726353d8b661e9d08888b812c`
- Commit message: `Merge pull request #1 from ShantiDraconis/copilot/update-documentation-files` / `Complete formal suite structure with comprehensive Lean formalization`
- Immutable commit URL: `https://github.com/ShantiDraconis/0-0-FORMAL-SUITE/commit/c8e0e6a0ae1fef1726353d8b661e9d08888b812c`

The commit records a repository structure containing:

- `src/FormalSuite/Core/`
- `src/FormalSuite/I/`
- `src/FormalSuite/Zeta/`
- `src/FormalSuite/NavierStokes/`
- `src/FormalSuite/Geometry/`
- `test/`
- `latex/`
- `.github/workflows/lean-ci.yml`

The commit message/diff also records CI intended to build Lean and LaTeX and to search for `sorry` in `src/`.

#### `latex/main.tex`

- Commit SHA: `c8e0e6a0ae1fef1726353d8b661e9d08888b812c`
- Git blob SHA: `66c9b7e68811257684b136c0f3a6bf3bb1c957cb`
- Immutable file URL: `https://github.com/ShantiDraconis/0-0-FORMAL-SUITE/blob/c8e0e6a0ae1fef1726353d8b661e9d08888b812c/latex/main.tex`
- The file is a complete LaTeX article source beginning with `\documentclass[11pt,a4paper]{article}` and defines theorem/lemma/proposition/corollary environments.
- Header identifies the document as `FormalSuite` / `Formal Foundations for Symbolic Constant I`.

Forensic classification:

- `DOCUMENT_TYPE = MASTER_LATEX_CANDIDATE_FOR_0-0-FORMAL-SUITE`
- `PROOF_STATUS = REQUIRES_FILE-BY-FILE LEAN AUDIT`
- `EVIDENCE_LEVEL = IMMUTABLE_GIT_OBJECT + FULL_SHA + BLOB_SHA`

Important caution: repository documentation claims complete proofs/no `sorry`; that claim must be independently checked against the exact Lean source at the same commit before it is treated as a verified proof-status result.

---

### 3. `ShantiDraconis/S5-Core-Private`

Repository metadata verified through authenticated GitHub access:

- Repository ID: `1150094469`
- Visibility: private
- Default branch: `main`

Verified historical commit:

- Full SHA: `feb89339d377722f8749a67abca4932209f003a5`
- Commit message: `Merge pull request #61 from ShantiDraconis/copilot/add-devcontainer-setup` / `Add Moltbook Heartbeat system for Codespaces with API integration`
- Immutable commit URL: `https://github.com/ShantiDraconis/S5-Core-Private/commit/feb89339d377722f8749a67abca4932209f003a5`

Verified LaTeX/documentation artifacts visible in the indexed state include:

- `LaTeX/mqc_template.tex`
- `latex/templates/mqc_paper_template.tex`
- `docs/STYLE_GUIDE.md`
- `docs/MOLT_REVIEW_INTEGRATION.md`

#### `LaTeX/mqc_template.tex`

- Commit SHA: `feb89339d377722f8749a67abca4932209f003a5`
- Git blob SHA: `3c6c31e4b8eb1538bf3c986a9d97e258b28f4232`
- Immutable file URL: `https://github.com/ShantiDraconis/S5-Core-Private/blob/feb89339d377722f8749a67abca4932209f003a5/LaTeX/mqc_template.tex`
- The file is a complete LaTeX article template with theorem environments and custom commands including `\I` and `\R`.

Additional verified commit-history evidence from this repository:

- `f62f8ffb00a5130f770feed40512ebf9e502772b` — `2026-02-05T18:14:30Z` — `Exportação automática: 2026-02-05_18:14:30`
- `ac5ac0af8336528b108d0f216cb23af2b2867618` — `2026-02-05T18:15:28Z` — `Exportação automática: 2026-02-05_18:15:28`
- `08134ba458ffdea4f302397b5c35e913f79125d5` — `2026-02-05T18:15:49Z` — `Exportação automática: 2026-02-05_18:15:49`
- `54d381b9e0d5248ce0f9890d39af4e9bd02b04a8` — `2026-02-05T18:16:21Z` — repository expansion describing a formal-research pipeline with Lean/Coq/Isabelle.

Prior audit checkpoint concluded that inspected S5 generation pipelines can generate Lean/Coq/Isabelle stubs and that presence of workflow/proof-generation infrastructure is not itself proof of the generated theorems. This distinction remains mandatory.

Forensic classification:

- `DOCUMENT_TYPE = FORMAL-RESEARCH INFRASTRUCTURE / LATEX TEMPLATES`
- `PROOF_STATUS = MUST BE DETERMINED PER GENERATED/VERIFIED ARTIFACT`
- `EVIDENCE_LEVEL = FULL_SHA + IMMUTABLE FILE/BLOB REFERENCES`

---

## Preserved prior-audit evidence requiring later cross-linking

The previous checkpoint also recorded historically relevant objects that must be linked into the final provenance DAG:

### `ShantiDraconis/UMA`

- `.formal_foundations/lean/Universe00.lean`
  - earliest verified SHA in the prior audit: `e905d430fb337e7d353b1ceefcc8575fbbde2254`
  - recorded UTC date: `2026-01-08T08:31:00Z`
  - classification: structural precursor for state/error/threshold logic, not a complete correction recurrence.

- `.formal_foundations/lean/NavierStokes.lean`
  - earliest verified SHA: `e905d430fb337e7d353b1ceefcc8575fbbde2254`
  - later modification SHA: `e49abf89ab8d49f83eb29a6fc24e80f0c2f9d3ce`
  - later recorded UTC date: `2026-01-16T12:33:45Z`
  - prior audit classification: theorem statement/incomplete proof containing `sorry`.

- `MATH_FOUNDATION.py`
  - `aaa65ffaa20c5990be29d1c3a62abca2b19ed180` — `2026-01-16T13:14:03Z`
  - `67ab946e125594b204761b3484823f8bc1eaa118` — `2026-01-16T13:45:48Z`
  - `0597cfdae8381a9ce9ca3e958aedafb8cb143639` — `2026-01-16T14:06:14Z`
  - `59d7d127db1a92b138c814bacf6753072c69c912` — `2026-01-16T19:38:16Z`

### `indus-operational-mathematics`

- `tcop_model.py`
  - earliest verified SHA: `334abe1f4811abfb66bf669dca84fa19f7bf5e08`
  - recorded UTC date: `2026-02-03T15:36:48Z`

- `core/harappan_automaton.py`
  - earliest verified SHA: `3ddbca8b95b680374ca60f425e63b93fcc5f5034`
  - recorded UTC date: `2026-02-03T15:14:44Z`

### `Universal-translation-0-0`

- `universal_translation/core/pipeline.py`
  - introduction SHA: `141affbb4490a00f02e84f3d4383ed2698a8e961`
  - recorded UTC date: `2025-11-30T15:02:56Z`
  - prior audit classification: pipeline without demonstrated automatic error-feedback recurrence.

### `emergent-identity-rh`

- `MANUSCRIPT/tex/emergent_unity.tex`
  - introduction SHA: `d64b05964a2dfc8ac9a55cc945f16ec44ae02405`
  - recorded UTC date: `2025-12-09T17:50:53Z`
  - prior audit classification: conceptual/error observable; no demonstrated iterative correction cycle.

These preserved records must be revalidated directly against GitHub objects before they are promoted to the same evidence level as the three directly verified repositories above.

---

## Repositories that remain mandatory for exact inventory

The complete cross-repository audit must still directly inspect:

1. `ShantiDraconis/i-constant-core`
2. `ShantiDraconis/millennium-symbolic-program`
3. `ShantiDraconis/millennium-p-vs-np-I`
4. `ShantiDraconis/millennium-navier-stokes-I`
5. `ShantiDraconis/millennium-bsd-hodge-yangmills-I`
6. `ShantiDraconis/UMA`
7. `ShantiDraconis/indus-operational-mathematics`
8. `ShantiDraconis/Universal-translation-0-0`
9. `ShantiDraconis/emergent-identity-rh`

Additionally, all accessible repositories under `ShantiDraconis` should be searched for historical `.tex`, `.lean`, `.v`, `.thy`, `.pdf`, `.md`, `.py`, `.json`, `.csv`, and related files, including deleted/renamed historical paths where API access permits.

## Required next evidence products

The next audit commits should add, without modifying source repositories:

- `audit/LATEX_INDEX.md`
- `audit/EARLIEST_EVIDENCE.md`
- `audit/WHERE_IS_EVERYTHING.md`
- `audit/MASTER_TIMELINE.md`
- `audit/MASTER_EQUIVALENCE_MAP.md`
- `audit/MASTER_THEOREM_STATUS.md`

For every artifact, preserve separately:

- full commit SHA
- parent SHA(s)
- tree SHA
- Git blob SHA
- raw author timestamp + timezone
- normalized UTC author timestamp
- raw committer timestamp + timezone
- normalized UTC committer timestamp
- immutable commit/file URL
- SHA-256 of extracted raw bytes when a local byte-preserving extraction is available
- theorem/proof-status classification
- semantic-equivalence classification

## Evidence discipline

A Git SHA/timestamp establishes repository provenance for content. It does not by itself establish mathematical correctness, independent discovery, publication priority, or priority over the mathematical literature. Those claims require separate evidence and separate analysis.
