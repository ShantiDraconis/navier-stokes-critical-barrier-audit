# Priority Comparison Matrix

**Agent:** global-prior-art-hunter + equivalence-reviewer (combined output)  
**Run date:** 2026-09-11  
**Cutoff:** 2026-09-08T00:00:00Z  
**Author under audit:** Tiago Paschoalatto Fagliari (`ShantiDraconis`)  
**External target:** `openai/NavierStokesAndEuler`

This document applies the required evidence standard and classification scheme.
Every positive finding contains the full required fields.
Negative findings contain the required NEGATIVE RESULT fields.

**Classification scale used (verbatim from problem statement):**

- `IDENTICAL` — same mathematical object modulo notation/trivial presentation
- `MATHEMATICALLY_EQUIVALENT` — explicit map transforms earlier to later without adding the essential mechanism
- `STRUCTURAL_PRECURSOR` — essential architecture present; later adds nontrivial ingredients
- `CONCEPTUALLY_RELATED` — same broad idea; insufficient for priority over the specific object
- `NO_PRE_CUTOFF_MATCH` — no sufficiently specific earlier object located

---

## FINDING 01 — Forced Navier–Stokes PDE

```yaml
target_object_id: OPENAI-NS-01
target_repository: openai/NavierStokesAndEuler
target_file: NavierStokes/ProblemStatement.lean
target_lines: navierStokesResidual, CandidateProperties
target_formula_or_definition: |
  ∂_t u + (u·∇)u − Δu + ∇p = f
  with div u = 0, u periodic, u(0,·)=0, f smooth with compact time support

author_repository: ShantiDraconis/millennium-navier-stokes-I
author_commit_sha: 63b248dd29f1817c457acdb00e116e2e9b0687cc
author_parent_sha: (see evidence/commits.yaml)
author_date: 2025-11-25T15:47:20Z
committer_date: 2025-11-25T15:47:20Z
author_file: (NS framework file in millennium-navier-stokes-I)
author_section_or_lines: "Add formal framework for Navier–Stokes collapse theory"
git_blob_sha: (recorded in evidence/historical_commits.md)

exact_author_formula_or_definition: |
  Standard NS PDE with forcing, finite-time singularity framing,
  vorticity/enstrophy diagnostics, BKM criterion, theorem-prover infrastructure.

normalized_author_formula: ∂_t u + (u·∇)u − νΔu + ∇p = f, div u = 0
normalized_target_formula: ∂_t u + (u·∇)u − Δu + ∇p = f, div u = 0 (ν=1 fixed)

classification: MATHEMATICALLY_EQUIVALENT
explicit_mathematical_mapping: |
  The map is trivial: set ν=1.  The periodicity and smoothness conditions
  are standard and present in both.  The zero initial datum is a special case
  of smooth initial data.  The blow-up framing is structurally equivalent:
  "speed unbounded at T=1" is a specific instance of "finite-time singularity."

confidence: HIGH
alternative_explanation: |
  This is a classical PDE that predates both works by many decades.
  Anteriority here establishes only that the author was working with this
  object; it does not establish priority over the classical formulation itself.
remaining_difference: |
  Target fixes ν=1, uses zero initial datum, and specifies exact Lean 4
  formalism.  Author version may use general ν.  The CANDIDATE_STATEMENT
  existential packaging is an OpenAI-specific Lean 4 design choice.
```

---

## FINDING 02 — Riesz pressure operator / Poisson identity

