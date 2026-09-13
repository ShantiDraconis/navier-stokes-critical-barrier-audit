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

/-- The one-dimensional orthonormal basis of R indexed by Fin 1. -/
def realSingletonONB : OrthonormalBasis (Fin 1) ℝ ℝ :=
  orthonormalBasisSingleton (Fin 1) ℝ (by simp) (1 : ℝ) (by simp)

/-- Reindex the four Euclidean coordinates as time ⊕ space. -/
def spaceTimeReindex :
    SpaceTime ≃ₗᵢ[ℝ] EuclideanSpace ℝ (Fin 1 ⊕ Fin 3) :=
  LinearIsometryEquiv.piLpCongrLeft 2 ℝ ℝ finSumFinEquiv.symm

/-- Split the reindexed Euclidean space into its 1D and 3D L2 factors. -/
def reindexedSplit :
    EuclideanSpace ℝ (Fin 1 ⊕ Fin 3) ≃ₗᵢ[ℝ]
      WithLp 2 (EuclideanSpace ℝ (Fin 1) × Vec3) :=
  PiLp.sumPiLpEquivProdLpPiLp 2 (fun _ : Fin 1 ⊕ Fin 3 => ℝ)

/-- Identify the first Euclidean factor with R while leaving Vec3 unchanged. -/
def firstFactorToReal :
    WithLp 2 (EuclideanSpace ℝ (Fin 1) × Vec3) ≃ₗᵢ[ℝ]
      WithLp 2 (ℝ × Vec3) :=
  LinearIsometryEquiv.withLpProdCongr 2
    realSingletonONB.repr.symm
    (LinearIsometryEquiv.refl ℝ Vec3)

/-- Coordinate-aligned L2 isometry: x ↦ (x_0, (x_1,x_2,x_3)). -/
def spaceTimeSplitL2 : SpaceTime ≃ₗᵢ[ℝ] WithLp 2 (ℝ × Vec3) :=
  spaceTimeReindex.trans (reindexedSplit.trans firstFactorToReal)

/-- The L2-valued coordinate split preserves canonical volume. -/
theorem spaceTimeSplitL2_measurePreserving :
    MeasurePreserving spaceTimeSplitL2 :=
  LinearIsometryEquiv.measurePreserving spaceTimeSplitL2

/-- Ordinary product-valued coordinate map obtained by forgetting the WithLp wrapper. -/
def spaceTimeToProduct (z : SpaceTime) : ProductSpaceTime :=
  WithLp.ofLp (spaceTimeSplitL2 z)

/-- The ordinary product coordinate map preserves volume. -/
theorem spaceTimeToProduct_measurePreserving :
    MeasurePreserving spaceTimeToProduct := by
  exact spaceTimeSplitL2_measurePreserving.trans
    (WithLp.volume_preserving_ofLp ℝ Vec3)

/-- Inverse product coordinate map. -/
def productToSpaceTime (z : ProductSpaceTime) : SpaceTime :=
  spaceTimeSplitL2.symm (WithLp.toLp 2 z)

/-- The inverse product coordinate map also preserves canonical volume. -/
theorem productToSpaceTime_measurePreserving :
    MeasurePreserving productToSpaceTime := by
  exact (WithLp.volume_preserving_toLp ℝ Vec3).trans
    (LinearIsometryEquiv.measurePreserving spaceTimeSplitL2.symm)

/-- The target canonical volume is the product measure used by Fubini. -/
theorem productSpaceTimeMeasure_eq_volume :
    productSpaceTimeMeasure = (volume : Measure ProductSpaceTime) := by
  rfl

/-- Transport an L2 representative on Euclidean R^4 to R x R^3. -/
def l2RepToProduct
    (F : Lp ℂ 2 (volume : Measure SpaceTime)) : ProductScalarField :=
  fun z => F (productToSpaceTime z)

/-- Measure-preserving pullback keeps an L2 representative in L2. -/
theorem l2RepToProduct_memLp
    (F : Lp ℂ 2 (volume : Measure SpaceTime)) :
    MemLp (l2RepToProduct F) 2 productSpaceTimeMeasure := by
  have hcomp :
      MemLp ((fun x : SpaceTime => F x) ∘ productToSpaceTime) 2
        (volume : Measure ProductSpaceTime) :=
    (Lp.memLp F).comp_measurePreserving productToSpaceTime_measurePreserving
  simpa [l2RepToProduct, productSpaceTimeMeasure, Function.comp_def] using hcomp

/-- Canonically transported omega representative. -/
def WeakOmegaSpaceTime.omegaProd
    (h : WeakOmegaSpaceTime) (i : Fin 3) : ProductScalarField :=
  l2RepToProduct (h.omegaL2 i)

/-- Canonically transported weak spatial derivative representative. -/
def WeakOmegaSpaceTime.weakDxProd
    (h : WeakOmegaSpaceTime) (i k : Fin 3) : ProductScalarField :=
  l2RepToProduct (h.weakDxL2 i k)

/-- The transported omega representative is genuinely L2(dt dx). -/
theorem WeakOmegaSpaceTime.omegaProd_memLp
    (h : WeakOmegaSpaceTime) (i : Fin 3) :
    MemLp (h.omegaProd i) 2 productSpaceTimeMeasure := by
  exact l2RepToProduct_memLp (h.omegaL2 i)

/-- Every transported weak spatial derivative is genuinely L2(dt dx). -/
theorem WeakOmegaSpaceTime.weakDxProd_memLp
    (h : WeakOmegaSpaceTime) (i k : Fin 3) :
    MemLp (h.weakDxProd i k) 2 productSpaceTimeMeasure := by
  exact l2RepToProduct_memLp (h.weakDxL2 i k)

/-- Hence omega has L2 spatial slices for almost every time. -/
theorem WeakOmegaSpaceTime.omegaProd_slice_memLp_ae
    (h : WeakOmegaSpaceTime) (i : Fin 3) :
    ∀ᵐ t ∂(volume : Measure ℝ),
      MemLp (spatialSlice (h.omegaProd i) t) 2 (volume : Measure Vec3) :=
  memLp_two_spatialSlice_ae (h.omegaProd_memLp i)

/-- The weak spatial derivative representatives have L2 slices a.e. in time. -/
theorem WeakOmegaSpaceTime.weakDxProd_slice_memLp_ae
    (h : WeakOmegaSpaceTime) (i k : Fin 3) :
    ∀ᵐ t ∂(volume : Measure ℝ),
      MemLp (spatialSlice (h.weakDxProd i k) t) 2 (volume : Measure Vec3) :=
  memLp_two_spatialSlice_ae (h.weakDxProd_memLp i k)

/-- All three components and all nine spatial derivatives are good simultaneously a.e. -/
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
  | omegaL2TransferImplemented
  | weakDxL2TransferImplemented
  | productSlicesL2Proved
  | spatialDistributionalDerivativeSliceOpen
  deriving DecidableEq, Repr

end G1Audit
