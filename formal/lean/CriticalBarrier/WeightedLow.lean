import Mathlib

/-!
# WeightedLow

This module formalizes the *logical* part of the weighted-low-vorticity route while
leaving the genuinely analytic estimate as an explicit hypothesis/interface.

No `sorry`, `axiom`, or hidden use of `sup y` occurs here.

The open analytic theorem is the derivation, from `ActualNS`, of a uniform-in-epsilon
weighted low-vorticity estimate and the corresponding strict weighted absorption.
-/

namespace CriticalBarrier.WeightedLow

/-- Data for the low-vorticity weighted estimate. -/
structure WeightedLowData where
  etaLow : ℝ → ℝ
  C_low : ℝ
  C_low_nonneg : 0 ≤ C_low
  eta_nonneg : ∀ δ, 0 ≤ etaLow δ
  quantitative : ∀ {δ : ℝ}, 0 ≤ δ → etaLow δ ≤ C_low * Real.sqrt δ

/-- The quantitative `sqrt(delta)` estimate forces the low-tail modulus to vanish. -/
theorem etaLow_tendsto_zero (D : WeightedLowData) :
    Filter.Tendsto D.etaLow (nhdsWithin 0 (Set.Ici 0)) (nhds 0) := by
  rw [Metric.tendsto_nhdsWithin_iff]
  intro ε hε
  refine ⟨min 1 ((ε / (D.C_low + 1)) ^ 2), ?_, ?_⟩
  · exact lt_min (by norm_num) (sq_pos_of_pos (div_pos hε (by linarith [D.C_low_nonneg])))
  · intro δ hδ0 hδ
    have hδ_nonneg : 0 ≤ δ := hδ0
    have hq := D.quantitative hδ_nonneg
    have hCpos : 0 < D.C_low + 1 := by linarith [D.C_low_nonneg]
    have hroot_nonneg : 0 ≤ Real.sqrt δ := Real.sqrt_nonneg δ
    have hδ_sq : δ < (ε / (D.C_low + 1)) ^ 2 := by
      exact lt_of_lt_of_le hδ (min_le_right _ _)
    have hsqrt : Real.sqrt δ < ε / (D.C_low + 1) := by
      rw [Real.sqrt_lt' (div_nonneg (le_of_lt hε) (le_of_lt hCpos))]
      simpa [pow_two] using hδ_sq
    have hscale : D.C_low * Real.sqrt δ < ε := by
      calc
        D.C_low * Real.sqrt δ ≤ (D.C_low + 1) * Real.sqrt δ := by
          nlinarith
        _ < (D.C_low + 1) * (ε / (D.C_low + 1)) := by
          gcongr
        _ = ε := by field_simp
    have heta : D.etaLow δ < ε := lt_of_le_of_lt hq hscale
    rw [Real.dist_eq]
    simpa [abs_of_nonneg (D.eta_nonneg δ)] using heta

/--
Abstract strict absorption package.

`comm` is the weighted commutator/error contribution, `diss` the coercive term,
and `lower` the integrable lower-order contribution.  The hard theorem is to construct
this package from the mollified Navier--Stokes equations with constants independent of
`epsilon` and without any `sup y` input.
-/
structure WeightedAbsorptionData where
  comm diss lower : ℝ
  gamma : ℝ
  gamma_nonneg : 0 ≤ gamma
  gamma_lt_one : gamma < 1
  diss_nonneg : 0 ≤ diss
  lower_nonneg : 0 ≤ lower
  bound : comm ≤ gamma * diss + lower

/-- Strict subcriticality is preserved exactly once the analytic package is available. -/
theorem strict_absorption (D : WeightedAbsorptionData) :
    D.comm ≤ D.gamma * D.diss + D.lower ∧ D.gamma < 1 := by
  exact ⟨D.bound, D.gamma_lt_one⟩

/--
Time-dependent coefficient interface.  `aL1` is intentionally explicit: proving it from
energy alone, with no `sup y`, is a separate analytic obligation.
-/
structure IntegrableCoefficient where
  a : ℝ → ℝ
  nonneg : ∀ t, 0 ≤ a t
  aL1 : MeasureTheory.Integrable a

/-- Current numerical bookkeeping used by the audit: 2 * 0.6^2 * 50 = 36. -/
theorem audit_constant_36 :
    (2 : ℝ) * (0.6 : ℝ) ^ 2 * 50 = 36 := by
  norm_num

/--
Signed-depletion interface.  Note that this statement keeps the sign of the stretching
term and does not replace it by an absolute value.
-/
structure SignedDepletionData where
  stretch y z nu a : ℝ
  theta : ℝ
  nu_pos : 0 < nu
  theta_nonneg : 0 ≤ theta
  theta_lt_one : theta < 1
  y_nonneg : 0 ≤ y
  z_nonneg : 0 ≤ z
  a_nonneg : 0 ≤ a
  depletion : stretch ≤ theta * nu * z + a * y

/-- The coefficient of the remaining dissipation is strictly positive. -/
theorem residual_dissipation_positive (D : SignedDepletionData) :
    0 < (1 - D.theta) * D.nu := by
  positivity

/--
OPEN ANALYTIC BRIDGE (documentation-level declaration): construct `WeightedLowData`,
`WeightedAbsorptionData`, and `SignedDepletionData` from ActualNS uniformly in epsilon.
This is intentionally *not* represented by an axiom in Lean.
-/

end CriticalBarrier.WeightedLow
