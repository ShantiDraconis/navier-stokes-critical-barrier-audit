# 02 — Scaling

## Navier–Stokes scaling symmetry

The incompressible Navier–Stokes equations

\[
\partial_t u + (u\cdot\nabla)u + \nabla p = \nu\Delta u + f,\qquad \nabla\cdot u = 0,
\]

admit the one-parameter family of rescalings

\[
u_\lambda(x,t)=\lambda\, u(\lambda x,\, \lambda^2 t),
\qquad
p_\lambda(x,t)=\lambda^2\, p(\lambda x,\,\lambda^2 t),
\qquad
f_\lambda(x,t)=\lambda^3\, f(\lambda x,\,\lambda^2 t).
\]

Under this rescaling, if \((u,p,f)\) solves NS on \(\mathbb{R}^3\times(0,T)\), then
\((u_\lambda,p_\lambda,f_\lambda)\) solves NS on \(\mathbb{R}^3\times(0,\lambda^{-2}T)\).

## Critical Lebesgue space

The \(L^p\) norms of the rescaled velocity obey

\[
\|u_\lambda(\cdot,t)\|_{L^p} = \lambda^{1-3/p}\,\|u(\cdot,\lambda^2 t)\|_{L^p}.
\]

The exponent \(1-3/p\) vanishes at \(p=3\), giving

\[
\|u_\lambda\|_{L^3} = \|u\|_{L^3}.
\]

Hence \(L^3(\mathbb{R}^3)\) is **scale-critical** for 3D incompressible NS.  The
corresponding endpoint Lebesgue space in the blow-up characterisation is
\(L^\infty_t L^3_x\).

## Critical Sobolev and Besov spaces

Analogously:
- \(\dot H^{1/2}(\mathbb{R}^3)\) is scale-critical for velocity (Sobolev).
- \(\dot B^{-1}_{\infty,\infty}\) is scale-critical for pressure-type forcing.
- The homogeneous Besov space \(\dot B^{0}_{3,\infty}\) embeds into \(L^3\) and
  is also scale-critical.

## Scaling exponents for singular ansatz

Near a putative blow-up time \(T^*\), one seeks solutions of the form

\[
u(x,t)\sim (T^*-t)^{-\alpha}\,U\!\left(\frac{x-x^*}{(T^*-t)^\beta}\right).
\]

The Navier–Stokes balance requires

| Term | Size |
|---|---|
| \(\partial_t u\) | \((T^*-t)^{-\alpha-1}\) |
| \((u\cdot\nabla)u\) | \((T^*-t)^{-2\alpha-\beta}\) |
| \(\nu\Delta u\) | \((T^*-t)^{-\alpha-2\beta}\) |

Matching the nonlinear and viscous terms gives \(\alpha = 2\beta - \alpha\), i.e.\
\(\alpha + 2\beta = 2\alpha\), so \(\beta = \alpha/2\).  The classical
Type-I blow-up profile corresponds to \(\alpha=1,\,\beta=1/2\):

\[
u(x,t)\sim (T^*-t)^{-1}\,U\!\left(\frac{x-x^*}{(T^*-t)^{1/2}}\right).
\]

The self-similar type-I profile satisfies \(|U(y)|\lesssim(1+|y|)^{-1}\).

## Graph node

See `graph/nodes.yaml`: `THEOREM:SCALING_SYMMETRY`, `CONST:SCALING_EXPONENT_ALPHA`,
`CONST:SCALING_EXPONENT_BETA`.
