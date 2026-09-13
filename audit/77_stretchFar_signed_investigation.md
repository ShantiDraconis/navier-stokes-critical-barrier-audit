# Audit 77 — Signed far-field investigation after XiEps localized realization

Branch: `audit/pde-to-dynamic-campanato-20260913`

Verified current branch HEAD before writing:

```text
4ab59061a9004f3405ed2af263ddfd311a8e9b33
```

The historical blocker commit remains:

```text
28a943d9b381a1fb1e7177d1ea84dcfa5137cc5f
```

The branch has advanced beyond `28a943d9`; this note does not overwrite or backdate that state.

## 1. Localized PDE realization status

`formal/G1/XiEpsPDE.lean` already defines

\[
|\omega|_\varepsilon=\sqrt{\|\omega\|^2+\varepsilon^2},
\qquad
\xi_\varepsilon=\omega/|\omega|_\varepsilon,
\]

so no duplicate regularization is introduced.

`formal/G1/XiEpsLocalizedRealization.lean` now contains:

- concrete Lebesgue/Bochner spatial integration;
- ball integral and ball average;
- the real localized test field
  \(\phi^2(\xi_\varepsilon-(\xi_\varepsilon)_{B_r})|\omega|_\varepsilon\);
- signed near/far strain split support interfaces;
- a theorem `XiEpsPDE.bochnerPair_equation` obtained from the pointwise PDE;
- a theorem `XiEpsLocalizedRealization.testedEquation` reconstructed from the Bochner pairing plus the two pairing expansions;
- a theorem `localized_identity` conditional on the weak diffusion IBP and the time/material pairing expansion;
- `LocalEnergyIdentityData.ofXiEpsPDE` with `identity := h.localized_identity`.

The final scalar energy identity is therefore **not stored as an assumed `hIdentity` field**.

Current classification:

```text
pointwise XiEpsPDE -> Bochner pairing             PROVED_LOGIC
scalar tested equation from Bochner pairing        PROVED_LOGIC
localized scalar identity from listed expansions   PROVED_IDENTITY_CONDITIONAL
weighted weak Sobolev IBP                          OPEN_ANALYTIC_LEMMA
time/material lhs pairing expansion                OPEN_ANALYTIC_LEMMA
full Mathlib Sobolev/Frechet realization           OPEN_LOWER_LEVEL_FORMALIZATION
CZ / Young                                         NOT USED
```

No claim of `lake build PASS` is made here because this connector has not executed Lean.

## 2. Frozen far-field obstruction

Keep the result from Audit 76 unchanged:

\[
|S^{far}|\lesssim (K\rho_*)^{-3/2}\|\omega\|_2
\]

implies after squaring

\[
|S^{far}|^2\lesssim K^{-3}\rho_*^{-3}\|\omega\|_2^2.
\]

Local Campanato information restricted to

\[
0<r\le\rho_*
\]

does not compare arbitrary pairs satisfying

\[
|x-y|\ge K\rho_*.
\]

Therefore the currently derivable far-field exponent remains

\[
\boxed{\beta=0}.
\]

Even if a new mechanism supplied a dimensionless factor

\[
(r/\rho_*)^\beta,
\qquad \beta>0,
\]

it would not remove the dimensional factor \(\rho_*^{-3}\).  A scale compensation carrying net length power \(\rho_*^3\), or an analytically equivalent replacement, is still necessary before the far-field coefficient can be paid solely by the Leray energy budget.

## 3. Candidate mechanism A — telescoping ball averages

A possible signed route is to compare averages rather than pointwise directions:

\[
(\xi)_{B_r(x)}-(\xi)_{B_r(y)}
=
\sum_{j=0}^{N-1}
\bigl[(\xi)_{B_j}-(\xi)_{B_{j+1}}\bigr].
\]

For this to help, one needs a chain of overlapping balls with a loss summable uniformly as the separation reaches `K rho_*` and then the full far region.

