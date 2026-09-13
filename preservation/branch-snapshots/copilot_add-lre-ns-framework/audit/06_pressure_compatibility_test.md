# 06 — Pressure Compatibility Test

## Purpose

\[
-\Delta p = \partial_i\partial_j(u_i u_j)-\nabla\cdot f
\]

Checks nonlocal pressure tails, support compatibility, and differentiation stability
for the proposed external construction.

## Pressure nonlocality constraint

The pressure is determined globally by the velocity through the Riesz operator:

\[
p(x,t) = \int_{\mathbb{R}^3}\frac{\partial_i\partial_j(u_iu_j)(y,t)}{4\pi|x-y|}\,dy.
\]

For any compactly supported \(u\), the pressure decays as \(|x|^{-3}\) but is
**never compactly supported**.

## Test PC-1: Support compatibility of pressure tails

Suppose the proposed construction claims compact spatial support for the
forcing \(f\) inside some ball \(B(0,R_f)\).  The pressure gradient
\(\nabla p\) satisfies

\[
|\nabla p(x,t)| \lesssim |x|^{-4}\int|u|^2\,dy
\]

for \(|x|>2R_0\) (outside the velocity support).  Thus
\(\nabla p\notin L^1(\mathbb{R}^3)\) in general, and the forcing
\(f = \partial_t u + (u\cdot\nabla)u + \nabla p - \nu\Delta u\) inherits
these tails.

**Claim to test:** \(f\in C^\infty_c(B(0,R_f)\times[0,T])\).

**Conflict:** If \(\nabla p\notin L^1\) and \(u, (u\cdot\nabla)u\) are
compactly supported, then \(f\) cannot be compactly supported unless
\(\nu\Delta u - \partial_t u - (u\cdot\nabla)u\) exactly cancels the
pressure tail.

**Status: UNRESOLVED** — exact cancellation mechanism not verified.

## Test PC-2: Pressure regularity under blow-up

Near a blow-up singularity \((x^*,T^*)\), the pressure satisfies

\[
|p(x,t)| \lesssim \frac{1}{|x-x^*|^2 + (T^*-t)}
\]

in the concentration window.  This forces

\[
\|\nabla p(\cdot,t)\|_{L^{3/2}(B_r)} \lesssim r^{-1/2}(T^*-t)^{-1/2}
\]

at scale \(r\sim(T^*-t)^{1/2}\).  Whether the proposed forcing can absorb this
growth is the key test.

**Status: UNRESOLVED**.

## Test PC-3: Elliptic compatibility across the forcing cut-off

If a spatial cut-off function \(\chi_R\) is applied to separate the near-field
construction from the far field, the commutator

\[
[\Delta^{-1}\partial_i\partial_j, \chi_R](u_iu_j)
\]

generates lower-order correction terms that must be bounded in the appropriate
Sobolev space.  The Calderon–Zygmund theory gives control in \(L^p\) for
\(1<p<\infty\) but not at the endpoint \(p=1\).

**Status: NOT REFUTED** (no explicit contradiction found, but not verified closed).

## Current finding

| Test | Result |
|---|---|
| PC-1: compact support of forcing vs.\ pressure tails | UNRESOLVED |
| PC-2: pressure growth rate at blow-up | UNRESOLVED |
| PC-3: elliptic commutator across cut-off | NOT REFUTED |

Overall status for this test module: **UNRESOLVED**.
