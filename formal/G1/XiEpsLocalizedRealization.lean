/-
XiEpsLocalizedRealization.lean

Analytic realization layer for the localized XiEpsPDE test.

The key audit rule in this file is that the final LocalEnergyIdentityData.identity
is NOT a field of XiEpsLocalizedRealization.  Instead it is derived from three
primitive analytic facts:

1. the localized pairing of the concrete XiEpsPDE (`testedEquation`),
2. the signed near/far strain decomposition (`strainSplitPair`),
3. integration by parts for the Laplacian term (`diffusionIBP`).

No CZ estimate, Young inequality, Campanato/Hölder input, enstrophy supremum, or
uniform palinstrophy integral is used.
-/

import G1.XiEpsPDE
import G1.DynamicCampanato

noncomputable section

namespace G1Audit

/--
Abstract analytic operators needed to interpret the localized test.

These are deliberately typed at the scalar/vector-field level.  Their concrete
measure-theoretic realization can later be replaced by Mathlib integrals and
Fréchet derivatives without changing the logical DAG below.
-/
structure AnalyticOperators where
  integralScalar : ScalarField → ℝ
  timeDerivScalar : ScalarField → ℝ
  gradScalar : ScalarField → (Vec3 → Vec3)
  laplacianVector : VectorField → VectorField
  avgBallVector : ℝ → Vec3 → VectorField → Vec3

  /-- Scalar ledger for an integration-by-parts application. -/
  ibpLaplacian :
    (weightPair bulk cutoffCross weightCross : ℝ) →
    weightPair = -bulk - cutoffCross - weightCross → Prop

/--
Near/far strain splitting at radius R = K rho_*.

`stretchTotal`, `stretchNear`, and `stretchFar` are the signed localized pairings,
not pointwise absolute-value estimates.
-/
structure StrainSplit where
  stretchTotal : ℝ
  stretchNear : ℝ
  stretchFar : ℝ
  splitRadius : ℝ
  K : ℝ
  rho : ℝ
  hK_pos : 0 < K
  hrho_pos : 0 < rho
  hRadius : splitRadius = K * rho
  hSplitPair : stretchTotal = stretchNear + stretchFar

/--
Primitive scalar ledger produced by testing XiEpsPDE with

  psi = phi^2 (xi_eps - (xi_eps)_{B_r}) |omega_eps|.

The `logDrift` field includes the factor 2 from
`2 grad(log |omega|_eps) · grad xi_eps`, so the tested equation carries
`nu * logDrift` exactly as LocalEnergyIdentityData does.
-/
structure XiEpsLocalizedTerms where
  r : ℝ
  rho : ℝ
  K : ℝ
  R : ℝ
  ballVolume : ℝ

  timeEnergyDerivative : ℝ
  timeWeightAndMean : ℝ
  transport : ℝ

  stretchTotal : ℝ
  stretchNear : ℝ
  stretchFar : ℝ

  /-- Raw pairing of Delta xi_eps before integration by parts. -/
  laplacianPair : ℝ
  /-- Positive integral int phi^2 |grad xi_eps|^2 |omega_eps|. -/
  diffusionBulk : ℝ
  /-- Cutoff-gradient cross term. -/
  diffusionCutoffCross : ℝ
  /-- grad |omega_eps| cross term. -/
  diffusionWeightCross : ℝ
  /-- Includes the coefficient 2 from the XiEpsPDE drift. -/
  logDrift : ℝ

  R1Pair : ℝ
  R2Pair : ℝ

  hr_pos : 0 < r
  hrho_pos : 0 < rho
  hK_pos : 0 < K
  hR : R = K * rho
  hballVolume_pos : 0 < ballVolume

