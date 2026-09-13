# 07 — Support Compatibility Test

## Purpose

Checks compact support and decay consistency across \(u\), \(p\), \(\nabla p\),
and \(f\) throughout the proposed construction.

## Test SC-1: Initial data support

The proposed construction nominally places divergence-free smooth initial data
\(u_0\in C^\infty_c(B(0,R_0))\) with \(\nabla\cdot u_0=0\).

**Status: REPORTED** — initial data support claimed, not independently verified.

## Test SC-2: Velocity support evolution

The Navier–Stokes evolution does **not** preserve compact support in general.
The nonlinear term \((u\cdot\nabla)u\) and pressure gradient \(\nabla p\) (which
is nonlocal) can spread the support.  Any claim that the velocity remains
compactly supported for \(t>0\) requires an explicit mechanism — e.g.\
a decay estimate \(|u(x,t)|\leq C e^{-|x|^2/(4\nu(T^*-t))}\) or a localization
cut-off argument.

**Status: UNRESOLVED** — no explicit mechanism identified in the public material.

## Test SC-3: Forcing support consistency

Given the pressure tails described in `audit/06_pressure_compatibility_test.md`
(Test PC-1), the forcing \(f = \partial_t u + (u\cdot\nabla)u + \nabla p - \nu\Delta u\)
inherits the non-compact support of \(\nabla p\) unless a compensating
cancellation is built in.

**Status: UNRESOLVED** — see PC-1 for the pressure-tail conflict.

## Test SC-4: Decay rates at spatial infinity

For large \(|x|\), the solution must satisfy

\[
|u(x,t)| = O(|x|^{-3}),\quad |\nabla u(x,t)| = O(|x|^{-4}),
\quad |p(x,t)| = O(|x|^{-3})
\]

for standard Leray–Hopf solutions with compactly supported or fast-decaying
initial data (Caffarelli–Kohn–Nirenberg theory).  Whether the proposed
construction's concentration near \(x^*\) is compatible with these far-field
decay rates has not been independently audited.

**Status: NOT REFUTED** (no direct contradiction found).

## Test SC-5: Carrier jet localisation

The carrier-jet component \(u_\perp\) must be localised in the frequency
support \(\{|\xi|>N\}\) and in the spatial ball \(B(x^*,r)\).  The
spatial-frequency localisation trade-off (Heisenberg uncertainty) limits
how sharply both can be enforced simultaneously.

At the critical scale \(r\sim N^{-1}\), the product \(r\cdot N\sim 1\) saturates
the Heisenberg bound.  Whether the proposed construction stays within this bound
is required for the localisation architecture to close.

**Status: UNRESOLVED**.

## Current finding

| Test | Result |
|---|---|
| SC-1: initial data support | REPORTED |
| SC-2: velocity support evolution | UNRESOLVED |
| SC-3: forcing support consistency | UNRESOLVED |
| SC-4: far-field decay compatibility | NOT REFUTED |
| SC-5: carrier-jet localisation (Heisenberg) | UNRESOLVED |

Overall status for this test module: **UNRESOLVED**.
