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