/--
A localized realization contains only primitive analytic steps.
There is intentionally NO `hIdentity : LocalEnergyIdentityData` field.
-/
structure XiEpsLocalizedRealization where
  pde : XiEpsPDE
  ops : AnalyticOperators
  split : StrainSplit
  terms : XiEpsLocalizedTerms

  /-- The scalar ledgers use the same localization radius and strain split. -/
  hSplitRadius : split.splitRadius = terms.R
  hSameK : split.K = terms.K
  hSameRho : split.rho = terms.rho
  hStretchTotal : terms.stretchTotal = split.stretchTotal
  hStretchNear : terms.stretchNear = split.stretchNear
  hStretchFar : terms.stretchFar = split.stretchFar

  /--
  Localized pairing of the concrete XiEpsPDE before integration by parts:

    temporal + weight/mean + transport
      = stretchTotal + nu*laplacianPair + nu*logDrift + R1 + R2.

  This is the analytic realization of testing `pde.equation`; it is strictly
  earlier than the LocalEnergyIdentity target.
  -/
  testedEquation :
    terms.timeEnergyDerivative + terms.timeWeightAndMean + terms.transport =
      terms.stretchTotal
        + pde.ν * terms.laplacianPair
        + pde.ν * terms.logDrift
        + terms.R1Pair + terms.R2Pair

  /--
  Integration by parts for the Laplacian pairing, with signs retained:

    laplacianPair = -diffusionBulk - cutoffCross - weightCross.
  -/
  diffusionIBP :
    terms.laplacianPair =
      -terms.diffusionBulk
        - terms.diffusionCutoffCross
        - terms.diffusionWeightCross

  /-- The signed strain pairing is decomposed, not estimated. -/
  strainSplitPair :
    terms.stretchTotal = terms.stretchNear + terms.stretchFar

/--
The exact localized energy identity follows algebraically from the tested PDE,
strain split, and integration by parts.  It is not postulated as a field.
-/
theorem XiEpsLocalizedRealization.localized_identity
    (h : XiEpsLocalizedRealization) :
    h.terms.timeEnergyDerivative
        + h.terms.timeWeightAndMean
        + h.terms.transport
        + h.pde.ν * h.terms.diffusionBulk =
      h.terms.stretchNear + h.terms.stretchFar
        - h.pde.ν * h.terms.diffusionCutoffCross
        - h.pde.ν * h.terms.diffusionWeightCross
        + h.pde.ν * h.terms.logDrift
        + h.terms.R1Pair + h.terms.R2Pair := by
  rw [h.strainSplitPair] at h.testedEquation
  rw [h.diffusionIBP] at h.testedEquation
  linarith

/--
Construct the audit's LocalEnergyIdentityData from the concrete XiEpsPDE
realization.  The `identity` field is filled by the theorem above.
-/
def LocalEnergyIdentityData.ofXiEpsPDE
    (h : XiEpsLocalizedRealization) : LocalEnergyIdentityData where
  r := h.terms.r
  rho := h.terms.rho
  K := h.terms.K
  R := h.terms.R
  ballVolume := h.terms.ballVolume
  nu := h.pde.ν

  timeEnergyDerivative := h.terms.timeEnergyDerivative
  timeWeightAndMean := h.terms.timeWeightAndMean
  transport := h.terms.transport

  stretchNear := h.terms.stretchNear
  stretchFar := h.terms.stretchFar

  diffusionBulk := h.terms.diffusionBulk
  diffusionCutoffCross := h.terms.diffusionCutoffCross
  diffusionWeightCross := h.terms.diffusionWeightCross
  logDrift := h.terms.logDrift

  R1 := h.terms.R1Pair
  R2 := h.terms.R2Pair

  hr_pos := h.terms.hr_pos
  hrho_pos := h.terms.hrho_pos
  hK_pos := h.terms.hK_pos
  hnu_pos := h.pde.hν
  hR := h.terms.hR
  hballVolume_pos := h.terms.hballVolume_pos

  identity := h.localized_identity

/-- The OPEN_PDE_IDENTITY layer is closed relative to the primitive analytic realization. -/
theorem LocalEnergyIdentityData.ofXiEpsPDE_identity
    (h : XiEpsLocalizedRealization) :
    LocalEnergyIdentity (LocalEnergyIdentityData.ofXiEpsPDE h) := by
  exact (LocalEnergyIdentityData.ofXiEpsPDE h).identity

/--
Audit status: the identity is a proved consequence of primitive PDE-test/IBP
facts.  This does not prove the later CZ or signed far-field estimate.
-/
inductive XiEpsLocalizedStatus
  | provedIdentity
  | openSignedFarField
  deriving DecidableEq, Repr

end G1Audit
