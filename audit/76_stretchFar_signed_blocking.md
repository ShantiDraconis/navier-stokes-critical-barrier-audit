# Audit 76 — Signed stretchFar attack

Branch: `audit/pde-to-dynamic-campanato-20260913`

## Target

Attack the far-field contribution in signed bilinear form before pointwise absolute values:

\[
\mathcal F_{far}=\iint_{|x-y|\ge K\rho_*}K(x-y)D(\xi(x),\xi(y))|\omega(x)||\omega(y)|\phi(x)^2\,dy\,dx.
\]

The forbidden fallback remains

\[
|S^{far}|\lesssim(K\rho_*)^{-3/2}\|\omega\|_2,
\]

because squaring gives

\[
K^{-3}\rho_*^{-3}\|\omega\|_2^2.
\]

Status: `BLOCKING_SCALING` for this naive pointwise route.

## Localized identity status

`formal/G1/XiEpsLocalizedRealization.lean` now contains concrete MeasureTheory definitions for spatial scalar/vector integrals, ball integrals, ball volume, ball average, and the weighted Xi integral.  It also records the real localization scale

\[
R=K\rho_*,\qquad |\nabla\phi|\sim(K\rho_*)^{-1},\qquad |D^2\phi|\sim(K\rho_*)^{-2}.
\]

The final `LocalEnergyIdentityData.identity` is not an input field.  It is derived through the DAG

```text
XiEpsPDE
  + localized testedEquation
  + real signed strainSplit
  + diffusionIBP
  -> XiEpsLocalizedRealization.localized_identity
  -> LocalEnergyIdentityData.ofXiEpsPDE
  -> LocalEnergyIdentity
```

Thus `ofXiEpsPDE` is not a renaming of an assumed final equality.  The final equality is a Lean algebraic consequence of the primitive PDE-test, kernel split, and IBP facts.

Classification:

```text
LocalEnergyIdentity from primitive analytic facts   PROVED_IDENTITY
full Sobolev/Frechet derivation of testedEquation   OPEN_LOWER_LEVEL_FORMALIZATION
full Mathlib proof of diffusion IBP                 OPEN_LOWER_LEVEL_FORMALIZATION
CZ / Young                                           NOT USED
```

This distinction is mandatory: `PROVED_IDENTITY` means the final localized identity is derived rather than postulated; it does not claim that every lower-level PDE differentiation theorem has already been rebuilt from first principles in Mathlib.

## Why the far-field exponent is beta = 0 with current inputs

The available Campanato iteration hypothesis controls

\[
J_r(x,t)\le C\frac r{\rho_*},\qquad 0<r\le\rho_*.
\]

But the far-field compares points with

\[
|x-y|\ge K\rho_*.
\]

For `K>1`, the local one-ball estimate does not directly compare those separated directions.  Therefore current inputs do not imply

\[
|D(\xi(x),\xi(y))|\lesssim(r/\rho_*)^\beta
\]

with any positive beta on the far-field domain.

The guaranteed exponent is exactly

\[
\boxed{\beta=0}.
\]

The formal ledger `FarFieldCampanatoExponentLedger` records this as `beta = 0` rather than silently inserting a positive exponent.

A positive exponent would require an additional independently proved mechanism: a summable chain of balls, a genuine moment cancellation of the Biot–Savart tensor, a weighted mean-zero identity, or global coherence not obtained from the DynamicCampanato conclusion itself.

Status: `OPEN_SIGNED_CANCELLATION / BLOCKING_WITH_CURRENT_INPUTS`.

## Exact dimensional deficit

Even if one hypothetically obtained a dimensionless gain

\[
(r/\rho_*)^\beta,\qquad\beta>0,
\]

multiplying the naive squared far-field scale gives

\[
K^{-3}(r/\rho_*)^\beta\rho_*^{-3}\|\omega\|_2^2.
\]

The factor `(r/rho_*)^beta` is dimensionless and does not cancel `rho_*^{-3}`.  Leray pays for

\[
\int_0^T\|\nabla u\|_2^2dt
\]

(and, in the standard whole-space divergence-free normalization, the corresponding time-integrated enstrophy), but not automatically for

\[
\int_0^T\rho_*^{-3}\|\omega\|_2^2dt.
\]

The dimensional deficit is therefore three powers of length.  A compensating mechanism must carry the net scale

\[
\boxed{\rho_*^3}.
\]

This is a dimensional diagnosis only.  It is NOT a theorem asserting that Navier–Stokes dynamics provides such compensation.

## GeometricNonDegeneracy is the open bridge

One possible bridge is an independently established effective-volume lower bound

\[
V_{eff}(t)\ge\kappa\rho_*(t)^3,\qquad\kappa>0.
\]

`formal/G1/XiEpsLocalizedRealization.lean` records this only as

```text
structure GeometricNonDegeneracy where
  rho : R
  kappa : R
  effectiveVolume : R
  ...
  volume_lower_bound : kappa * rho^3 <= effectiveVolume
```

There is deliberately no theorem

```text
XiEpsPDE -> GeometricNonDegeneracy
```

and no constructor deriving it from dimensional analysis.

Therefore:

```text
rho_*^3 dimensional compensation      NECESSARY FOR THE NAIVE DEFICIT / DIAGNOSTIC
V_eff >= kappa rho_*^3                 OPEN_BRIDGE GeometricNonDegeneracy
ActualNS -> GeometricNonDegeneracy      NOT ESTABLISHED
```

This prevents dimensional bookkeeping from being promoted into an analytic theorem.

## Circularity guard

It is legitimate for a one-step Campanato induction to assume the coarser-scale bound needed to prove a smaller-scale bound.  It is not legitimate to assume the final global pairwise coherence for `|x-y| >= K rho_*` and feed it back into the PDE estimate that is supposed to generate DynamicCampanato.

The forbidden loop is

```text
DynamicCampanato target
 -> global far-field coherence
 -> stretchFar small
 -> PDE one-step estimate
 -> DynamicCampanato target.
```

Until an independent signed cancellation or geometric non-degeneracy theorem breaks this loop, `stretchFar` remains open.

## Current ledger

```text
XiEpsPDE regularization                         FORMALIZED
magEps > 0 for eps > 0                          PROVED_LOGIC
concrete spatial integrals / ball average       FORMALIZED
R = K rho_* cutoff powers                       EXPLICIT: rho_*^-1, rho_*^-2
signed near/far kernel support split             FORMALIZED INTERFACE
LocalEnergyIdentity from tested PDE + IBP        PROVED_IDENTITY
lower-level Sobolev/Frechet testedEquation       OPEN_LOWER_LEVEL_FORMALIZATION
lower-level Mathlib diffusion IBP                OPEN_LOWER_LEVEL_FORMALIZATION
signed far-field gain from local J_r alone       BLOCKING: beta = 0
naive pointwise far-field route                  BLOCKING_SCALING: rho_*^-3 ||omega||_2^2
missing dimensional compensation                 rho_*^3
GeometricNonDegeneracy V_eff >= kappa rho_*^3    OPEN_BRIDGE
ActualNS -> GeometricNonDegeneracy                NOT ESTABLISHED
scale-correct signed/averaged far-field CZ        OPEN_CZ
PDEToDynamicCampanato                            NOT_ESTABLISHED
FinalF                                            NOT_TOUCHED
```
