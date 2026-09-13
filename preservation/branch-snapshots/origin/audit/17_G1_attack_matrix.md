# G1 attack matrix

This matrix specifies how every candidate closure of G1 must be stress-tested before being promoted to a theorem.

| Attack | Candidate failure mode | Required certificate |
|---|---|---|
| Scaling | wrong homogeneity under NSE scaling | symbolic scaling table |
| Localized packet | global norms miss tiny high-amplitude structures | explicit divergence-free packet family |
| Anti-parallel tubes | angle criterion confuses alignment/anti-alignment | exact angle/kernel sign test |
| Tangential strain | coherent direction but large stretching remains | eigenvector/tangential-strain example |
| Vorticity zeros | `xi=omega/|omega|` becomes undefined | cutoff/localization proof |
| Component splitting | moving superlevel sets merge/split | formulation invariant under topology changes |
| Terminal uniformity | constants blow up as `t->T*` | uniform constant ledger |
| Circularity | proof imports bounded enstrophy or `L^infty_t L^3_x` | dependency DAG |
| Discretization | apparent beta caused by grid smoothness | convergence across N and resolved scale decade |
| Sign loss | absolute-value estimate replaces signed depletion | positive/negative stretching decomposition |
| Young exponent | incorrect residual dependence on depletion factor | symbolic proof of `D^4 y^3` |
| Helicity misuse | finite H treated as upper bound on enstrophy | inequality-direction certificate |

## Pass criterion

A candidate bridge is retained only if it survives **all** attacks without introducing an assumption already known to imply regularity.

## Priority order

1. Derive the exact vorticity-direction PDE.
2. Identify the scale-critical local oscillation functional.
3. Prove/attempt an evolution inequality for that functional.
4. Attack it with localized packets and high tangential strain.
5. Only after survival, derive the Constantin–Fefferman kernel depletion estimate.
6. Reduce to bounded enstrophy, then directly to `L^infty_t L^3_x`, then ESS.

## Definition of success

The research branch reaches a prize-standard claim only if the dependency DAG has the form

`NSE dynamics -> critical geometry -> signed depletion -> bounded enstrophy -> L^infty_t L^3_x -> ESS`

with **no unproved node** before the externally established ESS theorem.
