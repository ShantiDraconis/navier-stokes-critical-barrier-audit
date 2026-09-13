/-
WeakOmegaSpatialSlice.lean

Intermediate, audit-safe reduction for the 4D -> 3D weak-derivative slice.

This file does NOT assume that a fixed-time slice is already an H^1_x function.
Instead it proves the precise du Bois-Reymond reduction needed after Fubini:
if the product-space weak derivative identity holds against every separated test
  alpha(t) * psi(x),
then the spatial weak-derivative residual vanishes for almost every time.

The remaining bridge is to derive the separated-test identity from the transported
R^4 tempered-distribution derivative relation.  That step is kept explicit.
-/

import G1.SpaceTimeCoordinateSplit
import G1.WeakOmegaSliceInterface

noncomputable section

open MeasureTheory

namespace G1Audit

/--
For one component i, one spatial direction k, and one fixed spatial test pair
(psi, dpsi), this is the fixed-time residual encoding

  int g_k(t,x) psi(x) dx + int f(t,x) d_k psi(x) dx.

Vanishing of this residual is exactly the scalar weak-derivative identity for
that test function.
-/
def spatialWeakResidual
    (f g : ProductScalarField)
    (psi dpsi : Vec3 → ℂ) (t : ℝ) : ℂ :=
  (∫ x : Vec3, g (t, x) * psi x ∂(volume : Measure Vec3)) +
  (∫ x : Vec3, f (t, x) * dpsi x ∂(volume : Measure Vec3))

/--
Separated-test hypothesis after the R^4 distribution identity has been
transported to R x R^3 and Fubini has been applied.

This is intentionally weaker than assuming the desired fixed-time weak
identity: it only states the integrated-in-time identity against arbitrary
smooth compactly supported alpha.
-/
def SeparatedSpatialWeakDerivativeIdentity
    (f g : ProductScalarField)
    (psi dpsi : Vec3 → ℂ) : Prop :=
  ∀ alpha : ℝ → ℝ,
    ContDiff ℝ ∞ alpha → HasCompactSupport alpha →
      ∫ t : ℝ,
        alpha t • spatialWeakResidual f g psi dpsi t
          ∂(volume : Measure ℝ) = 0

/--
The du Bois-Reymond step: once the residual is locally integrable and all
separated time tests vanish, the fixed-time weak derivative identity holds for
almost every time for this spatial test pair.
-/
theorem spatialWeakResidual_ae_zero
    {f g : ProductScalarField}
    {psi dpsi : Vec3 → ℂ}
    (hlocal : LocallyIntegrable (spatialWeakResidual f g psi dpsi)
      (volume : Measure ℝ))
    (hsep : SeparatedSpatialWeakDerivativeIdentity f g psi dpsi) :
    ∀ᵐ t ∂(volume : Measure ℝ),
      spatialWeakResidual f g psi dpsi t = 0 := by
  apply ae_eq_zero_of_time_smooth_tests hlocal
  intro alpha halpha hsupp
  exact hsep alpha halpha hsupp

/--
Specialization to the canonically transported vorticity and weak spatial
representative.  This still requires the separated product-test identity and
local integrability for the chosen spatial test pair; no fixed-time derivative
conclusion is stored as a field.
-/
theorem WeakOmegaSpaceTime.spatialDerivative_test_ae
    (h : WeakOmegaSpaceTime)
    (i k : Fin 3)
    (psi dpsi : Vec3 → ℂ)
    (hlocal : LocallyIntegrable
      (spatialWeakResidual (h.omegaProd i) (h.weakDxProd i k) psi dpsi)
      (volume : Measure ℝ))
    (hsep : SeparatedSpatialWeakDerivativeIdentity
      (h.omegaProd i) (h.weakDxProd i k) psi dpsi) :
    ∀ᵐ t ∂(volume : Measure ℝ),
      spatialWeakResidual (h.omegaProd i) (h.weakDxProd i k) psi dpsi t = 0 := by
  exact spatialWeakResidual_ae_zero hlocal hsep

/--
Audit status.  The next genuine theorem must derive `hsep` from the transported
R^4 distributional derivative identity for tensor-product tests.  Only after
that is done for a dense/countable spatial test family can one package
omega(t,.) in H^1_x for almost every t.
-/
inductive WeakOmegaSpatialSliceStatus
  | residualDefined
  | duBoisReymondReductionProved
  | separatedProductTestIdentityOpen
  | denseSpatialTestPassageOpen
  | fixedTimeH1Open
  | omegaEpsAEBridgeOpen
  | regularizedChainRuleOpen
  deriving DecidableEq, Repr

end G1Audit
