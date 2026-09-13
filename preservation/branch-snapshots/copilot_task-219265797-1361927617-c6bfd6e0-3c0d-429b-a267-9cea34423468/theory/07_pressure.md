# 07 — Pressure

## Pressure equation

For a divergence-free velocity field \(u\) satisfying Navier–Stokes, the pressure
\(p\) satisfies the Poisson equation

\[
-\Delta p = \partial_i\partial_j(u_i u_j)-\nabla\cdot f.
\]

In the zero-forcing case this reduces to \(-\Delta p = \partial_i\partial_j(u_iu_j)\).

## Riesz representation

The pressure can be written as

\[
p = (-\Delta)^{-1}\partial_i\partial_j(u_iu_j) = R_iR_j(u_iu_j),
\]

where \(R_i = \partial_i(-\Delta)^{-1/2}\) is the \(i\)-th Riesz transform.
This is the **Riesz–Calderon–Zygmund** representation: the pressure is
a nonlocal function of the velocity.

## Nonlocal tails and support compatibility

A key constraint for any construction that places the initial data in a
compact spatial support \(\text{supp}(u_0)\subset B(0,R_0)\) is:

\[
p(x,t) = \int_{\mathbb{R}^3}\frac{1}{4\pi|x-y|}
           \partial_i\partial_j(u_iu_j)(y,t)\,dy.
\]

Even if \(\text{supp}(u)\subset B(0,R)\), the pressure satisfies
\(p(x,t) = O(|x|^{-3})\) as \(|x|\to\infty\), so the pressure is never
compactly supported.

Pressure **nonlocal tails** must be accounted for in:
- The forcing smoothness test (`audit/05_forcing_smoothness_test.md`).
- The support compatibility analysis (`audit/07_support_compatibility_test.md`).

## Pressure gradient and energy cancellation

The NS momentum equation implies \(\langle\nabla p, u\rangle = 0\) for
divergence-free \(u\), used to eliminate the pressure gradient from the energy
identity.  However, in the localised setting (cut-off functions \(\phi_r\)),
boundary commutator terms arise:

\[
\int|\nabla u|^2\phi_r\,dx \neq -\int u\cdot\nabla(u\cdot\nabla\phi_r)\,dx,
\]

and the pressure appears explicitly through:

\[
-\int u_i\partial_i p\,\phi_r\,dx = \int p\,u\cdot\nabla\phi_r\,dx.
\]

The right-hand side is an error term bounded by
\(\|p\|_{L^{3/2}(r<|x|<2r)}\cdot\|u\|_{L^3(r<|x|<2r)}\cdot r^{-1}\).

## Audit status

See `audit/06_pressure_compatibility_test.md`:
the pressure nonlocal tails and localisation compatibility under the proposed
construction remain **UNRESOLVED** as of the current audit pass.

## Graph nodes

`OPERATOR:PRESSURE_LAPLACIAN`, `OPERATOR:RIESZ_TRANSFORM`, `EQUATION:PRESSURE_POISSON`.

Convention: pressure is defined with explicit sign \(-\Delta p = \partial_i\partial_j(u_iu_j)-\nabla\cdot f\)
throughout this repository.
