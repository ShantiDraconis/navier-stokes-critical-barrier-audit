# 04 — Critical \(L^3\)

## Role of \(L^3\) in the regularity theory

The space \(L^3(\mathbb{R}^3)\) is **scale-critical** for the 3D incompressible
Navier–Stokes equations (see `theory/02_scaling.md`).  The fundamental
regularity result of this type is the **Escauriaza–Seregin–Šverák theorem** (2003),
which establishes:

> If \(u\) is a Leray–Hopf weak solution on \(\mathbb{R}^3\times(0,T^*)\) and
> \(T^*\) is the first singularity time, then
> \[
>   \sup_{t<T^*}\|u(\cdot,t)\|_{L^3(\mathbb{R}^3)} = +\infty.
> \]

This is the **ESS blow-up alternative**: boundedness of the critical norm
\(\|u\|_{L^\infty_t L^3_x}\) implies global regularity.

## Equivalent formulation via concentration compactness

The ESS result is equivalent (via backward uniqueness + unique continuation) to:

- Either \(u\) remains smooth for all time.
- Or the \(L^3\)-norm must blow up as \(t\nearrow T^*\).

This makes \(L^3\) the **critical-space threshold** for the millennium problem.

## Quantitative \(L^3\)-loss profile

For a blow-up solution, the critical norm satisfies a quantitative loss estimate
near \(T^*\): there exist constants \(c, C > 0\) such that for \(t < T^*\),

\[
\|u(\cdot,t)\|_{L^3} \geq c\,(T^*-t)^{-1/2 + \varepsilon}
\]

for any \(\varepsilon > 0$.

The proposed external construction (target of this audit) claims to produce a
smooth initial datum whose \(L^3\)-norm profile along the solution satisfies a
prescribed blow-up rate.  Whether this rate is consistent with the ESS and
scaling constraints is the subject of `audit/03_L3_consistency_test.md`.

## Critical \(L^3\) in the localisation window

At the concentration scale \(r\sim(T^*-t)^{1/2}\), the local \(L^3\)-norm satisfies

\[
\int_{B(x^*,r(t))}|u(x,t)|^3\,dx \geq c_0 > 0,
\]

while for \(R \gg r(t)\),

\[
\int_{B(x^*,R)\setminus B(x^*,r(t))}|u(x,t)|^3\,dx \to 0.
\]

This **concentration at the critical scale** is the central mechanism connecting
the ESS endpoint to the localisation and support architecture.

## Graph nodes

`THEOREM:ESS_ENDPOINT`, `THEOREM:ESS_BLOWUP_ALTERNATIVE`, `SPACE:L3_CRITICAL`,
`CONST:C0_CONCENTRATION`.

See `theory/05_ESS_endpoint.md` for the full classical statement.
