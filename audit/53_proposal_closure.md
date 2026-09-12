# Proposal 53 — Closure Work Packages

Audit date: 2026-09-12  
Repository: `ShantiDraconis/navier-stokes-critical-barrier-audit`

## Verified starting anchors

- `e00a1ac0ad10bec6d706fec3e00149af91af60dd` — **formal: certify scalar residual insufficiency by exact Fourier triad algebra**. This is the verified B2.9 obstruction anchor.
- `532c1965bc37d3b3fa2aeea5d691ce6c9fbd9d7e` — **audit: record B2.9 Fourier counterexample and correct B2.8 sign target**. This is the verified sign-correction anchor.
- `76506335bac994aaef3d63fc1f3428984b4017bf` — **ci: verify axiom-free B2 scalar residual counterexample**. This is the CI-oriented verification anchor for the scalar-residual counterexample.

The shorthand `51_...` previously used in notes is not used here as a citation because the full verified SHA is `532c1965bc37d3b3fa2aeea5d691ce6c9fbd9d7e`.

## Scientific boundary

This document is a proposal, not a proof. It freezes the remaining work packages after two defensible steps:

1. scalar residual insufficiency has an exact algebraic/Fourier counterexample;
2. the energy identity sign convention has been corrected so dissipative closure uses an upper bound on the signed flux term.

No work package below may be marked CLOSED until the relevant theorem is proved without `sorry`, `axiom ..._OPEN`, `True`, or equivalent placeholders and independently rebuilt.

## Frozen target constants

- `C_Bernstein = 4`
- `C_Sobolev_R3 = 0.62`
- `C_error = 2.48`
- `kappa(ν,Λ) = ν Λ^2 / 4`
- `delta_alignment = 0.1`
- proposed `cstar ≈ 0.403 ν`
- RH target radius `r = 0.01`
- YM target normalization `Delta = 1`

These constants are **research targets**, not certified sharp constants.

# WP1 — Refined B2.8 alignment / signed flux control

## Goal

Derive, under an explicit refined repository hypothesis and explicit alignment condition,

\[
\Pi_\Lambda(u)
\le
\kappa_\Lambda R_\Lambda(u)
+
C_{\rm error}\Lambda^{-1/2}R_\Lambda(u),
\qquad
\kappa_\Lambda=\frac{\nu\Lambda^2}{4},
\quad C_{\rm error}=2.48.
\]

This is the sign convention consistent with

\[
\frac{d}{dt}R_\Lambda + D_\Lambda = \Pi_\Lambda + F_\Lambda.
\]

## Proposed object

\[
\operatorname{Alignment}(u,\Lambda)
=
\frac{\langle u_>,S_{\le\Lambda}u_>\rangle}
{\|S_{\le\Lambda}\|\,\|u_>\|^2}.
\]

Proposed hypothesis:

\[
\operatorname{Alignment}(u,\Lambda)\le 1-\delta,
\qquad \delta=0.1.
\]

## Lean deliverables

- `formal/lean/CriticalBarrier/B2_8_Alignment.lean`
- concrete LP projections and support lemmas;
- Bony/paraproduct decomposition;
- Bernstein estimate with the constant convention used by the project;
- Calderón–Zygmund/Riesz pressure estimate;
- theorem deriving low-frequency strain control from `HRepo_refined`;
- theorem deriving the alignment gap from the refined hypothesis;
- final theorem `B2_8_CLOSED_REFINED` with no placeholders.

## Numerical target check only

For the normalization `ν=1`, `Λ=10`:

\[
D=\nu\Lambda^2R=100R,
\qquad
\kappa R=25R,
\]

and

\[
2.48\Lambda^{-1/2}R
\approx
2.48/\sqrt{10}\,R
\approx0.784R.
\]

Thus a sign-consistent differential inequality of the form

\[
R'\le(25+0.784-100)R
\]

would yield

\[
R'\le -74.216R.
\]

This calculation is only a target sanity check. It does not prove the analytic hypotheses producing the inequality.

# WP2 — B2.10 Gronwall + B2.12 ESS endpoint

## B2.10 target

Given

