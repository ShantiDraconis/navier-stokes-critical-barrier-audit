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

/-- Pure x_k direction in the product model R x R^3. -/
def productSpatialDirection (k : Fin 3) : ProductSpaceTime :=
  (0, EuclideanSpace.single k 1)

/-- The coordinate split sends the canonical R^4 spatial basis direction to
exactly the pure x_k product direction. -/
theorem spaceTimeProductCLE_spatialDirection (k : Fin 3) :
    spaceTimeProductCLE (spatialDirection k) = productSpatialDirection k := by
  fin_cases k
  all_goals
    apply Prod.ext
    · ext i
      fin_cases i
      simp [spaceTimeProductCLE, spaceTimeSplitL2, spaceTimeReindex,
        reindexedSplit, firstFactorToReal, spatialDirection,
        productSpatialDirection, finFourEquivTimeSpace, realSingletonONB,
        PiLp.sumPiLpEquivProdLpPiLp]
    · ext j
      fin_cases j <;>
        simp [spaceTimeProductCLE, spaceTimeSplitL2, spaceTimeReindex,
          reindexedSplit, firstFactorToReal, spatialDirection,
          productSpatialDirection, finFourEquivTimeSpace, realSingletonONB,
          PiLp.sumPiLpEquivProdLpPiLp]

inductive SpaceTimeSpatialDirectionStatus
  | pureSpatialDirectionDefined
  | canonicalSpatialDirectionIdentified
  deriving DecidableEq, Repr

end G1Audit
