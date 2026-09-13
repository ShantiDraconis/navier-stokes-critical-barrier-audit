# 21 — Citation and Evidence Guide

## How to cite this research program without losing the provenance chain

This guide tells reviewers/readers exactly where to find the historical objects and how to cite them.

---

# 1. Central audit repository

Repository:

`https://github.com/ShantiDraconis/navier-stokes-critical-barrier-audit`

Recommended role in citations:

> Central forensic/provenance audit repository linking historical Git objects, mathematical formulations, theorem-status classifications, external archives, and unresolved verification tasks.

The central audit is **not a replacement for the original source repositories**. Cite the original immutable commit/file whenever a mathematical object is attributed historically.

---

# 2. Primary source repositories

## Universal Emergent Logic

`https://github.com/ShantiDraconis/universal-emergent-logic-`

Core provenance lineage:

```text
23bbc031f0c9420978be26c538d777c158255283
bfd5cbad99015850b4116b181856b933704760fe
583c7fc1779c49739a1874bb1443aaed6c91098b
f7b51f6ac1cc95d357888aa60e4eeeaea24a49cf
ca5b39eeb953757f8ce4a72dece94e4dd23890fd
08d468c32fd0ba600488887b4c325d6f1b4222dc
38e46ac792770423765c0573efbc73f76b5664ef
91ba0b43b0bec9bf6d13621cda886bceb7b3e152
20c8f0974b1d85076b29ce842706d1d702eb5ccd
9b67b7c81d6065da2841a88d89f122cc6387c09a
```

## Millennium

`https://github.com/ShantiDraconis/Millennium`

Primary error-coordinate commit:

`bfc4cf5b804bc58348efe930651512bc079c33d4`

## Riemann symbolic repository

`https://github.com/ShantiDraconis/millennium-riemann-I`

Historical LaTeX commit:

`d4e57156d12a4aa0ea839835aacd39d2cb3008e8`

## 0-0 formal suite

`https://github.com/ShantiDraconis/0-0-FORMAL-SUITE`

Historical master-LaTeX candidate commit:

`c8e0e6a0ae1fef1726353d8b661e9d08888b812c`

## S5 Core

`https://github.com/ShantiDraconis/S5-Core-Private`

Indexed LaTeX/documentation commit:

`feb89339d377722f8749a67abca4932209f003a5`

---

# 3. Immutable file citations

## Canonical percentage decomposition

```text
https://github.com/ShantiDraconis/universal-emergent-logic-/blob/f7b51f6ac1cc95d357888aa60e4eeeaea24a49cf/DECOMPOSICAO_CANONICA_ERROS_MILLENNIUM.md
```

Git blob:

`18d095e75c115bb94a139bda65396b7d77759355`

## Error-coordinate system

```text
https://github.com/ShantiDraconis/Millennium/blob/bfc4cf5b804bc58348efe930651512bc079c33d4/ERROR_COORDINATE_SYSTEM.md
```

Git blob:

`236e9875e3d93a70c8fe6676ff7b5a5c73a966aa`

## Riemann symbolic LaTeX

```text
https://github.com/ShantiDraconis/millennium-riemann-I/blob/d4e57156d12a4aa0ea839835aacd39d2cb3008e8/latex/millennium-riemann-I.tex
```

Git blob:

`6b9829a035c6f7c4ca3b9570ea9222fa1a571ec6`

## 0-0 formal suite master LaTeX candidate

```text
https://github.com/ShantiDraconis/0-0-FORMAL-SUITE/blob/c8e0e6a0ae1fef1726353d8b661e9d08888b812c/latex/main.tex
```

Git blob:

`66c9b7e68811257684b136c0f3a6bf3bb1c957cb`

## S5 LaTeX template

```text
https://github.com/ShantiDraconis/S5-Core-Private/blob/feb89339d377722f8749a67abca4932209f003a5/LaTeX/mqc_template.tex
```

Git blob:

`3c6c31e4b8eb1538bf3c986a9d97e258b28f4232`

---

# 4. Archive citation

Requested archival record:

`https://zenodo.org/records/22180836`

Until metadata is independently captured, do not invent its title/creator/date. See:

`audit/20_zenodo_22180836_evidence.md`

---

# 5. Recommended citation hierarchy

For a claim about **when an idea appeared**, cite:

```text
1. immutable Git commit/file URL
2. full commit SHA
3. exact author/committer timestamp
4. Git blob SHA
5. SHA-256 of raw file bytes, once independently captured
6. Zenodo/DOI snapshot if available
```

For a claim about **mathematical correctness**, provenance is not sufficient. Cite the exact theorem, hypotheses, formal proof status, build result, and dependency/axiom report.

---

# 6. Suggested textual attribution

> The error-coordinate and error-as-parameter framework is documented in the ShantiDraconis Git history through a sequence of immutable commits beginning in the audited December 2025 lineage. The source history progresses from universal analytic error formulations to measurable critical gaps, intrinsic `(value,error)` parameter objects, vector-valued error coordinates, percentage decompositions, and later phase-based extensions. The central `navier-stokes-critical-barrier-audit` repository provides the cross-repository provenance map and theorem-status audit.

This formulation claims the documented synthesis/implementation lineage, not ownership of classical concepts such as norms, derivatives, sensitivity analysis, complex numbers, Navier–Stokes equations, or the Riemann zeta function.

---

# 7. Machine-readable citation fields to preserve

For every evidence object:

```text
repo_full_name
repository_url
path
full_commit_sha
parent_shas
tree_sha
blob_sha
sha256_raw
author_name
author_email
author_date_raw
author_date_utc
committer_name
committer_email
committer_date_raw
committer_date_utc
immutable_commit_url
immutable_blob_url
pr_number
pr_url
archive_record
archive_doi
proof_status
claim_status
```

---

# 8. Reader navigation

Start with:

1. `audit/18_master_error_framework_provenance.md`
2. `audit/19_remote_unmerged_commit_inventory.md`
3. `audit/20_zenodo_22180836_evidence.md`
4. `audit/21_citation_and_evidence_guide.md`
5. existing `audit/15_git_provenance_full.md`
6. existing `audit/13_cross_repository_forensic_index.md`
7. existing `TIMELINE.md`
8. existing `CLAIMS.md`
9. existing `LIMITATIONS.md`

This order separates chronology, unmerged evidence, archival evidence, citation rules, and mathematical claim status.
