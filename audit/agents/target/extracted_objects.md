# Target Extraction — openai/NavierStokesAndEuler

**Agent:** target-extractor  
**Run date:** 2026-09-11  
**Target repository:** `openai/NavierStokesAndEuler`  
**Target HEAD commit:** `f9e8bc5b38b6e212696e8a30e3e91517af887bbd`  
**Temporal cutoff:** `2026-09-08T00:00:00Z`

This document records every substantive mathematical object identified in the
target repository.  Objects are labelled `OPENAI-NS-NN` (Navier–Stokes) or
`OPENAI-EU-NN` (Euler).  No priority conclusion is drawn here; that is the
task of a downstream agent.

---

## NAVIER–STOKES OBJECTS

---

### OPENAI-NS-01 — Forced Navier–Stokes PDE (viscosity-one form)

**Target file:** `NavierStokes/ProblemStatement.lean`  
**Target SHA (blob):** `f58563f682784537e1988552e5fb209210ea8300`  
**Key declarations:**

```
navierStokesResidual u p t x :=
    temporalDerivative u t x
  + advection u t x
  - spatialLaplacian u t x
  + pressureGradient p t x
```

**Normalized formula:**

```
∂_t u + (u·∇)u − Δu + ∇p = f
```

with `u : ℝ × ℝ³ → ℝ³`, `p : ℝ × ℝ³ → ℝ`, `f` smooth, periodic in space with
unit periods, `u(0,·) = 0`, `div u = 0`, and speed unbounded as `t → 1⁻`.

**Structural notes:**

- `CandidateProperties` packages the entire set of regularity, periodicity,
  divergence-free, PDE, initial-value, and blow-up conditions.
- `candidateStatement` is the existential proposition; it is NOT an axiom and
  is NOT proved in this file.
- `ContDiffOn ℝ ∞` smoothness; `⊤` (analytic) is explicitly not used.
- Incompressibility enforced by `spatialDivergence u t x = 0`.

---

### OPENAI-NS-02 — Riesz pressure operator / Poisson identity

**Target file:** `NavierStokes/R3PressureFourier.lean`  
**Target SHA (blob):** `950fe135d4e891c14d3e82f553b7731fc3eafda3`  
**Key declarations:**

```
rieszSymbol i j x := -(x i * x j) / ‖x‖²
pressureL1 i j f := 𝓕⁻(rieszSymbol i j · * 𝓕 f)
pressureL1_poisson: Δ(pressureL1 i j f) = -∂_{eᵢ}(∂_{eⱼ} f)
stressPressure g := ∑ᵢ ∑ⱼ pressureL1 i j (g i j)
stressPressure_poisson: Δ(stressPressure g) = −∑ᵢ∑ⱼ ∂ᵢ∂ⱼ(gᵢⱼ)
```

**Normalized formula:**

```
p = R_i R_j(u_i u_j)
−Δp = ∂_i ∂_j (u_i u_j)
```

Additional: space-time version in `NavierStokes/R3SpaceTimePressure.lean`
(SHA `93974fbff50f228c98fda504266efa14ca8383de`).

**Structural notes:**

- Riesz symbol proven bounded `‖R_{ij} ξ‖ ≤ 1`.
- `pressureL2` defined separately for L² data with contraction bound.
- `pressureL1_eq_pressureL2` proves L¹/L² consistency.
- Pressure gradient uniqueness in negative Sobolev class.

---

### OPENAI-NS-03 — Maximal classical lifespan and admissible lifespans

**Target file:** `NavierStokes/MaximalLifespan.lean`  
**Target SHA (blob):** `83968db431a7327110e9ea10c6196dc3e39d5323`  
**Key declarations:**

```
ClassicalSolution f u₀ T u p    -- full smoothness + periodicity + PDE on [0,T)
IsMaximalClassicalSolution f u₀ T u p :=
    ClassicalSolution ... ∧ ¬HasClassicalExtension ...
admissibleLifespans f u₀ :=
    {T | ∃ u p, ClassicalSolution f u₀ T u p}
candidate_greatest_lifespan h : IsGreatest (admissibleLifespans f 0) 1
candidate_admissible_lifespans h : admissibleLifespans f 0 = Ioc 0 1
```

**Normalized formula:**

```
T* := sup{T > 0 : ∃ classical solution on [0,T)}
admissibleLifespans = (0, 1]   (for the candidate)
```

**Structural notes:**

- Maximality proved by combining uniqueness on overlapping intervals with
  the blow-up at time 1.
- `candidate_excludes_global_solution` makes the non-global character explicit.
- Compactness of the spatial torus used in `periodic_bound_on_slab`.

