# G1 geometric-depletion computational audit

## What was run
A reproducible low-resolution 3D pseudo-spectral Navier–Stokes pilot was run for two oppositely-signed, sinusoidally bent vortex tubes in a periodic box, with 2/3 dealiasing and viscosity nu=0.02.

Resolutions: N=24, 32, 40.
Times sampled: t=0, T/2, T with T=0.20.
High-vorticity thresholds: theta=0.30, 0.40, 0.50 times ||omega||_infinity.

For selected points, the code measures sin(angle(omega(x),omega(y))) against periodic separation and fits the slope of the 95th-percentile envelope in log-log coordinates.

## Numerical result
For theta=0.40, fitted q95 slopes across all resolutions/times ranged from 0.408 to 0.605, with mean 0.523.
A random-direction negative control gave slope 0.000, approximately zero as expected.

This pilot therefore *does* produce an apparent exponent near 1/2 at resolved scales in this particular smooth two-tube setup.

## Critical interpretation
This is **not evidence that G1 is proved**, and it is not even strong evidence that beta=1/2 is the singularity-precluding exponent:
1. The simulation is low-resolution and short-time.
2. Smooth resolved fields already possess strong local directional regularity; an apparent positive exponent is expected.
3. A fitted 95th-percentile slope is weaker than the required uniform supremum bound.
4. The conjecture must hold in the relevant high-vorticity regime uniformly as a putative singular time is approached, not merely in one smooth pilot trajectory.

## Scaling audit: the conjecture as written fails
Under Navier–Stokes scaling u_lambda(x,t)=lambda u(lambda x,lambda^2 t),
omega_lambda=lambda^2 omega(lambda x,lambda^2 t), while
||omega_lambda||_2=lambda^(1/2)||omega||_2.

Therefore:
- the threshold |omega| > c M with M=||omega_0||_2 is not scale-covariant;
- rho=c/M scales as lambda^(-1/2), whereas length must scale as lambda^(-1).

A scale-covariant replacement is:
Omega_theta(t)={x: |omega(x,t)| > theta ||omega(t)||_infinity}
and a natural length is
rho_*(t)=kappa ||omega(t)||_2/||grad omega(t)||_2 = kappa sqrt(y/z),
which scales exactly as lambda^(-1).

## Topology/helicity audit
The proposed step “rho -> 0 implies writhe -> infinity implies helicity -> infinity” is not a valid theorem as stated.
Helicity can mix writhe, twist, linking, circulation weights, signs, and cancellation. A uniform lower bound on rho cannot be inferred from finite helicity without additional hypotheses controlling tube decomposition, circulation, twist, linking and cancellation.

## Verdict
- Geometric-depletion direction: worth investigating.
- beta≈1/2 in this pilot: observed, but not decisive.
- original Omega_M and rho=c/M formulation: FAILS SCALING.
- helicity-to-rho lower-bound step: NOT ESTABLISHED and currently the main topological gap.
- G1 remains OPEN.

Runtime: 12.9 seconds.
