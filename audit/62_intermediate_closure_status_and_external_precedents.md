# Audit 62 — Intermediate closure status and external precedents

Status: `COMPARATIVE_PRECEDENT_AUDIT`

Date: `2026-09-13`

## 1. Purpose

This note records two separate questions:

1. What is the exact proof-completion ladder for the current Navier–Stokes audit?
2. Are there prior or external works using related ideas such as conditional closure, bridge status, directional depletion, pressure/flux depletion, or frequency-envelope closure?

The two questions must not be conflated. Similar vocabulary or similar analytical mechanisms do not establish identity, derivation, copying, or worldwide priority.

## 2. Current proof-completion ladder

The audit now distinguishes the following levels:

```text
LEVEL 0 — FALSIFIED ROUTE
A proposed sufficient implication has a countercertificate.

LEVEL 1 — OPEN
A substantive mathematical bridge is absent.

LEVEL 2 — TARGET_FORMALIZED
The missing theorem is explicitly stated and machine-encoded as a target/interface.

LEVEL 3 — CONDITIONALLY_CLOSED
All downstream implications are proved from a finite list of explicit unresolved premises and external theorem maps.

LEVEL 4 — PDE_CLOSED
The missing critical premise is itself derived from the actual Navier–Stokes hypotheses.

LEVEL 5 — ENDPOINT_CLOSED
The critical norm bound is matched rigorously to the endpoint theorem with all assumptions verified.

LEVEL 6 — FULLY_CLOSED
The complete theorem establishes global regularity, or on a negative route an admissible finite-time singularity construction establishes failure of global regularity.
```

Current repository placement:

```text
B2.8 proposed scalar/alignment route = LEVEL 0 for that route
DirectionalDepletion replacement target = LEVEL 2
Conditional decay machinery = LEVEL 3 where premises are explicit
DirectionalDepletion derived from actual NS = LEVEL 1 / OPEN_BRIDGE
Critical L3 completion / ESS map = below LEVEL 5
Millennium conclusion = NOT LEVEL 6
```

This ladder is a proof-status taxonomy, not a new logical truth value between true and false.

## 3. Positive closure target

The current positive-resolution route is:

```text
actual 3D Navier-Stokes dynamics
  -> PDE-derived directional depletion or equivalent critical mechanism
  -> signed high-frequency flux upper bound
  -> dissipation dominates production
  -> residual decay
  -> high-frequency critical control
  -> uniform low-frequency critical control
  -> sup_{t<T*} ||u(t)||_L3 < infinity
  -> exact ESS hypothesis map
  -> T* = infinity.
```

An audit-safe schematic target is

```text
Pi_Lambda(u)
 <= [nu Lambda^2/4 + Err_Lambda(u)] R_Lambda(u)
```

with

```text
Err_Lambda(u) < (3/4) nu Lambda^2
```

uniformly on the maximal interval, derived from the PDE rather than inserted as an assumption.

The main closure target remains

```text
For every admissible maximal smooth 3D Navier-Stokes solution u,

sup_{t<T*} ||u(t)||_L3 < infinity,

hence T* = infinity.
```

## 4. Negative closure target

A negative resolution would require an actual admissible smooth initial datum and a rigorous proof of finite maximal existence time or the exact alternative allowed by the official problem formulation.

The present countercertificates do not provide this. In particular,

```text
Alignment = 1
proposed strain coefficient > 25
scalar residual does not determine signed flux
```

do not imply

```text
T* < infinity.
```

Therefore:

```text
GLOBAL_REGULARITY = NOT_ESTABLISHED
FINITE_TIME_BLOWUP = NOT_ESTABLISHED
```

## 5. External precedents — proof-status language

There are external examples using related proof-audit language.

A 2026 research-level proof-evaluation framework uses the expression `only conditionally closed` when a route depends on an unresolved global premise. This is conceptually close to the present distinction between a completed downstream derivation and an unresolved upstream bridge.

A separate 2026 status-document project uses the phrase `Conditional Bridge Closure Edition` and organizes results around explicit bridge/gap status.

These examples show that the general idea of distinguishing a conditional closure from a fully discharged theorem is **not unique in the abstract**.

No claim is made here that either source uses the exact seven-level ladder of this repository or the same Navier-Stokes dependency graph.

## 6. External precedents — Navier-Stokes directional depletion and flux mechanisms

Several external 2026 works use concepts related to directional depletion, alignment, frequency decomposition, or flux depletion.

### 6.1 Quantitative directional depletion / alignment

A 2026 paper by Bryan Permana and collaborators publicly claims a global-regularity framework based on quantitative vorticity alignment/depletion, Biot-Savart analysis, Littlewood-Paley decomposition, and an endpoint criterion. Public versions appeared on Zenodo/SSRN in April 2026.

This is thematically close to the current repository's focus on a missing PDE-derived directional mechanism, but the existence of a public claim is not equivalent to independent verification of its proof.

### 6.2 Equilibrium depletion / frequency envelopes

A 2026 paper by William Harbeck publicly claims global regularity using equilibrium depletion and universal frequency envelopes. Again, this is conceptually related to spectral non-concentration and depletion mechanisms, but it is not identified here as mathematically equivalent to the present B2 architecture.

### 6.3 Coarse-grained pressure/flux work depletion

Runlong Yu's June 2026 arXiv work develops coarse-grained resolution and a pressure-flux work depletion mechanism near the Caffarelli-Kohn-Nirenberg framework. This is especially relevant as an external example where resolved/unresolved scales and signed work/flux structures are isolated explicitly.

The present audit must compare exact hypotheses, observables, signs, domains, norms, and theorem statements before assigning any stronger relation than `CONCEPTUALLY_RELATED` or, where justified, `STRUCTURAL_PRECURSOR`.

## 7. What has and has not been established by this comparison

Established:

```text
- conditional-closure style proof-status language exists elsewhere;
- directional-depletion/alignment approaches to Navier-Stokes exist elsewhere;
- coarse-grained pressure/flux-depletion frameworks exist elsewhere;
- frequency-envelope/depletion approaches exist elsewhere.
```

Not established:

```text
- that another source uses the exact same seven-level taxonomy;
- that another source has the exact same B2 dependency graph;
- that another source has the same finite Fourier countercertificate;
- that another source has the same Lean/Coq audit architecture;
- worldwide priority;
- causal derivation or copying;
- correctness of any external claimed Navier-Stokes solution.
```

## 8. Required comparison standard

For any future external-claim comparison, classify each relation as one of:

```text
IDENTICAL
MATHEMATICALLY_EQUIVALENT
STRUCTURAL_PRECURSOR
CONCEPTUALLY_RELATED
NO_PRE_CUTOFF_MATCH
```

and record exact source dates, theorem statements, hypotheses, equations, and public identifiers before making an anteriority or equivalence claim.

## 9. Current audit verdict

```text
EXACT_SEVEN_LEVEL_PROOF_STATUS_TAXONOMY_ELSEWHERE = NOT_ESTABLISHED
GENERAL_CONDITIONAL_CLOSURE_IDEA_ELSEWHERE = ESTABLISHED
DIRECTIONAL_DEPLETION_APPROACHES_ELSEWHERE = ESTABLISHED
PRESSURE_FLUX_DEPLETION_APPROACHES_ELSEWHERE = ESTABLISHED
EXACT_EQUIVALENCE_TO_CURRENT_B2_ARCHITECTURE = NOT_ESTABLISHED
WORLDWIDE_PRIORITY = NOT_ESTABLISHED
CAUSAL_DERIVATION_BY_OTHERS = NOT_ESTABLISHED
```

This document is a comparative audit note, not a priority declaration.