\[
R'+D\le \Pi+F,
\qquad
D\ge c_\nu\Lambda^2R,
\qquad
\Pi\le\kappa R+E,
\]

with

\[
a:=c_\nu\Lambda^2-\kappa>0,
\]

prove

\[
R(T)
\le
R(0)e^{-aT}
+
\int_0^T e^{-a(T-s)}(E(s)+F(s))\,ds.
\]

## Critical-space bridge

The audit already establishes that scalar `L2` residual control alone is insufficient for the critical `L3` endpoint. Therefore the valid positive target must control a critical tail, Besov quantity, or another endpoint-equivalent object. A proposed tail is

\[
H_J(u)=\sum_{j>J}\|\Delta_j u\|_3.
\]

The target is

\[
\text{NS dynamics + refined H}
\Longrightarrow
\sup_{t<T}H_J(u(t))<\infty,
\]

then

\[
\sup_{t<T}\|u(t)\|_3<\infty.
\]

## B2.12 target

Formalize or import an exact theorem corresponding to the Escauriaza–Seregin–Šverák endpoint continuation criterion with all hypotheses explicit:

\[
u\in L^\infty(0,T;L^3(\mathbb R^3))
\Longrightarrow
\text{continuation / no finite-time singularity at }T.
\]

No local shorthand such as `M3 < ∞ → T*=∞` may be used without fixing the precise solution class and continuation statement.

# WP3 — RH G8 certified zero localization

## Goal

Build a rigorous numerical certificate around a model zero using interval arithmetic and an argument-principle/Rouché step.

Target parameters presently frozen for testing:

- radius `r = 0.01`;
- model-center residual target `|ζ(ρ_model)| ≤ 10^-30`;
- boundary nonvanishing target `|ζ(s)| ≥ 10^-20`.

These numbers by themselves do not prove RH. Even a certificate for the first `10^6` zeros proves only the verified finite range. A global RH theorem still requires a global argument excluding all off-line zeros.

## Deliverables

- rigorous Arb/ball arithmetic script with reproducible version metadata;
- proof/certificate of boundary nonvanishing for every certified disk;
- zero-count certificate by argument principle/Rouché;
- explicit bridge explaining what finite verified ranges establish and what remains global.

# WP4 — Yang–Mills G16 constructive QFT + mass gap

## Goal

Construct the Euclidean theory and prove a positive spectral gap from first principles.

## Deliverables

- lattice Yang–Mills measure;
- controlled continuum limit;
- Osterwalder–Schrader axioms, including reflection positivity;
- Hilbert-space reconstruction;
- Hamiltonian and spectral theorem setup;
- a proved mechanism implying a positive mass gap.

`Delta = 1` is to be treated only as a target normalization unless derived after fixing units. An area-law statement does not automatically equal a mass-gap theorem without the required bridge.

# Other Millennium targets

`P vs NP`, `BSD`, and `Hodge` remain open without a currently validated closure route in this repository. They must not be represented as nearer to closure merely because they can be stated as `Residue = 0/1` targets.

# Dependency graph

```text
B2.9 scalar-residual obstruction
  e00a1ac0ad10bec6d706fec3e00149af91af60dd
          |
          v
sign-corrected B2.8 target
  532c1965bc37d3b3fa2aeea5d691ce6c9fbd9d7e
          |
          v
WP1: alignment / flux-control theorem
          |
          v
WP2: Gronwall + critical-tail bridge + ESS
          |
          v
NS closure candidate

parallel:
WP3 RH certified-zero program
WP4 YM constructive-QFT / gap program
```

# Release gate

A work package changes from `TARGET` to `CLOSED` only when all of the following are true:

1. theorem has no `sorry`, no `axiom ..._OPEN`, no `True` placeholder;
2. every analytic constant used by the theorem is either derived or clearly assumed;
3. all function spaces and domains are explicit;
4. sign conventions are frozen and internally consistent;
5. exact commit SHA is recorded;
6. exact CI/build artifact is archived;
7. an independent second-pass review reproduces the theorem or identifies no circular assumption;
8. no statement stronger than the actually proved theorem is promoted in `README`, `STATUS`, or certificates.
