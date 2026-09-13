# 09 — Required Cancellations

## Purpose

Lists candidate dominant terms and cancellation identities that must hold to
preserve the claimed forcing smoothness classes under the proposed construction.

## Background

For a construction that builds a smooth, compactly supported forcing \(f\),
the NS residual must satisfy

\[
R_{\text{NS}}(u,p,f) := \partial_t u + (u\cdot\nabla)u + \nabla p - \nu\Delta u - f = 0.
\]

If the construction decomposes \(u = u_N + u_\perp\) (low + high frequency),
then the residual splits as

\[
R = R_{\text{low}} + R_{\text{cross}} + R_{\text{high}},
\]

where cross-term \(R_{\text{cross}} = (u_N\cdot\nabla)u_\perp + (u_\perp\cdot\nabla)u_N\)
is the closure obstruction (see A-02 in `evidence/lre_evidence_inventory.md`).

## Required cancellations list

### CAN-1: Pressure–forcing cancellation

The main cancellation required for compact forcing support is

\[
\nabla p + \partial_t u_\perp + (u\cdot\nabla)u_\perp - \nu\Delta u_\perp
= f_{\perp} + \text{(compactly supported correction)}.
\]

For \(f\) to be compactly supported, the non-compact pressure tail
\(\nabla p = O(|x|^{-4})\) must be cancelled by a corresponding non-compact
term in \(\partial_t u_\perp\).  This requires \(\partial_t u_\perp \not\in C^\infty_c\)
unless an explicit far-field compensator is introduced.

**Status: NOT VERIFIED** — no explicit compensator found in the public Lean files.

### CAN-2: Cross-frequency cancellation (closure obstruction)

\[
P_N[(u\cdot\nabla)u] - (P_N u)\cdot\nabla(P_N u) = T(u_N, u_\perp)
\]

must be bounded (and ideally smooth) for the projected dynamics to close.
In the LRE prior work this term \(T\) is the **residual coupling operator**
(commit `730aa849`, evidence item A-04).  The question for the external
construction is whether \(T\) is bounded in the relevant energy space near
blow-up.

**Status: STRUCTURAL_OVERLAP_FOUND** — the residual coupling architecture matches
the LRE prior work at the structural level.  Exact quantitative bounds from
the public CorrectionStep.lean machinery are NOT YET MATCHED.

### CAN-3: Reynolds–stress cancellation in correction step

The iterative correction \(u^{(n+1)} = u^{(n)} + C_n\) requires that the new
residual \(R_{n+1}\) be strictly smaller than \(R_n\) in the \(L^2\) or critical
norm:

\[
R_{n+1}(u^{(n+1)}) \prec R_n(u^{(n)}).
\]

This requires term-by-term cancellation of the new residual contributions
coming from the cross-frequency interaction of \(C_n\) with \(u^{(n)}\).

**Status: NOT_ESTABLISHED** — iterative correction hierarchy not found in prior corpus.

### CAN-4: Forcing cancellation at high frequency (\(f = -R\))

The LRE prior work records the **engineered forcing cancellation** candidate
\(F = -R\) (evidence item D-05) as `NOT_ESTABLISHED`.  The external construction
nominally uses a forcing designed to cancel the high-frequency residual.  The
exact formulation in the public files (NavierStokes/Forcing.lean, if present)
has not been fully matched to the prior corpus.

**Status: NOT_ESTABLISHED** in prior corpus.

### CAN-5: Pressure–nonlinearity commutator

Near the blow-up concentration ball, the commutator

\[
[\partial_t + (u\cdot\nabla), \Delta^{-1}\partial_i\partial_j](u_iu_j)
\]

generates terms of order \(|\nabla u|^2\) in \(L^{3/2}\), which must be
absorbed into the forcing bounds.  This is a standard elliptic estimate but
requires tracking through the localisation cut-off.

**Status: NOT REFUTED** (no contradiction found).

## Summary table

| Cancellation | Status |
|---|---|
| CAN-1: pressure–forcing compact support | NOT_VERIFIED |
| CAN-2: cross-frequency closure (T term) | STRUCTURAL_OVERLAP_FOUND (not exact) |
| CAN-3: Reynolds-stress correction (iterative) | NOT_ESTABLISHED |
| CAN-4: engineered forcing \(F=-R\) | NOT_ESTABLISHED |
| CAN-5: pressure–nonlinearity commutator | NOT_REFUTED |

Overall status: **UNRESOLVED** — several required cancellations not verified or not found.
