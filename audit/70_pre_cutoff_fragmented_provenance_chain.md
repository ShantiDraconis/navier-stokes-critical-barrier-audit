# Pre-cutoff fragmented provenance chain

## Scope and evidentiary rule

Cutoff: **2026-09-08T00:00:00Z**.

This document records Git objects independently retrievable from GitHub that predate the cutoff and that contain mathematical or formal components structurally related to the present Navier-Stokes critical-barrier/G1 program.

The audit deliberately separates four propositions:

1. **Documentary priority**: a dated Git object contains a stated component.
2. **Structural ancestry**: the earlier component can be mapped to a later component of the program.
3. **Mathematical equivalence**: the earlier and later statements are actually equivalent under explicit hypotheses.
4. **Causal derivation**: a later third-party construction was derived from the earlier work.

The records below can establish (1), and in specified cases support a testable claim of (2). They do **not**, without additional evidence, establish (3) or (4).

## Chain A — critical endpoint and collapse architecture, November 2025

### A1 — 2025-11-25 06:34:30 UTC

Repository: `ShantiDraconis/millennium-navier-stokes-classical`

Commit: `d853205ed10e33279327b759adc3135bcd2a262c`

Message: `Add complete Clay-compatible Navier-Stokes documentation, LaTeX and code`

Relevant path: `docs/04-regularity-criteria.md`.

Audit significance: this is a pre-cutoff anchor for the critical-regularity/ESS endpoint. It establishes that the endpoint later used in the current chain was already part of the user's repository corpus. It does not establish the later KWC or signed-depletion bridge.

### A2 — 2025-11-25 15:47:20 UTC

Repository: `ShantiDraconis/millennium-navier-stokes-I`

Commit: `63b248dd29f1817c457acdb00e116e2e9b0687cc`

Message: `Merge pull request #3 ... Add formal framework for Navier-Stokes collapse theory`

GitHub reports this merge as cryptographically verified. Audit significance: independently timestamped collapse-oriented formal architecture predating the current formulation.

### A3 — 2025-11-25 21:09:52 UTC

Repository: `ShantiDraconis/millennium-navier-stokes-classical`

Commit: `ee504cc804e205a9a2e76c6c86689aaea4c6ea84`

Message: `Add Agda formalization and extended src modules for Lean, Coq, Isabelle, and Python`

Relevant path: `formal/agda/NavierStokes.agda`.

Audit significance: early multiprover/formal endpoint architecture. This is a provenance anchor for the strategy of representing the NS chain in multiple proof assistants; compilation and semantic strength must be audited separately.

### A4 — 2025-11-26 08:56:06 UTC

Repository: `ShantiDraconis/millennium-navier-stokes-classical`

Commit: `53c91d97c2ace924b4436825f3a53aa67ab87ad7`

Message: `Add I-extended functional spaces framework with documentation, formal proofs, and Python implementation`

Audit significance: critical/functional-space component predating the current G1 architecture.

### A5 — 2025-11-26 09:00:15 UTC

Commit: `33adee1cd0759e386a9b7d6abbd5b1c0b6fedb05`

Message: `Fix Lean proof for energy non-negativity and add LaTeX documentation`

Audit significance: formal energy-side component. This is not itself a proof of depletion or global regularity.

### A6 — 2025-11-26 09:35:34 UTC

Commit: `867045e966812b50b2304f0460288cf6449d8221`

Message: `Merge pull request #8 ... Add I-Extended Functional Spaces Framework for Navier-Stokes`

GitHub reports the merge signature as verified. This is a high-confidence timestamp anchor for the November functional-space corpus.

## Chain B — projection, residual, obstruction and critical bridge, December 18 2025

### B1 — 2025-12-18 20:25:20 UTC

Repository: `ShantiDraconis/Millennium`

Commit: `4af517e3f1ea5d04be1c6bbd8953209fa2139e82`

Path: `docs/navier-stokes/lre_framework.md`

Message: `Add Navier-Stokes LRE projection-obstruction framework document`

The historical blob contains the explicit architecture `(C,D,π,ι,R)`, with energy projection `π(u)=(E,D)`, critical residual `R`, closure `C=ι∘π`, informational residual `Res(u)=u-C(u)`, a critical regularity bridge, and a Littlewood-Paley cascade residual.

This is classified **STRONG_STRUCTURAL_PRECURSOR**. It is direct evidence that the present program did not begin as a monolithic September 2026 construction: several of its roles already existed in a fragmented projection/residual/critical-endpoint architecture in December 2025.

