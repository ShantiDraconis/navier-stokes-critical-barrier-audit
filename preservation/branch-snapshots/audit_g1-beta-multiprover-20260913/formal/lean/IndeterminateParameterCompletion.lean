/-
Audit-safe completion layer for unresolved parameters and historical `sorry` sites.

Important: this file does NOT pretend to prove Millennium-problem independence or
other open mathematics.  It separates:
  * propositions provable from the data already present;
  * conditional theorems whose missing mathematical content is an explicit input;
  * historical definitions that cannot satisfy the advertised structure.

In particular, fixed-epsilon closeness |x-y| < ε is NOT transitive in general,
so it cannot honestly be used as a Setoid on ℚ.  We formalize the valid
reflexive/symmetric/graded-triangle structure instead.
-/

import Mathlib.Data.Rat.Basic
import Mathlib.Data.Int.Basic
import Mathlib.Tactic

namespace AuditCompletion

/-! ## 1. Explicit unresolved-parameter state -/

inductive ObligationStatus where
  | proved
  | conditional
  | externalTheorem
  | openBridge
  | inconsistentSpecification
  deriving Repr, DecidableEq

structure Parameter (α : Type) where
  current : α
  target : α

structure WeightedGap where
  sensitivity : ℚ
  gap : ℚ
  sensitivity_nonneg : 0 ≤ sensitivity
  gap_nonneg : 0 ≤ gap

namespace WeightedGap

def weight (g : WeightedGap) : ℚ := g.sensitivity * g.gap

theorem weight_nonneg (g : WeightedGap) : 0 ≤ g.weight :=
  mul_nonneg g.sensitivity_nonneg g.gap_nonneg

end WeightedGap

/-! ## 2. Percentage decomposition without division-by-zero ambiguity -/

structure ErrorDecomposition where
  terms : List WeightedGap
  total : ℚ := (terms.map WeightedGap.weight).sum
  total_pos : 0 < total

namespace ErrorDecomposition

def contribution (D : ErrorDecomposition) (g : WeightedGap) : ℚ :=
  g.weight / D.total

def percentage (D : ErrorDecomposition) (g : WeightedGap) : ℚ :=
  100 * D.contribution g

theorem contribution_nonneg (D : ErrorDecomposition) (g : WeightedGap) :
    0 ≤ D.contribution g := by
  exact div_nonneg g.weight_nonneg (le_of_lt D.total_pos)

end ErrorDecomposition

/-! ## 3. Shared/distinct feature bookkeeping -/

structure PairwiseComparison where
  shared : ℕ
  leftOnly : ℕ
  rightOnly : ℕ
  nonempty : 0 < shared + leftOnly + rightOnly

namespace PairwiseComparison

def total (C : PairwiseComparison) : ℕ := C.shared + C.leftOnly + C.rightOnly

def similarity (C : PairwiseComparison) : ℚ := C.shared / C.total

def distinctness (C : PairwiseComparison) : ℚ := (C.leftOnly + C.rightOnly) / C.total

end PairwiseComparison

/-! ## 4. Valid replacement for historical epsilonEquiv -/

structure Tolerance (ε : ℚ) where
  pos : 0 < ε

namespace Tolerance

def Close {ε : ℚ} (T : Tolerance ε) (x y : ℚ) : Prop := |x - y| < ε

theorem refl {ε : ℚ} (T : Tolerance ε) (x : ℚ) : T.Close x x := by
  simp [Close, T.pos]

theorem symm {ε : ℚ} (T : Tolerance ε) {x y : ℚ} :
    T.Close x y → T.Close y x := by
  intro h
  simpa [Close, abs_sub_comm] using h

/-- The honest composition law: ε-close followed by δ-close gives (ε+δ)-close. -/
theorem triangle
    {ε δ : ℚ} (Tε : Tolerance ε) (Tδ : Tolerance δ)
    {x y z : ℚ}
    (hxy : Tε.Close x y) (hyz : Tδ.Close y z) :
    |x - z| < ε + δ := by
  calc
    |x - z| ≤ |x - y| + |y - z| := abs_sub_le_iff.2 ⟨by linarith [le_abs_self (x-y), le_abs_self (y-z)], by linarith [neg_abs_le (x-y), neg_abs_le (y-z)]⟩
    _ < ε + δ := add_lt_add hxy hyz

/-- Concrete counterexample: fixed ε-closeness is not transitive. -/
theorem epsilon_close_not_transitive :
    ¬ (∀ x y z : ℚ, |x-y| < 1 → |y-z| < 1 → |x-z| < 1) := by
  intro h
  have hx := h 0 (3/4 : ℚ) (3/2 : ℚ)
  norm_num at hx

end Tolerance

/-! ## 5. Conditional replacement for model/independence sorries -/

/-- Minimal semantic interface.  No completeness theorem is smuggled in. -/
structure SemanticContext (Sentence Model : Type) where
  satisfies : Model → Sentence → Prop
  neg : Sentence → Sentence

namespace SemanticContext

variable {Sentence Model : Type}
variable (C : SemanticContext Sentence Model)

def DualWitness (φ : Sentence) : Prop :=
  (∃ M : Model, C.satisfies M φ) ∧
  (∃ N : Model, C.satisfies N (C.neg φ))

/-- If the historical notion of independence has already been connected to
    two semantic witnesses, DualWitness follows without `sorry`. -/
theorem dual_of_independence_bridge
    (Independent : Sentence → Prop)
    (bridge : ∀ φ, Independent φ → C.DualWitness φ)
    {φ : Sentence} (h : Independent φ) : C.DualWitness φ :=
  bridge φ h

end SemanticContext

/-! ## 6. Superpositional values require evidence, not a placeholder -/

structure TwoBranchValue (Sentence α : Type) where
  whenTrue : α
  whenFalse : α
  conjecture : Sentence

structure CertifiedTwoBranch
    (Sentence Model α : Type)
    (C : SemanticContext Sentence Model) where
  value : TwoBranchValue Sentence α
  witnesses : C.DualWitness value.conjecture

/-- Construction is total once the genuinely mathematical witness is supplied. -/
def certifyTwoBranch
    {Sentence Model α : Type}
    {C : SemanticContext Sentence Model}
    (v : TwoBranchValue Sentence α)
    (h : C.DualWitness v.conjecture) : CertifiedTwoBranch Sentence Model α C :=
  ⟨v, h⟩

/-! ## 7. Proof-status rule: metadata never upgrades an open bridge -/

def upgradesToProof : ObligationStatus → Bool
  | .proved => true
  | _ => false

theorem open_bridge_not_proved : upgradesToProof .openBridge = false := rfl
theorem conditional_not_proved : upgradesToProof .conditional = false := rfl
theorem inconsistent_spec_not_proved :
    upgradesToProof .inconsistentSpecification = false := rfl

end AuditCompletion
