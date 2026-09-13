# Verified results

This directory holds numerical outputs and formal proofs that have been
independently verified in the current audit environment.

## Verified items as of 2026-09-11

| Item | Type | Source | Verification method |
|---|---|---|---|
| \(L^3\) scale-invariance identity \(\|u_\lambda\|_3 = \|u\|_3\) | algebraic | `theory/02_scaling.md` | symbolic computation |
| Energy identity \(\partial_t E_2 + \nu\|\nabla u\|_2^2 = \langle f,u\rangle\) | PDE identity | `theory/03_energy.md` | standard PDE calculus |
| Pressure Poisson equation \(-\Delta p = \partial_i\partial_j(u_iu_j)-\nabla\cdot f\) | PDE identity | `theory/07_pressure.md` | divergence of momentum equation |
| Commit `63b248dd` pre-dates 2026-09-08 | provenance | `evidence/commits.yaml` | git timestamp |
| Commit `730aa849` contains spectral projection + residual | code/math | `evidence/lre_evidence_inventory.md` A-01 | commit content inspection |
| Commit `f30ef6a9` contains closure obstruction | code/math | `evidence/lre_evidence_inventory.md` A-02 | commit content inspection |
| Commit `14322ff2` contains coupling evolution equation | code/math | `evidence/lre_evidence_inventory.md` A-06 | commit content inspection |

These are **CLASSICAL** or **PROVED_IN_REPOSITORY** results; see `CLAIMS.md` for status codes.

## Not in this directory

- Numerical concentration simulations: see `results/numerical/`
- Falsified or refuted hypotheses: see `results/falsified/`
- Unresolved items: see `results/unresolved/`
