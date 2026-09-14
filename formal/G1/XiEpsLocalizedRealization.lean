/-
XiEpsLocalizedRealization.lean

Localized analytic realization for XiEpsPDE.

The final LocalEnergyIdentityData.identity is never assumed.  The concrete
pointwise XiEpsPDE is paired with the real localized Bochner test field, and the
resulting full-RHS pairing is a theorem.  The only remaining analytic input at
the diffusion layer is the exact weak integration-by-parts identity; it is
recorded at integral level rather than as the final scalar energy identity.

Important audit status: Mathlib supplies Bochner integration, gradients and
parametric-integral machinery, but this repository does not yet contain a full
Sobolev realization of the vector-valued whole-space divergence theorem needed
to prove the weighted weak IBP below from first principles.  Therefore the file
does NOT pretend that this lower-level lemma is already proved.
-/

import G1.XiEpsPDE
import G1.DynamicCampanato

noncomputable section

open MeasureTheory Metric

namespace G1Audit

/-! ## Concrete spatial integration and localization -/

def spatialIntegralScalar (f : ScalarField) : ℝ :=
  ∫ x, f x ∂(volume : Measure Vec3)

def spatialIntegralVector (f : VectorField) : Vec3 :=
  ∫ x, f x ∂(volume : Measure Vec3)

/-- Real Bochner/Lebesgue pairing on R^3. -/
def bochnerPair (v w : VectorField) : ℝ :=
  spatialIntegralScalar (fun x => inner ℝ (v x) (w x))

/-- Volume of B_r(c), represented as a real number. -/
def ballVolume (r : ℝ) (c : Vec3) : ℝ :=
  (volume (Metric.ball c r)).toReal

def ballIntegralVector (r : ℝ) (c : Vec3) (f : VectorField) : Vec3 :=
  ∫ x in Metric.ball c r, f x ∂(volume : Measure Vec3)

/-- Ball average; the positive-radius realization must discharge nonzero volume. -/
def avgBallVector (r : ℝ) (c : Vec3) (f : VectorField) : Vec3 :=
  (ballVolume r c)⁻¹ • ballIntegralVector r c f

/-- Weighted scalar integral with localization weight phi^2 |omega|_eps. -/
def weightedXiIntegral
    (phi mag : ScalarField) (F : ScalarField) : ℝ :=
  spatialIntegralScalar (fun x => (phi x)^2 * mag x * F x)

structure LocalizedCutoff where
  phi : ScalarField
  K : ℝ
  rho : ℝ
  R : ℝ
  gradScale : ℝ
  lapScale : ℝ
  hK_pos : 0 < K
  hrho_pos : 0 < rho
  hR : R = K * rho
  hgradScale : gradScale = R⁻¹
  hlapScale : lapScale = (R⁻¹)^2

theorem LocalizedCutoff.grad_rho_power (c : LocalizedCutoff) :
    c.gradScale = (c.K * c.rho)⁻¹ := by
  rw [c.hgradScale, c.hR]

theorem LocalizedCutoff.lap_rho_power (c : LocalizedCutoff) :
    c.lapScale = ((c.K * c.rho)⁻¹)^2 := by
  rw [c.hlapScale, c.hR]

/-- The exact test field phi^2 (xi_eps-(xi_eps)_{B_r}) |omega|_eps. -/
def localizedTestField
    (h : XiEpsPDE) (phi : ScalarField) (r : ℝ) (c : Vec3) : VectorField :=
  fun x =>
    ((phi x)^2 * magEps h.omegaEps h.ε x) •
      (h.xi x - avgBallVector r c h.xi)

/-! ## Concrete pairing of the pointwise XiEpsPDE -/

/-- Full right-hand side of XiEpsPDE as one vector field. -/
def XiEpsPDE.rhs (h : XiEpsPDE) : VectorField :=
  fun x =>
    h.projectedStretch x
      + h.ν • h.lapXi x
      + (2 * h.ν) • h.logGradDotGradXi x
      + h.R1 x + h.R2 x

/-- The pointwise equation identifies DtXi and the full RHS as fields. -/
theorem XiEpsPDE.DtXi_eq_rhs (h : XiEpsPDE) :
    h.DtXi = h.rhs := by
  funext x
  exact h.equation x

/--
Actual Bochner pairing of XiEpsPDE with any vector test field.  This theorem is
obtained by rewriting the pointwise PDE; no scalar `testedEquation` assumption
is used.
-/
theorem XiEpsPDE.bochnerPair_equation
    (h : XiEpsPDE) (test : VectorField) :
    bochnerPair h.DtXi test = bochnerPair h.rhs test := by
  rw [h.DtXi_eq_rhs]

