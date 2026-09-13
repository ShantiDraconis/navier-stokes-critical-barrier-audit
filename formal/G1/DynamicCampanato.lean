/-
DynamicCampanato.lean

Audit-level interface for the PDE -> dynamic Campanato route.

Design rules:
* no `axiom`
* no `sorry`
* no theorem claiming unconditional regularity
* the exact local-energy identity is recorded before any estimate
* the far-field scaling and the `γ < 1/2` iteration threshold remain explicit
  obligations when they are not proved from the primitive Leray-Hopf data
* circular steps must remain visible as interface fields or audit notes
-/

import Mathlib

noncomputable section

namespace G1DynamicCampanato

abbrev Vec3 := EuclideanSpace ℝ (Fin 3)
abbrev Space := Vec3

/-- `ω_ε(t,x)` family used in the regularized direction equation. -/
abbrev VorticityFamily := ℝ → ℝ → Space → Vec3

/-- Time-dependent norm data for the underlying vorticity. -/
structure VorticityNorms where
  supNorm : ℝ → ℝ
  l2 : ℝ → ℝ
  gradL2 : ℝ → ℝ
  hsupNorm : ∀ t, 0 ≤ supNorm t
  hl2 : ∀ t, 0 ≤ l2 t
  hgradL2 : ∀ t, 0 ≤ gradL2 t

/-- Scale-covariant radius `ρ_* = κ ||ω||₂ / ||∇ω||₂`. -/
def rhoStar (κ omegaL2 gradOmegaL2 : ℝ) : ℝ :=
  κ * omegaL2 / gradOmegaL2

/-- Time-dependent critical radius. -/
def rhoStarAt (norms : VorticityNorms) (κ t : ℝ) : ℝ :=
  rhoStar κ (norms.l2 t) (norms.gradL2 t)

/-- Fixed cutoff scale `R = K ρ_*`. -/
def cutoffRadius (norms : VorticityNorms) (κ K t : ℝ) : ℝ :=
  K * rhoStarAt norms κ t

/-- High-vorticity region `|ω| ≥ θ ||ω||_∞`. -/
def OmegaTheta (ω : VorticityFamily) (norms : VorticityNorms) (θ ε t : ℝ) : Set Space :=
  {x | θ * norms.supNorm t ≤ ‖ω ε t x‖}

/-- Regularized denominator `(|ω_ε|² + ε²)^{1/2}`. -/
def omegaMagEps (ω : VorticityFamily) (ε t : ℝ) (x : Space) : ℝ :=
  Real.sqrt (‖ω ε t x‖^2 + ε^2)

/-- Regularized direction field `ξ_ε`. -/
def xiEps (ω : VorticityFamily) (ε t : ℝ) (x : Space) : Vec3 :=
  (omegaMagEps ω ε t x)⁻¹ • ω ε t x

/-- Unweighted vorticity magnitude `|ω_ε|`. -/
def omegaAbsEps (ω : VorticityFamily) (ε t : ℝ) (x : Space) : ℝ :=
  ‖ω ε t x‖

/-- Closed ball used for Campanato oscillation. -/
def closedBall (center : Space) (r : ℝ) : Set Space :=
  {x | ‖x - center‖ ≤ r}

/-- Scale-locked cutoff profile with moving centers. -/
structure FixedScaleCutoff (norms : VorticityNorms) (κ : ℝ) where
  K : ℝ
  hK : 0 < K
  center : ℝ → Space
  w : ℝ → Space → ℝ
  supportedInside : ∀ t x, w t x ≠ 0 → ‖x - center t‖ ≤ cutoffRadius norms κ K t

/-- The cutoff profile `φ = w_R`, with `R = K ρ_*`. -/
def wR {norms : VorticityNorms} {κ : ℝ} (cutoff : FixedScaleCutoff norms κ) :
    ℝ → Space → ℝ :=
  cutoff.w

/-- Averaged oscillation center `(ξ_ε)_{B_r}` supplied by the analytic layer. -/
abbrev XiBallAverage := ℝ → ℝ → ℝ → Vec3

/-- Oscillation `ξ_ε - (ξ_ε)_{B_r}`. -/
def xiOscillation (ω : VorticityFamily) (avg : XiBallAverage) (ε t r : ℝ) (x : Space) : Vec3 :=
  xiEps ω ε t x - avg ε t r

/--
Exact test field used in the local identity:
`φ² (ξ_ε - (ξ_ε)_{B_r}) |ω_ε|`, with `φ = w_R` and `R = K ρ_*`.
-/
def localTestField
    (ω : VorticityFamily) (avg : XiBallAverage)
    {norms : VorticityNorms} {κ : ℝ}
    (cutoff : FixedScaleCutoff norms κ) (ε t r : ℝ) (x : Space) : Vec3 :=
  (((wR cutoff) t x)^2 * omegaAbsEps ω ε t x) • xiOscillation ω avg ε t r x

/-- Exact regularized viscosity contribution kept outside the cutoff remainder. -/
def viscosityContribution (ν : ℝ) (laplacianXi relGradOmegaDotGradXi : Vec3) : Vec3 :=
  ν • (laplacianXi + (2 : ℝ) • relGradOmegaDotGradXi)