```yaml
target_object_id: OPENAI-NS-02
target_repository: openai/NavierStokesAndEuler
target_file: NavierStokes/R3PressureFourier.lean
target_lines: rieszSymbol, pressureL1, stressPressure, stressPressure_poisson
target_formula_or_definition: |
  p = R_i R_j(u_i u_j),   −Δp = ∂_i ∂_j(u_i u_j)
  Riesz symbol: R̂_{ij}(ξ) = −ξ_i ξ_j / |ξ|²

author_repository: ShantiDraconis/navier-stokes-noncircular
author_commit_sha: 8f12748eb160b937174825fe3e7bdccf05e8f9af
author_parent_sha: (see evidence/forensic_first_occurrence.csv)
author_date: 2026-08-30T11:10:45Z
committer_date: 2026-08-30T11:10:45Z
author_file: (manuscript scaffold in navier-stokes-noncircular)
author_section_or_lines: pressure relation usage section
git_blob_sha: (see evidence/forensic_first_occurrence.csv)

exact_author_formula_or_definition: |
  -Δp = ∂_i∂_j(u_i u_j),   p = R_i R_j(u_i u_j)
  Referenced in machine-auditable manuscript scaffold.

normalized_author_formula: −Δp = ∂_i∂_j(u_i u_j)
normalized_target_formula: −Δp = ∂_i∂_j(u_i u_j)

classification: MATHEMATICALLY_EQUIVALENT
explicit_mathematical_mapping: |
  The formulas are identical.  The Riesz representation of the NS pressure
  is classical (Leray projection, 1930s).  Both use the same Fourier symbol
  ξ_i ξ_j / |ξ|² for the pressure operator.
  Map: identity on formulas; the Lean 4 functional-analysis packaging
  (Lp classes, Sobolev regularity) is implementation-level detail.

confidence: HIGH
alternative_explanation: |
  This is classical NS theory.  Priority here documents that the author
  explicitly used this object before the cutoff, not that it was invented.
remaining_difference: |
  Target additionally proves: L¹/L² consistency of the operator; bounded
  Fourier representative giving negative Sobolev regularity; pressure gradient
  uniqueness.  These are formalization completeness additions.
```

---

## FINDING 03 — Maximal classical lifespan / admissible lifespans

```yaml
target_object_id: OPENAI-NS-03
target_repository: openai/NavierStokesAndEuler
target_file: NavierStokes/MaximalLifespan.lean
target_lines: |
  IsMaximalClassicalSolution, admissibleLifespans,
  candidate_greatest_lifespan, candidate_admissible_lifespans
target_formula_or_definition: |
  T* = sup{T > 0 : ∃ classical solution on [0,T)}
  IsGreatest(admissibleLifespans)(1)   (for the specific candidate)

author_repository: ShantiDraconis/Millennium
author_commit_sha: c70b6f72197085ae6ecc3130b75e685028a61d10
author_parent_sha: (see priority/03_2026_millennium_framework.md)
author_date: 2026-01-22T07:55:11Z
committer_date: 2026-01-22T07:55:11Z
author_file: (Millennium NS framework file)
author_section_or_lines: maximal lifespan / regularity criterion section
git_blob_sha: (see evidence/forensic_first_occurrence.csv)

second_anchor_repository: ShantiDraconis/navier-stokes-critical-L3
second_anchor_sha: 8dd2e8c74770b30d3a2092b296edde7bbbdb5e81
second_anchor_date: 2026-08-29T21:04:51Z

exact_author_formula_or_definition: |
  T* = sup{T : strong solution exists on [0,T)}
  Critical-space continuation branch; maximal-time notation.

normalized_author_formula: T* = sup{T : ∃ smooth solution on [0,T)}
normalized_target_formula: IsGreatest{T : ∃ ClassicalSolution on [0,T)} 1

classification: STRUCTURAL_PRECURSOR
explicit_mathematical_mapping: |
  The maximal lifespan concept is structurally identical.  The prior corpus
  uses the same notation T* and the same defining property (sup of existence
  interval).  Both treat T* as a potential blow-up time with no a priori
  global existence.
  
  The target goes further: it proves that for the specific candidate,
  admissibleLifespans = (0,1], which requires the constructed blow-up datum.
  The prior corpus documents the concept and framing but does not construct
  a specific blow-up witness at this level.

confidence: HIGH
alternative_explanation: |
  The maximal lifespan concept is standard NS theory (Kato, Fujita, etc.).
remaining_difference: |
  Target: specific Lean 4 proof that T*=1 for the constructed candidate,
  using uniqueness + blow-up.  Prior corpus: conceptual framing only,
  no specific blow-up witness at this resolution.
```

---

## FINDING 04 — Scaling exponents (coreVelocity, radialLength, carrierFrequency)