/-! ## Differential / weak-IBP layer -/

/--
Operators needed for the eventual Sobolev realization.  The present XiEpsPDE
still stores DtXi/lapXi as fields; these operators expose the exact next
refactoring target rather than silently identifying them with weak derivatives.
-/
structure DifferentialOperators where
  timeDerivScalar : ScalarField → ScalarField
  gradScalar : ScalarField → VectorField
  laplacianVector : VectorField → VectorField

/--
Exact integral-level weak integration by parts for the localized Laplacian term.

Analytically this represents

  ∫ phi^2 <Delta xi_eps, xi_eps-mean> |omega_eps|
    = - ∫ phi^2 |grad xi_eps|^2 |omega_eps|
      - (cutoff cross)
      - (grad |omega|_eps cross).

Equivalently it is the expansion of

  -∫ div(phi^2 |omega_eps| grad xi_eps) · (xi_eps-mean).

This is deliberately the smallest remaining OPEN_ANALYTIC_LEMMA.  It is not the
final LocalEnergyIdentity and contains no CZ/Young/Campanato estimate.
-/
structure WeakDiffusionIBP where
  pde : XiEpsPDE
  test : VectorField
  laplacianPair : ℝ
  diffusionBulk : ℝ
  diffusionCutoffCross : ℝ
  diffusionWeightCross : ℝ
  hLaplacianPair : laplacianPair = bochnerPair pde.lapXi test
  weakIBP :
    bochnerPair pde.lapXi test =
      -diffusionBulk - diffusionCutoffCross - diffusionWeightCross

/-! ## Real signed strain split -/

abbrev StrainKernel := Vec3 → Vec3 → ℝ

structure StrainSplit where
  kernelTotal : StrainKernel
  kernelNear : StrainKernel
  kernelFar : StrainKernel
  K : ℝ
  rho : ℝ
  R : ℝ
  hK_pos : 0 < K
  hrho_pos : 0 < rho
  hR : R = K * rho
  hSplit : ∀ x y, kernelTotal x y = kernelNear x y + kernelFar x y
  hNearSupport : ∀ x y, R ≤ ‖x - y‖ → kernelNear x y = 0
  hFarSupport : ∀ x y, ‖x - y‖ < R → kernelFar x y = 0

structure StrainPairing where
  total : ℝ
  near : ℝ
  far : ℝ
  hPairSplit : total = near + far

/-! ## Localized scalar ledger after the concrete PDE pairing -/

structure XiEpsLocalizedTerms where
  r : ℝ
  rho : ℝ
  K : ℝ
  R : ℝ
  ballVolume : ℝ
  timeEnergyDerivative : ℝ
  timeWeightAndMean : ℝ
  transport : ℝ
  stretchTotal : ℝ
  stretchNear : ℝ
  stretchFar : ℝ
  laplacianPair : ℝ
  diffusionBulk : ℝ
  diffusionCutoffCross : ℝ
  diffusionWeightCross : ℝ
  /-- Includes the coefficient 2 from the log-drift term. -/
  logDrift : ℝ
  R1Pair : ℝ
  R2Pair : ℝ
  hr_pos : 0 < r
  hrho_pos : 0 < rho
  hK_pos : 0 < K
  hR : R = K * rho
  hballVolume_pos : 0 < ballVolume

/--
Localized realization.  `testedEquation` has been removed.  Instead:

* `pdePairing` is the proved Bochner pairing theorem from XiEpsPDE;
* `pairingExpansion` is the integrability/linearity bookkeeping that identifies
  the Bochner full-RHS pairing with the scalar term ledger;
