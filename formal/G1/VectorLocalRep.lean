/-
VectorLocalRep.lean

Actual L2 representatives for componentwise weak first derivatives. No
second-order function representative is postulated.
-/

import G1.WeakDerivBridge
import Mathlib.Analysis.Calculus.BumpFunction.Convolution

noncomputable section

open MeasureTheory TemperedDistribution
open scoped LineDeriv Laplacian

namespace G1Audit

theorem WeakXiSpaceTime.exists_lineDeriv_L2_rep
    (h : WeakXiSpaceTime) (i : Fin 3) (m : SpaceTime) :
    ∃ v : Lp ℂ 2 (volume : Measure SpaceTime),
      (∂_{m} (h.xiDist i)) = (v : ScalarDist) := by
  exact memSobolev_zero_iff.mp (h.lineDeriv_memSobolev_zero i m)

def WeakXiSpaceTime.weakDtL2 (h : WeakXiSpaceTime) (i : Fin 3) :
    Lp ℂ 2 (volume : Measure SpaceTime) :=
  Classical.choose (h.exists_lineDeriv_L2_rep i timeDirection)

theorem WeakXiSpaceTime.weakDtL2_spec (h : WeakXiSpaceTime) (i : Fin 3) :
    h.dtDist i = (h.weakDtL2 i : ScalarDist) := by
  exact Classical.choose_spec (h.exists_lineDeriv_L2_rep i timeDirection)

def WeakXiSpaceTime.weakDirectionalL2
    (h : WeakXiSpaceTime) (i : Fin 3) (m : SpaceTime) :
    Lp ℂ 2 (volume : Measure SpaceTime) :=
  Classical.choose (h.exists_lineDeriv_L2_rep i m)

theorem WeakXiSpaceTime.weakDirectionalL2_spec
    (h : WeakXiSpaceTime) (i : Fin 3) (m : SpaceTime) :
    (∂_{m} (h.xiDist i)) = (h.weakDirectionalL2 i m : ScalarDist) := by
  exact Classical.choose_spec (h.exists_lineDeriv_L2_rep i m)

/-- Chosen L2 representative of ∂_{x_k} xi_i. -/
def WeakXiSpaceTime.weakDxL2
    (h : WeakXiSpaceTime) (i k : Fin 3) : Lp ℂ 2 (volume : Measure SpaceTime) :=
  h.weakDirectionalL2 i (spatialDirection k)

theorem WeakXiSpaceTime.weakDxL2_spec
    (h : WeakXiSpaceTime) (i k : Fin 3) :
    h.dxDist i k = (h.weakDxL2 i k : ScalarDist) := by
  exact h.weakDirectionalL2_spec i (spatialDirection k)

/-- Componentwise L2 weak spatial gradient: component i, direction k. -/
def WeakXiSpaceTime.weakSpatialGradientL2
    (h : WeakXiSpaceTime) : Fin 3 → Fin 3 → Lp ℂ 2 (volume : Measure SpaceTime) :=
  fun i k => h.weakDxL2 i k

inductive VectorLocalRepStatus
  | componentwiseFirstDerivativeL2Proved
  | componentwiseWeakTimeDerivativeL2Proved
  | threeSpatialDerivativeL2Representatives
  | spatialWeakGradientPackaged
  | vectorMollifierAPIAvailable
  | laplacianL1LocNotFromH1
  | weightedProductRuleStillOpen
  | materialProductStillOpen
  deriving DecidableEq, Repr

end G1Audit
