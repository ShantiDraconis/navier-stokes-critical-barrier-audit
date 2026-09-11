# 11 — Failed Refutation Attempts

## Purpose

Catalog of attempted contradiction paths that did not close under explicit
hypotheses.  Each entry records the attempt, the blocking step, and the
residual open question.

## FRA-01: Dimensional analysis contradiction

**Attempt:** Show that no forcing \(f\in C^\infty_c\) can produce a solution
blowing up in finite time, by dimensional analysis of the energy input rate.

**Blocking step:** The dimensional argument applies to the energy identity

\[
\partial_t E_2 \leq \|f\|_{L^2}\|u\|_{L^2},
\]

but this bound does not prevent concentration — it only bounds the total energy.
Local concentration is consistent with a globally bounded \(\|f\|_{L^2}\) norm.

**Residual question:** Whether the \(L^3\)-norm can blow up without the
\(L^2\)-energy blowing up is exactly the ESS open problem.

**Verdict: NOT CLOSED**.

## FRA-02: Frequency cut-off incompatibility

**Attempt:** Show that a sharp frequency cut-off at \(N\) introduces Gibbs
oscillations in physical space that are inconsistent with smooth compact
forcing.

**Blocking step:** Smooth frequency cut-offs (mollification via a Schwartz
function in Fourier space) avoid Gibbs oscillations.  The Bony paradifferential
calculus provides smooth localisation.

**Verdict: NOT CLOSED** (contradiction does not arise for smooth cut-offs).

## FRA-03: Backward uniqueness constraint on the correction hierarchy

**Attempt:** Use the ESS backward uniqueness argument to show that the iterative
correction sequence \(u^{(n)}\to u\) cannot converge to a blow-up solution with
bounded \(L^3\)-norm.

**Blocking step:** Backward uniqueness shows that a smooth solution cannot
transition from blow-up to regular behaviour, but it does not prevent a
sequence of smooth approximate solutions from converging to a blow-up solution.
The convergence of the correction hierarchy must be shown separately.

**Verdict: NOT CLOSED**.

## FRA-04: Non-existence of type-I self-similar blow-up

**Attempt:** Invoke Nečas–Růžička–Šverák (1996) non-existence of nontrivial
type-I self-similar blow-up to rule out the proposed construction.

**Blocking step:** The NRS result applies to self-similar blow-up profiles in
the exact Leray system.  The proposed construction does not claim a purely
self-similar profile; it uses a carrier–jet architecture that is not of the
standard self-similar form.

**Verdict: NOT APPLICABLE** (NRS does not directly refute the construction).

## FRA-05: Energy cascade contradicts compact support

**Attempt:** Show that the turbulent energy cascade requires energy transfer
to arbitrarily large spatial scales, contradicting the compact-support claim.

**Blocking step:** The direct energy cascade goes to **small** scales (high
frequencies), not large scales.  The inverse energy cascade (present in 2D NS)
does not occur in 3D.  Compact support is not contradicted by the forward cascade.

**Verdict: NOT CLOSED** (cascade argument does not produce contradiction).

## FRA-06: Pressure nonlocality trivially refutes compact forcing

**Attempt:** Use the explicit formula \(p = R_iR_j(u_iu_j)\) to show that for
compactly supported \(u\), the pressure is not compactly supported, hence
\(f = \partial_tu + (u\cdot\nabla)u + \nabla p - \nu\Delta u\) is not
compactly supported, contradicting the construction's claims.

**Blocking step:** The construction's claimed compact support for \(f\) may
involve a renormalization: the constructed \(f\) may be defined to absorb
exactly the non-compact pressure tail, so that the sum is compact.  This
requires an explicit cancellation mechanism (see CAN-1 in `audit/09_required_cancellations.md`).

**Verdict: OPEN** — CAN-1 has not been verified, so this remains a potential
refutation path.  However, until CAN-1 is explicitly tested and confirmed to
fail, no definitive refutation is registered.

## Summary

| Attempt | Verdict |
|---|---|
| FRA-01: energy-dimension argument | NOT CLOSED |
| FRA-02: Gibbs/sharp cut-off | NOT CLOSED (smooth cut-offs avoid this) |
| FRA-03: backward uniqueness | NOT CLOSED |
| FRA-04: NRS non-existence | NOT APPLICABLE |
| FRA-05: energy cascade | NOT CLOSED |
| FRA-06: pressure nonlocality | OPEN — potential refutation path via CAN-1 |

**Global refutation status: NOT ESTABLISHED** (see `CLAIMS.md` CLAIM-007 and
`audit/10_candidate_contradictions.md`).
