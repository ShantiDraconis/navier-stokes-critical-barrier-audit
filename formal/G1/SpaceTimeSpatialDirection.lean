/-
SpaceTimeSpatialDirection.lean

Audit-safe coordinate lemma identifying the canonical R^4 spatial directions
with the pure spatial directions in R x R^3.  This is the missing geometric
input for the separated tensor-product derivative formula.
-/

import G1.SpaceTimeCoordinateSplit

noncomputable section

open Module WithLp

namespace G1Audit

/-- The chosen Fin 4 = Fin 1 ⊕ Fin 3 reindexing sends coordinate k+1 to
exactly the spatial summand coordinate k. -/
@[simp]
theorem finFourEquivTimeSpace_spatial (k : Fin 3) :
    finFourEquivTimeSpace k.succ = Sum.inr k := by
  fin_cases k <;> rfl

/-- Pure x_k direction in the product model R x R^3. -/
def productSpatialDirection (k : Fin 3) : ProductSpaceTime :=
  (0, EuclideanSpace.single k 1)

/-- The coordinate split sends the canonical R^4 spatial basis direction to
exactly the pure x_k product direction. -/
theorem spaceTimeProductCLE_spatialDirection (k : Fin 3) :
    spaceTimeProductCLE (spatialDirection k) = productSpatialDirection k := by
  simp only [spaceTimeProductCLE, spaceTimeSplitL2, spaceTimeReindex,
    reindexedSplit, firstFactorToReal, spatialDirection,
    productSpatialDirection, realSingletonONB,
    LinearEquiv.coe_trans, LinearIsometryEquiv.coe_toLinearEquiv,
    ContinuousLinearEquiv.coe_trans, LinearIsometryEquiv.coe_toContinuousLinearEquiv,
    Function.comp_apply, LinearIsometryEquiv.piLpCongrLeft_single,
    finFourEquivTimeSpace_spatial, PiLp.sumPiLpEquivProdLpPiLp_apply,
    LinearIsometryEquiv.withLpProdCongr_apply, LinearIsometryEquiv.refl_apply,
    OrthonormalBasis.coe_repr, OrthonormalBasis.singleton_repr_apply,
    WithLp.ofLp_toLp]
  constructor
  · rfl
  · apply congrArg (WithLp.toLp 2)
    funext j
    simp [Pi.single_apply]

inductive SpaceTimeSpatialDirectionStatus
  | pureSpatialDirectionDefined
  | finFourSpatialReindexProved
  | canonicalSpatialDirectionIdentified
  deriving DecidableEq, Repr

end G1Audit