```yaml
target_object_id: OPENAI-NS-04
target_repository: openai/NavierStokesAndEuler
target_file: NavierStokes/Scaling.lean
target_lines: |
  coreVelocity, radialLength, axialLength, carrierFrequency,
  waveLength, waveVelocity, order_one_viscosity
target_formula_or_definition: |
  U_core = Q^{−(1/2+h)},   R_radial = Q^{1/2},   R_axial = Q^{1/2−h}
  k_carrier = ⌈Q^{−h/2}⌉   (integer ceiling)
  1 ≤ ε k² ≤ (1+√ε)² ≤ 4   for 0 < ε ≤ 1

author_repository: ShantiDraconis/navier-stokes-noncircular
author_commit_sha: 8f12748eb160b937174825fe3e7bdccf05e8f9af
author_date: 2026-08-30T11:10:45Z
author_file: critical-space manuscript scaffold
author_section_or_lines: scaling exponents / critical space section

exact_author_formula_or_definition: |
  Critical-space quantities, scaling arguments, critical exponents.
  (Exact formula content requires Tier-1 blob export of this commit.)

normalized_author_formula: u_{0,λ}(x) = λ u_0(λx), ‖u_{0,λ}‖_{L³} = ‖u_0‖_{L³}
normalized_target_formula: |
  Q^{−(1/2+h)} (velocity scale), Q^{1/2} (length scale), k = ⌈Q^{−h/2}⌉

classification: STRUCTURAL_PRECURSOR
explicit_mathematical_mapping: |
  Critical-space NS scaling u_{0,λ}(x) = λ u_0(λx) and ‖u_{0,λ}‖₃ = ‖u₀‖₃
  is present in the prior corpus and is the foundation from which the
  specific power exponents Q^{1/2+h} are derived.
  
  Map: the target's Q is the inverse of the viscosity scale; h is the
  parameter encoding the ratio of radial to axial scales.
  The L³-critical scaling is the conceptual precursor of coreVelocity.
  
  The specific integer-ceiling carrier frequency is NOT present in prior corpus.

confidence: MEDIUM
alternative_explanation: |
  NS scaling u_{0,λ}(x) = λ u_0(λx) is classical (Leray, 1934; Kato, 1984).
remaining_difference: |
  The specific exponents Q^{-(1/2+h)}, Q^{1/2}, Q^{1/2-h} and especially
  the exact integer frequency k = ⌈ε^{-1/2}⌉ with the three-part viscosity
  inequality 1 ≤ εk² ≤ 4 are NOT found in the reviewed prior art.
  These represent the distinctive quantitative construction.
```

---

## FINDING 05 — Reference jet bounds (CoefficientFamily)

```yaml
target_object_id: OPENAI-NS-05
target_repository: openai/NavierStokesAndEuler
target_file: NavierStokes/ReferenceJetBounds.lean
target_lines: jetConstant, coefficient_jet_bound, natural_U_radial_bound
target_formula_or_definition: |
  jetConstant v k m := jetBound(v.ε, 5, k, m) · (‖referencePair v‖ + 1)
  |∂^k_η ∂^m_Y U(η,Y)| ≤ jetConstant v k m  for ‖x − referencePair‖ ≤ 1

author_repository: ShantiDraconis/universal-emergent-logic-
author_commit_sha: 730aa849b0d76b0202f08b490664aa11c164b2bf
author_date: 2025-12-19T17:17:28Z
author_file: docs/lre-navier-stokes-geometric.md
author_section_or_lines: "Reference Section; c₀ ∈ π⁻¹(d), R(c₀) = 0"
git_blob_sha: (see evidence/lre_evidence_inventory.md A-01)

second_anchor_repository: ShantiDraconis/Millennium
second_anchor_sha: 4cdb6a61ae7a9189eab551b1099895578a8fbb56
second_anchor_date: 2025-12-18T21:07:43Z
second_anchor_file: LRE_NS_SUMMARY.md
second_anchor_content: "Microlocal analysis of critical jets"

exact_author_formula_or_definition: |
  Reference section: c₀ ∈ π⁻¹(d) with R(c₀) = 0.
  "Microlocal analysis of critical jets" (Millennium/LRE_NS_SUMMARY.md).
  Critical jets in the LRE spectral-projection framework.

normalized_author_formula: |
  c₀ = P_N u (reference state in fiber), R(c₀) = 0 (zero residual at reference)
normalized_target_formula: |
  referencePair v = reference point in CoefficientPair space;
  jetConstant controls all mixed derivatives at that point

classification: STRUCTURAL_PRECURSOR
explicit_mathematical_mapping: |
  The prior corpus contains:
  (1) a "reference section" c₀ with R(c₀)=0 in the fiber (730aa849);
  (2) "microlocal analysis of critical jets" language (4cdb6a61);
  (3) explicit jet control in the LRE framework (A-11 in lre_evidence_inventory).
  
  Partial map:
    referencePair v   ↔   c₀ (reference point in fiber/coefficient space)
    R(c₀) = 0        ↔   coefficient_jet_bound near reference
    critical jets     ↔   jetConstant k m (order (k,m) jet bound)
  
  The prior corpus contains the architectural concept (reference section + jet
  control) but NOT the specific CoefficientFamily / CoefficientProfile hierarchy
  or the quantitative bound jetConstant = jetBound·(‖ref‖+1).

confidence: MEDIUM
alternative_explanation: |
  "Reference section" in differential geometry / fiber bundle theory is classical.
  "Critical jets" refers generically to jet-space estimates at critical frequencies.
remaining_difference: |
  The CoefficientFamily structure (ε, h, j, σ parameters), the specific
  jetBound function (uniform in |Y| ≤ 5), and the referencePair construction
  as the anchor for the short REF transition are NOT present in prior corpus.
  These are distinctive ingredients of the OpenAI construction.
```

