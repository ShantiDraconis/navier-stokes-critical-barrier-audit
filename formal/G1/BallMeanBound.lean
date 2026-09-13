/-
BallMeanBound.lean

Bochner/Jensen control of the spatial average of the regularized direction.
This lemma is independent of the space-time slicing problem for omega.
-/

import G1.XiEpsPDE
import Mathlib.Analysis.Convex.Integral

noncomputable section

open MeasureTheory Metric

namespace G1Audit

/-- The regularized direction has norm at most one for eps>0. -/
theorem xiEps_norm_le_one_for_mean
    (omega : VectorField) (eps : ℝ) (heps : 0 < eps) (x : Vec3) :
    ‖xiEps omega eps x‖ ≤ 1 := by
  have hmpos : 0 < magEps omega eps x := magEps_pos omega eps heps x
  have hsqrt : ‖omega x‖ ≤ magEps omega eps x := by
    unfold magEps
    rw [le_sqrt (norm_nonneg _)]
    nlinarith [sq_nonneg eps]
  calc
    ‖xiEps omega eps x‖
        = (magEps omega eps x)⁻¹ * ‖omega x‖ := by
            simp [xiEps, norm_smul, Real.norm_eq_abs, abs_of_pos hmpos]
    _ ≤ (magEps omega eps x)⁻¹ * magEps omega eps x := by
          exact mul_le_mul_of_nonneg_left hsqrt (inv_nonneg.mpr (le_of_lt hmpos))
    _ = 1 := by exact inv_mul_cancel₀ (ne_of_gt hmpos)

/-- Spatial Bochner average of xi_eps over the open ball B(c,r). -/
def xiBallMean
    (omega : VectorField) (eps : ℝ) (c : Vec3) (r : ℝ) : Vec3 :=
  ⨍ x in ball c r, xiEps omega eps x ∂volume

/--
If xi_eps is integrable on B(c,r), its Bochner average remains in the closed
unit ball.  This is Jensen/convexity for the closed unit ball, with the pointwise
bound |xi_eps|<=1 supplying the a.e. membership hypothesis.
-/
theorem ballMeanBound
    (omega : VectorField) (eps : ℝ) (heps : 0 < eps)
    (c : Vec3) (r : ℝ) (hr : 0 < r)
    (hxi : IntegrableOn (xiEps omega eps) (ball c r) volume) :
    ‖xiBallMean omega eps c r‖ ≤ 1 := by
  have h0 : volume (ball c r) ≠ 0 :=
    ne_of_gt (measure_ball_pos volume c hr)
  have htop : volume (ball c r) ≠ ∞ := measure_ball_lt_top.ne
  have hmem : xiBallMean omega eps c r ∈ closedBall (0 : Vec3) 1 := by
    unfold xiBallMean
    apply (convex_closedBall (0 : Vec3) 1).set_average_mem isClosed_closedBall h0 htop
    · filter_upwards with x
      simpa [mem_closedBall, dist_zero_right] using
        (xiEps_norm_le_one_for_mean omega eps heps x)
    · exact hxi
  simpa [mem_closedBall, dist_zero_right] using hmem

end G1Audit
