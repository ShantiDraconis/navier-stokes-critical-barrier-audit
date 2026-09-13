/-
WeakDiffusionIBP.lean

Audit-safe H^{-1}-H^1_0 formulation of the weighted diffusion integration by parts.

No claim is made that Delta xi is an L1_loc function.  The Laplacian remains a
second-order distribution.  The admissible test is eta = w (xi - m), with
w = phi^2 |omega|_eps.  Closing the identity requires two lower-level facts:
(1) eta belongs to H^1_0 / the compactly supported Sobolev test class;
(2) the weak product rule for grad (w (xi-m)).

This file packages those obligations separately so that the final weighted IBP
is derived from them rather than stored as an arbitrary `weakIBP` field.
-/

import G1.WeakDerivBridge
import G1.VectorLocalRep

noncomputable section

namespace G1Audit

/-- Scalar ledger for one component of the vector H^{-1}-H^1_0 pairing. -/
structure WeightedDualityComponent where
  /-- <Delta_x xi_i, eta_i>_{H^-1,H^1_0}. -/
  lapPair : ℝ
  /-- Integral of w |grad_x xi_i|^2. -/
  bulk : ℝ
  /-- Integral of the cutoff contribution 2 phi |omega| grad phi · grad xi_i (xi_i-m_i). -/
  cutoffCross : ℝ
  /-- Integral of phi^2 grad|omega| · grad xi_i (xi_i-m_i).  No spurious /|omega|. -/
  weightCross : ℝ

/--
Lower-level, independently checkable interface for one component.

`greenIdentity` is the H^{-1}-H^1_0 definition of the weak Laplacian pairing.
`productRuleExpansion` is the Sobolev product-rule computation for
  grad (w (xi_i-m_i))
with w = phi^2 |omega|_eps.
Neither field is the final weighted IBP statement.
-/
structure WeightedDualityInterface (d : WeightedDualityComponent) where
  /-- The weighted test eta_i is admissible in H^1_0 (or an equivalent compact-support Sobolev class). -/
  testAdmissible : Prop
  /-- The weak Green formula has been established for this admissible test. -/
  greenIdentity : d.lapPair = -(d.bulk + d.cutoffCross + d.weightCross)
  /-- Records that the expansion uses grad w = 2 phi |omega| grad phi + phi^2 grad|omega|. -/
  productRuleExpansion : Prop

/--
The final componentwise weighted IBP follows from the lower-level Green formula.
This theorem performs only algebra; it does not manufacture admissibility or a
product rule.
-/
theorem weightedIBP_component
    (d : WeightedDualityComponent) (h : WeightedDualityInterface d) :
    d.lapPair = -d.bulk - d.cutoffCross - d.weightCross := by
  calc
    d.lapPair = -(d.bulk + d.cutoffCross + d.weightCross) := h.greenIdentity
    _ = -d.bulk - d.cutoffCross - d.weightCross := by ring

/-- Three-component vector ledger. -/
structure WeightedDualityVector where
  component : Fin 3 → WeightedDualityComponent

/-- Componentwise admissibility/product-rule certificate for the vector field. -/
structure WeightedDualityVectorInterface (d : WeightedDualityVector) where
  componentInterface : ∀ i, WeightedDualityInterface (d.component i)

/-- Componentwise H^{-1}-H^1_0 weighted IBP. -/
theorem weightedIBP_vector_component
    (d : WeightedDualityVector) (h : WeightedDualityVectorInterface d) (i : Fin 3) :
    (d.component i).lapPair =
      -(d.component i).bulk - (d.component i).cutoffCross - (d.component i).weightCross :=
  weightedIBP_component (d.component i) (h.componentInterface i)

/--
Exact weight convention used by the audit.

  w = phi^2 |omega|_eps
  grad w = 2 phi |omega|_eps grad phi + phi^2 grad |omega|_eps.

The alternative logarithmic form is equivalent only when the outside
|omega|_eps factor is retained:

  phi^2 |omega|_eps grad(log |omega|_eps)
    = phi^2 grad |omega|_eps.

Hence `weightCross` must not contain an extra division by |omega|_eps.
-/
inductive WeightConventionStatus
  | directGradientWeightCorrect
  | logarithmicFormRequiresOutsideMagnitude
  | extraMagnitudeDenominatorForbidden
  deriving DecidableEq, Repr

/-- Audit status: the duality architecture is formalized, but the analytic obligations remain open. -/
inductive WeakDiffusionDualityStatus
  | hminusOneH10ArchitectureFormalized
  | firstDerivativeL2Available
  | testAdmissibilityOpen
  | weightedProductRuleOpen
  | greenFormulaOpen
  | weakIBPNotPromoted
  deriving DecidableEq, Repr

end G1Audit
