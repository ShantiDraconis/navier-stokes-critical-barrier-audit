# 04 — Energy Concentration Test

## Purpose

Test compatibility of the proposed construction's energy constraints with the
required \(L^3\)-loss concentration profile and the ESS blow-up alternative.

## Required conditions for a valid blow-up construction

For the proposed external construction (target: 2026-09-08) to be consistent,
it must satisfy simultaneously:

1. **Local energy concentration:** There exists \(r(t)\sim(T^*-t)^{1/2}\) with
   \[
   \int_{B(x^*,r(t))}|u|^3\,dx \geq c_0 > 0.
   \]

2. **Leray energy inequality:** The solution obeys the Leray inequality globally.

3. **\(L^3\)-blow-up profile:** \(\|u(\cdot,t)\|_{L^3}\to\infty\) as \(t\nearrow T^*\).

4. **Concentration-energy balance:** The energy concentrated in the ball
   \(B(x^*,r(t))\) must be consistent with the global energy decay
   \(\|u(\cdot,t)\|_{L^2}^2\leq E_0\).

## Concentration window analysis

At the critical concentration scale \(r\sim(T^*-t)^{1/2}\):

| Quantity | Scaling | Required behaviour |
|---|---|---|
| \(\|u\|_{L^3(B_r)}\) | \(r^0 \cdot (T^*-t)^{-1}\) | \(\to\infty\) |
| \(\|u\|_{L^2(B_r)}\) | \(r^{1/2}\cdot(T^*-t)^{-1}\) | bounded above |
| \(\|\nabla u\|_{L^2(B_r)}\) | \(r^{-1/2}\cdot(T^*-t)^{-1}\) | \(\to\infty\) |
| local enstrophy | \(r^{-1}\cdot(T^*-t)^{-2}\) | singular |

## Conflict tests performed

### Test EC-1: Energy-concentration vs.\ compact-support constraint

If the construction places initial data in \(B(0,R_0)\) and claims blow-up at
the interior point \(x^*\), the finite-speed propagation (which does not hold
for NS due to pressure nonlocality) cannot be invoked.  The pressure nonlocal
tails can carry energy outward at any speed.

**Result:** No direct contradiction found.  The energy remains bounded; the
concentration is a local phenomenon consistent with global energy bounds.
**Status: NOT REFUTED**.

### Test EC-2: \(L^3\)-loss rate vs.\ scaling ansatz

The type-I self-similar profile \(u\sim(T^*-t)^{-1}U((x-x^*)/(T^*-t)^{1/2})\)
gives \(\|u\|_{L^3}\sim(T^*-t)^{-1/2}\to\infty\).  Whether the claimed
construction achieves a type-I, type-II, or other loss rate is
**not established** from the public material reviewed.

**Status: UNRESOLVED**.

### Test EC-3: Energy of carrier-jet component

The proposed high-frequency component (carrier jet) must carry sufficient
energy in \(B(x^*,r(t))\) to produce the required \(L^3\)-concentration.
The energy budget reads:

\[
\int_{B_r}|u_\perp|^3\,dx \lesssim \|u_\perp\|_{L^\infty(B_r)}\cdot\int_{B_r}|u_\perp|^2\,dx.
\]

Without an explicit estimate of \(\|u_\perp\|_{L^\infty}\), this is not closed.

**Status: UNRESOLVED**.

## Current finding

| Test | Result |
|---|---|
| EC-1: global energy vs.\ local concentration | NOT REFUTED |
| EC-2: \(L^3\)-loss rate consistency | UNRESOLVED |
| EC-3: carrier-jet energy budget | UNRESOLVED |

Overall status for this test module: **UNRESOLVED**.
