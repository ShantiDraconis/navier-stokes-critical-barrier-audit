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

/-! ## Exact localized XiEps identity before estimates -/

/--
Bookkeeping for the localized test

  psi = phi^2 (xi_eps - (xi_eps)_{B_r}) |omega_eps|,
  phi = w_R,  R = K rho_*.

No Calderon--Zygmund estimate and no absolute-value estimate is encoded here.
Each scalar is the corresponding signed integral after pairing XiEpsPDE with psi.

The convention is that `diffusionBulk` is the positive integral

  ∫ phi^2 |grad xi_eps|^2 |omega_eps|,

so the tested PDE places `nu * diffusionBulk` on the dissipative side.
The `diffusionWeightCross` and `logDrift` fields are kept separate on purpose:
when |omega|_eps is the same regularized magnitude used in log|omega|_eps,
the analytic derivation may combine one copy after integration by parts, but
this file does not assume that cancellation until it is proved.
-/
structure LocalEnergyIdentityData where
  r : ℝ
  rho : ℝ
  K : ℝ
  R : ℝ
  ballVolume : ℝ
  nu : ℝ

  /-- (1/2) d/dt ∫ phi^2 |xi_eps - mean|^2 |omega_eps|. -/
  timeEnergyDerivative : ℝ
  /-- Terms from d/dt(phi^2 |omega_eps|) and d/dt(mean_{B_r} xi_eps). -/
  timeWeightAndMean : ℝ
  /-- Transport contribution after the same localization, before estimation. -/
  transport : ℝ

  /-- Signed near-field stretching pairing. -/
  stretchNear : ℝ
  /-- Signed far-field stretching pairing; this is where S_eps^far occurs. -/
  stretchFar : ℝ

  /-- Positive bulk diffusion integral ∫ phi^2 |grad xi_eps|^2 |omega_eps|. -/
  diffusionBulk : ℝ
  /-- Cross term from grad(phi): 2∫ phi |omega| (xi-mean) grad phi : grad xi. -/
  diffusionCutoffCross : ℝ
  /-- Cross term from grad|omega_eps| in integration by parts. -/
  diffusionWeightCross : ℝ
  /-- 2∫ phi^2 |omega| (xi-mean)·(grad log|omega| · grad xi). -/
  logDrift : ℝ

  /-- Mollification/regularization remainder R1 paired with psi. -/
  R1 : ℝ
  /-- Mollification/regularization remainder R2 paired with psi. -/
  R2 : ℝ

  hr_pos : 0 < r
  hrho_pos : 0 < rho
  hK_pos : 0 < K
  hnu_pos : 0 < nu
  hR : R = K * rho
  hballVolume_pos : 0 < ballVolume

  /-- Exact signed identity after the localized test and integration by parts. -/
  identity :
    timeEnergyDerivative + timeWeightAndMean + transport + nu * diffusionBulk =
      stretchNear + stretchFar
        - nu * diffusionCutoffCross
        - nu * diffusionWeightCross
        + nu * logDrift
        + R1 + R2

/--
`LocalEnergyIdentity` is deliberately an extraction lemma: it records the exact
identity that the analytic XiEpsPDE derivation must instantiate.  It does not
manufacture that derivation from an absent formal PDE definition.
-/
theorem LocalEnergyIdentity (d : LocalEnergyIdentityData) :
    d.timeEnergyDerivative + d.timeWeightAndMean + d.transport + d.nu * d.diffusionBulk =
      d.stretchNear + d.stretchFar
        - d.nu * d.diffusionCutoffCross
        - d.nu * d.diffusionWeightCross
        + d.nu * d.logDrift
        + d.R1 + d.R2 :=
  d.identity

/-- The localization radius is exactly R = K rho_*. -/
theorem localization_radius_scale (d : LocalEnergyIdentityData) :
    d.R = d.K * d.rho :=
  d.hR

/--
Explicit scale ledger used before any CZ estimate.  `invBallVolume` represents
|B_r|^{-1}; `cutoffGradScale` and `cutoffLapScale` record the powers generated
by a cutoff w_R with R = K rho_*.
-/
structure LocalizedScaleLedger where
  r : ℝ
  rho : ℝ
  K : ℝ
  R : ℝ
  ballVolume : ℝ
  invBallVolume : ℝ
  cutoffGradScale : ℝ
  cutoffLapScale : ℝ
  hr_pos : 0 < r
  hrho_pos : 0 < rho
  hK_pos : 0 < K
  hR : R = K * rho
  hballVolume_pos : 0 < ballVolume
  hinvBall : invBallVolume = ballVolume⁻¹
  hgradScale : cutoffGradScale = R⁻¹
  hlapScale : cutoffLapScale = (R⁻¹)^2

/-- Substituting R = K rho_* exposes the exact cutoff power rho_*^{-1}. -/
theorem cutoff_grad_rho_power (s : LocalizedScaleLedger) :
    s.cutoffGradScale = (s.K * s.rho)⁻¹ := by
  rw [s.hgradScale, s.hR]

/-- Substituting R = K rho_* exposes the exact cutoff power rho_*^{-2}. -/
theorem cutoff_lap_rho_power (s : LocalizedScaleLedger) :
    s.cutoffLapScale = ((s.K * s.rho)⁻¹)^2 := by
  rw [s.hlapScale, s.hR]

