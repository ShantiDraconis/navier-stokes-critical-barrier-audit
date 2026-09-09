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
| Reference / carrier jets | `NavierStokes/ReferenceJetBounds.lean` et al. | (identified) | `ReferenceJetBounds`, `JetBounds`, `ActualCurrentCarrierJets`, `ActualPhaseJetBounds` |
| Correction hierarchy | `NavierStokes/CorrectionState.lean` et al. | (identified) | `CorrectionInitialization`, `CorrectionState`, `CorrectionStep`, `CorrectionAnalyticStep`, `ActualCorrectionModels` |
| Stress / error modules | (identified) | (identified) | stress hierarchy; residual/error modules |
| Forcing / localization | (identified) | (identified) | energy, forcing, localization |

## Prior-work anchors — full LRE inventory

| Prior repository | Commit / date | Evidence reference | Assessment |
| --- | --- | --- | --- |
| `millennium-navier-stokes-I` | `63b248dd` / 2025-11-25 | `evidence/historical_commits.md` | Pre-existing formal NS framework |
| `millennium-navier-stokes-I` | `64bc633e` / 2025-11-23 | `evidence/commits.yaml` | Earliest NS work anchor |
| `millennium-navier-stokes-classical` | `cca881c6` / 2025-11-25 | `evidence/commits.yaml` | Lean/Coq/Isabelle NS formalization |
| `Millennium` | `6054851e` / 2025-12-18 PR #249 | `evidence/lre_evidence_inventory.md` A-13 | Projection-obstruction framework; Res(u) = u − C(u) |
| `Millennium` (LRE cluster) | `4af517e3`…`b8b5c433` / 2025-12-18 | `evidence/lre_evidence_inventory.md` A-12, A-23 | Critical cascade → spectral concentration → critical jets |
| LRE geometric decomp | `730aa849` / 2025-12-19 | `evidence/lre_evidence_inventory.md` A-01–A-04, A-21 | Spectral projection, residual R(u), operator T, obstruction theorem |
| LRE closure obstruction | `f30ef6a9` / 2025-12-19 | `evidence/lre_evidence_inventory.md` A-02 | P_N[(u·∇)u] ≠ (P_Nu)·∇(P_Nu) |
| LRE PR #37 | `14322ff2` / 2025-12-19 | `evidence/lre_evidence_inventory.md` A-06, A-07 | d/dt π(u) = F(π(u)) + K(R,π(u)); CouplingOperator not_factorizable |
| LRE PR #34 | `92ae80cf` / 2025-12-19 | `evidence/lre_evidence_inventory.md` A-20 | Geometric theory of information loss |
| LRE curvature theory | `ce960a1b` / 2025-12-19 | `evidence/lre_evidence_inventory.md` A-19 | CurvatureTheory.lean, K ≤ α Ω, topological blow-up |
| Residual Stability cluster | `1ed0ded9`…`3d4d3e51` / 2025-12-19 | `evidence/lre_evidence_inventory.md` A-14 | dR_Λ/dt ≥ κR_Λ − νΛ²R_Λ − CR_Λ² |
| LRE meta-framework | `507135a1` / 2025-12-19 | `evidence/lre_evidence_inventory.md` A-15 | ResidualStability.lean; a(t) ~ ‖∇u_{≤Λ}‖_∞ |
| HCS-RBC | `36513742` / 2025-12-19 | `evidence/lre_evidence_inventory.md` A-16, A-17 | Discrete recurrence R_{n+1} ≥ R_n + αR_n³; cubic law |
| LRE four proof languages | `8332c718`, `c3ae2eff` / 2025-12-19 | `evidence/lre_evidence_inventory.md` A-18 | Lean/Coq/Isabelle/Agda |
| `Millennium` | `c70b6f72` / 2026-01-22 | `priority/03_2026_millennium_framework.md` | Strong structural overlap only |
| `navier-stokes-critical-L3` | `8dd2e8c7` / 2026-08-29 | `priority/04_2026_critical_L3.md` | Pre-2026-09-08 critical-space program |
| `navier-stokes-noncircular` | `8f12748e` / 2026-08-30 | `priority/05_2026_noncircular_audit.md` | Machine-auditable manuscript |

