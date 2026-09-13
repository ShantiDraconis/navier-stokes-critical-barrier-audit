/-!
# StabilizedHypothetical

Proof-carrying specification of the counterfactual 22 -> 25 -> 3 -> 1
Navier--Stokes programme.

The analytic bridge is an input structure.  Consequently this module contains
no proof of `ActualNS -> GlobalRegularity`.  It proves only the composition and
the exact rational calculations used in the proposed numerical scenario.
-/

import Mathlib

noncomputable section

namespace MillenniumAudit.StabilizedHypothetical

/-! ## Fixed numerical scenario -/

def ν : ℝ := 1 / 100
def E0 : ℝ := 1
def κ0 : ℝ := 1 / 2
def ε0 : ℝ := 1 / 10
def δTail : ℝ := 1 / 20
def γ : ℝ := 9 / 10
def α : ℝ := 1
def Φ : ℝ := 3 / 5
def c0 : ℝ := 1
def CBS : ℝ := 2
def θ : ℝ := Φ / (1 + Φ)

theorem viscosity_positive : 0 < ν := by
  norm_num [ν]

theorem kappa_positive : 0 < κ0 := by
  norm_num [κ0]

theorem epsilon_positive : 0 < ε0 := by
  norm_num [ε0]

theorem tail_budget_positive : 0 < δTail := by
  norm_num [δTail]

theorem gamma_strict : 0 ≤ γ ∧ γ < 1 := by
  norm_num [γ]

theorem theta_exact : θ = 3 / 8 := by
  norm_num [θ, Φ]

theorem theta_strict : 0 ≤ θ ∧ θ < 1 := by
  rw [theta_exact]
  norm_num

theorem energy_dissipation_budget : E0 / (2 * ν) = 50 := by
  norm_num [E0, ν]

theorem time_coefficient_budget :
    CBS * Φ ^ 2 * (E0 / (2 * ν)) = 36 := by
  norm_num [CBS, Φ, E0, ν]

theorem dissipative_margin : 2 * (1 - θ) * ν = 1 / 80 := by
  rw [theta_exact]
  norm_num [ν]

theorem empirical_eta_budget : (1 / 25 : ℝ) ≤ δTail := by
  norm_num [δTail]

/-! ## K0: total regularization -/

def regularizedAmplitude (w ε : ℝ) : ℝ :=
  Real.sqrt (w ^ 2 + ε ^ 2)

theorem K0a_totality (w ε : ℝ) (hε : 0 < ε) :
    ε ≤ regularizedAmplitude w ε := by
  rw [regularizedAmplitude, ← Real.sqrt_sq (le_of_lt hε)]
  exact Real.sqrt_le_sqrt (by nlinarith [sq_nonneg w])

structure K0DegenerateCertificate where
  y z : ℝ
  hy : 0 ≤ y
  hz : 0 ≤ z
  zeroGradient : z = 0 → y = 0

theorem K0b_degenerate_trivial
    (h : K0DegenerateCertificate) (hz : h.z = 0) :
    h.y = 0 :=
  h.zeroGradient hz

/-! ## K1: weighted limiting process -/

structure WeightedNegligibility where
  etaLow : ℝ → ℝ
  constant : ℝ
  hConstant : 0 ≤ constant
  bound : ∀ δ, 0 < δ →
    etaLow δ ≤ constant * Real.sqrt δ

structure WeightedGradientControl where
  weightedGradient palinstrophy : ℝ → ℝ
  hWeighted : ∀ t, 0 ≤ weightedGradient t
  hPalinstrophy : ∀ t, 0 ≤ palinstrophy t
  domination : ∀ t, weightedGradient t ≤ palinstrophy t

structure AubinLionsCertificate where
  compactnessStatement : Prop
  compactnessProof : compactnessStatement

structure LowerSemicontinuityCertificate where
  regularizedIntegral : ℕ → ℝ
  limitIntegral liminfValue : ℝ
  hRegularized : ∀ k, 0 ≤ regularizedIntegral k
  hLimit : 0 ≤ limitIntegral
  liminfBound : limitIntegral ≤ liminfValue

