# Audit 75 — DynamicCampanato noncircular DAG

Status: `INTERFACE_FORMALIZED__HDYNAMIC_OPEN_BRIDGE`

Date: `2026-09-13`

## Preservation

Audit 74 is preserved unchanged. Its diagnosis remains authoritative:

```text
Front 1: near-field use of hDynamic to prove hDynamic is circular.
Front 1: rho_star^{-3/2}||omega||_2 produces a palinstrophy-sized expression not paid by Leray energy.
Front 2: a_eps ~ ||omega_eps||_2^4 is not L1 uniformly from Leray energy.
Front 2: epsilon compactness requires real space/time estimates.
Front 3: Gronwall is valid; geometric nondegeneracy remains open.
```

No branch or historical file is deleted or rewritten by this audit.

## New formal interfaces

Added:

```text
formal/G1/DynamicCampanato.lean
formal/G1/G1_DynamicCriticalGeometry.lean
```

The first fixes the scale-covariant Campanato target

```text
J_r(x,t)
= average_{B_r(x) intersect Omega_{1/2}(t)}
  |xi - xi_{B_r}|^2

J_r(x,t) <= Ccamp * r/rho_star(t),
0<r<=rho_star(t).
```

The constant is represented as cutoff-free data depending only on allowed macroscopic inputs in the eventual analytic construction.  The file deliberately contains no uniform `sup ||omega||_2^2` field and no uniform `integral ||grad omega||_2^2` field.

The permitted remainder target is

```text
a_eps(t) <= C_kappa ||grad u_eps(t)||_2^2,
```

because the kinetic-energy inequality supplies the independent spacetime budget

```text
integral ||grad u_eps||_2^2
<= ||u0||_2^2/(2 nu).
```

The Lean theorem `remainder_integral_from_energy` proves only the arithmetic implication once the concrete integral budget is supplied; it does not fabricate the analytic integral.

## Xi epsilon PDE interface

`G1_DynamicCriticalGeometry.lean` preserves an explicit

```text
XiEpsPDE
```

with

```text
R1
R2
```

and does not set either remainder to zero.

It also preserves

```text
RemainderCutoffFreeWitness
C_rem
C0_cutoff_free
```

as explicit data.

## New DAG

The noncircular proof architecture is now

```text
Maximal smooth NS / epsilon approximation
        |
        | XiEpsPDE + R1 + R2
        | kinetic-energy budget only
        v
PDEToDynamicCampanato                         OPEN_BRIDGE
        |
        v
DynamicCampanato
J_r <= C r/rho_star                           OPEN_BRIDGE
        |
        | concrete Campanato embedding
        v
hDynamic                                      NOT_ESTABLISHED
        |
        | Constantin-Fefferman-type
        | geometric depletion mechanism
        v
signed sub-dissipative stretching             OPEN/EXTERNAL BRIDGE
        |
        v
G1_flex
        |
        v
uniform enstrophy
        |
        v
L-infinity_t L3_x
        |
        v
ESS continuation
```

## Why Campanato removes the near-field circularity

The rejected route was

```text
assume hDynamic
 -> reduce near-field kernel singularity
 -> estimate evolution of xi
 -> conclude hDynamic.
```

That is logically circular.

The new route asks for a PDE estimate on the oscillation functional itself:

```text
PDE + energy
 -> local mean oscillation decay for xi
 -> Campanato estimate
 -> Holder coherence.
```

The target Hölder estimate is not an input to `PDEToDynamicCampanato`.

This does not by itself prove the Campanato estimate.  It changes the missing theorem into an auditable, non-self-referential PDE obligation.

## Cutoff-free requirement

The analytic theorem must produce constants uniform in epsilon/cutoff.  In particular, it may not use

```text
sup_t ||omega_eps||_2^2,
integral ||grad omega_eps||_2^2,
rho_star^{-3/2}||omega||_2 as an L2_t quantity,
or hDynamic itself in the near field.
```

A remainder is acceptable only after its `L1_t` norm is traced to an independent budget, preferably

```text
C_kappa integral ||grad u_eps||_2^2
<= C_kappa ||u0||_2^2/(2nu).
```

## Current certificate

```text
DYNAMIC_CAMPANATO_INTERFACE = FORMALIZED
XI_EPS_PDE_INTERFACE = FORMALIZED
R1_R2 = EXPLICIT
C_REM_CUTOFF_FREE = EXPLICIT
C0_CUTOFF_FREE = EXPLICIT
FORBIDDEN_SUP_ENSTROPHY = ABSENT
FORBIDDEN_PALINSTROPHY_BUDGET = ABSENT
HDYNAMIC_IN_NEAR_FIELD_PREMISE = ABSENT
PDE_TO_DYNAMIC_CAMPANATO = OPEN_BRIDGE
HDYNAMIC = NOT_ESTABLISHED
G1_UNCONDITIONAL = NOT_ESTABLISHED
GLOBAL_REGULARITY = NOT_ESTABLISHED
```

## Next theorem

The next analytic target is therefore not a new endpoint theorem.  It is precisely:

```text
PDEToDynamicCampanato:
XiEpsPDE + kinetic-energy budget + cutoff-free remainder control
=>
J_r(x,t) <= C(K,||u0||_2,nu,theta) r/rho_star(t)
```

uniformly in epsilon for `theta=1/2`, with a limit passage that preserves the constant and does not assume the desired Hölder coherence.
