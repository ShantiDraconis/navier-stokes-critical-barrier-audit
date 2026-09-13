# Audit 69 — Critical-loop signature, flexible G1 closure, and loss-of-margin diagnostics

Status: **CONDITIONAL CLOSURE DERIVED; ACTUAL-NS → G1 REMAINS OPEN**  
Date: 2026-09-13

## 1. Scope and non-claim

This note records the exact calculation that breaks the enstrophy loop **if** the Navier–Stokes dynamics supply a flexible signed stretching control. It does **not** upgrade the open PDE bridge to a proof of unconditional regularity.

The open arrow remains

\[
\mathrm{ActualNS}\Longrightarrow G1_{\mathrm{flex}}.
\]

Everything after that arrow is a conditional consequence.

## 2. Variables and exact enstrophy balance

Let

\[
y(t):=\|\omega(t)\|_{L^2}^2,\qquad
z(t):=\|\nabla\omega(t)\|_{L^2}^2,
\]

and

\[
\mathcal S(t):=\int_{\mathbb R^3}\omega(x,t)\cdot S(x,t)\omega(x,t)\,dx.
\]

For a smooth incompressible solution on \([0,T^*)\),

\[
\frac12y'(t)+\nu z(t)=\mathcal S(t).
\tag{E}
\]

## 3. Flexible G1 hypothesis

The useful non-circular target is not necessarily the rigid fixed-\(\delta\) inequality. It is enough to derive from the PDE a bound of the form

\[
\boxed{\mathcal S(t)\le \theta\,\nu z(t)+a(t)y(t)}
\tag{G1-flex}
\]

with

\[
0\le\theta<1,
\qquad
a(t)\ge0,
\qquad
\int_0^{T^*}a(t)\,dt<\infty.
\tag{H}
\]

The coefficient

\[
(1-\theta)\nu
\]

is the surviving dissipative margin.

## 4. Exact closure calculation

Insert (G1-flex) into (E):

\[
\frac12y'(t)+(1-\theta)\nu z(t)\le a(t)y(t).
\tag{1}
\]

Dropping the nonnegative dissipation term gives

\[
y'(t)\le2a(t)y(t).
\tag{2}
\]

Hence Grönwall yields, for every \(t<T^*\),

\[
\boxed{
y(t)\le y(0)\exp\!\left(2\int_0^t a(s)\,ds\right).
}
\tag{3}
\]

If

\[
A_*:=\int_0^{T^*}a(s)\,ds<\infty,
\]

then

\[
\sup_{t<T^*}y(t)\le y(0)e^{2A_*}<\infty.
\tag{4}
\]

Thus the loop is broken **conditionally** by an integrable coefficient that does not require the desired enstrophy bound to be assumed in advance.

## 5. Integrated dissipation estimate

Equation (1) also implies

\[
(1-\theta)\nu\int_0^t z(s)\,ds
\le
\frac12y(0)+\int_0^t a(s)y(s)\,ds.
\]

Using (3),

\[
\int_0^t a(s)y(s)\,ds
\le
\frac{y(0)}2\left(e^{2\int_0^t a}-1\right),
\]

so

\[
\boxed{
(1-\theta)\nu\int_0^t z(s)\,ds
\le
\frac{y(0)}2e^{2\int_0^t a(s)\,ds}.
}
\tag{5}
\]

Equivalently,

\[
\boxed{
\int_0^t z(s)\,ds
\le
\frac{y(0)}{2(1-\theta)\nu}
\exp\!\left(2\int_0^t a(s)\,ds\right).
}
\tag{6}
\]

This formula exposes the two failure channels separately:

1. **margin collapse:** \(\theta\uparrow1\), causing \((1-\theta)^{-1}\to\infty\);
2. **Grönwall growth:** \(\int a\uparrow\infty\), causing \(e^{2\int a}\to\infty\).

## 6. Critical \(L^3\) consequence

Let

\[
E_0:=\|u_0\|_{L^2}^2.
\]

Energy control gives

\[
\|u(t)\|_2\le E_0^{1/2}.
\]

For divergence-free fields on \(\mathbb R^3\), Sobolev plus the div–curl identity give

\[
\|u(t)\|_6\le C_S\|\nabla u(t)\|_2
\lesssim C_S\|\omega(t)\|_2.
\]

Interpolation therefore yields

\[
\|u(t)\|_3
\le
\|u(t)\|_2^{1/2}\|u(t)\|_6^{1/2}
\le
C E_0^{1/4}y(t)^{1/4}.
\tag{7}
\]

