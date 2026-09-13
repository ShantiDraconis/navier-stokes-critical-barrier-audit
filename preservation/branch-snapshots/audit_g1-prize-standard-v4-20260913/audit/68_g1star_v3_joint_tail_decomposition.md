# Audit 68 — G1* v3 joint-law and exceptional-tail decomposition

Status: **CONDITIONAL ALGEBRA CLOSED; THREE ANALYTIC ARROWS OPEN**

Date: 2026-09-13

## Numerical diagnostic

The synthetic packet diagnostic used N=256, 200,000 norm samples and 100,000
accepted intense-region pairs for each value of kappa.

| kappa | C_H^95 | C_H^95/sqrt(kappa) | exceptional pairs | kernel-proxy share |
|---:|---:|---:|---:|---:|
| 0.25 | 0.1489 | 0.2978 | 5% | 11.67% |
| 0.5 | 0.2974 | 0.4206 | 5% | 10.00% |
| 1 | 0.5781 | 0.5781 | 5% | 8.46% |
| 2 | 0.9966 | 0.7047 | 5% | 8.65% |
| 4 | 1.2177 | 0.6089 | 5% | 15.65% |
| 8 | 1.6419 | 0.5805 | 5% | 18.82% |

The values at kappa=1,4,8 are consistent with an O(1) normalized quantity, but
the non-monotone six-point sample does not prove convergence or a universal constant.
The exceptional 5% carries substantially more than 5% of the singular-kernel proxy in
several runs. This confirms that percentile stability cannot replace a weighted-tail
theorem.

The proxy is

\[
w(x,y)=\frac{|\omega(x)|^2|\omega(y)|\,|\sin\theta(x,y)|}{|x-y|^3}.
\]

It is evaluated on a synthetic divergence-free packet. It is neither the signed
stretching integral nor a Navier--Stokes trajectory.

## Correct formal decomposition

Write the stretching as

\[
\mathcal S(t)=B(t)+E(t),
\]

where B is the analytically controlled bulk and E is the exceptional tail. Assume

\[
B(t)\le c_{bulk}\nu z(t),\qquad
E(t)\le\delta_{tail}\nu z(t),
\]

and the exact budget

\[
c_{bulk}+\delta_{tail}<1.
\]

Then, with

\[
\delta=1-c_{bulk}-\delta_{tail}>0,
\]

one obtains

\[
\mathcal S(t)\le(1-\delta)\nu z(t).
\]

This algebra is encoded without `axiom` or `sorry` in
`formal/millennium/lean/MillenniumAudit/HypothesesComplete_v3.lean`.

## Open arrows retained

The formal source deliberately does not assert:

1. empirical finite-resolution C_H^95 implies an analytic joint law;
2. the joint law implies a bulk coefficient c_bulk;
3. the exceptional 5% satisfies the required kernel-weighted tail inequality;
4. the sum c_bulk+delta_tail is strictly below one;
5. actual Navier--Stokes dynamics supplies these premises.

The earlier proposal compressed items 2--4 into two labels. The exact formal budget
shows that there are three analytic tasks: bulk conversion, tail control, and strict
subcriticality of their combined constants.

## Viscosity normalization warning

The numerical expression `0.6 * 0.427^(3/2) approximately 0.167` is only an arithmetic
combination of tentative constants. It is not a verified PDE coefficient. Scaling can
normalize viscosity in a chosen formulation, but a proof must propagate that
normalization through the kernel representation, rho_j, C_H, and every Sobolev or HLS
constant. No physical conclusion follows from comparing 0.167 with an unspecified nu.

## Current verdict

```text
componentwise C_H^95 stability on synthetic packet = OBSERVED
normalized C_H^95 approximately O(1) for sampled kappa = OBSERVED
existence of a kappa-asymptotic limit = NOT ESTABLISHED
exceptional 5% negligible under kernel weight = FALSE IN THIS PROXY
bulk + tail + budget -> strict depletion = PROVED LOGIC
empirical CH95 -> analytic joint law = OPEN
joint law -> subcritical bulk coefficient = OPEN
kernel-weighted exceptional-tail bound = OPEN
combined coefficient budget < 1 = OPEN
ActualNS -> required analytic premises = OPEN
global regularity = NOT ESTABLISHED
```