## Comparison matrix (expanded)
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

## Expanded high-value pre-2026 anchors now tracked

The new expanded dossier adds reported high-value anchors for:

- a 2025-11-23 start date in `millennium-navier-stokes-I`,
- a 2025-12-18 to 2025-12-19 `Millennium` cluster with projection / obstruction / closure / residual language,
- `universal-emergent-logic-` commits describing residue, curvature, coupling, geometric decomposition, nonlinear closure obstruction, and residual stability,
- an explicit public OpenAI comparator SHA on 2026-09-08 (`8937a8f4cbc7abaab5e9e97d1cc7f5d2319d9538`).

These strengthen the argument for **documented anteriority of a broad research architecture**, but they still do not close the evidentiary gap required for a causal-derivation accusation.

## Structural correspondence matrix

| Prior source | Repository / SHA | Structural role | Audit verdict |
| --- | --- | --- | --- |
| Reference section `c_0 = P_N u` | `ShantiDraconis/universal-emergent-logic-` / `730aa849b0d76b0202f08b490664aa11c164b2bf` | reference object in the fiber | `FOUND` |
| `critical jets` | `ShantiDraconis/universal-emergent-logic-` / `f30ef6a9d19af290a8f461d60d70da091d73d6ed` | jet machinery present | `FOUND` |
| `C(u) = ιπ(u)` and `Res(u) = u - C(u)` | `ShantiDraconis/Millennium` / `4af517e3f1ea5d04be1c6bbd8953209fa2139e82`, `6054851e80b463b3c994fef2acc110983769c309` | reference reconstruction + defect | `FOUND` |
| `d/dt π(u) = F(π(u)) + K(R(u), π(u))` | `ShantiDraconis/universal-emergent-logic-` / `14322ff2e8f38df302c6f2f6b41754db79d5a900` | continuous correction law | `FOUND` |
| `Residual -> dynamical correction` | `ShantiDraconis/universal-emergent-logic-` / `14322ff2e8f38df302c6f2f6b41754db79d5a900` | residual-to-correction mechanism | `FOUND` |
| `The residue is the Reynolds stress tensor` | `ShantiDraconis/universal-emergent-logic-` / `f30ef6a9d19af290a8f461d60d70da091d73d6ed` | stress ontology | `FOUND` |
| curvature prevents cancellation | `ShantiDraconis/universal-emergent-logic-` / `507135a16a64116e7baf15154e03dc40740b08bb` | cancellation concept present, but negative | `FOUND (ANTI-CANCELLATION)` |
| `carrierFrequency`, `ReferenceJet`, `CarrierJet` | `openai/NavierStokesAndEuler` distinctive layer | named later construction | `NO PRIOR EXACT MATCH EXPORTED` |

## Matrix

