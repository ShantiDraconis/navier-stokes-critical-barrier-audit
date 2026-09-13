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

def spatialWeakResidual
    (f g : ProductScalarField)
    (psi dpsi : Vec3 → ℂ) (t : ℝ) : ℂ :=
  (∫ x : Vec3, g (t, x) * psi x ∂(volume : Measure Vec3)) +
  (∫ x : Vec3, f (t, x) * dpsi x ∂(volume : Measure Vec3))

def SeparatedSpatialWeakDerivativeIdentity
    (f g : ProductScalarField)
    (psi dpsi : Vec3 → ℂ) : Prop :=
  ∀ alpha : ℝ → ℝ,
    ContDiff ℝ ⊤ alpha → HasCompactSupport alpha →
      ∫ t : ℝ,
        alpha t • spatialWeakResidual f g psi dpsi t
          ∂(volume : Measure ℝ) = 0

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
