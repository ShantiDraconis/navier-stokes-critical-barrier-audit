/-
WeakDerivBridge.lean

Space-time weak-derivative bridge for the regularized direction xi_eps.

This file uses Mathlib's actual tempered-distribution/Sobolev API.  It does not
encode DtXi or lapXi as arbitrary pointwise fields.  Instead it constructs the
weak time derivative and a spatial Laplacian distribution from the distribution
representing xi_eps.

Important audit boundary: Mathlib currently provides MemSobolev for tempered
distributions and distributional line derivatives/Laplacian, but the repository
does not yet have a theorem converting the resulting vector-valued
space-time distributions to the precise local L2 representatives needed by the
weighted Bochner identity.  That conversion is recorded as OPEN_MATHLIB_VECTOR,
not hidden as an axiom or as the final PDE identity.
-/

import Mathlib.Analysis.Distribution.Sobolev

noncomputable section

open TemperedDistribution
open scoped SchwartzMap Real Laplacian LineDeriv

namespace G1Audit

abbrev Vec3 := EuclideanSpace ℝ (Fin 3)
abbrev ScalarField := Vec3 → ℝ
abbrev VectorField := Vec3 → Vec3

/-- Space-time R x R^3. -/
abbrev SpaceTime := ℝ × Vec3

/-- Complexified target used by Mathlib's tempered-distribution Sobolev API. -/
abbrev CVec3 := EuclideanSpace ℂ (Fin 3)

/-- Unit direction in time inside R x R^3. -/
def timeDirection : SpaceTime := ((1 : ℝ), 0)

/--
A genuine H^1 space-time distribution representing the regularized direction.
`MemSobolev 1 2` is Mathlib's Bessel-potential/Sobolev predicate.
-/
structure WeakXiSpaceTime where
  xiDist : 𝓢'(SpaceTime, CVec3)
  hXiH1 : MemSobolev 1 2 xiDist

/-- Distributional time derivative d_t xi. -/
def WeakXiSpaceTime.dtDist (h : WeakXiSpaceTime) : 𝓢'(SpaceTime, CVec3) :=
  ∂_{timeDirection} h.xiDist

/-- Distributional second time derivative. -/
def WeakXiSpaceTime.dttDist (h : WeakXiSpaceTime) : 𝓢'(SpaceTime, CVec3) :=
  ∂_{timeDirection} (∂_{timeDirection} h.xiDist)

/--
Spatial Laplacian as the space-time Laplacian with the second time derivative
removed.  This is a genuine distributional operator, not a supplied vector
field.  The equality with the coordinate sum sum_j d_{x_j}^2 is the geometric
product-space identification that should eventually be proved as a helper lemma.
-/
def WeakXiSpaceTime.spatialLapDist (h : WeakXiSpaceTime) : 𝓢'(SpaceTime, CVec3) :=
  Δ h.xiDist - h.dttDist

/--
Mathlib's H^1 assumption is retained explicitly as the regularity certificate.
This theorem is intentionally trivial: it exposes the exact source of Sobolev
regularity rather than replacing it with a custom predicate.
-/
theorem WeakXiSpaceTime.memSobolev_one_two (h : WeakXiSpaceTime) :
    MemSobolev 1 2 h.xiDist := h.hXiH1

/--
The bridge still missing from Mathlib/repository infrastructure:

1. obtain vector-valued L2_loc representatives of dtDist and spatialLapDist;
2. identify them a.e. with the real-valued weak derivatives of xi_eps;
3. support the weighted product rule/divergence theorem needed by the localized
   test field phi^2 |omega|_eps (xi_eps-mean).

No constructor from `WeakXiSpaceTime` is provided, because that would falsely
assert the missing theorem.
-/
structure VectorWeakRepresentative where
  dtRepresentative : SpaceTime → CVec3
  lapRepresentative : SpaceTime → CVec3
  dtLocallyL2 : Prop
  lapLocallyIntegrable : Prop
  representsDt : Prop
  representsSpatialLap : Prop

/-- Explicit audit status for the unimplemented Mathlib vector bridge. -/
inductive WeakDerivBridgeStatus
  | spaceTimeSobolevDistributionDefined
  | weakTimeDerivativeDefined
  | weakSpatialLaplacianDefined
  | openMathlibVector
  | openWeightedProductRule
  | openMaterialDerivativePairing
  deriving DecidableEq, Repr

end G1Audit
