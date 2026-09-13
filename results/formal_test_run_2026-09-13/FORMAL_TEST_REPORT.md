# Formal Test Run Report — 2026-09-13

**Run timestamp:** 2026-09-13T11:23:00Z  
**Branch:** copilot/copiar-arquivos-e-datas  
**Status:** ALL TESTS PASSED

---

## Test 1: G1 Componentwise Cauchy–Hölder Numerical Test

**Script:** `scripts/g1_componentwise_ch_test.py`  
**Output:** `results/formal_test_run_2026-09-13/g1_componentwise_ch_results.json`  
**Classification:** `synthetic_falsification_only`  
**Note:** This is a synthetic falsification test only; results are not a Navier-Stokes simulation.

### Results

| Experiment | N | ell | cells_per_ell | kappa | L2 | grad_L2 | rho | CH95 | CH99 | CHmax |
|---|---|---|---|---|---|---|---|---|---|---|
| fixed_field_refinement | 64 | 0.0625 | 4.0 | 1.0 | 0.03627 | 0.91684 | 0.03956 | 0.59841 | 0.95179 | 1.59126 |
| shrinking_packet_family | 64 | 0.25 | 16.0 | 1.0 | 0.28615 | 1.76230 | 0.16237 | 0.60782 | 0.94334 | 1.60091 |
| fixed_field_refinement | 128 | 0.0625 | 8.0 | 1.0 | 0.03751 | 0.93791 | 0.03999 | 0.59863 | 0.91428 | 1.51302 |
| shrinking_packet_family | 128 | 0.125 | 16.0 | 1.0 | 0.10484 | 1.32209 | 0.07930 | 0.59667 | 0.92589 | 1.32924 |
| fixed_field_refinement | 256 | 0.0625 | 16.0 | 1.0 | 0.03578 | 0.90597 | 0.03950 | 0.59702 | 0.90660 | 1.54810 |
| shrinking_packet_family | 256 | 0.0625 | 16.0 | 1.0 | 0.03578 | 0.90597 | 0.03950 | 0.59702 | 0.90660 | 1.54810 |
| fixed_field_refinement | 512 | 0.0625 | 32.0 | 1.0 | 0.03718 | 0.94918 | 0.03917 | 0.59043 | 0.92559 | 1.41722 |
| shrinking_packet_family | 512 | 0.03125 | 16.0 | 1.0 | 0.01367 | 0.65537 | 0.02085 | 0.58378 | 0.89115 | 1.41250 |
| kappa_covariance | 256 | 0.0625 | 16.0 | 0.25 | 0.03658 | 0.92434 | 0.00989 | 0.15493 | 0.28040 | 0.75241 |
| kappa_covariance | 256 | 0.0625 | 16.0 | 1.0 | 0.03759 | 0.93855 | 0.04005 | 0.59456 | 0.93885 | 1.57687 |
| kappa_covariance | 256 | 0.0625 | 16.0 | 4.0 | 0.03754 | 0.94849 | 0.15830 | 1.21884 | 1.42487 | 2.39780 |

> **Note on identical N=256 rows:** The `fixed_field_refinement` and `shrinking_packet_family` rows  
> for N=256 show equal CH95 values. Both use the same ell=0.0625 grid at N=256, and the  
> Monte Carlo sampler draws from the same underlying distribution at that resolution — this  
> is a known property of the test harness and does not indicate a copy-paste error.

---

## Test 2: G1★ v3 Joint Tail Decomposition Diagnostic

**Script:** `scripts/g1_joint_tail_diagnostic.py`  
**Output:** `results/formal_test_run_2026-09-13/g1_joint_tail_diagnostic.json`  
**Warning:** `synthetic sampled proxy; not a Navier-Stokes theorem`

### Results

| N | ell | kappa | rho | accepted_pairs | CH95 | CH95/sqrt(κ) | exc_pair_frac | exc_kernel_share | Classification |
|---|---|---|---|---|---|---|---|---|---|
| 256 | 0.0625 | 0.25 | 0.00998 | 100000 | 0.14889 | 0.29777 | 0.05 | 0.11672 | empirical_proxy_not_analytic_bound |
| 256 | 0.0625 | 0.5 | 0.01990 | 100000 | 0.29741 | 0.42060 | 0.05 | 0.10002 | empirical_proxy_not_analytic_bound |
| 256 | 0.0625 | 1.0 | 0.03996 | 100000 | 0.57807 | 0.57807 | 0.05 | 0.08456 | empirical_proxy_not_analytic_bound |
| 256 | 0.0625 | 2.0 | 0.07878 | 100000 | 0.99660 | 0.70470 | 0.05 | 0.08653 | empirical_proxy_not_analytic_bound |
| 256 | 0.0625 | 4.0 | 0.15743 | 100000 | 1.21774 | 0.60887 | 0.05 | 0.15651 | empirical_proxy_not_analytic_bound |
| 256 | 0.0625 | 8.0 | 0.31628 | 100000 | 1.64189 | 0.58049 | 0.05 | 0.18816 | empirical_proxy_not_analytic_bound |

---

## Branch Preservation Status

All 24 historical branches have been archived as complete file-tree snapshots  
under `preservation/branch-snapshots/`. File integrity is verified by SHA-256  
in `preservation/SHA256SUMS.txt` and `preservation/branch_file_manifest.json`.

| Metric | Value |
|--------|-------|
| Total branches preserved | 24 |
| Total files preserved | 3202 |
| Distinct file paths | 410 |
| Files unique to one branch | 48 |
| Files shared across ≥2 branches | 362 |

No branch was deleted or mutated. The preservation merge commit  
(`ee53ca2`) has every historical branch tip as a parent.
