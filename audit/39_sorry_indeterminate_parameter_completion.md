# 39 — `sorry` and Indeterminate-Parameter Completion Audit

## Purpose

This document converts unresolved formal placeholders into explicit, typed proof obligations. It does **not** replace an unknown theorem with an axiom and does **not** label an open mathematical statement as proved.

Companion Lean module:

```text
formal/lean/IndeterminateParameterCompletion.lean
```

## Recovered unresolved sites

A search of `ShantiDraconis/Meta-mathematical-foundation-00` found unresolved sites including:

```text
lean/millennium-meta.lean
lean/independence-schemes.lean
lean/equivalence-collapse.lean
src/lean/MetaMillennium/ZFC/Independence.lean
DualState.lean
src/lean/MetaMillennium/ZFC/ForcingSkeleton.lean
lean/MetaMillennium/Basic.lean
src/lean/NumericalClasses.lean
lean/MetaMillennium/NumericClasses.lean
```

The sites fall into distinct classes.

### S1 — proof-engineering gap

A theorem is mathematically valid from existing assumptions, but the Lean term is unfinished.

Action: prove it directly.

### S2 — missing library theorem / semantic infrastructure

Example: deriving semantic dual witnesses from syntactic independence via completeness.

Action: make the exact completeness/soundness/model-restriction theorem an explicit dependency. Do not use `sorry` and do not silently add an axiom.

### S3 — open mathematical assertion

Example: a claimed `DualState` for RH requiring actual independence of RH.

Action: parameterize by the missing witness. The formal construction becomes conditional:

```text
hDual : DualWitness RH
----------------------
CertifiedTwoBranch RH
```

This eliminates the placeholder without claiming RH independence.

### S4 — incomplete construction

Example: forcing `generic_extension` defined by `sorry`.

Action: expose a construction interface carrying the required preservation/model properties, or import a verified forcing development. A fake arbitrary model is not a valid replacement.

### S5 — inconsistent advertised specification

The historical `epsilonEquiv` used

```text
x ~ y  iff  |x-y| < epsilon
```

and attempted to make this a `WeakEquivalence` with transitivity.

For fixed positive epsilon this relation is **not transitive**. Example with epsilon=1:

```text
x=0, y=3/4, z=3/2
|x-y|=3/4<1
|y-z|=3/4<1
|x-z|=3/2>1.
```

Therefore this `sorry` cannot be honestly filled while retaining the same theorem statement.

The audit-safe replacement is a graded relation:

```text
Close_epsilon(x,y) := |x-y| < epsilon
```

with

```text
Close_epsilon(x,y) and Close_delta(y,z)
=> Close_(epsilon+delta)(x,z).
```

The companion Lean file formalizes this correction and a counterexample to fixed-epsilon transitivity.

## Indeterminate parameter completion

For every parameter `theta_i`, store separately:

```text
current(theta_i)
target(theta_i)
gap(theta_i)=|current-target|
sensitivity(theta_i)=|dE/dtheta_i|
weight(theta_i)=sensitivity*gap
status(theta_i)
```

where status is one of

```text
PROVED
CONDITIONAL
EXTERNAL_THEOREM
OPEN_BRIDGE
INCONSISTENT_SPECIFICATION
```

If

```text
W = sum_i weight(theta_i) > 0,
```

then define

```text
contribution_i = weight_i/W
percentage_i = 100*weight_i/W.
```

The positivity requirement on `W` removes the hidden `0/0` branch from the percentage calculation.

If `W=0`, the decomposition is not assigned arbitrary percentages. It receives a separate degenerate status.

## Cross-problem comparison completion

For a pair `(P_i,P_j)`, distinguish:

```text
shared
leftOnly
rightOnly
```

and define, after fixing a feature representation/measure,

```text
similarity = shared/(shared+leftOnly+rightOnly)
distinctness = (leftOnly+rightOnly)/(shared+leftOnly+rightOnly).
```

The denominator must be nonzero.

These values are representation-dependent diagnostics unless invariance under admissible reparameterizations is proved.

## Numeric-class completion rule

A historical numeric class is accepted as formally completed only when its advertised laws are actually proved.

For quotient classes:

```text
carrier
relation
reflexivity
symmetry
transitivity
well-defined operations
closure
advertised algebraic laws
```

must all be checked.

For problem-native classes such as

```text
RegularityNumber
CriticalZeroNumber
MassGapNumber
RankNumber
HodgeNumber
ComplexityNumber
```

the type definition itself does not prove the corresponding Millennium conjecture.

## `RH_SuperZero` repair

Historical code contains:

```text
is_dual := sorry
```

with the source comment that actual independence would be required.

The repaired form is not

```text
is_dual := axiom
```

but schematically

```text
def RH_SuperZero (hRH : DualWitness RH) := {
  whenTrue := ...
  whenFalse := ...
  conjecture := RH
  witnesses := hRH
}
```

Thus all computational/type-level content can be developed while the genuine mathematical obligation remains visible.

## Independence/completeness repair

Historical files contain statements of the form

```text
Independent T phi -> DualState T phi
```

with comments referring to completeness.

The audit-safe theorem shape is

```text
(bridge : forall phi, Independent phi -> DualWitness phi)
-> Independent phi
-> DualWitness phi.
```

The `bridge` must later be instantiated by an actual verified soundness/completeness theorem for the exact syntax, semantics, theory extension, and model notion used in the repository.

## Forcing repair

A generic extension cannot be supplied merely to eliminate `sorry`.

The missing object must include at least the intended semantic invariants, e.g. a verified relation between base model `M`, forcing notion `P`, generic filter `G`, and extension `M[G]`.

Until such a construction is imported/proved:

```text
FORCING_GENERIC_EXTENSION = OPEN_BRIDGE
```

## Formal status after this audit

The new module removes ambiguity at the specification level:

- percentage denominators are explicit;
- indeterminate parameters are typed;
- open bridges cannot be upgraded by metadata;
- dual-state constructions require explicit witnesses;
- epsilon closeness is corrected from a false equivalence claim to a graded triangle relation;
- `sorry` sites that encode genuinely open mathematics remain obligations rather than fabricated proofs.

This is a stronger formalization than mechanically replacing every `sorry`: it distinguishes **provable gaps**, **missing infrastructure**, **open mathematics**, and **false specifications**.

## Build caveat

The companion Lean source has been committed as a candidate formalization. No successful `lake build` / kernel-check result is claimed by this audit until CI or a local Lean environment verifies the exact Mathlib imports and theorem names.
