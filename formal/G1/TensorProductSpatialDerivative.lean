/-
TensorProductSpatialDerivative.lean

Spatial derivative formula for the separated Schwartz test alpha(t) psi(x).
This file is intentionally isolated so the coordinate and calculus obligations
are CI-auditable before they are used in the weak slicing argument.
-/

import G1.SpaceTimeSpatialDirection
import G1.TensorProductSchwartz

noncomputable section

open MeasureTheory Module WithLp Set
open scoped LineDeriv SchwartzMap

namespace G1Audit

/-- Classical x_k derivative of a smooth spatial test. -/
def spatialTestDerivative (psi : Vec3 → ℂ) (k : Fin 3) : Vec3 → ℂ :=
  fun x => fderiv ℝ psi x (EuclideanSpace.single k 1)

/-- Differentiating alpha(t) psi(x) in the pure x_k direction differentiates
only psi. -/
theorem productTensorSchwartz_spatial_lineDeriv_apply
    (alpha : ℝ → ℝ) (psi : Vec3 → ℂ)
    (halphaSmooth : ContDiff ℝ ⊤ alpha)
    (halphaCompact : HasCompactSupport alpha)
    (hpsiSmooth : ContDiff ℝ ⊤ psi)
    (hpsiCompact : HasCompactSupport psi)
    (k : Fin 3) (z : ProductSpaceTime) :
    (∂_{productSpatialDirection k}
      (productTensorSchwartz alpha psi halphaSmooth halphaCompact hpsiSmooth hpsiCompact)) z =
      (alpha z.1 : ℂ) * spatialTestDerivative psi k z.2 := by
  rw [SchwartzMap.lineDerivOp_apply_eq_fderiv]
  change fderiv ℝ (tensorProductRaw alpha psi) z (productSpatialDirection k) = _
  have ha : DifferentiableAt ℝ (fun y : ProductSpaceTime => (alpha y.1 : ℂ)) z := by
    fun_prop
  have hp : DifferentiableAt ℝ (fun y : ProductSpaceTime => psi y.2) z := by
    fun_prop
  rw [fderiv_mul ha hp]
  simp [tensorProductRaw, productSpatialDirection, spatialTestDerivative,
    ContinuousLinearMap.add_apply, ContinuousLinearMap.smul_apply]

/-- The corresponding SpaceTime derivative is obtained by coordinate transport. -/
theorem spaceTimeTensorSchwartz_spatial_lineDeriv
    (alpha : ℝ → ℝ) (psi : Vec3 → ℂ)
    (halphaSmooth : ContDiff ℝ ⊤ alpha)
    (halphaCompact : HasCompactSupport alpha)
    (hpsiSmooth : ContDiff ℝ ⊤ psi)
    (hpsiCompact : HasCompactSupport psi)
    (k : Fin 3) :
    ∂_{spatialDirection k}
      (spaceTimeTensorSchwartz alpha psi halphaSmooth halphaCompact hpsiSmooth hpsiCompact) =
      productSchwartzPullback
        (∂_{productSpatialDirection k}
          (productTensorSchwartz alpha psi halphaSmooth halphaCompact hpsiSmooth hpsiCompact)) := by
  rw [← spaceTimeProductCLE_spatialDirection k]
  exact SchwartzMap.lineDerivOp_compCLMOfContinuousLinearEquiv
    (spatialDirection k) spaceTimeProductCLE
    (productTensorSchwartz alpha psi halphaSmooth halphaCompact hpsiSmooth hpsiCompact)

inductive TensorProductSpatialDerivativeStatus
  | spatialDerivativeFunctionDefined
  | productDerivativeFormulaProved
  | spaceTimeDerivativeTransported
  deriving DecidableEq, Repr

end G1Audit