structure TypedDefectCertificate where
  DefectSpace : Type
  instNorm : Norm DefectSpace
  defect : ℝ → DefectSpace
  defectEnergy : ℝ → ℝ
  hDefectEnergy : ∀ t,
    defectEnergy t = (@norm DefectSpace instNorm (defect t)) ^ 2

/-! ## G1a: six evolution-term classes -/

structure SixForces where
  commutator transport tail cutoff scaleMotion : ℝ → ℝ
  dissipation : ℝ → ℝ

def SixForces.production (q : SixForces) (t : ℝ) : ℝ :=
  q.commutator t + q.transport t + q.tail t + q.cutoff t + q.scaleMotion t

structure JointEvolutionCertificate where
  q qDerivative lowerOrder : ℝ → ℝ
  forces : SixForces
  hq : ∀ t, 0 ≤ q t
  hDissipation : ∀ t, 0 ≤ forces.dissipation t
  evolution : ∀ t,
    qDerivative t + forces.dissipation t * q t ≤
      forces.production t + lowerOrder t * q t

theorem G1a5_expansive_example :
    (0 : ℝ) + α * 2 = 2 := by
  norm_num [α]

/-! ## G1b/G1c: absorption and principal-value-compatible tail -/

structure AbsorptionCertificate where
  γ1 γ2 θTail θCutoff θMotion : ℝ
  hγ1 : 0 ≤ γ1
  hγ2 : 0 ≤ γ2
  hTail : 0 ≤ θTail
  hCutoff : 0 ≤ θCutoff
  hMotion : 0 ≤ θMotion
  strictBudget : γ1 + γ2 + θTail + θCutoff + θMotion < 1

def AbsorptionCertificate.total (h : AbsorptionCertificate) : ℝ :=
  h.γ1 + h.γ2 + h.θTail + h.θCutoff + h.θMotion

theorem G1b_total_strict (h : AbsorptionCertificate) :
    0 ≤ h.total ∧ h.total < 1 := by
  constructor
  · unfold AbsorptionCertificate.total
    positivity
  · exact h.strictBudget

structure PrincipalValueTailCertificate where
  numerator denominator eta : ℝ → ℝ
  hNumerator : ∀ t, 0 ≤ numerator t
  hDenominator : ∀ t, 0 ≤ denominator t
  ratioOnNonzero : ∀ t, denominator t ≠ 0 →
    eta t = numerator t / denominator t
  zeroBranch : ∀ t, denominator t = 0 → numerator t = 0
  tailBound : ∀ t, eta t ≤ δTail

structure WeightedNoncollapseCertificate where
  weightedVolume : ℝ → ℝ → ℝ
  noncollapseConstant : ℝ
  hConstant : 0 < noncollapseConstant
  noncollapse : ∀ x ell, 0 < ell →
    noncollapseConstant * ell ^ 3 ≤ weightedVolume x ell

/-! ## G1d: energy-derived time integrability -/

structure LerayEnergyCertificate where
  totalGradU2 : ℝ
  hTotalGradU2 : 0 ≤ totalGradU2
  energy : totalGradU2 ≤ E0 / (2 * ν)

structure NonCircularMultiplier where
  multiplierBound : ℝ
  hBound : 0 ≤ multiplierBound
  independentOfCriticalEndpoint : Prop
  hIndependent : independentOfCriticalEndpoint

theorem G1d2_time_integral_bound
    (hEnergy : LerayEnergyCertificate)
    (totalA : ℝ)
    (hA : totalA ≤ CBS * Φ ^ 2 * hEnergy.totalGradU2) :
    totalA ≤ 36 := by
  calc
    totalA ≤ CBS * Φ ^ 2 * hEnergy.totalGradU2 := hA
    _ ≤ CBS * Φ ^ 2 * (E0 / (2 * ν)) := by
      exact mul_le_mul_of_nonneg_left hEnergy.energy (by norm_num [CBS, Φ])
    _ = 36 := time_coefficient_budget

