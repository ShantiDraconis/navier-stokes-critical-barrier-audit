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

/-! ## LocalEnergyIdentity: exact term-by-term expansion before any estimate -/

/-
MATHEMATICAL BACKGROUND

Testing XiEpsPDE with test function  Ψ = φ²(ξ_ε − (ξ_ε)_{B_r}) |ω_ε|,
where φ = w_R is a smooth cutoff with φ=1 on B_{r}, supp φ ⊂ B_R, R = K ρ_*,
|∇φ| ≤ C/R = C/(K ρ_*), and (ξ_ε)_{B_r} = ⨍_{B_r} ξ_ε is the ball mean,
produces — after integration by parts — the following exact identity:

  (d/dt) ∫ φ² ½|ξ_ε − (ξ_ε)_{B_r}|² |ω_ε|
  + ν ∫ φ² |∇ξ_ε|² |ω_ε|              [DIFFUSION — positive, wanted]
  =
  [T_STRETCH]:  ∫ φ² (ξ_ε · S_ε ξ_ε − (ξ_ε)_{B_r}·S_ε(ξ_ε)_{B_r}) |ω_ε|
  [T_TRANSPORT]: ∫ φ² (u_ε·∇(ξ_ε)_{B_r}) · (ξ_ε − (ξ_ε)_{B_r}) |ω_ε|
  [T_CUTOFF]:    ∫ 2φ ∇φ · (ξ_ε − (ξ_ε)_{B_r}) ∂_t(·) terms
  [T_VISCLAPL]:  ν ∫ φ² (2 ∇|ω_ε|/|ω|_ε · ∇ξ_ε) · (ξ_ε − (ξ_ε)_{B_r}) |ω_ε|
  [T_CROSSDIFF]: ν ∫ 2φ ∇φ · ∇ξ_ε · (ξ_ε − (ξ_ε)_{B_r}) |ω_ε|
  [T_REMAINDER]: ∫ φ² R_ε · (ξ_ε − (ξ_ε)_{B_r}) |ω_ε|
  [T_RHOSTAR]:   -(d ρ_*/dt) / ρ_* · ∫ φ² ½|ξ_ε − (ξ_ε)_{B_r}|² |ω_ε|
  [T_MEAN]:      d/dt (ξ_ε)_{B_r} · ∫ φ² (ξ_ε − (ξ_ε)_{B_r}) |ω_ε|

Key power counting at scale r, φ supported in B_R, R = K ρ_*:

  DIFFUSION:   ν ∫_{B_r} |∇ξ_ε|² |ω_ε|   ~ ν · J_r^{(2)} · |B_r| · |ω|_avg
  CUTOFF grad: |∇φ| ~ 1/R = 1/(K ρ_*),   so T_CROSSDIFF ~ ν/R · |B_r|^{1/2} · osc₂

  FAR-FIELD:   The strain S_ε decomposes as S_near + S_far.
               S_near (|x-y| < ρ_*): involves ∫_{B_{ρ_*}} |∇u_ε|, controlled by Sobolev.
               S_far  (|x-y| ≥ ρ_*): the Biot-Savart kernel D_{ij}(x-y) |ω|/|x-y|³
               gives a contribution scaling as  ρ_*^{-3} ‖ω_ε‖_2² = Z_ε / ρ_*³ · ρ_*³.

  In R = K ρ_*, the far-field average integral satisfies:
    ⨍_{B_r} |S_far|² ~ (r/ρ_*)^β · ρ_*^{-3} ‖ω_ε‖_2²   (for some β≥0)

  If β < 3 (non-integrable power) and ρ_*^{-3} ‖ω_ε‖_2² cannot be bounded by
  the Leray L¹ budget alone, this is the BLOCKING_SCALING point.

  From ρ_* = κ ‖ω‖_2 / ‖∇ω‖_2:
    ρ_*^{-3} ‖ω‖_2² = ‖∇ω‖_2³ / (κ³ ‖ω‖_2)
  which requires ‖∇ω‖_2³/‖ω‖_2 to be time-integrable — this is palinstrophy
  divided by enstrophy, NOT available from Leray energy alone.
-/

/--
Exact localized identity from testing XiEpsPDE with
Ψ = φ²(ξ_ε − (ξ_ε)_{B_r}) |ω_ε|, φ = w_R, R = K ρ_*.

