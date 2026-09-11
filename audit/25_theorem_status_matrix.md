# 25 — Theorem / Model Status Matrix

## Status vocabulary

- `FORMAL_PROOF_CHECKED` — proof assistant kernel/toolchain actually checked exact source.
- `MATHEMATICAL_PROOF` — ordinary mathematical derivation is complete at the stated level.
- `DERIVED_FROM_CLASSICAL` — follows from a cited classical theorem under its hypotheses.
- `FORMAL_PROOF_REQUIRES_AUDIT` — formal source exists but exact historical compilation has not been independently reproduced.
- `COMPUTATIONAL_EVIDENCE` — finite computation/test.
- `SPECIFICATION` — definition or model declaration.
- `HYPOTHESIS` — assumed proposition/condition.
- `PROOF_SKETCH` — incomplete proof outline.
- `PLACEHOLDER` — `sorry`, `Admitted`, `admit`, `oops`, vacuous placeholder, etc.
- `OPEN_BRIDGE` — decisive implication not yet proved.
- `UNKNOWN` — insufficient evidence.

| Object | Statement / role | Status | Reason |
|---|---|---|---|
| Weighted error model | `E=Σ w_i g_i(Δ_i)` | `SPECIFICATION` | declared scalarization |
| Percentage normalization | `Σ C_i = 100%` when `E>0` | `MATHEMATICAL_PROOF` | elementary algebra; proof recorded |
| Sensitivity model | `C_i ∝ |∂E/∂θ_i|Δ_i` | `SPECIFICATION` | declared local-sensitivity scalarization |
| Sensitivity normalization | normalized contributions sum to 100% | `MATHEMATICAL_PROOF` | elementary algebra |
| Error coordinate | `ε(P)∈R_+^n` | `SPECIFICATION` | declared state representation |
| Zero norm equivalence | `||ε||₂=0 ↔ ε_i=0 ∀i` | `MATHEMATICAL_PROOF` | positive definiteness of Euclidean norm |
| Progress monotonicity | norm contraction implies nondecreasing declared progress | `MATHEMATICAL_PROOF` | algebraic monotonicity |
| Proof = error trajectory | `ε₀→…→0` interpreted as proof | `SPECIFICATION / INTERPRETATION` | requires bridge to classical theorem |
| Pure periodic phase cancellation | whole-period average of `Ae^{iωt}`, `ω≠0`, is zero | `MATHEMATICAL_PROOF` | direct integration |
| General phase nullification | arbitrary imaginary error averages to zero | `OPEN_BRIDGE` | periodic-mode proof insufficient |
| NS error ratio | `||(u·∇)u||₂ /(ν||Δu||₂)` | `SPECIFICATION_REQUIRES_DOMAIN_AUDIT` | denominator/domain/solution-class conditions must be explicit |
| `0.65±0.05` NS threshold | universal critical threshold | `OPEN_BRIDGE` | model/source association is not universal PDE proof |
| ESS endpoint theorem | bounded critical L3 excludes blow-up under classical hypotheses | `DERIVED_FROM_CLASSICAL` dependency | external classical theorem; audit must map exact hypotheses |
| Error-zero ⇒ bounded critical L3 | decisive bridge | `OPEN_BRIDGE` | not established |
| Error-zero ⇒ Clay global regularity | decisive bridge | `OPEN_BRIDGE` | not established |
| Phase cancellation ⇒ bounded critical L3 | decisive bridge | `OPEN_BRIDGE` | not established |
| Finite computation ⇒ all-data theorem | universal extrapolation | `INVALID_WITHOUT_BRIDGE` | finite sampling cannot discharge universal quantifier |
| Nov 2025 Lean/Coq/Isabelle NS files | historical formalization | `FORMAL_PROOF_REQUIRES_AUDIT` | exact historical compile still needed |
| UEL/Millennium formal layers containing assumptions | theorem-like declarations | `FORMAL_PROOF_DEPENDS_ON_ASSUMPTIONS` or `SPECIFICATION` | must inspect individual declarations |
| Files containing `sorry` / `Admitted` | unfinished formal result | `PLACEHOLDER` | kernel acceptance with placeholder is not completed theorem proof |
| CI invariant tests | audit internal identities | `COMPUTATIONAL_EVIDENCE` supporting already proved identities | CI is not PDE theorem verification |

## Critical rule for reviewers

A field of type `Prop`, an axiom, a hypothesis, or a constructor argument requiring a proposition is **not** itself a proof of the proposition. A formal theorem is promoted to `FORMAL_PROOF_CHECKED` only after the exact declaration is proved without unresolved placeholders and the exact historical source compiles under a recorded toolchain.

## Current classical Navier–Stokes verdict

```text
Repository-specific frameworks: documented.
Internal audit lemmas: several proved.
Critical-L3 classical dependency: recognized.
Decisive bridge from repository error/phase model to classical theorem: OPEN.
Clay Millennium solution: NOT ESTABLISHED by this audit.
```
