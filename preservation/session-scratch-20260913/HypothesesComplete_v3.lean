/-
HypothesesComplete_v3.lean

Audit-safe G1* decomposition after the componentwise C_H experiment.
No axiom, no sorry, and no theorem asserting that numerical percentiles imply
an analytic singular-integral estimate.
-/

import Mathlib

noncomputable section

namespace G1HypothesesV3

structure EnstrophyData where
  z : ℝ → ℝ
  stretch : ℝ → ℝ
  hz : ∀ t, 0 ≤ z t

/-- An exact analytic split of stretching into controlled bulk and exceptional tail. -/
structure StretchSplit (d : EnstrophyData) where
  bulk : ℝ → ℝ
  tail : ℝ → ℝ
  split : ∀ t, d.stretch t = bulk t + tail t

/-- Analytic, kernel-weighted tail control; a 95th percentile does not prove this. -/
def ExceptionalTailControl
    (ν δTail : ℝ) (d : EnstrophyData) (s : StretchSplit d) : Prop :=
  0 ≤ δTail ∧ ∀ t, s.tail t ≤ δTail * ν * d.z t

/-- Bulk absorption coefficient after all kernel constants are accounted for. -/
def BulkAbsorption
    (ν cBulk : ℝ) (d : EnstrophyData) (s : StretchSplit d) : Prop :=
  0 ≤ cBulk ∧ ∀ t, s.bulk t ≤ cBulk * ν * d.z t

/-- The combined analytic coefficient must be strictly below viscosity. -/
def SubcriticalBudget (cBulk δTail : ℝ) : Prop :=
  cBulk + δTail < 1

/-- The exact signed depletion conclusion required by the enstrophy route. -/
def GeometricDepletion (ν : ℝ) (d : EnstrophyData) : Prop :=
  ∃ δ : ℝ, 0 < δ ∧ δ ≤ 1 ∧
    ∀ t, d.stretch t ≤ (1 - δ) * ν * d.z t

/-- Pure algebra: analytic bulk and tail bounds close G1 when their budget is < 1. -/
theorem bulk_tail_to_depletion
    (ν cBulk δTail : ℝ) (hν : 0 ≤ ν)
    (d : EnstrophyData) (s : StretchSplit d)
    (hBulk : BulkAbsorption ν cBulk d s)
    (hTail : ExceptionalTailControl ν δTail d s)
    (hBudget : SubcriticalBudget cBulk δTail) :
    GeometricDepletion ν d := by
  rcases hBulk with ⟨hc, hbulk⟩
  rcases hTail with ⟨ht, htail⟩
  let δ := 1 - (cBulk + δTail)
  have hδ : 0 < δ := by
    dsimp [δ]
    linarith
  have hδone : δ ≤ 1 := by
    dsimp [δ]
    linarith
  refine ⟨δ, hδ, hδone, ?_⟩
  intro t
  have hzν : 0 ≤ ν * d.z t := mul_nonneg hν (d.hz t)
  have hs := s.split t
  have hb := hbulk t
  have he := htail t
  dsimp [δ]
  nlinarith

/-- Candidate joint normalization. This definition alone asserts no asymptotic law. -/
def JointNormalizedCH (CH : ℝ → ℝ) (κ : ℝ) : ℝ :=
  CH κ / Real.sqrt κ

/-- Analytic joint law; boundedness is an explicit premise, not inferred from 3–6 samples. -/
structure JointLaw (CH : ℝ → ℝ) where
  normalized : ℝ → ℝ
  factorization : ∀ κ, 0 < κ → CH κ = normalized κ * Real.sqrt κ
  bound : ℝ
  hbound_nonneg : 0 ≤ bound
  normalized_le : ∀ κ, 0 < κ → normalized κ ≤ bound

/--
The missing harmonic-analysis map. It must turn the joint law, including all
normalizations and constants, into the bulk coefficient used above.
-/
structure JointLawToBulkBridge
    (CH : ℝ → ℝ) (ν : ℝ) (d : EnstrophyData) (s : StretchSplit d) where
  cBulk : ℝ
  law_to_bulk : JointLaw CH → BulkAbsorption ν cBulk d s

/-- No-sorry composition theorem exposing both remaining analytic obligations. -/
theorem joint_law_and_tail_conditional_G1
    (CH : ℝ → ℝ) (ν δTail : ℝ) (hν : 0 ≤ ν)
    (d : EnstrophyData) (s : StretchSplit d)
    (law : JointLaw CH)
    (bridge : JointLawToBulkBridge CH ν d s)
    (tail : ExceptionalTailControl ν δTail d s)
    (budget : SubcriticalBudget bridge.cBulk δTail) :
    GeometricDepletion ν d :=
  bulk_tail_to_depletion ν bridge.cBulk δTail hν d s
    (bridge.law_to_bulk law) tail budget

/-
AUDIT STATUS

PROVED HERE:
* bulk + tail + subcritical coefficient budget -> signed depletion;
* logical composition of explicit JointLawToBulkBridge and tail certificate.

NOT PROVED HERE:
* finite-resolution C_H^95 -> analytic JointLaw;
* control of the kernel-weighted exceptional tail;
* JointLaw -> BulkAbsorption with a subcritical coefficient;
* ActualNS -> any of the preceding analytic hypotheses;
* unconditional Navier--Stokes regularity.
-/

end G1HypothesesV3
