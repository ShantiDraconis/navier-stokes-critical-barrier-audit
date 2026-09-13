# Audit 76 — Signed stretchFar attack

Branch: `audit/pde-to-dynamic-campanato-20260913`  
Input commits: `c364931c`, `1b5417f`  
XiEpsPDE definition commit: `f43ed5cf913856844f9747dd47d75f1f0a31ff5f`

## Target

Attack the far-field contribution in its signed bilinear form before taking a pointwise absolute value:

\[
\mathcal F_{far}
=
\iint_{|x-y|\ge K\rho_*}
K(x-y)D(\xi(x),\xi(y))
|\omega(x)||\omega(y)|\phi(x)^2\,dy\,dx.
\]

The forbidden fallback is

\[
|S^{far}|\lesssim(K\rho_*)^{-3/2}\|\omega\|_2,
\]

because squaring produces the already identified

\[
K^{-3}\rho_*^{-3}\|\omega\|_2^2.
\]

## Result of the signed Campanato check

A Campanato hypothesis at scales

\[
0<r\le\rho_*
\]

controls oscillation of \(\xi\) **inside balls of radius at most \(\rho_*\)**:

\[
J_r(x,t)\le C\frac r{\rho_*}.
\]

The far-field domain, however, compares points satisfying

\[
|x-y|\ge K\rho_*.
\]

For \(K>1\), those pairs are outside the range on which the one-ball Campanato hypothesis directly compares \(\xi(x)\) and \(\xi(y)\). Therefore the local hypothesis alone does not imply

\[
|D(\xi(x),\xi(y))|
\lesssim
(r/\rho_*)^\beta
\]

for any \(\beta>0\) on the far-field domain.

The only unconditional exponent supplied by this information is

\[
\boxed{\beta=0.}
\]

Obtaining \(\beta>0\) would require an additional mechanism, for example:

1. a telescoping chain of overlapping balls with a quantitatively summable loss;
2. cancellation/moment conditions of the actual Biot–Savart tensor kernel;
3. a weighted mean-zero identity for the signed strain pairing;
4. a global coherence estimate independent of the DynamicCampanato conclusion.

None of these is presently derived from `XiEpsPDE` on this branch.

Status: `OPEN_SIGNED_CANCELLATION / BLOCKING_WITH_CURRENT_INPUTS`.

## Dimensional obstruction: a dimensionless `(r/rho_*)^beta` is not enough by itself

There is a stronger scale point. Suppose, even optimistically, that the far-field estimate gained

\[
(r/\rho_*)^\beta,
\qquad \beta>0.
\]

This factor is dimensionless. Multiplying the naive squared scale gives

\[
K^{-3}
(r/\rho_*)^\beta
\rho_*^{-3}\|\omega\|_2^2.
\]

For arbitrary \(0<r\le\rho_*\), this does **not** remove the dimensional factor \(\rho_*^{-3}\). Thus a positive Campanato exponent alone cannot turn

\[
\int \rho_*^{-3}\|\omega\|_2^2dt
\]

into the Leray-paid quantity

\[
\int\|\nabla u\|_2^2dt.
\]

The missing compensation is dimensionally equivalent to

\[
\boxed{\rho_*^{3}}
\]

(or another estimate carrying the same net length power), unless one has an independent uniform lower bound on \(\rho_*\).

Equivalently, if a localized signed estimate produces a dimensional prefactor \(r^\alpha\rho_*^{-3-\alpha}\), then merely rewriting it as

\[
(r/\rho_*)^\alpha\rho_*^{-3}
\]

has not solved the Leray integrability problem.

The actual target must therefore be stronger: after all spatial averaging, kernel cancellation, and normalization, the surviving coefficient multiplying \(\|\omega\|_2^2\) must be bounded independently of negative powers of \(\rho_*\), or those negative powers must be paid for by another independently integrable quantity.

## Why using the target DynamicCampanato estimate here would risk circularity

The iteration may assume a bound at the **current/coarser scale** in order to prove a smaller-scale estimate. That is legitimate one-step induction. But it cannot assume the final global half-Hölder/coherence consequence for pairs separated by more than \(\rho_*\) and then use that consequence to establish the PDE estimate that generates the iteration.

Hence

```text
DynamicCampanato target
  -> global pairwise far-field coherence
  -> stretchFar small
  -> PDE one-step estimate
  -> DynamicCampanato target
```

is circular unless the second arrow is replaced by an independently proved lemma.

## XiEpsPDE status after the new definition

`formal/G1/XiEpsPDE.lean` now fixes

\[
|\omega|_\varepsilon
=\sqrt{|\omega|^2+\varepsilon^2},
\qquad
\xi_\varepsilon=\omega/|\omega|_\varepsilon,
\]

and the exact vector equation

\[
D_t\xi_\varepsilon
=
P_{\xi_\varepsilon^\perp}S_\varepsilon\xi_\varepsilon
+\nu\Delta\xi_\varepsilon
+2\nu\nabla\log|\omega|_\varepsilon\cdot\nabla\xi_\varepsilon
+R_1+R_2.
\]

The `R1` denominator is explicit. For `R2`, the file deliberately uses an already-contracted vector numerator: a raw `grad omega` is matrix-valued and cannot be added to the vector direction equation without specifying the contraction.

The cutoff-free remainder budget is expressed solely through a Leray-paid `gradUEpsSq` quantity and does not use `sup_t ||omega||_2^2`.

## OPEN_PDE_IDENTITY status

The concrete `XiEpsPDE` object is now defined, but **the localized integral identity is not yet legitimately PROVED_IDENTITY**.

Reason: the existing `DynamicCampanato.lean` identity is represented by scalar integral slots. To derive those slots from the new pointwise PDE rather than assuming the equality field, Lean still needs a concrete analytic layer defining:

- time-dependent fields and the material derivative;
- spatial gradient/Laplacian as actual operators rather than supplied vector fields;
- the ball mean `(xi_eps)_{B_r}`;
- the cutoff `phi=w_R`;
- the spatial integrals;
- integration by parts and boundary/decay hypotheses;
- differentiation under the integral sign;
- the near/far decomposition of the projected strain.

Without that layer, defining `ofXiEpsPDE` by copying an assumed scalar equality would merely rename `OPEN_PDE_IDENTITY`; it would not prove it.

Therefore the audit status is

```text
XiEpsPDE regularization and pointwise equation   FORMALIZED
magEps > 0 for eps > 0                          PROVED_LOGIC
R1/R2 denominator safety                        PROVED_LOGIC
cutoff-free remainder interface                 FORMALIZED
XiEpsPDE -> localized integral identity          OPEN_ANALYTIC_FORMALIZATION
signed far-field gain from local J_r alone       BLOCKING; beta = 0
missing dimensional compensation                 rho_*^3
naive rho_*^-3 route                             BLOCKING_SCALING
OPEN_CZ                                          PRESERVED
```

## Next exact proof obligation

The next legitimate formal object is not another estimate. It is an analytic realization structure, e.g.

```text
structure XiEpsLocalizedRealization (h : XiEpsPDE) where
  phi : ...
  meanBr : ...
  integral : ...
  grad : ...
  lap : ...
  ibp : ...
  diffUnderIntegral : ...
  strainSplit : ...
```

with the hypotheses needed to prove the localized equality by rewriting `h.equation`, pairing with

\[
\phi^2(\xi_\varepsilon-(\xi_\varepsilon)_{B_r})|\omega|_\varepsilon,
\]

integrating, and applying integration by parts. Only after that theorem compiles without an equality assumption should the status be changed to `PROVED_IDENTITY`.
