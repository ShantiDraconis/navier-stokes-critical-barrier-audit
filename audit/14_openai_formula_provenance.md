# 14 — OpenAI formula provenance audit

## Conclusion

- Exact mathematical overlaps are present for standard Navier–Stokes identities.
- Current evidence does **not** establish access, copying, or causal derivation.
- The distinctive construction layer remains **NOT FOUND** in the audited prior work.
- The expanded dossier in `priority/08_expanded_git_provenance_dossier.md` materially strengthens the chronology and structural-overlap record, but its newly added anchors should still be separated into verified versus reported tiers.
- For the ordered projection → representative → residual → carrier/jet → coupling → correction chain, see `audit/15_projection_chain_audit_map.md`.

## Exact OpenAI locations

| Formula class | OpenAI file | OpenAI SHA | What it states |
| --- | --- | --- | --- |
| Forced NS residual | `NavierStokes/ProblemStatement.lean` | `f58563f682784537e1988552e5fb209210ea8300` | `navierStokesResidual := temporalDerivative + advection - spatialLaplacian + pressureGradient` |
| Pressure / Riesz operator | `NavierStokes/R3PressureFourier.lean` | `950fe135d4e891c14d3e82f553b7731fc3eafda3` | `pressureL1` is `R_i R_j f`, with Poisson identity for the stress-pressure source |
| Space-time pressure operator | `NavierStokes/R3SpaceTimePressure.lean` | `93974fbff50f228c98fda504266efa14ca8383de` | Same normalized pressure operator on space-time data |
| Maximal lifespan | `NavierStokes/MaximalLifespan.lean` | `83968db431a7327110e9ea10c6196dc3e39d5323` | `admissibleLifespans`, `IsMaximalClassicalSolution`, `IsGreatest` |
| Scaling / carrier frequency | `NavierStokes/Scaling.lean` | `5e7b0c90d02f2918261132127b758699ee2ba21c` | `coreVelocity`, `radialLength`, `axialLength`, `carrierFrequency`, `waveLength` |
| Consequence package | `NavierStokes/CandidateConsequences.lean` | `5f3eae72b029ea2503f9c2eaa20a1b11685062ff` | Packages maximal lifespan, Sobolev blow-up, and force decay consequences |

## Prior-work anchors already recorded in this audit

| Prior repository | Commit / date | Evidence in this repo | Assessment |
| --- | --- | --- | --- |
| `millennium-navier-stokes-I` | `63b248dd29f1817c457acdb00e116e2e9b0687cc` / `2025-11-25T15:47:20Z` | `evidence/historical_commits.md`, `priority/01_2025_navier_stokes_formal_framework.md` | Pre-existing formal NS framework |
| `Millennium` | `c70b6f72197085ae6ecc3130b75e685028a61d10` / `2026-01-22T07:55:11Z` | `priority/03_2026_millennium_framework.md`, `evidence/forensic_first_occurrence.csv` | Strong structural overlap only |
| `navier-stokes-critical-L3` | `8dd2e8c74770b30d3a2092b296edde7bbbdb5e81` / `2026-08-29T21:04:51Z` | `priority/04_2026_critical_L3.md`, `evidence/historical_commits.md` | Pre-2026-09-08 critical-space program |
| `navier-stokes-noncircular` | `8f12748eb160b937174825fe3e7bdccf05e8f9af` / `2026-08-30T11:10:45Z` | `priority/05_2026_noncircular_audit.md`, `evidence/forensic_first_occurrence.csv` | Machine-auditable manuscript track |

## Expanded high-value pre-2026 anchors now tracked

The new expanded dossier adds reported high-value anchors for:

- a 2025-11-23 start date in `millennium-navier-stokes-I`,
- a 2025-12-18 to 2025-12-19 `Millennium` cluster with projection / obstruction / closure / residual language,
- `universal-emergent-logic-` commits describing residue, curvature, coupling, geometric decomposition, nonlinear closure obstruction, and residual stability,
- an explicit public OpenAI comparator SHA on 2026-09-08 (`8937a8f4cbc7abaab5e9e97d1cc7f5d2319d9538`).

These strengthen the argument for **documented anteriority of a broad research architecture**, but they still do not close the evidentiary gap required for a causal-derivation accusation.

### File-level anchors confirmed by path-history API (Tier 2)

