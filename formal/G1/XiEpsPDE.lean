/-
XiEpsPDE.lean

Concrete regularized direction-equation interface used by the DynamicCampanato
attack.  This file fixes the regularization and the exact PDE decomposition while
keeping the commutator/remainder estimates cutoff-free.

No `axiom`, `sorry`, `admit`, `sup_t ||omega||_2^2`, or palinstrophy integral is
introduced here.
-/

import Mathlib

noncomputable section

namespace G1Audit

abbrev Vec3 := EuclideanSpace ℝ (Fin 3)
abbrev ScalarField := Vec3 → ℝ
abbrev VectorField := Vec3 → Vec3

/-- Regularized vorticity magnitude |omega|_eps = sqrt(|omega|^2 + eps^2). -/
def magEps (ω : VectorField) (ε : ℝ) (x : Vec3) : ℝ :=
  Real.sqrt (‖ω x‖ ^ 2 + ε ^ 2)

/-- Regularized direction xi_eps = omega / |omega|_eps. -/
def xiEps (ω : VectorField) (ε : ℝ) (x : Vec3) : Vec3 :=
  (magEps ω ε x)⁻¹ • ω x

/-- The regularized magnitude is nonnegative. -/
theorem magEps_nonneg (ω : VectorField) (ε : ℝ) (x : Vec3) :
    0 ≤ magEps ω ε x :=
  Real.sqrt_nonneg _

/-- For eps > 0, the regularized magnitude is strictly positive. -/
theorem magEps_pos (ω : VectorField) (ε : ℝ) (hε : 0 < ε) (x : Vec3) :
    0 < magEps ω ε x := by
  unfold magEps
  apply Real.sqrt_pos.2
  nlinarith [sq_nonneg ‖ω x‖, sq_pos_of_pos hε]

/-- In particular |omega|_eps is never zero when eps > 0. -/
theorem magEps_ne_zero (ω : VectorField) (ε : ℝ) (hε : 0 < ε) (x : Vec3) :
    magEps ω ε x ≠ 0 :=
  ne_of_gt (magEps_pos ω ε hε x)

/--
Cutoff-free remainder budget.  `gradUEpsSq` is the Leray-paid quantity and
`remainderSize` is the total R1/R2 contribution used downstream.
-/
structure XiEpsRemainderBudget where
  gradUEpsSq : ℝ → ℝ
  remainderSize : ℝ → ℝ
  Crem : ℝ
  hgrad_nonneg : ∀ t, 0 ≤ gradUEpsSq t
  hrem_nonneg : ∀ t, 0 ≤ remainderSize t
  hCrem_nonneg : 0 ≤ Crem
  cutoff_free : ∀ t, remainderSize t ≤ Crem * gradUEpsSq t

/--
Exact regularized direction PDE.

To keep all types correct, `R2Numerator` is the already-contracted vector
numerator corresponding to the schematic term eps^2 * grad omega_eps.  A raw
Jacobian `grad omega_eps` is matrix-valued and cannot itself be added to the
vector equation for xi_eps without specifying the contraction.
-/
structure XiEpsPDE where
  ε : ℝ
  hε : 0 < ε
  ν : ℝ
  hν : 0 < ν

  omegaEps : VectorField
  uEps : VectorField

  /-- Material derivative D_t xi_eps. -/
  DtXi : VectorField
  /-- Projected stretching S_eps xi_eps - (xi_eps·S_eps xi_eps) xi_eps. -/
  projectedStretch : VectorField
  /-- Laplacian of xi_eps. -/
  lapXi : VectorField
  /-- Vector field representing grad(log |omega|_eps) · grad xi_eps. -/
  logGradDotGradXi : VectorField

  /-- Numerator [J_eps, u·grad] omega. -/
  R1Numerator : VectorField
  R1 : VectorField
  /-- Already-contracted vector numerator associated with eps^2 grad omega_eps. -/
  R2Numerator : VectorField
  R2 : VectorField

  /-- R1 = [J_eps,u·grad]omega / |omega|_eps. -/
  hR1_def : ∀ x,
    R1 x = (magEps omegaEps ε x)⁻¹ • R1Numerator x

  /-- R2 = eps^2 * R2Numerator / |omega|_eps^3. -/
  hR2_def : ∀ x,
    R2 x = (ε ^ 2 * (magEps omegaEps ε x)⁻¹ ^ 3) • R2Numerator x

  /-- Exact pointwise regularized direction equation. -/
  equation : ∀ x,
    DtXi x =
      projectedStretch x
        + ν • lapXi x
        + (2 * ν) • logGradDotGradXi x
        + R1 x + R2 x

  /-- Cutoff-free Leray-paid remainder control; no enstrophy supremum. -/
  remainderBudget : XiEpsRemainderBudget

/-- The xi field attached to a XiEpsPDE object is exactly omega/|omega|_eps. -/
def XiEpsPDE.xi (h : XiEpsPDE) : VectorField :=
  xiEps h.omegaEps h.ε

/-- R1 is well-defined pointwise because |omega|_eps > 0. -/
theorem XiEpsPDE.R1_denominator_ne_zero (h : XiEpsPDE) (x : Vec3) :
    magEps h.omegaEps h.ε x ≠ 0 :=
  magEps_ne_zero h.omegaEps h.ε h.hε x

/-- R2 is well-defined pointwise for the same reason. -/
theorem XiEpsPDE.R2_denominator_ne_zero (h : XiEpsPDE) (x : Vec3) :
    magEps h.omegaEps h.ε x ≠ 0 :=
  magEps_ne_zero h.omegaEps h.ε h.hε x

/-- Status marker for the concrete PDE layer. -/
inductive XiEpsPDEStatus
  | definedExactEquation
  | remainderCutoffFree
  | localizedIdentityProved
  | signedFarFieldOpen
  deriving DecidableEq, Repr

end G1Audit
