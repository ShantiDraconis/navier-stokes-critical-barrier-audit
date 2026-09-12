/-
NumericClassAudit.lean

Axiom-free audit core for the historical numeric-class program.
This file formalizes only bookkeeping structures and logical laws that do not
presuppose any unresolved Millennium result.
-/

namespace CriticalBarrier

inductive ProofStatus where
  | proved
  | conditional
  | externalTheorem
  | openBridge
  | inconsistentSpecification
  deriving DecidableEq, Repr

inductive Problem where
  | riemann
  | pVsNP
  | navierStokes
  | birchSwinnertonDyer
  | hodge
  | yangMills
  deriving DecidableEq, Repr

inductive NumericClassTag where
  | independenceNumber
  | multiModelNumber
  | equivalenceBreakNumber
  | obstructionNumber
  | regularityNumber
  | criticalZeroNumber
  | massGapNumber
  | rankNumber
  | hodgeNumber
  | complexityNumber
  | forcingNumber
  | woodinNumber
  | truthValueNumber
  | dualityNumber
  deriving DecidableEq, Repr

structure ProvenanceRef where
  repository : String
  commitSha : String
  timestamp : String
  relativePath : String
  deriving DecidableEq, Repr

structure ClassCertificate where
  tag : NumericClassTag
  problem : Option Problem
  status : ProofStatus
  provenance : ProvenanceRef
  deriving DecidableEq, Repr

structure RegularityNumber where
  sobolevIndex : Int
  finiteBlowupTime : Option Nat
  globallyRegular : Bool
  deriving DecidableEq, Repr

structure CriticalZeroNumber where
  realNumerator : Int
  realDenominator : Nat
  imaginaryIndex : Int
  denominatorNonzero : Bool
  deriving DecidableEq, Repr

structure MassGapNumber where
  gapNumerator : Nat
  gapDenominator : Nat
  denominatorNonzero : Bool
  positive : Bool
  deriving DecidableEq, Repr

structure RankNumber where
  algebraicRank : Nat
  analyticRank : Nat
  deriving DecidableEq, Repr

structure HodgeNumber where
  p : Nat
  q : Nat
  dimension : Nat
  deriving DecidableEq, Repr

structure ComplexityNumber where
  timeClass : Nat
  lowerBoundLevel : Nat
  exactDecisionCertified : Bool
  deriving DecidableEq, Repr

structure ObstructionNumber where
  magnitude : Nat
  status : ProofStatus
  deriving DecidableEq, Repr

structure IndependenceNumber where
  degreeBasisPoints : Nat
  bounded : degreeBasisPoints ≤ 10000

structure MultiModelNumber where
  values : List Int
  nonempty : values ≠ []

structure EquivalenceBreakNumber where
  gap : Nat
  broken : Bool
  deriving DecidableEq, Repr

structure ForcingNumber where
  ordinalCode : Nat
  conditionCount : Nat
  addsReals : Bool
  deriving DecidableEq, Repr

structure WoodinNumber where
  strengthCode : Nat
  ultimateLHolds : Bool
  deriving DecidableEq, Repr

inductive TruthValueNumber where
  | trueInAll
  | falseInAll
  | independent
  deriving DecidableEq, Repr

structure DualityNumber where
  positive : Int
  negative : Int
  deriving DecidableEq, Repr

namespace DualityNumber

def collapse (d : DualityNumber) : Option Int :=
  if d.positive = d.negative then some d.positive else none

def divergence (d : DualityNumber) : Nat :=
  Int.natAbs (d.positive - d.negative)

theorem collapse_some_implies_equal (d : DualityNumber) (v : Int)
    (h : d.collapse = some v) : d.positive = d.negative := by
  unfold collapse at h
  split at h
  · assumption
  · contradiction

theorem equal_implies_collapse (d : DualityNumber)
    (h : d.positive = d.negative) : d.collapse = some d.positive := by
  unfold collapse
  simp [h]

end DualityNumber

structure ParameterGap where
  sensitivity : Nat
  distance : Nat
  deriving DecidableEq, Repr

namespace ParameterGap

def weight (g : ParameterGap) : Nat := g.sensitivity * g.distance

theorem zero_sensitivity_zero_weight (g : ParameterGap)
    (h : g.sensitivity = 0) : g.weight = 0 := by
  simp [weight, h]

theorem zero_distance_zero_weight (g : ParameterGap)
    (h : g.distance = 0) : g.weight = 0 := by
  simp [weight, h]

end ParameterGap

structure ErrorState where
  terms : List ParameterGap
  totalWeight : Nat
  totalMatches : totalWeight = (terms.map ParameterGap.weight).foldl (· + ·) 0

/-- Percentage-like values are represented as basis points and are defined only
    when the total weight is nonzero.  This avoids silently introducing 0/0. -/
def contributionBasisPoints (weight total : Nat) : Option Nat :=
  if total = 0 then none else some ((10000 * weight) / total)

theorem zero_total_is_undefined (w : Nat) :
    contributionBasisPoints w 0 = none := by
  simp [contributionBasisPoints]

theorem positive_total_is_defined (w t : Nat) (h : t ≠ 0) :
    ∃ b, contributionBasisPoints w t = some b := by
  refine ⟨(10000 * w) / t, ?_⟩
  simp [contributionBasisPoints, h]

structure SharedDistinct where
  shared : Nat
  leftOnly : Nat
  rightOnly : Nat
  deriving DecidableEq, Repr

namespace SharedDistinct

def total (s : SharedDistinct) : Nat := s.shared + s.leftOnly + s.rightOnly

def similarityBasisPoints (s : SharedDistinct) : Option Nat :=
  contributionBasisPoints s.shared s.total

def distinctBasisPoints (s : SharedDistinct) : Option Nat :=
  contributionBasisPoints (s.leftOnly + s.rightOnly) s.total

theorem empty_comparison_undefined :
    (SharedDistinct.mk 0 0 0).similarityBasisPoints = none := by
  rfl

end SharedDistinct

/-- Metadata cannot upgrade an unresolved bridge into a proof. -/
def isProof : ProofStatus → Bool
  | .proved => true
  | _ => false

theorem open_bridge_is_not_proof : isProof .openBridge = false := rfl
theorem conditional_is_not_proof : isProof .conditional = false := rfl
theorem inconsistent_spec_is_not_proof :
    isProof .inconsistentSpecification = false := rfl

end CriticalBarrier
