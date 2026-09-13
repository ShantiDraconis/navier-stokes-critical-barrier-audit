# G1 research program at prize standard

## Purpose

This document reformulates the remaining Navier–Stokes gap as a sequence of explicit theorem obligations. It does **not** claim the Millennium Problem is solved. The goal is to identify the shortest non-circular route from a genuinely dynamical geometric statement about the vorticity direction to the known critical regularity endpoint.

## 0. Corrected reduction

Let

\[
y(t)=\|\omega(t)\|_{L^2}^2,\qquad z(t)=\|\nabla\omega(t)\|_{L^2}^2,
\]

and write the enstrophy balance as

\[
\frac12 y'(t)+z(t)=\mathcal S(t),\qquad
\mathcal S(t):=\int_{\mathbb R^3}\omega\cdot S\omega\,dx.
\]

The scalar route gives only a bound of the form

\[
|\mathcal S(t)|\le D(t)y(t)^{3/4}z(t)^{3/4},
\]

where `D(t)` is solution dependent. Young's inequality yields

\[
D y^{3/4}z^{3/4}\le \varepsilon z+C_\varepsilon D^4y^3.
\]

Hence `D(t) -> 0` alone does not exclude blow-up for arbitrary data. The exponent four is essential.

The correct prize-standard target is a **signed coercive estimate**:

\[
\boxed{
\mathcal S(t)\le (1-\delta)z(t)
}
\tag{G1-CLOSED}
\]

with a solution-independent `delta>0` on a terminal interval approaching any putative first singular time.

This immediately implies

\[
y'(t)+2\delta z(t)\le0,
\]

hence

\[
\sup_{t<T^*}\|\omega(t)\|_2<\infty.
\]

No exponential decay is claimed on `R^3`; there is no global Poincare inequality.

## 1. Why G1-CLOSED is already enough

Energy gives

\[
\sup_{t<T^*}\|u(t)\|_2<\infty.
\]

For divergence-free fields on `R^3`,

\[
\|\nabla u\|_2\lesssim\|\omega\|_2.
\]

Sobolev and interpolation give

\[
\|u\|_3
\le \|u\|_2^{1/2}\|u\|_6^{1/2}
\lesssim
\|u\|_2^{1/2}\|\omega\|_2^{1/2}.
\]

Therefore G1-CLOSED implies

\[
u\in L_t^\infty L_x^3.
\]

The Escauriaza–Seregin–Sverak endpoint theorem then rules out a finite first singular time. Thus a successful proof of G1-CLOSED removes the need for a separate small-`epsilon_ESS` reconstruction through a fixed Littlewood–Paley scale.

## 2. What cannot be used

The following are now forbidden shortcuts in this branch of the audit:

1. Optimizing the scalar constant `0.279` and treating that as signed depletion.
2. Replacing `D^4 y^3` by `D y^3` after Young.
3. Inferring exponential decay of enstrophy from `y'+2 delta z<=0` on `R^3`.
4. Using helicity to upper-bound enstrophy. From
   \[
   |H|\le\|u\|_2\|\omega\|_2
   \]
   one obtains no enstrophy upper bound.
5. Assuming global Holder-1/2 coherence from global norms. The localized-packet attack in `audit/15_G1star_adversarial_attack.md` rules this out.
6. Claiming novelty for the conditional fact that critical directional coherence is regularizing; this belongs to the established geometric-regularity literature.

## 3. The genuinely new theorem that would be needed

The open theorem must be dynamical, local, and non-circular.

### Dynamic Critical Geometry Theorem (target)

Assume a smooth solution on `[0,T*)` and suppose `T*<infinity` is the first singular time. Then there exist

- `t0<T*`,
- a dimensionless threshold `theta in (0,1)`,
- dynamically relevant connected components `U_j(t)` of the intense-vorticity region,
- a scale-covariant local radius `rho_j(t)`,
- and a constant `C_*` independent of `t->T*`,

