/-
WeakDiffusionIBP.lean

Audit-safe H^{-1}-H^1_0 formulation of the weighted diffusion integration by parts.

The important correction in this file is that admissibility of
  eta = phi^2 |omega|_eps (xi_eps - m)
does NOT require the false implication H^1_loc -> W^{1,infty}_loc.
Instead the route uses the special regularized-direction structure:
  |xi_eps| <= 1,
  grad |omega|_eps in L2_loc,
  |omega|_eps grad xi_eps
    = grad omega - xi_eps tensor grad |omega|_eps.
The last two weak-chain/product identities still need their actual Sobolev
realization before A2 is promoted.
-/

import G1.WeakDerivBridge
import G1.VectorLocalRep
import G1.XiEpsPDE

noncomputable section

namespace G1Audit

/-- Square identity for the regularized magnitude. -/
theorem magEps_sq (omega : VectorField) (eps : ℝ) (x : Vec3) :
    (magEps omega eps x) ^ 2 = ‖omega x‖ ^ 2 + eps ^ 2 := by
  unfold magEps
  rw [Real.sq_sqrt]
  positivity

/-- The regularized magnitude dominates the ordinary norm pointwise. -/
theorem norm_le_magEps (omega : VectorField) (eps : ℝ) (x : Vec3) :
    ‖omega x‖ ≤ magEps omega eps x := by
  have hs := magEps_sq omega eps x
  have hm := magEps_nonneg omega eps x
  have hn : 0 ≤ ‖omega x‖ := norm_nonneg _
  nlinarith [sq_nonneg eps]

/-- For eps > 0, the regularized direction has norm at most one. -/
theorem xiEps_norm_le_one
    (omega : VectorField) (eps : ℝ) (heps : 0 < eps) (x : Vec3) :
    ‖xiEps omega eps x‖ ≤ 1 := by
  have hmpos : 0 < magEps omega eps x := magEps_pos omega eps heps x
  have hdom : ‖omega x‖ ≤ magEps omega eps x := norm_le_magEps omega eps x
  calc
    ‖xiEps omega eps x‖
        = (magEps omega eps x)⁻¹ * ‖omega x‖ := by
            simp [xiEps, norm_smul, Real.norm_eq_abs, abs_of_pos hmpos]
    _ ≤ (magEps omega eps x)⁻¹ * magEps omega eps x := by
          exact mul_le_mul_of_nonneg_left hdom (inv_nonneg.mpr (le_of_lt hmpos))
    _ = 1 := by
          exact inv_mul_cancel₀ (ne_of_gt hmpos)

/-- If the spatial mean has norm <= 1, the oscillation is pointwise <= 2. -/
theorem xiEps_sub_mean_norm_le_two
    (omega : VectorField) (eps : ℝ) (heps : 0 < eps)
    (m : Vec3) (hm : ‖m‖ ≤ 1) (x : Vec3) :
    ‖xiEps omega eps x - m‖ ≤ 2 := by
  calc
    ‖xiEps omega eps x - m‖ ≤ ‖xiEps omega eps x‖ + ‖m‖ := norm_sub_le _ _
    _ ≤ 1 + 1 := add_le_add (xiEps_norm_le_one omega eps heps x) hm
    _ = 2 := by norm_num

/--
The weak Sobolev identities needed to turn the structural pointwise bounds into
an H^1 test.  These are deliberately separated from the final IBP theorem.
No W^{1,infty} assumption on |omega|_eps is present.
-/
structure EtaStructuralSobolevData where
  /-- The ball mean m(t); spatially constant at the fixed time slice. -/
  mean : Vec3
  meanNormLeOne : ‖mean‖ ≤ 1

  /-- Abstract L2/local-L2 certificates for the actual weak gradients. -/
  gradOmegaL2Loc : Prop
  gradMagL2Loc : Prop
  weightedGradXiL2Loc : Prop

  /-- Weak chain rule: |grad |omega|_eps| <= |grad omega| a.e. -/
  weakMagChainRule : Prop

  /--
  Weak structural identity
    |omega|_eps grad xi_eps
      = grad omega - xi_eps tensor grad |omega|_eps
  componentwise / a.e. on the time slice.
  -/
  weightedXiGradientIdentity : Prop