Combining with (3),

\[
\boxed{
\|u(t)\|_3
\le
C E_0^{1/4}y(0)^{1/4}
\exp\!\left(\frac12\int_0^t a(s)\,ds\right).
}
\tag{8}
\]

Thus \(a\in L^1(0,T^*)\) gives a uniform \(L^\infty_tL^3_x\) bound. The endpoint continuation theorem may then be invoked after checking its hypotheses.

## 7. Diagnostic control table

| Control regime | Dissipative margin | Grönwall factor | Audit consequence |
|---|---:|---:|---|
| \(0\le\theta<1\), \(A_*<\infty\) | positive | finite | conditional closure |
| \(\theta\uparrow1^-\), \(A_*<\infty\) | tends to 0 | finite | enstrophy can remain bounded, but integrated \(z\)-bound degenerates |
| \(\theta=1\), \(A_*<\infty\) | zero | finite | Grönwall controls \(y\), but no positive dissipation remains in (1) |
| \(\theta>1\) | negative | finite or infinite | absorption fails |
| \(0\le\theta<1\), \(A_*\to\infty\) | positive | diverges | no uniform enstrophy bound from this route |
| \(\theta\uparrow1^-\), \(A_*\to\infty\) | collapses | diverges | both mechanisms fail |

The main quantitative quantities to monitor are therefore

\[
M_{\mathrm{diss}}:=(1-\theta)\nu,
\qquad
G(t):=\exp\!\left(2\int_0^t a(s)\,ds\right).
\]

## 8. Why the naive amplitude-invariant closure fails

For amplitude scaling \(u\mapsto Au\),

\[
\mathcal S(Au)=A^3\mathcal S(u),
\qquad
z(Au)=A^2z(u).
\]

Therefore a conclusion of the rigid form

\[
\mathcal S\le(1-\delta)\nu z
\]

cannot follow from a hypothesis that is completely amplitude-invariant unless additional information restricts the allowed amplitudes. Algebraically,

\[
A^3\mathcal S_0\le(1-\delta)\nu A^2z_0
\]

requires

\[
A\le \frac{(1-\delta)\nu z_0}{\mathcal S_0}
\]

when \(\mathcal S_0>0\). This is the precise obstruction behind Attack B.

The flexible form (G1-flex) identifies what is missing: either the geometric hypothesis must carry amplitude information, or the residual stretching must be absorbed into an explicitly integrable coefficient \(a(t)y(t)\).

## 9. Circularity test for candidate formulas for \(a(t)\)

A candidate \(a(t)\) is useful only if its time integrability is proved independently of the target enstrophy bound.

Bad example:

\[
a(t)\sim y(t)^2.
\]

Then the condition \(a\in L^1\) requires \(\int y^2<\infty\), which is not supplied by the basic energy inequality and risks re-importing the desired regularity.

Potentially useful target:

\[
a(t)\le C\,y(t)
\]

because for Leray–Hopf energy solutions

\[
\int_0^T y(t)\,dt
=
\int_0^T\|\omega(t)\|_2^2dt
\lesssim
\frac{\|u_0\|_2^2}{2\nu}
\]

under the standard whole-space div–curl normalization. Such a bound would make \(a\in L^1\) follow from the energy budget rather than from the sought-after enstrophy supremum.

However, **the audit does not currently derive** the estimate \(a(t)\le Cy(t)\) from the proposed coherence quantities. That derivation is part of the open bridge.

## 10. Zero-denominator branches

The recurring \(0/0\) situations are bookkeeping singularities that must be separated from the true PDE bridge:

- \(\xi=\omega/|\omega|\) at \(\omega=0\);
- ratios defining \(\rho_*\) when both numerator and denominator vanish;
- weighted tail ratios \(N_j/D_j\) when \(D_j=0\).

Regularization or degenerate-branch definitions are acceptable only when accompanied by a uniform dominating estimate and a proof that the branch does not inject hidden regularity assumptions.

These repairs do **not** prove ActualNS → G1-flex.

## 11. Critical-loop signature

For the Navier–Stokes audit, the recurring formal pattern can be recorded as

```text
CriticalSignature:
  scale_inv  : F(λX) = F(X)        -- scale-invariant ratio
  self_ref   : X = G(X) / H(X)     -- quantities built from the same unknown
  zero_div   : H = 0 and G = 0     -- degenerate 0/0 branch
  amplitude  : stretching ~ A^3, dissipation ~ A^2
```

