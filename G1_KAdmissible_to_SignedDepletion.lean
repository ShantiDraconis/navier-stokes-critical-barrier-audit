/-!
# G1_KAdmissible_to_SignedDepletion

Audit-safe formal core for the proposed K0 -> K1 -> G1 -> G2 -> G3 -> G4
Navier--Stokes closure programme.

The file deliberately separates:

* algebraic consequences proved below;
* analytic certificates which a future PDE argument must construct;
* the external endpoint continuation theorem.

There is no axiom, `sorry`, `admit`, or unconditional global-regularity theorem.
-/

import Mathlib

noncomputable section

namespace MillenniumAudit.G1KAdmissible

/-! ## K0: scalar regularization facts -/

/-- Scalar model of `sqrt (|omega|^2 + epsilon^2)` used to audit the
denominator.  It is an amplitude, not a spatial radius. -/
def regularizedAmplitude (w ε : ℝ) : ℝ :=
  Real.sqrt (w ^ 2 + ε ^ 2)

/-- K0a: a positive regularization parameter gives a strictly positive
denominator. -/
theorem K0a_regularizedAmplitude_ge
    (w ε : ℝ) (hε : 0 < ε) :
    ε ≤ regularizedAmplitude w ε := by
  rw [regularizedAmplitude, ← Real.sqrt_sq (le_of_lt hε)]
  exact Real.sqrt_le_sqrt (by nlinarith [sq_nonneg w])

/-- K0a': the regularized amplitude is nonnegative. -/
theorem K0a_regularizedAmplitude_nonneg (w ε : ℝ) :
    0 ≤ regularizedAmplitude w ε :=
  Real.sqrt_nonneg _

/-- K0b is an analytic fact only after Sobolev and L2 hypotheses are supplied.
This structure records that fact without asserting it for arbitrary functions. -/
structure DegenerateVorticityCertificate where
  y : ℝ
  z : ℝ
  hy : 0 ≤ y
  hz : 0 ≤ z
  gradient_zero_forces_vorticity_zero : z = 0 → y = 0

/-- K0b: certificate-level elimination of the degenerate branch. -/
theorem K0b_degenerate_branch
    (d : DegenerateVorticityCertificate) (hz0 : d.z = 0) :
    d.y = 0 :=
  d.gradient_zero_forces_vorticity_zero hz0

/-! ## K1: measure split and lower-semicontinuity interfaces -/

/-- Arithmetic content of the correct Chebyshev superlevel estimate.
`m` represents the measure of `{x | delta <= |omega x|}`. -/
theorem K1a_chebyshev_superlevel_arithmetic
    (y m δ : ℝ) (hm : 0 ≤ m) (hδ : 0 < δ)
    (hMoment : δ ^ 2 * m ≤ y) :
    m ≤ y / δ ^ 2 := by
  have hδ2 : 0 < δ ^ 2 := by
    simpa [pow_two] using mul_pos hδ hδ
  apply (le_div_iff₀ hδ2).2
  simpa [mul_comm] using hMoment

/-- K1b: pointwise weighted-gradient domination.  The actual vector-calculus
identity must provide `hPointwise`; this theorem records its integral-budget
consequence without pretending to control the unweighted gradient of xi. -/
theorem K1b_weighted_gradient_budget
    (weightedGradient palinstrophy : ℝ)
    (hWeighted : 0 ≤ weightedGradient)
    (hDomination : weightedGradient ≤ palinstrophy) :
    0 ≤ weightedGradient ∧ weightedGradient ≤ palinstrophy :=
  ⟨hWeighted, hDomination⟩

/-- Open analytic K1 content: measurability, pointwise convergence away from
zeros, and Fatou/lower-semicontinuity for the correctly normalized density. -/
structure K1LowerSemicontinuityCertificate where
  regularizedIntegral : ℕ → ℝ
  limitIntegral : ℝ
  h_regularized_nonneg : ∀ k, 0 ≤ regularizedIntegral k
  h_limit_nonneg : 0 ≤ limitIntegral
  liminfValue : ℝ
  h_liminf_is_bound : limitIntegral ≤ liminfValue

/-- K1c: expose exactly the conclusion supplied by a K1 certificate. -/
theorem K1c_liminf_bound (h : K1LowerSemicontinuityCertificate) :
    h.limitIntegral ≤ h.liminfValue :=
  h.h_liminf_is_bound

/-! ## G1a: exact decomposition into six term classes -/

structure EvolutionTerms where
  dissipation : ℝ
  commutator : ℝ
  transport : ℝ
  tail : ℝ
  cutoff : ℝ
  scaleMotion : ℝ

def EvolutionTerms.production (q : EvolutionTerms) : ℝ :=
  q.commutator + q.transport + q.tail + q.cutoff + q.scaleMotion

/-- G1a1: summing independently certified upper bounds. -/
theorem G1a1_sum_six_term_bounds
    (q : EvolutionTerms)
    (bComm bTransport bTail bCutoff bMotion : ℝ)
    (hc : q.commutator ≤ bComm)
    (ht : q.transport ≤ bTransport)
    (he : q.tail ≤ bTail)
    (hk : q.cutoff ≤ bCutoff)
    (hm : q.scaleMotion ≤ bMotion) :
    q.production ≤ bComm + bTransport + bTail + bCutoff + bMotion := by
  unfold EvolutionTerms.production
  linarith

