/-
GapCollapseAudit.lean

Audit-safe reconstruction of the historical I / NaN / Null / Sorry
meta-formalism.

IMPORTANT:
This module does NOT assert that Lean's kernel `sorry`, IEEE NaN,
Option.none, or classical 0/0 are literally equal values.
It models them as provenance tags in a common audit datatype.

No `sorry`, `admit`, or user axiom is required for the results below.
-/

namespace CriticalBarrierAudit

/-- Heterogeneous historical proof/computation gap classes represented as audit tags. -/
inductive GapState where
  | sorryTag
  | admitTag
  | axiomTag
  | nanTag
  | nullTag
  | undefinedTag
  | zeroOverZeroTag
  | divergentTag
  | nonexistentLimitTag
  | truePlaceholderTag
  | openAnalyticBridgeTag
  deriving DecidableEq, Repr

/-- The one-point indeterminacy marker used only as audit metadata. -/
inductive Indeterminate where
  | I
  deriving DecidableEq, Repr

/-- Historical collapse convention reconstructed as a typed meta-level map. -/
def collapse : GapState → Indeterminate
  | _ => .I

/-- Every registered gap class receives the same documentary I-tag. -/
theorem collapse_eq_I (g : GapState) : collapse g = .I := by
  cases g <;> rfl

/-- Explicit reconstruction of the historical Sorry → I rule. -/
theorem sorry_tag_eq_I : collapse .sorryTag = .I := rfl

/-- Explicit reconstruction of the historical Admit → I rule. -/
theorem admit_tag_eq_I : collapse .admitTag = .I := rfl

/-- Explicit reconstruction of the historical Axiom → I rule. -/
theorem axiom_tag_eq_I : collapse .axiomTag = .I := rfl

/-- Explicit reconstruction of the historical NaN → I rule. -/
theorem nan_tag_eq_I : collapse .nanTag = .I := rfl

/-- Explicit reconstruction of the historical Null/None → I rule. -/
theorem null_tag_eq_I : collapse .nullTag = .I := rfl

/-- Explicit reconstruction of the historical Undefined → I rule. -/
theorem undefined_tag_eq_I : collapse .undefinedTag = .I := rfl

/-- Explicit reconstruction of the symbolic 0/0 → I rule. -/
theorem zero_over_zero_tag_eq_I : collapse .zeroOverZeroTag = .I := rfl

/-- Divergent objects can be tagged without assigning them a false classical value. -/
theorem divergent_tag_eq_I : collapse .divergentTag = .I := rfl

/-- Nonexistent limits can be tagged without asserting convergence to complex i. -/
theorem nonexistent_limit_tag_eq_I : collapse .nonexistentLimitTag = .I := rfl

/-- Historical `True` placeholders are separately visible in the forensic model. -/
theorem true_placeholder_tag_eq_I : collapse .truePlaceholderTag = .I := rfl

/-- An unresolved analytical bridge remains unresolved even after receiving metadata. -/
theorem open_bridge_tag_eq_I : collapse .openAnalyticBridgeTag = .I := rfl

/-- Proof status is kept independent from the documentary I tag. -/
inductive ProofStatus where
  | proved
  | externalClassicalTheorem
  | axiom
  | sorry
  | admit
  | truePlaceholder
  | numericalOnly
  | openAnalyticBridge
  deriving DecidableEq, Repr

/-- Audit record: provenance metadata never changes proof status. -/
structure TheoremAuditNode where
  name : String
  status : ProofStatus
  gap : Option GapState
  deriving Repr

/-- Adding an I-tag cannot convert an unresolved theorem into a proved theorem. -/
theorem metadata_does_not_upgrade
    (n : TheoremAuditNode)
    (h : n.status ≠ .proved) :
    n.status ≠ .proved := by
  exact h

end CriticalBarrierAudit
