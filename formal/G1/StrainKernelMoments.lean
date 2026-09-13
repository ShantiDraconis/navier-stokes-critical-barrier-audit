/-
StrainKernelMoments.lean

Preparatory, audit-safe moment layer for the tensorial strain kernel.

This file proves only pointwise parity consequences of `StrainKernelData.odd`.
It does NOT assert spherical/annular principal-value cancellation for the
physical Biot-Savart strain operator, and it does NOT pay the rho_*^3 scaling
deficit.  Integral moment statements remain separate analytic obligations.
-/

import G1.StrainKernel

noncomputable section

namespace G1Audit

/-- One scalar tensor component of the strain kernel. -/
def strainComponent
    (K : StrainKernelData) (i j k : Fin 3) : Vec3 → ℝ :=
  fun z => K.kernel z i j k

/-- Every scalar tensor component inherits odd parity. -/
theorem strainComponent_odd
    (K : StrainKernelData) (i j k : Fin 3) (z : Vec3) :
    strainComponent K i j k (-z) = - strainComponent K i j k z := by
  exact K.odd z i j k

/-- Coordinate function z ↦ z_l. -/
def coordinate (l : Fin 3) : Vec3 → ℝ := fun z => z l

/-- A first-moment integrand z_l K_ijk(z). -/
def firstMomentIntegrand
    (K : StrainKernelData) (l i j k : Fin 3) : Vec3 → ℝ :=
  fun z => coordinate l z * strainComponent K i j k z

/--
Odd kernel × odd coordinate = even first-moment integrand.
Therefore oddness alone cannot force the first moment to vanish.
-/
theorem firstMomentIntegrand_even
    (K : StrainKernelData) (l i j k : Fin 3) (z : Vec3) :
    firstMomentIntegrand K l i j k (-z) =
      firstMomentIntegrand K l i j k z := by
  simp [firstMomentIntegrand, coordinate, strainComponent, K.odd]

/--
A constant-mode subtraction is pointwise algebra only.  Whether it is useful
inside an annular or spherical integral requires an actual zero-moment theorem.
-/
theorem subtract_constant_identity
    (K : StrainKernelData) (i j k : Fin 3)
    (a c : ℝ) (z : Vec3) :
    strainComponent K i j k z * a =
      strainComponent K i j k z * (a - c) +
      strainComponent K i j k z * c := by
  ring

/--
The ratio (r/rho)^beta is dimensionless at the level of scalar arithmetic;
this marker prevents it from being confused with a length^3 compensation.
No dimensional-analysis theorem is encoded beyond this classification.
-/
inductive StrainKernelMomentStatus
  | kernelComponentOddProved
  | firstMomentIntegrandEvenProved
  | sphericalMeanZeroOpenSignedCancellation
  | annularMeanZeroOpenSignedCancellation
  | firstMomentZeroFromOddnessFalseRoute
  | divOmegaCancellationOpenCZ
  | meanSubtractionArchitectureIsolated
  | campanatoGainDimensionlessOnly
  | rhoStarCubedCompensationNotEstablished
  deriving DecidableEq, Repr

end G1Audit