---

### OPENAI-NS-04 — Exact scaling exponents and carrier frequency

**Target file:** `NavierStokes/Scaling.lean`  
**Target SHA (blob):** `5e7b0c90d02f2918261132127b758699ee2ba21c`  
**Key declarations:**

```
coreVelocity q h  := q ^ (−(1/2 + h))
radialLength q    := q ^ (1/2)
axialLength q h   := q ^ (1/2 − h)
reynolds v l      := v * l
carrierFrequency ε := ⌈ε ^ (−1/2)⌉₊          -- natural ceiling
waveLength Q h    := radialLength Q / carrierFrequency(Q^h)
waveVelocity Q h e := coreVelocity Q h * √(Q^h) * e
```

**Key theorems:**

```
core_radial_reynolds   : reynolds(coreVelocity q h)(radialLength q)     = q^(−h)
core_axial_reynolds    : reynolds(coreVelocity q h)(axialLength q h)     = q^(−2h)
normalized_viscosity   : (Q^(−(1/2+h)−1)) / (Q^(−2(1/2+h)−1/2))        = Q^h
carrier_viscosity_bounds: 1 ≤ ε · carrierFrequency(ε)² ≤ (1+√ε)²
order_one_viscosity    : the complete 3-part inequality for 0 < ε ≤ 1
wave_reynolds_exact    : reynolds(waveVelocity)(waveLength)
                             = envelope / (carrierFreq · √(Q^h))
```

**Normalized formulas:**

```
U_core ~ Q^{−(1/2+h)},   R_radial ~ Q^{1/2},   R_axial ~ Q^{1/2−h}
k_carrier := ⌈Q^{−h/2}⌉   (integer frequency)
1 ≤ ε k² ≤ 4   for 0 < ε ≤ 1
```

**Structural notes:**

- Appendix A / Remark 8.6 of the candidate manuscript formalized here.
- The exact integer ceiling `⌈ε^{-1/2}⌉₊` is a distinctive feature;
  earlier scaling work uses continuous exponents only.

---

### OPENAI-NS-05 — Reference jet bounds (CoefficientFamily)

**Target file:** `NavierStokes/ReferenceJetBounds.lean`  
**Target SHA (blob):** `476a26a9d8cf5ce55028460c67365d2da697602e`  
**Key declarations:**

```
jetConstant v k m := AxisEvaluation.jetBound v.ε 5 k m * (‖referencePair v‖ + 1)
coefficient_jet_bound v x hx k m hp :
    |mixedSeries ... x.1 k m p| ≤ jetConstant v k m   ∧
    |mixedSeries ... x.2 k m p| ≤ jetConstant v k m
natural_U_radial: Λ · (Y · ∂_Y U) = rescaled partial at rescalePoint Λ p
-- Then: JetBounds, exists_transition_control, reference_U_radial_bound
```

**Normalized description:**

Control of all mixed (η, Y) derivatives of the profile U up to order (k, m)
uniformly on |Y| ≤ 5, near the reference coefficient pair, via:

```
|∂^k_η ∂^m_Y U(η, Y)| ≤ C_{k,m} (‖ref‖ + 1)
```

The estimate is uniform in the ball of radius 1 around `referencePair`.

**Structural notes:**

- The `CoefficientFamily` / `CoefficientProfile` hierarchy is distinctive to
  the OpenAI construction.
- The `referencePair` encodes the specific reference point in coefficient space.
- Depends on `NaturalEntrance`, `ReferencePath`, `NaturalProfile` modules.
- This is the bridge between abstract coefficient control and physical bounds.

---

### OPENAI-NS-06 — Correction step (discrete cycle-state bookkeeping)

**Target file:** `NavierStokes/CorrectionStep.lean`  
**Target SHA (blob):** `34d00e34b2819f1b7c3b04bf4cb77ff98f96a9a3`  
**Key declarations (extracted from imports and structure):**

```
-- Imports: LabelSupportPreservation, HarmonicStructurePreservation,
--   LocalResidualGrouping, AxisymmetricResidualGrouping,
--   MeanBoundsReindex, MeanStageRegularity, WaveStateRegularity,
--   MeanStateRegularity, BandReindexedSignedMeanGain, ...
-- Key lemmas (per audit/15_projection_chain_audit_map.md):
temporalStage_theta_exact
temporalStage_axial_exact
temporalStage_cumulative
rankStage_cumulative
fullResidual_harmonic_decomposition
fullResidual_decomposition
fullResidual_actual_update
fullGoodResidual_actual_update
meanGoodResidual_exact_errors
```

**Normalized description:**

