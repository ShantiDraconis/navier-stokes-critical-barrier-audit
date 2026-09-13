/-
VectorLocalRep.lean

Actual L2 representatives for the componentwise weak first derivatives created
in WeakDerivBridge.  No second-order representative is postulated.
-/

import G1.WeakDerivBridge
import Mathlib.Analysis.Calculus.BumpFunction.Convolution

noncomputable section

open MeasureTheory TemperedDistribution
open scoped LineDeriv Laplacian

namespace G1Audit

/-- Every componentwise first weak derivative of xi_eps has a global L2 representative. -/
theorem WeakXiSpaceTime.exists_lineDeriv_L2_rep
    (h : WeakXiSpaceTime) (i : Fin 3) (m : SpaceTime) :
    ∃ v : Lp ℂ 2 (volume : Measure SpaceTime),
      (∂_{m} (h.xiDist i)) = (v : ScalarDist) := by
  exact memSobolev_zero_iff.mp (h.lineDeriv_memSobolev_zero i m)

/-- Chosen L2 representative of component i of the weak time derivative. -/
def WeakXiSpaceTime.weakDtL2 (h : WeakXiSpaceTime) (i : Fin 3) :
    Lp ℂ 2 (volume : Measure SpaceTime) :=
  Classical.choose (h.exists_lineDeriv_L2_rep i timeDirection)

theorem WeakXiSpaceTime.weakDtL2_spec (h : WeakXiSpaceTime) (i : Fin 3) :
    h.dtDist i = (h.weakDtL2 i : ScalarDist) := by
  exact Classical.choose_spec (h.exists_lineDeriv_L2_rep i timeDirection)

/-- Chosen L2 representative in any space-time direction; spatial basis directions are instances. -/
def WeakXiSpaceTime.weakDirectionalL2
    (h : WeakXiSpaceTime) (i : Fin 3) (m : SpaceTime) :
    Lp ℂ 2 (volume : Measure SpaceTime) :=
  Classical.choose (h.exists_lineDeriv_L2_rep i m)

theorem WeakXiSpaceTime.weakDirectionalL2_spec
    (h : WeakXiSpaceTime) (i : Fin 3) (m : SpaceTime) :
    (∂_{m} (h.xiDist i)) = (h.weakDirectionalL2 i m : ScalarDist) := by
  exact Classical.choose_spec (h.exists_lineDeriv_L2_rep i m)

/--
Mathlib's bump-convolution API is polymorphic in a complete normed target, so
regularization itself is not scalar-only.  Its available locally-integrable
convergence theorem is a.e.; this file does not relabel that as L2_loc
convergence of both a function and its gradient.
-/
inductive VectorLocalRepStatus
  | componentwiseFirstDerivativeL2Proved
  | componentwiseWeakTimeDerivativeL2Proved
  | vectorMollifierAPIAvailable
  | mollifierL2LocGradientConvergenceNotYetPackaged
  | laplacianL1LocNotFromH1
  | weightedProductRuleStillOpen
  | materialProductStillOpen
  deriving DecidableEq, Repr

end G1Audit
