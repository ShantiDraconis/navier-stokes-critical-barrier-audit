/-
WeakDerivBridge.lean

Space-time weak-derivative bridge for the regularized direction xi_eps.

Mathlib's tempered-distribution Sobolev API is used componentwise.  A vector
field in R^3 is represented as three scalar tempered distributions on R^4.
This avoids pretending that an unsupported vector target instance exists while
retaining the exact vector information component-by-component.

No pointwise DtXi or lapXi is supplied here.  Time derivatives and the spatial
Laplacian are distributional operators constructed from xiDist.
-/

import Mathlib.Analysis.Distribution.Sobolev

noncomputable section

open TemperedDistribution
open scoped SchwartzMap Real Laplacian LineDeriv

namespace G1Audit

/-- Spatial R^3 and space-time R^4. -/
abbrev Vec3 := EuclideanSpace ℝ (Fin 3)
abbrev SpaceTime := EuclideanSpace ℝ (Fin 4)

/-- A complex scalar component, as required by Mathlib's Sobolev API. -/
abbrev ScalarDist := 𝓢'(SpaceTime, ℂ)

/-- Time coordinate direction e_0 in R^4. -/
def timeDirection : SpaceTime := fun j => if j = 0 then 1 else 0

/--
A genuine vector-valued H^1 space-time distribution represented componentwise.
Each of the three components is a Mathlib tempered distribution in H^1.
-/
structure WeakXiSpaceTime where
  xiDist : Fin 3 → ScalarDist
  hXiH1 : ∀ i, MemSobolev 1 2 (xiDist i)

/-- Distributional time derivative of component i. -/
def WeakXiSpaceTime.dtDist (h : WeakXiSpaceTime) (i : Fin 3) : ScalarDist :=
  ∂_{timeDirection} (h.xiDist i)

/-- Distributional second time derivative of component i. -/
def WeakXiSpaceTime.dttDist (h : WeakXiSpaceTime) (i : Fin 3) : ScalarDist :=
  ∂_{timeDirection} (∂_{timeDirection} (h.xiDist i))

/--
Spatial Laplacian componentwise, realized as the R^4 Laplacian minus the second
time derivative.  Equality with the sum of the three spatial coordinate second
derivatives is a separate product-coordinate lemma and is not faked here.
-/
def WeakXiSpaceTime.spatialLapDist (h : WeakXiSpaceTime) (i : Fin 3) : ScalarDist :=
  Δ (h.xiDist i) - h.dttDist i

/-- Expose the exact H^1 certificate for every component. -/
theorem WeakXiSpaceTime.memSobolev_one_two (h : WeakXiSpaceTime) (i : Fin 3) :
    MemSobolev 1 2 (h.xiDist i) := h.hXiH1 i

/-- Every first directional derivative is H^0=L^2 at the distribution level. -/
theorem WeakXiSpaceTime.lineDeriv_memSobolev_zero
    (h : WeakXiSpaceTime) (i : Fin 3) (m : SpaceTime) :
    MemSobolev 0 2 (∂_{m} (h.xiDist i)) := by
  simpa using (h.hXiH1 i).lineDerivOp (m := m)

/-- In particular, the weak time derivative is H^0=L^2. -/
theorem WeakXiSpaceTime.dt_memSobolev_zero
    (h : WeakXiSpaceTime) (i : Fin 3) :
    MemSobolev 0 2 (h.dtDist i) := by
  exact h.lineDeriv_memSobolev_zero i timeDirection

/--
Audit boundary: H^1 controls first derivatives in L^2, but does not by itself
upgrade the second-order spatial Laplacian to an L^1_loc function.  Weighted
IBP must therefore use distribution/H^1 duality or additional PDE regularity.
-/
inductive WeakDerivBridgeStatus
  | componentwiseSpaceTimeSobolevDefined
  | weakFirstDerivativesH0
  | weakTimeDerivativeH0
  | weakSpatialLaplacianDistributionDefined
  | laplacianFunctionRepresentativeOpen
  | openWeightedProductRule
  | openMaterialDerivativePairing
  deriving DecidableEq, Repr

end G1Audit
