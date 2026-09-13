# 14 — External Architecture Crosswalk (OpenAI vs Fagliari)

## Scope

This module compares **architecture-level objects** between:
- external OpenAI Navier–Stokes formalization tree, and
- pre-2026-09-08 Fagliari program artifacts.

It is not an identity proof and not a causal-derivation claim.

## Current finding

- Structural overlap: **STRONG** (programmatic level).
- Distinctive-construction equivalence: **NOT ESTABLISHED**.

## OpenAI module families (observed in NavierStokes tree snapshot)

Observed families include substantial modules around:
- jets,
- pressure,
- residual bounds,
- correction steps,
- transport primitives,
- data pipelines.

Examples from observed file names:
- `ReferenceJetBounds.lean`
- `R3PressureKernel.lean`, `R3StressPressureEstimate.lean`
- `ResidualCalculus.lean`, `ResidualStability.lean`
- `CorrectionStep.lean`
- `TransportPrimitive.lean`

## Crosswalk targets

1. `Field/Jet decomposition` ↔ `Profile decomposition`
2. `Correction family` ↔ `Profiles/remainders/stability ledger`
3. `Pressure + pressure bounds` ↔ `Pressure/coercivity estimates`
4. `Residual bounds` ↔ `Error/remainder/compactness controls`

## Interpretation rule

Crosswalk entries are classified as:
- `EXACT_DISTINCTIVE`
- `STRUCTURAL`
- `CLASSICAL_GENERIC`
- `LEXICAL_FALSE_POSITIVE`
- `NO_MATCH`

Only definition-level and formula-level comparisons can move a row from structural to exact.
