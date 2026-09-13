# Audit 66 — Corrected conditional closure theorem and final-paper language

Status: **CONDITIONAL REDUCTION ESTABLISHED; OPEN PDE BRIDGE NOT PROVED**

Date: 2026-09-13

## 1. Executive correction

The shortest honest route is not G1 -> G2 -> G3 -> G4 as four equally independent
gaps. If G1 supplies a uniform enstrophy bound, the critical endpoint follows directly:

\[
\sup_{t<T^*}\|u(t)\|_2<\infty,\qquad
\sup_{t<T^*}\|\omega(t)\|_2<\infty
\]

imply, for divergence-free fields on \(\mathbb R^3\),

\[
\|\nabla u(t)\|_2\lesssim\|\omega(t)\|_2,\qquad
\|u(t)\|_6\lesssim\|\nabla u(t)\|_2,
\]

and therefore

\[
\|u(t)\|_3
\le
\|u(t)\|_2^{1/2}\|u(t)\|_6^{1/2}
\lesssim
\|u(t)\|_2^{1/2}\|\omega(t)\|_2^{1/2}.
\]

Thus bounded energy plus bounded enstrophy gives
\(u\in L^\infty(0,T^*;L^3(\mathbb R^3))\), after which the classical
Escauriaza–Seregin–Šverák endpoint excludes a finite first singular time.

Littlewood–Paley high/low reconstruction remains useful as a diagnostic or an
alternative route, but is not needed for this particular implication.

## 2. Exact enstrophy identity and normalization

For a sufficiently smooth unforced incompressible solution

\[
\partial_tu+(u\cdot\nabla)u-\nu\Delta u+\nabla p=0,\qquad
\nabla\cdot u=0,
\]

let \(\omega=\nabla\times u\) and
\(S=\frac12(\nabla u+\nabla u^\mathsf T)\). Then

\[
\frac12\frac{d}{dt}\|\omega(t)\|_2^2
+\nu\|\nabla\omega(t)\|_2^2
=
\int_{\mathbb R^3}\omega\cdot S\omega\,dx.
\tag{E}
\]

Under the boundary/decay and integrability assumptions required for the Betchov
identity,

\[
\int_{\mathbb R^3}\omega\cdot S\omega\,dx
=
-4\int_{\mathbb R^3}\det S\,dx
=
-\frac43\int_{\mathbb R^3}\operatorname{tr}(S^3)\,dx,
\tag{B}
\]

because \(S\) is trace-free and
\(\operatorname{tr}(S^3)=3\det S\) pointwise for a trace-free \(3\times3\)
matrix.

Consequently, the three integrals in the draft are not literally equal. Their signs
and constants must be preserved. If a different convention for \(S\), vorticity, or
the Laplacian is used, the identity must be re-derived under that convention.

## 3. Minimal sufficient open bridge

Fix a putative first singular time \(T^*<\infty\). A sufficient terminal-interval
bridge is:

\[
\exists t_0<T^*,\ \exists\delta\in(0,1]:
\quad
\int_{\mathbb R^3}\omega\cdot S\omega\,dx
\le
(1-\delta)\nu\|\nabla\omega\|_2^2
\quad
\text{for a.e. }t\in(t_0,T^*).
\tag{G1}
\]

Combining (E) and (G1),

\[
\frac{d}{dt}\|\omega(t)\|_2^2
+2\delta\nu\|\nabla\omega(t)\|_2^2
\le0.
\]

Therefore

\[
\sup_{t_0<t<T^*}\|\omega(t)\|_2
\le \|\omega(t_0)\|_2<\infty.
\]

The solution is smooth on every compact subinterval before \(T^*\), so this gives the
required bound on the whole maximal interval after combining it with the earlier-time
bound.

### Classification

G1 is a **sufficient condition** for this route. The audit does not establish that G1
is logically equivalent to the Millennium problem, nor that every globally regular
solution must satisfy this exact pointwise-in-time sub-viscous inequality.

## 4. Direct endpoint closure

Energy inequality/balance gives

\[
\sup_{t<T^*}\|u(t)\|_2\le \|u_0\|_2.
\]

For suitable decay on \(\mathbb R^3\), the div–curl identity gives

\[
\|\nabla u(t)\|_2=\|\omega(t)\|_2
\]

for divergence-free \(u\); an inequality with a fixed convention-dependent constant
is enough. Sobolev and interpolation then yield