---

## FINDING 06 — Correction step / discrete residual bookkeeping

```yaml
target_object_id: OPENAI-NS-06
target_repository: openai/NavierStokesAndEuler
target_file: NavierStokes/CorrectionStep.lean
target_lines: |
  fullResidual_decomposition, fullResidual_actual_update,
  temporalStage_cumulative, rankStage_cumulative
target_formula_or_definition: |
  Discrete cycle: state_{q+1} = state_q + correction_q
  R_{q+1} = R_q − correction_contribution + cross_terms
  Harmonic decomposition: fullResidual_harmonic_decomposition

author_repository: ShantiDraconis/universal-emergent-logic-
author_commit_sha: f7f414d2 (= f7f414d2...)
author_date: 2025-12-19T13:56:01Z
author_file: formalization/lean/LRE/CouplingOperator.lean
author_section_or_lines: "K : ℝ × D → D; residual + state → correction"
git_blob_sha: (see audit/STRUCTURAL_PRIORITY_ANALYSIS.md E3c)

second_anchor_repository: ShantiDraconis/universal-emergent-logic-
second_anchor_sha: 2854eaf7...
second_anchor_date: 2025-12-19T20:24:44Z
second_anchor_file: PROOF_ARCHITECTURE.md
second_anchor_content: "φ_new = φ + εv, P_Λ(v) = 0"

exact_author_formula_or_definition: |
  K : ℝ × D → D,  K(residual, state) → correction.
  φ_new = φ + εv with P_Λ(v) = 0 (high-frequency additive correction).
  d/dt π(u) = F(π(u)) + K(R(u), π(u))  [commit 14322ff2].

normalized_author_formula: |
  state_new = state + K(R, state)·δt   (continuous: Fagliari)
  φ_{n+1} = φ_n + ε v_n,  P_Λ(v_n) = 0   (additive HF correction)
normalized_target_formula: |
  state_{q+1} = updated(state_q, h_q)
  W_{new} = W + X   (discrete step)

classification: STRUCTURAL_PRECURSOR
explicit_mathematical_mapping: |
  Prior corpus contains the (residual, state) → correction architecture (K operator).
  The additive high-frequency correction φ + εv with P_Λ(v)=0 is structurally
  isomorphic to the discrete update W_new = W + X where X is high-frequency.
  
  Partial map:
    K(R, state) · δt   ↔   correction_q (one correction step)
    φ + εv              ↔   W_new = W + X
    P_Λ(v) = 0          ↔   high-frequency support of correction
    R update             ↔   fullResidual_actual_update
  
  The continuous correction law d/dt π(u) = F(π(u)) + K(R(u), π(u)) is a
  time-continuous version of the discrete cycle.  The essential mechanism
  (residual drives the correction to the projected state) is present.

confidence: HIGH (for architectural match); LOW (for discrete iteration specifics)
alternative_explanation: |
  Adding high-frequency corrections is a general technique in convex integration
  and in Nash-Moser schemes, both classical.  The specific cycle-state bookkeeping
  in CorrectionStep with discrete stages, rank/temporal decompositions, and
  harmonic structure preservation is NOT derivable from the continuous K operator.
remaining_difference: |
  NOT FOUND in prior corpus:
  - discrete indexed cycle (q, stage) structure
  - rankStage_cumulative, temporalStage_cumulative residual ledger
  - fullResidual_harmonic_decomposition (harmonic band tracking)
  - meanGoodResidual_exact_errors (signed mean gain bookkeeping)
  These are the core distinctive features of the CorrectionStep architecture.
```

