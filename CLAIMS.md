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

  - id: reference-jet-priority
    statement: >
      Fagliari possessed an equivalent of the later reference-jet
      construction before September 2026.
    status: NOT_ESTABLISHED

  - id: causal-derivation
    statement: >
      The later OpenAI construction was derived from Fagliari's work.
    status: NOT_ESTABLISHED
```