Tracks how the full residual decomposes into harmonic components and evolves
under one correction cycle.  Each stage updates:

```
m_new = updated(m, h)
W_new = W + X
residual_new = residual - correction_contribution
```

The bookkeeping is discrete: indexed by (q, stage) with cumulative estimates.

**Structural notes:**

- This is the central iteration ledger.  It tracks `R_{q+1} − R_q` as a sum of
  explicit cross-terms.
- Depends on ~130 separate `.lean` files in the NavierStokes module.
- The discrete cycle structure with explicit harmonic decomposition is distinctive.

---

### OPENAI-NS-07 — Candidate consequences package

**Target file:** `NavierStokes/CandidateConsequences.lean`  
**Target SHA (blob):** `5f3eae72b029ea2503f9c2eaa20a1b11685062ff`  
**Key declarations:**

```
structure Consequences u p f where
  maximal   : IsMaximalClassicalSolution f 0 1 u p
  lifespans : admissibleLifespans f 0 = Ioc 0 1
  h3_unbounded : DerivativeH3UnboundedAtOne u
  force_nonzero : ∃ t ∈ Ioo 0 1, ∃ x, f(t,x) ≠ 0
  force_jet_decay : ∀ m K, 0≤K → ∃C>0, ∀t≥0,∀x, ‖futureJet f m (t,x)‖ ≤ C(1+t)^(−K)

consequences_of_candidate : CandidateProperties u p f → Consequences u p f
```

**Normalized description:**

Packages:
1. Maximality of the blow-up lifespan `T* = 1`
2. Sobolev `H³` norm blow-up: `limsup_{t→1⁻} ‖∂³u(t,·)‖_{L²} = ∞`
3. Force polynomial decay of all jets: `‖∂^m f(t,x)‖ ≤ C(1+t)^{-K}` for all `K`
4. Force non-vanishing

---

### OPENAI-NS-08 — Main breakdown theorems (C) and (D)

**Target file:** `NavierStokes/ComparatorSolution.lean`  
**Target SHA (blob):** `cc232068cd384dbbddce2753b1fc4a4017c0f2d7`  
**Key theorems:**

```lean
theorem navier_stokes_breakdown_R3 (ν : ℝ) (hν : ν > 0) :
    ∃ u₀ f, InitialVelocityConditionDecay u₀ ∧ ForceConditionDecay f ∧
      ¬(∃ v p, NavierStokesExistenceAndSmoothnessRn ν u₀ f v p)

theorem navier_stokes_breakdown_periodic (ν : ℝ) (hν : ν > 0) :
    ∃ u₀ f, InitialVelocityConditionPeriodic u₀ ∧ ForceConditionPeriodic f ∧
      ¬(∃ v p, NavierStokesExistenceAndSmoothnessPeriodic ν u₀ f v p)
```

**Normalized description:**

For every `ν > 0`: finite-time breakdown of smooth solutions to the forced
3D incompressible NS equations, both on ℝ³ (with suitable decay conditions)
and on the periodic torus ℝ³/ℤ³.

**Axiom list (confirmed zero sorry):**
`propext`, `Classical.choice`, `Quot.sound`

---

### OPENAI-NS-09 — H³ Sobolev blow-up criterion

**Target file:** `NavierStokes/PeriodicSobolev.lean` (referenced from consequences)  
**Declaration referenced:** `DerivativeH3UnboundedAtOne`  
**Normalized description:**

```
limsup_{t→1⁻} ‖∂³_x u(t,·)‖_{L²(ℝ³/ℤ³)} = +∞
```

This is the Sobolev embedding version of the blow-up criterion, stated for
the periodic candidate.

---

### OPENAI-NS-10 — Actual carrier jets (ActualCurrentCarrierJets)

**Target file:** `NavierStokes/ActualCurrentCarrierJets.lean`  
**Key declarations (per audit/15):**
`harmonic_carrier_eq`, `weightedPhase_positive_jets`,
`weightedPhase_positive_jets_controlPatch`

**Normalized description:**

Carrier-weighted phase fields with positivity and jet control:
```
phase_jets_positive:  ∀ control-patch point p, Φ(p) > 0
harmonic_carrier_eq:  carrier satisfies harmonicity condition on support
```

---

## EULER OBJECTS

---

### OPENAI-EU-01 — Euler breakdown on ℝ³

**Target file:** `Euler/Solution.lean`  
**Target SHA (blob):** `5f936ddfc0a891c3e9c9f45b2d964cc2325064b7`  
**Key theorem:**

```lean
theorem euler_breakdown_R3 :
    ∃ u₀ : ℝ³ → ℝ³,
      InitialVelocityConditionDecay u₀ ∧
      ¬(∃ v p, EulerExistenceAndSmoothnessR3 u₀ v p)
```

