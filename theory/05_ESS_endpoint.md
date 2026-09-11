# 05 — ESS Endpoint

## Classical statement (Escauriaza–Seregin–Šverák 2003)

**Theorem (ESS).**  Let \(u\) be a Leray–Hopf weak solution to the incompressible
Navier–Stokes equations on \(\mathbb{R}^3\times(0,T^*)\) with divergence-free
initial data \(u_0\in L^2(\mathbb{R}^3)\).  If \(T^*<\infty\) is the first
singular time, then

\[
\lim_{t\nearrow T^*}\|u(\cdot,t)\|_{L^3(\mathbb{R}^3)} = +\infty.
\]

Equivalently: if \(\sup_{0<t<T}\|u(\cdot,t)\|_{L^3}<\infty\), then \(u\) extends
to a smooth solution on \([0,T+\varepsilon)\) for some \(\varepsilon>0\).

## Blow-up alternative

Combined with the Leray regularity theory, the ESS theorem gives the
**dichotomy**:

> A Leray–Hopf weak solution is either (i) globally smooth, or (ii) has
> \(\|u(\cdot,t)\|_{L^3}\to\infty\) at the first singularity time \(T^*\).

This is recorded as `THEOREM:ESS_BLOWUP_ALTERNATIVE` in `graph/nodes.yaml`.

## Proof strategy

The ESS argument proceeds via:

1. **Backward uniqueness** — use Carleman inequalities to show that any two
   weak solutions agreeing at \(t=T^*\) must agree for all earlier times.
2. **Unique continuation** — extend backward uniqueness to yield that a bounded
   \(L^3\)-norm solution cannot develop a singularity.
3. **Energy concentration** — combine with local energy estimates to exclude
   mild singularities in bounded \(L^3\) classes.

## Role in this audit

The ESS endpoint is a **classical result** and does not constitute an original
priority claim.  It is the outer regularity envelope within which the
construction under audit (target: 2026-09-08) must operate.

`THEOREM:ESS_ENDPOINT` and `THEOREM:ESS_BLOWUP_ALTERNATIVE` are both
classified as `CLASSICAL` in `CLAIMS.md` (see `CLAIM-002`, `CLAIM-003`).

## References

- L.\ Escauriaza, G.\ Seregin, V.\ Šverák, *\(L_{3,\infty}\)-solutions of the
  Navier–Stokes equations and backward uniqueness*, Uspekhi Mat.\ Nauk **58** (2003)
  no.\ 2, 3–44.
- G.\ Seregin, *Lecture notes on regularity theory for the Navier–Stokes
  equations*, World Scientific, 2015.

Consequence node: `THEOREM:ESS_BLOWUP_ALTERNATIVE` derived from classical result,
not an original authorship claim.
