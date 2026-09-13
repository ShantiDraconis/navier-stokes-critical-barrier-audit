# Audit 70 — Stabilized Perelman-like hypothetical closure program and the three remaining open obligations

Status: **HYPOTHETICAL CLOSURE PROGRAM ONLY — NOT AN UNCONDITIONAL NAVIER–STOKES PROOF**  
Date: 2026-09-13

## 1. Purpose

This note records the strongest stabilized version of the proposed Perelman-like compression program **as it would look if the missing PDE bridges were genuinely proved from ActualNS**.

It is not a claim that those bridges have already been proved.

The intended logical structure is

\[
\mathrm{ActualNS}
\dashrightarrow
\{R3\ f_{NS},\ \mathrm{Noncollapse},\ \mathrm{Surgery/Classified\ ancient\ limits}\}
\dashrightarrow
Q_{\mathrm{joint}}+\mathrm{TailControl}
\dashrightarrow
G1_{\mathrm{flex}}
\Longrightarrow
\sup y<\infty
\Longrightarrow
L_t^\infty L_x^3
\Longrightarrow
\mathrm{ESS}.
\]

The dashed arrows are open.

---

## 2. Correction A — Chebyshev does not imply weighted negligibility

A Lebesgue-measure estimate such as

\[
|\{|\omega|<\delta\}|\le \frac{\|\omega\|_2^2}{\delta^2}
\]

is not sufficient to control a singular weighted commutator or Biot–Savart quantity.

The needed hypothesis is of the schematic form

\[
\boxed{
\int_{\{|\omega|<\delta\}}
 r^2|\nabla\xi|^2\,W\,d\mu
\le \eta_{\mathrm{low}}(\delta),
\qquad
\eta_{\mathrm{low}}(\delta)\to0
}
\]

for the **actual weight** appearing in the nonlinear estimate.

This is the correct replacement for a purely Lebesgue-volume argument.

Interpretation: if a Perelman-style noncollapse principle were available, it would have to control the weighted geometry relevant to the stretching kernel, not merely Euclidean volume.

---

## 3. Correction B — the numerical value \(\int a=36\)

If

\[
a(t)=C\Phi^2y(t),
\qquad
C=2,
\qquad
\Phi=0.6,
\qquad
\nu=0.01,
\qquad
E_0=1,
\]

and the energy inequality gives

\[
\int_0^{T^*}y(t)\,dt
\le
\frac{E_0}{2\nu}=50,
\]

then indeed

\[
\int_0^{T^*}a(t)\,dt
\le
2(0.6)^2(50)=36.
\]

However, this **does not** imply a modest Grönwall factor.

From

\[
y'(t)\le2a(t)y(t)
\]

we obtain

\[
\boxed{
y(t)\le y_0\exp\!\left(2\int_0^t a(s)\,ds\right).
}
\]

Therefore, if \(\int a=36\), the worst-case factor is

\[
\boxed{e^{72}},
\]

not \(4.17\).

Consequently the previously quoted numerical chain

\[
\int a=36
\quad\Longrightarrow\quad
y\le4.17
\quad\Longrightarrow\quad
\|u\|_3\le1.43
\]

is arithmetically inconsistent unless additional smallness information, a different normalization, or a much smaller value of \(\int a\) is proved.

This correction is mandatory in any final paper or formal status ledger.

---

## 4. Scaling correction for \(a=C\Phi^2 y\)

Under amplitude scaling

\[
u\mapsto Au,
\]

we have

\[
\omega\mapsto A\omega,
\qquad
y=\|\omega\|_2^2\mapsto A^2y.
\]

Hence, if \(\Phi\) is amplitude-invariant,

\[
\boxed{a=C\Phi^2y\mapsto A^2a.}
\]

Thus \(a\) scales quadratically in amplitude, not linearly.

The useful feature is not favorable amplitude homogeneity by itself; it is that

\[
\int_0^{T^*}a(t)\,dt
\le
C\Phi^2\int_0^{T^*}y(t)\,dt
\]

can still be finite because \(\int y\) is controlled by the energy budget.

