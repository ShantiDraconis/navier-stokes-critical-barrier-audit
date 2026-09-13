# Evidence Status Report

## Scope

This report creates a canonical evidence-status layer for the Zenodo/public-prior-art portion of the audit. Each material assertion is classified exactly once as `VERIFIED`, `REPORTED`, `INFERRED`, or `MISSING`.

## Status definitions

- `VERIFIED`: directly established from the primary source or independently retrievable forensic evidence.
- `REPORTED`: asserted by an existing repository/document/metadata source but not directly verified against the primary external source in the current environment.
- `INFERRED`: conclusion derived from verified/reported evidence, but not itself directly observed.
- `MISSING`: required evidence has not been located or established.

## Source dependence

The current Zenodo layer contains a key dependence constraint:

- `evidence/zenodo_records.yaml`
- `priority/12_zenodo_public_prior_art_dossier.md`
- `evidence/external_publications/README.md`
- `TIMELINE.md`

all repeat the same underlying reported Zenodo metadata for `10.5281/zenodo.15164501`. In the absence of a direct Zenodo capture, these count as **one dependent reported source**, not multiple independent corroborations.

## Zenodo field-by-field status

| Object | Assertion class | Status | Notes |
|---|---|---|---|
| `10.5281/zenodo.15164501` | ROLE = `ZENODO_PUBLIC_PRIOR_ART` in the current audit | VERIFIED | Internal audit classification only |
| `10.5281/zenodo.15164501` | DOI / record identifier under review | REPORTED | Known in repo/task, not directly verified against Zenodo here |
| `10.5281/zenodo.15164501` | title | REPORTED | Repeated repo metadata, source-dependent |
| `10.5281/zenodo.15164501` | creator | REPORTED | Repeated repo metadata, source-dependent |
| `10.5281/zenodo.15164501` | publication date `2025-04-06` | REPORTED | Not an independently verified public timestamp yet |
| `10.5281/zenodo.15164501` | type = preprint | REPORTED | Direct Zenodo fetch unavailable |
| `10.5281/zenodo.15164501` | license = `CC-BY-4.0` | REPORTED | Direct Zenodo fetch unavailable |
| `10.5281/zenodo.15164501` | subjects include `Navier-Stokes`, `Millennium` | REPORTED | Cannot establish equivalence |
| `10.5281/zenodo.15164501` | version/original-April-preserved note | REPORTED | Narrative note only |
| `10.5281/zenodo.15164501` | file list | MISSING | Not captured |
| `10.5281/zenodo.15164501` | checksums | MISSING | Not captured |
| `10.5281/zenodo.15164501` | related identifiers / version relationships | MISSING | Not established |
| `10.5281/zenodo.15164501` | earlier-than-Nov-2025 public anchor claim | INFERRED | Depends on the reported date |
| `10.5281/zenodo.15164501` | mathematical equivalence to Dec 2025 LRE chain | MISSING | No file-level comparison |
| `10.5281/zenodo.17204147` | role = `UNVERIFIED_RELATED_ZENODO` in current audit | VERIFIED | Internal audit classification only |
| `10.5281/zenodo.17204147` | reported title retained | REPORTED | Secondary-search-only; not primary-source verified |
| `N7 experimental validation` | concrete primary source identified | MISSING | No DOI, URL, file set, or metadata packet located |
| `N7 experimental validation` | relationship to current Zenodo records established | MISSING | Explicitly not established |

## A. VERIFIED-only results

Only the following propositions are supported in the VERIFIED-only layer:

1. The current audit classifies `10.5281/zenodo.15164501` as `ZENODO_PUBLIC_PRIOR_ART`.
2. The current audit classifies `10.5281/zenodo.17204147` as `UNVERIFIED_RELATED_ZENODO`.
3. Direct Zenodo access was unavailable in the current environment during this audit.

### VERIFIED-only priority claim table