/--
Regularized `ξ_ε` equation, with no estimate and no hidden cutoff dependence.
Each field below uses argument order `(ε t : ℝ)` before the spatial point.
-/
structure XiEpsPDE where
  ω : VorticityFamily
  norms : VorticityNorms
  ν : ℝ
  hν : 0 < ν
  κ : ℝ
  theta : ℝ
  cutoff : FixedScaleCutoff norms κ
  xiAverage : XiBallAverage
  materialDerivative : ℝ → ℝ → Space → Vec3
  strainAction : ℝ → ℝ → Space → Vec3
  laplacianXi : ℝ → ℝ → Space → Vec3
  relGradOmegaDotGradXi : ℝ → ℝ → Space → Vec3
  remainder : ℝ → ℝ → Space → Vec3
  remainderL1 : ℝ → ℝ → ℝ
  hRemainderL1 : ∀ ε t, 0 ≤ remainderL1 ε t
  evolution :
    ∀ ε t x,
      materialDerivative ε t x
        = (strainAction ε t x
            - (inner ℝ (xiEps ω ε t x) (strainAction ε t x)) • xiEps ω ε t x)
            + viscosityContribution ν (laplacianXi ε t x) (relGradOmegaDotGradXi ε t x)
            + remainder ε t x

/-- Definitional expansion of the local test field. -/
theorem localTestField_eq
    (ω : VorticityFamily) (avg : XiBallAverage)
    {norms : VorticityNorms} {κ : ℝ}
    (cutoff : FixedScaleCutoff norms κ) (ε t r : ℝ) (x : Space) :
    localTestField ω avg cutoff ε t r x
      = (((wR cutoff) t x)^2 * omegaAbsEps ω ε t x) • (xiEps ω ε t x - avg ε t r) := rfl

/--
Cutoff-free remainder witness. The constant depends only on `||u₀||₂` and `ν`,
never on `R`, `K`, `r`, or `ε`.
-/
structure RemainderCutoffFreeWitness (P : XiEpsPDE) where
  u0L2 : ℝ
  C_rem : ℝ → ℝ → ℝ
  hC_rem : ∀ u0 ν, 0 ≤ C_rem u0 ν
  localRemainder : ℝ → ℝ → ℝ → ℝ
  cutoff_free_bound :
    ∀ T ≥ 0, ∀ ε t r, 0 < |ε| → 0 ≤ t → t ≤ T →
      |localRemainder ε t r| ≤ C_rem u0L2 P.ν
  vanishes_uniformly_in_eps :
    ∀ T ≥ 0, ∀ η > 0, ∃ ε0 > 0, ∀ ε, 0 < |ε| → |ε| ≤ ε0 →
      ∀ t, 0 ≤ t → t ≤ T → ∀ r,
        |localRemainder ε t r| ≤ η

/--
Exact local energy identity obtained by testing the `XiEpsPDE` with
`φ² (ξ_ε - (ξ_ε)_{B_r}) |ω_ε|`, keeping `R1`, `R2`, and the cutoff-free
remainder explicit.
-/
structure LocalEnergyIdentity (P : XiEpsPDE) where
  timeTerm : ℝ → ℝ → ℝ → ℝ
  diffusionTerm : ℝ → ℝ → ℝ → ℝ
  transportTerm : ℝ → ℝ → ℝ → ℝ
  strainTerm : ℝ → ℝ → ℝ → ℝ
  cutoffMainTerm : ℝ → ℝ → ℝ → ℝ
  R1 : ℝ → ℝ → ℝ → ℝ
  R2 : ℝ → ℝ → ℝ → ℝ
  remainderWitness : RemainderCutoffFreeWitness P
  exactIdentity :
    ∀ ε t r,
      timeTerm ε t r + diffusionTerm ε t r
        = strainTerm ε t r + transportTerm ε t r + cutoffMainTerm ε t r
            + R1 ε t r + R2 ε t r + remainderWitness.localRemainder ε t r

/-- Cubic inverse-length weight `ρ_*^{-3}`. -/
def rhoWeight (ρ : ℝ) : ℝ :=
  ρ⁻¹ * ρ⁻¹ * ρ⁻¹

/--
Far-field control must respect scaling. The bound is recorded only in averaged
form; the invalid route `|S_far| ≤ C(K) ||∇u||₂` is intentionally absent.
-/
structure FarFieldAveragedScaling (P : XiEpsPDE) where
  beta : ℝ
  hbeta_nonneg : 0 ≤ beta
  constant : ℝ
  hconstant : 0 ≤ constant
  averageFarFieldSq : ℝ → ℝ → ℝ → ℝ
  omegaEpsL2Sq : ℝ → ℝ → ℝ
  averagedBound :
    ∀ ε t r, 0 ≤ r → r ≤ rhoStarAt P.norms P.κ t →
      averageFarFieldSq ε t r
        ≤ constant * rhoWeight (rhoStarAt P.norms P.κ t)
            * omegaEpsL2Sq ε t
            * Real.rpow (r / rhoStarAt P.norms P.κ t) beta
  beta_selected_by_local_identity : Prop
  energy_only_leray_integrability : Prop
  no_palinstrophy_input : Prop