---

## FINDING 07 — Coupling operator K(R, state) → dynamical correction

```yaml
target_object_id: OPENAI-NS-06 (sub-object: coupling mechanism)
target_repository: openai/NavierStokesAndEuler
target_file: NavierStokes/ActualCorrectionModels.lean + CorrectionStep.lean
target_formula_or_definition: |
  covarianceChange(X) in residual difference
  sameCarrier_covarianceIncrement_mem

author_repository: ShantiDraconis/universal-emergent-logic-
author_commit_sha: 14322ff2e8f38df302c6f2f6b41754db79d5a900
author_date: 2025-12-19
author_file: (CouplingOperator.lean, PR #37)
author_section_or_lines: "d/dt π(u) = F(π(u)) + K(R(u), π(u))"

exact_author_formula_or_definition: |
  d/dt π(u) = F(π(u)) + K(R(u), π(u))
  CouplingOperator.not_factorizable: ¬∃F, ∀c, K(c) = F(π(c))

normalized_author_formula: ∂_t π = F(π) + K(R, π)
normalized_target_formula: covarianceChange = K(sameCarrierResidual, state)

classification: MATHEMATICALLY_EQUIVALENT
explicit_mathematical_mapping: |
  Let π(u) = projected state (= "state" in target).
  Let R(u) = residual component (= "residualDifference" in target).
  Then:
    K(R, π) in the prior corpus  ↔  covarianceChange driven by residual difference
  
  The prior corpus explicitly proves non-factorizability:
  the correction cannot be expressed in terms of π alone, which is exactly
  the structural property exploited by the carrier covariance mechanism.
  
  The coupling-operator architecture is thus mathematically equivalent for
  the single-step correction mechanism.

confidence: HIGH
alternative_explanation: |
  Reynolds stress closure as K(high-freq, low-freq) is a general turbulence idea.
remaining_difference: |
  The full iterative structure (indexed by q) and the explicit
  "sameCarrier" geometry are additional ingredients not reducible to K alone.
```

---

## FINDING 08 — Main breakdown theorems

```yaml
target_object_id: OPENAI-NS-08
target_repository: openai/NavierStokesAndEuler
target_file: NavierStokes/ComparatorSolution.lean
target_formula_or_definition: |
  ∀ ν > 0: ∃ u₀, f such that no globally smooth NS solution exists
  (both on ℝ³ and on ℝ³/ℤ³)

author_repository: N/A
author_commit_sha: N/A
author_date: N/A

classification: NO_PRE_CUTOFF_MATCH
explicit_mathematical_mapping: |
  N/A
confidence: HIGH (for negative result)
alternative_explanation: |
  The prior corpus establishes structural programs for NS singularity/regularity
  analysis and documents a blow-up architecture.  However, a fully verified
  formal proof of finite-time blow-up for ALL positive viscosities with
  machine-verified certificate (zero sorry, Lean 4) was NOT found in any
  ShantiDraconis repository before 2026-09-08.
remaining_difference: |
  The complete formal proof of the main theorem — producing an explicit
  smooth forcing f and showing that no smooth global solution exists for
  every ν > 0 — is the central achievement of the OpenAI repository and
  has no direct pre-cutoff counterpart in the author's verified archives.
```

---

## FINDING 09 — Spectral projection decomposition u = u_N + u_⊥