**Normalized description:**

Existence of smooth, divergence-free, rapidly decaying initial data `u₀` for the
unforced Euler equations such that no globally smooth solution exists.

---

### OPENAI-EU-02 — Compact smooth Euler singularity with vorticity criterion

**Target file:** `Euler/Solution.lean`  
**Target SHA (blob):** `5f936ddfc0a891c3e9c9f45b2d964cc2325064b7`  
**Key theorem:**

```lean
theorem exists_compact_smooth_euler_singularity :
    ∃ u₀ Tstar v p,
      InitialVelocityConditionDecay u₀ ∧
      HasCompactSupport u₀ ∧ u₀ ≠ 0 ∧
      0 < Tstar ∧ Tstar ≤ 1 ∧
      EulerSobolevExistenceAndSmoothnessR3On (Ico 0 Tstar) u₀ v p ∧
      -- kinetic energy bounded on [0, Tstar)
      (∃ E, ∀ t ∈ Ico 0 Tstar, ∫ x, ‖v x t‖² < E) ∧
      -- Sobolev existence iff T < Tstar
      (∀ T > 0, (∃ w q, EulerSobolevOn Icc0T u₀ w q) ↔ T < Tstar) ∧
      -- locally bounded C¹ and locally integrable vorticity
      (∀ T ∈ Ioo 0 Tstar, ‖C¹‖_{Icc0T} < ⊤ ∧ ∫_{Ico0T} ‖ω‖ < ⊤) ∧
      -- BKM blow-up: C¹ limsup = ∞ at Tstar
      limsup_{t→Tstar⁻} ‖v(·,t)‖_{C¹} = ⊤ ∧
      -- vorticity integral blows up
      ∫_{Ico 0 Tstar} ‖ω(·,t)‖ dt = ⊤ ∧
      ¬(∃ w q, EulerExistenceAndSmoothnessR3 u₀ w q)
```

**Normalized description:**

Compact smooth initial data producing finite-time blow-up in the sense of:
- BKM criterion: `∫₀^{T*} ‖ω(·,t)‖_{L∞} dt = +∞`
- Limsup of `C¹` velocity norm is `+∞` as `t → T*⁻`
- Sharp: all-order Sobolev smooth on `[0,T*)`, bounded kinetic energy.

---

### OPENAI-EU-03 — Compact vorticity confinement

**Target file:** `Euler/CanonicalVorticityConfinement.lean`  
**Referenced declarations:**
`canonicalVorticityBall`, `canonicalVorticityBall_compact`,
`canonical_vorticity_eq_zero_outside`, `canonical_vorticity_hasCompactSupport`

**Normalized description:**

The canonical Euler blow-up datum has vorticity supported in a fixed compact
ball throughout the solution lifespan `[0, T*)`.

---

### OPENAI-EU-04 — All-order correction budget (Euler)

**Target file:** `Euler/AllOrderCorrectionBudget.lean`  
**Normalized description:**

Budget control on the all-order correction series for the Euler solution;
analogous to the NS correction hierarchy but for the unforced Euler case.

---

### OPENAI-EU-05 — All-order drift correction and pressure (Euler)

**Target files:**
`Euler/AllOrderDriftCorrection.lean`,
`Euler/AllOrderDriftPressure.lean`,
`Euler/AllOrderDriftResidualBounds.lean`

**Normalized description:**

Drift-mode decomposition and residual bounds for the Euler all-order
correction scheme; tracks how each correction order changes the residual.

---

### OPENAI-EU-06 — Asymmetric transport (Euler)

**Target file:** `Euler/AsymmetricTransport.lean`  
**Normalized description:**

Asymmetric advection structure exploited in the Euler blow-up construction;
related to the angular-mode transport inequalities.

---

## SHARED / CROSS-CUT OBJECTS

---

### OPENAI-CROSS-01 — Four-language formal verification infrastructure

**Target tooling:** Lean 4 / Mathlib 4  
**Confirmed axioms:** `propext`, `Classical.choice`, `Quot.sound` (no sorry)  
**Normalized description:**

Complete formal machine-checked proof in Lean 4 with zero sorry.

---

### OPENAI-CROSS-02 — Projection decomposition u = u_N + u_⊥

**Target files:** Multiple; most explicit in ProblemStatement / Scaling context  
**Normalized description:**

```
u = P_Λ u + (I − P_Λ) u =: u_N + u_⊥
```

Used throughout as the foundation for the correction architecture.

---

*End of target extraction.  Object count: 16 (NS-10 + EU-06).*
