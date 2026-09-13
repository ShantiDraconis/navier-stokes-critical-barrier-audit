/-
SpaceTimeCoordinateSplit.lean

Coordinate-aligned identification of
  SpaceTime = EuclideanSpace R (Fin 4)
with one time coordinate and three spatial coordinates.

Besides the coordinate isometry, this file transports the chosen L2
representatives of omega and its weak spatial derivatives to the genuine
product space R x R^3.  The transport is by composition with the inverse
measure-preserving coordinate map, so no null-slice evaluation is introduced.
-/

import G1.WeakOmegaSliceInterface
import Mathlib.MeasureTheory.Measure.Haar.InnerProductSpace
import Mathlib.Analysis.InnerProductSpace.ProdL2

noncomputable section

open MeasureTheory Module WithLp

namespace G1Audit

def realSingletonONB : OrthonormalBasis (Fin 1) ℝ ℝ :=
  OrthonormalBasis.singleton (Fin 1) ℝ

def finFourEquivTimeSpace : Fin 4 ≃ Fin 1 ⊕ Fin 3 :=
  (finSumFinEquiv : Fin 1 ⊕ Fin 3 ≃ Fin (1 + 3)).symm

def spaceTimeReindex :
    SpaceTime ≃ₗᵢ[ℝ] EuclideanSpace ℝ (Fin 1 ⊕ Fin 3) :=
  LinearIsometryEquiv.piLpCongrLeft 2 ℝ ℝ finFourEquivTimeSpace

def reindexedSplit :
    EuclideanSpace ℝ (Fin 1 ⊕ Fin 3) ≃ₗᵢ[ℝ]
      WithLp 2 (EuclideanSpace ℝ (Fin 1) × Vec3) :=
  PiLp.sumPiLpEquivProdLpPiLp 2 (fun _ : Fin 1 ⊕ Fin 3 => ℝ)

def firstFactorToReal :
    WithLp 2 (EuclideanSpace ℝ (Fin 1) × Vec3) ≃ₗᵢ[ℝ]
      WithLp 2 (ℝ × Vec3) :=
  LinearIsometryEquiv.withLpProdCongr 2
    realSingletonONB.repr.symm
    (LinearIsometryEquiv.refl ℝ Vec3)

def spaceTimeSplitL2 : SpaceTime ≃ₗᵢ[ℝ] WithLp 2 (ℝ × Vec3) :=
  spaceTimeReindex.trans (reindexedSplit.trans firstFactorToReal)

theorem spaceTimeSplitL2_measurePreserving :
    MeasurePreserving spaceTimeSplitL2 :=
  LinearIsometryEquiv.measurePreserving spaceTimeSplitL2

def spaceTimeToProduct (z : SpaceTime) : ProductSpaceTime :=
  WithLp.ofLp (spaceTimeSplitL2 z)

theorem spaceTimeToProduct_measurePreserving :
    MeasurePreserving spaceTimeToProduct := by
  have h1 : MeasurePreserving
      (spaceTimeSplitL2 : SpaceTime → WithLp 2 (ℝ × Vec3))
      (volume : Measure SpaceTime)
      (volume : Measure (WithLp 2 (ℝ × Vec3))) :=
    spaceTimeSplitL2_measurePreserving
  have h2 : MeasurePreserving
      (@WithLp.ofLp 2 (ℝ × Vec3))
      (volume : Measure (WithLp 2 (ℝ × Vec3)))
      (volume : Measure ProductSpaceTime) :=
    WithLp.volume_preserving_ofLp ℝ Vec3
  have h := h2.comp h1
  change MeasurePreserving
    (fun z : SpaceTime => WithLp.ofLp (spaceTimeSplitL2 z))
  simpa only [Function.comp_def] using h

def productToSpaceTime (z : ProductSpaceTime) : SpaceTime :=
  spaceTimeSplitL2.symm (WithLp.toLp 2 z)

theorem productToSpaceTime_measurePreserving :
    MeasurePreserving productToSpaceTime := by
  have h1 : MeasurePreserving
      (@WithLp.toLp 2 (ℝ × Vec3))
      (volume : Measure ProductSpaceTime)
      (volume : Measure (WithLp 2 (ℝ × Vec3))) :=
    WithLp.volume_preserving_toLp ℝ Vec3
  have h2 : MeasurePreserving
      (spaceTimeSplitL2.symm : WithLp 2 (ℝ × Vec3) → SpaceTime)
      (volume : Measure (WithLp 2 (ℝ × Vec3)))
      (volume : Measure SpaceTime) :=
    LinearIsometryEquiv.measurePreserving spaceTimeSplitL2.symm
  have h := h2.comp h1
  change MeasurePreserving
    (fun z : ProductSpaceTime => spaceTimeSplitL2.symm (WithLp.toLp 2 z))
  simpa only [Function.comp_def] using h

/-- Continuous linear equivalence underlying the coordinate split; this is the
form used by Schwartz-space composition and derivative transport. -/
def spaceTimeProductCLE : SpaceTime ≃L[ℝ] ProductSpaceTime :=
  spaceTimeSplitL2.toContinuousLinearEquiv.trans
    (WithLp.prodContinuousLinearEquiv 2 ℝ ℝ Vec3)

