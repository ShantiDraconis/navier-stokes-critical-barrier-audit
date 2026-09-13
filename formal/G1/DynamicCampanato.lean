/-
DynamicCampanato.lean

Non-circular audit of the PDE -> Dynamic Campanato bridge.

The file proves only the algebraic/ordering consequences that genuinely follow
from abstract estimates.  The PDE realization remains isolated in structures
whose fields state exactly the missing analytic estimates.

No `axiom`, no `sorry`, no `admit`, no use of `sup_t ||omega||_2^2`, and no
uniform `integral ||grad omega||_2^2` are introduced.
-/

import Mathlib

noncomputable section

namespace G1Audit

structure DynamicCampanatoData (Point : Type*) where
  J : ℝ → Point → ℝ → ℝ
  rhoStar : ℝ → ℝ
  K : ℝ
  u0L2 : ℝ
  nu : ℝ
  theta : ℝ
  Ccamp : ℝ
  hJ_nonneg : ∀ r x t, 0 ≤ J r x t
  hrho_pos : ∀ t, 0 < rhoStar t
  hnu_pos : 0 < nu
  htheta : theta = (1 / 2 : ℝ)
  hCcamp_nonneg : 0 ≤ Ccamp

def CampanatoRadiusAdmissible {Point : Type*}
    (d : DynamicCampanatoData Point) (r t : ℝ) : Prop :=
  0 < r ∧ r ≤ d.rhoStar t

def DynamicCampanatoTarget {Point : Type*}
    (d : DynamicCampanatoData Point) : Prop :=
  ∀ r x t,
    CampanatoRadiusAdmissible d r t →
    d.J r x t ≤ d.Ccamp * (r / d.rhoStar t)

/-- Approximation-level quantities paid for by the Leray kinetic-energy budget. -/
structure CutoffFreeApproximationData where
  eps : ℝ
  gradUEpsSq : ℝ → ℝ
  aEps : ℝ → ℝ
  Ckappa : ℝ
  hEps_pos : 0 < eps
  hGrad_nonneg : ∀ t, 0 ≤ gradUEpsSq t
  hCkappa_nonneg : 0 ≤ Ckappa

/--
Allowed remainder witness:
  a_eps(t) <= C_kappa ||grad u_eps(t)||_2^2.

There is intentionally no enstrophy supremum and no palinstrophy integral here.
-/
structure RemainderCutoffFreeWitness (d : CutoffFreeApproximationData) where
  a_nonneg : ∀ t, 0 ≤ d.aEps t
  pointwise_budget : ∀ t, d.aEps t ≤ d.Ckappa * d.gradUEpsSq t

structure LerayEnergyIntegralBudget (d : CutoffFreeApproximationData) where
  gradIntegral : ℝ
  aIntegral : ℝ
  hgradIntegral_nonneg : 0 ≤ gradIntegral
  haIntegral_nonneg : 0 ≤ aIntegral
  aIntegral_le_Ckappa_gradIntegral :
    aIntegral ≤ d.Ckappa * gradIntegral

/-- Pure consequence of the kinetic-energy budget. -/
theorem remainder_integral_from_energy
    (d : CutoffFreeApproximationData)
    (b : LerayEnergyIntegralBudget d)
    (u0L2 nu : ℝ)
    (hnu : 0 < nu)
    (hEnergy : b.gradIntegral ≤ u0L2 ^ 2 / (2 * nu)) :
    b.aIntegral ≤ d.Ckappa * (u0L2 ^ 2 / (2 * nu)) := by
  have hmul := mul_le_mul_of_nonneg_left hEnergy d.hCkappa_nonneg
  exact le_trans b.aIntegral_le_Ckappa_gradIntegral hmul

/-! ## PDE testing and Caccioppoli interfaces -/

/--
The concrete local-energy test requested in the analytic program:

  test XiEpsPDE against
    phi^2 (xi_eps - (xi_eps)_{B_r}) |omega_eps|.

The scalar fields below stand for the realized integrals after all integration by
parts.  This structure is not a theorem; it is the exact proof obligation.
-/
structure LocalEnergyEstimate where
  r : ℝ
  rho : ℝ
  lhs : ℝ
  osc2 : ℝ
  aTerm : ℝ
  R1 : ℝ
  R2 : ℝ
  Ccacc : ℝ
  hr_pos : 0 < r
  hrho_pos : 0 < rho
  hr_le_rho : r ≤ rho
  hlhs_nonneg : 0 ≤ lhs
  hosc_nonneg : 0 ≤ osc2
  ha_nonneg : 0 ≤ aTerm
  hR1_nonneg : 0 ≤ R1
  hR2_nonneg : 0 ≤ R2
  hC_nonneg : 0 ≤ Ccacc
  /-- Caccioppoli form produced by the PDE test. -/
  caccioppoli :
    lhs ≤ Ccacc * (r⁻¹)^2 * osc2 + aTerm + R1 + R2

