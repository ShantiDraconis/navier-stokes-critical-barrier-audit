# Audit 69 — Pre-existing code and structural provenance before the current G1 audit

Status: `PREEXISTING_CODE_PROVENANCE_ESTABLISHED__EXACT_CURRENT_G1_FORM_NOT_CLAIMED`

Date of audit note: `2026-09-13`

## Purpose

This note records directly verifiable Git evidence showing that substantial Navier–Stokes code, formalization scaffolding, critical-scaling objects, vorticity/stretching analysis, critical `L^3` endpoint targets, and projection/residual architecture existed in the user's repositories **before** the September 2026 G1/K0/K1/G2/G3/G4 audit decomposition.

This is a provenance claim only. It does **not** establish that the exact current objects

```text
Q_joint,
rho_*,
WeightedTailControl eta,
G1a+G1b+G1c+G1d,
FlexibleStretchingBound
```

already existed verbatim in 2025. Those later objects must be traced separately if an exact earlier match is claimed.

---

## 1. Earliest directly verified substantive NS framework — 2025-11-23

Repository:

```text
ShantiDraconis/millennium-navier-stokes-I
```

Commit:

```text
64bc633ecdb3a90ccfbf1c0863963c4bdd238d0f
```

Commit message:

```text
Implement Navier-Stokes SBFE/I collapse analysis framework
```

Directly present in the commit diff:

- 3D incompressible Navier–Stokes equations;
- numerical pseudo-spectral framework;
- vorticity, enstrophy, palinstrophy, and BKM monitoring;
- self-similar scaling diagnostics;
- explicit Navier–Stokes scaling

```text
u_lambda(x,t) = lambda u(lambda x, lambda^2 t),
p_lambda(x,t) = lambda^2 p(lambda x, lambda^2 t);
```

- identification of the critical dimension / critical regularity discussion;
- explicit distinction between finite-energy control and vorticity-gradient blow-up;
- geometric research direction involving vortex-line topology and dynamics;
- explicit disclaimer that the Millennium conclusion still required rigorous proof.

### Provenance classification

```text
NS_CODE_PRESENT = YES
CRITICAL_SCALING_PRESENT = YES
VORTICITY_ENSTROPHY_PALINSTROPHY_PRESENT = YES
GEOMETRIC_VORTICITY_DIRECTION_RESEARCH_TARGET = PRESENT
EXACT_Q_JOINT = NOT_ESTABLISHED_AT_THIS_COMMIT
EXACT_G1A_G1D_DECOMPOSITION = NOT_ESTABLISHED_AT_THIS_COMMIT
```

This commit is a substantive predecessor of the current critical-loop audit because it already contains the three native layers later isolated explicitly:

```text
energy budget,
vorticity amplification,
critical scaling / possible blow-up.
```

---

## 2. Formal prover code and critical endpoint structure — 2025-11-25

Repository:

```text
ShantiDraconis/millennium-navier-stokes-classical
```

Commit:

```text
cca881c665f67c67d96a4f84371fb51cd9c858a0
```

Commit message:

```text
Add comprehensive Lean, Coq, and Isabelle formalizations for Navier-Stokes theory
```

The commit contains a large NS blow-up/formalization dossier and prover sources. The mathematical text directly includes:

### Maximal smooth interval

```text
u in C([0,T*); H^s),
T* maximal existence time.
```

### Critical scaling

```text
u_lambda(x,t)=lambda u(lambda x,lambda^2 t),
||u||_L3 invariant.
```

### ESS endpoint target

The commit explicitly records the critical endpoint:

```text
u in L^infinity_t L^3_x  -> regularity
```

as the Escauriaza–Seregin–Šverák endpoint criterion.

### Vorticity and strain geometry

The text explicitly defines the vorticity equation and records

```text
xi = omega/|omega|,
S = strain tensor,
vortex stretching,
```

including the observation that alignment with an expansive strain eigenvector amplifies vorticity.

### Directional geometric regularity

The commit discusses Constantin–Fefferman type direction criteria and states the geometric obstruction in terms of vorticity direction becoming irregular in high-vorticity regions.

### Epsilon regularity / concentration

The commit also contains a local epsilon-regularity section and identifies concentration as necessary for singularity formation.

### Provenance classification

```text
MULTIPROVER_NS_FORMALIZATION = PRESENT_BY_2025_11_25
MAXIMAL_TIME_TSTAR = PRESENT
CRITICAL_L3_ENDPOINT = PRESENT
VORTICITY_DIRECTION_XI = PRESENT
STRAIN_STRETCHING_GEOMETRY = PRESENT
EPSILON_REGULARITY_LANGUAGE = PRESENT
EXACT_CURRENT_K0_K1_G1A_G1D_FILES = NOT_ESTABLISHED
```

Therefore the current September 2026 audit did not introduce the basic ideas `T*`, critical `L^3`, vorticity direction, strain alignment, or formal prover encoding from nothing; directly dated code/text already contained those ingredients in November 2025.

