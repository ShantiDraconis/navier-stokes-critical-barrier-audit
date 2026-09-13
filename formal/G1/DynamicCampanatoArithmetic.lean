/-
DynamicCampanatoArithmetic.lean

Pure arithmetic consequences of the already isolated Campanato recurrence.
No PDE-to-recurrence implication is proved here.
-/

import G1.DynamicCampanato

noncomputable section

namespace G1Audit

/-- If gamma=C(K) kappa and kappa<1/(2 C(K)), then gamma<1/2. -/
theorem gamma_lt_half_of_kappa
    {CK kappa gamma : ℝ}
    (hCK : 0 < CK)
    (hkappa : 0 ≤ kappa)
    (hgamma : gamma = CK * kappa)
    (hsmall : kappa < 1 / (2 * CK)) :
    gamma < (1 : ℝ) / 2 := by
  have hden : 0 < 2 * CK := mul_pos (by norm_num) hCK
  have hmul : kappa * (2 * CK) < 1 := by
    exact (lt_div_iff₀ hden).mp hsmall
  rw [hgamma]
  nlinarith

/--
The already-proved one-step theorem has exactly the desired linear-rate shape.
This wrapper makes the audit dependency explicit without adding analytic input.
-/
theorem campanato_linear_half_step
    (s : OneStepCampanato)
    (C : ℝ)
    (hC : 0 ≤ C)
    (hJ : s.Jr ≤ C * (s.r / s.rho))
    (hclose : 2 * s.gamma * C + 2 * s.A ≤ C) :
    s.JrHalf ≤ C * ((s.r / 2) / s.rho) := by
  exact linear_rate_one_step s C hC hJ hclose

/-- Audit boundary for the arithmetic-only track. -/
inductive DynamicCampanatoArithmeticStatus
  | gammaSmallnessProvedLogic
  | linearHalfStepProvedLogic
  | pdeRecurrenceNotEstablished
  deriving DecidableEq, Repr

end G1Audit
