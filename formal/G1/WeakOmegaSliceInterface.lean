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

noncomputable section

open MeasureTheory
open scoped ENNReal

namespace G1Audit

abbrev ProductSpaceTime := ℝ × Vec3
abbrev ProductScalarField := ProductSpaceTime → ℂ

/-- The product measure dt dx used for the rigorous Fubini slicing layer. -/
def productSpaceTimeMeasure : Measure ProductSpaceTime :=
  (volume : Measure ℝ).prod (volume : Measure Vec3)

/-- Spatial slice of a genuine product-space representative. -/
def spatialSlice (f : ProductScalarField) (t : ℝ) : Vec3 → ℂ :=
  fun x => f (t, x)

/--
An L2 function on R x R^3 has an L2 spatial slice for almost every time.
This is the rigorous replacement for pointwise evaluation of an L2(R^4)
equivalence class on the null set {t} x R^3.
-/
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
    simpa [spatialSlice] using hsliceMeasRaw
  filter_upwards [hsliceSq, hsliceMeas] with t ht htm
  exact (memLp_two_iff_integrable_sq_norm htm).2 ht

/--
Fubini identity for the quadratic L2 mass.  This is the function-level content
of ||f||^2_{L2(RxR3)} = int ||f(t,.)||^2_{L2(R3)} dt, written without choosing
an L2 representative on each exceptional time.
-/
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

/--
For the componentwise vorticity argument we need the function and its three
spatial weak derivatives to have good slices simultaneously.  Since Fin 3 is
finite, this is an a.e. finite intersection once product representatives are
available.
-/
def ProductOmegaSliceGood
    (omega : Fin 3 → ProductScalarField)
    (dxOmega : Fin 3 → Fin 3 → ProductScalarField)
    (t : ℝ) : Prop :=
  (∀ i, MemLp (spatialSlice (omega i) t) 2 (volume : Measure Vec3)) ∧
  (∀ i k, MemLp (spatialSlice (dxOmega i k) t) 2 (volume : Measure Vec3))

/--
Audit interface for the still-missing transfer from the existing EuclideanSpace
space-time distributions to product-space representatives.

These are mathematical obligations, not assumptions used to promote A2.
-/
structure SpaceTimeProductTransfer (h : WeakOmegaSpaceTime) where
  omegaProd : Fin 3 → ProductScalarField
  dxOmegaProd : Fin 3 → Fin 3 → ProductScalarField

  /-- Each product representative is genuinely L2(dt dx). -/
  omegaProd_memLp : ∀ i, MemLp (omegaProd i) 2 productSpaceTimeMeasure
  dxOmegaProd_memLp : ∀ i k, MemLp (dxOmegaProd i k) 2 productSpaceTimeMeasure

  /--
  Coordinate-transfer obligation: the chosen product functions represent the
  same tempered distributions as omegaL2 / weakDxL2 after a measure-preserving
  identification SpaceTime ~= R x Vec3.
  -/
  coordinateCompatible : Prop

  /--
  Distributional slicing obligation: for a.e. t, dxOmegaProd i k(t,.) is the
  x_k weak derivative of omegaProd i(t,.) on R^3, obtained from product tests
  phi(t) psi(x) and Fubini.
  -/
  spatialDerivativeSlices : Prop

/-- The L2 part of the transfer already implies simultaneous L2 slices a.e. -/
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

/-- Precise status after the function-level Fubini slice has been formalized. -/
inductive WeakOmegaSliceStatus
  | productL2SlicesProved
  | productQuadraticFubiniProved
  | simultaneousComponentSlicesProved
  | euclideanSpaceToProductCoordinatesOpen
  | spatialWeakDerivativeSliceOpen
  | xiEpsOmegaSliceLinkOpen
  | chainRuleNotYetPromoted
  deriving DecidableEq, Repr

end G1Audit
