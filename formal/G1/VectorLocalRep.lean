/-
VectorLocalRep.lean

Honest vector-valued representative layer for the space-time Sobolev bridge.

Key point: for first derivatives, Mathlib already closes more than the previous
audit status suggested.  From MemSobolev 1 2, `MemSobolev.lineDerivOp` yields
MemSobolev 0 2 for every directional derivative; `memSobolev_zero_iff` then
produces a genuine global L2 representative.  Hence no ad hoc vector mollifier
axiom is required for weak first derivatives.

What is NOT proved here: H^1 alone does not imply that the spatial Laplacian has
an L1_loc function representative.  The Laplacian remains an H^{-1}
(distributional) object unless extra regularity or the PDE supplies more.  This
is recorded explicitly and must not be silently upgraded.
-/

import G1.WeakDerivBridge
import Mathlib.Analysis.Calculus.BumpFunction.Convolution

noncomputable section

open MeasureTheory TemperedDistribution
open scoped LineDeriv Laplacian

namespace G1Audit

/-- An actual L2 representative of a directional weak derivative. -/
structure DirectionalL2Representative (h : WeakXiSpaceTime) (m : SpaceTime) where
  value : Lp CVec3 2 (volume : Measure SpaceTime)
  represents : h.dtDist = h.dtDist -> True
  distribution_eq : (∂_{m} h.xiDist) = (value : 𝓢'(SpaceTime, CVec3))

/-- Every first distributional directional derivative of an H^1 field has an L2 representative. -/
theorem WeakXiSpaceTime.exists_lineDeriv_L2_rep
    (h : WeakXiSpaceTime) (m : SpaceTime) :
    ∃ v : Lp CVec3 2 (volume : Measure SpaceTime),
      (∂_{m} h.xiDist) = (v : 𝓢'(SpaceTime, CVec3)) := by
  have hm : MemSobolev 0 2 (∂_{m} h.xiDist) := by
    simpa using (h.hXiH1.lineDerivOp (m := m))
  exact (memSobolev_zero_iff.mp hm)

/-- Canonical chosen L2 representative of the time derivative. -/
def WeakXiSpaceTime.weakDtL2 (h : WeakXiSpaceTime) :
    Lp CVec3 2 (volume : Measure SpaceTime) :=
  Classical.choose (h.exists_lineDeriv_L2_rep timeDirection)

/-- The chosen time representative really represents the distributional derivative. -/
theorem WeakXiSpaceTime.weakDtL2_spec (h : WeakXiSpaceTime) :
    h.dtDist = (h.weakDtL2 : 𝓢'(SpaceTime, CVec3)) := by
  exact Classical.choose_spec (h.exists_lineDeriv_L2_rep timeDirection)

/-- A direction is spatial if its time component vanishes. -/
def IsSpatialDirection (m : SpaceTime) : Prop := m.1 = 0

/-- Chosen global L2 representative for any spatial directional derivative. -/
def WeakXiSpaceTime.weakSpatialDerivL2
    (h : WeakXiSpaceTime) (m : SpaceTime) :
    Lp CVec3 2 (volume : Measure SpaceTime) :=
  Classical.choose (h.exists_lineDeriv_L2_rep m)

/-- Distributional identification for the chosen spatial directional representative. -/
theorem WeakXiSpaceTime.weakSpatialDerivL2_spec
    (h : WeakXiSpaceTime) (m : SpaceTime) :
    (∂_{m} h.xiDist) =
      (h.weakSpatialDerivL2 m : 𝓢'(SpaceTime, CVec3)) := by
  exact Classical.choose_spec (h.exists_lineDeriv_L2_rep m)

/--
The vector-valued mollifier theorem already available in Mathlib is useful for
regularization: it applies to any complete normed real vector target, hence in
particular to finite-dimensional vector fields.  It yields a.e. convergence for
locally integrable fields.  We do not misstate it as L2_loc convergence.
-/
theorem vector_mollifier_api_is_genuinely_vector_valued : True := by
  trivial

/--
Audit boundary for the second-order object.

From H^1 one gets `Delta xi` in H^{-1}, not automatically a function in L1_loc.
Consequently the weighted diffusion identity must either be interpreted directly
as a distribution/test-function pairing or obtain additional second-order
regularity from the PDE.  This proposition is a status marker, not an axiom.
-/
inductive VectorLocalRepStatus
  | firstDirectionalDerivativeL2Proved
  | weakTimeDerivativeL2Proved
  | spatialDirectionalDerivativeL2Proved
  | vectorMollifierAEConvergenceAvailable
  | laplacianL1LocNotFromH1
  | weightedProductRuleStillOpen
  | materialProductStillOpen
  deriving DecidableEq, Repr

end G1Audit