/-- Algebraic detector for the example `diag(2,-1,-1), xi=e1`.
It does not assert absence of every possible dead mode. -/
theorem G1a5_expansive_mode_detected
    (α amplitude ν : ℝ)
    (hα : 0 < α) (ha : 0 < amplitude) (hν : 0 < ν) :
    0 < α * (2 * amplitude ^ 2 / ν) := by
  positivity

/-- The genuinely analytic G1a evolution inequality.  Constructing a value of
this structure from an actual NSE solution is OPEN. -/
structure JointEvolutionCertificate where
  q qDerivative viscousRate production lowerOrder : ℝ → ℝ
  hq : ∀ t, 0 ≤ q t
  hViscous : ∀ t, 0 ≤ viscousRate t
  evolution : ∀ t,
    qDerivative t + viscousRate t * q t ≤
      production t + lowerOrder t * q t

/-- G1a2: retrieve the certified joint evolution inequality. -/
theorem G1a2_joint_evolution
    (h : JointEvolutionCertificate) (t : ℝ) :
    h.qDerivative t + h.viscousRate t * h.q t ≤
      h.production t + h.lowerOrder t * h.q t :=
  h.evolution t

/-! ## G1b/G1c: absorption, bulk, and exceptional tail -/

structure EnstrophyData where
  y : ℝ → ℝ
  yDerivative : ℝ → ℝ
  z : ℝ → ℝ
  stretch : ℝ → ℝ
  gradU2 : ℝ → ℝ
  hy : ∀ t, 0 ≤ y t
  hz : ∀ t, 0 ≤ z t
  hgradU2 : ∀ t, 0 ≤ gradU2 t

structure EnstrophyBalance (ν : ℝ) (d : EnstrophyData) where
  balance : ∀ t, d.yDerivative t / 2 + ν * d.z t = d.stretch t

structure StretchSplit (d : EnstrophyData) where
  bulk : ℝ → ℝ
  tail : ℝ → ℝ
  split : ∀ t, d.stretch t = bulk t + tail t

def BulkAbsorption
    (ν cBulk : ℝ) (d : EnstrophyData) (s : StretchSplit d) : Prop :=
  0 ≤ cBulk ∧ ∀ t, s.bulk t ≤ cBulk * ν * d.z t

def ExceptionalTailControl
    (ν δTail : ℝ) (d : EnstrophyData) (s : StretchSplit d) : Prop :=
  0 ≤ δTail ∧ ∀ t, s.tail t ≤ δTail * ν * d.z t

def SubcriticalBudget (cBulk δTail : ℝ) : Prop :=
  cBulk + δTail < 1

/-- G1b/G1c: bulk plus tail closes a strict signed-depletion budget. -/
theorem G1bc_bulk_tail_to_signed_depletion
    (ν cBulk δTail : ℝ) (hν : 0 ≤ ν)
    (d : EnstrophyData) (s : StretchSplit d)
    (hBulk : BulkAbsorption ν cBulk d s)
    (hTail : ExceptionalTailControl ν δTail d s)
    (hBudget : SubcriticalBudget cBulk δTail) :
    ∃ θ : ℝ, 0 ≤ θ ∧ θ < 1 ∧
      ∀ t, d.stretch t ≤ θ * ν * d.z t := by
  rcases hBulk with ⟨hc0, hc⟩
  rcases hTail with ⟨hd0, hd⟩
  refine ⟨cBulk + δTail, add_nonneg hc0 hd0, hBudget, ?_⟩
  intro t
  have hzν : 0 ≤ ν * d.z t := mul_nonneg hν (d.hz t)
  rw [s.split t]
  have hct := hc t
  have hdt := hd t
  nlinarith

/-- G1b2: all absorption costs must share one budget; no individual
reparameterization can replace this strict inequality. -/
theorem G1b2_total_absorption_budget
    (γ bulk tail cutoff motion : ℝ)
    (hγ : 0 ≤ γ) (hb : 0 ≤ bulk) (ht : 0 ≤ tail)
    (hc : 0 ≤ cutoff) (hm : 0 ≤ motion)
    (hsub : γ + bulk + tail + cutoff + motion < 1) :
    ∃ θ : ℝ, 0 ≤ θ ∧ θ < 1 := by
  exact ⟨γ + bulk + tail + cutoff + motion,
    by positivity, hsub⟩

/-! ## G1d: non-circular time-integrability bookkeeping -/

structure LerayEnergyCertificate where
  ν E0 totalGradU2 : ℝ
  hν : 0 < ν
  hE0 : 0 ≤ E0
  hgrad : 0 ≤ totalGradU2
  energy : totalGradU2 ≤ E0 / (2 * ν)

/-- G1b3: the only time-integrated derivative supplied by the basic energy
inequality is the velocity-gradient budget. -/
theorem G1b3_leray_budget (h : LerayEnergyCertificate) :
    h.totalGradU2 ≤ h.E0 / (2 * h.ν) :=
  h.energy

