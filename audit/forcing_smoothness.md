# Forcing Smoothness Audit

Base identity:
\[
f=\partial_tu+(u\cdot\nabla)u-\nu\Delta u+\nabla p.
\]

Local ansatz:
\[
u(x,t)=A(t)U\!\left(\frac{x-x_*}{\ell(t)}\right),
\quad A(t)\sim(T-t)^{-\alpha},
\quad \ell(t)\sim(T-t)^\beta.
\]

Term scales to audit:
\[
\partial_t u \sim (T-t)^{-\alpha-1},
\]
\[
(u\cdot\nabla)u \sim (T-t)^{-2\alpha-\beta},
\]
\[
\nu\Delta u \sim (T-t)^{-\alpha-2\beta}.
\]

Audit target: determine whether the specific construction cancels all divergent components required to preserve the claimed smoothness class for \(f\).
