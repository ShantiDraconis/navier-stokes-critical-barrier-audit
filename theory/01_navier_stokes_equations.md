# 01 — Navier–Stokes Equations

\[
\partial_t u + (u\cdot\nabla)u = -\nabla p + \nu\Delta u + f,
\qquad \nabla\cdot u = 0.
\]

Definitions:
- \(E_2(t) = \tfrac12\|u(t)\|_2^2\)
- \(E_3(t) = \|u(t)\|_3\)
- \(D_3(t) = \|\nabla |u|^{3/2}\|_2^2\)
- \(P_3(t)\): pressure contribution in \(L^3\) balance
- \(F_3(t) = \int f\cdot |u|u\,dx\)
