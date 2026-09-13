# Recovered formalization inventory from the early Codespace lineage

Date: 2026-09-11
Audit class: source recovery + proof-status correction

## Executive finding

The early Codespace lineage contains two very different kinds of evidence and they must not be conflated:

1. **A large intended formal architecture** — preserved by `ShantiDraconis/universal/init_structure.sh`, registry files, build files, CI definitions, documentation, and many path names.
2. **Actual non-empty formal source** — surviving Lean/Coq/Isabelle files whose bytes can be inspected.

A path appearing in `init_structure.sh` or `registry/results.yml` is evidence that the formalization was planned/registered. It is not evidence that a proof existed. In particular, the current `universal/lean4/Fluid/NavierStokes/LocalExistence.lean` is the canonical empty Git blob `e69de29bb2d1d6434b8b29ae775ad8c2e48c5391`, despite `registry/results.yml` describing `NS-LOCAL-EXIST` as `status: proved`. The audit therefore downgrades that claim to `REGISTRY_CLAIM_CONTRADICTED_BY_CURRENT_SOURCE` until an earlier non-empty blob is recovered from history/branch/PR/local Git objects.

## Original intended formal tree preserved by `universal/init_structure.sh`

### Lean 4

- `lean4/Core/Topology/Base.lean`
- `lean4/Core/Analysis/Base.lean`
- `lean4/Core/Geometry/Base.lean`
- `lean4/Core/Spectral/Base.lean`
- `lean4/Fluid/Continuity/Definitions.lean`
- `lean4/Fluid/Continuity/ConservationLaw.lean`
- `lean4/Fluid/Continuity/WeakSolutions.lean`
- `lean4/Fluid/NavierStokes/Setup.lean`
- `lean4/Fluid/NavierStokes/EnergyInequalities.lean`
- `lean4/Fluid/NavierStokes/LocalExistence.lean`
- `lean4/Fluid/NavierStokes/RegularityCriteria.lean`
- `lean4/Fluid/NavierStokes/BlowupScenarios.lean`
- `lean4/Fluid/RelativisticFluid/{StressEnergy,CovariantConservation,NewtonianLimit}.lean`
- gravity, horizon/Hawking, Yang-Mills, Zeta/RH, Complexity/P-vs-NP, Hodge, BSD, and Unified modules.

### Coq

- `coq/Core/{Topology_Base,Analysis_Base,Geometry_Base}.v`
- `coq/Fluid/{Continuity,NavierStokes,RelativisticFluid}.v`
- `coq/Gravity/{Einstein,Horizon}.v`
- `coq/YangMills/{YM_Action,YM_MassGap}.v`
- `coq/Zeta/{Zeta_Core,RH_Formal}.v`
- `coq/Complexity/{Circuits,P_vs_NP_Framework}.v`
- `coq/Hodge/{Hodge_Laplacian,Hodge_Conjecture}.v`
- `coq/BSD/{EllipticCurves_BSD,LFunction_BSD}.v`

### Isabelle/HOL

- `isabelle/Fluid/{Continuity,Navier_Stokes}.thy`
- `isabelle/Gravity/{Einstein_Equations,Horizon_Theory}.thy`
- `isabelle/Zeta/{Zeta_Function,Riemann_Hypothesis}.thy`
- `isabelle/Hodge/{Kahler_Manifolds,Hodge_Conjecture}.thy`
- `isabelle/BSD/{Elliptic_Curves,BSD_Conjecture}.thy`
- `isabelle/Complexity/{Circuits,Complexity_Classes}.thy`

## Surviving formal source already inspected

### A. `universal/coq/Fluid/NavierStokes.v`

This is non-empty and substantial. It explicitly identifies itself as an incompressible Navier-Stokes **SPECIFICATION LAYER (CLAY STYLE)**. It formalizes records/interfaces for:

- domain and dimension;
- viscosity, force, initial data and boundary conditions;
- velocity and pressure unknowns;
- gradient, divergence, Laplacian and convective operators;
- time derivative;
- local/strong formulation;
- weak Leray-Hopf formulation;
- energy inequality;
- weak time continuity and initial trace;
- regularity criteria and global/blow-up specification.

Its own header states that deep theorems are represented as `Prop` fields and must be proved elsewhere. Audit status: `SPECIFICATION`, not `FORMAL_PROOF_CHECKED`.

This distinction is essential: a record field such as `NS_local_equation : Prop` or `NS_energy_inequality : Prop` is an obligation/assumption carried by an instance, not a proof of the equation or inequality.

