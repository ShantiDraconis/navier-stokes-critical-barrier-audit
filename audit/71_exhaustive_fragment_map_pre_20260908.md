# Audit 71 — Pre-2026-09-08 fragment map to the current Navier–Stokes closure architecture

**Cutoff:** strictly before `2026-09-08T00:00:00Z`.

**Purpose.** Identify where the functional ingredients of the present audit architecture already occurred in the ShantiDraconis GitHub corpus before the cutoff. This is a provenance/priority audit. It does not convert historical fragments into a retrospective proof.

## Result in one sentence

The search now supports a substantially stronger fragmented-ancestry claim: by late November 2025 the corpus already contained (i) collapse/singularity monitoring, (ii) enstrophy/palinstrophy/BKM, (iii) explicit strain-vorticity stretching, (iv) vorticity–strain alignment, (v) the normalized direction `xi = omega/|omega|`, (vi) a high-vorticity mask and a weighted `|grad xi|` diagnostic, and (vii) critical endpoint machinery; on 4 December 2025 the same corpus explicitly documented Perelman's local-to-global template as `entropy + kappa-noncollapse + canonical neighborhoods + surgery`, and explicitly asked whether that strategy could transfer to Navier–Stokes; on 18–20 December 2025 the corpus developed projection/residual, Littlewood–Paley, geometric decomposition, coupling, residual-stability and critical-space modules. What is not found before the cutoff is the exact later theorem `ActualNS -> KWC -> SignedDepletion`, or a valid NS Perelman entropy identity.

## A. Earliest NS collapse / critical diagnostics

### 2025-11-23 — `64bc633ecdb3a90ccfbf1c0863963c4bdd238d0f`
Repository: `ShantiDraconis/millennium-navier-stokes-I`.

The commit implements an SBFE/I collapse-analysis framework and records the classical diagnostic stack: energy, enstrophy, palinstrophy, BKM, self-similar scaling, vorticity concentration/localization and geometric constraints. This is the earliest verified NS architecture anchor found in this sweep.

Classification: `EARLIEST_NS_ARCHITECTURE_ANCHOR`.

### 2025-11-25 — `1a16d4f8eae998790b3e8bed8a4cc5a964f7ee0b`
Path: `src/analysis/geometric_flow.py`.

This adds vortex-filament detection, local vorticity direction, vorticity-gradient/curvature diagnostics, concentration, conical-defect classification and a geometrically motivated singularity score.

Classification: `GEOMETRIC_VORTICITY_PRECURSOR`.

## B. Direct primitives of the later G1 geometry already in code

### 2025-11-25 — `d853205ed10e33279327b759adc3135bcd2a262c`
Repository: `ShantiDraconis/millennium-navier-stokes-classical`.
Path: `src/vorticity-tracking.py`.

This is the most important newly isolated direct-code ancestor. The historical file already implements:

```text
omega = curl u
S_ij = (partial_j u_i + partial_i u_j)/2
stretching = integral omega_i omega_j S_ij dx
alignment = omega . S omega / (|omega|^2 |S|)
threshold = 0.01 * max |omega|
mask = |omega| > threshold
xi = omega / |omega|
|grad xi|
weighted average of |grad xi| with |omega|
BKM integral
```

Thus the following present-day ingredients were not invented for the September 2026 audit:

```text
vorticity magnitude
high-vorticity region selection
strain tensor
vortex stretching
strain-vorticity alignment
normalized vorticity direction xi
vorticity-direction variation |grad xi|
weighted geometric diagnostic
endpoint/blow-up monitoring
```

This does **not** establish the later beta=1/2 KWC estimate, a uniform constant, a Biot–Savart weighted-tail theorem, or signed sub-viscous depletion. It does establish direct documentary ancestry of the variables and diagnostics from which those later obligations were assembled.

Classification: `DIRECT_G1_PRIMITIVE_PRECURSOR`.

### 2025-11-25 — `cca881c665f67c67d96a4f84371fb51cd9c858a0`
Path: `docs/navier-blowup-analysis.md` plus multiprover formalizations.

The historical document explicitly discusses alignment with the stretching eigendirection and the Constantin–Fefferman vorticity-direction criterion. This anchors the directional-geometric route independently of the later G1 naming.

Classification: `DIRECTIONAL_GEOMETRY_AND_FORMALIZATION`.

## C. Gap-aware formal architecture

### 2025-11-25 — `12f8b424646fba8e278a99f7cf350f3d2c7eb09e`
Merge title: `Add complete analytical, functional, and geometric formulation with marked gaps`.

The phrase `with marked gaps` is important forensic evidence. The corpus was already organized around an explicit distinction between formal structure and unresolved analytic obligations.