such that on every relevant component one has a critical geometric condition sufficient to deplete the Biot–Savart stretching kernel.

Two candidate formulations should be attacked in parallel.

### Route A: pointwise critical coherence

Let `xi=omega/|omega|`. Seek

\[
|\sin\angle(\xi(x,t),\xi(y,t))|
\le C_*
\left(\frac{|x-y|}{\rho_j(t)}\right)^{1/2}
\]

for `x,y in U_j(t)` with `|x-y|<rho_j(t)`.

The radius must be local/componentwise. A candidate is

\[
\rho_j(t)=\kappa
\frac{\|\omega\|_{L^2(U_j(t))}}
{\|\nabla\omega\|_{L^2(U_j(t))}},
\]

but this definition itself requires a robust treatment of moving components and boundary localization.

### Route B: critical local mean oscillation

Because pointwise Holder control may be too strong, seek a logarithmically critical mean-oscillation condition for `xi` on intense-vorticity components. This is closer to current geometric PDE work and may be compatible with the direction equation itself.

The novelty threshold is not the criterion by itself. The novelty must be:

\[
\boxed{
\text{Navier--Stokes dynamics}
\Longrightarrow
\text{critical geometry}
}
\]

without assuming beforehand the regularity one is trying to prove.

## 4. Exact proof tree

### G1.A — direction equation

Away from zeros of vorticity derive the PDE for

\[
\xi=\frac{\omega}{|\omega|}.
\]

The equation has the schematic form

\[
(\partial_t+u\cdot\nabla)\xi
-\nu\Delta\xi
=
P_{\xi^\perp}S\xi
+\text{cross-diffusion/HMHF terms}.
\]

This must be derived with every coefficient and singular factor checked.

### G1.B — local oscillation functional

Choose a scale-invariant quantity `Q_j(t,r)` measuring directional oscillation. Requirements:

- dimensionless under Navier–Stokes scaling;
- stable under localization;
- meaningful when `omega` is large;
- compatible with the direction PDE;
- strong enough to imply signed stretching depletion.

Pointwise Holder seminorm and logarithmic mean oscillation are the two primary candidates.

### G1.C — evolution inequality for Q

Prove a differential/recursive inequality of the schematic form

\[
\partial_t Q + \text{positive smoothing}
\le \text{tangential-strain forcing} + \text{controlled transport terms}.
\]

This is the core new PDE calculation.

### G1.D — terminal-interval propagation

Under the contradiction assumption `T*<infinity`, prove that the scale-critical oscillation cannot diverge on `[t0,T*)`.

This step must exclude the localized-packet counterexample by using dynamics, not merely kinematics.

### G1.E — kernel depletion

Using the Constantin–Fefferman representation of strain, show that the established geometric control yields a signed estimate strong enough to imply

\[
\mathcal S(t)\le(1-\delta)z(t)
\]

or an equally strong critical inequality from which uniform enstrophy follows.

### G1.F — enstrophy bound

From the exact balance and G1.E derive

\[
\sup_{t<T^*}y(t)\le C(y(t_0)).
\]

### G1.G — endpoint map

Use energy, div–curl equivalence, Sobolev and interpolation to prove

\[
\sup_{t<T^*}\|u(t)\|_3<\infty.
\]

Then invoke the exact Escauriaza–Seregin–Sverak endpoint theorem.

## 5. Attack strategy

The program should try to **kill** each proposed bridge before investing in a proof.

### Attack A — scaling
Every candidate must be invariant/covariant under

\[
u_\lambda(x,t)=\lambda u(\lambda x,\lambda^2t).
\]

Reject immediately if dimensions fail.

### Attack B — localized packet
Superimpose high-amplitude, small-support divergence-free packets on a smooth background. Any statement based only on global norms is expected to fail.

### Attack C — opposite tubes / anti-parallel geometry
Test whether the criterion distinguishes alignment, anti-alignment, osculation and reconnection-like configurations.

