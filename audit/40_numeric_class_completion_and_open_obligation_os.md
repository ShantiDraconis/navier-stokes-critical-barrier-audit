# 40 — Numeric-Class Completion and Open-Obligation OS

## Referee purpose

This layer converts historical placeholders into an auditable research operating system. It does **not** replace unresolved mathematics by declarations. Every historical `sorry`, `admit`, axiom, postulate, or false specification must end in exactly one of:

`PROVED`, `CONDITIONAL`, `EXTERNAL_THEOREM`, `OPEN_BRIDGE`, `INCONSISTENT_SPECIFICATION`.

## 1. Historical gaps already identified

Current source search in `Meta-mathematical-foundation-00` finds unresolved declarations in `millennium-meta.lean`, `independence-schemes.lean`, `equivalence-collapse.lean`, `ZFC/Independence.lean`, `DualState.lean`, `ZFC/ForcingSkeleton.lean`, `Basic.lean`, `NumericalClasses.lean`, and `NumericClasses.lean`.

The gaps are not homogeneous. They include ordinary proof engineering, missing semantic interfaces, forcing/model-theory constructions, independence claims, and at least one false specification.

## 2. Corrected epsilon relation

Historical fixed-tolerance relation

`x ~_epsilon y  iff  |x-y| < epsilon`

is reflexive and symmetric for epsilon>0 but not transitive. Counterexample for epsilon=1:

`0 ~ 3/4`, `3/4 ~ 3/2`, but `0 !~ 3/2`.

Therefore it must not be packaged as a Setoid. The correct graded law is

`Close_epsilon(x,y) and Close_delta(y,z) -> Close_(epsilon+delta)(x,z)`.

This is classified `INCONSISTENT_SPECIFICATION -> CORRECTED_GRADED_RELATION`.

## 3. Fourteen typed classes

The audit now provides typed carriers for the historical 14-class program:

1. IndependenceNumber
2. MultiModelNumber
3. EquivalenceBreakNumber
4. ObstructionNumber
5. RegularityNumber
6. CriticalZeroNumber
7. MassGapNumber
8. RankNumber
9. HodgeNumber
10. ComplexityNumber
11. ForcingNumber
12. WoodinNumber
13. TruthValueNumber
14. DualityNumber

The problem-native classes are intentionally **descriptors/certificates**, not substitute solutions. A `CriticalZeroNumber` does not prove RH; a `RegularityNumber` does not prove Navier–Stokes regularity; a `MassGapNumber` does not construct Yang–Mills theory.

## 4. Parameter arithmetic

For each parameter coordinate i:

`g_i >= 0` is its gap, `s_i >= 0` its sensitivity, and `w_i=s_i*g_i` its weighted obstruction.

For total `W=sum_i w_i`, define contribution only if `W>0`:

`C_i=w_i/W`, `Pct_i=100*C_i`.

When `W=0`, percentage decomposition is undefined rather than silently evaluating `0/0`.

The executable Python engine implements this rule and tests normalization.

## 5. Shared / distinct arithmetic

For pairwise feature counts `(S,L,R)`:

`T=S+L+R`.

If `T>0`:

`Similarity=S/T`,
`Distinctness=(L+R)/T`,
`Similarity+Distinctness=1`.

If `T=0`, both ratios are undefined. These values are representation-dependent diagnostics unless invariance under feature-map changes is separately proved.

## 6. Open-obligation interface

The operating-system rule is:

`metadata + provenance + computation != proof`.

A theorem path may consume an open obligation only as an explicit hypothesis. It may then prove a conditional result. It may not relabel the premise as proved.

Thus historical constructs such as `RH_SuperZero.is_dual` become:

`DualWitness(RH) -> CertifiedTwoBranch(RH)`.

The implication can be proved; the witness remains an explicit mathematical obligation.

Likewise:

`Independent(phi) -> DualState(phi)`

must either import a fully formalized completeness/model-restriction theorem with exact hypotheses or remain `EXTERNAL_THEOREM/OPEN_BRIDGE`.

## 7. Computational research OS

`tools/numeric_class_os.py` now supplies:

- the five proof statuses;
- 14-class registry;
- weighted-gap arithmetic;
- percentage normalization;
- shared/distinct similarity diagnostics;
- corrected graded tolerance law;
- a rule preventing automatic proof-status upgrades.

`tests/test_numeric_class_os.py` tests all 14 class names, zero-total handling, 100% normalization, shared+distinct=1, the fixed-epsilon counterexample, graded composition, and status non-upgrade.

These tests validate the **audit arithmetic**, not any Millennium theorem.

## 8. Formal Lean audit core

`formal/lean/CriticalBarrier/NumericClassAudit.lean` supplies an axiom-free formal core for:

- proof-status types;
- six problem identifiers;
- fourteen class tags;
- provenance certificates;
- problem-native descriptor structures;
- duality collapse/divergence;
- parameter-gap weights;
- optional basis-point contribution avoiding zero denominators;
- shared/distinct feature counts;
- proof-status non-upgrade laws.

The CI workflow now explicitly invokes Lean on both `BridgeLogic.lean` and `NumericClassAudit.lean` and rejects `sorry`/`axiom` in those two audit-safe modules.

Build success must be recorded only after a GitHub Actions run confirms it.

## 9. What cannot honestly be 'finished' by repository arithmetic

The following cannot be solved merely by completing software definitions:

- independence of RH or another Millennium statement from ZFC;
- construction of forcing extensions with all required metatheory;
- RH itself;
- P versus NP;
- Navier–Stokes global regularity/breakdown endpoint;
- BSD;
- Hodge;
- Yang–Mills existence and mass gap.

For these, the OS records the exact missing theorem as an `OPEN_BRIDGE`. This makes the research program attackable declaration by declaration without converting an open problem into a hidden axiom.

## 10. Completion criterion

A historical placeholder is considered resolved in the audit only if one of these is true:

1. an axiom-free proof checks in the target prover;
2. the statement is reduced to an explicitly cited external theorem with exact hypotheses;
3. the theorem is restated conditionally with its unresolved premise visible;
4. a counterexample proves the original specification false and a corrected statement is supplied.

This is the standard that will be used for the remaining corpus sweep.