# 08 — Scaling Exponents

## Ansatz diagnostics

For a blow-up profile ansatz

\[
u(x,t)\sim(T-t)^{-\alpha}\,U\!\left(\frac{x-x^*}{(T-t)^\beta}\right),
\]

the dominant terms in the NS equation scale as follows:

\[
\partial_t u\sim(T-t)^{-\alpha-1},\quad
(u\cdot\nabla)u\sim(T-t)^{-2\alpha-\beta},\quad
\nu\Delta u\sim(T-t)^{-\alpha-2\beta}.
\]

## Balance conditions

### Inviscid (nonlinear = temporal):

\[
-\alpha-1 = -2\alpha-\beta \implies \alpha = 1-\beta.
\]

### Type-I (classical self-similar): \(\alpha=1,\,\beta=1/2\)

The unique choice \(\alpha=1,\,\beta=1/2\) balances all three terms simultaneously
(viscous ∼ temporal ∼ nonlinear) and corresponds to the self-similar blow-up
profile:

\[
u\sim\frac{1}{T-t}\,U\!\left(\frac{x-x^*}{\sqrt{T-t}}\right).
\]

The self-similar profile \(U\) satisfies the **Leray system**.

### Type-II blow-up: \(\alpha\neq 1\) or \(\beta\neq 1/2\)

Type-II blow-up concentrates faster than the self-similar rate.  Hou–Li and
others have proposed type-II scenarios with \(\alpha>1\).  These require
stronger concentration and make the \(L^3\)-norm blow up faster than
\((T^*-t)^{-1/2}\).

## Exponent scan (python/exponent_scan.py)

The script `python/exponent_scan.py` performs a numerical sweep over
\((\alpha,\beta)\in[0.5,2.0]\times[0.1,1.0]\) and reports which pairs satisfy
the NS balance condition \(2\alpha+\beta = \alpha+2\beta+1\) (i.e.\
\(\alpha-\beta=1\)).  The result is the one-dimensional locus

\[
\alpha = \beta + 1.
\]

| \(\beta\) | \(\alpha\) | Type |
|---|---|---|
| 0.5 | 1.5 | non-self-similar |
| **0.5** | **1.0** | **Type-I self-similar** (only if \(\alpha-\beta=0.5\)†) |
| 1.0 | 2.0 | faster blow-up |

†The classical Type-I value satisfies the full 3-way balance \(\alpha+1 = 2\alpha+\beta = \alpha+2\beta\),
which requires separately \(\alpha=1\) and \(\beta=1/2\).

## Exponents in the proposed construction

The proposed external construction (target 2026-09-08) introduces a **carrier
frequency** \(N\) and a **scaling parameter** \(\lambda\).  The relevant
exponents inferred from the public Lean files are:

| Parameter | Scaling | Source file (OpenAI) |
|---|---|---|
| `coreVelocity` | \(N^0\) | `Scaling.lean` |
| `carrierFrequency` | \(N\) | `Scaling.lean` |
| `radialLength` | \(N^{-1}\) | `Scaling.lean` |
| `waveLength` | \(N^{-1}\) | `Scaling.lean` |
| residual bound | \(N^{-\gamma}\) | `BaseResidual.lean` |

The relationship between the carrier frequency \(N\to\infty\) and the blow-up
time \(T^*\) is not explicitly established in the material currently audited.

## Consistency with critical-\(L^3\) architecture

For the construction to produce an \(L^3\)-blow-up, we need

\[
\int_{\mathbb{R}^3}|u(x,t)|^3\,dx\to\infty.
\]

In the concentration ball of radius \(r\sim N^{-1}\), the \(L^3\) contribution
of the carrier component scales as

\[
\int_{B_r}|u_\perp|^3\,dx \sim \|u_\perp\|_{L^\infty}^3\,r^3 \sim N^3\cdot N^{-3} = 1,
\]

giving an \(O(1)\) contribution that does **not** blow up by itself.  The blow-up
must come from accumulation across the correction hierarchy, which is the
\(u^{(n+1)}=u^{(n)}+C_n\) iterative correction mechanism — a mechanism
classified as `NOT_FOUND` in the current prior-work corpus.

## Status

| Test | Result |
|---|---|
| SE-1: Type-I balance (\(\alpha=1,\beta=1/2\)) | CONSISTENT_WITH_CONSTRUCTION (not confirmed) |
| SE-2: Carrier frequency vs.\ blow-up time linking | UNRESOLVED |
| SE-3: \(L^3\)-blow-up from carrier alone | NOT_ESTABLISHED |
| SE-4: \(L^3\)-blow-up from iterative accumulation | CONSTRUCTION_NOT_FOUND_IN_PRIOR_CORPUS |

Overall status: **UNRESOLVED**.
