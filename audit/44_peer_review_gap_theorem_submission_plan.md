# 44 — Peer-review gap theorems, release gates, and submission plan

## Scope

This record converts the current audit corpus into explicit theorem obligations, testable invariants, and publication tracks. It does **not** claim that Navier–Stokes or the Riemann hypothesis has been solved.

## Provenance theorem

**Chronology does not imply global priority.** If object A has an authenticated timestamp earlier than object B inside the audited corpus, then A predates B in that corpus. This does not imply that the mathematical idea in A was first discovered globally, because the corpus does not quantify over all unobserved prior art.

Safe priority language:

- `EARLIEST_VERIFIED_OCCURRENCE_IN_AUDITED_CORPUS`
- `ACCOUNT_ASSOCIATED_IMPLEMENTATION_PROVENANCE`
- `EXACT_REVISION_CONTAINS_FORMULA_F` when exact historical bytes are available.

Unsafe without additional evidence:

- `FIRST_IN_WORLD`
- `GLOBAL_PRIORITY`
- `MILLENNIUM_PROBLEM_SOLVED`

## Generic defect-correction operator

Let a state space be X, a defect functional be `E : X -> R_{≥0}`, and a correction family be

`C_θ : X × R_{≥0} -> X`.

Define

`T_θ(x) = C_θ(x, E(x))`.

A closed correction loop is

`D_n = E(x_n)`

`x_{n+1} = C_{θ_n}(x_n, D_n)`

`D_{n+1} = E(x_{n+1})`.

A pipeline that does not recompute `D_{n+1}` is not a closed defect-feedback loop under this definition.

### Contraction theorem

If there exists `q in [0,1)` such that

`E(T_θ x) <= q E(x)`

for every admissible state, then

`E(x_n) <= q^n E(x_0)`

and therefore `E(x_n) -> 0`.

**Open problem-specific obligation:** prove that the chosen repository defect controls a recognized classical quantity strongly enough that closing the abstract defect closes the original mathematical problem.

## Error-model theorems

For

`E_w = Σ_i w_i g_i(Δ_i)`, `w_i >= 0`, `Σ_i w_i = 1`,

define, when `E_w > 0`,

`C_i = 100 w_i g_i(Δ_i) / E_w`.

Then `Σ_i C_i = 100`.

This proves normalization only. It does not prove canonicity or invariance under reparameterization. A direct counterexample is obtained by changing a coordinate from `Δ_2=2` to `h(Δ_2)=Δ_2^2=4`, which changes the normalized percentages.

For vector error coordinates `ε in R^n_{≥0}`, `||ε||_2 = 0` iff every coordinate is zero.

Monotone error reduction does not imply closure: `E_n = 1 + 1/(n+1)` decreases strictly but converges to 1.

## Navier–Stokes established identity

For

`ε_NS(u) = ||(u·∇)u||_2 / (ν ||Δu||_2)`

when the denominator is nonzero, classical 3D scaling

`u_λ(x,t)=λ u(λx,λ²t)`

scales both numerator and denominator by `λ^(3/2)`. Therefore `ε_NS` is scale invariant whenever defined.

### Open NS bridge obligations

1. State domain, forcing, solution class and viscosity assumptions exactly.
2. Treat denominator degeneracy rigorously.
3. Prove a non-circular implication from the exact repository condition to a recognized critical regularity criterion, e.g. bounded `L^∞_t L^3_x` under the appropriate hypotheses.
4. If a universal threshold is proposed, prove a coercive estimate connecting the threshold to a classical regularity norm.
5. Do not promote scaling invariance, zero mean, or numerical threshold clustering to a regularity theorem.

## Riemann / SE'ET established model identities

Define

`R(u)=exp(u/2) sin(γu)`

`S_d(u)=exp((1/2+d)u) sin(γu)`.

Then

`Δ_d(u)=S_d(u)-R(u)=exp(u/2)(exp(du)-1)sin(γu)`.

Whenever `sin(γu) != 0`,

`S_d(u)/R(u)=exp(du)`.

For the recovered parameters `d=.025`, `u=15`, the envelope ratio is `exp(.375) ≈ 1.45499`.

For the quartet

`ρ_{σ,τ}=1/2 + σ d + i τ γ`, `σ,τ ∈ {−1,+1}`,

the set is closed under conjugation and under `s -> 1-conj(s)`.

These are exact identities of the model. They do not prove that any chosen `ρ` is a zero of `ζ(s)`.

### Open RH bridge obligations