* `weakIBP` is the exact lower-level Sobolev/divergence obligation.
-/
structure XiEpsLocalizedRealization where
  pde : XiEpsPDE
  center : Vec3
  diffOps : DifferentialOperators
  cutoff : LocalizedCutoff
  split : StrainSplit
  pairing : StrainPairing
  ibp : WeakDiffusionIBP
  terms : XiEpsLocalizedTerms

  hCutoffR : cutoff.R = terms.R
  hCutoffK : cutoff.K = terms.K
  hCutoffRho : cutoff.rho = terms.rho
  hSplitR : split.R = terms.R
  hSplitK : split.K = terms.K
  hSplitRho : split.rho = terms.rho

  hIBPPDE : ibp.pde = pde
  hIBPTest : ibp.test = localizedTestField pde cutoff.phi terms.r center

  hStretchTotal : terms.stretchTotal = pairing.total
  hStretchNear : terms.stretchNear = pairing.near
  hStretchFar : terms.stretchFar = pairing.far
  hPairingSplit : pairing.total = pairing.near + pairing.far

  hLaplacianPair : terms.laplacianPair = ibp.laplacianPair
  hDiffusionBulk : terms.diffusionBulk = ibp.diffusionBulk
  hDiffusionCutoff : terms.diffusionCutoffCross = ibp.diffusionCutoffCross
  hDiffusionWeight : terms.diffusionWeightCross = ibp.diffusionWeightCross

  /--
  Expansion of the *proved* full-RHS Bochner pairing into the named scalar
  integrals.  This is only linearity/integrability bookkeeping, not the PDE.
  -/
  pairingExpansion :
    bochnerPair pde.rhs (localizedTestField pde cutoff.phi terms.r center) =
      terms.stretchTotal
        + pde.ν * terms.laplacianPair
        + pde.ν * terms.logDrift
        + terms.R1Pair + terms.R2Pair

  /--
  Identification of the actual DtXi pairing with the temporal/transport ledger.
  This is the differentiation-under-the-integral/material-derivative bookkeeping.
  -/
  lhsPairingExpansion :
    bochnerPair pde.DtXi (localizedTestField pde cutoff.phi terms.r center) =
      terms.timeEnergyDerivative + terms.timeWeightAndMean + terms.transport

/-- Signed near/far decomposition, with no estimate. -/
theorem XiEpsLocalizedRealization.strainSplitPair
    (h : XiEpsLocalizedRealization) :
    h.terms.stretchTotal = h.terms.stretchNear + h.terms.stretchFar := by
  rw [h.hStretchTotal, h.hStretchNear, h.hStretchFar]
  exact h.hPairingSplit

/-- Recover the exact diffusion IBP in the term ledger. -/
theorem XiEpsLocalizedRealization.diffusionIBP
    (h : XiEpsLocalizedRealization) :
    h.terms.laplacianPair =
      -h.terms.diffusionBulk
        - h.terms.diffusionCutoffCross
        - h.terms.diffusionWeightCross := by
  rw [h.hLaplacianPair, h.hDiffusionBulk, h.hDiffusionCutoff, h.hDiffusionWeight]
  calc
    h.ibp.laplacianPair = bochnerPair h.ibp.pde.lapXi h.ibp.test := h.ibp.hLaplacianPair
    _ = bochnerPair h.pde.lapXi
          (localizedTestField h.pde h.cutoff.phi h.terms.r h.center) := by
          rw [h.hIBPPDE, h.hIBPTest]
    _ = -h.ibp.diffusionBulk - h.ibp.diffusionCutoffCross - h.ibp.diffusionWeightCross := by
          simpa [h.hIBPPDE, h.hIBPTest] using h.ibp.weakIBP

/--
The scalar tested equation is now derived from the concrete Bochner pairing of
the pointwise XiEpsPDE plus the two bookkeeping expansions.
-/
theorem XiEpsLocalizedRealization.testedEquation
    (h : XiEpsLocalizedRealization) :
    h.terms.timeEnergyDerivative + h.terms.timeWeightAndMean + h.terms.transport =
      h.terms.stretchTotal
        + h.pde.ν * h.terms.laplacianPair
        + h.pde.ν * h.terms.logDrift
        + h.terms.R1Pair + h.terms.R2Pair := by
  calc
    h.terms.timeEnergyDerivative + h.terms.timeWeightAndMean + h.terms.transport =
        bochnerPair h.pde.DtXi
          (localizedTestField h.pde h.cutoff.phi h.terms.r h.center) := by
          symm
          exact h.lhsPairingExpansion
    _ = bochnerPair h.pde.rhs
          (localizedTestField h.pde h.cutoff.phi h.terms.r h.center) :=
          h.pde.bochnerPair_equation _
    _ = h.terms.stretchTotal
          + h.pde.ν * h.terms.laplacianPair
          + h.pde.ν * h.terms.logDrift
          + h.terms.R1Pair + h.terms.R2Pair := h.pairingExpansion

