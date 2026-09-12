theory Resolution_Dynamics
  imports Main "HOL-Analysis.Analysis"
begin

theorem endpoint_from_native_control:
  assumes "R ⟹ N" and "N ⟹ E" and R
  shows E
  using assms by blast

theorem coercive_bound:
  fixes D N alpha beta M :: real
  assumes "0 ≤ alpha" "D ≤ M" "N ≤ alpha * D + beta"
  shows "N ≤ alpha * M + beta"
  using assms by nlinarith

definition Close :: "real ⇒ real ⇒ real ⇒ bool" where
  "Close eps x y ⟷ abs (x-y) < eps"

theorem close_triangle:
  assumes "Close eps x y" "Close delta y z"
  shows "Close (eps+delta) x z"
proof -
  have "abs (x-z) ≤ abs (x-y) + abs (y-z)"
    by (metis add.commute add_diff_cancel_left' abs_triangle_ineq diff_add_eq_diff_diff_swap)
  moreover have "abs (x-y) + abs (y-z) < eps + delta"
    using assms unfolding Close_def by linarith
  ultimately show ?thesis
    unfolding Close_def by linarith
qed

end
