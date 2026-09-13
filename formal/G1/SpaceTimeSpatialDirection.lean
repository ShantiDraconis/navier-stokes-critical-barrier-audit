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

@[simp]
theorem finFourEquivTimeSpace_spatial (k : Fin 3) :
    finFourEquivTimeSpace k.succ = Sum.inr k := by
  fin_cases k <;> rfl

/-- The first coordinate-reindexing stage sends e_{k+1} to the pure
`Sum.inr k` basis vector. -/
theorem spaceTimeReindex_spatialDirection (k : Fin 3) :
    spaceTimeReindex (spatialDirection k) =
      EuclideanSpace.single (Sum.inr k) 1 := by
  unfold spaceTimeReindex spatialDirection
  rw [EuclideanSpace.piLpCongrLeft_single]
  rw [finFourEquivTimeSpace_spatial]

/-- Pure x_k direction in the product model R x R^3. -/
def productSpatialDirection (k : Fin 3) : ProductSpaceTime :=
  (0, EuclideanSpace.single k 1)

/-- The coordinate split sends the canonical R^4 spatial basis direction to
exactly the pure x_k product direction. -/
theorem spaceTimeProductCLE_spatialDirection (k : Fin 3) :
    spaceTimeProductCLE (spatialDirection k) = productSpatialDirection k := by
  rw [spaceTimeProductCLE_apply]
  unfold spaceTimeToProduct spaceTimeSplitL2
  simp only [LinearIsometryEquiv.trans_apply]
  rw [spaceTimeReindex_spatialDirection]
  simp only [reindexedSplit, firstFactorToReal, productSpatialDirection,
    realSingletonONB, PiLp.sumPiLpEquivProdLpPiLp, Prod.mk.injEq]
  constructor
  · rfl
  · ext j
    simp [EuclideanSpace.single, PiLp.single_apply]

inductive SpaceTimeSpatialDirectionStatus
  | pureSpatialDirectionDefined
  | finFourSpatialReindexProved
  | firstReindexSpatialDirectionProved
  | canonicalSpatialDirectionIdentified
  deriving DecidableEq, Repr

end G1Audit
