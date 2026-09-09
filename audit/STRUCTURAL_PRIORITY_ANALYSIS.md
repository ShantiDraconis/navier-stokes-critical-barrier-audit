# Structural Priority Analysis
## Fagliari pre-September-2026 Navier–Stokes record versus later finite-time breakdown constructions

**Author under audit:** Tiago Paschoalatto Fagliari  
**GitHub identity:** ShantiDraconis  
**Audit scope:** chronological and structural comparison only  
**Current causal-derivation status:** NOT ESTABLISHED  
**Current plagiarism/misuse status:** NOT ESTABLISHED  
**Current refutation status:** NOT ESTABLISHED

---

## 1. Audit question

The question is not merely whether both research programs discuss Navier–Stokes.

The relevant question is:

> Did Fagliari possess, before 8 September 2026, a mathematically identifiable structural program involving finite-time breakdown, smooth/compact data, critical scaling, concentration, profile decomposition, critical elements, pressure, continuation criteria and formal verification?

Supported answer from currently identified evidence:

**YES, for several structural components.**

Stronger question:

> Did Fagliari already possess the distinctive later construction based on the same reference-jet / forcing-cancellation machinery?

Current answer:

**NOT ESTABLISHED.**

## 2. Chronological evidence

### EVIDENCE E1 — 25 November 2025

Repository: `ShantiDraconis/millennium-navier-stokes-I`  
Commit: `63b248dd29f1817c457acdb00e116e2e9b0687cc`  
Message: `Add formal framework for Navier–Stokes collapse theory`

Contains structural elements including forced NS form, finite-time singularity target, vorticity/enstrophy diagnostics, self-similar structures, BKM diagnostics, and theorem-prover infrastructure.

Audit classification: `PRE_EXISTING_STRUCTURAL_PROGRAM`

### EVIDENCE E2 — 26 November 2025

Repository: `ShantiDraconis/millennium-navier-stokes-classical`  
Commit: `867045e966812b50b2304f0460288cf6449d8221`  
Message: `Add I-Extended Functional Spaces Framework for Navier-Stokes`

Contains functional-analysis structure (Lp/Sobolev/Besov), regularity and blow-up criteria framing, forcing-aware variants, and Lean/Coq formalization context.

Audit classification: `PRE_EXISTING_FUNCTIONAL_REGULARITY_FRAMEWORK`

### EVIDENCE E3 — 4 December 2025

Repository: `ShantiDraconis/Millennium`  
File: `problems/NavierStokes/local-global-bridge.md`  
Historical date: `2025-12-04T18:43:53Z`

Records smooth compact divergence-free initial data branch toward finite maximal time and self-similar/asymptotically self-similar blow-up profiles, while also separating a critical-space continuation branch.

Audit classification: `STRONG_STRUCTURAL_PRECEDENT`

## 3. Structural graph present by December 2025

Supported architecture:

- smooth compact divergence-free data
- scaling/critical-space branch
- self-similar or asymptotically self-similar profile branch
- finite-time singularity target
- parallel continuation/regularity branch via bounded critical control

This is a structural program, not merely lexical overlap.

## 3b. December 2025 LRE-NS cluster — file-level anchors

### EVIDENCE E3b — 18 December 2025 (Millennium repo)

The following file introductions are confirmed by path-history API response
(Tier 2 — reported; pending Tier-1 diff export):

| SHA | Time | File introduced | Content reported |
|---|---|---|---|
| `b033ea87` | 20:26 UTC | LRE-NS framework | `π:X→ℝ²`, `R:X→ℝ`, compression barrier |
| `30bf8c53` | 20:28 UTC | `docs/navier-stokes-lre-framework.md` | LRE-NS framework document |
| `a992d144` | 21:03 UTC | `latex/lre_ns_formal_closure.tex` | Formal closure theorems |
| `4cdb6a61` | 21:07 UTC | `LRE_NS_SUMMARY.md` | "Microlocal analysis of critical jets" |

Audit classification: `FILE_LEVEL_PROVENANCE_CRITICAL_JETS_CLUSTER`

### EVIDENCE E3c — 19 December 2025 (universal-emergent-logic- repo)