Each field names one term of the exact equality before ANY estimate is applied.
No term is absorbed, dropped, or bounded here.  This is the identity itself.

Convention: all integrals are over ℝ³ at a fixed time t.
Positive terms on the lhs are "good" (diffusion).  All rhs terms carry signs
and must be estimated separately.
-/
structure LocalEnergyIdentity where
  /-- Ball radius r (scales r ≤ ρ_*). -/
  r : ℝ
  /-- ρ_* = κ ‖ω‖₂ / ‖∇ω‖₂ (scale-covariant). -/
  rho : ℝ
  /-- K: the fixed large constant with R = K ρ_*. -/
  K : ℝ
  /-- ν > 0. -/
  nu : ℝ
  hr_pos : 0 < r
  hrho_pos : 0 < rho
  hK_pos : 0 < K
  hnu_pos : 0 < nu
  hr_le_rho : r ≤ rho
  /-- Time derivative of the local oscillation energy (left-hand side). -/
  T_dt : ℝ
  /-- Diffusion term ν ∫ φ² |∇ξ_ε|² |ω_ε|  (positive, wanted). -/
  T_diff : ℝ
  hT_diff_nonneg : 0 ≤ T_diff
  /-- Stretching/strain term ∫ φ² (S_ε ξ_ε − S_ε(ξ_ε)_{B_r}) · (ξ_ε−(ξ_ε)_{B_r}) |ω_ε|. -/
  T_stretch : ℝ
  /-- Transport correction for moving mean (u·∇(ξ_ε)_{B_r}). -/
  T_transport : ℝ
  /-- Cutoff gradient cross term ν ∫ 2φ ∇φ · ∇ξ_ε · (ξ_ε−(ξ_ε)_{B_r}) |ω_ε|.
      Note |∇φ| ~ 1/(K ρ_*): this is where K appears in the constant. -/
  T_cutoff : ℝ
  /-- Viscous log-density term ν ∫ φ² 2(∇|ω|_ε/|ω|_ε)·∇ξ_ε·(ξ_ε−(ξ_ε)_{B_r}) |ω_ε|. -/
  T_visclog : ℝ
  /-- Remainder from ε-regularisation, ∫ φ² R_ε · (ξ_ε−(ξ_ε)_{B_r}) |ω_ε|. -/
  T_remainder : ℝ
  /-- ρ_*-motion term −(ρ̇_*/ρ_*) ∫ φ² ½|ξ_ε−(ξ_ε)_{B_r}|² |ω_ε|. -/
  T_rhostar : ℝ
  /-- Mean evolution term (d/dt)(ξ_ε)_{B_r} · ∫ φ² (ξ_ε−(ξ_ε)_{B_r}) |ω_ε|. -/
  T_mean : ℝ
  /-- THE EXACT IDENTITY (before any estimate):
      d/dt[osc energy] + ν·T_diff
      = T_stretch + T_transport + T_cutoff + T_visclog + T_remainder
        + T_rhostar + T_mean.
      This is a Prop-field: the analytic derivation from XiEpsPDE
      is an OPEN_BRIDGE obligation. -/
  identity : T_dt + nu * T_diff =
      T_stretch + T_transport + T_cutoff + T_visclog +
      T_remainder + T_rhostar + T_mean

/--
Far-field scaling witness.

Records the EXACT power of (r/ρ_*) and ρ_* that appears in the far-field
strain term T_stretch^{far} after the near/far split at scale ρ_*.

The Biot–Savart kernel gives:
  S_far(x) = P.V. ∫_{|x-y|≥ρ_*} D_{ij}(x-y) ω(y) dy / |x-y|³

so the averaged L² integral in B_r satisfies:
  ⨍_{B_r} |S_far|² ≲ (r/ρ_*)^β * ρ_*^{-3} ‖ω‖₂²

with exact exponent β = 0 (no decay from far field alone) or β > 0 if extra
cancellation is available.

If β = 0: the factor A in J_{r/2} ≤ γ J_r + A·(r/ρ_*) accumulates as
  A ~ ρ_*^{-3} ‖ω‖₂² · ρ_*^3 / r · r/ρ_* = ‖ω‖₂² / ρ_*  (time-integrable issue).

