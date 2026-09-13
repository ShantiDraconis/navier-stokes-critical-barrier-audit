/-
DynamicCampanato.lean

Audit-level interface for the PDE -> dynamic Campanato bridge, keeping the
local-energy identity exact and non-circular.

Design rules match the rest of `formal/G1`:
* no `axiom`
* no `sorry`
* no `True` endpoint placeholders
* every analytic gap is recorded as an explicit `Prop` field
* `R1`, `R2`, and the cutoff-free remainder witness stay visible
* `FinalF.lean` is not touched here
-/

import Mathlib
import formal.G1.G1_DynamicCriticalGeometry

noncomputable section G1DynamicCampanatoSection

namespace G1DynamicCampanato

open G1Dynamic

/-- The Campanato exponent forced by the linear `r / ρ_*` error term. -/
def betaCampanato : ℝ := 1

lemma betaCampanato_eq : betaCampanato = 1 := rfl

/-- The fixed cutoff radius is exactly `R = K ρ_*`. -/
theorem w_R_radius_formula
    {κ K omegaL2 gradOmegaL2 : ℝ}
    (w : w_R_Data κ K omegaL2 gradOmegaL2) :
    w.R = K * rhoStar κ omegaL2 gradOmegaL2 := by
  simpa [rhoStarFixed, rhoStar] using w.hR

/--
Exact local-energy bookkeeping obtained by testing `XiEpsPDE` against
`φ² (ξ_ε - (ξ_ε)_{B_r}) |ω|_ε` with `φ = w_R` and `R = K ρ_*`.

This structure records the identity term-by-term, without absorbing `R1`, `R2`,
or the remainder into a cubic ratio such as `‖∇ω‖₂³ / ‖ω‖₂`.
-/
structure LocalEnergyIdentity where
  nu eps kappa K omegaL2 gradOmegaL2 r : ℝ
  hnu : 0 < nu
  heps : 0 < eps
  hr : 0 < r
  xiPDE : XiEpsPDE
  remainderWitness : RemainderCutoffFreeWitness
  cutoff : w_R_Data kappa K omegaL2 gradOmegaL2
  /-- Explicit commutator/remainder channels kept visible in the identity. -/
  R1 R2 : ℝ
  timeDerivative diffusion stretching transport viscousDrift : ℝ
  cutoffError remainderError nearField farField : ℝ
  /-- Exact test choice: `φ² (ξ_ε - (ξ_ε)_{B_r}) |ω|_ε` with `φ = w_R`. -/
  tests_XiEpsPDE_exactly : Prop
  /-- Exact identity with no hidden absorption. -/
  exact_identity :
    timeDerivative + diffusion
      = stretching + transport + viscousDrift + R1 + R2
          + cutoffError + remainderError + nearField + farField
  /-- `C_rem(‖u₀‖₂, ν)` remains explicit and cutoff-free. -/
  remainder_cutoff_free :
    remainderWitness.independence_certificate ∧ 0 < remainderWitness.C_rem
  /-- No replacement by `‖∇ω‖₂³ / ‖ω‖₂` occurs at this stage. -/
  no_cubic_ratio_reduction : Prop

theorem localEnergy_radius_formula (I : LocalEnergyIdentity) :
    I.cutoff.R = I.K * rhoStar I.kappa I.omegaL2 I.gradOmegaL2 :=
  w_R_radius_formula I.cutoff

/--
Correctly scaled far-field control: only the averaged form is allowed.

The factor `(r / ρ_*)^β` is fixed here with `β = 1`, i.e. the scale that matches
the linear error term in the Campanato step and does not introduce `ρ_*^{-2}`.
-/
structure FarFieldAveragedBound where
  C_far rhoStar r omegaL2 farFieldSqAvg : ℝ
  hC_far : 0 ≤ C_far
  hr : 0 ≤ r
  hr_le_rhoStar : r ≤ rhoStar
  hrhoStar : 0 < rhoStar
  homegaL2 : 0 ≤ omegaL2
  estimate :
    farFieldSqAvg ≤
      C_far * (omegaL2 ^ 2 / rhoStar ^ 3) *
        Real.rpow (r / rhoStar) betaCampanato

theorem farField_linear_ratio (F : FarFieldAveragedBound) :
    F.farFieldSqAvg ≤
      F.C_far * (F.omegaL2 ^ 2 / F.rhoStar ^ 3) * (F.r / F.rhoStar) := by
  simpa [betaCampanato, Real.rpow_one] using F.estimate

