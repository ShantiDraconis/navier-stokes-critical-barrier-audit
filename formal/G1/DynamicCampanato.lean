/-
DynamicCampanato.lean

Formal algebraic skeleton for the dynamic-scale Campanato step used in the G1
PDE-to-geometry audit.  This file intentionally separates the analytic input
from the algebraic consequences: none of the structures below asserts that the
Navier--Stokes PDE actually supplies the required contraction estimate.
-/

import Mathlib

noncomputable section

namespace G1Audit

structure DynamicCampanatoData where
  nu : ℝ
  rho : ℝ
  r : ℝ
  q : ℝ
  Jr : ℝ
  JrHalf : ℝ
  A : ℝ
  gamma : ℝ
  hnu : 0 < nu
  hrho : 0 < rho
  hr : 0 < r
  hq : 0 ≤ q
  hJr : 0 ≤ Jr
  hJrHalf : 0 ≤ JrHalf
  hA : 0 ≤ A
  hgamma : 0 ≤ gamma
  hr_le_rho : r ≤ rho

/-- Dimensionless ratio r/rho. -/
def scaleRatio (s : DynamicCampanatoData) : ℝ := s.r / s.rho

/-- Joint local geometric quantity. -/
def Qjoint (directionOsc strainPos : ℝ) : ℝ := directionOsc + strainPos

/-- Abstract recurrence: this is an analytic hypothesis, not a theorem from NSE. -/
structure DynamicRecurrence (s : DynamicCampanatoData) where
  recurrence : s.JrHalf ≤ s.gamma * s.Jr + s.A * scaleRatio s

/-- Exact algebraic decomposition of the recurrence right-hand side. -/
theorem recurrence_rhs_factor
    (s : DynamicCampanatoData) :
    s.gamma * (s.q * scaleRatio s) + s.A * scaleRatio s =
      (s.gamma * s.q + s.A) * scaleRatio s := by
  ring

/-- If Jr is bounded by q r/rho, one recurrence step obeys the corresponding coefficient bound. -/
theorem recurrence_step_bound
    (s : DynamicCampanatoData)
    (hrec : DynamicRecurrence s)
    (hJ : s.Jr ≤ s.q * scaleRatio s) :
    s.JrHalf ≤ (s.gamma * s.q + s.A) * scaleRatio s := by
  have hgammaJ : s.gamma * s.Jr ≤ s.gamma * (s.q * scaleRatio s) :=
    mul_le_mul_of_nonneg_left hJ s.hgamma
  calc
    s.JrHalf ≤ s.gamma * s.Jr + s.A * scaleRatio s := hrec.recurrence
    _ ≤ s.gamma * (s.q * scaleRatio s) + s.A * scaleRatio s :=
      add_le_add_right hgammaJ _
    _ = (s.gamma * s.q + s.A) * scaleRatio s := recurrence_rhs_factor s

/-- Arithmetic closure condition for a linear Campanato rate. -/
def LinearClosure (gamma A C : ℝ) : Prop :=
  2 * gamma * C + 2 * A ≤ C

/-- The closure inequality implies gamma < 1/2 whenever A>0 and C>0. -/
theorem gamma_lt_half_of_linearClosure
    {gamma A C : ℝ}
    (hA : 0 < A)
    (hC : 0 < C)
    (hclose : LinearClosure gamma A C) :
    gamma < (1 : ℝ) / 2 := by
  unfold LinearClosure at hclose
  nlinarith

/-- A sufficient explicit choice of C when gamma<1/2. -/
theorem linearClosure_of_C
    {gamma A C : ℝ}
    (hgamma : gamma < (1 : ℝ) / 2)
    (hA : 0 ≤ A)
    (hC : 2 * A / (1 - 2 * gamma) ≤ C) :
    LinearClosure gamma A C := by
  unfold LinearClosure
  have hden : 0 < 1 - 2 * gamma := by linarith
  have hmul := mul_le_mul_of_nonneg_left hC (le_of_lt hden)
  field_simp at hmul
  linarith

/-- Dyadic geometric-series helper. -/
theorem geometric_half_sum_le_two (n : ℕ) :
    ∑ k in Finset.range n, ((1 : ℝ) / 2) ^ k ≤ 2 := by
  induction n with
  | zero => norm_num
  | succ n ih =>
      rw [Finset.sum_range_succ]
      have hpow : ((1 : ℝ) / 2) ^ n ≤ 1 := by
        exact pow_le_one₀ (by norm_num) (by norm_num)
      linarith

