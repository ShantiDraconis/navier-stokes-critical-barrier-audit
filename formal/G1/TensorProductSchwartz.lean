/-
TensorProductSchwartz.lean

Audit-safe tensor-product test functions for the 4D -> (time x space)
slicing bridge.  This file constructs the exact compactly supported smooth
product test on R x R^3 and transports it to SpaceTime through the already
formalized coordinate homeomorphism.  It does not promote fixed-time H1,
chain rules, Green identities, A2, or DynamicCampanato.
-/

import G1.SpaceTimeIntegralTransport
import Mathlib.Analysis.Distribution.SchwartzSpace.Deriv
import Mathlib.Analysis.Normed.Lp.ProdLp
import Mathlib.Topology.Algebra.Support

noncomputable section

open MeasureTheory Module WithLp Set
open scoped LineDeriv SchwartzMap

namespace G1Audit

/-- Raw tensor product on the genuine product space R x R^3. -/
def tensorProductRaw (alpha : ℝ → ℝ) (psi : Vec3 → ℂ) : ProductSpaceTime → ℂ :=
  fun z => (alpha z.1 : ℂ) * psi z.2

/-- Smoothness of the tensor product follows from projections and multiplication. -/
theorem tensorProductRaw_contDiff
    {alpha : ℝ → ℝ} {psi : Vec3 → ℂ}
    (halpha : ContDiff ℝ ⊤ alpha) (hpsi : ContDiff ℝ ⊤ psi) :
    ContDiff ℝ ⊤ (tensorProductRaw alpha psi) := by
  fun_prop

/-- The pointwise support is contained in support(alpha) x support(psi). -/
theorem support_tensorProductRaw_subset
    (alpha : ℝ → ℝ) (psi : Vec3 → ℂ) :
    Function.support (tensorProductRaw alpha psi) ⊆
      Function.support alpha ×ˢ Function.support psi := by
  intro z hz
  constructor
  · intro hzero
    apply hz
    simp [tensorProductRaw, hzero]
  · intro hzero
    apply hz
    simp [tensorProductRaw, hzero]

/-- Compact support of both factors gives compact support of the product test. -/
theorem tensorProductRaw_hasCompactSupport
    {alpha : ℝ → ℝ} {psi : Vec3 → ℂ}
    (halpha : HasCompactSupport alpha) (hpsi : HasCompactSupport psi) :
    HasCompactSupport (tensorProductRaw alpha psi) := by
  rw [hasCompactSupport_def] at halpha hpsi ⊢
  refine IsCompact.of_isClosed_subset (halpha.prod hpsi)
    (isClosed_tsupport (tensorProductRaw alpha psi)) ?_
  intro z hz
  have hz' :
      z ∈ closure (Function.support alpha ×ˢ Function.support psi) :=
    closure_mono (support_tensorProductRaw_subset alpha psi) hz
  simpa only [tsupport, closure_prod_eq] using hz'

/-- The actual Schwartz test on R x R^3. -/
def productTensorSchwartz
    (alpha : ℝ → ℝ) (psi : Vec3 → ℂ)
    (halphaSmooth : ContDiff ℝ ⊤ alpha)
    (halphaCompact : HasCompactSupport alpha)
    (hpsiSmooth : ContDiff ℝ ⊤ psi)
    (hpsiCompact : HasCompactSupport psi) : 𝓢(ProductSpaceTime, ℂ) :=
  (tensorProductRaw_hasCompactSupport halphaCompact hpsiCompact).toSchwartzMap
    (tensorProductRaw_contDiff halphaSmooth hpsiSmooth)

@[simp]
theorem productTensorSchwartz_apply
    (alpha : ℝ → ℝ) (psi : Vec3 → ℂ)
    (halphaSmooth : ContDiff ℝ ⊤ alpha)
    (halphaCompact : HasCompactSupport alpha)
    (hpsiSmooth : ContDiff ℝ ⊤ psi)
    (hpsiCompact : HasCompactSupport psi)
    (z : ProductSpaceTime) :
    productTensorSchwartz alpha psi halphaSmooth halphaCompact hpsiSmooth hpsiCompact z =
      (alpha z.1 : ℂ) * psi z.2 := by
  rfl

