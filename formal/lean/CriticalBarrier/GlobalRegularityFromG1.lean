import Mathlib

/-!
# GlobalRegularityFromG1

This file formalizes only the *logical composition* from a genuine G1 signed-depletion
bridge to global regularity. It does not prove G1 from the Navier--Stokes equations and
does not formalize the Escauriaza--Seregin--Sverak theorem internally.

There are no axioms and no `sorry` declarations in this file.
-/

namespace CriticalBarrier.GlobalRegularityFromG1

/-- Abstract state type for a maximal smooth Navier--Stokes trajectory. -/
variable {State : Type}

/-- Problem-level predicates. -/
variable (ActualNS : State → Prop)
variable (UniformEnstrophy : State → Prop)
variable (CriticalL3Bound : State → Prop)
variable (GlobalRegularity : State → Prop)

/-- Timewise data used by the signed depletion interface. -/
structure StretchingData where
  y : ℝ
  z : ℝ
  stretching : ℝ
  nu : ℝ
  theta : ℝ
  a : ℝ
  y_nonneg : 0 ≤ y
  z_nonneg : 0 ≤ z
  nu_pos : 0 < nu
  theta_nonneg : 0 ≤ theta
  theta_lt_one : theta < 1

/-- Flexible signed-depletion inequality at one time.
    The integrability of `a` is carried separately at the trajectory level. -/
def SignedDepletionAt (d : StretchingData) : Prop :=
  d.stretching ≤ d.theta * d.nu * d.z + d.a * d.y

/-- G1 bridge: actual NS dynamics imply the flexible stretching estimate with an
    integrable defect. The analytic content is deliberately represented as a premise,
    not manufactured by the kernel. -/
structure G1Bridge (ActualNS : State → Prop) where
  defect : State → ℝ → ℝ
  stretchingData : State → ℝ → StretchingData
  actual_to_signed : ∀ u, ActualNS u → ∀ t, SignedDepletionAt (stretchingData u t)
  defect_integrable : ∀ u, ActualNS u → Integrable (defect u)

/-- Explicit downstream certificate. Each field is a theorem obligation in the
    mathematical development; packaging them prevents an OPEN bridge from being
    silently promoted to a solved theorem. -/
structure DownstreamClosure
    (ActualNS UniformEnstrophy CriticalL3Bound GlobalRegularity : State → Prop) where
  g1_to_enstrophy : G1Bridge ActualNS → ∀ u, ActualNS u → UniformEnstrophy u
  enstrophy_to_l3 : ∀ u, ActualNS u → UniformEnstrophy u → CriticalL3Bound u
  ess_endpoint : ∀ u, ActualNS u → CriticalL3Bound u → GlobalRegularity u

/-- Composition theorem: if G1 has genuinely been derived and all downstream theorem
    obligations are supplied, global regularity follows for every actual NS state. -/
theorem global_regularity_from_G1
    (hG1 : G1Bridge ActualNS)
    (hDown : DownstreamClosure ActualNS UniformEnstrophy CriticalL3Bound GlobalRegularity) :
    ∀ u, ActualNS u → GlobalRegularity u := by
  intro u hu
  have hE : UniformEnstrophy u := hDown.g1_to_enstrophy hG1 u hu
  have hL3 : CriticalL3Bound u := hDown.enstrophy_to_l3 u hu hE
  exact hDown.ess_endpoint u hu hL3

/-- Same result exposed as the full dependency chain. -/
theorem dependency_chain
    (hG1 : G1Bridge ActualNS)
    (hDown : DownstreamClosure ActualNS UniformEnstrophy CriticalL3Bound GlobalRegularity)
    (u : State) (hu : ActualNS u) :
    UniformEnstrophy u ∧ CriticalL3Bound u ∧ GlobalRegularity u := by
  have hE : UniformEnstrophy u := hDown.g1_to_enstrophy hG1 u hu
  have hL3 : CriticalL3Bound u := hDown.enstrophy_to_l3 u hu hE
  have hG : GlobalRegularity u := hDown.ess_endpoint u hu hL3
  exact ⟨hE, hL3, hG⟩

end CriticalBarrier.GlobalRegularityFromG1
