/-
WeakOmegaSliceInterface.lean

Rigorous product-space slicing layer for the vorticity audit.

This file proves the part of the 4D -> 3D passage supplied directly by
Mathlib/Fubini: an L2 function on R x R^3 has L2 spatial slices for almost every
time, and its quadratic L2 mass satisfies the iterated Fubini identity.

The existing distributional model uses
  SpaceTime = EuclideanSpace R (Fin 4),
not the product type R x Vec3.  Hence two further obligations remain explicit:
(1) a measure-preserving coordinate identification SpaceTime ~= R x Vec3, and
(2) passage of the spatial weak-derivative identity through that identification
and Fubini to obtain the fixed-time distributional derivative for a.e. t.
No evaluation of an L2(R^4) class on a null time slice is used.
-/

import G1.WeakOmegaBridge
import Mathlib.MeasureTheory.Integral.Prod
import Mathlib.MeasureTheory.Function.L2Space
import Mathlib.Analysis.Distribution.AEEqOfIntegralContDiff

noncomputable section

open MeasureTheory
open scoped ENNReal

namespace G1Audit

abbrev ProductSpaceTime := ℝ × Vec3
abbrev ProductScalarField := ProductSpaceTime → ℂ

def productSpaceTimeMeasure : Measure ProductSpaceTime :=
  (volume : Measure ℝ).prod (volume : Measure Vec3)

def spatialSlice (f : ProductScalarField) (t : ℝ) : Vec3 → ℂ :=
  fun x => f (t, x)

theorem memLp_two_spatialSlice_ae
    {f : ProductScalarField}
    (hf : MemLp f 2 productSpaceTimeMeasure) :
    ∀ᵐ t ∂(volume : Measure ℝ), MemLp (spatialSlice f t) 2 (volume : Measure Vec3) := by
  have hsq : Integrable (fun z : ProductSpaceTime => ‖f z‖ ^ 2) productSpaceTimeMeasure := by
    exact (memLp_two_iff_integrable_sq_norm hf.1).mp hf
  have hsliceSq :
      ∀ᵐ t ∂(volume : Measure ℝ),
        Integrable (fun x : Vec3 => ‖f (t, x)‖ ^ 2) (volume : Measure Vec3) := by
    simpa [productSpaceTimeMeasure] using hsq.prod_right_ae
  have hsliceMeasRaw :
      ∀ᵐ t ∂(volume : Measure ℝ),
        AEStronglyMeasurable (fun x : Vec3 => f (t, x)) (volume : Measure Vec3) := by
    simpa [productSpaceTimeMeasure] using hf.1.prodMk_left
  have hsliceMeas :
      ∀ᵐ t ∂(volume : Measure ℝ),
        AEStronglyMeasurable (spatialSlice f t) (volume : Measure Vec3) := by
    filter_upwards [hsliceMeasRaw] with t ht
    change AEStronglyMeasurable (fun x : Vec3 => f (t, x)) (volume : Measure Vec3)
    exact ht
  filter_upwards [hsliceSq, hsliceMeas] with t ht htm
  exact (memLp_two_iff_integrable_sq_norm htm).2 ht

theorem integral_sq_norm_eq_iterated
    {f : ProductScalarField}
    (hf : MemLp f 2 productSpaceTimeMeasure) :
    ∫ z : ProductSpaceTime, ‖f z‖ ^ 2 ∂productSpaceTimeMeasure =
      ∫ t : ℝ, ∫ x : Vec3, ‖f (t, x)‖ ^ 2 ∂(volume : Measure Vec3)
        ∂(volume : Measure ℝ) := by
  have hsq : Integrable (fun z : ProductSpaceTime => ‖f z‖ ^ 2) productSpaceTimeMeasure := by
    exact (memLp_two_iff_integrable_sq_norm hf.1).mp hf
  simpa [productSpaceTimeMeasure] using
    (integral_prod (fun z : ProductSpaceTime => ‖f z‖ ^ 2) hsq)

/-- Time du Bois-Reymond separation lemma used after Fubini. -/
theorem ae_eq_zero_of_time_smooth_tests
    {r : ℝ → ℂ}
    (hr : LocallyIntegrable r (volume : Measure ℝ))
    (htest : ∀ a : ℝ → ℝ,
      ContDiff ℝ ⊤ a → HasCompactSupport a →
        ∫ t, a t • r t ∂(volume : Measure ℝ) = 0) :
    ∀ᵐ t ∂(volume : Measure ℝ), r t = 0 := by
  exact ae_eq_zero_of_integral_contDiff_smul_eq_zero hr htest

def ProductOmegaSliceGood
    (omega : Fin 3 → ProductScalarField)
    (dxOmega : Fin 3 → Fin 3 → ProductScalarField)
    (t : ℝ) : Prop :=
  (∀ i, MemLp (spatialSlice (omega i) t) 2 (volume : Measure Vec3)) ∧
  (∀ i k, MemLp (spatialSlice (dxOmega i k) t) 2 (volume : Measure Vec3))

structure SpaceTimeProductTransfer (h : WeakOmegaSpaceTime) where
  omegaProd : Fin 3 → ProductScalarField
  dxOmegaProd : Fin 3 → Fin 3 → ProductScalarField
  omegaProd_memLp : ∀ i, MemLp (omegaProd i) 2 productSpaceTimeMeasure
  dxOmegaProd_memLp : ∀ i k, MemLp (dxOmegaProd i k) 2 productSpaceTimeMeasure
  coordinateCompatible : Prop
  spatialDerivativeSlices : Prop

theorem SpaceTimeProductTransfer.goodSlices_ae
    {h : WeakOmegaSpaceTime} (tr : SpaceTimeProductTransfer h) :
    ∀ᵐ t ∂(volume : Measure ℝ), ProductOmegaSliceGood tr.omegaProd tr.dxOmegaProd t := by
  have hω :
      ∀ᵐ t ∂(volume : Measure ℝ),
        ∀ i, MemLp (spatialSlice (tr.omegaProd i) t) 2 (volume : Measure Vec3) := by
    rw [Filter.eventually_all]
    intro i
    exact memLp_two_spatialSlice_ae (tr.omegaProd_memLp i)
  have hdx :
      ∀ᵐ t ∂(volume : Measure ℝ),
        ∀ i k, MemLp (spatialSlice (tr.dxOmegaProd i k) t) 2 (volume : Measure Vec3) := by
    rw [Filter.eventually_all]
    intro i
    rw [Filter.eventually_all]
    intro k
    exact memLp_two_spatialSlice_ae (tr.dxOmegaProd_memLp i k)
  filter_upwards [hω, hdx] with t htω htdx
  exact ⟨htω, htdx⟩

inductive WeakOmegaSliceStatus
  | productL2SlicesProved
  | productQuadraticFubiniProved
  | simultaneousComponentSlicesProved
  | timeSmoothTestSeparationProved
  | euclideanSpaceToProductCoordinatesOpen
  | spatialWeakDerivativeSliceOpen
  | xiEpsOmegaSliceLinkOpen
  | chainRuleNotYetPromoted
  deriving DecidableEq, Repr

end G1Audit
