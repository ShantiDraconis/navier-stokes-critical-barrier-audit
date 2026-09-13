# 20 — Zenodo Evidence Record: 22180836

## Requested archival anchor

Record supplied for this audit:

`https://zenodo.org/records/22180836`

Canonical DOI-form candidate associated with Zenodo record numbering:

`https://doi.org/10.5281/zenodo.22180836`

## Current verification status

`PARTIALLY_IDENTIFIED / METADATA_REQUIRES DIRECT ARCHIVE CAPTURE`

The record identifier itself is preserved because it was explicitly supplied as an archival endpoint for this provenance audit. At the time this audit file was written, the web retrieval layer did not return sufficient trustworthy metadata to populate title, creators, publication date, version, file list, checksums, and related identifiers without risk of fabrication.

Therefore **no missing Zenodo metadata is invented here**.

---

# Required fields before promoting to `L3_ARCHIVE_VERIFIED`

The audit must capture directly from Zenodo/API:

```text
record_id
conceptrecid / concept DOI if present
DOI
concept DOI
record URL
title
creators/authors
publication date
upload/update date
version
resource type
description
keywords
license
related identifiers
GitHub relation, if declared
file names
file sizes
file checksums
file download URLs
record state
```

For every file downloaded from the record, additionally compute independently:

```text
SHA-256(raw bytes)
```

and retain the Zenodo-provided checksum separately.

---

# Required Git ↔ Zenodo linkage test

A Zenodo record must never be assumed to equal a GitHub HEAD.

For every archived file `Z` and candidate Git file `G`:

1. compare raw bytes;
2. compare independent SHA-256;
3. compare normalized text only as a secondary test;
4. compare embedded title/version/date;
5. identify candidate Git blob SHA;
6. identify the commit(s) containing that blob;
7. record whether equivalence is:

```text
BYTE_IDENTICAL
TEXT_IDENTICAL_METADATA_DIFFERS
SEMANTICALLY_EQUIVALENT
DERIVED_FROM
PARTIAL_OVERLAP
UNRESOLVED
NOT_EQUIVALENT
```

---

# Evidence object schema

When metadata is retrievable, add:

```json
{
  "schema_version": "1.0",
  "archive": "Zenodo",
  "record_id": "22180836",
  "record_url": "https://zenodo.org/records/22180836",
  "doi": null,
  "concept_doi": null,
  "title": null,
  "creators": [],
  "publication_date": null,
  "updated": null,
  "version": null,
  "files": [],
  "related_git_objects": [],
  "verification_status": "METADATA_PENDING_DIRECT_CAPTURE"
}
```

Null values are intentional until independently verified.

---

# Citation rule

Until the complete metadata is captured, cite the archive conservatively as:

> Zenodo record 22180836, archival record supplied for the project provenance audit; metadata verification pending direct archival capture.

Do not invent a title or author list.

Once verified, update `CITATION.cff`, the master provenance ledger, and the evidence manifest with the exact Zenodo metadata.

---

# Relation to Git chronology

Zenodo evidence and Git evidence answer different questions:

```text
Git author date      = timestamp recorded by author metadata
Git committer date   = timestamp recorded when commit object was created
GitHub PR date       = hosting-platform event
GitHub merge date    = integration event
Zenodo publication   = archival publication event
DOI registration     = persistent-identifier event
```

None should silently replace another in a priority timeline.

The master timeline should sort by UTC but retain `DATE_TYPE` explicitly.

---

# Current action state

```text
ZENODO_RECORD_22180836: REGISTERED_IN_AUDIT
TITLE: UNRESOLVED
CREATORS: UNRESOLVED
PUBLICATION_DATE: UNRESOLVED
FILES: UNRESOLVED
ZENODO_CHECKSUMS: UNRESOLVED
GIT_EQUIVALENCE: UNRESOLVED
DOI_METADATA: UNRESOLVED
```

This conservative state is preferable to fabricating archival evidence.
