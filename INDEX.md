# Repository Index and Evidence Map

This file is the navigation layer for the complete audit. It tells a reviewer where to find each class of evidence and which status applies to it.

## Read first

1. `README.md` — scope, evidence firewall, principal dates, and navigation.
2. `STATUS.md` — current scientific and provenance status.
3. `TIMELINE.md` — chronological evidence map in UTC.
4. `CLAIMS.md` — claim inventory and claim boundaries.
5. `LIMITATIONS.md` — explicit limitations and unresolved evidentiary gaps.
6. `METHODOLOGY.md` — audit methodology.
7. `PRIORITY.md` — priority/provenance summary.
8. `audit/59_final_public_freeze_evidence_ledger.md` — frozen evidence/status ledger.
9. `audit/61_logical_scenario_partition_after_gap_isolation.md` — post-countercertificate scenario partition.
10. `audit/62_intermediate_closure_status_and_external_precedents.md` — proof-status taxonomy.
11. `audit/63_reference_crosswalk_and_nonclosure_certificate.md` — literature crosswalk and nonclosure certificate.
12. `audit/64_b2_8_closure_blueprint_and_final_proof_spec.md` — three-route closure blueprint.
13. `audit/65_exact_failure_and_minimal_closure_obligations.md` — exact G1–G4 failure decomposition.
14. `audit/66_g1_g4_expanded_closure_program.md` — maximal safe expansion, corrected enstrophy identity, G1 coercivity targets, G2/G3 reconstruction and G4 endpoint map.

## Evidence firewall

A timestamp proves chronology only to the extent independently verifiable. Structural similarity does not prove copying. A machine-checked implication does not prove its supplied premises. An explicit target interface is not a proof of the target. Formal-source presence is distinct from compiler execution.

## Core mathematical audit sequence

- `audit/45_endpoint_closure_register.md` — endpoint closure register.
- `audit/46_universal_state_transition_resolution_architecture.md` — state/operator architecture.
- `audit/47_ns_b2_critical_tail_derivation_and_cross_problem_sources.md` — critical-tail route.
- `audit/50_audit_freeze_and_reopening_protocol.md` — freeze/reopening rules.
- `audit/51_b2_scalar_residual_counterexample_and_sign_correction.md` — scalar-residual countercertificate.
- `audit/52_multiprover_complete_closure_target_specification.md` — multiprover targets.
- `audit/56_complete_closure_operator_lemma_axiom_tree.md` — closure target tree.
- `audit/59_final_public_freeze_evidence_ledger.md` — frozen evidence ledger.
- `audit/61_logical_scenario_partition_after_gap_isolation.md` — eight admissible scenarios.
- `audit/62_intermediate_closure_status_and_external_precedents.md` — OPEN → TARGET_FORMALIZED → CONDITIONALLY_CLOSED → PDE_CLOSED → ENDPOINT_CLOSED → FULLY_CLOSED.
- `audit/63_reference_crosswalk_and_nonclosure_certificate.md` — references and nonclosure.
- `audit/64_b2_8_closure_blueprint_and_final_proof_spec.md` — Routes A/B/C and final-proof dependency specification.
- `audit/65_exact_failure_and_minimal_closure_obligations.md` — G1 signed nonlinear control; G2 critical high-frequency control; G3 fixed-scale reconstruction; G4 ESS map.
- `audit/66_g1_g4_expanded_closure_program.md` — corrected maximal closure program.

## New multiprover G1–G4 blueprint

Lean:
- `formal/lean/CriticalBarrier/G1G4ClosureBlueprint.lean`

Coq:
- `formal/coq/G1G4ClosureBlueprint.v`

Isabelle:
- `formal/isabelle/G1G4_Closure_Blueprint.thy`

Agda:
- `formal/agda/G1G4ClosureBlueprint.agda`

These files deliberately prove only implication/composition layers that follow from explicit certificates. They introduce no theorem or axiom asserting the missing universal geometric-depletion bridge.

Execution status must be recorded separately. Creation of a source file is not a compiler certificate.

## Corrected current dependency graph

```text
actual admissible 3D NS dynamics
  -> [G1 OPEN] uniform enstrophy / equivalent critical coercivity
  -> [G2 FORMALIZATION TARGET] fixed-cutoff high-frequency L3
  +  [energy + Bernstein] fixed-cutoff low-frequency L3
  -> [G3 PROVED_LOGIC ON PREMISES] uniform total L3
  -> [G4 EXTERNAL + MAP OPEN] ESS endpoint
  -> continuation / T*=infinity.
```

The reconstruction does not require the total global L3 norm to be small; a finite uniform `L^infinity_t L3_x` bound is the relevant ESS endpoint condition in the standard R3 formulation. Any local epsilon-regularity route is a different endpoint architecture and must not be silently substituted.

## Current conclusion

```text
TARGET_ARCHITECTURE = FORMALIZED
ALGEBRAIC_CONDITIONAL_LAYER = PROVED_LOGIC_FOR_TESTED_FILES
G1_SIGNED_NONLINEAR_CONTROL = OPEN_BRIDGE
G2_HIGH_FREQUENCY_L3 = FORMALIZATION_TARGET
G3_FIXED_SCALE_RECONSTRUCTION = PROVED_LOGIC_ON_EXPLICIT_PREMISES
G4_ESS_HYPOTHESIS_MAP = OPEN/EXTERNAL
GLOBAL_REGULARITY = NOT_ESTABLISHED
FINITE_TIME_BLOWUP = NOT_ESTABLISHED
```

## Negative certificates retained

```text
PROPOSED_STRAIN_TO_25 = FALSIFIED_PROPOSED_IMPLICATION
TRACELESS_PLUS_CONCENTRATION_TO_ALIGNMENT_09 = FALSIFIED_PROPOSED_IMPLICATION
SCALAR_RESIDUAL_TO_SIGNED_FLUX = FALSIFIED_AT_FINITE_FOURIER_LEVEL
```

The strain examples `diag(2,-1,-1)` and `diag(1,1,-2)` show that trace-free structure and equal quadratic size do not determine the sign of cubic strain production. This is a finite algebraic obstruction, not a Navier–Stokes blow-up construction.

## Principal final-proof specification

A genuine positive resolution through this architecture would require a theorem derived from the actual NS equations that supplies G1 without assuming an equivalent regularity criterion. Once G1 yields uniform enstrophy or an equivalent critical bound, the intended remaining chain is harmonic analysis → fixed-scale reconstruction → exact ESS hypothesis map → continuation.

Until that theorem is proved:

```text
FINAL_THEOREM_STATEMENT = SPECIFIED
FINAL_THEOREM_PROOF = NOT_ESTABLISHED
NAVIER_STOKES_MILLENNIUM_SOLUTION = NOT_ESTABLISHED
```

## Provenance and comparison

See `TIMELINE.md`, `PRIORITY.md`, and the audit provenance ledgers. The repository supports dated public genealogy for recorded objects but does not by itself establish worldwide first priority, causal derivation by others, or a completed Clay Millennium solution.
