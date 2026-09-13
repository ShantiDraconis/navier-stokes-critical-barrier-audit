# G1 K-admissible to signed depletion — formal status

Date: 2026-09-13

## Scope

`G1_KAdmissible_to_SignedDepletion.lean` formalizes the implication graph
without claiming the unresolved analytic inputs.  The file contains no `axiom`,
`sorry`, `admit`, or unconditional Navier--Stokes regularity theorem.

## Dimensional corrections

The amplitude

\[
R_\varepsilon=\sqrt{|\omega|^2+\varepsilon^2}
\]

is not a spatial radius.  A spatial coherence scale is denoted by `ell` in the
mathematical specification and must not be replaced by `R_epsilon`.  Under the
Navier--Stokes rescaling, `R_epsilon` has degree two while `ell` has degree
minus one.

The ratio

\[
\Phi=\frac{\|\omega\|_2\|u\|_3}{\nu\|\nabla u\|_2}
\]

is scale invariant, but on divergence-free fields it is equivalent, up to the
standard curl/gradient identity, to `||u||_3 / nu`.  A uniform bound for Phi is
therefore the desired endpoint in disguise and is not admitted as a
non-circular G1 input.

## Proved logic

1. positive epsilon gives a positive scalar regularized denominator;
2. the arithmetic part of the correct Chebyshev superlevel estimate;
3. aggregation of the six named evolution-term bounds;
4. bulk plus exceptional tail plus a strict coefficient budget implies signed
   depletion;
5. the enstrophy balance plus a flexible stretching estimate implies the exact
   differential inequality;
6. energy controls a coefficient of the form `C * ||grad u||_2^2` once `C` is
   bounded independently of the critical endpoint;
7. Gronwall, critical reconstruction, and ESS are connected only through
   explicit certificates.

## Open analytic certificates

* construction of the K1 lower-semicontinuity certificate from an actual NSE
  solution;
* derivation of the joint evolution inequality with dimensionally homogeneous
  terms;
* subcritical control of commutator, transport, cutoff, and scale-motion costs;
* an analytic, principal-value-compatible kernel tail estimate;
* proof that the combined absorption budget is strictly below one;
* derivation of an L1 time multiplier without using `||u||_3`, uniform
  enstrophy, palinstrophy, or `z/y`;
* formalization or import of the Escauriaza--Seregin--Sverak endpoint.

## Verdict

```text
K0 scalar regularization                 = PROVED_LOGIC
K1 analytic lower semicontinuity         = EXPLICIT_OPEN_CERTIFICATE
G1 ActualNS -> signed depletion          = OPEN_BRIDGE
G1 bulk+tail+budget -> signed depletion  = PROVED_LOGIC
G2 differential bookkeeping             = PROVED_LOGIC
G2 analytic Gronwall                     = EXPLICIT_CERTIFICATE
G3 critical reconstruction               = EXPLICIT_CERTIFICATE
G4 ESS endpoint                           = EXTERNAL_INTERFACE
unconditional global regularity          = NOT_ASSERTED
```

