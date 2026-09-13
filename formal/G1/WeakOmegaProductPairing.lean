/-
WeakOmegaProductPairing.lean

Transport the already-proved R^4 weak spatial derivative pairing to Schwartz
tests on the genuine product space R x R^3.

This file deliberately stops before separated alpha(t) psi(x) factorization and
Fubini.  It closes the coordinate/Schwartz derivative transport arrow without
claiming a fixed-time H1_x representative.
-/

import G1.SpaceTimeCoordinateSplit
import G1.WeakOmega4DPairing
import Mathlib.Analysis.Distribution.SchwartzSpace.Deriv

noncomputable section

open MeasureTheory TemperedDistribution
open scoped LineDeriv

namespace G1Audit

/-- Pull a product-space Schwartz test back to R^4 through the coordinate CLE. -/
def productSchwartzPullback (Phi : 𝓢(ProductSpaceTime, ℂ)) : 𝓢(SpaceTime, ℂ) :=
  SchwartzMap.compCLMOfContinuousLinearEquiv ℂ spaceTimeProductCLE Phi

@[simp]
theorem productSchwartzPullback_apply
    (Phi : 𝓢(ProductSpaceTime, ℂ)) (z : SpaceTime) :
    productSchwartzPullback Phi z = Phi (spaceTimeToProduct z) := by
  rfl

/-- Line derivatives commute with the coordinate pullback. -/
theorem lineDeriv_productSchwartzPullback
    (m : SpaceTime) (Phi : 𝓢(ProductSpaceTime, ℂ)) :
    ∂_{m} (productSchwartzPullback Phi) =
      productSchwartzPullback (∂_{spaceTimeProductCLE m} Phi) := by
  exact SchwartzMap.lineDerivOp_compCLMOfContinuousLinearEquiv
    m spaceTimeProductCLE Phi

/-- Negation also commutes definitionally with the product Schwartz pullback. -/
theorem neg_lineDeriv_productSchwartzPullback
    (m : SpaceTime) (Phi : 𝓢(ProductSpaceTime, ℂ)) :
    -(∂_{m} (productSchwartzPullback Phi)) =
      productSchwartzPullback (-(∂_{spaceTimeProductCLE m} Phi)) := by
  rw [lineDeriv_productSchwartzPullback]
  rfl

/--
The R^4 weak derivative pairing, rewritten for an arbitrary product-space
Schwartz test.  The derivative direction on the product side is exactly the
image of the canonical R^4 spatial direction under the coordinate equivalence.
-/
theorem WeakOmegaSpaceTime.weakDx_productSchwartz_pairing
    (h : WeakOmegaSpaceTime) (i k : Fin 3)
    (Phi : 𝓢(ProductSpaceTime, ℂ)) :
    (h.weakDxL2 i k : ScalarDist) (productSchwartzPullback Phi) =
      (h.omegaL2 i : ScalarDist)
        (productSchwartzPullback (-(∂_{spaceTimeProductCLE (spatialDirection k)} Phi))) := by
  rw [h.weakDx_schwartz_pairing i k (productSchwartzPullback Phi)]
  congr 1
  exact neg_lineDeriv_productSchwartzPullback (spatialDirection k) Phi

inductive WeakOmegaProductPairingStatus
  | productSchwartzPullbackDefined
  | derivativeCommutesWithPullbackProved
  | productSchwartzWeakPairingProved
  | canonicalProductSpatialDirectionOpen
  | separatedCompactProductTestOpen
  | productFubiniReductionOpen
  | commonAETimeDensePassageOpen
  deriving DecidableEq, Repr

end G1Audit
