/-
WeakOmegaProductPairing.lean

Transport the already-proved R^4 weak spatial derivative pairing to Schwartz
tests on the genuine product space R x R^3.

This file stops before the Fubini/du-Bois-Reymond slicing step.  The product
spatial derivative direction itself is now fully identified with (0,e_k).
-/

import G1.SpaceTimeSpatialDirection
import G1.SpaceTimeIntegralTransport
import G1.WeakOmega4DPairing
import Mathlib.Analysis.Distribution.SchwartzSpace.Deriv

noncomputable section

open MeasureTheory TemperedDistribution
open scoped LineDeriv SchwartzMap

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
    (𝕜 := ℂ) (m := m) (g := spaceTimeProductCLE) (f := Phi)

/-- Negation also commutes definitionally with the product Schwartz pullback. -/
theorem neg_lineDeriv_productSchwartzPullback
    (m : SpaceTime) (Phi : 𝓢(ProductSpaceTime, ℂ)) :
    -(∂_{m} (productSchwartzPullback Phi)) =
      productSchwartzPullback (-(∂_{spaceTimeProductCLE m} Phi)) := by
  rw [lineDeriv_productSchwartzPullback]
  rfl

/-- R^4 weak spatial derivative pairing transported to the product coordinates. -/
theorem WeakOmegaSpaceTime.weakDx_productSchwartz_pairing
    (h : WeakOmegaSpaceTime) (i k : Fin 3)
    (Phi : 𝓢(ProductSpaceTime, ℂ)) :
    (h.weakDxL2 i k : ScalarDist) (productSchwartzPullback Phi) =
      (h.omegaL2 i : ScalarDist)
        (productSchwartzPullback (-(∂_{spaceTimeProductCLE (spatialDirection k)} Phi))) := by
  rw [h.weakDx_schwartz_pairing i k (productSchwartzPullback Phi)]
  congr 1
  exact neg_lineDeriv_productSchwartzPullback (spatialDirection k) Phi

/-- Same pairing with the derivative direction written canonically as (0,e_k). -/
theorem WeakOmegaSpaceTime.weakDx_productSpatial_pairing
    (h : WeakOmegaSpaceTime) (i k : Fin 3)
    (Phi : 𝓢(ProductSpaceTime, ℂ)) :
    (h.weakDxL2 i k : ScalarDist) (productSchwartzPullback Phi) =
      (h.omegaL2 i : ScalarDist)
        (productSchwartzPullback (-(∂_{productSpatialDirection k} Phi))) := by
  simpa [spaceTimeProductCLE_spatialDirection k] using
    h.weakDx_productSchwartz_pairing i k Phi

/--
The same weak-derivative identity as an honest integral identity on
`R x R^3`.  Both L2 factors are first transported by the inverse
measure-preserving coordinate map; no representative is evaluated on a
four-dimensional null slice.
-/
theorem WeakOmegaSpaceTime.weakDx_productSpatial_integral_pairing
    (h : WeakOmegaSpaceTime) (i k : Fin 3)
    (Phi : 𝓢(ProductSpaceTime, ℂ)) :
    (∫ z : ProductSpaceTime,
        Phi z * h.weakDxProd i k z ∂(volume : Measure ProductSpaceTime)) =
      ∫ z : ProductSpaceTime,
        (-(∂_{productSpatialDirection k} Phi) z) * h.omegaProd i z
          ∂(volume : Measure ProductSpaceTime) := by
  have hp := h.weakDx_productSpatial_pairing i k Phi
  simp only [MeasureTheory.Lp.toTemperedDistribution_apply, smul_eq_mul] at hp
  have hleft := integral_comp_productToSpaceTime
    (fun y : SpaceTime =>
      productSchwartzPullback Phi y * (h.weakDxL2 i k) y)
  have hright := integral_comp_productToSpaceTime
    (fun y : SpaceTime =>
      productSchwartzPullback (-(∂_{productSpatialDirection k} Phi)) y *
        (h.omegaL2 i) y)
  calc
    (∫ z : ProductSpaceTime,
        Phi z * h.weakDxProd i k z ∂(volume : Measure ProductSpaceTime)) =
        ∫ y : SpaceTime,
          productSchwartzPullback Phi y * (h.weakDxL2 i k) y := by
      simpa [WeakOmegaSpaceTime.weakDxProd, l2RepToProduct] using hleft
    _ = ∫ y : SpaceTime,
          productSchwartzPullback (-(∂_{productSpatialDirection k} Phi)) y *
            (h.omegaL2 i) y := hp
    _ = ∫ z : ProductSpaceTime,
          (-(∂_{productSpatialDirection k} Phi) z) * h.omegaProd i z
            ∂(volume : Measure ProductSpaceTime) := by
      calc
        _ = ∫ z : ProductSpaceTime,
              productSchwartzPullback (-(∂_{productSpatialDirection k} Phi))
                  (productToSpaceTime z) *
                (h.omegaL2 i) (productToSpaceTime z) := hright.symm
        _ = _ := by
          simp [WeakOmegaSpaceTime.omegaProd, l2RepToProduct]

inductive WeakOmegaProductPairingStatus
  | productSchwartzPullbackDefined
  | derivativeCommutesWithPullbackProved
  | productSchwartzWeakPairingProved
  | canonicalProductSpatialDirectionProved
  | productIntegralPairingProved
  | separatedCompactProductTestOpen
  | productFubiniReductionOpen
  | commonAETimeDensePassageOpen
  deriving DecidableEq, Repr

end G1Audit
