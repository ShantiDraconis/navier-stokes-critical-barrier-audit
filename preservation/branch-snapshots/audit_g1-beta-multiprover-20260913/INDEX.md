# Repository Index and Evidence Map

This is the navigation layer for the audit. It separates documentary provenance, formal verification, mathematical validity, external comparison, and causal claims.

## Read first — final review path

1. `README.md` — repository overview.
2. `STATUS.md` — current scientific/provenance status.
3. `TIMELINE.md` — chronology.
4. `CLAIMS.md` — claim inventory and boundaries.
5. `audit/49_final_two_stage_referee_and_nsb2_verdict.md` — **final two-stage referee report and release-gate verdict**.
6. `audit/50_nsb2_journal_grade_analytic_obligations.tex` — **journal-grade LaTeX statement of B2.1–B2.10**.
7. `data/ns_b2_review_certificate.csv` — **machine-readable certificate/status matrix**.
8. `audit/47_ns_b2_critical_tail_derivation_and_cross_problem_sources.md` — critical-tail derivation and negative scalar-residual result.
9. `audit/48_ns_yang_mills_cross_problem_historical_bridge.md` — authenticated cross-problem historical bridge.
10. `audit/35_peer_review_master_protocol.md` — evidence and proof-status policy.
11. `audit/44_peer_review_gap_theorem_submission_plan.md` — publication tracks and open bridge obligations.
12. `audit/16_chat_provenance_ledger.md` — reconstructed conversation genealogy and export/hash protocol.

## Evidence firewall

Never collapse these questions into one:

- documentary priority;
- mathematical equivalence;
- public availability;
- submission/exposure;
- causal derivation.

Chronology is not proof. Structural overlap is not copying. A formal interface is not a proof of an analytic hypothesis. A repository timestamp is not necessarily a public-publication timestamp.

## Final NS-B2 status

The decisive target is

`Navier–Stokes + explicit admissibility hypotheses -> NS-B2`.

Current result:

- scalar high-frequency `L2` residual alone: **INSUFFICIENT** by concentration scaling;
- Littlewood–Paley critical-tail repair: **MATHEMATICALLY MOTIVATED / CONDITIONAL**;
- fixed-cutoff `energy + H_J -> L3`: **PROVED FROM EXPLICIT HYPOTHESES**;
- derivation of uniform `H_J` or equivalent critical control from NS dynamics: **OPEN ANALYTIC BRIDGE**;
- completed Clay solution: **NOT ESTABLISHED**.

## Principal provenance files

- `audit/13_cross_repository_forensic_index.md`
- `audit/14_openai_formula_provenance.md`
- `audit/15_correction_architecture_comparison.md`
- `audit/15_git_provenance_full.md`
- `audit/15_projection_chain_audit_map.md`
- `audit/15_uel_structural_analysis.md`
- `audit/16_related_commit_derivations.md`
- `audit/48_ns_yang_mills_cross_problem_historical_bridge.md`

## Mathematical audit files

- `audit/03_L3_consistency_test.md`
- `audit/04_energy_concentration_test.md`
- `audit/05_forcing_smoothness_test.md`
- `audit/06_pressure_compatibility_test.md`
- `audit/07_support_compatibility_test.md`
- `audit/08_scaling_exponents.md`
- `audit/09_required_cancellations.md`
- `audit/10_candidate_contradictions.md`
- `audit/11_failed_refutation_attempts.md`
- `audit/12_open_questions.md`
- `audit/47_ns_b2_critical_tail_derivation_and_cross_problem_sources.md`
- `audit/49_final_two_stage_referee_and_nsb2_verdict.md`
- `audit/50_nsb2_journal_grade_analytic_obligations.tex`

## Formal verification and CI

- `.github/workflows/audit-integrity.yml` — Python tests, registry validation, integrity scan, Lean build/checks, Coq compilation/checks; Isabelle/Agda explicitly recorded as unexecuted in that workflow.
- `formal/lean/` — Lean audit modules.
- `formal/coq/` — Coq audit modules.
- `tools/scan_sorry_certificates.py` — declaration-level historical gap scanner; source-clean status still requires a build/kernel certificate.
- `data/ns_b2_review_certificate.csv` — release-grade status matrix.