/--
Exact three-term gradient decomposition for eta.  This is the target weak
product identity; it is recorded as a proposition until represented using the
actual Sobolev multiplication API rather than assumed inside weightedIBP.
-/
structure EtaGradientDecomposition where
  cutoffTermL2 : Prop
  magnitudeTermL2 : Prop
  weightedXiTermL2 : Prop
  compactSupport : Prop
  weakGradientIdentity : Prop

/--
Once the four structural weak facts are proved, these are precisely the terms
whose L2 control yields eta in H^1 with compact support:

  grad eta
   = 2 phi grad phi |omega|_eps (xi-m)
     + phi^2 grad|omega|_eps (xi-m)
     + phi^2 |omega|_eps grad xi.

The first two use |xi-m| <= 2; the third uses weightedXiGradientIdentity.
Compact support comes entirely from phi.
-/
inductive EtaAdmissibilityRouteStatus
  | xiBoundProved
  | oscillationBoundFromMeanBoundProved
  | meanBoundBochnerJensenOpen
  | weakMagnitudeChainRuleOpen
  | weightedXiGradientIdentityOpen
  | threeTermGradientL2TargetIsolated
  | compactSupportToH10Open
  deriving DecidableEq, Repr

/-- Scalar ledger for one component of the vector H^{-1}-H^1_0 pairing. -/
structure WeightedDualityComponent where
  lapPair : ℝ
  bulk : ℝ
  cutoffCross : ℝ
  weightCross : ℝ

/--
Lower-level interface.  It is intentionally NOT yet an A2 certificate: the
actual Sobolev admissibility, product rule and Green formula are independent
obligations and remain visible.
-/
structure WeightedDualityInterface (d : WeightedDualityComponent) where
  testAdmissible : Prop
  greenIdentity : d.lapPair = -(d.bulk + d.cutoffCross + d.weightCross)
  productRuleExpansion : Prop

/-- Algebraic last step only; this does not promote A2. -/
theorem weightedIBP_component
    (d : WeightedDualityComponent) (h : WeightedDualityInterface d) :
    d.lapPair = -d.bulk - d.cutoffCross - d.weightCross := by
  calc
    d.lapPair = -(d.bulk + d.cutoffCross + d.weightCross) := h.greenIdentity
    _ = -d.bulk - d.cutoffCross - d.weightCross := by ring

structure WeightedDualityVector where
  component : Fin 3 → WeightedDualityComponent

structure WeightedDualityVectorInterface (d : WeightedDualityVector) where
  componentInterface : ∀ i, WeightedDualityInterface (d.component i)

theorem weightedIBP_vector_component
    (d : WeightedDualityVector) (h : WeightedDualityVectorInterface d) (i : Fin 3) :
    (d.component i).lapPair =
      -(d.component i).bulk - (d.component i).cutoffCross - (d.component i).weightCross :=
  weightedIBP_component (d.component i) (h.componentInterface i)

/--
Exact weight convention:
  w = phi^2 |omega|_eps,
  grad w = 2 phi |omega|_eps grad phi + phi^2 grad |omega|_eps.
There is no division by |omega|_eps in weightCross.  A logarithmic rewrite is
valid only with the outside |omega|_eps retained.
-/
inductive WeightConventionStatus
  | directGradientWeightCorrect
  | logarithmicFormRequiresOutsideMagnitude
  | extraMagnitudeDenominatorForbidden
  deriving DecidableEq, Repr

/-- A2 is deliberately not promoted before the Sobolev facts above are realized. -/
inductive WeakDiffusionDualityStatus
  | hminusOneH10ArchitectureFormalized
  | firstDerivativeL2Available
  | structuralEtaRouteFormalized
  | testAdmissibilityOpen
  | weightedProductRuleOpen
  | greenFormulaOpen
  | weakIBPNotPromoted
  deriving DecidableEq, Repr

end G1Audit
