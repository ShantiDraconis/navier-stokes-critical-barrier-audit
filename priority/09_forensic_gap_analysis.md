# 09 — Forensic Gap Analysis and Open Items

## Purpose

This document closes the loop on the repository/SHA inventory established in `08_expanded_git_provenance_dossier.md`
and defines the concrete work that remains to convert the chronology narrative into a **complete forensic chain**.

The four open blocks below are ordered by probative weight.

---

## Block 1 — Exact first-SHA per distinctive element

For each structural element listed below, the audit must identify the **earliest commit** in which the element
*actually appears in a file diff*, not merely in a later snapshot that contains the file.

| Element | First-SHA target repo | Status |
|---|---|---|
| $u = P_N u + (I - P_N)u$ decomposition | millennium-navier-stokes-I | PENDING |
| Residual high-frequency term $u_\perp = (I-P_N)u$ | Millennium | PENDING |
| Coupling operator $K(R, \pi(u))$ | universal-emergent-logic- | PENDING |
| Reynolds stress as residual coupling | universal-emergent-logic- | PENDING |
| Critical jets / $L^3$ critical framework | navier-stokes-critical-L3 | PENDING |
| ERS / RBC recurrence structure | universal-emergent-logic- | PENDING |
| Correction operator / dynamical correction step | Millennium | PENDING |
| Reference section $c_0 = P_N u$ | navier-stokes-critical-barrier-audit corpus | PENDING |

**Method**: for each target repo, run
```
git log --all --diff-filter=A --follow -S '<distinctive string>' -- .
```
and record the oldest SHA returned.  Archive the blob object or a patch into `evidence/` so the audit record
is self-contained.

---

## Block 2 — Iterative correction and stress-update structures

The following constructions are **more discriminative** than classical Navier–Stokes references because they
appear in the OpenAI comparator and are not standard textbook material:

| Construction | Description | Repos to search |
|---|---|---|
| $U_{n+1} = U_n + C_n$ | iterative stress/velocity update | all Millennium + universal-emergent-logic- |
| Explicit residual-cancelling forcing | forcing term that zeroes out a residual error | all Millennium |
| Correction step $C_n$ construction | building the correction from the residual | Millennium |
| Moment repair / defect correction | repairing low-order moments after truncation | universal-emergent-logic- |
| Cutoff / primitive activation | frequency cutoff as activation function analog | universal-emergent-logic- |
| ReferenceJet / CarrierJet equivalents | named jet structures | navier-stokes-critical-L3, navier-stokes-noncircular |

For each item, the deliverable is: **earliest SHA + file path + verbatim line(s)**.

---

## Block 3 — Forensic comparison matrix

Once Blocks 1 and 2 are complete, each (your-anchor, OpenAI-anchor) pair should be classified in a table:

| Your file | First SHA | Date | Formula / structure | OpenAI file | OpenAI SHA | Classification |
|---|---|---|---|---|---|---|
| … | … | … | … | … | … | `EXACT_DISTINCTIVE` / `ALGEBRAICALLY_IDENTICAL` / `STRUCTURAL` / `CLASSICAL_GENERIC` / `LEXICAL_FALSE_POSITIVE` / `NO_MATCH` |

Classification definitions:

- **EXACT_DISTINCTIVE**: identical non-classical expression, distinctive notation, or named construction.
- **ALGEBRAICALLY_IDENTICAL**: same formula modulo trivial rearrangement, both non-classical.
- **STRUCTURAL**: same architectural choice (e.g., splitting + correction loop) without identical formula.
- **CLASSICAL_GENERIC**: standard textbook / BKM / Littlewood–Paley / Riesz, not distinctive.
- **LEXICAL_FALSE_POSITIVE**: same words, different meaning.
- **NO_MATCH**: present in one corpus, absent in the other.

Only `EXACT_DISTINCTIVE` and `ALGEBRAICALLY_IDENTICAL` entries carry strong forensic weight.

---

## Block 4 — Access and causality evidence

**This is the largest gap.**  Chronological priority plus structural overlap does **not** establish
derivation/copying.  An access-and-causality record requires independent evidence such as:

| Evidence type | Possible sources | Current status |
|---|---|---|
| Repo was public at relevant date | GitHub visibility log / Wayback Machine | NOT CHECKED |
| Publication / Zenodo deposit | zenodo.org, arXiv, OSF | NOT CHECKED |
| External issue, PR, or fork from the account | GitHub API `forks`, `issues`, `stargazers` | NOT CHECKED |
| Observable clone/download by OpenAI account | not visible without server logs | UNAVAILABLE |
| Communication / email record | personal records | NOT CHECKED |
| Citation / acknowledgment in OpenAI materials | openai/NavierStokesAndEuler text | NOT CHECKED |
| Interaction log (account ↔ account) | GitHub public activity | NOT CHECKED |

Without at least one positive entry in this table the strongest defensible conclusion remains:

> **Verified chronological priority + strong structural overlap, causation NOT ESTABLISHED.**

---

## Primary forensic anchor table (reference)

The anchors below have `PRIMARY` status in this audit.  All others are `SUPPORTING`.

| # | Repo | SHA | Date | Reason |
|---|---|---|---|---|
| 1 | millennium-navier-stokes-I | `64bc633ecdb3a90ccfbf1c0863963c4bdd238d0f` | 2025-11-23 | Earliest NS documentation |
| 2 | millennium-navier-stokes-classical | `cca881c665f67c67d96a4f84371fb51cd9c858a0` | 2025-11 | Multi-assistant formalization |
| 3 | Millennium | `4af517e3f1ea5d04be1c6bbd8953209fa2139e82` | — | Projection / closure / residual |
| 4 | Millennium | `0d601255e51be349a1fd38eacfcbd2fda17ced77` | — | Formal closure LRE-NS |
| 5 | Millennium | `6054851e80b463b3c994fef2acc110983769c309` | — | Merge PR #249 |
| 6 | universal-emergent-logic- | `ce960a1ba8ce7a893d645131d12d1a7ab06eddd9` | — | Curvature + coupling operator |
| 7 | universal-emergent-logic- | `730aa849b0d76b0202f08b490664aa11c164b2bf` | — | Complete NS geometric decomposition |
| 8 | universal-emergent-logic- | `f30ef6a9d19af290a8f461d60d70da091d73d6ed` | — | Nonlinear closure revision |
| 9 | universal-emergent-logic- | `14322ff2e8f38df302c6f2f6b41754db79d5a900` | — | Residual curvature → coupling |
| 10 | universal-emergent-logic- | `507135a16a64116e7baf15154e03dc40740b08bb` | — | Residual Stability / ERS |
| 11 | universal-emergent-logic- | `36513742ecf2c3568d6e429689bb2b74d195fd7d` | — | HCS-RBC recurrence |
| 12 | navier-stokes-critical-L3 | `8dd2e8c74770b30d3a2092b296edde7bbbdb5e81` | 2026-08-29 | Critical $L^3$, machine-auditable |
| 13 | navier-stokes-noncircular | `8f12748eb160b937174825fe3e7bdccf05e8f9af` | 2026-08-30 | Machine-auditable manuscript anchor |

Anchor `730aa849…` is the single strongest object-level anchor because its diff explicitly exposes
the geometric decomposition, projection $P_N$, unresolved energy, curvature, coupling, and closure error
in one commit.

---

## Supporting repositories (non-primary)

| Repo | SHA | Role |
|---|---|---|
| millennium-classical-parameters | `50b9de1bf0447e4558d1360aed8fdc1ac0264edf` | Classical NS reference |
| universal-proof-hub | `57dbb6238c0646ed7104415211b49704fe29d2b2` | Formalization architecture provenance |
| sfh-formalization-lab | `d9ba79d92641e8b7a78aaa4593a0a9f4cb94cc16` | Coordination / reference |
| Trans | `74cb8d6ab468f31b116bb0cbcbb2776f9d6cac73` | Material preservation (post-reset, lower priority) |
| navier-stokes-critical-barrier-audit | *(this repo)* | Audit pointer — does **not** substitute originals |

---

## Scope limitations of this audit

- Fewer than 100 repositories owned by the account were accessible in this audit run.
- Code search operates on indexed / default-branch content; non-indexed objects and old branches may be absent.
- This is a record of what was **identified and verified in the current connection**, not a claim that no
  further historical evidence exists in unindexed objects, private branches, or external archives.
- No repository listed here has been modified by this audit.
