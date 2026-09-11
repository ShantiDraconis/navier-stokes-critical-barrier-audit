# 24 — Claim / Evidence Matrix

This matrix prevents a source claim, a mathematical theorem, a numerical observation, and a provenance fact from being conflated.

| ID | Claim | Evidence | Status | What would upgrade it |
|---|---|---|---|---|
| C-PROV-001 | NS-specific repository work existed by Nov 2025 | `millennium-navier-stokes-I`, SHA `64bc633ecdb3a90ccfbf1c0863963c4bdd238d0f`; later verified anchor `63b248dd29f1817c457acdb00e116e2e9b0687cc` | `PROVENANCE_SUPPORTED`; earliest object still marked pending independent export in existing ledger | complete reachable-history enumeration + commit/tree/blob capture |
| C-PROV-002 | Classical/multiprover NS formalization existed Nov 2025 | `millennium-navier-stokes-classical`, `cca881c665f67c67d96a4f84371fb51cd9c858a0`, merge `dc55830546d50d66ccf602250c16c5c366dd4a30` | `PROVENANCE_SUPPORTED` | compile exact historical tree with pinned toolchains |
| C-PROV-003 | Projection/residual NS framework existed Dec 2025 | `Millennium` cluster beginning `4af517e3f1ea5d04be1c6bbd8953209fa2139e82` | `PROVENANCE_SUPPORTED` | per-file blob inventory and immutable links |
| C-PROV-004 | Residual/coupling architecture existed Dec 2025 | `universal-emergent-logic-` Dec 19–20 cluster | `PROVENANCE_SUPPORTED` | exact symbol-level history for each operator |
| C-ERR-001 | Canonical weighted error decomposition was committed | UEL commit `f7b51f6ac1cc95d357888aa60e4eeeaea24a49cf`, tree `1dab403b7f0ad3307100ee76373807bf1a2a3011`, blob `18d095e75c115bb94a139bda65396b7d77759355` | `L5_GIT_OBJECT` | already strong provenance; SHA-256 raw bytes still desirable |
| C-ERR-002 | Weighted contribution percentages sum to 100% | definition plus `proofs/audit_bridge_lemmas.md` | `MATHEMATICALLY_PROVED_FROM_DEFINITION` | formal proof assistant version optional |
| C-ERR-003 | The chosen percentages are canonical/objective properties of Millennium problems | source explicitly says decomposition depends on error function/gaps | `NOT_ESTABLISHED` | independent theorem identifying unique invariant decomposition |
| C-ERR-004 | Sensitivity-based decomposition exists | UEL commit `08d468c32fd0ba600488887b4c325d6f1b4222dc` | `L5_GIT_OBJECT` | exact file/blob SHA + raw SHA-256 |
| C-ERR-005 | Sensitivity contributions normalize | definition plus bridge lemma | `MATHEMATICALLY_PROVED_FROM_DEFINITION` | formal proof assistant version optional |
| C-ERR-006 | Structural-weight and sensitivity models are equivalent | no general equivalence theorem currently established | `UNRESOLVED` | prove assumptions under which both scalarizations coincide |
| C-COORD-001 | Error-coordinate model exists | `Millennium` commit `bfc4cf5b804bc58348efe930651512bc079c33d4`, tree `af84c91442c181e6cf55dc6a54bfc1fd5af3a2e5`, blob `236e9875e3d93a70c8fe6676ff7b5a5c73a966aa` | `L5_GIT_OBJECT` | raw SHA-256 desirable |
| C-COORD-002 | `||ε||₂ = 0` iff every coordinate vanishes | elementary Euclidean lemma | `MATHEMATICALLY_PROVED` | formal proof assistant version optional |
| C-COORD-003 | `||ε(P)||` is a canonical mathematical distance to proof | interpretation internal to declared model | `NOT_ESTABLISHED` | metric/invariant theorem plus equivalence to classical theorem state |
| C-COORD-004 | Norm-based progress increases under norm contraction | bridge lemma + executable test | `MATHEMATICALLY_PROVED_AND_TESTED` | none for internal functional |
| C-NS-001 | Current UEL contains `ε_NS = ||(u·∇)u||₂/(ν||Δu||₂)` | current default-branch search result | `SOURCE_VERIFIED_CURRENT_BRANCH` | identify earliest commit/blob and audit domain/zero-denominator cases |
| C-NS-002 | Universal threshold `ε_NS ≤ 0.65 ± 0.05` proves regularity | source associates threshold, but universal theorem not established | `OPEN_BRIDGE` | rigorous PDE theorem with explicit hypotheses and all constants derived |
| C-PHASE-001 | Whole-period mean of a pure non-zero Fourier mode is zero | analytic bridge lemma | `MATHEMATICALLY_PROVED` | none for this narrow statement |
| C-PHASE-002 | Arbitrary imaginary/phase error can be removed by averaging | not implied by Fourier-mode lemma | `NOT_ESTABLISHED` | decomposition theorem + integrability/periodicity/control assumptions |
| C-PHASE-003 | Phase cancellation implies NS global regularity | no classical bridge theorem established | `OPEN_BRIDGE` | derive a recognized regularity criterion, e.g. bounded critical norm |
| C-ESS-001 | bounded `L∞_t L³_x` excludes finite-time singularity under ESS hypotheses | classical theorem represented in audit | `CLASSICAL_DEPENDENCY` | exact bibliographic theorem/hypotheses mapping |
| C-ESS-002 | finite-time blow-up implies critical L3 loss in the appropriate formulation | derived contrapositive/endpoint alternative under classical hypotheses | `DERIVED_FROM_CLASSICAL` | formalize exact solution class and time endpoint |
| C-FORMAL-001 | every formal file in the account is complete | account-wide scan found explicit `sorry`/`Admitted`/placeholder material | `FALSE_AS_BLANKET_CLAIM` | per-repository theorem inventory instead of blanket statement |
| C-FORMAL-002 | some repositories claim no-sorry completion | README/policy evidence exists | `SOURCE_CLAIM_REQUIRES_COMPILATION` | historical checkout + compiler/kernel success + placeholder scan |
| C-EXT-001 | prior work structurally overlaps later external NS program | `evidence/forensic_first_occurrence.csv`, STATUS and comparison dossiers | `SUPPORTED_AT_PROGRAMMATIC_LEVEL` | exact construction-level correspondences |
| C-EXT-002 | external work was causally derived from prior repositories | no access/causal evidence established | `NOT_ESTABLISHED` | independent evidence of access and derivation |
| C-PRIORITY-001 | Git chronology proves worldwide mathematical priority | Git establishes repository chronology only | `NOT_ESTABLISHED` | broader publication/prior-art search + precise claim identity |
| C-ZENODO-001 | Zenodo record 22180836 exactly archives a specific Git tree | record identified, byte mapping incomplete | `OPEN` | Zenodo metadata/files/checksums + byte-level Git comparison |
| C-CI-001 | audit invariant CI passed on 2026-09-11 | Actions run `34636992823`, head `cdbe509ed011584484cfaa4085b9e46f3bf5a23c`, conclusion `success` | `EXECUTION_VERIFIED` | subsequent runs remain separate evidence |

## Rule

No row may be upgraded from `SOURCE_CLAIM`, `COMPUTATIONAL_EVIDENCE`, `OPEN_BRIDGE`, or `NOT_ESTABLISHED` to `PROVED` merely because another document repeats the claim.