/--
Poincare ledger at scale r:

  fint_{B_r} |xi - (xi)_{B_r}|^2
    <= C_P r^2 fint_{B_r} |grad xi|^2.

The statement is represented at the scalar-integral level so the audit can
check powers before a concrete measure-theoretic realization is introduced.
-/
structure PoincareCampanatoStep where
  r : ℝ
  oscAverage : ℝ
  gradAverage : ℝ
  CP : ℝ
  hr_pos : 0 < r
  hosc_nonneg : 0 ≤ oscAverage
  hgrad_nonneg : 0 ≤ gradAverage
  hCP_nonneg : 0 ≤ CP
  poincare : oscAverage ≤ CP * r^2 * gradAverage

/--
If the PDE/Caccioppoli calculation produces gamma = C(K) * kappa, then choosing
kappa < 1/(2 C(K)) gives the contraction required by the linear r/rho target.
This theorem is pure arithmetic; it does not assert that the PDE actually gives
such a gamma.
-/
theorem gamma_lt_half_of_CK_kappa
    (CK kappa gamma : ℝ)
    (hCK : 0 < CK)
    (hkappa_nonneg : 0 ≤ kappa)
    (hgamma : gamma = CK * kappa)
    (hkappa : kappa < 1 / (2 * CK)) :
    gamma < (1 / 2 : ℝ) := by
  rw [hgamma]
  have hmul := mul_lt_mul_of_pos_left hkappa hCK
  have hCKne : CK ≠ 0 := ne_of_gt hCK
  calc
    CK * kappa < CK * (1 / (2 * CK)) := hmul
    _ = (1 / 2 : ℝ) := by field_simp [hCKne]

/--
Scale of the naive pointwise far-field Cauchy--Schwarz bound for a |x-y|^{-3}
kernel in dimension three:

  |S_far|^2 ~ C K^{-3} rho_*^{-3} ||omega||_2^2.

This is only a scale ledger.  It is NOT a CZ theorem and is not assumed by the
Campanato bridge.  It exists so the audit can detect whether a later Young/CZ
step creates a nonintegrable rho_*^{-3} coefficient.
-/
structure FarFieldScalingLedger where
  K : ℝ
  rho : ℝ
  omegaL2Sq : ℝ
  CK : ℝ
  farSquaredScale : ℝ
  hK_pos : 0 < K
  hrho_pos : 0 < rho
  homega_nonneg : 0 ≤ omegaL2Sq
  hCK_nonneg : 0 ≤ CK
  exactPower :
    farSquaredScale = CK * K⁻¹^3 * rho⁻¹^3 * omegaL2Sq

/-! ## PDE testing and Caccioppoli interfaces -/

/--
The concrete local-energy test requested in the analytic program:

  test XiEpsPDE against
    phi^2 (xi_eps - (xi_eps)_{B_r}) |omega_eps|.

The scalar fields below stand for the realized integrals after all integration by
parts.  This structure is not a theorem; it is the exact proof obligation after
one begins estimating the signed identity above.
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
  /-- Caccioppoli form produced only after estimating the exact identity. -/
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
  | openPDEIdentity
  | openCZ
  | blockingScaling
  | blockingContraction
  | blockingCircularity
  deriving DecidableEq, Repr

/-
CURRENT AUDIT RESULT
====================

1. `remainder_integral_from_energy`: PROVED_LOGIC.
2. `LocalEnergyIdentity` now records the signed localized XiEps bookkeeping before
   any CZ or Young estimate.  Because XiEpsPDE itself is not defined in this
   branch, derivation of `LocalEnergyIdentityData.identity` from the concrete PDE
   remains OPEN_PDE_IDENTITY rather than being fabricated.
3. The positive diffusion quantity is isolated explicitly as
      ∫ phi^2 |grad xi_eps|^2 |omega_eps|.
   The far-field stretching pairing is isolated separately as `stretchFar`.
4. The cutoff ledger exposes R = K rho_*, |grad phi| ~ (K rho_*)^{-1}, and
   second-derivative scale ~(K rho_*)^{-2}; ball averaging retains |B_r|^{-1}.
5. Poincare supplies the r^2 conversion from oscillation to gradient energy.
   It does NOT by itself prove gamma < 1/2.  If the PDE estimate yields
      gamma = C(K) kappa,
   then `gamma_lt_half_of_CK_kappa` proves that kappa < 1/(2 C(K)) is sufficient.
6. A naive pointwise far-field |x-y|^{-3} Cauchy--Schwarz step squares to the
   scale K^{-3} rho_*^{-3} ||omega||_2^2.  Unless another positive power of
   r/rho_* or a lower bound on rho_* compensates it, the Leray energy budget
   controls ∫||omega||_2^2 dt but not ∫rho_*^{-3}||omega||_2^2 dt.
   This is a candidate BLOCKING_SCALING mechanism and must be checked against
   the exact signed/local-averaged far-field estimate before CZ is invoked.
7. For a recurrence
      J_{r/2} <= gamma J_r + A r/rho,
   `gamma < 1` alone does NOT preserve the target J_r <= C r/rho.  The algebraic
   closure condition is `2 gamma C + 2 A <= C`; in particular one typically
   needs gamma < 1/2 (or a sharper recurrence with smaller remainder).
8. Therefore `PDEToDynamicCampanato.target` remains BLOCKING.  We do not assert
   FinalF, hDynamic, or SignedDepletion from this file.
-/

end G1Audit