### 2025-11-25 — `63b248dd29f1817c457acdb00e116e2e9b0687cc`
Signed GitHub merge of a WIP formal framework for Navier–Stokes collapse theory.

### 2025-11-25 — `ee504cc804e205a9a2e76c6c86689aaea4c6ea84`
Agda/multiprover extension containing an ESS endpoint interface.

These establish the early chain:

```text
Actual NS formulation
 -> singularity diagnostics
 -> geometric/directional quantities
 -> critical endpoint criterion
```

but not the missing dynamical bridge.

## D. Perelman template existed explicitly in the corpus before the later NS stabilization

### 2025-12-04 — `2dcd1fcf5d9dc8c87405c5c2af80e08c00f21c0b`
Repository: `ShantiDraconis/Millennium`.
Path: `problems/Poincare/local-global-bridge.md`.

This is the strongest evidence that the later Perelman-like organization had a documented precursor in the user's corpus. The file explicitly records:

```text
Perelman local objects:
  Ricci curvature
  scalar curvature
  singularity formation / blow-up analysis
  entropy functionals W and mu

Key lemmata:
  no local collapsing / kappa-noncollapsing
  canonical neighborhoods / singularity classification
  finite extinction / entropy monotonicity
  surgery preserves geometric control

Strategy:
  find the right flow
  control singularities
  use monotonicity
  bridge local to global
```

Most importantly for provenance, the same historical file contains a `Navier-Stokes Analogy` table and asks whether a `flow with surgery` / regularized-flow strategy could transfer to Navier–Stokes.

Therefore the defensible claim is:

> The corpus explicitly contained the Perelman template `entropy + noncollapse + singularity classification + surgery + local-to-global bridge`, and explicitly juxtaposed it with Navier–Stokes, by 4 December 2025.

The indefensible stronger claim would be:

> The NS entropy/noncollapse/surgery theorem was already proved in December 2025.

It was not.

Classification: `PERELMAN_TEMPLATE_PRECURSOR`.

## E. Projection/residual and critical-scale closure architecture

### 2025-12-18 — `f900684c3785ffbd9707291225b2c1751ae3e3eb`
`Universe-0-0`: LRE Projection Framework with an NS dossier.

### 2025-12-18 — `4af517e3f1ea5d04be1c6bbd8953209fa2139e82`
`Millennium`: `C,D,pi,iota,R`, critical residual, informational residual and Littlewood–Paley cascade residual.

### 2025-12-18 — `003eaba057081f262ea40cea0ab698af43109151`
Comprehensive NS LRE summary: projection obstruction, critical residual, bridge, formal module and explicit statement that the Clay problem is not solved.

### 2025-12-18 — `5fcf3fc5140ee231bc0b3d3fbbe699c4ad84a50b`
Formal-closure summary. The document explicitly says that a new blocking principle is required and lists helicity, vortex topology and geometric level-set regularity among possible mechanisms.

This gives the historical architecture:

```text
energy/subcritical projection
 -> information loss / residual
 -> critical norm
 -> need a new blocking/geometric principle
 -> regularity endpoint
```

Classification: `STRONG_STRUCTURAL_PRECURSOR`.

## F. Littlewood–Paley, geometric decomposition and coupling

### 2025-12-19 — `294141b0f13a015da92b25880d67a765f7150f14`
`universal-emergent-logic-`, `docs/lre-examples/navier-stokes-specialization.md`.

The historical specialization identifies the critical Hdot(1/2) residual, scale invariance, concentration and explicitly recommends:

```text
Littlewood-Paley decomposition
separate scales explicitly
control transfer between scales
bound enstrophy cascade
find a new observable J controlling the critical residual
```

This is a direct precursor of the later high/low-frequency and critical-scale program. Some theorem claims in that historical document are too strong and must not be imported as established facts; the file is used here only for provenance.

### 2025-12-19 — `730aa849b0d76b0202f08b490664aa11c164b2bf`
Adds a Navier–Stokes geometric decomposition and a Lean coupling hypothesis.

This is particularly important because it shows that the need for a **coupling bridge** between structural geometry and the desired quantitative estimate was already explicit.

### 2025-12-19 — residual-stability chain

```text
1ed0ded98d26966189fc5936914fd964d42cbd7a
0f3ae4e275068f81f516b45b14289dd1a699e659
4cb3cd8ae5d24d5b79825346fb59ed47ff95bc9f
abdaa41189864f85d3b9f8c8fec6b3ec4431eab5
3d4d3e51866e03420e97ff3b21dde2a1fca1cc4d
```

These commits develop a Residual Stability Inequality program. They are ancestors of the present desire for a coercive/differential inequality, but their exact hypotheses and proof escapes require separate theorem-level audit.