No theorem with `sorry`, `admit`, `Admitted`, `postulate`, `axiom`, `oops`, vacuous `True`, or an equivalent escape hatch may be advertised as a completed proof unless the relevant dependency and assumption status is explicitly part of the theorem claim.

## Historical anchors directly recovered from GitHub

Important authenticated full-SHA anchors include:

- `2025-11-23T02:27:31Z` — `millennium-navier-stokes-I@64bc633ecdb3a90ccfbf1c0863963c4bdd238d0f`.
- `2025-11-25T04:14:58Z` — `777d58e6f1eda3872a809492183ce432ead4f030`.
- `2025-11-25T04:19:53Z` — `1cd176fa02d0827cff24f61cfc27dbda21109c25`.
- `2025-11-25T15:47:20Z` — `63b248dd29f1817c457acdb00e116e2e9b0687cc`.
- `2025-11-25T21:04:43Z` — `millennium-navier-stokes-classical@cca881c665f67c67d96a4f84371fb51cd9c858a0`.
- `2025-12-02T21:36:26Z` — `Millennium@17686f99ff0b79711cbd3d2eac39261ac5d9c6c1`.
- `2025-12-18T20:20:34Z` — `Universe-0-0@f900684c3785ffbd9707291225b2c1751ae3e3eb`.
- `2025-12-18T20:25:20Z` — `Millennium@4af517e3f1ea5d04be1c6bbd8953209fa2139e82`.
- `2025-12-19T13:35:07Z` — `universal-emergent-logic-@f5d070d49557622c7168cd7b354d5d9629ce3fc6`.
- `2025-12-19T17:17:28Z` — `730aa849b0d76b0202f08b490664aa11c164b2bf`.
- `2025-12-19T17:43:21Z` — `1ed0ded98d26966189fc5936914fd964d42cbd7a`.
- `2025-12-19T17:55:31Z` — `abdaa41189864f85d3b9f8c8fec6b3ec4431eab5`.
- `2025-12-19T20:17:38Z` — `2ceba2ac14e9541561d76307af538ed91817c2af`.
- `2025-12-19T20:23:05Z` — `ace0acc3abd1067cd63bd94adfeffa962977bc9b`.
- `2025-12-19T20:24:44Z` — `2854eaf70a4cf91cef3b936304ae080ec69f4fb1`.
- `2026-08-30T11:10:45Z` — `navier-stokes-noncircular@8f12748eb160b937174825fe3e7bdccf05e8f9af`.

These dates establish account-associated corpus chronology only.

## Quarantined provenance

PR #20 corrects source attribution for LRE commits and quarantines three rows previously tied to `Millennium@c70b6f72...`. That commit is not valid evidence for the claimed December-2025 NS paths. The correct first occurrences remain unresolved pending path-history recovery. The rejected citation is retained in caveats to preserve the audit trail.

## Conversation provenance

Conversation-derived dates remain `REPORTED_CONVERSATION_METADATA` until the original account export is supplied. Current earliest recovered interaction is `2023-04-08T21:18:05Z`; this is not an independently verified account-creation date.

Required primary-evidence procedure:

1. preserve original export ZIP unchanged;
2. compute SHA-256;
3. extract conversation/message IDs and timestamps;
4. hash derived artifacts;
5. construct Chat -> Git -> Zenodo crosswalks;
6. publish only relevant excerpts/hashes, not unrelated private material.

## Publication/readiness boundary

Acceptable now: provenance/reproducibility paper, negative scalar-residual coercivity theorem, critical-defect/open-theorem program, research-software paper.

Not acceptable now: completed NS Millennium solution, global first-priority claim, plagiarism/copying claim, training-use claim, or causal-derivation claim.

See `audit/49_final_two_stage_referee_and_nsb2_verdict.md` for the canonical final wording.