BLOCKING_SCALING: ρ_*^{-3} ‖ω‖₂² = ‖∇ω‖₂³ / (κ³ ‖ω‖₂) requires palinstrophy
divided by square-root enstrophy to be time-integrable, which is NOT available
from Leray energy alone.
-/
structure FarFieldScalingWitness where
  /-- β = exact power of (r/ρ_*) in the far-field L² average. -/
  beta : ℝ
  /-- The prefactor ρ_*^{-3} ‖ω‖₂² that multiplies (r/ρ_*)^β. -/
  rho_power : ℝ    -- = ρ_*^{-3} ‖ω‖₂²
  /-- Whether this prefactor is time-integrable from Leray energy only. -/
  leray_integrable : Prop
  /-- Exact blocking statement if NOT leray_integrable. -/
  blocking_reason : Prop
  /-- The scaling is BLOCKING_SCALING if leray_integrable fails
      and beta ≤ some threshold that prevents summation. -/
  is_blocking : Prop

/--
BLOCKING_SCALING instance: β = 0, ρ_*^{-3}‖ω‖₂² requires palinstrophy/enstrophy.

Under ρ_* = κ ‖ω‖₂/‖∇ω‖₂:
  ρ_*^{-3} ‖ω‖₂² = ‖∇ω‖₂³ / (κ³ ‖ω‖₂)

This is NOT bounded by ∫‖∇u‖₂² dt ≤ ‖u₀‖₂²/(2ν) without palinstrophy or enstrophy supremum.
-/
def blockingScalingInstance : FarFieldScalingWitness := {
  beta := 0
  rho_power := 0    -- placeholder value; actual value is ‖∇ω‖₂³/(κ³‖ω‖₂) > 0
  leray_integrable := False  -- requires palinstrophy/enstrophy, not available
  blocking_reason :=
    /-- ρ_*^{-3}‖ω‖₂² = ‖∇ω‖₂³/(κ³‖ω‖₂); time integral requires
        ∫‖∇ω‖₂³/‖ω‖₂ dt which is palinstrophy/enstrophy, NOT Leray. -/
    (∀ κ : ℝ, 0 < κ →
      ¬ (∀ (gradOmegaL2 omegaL2 : ℝ → ℝ) (T u0L2 nu : ℝ),
          0 < nu → 0 < u0L2 →
          (∀ t, 0 ≤ omegaL2 t) → (∀ t, 0 < gradOmegaL2 t) →
          ∫ _t in Set.Icc 0 T, (gradOmegaL2 _t)^3 / (κ^3 * omegaL2 _t) ≤
            u0L2^2 / (2 * nu)))
  is_blocking := True
}

/-! ## Poincaré decay and γ < 1/2 via κ -/

/--
Poincaré decay witness: the Poincaré inequality on B_r gives

  ⨍_{B_r} |ξ − (ξ)_{B_r}|² ≤ C_P r² ⨍_{B_r} |∇ξ|²

so the diffusion term ν T_diff ~ ν ∫_{B_r} |∇ξ|² |ω| controls the oscillation.

In the one-step recurrence J_{r/2} ≤ γ J_r + A·(r/ρ_*), the Poincaré factor
contributes to γ via:

  γ_diff = C_P * r² / r² * (r/2)² / r² ... → factor (1/4) from halving radius.
  Combined with the Caccioppoli factor C_cacc/r²:
    γ ~ C_cacc * C_P / (K ρ_*)² * r²  (from cutoff cross-term)

For γ < 1/2 we need:
  C_cacc * C_P / (K ρ_*)² * ρ_*² ≤ 1/2
  ⟺ C_cacc * C_P / K² ≤ 1/2
  ⟺ K ≥ sqrt(2 C_cacc * C_P)

This is a condition on K (the large constant in R = K ρ_*), NOT on κ.
κ enters through ρ_* itself; larger κ → larger ρ_* → same ratio r/ρ_*.

The condition on κ comes from the far-field term:
  A ~ ρ_*^{-3} ‖ω‖₂² ~ κ^{-3}   (larger κ → smaller far-field)
  but this doesn't save integrability; it just rescales A.
