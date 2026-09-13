/-
SpaceTimeIntegralTransport.lean

Measurable-equivalence form of the already constructed volume-preserving
SpaceTime <-> R x R^3 coordinate split.  This is used to transport actual
Bochner/Lebesgue integrals, not to evaluate L2 classes on null slices.
-/

import G1.SpaceTimeCoordinateSplit
import Mathlib.Analysis.Normed.Lp.MeasurableSpace

noncomputable section

open MeasureTheory Module WithLp

namespace G1Audit

/-- Measurable equivalence underlying `spaceTimeToProduct`. -/
def spaceTimeProductMeasurableEquiv : SpaceTime ≃ᵐ ProductSpaceTime :=
  spaceTimeSplitL2.toHomeomorph.toMeasurableEquiv.trans
    (MeasurableEquiv.toLp 2 ProductSpaceTime).symm

@[simp]
theorem spaceTimeProductMeasurableEquiv_apply (z : SpaceTime) :
    spaceTimeProductMeasurableEquiv z = spaceTimeToProduct z := by
  rfl

@[simp]
theorem spaceTimeProductMeasurableEquiv_symm_apply (z : ProductSpaceTime) :
    spaceTimeProductMeasurableEquiv.symm z = productToSpaceTime z := by
  rfl

/-- Integral transport from R^4 to the product coordinates. -/
theorem integral_comp_productToSpaceTime (F : SpaceTime → ℂ) :
    ∫ z : ProductSpaceTime, F (productToSpaceTime z) =
      ∫ y : SpaceTime, F y := by
  have hmp : MeasurePreserving spaceTimeProductMeasurableEquiv.symm := by
    simpa using productToSpaceTime_measurePreserving
  simpa using hmp.integral_comp' F

/-- Integral transport in the forward coordinate direction. -/
theorem integral_comp_spaceTimeToProduct (F : ProductSpaceTime → ℂ) :
    ∫ z : SpaceTime, F (spaceTimeToProduct z) =
      ∫ y : ProductSpaceTime, F y := by
  have hmp : MeasurePreserving spaceTimeProductMeasurableEquiv := by
    simpa using spaceTimeToProduct_measurePreserving
  simpa using hmp.integral_comp' F

inductive SpaceTimeIntegralTransportStatus
  | measurableEquivalenceConstructed
  | inverseIntegralTransportProved
  | forwardIntegralTransportProved
  deriving DecidableEq, Repr

end G1Audit