@[simp]
theorem spaceTimeProductCLE_apply (z : SpaceTime) :
    spaceTimeProductCLE z = spaceTimeToProduct z := by
  rfl

@[simp]
theorem spaceTimeProductCLE_symm_apply (z : ProductSpaceTime) :
    spaceTimeProductCLE.symm z = productToSpaceTime z := by
  rfl

theorem productSpaceTimeMeasure_eq_volume :
    productSpaceTimeMeasure = (volume : Measure ProductSpaceTime) := by
  rfl

def l2RepToProduct
    (F : Lp ℂ 2 (volume : Measure SpaceTime)) : ProductScalarField :=
  fun z => F (productToSpaceTime z)

theorem l2RepToProduct_memLp_volume
    (F : Lp ℂ 2 (volume : Measure SpaceTime)) :
    MemLp (l2RepToProduct F) 2 (volume : Measure ProductSpaceTime) := by
  have hcomp :
      MemLp ((fun x : SpaceTime => F x) ∘ productToSpaceTime) 2
        (volume : Measure ProductSpaceTime) :=
    (Lp.memLp F).comp_measurePreserving productToSpaceTime_measurePreserving
  change MemLp (fun z : ProductSpaceTime => F (productToSpaceTime z)) 2
    (volume : Measure ProductSpaceTime)
  simpa only [Function.comp_def] using hcomp

theorem l2RepToProduct_memLp
    (F : Lp ℂ 2 (volume : Measure SpaceTime)) :
    MemLp (l2RepToProduct F) 2 productSpaceTimeMeasure := by
  rw [productSpaceTimeMeasure_eq_volume]
  exact l2RepToProduct_memLp_volume F

def WeakOmegaSpaceTime.omegaProd
    (h : WeakOmegaSpaceTime) (i : Fin 3) : ProductScalarField :=
  l2RepToProduct (h.omegaL2 i)

def WeakOmegaSpaceTime.weakDxProd
    (h : WeakOmegaSpaceTime) (i k : Fin 3) : ProductScalarField :=
  l2RepToProduct (h.weakDxL2 i k)

theorem WeakOmegaSpaceTime.omegaProd_memLp
    (h : WeakOmegaSpaceTime) (i : Fin 3) :
    MemLp (h.omegaProd i) 2 productSpaceTimeMeasure := by
  exact l2RepToProduct_memLp (h.omegaL2 i)

theorem WeakOmegaSpaceTime.weakDxProd_memLp
    (h : WeakOmegaSpaceTime) (i k : Fin 3) :
    MemLp (h.weakDxProd i k) 2 productSpaceTimeMeasure := by
  exact l2RepToProduct_memLp (h.weakDxL2 i k)

theorem WeakOmegaSpaceTime.omegaProd_slice_memLp_ae
    (h : WeakOmegaSpaceTime) (i : Fin 3) :
    ∀ᵐ t ∂(volume : Measure ℝ),
      MemLp (spatialSlice (h.omegaProd i) t) 2 (volume : Measure Vec3) :=
  memLp_two_spatialSlice_ae (h.omegaProd_memLp i)

theorem WeakOmegaSpaceTime.weakDxProd_slice_memLp_ae
    (h : WeakOmegaSpaceTime) (i k : Fin 3) :
    ∀ᵐ t ∂(volume : Measure ℝ),
      MemLp (spatialSlice (h.weakDxProd i k) t) 2 (volume : Measure Vec3) :=
  memLp_two_spatialSlice_ae (h.weakDxProd_memLp i k)

theorem WeakOmegaSpaceTime.productSlicesGood_ae
    (h : WeakOmegaSpaceTime) :
    ∀ᵐ t ∂(volume : Measure ℝ),
      ProductOmegaSliceGood h.omegaProd h.weakDxProd t := by
  have hω :
      ∀ᵐ t ∂(volume : Measure ℝ),
        ∀ i, MemLp (spatialSlice (h.omegaProd i) t) 2 (volume : Measure Vec3) := by
    rw [Filter.eventually_all]
    intro i
    exact h.omegaProd_slice_memLp_ae i
  have hdx :
      ∀ᵐ t ∂(volume : Measure ℝ),
        ∀ i k, MemLp (spatialSlice (h.weakDxProd i k) t) 2 (volume : Measure Vec3) := by
    rw [Filter.eventually_all]
    intro i
    rw [Filter.eventually_all]
    intro k
    exact h.weakDxProd_slice_memLp_ae i k
  filter_upwards [hω, hdx] with t htω htdx
  exact ⟨htω, htdx⟩

inductive SpaceTimeCoordinateSplitStatus
  | coordinateIsometryConstructed
  | coordinateVolumePreservingProved
  | productMeasureIdentified
  | continuousLinearEquivConstructed
  | omegaL2TransferImplemented
  | weakDxL2TransferImplemented
  | productSlicesL2Proved
  | spatialDistributionalDerivativeSliceOpen
  deriving DecidableEq, Repr

end G1Audit
