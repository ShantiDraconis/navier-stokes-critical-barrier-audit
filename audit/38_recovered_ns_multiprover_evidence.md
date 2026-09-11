# Recovered Navier–Stokes multiprover evidence — forensic peer-review classification

Audit date: 2026-09-11
Scope: historical GitHub evidence recovered from the ShantiDraconis Codespace/repository lineage.

## Executive finding

The historical `millennium-navier-stokes-I` lineage contains two materially different formal layers that must not be conflated:

1. a **non-vacuous algebraic Cᵢ layer** implemented independently in Lean 4, Coq and Isabelle/HOL; and
2. a **Navier–Stokes global-regularity/collapse layer** that is explicitly a prototype/skeleton and contains assumptions, `True` placeholders, axioms and/or `sorry`.

Accordingly, the recovered material is strong provenance evidence for an early multiprover formalization program, but it is not evidence of a completed formal proof of the Clay Navier–Stokes problem.

## Historical anchor

Repository: `ShantiDraconis/millennium-navier-stokes-I`

Recovered merge anchor:

`63b248dd29f1817c457acdb00e116e2e9b0687cc`

Commit message:

`Merge pull request #3 from ShantiDraconis/copilot/formal-framework-navier-stokes`

`[WIP] Add formal framework for Navier–Stokes collapse theory`

The commit tree preserves a large non-empty corpus including documentation, Python implementations, Lean, Coq, Isabelle/HOL, numerical solvers, tests, and LaTeX. Relevant exact historical blobs include:

- `src/lean/CI_numbers.lean` — blob `4d893952dea2b2590846dfb85dda4e4c543c95b5`, 3252 bytes
- `src/lean/collapse_axioms.lean` — blob `e1b80f88192d9ea650b55db95cd3e9315c39ede0`, 2990 bytes
- `src/lean/global_existence.lean` — blob `a784cc948b1a0c0c2723b1d43e5b767be1e41299`, 3261 bytes
- `src/coq/CI.v` — blob `d2d8a47563da386f129a4dd90f9c5c6482364941`, 3526 bytes
- `src/coq/GlobalExistence.v` — blob `357a206545ef8321f6e55dc581d46a54b4cb3e38`, 4215 bytes
- `src/isabelle/CI.thy` — blob `6d2e0bb69da09d696283adaf94f86ecb3a015930`, 3608 bytes
- `src/isabelle/GlobalExistence.thy` — blob `27b635859e040f75b0c70f3c4bdfe6ce884b9d73`, 3068 bytes
- `src/formalization/NS_collapse.lean` — blob `f2740aa2a5fa6b0109a792cae8e0581ac24c3dd7`, 9481 bytes
- `docs/COMPLETE_FORMULATION.md` — blob `b59efda38554c8d1ddd0a626137009451ac136ce`, 14721 bytes
- `docs/FORMAL_FOUNDATIONS.md` — blob `124422d1ee08aaad6cea2632d6553dc4f0e4d668`, 11628 bytes
- `docs/latex/energy_theory.tex` — blob `91a0710fef53a7d635f1ff120825e16260eaf58c`, 17086 bytes
- `latex/navier-stokes-I.tex` — blob `a9f9946436c89eb9d38902e0407bbc01e746dc8c`, 22222 bytes

## A. Cᵢ algebraic layer

### Lean 4

`src/lean/CI_numbers.lean` defines the triple `CINumber = (z,a,s)` over `ℂ`, distinguished elements `I=(0,1,0)` and `S=(0,0,1)`, addition, negation, multiplication, numeric classes, an I-norm, and proves:

- `I_mul_I : I * I = S`
- `I_isAnomalous : isAnomalous I`
- `S_isCollapsed : isCollapsed S`
- `critical_iso_complex`

No `sorry` is visible in this recovered file. Classification: `FORMAL_PROOF_SOURCE_PRESENT / BUILD_NOT_YET_INDEPENDENTLY_VERIFIED`.

### Coq

`src/coq/CI.v` mirrors the triple construction and contains completed `Qed` proofs for:

- `I_mul_I`
- `I_is_anomalous`
- `S_is_collapsed`
- `critical_iso_complex`

No `Admitted` is visible in this recovered file. Classification: `FORMAL_PROOF_SOURCE_PRESENT / BUILD_NOT_YET_INDEPENDENTLY_VERIFIED`.

### Isabelle/HOL

`src/isabelle/CI.thy` defines `ci_number`, lifted operations and proves:

- `I_mul_I`
- `I_is_anomalous`
- `S_is_collapsed`
- `critical_iso_complex`

No `sorry`/`oops` is visible in this recovered file. Classification: `FORMAL_PROOF_SOURCE_PRESENT / BUILD_NOT_YET_INDEPENDENTLY_VERIFIED`.

### Cross-language equivalence

The three sources encode the same principal algebraic multiplication law

`(z₁,a₁,s₁)(z₂,a₂,s₂) = (z₁z₂, z₁a₂+z₂a₁, z₁s₂+z₂s₁+a₁a₂)`