/-- Final localized identity, with no CZ or Young estimate. -/
theorem XiEpsLocalizedRealization.localized_identity
    (h : XiEpsLocalizedRealization) :
    h.terms.timeEnergyDerivative
        + h.terms.timeWeightAndMean
        + h.terms.transport
        + h.pde.ν * h.terms.diffusionBulk =
      h.terms.stretchNear + h.terms.stretchFar
        - h.pde.ν * h.terms.diffusionCutoffCross
        - h.pde.ν * h.terms.diffusionWeightCross
        + h.pde.ν * h.terms.logDrift
        + h.terms.R1Pair + h.terms.R2Pair := by
  have htested := h.testedEquation
  have hsplit := h.strainSplitPair
  have hibp := h.diffusionIBP
  rw [hsplit] at htested
  rw [hibp] at htested
  linarith

/-- Exact scalar data exported by the localized identity. -/
structure LocalEnergyIdentityData where
  r : ℝ
  rho : ℝ
  K : ℝ
  R : ℝ
  ballVolume : ℝ
  nu : ℝ
  timeEnergyDerivative : ℝ
  timeWeightAndMean : ℝ
  transport : ℝ
  stretchNear : ℝ
  stretchFar : ℝ
  diffusionBulk : ℝ
  diffusionCutoffCross : ℝ
  diffusionWeightCross : ℝ
  logDrift : ℝ
  R1 : ℝ
  R2 : ℝ
  hr_pos : 0 < r
  hrho_pos : 0 < rho
  hK_pos : 0 < K
  hnu_pos : 0 < nu
  hR : R = K * rho
  hballVolume_pos : 0 < ballVolume
  identity :
    timeEnergyDerivative + timeWeightAndMean + transport + nu * diffusionBulk =
      stretchNear + stretchFar
        - nu * diffusionCutoffCross
        - nu * diffusionWeightCross
        + nu * logDrift + R1 + R2

/-- Proposition exposed for downstream audit code. -/
def LocalEnergyIdentity (d : LocalEnergyIdentityData) : Prop :=
  d.timeEnergyDerivative + d.timeWeightAndMean + d.transport + d.nu * d.diffusionBulk =
    d.stretchNear + d.stretchFar
      - d.nu * d.diffusionCutoffCross
      - d.nu * d.diffusionWeightCross
      + d.nu * d.logDrift + d.R1 + d.R2

def LocalEnergyIdentityData.ofXiEpsPDE
    (h : XiEpsLocalizedRealization) : LocalEnergyIdentityData where
  r := h.terms.r
  rho := h.terms.rho
  K := h.terms.K
  R := h.terms.R
  ballVolume := h.terms.ballVolume
  nu := h.pde.ν
  timeEnergyDerivative := h.terms.timeEnergyDerivative
  timeWeightAndMean := h.terms.timeWeightAndMean
  transport := h.terms.transport
  stretchNear := h.terms.stretchNear
  stretchFar := h.terms.stretchFar
  diffusionBulk := h.terms.diffusionBulk
  diffusionCutoffCross := h.terms.diffusionCutoffCross
  diffusionWeightCross := h.terms.diffusionWeightCross
  logDrift := h.terms.logDrift
  R1 := h.terms.R1Pair
  R2 := h.terms.R2Pair
  hr_pos := h.terms.hr_pos
  hrho_pos := h.terms.hrho_pos
  hK_pos := h.terms.hK_pos
  hnu_pos := h.pde.hν
  hR := h.terms.hR
  hballVolume_pos := h.terms.hballVolume_pos
  identity := h.localized_identity

theorem LocalEnergyIdentityData.ofXiEpsPDE_identity
    (h : XiEpsLocalizedRealization) :
    LocalEnergyIdentity (LocalEnergyIdentityData.ofXiEpsPDE h) := by
  exact (LocalEnergyIdentityData.ofXiEpsPDE h).identity

/-! ## Far-field obstruction and missing geometric bridge -/

structure FarFieldCampanatoExponentLedger where
  beta : ℝ
  hbeta_zero : beta = 0

structure GeometricNonDegeneracy where
  rho : ℝ
  kappa : ℝ
  effectiveVolume : ℝ
  hrho_pos : 0 < rho
  hkappa_pos : 0 < kappa
  hVolume_nonneg : 0 ≤ effectiveVolume
  volume_lower_bound : kappa * rho^3 ≤ effectiveVolume

inductive XiEpsLocalizedStatus
  | pointwisePDEPairingProved
  | openWeakSobolevIBP
  | openTimePairingExpansion
  | openSignedFarField
  | openGeometricNonDegeneracy
  | blockingScaling
  deriving DecidableEq, Repr

end G1Audit