### Attack D — high strain with coherent direction
Direction may be an eigenvector of the strain tensor while stretching remains large. Any criterion that merely says 'direction is coherent' must be checked against tangential versus longitudinal strain.

### Attack E — zeros of vorticity
The direction field `xi` is undefined at `omega=0`. Every localization and PDE identity must avoid hidden division by zero.

### Attack F — moving-component pathology
Connected superlevel components can split, merge and disappear. A proof cannot silently differentiate a componentwise quantity through topology changes.

### Attack G — circularity
Reject any proof of directional regularity that uses an estimate already equivalent to `L_t^infty L_x^3`, bounded enstrophy, or another known regularity criterion.

### Attack H — terminal-time uniformity
A bound with a constant `C(t)` that diverges as `t->T*` does not close G1. Uniformity is mandatory.

## 6. Numerical program

Numerics are for falsification and conjecture selection only.

Required observables:

1. local directional oscillation on high-vorticity connected components;
2. `rho_j/dx` with at least one decade, preferably two, of resolved subscales;
3. tangential strain `|P_{xi^perp}S xi|`;
4. total stretching `omega.S.omega`;
5. positive and negative stretching contributions separately;
6. local enstrophy and palinstrophy;
7. dependence on Reynolds number and resolution;
8. convergence of the proposed critical seminorm as `N` increases.

A numerical beta fit is not accepted unless the fitted interval lies well above the grid scale and is stable under refinement.

## 7. Formalization architecture

Formalization should separate known mathematics from the open bridge.

Files:

- `formal/G1/01_EnstrophyBalance.lean`
- `formal/G1/02_YoungD4.lean`
- `formal/G1/03_NoPoincareR3.lean`
- `formal/G1/04_G1ClosedInterface.lean`
- `formal/G1/05_G1ClosedToEnstrophy.lean`
- `formal/G1/06_EnstrophyToL3.lean`
- `formal/G1/07_ESSEndpointInterface.lean`
- `formal/G1/08_ConditionalRegularity.lean`
- `formal/G1/OPEN_DynamicCriticalGeometry.lean`

All files except the final `OPEN_...` bridge should ultimately compile without `sorry`. The open theorem must remain syntactically visible as an assumption/interface until a genuine proof is supplied.

## 8. Publication standard

A prize-level manuscript must contain:

1. exact statement of the new dynamic geometry theorem;
2. proof that it is generated by the NSE dynamics, not assumed;
3. exact kernel representation and signed depletion estimate;
4. no hidden small-data hypothesis;
5. no numerically inferred theorem;
6. no use of helicity as an enstrophy upper bound;
7. complete treatment of vorticity zeros and localization;
8. exact map into the established endpoint regularity theorem;
9. independent checking of constants/signs;
10. machine-checked logical reduction wherever practical.

## 9. Current audit verdict

| Node | Status |
|---|---|
| scalar OPEN estimate | ESTABLISHED / NON-CLOSING |
| Young residual `D^4 y^3` | PROVED-LOGIC |
| `D(t)->0` alone excludes blow-up | FALSE |
| exponential enstrophy decay on `R^3` from G1-CLOSED | FALSE |
| helicity upper-bounds enstrophy | FALSE |
| global G1* from global `rho_*` | FALSIFIED |
| dynamic/local critical geometry | OPEN |
| geometry -> signed depletion | KNOWN CONDITIONALLY IN RELATED FORMS / MUST MATCH EXACT TARGET |
| G1-CLOSED -> bounded enstrophy | PROVED-LOGIC |
| bounded energy + enstrophy -> `L_t^infty L_x^3` | PROVED-LOGIC |
| `L_t^infty L_x^3` -> no finite blow-up | EXTERNAL THEOREM (ESS) |
| unconditional global regularity | NOT ESTABLISHED |

## 10. Research decision rule

The program advances only if each new candidate survives scaling, localized-packet, tangential-strain, terminal-uniformity and non-circularity attacks. If a candidate fails any one of these, it is archived as a negative result and replaced rather than patched by changing constants.
