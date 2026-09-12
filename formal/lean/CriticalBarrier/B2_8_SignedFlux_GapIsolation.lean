import Mathlib

/-!
# B2.8 signed-flux gap isolation

This file proves two negative audit facts about the proposed B2.8 closure route:

1. the displayed Bernstein/CZ/low-L3 numerical chain does not yield the target
   strain bound 25 at Lambda=10; its coefficient is strictly larger than 25;
2. traceless strain plus a 50% high-frequency concentration condition does not,
   by itself, imply Alignment <= 0.9.

These are finite algebraic certificates. They do not prove or refute global
Navier--Stokes regularity.
-/

namespace CriticalBarrier.B28GapIsolation

abbrev Scalar := ℝ

def C_Bern : Scalar := 4
def C_CZ : Scalar := 3 / 2
def cstarDecimal : Scalar := 5851230687 / 10000000000

def targetKappa : Scalar := 25

def delta : Scalar := 1 / 10

/-- The coefficient suggested by the chain
    C_CZ * C_Bern * Lambda^(3/2) * cstar at Lambda=10.
    We write 10^(3/2) as 10*sqrt(10). -/
def proposedStrainCoeff : Scalar :=
  C_CZ * C_Bern * (10 * Real.sqrt 10) * cstarDecimal

/-- sqrt(10) > 3. -/
theorem sqrt10_gt_three : (3 : ℝ) < Real.sqrt 10 := by
  have hsq : (Real.sqrt 10)^2 = (10 : ℝ) := by
    norm_num [sq, Real.sq_sqrt]
  have hsnonneg : 0 ≤ Real.sqrt 10 := Real.sqrt_nonneg 10
  nlinarith

/-- The displayed numerical chain cannot prove the target strain bound 25.
    In fact its coefficient is already > 100, hence certainly > 25. -/
theorem proposed_strain_chain_exceeds_target :
    targetKappa < proposedStrainCoeff := by
  have hs := sqrt10_gt_three
  dsimp [targetKappa, proposedStrainCoeff, C_CZ, C_Bern, cstarDecimal]
  have hc : (0 : ℝ) < (5851230687 : ℝ) / 10000000000 := by norm_num
  nlinarith

/-- A minimal abstract alignment model. -/
structure AlignmentState where
  lambda1 : Scalar
  lambda2 : Scalar
  lambda3 : Scalar
  weight1 : Scalar
  weight2 : Scalar
  weight3 : Scalar

namespace AlignmentState

def trace (s : AlignmentState) : Scalar := s.lambda1 + s.lambda2 + s.lambda3

def totalWeight (s : AlignmentState) : Scalar := s.weight1 + s.weight2 + s.weight3

def quadratic (s : AlignmentState) : Scalar :=
  s.lambda1 * s.weight1 + s.lambda2 * s.weight2 + s.lambda3 * s.weight3

/-- Normalized alignment when the operator norm is 1 and total weight is 1.
    This specialized model is enough to falsify the proposed implication. -/
def alignment (s : AlignmentState) : Scalar := s.quadratic

end AlignmentState

/-- Trace-free strain diag(1,-1/2,-1/2), with all high-frequency mass aligned
    with the expansive eigenvector. -/
def expansiveExample : AlignmentState where
  lambda1 := 1
  lambda2 := -1/2
  lambda3 := -1/2
  weight1 := 1
  weight2 := 0
  weight3 := 0

theorem expansive_trace_zero : expansiveExample.trace = 0 := by
  norm_num [expansiveExample, AlignmentState.trace]

theorem expansive_total_weight_one : expansiveExample.totalWeight = 1 := by
  norm_num [expansiveExample, AlignmentState.totalWeight]

/-- The usual "at least 50% high-frequency mass" scalar condition is satisfied
    in this normalized example. -/
theorem expansive_is_concentrated :
    (1/2 : ℝ) ≤ expansiveExample.totalWeight := by
  norm_num [expansiveExample, AlignmentState.totalWeight]

/-- Yet the normalized alignment is exactly 1, so Alignment <= 0.9 fails. -/
theorem expansive_alignment_one : expansiveExample.alignment = 1 := by
  norm_num [expansiveExample, AlignmentState.alignment, AlignmentState.quadratic]

theorem traceless_and_concentrated_do_not_force_alignment_09 :
    expansiveExample.trace = 0 ∧
    (1/2 : ℝ) ≤ expansiveExample.totalWeight ∧
    ¬ (expansiveExample.alignment ≤ 1 - delta) := by
  constructor
  · exact expansive_trace_zero
  constructor
  · exact expansive_is_concentrated
  · norm_num [delta, expansive_alignment_one]

/-- Therefore the B2.8 closure needs an additional directional/depletion
    hypothesis or a genuinely PDE-derived mechanism excluding the expansive
    alignment example. -/
structure MissingDirectionalCertificate (Pi R kappa err : Scalar) : Prop where
  alignmentDepletion : Prop
  directionalMechanism : alignmentDepletion
  signedFlux : alignmentDepletion → Pi ≤ (kappa + err) * R

theorem signed_flux_from_directional_certificate
    (Pi R kappa err : Scalar)
    (C : MissingDirectionalCertificate Pi R kappa err) :
    Pi ≤ (kappa + err) * R :=
  C.signedFlux C.directionalMechanism

end CriticalBarrier.B28GapIsolation
