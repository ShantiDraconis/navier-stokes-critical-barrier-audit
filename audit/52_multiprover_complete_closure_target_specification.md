# Multiprover complete-closure target specification

## Status

This document is a **target specification**, not a proof of any open Millennium Problem.

The formal files introduced with this audit layer contain no intentional `sorry`, `admit`, or global `axiom OPEN`.  Instead, unresolved mathematics is represented by explicit package fields/hypotheses.  Consequently, a successful type-check certifies the dependency graph and composition logic only.  It does not discharge the package fields.

## Formalizations

- Lean: `formal/lean/CriticalBarrier/CompleteClosureTargets.lean`
- Coq: `formal/coq/CompleteClosureTargets.v`
- Isabelle: `formal/isabelle/Complete_Closure_Targets.thy`
- Agda: `formal/agda/CompleteClosureTargets.agda`

## Navier--Stokes target

The proposed B2 chain is split into four genuinely distinct analytic obligations:

1. Bernstein/Littlewood--Paley estimate in the exact chosen spaces;
2. Calderon--Zygmund/Riesz-transform estimate in the exact chosen spaces;
3. low-frequency strain control from the repository condition;
4. an **alignment or flux-depletion theorem** controlling the sign of the high-low-high transfer.

The fourth item cannot be inferred merely from high-frequency concentration or from the tracelessness of the strain tensor.  The previously certified scalar-residual counterexample demonstrates why scalar energy alone cannot determine signed triadic interaction.

The sign convention must also remain fixed.  If the energy identity is written

`dR/dt + D = Pi`,

then a Gronwall decay argument requires an upper control on `Pi` relative to the dissipative term, not a positive lower bound of the same sign.  Equivalently one may redefine the flux with the opposite sign, but B2.8 and B2.10 must use one convention consistently.

Therefore the formal package names the target `FluxUpperControl` rather than asserting the earlier lower-bound formula.

## Constants

The historical/proposed numerical values `C_Bern = 4`, `C_Sob = 0.62`, `C_error = 2.48`, `cstar = nu/(4 C_Sob)`, and `kappa = nu Lambda^2/4` are **not promoted to universal proved constants by this formal layer**.  Each requires a theorem with fully specified Fourier normalization, cutoff, domain, measure normalization, vector norm, and operator convention.

In particular:

- a Bernstein constant depends on the cutoff/kernel normalization;
- a Calderon--Zygmund/Riesz operator bound of exactly `1.5` is not justified merely by selecting a generic Mihlin constant;
- `0.62` is not used as a theorem-level Sobolev constant until the precise sharp/non-sharp inequality and normalization are certified;
- `Delta = 1` in Yang--Mills cannot be asserted without specifying the physical normalization/scale and constructing the theory.

## RH target

A local Arb/Rouche or argument-principle certificate can certify zeros only in the regions actually enclosed.  RH additionally requires a global theorem excluding every off-critical-line nontrivial zero.  The formal package therefore separates `LocalZeroCertification` from `GlobalOffLineExclusion`.

A fixed radius such as `r = 0.01` and decimal boundary bounds are certificate parameters, not a proof of the infinite global statement.

## P versus NP target

The open obligation is represented as `SATnotP`.  Cook--Levin/NP-completeness can then exactify the consequence to `P != NP` once the exact complexity definitions are supplied.  No exponential SAT lower bound is asserted here.

## BSD target

The package separates rank equality from the leading-coefficient part of the full BSD conjecture.  A statement only of `r_alg = r_an` does not by itself formalize the complete BSD conjecture.

## Hodge target

The native bridge is the algebraicity/surjectivity of the cycle-class map for the required rational Hodge classes.  Vanishing of an abstract scalar residue is not substituted for cycle construction.

## Yang--Mills target

The package separates:

1. construction of the required nontrivial four-dimensional quantum Yang--Mills theory satisfying the relevant axiomatic framework;
2. proof of a strictly positive spectral mass gap.

A lattice computation, Wilson-loop numerical observation, or a definition `Delta := 1` is not promoted to the Clay endpoint.

## Cross-problem theorem

The multiprover files prove only the following logical form:

> if each problem-specific closure package is inhabited by genuine proofs of its native obligations, then the corresponding endpoint propositions follow by composition.

This is intentionally weaker than claiming the packages are inhabited.

## Verification status

- Lean source: committed; requires CI/type-check before `KERNEL_VERIFIED` status.
- Coq source: committed; requires CI/type-check before verified status.
- Isabelle source: committed; current audit workflow does not execute Isabelle unless separately extended.
- Agda source: committed; current audit workflow does not execute Agda unless separately extended.

No Millennium endpoint status is changed by this target-specification commit.
