# 20 — Cross-Repository Formal Corpus Commit Sweep

## Purpose

This ledger records high-value commits recovered from the connected `ShantiDraconis` GitHub corpus during a cross-repository sweep for formal proof development, proof skeletons, axioms, placeholders, `I = 0/0`, Millennium-problem bridges, and multi-prover implementations.

The search covered commit-message terms including `formal`, `proof`, plus code-level searches for `theorem`, `axiom`, `sorry`, `admit`, `Admitted`, `postulate`, `I = 0/0`, `NaN`, `Null`, and related formalization markers.

## Important limitation

GitHub search endpoints cap result sets and code search primarily indexes current/default-branch content. Therefore this document is a **deep recovered commit ledger**, not a mathematical assertion that no additional historical objects exist. An exhaustive tree/ref scanner is added separately in `tools/scan_formal_history.py` so the corpus can be enumerated reproducibly without exposing secrets.

Proof-status labels used here:

- `ORIGIN` — provenance/root or infrastructure marker.
- `SKELETON` — statements/architecture exist, but proof gaps remain.
- `AXIOMATIC` — result depends on explicit added axioms/postulates.
- `FORMAL_CLAIM` — commit claims a proof/formalization; kernel validity still requires dependency/build audit.
- `INTERNAL_PROOF_CANDIDATE` — source inspection found an actual proof body for a substantive theorem; still requires build/dependency audit.
- `OPEN_GAP` — source/commit explicitly identifies a missing theorem/bridge.
- `MULTIPROVER` — same research object implemented in multiple assistants.

---

## 1. Earliest recovered formal/multiprover infrastructure

### 2025-11-23

- `010458449724a48086f38214150e8fc115ce63c5` — `ShantiDraconis/proofs-multiprover` — **Add complete multi-prover formal verification infrastructure**. `ORIGIN / MULTIPROVER`.

### 2025-11-24

- `df249e761c6b3d326bbd1846805ea1185223b369` — `proofs-multiprover` — expands `Basic.lean`; commit text explicitly says some complex proofs are marked `admit`. `SKELETON / GAP_EXPLICIT`.

This is important negative evidence: formal infrastructure predates several Millennium repositories, but incompleteness was explicitly acknowledged.

---

## 2. Riemann / I-framework — early proof architecture

### 2025-11-25

- `12a65e11b53d336b389b47e8fb85c0e75caaf762` — `millennium-riemann-I` — **Improve documentation on incomplete proofs**. `OPEN_GAP`.
- `5b283aa3ff5eac132f8b8dd5b8b3827633ced9a8` — `millennium-riemann-I` — expanded proof structure with `src/Riemann` modules. `SKELETON`.
- `9c1132fda6834f43c64a236dc6626e8f5cd5492b` — `millennium-riemann-I` — TODO comments for incomplete proofs and symbolic-notation clarification. `OPEN_GAP`.
- `46982675efee59e50f72a1288baafbd7ed53b75e` — `millennium-riemann-I` — Two-Phase Theorem framework with formal axioms/geometric theory. `AXIOMATIC`.
- `cfd8082b26d61b0061745942180c6d81c6651461` — `millennium-riemann-I` — numerical-class rules based on proof refutation. `META_FORMAL`.
- `661ba6fd06dda8ff2bbb392de687b8a96a7ce521` — `millennium-riemann-I` — Riemann regularization operator and proof structure. `SKELETON`.
- `d4e57156d12a4aa0ea839835aacd39d2cb3008e8` — `millennium-riemann-I` — numerical classes / proof-refutation line. `SKELETON / META`.

### Later RH classical anchors