/-- A non-circular multiplier must be bounded independently of the desired
L-infinity-in-time L3 endpoint and of the ratio z/y. -/
structure AdmissibleMultiplier where
  coefficient : ℝ
  hCoefficient : 0 ≤ coefficient
  universalBound : ℝ
  hUniversalBound : coefficient ≤ universalBound
  hUniversalBoundNonneg : 0 ≤ universalBound

/-- G1d2: scalar form of the energy-derived L1 estimate. -/
theorem G1d2_energy_controls_time_coefficient
    (A coefficient D E0 ν : ℝ)
    (hA : A ≤ coefficient * D)
    (hc : 0 ≤ coefficient)
    (hD : 0 ≤ D)
    (hEnergy : D ≤ E0 / (2 * ν))
    (hν : 0 < ν) :
    A ≤ coefficient * (E0 / (2 * ν)) := by
  exact hA.trans (mul_le_mul_of_nonneg_left hEnergy hc)

/-! ## G2: differential inequality obtained from balance and stretching -/

structure FlexibleStretchingBound
    (ν θ : ℝ) (d : EnstrophyData) where
  a : ℝ → ℝ
  hθ0 : 0 ≤ θ
  hθ1 : θ < 1
  ha : ∀ t, 0 ≤ a t
  stretching : ∀ t,
    d.stretch t ≤ θ * ν * d.z t + a t * d.y t

/-- G2a: exact differential inequality, with every premise visible. -/
theorem G2a_enstrophy_differential
    (ν θ : ℝ) (d : EnstrophyData)
    (hBalance : EnstrophyBalance ν d)
    (hStretch : FlexibleStretchingBound ν θ d) :
    ∀ t, d.yDerivative t + 2 * (1 - θ) * ν * d.z t ≤
      2 * hStretch.a t * d.y t := by
  intro t
  have hb := hBalance.balance t
  have hs := hStretch.stretching t
  linarith

/-- Explicit Gronwall output.  Proving it from an analytic derivative notion is
separated from the algebraic PDE bookkeeping. -/
structure GronwallCertificate (d : EnstrophyData) where
  totalA : ℝ
  htotalA : 0 ≤ totalA
  bound : ∀ t, d.y t ≤ d.y 0 * Real.exp (2 * totalA)

/-- G2b: uniform enstrophy bound supplied by the Gronwall certificate. -/
theorem G2b_uniform_enstrophy
    (d : EnstrophyData) (h : GronwallCertificate d) :
    ∀ t, d.y t ≤ d.y 0 * Real.exp (2 * h.totalA) :=
  h.bound

/-! ## G3/G4/F: critical reconstruction and external endpoint -/

/-- Algebraic G3 reconstruction data. -/
structure CriticalReconstruction where
  E0 M C : ℝ
  hE0 : 0 ≤ E0
  hM : 0 ≤ M
  hC : 0 ≤ C
  velocityL3 : ℝ → ℝ
  hVelocityL3 : ∀ t,
    velocityL3 t ≤
      C * Real.sqrt (Real.sqrt E0) * Real.sqrt (Real.sqrt M)

theorem G3_critical_bound (h : CriticalReconstruction) :
    ∀ t, h.velocityL3 t ≤
      h.C * Real.sqrt (Real.sqrt h.E0) * Real.sqrt (Real.sqrt h.M) :=
  h.hVelocityL3

/-- G4 is an external theorem interface (the ESS endpoint), not reproved here. -/
structure ESSEndpoint where
  CriticalBound : Prop
  NoFiniteSingularTime : Prop
  endpoint : CriticalBound → NoFiniteSingularTime

theorem G4_apply_endpoint (h : ESSEndpoint) (hc : h.CriticalBound) :
    h.NoFiniteSingularTime :=
  h.endpoint hc

/-- Complete dependency bundle.  Its analytic fields are explicit and cannot be
created merely by importing this module. -/
structure ClosureInputs where
  CriticalBound : Prop
  GlobalRegularity : Prop
  criticalBoundEstablished : CriticalBound
  endpoint : CriticalBound → GlobalRegularity

/-- F is conditional on an explicitly supplied critical bound and endpoint.
There is intentionally no theorem `ActualNS -> GlobalRegularity`. -/
theorem F_conditional_global_regularity (h : ClosureInputs) :
    h.GlobalRegularity :=
  h.endpoint h.criticalBoundEstablished

/-!
Audit verdict encoded by the theorem types:

* K0 scalar denominator facts: proved.
* Correct Chebyshev arithmetic and weighted-gradient bookkeeping: proved.
* K1 lower semicontinuity: explicit certificate.
* Actual NSE -> joint evolution/bulk/tail/subcritical budget: open certificate.
* Bulk + tail + strict budget -> signed depletion: proved.
* Balance + flexible stretching -> differential inequality: proved.
* Gronwall, reconstruction, ESS: explicit certificates/interfaces.
* Unconditional three-dimensional global regularity: not asserted.
-/

end MillenniumAudit.G1KAdmissible