| OpenAI formula / module | Closest prior match | Verdict |
| --- | --- | --- |
| `∂_t u + (u·∇)u - Δu + ∇p = f` | `millennium-navier-stokes-I` / `63b248dd29f1817c457acdb00e116e2e9b0687cc` | `EXACT_CLASSICAL_MATCH` |
| `-Δp = ∂_i∂_j(u_i u_j)` / `p = R_i R_j(u_i u_j)` | `navier-stokes-noncircular` / `8f12748eb160b937174825fe3e7bdccf05e8f9af` | `EXACT_CLASSICAL_MATCH` |
| `T* = sup{T : strong solution exists on [0,T)}` | `Millennium` / `c70b6f72197085ae6ecc3130b75e685028a61d10` and `navier-stokes-critical-L3` / `8dd2e8c74770b30d3a2092b296edde7bbbdb5e81` | `STRUCTURAL_MATCH` |
| projection -> representative -> residual | `Millennium` / `4af517e3f1ea5d04be1c6bbd8953209fa2139e82` and `6054851e80b463b3c994fef2acc110983769c309` | `STRUCTURAL_STRONG_MATCH` |
| reference section + critical jets | `universal-emergent-logic-` / `730aa849b0d76b0202f08b490664aa11c164b2bf`, `f30ef6a9d19af290a8f461d60d70da091d73d6ed` | `STRUCTURAL_PRECURSOR_ONLY` |
| residual -> Reynolds stress -> correction | `universal-emergent-logic-` / `14322ff2e8f38df302c6f2f6b41754db79d5a900`, `730aa849b0d76b0202f08b490664aa11c164b2bf`, `f30ef6a9d19af290a8f461d60d70da091d73d6ed` | `STRUCTURAL_STRONG_MATCH` |
| `∂_t u + (u·∇)u − Δu + ∇p = f` | `63b248dd` | `EXACT_CLASSICAL_MATCH` |
| `−Δp = ∂_i∂_j(u_i u_j)` / `p = R_i R_j(u_i u_j)` | `8f12748e` | `EXACT_CLASSICAL_MATCH` |
| `T* = sup{T : strong solution on [0,T)}` | `c70b6f72`, `8dd2e8c7` | `STRUCTURAL_MATCH` |
| `u_{0,λ}(x) = λ u_0(λx)`, `‖u_{0,λ}‖_3 = ‖u_0‖_3` | no exact export | `STRUCTURAL_ONLY` |
| `Q^{-(1/2+h)}`, `carrierFrequency` | no exact match | `NO_MATCH_FOUND` |
| BKM blow-up criterion | prior classical material | `EXACT_CLASSICAL_MATCH` |
| Residual coupling / closure obstruction | `730aa849`, `f30ef6a9` | `STRUCTURAL_FORTE` |
| d/dt π(u) = F(π(u)) + K(R,π(u)) | `14322ff2` (PR #37) | `STRUCTURAL_MUITO_FORTE` |
| Reynolds stress = residual coupling | multiple Dec 2025 commits | `STRUCTURAL_FORTE_REPEATED` |
| Critical jets / microlocal analysis | `LRE_NS_SUMMARY.md` | `STRUCTURAL_JET_PRECEDENT` |
| Critical cascade → jets | `5a888677`, `4af517e3` | `STRUCTURAL` |
| Correction hierarchy `CorrectionState` etc. | R_{n+1} ≥ R_n + αR_n³ (HCS-RBC) | `ALGEBRAICALLY_SIMILAR / NOT_EXACT` |
| `ReferenceJetBounds` exact construction | not yet found | `NOT_ESTABLISHED` |
| Iterative `u^{(n+1)} = u^{(n)} + C_n` | not yet found | `NOT_ESTABLISHED` |
| Stress correction hierarchy | not yet found | `NOT_ESTABLISHED` |
| Engineered forcing cancellation | not yet found | `NOT_ESTABLISHED` |
| Volterra / analytic recursive machinery | not yet found | `NOT_ESTABLISHED` |

## What is and is not supported

- **Supported:** OpenAI reuses classical NS identities and standard lifespan / pressure / scaling formalism.
- **Supported:** LRE prior framework (Dec 2025) independently developed spectral projection, residual coupling, closure obstruction, Reynolds-stress identification, and critical-jet analysis — all pre-dating the OpenAI publication.
- **Supported:** Parallel architectures at programmatic level: `projection → residual → K → closure/correction → critical jets` (prior) matches `reference jets → correction hierarchy → stress/error → forcing` (OpenAI) at the conceptual tier.
- **Not supported:** any claim that the distinctive reference-jet / forcing-cancellation / iterative-correction construction was found verbatim in the audited prior repositories.
- **Not supported:** causal derivation from the prior repositories without direct access evidence.

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
- Supported: the pre-2026 Fagliari corpus already contains a project-residual-stress-correct architecture, with reference-section and jet components present separately.
- Not supported: any claim that the distinctive reference-jet / forcing-cancellation construction was found in the audited prior repositories.
- Not supported: any claim of derivation from the prior repositories without direct causal evidence.