- `5db1a345af289e56c4a85dd1534d796689d5edc9` — `millennium-riemann-classical` — theorem documentation plus Lean/Coq/Isabelle/Agda tail-behavior modules. `MULTIPROVER`.
- `477a8d2b71e951619c830129909c03ce7a9ff615` — 2025-12-01 — explicitly names **Rigidity Conjecture (Theorem 4.1) — the final gap for RH proof**. `OPEN_GAP`.
- `ed8fb04913729d16758b276cabe30a46bf029003` — 2025-12-12 — `LC_RH_Proof` blueprint. `SKELETON`.
- `a54ef33d82dee446ca081195015b8b38dd0d84ed` — proof architecture blueprint. `SKELETON`.
- `53022c67aa0374e8ed809133bb72255aa0fb3fcf` — missing arithmetic sampling layer / formal stubs. `OPEN_GAP`.
- `2bcf5cf88be20a533ed500ce86f9b35510477829` — coercivity threshold scaffolding. `SKELETON`.
- `65365e27f4f856a7f4b721ae4285aea345d17993` — stability/coercivity theorem documentation. `FORMAL_CLAIM`.
- `d7f5a314f71d353c7dced021d1dbd8af30261958` and `938a86f668c21aa979bbcfa5adc265628ef89bdb` — uniform/coercivity target pathways. `OPEN_BRIDGE / SKELETON`.
- `f169a3c5955b18eb62e0be98ae52c4bcd59efaa4` — merge branch named final-proof, but commit message again identifies the Rigidity Conjecture as the final gap. `OPEN_GAP`.

These commits prevent a defensible audit from treating every repository-level “proof” label as a completed RH proof.

---

## 3. `I = 0/0` formal foundations

### 2025-11-25

- `78083d5ae2924a46a67562c2551de39a06718143` — `0-0-FORMAL-SUITE` — formal foundations for symbolic constant `I` as an abstract element with defined axioms. `AXIOMATIC / FOUNDATIONAL`.
- `b219dc7f0e5ad36eb7f590bbccd4a28de0aebd41` — complete formal-suite structure with Lean modules/tests/docs/LaTeX/CI. `MULTIPROVER_INFRA`.
- `c8e0e6a0ae1fef1726353d8b661e9d08888b812c` — merge of comprehensive Lean formalization. `FORMAL_CLAIM`.
- `2c52c5e221a7cb55cd3c5d0b55399e97ad2e9262` — `Universe-0-0` — operators, axioms, classes, formal language, prover libraries. `FOUNDATIONAL / AXIOMATIC`.

### 2025-12

- `0a05801f649dd80a78f9e7fbf4d848ee59af51db` — `Meta-mathematical-foundation-00` — formal numerical classes in LaTeX + Lean 4. `META_FORMAL`.
- `6cfbc85e30a39492cf1ecff6eb2b2759cd587756` — `Universe-0-0` — formal mathematical lineage and axiom systems. `FOUNDATIONAL`.
- `8afc7b9151d97e890074dde61c322e164e2f8bd6` — formal impossibility theorems for `0/0` and totalized algebra. `FORMAL_CLAIM`.
- `976754b081d72b7f5516904b441846e4b5eec796` — formal impossibility/construction theorems for `I = 0/0`. `FORMAL_CLAIM`.
- `216a4d62ee0696e1096ed2f75a86d9f46460debf` — foundational impossibility proof for `I=0/0`. `FORMAL_CLAIM`.

### 2026-01 meta-gap formalism

- `3a212951fbc740c59aecacdeae4c3aca1ac155d6` — `Universe-0-0` — Sorry Singularity Axiom / Lean4 formalization.
- `da863af1f988902aab6bb175954ba2b2ead5015b` — validation / manifesto integration.
- `720c79403b4fa30a3a6aba26ba1c2179074fc448` — formal-axiom integration.
- `184613fa824b54cd58bf5ecf2cb3526a4ccd116e` — merge explicitly labeled `sorry = 0/0 = I`.
- `064bc172598e9a2545abaedd4553bb7232234152` — `Singulariity` — comprehensive unification formalization; source inspection shows several bridges are declared `axiom`. `META_FORMAL / AXIOMATIC`.
- `28b39a332b5cc40a0949701445d9b59b424736d1` — multi-language singularity formalization in Coq/Lean/Agda/Isabelle/Python. `MULTIPROVER / AXIOMATIC`.

For a standard-foundation audit these must be represented as **meta-level tags or explicit extension axioms**, not silently converted into classical equalities.

---

## 4. Navier–Stokes formal genealogy

### 2025-11-23/25