With only the present local estimate

\[
J_s\lesssim s/\rho_*,\qquad s\le\rho_*,
\]

a chain over a distance `L >= K rho_*` requires on the order of `L/rho_*` local links.  The accumulated loss is therefore not automatically summable over the unbounded far field and does not by itself manufacture a factor `rho_*^3`.

Status:

```text
TELESCOPING_AVERAGES = POSSIBLE_REORGANIZATION
POSITIVE_BETA_FROM_CURRENT_INPUTS = NOT_DERIVED
RHO_STAR_CUBED_COMPENSATION = NOT_DERIVED
```

## 4. Candidate mechanism B — Biot-Savart kernel moments

A genuine improvement could arise if the signed strain tensor kernel has a cancellation usable after subtracting an appropriate local/annular mean.  The target schematic identity would be of the form

\[
\int_{A_R} K_S(z)c\,dz=0
\]

for constants or selected low moments, allowing

\[
K_S(z)D(\xi(x),\xi(x-z))
\]

to be rewritten with a mean-zero increment before absolute values are taken.

This route is potentially stronger than a pointwise Campanato gain because cancellation can change which norm of the kernel is paid.  However, the present branch does **not** yet contain:

1. the exact tensorial Biot-Savart strain kernel in the formal object;
2. a proved annular/spherical mean-zero moment identity for that kernel;
3. a Fubini/principal-value theorem justifying the signed rearrangement;
4. a resulting estimate whose final coefficient is free of negative powers of `rho_*`.

Therefore:

```text
KERNEL_MOMENT_CANCELLATION = OPEN_CZ
RHO_STAR_CUBED_FROM_KERNEL_MOMENTS = NOT_ESTABLISHED
```

This is the most mathematically plausible place to search next because it can alter the singular-integral estimate itself rather than merely multiplying the naive pointwise bound by a dimensionless factor.

## 5. Candidate mechanism C — signed mean-zero direction difference

The far-field bilinear form is

\[
\mathcal F_{far}
=
\iint_{|x-y|\ge K\rho_*}
K(x-y)D(\xi(x),\xi(y))
|\omega(x)||\omega(y)|\phi(x)^2\,dy\,dx.
\]

A useful identity would have to expose a signed difference, for example schematically

\[
D(\xi(x),\xi(y))
=
\widetilde D(\xi(x)-m,\xi(y)-m)
+
\text{terms annihilated by a kernel moment}.
\]

The subtraction point `m` must be independently defined (ball mean, annular mean, or weighted mean), and the annihilation must be an exact algebraic/kernel identity.  Merely writing `xi-mean` is not enough.

What would count as success:

```text
signed_far_pair
  <= gamma * diffusionBulk
     + C(K) * ||grad u_eps||_2^2 * localOscillation
     + integrable_remainder
```

with

```text
gamma < 1/2
```

and all constants uniform in `eps`, with no `rho_*^-3` coefficient left unpaid.

No such identity is currently proved.

Status:

```text
SIGNED_MEAN_ZERO_IDENTITY = OPEN_SIGNED_CANCELLATION
```

## 6. Candidate mechanism D — weighted double integral instead of pointwise `S^far`

The naive obstruction appears after first obtaining a pointwise far-field strain bound and then squaring.  A potentially different route is to retain the full weighted bilinear quantity

\[
\iint
|x-y|^{-3}
|\omega(x)||\omega(y)|
\phi(x)^2
D(\xi(x),\xi(y))\,dy\,dx
\]

and estimate this object directly before any `L^infty_x` reduction of `S^far`.

This changes the bookkeeping because the extra `|omega(x)|` remains inside the outer integration and may pair with the weighted diffusion/oscillation term.  But an actual proof would still need a scale-correct bilinear singular-integral estimate.

Necessary theorem shape:

\[
|\mathcal F_{far}|
\le
\gamma\nu
\int \phi^2|\nabla\xi_\varepsilon|^2|\omega_\varepsilon|
+
C_\kappa\|\nabla u_\varepsilon\|_2^2 J_r
+
R_\varepsilon,
\]

with `gamma < 1/2`, `C_kappa` independent of epsilon, and `R_eps` paid by the cutoff-free remainder budget.

This theorem, if true, would avoid the specific squared pointwise route that generates `rho_*^-3`.  It is **not** currently established.

Status:

```text
DIRECT_WEIGHTED_BILINEAR_ROUTE = PRIORITY_CANDIDATE
SIGNED_AVERAGED_CZ = OPEN_CZ
```

## 7. Candidate mechanism E — GeometricNonDegeneracy

The formal branch already isolates

\[
V_{eff}\ge\kappa\rho_*^3
\]

as `GeometricNonDegeneracy`.

This has exactly the required length scale, but there is still no theorem

```text
XiEpsPDE -> GeometricNonDegeneracy
```

and no theorem

```text
ActualNS -> GeometricNonDegeneracy.
```

Therefore it cannot be used to close the present branch without introducing a new independent bridge.

Status:

```text
GeometricNonDegeneracy = OPEN_BRIDGE
ActualNS -> GeometricNonDegeneracy = NOT_ESTABLISHED
```

## 8. Investigation result

No currently verified input on this branch produces the missing `rho_*^3` compensation.

The two highest-value next analytic targets are:

1. **exact moment cancellation of the tensorial Biot-Savart strain kernel**, followed by a signed annular/averaged estimate;
2. **a direct weighted bilinear far-field inequality** that never passes through the pointwise squared estimate for `S^far`.

The following are insufficient by themselves:

- a positive dimensionless Campanato exponent `(r/rho_*)^beta`;
- the current local one-ball Campanato estimate;
- the naive pointwise Cauchy-Schwarz far-field estimate;
- naming `V_eff` without deriving a lower bound from independent NS data.

## 9. Campanato chain remains frozen

The already formalized arithmetic remains valid:

```text
gamma = C(K) * kappa
kappa < 1/(2 C(K))
=> gamma < 1/2
```

and the one-step closure condition remains

\[
2\gamma C+2A\le C.
\]

The cutoff-free remainder target remains

\[
a_\varepsilon(t)
\le
C_\kappa\|\nabla u_\varepsilon(t)\|_2^2,
\]

hence, once analytically derived,

\[
\int a_\varepsilon
\le
C_\kappa\frac{\|u_0\|_2^2}{2\nu}
\]

uniformly in epsilon.

But `PDEToDynamicCampanato` must remain `NOT_ESTABLISHED` until the far-field route actually eliminates or independently pays the `rho_*^-3` deficit.

## 10. Audit status after this investigation

```text
XiEpsPDE regularization                         FORMALIZED
pointwise PDE -> real Bochner pairing            PROVED_LOGIC
tested scalar equation from pairing              PROVED_LOGIC
weighted weak diffusion IBP                      OPEN_ANALYTIC_LEMMA
time/material lhs expansion                      OPEN_ANALYTIC_LEMMA
LocalEnergyIdentity                              PROVED_IDENTITY_CONDITIONAL
far-field beta from local Campanato alone        beta = 0
naive far-field squared route                    BLOCKING_SCALING
required dimensional compensation                rho_*^3 DIAGNOSTIC
kernel-moment cancellation                       OPEN_CZ
direct weighted bilinear far-field route         OPEN_CZ / PRIORITY_CANDIDATE
GeometricNonDegeneracy                           OPEN_BRIDGE
ActualNS -> GeometricNonDegeneracy                NOT_ESTABLISHED
PDEToDynamicCampanato                            NOT_ESTABLISHED
G1                                               NOT_ESTABLISHED
FinalF                                           NOT_TOUCHED
```

No `PROVED_LOGIC` upgrade is made for the far-field bridge in this commit.