and the same distinguished elements. The relation between these files is therefore provisionally classified `SYNTACTIC_TRANSLATION / SAME_DECLARED_MODEL`, pending a complete AST/semantic comparison.

This establishes historical multiprover implementation of the symbolic algebraic model. It does **not** establish that the model is a conservative extension of classical complex analysis, nor that it proves a PDE regularity theorem.

## B. Collapse-axiom layer

`src/lean/collapse_axioms.lean` encodes the intended assumptions as structure fields. In particular, `Axiom4Collapse` contains the desired implication from enstrophy divergence to convergence of the symbolic parameter to a collapsed state. These are requirements needed to construct a `CollapseAxioms` instance. They are not proofs that Navier–Stokes dynamics satisfies those requirements.

Classification:

`SPECIFICATION / ASSUMPTION_PACKAGE / NOT_A_PROOF_OF_THE_PDE_BRIDGE`.

## C. Global-existence layer

### Lean

`src/lean/global_existence.lean` explicitly calls itself a proof skeleton. It contains multiple `True` placeholders and ends the principal theorem with `sorry`.

Classification:

`PLACEHOLDER + INCOMPLETE + ASSUMPTION_BASED`.

### Coq

`src/coq/GlobalExistence.v` encodes Axiom 4 with a final `True` placeholder, collapse and regularity lemmas as `True -> True`, and a `global_existence` theorem whose substantive conclusions are `True` conjunctions and whose witness is `fun t => 0`.

Classification:

`VACUOUS_FORMALIZATION / PLACEHOLDER`, not a proof of global regularity.

### Isabelle/HOL

`src/isabelle/GlobalExistence.thy` similarly uses `True` for the collapse conclusions, regularity lemma, initial H1 condition and the conjunction advertised as global/smooth/finite-energy/no-blow-up.

Classification:

`VACUOUS_FORMALIZATION / PLACEHOLDER`, not a proof of global regularity.

### Prototype NS_collapse.lean

`src/formalization/NS_collapse.lean` explicitly states that it is a prototype/sketch and not a complete formalization. It introduces numerous primitives as `axiom`, assumes the classical energy identity/inequality and BKM criterion, adds `NS_collapse_axiom`, and retains `sorry` in crucial implications.

Classification:

`FORMAL_PROTOTYPE / AXIOMATIC / INCOMPLETE`.

## D. PR chronology recovered

The repository's PR record gives additional historical evidence:

- PR #3: `[WIP] Add formal framework for Navier–Stokes collapse theory`; it explicitly reports creation of Lean, Coq and Isabelle formal proof **stubs**.
- PR #6: created `2025-11-25T04:06:42Z`, merged `2025-11-25T15:43:40Z`, merge commit `d8c83f59088ba58af6a121067999c4e275cc5256`; added classical energy inequalities, `Φ_NS`, and a formalization prototype.
- PR #7: created `2025-11-25T04:07:04Z`, merged `2025-11-25T15:37:49Z`, merge commit `12f8b424646fba8e278a99f7cf350f3d2c7eb09e`; explicitly identified the analytical collapse lemma as `Gap 3 - CRITICAL` and documented six gaps.

These PRs are important because the historical project itself distinguished implementation/prototype/gap status. Later audit language must preserve that distinction.

## E. Build/certificate status

No GitHub Actions workflow run was returned for historical commit `63b248dd...` by the available commit-workflow query. Therefore no kernel/build certificate is asserted here for that exact commit.

Current status for the Cᵢ source files is:

`SOURCE_PRESENT; PROOF_TERMS/TEXT_PRESENT; INDEPENDENT_BUILD_PENDING`.

A file must not be upgraded to `FORMAL_PROOF_CHECKED` until the exact historical source is built with a documented Lean/Mathlib, Coq/Coquelicot, or Isabelle version and the build log/hash is preserved.

## F. Trans preservation

The exact historical `src/lean/CI_numbers.lean` has been copied into the Trans forensic branch under its source commit namespace. Its source blob is `4d893952...`. Coq and Isabelle counterparts are also being preserved under the same source-commit namespace.

The archive path convention is:

`FORENSIC_RECOVERY/sources/<repository>/<source-commit>/<original-path>`

No historical source repository is modified by this recovery process.

## G. Peer-review verdict

The strongest defensible statement at this stage is:

> By the recovered `63b248dd...` snapshot, the project had a concrete multiprover implementation of its symbolic Cᵢ algebra in Lean 4, Coq and Isabelle/HOL, together with a much broader Navier–Stokes collapse/global-regularity program. The algebraic lemmas have non-vacuous proof source, but independent historical-toolchain builds remain pending. The claimed PDE/global-regularity layer was explicitly incomplete, assumption-dependent and/or vacuous in the recovered formal files, and the contemporaneous documentation identified critical analytical gaps.

This is repository provenance, not a claim of worldwide mathematical priority and not a claim that Navier–Stokes has been solved.