\[
\sup_{t<T^*}\|u(t)\|_3
\le
C_\mathrm{Sob}^{1/2}
\|u_0\|_2^{1/2}
\sup_{t<T^*}\|\omega(t)\|_2^{1/2}
<\infty.
\tag{L3}
\]

By the ESS endpoint theorem, (L3) excludes \(T^*\) as a finite singular time.
Therefore the conditional conclusion is global continuation.

This route requires finiteness, not smallness, of the global \(L^3\) norm. Introducing
an unspecified \(\varepsilon_{\mathrm{ESS}}\) smallness threshold is unnecessary for
the global endpoint theorem and risks confusing ESS with local epsilon-regularity
criteria.

## 5. Correct conditional theorem for the paper

### Theorem (conditional global regularity under uniform signed depletion)

Let \(u_0\) be smooth, divergence-free initial data in the admissible class of the
three-dimensional incompressible Navier–Stokes Cauchy problem on \(\mathbb R^3\), and
let \(u\) be the corresponding maximal smooth solution on \([0,T^*)\), with viscosity
\(\nu>0\). Assume that whenever \(T^*<\infty\), there exist
\(t_0\in(0,T^*)\) and \(\delta\in(0,1]\) such that, for almost every
\(t\in(t_0,T^*)\),

\[
\int_{\mathbb R^3}\omega(x,t)\cdot S(x,t)\omega(x,t)\,dx
\le
(1-\delta)\nu\|\nabla\omega(t)\|_{L^2(\mathbb R^3)}^2.
\]

Then \(T^*=\infty\).

### Proof

Assume for contradiction that \(T^*<\infty\). The enstrophy identity and the
hypothesis imply

\[
\frac{d}{dt}\|\omega(t)\|_2^2
+2\delta\nu\|\nabla\omega(t)\|_2^2\le0
\]

on the terminal interval. Hence
\(\sup_{t<T^*}\|\omega(t)\|_2<\infty\). Energy control, the div–curl identity,
the Sobolev embedding \(\dot H^1(\mathbb R^3)\hookrightarrow L^6(\mathbb R^3)\),
and interpolation between \(L^2\) and \(L^6\) give

\[
\sup_{t<T^*}\|u(t)\|_3<\infty.
\]

The Escauriaza–Seregin–Šverák endpoint regularity theorem then implies that \(u\)
extends regularly through \(T^*\), contradicting maximality. Therefore
\(T^*=\infty\). \(\square\)

## 6. What this theorem delivers automatically

Once G1 is genuinely derived from the Navier–Stokes dynamics, the following are
downstream:

1. uniform terminal enstrophy control;
2. uniform \(H^1\) control of velocity;
3. uniform \(L^6\) control;
4. uniform critical \(L^3\) control by interpolation;
5. exclusion of a finite first singular time through ESS;
6. global continuation in the selected admissible solution class.

These consequences are conditional algebra/analysis. The new mathematical burden is
the derivation of G1 from the PDE without importing an already regularizing hypothesis.

## 7. What must not appear in a final claim

The following statements are unsupported or incorrectly normalized:

- “G1 is equivalent to the Millennium problem.” Use “G1 is sufficient for the stated
  continuation route.”
- “\(\int\det S=\int\omega\cdot S\omega=\int\operatorname{tr}(S^3)\).”
  Preserve the Betchov constants and signs.
- “A large helicity forces the stretching term to change sign.” No such general
  implication has been established here; viscosity also prevents treating helicity as
  a universally conserved Navier–Stokes quantity.