| Final claim | MATHEMATICAL_MATCH_STATUS | TEMPORAL_PRIORITY_STATUS | PUBLIC_TIMESTAMP_STATUS | SOURCE_INDEPENDENCE_STATUS | EVIDENCE_STATUS |
|---|---|---|---|---|---|
| `10.5281/zenodo.15164501` establishes documentary public priority over the Nov/Dec 2025 private chain | NOT_ESTABLISHED | NOT_ESTABLISHED | NOT_VERIFIED | DEPENDENT_REPORTED_SOURCE_ONLY | MISSING |
| `10.5281/zenodo.15164501` establishes mathematical equivalence with the later LRE/projection/coupling chain | NOT_ESTABLISHED | NOT_APPLICABLE | NOT_APPLICABLE | NO_COMPARISON_SOURCE | MISSING |
| `10.5281/zenodo.15164501` supports causal derivation or genealogy | NOT_ESTABLISHED | NOT_APPLICABLE | NOT_APPLICABLE | NO_ACCESS_EVIDENCE | MISSING |
| `10.5281/zenodo.17204147` strengthens priority/equivalence/genealogy | NOT_ESTABLISHED | NO_EFFECT | NOT_VERIFIED | SECONDARY_SOURCE_ONLY | MISSING |
| Alleged N7 validation source is identified and linked | NOT_ESTABLISHED | NOT_ESTABLISHED | NOT_VERIFIED | NO_PRIMARY_SOURCE | MISSING |

**Result:** Layer A does **not** support a final strong documentary priority statement from Zenodo alone.

## B. VERIFIED + REPORTED context

When REPORTED context is included, a narrower candidate chronology statement becomes available.

### VERIFIED + REPORTED priority claim table

| Final claim | MATHEMATICAL_MATCH_STATUS | TEMPORAL_PRIORITY_STATUS | PUBLIC_TIMESTAMP_STATUS | SOURCE_INDEPENDENCE_STATUS | EVIDENCE_STATUS |
|---|---|---|---|---|---|
| `10.5281/zenodo.15164501` is a candidate earliest public anchor earlier than the Nov/Dec 2025 private chain | NOT_ESTABLISHED | CANDIDATE_EARLIER_THAN_PRIVATE_CHAIN | REPORTED_ONLY | DEPENDENT_REPORTED_SOURCE_ONLY | INFERRED |
| `10.5281/zenodo.15164501` establishes mathematical equivalence with the later LRE/projection/coupling chain | NOT_ESTABLISHED | NOT_APPLICABLE | REPORTED_ONLY | NO_COMPARISON_SOURCE | MISSING |
| `10.5281/zenodo.15164501` supports causal derivation or genealogy | NOT_ESTABLISHED | NOT_APPLICABLE | REPORTED_ONLY | NO_ACCESS_EVIDENCE | MISSING |
| `10.5281/zenodo.17204147` contributes to priority, equivalence, genealogy, N7, or causation | NOT_ESTABLISHED | NO_EFFECT | NOT_VERIFIED | SECONDARY_SOURCE_ONLY | MISSING |
| Alleged N7 validation source is identified and linked | NOT_ESTABLISHED | NOT_ESTABLISHED | NOT_VERIFIED | NO_PRIMARY_SOURCE | MISSING |

**Result:** Layer B supports only a **candidate** public-priority chronology, not a strong independently verified documentary priority claim.

## Explicit non-conversions preserved

The canonical layer preserves the following prohibitions:

- mathematical similarity does **not** become authorship;
- priority does **not** become causation;
- repository timestamp does **not** become public timestamp;
- reported Zenodo metadata does **not** become verified Zenodo metadata;
- neighboring or similar Zenodo records do **not** become N7 evidence.

## Immediate next actions

1. Capture `https://zenodo.org/api/records/15164501` or an equivalent archived primary-source record.
2. Record direct file list, checksums, and relation metadata for `15164501`.
3. Verify `17204147` directly before using any of its metadata beyond the `UNVERIFIED_RELATED_ZENODO` label.
4. Keep the alleged N7 validation source at `MISSING` / `NOT_ESTABLISHED` until a concrete primary source is identified.
5. Recompute the priority claim tables after any primary-source Zenodo capture.
