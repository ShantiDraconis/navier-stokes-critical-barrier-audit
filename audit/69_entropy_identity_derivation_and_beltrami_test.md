# Audit 69 — Entropy identity derivation and Beltrami falsification test

Date: 2026-09-13

## Claim under test

The proposed Perelman-like Navier--Stokes entropy architecture asked whether one can derive

\[
\frac{d}{dt}\mathcal W_{NS}
=
\int |\mathfrak D_{NS}|^2 e^{-f}\,dx\ge 0
\]

from

\[
f_t=-\Delta f+|\nabla f|^2-Q,
\qquad Q=Q_{\rm joint}.
\]

This audit tests the naive choice

\[
W_0=\int (|\nabla f|^2+Q)e^{-f}\,dx.
\]

It does not assume the desired square identity.

## Step 1 — density evolution

Set

\[
\rho=e^{-f}.
\]

Then

\[
\nabla\rho=-\rho\nabla f,
\qquad
\Delta\rho=\rho(|\nabla f|^2-\Delta f).
\]

Therefore

\[
\rho_t=-\rho f_t
=\rho(\Delta f-|\nabla f|^2+Q)
=-\Delta\rho+Q\rho.
\]

Thus the candidate density satisfies a backward-heat-plus-potential equation rather than a probability-preserving conjugate heat equation unless further normalization terms are introduced.

## Step 2 — derivative of Fisher part

Define

\[
I=\int |\nabla f|^2\rho\,dx.
\]

Under smooth periodic data, or sufficient decay so all boundary terms vanish, differentiation and integration by parts yield

\[
I'
=
2\int |\nabla^2 f|^2\rho\,dx
+
\int\left(Q|\nabla f|^2-2\Delta Q\right)\rho\,dx.
\]

This is already not a pure square because of the Q-dependent remainder.

## Step 3 — derivative of the potential part

Let

\[
V=\int Q\rho\,dx.
\]

Using \(\rho_t=-\Delta\rho+Q\rho\),

\[
V'
=
\int (Q_t-\Delta Q+Q^2)\rho\,dx.
\]

Therefore

\[
\boxed{
W_0'
=
2\int |\nabla^2 f|^2\rho\,dx
+
\int
\bigl(
Q_t+Q^2+Q|\nabla f|^2-3\Delta Q
\bigr)\rho\,dx
}.
\]

Define the uncompensated remainder

\[
R_Q
:=
Q_t+Q^2+Q|\nabla f|^2-3\Delta Q.
\]

The desired monotonicity does not follow unless \(R_Q\) is controlled or cancelled by additional structure.

## Step 4 — exact Beltrami Navier--Stokes test

Work on \(\mathbb T^3\) and define

\[
u(x,t)=A e^{-\nu t}(\sin z,\cos z,0).
\]

Then

\[
\nabla\cdot u=0,
\qquad
\nabla\times u=u,
\qquad
\Delta u=-u,
\]

and the nonlinear term is compatible with pressure, so this is a smooth exact decaying Navier--Stokes solution.

Hence

\[
\omega=u,
\qquad
|\omega|=A e^{-\nu t},
\qquad
\xi=(\sin z,\cos z,0),
\qquad
|\nabla\xi|^2=1.
\]

For this configuration the positive strain-direction contribution vanishes:

\[
\xi\cdot S\xi=0.
\]

Thus, for the directional component used in the proposed joint diagnostic,

\[
Q=Q_{\rm joint}=A^2e^{-2\nu t}.
\]

Take f spatially constant. The f-equation reduces to

\[
f_t=-Q,
\]

so

\[
\rho_t=Q\rho.
\]

The naive entropy is

\[
W_0=\operatorname{Vol}(\mathbb T^3)Q\rho.
\]

Since

\[
Q'=-2\nu Q,
\]

we obtain

\[
\boxed{
W_0'
=
\operatorname{Vol}(\mathbb T^3)\rho\,Q(Q-2\nu)
}.
\]

Therefore

\[
0<Q<2\nu\Longrightarrow W_0'<0,
\]

\[
Q=2\nu\Longrightarrow W_0'=0,
\]

\[
Q>2\nu\Longrightarrow W_0'>0.
\]

For

\[
\nu=0.01,
\qquad
A=0.1,
\]

we have

\[
Q(0)=A^2=0.01,
\qquad
2\nu=0.02,
\]

and hence

\[
Q(0)(Q(0)-2\nu)
=0.01(0.01-0.02)
=-10^{-4}<0.
\]

The pure monotonicity claim for this naive W0 is therefore falsified by a smooth exact solution.

## What survives

The falsification does **not** exclude a corrected functional

\[
\mathcal W_{NS}
=
\int
\bigl(|\nabla f|^2+Q+\Psi\bigr)\rho\,dx.
\]

A legitimate correction must be specified independently and derived from the PDE. It must satisfy, after differentiation,

\[
2|\nabla^2f|^2+R_Q+\mathcal L_\rho\Psi
=
|\mathfrak D_{NS}|^2
\]

pointwise or after integration, with all boundary/normalization terms justified. Defining \(\Psi\) after observing \(R_Q\) solely to force the equality is circular and is not accepted as a proof.

## Formal certificate scope

`formal/lean/CriticalBarrier/EntropyObstruction.lean` formalizes only the sign polynomial

\[
q(q-2\nu)
\]

in the subcritical, threshold, and supercritical regimes. It does not claim to formalize the full Navier--Stokes PDE or the integration-by-parts derivation.

`tests/test_entropy_identity.py` numerically checks the exact sign regimes and the ODE \(Q'=-2\nu Q\).

## Status

```text
NAIVE_W0_MONOTONICITY = FALSIFIED
BELTRAMI_SIGN_OBSTRUCTION = ALGEBRAICALLY_FORMALIZED
FULL_PDE_DERIVATION = HAND_DERIVATION / FORMALIZATION_PENDING
PSI_CORRECTED_ENTROPY = OPEN_ANALYTIC_LEMMA
PERELMAN_LIKE_NS_ENTROPY = NOT_ESTABLISHED
GLOBAL_REGULARITY = NOT_ESTABLISHED
```

This is a negative result that improves the proof architecture: the naive entropy object cannot be promoted into the `25 -> 3 -> 1` compression. Any surviving entropy object must contain additional normalization/correction structure and pass this Beltrami test.