This is precisely the distinction between:

- **pointwise amplitude growth**, which can be large; and
- **time-integrated control**, which may remain finite.

---

## 5. Three hypothetical Perelman-like objects

### R3 — backward auxiliary field \(f_{NS}\)

A proposed decisive object would be a backward problem

\[
\partial_t f
=
-\Delta f+|\nabla f|^2-Q_{\mathrm{joint}},
\qquad
f(T)=0.
\]

The desired result would be a uniform estimate

\[
\boxed{\|f\|_{L^\infty}\le C(E_0)}
\]

obtained from a maximum principle plus a suitable weighted logarithmic-Sobolev or entropy inequality.

This would be analogous in architecture to Perelman’s use of an auxiliary backward potential, but **no such Navier–Stokes entropy formula has been established here**.

Required proof obligation:

\[
\mathrm{ActualNS}
\Longrightarrow
Q_{\mathrm{joint}}\in L_t^1L_x^\infty
\Longrightarrow
\text{well-posed backward }f_{NS}
\Longrightarrow
\|f\|_\infty\le C(E_0).
\]

Status: **OPEN**.

### Noncollapse — weighted lower-volume control

The proposed analogue is a monotone functional

\[
\frac{d}{dt}\mathcal W_{NS}\ge0
\]

from which one would derive a weighted noncollapsing estimate

\[
\boxed{
\mathrm{Vol}_W(B_r)\ge\kappa r^3
\quad\text{whenever}\quad
|S|\le r^{-2}.
}
\]

The intended use is not merely geometric volume control, but conversion of a small exceptional percentile into small **weighted kernel mass**:

\[
\eta(r,t)
:=
\frac{\iint_{E_r}W}{\iint_{\mathrm{annulus}}W}
\le\delta_{\mathrm{tail}}.
\]

A percentile statement such as “5% exceptional set” is insufficient without this weighted estimate.

Status: **OPEN**.

### Surgery / ancient-limit classification

A hypothetical blow-up sequence would take

\[
Q_k:=|\omega|(x_k,t_k)\to\infty
\]

and rescale around \((x_k,t_k)\). To mimic Ricci-flow surgery one would need:

1. compactness of the rescaled NSE sequence in a topology strong enough to pass the equation;
2. a nontrivial ancient Navier–Stokes limit;
3. a rigidity/classification theorem for those ancient limits;
4. a canonical local model, such as a neck-like geometry, with quantitative stability;
5. a mechanism showing that all possible singular blow-up profiles are exhausted by the classification.

The shorthand “\(S^2\times(-L,L)\) neck classification” is therefore a **research target**, not an established Navier–Stokes theorem.

Status: **OPEN**.

---

## 6. Hypothetical Perelman-square identity

The decisive hypothetical identity would have the form

\[
\boxed{
\frac{d}{dt}\mathcal W_{NS}(t)
=
\int |\mathfrak D(u,f)|^2\,d\mu_t
\ge0.
}
\]

If such an identity were genuinely derived from Navier–Stokes and if its defect tensor \(\mathfrak D\) encoded the correct strain/vorticity geometry, it could in principle support:

- backward control of \(f_{NS}\);
- weighted noncollapse;
- rigidity of blow-up limits;
- control of exceptional weighted tails;
- a route to a quantitative joint-coherence estimate.

At present this is a **hypothetical structural template only**.

---

## 7. Joint coherence, not direction-only coherence

Direction-only coherence is insufficient because of the obstruction

\[
S=\mathrm{diag}(2,-1,-1),
\qquad
\xi=e_1.
\]

Then

\[
P_{\xi^\perp}S\xi=0
\]

while

\[
\xi\cdot S\xi=2>0.
\]

Thus the vortex direction can be perfectly aligned in the transverse sense while stretching remains maximal.

Any viable quantity must therefore include a strain contribution, schematically

\[
\boxed{
Q_{\mathrm{joint}}
=
Q_{\mathrm{dir}}
+
Q_{\mathrm{strain}},
}
\]