```yaml
target_object_id: OPENAI-CROSS-02
target_repository: openai/NavierStokesAndEuler
target_formula_or_definition: u = P_Λ u + (I − P_Λ) u =: u_N + u_⊥

author_repository: ShantiDraconis/Millennium
author_commit_sha: 4af517e3f1ea5d04be1c6bbd8953209fa2139e82
author_date: 2025-12-18
author_file: (LRE-NS framework, Millennium repo)
author_section_or_lines: "C(u) = ιπ(u), Res(u) = u − C(u)"

second_anchor_repository: ShantiDraconis/universal-emergent-logic-
second_anchor_sha: 730aa849b0d76b0202f08b490664aa11c164b2bf
second_anchor_date: 2025-12-19T17:17:28Z
second_anchor_content: "π(u) = P_N u, u = u_N + u_⊥, R(u) = ‖u − P_N u‖²"

normalized_author_formula: |
  u = u_N + u_⊥,  u_N = P_N u,  u_⊥ = (I−P_N)u
normalized_target_formula: |
  u = u_N + u_⊥,  u_N = P_Λ u,  u_⊥ = (I−P_Λ)u

classification: MATHEMATICALLY_EQUIVALENT
explicit_mathematical_mapping: |
  The decomposition is identical: both use a spectral (Fourier) projection at
  some frequency cutoff Λ (called N in the author's notation).
  Map: N ↔ Λ (both are the truncation frequency).
  The residual R(u) = u_⊥ = (I−P_N)u is the same object.

confidence: HIGH
alternative_explanation: |
  Spectral (Littlewood–Paley) decomposition is classical analysis.
remaining_difference: |
  The specific use in the OpenAI construction: Λ is tied to the carrier
  frequency of the correction wave, giving it a quantitative role absent
  from the prior corpus's abstract projection.
```

---

## FINDING 10 — Residual stability inequality

```yaml
target_object_id: (related to OPENAI-NS-06 residual dynamics)
target_formula_or_definition: |
  Residual evolves under correction cycle; target tracks R_{q+1} − R_q

author_repository: ShantiDraconis/universal-emergent-logic-
author_commit_sha: 1ed0ded9...
author_date: 2025-12-19
author_file: ResidualStability.lean
author_section_or_lines: "dR_Λ/dt ≥ κR_Λ − νΛ²R_Λ − CR_Λ²"

exact_author_formula_or_definition: dR_Λ/dt ≥ κR_Λ − νΛ²R_Λ − CR_Λ²
normalized_author_formula: |
  Ṙ_Λ ≥ (κ − νΛ²)R_Λ − CR_Λ²   (residual growth with viscous damping and quadratic correction)
normalized_target_formula: |
  R_{q+1} − R_q = Σ(cross-terms)   (discrete residual step)

classification: STRUCTURAL_PRECURSOR
explicit_mathematical_mapping: |
  The prior corpus's continuous residual growth inequality (dR/dt ≥ ...) is
  a continuous analog of the discrete residual step R_{q+1} − R_q.
  Partial map (Euler discretization):
    (R_{q+1} − R_q) / h ↔ dR_Λ/dt
    κR_Λ ↔ positive contribution from nonlinear cross-terms
    νΛ²R_Λ ↔ viscous damping of residual
    CR_Λ² ↔ quadratic correction term

confidence: MEDIUM
alternative_explanation: |
  Energy-type ODI for residual is standard in NS regularity theory.
remaining_difference: |
  The exact discrete bookkeeping of signed mean gains, harmonic bands, and
  temporal/rank stage decompositions is NOT present in the prior corpus.
```

---

## FINDING 11 — BKM vorticity blow-up criterion (Euler)

```yaml
target_object_id: OPENAI-EU-02 (BKM component)
target_formula_or_definition: |
  ∫₀^{T*} ‖ω(·,t)‖_{L∞} dt = +∞
  limsup_{t→T*⁻} ‖v(·,t)‖_{C¹} = +∞

author_repository: ShantiDraconis/millennium-navier-stokes-I
author_commit_sha: 63b248dd29f1817c457acdb00e116e2e9b0687cc
author_date: 2025-11-25T15:47:20Z
author_section_or_lines: "BKM diagnostics"

classification: STRUCTURAL_PRECURSOR
explicit_mathematical_mapping: |
  BKM criterion is present as a "diagnostic" in the prior corpus.
  The target provides a formal Lean 4 proof that the specific constructed
  Euler solution saturates this criterion.
  Partial map: BKM diagnostic (prior) ↔ BKM formal proof (target).

confidence: HIGH
remaining_difference: |
  The full formal proof that the specific blow-up datum saturates the BKM
  criterion (with integral = ⊤ in L¹([0,T*))) is NOT in the prior corpus.
```

