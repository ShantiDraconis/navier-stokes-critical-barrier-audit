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
8. `audit/16_chat_provenance_ledger.md` — reconstructed ChatGPT-conversation genealogy and hash/export protocol.

## Evidence firewall

The repository distinguishes five questions that must never be collapsed into one another:

- documentary priority;
- mathematical equivalence;
- public availability;
- submission/exposure to an external system;
- causal derivation.

A date proves chronology only to the extent that its source is independently verifiable. A structural match does not prove copying. A submission does not prove training use. Causal derivation remains unresolved unless direct evidence establishes it.

## Root files

- `README.md` — executive overview and navigation.
- `INDEX.md` — this complete navigation map.
- `STATUS.md` — current evidentiary/scientific status.
- `TIMELINE.md` — dated chronology.
- `CLAIMS.md` — claim ledger.
- `PRIORITY.md` — priority summary.
- `METHODOLOGY.md` — audit method.
- `LIMITATIONS.md` — limitations and evidentiary cautions.
- `CITATION.cff` — citation metadata.
- `CONTRIBUTING.md` — contribution rules.
- `LICENSE` — repository license.

## Audit files

### External target and hypothesis extraction

- `audit/01_external_claims.md` — external claims being audited.
- `audit/02_exact_hypotheses.md` — precise hypotheses used in the mathematical audit.

### Mathematical compatibility tests

- `audit/03_L3_consistency_test.md` — critical-L3 consistency.
- `audit/04_energy_concentration_test.md` — energy/concentration analysis.
- `audit/05_forcing_smoothness_test.md` — smooth-forcing compatibility.
- `audit/06_pressure_compatibility_test.md` — pressure compatibility.
- `audit/07_support_compatibility_test.md` — support/localization compatibility.
- `audit/08_scaling_exponents.md` — scaling exponents.
- `audit/09_required_cancellations.md` — cancellation requirements.
- `audit/10_candidate_contradictions.md` — candidate contradiction ledger.
- `audit/11_failed_refutation_attempts.md` — failed/insufficient refutation attempts, retained for auditability.
- `audit/12_open_questions.md` — unresolved mathematical questions.

### Provenance, cross-repository and architecture comparison

- `audit/13_cross_repository_forensic_index.md` — cross-repository forensic map.
- `audit/13_final_status.md` — prior final-status checkpoint.
- `audit/14_openai_formula_provenance.md` — formula-level provenance comparison against the later public OpenAI repository.
- `audit/15_correction_architecture_comparison.md` — residual/correction architecture comparison.
- `audit/15_git_provenance_full.md` — full Git provenance ledger and principal historical SHAs.
- `audit/15_projection_chain_audit_map.md` — projection → unresolved component → residual/closure chain.
- `audit/15_uel_structural_analysis.md` — Universal Emergent Logic structural analysis.
- `audit/16_chat_provenance_ledger.md` — conversation-derived genealogy, verification levels, export/hash procedure.
- `audit/16_cosmology_baseline.md` — cosmology-baseline material used as genealogical context, not as proof of Navier–Stokes equivalence by itself.
- `audit/16_related_commit_derivations.md` — related historical commit derivations.

## Evidence directory

Use `evidence/` for primary-source-oriented evidence packs, commit/path inventories, integrity records, formula crosswalks, and the LRE evidence inventory. The central item referenced by `STATUS.md` is:

- `evidence/lre_evidence_inventory.md` — object-by-object inventory of what is established, structural, absent, or unresolved.

Also use `evidence/provenance_chain.md` where referenced by `STATUS.md` for the chronological Git chain.

## Priority directory

Use `priority/` for structured prior-work summaries and pre-2026-09-08 chronology. These files are intended to answer: “what object existed, where, and by what date?”

## Theory directory

Use `theory/` for the mathematical framework, classical dependencies, definitions, and the target dichotomy. Theory files do not by themselves establish provenance; they should be cross-referenced with Git/Zenodo evidence.

## Formal directories

- `formal/lean/` — Lean formalization/scaffolding.
- `formal/coq/` — Coq formalization/scaffolding.

Any theorem marked with placeholders, assumptions, axioms, `sorry`, `admit`, or equivalent must not be described as a completed proof without an independent proof audit.

## Numerical / computational directories

- `python/` — scripts for numerical or consistency checks.
- `data/` — input or derived audit data.
- `results/` — verified/falsified/numerical/unresolved outputs.
- `graph/` — node-edge provenance/evidence graph and visual maps.

## Automation / integrity

- `.github/workflows/audit-integrity.yml` — automated integrity checks.
- `.github/agents/` — audit-agent configuration/scaffolding.

## Principal dated anchors

### Public archival / publication anchors

