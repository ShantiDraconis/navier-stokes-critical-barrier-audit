/-
WeakOmega4DPairing.lean

The first genuinely distributional step in the fixed-time slicing argument.
For every Schwartz test on R^4, the chosen L2 representative of the weak
spatial derivative satisfies the defining distributional integration-by-parts
identity against the chosen L2 representative of omega.

This closes only the R^4 distribution-pairing arrow.  Transport of a separated
product test alpha(t) psi(x), Fubini, and the common-a.e.-time dense test family
remain separate obligations.  No H1_x slice or nonlinear chain rule is claimed.
-/

import G1.SpaceTimeCoordinateSplit

noncomputable section

open MeasureTheory TemperedDistribution
open scoped LineDeriv

namespace G1Audit

/--
The exact R^4 weak derivative pairing.  This is derived from
`WeakOmegaSpaceTime.weakDxL2_spec` and Mathlib's defining identity
`TemperedDistribution.lineDerivOp_apply_apply`; no pointwise derivative is used.
-/
theorem WeakOmegaSpaceTime.weakDx_schwartz_pairing
    (h : WeakOmegaSpaceTime) (i k : Fin 3) (Phi : 𝓢(SpaceTime, ℂ)) :
    (h.weakDxL2 i k : ScalarDist) Phi =
      (h.omegaL2 i : ScalarDist) (Neg.neg (∂_{spatialDirection k} Phi)) := by
  rw [← h.weakDxL2_spec i k]
  change h.dxDist i k Phi = _
  rw [WeakOmegaSpaceTime.dxDist]
  rw [TemperedDistribution.lineDerivOp_apply_apply]
  rw [h.omegaL2_spec i]

/--
Equivalent statement retaining `omegaDist` on the right.  Useful when the next
transport step is phrased directly at the tempered-distribution level.
-/
theorem WeakOmegaSpaceTime.weakDx_schwartz_pairing_dist
    (h : WeakOmegaSpaceTime) (i k : Fin 3) (Phi : 𝓢(SpaceTime, ℂ)) :
    (h.weakDxL2 i k : ScalarDist) Phi =
      h.omegaDist i (Neg.neg (∂_{spatialDirection k} Phi)) := by
  rw [← h.weakDxL2_spec i k]
  rfl

inductive WeakOmega4DPairingStatus
  | distributionalPairingProved
  | separatedProductTestTransportOpen
  | productFubiniReductionOpen
  | denseSpatialTestPassageOpen
  | fixedTimeH1Open
  deriving DecidableEq, Repr

end G1Audit