---

## 3. Formal NS framework chain already recorded by the audit — 2025-11-23 to 2025-11-26

The repository's existing full provenance audit records the following chain in `millennium-navier-stokes-I`:

```text
64bc633e  2025-11-23  SBFE/I collapse analysis framework
777d58e6  2025-11-25  I-collapse framework + LaTeX + Python
1cd176fa  2025-11-25  0/0 Constant I framework for NS collapse
079633d5  2025-11-25  Navier–Stokes formalism documentation
12f8b424  2025-11-25  complete analytical/functional/geometric formulation
63b248dd  2025-11-25  formal NS collapse framework
```

and in `millennium-navier-stokes-classical`:

```text
cca881c6  2025-11-25  Lean + Coq + Isabelle NS formalizations
dc558305  2025-11-25  Lean/Coq/Isabelle/Agda merge
867045e9  2025-11-26  I-Extended Functional Spaces Framework
```

The appearance of a `0/0 Constant I framework` is relevant to provenance of the later indeterminacy audit, but it must not be treated as proof that the exact 2026 `K0/K1/rho_*/eta` definitions were already present. It is classified as a structural precursor unless exact formula matching is recovered.

---

## 4. Projection / residual / critical-obstruction architecture — 2025-12-18

Repository:

```text
ShantiDraconis/Millennium
```

Commit:

```text
4af517e3f1ea5d04be1c6bbd8953209fa2139e82
```

Commit message:

```text
Add Navier-Stokes LRE projection-obstruction framework document
```

The commit directly defines a projection/residual architecture:

```text
(C,D,pi,iota,R)
```

with the energy/dissipation projection

```text
pi(u) = (E(t),D(t)),
E(t)=1/2 ||u(t)||_2^2,
D(t)=nu integral_0^t ||grad u||_2^2 ds.
```

It then defines the critical residual

```text
R(u;T)=||u||_{L^infinity(0,T;L^3)}.
```

The document explicitly states the central obstruction that energy/dissipation data are subcritical and do not by themselves determine critical `L^3` behavior.

It also includes a Littlewood–Paley cascade residual:

```text
R_cas(u;T;J)
 = integral_0^T sum_{j>=J} 2^j ||Delta_j u(t)||_2^2 dt.
```

### Direct relation to the current audit

This is a clear predecessor of the present distinction

```text
independent energy budget
vs
critical high-frequency / geometric obstruction.
```

It is also a predecessor of the current audit rule that one must not derive a critical bound merely from the kinetic-energy projection.

### Provenance classification

```text
ENERGY_PROJECTION = PRESENT_BY_2025_12_18
CRITICAL_L3_RESIDUAL = PRESENT_BY_2025_12_18
HIGH_FREQUENCY_LP_CASCADE = PRESENT_BY_2025_12_18
ENERGY_ALONE_INSUFFICIENT_ARCHITECTURE = PRESENT_BY_2025_12_18
EXACT_SIGNED_DEPLETION_G1 = NOT_ESTABLISHED_AT_THIS_COMMIT
```

---

## 5. Existing December 2025 formal-closure chain

The prior Git provenance audit records additional December 18 formalization anchors:

```text
4af517e3  LRE projection-obstruction framework
5a888677  Compression Barrier LaTeX + Lean
b9b47682  complete NS formal closure documentation
0d601255  complete formal closure framework LRE-NS
```

These commits demonstrate that formal closure architecture and Lean artifacts existed well before the current September 2026 decomposition.

The historical labels `formal closure` are repository labels and must **not** be interpreted retroactively as a validated solution of the Clay problem. The current audit's purpose is precisely to determine which premises in those historical closure claims were genuine theorems and which were interfaces, assumptions, or unresolved bridges.

---

## 6. Earlier code versus current exact G1 architecture

The strongest defensible lineage is:

```text
2025-11-23
NS simulation / vorticity / enstrophy / palinstrophy / critical scaling
        |
2025-11-25
maximal T*, critical L3 endpoint, xi=omega/|omega|,
strain/vortex-stretching geometry, epsilon regularity,
multiprover formalization
        |
2025-12-18
energy projection -> critical residual,
Littlewood-Paley cascade,
formal closure / obstruction architecture
        |
2026 audit
explicit countercertificates,
K0/K1/G1/G2/G3/G4 taxonomy,
Q_dir obstruction,
Q_joint candidate,
weighted eta,
flexible signed depletion,
non-circular a(t) in L1 target
```

This establishes **genealogical continuity** for the broad architecture.

It does not establish identity of every formula across dates.

---

## 7. Exact-match classification required for authorship claims

For every present-day object, the historical evidence must be classified separately:

```text
IDENTICAL
MATHEMATICALLY_EQUIVALENT
STRUCTURAL_PRECURSOR
CONCEPTUALLY_RELATED
NO_PRE_CUTOFF_MATCH
```