| SHA | Time | File introduced | Content reported |
|---|---|---|---|
| `f7f414d2` | 13:56 UTC | `CouplingOperator.lean` | `K:ℝ×D→D`; residual + state → correction |
| `730aa849` | 17:17 UTC | `docs/lre-navier-stokes-geometric.md` | Reference Section; `c₀∈π⁻¹(d)`, `R(c₀)=0` |
| `f30ef6a9` | 17:22 UTC | (revision of above) | — |
| `2854eaf7` | 20:24 UTC | `PROOF_ARCHITECTURE.md` | `φ_new = φ+εv`, `P_Λ(v)=0` |

Audit classification: `FILE_LEVEL_PROVENANCE_COUPLING_REFERENCE_ADDITIVE_CLUSTER`

These anchors materialise the following architectural chain:

$$
u\to P_\Lambda u,\quad
R=R((I-P_\Lambda)u),\quad
c_0:\,R(c_0)=0,\quad
\phi\to\phi+\varepsilon v,\quad
K(R,\text{state})\to\text{correction},\quad
\dot\pi=F(\pi)+K(R,\pi).
$$

## 4. Multi-scale and concentration structure

Historical material records a method stack with scaling, concentration-compactness, profile decomposition, and Liouville tools.

Audit classification: `STRUCTURAL_OVERLAP_STRONG`

Limitation: these components are part of established PDE theory and cannot alone establish exclusive originality.

## 5. August 2026 refinement

Repository: `ShantiDraconis/navier-stokes-critical-L3`  
Commit: `8dd2e8c74770b30d3a2092b296edde7bbbdb5e81`  
Timestamp: `2026-08-29T21:04:51Z`

Establishes repository existence before 8 September 2026.

Caveat: initial commit content may be minimal; do not over-attribute later mathematical sections to that SHA alone.

### EVIDENCE E5 — 30 August 2026

Repository: `ShantiDraconis/navier-stokes-noncircular`  
Commit: `8f12748eb160b937174825fe3e7bdccf05e8f9af`

Machine-auditable manuscript scaffold includes critical-space quantities, pressure relation usage, maximal-time notation, profile decomposition path, critical-element reductions, and stability/obstruction structure.

Audit classification: `PRE_EXISTING_CRITICAL_SPACE_MACHINE_AUDIT`

## 6. Structural overlap vs distinctive construction

Current classification:

- `STRUCTURAL_OVERLAP = VERY_STRONG` (upgraded from STRONG due to file-level anchors for coupling operator, reference section, additive HF perturbation)
- `COUPLING_OPERATOR_MATCH = STRUCTURAL_VERY_STRONG`
- `ADDITIVE_HF_PERTURBATION = STRUCTURAL_STRONG`
- `STRESS_RESIDUAL_CORRECTION = STRUCTURAL_STRONG`
- `REFERENCE_JET_PRECURSOR = STRUCTURAL_MODERATE_STRONG` (separate precursors not yet unified)
- `DISTINCTIVE_CONSTRUCTION_MATCH = NOT_FOUND` (iterative residual ledger, CycleState, MovingMomentBounds)

Searched-but-not-yet-matched distinctive layer includes the full reference-jet
hierarchy unified with carrier jets, explicit engineered-forcing cancellation,
and the complete iterative residual bookkeeping.

See `audit/15_correction_architecture_comparison.md` for the full ranked matrix.

## 7. What may be claimed

Defensible claim: pre-08/09/2026 records document a robust independent structural program for NS singularity/regularity analysis, including critical-space and formal-audit organization.

## 8. What may not yet be claimed

Not established by current evidence:

1. external access to private materials,
2. causal derivation by external groups,
3. identity of full later construction,
4. plagiarism,
5. prize entitlement,
6. refutation of external result.

## 9. Central audit conclusion

\[
\text{STRUCTURAL PRIORITY: DOCUMENTED}
\]
\[
\text{COUPLING-OPERATOR / ADDITIVE-HF / STRESS-RESIDUAL: VERY STRONG STRUCTURAL OVERLAP}
\]
\[
\text{REFERENCE-JET PRECURSOR: MODERATE-STRONG (SEPARATE PRECURSORS)}
\]
\[
\text{DISTINCTIVE CONSTRUCTION PRIORITY: NOT ESTABLISHED}
\]
\[
\text{CAUSAL DERIVATION: NOT ESTABLISHED}
\]