- “G2 is completely proved” when the Lean item still contains \`sorry\` or only an
  abstract projector inequality.
- “G4 is only formalization.” A theorem invocation is mathematically legitimate on
  paper once its hypotheses are checked, but a fully internal Lean proof would require
  a major analytic library. These are different deliverables.
- “Three to five thousand lines will suffice.” No defensible line estimate is available
  before dependency and Mathlib coverage analysis.
- “ESS eliminates only Type-I blow-up.” The endpoint theorem excludes a finite singular
  time under the bounded critical \(L^\infty_tL^3_x\) hypothesis; it is not merely a
  Type-I exclusion.

## 8. Optional Littlewood–Paley lemma, correctly parameterized

If \(P_k\) denotes a homogeneous dyadic block and \(J\) a dyadic index, then formally

\[
\|P_k u\|_3
\lesssim
2^{k/2}\|P_k u\|_2
\lesssim
2^{-k/2}\|P_k\omega\|_2.
\]

Cauchy–Schwarz gives

\[
\|P_{>J}u\|_3
\lesssim
2^{-J/2}\|\omega\|_2.
\]

If the cutoff is expressed as a physical frequency \(\Lambda=2^J\), the same bound is

\[
\|P_{>\Lambda}u\|_3
\lesssim
\Lambda^{-1/2}\|\omega\|_2.
\]

Do not mix \(2^{-J/2}\) with \(\Lambda^{-1/2}\), and do not replace either by
\(R^{-1/2}\) until \(R\) has been defined as an index or a physical frequency.

This lemma is useful, but once uniform enstrophy is available, direct Sobolev
interpolation already supplies the global critical bound needed by ESS.

## 9. Dynamic-coherence research program

A geometric route must have two separately proved arrows:

\[
\text{actual Navier–Stokes dynamics}
\Longrightarrow
\text{quantitative terminal geometry}
\Longrightarrow
\text{G1 signed sub-viscous depletion}.
\]

A vorticity-direction coherence criterion from the literature cannot be relabeled as
the first arrow. The project must also handle:

- zeros of vorticity, where \(\xi=\omega/|\omega|\) is undefined;
- localization and boundary terms;
- splitting and merging of intense-vorticity components;
- scale covariance;
- constants uniform as \(t\uparrow T^*\);
- the signed kernel, not only its absolute value;
- localized-packet and high-strain coherent-direction countertests;
- non-circularity against known critical regularity criteria.

A percentile statistic such as \(C_H^{95}\) is numerical evidence for or against a
conjecture; it is not a uniform theorem and does not prove G1.

## 10. Formal-status ledger

| Object | Status |
|---|---|
| Enstrophy balance with exact hypotheses | EXTERNAL/TO FORMALIZE |
| Betchov constants and signs | MUST BE VERIFIED UNDER FIXED CONVENTIONS |
| G1 -> dissipative inequality | PROVED LOGIC |
| Dissipative inequality -> uniform enstrophy | STANDARD ANALYSIS / TO FORMALIZE |
| Energy + enstrophy -> uniform \(L^3\) | STANDARD ANALYSIS / TO FORMALIZE |
| Uniform \(L^\infty_tL^3_x\) -> continuation | EXTERNAL ESS THEOREM |
| Dynamics -> critical geometry | OPEN |
| Critical geometry -> exact G1 coefficient | OPEN UNTIL QUANTITATIVELY MATCHED |
| Littlewood–Paley tail formula | PAPER-LEVEL STANDARD; LEAN PROOF NOT YET CERTIFIED |
| Unconditional global regularity | NOT ESTABLISHED |

## 11. Formal companion

The corrected companion file is:

\`formal/G1/G1_PrizeStandard_Interface.lean\`

It removes the earlier definition

\`DynamicCriticalGeometry := True\`

and replaces it with an explicit proposition parameter plus a bridge structure. It
also restores viscosity in G1 and represents fractional powers with \`Real.rpow\`.

Its proved declarations certify conditional algebra and logical composition only.

## 12. Primary literature anchors

- Escauriaza, Seregin and Šverák, *L3,infinity-solutions to the Navier–Stokes
  equations and backward uniqueness*:  
  https://www.pdmi.ras.ru/~seregin/L3infty.pdf
- Constantin and Fefferman, *Direction of vorticity and the problem of global
  regularity for the Navier–Stokes equations*:  
  https://iumj.s3-us-west-2.amazonaws.com/IUMJ/FullText/42/42-3-08.pdf

## 13. Final audit verdict

\`\`\`text
CONDITIONAL_THEOREM = VALID AFTER EXACT ANALYTIC HYPOTHESES
G1_AS_SUFFICIENT_TERMINAL_DEPLETION = OPEN_FROM_ACTUAL_NS
G1_EQUIVALENT_TO_MILLENNIUM = NOT ESTABLISHED
G2_G3_REQUIRED_AFTER_UNIFORM_ENSTROPHY = NO
DIRECT_ENERGY_ENSTROPHY_TO_L3 = AVAILABLE
ESS_SMALLNESS_THRESHOLD_REQUIRED = NO
DYNAMIC_COHERENCE_TO_G1 = OPEN
LEAN_UNCONDITIONAL_PROOF = ABSENT
NAVIER_STOKES_GLOBAL_REGULARITY = NOT ESTABLISHED
\`\`\`
