# Audit 58 — Positive Navier–Stokes Closure Chain: Formalization Plan

Audit date: 2026-09-12
Branch: `audit/final-two-stage-review-nsb2-20260912`

## Purpose

This document formalizes the positive chain that would be required to upgrade the current negative B2.9 obstruction and sign correction into a genuine Navier–Stokes regularity theorem.

It does **not** claim that the chain is proved. Every item below is classified as either:

- `VERIFIED_ARITHMETIC`: exact numerical identity already checked;
- `VERIFIED_NEGATIVE_ANCHOR`: negative obstruction/correction already established in the audit;
- `TARGET_ANALYTIC`: genuine analytic theorem still requiring proof;
- `TARGET_GLOBAL`: theorem whose proof would amount to a substantial global regularity/continuation result.

## Historical anchors

- `e00a1ac0ad10bec6d706fec3e00149af91af60dd` — B2.9 scalar-residual/Fourier-triad obstruction.
- `532c1965bc37d3b3fa2aeea5d691ce6c9fbd9d7e` — corrected sign target for B2.8.
- `f4c6a0e572a0084a6d088d46a707c0984a084c4f` — all-missing-lemmas registry.
- `f29d5cfc9d1d719706ef2c94544b1de2cb3dc898` — submission/readiness gate.
- `3481616a5b181ac575e399b673141874593e3da3` — explicit Lean TARGET chain with arithmetic isolated from PDE claims.
- `84ee342bde987672080aed7d09dfd2e3defff19d` — corrected deterministic parameter calculator using the frozen paper constants.

## Stage 0 — What is already defensible

### B2.9 negative anchor

Status: `VERIFIED_NEGATIVE_ANCHOR`.

The scalar quantity `R` does not determine the signed nonlinear interaction/flux quantity. The audit uses the explicit equal-energy / unequal-interaction example anchored at `e00a1ac0...`.

### Sign convention

Status: `VERIFIED_NEGATIVE_ANCHOR`.

The decay-compatible target is of the form

\[
R'(t)+D(t)=\Pi(t)+F(t),
\qquad
\Pi(t)\le \kappa R(t)+\mathcal E(t),
\]

not a lower bound of the form `Pi >= kappa R` under the same sign convention.

## Stage 1 — A1/A2/A3 functional-analysis prerequisites

### A1 — LP/Bernstein

Target statement:

\[
\|\Delta_j u\|_{L^p}
\le C_{\rm Bern}\,2^{3j(1/q-1/p)}\|\Delta_j u\|_{L^q}.
\]

Frozen target value:

\[
C_{\rm Bern}=4.
\]

Status: `TARGET_ANALYTIC`.

Release requirements:

1. exact dyadic cutoff `phi`;
2. exact Fourier convention;
3. exact definition of `Delta_j`;
4. exact Young-convolution theorem used;
5. rigorous bound proving the chosen kernel norm is at most `4`.

The numerical observation that one particular cutoff may have kernel `L1` norm near `3.2` is not a proof of a universal theorem.

### A2 — Calderón–Zygmund / Riesz

Target statement:

\[
\|R_iR_j f\|_{L^{3/2}}
\le C_{CZ}\|f\|_{L^{3/2}}.
\]

Frozen target value:

\[
C_{CZ}=1.5.
\]

Status: `TARGET_ANALYTIC`.

Release requirements:

1. exact Riesz-transform normalization;
2. multiplier theorem hypotheses;
3. operator norm estimate with a rigorously derived constant;
4. no inference of `1.5` merely from an informal weak-(1,1)/L2 interpolation narrative.

### A3 — Sobolev

Target statement:

\[
\|f\|_{L^6(\mathbb R^3)}\le C_S\|\nabla f\|_{L^2(\mathbb R^3)}.
\]

Frozen paper/audit value:

\[
C_S=0.62.
\]

Status: `TARGET_ANALYTIC`.

Important normalization gate:

The formula previously written as

\[
\frac{4^{1/3}}{\sqrt 3\,(2\pi)^{2/3}}
\]

numerically evaluates to approximately `0.269157...`, not `0.62`. Therefore the paper must either:

- derive `0.62` under a different, explicitly fixed convention; or
- change the frozen target constant to the actual constant implied by the chosen convention.

Until that is resolved, `0.62` is not to be labelled “sharp constant”.

## Stage 2 — B2.8 refined alignment / signed flux theorem

Target constants under the currently frozen audit convention:

\[
C_{\rm Bern}=4,
\quad C_S=0.62,
\quad C_{\rm error}=4\cdot0.62=2.48,
\]

\[
c^*(\nu)=\frac{\nu}{2.48},
\qquad
\kappa(\nu,\Lambda)=\frac{\nu\Lambda^2}{4},
\qquad
\delta=0.1.
\]

Status of these identities: `VERIFIED_ARITHMETIC` only.

Target geometric theorem:

\[
H_{\rm repo}^{\rm refined}(u,\Lambda,c^*)
+\operatorname{Concentrated}(u,\Lambda)
\Longrightarrow
\operatorname{Alignment}(u,\Lambda)\le0.9.
\]

Target signed flux theorem:

\[
\Pi_\Lambda(u)
\le
\frac{\nu\Lambda^2}{4}R_\Lambda(u)
+2.48\Lambda^{-1/2}R_\Lambda(u).
\]

Status: `TARGET_ANALYTIC`.

### Critical logical warning

The B2.9 counterexample establishes that scalar `R` alone is insufficient to determine `Pi`. It does **not** imply an alignment gap `<= 0.9`. Likewise, trace-freeness of `S_le` guarantees positive and/or negative eigen-directions according to its spectrum, but does not by itself force `u_>` to carry a fixed positive fraction in a contractive eigenspace.

Therefore the implication

\[
H_{\rm repo}^{\rm refined}+\operatorname{Concentrated}
\Rightarrow
\operatorname{Alignment}\le0.9
\]

is the principal new theorem that must actually be proved. It cannot be inferred from B2.9 alone.

## Stage 3 — Energy balance and Gronwall

Exact convention must be fixed for

\[
R_\Lambda=\frac12\|u_{>\Lambda}\|_2^2
\]

versus `R = ||u_>||_2^2`, because this changes factors in the dissipative coercivity estimate.

Target energy balance:

\[
R_\Lambda'(t)+D_\Lambda(t)=\Pi_\Lambda(t)+F_\Lambda(t).
\]

Target coercivity:

\[
D_\Lambda(t)\ge c_\nu\Lambda^2R_\Lambda(t).
\]

For the frozen test values `nu=1`, `Lambda=10`, `R=51` and the current audit convention `c_nu=1`:

\[
D=5100.
\]

With

\[
\kappa=25,
\qquad
2.48\Lambda^{-1/2}=0.7842448597...,
\]

the test-point upper bound is

\[
\Pi_{\max}=1314.9964878458...,
\]

so

\[
R'\le -3785.0035121542...
\]

at that test point.

The homogeneous damping coefficient is

\[
100-25=75,
\]

whereas if the proportional error is absorbed into the coefficient the effective test coefficient is

\[
100-25-0.7842448597...=74.2157551403....
\]

Status: arithmetic is `VERIFIED_ARITHMETIC`; PDE inequality is `TARGET_ANALYTIC`.

## Stage 4 — Critical L3 bridge

This is an independent gap and must not be collapsed into ordinary Gronwall.

A bound on an `L2`-type high-frequency residual does not by itself imply an `L3` endpoint estimate.

A valid route must control a critical quantity, for example

\[
H_J(u)=\sum_{j>J}\|\Delta_j u\|_3,
\]

or another Besov/Lorentz/critical norm sufficient to recover

\[
\sup_{t<T}\|u(t)\|_3<\infty.
\]

Status: `TARGET_ANALYTIC`.

The formula

\[
M_3\le 0.62(E_0+0.403\nu)
\]

is currently an audit target and numerical consequence of frozen constants, not a proved endpoint theorem.

## Stage 5 — ESS continuation

Target: a precise formal theorem corresponding to the Escauriaza–Seregin–Šverák endpoint regularity criterion, with:

- the exact solution class;
- the spatial domain;
- the maximal-lifespan definition;
- the exact `L^infty_t L^3_x` hypothesis;
- the continuation conclusion.

Status: `TARGET_GLOBAL`.

A finite `L^3_t L^3_x` integral is not interchangeable with a uniform `L^infty_t L^3_x` bound unless an additional theorem provides that implication.

## Full dependency chain

```text
e00a1ac0...  B2.9 scalar residual obstruction         VERIFIED
532c196...   sign correction                         VERIFIED
        |
        v
A1 LP/Bernstein C=4                                 TARGET
A2 CZ/Riesz C=1.5                                   TARGET
A3 Sobolev convention / constant                    TARGET
        |
        v
Alignment gap delta=0.1                             TARGET (principal new theorem)
        |
        v
B2.8 signed flux upper bound                        TARGET
        |
        v
Energy balance + coercivity                         TARGET
        |
        v
Gronwall                                             standard once hypotheses are proved
        |
        v
critical L3 / critical-tail bridge                  TARGET (independent major gap)
        |
        v
ESS endpoint continuation                           TARGET_GLOBAL
        |
        v
T* = infinity / global regularity                   NOT ESTABLISHED
```

## Release gate

No file may be renamed `*_CLOSED.lean` merely because it compiles. To be classified `CLOSED`, the theorem must have:

1. no `sorry`;
2. no `axiom` in its transitive dependency chain except standard foundational axioms explicitly allowed by the project;
3. no theorem whose conclusion was built into a definition;
4. exact constants under exact conventions;
5. successful clean `lake build` on the exact SHA;
6. a dependency audit showing no hidden TARGET theorem;
7. independent review of the mathematical implication, especially the Alignment and critical-L3 steps.

## Current conclusion

The branch now contains a reproducible specification of the entire positive closure route, but the following remain genuinely open inside this project:

- LP constant `4` under a concrete cutoff;
- CZ constant `1.5`;
- Sobolev normalization yielding `0.62`;
- `Alignment <= 0.9` from the proposed PDE hypotheses;
- the signed-flux theorem B2.8;
- the critical-L3 bridge;
- the ESS formalization/continuation theorem.

The strongest currently verified mathematical result in this chain remains the B2.9 negative obstruction plus the corrected sign architecture.
