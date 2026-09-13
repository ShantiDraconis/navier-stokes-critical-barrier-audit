# 15 — Projection / representative / residual chain audit map

## Scope of this note

For the specific chain now under audit,

\[
\text{projection} \to \text{reference or closure representative} \to \text{residual} \to \text{high-frequency component} \to \text{coupling} \to \text{dynamical correction},
\]

the central pre-2026 prior-work corpus should be restricted to the following three repositories:

1. `ShantiDraconis/millennium-navier-stokes-I`
2. `ShantiDraconis/millennium-navier-stokes-classical`
3. `ShantiDraconis/Millennium`

Other repositories may still matter for broader chronology, but they are **secondary** unless they contribute a directly exported file or formula to this exact chain.

## Audit-safe provenance boundary

- `63b248dd29f1817c457acdb00e116e2e9b0687cc` in `millennium-navier-stokes-I` is already independently captured in this repository.
- `867045e966812b50b2304f0460288cf6449d8221` in `millennium-navier-stokes-classical` is already independently captured in this repository.
- The December 2025 `Millennium` cluster around `4af517e3f1ea5d04be1c6bbd8953209fa2139e82` is presently a **reported / recovered** anchor pending full local export, but it is the key chronological location for the closure-residual architecture now under comparison.

Recovered content associated with the 2025-12-18 `Millennium` cluster reportedly contains

\[
\mathcal C = \iota \circ \pi,\qquad \operatorname{Res}(u)=u-\mathcal C(u),
\]

together with explicit `C`, `D`, `\pi`, `\iota`, `R`, and closure-operator language. That makes this cluster the most important prior target for the present chain audit.

## Central prior-work anchors

| Repository | Anchor(s) | Current status in this repo | Why it matters for this chain |
| --- | --- | --- | --- |
| `millennium-navier-stokes-I` | `64bc633ecdb3a90ccfbf1c0863963c4bdd238d0f` to `63b248dd29f1817c457acdb00e116e2e9b0687cc` | earliest anchor reported; `63b248...` verified | establishes an early formal Navier–Stokes framework, collapse framing, and NS-specific proof infrastructure |
| `millennium-navier-stokes-classical` | `cca881c665f67c67d96a4f84371fb51cd9c858a0`, `867045e966812b50b2304f0460288cf6449d8221` | `867045...` verified; `cca881...` reported | formalization layer (Lean/Coq/Isabelle) and functional-space / classical regularity organization |
| `Millennium` | `4af517e3f1ea5d04be1c6bbd8953209fa2139e82`, `b9b4768206ee3d817cbbaf35bb7da92dc835c4e1`, `0d601255e51be349a1fd38eacfcbd2fda17ced77`, `6054851e80b463b3c994fef2acc110983769c309` | reported / recovered anchors pending local file export | projection-obstruction, closure, residual, and Clay-oriented LRE-NS packaging |

## External Lean files and lemmas to audit, layer by layer

