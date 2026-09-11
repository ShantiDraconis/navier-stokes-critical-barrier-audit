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

  # ── LRE-specific forensic claims (added from 42-item inventory) ───────────

  - id: lre-spectral-projection-residual
    statement: >
      By 19 December 2025, the LRE framework documented spectral projection
      π(u) = P_N u, high-frequency residual R(u) = ‖u − P_N u‖², and the
      resolved/unresolved advection expansion.
    status: ESTABLISHED
    evidence:
      - repo: ShantiDraconis/navier-stokes-critical-barrier-audit
        commit: 730aa849b0d76b0202f08b490664aa11c164b2bf
        date: 2025-12-19
        file: docs/lre-navier-stokes-geometric.md

  - id: lre-closure-obstruction
    statement: >
      By 19 December 2025, the LRE framework explicitly recorded the closure
      obstruction P_N[(u·∇)u] ≠ (P_N u)·∇(P_N u).
    status: ESTABLISHED
    evidence:
      - repo: ShantiDraconis/navier-stokes-critical-barrier-audit
        commit: f30ef6a9d19af290a8f461d60d70da091d73d6ed
        date: 2025-12-19T17:22:45Z
        file: docs/lre-navier-stokes-geometric.md

  - id: lre-residual-coupling-operator
    statement: >
      By 19 December 2025, the LRE framework had an explicit residual coupling
      operator T(u_N, u_⊥) = −P_N[(u_⊥·∇)u_N + (u_N·∇)u_⊥ + (u_⊥·∇)u_⊥].
    status: ESTABLISHED
    evidence:
      - repo: ShantiDraconis/navier-stokes-critical-barrier-audit
        commit: 730aa849b0d76b0202f08b490664aa11c164b2bf
        date: 2025-12-19

  - id: lre-projected-dynamics-equation
    statement: >
      By 19 December 2025, the LRE framework had documented the projected
      dynamics d/dt π(u) = F(π(u)) + K(R(u), π(u)) and a formally
      non-factorizable CouplingOperator K.
    status: ESTABLISHED
    evidence:
      - repo: ShantiDraconis/navier-stokes-critical-barrier-audit
        commit: 14322ff2e8f38df302c6f2f6b41754db79d5a900
        pr: 37
        date: 2025-12-19

  - id: lre-reynolds-stress-residual-coupling
    statement: >
      By 19 December 2025, multiple independent files in the LRE archive
      explicitly equated Reynolds stress with residual coupling K(R, ·).
    status: ESTABLISHED
    evidence:
      - file: formalization/lean/LRE/SUMMARY.md
      - file: formalization/lean/LRE/QUICKSTART.md
      - file: README_COMPLETE.md
      - file: Examples/NavierStokesLRE.lean

  - id: lre-critical-jets-microlocal
    statement: >
      By 18 December 2025, the LRE archive documented microlocal analysis of
      critical jets and the chain critical cascade → spectral concentration →
      self-similar blow-up profile → critical jets.
    status: ESTABLISHED
    evidence:
      - file: Millennium/LRE_NS_SUMMARY.md
      - commits:
          - 4af517e3f1ea5d04be1c6bbd8953209fa2139e82
          - 5a888677611ec79eb959f368e941699217487c2d

  - id: lre-projection-obstruction-pr249
    statement: >
      By 18 December 2025, the LRE archive documented the projection-obstruction
      framework C(u) = (ι∘π)(u), Res(u) = u − C(u) in Millennium PR #249.
    status: ESTABLISHED
    evidence:
      - repo: ShantiDraconis/Millennium
        pr: 249
        merge_commit: 6054851e80b463b3c994fef2acc110983769c309
        date: 2025-12-18

  - id: lre-residual-stability-inequality-ns
    statement: >
      By 19 December 2025, the LRE archive documented the NS-specific residual
      stability inequality dR_Λ/dt ≥ κ(t)R_Λ − νΛ²R_Λ − CR_Λ².
    status: ESTABLISHED
    evidence:
      - commits:
          - 1ed0ded98d26966189fc5936914fd964d42cbd7a
          - 0f3ae4e275068f81f516b45b14289dd1a699e659
          - 4cb3cd8ae5d24d5b79825346fb59ed47ff95bc9f
          - abdaa41189864f85d3b9f8c8fec6b3ec4431eab5
          - 3d4d3e51866e03420e97ff3b21dde2a1fca1cc4d

  - id: lre-ehresmann-curvature
    statement: >
      By 19 December 2025, the LRE archive documented a fiber-bundle / Ehresmann
      connection interpretation of the residual, with CouplingCurvature.lean and
      topological blow-up theory in NavierStokes.lean.
    status: ESTABLISHED
    evidence:
      - commits:
          - 92ae80cf78bf7d94c78795ea0929dc73cd145a97
          - 14322ff2e8f38df302c6f2f6b41754db79d5a900
          - ce960a1ba8ce7a893d645131d12d1a7ab06eddd9

  - id: lre-iterative-correction-ns
    statement: >
      Fagliari's archive contained an iterative NS correction scheme equivalent
      to u^{(n+1)} = u^{(n)} + C_n with explicit residual update.
    status: NOT_ESTABLISHED

  - id: lre-stress-correction-hierarchy
    statement: >
      Fagliari's archive contained a stress correction hierarchy S_n → C_n → S_{n+1}
      or ∇·S = R equivalent to OpenAI's correction state machinery.
    status: NOT_ESTABLISHED

  - id: lre-engineered-forcing-cancellation
    statement: >
      Fagliari's archive contained an engineered forcing f := −R explicitly
      constructed to cancel the residual.
    status: NOT_ESTABLISHED
```
