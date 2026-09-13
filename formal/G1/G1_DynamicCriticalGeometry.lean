/-
G1_DynamicCriticalGeometry.lean

Audit-level formalization of the corrected G1 program.

Important status:
* no axiom
* no sorry
* no theorem claiming unconditional regularity
* the finite-dimensional direction algebra is separated from the PDE evolution
* the PDE-level evolution law for xi is represented as an explicit hypothesis
  until the material derivative/Laplacian identities are fully encoded in Mathlib
* Q is dimensionless by construction
-/

import Mathlib

noncomputable section

namespace G1Dynamic

abbrev Vec3 := EuclideanSpace ℝ (Fin 3)

/-- Vorticity direction at a point where ω ≠ 0. -/
def xi (ω : Vec3) : Vec3 := (‖ω‖⁻¹ : ℝ) • ω

/-- Algebraic tangential projection of a forcing vector F onto ξ^⊥. -/
def tangentialPart (ξ F : Vec3) : Vec3 :=
  F - (inner ℝ ξ F) • ξ

/-- The tangential part is unchanged by adding a vector parallel to ξ. -/
theorem tangentialPart_add_parallel
    (ξ F : Vec3) (a : ℝ) :
    tangentialPart ξ (F + a • ξ)
      = tangentialPart ξ F + a • ξ - (a * inner ℝ ξ ξ) • ξ := by
  simp [tangentialPart, inner_add_right, inner_smul_right, sub_eq_add_neg,
    add_assoc, add_left_comm, add_comm]

/--
A scale-covariant coherence radius. The caller supplies the actual L² norms.
-/
def rhoStar (κ omegaL2 gradOmegaL2 : ℝ) : ℝ :=
  κ * omegaL2 / gradOmegaL2

/--
Scaling data for the Navier–Stokes vorticity norms:
||ω_λ||₂ = λ^(1/2)||ω||₂,
||∇ω_λ||₂ = λ^(3/2)||∇ω||₂.
-/
structure VorticityScalingData where
  λ : ℝ
  hλ : 0 < λ
  omegaL2 : ℝ
  gradOmegaL2 : ℝ
  omegaL2_scaled : ℝ
  gradOmegaL2_scaled : ℝ
  homega : omegaL2_scaled = Real.sqrt λ * omegaL2
  hgrad : gradOmegaL2_scaled = λ * Real.sqrt λ * gradOmegaL2

/--
The expected spatial scaling law for ρ_* is exposed as a proposition.
This separates dimensional consistency from any PDE regularity claim.
-/
def RhoStarScalesLikeLength (κ : ℝ) (s : VorticityScalingData) : Prop :=
  rhoStar κ s.omegaL2_scaled s.gradOmegaL2_scaled
    = (1 / s.λ) * rhoStar κ s.omegaL2 s.gradOmegaL2

/--
Pairwise directional discrepancy. We use the Gram determinant rather than a
cross-product API, so the definition is coordinate-free in EuclideanSpace.
For unit vectors this is sin²(theta).
-/
def sinAngleSq (ξ η : Vec3) : ℝ :=
  max 0 (‖ξ‖^2 * ‖η‖^2 - (inner ℝ ξ η)^2)

/-- Nonnegative directional angle surrogate. -/
def sinAngle (ξ η : Vec3) : ℝ := Real.sqrt (sinAngleSq ξ η)

/--
Dimensionless critical Holder quotient at beta=1/2.
`distance` and `rho` must have the same physical dimension.
-/
def criticalQuotient (angle distance rho : ℝ) : ℝ :=
  if 0 < distance ∧ 0 < rho then
    angle / Real.sqrt (distance / rho)
  else 0

/--
Analytic all-pairs critical coherence at one time. This is intentionally
stronger than a finite-resolution percentile such as C_H^95.
-/
structure CriticalCoherenceAtTime where
  C : ℝ
  hC : 0 ≤ C
  holds : Prop

/--
A numerical percentile observation. It is evidence, not the analytic theorem
hypothesis, because an exceptional tail may dominate a singular integral.
-/
structure CH95AtTime where
  C95 : ℝ
  hC95 : 0 ≤ C95
  resolution : ℕ
  resolvedScaleRatio : ℝ

