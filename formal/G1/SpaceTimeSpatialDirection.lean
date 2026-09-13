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

/-- Pure x_k direction in the product model R x R^3. -/
def productSpatialDirection (k : Fin 3) : ProductSpaceTime :=
  (0, EuclideanSpace.single k 1)

/-- The coordinate split sends the canonical R^4 spatial basis direction to
exactly the pure x_k product direction. -/
theorem spaceTimeProductCLE_spatialDirection (k : Fin 3) :
    spaceTimeProductCLE (spatialDirection k) = productSpatialDirection k := by
  simp [spaceTimeProductCLE, spaceTimeSplitL2, spaceTimeReindex,
    reindexedSplit, firstFactorToReal, spatialDirection,
    productSpatialDirection, realSingletonONB,
    PiLp.sumPiLpEquivProdLpPiLp]
  constructor
  · rfl
  · change WithLp.toLp 2 (fun j : Fin 3 => Pi.single (Sum.inr k) 1 (Sum.inr j)) =
      WithLp.toLp 2 (Pi.single k 1)
    congr 1
    funext j
    simp [Pi.single_apply]

inductive SpaceTimeSpatialDirectionStatus
  | pureSpatialDirectionDefined
  | finFourSpatialReindexProved
  | canonicalSpatialDirectionIdentified
  deriving DecidableEq, Repr

end G1Audit