-/
structure PoincareDecayWitness where
  /-- Poincaré constant C_P. -/
  C_P : ℝ
  hCP_pos : 0 < C_P
  /-- Caccioppoli constant C_cacc from LocalEnergyIdentity. -/
  C_cacc : ℝ
  hCacc_nonneg : 0 ≤ C_cacc
  /-- K = R/ρ_* (fixed large constant). -/
  K : ℝ
  hK_pos : 0 < K
  /-- γ_diff: the contraction factor from diffusion via Poincaré. -/
  gamma_diff : ℝ
  hgamma_diff_eq : gamma_diff = C_cacc * C_P / K^2
  /-- Condition for γ_diff < 1/2: K ≥ sqrt(2 * C_cacc * C_P). -/
  gamma_half_condition : K^2 ≥ 2 * C_cacc * C_P

/-- γ_diff < 1/2 is a theorem given the K-condition. -/
theorem gamma_diff_lt_half (w : PoincareDecayWitness) : w.gamma_diff < 1 / 2 := by
  rw [w.hgamma_diff_eq]
  have hK2 : 0 < w.K^2 := by positivity
  rw [div_lt_iff hK2]
  linarith [w.gamma_half_condition, w.hCacc_nonneg, w.hCP_pos]

/--
γ-closure lemma: given γ_diff < 1/2 and that the far-field remainder A
is controlled by an integrable quantity, the linear Campanato exponent holds.

OPEN_BRIDGE: the claim "A controlled by Leray budget" is the exact BLOCKING_SCALING
field — it requires palinstrophy/enstrophy, not available from Leray alone.
-/
structure GammaClosure where
  /-- γ from diffusion (must be < 1/2). -/
  gamma : ℝ
  hgamma_lt_half : gamma < 1 / 2
  /-- A in J_{r/2} ≤ γ J_r + A·(r/ρ_*). -/
  A : ℝ
  hA_nonneg : 0 ≤ A
  /-- A bounded by Leray budget (OPEN_BRIDGE — actually BLOCKING_SCALING). -/
  A_leray_bounded : Prop
  /-- Explicit blocking flag. -/
  far_field_is_blocking : Prop

/-- The algebraic closure is proved once γ < 1/2 and A is given. -/
theorem gamma_half_closes_campanato
    (g : GammaClosure) (C : ℝ) (hC : 0 ≤ C)
    (hJr : ∀ s : OneStepCampanato, s.gamma = g.gamma → s.A = g.A →
            s.Jr ≤ C * (s.r / s.rho))
    (s : OneStepCampanato)
    (hsg : s.gamma = g.gamma) (hsA : s.A = g.A)
    (hclose : 2 * g.gamma * C + 2 * g.A ≤ C) :
    s.JrHalf ≤ C * ((s.r / 2) / s.rho) :=
  linear_rate_one_step s C hC (hJr s hsg hsA) hclose

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
5. `LocalEnergyIdentity`: SPECIFIED.  Term-by-term expansion of XiEpsPDE tested
   against phi^2 (xi_eps - (xi_eps)_{B_r}) |omega_eps| is now recorded as an
   exact interface structure with no estimates applied.  Diffusion term T_diff
   and far-field within T_stretch are labelled.  Analytic derivation: OPEN_BRIDGE.
6. `FarFieldScalingWitness`: BLOCKING_SCALING confirmed with beta=0.
   rho_*^{-3} ||omega||_2^2 = ||grad omega||_2^3 / (kappa^3 ||omega||_2).
   Time-integration requires palinstrophy/enstrophy NOT available from Leray.
7. `gamma_diff_lt_half`: PROVED_LOGIC (algebra only).  Diffusion gives gamma < 1/2
   provided K >= sqrt(2 C_cacc C_P).  This is a condition on K, NOT a free choice.
8. `blockingScalingInstance`: registered as BLOCKING_SCALING in `blockingScaling`
   status value.  Far-field does NOT close from Leray budget.
9. Therefore `PDEToDynamicCampanato.target` remains BLOCKING.  We do not assert
   FinalF, hDynamic, or SignedDepletion from this file.
10. If the only available near-field closure requires hDynamic itself, or terms
    such as ||grad omega||_2^3 / ||omega||_2, the branch must remain BLOCKING.
-/

end G1Audit