/-- Uniform empirical boundedness across a refinement sequence. -/
def UniformCH95 (obs : ℕ → CH95AtTime) : Prop :=
  ∃ C0 : ℝ, 0 ≤ C0 ∧ ∀ n, (obs n).C95 ≤ C0

/-- Spatial points for the audit-level vorticity geometry. -/
abbrev Space := Vec3

/-- Time-dependent vorticity field on `R^3`. -/
abbrev VorticityField := ℝ → Space → Vec3

/-- Abstract norm data attached to a vorticity field. -/
structure VorticityNorms where
  supNorm : ℝ → ℝ
  l2 : ℝ → ℝ
  gradL2 : ℝ → ℝ
  hsupNorm : ∀ t, 0 ≤ supNorm t
  hl2 : ∀ t, 0 ≤ l2 t
  hgradL2 : ∀ t, 0 ≤ gradL2 t

/-- Regularized magnitude `(|ω|² + ε²)^{1/2}`. -/
def omegaMagEps (ω : VorticityField) (ε t : ℝ) (x : Space) : ℝ :=
  Real.sqrt (‖ω t x‖^2 + ε^2)

/-- Regularized direction `ω / (|ω|² + ε²)^{1/2}`. -/
def xiEps (ω : VorticityField) (ε t : ℝ) (x : Space) : Vec3 :=
  (omegaMagEps ω ε t x)⁻¹ • ω t x

/-- High-vorticity region `|ω| ≥ θ ||ω||_∞`. -/
def OmegaTheta (ω : VorticityField) (norms : VorticityNorms) (θ t : ℝ) : Set Space :=
  {x | θ * norms.supNorm t ≤ ‖ω t x‖}

/-- Scale-covariant radius `ρ_* = κ ||ω||₂ / ||∇ω||₂` at time `t`. -/
def rhoStarAt (norms : VorticityNorms) (κ t : ℝ) : ℝ :=
  rhoStar κ (norms.l2 t) (norms.gradL2 t)

/-- The cutoff radius is fixed at `R = K ρ_*`, not an arbitrary free scale. -/
def cutoffRadius (norms : VorticityNorms) (κ K t : ℝ) : ℝ :=
  K * rhoStarAt norms κ t

/--
A scale-locked cutoff profile. `w_R` is supplied only at the derived
radius `R = K ρ_*`.
-/
structure FixedScaleCutoff (norms : VorticityNorms) (κ : ℝ) where
  K : ℝ
  hK : 0 < K
  w : ℝ → Space → ℝ
  supportedInside : ∀ t x, w t x ≠ 0 → ‖x‖ ≤ cutoffRadius norms κ K t

/-- Notation for the fixed-radius cutoff profile. -/
def wR {norms : VorticityNorms} {κ : ℝ} (cutoff : FixedScaleCutoff norms κ) :
    ℝ → Space → ℝ :=
  cutoff.w

/--
PDE-level evolution law for the regularized direction field `xi_eps`. The
identity keeps the regularized denominator explicit and isolates the exact
uniform-in-`ε` remainder obligation instead of hiding it in a cutoff-dependent
constant.
-/
structure RegularizedXiEvolution where
  ω : VorticityField
  norms : VorticityNorms
  ε : ℝ
  ν : ℝ
  materialDerivative : ℝ → Space → Vec3
  strainAction : ℝ → Space → Vec3
  laplacianXi : ℝ → Space → Vec3
  gradOmegaOverOmegaEpsDotGradXi : ℝ → Space → Vec3
  remainder : ℝ → Space → Vec3
  remainderL1 : ℝ → ℝ
  hRemainderL1 : ∀ t, 0 ≤ remainderL1 t
  evolution :
    ∀ t x,
      materialDerivative t x
        = tangentialPart (xiEps ω ε t x) (strainAction t x)
            + ν • (laplacianXi t x + (2 : ℝ) • gradOmegaOverOmegaEpsDotGradXi t x)
            + remainder t x
  remainder_uniform_L1_vanishes_from_leray_hopf : Prop

/-- Audit interface for the `xi_eps` evolution theorem. -/
structure XiEvolutionLaw where
  regularized : RegularizedXiEvolution