This is an **audit taxonomy**, not a theorem of equivalence among mathematical problems.

## 12. Cross-problem analogy: heuristic only

Several Clay problems involve criticality, scale invariance, degeneracy, or self-reference in very different technical senses. It is legitimate to use those similarities as a research heuristic, but the audit must not state that all seven Millennium problems possess the same proven \(\kappa,\varepsilon,\theta\) mechanism or the same \(0/0\) obstruction.

In particular:

- Navier–Stokes has a precise PDE scaling and a cubic-vs-quadratic stretching/dissipation amplitude test.
- Yang–Mills has classical scale invariance and a quantum mass-gap problem, but this is not the same inequality as (G1-flex).
- Riemann’s critical line is not mathematically an \(A^3\)-versus-\(A^2\) balance.
- P vs NP does not reduce to a literal \(2^n/n^k\) self-referential fixed-point equation.
- Poincaré is solved and its topology should not be represented as a norm-ratio closure problem.

Therefore the phrase “same signature” is retained only as a **comparative heuristic label**, not as evidence for a proof or universal constant.

## 13. Status of empirical coherence constants

Observed stabilization of quantities such as

\[
\Phi:=\frac{C_H}{\sqrt\kappa}
\]

or numerical values near \(O(1)\) is evidence about the tested data set only. A value such as \(\Phi\approx0.6\) does not by itself imply the sub-viscous inequality required in G1-flex, because the coefficient must be quantitatively matched against viscosity, the signed Biot–Savart structure, exceptional tails, localization errors, and amplitude dependence.

Accordingly:

```text
rho_j componentwise              = OBSERVED
CH95 stability                    = OBSERVED
Uniform CH95 -> weighted kernel   = OPEN
weighted kernel -> G1-flex        = OPEN
ActualNS -> terminal coherence    = OPEN
G1-flex -> Gronwall closure       = PROVED CONDITIONAL ANALYSIS
unconditional regularity          = NOT ESTABLISHED
```

## 14. Attack matrix update

### Attack A — ActualNS → coherence

A divergence-free field with bad coherence is not enough. A genuine refutation must arise along an actual Navier–Stokes evolution satisfying the antecedent assumptions.

### Attack B — amplitude

Any amplitude-invariant KWC-type antecedent is insufficient by itself to force a rigid cubic-to-quadratic absorption estimate uniformly in \(A\). This is an algebraic obstruction, not yet a counterexample to every possible geometry-to-G1 theorem.

### Attack C — percentile-to-weighted control

A percentile bound such as CH95 does not control a Biot–Savart-weighted tail unless one proves that the exceptional set carries sufficiently small **weighted** mass. A 5% geometric tail can dominate a singular weighted integral.

The correct missing hypothesis has the schematic form

\[
\eta(r,t):=
\frac{\iint_{E_r}W}{\iint_{\mathrm{annulus}}W}
\ll1,
\]

with all denominators and degenerate cases handled explicitly.

## 15. Final logical DAG

\[
\mathrm{ActualNS}
\dashrightarrow
\mathrm{terminal\ quantitative\ geometry}
\dashrightarrow
G1_{\mathrm{flex}}
\Longrightarrow
\begin{cases}
\sup_{t<T^*}y(t)<\infty,\\
\|u\|_{L^\infty_tL^3_x}<\infty,
\end{cases}
\Longrightarrow
\mathrm{endpoint\ continuation}.
\]

The dashed arrows are open. The solid arrows are conditional consequences once their analytic hypotheses are fixed.

## 16. Audit verdict

```text
FLEXIBLE_G1:
  S(t) <= theta * nu * z(t) + a(t) * y(t)
  theta < 1
  integral_0^T* a(t) dt < infinity

IMPLIES:
  y(t) <= y0 * exp(2 * integral_0^t a)
  ||u(t)||_3 <= C * E0^(1/4) * y(t)^(1/4)
  integrated z <= y0 * exp(2A(t)) / [2(1-theta)nu]

LOSS_OF_MARGIN:
  theta -> 1  =>  (1-theta)nu -> 0

GRONWALL_BLOWUP:
  integral a -> infinity  =>  exp(2 integral a) -> infinity

OPEN_BRIDGE:
  ActualNS -> flexible G1

UNCONDITIONAL_PROOF:
  NOT ESTABLISHED
```

The diagram and the formulas are therefore diagnostics for **what must be proved to break the circle**; they are not a replacement for the missing bridge.