/--
Uniformity in epsilon is a separate obligation.  It is essential: an estimate
whose constant blows up as eps -> 0 cannot feed the limiting Campanato theorem.
-/
structure UniformLocalEnergyFamily where
  Ccacc : ℝ
  Crem : ℝ
  Cfar : ℝ
  hCcacc_nonneg : 0 ≤ Ccacc
  hCrem_nonneg : 0 ≤ Crem
  hCfar_nonneg : 0 ≤ Cfar
  constants_independent_of_eps : Prop
  derived_from_XiEpsPDE : Prop
  uses_only_Leray_energy_and_cutoff_free_remainder : Prop

/-! ## Far field: scale-correct formulation -/

/--
A far-field estimate suitable for a scale-invariant proof must record its norm
and normalization explicitly.  We do NOT encode the dimensionally suspect
pointwise statement

  ||S_far||_infty <= C(K) ||grad u||_2

with no scale factor.  Under Navier--Stokes scaling the two sides have different
homogeneities.  A local averaged estimate or an explicit rho-factor is required.
-/
structure FarFieldAveragedEstimate where
  rho : ℝ
  farL2Average : ℝ
  gradUL2 : ℝ
  CK : ℝ
  hRho_pos : 0 < rho
  hFar_nonneg : 0 ≤ farL2Average
  hGrad_nonneg : 0 ≤ gradUL2
  hCK_nonneg : 0 ≤ CK
  /-- Placeholder for a scale-correct CZ/localized estimate. -/
  estimate : Prop
  uniform_in_eps : Prop

/-! ## One-step Campanato decay and iteration -/

/--
One dyadic Campanato step.  The remainder is normalized to the *current* scale.

  J_{r/2} <= gamma J_r + A r/rho.
-/
structure OneStepCampanato where
  Jr : ℝ
  JrHalf : ℝ
  r : ℝ
  rho : ℝ
  gamma : ℝ
  A : ℝ
  hJr_nonneg : 0 ≤ Jr
  hJrHalf_nonneg : 0 ≤ JrHalf
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
      s.JrHalf ≤ s.gamma * (C * (s.r / s.rho)) + s.A * (s.r / s.rho) :=
    le_trans s.recurrence (add_le_add_right h1 (s.A * (s.r / s.rho)))
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
This is the exact non-circular analytic bridge still missing.  No hDynamic is
an input.  The bridge must be built from XiEpsPDE, the Leray energy budget,
uniform CZ/localized singular-integral estimates, and the cutoff-free remainder.
-/
structure PDEToDynamicCampanato {Point : Type*}
    (d : DynamicCampanatoData Point) where
  local_energy_family : UniformLocalEnergyFamily
  /-- Concrete Caccioppoli estimate from XiEpsPDE. -/
  caccioppoli_from_PDE : Prop
  /-- Scale-correct far-field singular-integral estimate, uniform in eps. -/
  far_field_uniform_CZ : Prop
  /-- Near-field term closes without assuming hDynamic. -/
  near_field_without_hDynamic : Prop
  /-- Dyadic decay has enough contraction for the desired exponent 1. -/
  dyadic_linear_contraction : Prop
  /-- eps -> 0 compactness/semicontinuity preserves all constants. -/
  eps_limit_uniform : Prop
  /-- Final target, only after the previous analytic obligations are proved. -/
  target : DynamicCampanatoTarget d

/-- Logical extraction only; does not manufacture the PDE proof. -/
theorem dynamic_campanato_of_bridge
    {Point : Type*}
    (d : DynamicCampanatoData Point)
    (bridge : PDEToDynamicCampanato d) :
    DynamicCampanatoTarget d :=
  bridge.target

/-! ## Audit firewall -/

/-- Forbidden circular inputs are represented only as labels for scanning. -/
inductive ForbiddenCircularInput
  | supEnstrophy
  | palinstrophyIntegral
  | gradOmegaCubedOverOmega
  | assumedHDynamic
  deriving DecidableEq, Repr

/-- Current status of the analytic attack. -/
inductive DynamicCampanatoStatus
  | provedLogic
  | openCZ
  | blockingScaling
  | blockingContraction
  | blockingCircularity
  deriving DecidableEq, Repr

/-
CURRENT AUDIT RESULT
====================

1. `remainder_integral_from_energy`: PROVED_LOGIC.
2. The requested Caccioppoli shape is now typed explicitly in `LocalEnergyEstimate`.
3. A pointwise far-field estimate `|S_far| <= C(K)||grad u||_2` without a scale
   factor is NOT accepted: it is not scale-homogeneous.  The proof must instead
   provide a scale-correct localized/averaged CZ estimate, uniform in epsilon.
4. For a recurrence
      J_{r/2} <= gamma J_r + A r/rho,
   `gamma < 1` alone does NOT preserve the target J_r <= C r/rho.  The algebraic
   closure condition is `2 gamma C + 2 A <= C`; in particular one typically
   needs gamma < 1/2 (or a sharper recurrence with smaller remainder).
5. Therefore `PDEToDynamicCampanato.target` remains BLOCKING.  We do not assert
   FinalF, hDynamic, or SignedDepletion from this file.
6. If the only available near-field closure requires hDynamic itself, or terms
   such as ||grad omega||_2^3 / ||omega||_2, the branch must remain BLOCKING.
-/

end G1Audit
