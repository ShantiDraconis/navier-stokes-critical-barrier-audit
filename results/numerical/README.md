# Numerical outputs

This directory holds outputs from the numerical Python scripts in `python/`.

## Scripts and their outputs

| Script | Purpose | Current status |
|---|---|---|
| `python/concentration_scaling.py` | Concentration window scaling estimates | See output below |
| `python/concentration_window.py` | Local \(L^3\) concentration vs.\ radius | See output below |
| `python/exponent_scan.py` | Blow-up ansatz scaling exponent sweep | See output below |
| `python/forcing_scaling.py` | Forcing energy scaling estimates | See output below |
| `python/forcing_test.py` | Forcing smoothness class tests | See output below |
| `python/pressure_checks.py` | Pressure nonlocality estimates | See output below |
| `python/verify_results.py` | Cross-validation of key estimates | See output below |

## Key numerical findings

### Concentration scaling (concentration_scaling.py)

At the critical scale \(r\sim N^{-1}\sim (T^*-t)^{1/2}\):

```
alpha = 1.0, beta = 0.5  -> balance residual = 0.0  (Type-I)
alpha = 1.5, beta = 0.5  -> balance residual = 0.5  (no balance)
alpha = 1.0, beta = 1.0  -> balance residual = 1.0  (no balance)
```

The Type-I self-similar exponents (\(\alpha=1, \beta=0.5\)) are the unique
balanced solution consistent with the Navier–Stokes scaling.

### \(L^3\) concentration window (concentration_window.py)

Estimated \(L^3\) norm in the concentration ball of radius \(r\):

```
r = 1e-2:  ||u||_L3(B_r) ~ 4.0e-2  (below threshold c_0)
r = 1e-3:  ||u||_L3(B_r) ~ 1.2e-1  (approaching threshold)
r = 1e-4:  ||u||_L3(B_r) ~ 3.8e-1  (near threshold c_0 ~ 0.5)
r = 1e-5:  ||u||_L3(B_r) ~ 1.1e+0  (above threshold: concentration confirmed)
```

These estimates are **indicative only** (analytical model, not a numerical
simulation of a real blow-up solution).

### Pressure nonlocality (pressure_checks.py)

Far-field pressure gradient decay:

```
|x| = 10:   |nabla p| ~ 1.0e-4
|x| = 100:  |nabla p| ~ 1.0e-8
|x| = 1000: |nabla p| ~ 1.0e-12
```

Decay exponent: \(-4\) (consistent with \(|\nabla p(x)| = O(|x|^{-4})\)).
The pressure tail is non-zero for all \(|x|<\infty\).

## Summary

All numerical outputs are **consistent with the classical theory** and do not
independently verify or refute the proposed external construction.  They serve
as reference baselines for comparison against any explicit numerical data from
the construction.
