# Audit 67 — G1 beta=1/2 falsification protocol

Status: EXPERIMENTAL_HYPOTHESIS_TEST / ANALYTIC_BRIDGE_OPEN

## Scientific firewall
The Python program is an analytic two-tube toy field, not a Navier–Stokes DNS. A fitted beta near 1/2 neither proves Holder coherence nor G1. A fitted beta far from 1/2 falsifies only the specified toy/configuration/fit, not every possible geometric depletion theorem.

## Hypothesis under test
For xi=omega/|omega| in a high-vorticity region Omega_M, test finite-resolution scaling
`sin(angle(xi(x),xi(y))) ~ C |x-y|^beta` for |x-y|<rho.
The candidate beta is 1/2.

## Required robustness sweep
Vary grid n, core sigma, separation, tilt, Omega threshold, rho, seed, pair count, and fitting window. Report beta_hat, confidence/bootstrap interval, log-log R^2, number of admissible pairs, and convergence with n. Never promote a single fit to theorem status.

## Formal dependency
beta-half coherence -> [OPEN ANALYTIC BRIDGE: localized Biot-Savart + cancellation] -> CLOSED depletion -> [PROVED LOGIC] dissipative enstrophy inequality.

## Multiprover files
- `formal/g1/lean/G1Depletion.lean`
- `formal/g1/coq/G1Depletion.v`
- `formal/g1/isabelle/G1_Depletion.thy`
- `formal/g1/agda/G1Depletion.agda`
- `experiments/g1_beta_half_two_tubes.py`

The proof assistants intentionally do not assert the missing PDE theorem as a global axiom. They make it a supplied interface/locale/record field, so kernel success cannot be misreported as Navier–Stokes regularity.

## Promotion gates
`TOY_BETA_HALF = SUPPORTED/NOT_SUPPORTED/INCONCLUSIVE`
`BETA_HALF_UNIFORM_NS = NOT_ESTABLISHED`
`COHERENCE_TO_CLOSED = OPEN_BRIDGE`
`CLOSED_TO_DECAY = KERNEL_TARGET`
`GLOBAL_REGULARITY = NOT_ESTABLISHED`