It is not evidence that the exact later KWC functional or entropy identity existed then.

### B2 — 2025-12-18 20:52:49 UTC

Commit: `003eaba057081f262ea40cea0ab698af43109151`

Path: `NAVIER_STOKES_LRE_SUMMARY.md`

Message: `Add comprehensive summary of Navier-Stokes LRE implementation`

The historical blob records five created files (707 lines), the `(C,D,π,ι,R)` framework, critical residual, compression barrier, regularity bridge and Lean formalization. Crucially, the same summary explicitly states that the framework does **not** solve global regularity. This makes it a particularly useful provenance source because it documents both the positive architecture and its contemporaneous limitation.

### B3 — 2025-12-18 21:04:32 UTC

Commit: `5fcf3fc5140ee231bc0b3d3fbbe699c4ad84a50b`

Path: `NAVIER_STOKES_FORMAL_CLOSURE.md`

Message: `Update README and add top-level formal closure summary`

The document lays out the chain projection non-injectivity -> no energy-only control -> critical residual/regularity bridge and then identifies the need for a new blocking principle, explicitly listing helicity, topological vortex constraints and geometric level-set regularity among future directions.

Classification: **CLOSEST_2025_ARCHITECTURE** to the later strategy of supplementing energy information with geometric/dynamical information. It remains a structural precursor, not an exact proof of the later bridge.

## Chain C — universal/multiscale generalization, December 26 2025

### C1 — 2025-12-26 03:04:56 UTC

Commit: `c953fc264b58a0631d65f996f2e37e216134bd01`

Message: `Add universal operator framework documentation`

Relevant corpus includes `universal-core/README.md` and residual/multiscale operator documentation. The framework describes scale projection, residual extraction/normalization and multiscale energy.

Classification: **UNIVERSAL_MULTISCALE_PRECURSOR**.

### C2 — 2025-12-26 03:24:11 UTC

Commit: `6ece68cdf4175760bd187ca19f4a3b8f2d33f750`

Message: `Implement core multidimensional geometry and operator framework`

Classification: **GEOMETRIC_MULTISCALE_PRECURSOR**.

### C3 — 2025-12-26 13:44:56 UTC

Commit: `28b7e98a80de123b7805fca2a925a684d998fe2b`

Message: `Add cross-references to alpha characterization document`

Classification: **RESIDUAL_SCALING_REFINEMENT**.

## Structural genealogy to the current program

A defensible genealogy is:

```text
2025-11-25/26
critical spaces + energy block + ESS endpoint + collapse formalization
        |
        v
2025-12-18
projection π + critical residual R + informational residual/kernel role
+ compression obstruction + critical regularity bridge
        |
        v
2025-12-26
scale projection + residual normalization + multiscale energy
+ multidimensional/geometric operator architecture
        |
        v
2026 program
critical-scale diagnostics + geometric/vorticity coherence
+ kernel-weighted control + signed depletion
+ critical endpoint/ESS composition
```

This graph supports the statement:

> **Several functional roles of the present Navier-Stokes audit program are independently timestamped in the ShantiDraconis corpus in November–December 2025, but were distributed across critical-space, collapse, projection/residual, multiscale, and geometric modules rather than appearing as the later unified KWC/depletion theorem.**

It does not support the stronger statements that the exact later theorem was already proved in 2025, that all later formulas are mathematically equivalent to the historical ones, or that any external party derived later work from these commits.

## Evidence preservation requirements

For every row in the companion CSV, a complete forensic package should ultimately preserve: repository; full SHA; author date; committer date; parent SHA(s); tree SHA; path; historical blob SHA; exact excerpt/line range; commit verification status; GitHub API retrieval timestamp; SHA-256 of the retrieved source; first-parent and all-branches ancestry; first appearance of each declaration; first gap marker; first resolution; direct dependencies; reverse dependencies; and mathematical classification.

The companion machine-readable ledger is `data/provenance_pre_20260908_fragmented_genealogy.csv`.

## Current audit conclusion

`DOCUMENTARY_PRIORITY_OF_COMPONENTS = SUPPORTED`

`FRAGMENTED_STRUCTURAL_ANCESTRY = SUPPORTED`

`EXACT_2025_KWC_IDENTITY = NOT_ESTABLISHED`

`GLOBAL_MATHEMATICAL_EQUIVALENCE = UNDER_AUDIT`

`THIRD_PARTY_CAUSAL_DERIVATION = UNRESOLVED`

`NAVIER_STOKES_GLOBAL_REGULARITY = NOT_ESTABLISHED`