- `d4a3a745269c10a15c12d2b854cac7c3553d243d` — `millennium-navier-stokes-I` root origin.
- `64bc633ecdb3a90ccfbf1c0863963c4bdd238d0f` — first substantive analytical/computational NS framework.
- `f1c920dfe7e7d42f4c40417e0c0c0fb8b8c43670` — formal mathematical foundations / related work.
- `777d58e6f1eda3872a809492183ce432ead4f030` — I-collapse LaTeX framework.
- `c8489c74b179c5829ce14a48ef95158610e338b2` — energy inequalities, `Φ_NS`, two-phase theorem and formalization; conditional architecture.
- `5eee6ce82dda31852cd52db61104c42433ec7ae4` — `millennium-navier-stokes-classical` energy/regularity Lean skeleton with `True`/`sorry` placeholders.
- `9b7b16c97a98c5b378deb43571ef89bd57e20765` — Clay theorem statement on `T³`. `STATEMENT`.
- `1ae8b318d9c8ab9ebfb59b8719f91c29ca86ac70` — replaces `sorry` with axioms/proofs; must distinguish actual proofs from declarations promoted to axioms. `MIXED / AXIOMATIC`.
- `53c91d97c2ace924b4436825f3a53aa67ab87ad7` — I-extended functional spaces, docs/formal proofs/Python. `FORMAL_CLAIM`.
- `33adee1cd0759e386a9b7d6abbd5b1c0b6fedb05` — energy non-negativity Lean proof fix. `INTERNAL_PROOF_CANDIDATE`.

### 2025-12 projection/residual line

Representative anchors:

- `4af517e3f1ea5d04be1c6bbd8953209fa2139e82` — NS projection-obstruction.
- `b9b4768206ee3d817cbbaf35bb7da92dc835c4e1` — formal closure documentation.
- `a992d144c235572ac2b7413b015e58535a864a41` — LRE-NS closure framework.
- `0f17dc7b673ea8208796763099f576ea59420b7e` — energy projection cannot control critical residual.
- `6054851e80b463b3c994fef2acc110983769c309` — LRE projection-obstruction Clay dossier.
- `730aa849b0d76b0202f08b490664aa11c164b2bf` — quantitative obstruction + NS geometric decomposition; own source acknowledges remaining hard analytic steps / sorries.
- `a762e7b76464656236075548343f596ab8bc6815` — generic quantitative obstruction theorem; main abstract theorem has an explicit proof body under coupling hypothesis. `INTERNAL_PROOF_CANDIDATE`.
- `abdaa41189864f85d3b9f8c8fec6b3ec4431eab5`, `469910d3a18d6a2891525da5f1a1a3dd6ec00799` — residual-stability framework/formalization; NS-specific evolution statements retain gaps/placeholders. `SKELETON / OPEN_ANALYTIC_BRIDGE`.

See `audit/16_related_commit_derivations.md` and `audit/17_deep_proof_origin_integral_sweep.md` for theorem-level analysis.

---

## 5. P vs NP

- `2cc08bee0675c5a5bb848102f26ccfee67a3d24e` — 2025-11-25 — `millennium-p-vs-np-classical` formal folder with Lean4/Coq/Isabelle foundations. `MULTIPROVER / SKELETON`.
- `7ed50eaefc22387bb02fec13f47cc3ebbfeaa71d` — classical framework, scenarios and proof approaches. `PROGRAMMATIC`.
- `fe058d97001390c2b7b296bba900a37b08bb29bb` — merged classical proof-approach architecture.
- `1985425a40891ab1251a837aa9cca7a4efeb5a48` — cleanup + axiom documentation. `AXIOM_AUDIT`.
- `bdea7e9ea9c58ca8f142ebca14aece5ce0938816` — 2026-01 — `Singulariity` Lean 3 P-vs-NP singular-solution structure. `META_FORMAL_CLAIM`.

Cross-problem Delta/Gap commits in `Millennium` beginning 2025-12-02 also connect RH/P-vs-NP; they require theorem-level validity review rather than acceptance from commit titles.

---

## 6. Yang–Mills

- `53eeb8e943575e9b80fc471aa531f51163c9a7d9` — 2025-11-25 — classical math-core/docs.
- `fb8a373bd874a3e7c3f12e3e945bdf6d6984fabf` — formal proofs in Lean/Coq/Isabelle/Agda + LaTeX. `MULTIPROVER / FORMAL_CLAIM`.
- `fb9a42229479ed8b38199204a9d98fa7b14c6e05` — Lean 4 mass-gap proof structure. `SKELETON` unless dependency audit proves otherwise.
- `719b073d9f8597698aaa2a9f372be4bf0fd0c790` — formal structures in Coq/Isabelle/Agda. `MULTIPROVER`.
- `7b666ef530e3e6d4abc0021dff9758db53f3f5f4` — merged classical repository structure.

---

## 7. Birch–Swinnerton-Dyer

