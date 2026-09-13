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
9. `audit/61_logical_scenario_partition_after_gap_isolation.md` — post-countercertificate scenario partition and intermediate closure ladder.
10. `audit/62_intermediate_closure_status_and_external_precedents.md` — proof-status taxonomy and external-precedent comparison.
11. `audit/63_reference_crosswalk_and_nonclosure_certificate.md` — literature crosswalk and exact nonclosure certificate.
12. `audit/64_b2_8_closure_blueprint_and_final_proof_spec.md` — three-route B2 closure blueprint and final-proof specification.

## Evidence firewall

The repository distinguishes documentary priority, mathematical equivalence, public availability, external exposure, causal derivation, formal target encoding, and actual theorem closure. These must not be collapsed.

A timestamp proves chronology only to the extent independently verifiable. Structural similarity does not prove copying. A machine-checked implication does not prove its supplied premises. An explicit target interface is not a proof of the target.

## Root files

- `README.md` — executive overview.
- `INDEX.md` — this navigation map.
- `STATUS.md` — current evidentiary/scientific status.
- `TIMELINE.md` — chronology.
- `CLAIMS.md` — claim ledger.
- `PRIORITY.md` — priority summary.
- `METHODOLOGY.md` — audit method.
- `LIMITATIONS.md` — limitations.
- `CITATION.cff` — citation metadata.
- `CONTRIBUTING.md` — contribution rules.
- `LICENSE` — repository license.

## Core mathematical audit sequence

- `audit/03_L3_consistency_test.md` through `audit/12_open_questions.md` — compatibility, scaling, cancellations, contradictions, and open questions.
- `audit/45_endpoint_closure_register.md` — endpoint closure register.
- `audit/46_universal_state_transition_resolution_architecture.md` — state/operator resolution architecture.
- `audit/47_ns_b2_critical_tail_derivation_and_cross_problem_sources.md` — critical-tail route.
- `audit/50_audit_freeze_and_reopening_protocol.md` — freeze/reopening rules.
- `audit/51_b2_scalar_residual_counterexample_and_sign_correction.md` — finite Fourier scalar-residual countercertificate and sign correction.
- `audit/52_multiprover_complete_closure_target_specification.md` — multiprover closure targets.
- `audit/56_complete_closure_operator_lemma_axiom_tree.md` — closure target tree.
- `audit/59_final_public_freeze_evidence_ledger.md` — frozen public evidence ledger.
- `audit/60_youtube_live_historical_claim_evidence.md` — historical-claim provenance addendum.
- `audit/61_logical_scenario_partition_after_gap_isolation.md` — eight admissible research scenarios; no false dichotomy.
- `audit/62_intermediate_closure_status_and_external_precedents.md` — OPEN → TARGET_FORMALIZED → CONDITIONALLY_CLOSED → PDE_CLOSED → ENDPOINT_CLOSED → FULLY_CLOSED taxonomy.
- `audit/63_reference_crosswalk_and_nonclosure_certificate.md` — literature crosswalk; reference gap substantially closed, PDE bridge not closed.
- `audit/64_b2_8_closure_blueprint_and_final_proof_spec.md` — Route A geometric depletion, Route B vector/tensor defect, Route C enstrophy-production depletion; exact final-proof dependency specification.

## Provenance and comparison

- `audit/13_cross_repository_forensic_index.md`
- `audit/14_openai_formula_provenance.md`
- `audit/15_correction_architecture_comparison.md`
- `audit/15_git_provenance_full.md`
- `audit/15_projection_chain_audit_map.md`
- `audit/16_chat_provenance_ledger.md`
- `audit/16_related_commit_derivations.md`

## Formal directories

Four prover families are now represented:

- `formal/lean/` — Lean 4 / Mathlib formalization and tested targets.
- `formal/coq/` — Coq formalization and configured targets.
- `formal/isabelle/` — Isabelle source targets; execution status must be reported separately.
- `formal/agda/` — Agda source targets; execution status must be reported separately.

### B2 gap and closure target files