| Chain stage | External file(s) | Lemmas / declarations to inspect first | Why this is the right target | Prior corpus anchor to compare | Local audit files that should absorb findings |
| --- | --- | --- | --- | --- | --- |
| Projection | `NavierStokes/TangentProjection.lean` | `tangentProj_normal`, `projected_balance`, `pressure_cancellation`, `tangency_preserved` | this is the explicit projection-and-pressure algebra file; it isolates the cancellation identity used to keep the evolution tangent | `Millennium` `4af517e3...` and `6054851...` reported projection/obstruction content | `audit/06_pressure_compatibility_test.md`, `audit/09_required_cancellations.md`, `audit/14_openai_formula_provenance.md` |
| Reference / representative | `NavierStokes/PrimaryRepresentatives.lean` | `representative_mem`, `representative_enlarged_distance`, `representative_parameter_bounds`, `representative_target_choice`, `representative_target_margin` | this is where actual representatives are selected and given uniform geometric margins | `Millennium` closure/projection cluster; `millennium-navier-stokes-classical` formalization anchors | `audit/14_openai_formula_provenance.md`, this file |
| Reference jet / microlocal control | `NavierStokes/ReferenceJetBounds.lean` | `JetBounds`, `exists_transition_control`, `reference_U_radial_bound`, `bounds_of_control` | this is the strongest public “critical jets” location: ordered jet control on the reference path before the short transition is chosen | `Millennium` recovered `C,D,\pi,\iota,R` / closure language; `867045...` functional-space organization | `audit/08_scaling_exponents.md`, `audit/09_required_cancellations.md`, `audit/14_openai_formula_provenance.md` |
| Residual | `NavierStokes/BaseResidual.lean`, `NavierStokes/CorrectionStep.lean` | `baseResidual_identity`, `baseResidual_jetRate`, `fullResidual_decomposition`, `fullResidual_actual_update`, `fullGoodResidual_actual_update`, `meanGoodResidual_exact_errors` | these files define the residual and then track exactly how it changes under one correction cycle | `Millennium` `4af517e3...` / `6054851...` reported residual architecture; `63b248...` as early NS framework background | `audit/05_forcing_smoothness_test.md`, `audit/06_pressure_compatibility_test.md`, `audit/09_required_cancellations.md`, `audit/10_candidate_contradictions.md` |
| High-frequency / carrier component | `NavierStokes/ActualCurrentCarrierJets.lean`, `NavierStokes/PhysicalResidualJetBounds.lean` | `harmonic_carrier_eq`, `weightedPhase_positive_jets`, `weightedPhase_positive_jets_controlPatch`, `ResidualChartData.residual_jet_bound`, `ResidualChartData.residual_jetRate`, `finite_residual_rates` | this is the main public location where carrier-weighted phases and finite-state residual jet estimates become explicit | `Millennium` reported high-frequency residual / projection-obstruction cluster | `audit/03_L3_consistency_test.md`, `audit/08_scaling_exponents.md`, `audit/09_required_cancellations.md` |
| Coupling | `NavierStokes/PrimaryRepresentatives.lean`, `NavierStokes/ActualCorrectionModels.lean`, `NavierStokes/CorrectionStep.lean` | `coupling_eq`, `ReferenceCone.coupling_neg`, `representative_target_choice`, `sameCarrier_covarianceIncrement_mem`, `meanUpdate_residualBlock_mem` | this is where the representative geometry is tied to sign/margin conditions and then fed into same-carrier covariance updates | `Millennium` reported closure/coupling architecture and classical-formal scaffolding in `millennium-navier-stokes-classical` | `audit/04_energy_concentration_test.md`, `audit/09_required_cancellations.md`, `audit/10_candidate_contradictions.md` |
| Dynamical correction | `NavierStokes/CorrectionStep.lean` | `temporalStage_theta_exact`, `temporalStage_axial_exact`, `temporalStage_cumulative`, `rankStage_cumulative`, `fullResidual_harmonic_decomposition` | this is the exact public correction-cycle bookkeeping file; it tracks how residual pieces feed the next stage | `Millennium` reported dynamical closure/correction cluster and 2025-12-18 completion summaries | `audit/05_forcing_smoothness_test.md`, `audit/06_pressure_compatibility_test.md`, `audit/10_candidate_contradictions.md`, `audit/12_open_questions.md` |

## Maximum-priority file queue for the present audit

If only a small number of public files can be audited first, the order should be:

1. `NavierStokes/ReferenceJetBounds.lean`
2. `NavierStokes/ActualCurrentCarrierJets.lean`
3. `NavierStokes/PhysicalResidualJetBounds.lean`
4. `NavierStokes/CorrectionStep.lean`
5. `NavierStokes/TangentProjection.lean`
6. `NavierStokes/PrimaryRepresentatives.lean`
7. `NavierStokes/BaseResidual.lean`

This ordering matches the user-supplied chain and isolates the most distinctive non-classical layer before spending effort on broader PDE background files.

## What to verify in each pass

### 1. Projection pass

Check whether the public projection file is only tangent-pressure algebra or whether it is explicitly composed into a closure operator comparable to recovered `\mathcal C = \iota \circ \pi`.

### 2. Representative pass

Check whether “representative” means only point selection plus cone margins, or whether it already behaves like a closure/reference representative carrying stable jet data.

### 3. Residual pass

Check whether the public residual is merely a bookkeeping difference, or a structurally central obstruction term with its own decomposition and propagation law.

### 4. High-frequency / critical-jet pass

Check whether the carrier and jet files really encode the microlocal critical layer of the argument, including explicit powers of `Q`, positive-jet losses, and residual jet-rate bounds.

### 5. Coupling pass

Check whether coupling enters only through geometric sign conditions, or as a true residual-to-dynamics feedback mechanism.

### 6. Dynamical-correction pass

Check whether the correction stage closes the full chain

\[
\pi \to \mathcal C \to \operatorname{Res} \to \text{carrier/high-frequency control} \to \text{coupling} \to \text{next-stage correction},
\]

or whether some of these links remain only metaphorical / organizational.

## Current repository-policy consequence

- Use `priority/08_expanded_git_provenance_dossier.md` for chronology and repo-level anchor logging.
- Use this file for the exact chain-level audit queue.
- Do **not** upgrade the current `DISTINCTIVE_CONSTRUCTION_MATCH` status until file-level exports from the December 2025 `Millennium` cluster are locally archived and compared against the public jet / residual / correction files above.