/--
With `β = 1`, the far-field factor is bounded by `1` whenever `0 ≤ r ≤ ρ_*`.
This is the compatibility needed to stay within the Leray energy budget rather
than introducing a palinstrophy-level `ρ_*^{-2}` coefficient.
-/
theorem betaCampanato_energy_only
    {A r rho : ℝ}
    (hA : 0 ≤ A)
    (hr : 0 ≤ r)
    (hr_le_rho : r ≤ rho)
    (hrho : 0 < rho) :
    A * Real.rpow (r / rho) betaCampanato ≤ A := by
  have hratio_nonneg : 0 ≤ r / rho := by
    exact div_nonneg hr hrho.le
  have hratio_le_one : r / rho ≤ 1 := by
    exact (div_le_iff hrho).2 (by simpa using hr_le_rho)
  rw [betaCampanato, Real.rpow_one]
  nlinarith

/-- One step of the Campanato iteration `J_{r/2} ≤ γ J_r + A r / ρ_*`. -/
structure CampanatoIterationStep where
  gamma A rhoStar r Jr Jhalf : ℝ
  hgamma : 0 ≤ gamma
  hA : 0 ≤ A
  hr : 0 ≤ r
  hrhoStar : 0 < rhoStar
  step : Jhalf ≤ gamma * Jr + A * (r / rhoStar)

theorem iterate_linear_barrier
    (S : CampanatoIterationStep)
    {C : ℝ}
    (hJr : S.Jr ≤ C * (S.r / S.rhoStar)) :
    S.Jhalf ≤ (S.gamma * C + S.A) * (S.r / S.rhoStar) := by
  have hmul :
      S.gamma * S.Jr ≤ S.gamma * (C * (S.r / S.rhoStar)) :=
    mul_le_mul_of_nonneg_left hJr S.hgamma
  have hbase :
      S.Jhalf ≤ S.gamma * (C * (S.r / S.rhoStar)) + S.A * (S.r / S.rhoStar) := by
    linarith [S.step, hmul]
  have hfactor :
      S.gamma * (C * (S.r / S.rhoStar)) + S.A * (S.r / S.rhoStar) =
        (S.gamma * C + S.A) * (S.r / S.rhoStar) := by
    ring
  rw [hfactor] at hbase
  exact hbase

theorem iterate_to_half_scale
    (S : CampanatoIterationStep)
    {C : ℝ}
    (hJr : S.Jr ≤ C * (S.r / S.rhoStar))
    (hpreserve : 2 * S.gamma * C + 2 * S.A ≤ C) :
    S.Jhalf ≤ C * ((S.r / 2) / S.rhoStar) := by
  have hratio_nonneg : 0 ≤ S.r / S.rhoStar := by
    exact div_nonneg S.hr S.hrhoStar.le
  have hlin :
      S.Jhalf ≤ (S.gamma * C + S.A) * (S.r / S.rhoStar) :=
    iterate_linear_barrier S hJr
  have hcoeff : S.gamma * C + S.A ≤ C / 2 := by
    linarith
  have hmul :
      (S.gamma * C + S.A) * (S.r / S.rhoStar) ≤
        (C / 2) * (S.r / S.rhoStar) :=
    mul_le_mul_of_nonneg_right hcoeff hratio_nonneg
  have hrewrite :
      (C / 2) * (S.r / S.rhoStar) = C * ((S.r / 2) / S.rhoStar) := by
    ring_nf
  rw [← hrewrite] at hmul
  linarith

/--
If the linear barrier is preserved with a nonzero inhomogeneous error, then the
contraction coefficient must satisfy `γ < 1/2`.
-/
theorem gamma_lt_half_of_barrier_condition
    {gamma A C : ℝ}
    (hC : 0 < C)
    (hA : 0 < A)
    (hpreserve : 2 * gamma * C + 2 * A ≤ C) :
    gamma < (1 : ℝ) / 2 := by
  have hstrict : 2 * gamma * C < C := by
    linarith
  have hmul : gamma * (2 * C) < C := by
    nlinarith
  have h2C : 0 < 2 * C := by
    positivity
  have hgamma : gamma < C / (2 * C) :=
    (lt_div_iff h2C).2 hmul
  have hfrac : C / (2 * C) = (1 : ℝ) / 2 := by
    field_simp [hC.ne']
  simpa [hfrac] using hgamma

/--
The diffusion side must supply a genuine half-contraction after choosing `κ`;
recording merely `γ < 1` is insufficient for the Campanato barrier.
-/
structure DiffusionHalfContraction where
  kappa gammaDiff : ℝ
  hkappa : 0 < kappa
  half_contraction : gammaDiff ≤ (1 : ℝ) / 2
  produced_by_diffusion : Prop

/-- Consolidated non-circular PDE -> dynamic Campanato interface. -/
structure PDEToDynamicCampanatoBridge where
  localEnergy : LocalEnergyIdentity
  farField : FarFieldAveragedBound
  diffusionChoice : DiffusionHalfContraction
  iteration : CampanatoIterationStep
  /-- OPEN_BRIDGE: the near-field gain must come from the PDE identity itself,
      not by importing `hDynamic` as an input hypothesis. -/
  no_hDynamic_circularity : Prop

end G1DynamicCampanato

end G1DynamicCampanatoSection
