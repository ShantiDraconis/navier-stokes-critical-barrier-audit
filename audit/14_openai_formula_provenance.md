# 14 — OpenAI formula provenance audit

## Conclusion

- Exact mathematical overlaps are present for standard Navier–Stokes identities.
- Current evidence does **not** establish access, copying, or causal derivation.
- The distinctive construction layer remains **NOT FOUND** in the audited prior work.

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
| `millennium-navier-stokes-I` | `64bc633e` / `2025-11-23` | `evidence/commits.yaml`, `audit/15_git_provenance_full.md` | Earliest NS SBFE/I collapse framework |
| `millennium-navier-stokes-classical` | `cca881c6` / `2025-11-25` | `evidence/commits.yaml` | Lean+Coq+Isabelle+Agda NS formalizations |
| `Millennium` | `4af517e3` / `2025-12-18` | `evidence/commits.yaml` | LRE projection-obstruction anchor |
| `Millennium` | `b9b47682`, `0d601255` / `2025-12-18` | `evidence/commits.yaml` | Complete formal closure LRE-NS |
| `Millennium` | `6054851e` / `2025-12-19` | `evidence/commits.yaml` | Explicit `u→π(u)→C(u)→Res(u)` chain |
| `universal-emergent-logic-` | `14322ff2` / `2025-12-19` | `evidence/commits.yaml` | `d/dt π(u)=F(π(u))+K(R(u),π(u))`; CouplingOperator (non-factorable) |
| `universal-emergent-logic-` | `730aa849` / `2025-12-19` | `evidence/commits.yaml` | NS geometric decomposition C,D,π,R |
| `universal-emergent-logic-` | `f30ef6a9` / `2025-12-19` | `evidence/commits.yaml` | `P_N[(u·∇)u] ≠ (P_Nu)·∇` |
| `universal-emergent-logic-` | `8b1aedfd` / `2025-12-19` | `evidence/commits.yaml` | NS blow-up via residual curvature |
| `Millennium` | `c70b6f72197085ae6ecc3130b75e685028a61d10` / `2026-01-22T07:55:11Z` | `priority/03_2026_millennium_framework.md`, `evidence/forensic_first_occurrence.csv` | Strong structural overlap only |
| `navier-stokes-critical-L3` | `8dd2e8c74770b30d3a2092b296edde7bbbdb5e81` / `2026-08-29T21:04:51Z` | `priority/04_2026_critical_L3.md`, `evidence/historical_commits.md` | Pre-2026-09-08 critical-space program |
| `navier-stokes-noncircular` | `8f12748eb160b937174825fe3e7bdccf05e8f9af` / `2026-08-30T11:10:45Z` | `priority/05_2026_noncircular_audit.md`, `evidence/forensic_first_occurrence.csv` | Machine-auditable manuscript track |

## Matrix

| OpenAI formula | Prior source in this audit | Verdict |
| --- | --- | --- |
| `∂_t u + (u·∇)u - Δu + ∇p = f` | `millennium-navier-stokes-I` / `63b248dd` | `EXACT_CLASSICAL_MATCH` |
| `-Δp = ∂_i∂_j(u_i u_j)` / `p = R_i R_j(u_i u_j)` | `navier-stokes-noncircular` / `8f12748e` | `EXACT_CLASSICAL_MATCH` |
| `T* = sup{T : strong solution exists on [0,T)}` | `Millennium` / `c70b6f72` and `navier-stokes-critical-L3` / `8dd2e8c7` | `STRUCTURAL_MATCH` |
| `u_{0,λ}(x) = λ u_0(λx)` and `‖u_{0,λ}‖_3 = ‖u_0‖_3` | no exact prior-match file exported in current evidence | `STRUCTURAL_ONLY` |
| `Q^{-(1/2+h)}`, `Q^{1/2}`, `Q^{1/2-h}`, `carrierFrequency` | no exact prior-match file exported in current evidence | `NO_MATCH_FOUND` |
| BKM / vorticity integral blow-up criterion | prior classical material only | `EXACT_CLASSICAL_MATCH` |
| `u = π(u) + R(u)` (spectral projection decomposition) | `Millennium` / `4af517e3` (2025-12-18) | `STRUCTURAL_MATCH` |
| High-frequency residual `R_Λ(u)` | `Millennium` / `4af517e3`, `0d601255` (2025-12-18) | `STRUCTURAL_MATCH` |
| `d/dt π(u) = F(π(u)) + K(R(u),π(u))` | `universal-emergent-logic-` / `14322ff2` (2025-12-19) | `STRUCTURAL_MATCH` |
| CouplingOperator (non-factorable by π alone) | `universal-emergent-logic-` / `14322ff2` (2025-12-19) | `STRUCTURAL_MATCH` |
| `P_N[(u·∇)u] ≠ (P_Nu)·∇` | `universal-emergent-logic-` / `f30ef6a9` (2025-12-19) | `STRUCTURAL_MATCH` |
| Residual Stability Inequality | `universal-emergent-logic-` / `1ed0ded9` (2025-12-19) | `STRUCTURAL_MATCH` |
| Lean NS formalization | `millennium-navier-stokes-classical` / `cca881c6` (2025-11-25) | `STRUCTURAL_MATCH` |

## What is and is not supported

- Supported: the OpenAI repo reuses classical Navier–Stokes identities and standard lifespan/pressure/scaling formalism.
- Not supported: any claim that the distinctive reference-jet / forcing-cancellation construction was found in the audited prior repositories.
- Not supported: any claim of derivation from the prior repositories without direct causal evidence.

