/-
SpaceTimeCoordinateSplit.lean

Coordinate-aligned identification of
  SpaceTime = EuclideanSpace R (Fin 4)
with one time coordinate and three spatial coordinates.

The construction uses only linear isometries already present in Mathlib:
Fin 4 is reindexed as Fin 1 ⊕ Fin 3, then PiLp is split into an L2 product,
and the one-dimensional Euclidean factor is identified with R by its singleton
orthonormal basis.  Measure preservation follows from the canonical theorem
that finite-dimensional real linear isometry equivalences preserve volume.
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

/-- In particular, the target canonical volume is the product measure used by Fubini. -/
theorem productSpaceTimeMeasure_eq_volume :
    productSpaceTimeMeasure = (volume : Measure ProductSpaceTime) := by
  rfl

inductive SpaceTimeCoordinateSplitStatus
  | coordinateIsometryConstructed
  | coordinateVolumePreservingProved
  | productMeasureIdentified
  deriving DecidableEq, Repr

end G1Audit
