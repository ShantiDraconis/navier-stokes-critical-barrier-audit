# 33 — Mathlib4 map for the critical \`L^∞_t L^3_x\` endpoint

## Scope and status

This audit note maps the classical endpoint condition

\[
u \in L^\infty(0,T;L^3(\mathbb R^3))
\]

to current Mathlib4 primitives and links that representation to the earliest presently verified occurrences in the ShantiDraconis repositories.

**Status:** representation layer only. This file does **not** claim that Mathlib4 contains a formal proof of the Escauriaza–Seregin–Šverák theorem, and it does not turn an \`axiom\`, \`sorry\`, placeholder, numerical diagnostic, or bounded sample into a proof of global Navier–Stokes regularity.

## Mathematical object

For a time-dependent velocity field \(u(t,x)\),

\[
\|u(t)\|_{L^3_x}
 =
 \left(\int_{\mathbb R^3}|u(x,t)|^3\,dx\right)^{1/3},
\qquad
\|u\|_{L^\infty_tL^3_x}
 =
 \operatorname*{ess\,sup}_{t\in(0,T)}\|u(t)\|_{L^3_x}.
\]

The bounded endpoint hypothesis is

\[
\operatorname*{ess\,sup}_{t\in(0,T)}
\left(\int_{\mathbb R^3}|u(x,t)|^3\,dx\right)^{1/3}<\infty.
\]

For an appropriate Navier–Stokes solution, the classical endpoint implication is

\[
u\in L^\infty(0,T;L^3(\mathbb R^3))
\Longrightarrow
\text{regularity through }T.
\]

Its safe contraposition is

\[
T^*<\infty\text{ is a singular time}
\Longrightarrow
\operatorname*{ess\,sup}_{0<t<T^*}\|u(t)\|_{L^3_x}=\infty.
\]

A statement with an ordinary limit,
\(\lim_{t\uparrow T^*}\|u(t)\|_{L^3_x}=\infty\), is stronger in form than an
\`essSup\` or \`limsup\` statement and must not be substituted without the required hypotheses and a cited theorem.

## Correct Mathlib4 primitives

The mapping below was checked against [leanprover-community/mathlib4 at \`0a54cbb6...\`](https://github.com/leanprover-community/mathlib4/tree/0a54cbb6b30aa313442c77e7d6fe41f992f8ab47).

| Mathematical object | Mathlib4 representation |
|---|---|
| \(\mathbb R^3\) | \`EuclideanSpace ℝ (Fin 3)\` |
| spatial \(L^3\) extended norm | \`MeasureTheory.eLpNorm v (3 : ℝ≥0∞) volume\` |
| time interval | \`Set.Ioo (0 : ℝ) T\` |
| restricted Lebesgue measure | \`volume.restrict (Set.Ioo (0 : ℝ) T)\` |
| essential supremum | \`MeasureTheory.essSup f μ\` |
| finiteness in \(\mathbb R_{\ge0}\cup\{\infty\}\) | \`value < ⊤\` |

Primary Mathlib source anchors:

- [\`EssSup.lean\`](https://github.com/leanprover-community/mathlib4/blob/0a54cbb6b30aa313442c77e7d6fe41f992f8ab47/Mathlib/MeasureTheory/Function/EssSup.lean): \`essSup f μ := (ae μ).limsup f\`.
- [\`LpSeminorm/Basic.lean\`](https://github.com/leanprover-community/mathlib4/blob/0a54cbb6b30aa313442c77e7d6fe41f992f8ab47/Mathlib/MeasureTheory/Function/LpSeminorm/Basic.lean): contains \`eLpNorm f p μ\`, \`eLpNormEssSup\`, and finiteness lemmas.

Corrections to the proposed transcription:

1. \`EuclidianSpace\` is a misspelling; use \`EuclideanSpace\`.
2. Use \`⊤\`, not the prose symbol \`∞\`, in Lean inequalities.
3. The exponent of \`eLpNorm\` is an \`ℝ≥0∞\`; write `f1c920dfe7e7d42f4c40417e0c0c0fb8b8c43670` (private source URL withheld)\`.
4. \`essSup\` accepts a measure and returns an order-theoretic essential supremum; supply the restricted measure explicitly.
5. A raw function \`ℝ³ → ℝ³\` is not itself the quotient type \`MeasureTheory.Lp\`. \`eLpNorm\` provides the extended seminorm representation; an actual \`Lp\` element additionally requires measurability and finite-norm evidence.
6. \`IsWeakSolutionNavierStokes\` and \`IsSmoothAt\` are not supplied merely by importing the cited Mathlib modules. The project must define those predicates and its PDE theory.
7. \`by sorry\` is a proof gap and must be classified as a placeholder, never as machine-checked ESS regularity.

## Auditable Lean representation

This is the intended representation layer. It is a specification fragment; compilation must be checked against the repository's pinned Lean/Mathlib toolchain.

\`\`\`lean
import Mathlib.MeasureTheory.Function.LpSeminorm.Basic
import Mathlib.MeasureTheory.Function.EssSup
import Mathlib.MeasureTheory.Measure.Lebesgue.Basic
import Mathlib.Analysis.InnerProductSpace.EuclideanDist

noncomputable section

open MeasureTheory Set

namespace CriticalBarrier

abbrev R3 := EuclideanSpace ℝ (Fin 3)
abbrev VelocityField := ℝ → R3 → R3

def spatialL3Norm (v : R3 → R3) : ℝ≥0∞ :=
  eLpNorm v (3 : ℝ≥0∞) volume

def timeMeasure (T : ℝ) : Measure ℝ :=
  volume.restrict (Ioo (0 : ℝ) T)

def bochnerLInfL3Norm (u : VelocityField) (T : ℝ) : ℝ≥0∞ :=
  essSup (fun t : ℝ => spatialL3Norm (u t)) (timeMeasure T)

def IsBoundedLInfL3 (u : VelocityField) (T : ℝ) : Prop :=
  bochnerLInfL3Norm u T < ⊤

end CriticalBarrier
\`\`\`

The name \`bochnerLInfL3Norm\` records the mathematical intention. A complete Bochner-space development must still discharge strong-measurability and almost-everywhere-equivalence obligations.

## ESS theorem boundary

A logically honest interface may declare the missing analytic theorem as a named assumption while keeping it visibly separate from proved Mathlib facts:

\`\`\`lean
namespace CriticalBarrier

variable
  (IsSuitableWeakSolution : VelocityField → ℝ → Prop)
  (IsRegularThrough : VelocityField → ℝ → Prop)

axiom ess_endpoint
    (u : VelocityField) (T : ℝ)
    (hT : 0 < T)
    (hsol : IsSuitableWeakSolution u T)
    (hcrit : IsBoundedLInfL3 u T) :
    IsRegularThrough u T

end CriticalBarrier
\`\`\`

\`\`\`text
OBJECT: ess_endpoint
LEAN_STATUS: AXIOM / EXTERNAL_THEOREM_INTERFACE
MATHLIB_PROOF_PRESENT: NO
NAVIER_STOKES_PDE_DEFINITION_PRESENT: REQUIRED
CARLEMAN_BACKWARD_UNIQUENESS_FORMALIZATION: REQUIRED
CLAY_GLOBAL_REGULARITY_CONCLUSION: NOT_ESTABLISHED
\`\`\`

Dependency chain:

\[
\text{measure spaces}
\to eLpNorm_{x,3}
\to essSup_{t\in(0,T)}
\to L^\infty_tL^3_x\text{ boundedness}
\to \text{suitable weak solution}
\to \text{local energy inequalities}
\to \text{compactness/rescaling}
\to \text{backward uniqueness/Carleman}
\to \text{regularity through }T.
\]

Mathlib supplies infrastructure near the beginning. The Navier–Stokes-specific bridge through backward uniqueness remains a separate, substantial formalization obligation.

## Disclosure and verification policy

The historical source repositories cited below are access-controlled. To reduce public
metadata exposure, this public ledger uses stable source identifiers rather than private
repository names or direct private URLs.

- `PRIVATE-SOURCE-A`: earliest Navier–Stokes research source.
- `PRIVATE-SOURCE-B`: classical/formalization source.

The full commit SHA, UTC timestamp, relative path, minimal relevant quotation, and
classification are retained. An authorized auditor can verify them after being granted
read access to the corresponding source. A SHA without access to the source is a
commitment/reference, not independently inspectable public evidence.

This policy protects repository topology while preserving the information needed for
controlled verification. It does not conceal the public audit repository or public
Mathlib4 sources.

## Repository provenance chain

### 1. Earliest recovered conceptual ESS/\(L^3\) occurrence

- Repository: \`ShantiDraconis/millennium-navier-stokes-I\`
- Commit: [\`f1c920dfe7e7d42f4c40417e0c0c0fb8b8c43670\`](https://github.com/ShantiDraconis/millennium-navier-stokes-I/commit/f1c920dfe7e7d42f4c40417e0c0c0fb8b8c43670)
- Timestamp: \`2025-11-25T04:16:50Z\`
- Historical file: [\`docs/RELATED_WORK.md\`](https://github.com/ShantiDraconis/millennium-navier-stokes-I/blob/f1c920dfe7e7d42f4c40417e0c0c0fb8b8c43670/docs/RELATED_WORK.md)
- Recovered wording: \`Escauriaza, Seregin & Šverák (2003): L^3 regularity criterion\`.
- Classification: literature/criterion identification, not a formal proof.

### 2. Earliest recovered compact \(L^{3,\infty}\) notation

- Commit: [\`80951ea236e5f069279fa34d51db95fe8d5b7937\`](https://github.com/ShantiDraconis/millennium-navier-stokes-I/commit/80951ea236e5f069279fa34d51db95fe8d5b7937)
- Timestamp: \`2025-11-25T04:18:20Z\`
- Message: \`Fix typographical notation for L^{3,∞} in related work documentation\`.
- Historical file: [\`docs/RELATED_WORK.md\`](https://github.com/ShantiDraconis/millennium-navier-stokes-I/blob/80951ea236e5f069279fa34d51db95fe8d5b7937/docs/RELATED_WORK.md)
- Classification: explicit compact notation and bibliographic identification.
- Ambiguity warning: isolated \(L^{3,\infty}\) can denote a Lorentz space; normalize the intended endpoint as \(L^\infty_tL^3_x\).

### 3. Earliest recovered unambiguous Bochner endpoint plus blow-up criterion

- Repository: \`ShantiDraconis/millennium-navier-stokes-classical\`
- Commit: [\`d853205ed10e33279327b759adc3135bcd2a262c\`](https://github.com/ShantiDraconis/millennium-navier-stokes-classical/commit/d853205ed10e33279327b759adc3135bcd2a262c)
- Timestamp: \`2025-11-25T06:34:30Z\`
- Historical file: [\`docs/07-blowup-criteria.md\`](https://github.com/ShantiDraconis/millennium-navier-stokes-classical/blob/d853205ed10e33279327b759adc3135bcd2a262c/docs/07-blowup-criteria.md)
- Recovered statements: \(\limsup_{t\to T^{*-}}\|u(t)\|_{L^3}=\infty\), and \`u ∈ L^∞([0,T]; L³) implies regularity on [0,T]\`.
- Classification: mathematical documentation, not a Lean-formalized proof.

### 4. Earliest recovered Lean target

- Repository: \`ShantiDraconis/millennium-navier-stokes-classical\`
- Commit: [\`5eee6ce82dda31852cd52db61104c42433ec7ae4\`](https://github.com/ShantiDraconis/millennium-navier-stokes-classical/commit/5eee6ce82dda31852cd52db61104c42433ec7ae4)
- Timestamp: \`2025-11-25T11:37:02Z\`
- Historical file: [\`formal/lean/RegularityCriteria.lean\`](https://github.com/ShantiDraconis/millennium-navier-stokes-classical/blob/5eee6ce82dda31852cd52db61104c42433ec7ae4/formal/lean/RegularityCriteria.lean)
- Recovered target: \`u ∈ L^∞([0,T]; L³) implies regularity\`.
- Classification: \`FORMALIZATION_SKELETON / PLACEHOLDER\`; use of \`True\` and \`sorry\` does not certify ESS.

## Links inside the audit repository

- [\`theory/04_critical_L3.md\`](../theory/04_critical_L3.md)
- [\`theory/05_ESS_endpoint.md\`](../theory/05_ESS_endpoint.md)
- [\`formal/lean/CriticalBarrier/CriticalL3.lean\`](../formal/lean/CriticalBarrier/CriticalL3.lean)
- [\`audit/31_exact_origin_ns_error_to_L3_bridge.md\`](31_exact_origin_ns_error_to_L3_bridge.md)
- [\`evidence/files.yaml\`](../evidence/files.yaml)
- [\`graph/nodes.yaml\`](../graph/nodes.yaml)

## Claim discipline

Supported:

1. classical ESS \(L^3\) criterion referenced by \`2025-11-25T04:16:50Z\`;
2. compact \(L^{3,\infty}\) notation present by \`2025-11-25T04:18:20Z\`;
3. unambiguous \(L^\infty_tL^3_x\) implication and blow-up \`limsup\` statement present by \`2025-11-25T06:34:30Z\`;
4. Lean theorem target present by \`2025-11-25T11:37:02Z\`.

Not supported:

- authorship of the classical ESS theorem;
- a completed ESS proof in Mathlib4;
- arbitrary-data global \(L^3\) boundedness;
- a completed Clay solution;
- replacing \`essSup\` or \`limsup\` with an ordinary divergent limit without additional justification;
- the unsupported conversation date \`2026-01-14\`.

## Reproduction queries

\`\`\`bash
git log --all --date=iso-strict --format='%H%x09%aI%x09%cI%x09%s' -- docs/RELATED_WORK.md
git show f1c920dfe7e7d42f4c40417e0c0c0fb8b8c43670:docs/RELATED_WORK.md
git show 80951ea236e5f069279fa34d51db95fe8d5b7937:docs/RELATED_WORK.md
git show d853205ed10e33279327b759adc3135bcd2a262c:docs/07-blowup-criteria.md
git show 5eee6ce82dda31852cd52db61104c42433ec7ae4:formal/lean/RegularityCriteria.lean
\`\`\`

Run each command in its corresponding source repository.