/-! ## The three aggregated Perelman-like objects -/

structure MonotoneNSEntropy where
  entropyDerivative defectEnergy remainder multiplier entropy : ℝ → ℝ
  hDefect : ∀ t, 0 ≤ defectEnergy t
  identity : ∀ t,
    entropyDerivative t = defectEnergy t + remainder t
  remainderControl : ∀ t,
    remainder t ≤ multiplier t * entropy t

structure CriticalDecomposition where
  preservesVelocity : Prop
  preservesPressureEquation : Prop
  preservesIncompressibility : Prop
  hVelocity : preservesVelocity
  hPressure : preservesPressureEquation
  hDivergence : preservesIncompressibility

structure ThreeObjects where
  entropy : MonotoneNSEntropy
  noncollapse : WeightedNoncollapseCertificate
  decomposition : CriticalDecomposition

/-! ## G2/G3/G4 and the conditional F -/

structure EnstrophyState where
  y yDerivative z stretch a : ℝ → ℝ
  hy : ∀ t, 0 ≤ y t
  hz : ∀ t, 0 ≤ z t
  ha : ∀ t, 0 ≤ a t

structure SignedDepletion (d : EnstrophyState) where
  θValue : ℝ
  hθ0 : 0 ≤ θValue
  hθ1 : θValue < 1
  balance : ∀ t, d.yDerivative t / 2 + ν * d.z t = d.stretch t
  stretching : ∀ t,
    d.stretch t ≤ θValue * ν * d.z t + d.a t * d.y t

theorem G2_differential
    (d : EnstrophyState) (h : SignedDepletion d) :
    ∀ t, d.yDerivative t + 2 * (1 - h.θValue) * ν * d.z t ≤
      2 * d.a t * d.y t := by
  intro t
  have hb := h.balance t
  have hs := h.stretching t
  linarith

structure GronwallCertificate (d : EnstrophyState) where
  totalA : ℝ
  hTotalA : 0 ≤ totalA
  uniformBound : ∀ t,
    d.y t ≤ d.y 0 * Real.exp (2 * totalA)

structure CriticalL3Certificate where
  velocityL3 : ℝ → ℝ
  bound : ℝ
  hBound : 0 ≤ bound
  uniform : ∀ t, velocityL3 t ≤ bound

structure ESSEndpoint where
  CriticalBound : Prop
  NoFiniteSingularTime : Prop
  endpoint : CriticalBound → NoFiniteSingularTime

structure ActualNSToTwentyFive where
  ActualNS : Prop
  actual : ActualNS
  k1a : WeightedNegligibility
  k1b : WeightedGradientControl
  k1Compactness : AubinLionsCertificate
  k1c : LowerSemicontinuityCertificate
  k1d : TypedDefectCertificate
  evolution : JointEvolutionCertificate
  absorption : AbsorptionCertificate
  tail : PrincipalValueTailCertificate
  noncollapse : WeightedNoncollapseCertificate
  energy : LerayEnergyCertificate
  multiplier : NonCircularMultiplier
  objects : ThreeObjects

structure CompleteConditionalClosure where
  bridge : ActualNSToTwentyFive
  state : EnstrophyState
  depletion : SignedDepletion state
  gronwall : GronwallCertificate state
  criticalL3 : CriticalL3Certificate
  endpoint : ESSEndpoint
  criticalHypothesis : endpoint.CriticalBound

theorem Perelman_like_22_25_3_1
    (h : CompleteConditionalClosure) :
    h.endpoint.NoFiniteSingularTime :=
  h.endpoint.endpoint h.criticalHypothesis

/-!
No constructor for `ActualNSToTwentyFive` is provided.  Producing it from the
Navier--Stokes equations is precisely the unresolved analytic bridge.
-/

end MillenniumAudit.StabilizedHypothetical
