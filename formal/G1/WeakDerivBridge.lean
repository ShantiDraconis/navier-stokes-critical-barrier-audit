/-
WeakDerivBridge.lean

Space-time weak-derivative bridge for the regularized direction xi_eps.

Mathlib's tempered-distribution Sobolev API is used componentwise. A vector
field in R^3 is represented as three scalar tempered distributions on R^4.
No pointwise DtXi or lapXi is supplied here.
-/

import Mathlib.Analysis.Distribution.Sobolev
import Mathlib.Analysis.InnerProductSpace.PiL2

noncomputable section

open TemperedDistribution
open scoped SchwartzMap Real Laplacian LineDeriv BigOperators

namespace G1Audit

abbrev Vec3 := EuclideanSpace ℝ (Fin 3)
abbrev SpaceTime := EuclideanSpace ℝ (Fin 4)
abbrev ScalarDist := 𝓢'(SpaceTime, ℂ)

/-- Time coordinate e_0 in R^4. -/
def timeDirection : SpaceTime := EuclideanSpace.single (0 : Fin 4) 1

/-- Spatial coordinate e_{k+1} in R^4. -/
def spatialDirection (k : Fin 3) : SpaceTime :=
  EuclideanSpace.single k.succ 1

structure WeakXiSpaceTime where
  xiDist : Fin 3 → ScalarDist
  hXiH1 : ∀ i, MemSobolev 1 2 (xiDist i)

def WeakXiSpaceTime.dtDist (h : WeakXiSpaceTime) (i : Fin 3) : ScalarDist :=
  ∂_{timeDirection} (h.xiDist i)

/-- First spatial weak derivative ∂_{x_k} xi_i. -/
def WeakXiSpaceTime.dxDist (h : WeakXiSpaceTime) (i k : Fin 3) : ScalarDist :=
  ∂_{spatialDirection k} (h.xiDist i)

/--
Spatial Laplacian defined directly as sum_k ∂_{x_k}∂_{x_k}; no subtraction
of a time derivative from the four-dimensional Laplacian is used.
-/
def WeakXiSpaceTime.spatialLapDist (h : WeakXiSpaceTime) (i : Fin 3) : ScalarDist :=
  ∑ k : Fin 3, ∂_{spatialDirection k} (∂_{spatialDirection k} (h.xiDist i))

theorem WeakXiSpaceTime.memSobolev_one_two (h : WeakXiSpaceTime) (i : Fin 3) :
    MemSobolev 1 2 (h.xiDist i) := h.hXiH1 i

/-- Every first directional derivative is H^0=L^2 at distribution level. -/
theorem WeakXiSpaceTime.lineDeriv_memSobolev_zero
    (h : WeakXiSpaceTime) (i : Fin 3) (m : SpaceTime) :
    MemSobolev 0 2 (∂_{m} (h.xiDist i)) := by
  simpa using (h.hXiH1 i).lineDerivOp (m := m)

theorem WeakXiSpaceTime.dt_memSobolev_zero
    (h : WeakXiSpaceTime) (i : Fin 3) :
    MemSobolev 0 2 (h.dtDist i) := by
  exact h.lineDeriv_memSobolev_zero i timeDirection

/-- Each of the three spatial weak derivatives belongs to H^0=L^2. -/
theorem WeakXiSpaceTime.dx_memSobolev_zero
    (h : WeakXiSpaceTime) (i k : Fin 3) :
    MemSobolev 0 2 (h.dxDist i k) := by
  exact h.lineDeriv_memSobolev_zero i (spatialDirection k)

/--
Audit boundary: H^1 controls first derivatives in L^2. The spatial Laplacian is
well-defined distributionally by the explicit sum above, but H^1 does not imply
that it has an L1_loc representative.
-/
inductive WeakDerivBridgeStatus
  | componentwiseSpaceTimeSobolevDefined
  | weakFirstDerivativesH0
  | weakTimeDerivativeH0
  | threeSpatialDerivativesH0
  | weakSpatialLaplacianDistributionDefined
  | laplacianL1LocNotRequired
  | openWeightedProductRule
  | openMaterialDerivativePairing
  deriving DecidableEq, Repr

end G1Audit