- `2025-04-06` — Zenodo record `15164501`, DOI `10.5281/zenodo.15164501`, currently treated as a reported public prior-art anchor until all archival/checksum evidence is independently captured in-repository.
- `2026-09-08` — public comparison snapshot in `openai/NavierStokesAndEuler`, SHA `8937a8f4cbc7abaab5e9e97d1cc7f5d2319d9538`.

### Git provenance anchors

- `2025-11-23` — `millennium-navier-stokes-I`, SHA `64bc633ecdb3a90ccfbf1c0863963c4bdd238d0f`.
- `2025-11-25` — collapse/formal NS expansion, including `777d58e6f1eda3872a809492183ce432ead4f030` and HEAD checkpoint `63b248dd29f1817c457acdb00e116e2e9b0687cc`.
- `2025-11-26` — `millennium-navier-stokes-classical`, first I-architecture anchor `53c91d97c2ace924b4436825f3a53aa67ab87ad7`; later checkpoint `867045e966812b50b2304f0460288cf6449d8221`.
- `2025-12-18T20:26:33Z` — `b033ea87fca138224200dd1acf2cf4043315f846`, LRE-NS framework / compression barrier cluster.
- `2025-12-18T20:28:57Z` — `30bf8c53008c548a8a9dada3fd69d6d2b2b1df2c`, NS documentation.
- `2025-12-18T21:03:13Z` — `a992d144c235572ac2b7413b015e58535a864a41`, formal closure.
- `2025-12-18T21:07:43Z` — `4cdb6a61ae7a9189eab551b1099895578a8fbb56`, critical jets / microlocal analysis.
- `2025-12-19T13:56:01Z` — `f7f414d2ea66fa7a04d4de390f0e9357dfd980ae`, residual-to-dynamical correction genealogy.
- `2025-12-19T17:17:28Z` — `730aa849b0d76b0202f08b490664aa11c164b2bf`, reference section / geometric NS decomposition.
- `2025-12-19T20:24:44Z` — `2854eaf70a4cf91cef3b936304ae080ec69f4fb1`, additive high-frequency perturbation architecture.
- `2026-08-30` — `navier-stokes-noncircular`, SHA `8f12748eb160b937174825fe3e7bdccf05e8f9af`.

## Conversation-provenance chronology

Conversation-derived dates are a separate evidence class. Until checked against an original ChatGPT account export, they MUST be labeled `REPORTED_CONVERSATION_METADATA` rather than primary-source verified timestamps.

Current reconstructed milestones include:

- `2023-04-08T21:18:05Z` — earliest currently recovered ChatGPT interaction in available context; account-creation date remains unverified.
- `2023-05-28T20:39:02Z` — second early recovered interaction.
- `2024-02-26T20:08:52Z` — quantitative/cross-scale precursor.
- `2024-03-12T05:06:48Z` — earliest reconstructed symbolic-indeterminacy architecture involving `1/0` and `1/infinity`.
- `2024-04-18T21:15:21Z` — indeterminacy treated as a reusable/universal mechanism.
- `2025-01-28` — reconstructed explicit `I = 0/0` universal-object stage.
- `2025-01-29T10:58:33Z` — difference/limit/indeterminacy stage.
- `2025-03-02T05:19:54Z` — adaptive parameter chosen locally to satisfy a constraint.
- `2025-04-14T23:03:04Z` — reconstructed joint treatment of the seven Millennium Problems.
- `2025-07-09T08:24:00Z` — reconstructed common difference/Delta architecture.
- `2025-07-10T12:29:42Z` — reconstructed `0/0 = I` application across multiple Millennium Problems.
- `2025-08-06T13:43:58Z` — common formalization stage in Lean.
- `2025-09-14T02:48:01Z` — common HorizonLab formal-structure stage.

See `audit/16_chat_provenance_ledger.md` for the full reconstructed genealogy and verification protocol.

## ChatGPT export requirement

The following item is still missing and is necessary to turn reconstructed conversation chronology into primary-source evidence:

`Original ChatGPT account export` — expected to contain `conversations.json` and/or HTML/JSON export artifacts.

Required procedure:

1. preserve the ZIP unchanged;
2. compute SHA-256 before parsing;
3. extract conversation/message IDs and timestamps;
4. hash derived conversation/message artifacts;
5. build Chat → Git → Zenodo crosswalks;
6. publish hashes and relevant excerpts, not unrelated private conversations.

## Current comparison conclusion

The audit currently supports documentary anteriority for multiple pre-2026 objects and very strong programmatic structural overlap in parts of the residual/projection/correction architecture. It does NOT currently establish a distinctive-construction identity for the entire later construction, causal derivation, plagiarism, training use, or a completed Clay Millennium solution.

See `STATUS.md`, `audit/15_correction_architecture_comparison.md`, and `audit/16_chat_provenance_ledger.md` for the current boundary conditions.