| File (prior repo) | Intro SHA | Date | Reported content |
|---|---|---|---|
| `docs/navier-stokes-lre-framework.md` (Millennium) | `30bf8c53` | 2025-12-18T20:28:57Z | LRE-NS framework first commit |
| `latex/lre_ns_formal_closure.tex` (Millennium) | `a992d144` | 2025-12-18T21:03:13Z | Formal closure theorems |
| `LRE_NS_SUMMARY.md` (Millennium) | `4cdb6a61` | 2025-12-18T21:07:43Z | "Microlocal analysis of critical jets" |
| `formalization/lean/LRE/CouplingOperator.lean` (universal-emergent-logic-) | `f7f414d2` | 2025-12-19T13:56:01Z | `K:ℝ×D→D`; residual + state → correction |
| `docs/lre-navier-stokes-geometric.md` (universal-emergent-logic-) | `730aa849` | 2025-12-19T17:17:28Z | Reference Section; `c₀`, `R(c₀)=0` |
| `formalization/lean/LRE/NavierStokes/PROOF_ARCHITECTURE.md` (universal-emergent-logic-) | `2854eaf7` | 2025-12-19T20:24:44Z | `φ_new = φ + εv`, `P_Λ(v)=0` |

See `audit/15_correction_architecture_comparison.md` for the full structural analysis.

## Matrix

| OpenAI formula | Prior source in this audit | Verdict |
| --- | --- | --- |
| `∂_t u + (u·∇)u - Δu + ∇p = f` | `millennium-navier-stokes-I` / `63b248dd29f1817c457acdb00e116e2e9b0687cc` | `EXACT_CLASSICAL_MATCH` |
| `-Δp = ∂_i∂_j(u_i u_j)` / `p = R_i R_j(u_i u_j)` | `navier-stokes-noncircular` / `8f12748eb160b937174825fe3e7bdccf05e8f9af` | `EXACT_CLASSICAL_MATCH` |
| `T* = sup{T : strong solution exists on [0,T)}` | `Millennium` / `c70b6f72197085ae6ecc3130b75e685028a61d10` and `navier-stokes-critical-L3` / `8dd2e8c74770b30d3a2092b296edde7bbbdb5e81` | `STRUCTURAL_MATCH` |
| `u_{0,λ}(x) = λ u_0(λx)` and `‖u_{0,λ}‖_3 = ‖u_0‖_3` | no exact prior-match file exported in current evidence | `STRUCTURAL_ONLY` |
| `Q^{-(1/2+h)}`, `Q^{1/2}`, `Q^{1/2-h}`, `carrierFrequency` | no exact prior-match file exported in current evidence | `NO_MATCH_FOUND` |
| BKM / vorticity integral blow-up criterion | prior classical material only | `EXACT_CLASSICAL_MATCH` |
| `CorrectionStep`: `m_new = updated(m,h)`, `W_new = W + X` | `CouplingOperator.lean` `f7f414d2` / `PROOF_ARCHITECTURE.md` `2854eaf7` (19/12/2025) | `STRUCTURAL_VERY_STRONG` |
| `covarianceChange(X)` in residual difference | Reynolds stress = residual coupling (multiple commits, `universal-emergent-logic-`) | `STRUCTURAL_STRONG` |
| `section ReferenceJets` / `ReferenceJetBounds.lean` | `730aa849` reference section `c₀`, `R(c₀)=0` + `4cdb6a61` critical jets | `STRUCTURAL_MODERATE_STRONG` (separate precursors) |
| Iterative residual ledger `R_{q+1} - R_q = all cross terms` | Not found at NS level; closest: RBC `R_{n+1}-R_n ≥ αR_n³` | `NOT_FOUND` |
| `MovingMomentBounds` / mean/defect/wave increments / gauge debt | Only classical momentum conservation | `NO_MATCH` |
| `StressActivation` / `TransitionRamp` | Spectral cutoff `P_Λ` found; activation primitive not matched | `NOT_MATCHED` |
| Engineered forcing cancellation `f_correction = -Residual` | Residual feedback and forcing found; precise cancellation not established | `NOT_ESTABLISHED` |

## What is and is not supported

- Supported: the OpenAI repo reuses classical Navier–Stokes identities and standard lifespan/pressure/scaling formalism.
- Supported: very strong structural overlap exists between the prior K(R,d) coupling-operator architecture and the OpenAI CorrectionStep cycle-state architecture.
- Supported: strong structural overlap exists between the prior Reynolds-stress/residual-coupling language and the OpenAI covariance-change/residual-difference language.
- Supported: the prior corpus contains additive high-frequency perturbation φ+εv and a reference section c₀ with R(c₀)=0 separately, both dated December 2025.
- Not supported: any claim that the distinctive reference-jet / forcing-cancellation construction was found **unified** in the audited prior repositories.
- Not supported: any claim of derivation from the prior repositories without direct causal evidence.
- Not supported: that the full iterative residual ledger R_{q+1}−R_q or MovingMomentBounds has a prior-corpus match.
