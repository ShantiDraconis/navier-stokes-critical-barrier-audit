# Audit 67 — Synthetic componentwise C_H test and failed kappa absorption

Status: **NUMERICAL SUPPORT FOR SCALE-COVARIANT LOCALIZATION; NO PROOF OF DEPLETION**

Date: 2026-09-13

## Scope

The executable `scripts/g1_componentwise_ch_test.py` is a deterministic synthetic
falsification harness. It is not a Navier–Stokes solver. It evaluates the
divergence-free analytic packet

\[
\omega=\nabla\times(0,0,\psi),\qquad
\psi(x)=\ell e^{-|x|^2/(2\ell^2)},
\]

on quantized grids and estimates

\[
C_H^{95}=Q_{0.95}\left[
\frac{|\sin\angle(\omega(x),\omega(y))|}
{\sqrt{|x-y|/\rho_*}}
\right],\qquad
\rho_*=\kappa\frac{\|\omega\|_2}{\|\nabla\omega\|_2}.
\]

Each row uses 200,000 quadrature samples and 50,000 accepted intense-region pairs.

## Results

| Experiment | N | cells/ell | kappa | C_H^95 | C_H^99 | max |
|---|---:|---:|---:|---:|---:|---:|
| fixed field | 64 | 4 | 1 | 0.5984 | 0.9518 | 1.5913 |
| fixed field | 128 | 8 | 1 | 0.5986 | 0.9143 | 1.5130 |
| fixed field | 256 | 16 | 1 | 0.5970 | 0.9066 | 1.5481 |
| fixed field | 512 | 32 | 1 | 0.5904 | 0.9256 | 1.4172 |
| shrinking packet | 64 | 16 | 1 | 0.6078 | 0.9433 | 1.6009 |
| shrinking packet | 128 | 16 | 1 | 0.5967 | 0.9259 | 1.3292 |
| shrinking packet | 256 | 16 | 1 | 0.5970 | 0.9066 | 1.5481 |
| shrinking packet | 512 | 16 | 1 | 0.5838 | 0.8912 | 1.4125 |

The fixed-field `C_H^95` varies by about 1.4% from N=64 to N=512. The packet family,
kept at 16 cells per local scale while shrinking physically, also remains O(1). This
is consistent with scale covariance of a componentwise radius. It does not establish
boundedness for actual Navier–Stokes solutions or control the exceptional tail.

## Kappa covariance test

| kappa | rho_* | C_H^95 | C_H^95 / sqrt(kappa) |
|---:|---:|---:|---:|
| 0.25 | 0.00989 | 0.1549 | 0.3099 |
| 1 | 0.04005 | 0.5946 | 0.5946 |
| 4 | 0.15830 | 1.2188 | 0.6094 |

For a fixed geometry the definition itself contains `sqrt(rho_*)`; increasing
`kappa` therefore changes `C_H`. Once the sampled radius covers the same geometric
regime, the observed growth is approximately compatible with a square-root response.
Consequently, one cannot treat `C_0` as fixed and then choose `kappa` arbitrarily large
to make `C_0 kappa^{-1/2}` small. Their dependence must be tracked jointly.

## Analytic obstruction in the proposed 20-page closure

The proposed near-field/Young calculation does not prove

\[
|\mathcal S|\le(1-\delta)\nu z.
\]

Three gaps remain:

1. `C_H^95` leaves a kernel-weighted exceptional 5% uncontrolled. A percentile bound
   is not an all-pairs or weighted-tail estimate.
2. Finiteness of an analytic coherence constant supplies a finite coefficient, not
   automatically a coefficient smaller than viscosity. A quantitative smallness or a
   different signed cancellation theorem is required.
3. Young's inequality produces an additive enstrophy-dependent remainder. It cannot
   be written twice as `delta z/2` merely by enlarging `kappa`. Any absorbing-ball
   argument must state and prove the interpolation connecting `z`, enstrophy and the
   conserved energy, with all exponents and viscosity factors retained.

There is also an exponent/type error in the displayed Lean sketch: if
`y=||omega||_2^2` and `z=||grad omega||_2^2`, then a norm expression such as
`||omega||^(5/4)||grad omega||^(3/4)` becomes
`y^(5/8) z^(3/8)`, not the powers later displayed in the prompt.

## Correct status

```text
componentwise rho_j survives this synthetic packet test = OBSERVED
fixed-field refinement of C_H^95                  = NUMERICALLY STABLE HERE
Uniform C_H^95 -> kernel-weighted coherence       = OPEN
analytic sup C_H < infinity -> strict depletion   = NOT PROVED
kappa-large absorption with C_0 held fixed        = INVALID WITHOUT JOINT LAW
ActualNS -> uniform componentwise coherence       = OPEN
unconditional global regularity                   = NOT ESTABLISHED
```

The test narrows the conjecture: componentwise scaling is numerically plausible for
this packet, while the claimed `sup C_H < infinity -> GeometricDepletion` arrow remains
an explicit analytic bridge rather than a completed theorem.
