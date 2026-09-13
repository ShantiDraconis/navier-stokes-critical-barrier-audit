# 16 — Related Commit Derivation Ledger

## Purpose

This ledger records commits in repositories under `ShantiDraconis` that are identical, structurally similar, or plausible precursors/derivatives of the mathematical chain audited here:

1. spectral/projective decomposition `u = u_N + u_⊥`;
2. closure defect `P_N[(u·∇)u] − (P_Nu·∇)(P_Nu)`;
3. residual coupling `T(u_N,u_⊥)` / `K(R,π(u))`;
4. residual → projected-dynamics correction;
5. additive/correction architecture;
6. curvature / blow-up reformulations;
7. residual-stability / obstruction inequalities.

This is an **evidence ledger, not a claim of identity or of a Clay Millennium solution**. Similarity classes below distinguish direct mathematical overlap from contextual or programmatic relation.

## Search method

GitHub commit history accessible to the connected account was searched by commit-message terms including:

- `residual`
- `closure`
- `projection`
- `coupling`
- `perturbation`
- `blow-up`
- `Reynolds`
- `high-frequency`

Key commits were then inspected directly when possible. Commit-message search is not equivalent to a complete semantic scan of every blob in every historical tree, so this file should be treated as a reproducible high-confidence ledger, not an exhaustive proof that no additional related commit exists.

## Similarity scale

- **DIRECT** — commit explicitly contains the audited NS mathematical object or theorem family.
- **VERY_STRONG_STRUCTURAL** — same operator/decomposition/obstruction architecture, possibly in different notation.
- **STRONG_STRUCTURAL** — same mathematical mechanism but not exact object identity.
- **PROGRAMMATIC_PRECURSOR** — establishes the research/formalization program without the later exact formula.
- **CONTEXT_ONLY** — related to NS or proof infrastructure but not evidence of the specific chain.

---

## A. Earliest contextual / programmatic precursors found

### 2025-11-29 — `ShantiDraconis/millennium-hypothesi`

#### `200a83d3db44a892a588c94f7c94136469e01829`
Commit records a classical Navier–Stokes nucleus, weak/strong formulation, energy inequality, blow-up criteria, and an architecture for formal Lean/Coq modules.

**Classification:** PROGRAMMATIC_PRECURSOR

Reason: establishes the NS formalization program and classical target, but does not by itself contain the later residual-coupling/closure operator chain.

#### `fa3c2090353f11f1e1535f954627f157837d39ca`
Commit describes the Millennium hub with classical/symbolic layers, formal proof infrastructure, and explicit `symbolic perturbation analysis`.

**Classification:** PROGRAMMATIC_PRECURSOR

Reason: early formal-research architecture; not sufficient for exact mathematical equivalence.

---

## B. Projection / closure lineage

### 2025-12-16 — `ShantiDraconis/Millennium`

#### `09bd7c8b236a30850506e38e94edee9d195955bd`
`Clarify projection case and liminf scaffolding`

**Classification:** STRONG_STRUCTURAL

Reason: explicit projection machinery predating the 18–20 Dec concentration of LRE-NS commits.

### 2025-12-18 — `ShantiDraconis/Universe-0-0`

#### `f900684c3785ffbd9707291225b2c1751ae3e3eb`
`Create LRE Projection Framework article with Navier-Stokes Clay dossier`

**Classification:** VERY_STRONG_STRUCTURAL

Reason: projection framework explicitly tied to Navier–Stokes.

### 2025-12-18 — `ShantiDraconis/Millennium`

#### `4af517e3f1ea5d04be1c6bbd8953209fa2139e82`
`Add Navier-Stokes LRE projection-obstruction framework document`

**Classification:** DIRECT

Reason: explicit NS projection-obstruction formulation.

#### `b9b4768206ee3d817cbbaf35bb7da92dc835c4e1`
`Add complete Navier-Stokes formal closure documentation`

**Classification:** DIRECT

#### `a992d144c235572ac2b7413b015e58535a864a41`
`Implement LRE-NS formal closure framework with all theorems`

**Classification:** DIRECT

#### `5fcf3fc5140ee231bc0b3d3fbbe699c4ad84a50b`
`Update README and add top-level formal closure summary`

**Classification:** STRONG_STRUCTURAL

#### `886d169e179ed9be76cb21c05fea9e856a970364`
`Add validation report and complete formal closure implementation`

**Classification:** DIRECT / VALIDATION_LAYER

#### `0d601255e51be349a1fd38eacfcbd2fda17ced77`
`Complete formal closure framework for Navier-Stokes LRE-NS`