Lean:
- `formal/lean/CriticalBarrier/B2ScalarResidualCounterexample.lean`
- `formal/lean/CriticalBarrier/B2_8_AlignmentTarget.lean`
- `formal/lean/CriticalBarrier/B2_8_SignedFlux_GapIsolation.lean`
- `formal/lean/CriticalBarrier/B2_DeterministicParameterChain.lean`
- `formal/lean/CriticalBarrier/B2_ChainTarget.lean`
- `formal/lean/CriticalBarrier/B2_ClosureObligations.lean` — Route A/B/C and downstream closure composition; open PDE statements are explicit certificate fields.

Coq:
- `formal/coq/B2_8_AlignmentTarget.v`
- `formal/coq/CompleteClosureTargets.v`
- `formal/coq/B2_ClosureObligations.v` — Route A/B/C implication composition.

Isabelle:
- `formal/isabelle/B2_8_Alignment_Target.thy`
- `formal/isabelle/Complete_Closure_Targets.thy`
- `formal/isabelle/B2_Closure_Obligations.thy` — Route A/B/C implication composition.

Agda:
- `formal/agda/B2_8_AlignmentTarget.agda`
- `formal/agda/CompleteClosureTargets.agda`
- `formal/agda/B2ClosureObligations.agda` — Route A/B/C implication composition.

Formal-source presence must not be conflated with execution. Lean/Coq files should be described as checked only when the relevant compiler/CI step succeeds. Isabelle/Agda remain `SOURCE_PRESENT_NOT_EXECUTED` until an actual toolchain run is recorded.

## Current B2 dependency graph

```text
actual admissible 3D NS dynamics
  -> [OPEN] PDE-derived directional depletion / vector-tensor / enstrophy mechanism
  -> [TARGET] signed high-frequency flux upper bound
  -> [CONDITIONAL LOGIC] dissipative domination
  -> [CONDITIONAL LOGIC] residual decay
  -> [OPEN/CONDITIONAL] high-frequency critical L3
  +  [OPEN] low-frequency critical L3
  -> [OPEN] uniform L^infinity_t L3_x
  -> [EXTERNAL + MAP OPEN] ESS endpoint
  -> continuation / T*=infinity.
```

Current conclusion:

```text
TARGET_ARCHITECTURE = FORMALIZED
DOWNSTREAM_LOGIC = CONDITIONALLY_CLOSED
DIRECTIONAL_DEPLETION_FROM_NS = OPEN_BRIDGE
SIGNED_FLUX_FOR_ACTUAL_NS = OPEN_BRIDGE
CRITICAL_L3_RECONSTRUCTION = OPEN_BRIDGE
ESS_FORMAL_HYPOTHESIS_MAP = OPEN/EXTERNAL
GLOBAL_REGULARITY = NOT_ESTABLISHED
FINITE_TIME_BLOWUP = NOT_ESTABLISHED
```

## Literature crosswalk

See `audit/63_reference_crosswalk_and_nonclosure_certificate.md`. The current crosswalk includes foundational geometric depletion/directional-coherence work, the ESS endpoint theorem, and contemporary depletion/defect/flux-audit approaches. Generic directional depletion and frequency/flux-depletion ideas have prior art. Exact equivalence to the current multiprover B2 audit architecture is not established.

## Evidence, priority, theory, numerical, graph

- `evidence/` — primary-source evidence packs, integrity records, formula crosswalks.
- `priority/` — structured prior-work summaries and chronology.
- `theory/` — mathematical framework and classical dependencies.
- `python/`, `data/`, `results/` — computational checks and outputs.
- `graph/` — provenance/evidence graphs.

## Automation / integrity

- `.github/workflows/audit-integrity.yml` — automated integrity checks.
- `.github/agents/` — audit-agent configuration/scaffolding.

## Principal provenance anchors

The detailed chronology remains in `TIMELINE.md` and the provenance ledgers. Important Git anchors include the November–December 2025 projection/residual/correction lineage and the September 2026 formal audit/countercertificate lineage. Conversation-derived dates remain a separate evidence class unless verified against an original export.

## Current comparison conclusion

The audit supports public Git genealogy and multiple dated prior objects. It identifies substantial structural overlap with several mathematical traditions and later constructions, but does not establish causal derivation, plagiarism, worldwide priority, or a completed Clay Millennium solution.

The immediate mathematical remainder is no longer ambiguous: prove from actual 3D Navier–Stokes dynamics a non-circular critical mechanism strong enough to control signed high-frequency flux and reconstruct a uniform critical L3 bound, then verify the exact ESS endpoint map.