- `f6d70a94e4dc4bd302c1a4c4fe2bd68af26c7115` — 2025-11-25 — Iwasawa/BSD conjecture docs, proof architecture, formalization plans, bridge modules. `SKELETON / ARCHITECTURE`.
- `569757e3f2e250d964a56203cff342aabe639255` — theorem naming/proof-structure/documentation fixes. `REFINEMENT`.
- `8bdbd66e4cb0736156b4248e3a03b46a36b27643` — 2025-12-13 `Millennium` Clay-format proof structure including BSD article. `FORMAL_CLAIM / REQUIRES_AUDIT`.

---

## 8. Hodge / Poincaré / unified seven-problem structures

- `10fef561022709f9b15c190ac0dee9c69fa66327` — 2025-12-04 `Millennium` — unified Clay-compatible proof structures for all seven problems. `SKELETON / UNIFIED`.
- `921584dea250e67e08a93e48df1f65345784730e` — Local-Global Hypothesis across proof assistants. `MULTIPROVER / CONDITIONAL`.
- `754a81fbf95540b01450e0a28563ee10d4e64e05` — explicitly fixes incomplete proofs in `VectorDelta.v` and `Poincare.v`. `GAP_REPAIR`.
- `4369ad039780bcd6aa7db448a5a104993de9bd4f` — Clay-format LaTeX documents for all problems. `PAPER_LAYER`.

Dedicated repositories such as `millennium-hodge`, `millennium-hodge-classical`, `millennium-poincare-classical`, `millennium-bsd`, and related symbolic repositories are included in the exhaustive scanner allowlist stage; commit-message search alone is insufficient to certify every theorem within them.

---

## 9. `Millennium` unified formal program

Major recovered anchors include:

- `5491d87be7d1feb9f81395fa9a2467399ff5292f` — Delta-Gap RH/P-NP framework with 44 formal components.
- `b78dcf98f8aee768a4194ce95134d1bbb169f060` — formal DeltaRH / DeltaNP operator framework.
- `1335f1e21811f62f15e12f8b6d8649e0bc16d694` — Riemann zeros-primes equivalence formal systems.
- `1eb487a0d6d766974b3b63577f41e37d018cc7c4` — state-space framework for Millennium problems.
- `116354aee42777aeb98c3bb2bbc149c1f232d94a` — complete Delta Unified framework claim.
- `9168dbd30549495bbd45c2c0637102984af70fec` — Classical Invariance theorem/proof.
- `4be86e41bef0179a1f9ac63f365dbb47d94365e8` — Classical Invariance merge.
- `cbf317d13911d4934f96a24e4db51e0b6124366a` — Structural Fragmentation Theorem formal logic.
- `2ae05ad625f84e8db75d5c8b5d98ac5e24e82819` — Structural Insufficiency in LaTeX/Lean/Coq.
- `cbb25d18c58358f673f86f685f9baafef7f8af54` — structural-refutation framework for all seven.
- `29ba39a02c606ace8c6599b1eedef06631d83d57` — Lean4/Coq/Isabelle Delta modules.
- `a1091bb4f197d47b9f98d61d8e3a6df265f322bd` — main delta-collapse formalization + unified paper.
- `21467da90c8332a51bbb0b285eae6360b336c350` — TUNS formalization across proof assistants/tests.
- `a1edc9fd73eaa2e354fc425c6b882b273468fda9` — TUNS multi-prover verifications.
- `25f2ce9ee1e6af10cfb1fb9f7d8472453c181cea` — RH/NS bridge theorem skeletons.
- `3de430884e08403d389e461448d7ebf5fc39d3ea` — Lean Clay-format bridge theorems.
- `64ba1e977181ab540ee2aecc07dcc8f8bf1adf7b` — Clay-compatible bridge theorem proof structures.
- `8605c750ad904387b8a4a457663ce5849bad3d59` — TUNS 9 emergent objects across four proof assistants.
- `57fa17d67f00ad479f0426256158a7d3ab342a8b` — explicitly documents deferred `bridge_transfer` proof. `OPEN_GAP`.

Audit rule: commit messages such as “complete”, “proof”, or “formal” are provenance evidence only. Certification requires the historical source, build result, declaration dependency set, and absence of unacknowledged placeholders/axioms.

---

## 10. `Universe-0-0` RH claim lineage

Recovered commits include:

