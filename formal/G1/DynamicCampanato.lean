/-
DynamicCampanato.lean

Audit interface for the next genuinely open PDE target.

The purpose of this file is NOT to assert the Campanato estimate.  It fixes
its scale-covariant statement, records the cutoff-free remainder budget, and
keeps every analytic bridge explicit.

No `axiom`, no `sorry`, and no hidden `True` theorem are used here.
-/

import Mathlib

noncomputable section

namespace G1Audit

/--
Abstract data for the Campanato functional

  J_r(x,t) = average_{B_r(x) ∩ Omega_{1/2}(t)} |xi - xi_{B_r}|^2.

The actual integral/geometry realization is deliberately external: this file
records the exact quantity needed by the proof DAG without pretending to have
constructed it for arbitrary Leray--Hopf solutions.
-/
structure DynamicCampanatoData (Point : Type*) where
  J : ℝ → Point → ℝ → ℝ
  rhoStar : ℝ → ℝ
  K : ℝ
  u0L2 : ℝ
  nu : ℝ
  theta : ℝ
  Ccamp : ℝ
  hJ_nonneg : ∀ r x t, 0 ≤ J r x t
  hrho_nonneg : ∀ t, 0 ≤ rhoStar t
  hnu_pos : 0 < nu
  htheta : theta = (1 / 2 : ℝ)
  hCcamp_nonneg : 0 ≤ Ccamp

/-- Radius is inside the critical geometric scale. -/
def CampanatoRadiusAdmissible {Point : Type*}
    (d : DynamicCampanatoData Point) (r t : ℝ) : Prop :=
  0 < r ∧ r ≤ d.rhoStar t

/--
The scale-covariant target:

  J_r(x,t) <= C * r/rhoStar(t).

`Ccamp` is the cutoff-free constant C(K, ||u0||_2, nu, theta).  Dependence on
those parameters is part of the analytic construction and is not fabricated
inside this audit interface.
-/
def DynamicCampanatoTarget {Point : Type*}
    (d : DynamicCampanatoData Point) : Prop :=
  ∀ r x t,
    CampanatoRadiusAdmissible d r t →
    d.J r x t ≤ d.Ccamp * (r / d.rhoStar t)

/--
Approximation-level data.  `gradUEpsSq` is the quantity already paid for by
the Leray kinetic-energy inequality; no uniform sup ||omega||_2 or uniform
integral ||grad omega||_2^2 is included.
-/
structure CutoffFreeApproximationData where
  eps : ℝ
  gradUEpsSq : ℝ → ℝ
  aEps : ℝ → ℝ
  Ckappa : ℝ
  hEps_pos : 0 < eps
  hGrad_nonneg : ∀ t, 0 ≤ gradUEpsSq t
  hCkappa_nonneg : 0 ≤ Ckappa

/--
Pointwise cutoff-free remainder witness

  a_eps(t) <= C_kappa ||grad u_eps(t)||_2^2.

This is the allowed replacement for the circular quartic-enstrophy remainder.
-/
structure RemainderCutoffFreeWitness (d : CutoffFreeApproximationData) where
  a_nonneg : ∀ t, 0 ≤ d.aEps t
  pointwise_budget : ∀ t, d.aEps t ≤ d.Ckappa * d.gradUEpsSq t

/--
Abstract time-integral budget supplied by the kinetic-energy inequality.
The concrete analytic realization should instantiate

  integral gradUEpsSq <= ||u0||_2^2 / (2 nu)

uniformly in epsilon.
-/
structure LerayEnergyIntegralBudget (d : CutoffFreeApproximationData) where
  gradIntegral : ℝ
  aIntegral : ℝ
  hgradIntegral_nonneg : 0 ≤ gradIntegral
  haIntegral_nonneg : 0 ≤ aIntegral
  grad_bound_uniform : Prop
  aIntegral_le_Ckappa_gradIntegral :
    aIntegral ≤ d.Ckappa * gradIntegral

/-- Pure arithmetic consequence once the energy integral has been realized. -/
theorem remainder_integral_from_energy
    (d : CutoffFreeApproximationData)
    (b : LerayEnergyIntegralBudget d)
    (u0L2 nu : ℝ)
    (hnu : 0 < nu)
    (hEnergy : b.gradIntegral ≤ u0L2 ^ 2 / (2 * nu)) :
    b.aIntegral ≤ d.Ckappa * (u0L2 ^ 2 / (2 * nu)) := by
  have hC := d.hCkappa_nonneg
  have hmul := mul_le_mul_of_nonneg_left hEnergy hC
  exact le_trans b.aIntegral_le_Ckappa_gradIntegral hmul

/--
What must be proved analytically to remove the near-field circularity.
No Hölder coherence hypothesis appears in this structure.
-/
structure DynamicCampanatoBridge {Point : Type*}
    (d : DynamicCampanatoData Point) where
  from_PDE_and_energy : DynamicCampanatoTarget d

/--
The Hölder target is represented abstractly only as a downstream proposition.
Campanato -> Hölder is intentionally an explicit interface until the concrete
metric-domain realization is supplied.
-/
structure CampanatoToHDynamic
    {Point : Type*}
    (d : DynamicCampanatoData Point)
    (hDynamic : Prop) where
  campanato_to_hDynamic : DynamicCampanatoTarget d → hDynamic

/-- Logical composition only; the PDE estimate itself remains an input. -/
theorem hDynamic_from_dynamic_campanato
    {Point : Type*}
    (d : DynamicCampanatoData Point)
    (hDynamic : Prop)
    (bridge : DynamicCampanatoBridge d)
    (embed : CampanatoToHDynamic d hDynamic) :
    hDynamic :=
  embed.campanato_to_hDynamic bridge.from_PDE_and_energy

/-
Audit exclusions hard-coded by omission:

* no `sup_t ||omega_eps||_2^2` field;
* no uniform `integral ||grad omega_eps||_2^2` field;
* no hDynamic assumption in the Campanato target;
* no rhoStar^(-3/2)||omega||_2 far-field hypothesis;
* no epsilon-dependent Campanato constant.

Status:
- remainder_integral_from_energy: PROVED_LOGIC once the concrete energy integral is supplied;
- DynamicCampanatoTarget: OPEN_BRIDGE / NOT_ESTABLISHED;
- DynamicCampanatoBridge.from_PDE_and_energy: analytic target, not constructed here;
- hDynamic: downstream, not asserted.
-/

end G1Audit