/-- Scale ratio `r / ρ_*`. -/
def scaleRatio (P : XiEpsPDE) (t r : ℝ) : ℝ :=
  r / rhoStarAt P.norms P.κ t

/--
Campanato iteration target. The strict `γ < 1/2` threshold is kept explicit:
contraction by merely `< 1` is not enough to preserve the critical linear
barrier across dyadic scales.
-/
structure CampanatoIteration (P : XiEpsPDE) where
  J : ℝ → ℝ → ℝ → ℝ
  gamma : ℝ
  A : ℝ
  kappaThreshold : ℝ
  hkappaThreshold : 0 ≤ kappaThreshold
  hgamma_nonneg : 0 ≤ gamma
  hA_nonneg : 0 ≤ A
  diffusion_selects_half_contraction : kappaThreshold ≤ P.κ → gamma < (1 / 2 : ℝ)
  -- The forcing term is kept at the parent scale `r / ρ_*`, matching the
  -- audit target `J_{r/2} ≤ γ J_r + A r / ρ_*` and the barrier condition
  -- `2 γ C + 2 A ≤ C`.
  recursiveStepAtParentScale :
    ∀ ε t r, J ε t (r / 2) ≤ gamma * J ε t r + A * scaleRatio P t r

/-- The strict `γ < 1/2` threshold comes from the admissible `κ` regime. -/
theorem gamma_lt_half
    {P : XiEpsPDE} (it : CampanatoIteration P)
    (hκ : it.kappaThreshold ≤ P.κ) :
    it.gamma < (1 / 2 : ℝ) :=
  it.diffusion_selects_half_contraction hκ

/-- Algebraic rewriting of the half-scale barrier. -/
theorem half_scale_barrier_eq
    {C r rho : ℝ} (hrho : rho ≠ 0) :
    (C / 2) * (r / rho) = C * ((r / 2) / rho) := by
  field_simp [hrho]
  ring

/--
If `J_{r/2} ≤ γ J_r + A r / ρ` and `J_r ≤ C r / ρ`, then preserving the same
linear barrier at scale `r/2` requires the inequality `2 γ C + 2 A ≤ C`.
-/
theorem preserve_linear_barrier
    {γ A C r rho Jhalf Jr : ℝ}
    (hr : 0 ≤ r) (hrho : 0 < rho)
    (hstep : Jhalf ≤ γ * Jr + A * (r / rho))
    (hbound : Jr ≤ C * (r / rho))
    (hcontract : 2 * γ * C + 2 * A ≤ C) :
    Jhalf ≤ C * ((r / 2) / rho) := by
  have hratio : 0 ≤ r / rho := by
    exact div_nonneg hr hrho.le
  have hcoeff : γ * C + A ≤ C / 2 := by
    linarith
  have h1 : Jhalf ≤ (γ * C + A) * (r / rho) := by
    linarith
  have h2 : Jhalf ≤ (C / 2) * (r / rho) := by
    exact le_trans h1 (mul_le_mul_of_nonneg_right hcoeff hratio)
  have hrho_ne : rho ≠ 0 := ne_of_gt hrho
  simpa [half_scale_barrier_eq hrho_ne] using h2

/-- Dynamic Campanato estimate at one time. -/
structure DynamicCampanatoAtTime where
  C : ℝ
  hC : 0 ≤ C
  holds : Prop

/--
Open bridge from the exact PDE identity to a dynamic Campanato estimate.
The near-field step must be non-circular: it may not reuse the target hDynamic
coherence to manufacture the singularity gain it is meant to prove.
-/
structure PDEToDynamicCampanato (ActualNS : Prop) where
  xiPDE : XiEpsPDE
  localEnergy : LocalEnergyIdentity xiPDE
  farField : FarFieldAveragedScaling xiPDE
  iteration : CampanatoIteration xiPDE
  nonCircularNearFieldGain : Prop
  C0 : ℝ
  hC0 : 0 ≤ C0
  produces :
    ActualNS → ∀ t : ℝ, ∃ q : DynamicCampanatoAtTime, q.C ≤ C0 ∧ q.holds

/-
AUDIT STATUS

Machine-checkable content in this file:
* fixed-scale cutoff and local test-field definitions
* exact-interface declarations for `XiEpsPDE`, `LocalEnergyIdentity`,
  cutoff-free remainders, far-field averaged scaling, and Campanato iteration
* algebraic barrier lemma `preserve_linear_barrier`

Still open / not asserted:
* derivation of `LocalEnergyIdentity.exactIdentity` from Leray-Hopf dynamics
* proof of the far-field averaged scaling from energy alone with no palinstrophy
* proof that the resulting exponent `beta` yields the required integrability
* non-circular near-field gain delivering the `γ < 1/2` threshold
* unconditional Navier-Stokes regularity
-/

end G1DynamicCampanato
