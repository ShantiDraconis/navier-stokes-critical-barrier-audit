# 12 — Mean-to-Local Closure

## Problem statement

The Poincaré Mean Closure (PMC) and Mean-to-Local Closure (MLC) conjectures
address the passage from **mean-field** or **ensemble-averaged** dynamics to
**local** pointwise control in the concentration window.

## Poincaré Mean Closure (PMC)

**Conjecture (PMC).** Let \(u_N = P_N u\) be the low-frequency projection of
the velocity field and let \(\bar u = |\Omega|^{-1}\int_\Omega u\,dx\) be its
spatial mean over a concentration ball \(\Omega\).  Then there exists a constant
\(C_{PM}>0\) and an exponent \(\gamma>0\) such that

\[
\|u_N - \bar u_N\|_{L^2(\Omega)} \leq C_{PM}\,r^{\gamma}\,\|\nabla u_N\|_{L^2(\Omega)},
\]

where \(r = \text{diam}(\Omega)\).

This is a **Poincaré-type inequality** asserting that the mean of the projection
controls the local fluctuation at the sub-critical scale.

**Status:** `CONJECTURAL` — not established in the current prior-work corpus.
Node: `CONJECTURE:PMC`.

## Mean-to-Local Closure (MLC)

**Conjecture (MLC).** Under the spectral projection architecture
\(u = u_N + u_\perp\), the closure of the mean dynamics

\[
\frac{d}{dt}\bar\pi(u) = \bar F(\bar\pi(u)) + \bar K(\bar R(u),\bar\pi(u))
\]

locally controls the full projected dynamics \(\pi(u)\) pointwise through a
quantitative interpolation:

\[
\|\pi(u) - \bar\pi(u)\|_{L^\infty(\Omega)} \leq C_{ML}\,\|u_\perp\|_{L^2(\Omega)}.
\]

**Status:** `CONJECTURAL` — not established.  Node: `CONJECTURE:MLC`.

## Relationship to the LRE coupling architecture

The LRE construction (Fagliari prior corpus, December 2025) establishes the
**full projected dynamics**

\[
\frac{d}{dt}\pi(u) = F(\pi(u)) + K(R(u),\pi(u))
\]

at the structural/architectural level (evidence items A-06, A-07 in
`evidence/lre_evidence_inventory.md`, commit `14322ff2`, 2025-12-19).

The MLC conjecture addresses whether the **mean-to-pointwise** extension of
this architecture holds.  Its resolution would upgrade the current structural
overlap classification to a tighter local matching.

## Audit status

Both PMC and MLC remain in the `CONJECTURAL` tier.  They do not block the
established structural-overlap findings but are required for the strongest
version of the local concentration argument.

Nodes in `graph/nodes.yaml`: `CONJECTURE:PMC`, `CONJECTURE:MLC`.