## G. Universal multiscale architecture

### 2025-12-26

```text
c953fc264b58a0631d65f996f2e37e216134bd01
6ece68cdf4175760bd187ca19f4a3b8f2d33f750
5c70d6c2427739d5afaf6c9790072a917f51fc32
28b7e98a80de123b7805fca2a925a684d998fe2b
```

These commits document scale projection, residual functionals, normalization, multiscale energy, multidimensional geometry, an NS adapter and residual/exponent refinements.

Classification: `UNIVERSAL_MULTISCALE_PRECURSOR`.

## H. Fragment-to-current mapping

| Present role | Pre-cutoff evidence |
|---|---|
| `ActualNS` / target | `64bc...`, `be02...`, `12f8...` |
| enstrophy / palinstrophy / BKM | `64bc...` |
| high-vorticity region | `d853...` threshold/mask |
| strain tensor `S` | `d853...` |
| stretching `omega_i omega_j S_ij` | `d853...` |
| strain-vorticity alignment | `d853...`; `cca881...` |
| direction `xi = omega/|omega|` | `d853...`; `cca881...` |
| direction variation `|grad xi|` | `d853...`; `cca881...` |
| geometric filaments/local direction | `1a16...` |
| critical endpoint / ESS | `d853...`; `ee504...` |
| critical residual | `4af517...`; `003eaba...`; `294141...` |
| Littlewood–Paley / scale separation | `4af517...`; `294141...` |
| geometric decomposition | `730aa...` |
| coupling bridge explicitly isolated | `730aa...` |
| differential/stability inequality program | `1ed0...` through `3d4d...` |
| Perelman entropy template | `2dcd...` |
| Perelman kappa-noncollapse template | `2dcd...` |
| singularity classification/canonical neighborhoods | `2dcd...` |
| surgery/local-global template | `2dcd...` |
| explicit Perelman-to-NS analogy | `2dcd...` |
| universal multiscale residual architecture | `c953...`, `6ece...`, `5c70...`, `28b7...` |

## I. What this establishes

```text
PRE_CUTOFF_NS_COLLAPSE_ARCHITECTURE = VERIFIED
PRE_CUTOFF_VORTICITY_STRAIN_ALIGNMENT_CODE = VERIFIED
PRE_CUTOFF_HIGH_VORTICITY_DIRECTION_DIAGNOSTIC = VERIFIED
PRE_CUTOFF_CRITICAL_ENDPOINT_PROGRAM = VERIFIED
PRE_CUTOFF_PERELMAN_TEMPLATE_IN_CORPUS = VERIFIED
PRE_CUTOFF_EXPLICIT_PERELMAN_NS_ANALOGY = VERIFIED
PRE_CUTOFF_LP_CRITICAL_SCALE_PROGRAM = VERIFIED
PRE_CUTOFF_GEOMETRIC_DECOMPOSITION_AND_COUPLING_PROGRAM = VERIFIED
FRAGMENTED_STRUCTURAL_ANCESTRY = STRONGLY_SUPPORTED
```

## J. What this does not establish

```text
EXACT_PRE_CUTOFF_KWC_THEOREM = NOT_FOUND
EXACT_PRE_CUTOFF_BETA_HALF_UNIFORM_CONSTANT = NOT_FOUND
EXACT_PRE_CUTOFF_WEIGHTED_BIOT_SAVART_TAIL_BRIDGE = NOT_FOUND
EXACT_PRE_CUTOFF_SIGNED_DEPLETION_THEOREM_FROM_ACTUAL_NS = NOT_FOUND
EXACT_PRE_CUTOFF_NS_PERELMAN_ENTROPY_IDENTITY = NOT_FOUND
PRE_CUTOFF_GLOBAL_REGULARITY_PROOF = NOT_ESTABLISHED
THIRD_PARTY_DERIVATION_FROM_THIS_CORPUS = NOT_ESTABLISHED
```

## K. Priority-safe conclusion

The correct priority claim supported by the Git history is not that a complete Navier–Stokes proof existed in 2025. It is that a substantial fraction of the **functional architecture and even several of the exact computational primitives later assembled into the G1/Perelman-like audit** were already independently timestamped across the ShantiDraconis corpus in November–December 2025. In particular, the direct vorticity/strain/alignment/`xi`/`grad xi` implementation predates the later audit, and the Perelman `entropy + noncollapse + surgery + local-to-global` template was explicitly documented and explicitly compared with Navier–Stokes on 4 December 2025.

That establishes documentary ancestry. Mathematical equivalence of later theorems, and any claim of causal derivation by a third party, require separate evidence.
