module ResolutionDynamics where

open import Agda.Builtin.Nat
open import Agda.Builtin.Bool

-- Audit-safe propositional composition.  Problem-specific analytic bridges are
-- parameters, not postulated conclusions.

endpointFromNativeControl : {R N E : Set} -> (R -> N) -> (N -> E) -> R -> E
endpointFromNativeControl bridge endpoint r = endpoint (bridge r)

record TransitionCoordinates : Set where
  field
    defectNumber : Nat
    invariantViolationNumber : Nat
    certificateDepthNumber : Nat
    bridgeDistanceNumber : Nat
    degeneracyNumber : Nat
    reproducibilityBasisPoints : Nat

data Stage : Set where
  observed : Stage
  typed : Stage
  projected : Stage
  residualized : Stage
  corrected : Stage
  contractive : Stage
  criticalControlled : Stage
  endpointCertified : Stage
  formalProofChecked : Stage
  degenerate : Stage
  inconsistentSpecification : Stage
  openBridge : Stage
  falsified : Stage

-- Natural-number diagnostic contraction.  This is intentionally computational,
-- not a substitute for real-analysis coercivity in Navier--Stokes.
record NatDefectStep : Set where
  field
    before : Nat
    after : Nat
    decreased : Bool