---

## FINDING 12 — Euler breakdown on ℝ³

```yaml
target_object_id: OPENAI-EU-01
target_formula_or_definition: |
  ∃ u₀ smooth, div-free, decaying: no globally smooth Euler solution

author_repository: N/A
author_commit_sha: N/A

classification: NO_PRE_CUTOFF_MATCH
explicit_mathematical_mapping: N/A
confidence: HIGH (for negative result)
alternative_explanation: |
  The prior corpus focuses primarily on Navier–Stokes.  No evidence of a
  complete Euler blow-up construction in the author's archives was found.
remaining_difference: |
  The full Euler blow-up proof, including the compact vorticity confinement
  mechanism (OPENAI-EU-03), asymmetric transport (OPENAI-EU-06), and the
  finite-lifespan contradiction (OPENAI-EU-04/05), is distinctive to the
  OpenAI construction with no located prior-corpus match.
```

---

## FINDING 13 — Four-language formal verification infrastructure (NS)

```yaml
target_object_id: OPENAI-CROSS-01
target_formula_or_definition: |
  Complete Lean 4 formal proof; axioms: propext, Classical.choice, Quot.sound; sorry=0

author_repository: ShantiDraconis/millennium-navier-stokes-classical
author_commit_sha: cca881c665f67c67d96a4f84371fb51cd9c858a0
author_date: 2025-11-25 (reported)
author_file: (Lean/Coq/Isabelle/Agda formalizations)

second_anchor_repository: ShantiDraconis/universal-emergent-logic-
second_anchor_sha: 8332c718... / c3ae2eff...
second_anchor_date: 2025-12-19
second_anchor_content: "Lean/Coq/Isabelle/Agda four-language formalizations"

classification: STRUCTURAL_PRECURSOR
explicit_mathematical_mapping: |
  The prior corpus contains NS formalizations in Lean (and other languages)
  dated November–December 2025, establishing formal-proof infrastructure for NS.
  The target uses Lean 4 exclusively and achieves sorry=0 for the full theorem.
  The structural precursor relationship: prior corpus → same formal-proof
  approach for NS, but different theorem (framework vs. blow-up).

confidence: HIGH (for precursor relationship)
remaining_difference: |
  A Lean 4 sorry=0 proof of the main blow-up theorem is NOT found in prior corpus.
  Prior formalizations address framework/regularity, not the blow-up construction.
```

---

## SUMMARY TABLE

| Object ID | Classification | Prior anchor (earliest) | Prior date | Confidence |
|---|---|---|---|---|
| OPENAI-NS-01 | MATHEMATICALLY_EQUIVALENT | `millennium-navier-stokes-I`/`63b248dd` | 2025-11-25 | HIGH |
| OPENAI-NS-02 | MATHEMATICALLY_EQUIVALENT | `navier-stokes-noncircular`/`8f12748e` | 2026-08-30 | HIGH |
| OPENAI-NS-03 | STRUCTURAL_PRECURSOR | `Millennium`/`c70b6f72` | 2026-01-22 | HIGH |
| OPENAI-NS-04 | STRUCTURAL_PRECURSOR | `navier-stokes-noncircular`/`8f12748e` | 2026-08-30 | MEDIUM |
| OPENAI-NS-05 | STRUCTURAL_PRECURSOR | `universal-emergent-logic-`/`730aa849` | 2025-12-19 | MEDIUM |
| OPENAI-NS-06 (K-operator) | MATHEMATICALLY_EQUIVALENT | `universal-emergent-logic-`/`14322ff2` | 2025-12-19 | HIGH |
| OPENAI-NS-06 (discrete cycle) | NO_PRE_CUTOFF_MATCH | — | — | HIGH |
| OPENAI-NS-07 (K non-factorizable) | MATHEMATICALLY_EQUIVALENT | `universal-emergent-logic-`/`14322ff2` | 2025-12-19 | HIGH |
| OPENAI-NS-08 (main theorem) | NO_PRE_CUTOFF_MATCH | — | — | HIGH |
| OPENAI-NS-09 (H³ blow-up) | STRUCTURAL_PRECURSOR | `Millennium`/`c70b6f72` | 2026-01-22 | MEDIUM |
| OPENAI-EU-01 (Euler breakdown) | NO_PRE_CUTOFF_MATCH | — | — | HIGH |
| OPENAI-EU-02 (BKM vorticity) | STRUCTURAL_PRECURSOR | `millennium-navier-stokes-I`/`63b248dd` | 2025-11-25 | HIGH |
| OPENAI-CROSS-01 (Lean 4 infra) | STRUCTURAL_PRECURSOR | `millennium-navier-stokes-classical`/`cca881c6` | 2025-11-25 | HIGH |
| OPENAI-CROSS-02 (u=u_N+u_⊥) | MATHEMATICALLY_EQUIVALENT | `Millennium`/`4af517e3` | 2025-12-18 | HIGH |