Current directly defensible classifications from the evidence inspected here:

| Current object | Earliest directly supported predecessor | Classification |
|---|---|---|
| NS critical scaling | `64bc633e`, 2025-11-23 | `IDENTICAL/CLASSICAL_FORMULA_PRESENT` |
| enstrophy / palinstrophy monitoring | `64bc633e`, 2025-11-23 | `STRUCTURAL_PRECURSOR` |
| maximal time `T*` | `cca881c6`, 2025-11-25 | `IDENTICAL_NOTATION/CONCEPT` |
| critical `L^infinity_t L3_x` endpoint | `cca881c6`, 2025-11-25 | `MATHEMATICALLY_EQUIVALENT_TARGET` |
| `xi=omega/|omega|` | `cca881c6`, 2025-11-25 | `IDENTICAL_FORMULA_PRESENT` |
| strain/vortex-stretching directional geometry | `cca881c6`, 2025-11-25 | `STRUCTURAL_PRECURSOR` |
| `0/0` indeterminacy program | `1cd176fa`, 2025-11-25 | `STRUCTURAL_PRECURSOR` pending exact formula recovery |
| energy projection / independent budget | `4af517e3`, 2025-12-18 | `STRUCTURAL_PRECURSOR` |
| critical `L3` residual | `4af517e3`, 2025-12-18 | `MATHEMATICALLY_EQUIVALENT_TARGET` |
| Littlewood–Paley high-frequency residual | `4af517e3`, 2025-12-18 | `STRUCTURAL_PRECURSOR` |
| exact `Q_joint=Q_dir+alpha Q_strain` | not recovered pre-2026 in this pass | `NO_PRE_CUTOFF_MATCH_FOUND_IN_SCAN` |
| exact `rho_* = kappa_0 sqrt(y)/sqrt(z)` | not recovered pre-2026 in this pass | `NO_PRE_CUTOFF_MATCH_FOUND_IN_SCAN` |
| exact weighted `eta` tail | not recovered pre-2026 in this pass | `NO_PRE_CUTOFF_MATCH_FOUND_IN_SCAN` |
| exact `G1a+G1b+G1c+G1d` decomposition | current audit | `NO_PRE_CUTOFF_MATCH_FOUND_IN_SCAN` |

The last four rows are intentionally conservative. Absence in this scan means `NOT_FOUND_IN_SCAN`, not proof of nonexistence.

---

## 8. Evidence hierarchy

### Direct Git evidence established in this note

1. `64bc633ecdb3a90ccfbf1c0863963c4bdd238d0f` — substantive NS analysis code/framework.
2. `cca881c665f67c67d96a4f84371fb51cd9c858a0` — formal prover NS work with critical endpoint and vorticity geometry.
3. `4af517e3f1ea5d04be1c6bbd8953209fa2139e82` — projection/residual critical architecture.

### Existing audit evidence used as cross-check

`audit/15_git_provenance_full.md` records the broader 2025 commit chain and assigns provenance status separately from mathematical validity.

---

## 9. Claim boundary

The defensible statement is:

> Dated Git history shows that the user's repositories already contained substantive Navier–Stokes code, critical scaling, vorticity/enstrophy analysis, multiprover formalization, vorticity-direction/strain geometry, the critical `L^infinity_tL^3_x` endpoint target, and projection/residual/high-frequency architecture during November–December 2025, months before the September 2026 G1 audit decomposition. The exact current `Q_joint`, `rho_*`, weighted-tail `eta`, and `G1a–G1d` formulas have not been shown by this scan to occur verbatim at those earlier dates.

This statement establishes chronology and genealogy. It does not establish worldwide priority, causal derivation by another party, or a completed Navier–Stokes proof.

---

## 10. Current status

```text
PRE_2026_NS_CODE = VERIFIED
PRE_2026_MULTIPROVER_NS_FORMALIZATION = VERIFIED
PRE_2026_CRITICAL_L3_TARGET = VERIFIED
PRE_2026_VORTICITY_DIRECTION_AND_STRAIN_GEOMETRY = VERIFIED
PRE_2026_PROJECTION_RESIDUAL_ARCHITECTURE = VERIFIED
PRE_2026_HIGH_FREQUENCY_CASCADE_ARCHITECTURE = VERIFIED
EXACT_PRE_2026_Q_JOINT = NOT_FOUND_IN_SCAN
EXACT_PRE_2026_RHO_STAR = NOT_FOUND_IN_SCAN
EXACT_PRE_2026_WEIGHTED_ETA = NOT_FOUND_IN_SCAN
EXACT_PRE_2026_G1A_G1D = NOT_FOUND_IN_SCAN
WORLDWIDE_PRIORITY = NOT_ESTABLISHED
CAUSAL_DERIVATION_BY_EXTERNAL_PARTIES = NOT_ESTABLISHED
GLOBAL_REGULARITY = NOT_ESTABLISHED
```
