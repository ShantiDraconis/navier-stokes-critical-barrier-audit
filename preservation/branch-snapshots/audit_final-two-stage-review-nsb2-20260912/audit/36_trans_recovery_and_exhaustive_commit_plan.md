# Trans recovery branch + exhaustive historical audit

Capture date: 2026-09-11

## Preservation destination

A dedicated non-destructive archive branch was created in `ShantiDraconis/Trans`:

`forensic/codespace-recovery-20260911`

It branches from historical Trans `main` commit:

`74cb8d6ab468f31b116bb0cbcbb2776f9d6cac73`

Original commit timestamp: `2025-11-23T04:09:03Z`.
Original message: `Recuperar arquivos locais após reset / recriação do repo`.
Original tree: `1897dcd86923697c64108afff78063655dec028c`.
Parent: `21a7307082fb4b73f291df55198b932b7428f1f0`.
Signature: unsigned.

The recovery branch does not rewrite this history.

## Date-preservation rule

A copied file necessarily receives a new destination commit date. Therefore historical dates are preserved by recording the original immutable source commit/ref/blob and original author/committer timestamp, not by falsifying the new destination commit timestamp. Source Git objects remain the primary evidence.

## First source objects identified

### universal project skeleton

Repository: `ShantiDraconis/universal`
Ref: `5e392d705a4d47c3567a3f7268a051f2886c0d90`
Path: `init_structure.sh`
Blob: `fc5fa44ed5d35c6cbee0ebd89298821d24f435a9`

The script names the intended project `universal-variational-millennium-framework` and enumerates the original directory/file architecture for Lean 4, Coq, Isabelle/HOL, Python, notebooks, LaTeX, tests and CI, covering Navier–Stokes, Yang–Mills, Riemann, P vs NP, Hodge, BSD, fluid/gravity/Hawking and unified variational/spectral material.

### historical results registry

`ShantiDraconis/universal/registry/results.yml` records historical status claims including NS-SETUP `formalized`, NS-ENERGY-INEQ `partial`, NS-LOCAL-EXIST `proved`, RH and BSD definitions, P-vs-NP classes, Hodge statements, YM definitions, etc. These labels are provenance evidence only until exact source and exact proof-assistant build are independently verified.

### empty-file contradiction requiring historical recovery

Current `universal/lean4/Fluid/NavierStokes/LocalExistence.lean` is the canonical empty Git blob:

`e69de29bb2d1d6434b8b29ae775ad8c2e48c5391`

Therefore the registry's historical `proved` label cannot be promoted to `FORMAL_PROOF_CHECKED` from current main. All earlier commits, branches and PR heads must be searched for a non-empty predecessor blob.

### surviving Coq NS specification

`universal/coq/Fluid/NavierStokes.v` is non-empty and explicitly describes itself as a specification/API layer. It contains records for the NS domain, parameters, unknowns, operators, local formulation, Leray–Hopf weak formulation, energy inequality, regularity criteria and Millennium statements. Deep results are represented as `Prop` fields. Classification: `SPECIFICATION`, not a Clay proof.

### surviving Lean symbolic framework

Repository: `ShantiDraconis/millennium-navier-stokes-I`
Commit: `63b248dd29f1817c457acdb00e116e2e9b0687cc`
Path: `src/lean/CI_numbers.lean`
Blob: `4d893952dea2b2590846dfb85dda4e4c543c95b5`

The file defines `CINumber`, symbolic `I`, symbolic singularity `S`, arithmetic, numeric classes and explicit proofs `I_mul_I`, `I_isAnomalous`, `S_isCollapsed`, `critical_iso_complex`. Classification: `SYMBOLIC_NONSTANDARD_FRAMEWORK`; exact compilation remains to be reproduced before `FORMAL_PROOF_CHECKED` status.

## Exhaustive search order

1. `universal`
2. `millennium-navier-stokes-I`
3. `millennium-symbolic-program`
4. `i-constant-core`
5. `millennium-riemann-I`
6. `millennium-p-vs-np-I`
7. `-millennium-bsd-hodge-yangmills-I`
8. `0-0`
9. `zero-engine-00`
10. `Trans`
11. remaining Codespace-linked repositories from `audit/34_codespace_registry_snapshot.md`

For every repository enumerate all reachable branch heads, PR heads, commits, trees, relevant blobs, renames/deletions and formal proof markers. Preserve exact full SHA, parents, tree, timestamps/timezone, signature status, path, blob SHA, byte hash and immutable URL.

## Audit rule

Do not equate historical status strings, README claims, filenames, or Codespace existence with proof validity. Exact proof status is assigned only after source-level dependency/placeholder/vacuity audit and exact toolchain reproduction.
