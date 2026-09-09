# Claim Registry

All claims must use exactly one status:

- CLASSICAL
- PROVED_IN_REPOSITORY
- FORMALIZED
- DERIVED
- NUMERICALLY_SUPPORTED
- CONJECTURAL
- TARGET
- UNRESOLVED
- FALSE
- REFUTED
- NOT_APPLICABLE

| ID | Statement | Status | Reference |
|---|---|---|---|
| CLAIM-001 | L3 is scale invariant under Navier–Stokes scaling. | CLASSICAL | Standard literature; theory/02_scaling.md |
| CLAIM-002 | Bounded Linf_t L3_x excludes finite-time singularity under ESS hypotheses. | CLASSICAL | Escauriaza–Seregin–Sverak; theory/05_ESS_endpoint.md |
| CLAIM-003 | If T* < infinity then sup_{t<T*} ||u(t)||_3 = infinity. | DERIVED | Derived from classical ESS endpoint; evidence: graph/nodes.yaml THEOREM:ESS_BLOWUP_ALTERNATIVE |
| CLAIM-004 | Proposed external construction satisfies required critical-L3 loss profile. | UNRESOLVED | audit/03_L3_consistency_test.md |
| CLAIM-005 | Forcing remains smooth across required interval after full cancellation checks. | UNRESOLVED | audit/05_forcing_smoothness_test.md |
| CLAIM-006 | Pressure/support/elliptic compatibility constraints are all satisfied. | UNRESOLVED | audit/06_pressure_compatibility_test.md; audit/07_support_compatibility_test.md |
| CLAIM-007 | A rigorous contradiction has been established. | UNRESOLVED | audit/10_candidate_contradictions.md |
| CLAIM-008 | Priority components predate 2026-09-08 for specific repositories/commits. | PROVED_IN_REPOSITORY | Timestamped evidence in TIMELINE.md and evidence/commits.yaml |

Use `python/claim_status.py` to validate status assignments and reference requirements.

## Supplemental structural-priority claims (forensic taxonomy)

This supplemental YAML block uses a separate forensic taxonomy (`ESTABLISHED`, `SUPPORTED`, `NOT_ESTABLISHED`) and is descriptive only; `python/claim_status.py` validates only the `CLAIM-*` Markdown table rows above.

```yaml
claims:
  - id: priority-collapse-framework
    statement: >
      Fagliari documented a Navier-Stokes singularity/collapse framework
      by 25 November 2025.
    status: ESTABLISHED
    evidence:
      - repo: ShantiDraconis/millennium-navier-stokes-I
        commit: 63b248dd29f1817c457acdb00e116e2e9b0687cc

  - id: priority-blowup-profile-strategy
    statement: >
      By 4 December 2025, Fagliari's archive explicitly formulated
      smooth compact divergence-free data, finite-time singularity,
      and construction of self-similar or asymptotically self-similar
      blow-up profiles as a Navier-Stokes research path.
    status: ESTABLISHED
    evidence:
      - repo: ShantiDraconis/Millennium
        file: problems/NavierStokes/local-global-bridge.md
        date: 2025-12-04T18:43:53Z

  - id: priority-critical-profile-framework
    statement: >
      Before 8 September 2026 the archive contained critical-L3,
      profile-decomposition, critical-element and machine-auditable
      Navier-Stokes analysis.
    status: ESTABLISHED

  - id: structural-overlap
    statement: >
      There is substantial structural overlap between the prior Fagliari
      program and later finite-time breakdown research at the level of
      scaling, concentration, blow-up profiles, forcing, criticality,
      and formal verification.
    status: SUPPORTED

  - id: coupling-operator-priority
    statement: >
      Fagliari possessed a formal coupling operator K(R,d) converting
      (residual magnitude, current observable state) to a dynamical
      correction, formalised in CouplingOperator.lean, by 2025-12-19.
    status: ESTABLISHED
    evidence:
      - repo: ShantiDraconis/universal-emergent-logic-
        commit: f7f414d2ea66fa7a04d4de390f0e9357dfd980ae
        date: 2025-12-19T13:56:01Z
        tier: 2_reported

  - id: reference-section-priority
    statement: >
      Fagliari possessed a reference section c₀ with R(c₀)=0 in a NS
      geometric decomposition document, by 2025-12-19.
    status: ESTABLISHED
    evidence:
      - repo: ShantiDraconis/universal-emergent-logic-
        commit: 730aa849b0d76b0202f08b490664aa11c164b2bf
        date: 2025-12-19T17:17:28Z
        tier: 2_reported

  - id: critical-jets-priority
    statement: >
      Fagliari documented "microlocal analysis of critical jets" in
      LRE_NS_SUMMARY.md by 2025-12-18.
    status: ESTABLISHED
    evidence:
      - repo: ShantiDraconis/Millennium
        commit: 4cdb6a61ae7a9189eab551b1099895578a8fbb56
        date: 2025-12-18T21:07:43Z
        tier: 2_reported

  - id: additive-hf-perturbation-priority
    statement: >
      Fagliari documented the additive high-frequency perturbation schema
      φ_new = φ + εv with P_Λ(v)=0 in a NS proof architecture document
      by 2025-12-19.
    status: ESTABLISHED
    evidence:
      - repo: ShantiDraconis/universal-emergent-logic-
        commit: 2854eaf70a4cf91cef3b936304ae080ec69f4fb1
        date: 2025-12-19T20:24:44Z
        tier: 2_reported

  - id: reference-jet-priority
    statement: >
      Fagliari possessed a unified reference-jet + carrier-jet structure
      equivalent to the later OpenAI ReferenceJetBounds/ActualCurrentCarrierJets
      construction before September 2026.
    status: NOT_ESTABLISHED
    note: >
      Reference section c₀ and critical jets exist as separate precursors;
      they are not yet unified into a single formal jet structure.

  - id: causal-derivation
    statement: >
      The later OpenAI construction was derived from Fagliari's work.
    status: NOT_ESTABLISHED
```
