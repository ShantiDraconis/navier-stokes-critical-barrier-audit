/-
SeparatedSpatialWeakDerivativeIdentity.lean

Audit-safe countable-family passage for the 4D -> 3D weak spatial derivative
reduction.  This file deliberately stops before asserting density of a chosen
test sequence or fixed-time H^1_x.  It proves the legitimate quantifier move
for an arbitrary countable family once the fixed-test du Bois-Reymond
hypotheses are available.
-/

import G1.WeakOmegaSpatialSlice

noncomputable section

open MeasureTheory

namespace G1Audit

/-- For a countable family of spatial tests, each fixed-test a.e. identity can
be intersected to obtain one common full-measure set.  No density assumption is
used here. -/
theorem WeakOmegaSpaceTime.spatialDerivative_testSeq_ae_common
    (h : WeakOmegaSpaceTime)
    (i k : Fin 3)
    (psi dpsi : ℕ → Vec3 → ℂ)
    (hlocal : ∀ n,
      LocallyIntegrable
        (spatialWeakResidual (h.omegaProd i) (h.weakDxProd i k) (psi n) (dpsi n))
        (volume : Measure ℝ))
    (hsep : ∀ n,
      SeparatedSpatialWeakDerivativeIdentity
        (h.omegaProd i) (h.weakDxProd i k) (psi n) (dpsi n)) :
    ∀ᵐ t ∂(volume : Measure ℝ), ∀ n,
      spatialWeakResidual
        (h.omegaProd i) (h.weakDxProd i k) (psi n) (dpsi n) t = 0 := by
  apply ae_all_iff.2
  intro n
  exact h.spatialDerivative_test_ae i k (psi n) (dpsi n) (hlocal n) (hsep n)

/-- Explicit common-full-set formulation of the preceding a.e. theorem. -/
def spatialDerivativeCommonFullSet
    (h : WeakOmegaSpaceTime)
    (i k : Fin 3)
    (psi dpsi : ℕ → Vec3 → ℂ) : Set ℝ :=
  {t | ∀ n,
    spatialWeakResidual
      (h.omegaProd i) (h.weakDxProd i k) (psi n) (dpsi n) t = 0}

theorem WeakOmegaSpaceTime.spatialDerivativeCommonFullSet_compl_null
    (h : WeakOmegaSpaceTime)
    (i k : Fin 3)
    (psi dpsi : ℕ → Vec3 → ℂ)
    (hlocal : ∀ n,
      LocallyIntegrable
        (spatialWeakResidual (h.omegaProd i) (h.weakDxProd i k) (psi n) (dpsi n))
        (volume : Measure ℝ))
    (hsep : ∀ n,
      SeparatedSpatialWeakDerivativeIdentity
        (h.omegaProd i) (h.weakDxProd i k) (psi n) (dpsi n)) :
    (volume : Measure ℝ)
      (spatialDerivativeCommonFullSet h i k psi dpsi)ᶜ = 0 := by
  rw [← ae_iff]
  simpa [spatialDerivativeCommonFullSet] using
    h.spatialDerivative_testSeq_ae_common i k psi dpsi hlocal hsep

/-- Audit ledger: the countable intersection is proved, while the construction
of an H^1-dense countable test family and extension by continuity remain the
next genuine obligations. -/
inductive SeparatedSpatialWeakDerivativeStatus
  | fixedTestDuBoisReymondAvailable
  | countableFamilyCommonAEProved
  | explicitCommonFullSetProved
  | denseH1TestFamilyOpen
  | residualH1ContinuityOpen
  | denseToAllTestsOpen
  | fixedTimeH1Open
  | omegaEpsBridgeOpen
  | regularizedChainRuleOpen
  | weightedGradIdentityOpen
  deriving DecidableEq, Repr

end G1Audit