**Classification:** DIRECT

#### `c69cea5a2bf8a2e71219a308b7b341b61c4615d5`
`Add README and numerical demonstration for NS formal closure`

**Classification:** STRONG_STRUCTURAL

#### `d1c29035c449cc213ac822afaeb3c213b04da39f`
`Add completion summary for Navier-Stokes formal closure`

**Classification:** STRONG_STRUCTURAL

---

## C. Residual / closure-defect lineage

### 2025-12-19 — `ShantiDraconis/Millennium`

#### `ce295769703fb8fc5d73e6427c2b9a3bf8ac3ce4`
`Add Navier-Stokes Compression Barrier framework (LRE-NS)`

**Classification:** VERY_STRONG_STRUCTURAL

#### `0f17dc7b673ea8208796763099f576ea59420b7e`
`Add LRE-NS framework proving energy projection cannot control critical residual`

**Classification:** DIRECT

Reason: explicitly connects projection failure to a critical residual.

#### `6054851e80b463b3c994fef2acc110983769c309`
`Add LRE projection-obstruction framework for Navier-Stokes Clay problem`

**Classification:** DIRECT

#### `dfa3942f527f54ce92e61c9756052379b56e733e`
`Formalize Navier-Stokes LRE-NS closure framework with structural impossibility proofs`

**Classification:** DIRECT

#### `f02017f66d366a21542ccf69ef3145d1c6350914`
`Enhance NS formal closure: self-contained bridge, instantaneous barrier, decisive step framework`

**Classification:** VERY_STRONG_STRUCTURAL

---

## D. Coupling operator / geometric decomposition lineage

### 2025-12-19 — `ShantiDraconis/universal-emergent-logic-`

#### `ce960a1ba8ce7a893d645131d12d1a7ab06eddd9`
`Implement LRE geometric evolution: curvature theory, coupling operator, and Chapter 1`

Adds `CurvatureTheory.lean`, `CouplingCurvature.lean`, and NS topological blow-up theory.

**Classification:** DIRECT for coupling/curvature architecture.

#### `730aa849b0d76b0202f08b490664aa11c164b2bf`
`Complete formalization of LRE Theorem 1 and Navier-Stokes application`

Direct inspection shows the commit contains:

- projective system `(C,D,π)`;
- `D = H_N`, `π = P_N`;
- residue `R(u)=||u-P_Nu||²`;
- explicit closure defect from nonlinear advection:
  `P_N[(u·∇)u] ≠ (P_Nu·∇)(P_Nu)`;
- coupling hypothesis;
- Lean theorem `quantitative_closure_obstruction`;
- an NS Lean application.

The commit also explicitly states that the full Millennium proof remains open and that `sorry` placeholders / hard analytic steps remain.

**Classification:** DIRECT / VERY_STRONG_STRUCTURAL

This is one of the strongest internal matches to the mathematical chain currently under audit.

#### `a762e7b76464656236075548343f596ab8bc6815`
`Add comprehensive Quantitative Obstruction Theorem formalization`

Commit message states that `LRE/QuantitativeObstruction.lean` contains projective systems, residuals, dynamics, coupling hypothesis, a main theorem, and a toy model.

**Classification:** DIRECT

#### `ec14ceaa23ab173df3b13850ff2a83ad0a6da918`
`Address code review feedback: improve coupling coefficient and divergence-free handling`

**Classification:** DIRECT / REFINEMENT

Reason: refinement of the same coupling mechanism in a divergence-free setting.

---

## E. Residual-stability / dynamical-correction lineage

### 2025-12-19 — `ShantiDraconis/universal-emergent-logic-`

#### `1ed0ded98d26966189fc5936914fd964d42cbd7a`
`Implement Navier-Stokes Residual Stability Inequality formalization`

**Classification:** DIRECT

#### `0f3ae4e275068f81f516b45b14289dd1a699e659`
`Implement Phase 1-3: Navier-Stokes Residual Stability Framework`

**Classification:** DIRECT

#### `4cb3cd8ae5d24d5b79825346fb59ed47ff95bc9f`
`Add Residual Stability Inequality for Navier-Stokes in LRE framework`

**Classification:** DIRECT

#### `55398ace3c851133fb87f2d1efd260d5b8df82b3`
`Add complete Portuguese analytical proof of Residual Stability Inequality`

**Classification:** DIRECT / PAPER-PROOF LAYER

#### `3d4d3e51866e03420e97ff3b21dde2a1fca1cc4d`
`Complete Navier-Stokes Residual Stability Inequality and P vs NP formalization`

