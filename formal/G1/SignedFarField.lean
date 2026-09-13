/-
SignedFarField.lean

Preparatory signed far-field architecture.  This file keeps the vorticity
weight inside the double integral and deliberately does not pass through an
L-infinity estimate for S^far.
-/

import G1.StrainKernel

noncomputable section

open MeasureTheory Metric

namespace G1Audit

abbrev ScalarField3 := Vec3 → ℝ
abbrev VectorField3 := Vec3 → Vec3

/-- Geometric data for the far-field cutoff R = K rho. -/
structure FarFieldGeometry where
  K : ℝ
  rho : ℝ
  R : ℝ
  hK : 1 < K
  hrho : 0 < rho
  hR : R = K * rho

/-- Indicator of the far region |x-y| >= R. -/
def farIndicator (R : ℝ) (x y : Vec3) : ℝ :=
  if R ≤ ‖x - y‖ then 1 else 0

/--
A signed scalar contraction of the tensor kernel with the two direction fields.
The concrete contraction is intentionally supplied separately from the singular
integral theory; this prevents an unverified formula from being baked in.
-/
abbrev SignedDirectionContraction :=
  StrainKernelData → Vec3 → Vec3 → Vec3 → ℝ

/-- Pointwise integrand of the direct weighted far-field route. -/
def signedFarIntegrand
    (Kdata : StrainKernelData)
    (D : SignedDirectionContraction)
    (geom : FarFieldGeometry)
    (xi omega : VectorField3) (mag phi : ScalarField3)
    (x y : Vec3) : ℝ :=
  farIndicator geom.R x y *
    D Kdata (x - y) (xi x) (xi y) *
    mag x * mag y * (phi x)^2

/-- The signed far-field bilinear form, as an iterated Lebesgue integral. -/
def signedFarField
    (Kdata : StrainKernelData)
    (D : SignedDirectionContraction)
    (geom : FarFieldGeometry)
    (xi omega : VectorField3) (mag phi : ScalarField3) : ℝ :=
  ∫ x, ∫ y,
    signedFarIntegrand Kdata D geom xi omega mag phi x y
      ∂(volume : Measure Vec3)
    ∂(volume : Measure Vec3)

/-- Explicit Fubini/Tonelli prerequisites; no theorem is inferred from them. -/
structure SignedFarFieldFubiniData
    (Kdata : StrainKernelData)
    (D : SignedDirectionContraction)
    (geom : FarFieldGeometry)
    (xi omega : VectorField3) (mag phi : ScalarField3) where
  integrableDouble :
    Integrable (fun p : Vec3 × Vec3 =>
      signedFarIntegrand Kdata D geom xi omega mag phi p.1 p.2)

/--
Target inequality for the direct weighted bilinear route.  This is a target
record, not a proof object used downstream: `established` is intentionally absent.
-/
structure DirectWeightedFarFieldTarget where
  farValue : ℝ
  gamma : ℝ
  nu : ℝ
  diffusionBulk : ℝ
  Ckappa : ℝ
  gradUSq : ℝ
  Jr : ℝ
  remainder : ℝ
  hnu : 0 < nu
  hgammaNonneg : 0 ≤ gamma
  hgammaHalf : gamma < (1 : ℝ) / 2
  hDiffusionNonneg : 0 ≤ diffusionBulk
  hGradUNonneg : 0 ≤ gradUSq
  hJNonneg : 0 ≤ Jr
  /-- Desired estimate, recorded as a proposition to investigate, not assumed. -/
  targetStatement : Prop
  hTargetShape : targetStatement =
    (|farValue| ≤ gamma * nu * diffusionBulk + Ckappa * gradUSq * Jr + remainder)

/-- Audit classification for this preparatory layer. -/
inductive SignedFarFieldStatus
  | nearFarDomainDefined
  | signedIntegrandDefined
  | fubiniPrerequisitesExplicit
  | pointwiseLinfRouteBlockingScaling
  | directWeightedBilinearTargetIsolated
  | directWeightedBilinearNotProved
  deriving DecidableEq, Repr

end G1Audit