where one possible strain diagnostic is

\[
Q_{\mathrm{strain}}
:=
\left\langle
\frac{(\xi\cdot S\xi)_+}{|S|}
\right\rangle.
\]

Status of the implication

\[
\mathrm{ActualNS}\Longrightarrow
\sup Q_{\mathrm{joint}}\le\varepsilon_0
\]

remains **OPEN**.

---

## 8. The exact three open analytic obligations

The strongest compressed statement is:

```text
lemma uniform_joint_coherence_depletion
  (hQ    : uniform smallness of Q_joint from ActualNS)
  (hTail : uniform weighted exceptional-tail control)
  (hGain : nonlinear estimate improved to an energy-integrable coefficient)
  :
  exists theta < 1,
  exists a in L1,
    S <= theta * nu * z + a * y.
```

The three nontrivial obligations are:

### O1 — derive uniform \(Q_{\mathrm{joint}}\) from NSE

The HLS/Biot–Savart geometry may yield a bound involving

\[
|\hat r\cdot(\xi(y)\times\xi(x))|
\le |\sin\theta(x,y)|,
\]

plus far-field terms. But this only helps if the required small joint coherence is **derived from the actual evolution**, not assumed.

Status: **OPEN**.

### O2 — prove weighted-tail smallness

A 5% exceptional set can dominate a singular integral. The required hypothesis is

\[
\sup_{r,t}\eta(r,t)\le\delta_{\mathrm{tail}},
\]

where \(\eta\) uses the actual nonlinear kernel weight.

Status: **OPEN**.

### O3 — improve the nonlinear power to an energy-integrable coefficient

The crude estimate

\[
y^{3/4}z^{3/4}
\le
\theta z+Cy^3
\]

leads to

\[
a(t)\sim y(t)^2,
\]

which is not controlled by the basic energy inequality.

The desired structural improvement is of the schematic form

\[
\boxed{
y^{1/4}z^{3/4}
\le
\theta z+Cy,}
\]

or another inequality whose remainder has time integral controlled by energy.

This requires a genuine gain — for example a shrinking active volume, weighted noncollapse/tail cancellation, or another scale-breaking estimate — not just a different application of Young’s inequality.

Status: **OPEN**.

---

## 9. What would follow if O1–O3 were proved

Assume the three open obligations genuinely yield

\[
\mathcal S(t)
\le
\theta\nu z(t)+a(t)y(t),
\qquad
0\le\theta<1,
\qquad
\int_0^{T^*}a(t)dt<\infty.
\]

Then

\[
\frac12 y'(t)+(1-\theta)\nu z(t)
\le a(t)y(t).
\]

Hence

\[
\sup_{t<T^*}y(t)<\infty.
\]

Energy plus Sobolev/div–curl interpolation gives

\[
\sup_{t<T^*}\|u(t)\|_3<\infty.
\]

Then the Escauriaza–Seregin–Šverák endpoint continuation theorem excludes a finite first singular time.

Thus the downstream chain is standard conditional analysis once G1-flex has been obtained.

---

## 10. Numerical constants: what is valid and what is not

For the illustrative values

\[
\theta=0.375,
\qquad
\nu=0.01,
\]

the dissipative margin is indeed

\[
\boxed{(1-\theta)\nu=0.00625>0.}
\]

For

\[
C=2,
\qquad
\Phi=0.6,
\qquad
E_0=1,
\qquad
\nu=0.01,
\]

the energy-based estimate

\[
\int a\le36
\]

is arithmetically correct if \(a=2\Phi^2y\).

But the corresponding Grönwall bound is

\[
\boxed{
y(t)\le y_0e^{72}},
\]

which is finite but enormous.

Therefore the numerical example demonstrates **finiteness**, not useful smallness.

If one wants

\[
y(t)\le4.17\,y_0,
\]

then one needs approximately

\[
2\int_0^{T^*}a\le\log(4.17),
\]

so

\[
\boxed{
\int_0^{T^*}a
\lesssim0.714.
}
\]

That is a much stronger quantitative target than \(36\).

---

