# 03 — Energy

## Classical energy identity

For a smooth, divergence-free velocity field \(u\) solving the incompressible
Navier–Stokes equations on \(\mathbb{R}^3\times(0,T)\) with forcing \(f\),

\[
\frac{d}{dt} E_2(t) + \nu\|\nabla u(\cdot,t)\|_{L^2}^2 = \int_{\mathbb{R}^3} f\cdot u\,dx,
\]

where \(E_2(t)=\tfrac{1}{2}\|u(\cdot,t)\|_{L^2}^2\) is the kinetic energy.

## Leray energy inequality

For a Leray–Hopf weak solution \(u\), the energy inequality holds for almost
every \(t_0\) (including \(t_0=0\)) and all \(t>t_0\):

\[
E_2(t)+\nu\int_{t_0}^t\|\nabla u\|_{L^2}^2\,ds
\;\leq\;
E_2(t_0)+\int_{t_0}^t\langle f,u\rangle\,ds.
\]

## Energy concentration near blow-up

Suppose a smooth solution develops a singularity at time \(T^*\).  Then for
any ball \(B(x^*,r)\) centred at the singular point,

\[
\limsup_{t\nearrow T^*}\int_{B(x^*,r)}|u(x,t)|^3\,dx > c_0 > 0
\]

for a universal constant \(c_0>0\).  This is the **local energy concentration
criterion** tied to the critical \(L^3\) blow-up alternative.

Equivalently, there exists a sequence of times \(t_n\nearrow T^*\) and radii
\(r_n\to 0\) with

\[
r_n^{-1}\int_{B(x^*,r_n)}|u(x,t_n)|^2\,dx \geq \varepsilon_0 > 0.
\]

## Weighted and localised energy estimates

In the localised concentration window (radius \(r\ll 1\), time window
\([T^*-\delta,T^*]\)):

\[
\sup_{t\in[T^*-\delta,T^*]}\int_{\mathbb{R}^3}|u|^2\phi_r\,dx
+\nu\int_{T^*-\delta}^{T^*}\int_{\mathbb{R}^3}|\nabla u|^2\phi_r\,dx\,dt
\;\lesssim\;
r^{1/2}\,(E_2(0)+\|f\|_{\text{data}}^2),
\]

where \(\phi_r\) is a smooth cut-off supported on \(B(0,2r)\).

## Enstrophy and vorticity

The enstrophy \(\Omega(t)=\|\omega\|_{L^2}^2=\|\nabla\times u\|_{L^2}^2\)
satisfies

\[
\frac{d}{dt}\Omega(t)=-2\nu\|\nabla\omega\|_{L^2}^2+2\int\omega_i\omega_j\partial_j u_i\,dx+2\int f\cdot(-\Delta u)\,dx.
\]

For the zero-forcing case, blow-up at \(T^*\) requires \(\int_0^{T^*}\|\omega\|_{L^\infty}\,dt = +\infty\)
(Beale–Kato–Majda criterion).

## Graph nodes

See `graph/nodes.yaml`: `FUNCTIONAL:ENERGY_E2`, `FUNCTIONAL:ENSTROPHY`,
`INEQUALITY:LERAY_ENERGY`, `THEOREM:BKM_CRITERION`.