### B. `millennium-navier-stokes-I/src/lean/CI_numbers.lean`

At commit `63b248dd29f1817c457acdb00e116e2e9b0687cc`, blob `4d893952dea2b2590846dfb85dda4e4c543c95b5`, this file contains executable Lean definitions and several elementary proofs in the non-standard symbolic `CINumber` framework:

- structure `CINumber` with complex components `z`, `a`, `s`;
- constants `I=(0,1,0)` and `S=(0,0,1)`;
- custom addition, negation and multiplication;
- theorem `I_mul_I : I * I = S`;
- classification into `critical`, `anomalous`, `collapsed`;
- predicates `isCritical`, `isAnomalous`, `isCollapsed`;
- noncomputable weighted norm `normI`;
- theorem `I_isAnomalous`;
- theorem `S_isCollapsed`;
- theorem `critical_iso_complex`.

Audit status: `FORMAL_SOURCE_PRESENT`; the displayed theorem bodies are elementary consequences of the file's definitions. They do **not** establish the classical Navier-Stokes Millennium theorem. This source belongs to a symbolic/non-standard collapse framework and must be kept separate from classical PDE formalization.

## Registry claims requiring source-level verification

`universal/registry/results.yml` records historical statuses including:

- RH zeta definition — `formalized`;
- RH xi definition — `formalized`;
- RH functional equation — `statement-only`;
- RH critical-line formulation — `statement-only`;
- NS setup — `formalized`;
- NS energy inequality — `partial`;
- NS local existence — `proved`;
- YM gauge definition/action — `formalized`;
- YM mass gap — `statement-only`;
- BSD elliptic curve/L-function — `formalized`;
- BSD conjecture — `statement-only`;
- P/NP classes — `formalized`;
- SAT completeness — `statement-only`;
- Hodge decomposition/conjecture — `statement-only`;
- membrane paradigm — `partial`;
- Hawking temperature derivation — `proved`.

These are historical registry assertions only. Every `proved`/`formalized` item must be checked against the exact blob and exact compiler/toolchain. The NS local-existence example demonstrates why the registry cannot be accepted as proof evidence by itself.

## Additional non-empty formal sources discovered in `universal`

Default-branch code search currently exposes, among others:

- `lean4/Core/Analysis/Calculus/MeanValueTheorem.lean`
- `lean4/Core/Analysis/Calculus/Jacobians.lean`
- `lean4/Core/Analysis/Calculus/Derivatives.lean`
- `lean4/Core/Analysis/Topology/Continuity.lean`
- `lean4/Core/Analysis/Topology/Compactness.lean`
- `lean4/BSD/MordellWeil.lean`
- `coq/Hodge/Hodge_Laplacian.v`
- `coq/Zeta/RH_Formal.v`
- `coq/Fluid/Continuity.v`
- `coq/Complexity/P_vs_NP_Framework.v`.

These paths are now priority targets for exact blob capture and theorem-by-theorem classification.

## What is essential to bring into the central audit

The audit should preserve **evidence**, not rewrite the historical repositories. For each recovered formal source it should store:

- source repository;
- branch/ref;
- immutable commit SHA;
- source path;
- Git blob SHA;
- raw SHA-256;
- byte length;
- language/toolchain;
- theorem/definition names;
- proof markers (`sorry`, `axiom`, `Admitted`, etc.);
- whether statements are definitions, specifications, hypotheses, conjectures, proof sketches, or checked proofs;
- dependency imports;
- compile/test evidence;
- relationship to the later residual/error/critical-L3 lineage.

## Current recovery priority

1. `universal` — complete history and all non-empty Lean/Coq/Isabelle blobs.
2. `millennium-navier-stokes-I` — all Lean/Python/LaTeX and earliest collapse/regularity commits.
3. `millennium-symbolic-program` and `i-constant-core` — origin of symbolic `I=0/0` structures.
4. `-millennium-bsd-hodge-yangmills-I`, `millennium-p-vs-np-I`, `millennium-riemann-I` — cross-problem formalization lineage.
5. `Trans`, `0-0`, `zero-engine-00`, `-sbfe-physics-unified` — possible earlier common infrastructure.
6. unmerged PR heads and historical branches.
7. local-only Codespace/Git objects if independent copies still exist.

## Non-negotiable audit rule

No recovered file is to be relabeled as a solution to an open Millennium problem merely because it is syntactically formal, appears in a registry as `proved`, or contains a theorem declaration. Classical theorem status requires source inspection, dependency inspection, absence/understanding of assumptions and placeholders, and exact build/kernel verification.
