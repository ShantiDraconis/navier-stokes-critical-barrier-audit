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

## Localized PDE pairing status

`formal/G1/XiEpsLocalizedRealization.lean` now defines the real Bochner pairing

```text
bochnerPair v w = ∫ <v(x),w(x)> dx
```

and the exact localized test field

\[
\psi(x)=\phi(x)^2|\omega_\varepsilon(x)|
\left(\xi_\varepsilon(x)-(\xi_\varepsilon)_{B_r}\right).
\]

The pointwise equation in `XiEpsPDE` is rewritten as the field identity

```text
DtXi = rhs
```

and therefore yields, as a theorem rather than a structure field,

```text
bochnerPair DtXi psi = bochnerPair rhs psi.
```

Thus the previous scalar `testedEquation` assumption has been removed.  The scalar tested equation is reconstructed from:

1. the proved Bochner pairing of the pointwise PDE;
2. `lhsPairingExpansion`, which is the time/material-derivative differentiation-under-the-integral bookkeeping;
3. `pairingExpansion`, which is the integrability/linearity expansion of the full RHS into stretch, Laplacian, drift, R1 and R2 terms.

The resulting `XiEpsLocalizedRealization.testedEquation` is a theorem.

## Diffusion IBP status

The diffusion layer is now isolated at the exact weak integral identity

\[
\int \phi^2\langle \Delta\xi_\varepsilon,
\xi_\varepsilon-(\xi_\varepsilon)_{B_r}\rangle
|\omega_\varepsilon|\,dx
\]

\[
= -\int \phi^2|\nabla\xi_\varepsilon|^2|\omega_\varepsilon|\,dx
- \text{cutoff cross}
- \text{weight cross}.
\]

Equivalently this is the expansion of

\[
-\int \operatorname{div}
\bigl(\phi^2|\omega_\varepsilon|\nabla\xi_\varepsilon\bigr)
\cdot\left(\xi_\varepsilon-(\xi_\varepsilon)_{B_r}\right)\,dx.
\]

The repository does not currently contain a complete Sobolev/divergence theorem formalization proving this exact weighted vector identity from first principles in Mathlib.  Accordingly, the remaining obligation is not hidden under `LocalEnergyIdentity`; it is exposed as the smallest lower-level assumption `WeakDiffusionIBP.weakIBP`.

This is the correct audit boundary:

```text
pointwise XiEpsPDE -> Bochner pairing          PROVED_LOGIC
scalar testedEquation from pairing expansions PROVED_LOGIC
weighted weak Sobolev IBP                     OPEN_ANALYTIC_LEMMA
LocalEnergyIdentity once weakIBP is supplied  PROVED_IDENTITY_CONDITIONAL_ON_WEAK_IBP
CZ / Young                                    NOT USED
```

Therefore it is NOT yet correct to claim a completely unconditional `PROVED_IDENTITY via Mathlib Sobolev IBP`.  What is proved is that no final energy identity is postulated, and the remaining analytic gap has been reduced to a precise weak-IBP theorem plus time-pairing expansion.

## Localization powers

The concrete localization still records

\[
R=K\rho_*,\qquad |\nabla\phi|\sim(K\rho_*)^{-1},\qquad |D^2\phi|\sim(K\rho_*)^{-2}.
\]

The positive diffusion term generated after weak IBP is

\[
\int \phi^2|\nabla\xi_\varepsilon|^2|\omega_\varepsilon|\,dx,
\]

with cutoff and weight cross terms kept signed and separate.  The drift term remains the exact

\[
2\nu\nabla\log|\omega|_\varepsilon\cdot\nabla\xi_\varepsilon
\]

pairing; no Young inequality is used here.

## Why the far-field exponent is beta = 0 with current inputs

The available Campanato iteration hypothesis controls

\[
J_r(x,t)\le C\frac r{\rho_*},\qquad 0<r\le\rho_*.
\]

But the far-field compares points with

\[
|x-y|\ge K\rho_*.
\]

For `K>1`, the local one-ball estimate does not directly compare those separated directions. Therefore current inputs do not imply

\[
|D(\xi(x),\xi(y))|\lesssim(r/\rho_*)^\beta
\]

with any positive beta on the far-field domain.

The guaranteed exponent is exactly

\[
\boxed{\beta=0}.
\]

A positive exponent would require an additional independently proved mechanism: a summable chain of balls, genuine moment cancellation of the Biot–Savart tensor, a weighted mean-zero identity, or global coherence not obtained from the final DynamicCampanato conclusion.

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

The dimensionless factor does not cancel `rho_*^{-3}`. The dimensional deficit is therefore three powers of length, so a compensating mechanism must carry net scale

\[
\boxed{\rho_*^3}.
\]

This is a dimensional diagnosis only, not a theorem about Navier–Stokes dynamics.

## GeometricNonDegeneracy remains the open bridge

One possible independently proved bridge is

\[
V_{eff}(t)\ge\kappa\rho_*(t)^3,\qquad\kappa>0.
\]

The formal file records this only as `GeometricNonDegeneracy`; there remains deliberately no theorem

```text
XiEpsPDE -> GeometricNonDegeneracy.
```

Hence:

```text
rho_*^3 dimensional compensation               DIAGNOSTIC
V_eff >= kappa rho_*^3                          OPEN_BRIDGE GeometricNonDegeneracy
ActualNS -> GeometricNonDegeneracy               NOT ESTABLISHED
```

## Circularity guard

The forbidden loop remains

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
real Bochner localized test field               FORMALIZED
pointwise PDE -> Bochner pairing                 PROVED_LOGIC
scalar testedEquation from real pairing          PROVED_LOGIC
R = K rho_* cutoff powers                       EXPLICIT: rho_*^-1, rho_*^-2
signed near/far kernel support split             FORMALIZED INTERFACE
weighted weak Sobolev diffusion IBP              OPEN_ANALYTIC_LEMMA
time/material lhs pairing expansion              OPEN_ANALYTIC_LEMMA
LocalEnergyIdentity from these analytic facts    PROVED_IDENTITY_CONDITIONAL_ON_ABOVE
signed far-field gain from local J_r alone       BLOCKING: beta = 0
naive pointwise far-field route                  BLOCKING_SCALING: rho_*^-3 ||omega||_2^2
missing dimensional compensation                 rho_*^3
GeometricNonDegeneracy V_eff >= kappa rho_*^3    OPEN_BRIDGE
ActualNS -> GeometricNonDegeneracy                NOT ESTABLISHED
scale-correct signed/averaged far-field CZ        OPEN_CZ
PDEToDynamicCampanato                            NOT_ESTABLISHED
FinalF                                            NOT_TOUCHED
```
