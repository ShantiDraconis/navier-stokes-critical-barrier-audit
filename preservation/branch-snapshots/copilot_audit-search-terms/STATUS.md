# Scientific and Provenance Status

**Last synchronized: 2026-09-12**

## Executive status

### Documentary priority

**ESTABLISHED FOR MULTIPLE SPECIFIC PRE-2026-09-08 GIT OBJECTS.**

The repository contains or indexes Git evidence for multiple Navier–Stokes/LRE objects predating the external public comparison anchor of 2026-09-08. Priority is object-specific; it is not a blanket claim over the complete later construction.

### Structural overlap

**VERY STRONG AT THE PROGRAMMATIC LEVEL FOR SELECTED COMPONENTS.**

Strongest cluster: projection/resolved state → high-frequency/unresolved component → closure/residual → residual/stress coupling → residual-dependent dynamical correction.

### Distinctive-construction identity

**NOT ESTABLISHED.**

Exact later mechanisms such as the complete `CycleState`-style iterative residual ledger, unified `ReferenceJet`/`CarrierJet`, `MovingMomentBounds`, moment repair, gauge debt, and the full correction bookkeeping remain unmatched or insufficiently established in the historical corpus.

### Causal derivation

**UNRESOLVED / NOT ESTABLISHED.**

Chronological priority and structural similarity do not prove copying, plagiarism, training use, or causal derivation.

### Training use

**NOT ESTABLISHED.**

### Clay Millennium solution by Tiago Fagliari

**NOT ESTABLISHED.**

### Refutation of the external construction

**NOT ESTABLISHED.**

## Conversation provenance

The reconstructed conversation chronology is now indexed in `audit/16_chat_provenance_ledger.md` and `INDEX.md`.

Current earliest recovered interaction in available context:

`2023-04-08T21:18:05Z`

This is **not** treated as the account-creation date. `ACCOUNT_CREATION_DATE = UNVERIFIED`.

Conversation-derived milestones from 2023–2025 remain `REPORTED_CONVERSATION_METADATA` until checked against an original ChatGPT account export. That export is currently missing from the audit evidence set.

Required primary-source upgrade:

```text
original export ZIP
→ SHA256
→ conversation_id/message_id
→ exact UTC timestamp/text
→ per-artifact SHA256
→ Chat-to-Git crosswalk
→ Chat-to-Zenodo crosswalk
```

## Principal dated Git/public anchors

| Date/UTC | Evidence |
|---|---|
| 2025-04-06 | Zenodo `15164501`, DOI `10.5281/zenodo.15164501`; public-prior-art candidate, archival/checksum capture tracked separately. |
| 2025-11-23 | `millennium-navier-stokes-I` `64bc633ecdb3a90ccfbf1c0863963c4bdd238d0f`. |
| 2025-11-26T08:56:06Z | `millennium-navier-stokes-classical` `53c91d97c2ace924b4436825f3a53aa67ab87ad7`; explicit I-state decomposition. |
| 2025-12-18T20:26:33Z | `b033ea87fca138224200dd1acf2cf4043315f846`; LRE–NS/compression-barrier cluster. |
| 2025-12-18T20:28:57Z | `30bf8c53008c548a8a9dada3fd69d6d2b2b1df2c`; NS documentation. |
| 2025-12-18T21:03:13Z | `a992d144c235572ac2b7413b015e58535a864a41`; formal closure. |
| 2025-12-18T21:07:43Z | `4cdb6a61ae7a9189eab551b1099895578a8fbb56`; critical jets/microlocal analysis. |
| 2025-12-19T13:56:01Z | `f7f414d2ea66fa7a04d4de390f0e9357dfd980ae`; residual-dependent dynamical-correction genealogy. |
| 2025-12-19T17:17:28Z | `730aa849b0d76b0202f08b490664aa11c164b2bf`; reference section/geometric NS decomposition. |
| 2025-12-19T20:24:44Z | `2854eaf70a4cf91cef3b936304ae080ec69f4fb1`; additive high-frequency perturbation architecture. |
| 2026-08-30 | `navier-stokes-noncircular` `8f12748eb160b937174825fe3e7bdccf05e8f9af`. |
| 2026-09-08 | external public comparison anchor `openai/NavierStokesAndEuler` `8937a8f4cbc7abaab5e9e97d1cc7f5d2319d9538`. |

See `TIMELINE.md`, `audit/15_git_provenance_full.md`, and `INDEX.md`.

## LRE evidence inventory

| Evidential unit | Current status |
|---|---|
| Spectral projection + high-frequency residual | ESTABLISHED |
| Closure obstruction | ESTABLISHED |
| Resolved/unresolved advection expansion | ESTABLISHED |
| Residual coupling operator | ESTABLISHED |
| Residual → dynamical correction pipeline | ESTABLISHED |
| `d/dt π(u) = F(π(u)) + K(R(u),π(u))` architecture | ESTABLISHED |
| Reynolds stress / residual coupling language | ESTABLISHED |
| Critical jets / microlocal analysis | ESTABLISHED |
| Critical cascade → spectral concentration → critical jets | ESTABLISHED |
| Residual Stability Inequality material | ESTABLISHED |
| Ehresmann connection / curvature genealogy | ESTABLISHED |
| Additive high-frequency perturbation precursor | ESTABLISHED AS HISTORICAL STRUCTURAL ANCHOR |
| Exact unified `ReferenceJet` construction | NOT_ESTABLISHED |
| Exact `CarrierJet` construction | NOT_ESTABLISHED |
| Full iterative NS correction ledger | NOT_ESTABLISHED |
| Full stress-correction hierarchy | NOT_ESTABLISHED |
| Engineered forcing cancellation in exact target form | NOT_ESTABLISHED |
| StressActivation / TransitionRamp exact match | NOT_ESTABLISHED |
| Moment repair / MovingMomentBounds | NOT_ESTABLISHED |
| Gauge debt | NOT_ESTABLISHED |
| Volterra/analytic recursive machinery exact match | NOT_ESTABLISHED |

Full inventory: `evidence/lre_evidence_inventory.md`.

## Mathematical-audit status

- Critical-L3 / ESS framework: **PARTLY CLASSICAL + PRIOR INDEPENDENT ORGANIZATION/FORMALIZATION**.
- Poincaré Mean Closure: **CONJECTURAL**.
- Mean-to-Local Closure: **CONJECTURAL**.
- Finite-time breakdown consistency with ESS: **CONSISTENT IN PRINCIPLE**; this is not a proof of breakdown.
- Smooth-forcing compatibility: **UNDER AUDIT**.
- Pressure compatibility: **UNDER AUDIT**.
- Required cancellation analysis: active in `audit/09_required_cancellations.md`.
- Candidate contradictions: no rigorous final refutation currently established.

## Required evidence still missing

1. Original immutable ChatGPT account export with cryptographic hash.
2. Authoritative IDs/timestamps for reconstructed conversation events.
3. Complete object-by-object historical repository sweep for all repositories in the frozen repository universe.
4. Independent archival capture/checksum verification for every public-priority claim that is still marked reported.
5. Exact first-introduction SHA/path/diff for any candidate object not yet pinned at commit level.
6. Direct evidence, if any exists, for exposure/training/causal derivation; absent such evidence those statuses remain unresolved/not established.

## Interpretation rule

The audit's valid conclusion is deliberately narrower than an authorship or causation claim:

> There is verifiable documentary anteriority for multiple specific objects and a strong structural correspondence for selected parts of the later architecture. Global mathematical equivalence, distinctive-construction identity, training use, and causal derivation remain separate questions and are not established merely by those facts.