/--
The genuinely open dynamic statement: actual Navier–Stokes evolution produces
uniform critical directional geometry on the dynamically relevant region, with
a constant depending only on the fixed scale lock `K`, `||u₀||₂`, `ν`, and `θ`.
-/
structure DynamicCriticalGeometry (ActualNS : Prop) where
  xiEvolution : XiEvolutionLaw
  theta : ℝ
  kappa : ℝ
  viscosity : ℝ
  u0L2 : ℝ
  cutoff : FixedScaleCutoff xiEvolution.regularized.norms kappa
  C0 : ℝ
  hC0 : 0 ≤ C0
  C0_depends_only_on_K_u0_L2_nu_theta : Prop
  C0_independent_of_eps : Prop
  C0_independent_of_cutoff_radius : Prop
  dynamics_to_uniform_coherence :
    ActualNS → ∀ t : ℝ, ∃ q : CriticalCoherenceAtTime, q.C ≤ C0 ∧ q.holds

/--
Kernel-weighted condition strong enough to talk to Biot–Savart/strain.
This is intentionally distinct from C_H^95.
-/
structure KernelWeightedCoherence where
  constant : ℝ
  hconstant : 0 ≤ constant
  holds : Prop

/-- The percentile tail problem is explicit, not hidden. -/
structure CH95ToKernelBridge (obs : ℕ → CH95AtTime) where
  bridge : UniformCH95 obs → KernelWeightedCoherence

/-- The analytic all-pairs/local-coherence to kernel bridge. -/
structure CoherenceToKernelBridge where
  bridge : (∀ t : ℝ, ∃ q : CriticalCoherenceAtTime, q.holds) →
    KernelWeightedCoherence

/--
Audit-level stretching data. `stretch` is the signed integral
∫ ω·Sω, while z is ||∇ω||².
-/
structure StretchingData where
  stretch : ℝ → ℝ
  z : ℝ → ℝ
  hz : ∀ t, 0 ≤ z t

/-- Signed coercive depletion target. -/
def GeometricDepletion (ν : ℝ) (d : StretchingData) : Prop :=
  ∃ δ : ℝ, 0 < δ ∧ δ ≤ 1 ∧
    ∀ t, d.stretch t ≤ (1 - δ) * ν * d.z t

/-- Harmonic-analysis bridge; this is not proved by this file. -/
structure KernelToDepletionBridge (ν : ℝ) (d : StretchingData) where
  bridge : KernelWeightedCoherence → GeometricDepletion ν d

/--
Full conditional composition. It proves only that once the two analytic
bridges are supplied, DynamicCriticalGeometry closes G1.
-/
theorem dynamic_geometry_closes_G1
    (ActualNS : Prop)
    (ν : ℝ)
    (d : StretchingData)
    (dyn : DynamicCriticalGeometry ActualNS)
    (toKernel : CoherenceToKernelBridge)
    (toDep : KernelToDepletionBridge ν d)
    (hNS : ActualNS) :
    GeometricDepletion ν d := by
  have hcoh : ∀ t : ℝ, ∃ q : CriticalCoherenceAtTime, q.holds := by
    intro t
    rcases dyn.dynamics_to_uniform_coherence hNS t with ⟨q, hqC, hq⟩
    exact ⟨q, hq⟩
  exact toDep.bridge (toKernel.bridge hcoh)

/-
AUDIT VERDICT

Machine-checked logical content in this file:
* definitions of xi, tangential projection, rho_*, sin-angle surrogate, Q
* explicit separation C_H^95 vs analytic coherence vs kernel coherence
* composition DynamicCriticalGeometry -> kernel -> signed depletion

Still open / not asserted:
* derivation of `RegularizedXiEvolution.evolution` from actual Leray-Hopf dynamics in Mathlib calculus notation
* proof that `remainder_uniform_L1_vanishes_from_leray_hopf` follows from energy control alone, uniformly in `ε`
* proof that the coherence constant is independent of the derived cutoff radius `R = K ρ_*`
* ActualNS -> uniform critical coherence on `OmegaTheta`
* critical coherence -> kernel-weighted coherence / signed Constantin-Fefferman depletion
* kernel-weighted coherence -> signed coercive depletion
* global regularity
-/

end G1Dynamic