/--
Audit marker: the algebra is formalized, while the actual PDE-to-recurrence
implication remains external/open.
-/
inductive DynamicCampanatoStatus
  | arithmeticFormalized
  | contractionNeedsAnalyticInput
  | pdeToDynamicCampanatoOpen
  deriving DecidableEq, Repr

/-- Legacy scalar signature retained for downstream audit files. -/
structure CampanatoSignature where
  theta : ℝ
  C : ℝ
  aIntegral : ℝ
  htheta : 0 ≤ theta
  htheta_lt_one : theta < 1
  hC : 0 ≤ C
  haIntegral : 0 ≤ aIntegral

/-- Gronwall amplification associated with the flexible G1 remainder. -/
def gronwallFactor (s : CampanatoSignature) : ℝ := Real.exp (2 * s.aIntegral)

/-- The specific audit numbers theta<1,C=2,∫a=36 imply exp(72), not 4.17. -/
theorem gronwall_factor_36 (s : CampanatoSignature) (ha : s.aIntegral = 36) :
    gronwallFactor s = Real.exp 72 := by
  simp [gronwallFactor, ha]

/-- One-step Campanato recurrence used by the localized direction argument. -/
structure OneStepCampanato where
  Jr : ℝ
  JrHalf : ℝ
  gamma : ℝ
  A : ℝ
  r : ℝ
  rho : ℝ
  hr_pos : 0 < r
  hrho_pos : 0 < rho
  hgamma_nonneg : 0 ≤ gamma
  hA_nonneg : 0 ≤ A
  recurrence : JrHalf ≤ gamma * Jr + A * (r / rho)

/--
Algebraic closure of one linear Campanato step.

If Jr <= C r/rho, then to preserve the *linear* rate at r/2 we need

  2 gamma C + 2 A <= C.

Thus `gamma < 1` alone is not sufficient for this specific recurrence.  A
standard sufficient regime is gamma < 1/2 with C chosen large enough.
-/
theorem linear_rate_one_step
    (s : OneStepCampanato)
    (C : ℝ)
    (hC_nonneg : 0 ≤ C)
    (hJr : s.Jr ≤ C * (s.r / s.rho))
    (hclose : 2 * s.gamma * C + 2 * s.A ≤ C) :
    s.JrHalf ≤ C * ((s.r / 2) / s.rho) := by
  have h1 : s.gamma * s.Jr ≤ s.gamma * (C * (s.r / s.rho)) :=
    mul_le_mul_of_nonneg_left hJr s.hgamma_nonneg
  have hrec :
      s.JrHalf ≤ s.gamma * (C * (s.r / s.rho)) + s.A * (s.r / s.rho) := by
    calc
      s.JrHalf ≤ s.gamma * s.Jr + s.A * (s.r / s.rho) := s.recurrence
      _ ≤ s.gamma * (C * (s.r / s.rho)) + s.A * (s.r / s.rho) :=
        add_le_add_right h1 (s.A * (s.r / s.rho))
  have hrho_ne : s.rho ≠ 0 := ne_of_gt s.hrho_pos
  have hr_nonneg : 0 ≤ s.r := le_of_lt s.hr_pos
  have hratio_nonneg : 0 ≤ s.r / s.rho := div_nonneg hr_nonneg (le_of_lt s.hrho_pos)
  have hcoef : s.gamma * C + s.A ≤ C / 2 := by
    linarith
  have hmul := mul_le_mul_of_nonneg_right hcoef hratio_nonneg
  calc
    s.JrHalf
        ≤ s.gamma * (C * (s.r / s.rho)) + s.A * (s.r / s.rho) := hrec
    _ = (s.gamma * C + s.A) * (s.r / s.rho) := by ring
    _ ≤ (C / 2) * (s.r / s.rho) := hmul
    _ = C * ((s.r / 2) / s.rho) := by field_simp [hrho_ne] <;> ring

/--
Conditional dyadic closure marker.  No PDE claim is hidden here: callers must
supply the one-step recurrence at every scale.
-/
structure DyadicClosureData where
  C : ℝ
  gamma : ℝ
  A : ℝ
  hC_nonneg : 0 ≤ C
  hgamma_nonneg : 0 ≤ gamma
  hA_nonneg : 0 ≤ A
  hclose : 2 * gamma * C + 2 * A ≤ C

inductive DynamicCampanatoAuditStatus
  | algebraicOneStepProved
  | dyadicClosureConditional
  | pdeRecurrenceOpen
  deriving DecidableEq, Repr

end G1Audit