- `bca6aad29423cb337ca1c1565e855a0b2d2f664f` — 2025-12-09 — commit claims formal I-framework proof of RH.
- `c88f630c3d89db1cf87a0a9d5ac75a6a36b3af56` — proof announcement/integration.
- `3224b214ca4f17570995ed5f3033c15d5980da70` — comprehensive RH proof structure Lean/Coq/LaTeX.
- `feb13b075933127e76fcb9a7effd0067ea9598f0` — implementation documentation.
- `ef742c887786ef850cb8eadac5cd1b2fd6bb94d3` — comprehensive RH framework via I-constant.
- `e2944c04d57ceb208377b749c4434cfb32ddac3e` — formal proof via I-framework contradiction claim.

**Status:** `FORMAL_CLAIM / AXIOM-DEPENDENCY_AUDIT_REQUIRED`.

These commits should not be labeled as a classical RH proof solely from titles. The audit must reconstruct their theorem dependencies and distinguish standard results from I-framework axioms.

---

## 11. Other formal infrastructure with direct relevance

- `fbd43126fb6865793f80c08ea08f590cfd05560f` / `57dbb6238c0646ed7104415211b49704fe29d2b2` — `universal-proof-hub`, multi-assistant architecture.
- `a91f9327eba96ac90ba4de1f980988fd299e4d32` — `unified-classical-foundations`, Coq/Lean4/Isabelle/Python completion claim.
- `815be0024bf0e393330eb6a44f1d00123de43fdd`, `82942acc90ac71f2271a8f1129f47a797b014f3e` — `universal`, expanded Lean proofs in Hilbert spaces, differentiability and Baire category.
- `84db352cf00444004b363e2d07f7f0803a3a4388` — `universal-emergent-logic-`, master proof skeleton.
- `319e680a5dd213c797841c5de3b2dfa0ad3e77ba` — HEU scaffold with Lean stubs/CI. `SKELETON`.

These are potential dependency ancestors and must be included when reconstructing theorem provenance across repositories.

---

## 12. Repository families discovered for exhaustive traversal

The connected corpus contains many problem-specific and unified repositories, including families for:

- Navier–Stokes (`millennium-navier-stokes-I`, `millennium-navier-stokes-classical`, `millennium-regularity-I`, audit repos);
- Riemann (`millennium-riemann-I`, `millennium-riemann-classical`, `lc-rh-coercivity`, `emergent-identity-rh`);
- P vs NP (`millennium-p-vs-np-I`, `millennium-p-vs-np-classical`);
- Yang–Mills (`millennium-yang-mills`, `millennium-yang-mills-classical`, `millennium-mass-gap-I`);
- Hodge (`millennium-hodge`, `millennium-hodge-classical`);
- BSD (`millennium-bsd`, `millennium-birch-swinnerton-dyer-classical`);
- Poincaré (`millennium-poincare-classical`, `millennium-poincare-symbolic`);
- unified/meta (`Millennium`, `Universe-0-0`, `0-0-FORMAL-SUITE`, `universal`, `universal-proof-hub`, `universal-emergent-logic-`, `Meta-mathematical-foundation-00`, `Heu-7-universal-framework`, `millennium-classical-parameters`).

Private repository contents must not be copied into the public audit unless independently designated for release. The scanner defaults to metadata-only/sanitized output.

---

## 13. What remains to certify each commit

For every commit above, the theorem-level DAG must eventually store:

```text
repository
commit_sha
parent_sha(s)
author_date
committer_date
tree_sha
verification_status
file_path
blob_sha
language
declaration_name
declaration_kind
normalized_statement
proof_body_present
sorry_count
admit_count
axiom_dependency_count
postulate_count
True_placeholder_count
build_status
print_axioms/dependency_report
first_seen_sha
last_changed_sha
derivation_parents
derivation_children
public_evidence_id
confidential_source_hash (optional; no raw secret content)
```

A node may only be marked `KERNEL_VERIFIED` when its historical source builds and the declaration dependency audit supports that label.

---

## 14. Current conclusion

The recovered corpus demonstrates a broad, timestamped formal-research program beginning no later than November 2025 and spanning multiple proof assistants and multiple Millennium problems. It also contains explicit evidence of placeholders, axioms, deferred bridges, and named final gaps. Therefore the strongest defensible public claim at this stage is **provenance of the research/formalization program plus theorem-specific verification where separately established**, not blanket certification that every commit titled “proof” contains a completed classical proof.