## 11. Truncation before a putative singular time

For every fixed \(\delta>0\), the classical maximal smooth solution on

\[
[0,T^*-\delta]
\]

has finite smooth norms.

A useful diagnostic stopping time is therefore

\[
\tau_{\max}
:=
\sup\{t<T^*:\text{the proposed quantitative coherence/tail hypotheses hold on }[0,t]\}.
\]

This is preferable to language such as “before/after infinity.”

If \(\tau_{\max}<T^*\), then the audit has identified the first breakdown of the proposed bridge. If the hypotheses hold uniformly up to \(T^*\), then G1-flex and the conditional closure can be invoked.

A Leray–Hopf weak extension after a hypothetical singular time does not automatically preserve the pointwise quantities \(Q_j\), \(z(t)\), or \(\xi\) needed by the smooth geometric argument. Thus one cannot simply continue the same pointwise audit past \(T^*\) without a weak-solution reformulation.

---

## 12. Status of the current v4-style package

The following classification is the correct audit interpretation:

```text
rho_j componentwise                       = OBSERVED / NUMERICAL
CH95 fixed-field stability                 = OBSERVED / NUMERICAL
CH(kappa)/sqrt(kappa) near O(1)            = OBSERVED / NUMERICAL
ExceptionalTailHypothesis                  = EXPLICIT HYPOTHESIS
JointLawHypothesis                         = EXPLICIT HYPOTHESIS
Uniform CH95 -> weighted kernel control    = OPEN
Q_joint smallness from ActualNS            = OPEN
weighted tail control from ActualNS        = OPEN
strain obstruction resolved universally   = OPEN
energy-integrable nonlinear gain           = OPEN
G1_closed_no_sorry under hypotheses        = CONDITIONAL LOGIC
unconditional NSE regularity               = NOT ESTABLISHED
```

A Lean file with zero `sorry` can certify that a conclusion follows from explicit assumptions; it does not by itself certify that those assumptions follow from the Navier–Stokes equations.

---

## 13. The stabilized 22 → 25 → 3 → 1 compression

The proposed compression can be stated safely as follows:

- many low-level regularization, zero-denominator, localization, and numerical states;
- compressed into roughly three genuinely decisive mathematical obligations;
- which, if solved, produce one bridge inequality.

The three obligations are:

\[
\boxed{
\begin{aligned}
&\text{(A) ActualNS }\Longrightarrow Q_{\mathrm{joint}}\text{ uniformly controlled},\\
&\text{(B) exceptional geometric tail }\Longrightarrow\text{ weighted kernel tail small},\\
&\text{(C) nonlinear estimate }\Longrightarrow a\in L^1_t\text{ from energy alone}.
\end{aligned}
}
\]

The one bridge is

\[
\boxed{
\mathcal S(t)
\le
\theta\nu z(t)+a(t)y(t),
\qquad
\theta<1,
\qquad
a\in L^1(0,T^*).
}
\]

Everything downstream is conditional closure.

---

## 14. Final verdict

```text
PERELMAN_LIKE_W_NS_IDENTITY            = HYPOTHETICAL
BACKWARD_f_NS_UNIFORM_BOUND            = OPEN
WEIGHTED_NONCOLLAPSE                   = OPEN
ANCIENT_NS_BLOWUP_CLASSIFICATION       = OPEN
ACTUAL_NS_TO_Q_JOINT                   = OPEN
WEIGHTED_EXCEPTIONAL_TAIL              = OPEN
ENERGY_INTEGRABLE_POWER_GAIN           = OPEN

IF all above produce G1-flex:
  theta < 1
  integral a < infinity
THEN:
  sup y < infinity
  L^infinity_t L^3_x < infinity
  ESS continuation

NUMERICAL CHECK:
  (1-0.375)*0.01 = 0.00625
  integral a <= 36  [for C=2, Phi=0.6, E0=1, nu=0.01]
  Gronwall factor = exp(72), NOT 4.17

UNCONDITIONAL_NAVIER_STOKES_PROOF = NOT ESTABLISHED
```