1. Independently certify each purported zeta zero with rigorous error control.
2. State the exact explicit formula used, including truncation, smoothing, multiplicities and remainder terms.
3. Separate hard-coded residual strings from values derived by computation.
4. Preserve end-to-end precision; do not advertise 563/600-digit arithmetic after conversion to binary64 output.
5. Do not infer zerohood from quartet symmetry alone.

## Historical-computational branch limitations

The 2024 notebooks document exploratory computation involving constants, singularities, particle/molecular visualizations, SU-labeled models, quantum circuits, signal processing, weather models and chronology. Physical labels do not by themselves establish the corresponding physical theory.

A raw additive expression combining quantities of incompatible physical dimensions is not a dimensionally meaningful physical law unless an explicit nondimensionalization or unit-converting map is supplied.

Functions such as `1/x`, `1/x^2`, and `1/x^3` genuinely diverge as `x -> 0+`; naming the point `0/0` does not define a new algebraic value for the indeterminate form `0/0`.

## Formal proof release gate

A theorem may be marked `FORMAL_PROOF_CHECKED` only when:

1. exact source revision is identified;
2. prover/dependency versions are pinned;
3. clean compilation succeeds;
4. no admitted placeholder occurs in the transitive dependency chain;
5. all nontrivial axioms are explicitly enumerated.

A field such as `deepTheorem : Prop` is a specification field until an instance supplies a proof term.

The release scan must classify `sorry`, `admit`, `Admitted`, `axiom`, `Axiom`, `oops`, and vacuous `True` replacements appropriately.

## Required tests

The peer-review package should contain tests for:

- exact notebook SHA-256 / byte sizes / cell counts;
- weighted-percentage normalization;
- error-vector zero characterization;
- geometric contraction;
- monotone-nonzero counterexample;
- SE'ET residual factorization;
- SE'ET envelope ratio;
- stiffness-ratio monotonicity for `d>0`;
- left/right weight normalization;
- gamma-independence of the currently defined `delta_K`;
- quartet conjugation and critical-line reflection;
- Navier–Stokes scaling exponent cancellation;
- zero mean without pointwise smallness;
- anti-overclaim checks for timestamps, zeta-zero labels, formal placeholders, and hard-coded residuals.

## Evidence graph nodes

Required node classes:

- `DRIVE_OBJECT`
- `RAW_NOTEBOOK`
- `CELL_OCCURRENCE`
- `GIT_COMMIT`
- `GIT_BLOB`
- `FORMAL_THEOREM`
- `COMPUTATION`
- `CLAIM`
- `PUBLICATION`
- `BRIDGE`

Required typed edges include:

- `EXACT_COPY`
- `DERIVED_FROM`
- `RENAMED`
- `REFINED`
- `GENERALIZED`
- `SPECIALIZED`
- `SYNTACTIC_TRANSLATION`
- `CONCEPTUAL`
- `CONTRADICTS`
- `UNRESOLVED`

## Main open gaps

- G1 historical Drive revision bytes and checksums;
- G2 2024→2025 continuity;
- G3 first occurrence of `0/0`, `SU`, `C_I`, SBFE and collapse;
- G4 exact notebook-to-Git derivation;
- G5 clean multi-prover builds;
- G6 Navier–Stokes repository condition ⇒ recognized critical-space control;
- G7 coercive threshold theorem;
- G8 SE'ET model parameter ⇒ certified zeta zero;
- G9 complete explicit-formula hypotheses/error terms;
- G10 end-to-end high-precision integrity;
- G11 deterministic stochastic experiments;
- G12 dimensional consistency of physical models;
- G13 external prior-art/global-priority study;
- G14 independent external review.

## Publication tracks

### Experimental mathematics

Best current fit for a rigorously bounded paper presenting experiments, exact model identities, counterexamples, and precise conjectures: **Experimental Mathematics**. The paper must explicitly distinguish proved identities, numerical evidence and conjectures.

### Formal methods

After clean Lean/Coq/Isabelle/Agda builds and a real cross-prover methodological contribution: **Journal of Automated Reasoning**.

### Navier–Stokes mathematics

Only after the critical bridge/coercivity gaps are actually closed: **Journal of Mathematical Fluid Mechanics** or a comparable specialist PDE/fluid venue.

### Research software

The audit/provenance/reproducibility software can be separated from the Millennium claims and submitted as research software, e.g. **SoftwareX**, provided the package is reusable, documented and reproducible.

## Recommended publication sequence

1. Freeze cryptographic provenance dataset and manifests.
2. Publish software/audit infrastructure.
3. Submit experimental-mathematics manuscript.
4. Complete and submit multi-prover formalization work.
5. Submit specialist NS/RH theorem manuscripts only if the classical bridges are actually discharged.

This sequence maximizes defensible authorship, citability and peer-review value without using chronology as a substitute for proof.