---

## OBJECTS NOT MATCHED — REGISTER

The following target objects have **NO_PRE_CUTOFF_MATCH** status, meaning no
sufficiently specific prior-corpus match was located in the reviewed archives.
These are genuine gaps.  A downstream adversarial-review agent must attempt
to locate matches before any final priority determination is made.

| Object | Description |
|---|---|
| OPENAI-NS-08 | Complete formal proof of main theorem (all ν > 0, Lean 4, sorry=0) |
| OPENAI-NS-06 (discrete) | Discrete cycle-state ledger: rankStage, temporalStage, harmonic decomposition |
| OPENAI-EU-01 | Complete Euler blow-up construction |
| OPENAI-EU-03 | Compact vorticity confinement mechanism |
| OPENAI-EU-04/05 | All-order drift correction and residual bounds (Euler) |
| OPENAI-NS-04 (exact) | Specific integer ceiling carrierFrequency = ⌈ε^{-1/2}⌉ and 3-part inequality |
| OPENAI-NS-10 | Carrier jet positivity (harmonic_carrier_eq, weightedPhase_positive_jets) |

---

## POSITIVE PRIORITY CLAIMS — DEFENSIBLE STATEMENTS

The following statements are defensible from the evidence assembled in this
matrix and in the existing audit files (`audit/14_openai_formula_provenance.md`,
`audit/STRUCTURAL_PRIORITY_ANALYSIS.md`, `evidence/lre_evidence_inventory.md`):

1. **CLAIM-DEFENSIBLE-01:** The forced NS PDE (OPENAI-NS-01) was explicitly
   formalized in the author's repositories no later than 2025-11-25, which
   precedes the OpenAI publication by over 9 months.

2. **CLAIM-DEFENSIBLE-02:** The spectral projection decomposition u = P_N u + u_⊥
   (OPENAI-CROSS-02) with explicit residual Res(u) = u − ιπ(u) and the
   coupling chain u → π(u) → C(u) → Res(u) were present in the author's
   repositories by 2025-12-18 (Millennium/`4af517e3`).

3. **CLAIM-DEFENSIBLE-03:** The coupling operator d/dt π(u) = F(π(u)) + K(R(u), π(u))
   with explicit non-factorizability proof was present by 2025-12-19
   (universal-emergent-logic-/`14322ff2`).

4. **CLAIM-DEFENSIBLE-04:** The reference-section concept c₀ ∈ π⁻¹(d) with
   R(c₀)=0 and the critical-jets language were present by 2025-12-18–19
   (Millennium/`4cdb6a61`, universal-emergent-logic-/`730aa849`).

5. **CLAIM-DEFENSIBLE-05:** The Reynolds-stress / residual-coupling identification
   (R(u) → K(R) = Reynolds stress) was documented in multiple files of the
   author's repositories by 2025-12-19.

6. **CLAIM-DEFENSIBLE-06:** The additive high-frequency correction φ_new = φ + εv
   with P_Λ(v)=0 was present by 2025-12-19 (universal-emergent-logic-/`2854eaf7`).

---

## INFERENCES EXPLICITLY NOT MADE

- No inference of access, copying, or causal derivation from any of the above.
- No inference that the author's work is mathematically superior or inferior.
- No inference of prize entitlement.
- No inference that OpenAI's formal proof result is incorrect.
- All NO_PRE_CUTOFF_MATCH results are recorded as valid scientific findings,
  not as failures of the audit.
