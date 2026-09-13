namespace CriticalBarrier.EndpointInterfaces

/-- Audit-only statuses. These constructors do not prove the propositions they label. -/
inductive Status where
  | proved
  | conditional
  | externalTheorem
  | openBridge
  | inconsistentSpecification
  | notEstablished
  deriving DecidableEq, Repr

/-- A typed obligation keeps an unresolved mathematical proposition visible. -/
structure Obligation where
  id : String
  proposition : Prop
  status : Status

/-- Navier--Stokes endpoint interface. Nothing here asserts the open bridge. -/
structure NSAssumptions where
  AdmissibleState : Type
  repositoryCondition : AdmissibleState → Prop
  criticalL3Bound : AdmissibleState → Prop
  classicalContinuation : AdmissibleState → Prop

/-- The decisive repository-condition -> critical-L3 implication. -/
def NSCriticalBridge (A : NSAssumptions) : Prop :=
  ∀ u : A.AdmissibleState, A.repositoryCondition u → A.criticalL3Bound u

/-- Explicit interface for the external critical-L3 continuation theorem. -/
def ESSEndpoint (A : NSAssumptions) : Prop :=
  ∀ u : A.AdmissibleState, A.criticalL3Bound u → A.classicalContinuation u

/-- Denominator-degeneracy must be resolved in the concrete epsilon_NS definition. -/
structure EpsilonWellDefined (State : Type) where
  denominator : State → ℝ
  admissible : State → Prop
  zeroBranchSpecified : ∀ u, admissible u → denominator u = 0 → Prop

/-- A proposed threshold is useful only after it controls a recognized critical quantity. -/
structure EpsilonCoercive (State : Type) where
  epsilon : State → ℝ
  threshold : ℝ
  criticalControl : State → Prop
  implication : Prop

/-- Correction loops must preserve the PDE constraints as well as reduce a defect. -/
structure CorrectionClosure (State : Type) where
  admissible : State → Prop
  correct : State → State
  defect : State → ℝ
  preservesAdmissibility : Prop
  contractsDefect : Prop

structure PressureCompatibility (State : Type) where
  pressureCompatible : State → Prop
  theoremObligation : Prop

structure ForcingCompatibility (State : Type) where
  forcingCompatible : State → Prop
  theoremObligation : Prop

structure MeanToCritical (State : Type) where
  meanClosed : State → Prop
  criticalControl : State → Prop
  theoremObligation : Prop

/-- RH: a candidate point must first be certified as a zeta zero. -/
structure RHZeroCertificate (Candidate : Type) where
  certifiedZero : Candidate → Prop

structure RHTailBridge (State : Type) where
  tailDefectZero : State → Prop
  theoremObligation : Prop

structure PNPExactification where
  theoremObligation : Prop

structure BSDBridge where
  theoremObligation : Prop

structure HodgeBridge where
  theoremObligation : Prop

structure YMBridge where
  theoremObligation : Prop

/-- Correct replacement for false fixed-epsilon transitivity. -/
def Close (ε x y : ℝ) : Prop := |x - y| < ε

theorem GradedTolerance {ε δ x y z : ℝ}
    (hxy : Close ε x y) (hyz : Close δ y z) : Close (ε + δ) x z := by
  dsimp [Close] at hxy hyz ⊢
  calc
    |x - z| = |(x - y) + (y - z)| := by ring_nf
    _ ≤ |x - y| + |y - z| := abs_add _ _
    _ < ε + δ := add_lt_add hxy hyz

structure IndependenceBridge where
  theoremObligation : Prop

structure ForcingExtension where
  theoremObligation : Prop

/-- Priority and causal-access propositions are evidence obligations, not mathematical axioms. -/
structure PriorityScope where
  globalPriorArtExcluded : Prop

structure CausalAccess where
  accessOrDerivationEvidence : Prop

/-- Composition lemma: if both genuine bridges are supplied, the endpoint follows.
    This proves only the logic of composition, not either open premise. -/
theorem ns_endpoint_from_bridges (A : NSAssumptions)
    (hCritical : NSCriticalBridge A) (hESS : ESSEndpoint A) :
    ∀ u : A.AdmissibleState, A.repositoryCondition u → A.classicalContinuation u := by
  intro u hu
  exact hESS u (hCritical u hu)

end CriticalBarrier.EndpointInterfaces