**Classification:** DIRECT

#### `203ce4ff62809fbcf403ee03e89c3bc70ed608ec`
`Formalize Residual Stability Inequality for Navier-Stokes in Lean 4`

**Classification:** DIRECT / LEAN

---

## F. Blow-up / residual-curvature derivatives

### 2025-12-19 — `ShantiDraconis/universal-emergent-logic-`

#### `fd7734da89df3bff77aeaa1490bb78659c846372`
`Add corrected RBC (Residual Blow-up Criterion) with proper sign`

**Classification:** DIRECT_DERIVATIVE

Reason: downstream criterion explicitly derived from the residual framework.

#### `28c950e77fbecb1e74d9aaef45b2a1ff49c340cc`
`Fix RBC theorem: correct sign in cubic term for blow-up dynamics`

**Classification:** DIRECT_DERIVATIVE / CORRECTION

Important forensic note: this commit demonstrates that the RBC formulation evolved and required a sign correction; the earlier form should not be cited as final without this correction.

#### `a3ccbf31c08284110b32518060c7d18ac6359f6a`
`Add Residual Blow-Up Criterion (RBC) formalization with mathematical correction`

**Classification:** DIRECT_DERIVATIVE

### 2025-12-20 — same repository

#### `8b1aedfdd81b188b7b3d9ba91c9fbf4f0a47cda1`
`Add geometric frameworks for Navier-Stokes blow-up ... via residual curvature`

**Classification:** DIRECT_DERIVATIVE

### 2025-12-31 — same repository

#### `b45b6cf6fcc5c7fd20cb4e9ac950684a14247ead`
`Fill Lean proof for inverse-square derivative in RBC blow-up criterion`

**Classification:** DIRECT_DERIVATIVE / LATER_FORMAL_COMPLETION

---

## G. Core mathematical genealogy recovered from these commits

The strongest recoverable lineage is:

```text
spectral/projective truncation
        ↓
projection / closure obstruction
        ↓
critical residual not controlled by projected energy
        ↓
residual coupling operator / coupling hypothesis
        ↓
quantitative closure obstruction
        ↓
Navier–Stokes residual stability inequality
        ↓
residual-curvature / blow-up criteria and later corrections
```

Representative SHAs:

```text
09bd7c8  projection scaffolding                         2025-12-16
4af517e  NS projection-obstruction                     2025-12-18
b9b4768  NS formal closure                             2025-12-18
a992d14  LRE-NS formal closure                         2025-12-18
0f17dc7  energy projection vs critical residual        2025-12-19
6054851  NS projection-obstruction Clay dossier        2025-12-19
ce960a1  curvature + coupling operator                  2025-12-19
730aa84  quantitative obstruction + NS decomposition   2025-12-19
a762e7b  Lean quantitative obstruction                 2025-12-19
1ed0ded  NS residual stability                         2025-12-19
203ce4f  Lean residual stability                       2025-12-20
fd7734d  residual blow-up criterion                     2025-12-19
28c950e  RBC sign correction                            2025-12-19
8b1aedf  residual curvature blow-up framework           2025-12-20
b45b6cf  later Lean proof completion                    2025-12-31
```

## H. Relation to the current audit claim

These commits materially strengthen the evidence that the audited ideas were not isolated statements but developed as a **genealogical mathematical program** across multiple repositories and successive formalization layers.

They support claims of:

- independent prior organization of the projection/residual/closure program;
- documented formalization of the coupling/obstruction architecture;
- a dated progression from structural formulation to Lean artifacts;
- subsequent residual-stability and blow-up derivatives.

They do **not**, by themselves, establish:

- identity with any later external construction;
- causal access or copying by another party;
- a complete Clay Millennium solution;
- that every theorem in every listed commit is kernel-verified without `sorry`, axioms, or unproved analytic assumptions.

## I. Next audit obligations

To upgrade this ledger from commit-level provenance to theorem-level provenance, each DIRECT / VERY_STRONG_STRUCTURAL entry should be expanded with:

1. exact changed file path;
2. theorem/definition name;
3. exact formula or normalized AST;
4. `authorDate` and `committerDate`;
5. parent SHA;
6. whether the Lean file builds at that SHA;
7. `#print axioms` / declaration dependency report;
8. presence/absence of `sorry`, `axiom`, `admit`, `by_contra` gaps, or external hypotheses;
9. normalized comparison against the external target theorem/object.

This file therefore serves as the commit-level index for the next theorem-by-theorem forensic pass.
