/-!
Counterfactual, audit-safe specification of a Perelman-like stabilization
programme for three-dimensional Navier--Stokes.

This file proves composition only.  The difficult PDE objects are structure
fields, not axioms and not silently asserted theorems.
-/

import Mathlib

noncomputable section

namespace MillenniumAudit.PerelmanLikeNS

structure PhysicalData where
  ν : ℝ
  E0 : ℝ
  hν : 0 < ν
  hE0 : 0 ≤ E0

structure EnstrophyState where
  y : ℝ → ℝ
  yDerivative : ℝ → ℝ
  z : ℝ → ℝ
  stretch : ℝ → ℝ
  hy : ∀ t, 0 ≤ y t
  hz : ∀ t, 0 ≤ z t

/-- Object 1: a typed entropy identity.  Constructing this certificate from
ActualNS is not done by this module. -/
structure TypedEntropyCertificate where
  entropy dissipation remainder multiplier : ℝ → ℝ
  hDissipation : ∀ t, 0 ≤ dissipation t
  identity : ∀ t,
    entropy t + dissipation t = remainder t
  remainderBound : ∀ t,
    remainder t ≤ multiplier t * entropy t

/-- Object 2: an explicitly normalized noncollapse statement. -/
structure CriticalNoncollapseCertificate where
  weightedVolume : ℝ → ℝ → ℝ
  κ : ℝ
  hκ : 0 < κ
  noncollapse : ∀ x ℓ, 0 < ℓ →
    κ * ℓ ^ 3 ≤ weightedVolume x ℓ

/-- Object 3: decomposition/compactness which does not modify the solution. -/
structure CriticalDecompositionCertificate where
  profileMass : ℕ → ℝ
  defect : ℝ
  hProfileMass : ∀ k, 0 ≤ profileMass k
  hDefect : 0 ≤ defect
  preservesEquation : Prop
  hPreservesEquation : preservesEquation

structure SignedDepletionCertificate
    (p : PhysicalData) (d : EnstrophyState) where
  θ : ℝ
  a : ℝ → ℝ
  totalA : ℝ
  hθ0 : 0 ≤ θ
  hθ1 : θ < 1
  ha : ∀ t, 0 ≤ a t
  htotalA : 0 ≤ totalA
  stretching : ∀ t,
    d.stretch t ≤ θ * p.ν * d.z t + a t * d.y t

structure EnstrophyBalance
    (p : PhysicalData) (d : EnstrophyState) where
  balance : ∀ t,
    d.yDerivative t / 2 + p.ν * d.z t = d.stretch t

/-- The exact differential consequence after the open analytic bridge has
supplied signed depletion. -/
theorem signedDepletion_to_differential
    (p : PhysicalData) (d : EnstrophyState)
    (hb : EnstrophyBalance p d)
    (hs : SignedDepletionCertificate p d) :
    ∀ t, d.yDerivative t + 2 * (1 - hs.θ) * p.ν * d.z t ≤
      2 * hs.a t * d.y t := by
  intro t
  have hbalance := hb.balance t
  have hstretch := hs.stretching t
  linarith

structure GronwallOutput (d : EnstrophyState) where
  totalA : ℝ
  htotalA : 0 ≤ totalA
  uniformBound : ∀ t,
    d.y t ≤ d.y 0 * Real.exp (2 * totalA)

structure CriticalEndpoint where
  CriticalBound : Prop
  GlobalRegularity : Prop
  endpoint : CriticalBound → GlobalRegularity

/-- The missing prize-level map.  Its input is an actual-solution proposition;
its output contains all three proposed objects and signed depletion. -/
structure ActualNSToStabilization
    (ActualNS : Prop) (p : PhysicalData) (d : EnstrophyState) where
  entropy : TypedEntropyCertificate
  noncollapse : CriticalNoncollapseCertificate
  decomposition : CriticalDecompositionCertificate
  signedDepletion : SignedDepletionCertificate p d
  derivedFromActualNS : ActualNS → True

structure ConditionalClosure
    (ActualNS : Prop) (p : PhysicalData) (d : EnstrophyState) where
  actual : ActualNS
  bridge : ActualNSToStabilization ActualNS p d
  gronwall : GronwallOutput d
  endpoint : CriticalEndpoint
  criticalBound : endpoint.CriticalBound

/-- `F` remains explicitly conditional: no inhabitant of the bridge is
constructed in this file. -/
theorem F_of_complete_stabilization
    (ActualNS : Prop) (p : PhysicalData) (d : EnstrophyState)
    (h : ConditionalClosure ActualNS p d) :
    h.endpoint.GlobalRegularity :=
  h.endpoint.endpoint h.criticalBound

end MillenniumAudit.PerelmanLikeNS