/-- Topological equivalence underlying the already-used coordinate split. -/
def spaceTimeProductHomeomorph : SpaceTime ≃ₜ ProductSpaceTime :=
  spaceTimeSplitL2.toHomeomorph.trans
    (WithLp.uniformEquivProd (p := (2 : ℝ≥0∞)) (α := ℝ) (β := Vec3)).toHomeomorph

@[simp]
theorem spaceTimeProductHomeomorph_apply (z : SpaceTime) :
    spaceTimeProductHomeomorph z = spaceTimeToProduct z := by
  rfl

@[simp]
theorem spaceTimeProductHomeomorph_symm_apply (z : ProductSpaceTime) :
    spaceTimeProductHomeomorph.symm z = productToSpaceTime z := by
  rfl

/-- Raw SpaceTime tensor product Phi_{alpha,psi}(z)=alpha(t) psi(x). -/
def spaceTimeTensorRaw (alpha : ℝ → ℝ) (psi : Vec3 → ℂ) : SpaceTime → ℂ :=
  tensorProductRaw alpha psi ∘ spaceTimeToProduct

/-- The transported tensor product remains compactly supported. -/
theorem spaceTimeTensorRaw_hasCompactSupport
    {alpha : ℝ → ℝ} {psi : Vec3 → ℂ}
    (halpha : HasCompactSupport alpha) (hpsi : HasCompactSupport psi) :
    HasCompactSupport (spaceTimeTensorRaw alpha psi) := by
  have hprod := tensorProductRaw_hasCompactSupport halpha hpsi
  simpa only [spaceTimeTensorRaw, spaceTimeProductHomeomorph_apply, Function.comp_def] using
    hprod.comp_homeomorph spaceTimeProductHomeomorph

/-- The transported tensor product is C-infinity on SpaceTime. -/
theorem spaceTimeTensorRaw_contDiff
    {alpha : ℝ → ℝ} {psi : Vec3 → ℂ}
    (halpha : ContDiff ℝ ⊤ alpha) (hpsi : ContDiff ℝ ⊤ psi) :
    ContDiff ℝ ⊤ (spaceTimeTensorRaw alpha psi) := by
  have hprod := tensorProductRaw_contDiff halpha hpsi
  exact hprod.comp spaceTimeSplitL2.contDiff

/-- Exact Schwartz test used by the 4D distributional pairing. -/
def spaceTimeTensorSchwartz
    (alpha : ℝ → ℝ) (psi : Vec3 → ℂ)
    (halphaSmooth : ContDiff ℝ ⊤ alpha)
    (halphaCompact : HasCompactSupport alpha)
    (hpsiSmooth : ContDiff ℝ ⊤ psi)
    (hpsiCompact : HasCompactSupport psi) : 𝓢(SpaceTime, ℂ) :=
  (spaceTimeTensorRaw_hasCompactSupport halphaCompact hpsiCompact).toSchwartzMap
    (spaceTimeTensorRaw_contDiff halphaSmooth hpsiSmooth)

@[simp]
theorem spaceTimeTensorSchwartz_apply
    (alpha : ℝ → ℝ) (psi : Vec3 → ℂ)
    (halphaSmooth : ContDiff ℝ ⊤ alpha)
    (halphaCompact : HasCompactSupport alpha)
    (hpsiSmooth : ContDiff ℝ ⊤ psi)
    (hpsiCompact : HasCompactSupport psi)
    (z : SpaceTime) :
    spaceTimeTensorSchwartz alpha psi halphaSmooth halphaCompact hpsiSmooth hpsiCompact z =
      (alpha (spaceTimeToProduct z).1 : ℂ) * psi (spaceTimeToProduct z).2 := by
  rfl

inductive TensorProductSchwartzStatus
  | productSmoothProved
  | productCompactSupportProved
  | productSchwartzConstructed
  | spaceTimeHomeomorphConstructed
  | spaceTimeSchwartzConstructed
  | spatialDerivativeFormulaNext
  | separatedProductPairingNotYetPromoted
  deriving DecidableEq, Repr

end G1Audit
