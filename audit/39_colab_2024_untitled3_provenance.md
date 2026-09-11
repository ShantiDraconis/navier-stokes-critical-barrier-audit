# 39 — Colab 2024 provenance evidence: `Untitled3.ipynb`

## Scope

This record preserves a user-supplied Google Drive / Google Colab version-history record for the notebook identified by the shared Colab URL:

- Colab URL: `https://colab.research.google.com/drive/1VfHaxN14ZKXQRnNxITUCU0nI5yJ_LXZ8?usp=drive_link`
- Google Drive file ID: `1VfHaxN14ZKXQRnNxITUCU0nI5yJ_LXZ8`
- Notebook name at current version: `Untitled3.ipynb`
- Owner/actor shown in the version panel: `tiago fagliari`

This artifact is a provenance record. It does **not** by itself prove that every item currently present in the notebook existed in the earliest version, and it does not establish mathematical correctness or publication priority.

## User-supplied Drive version history

The following timestamps were supplied directly from the Google Drive/Colab version-history panel:

| Version | Name shown | Timestamp shown |
|---|---|---|
| Version 1 | `Untitled` | 2024-08-14 01:38 |
| Version 2 | `Untitled` | 2024-08-14 01:39 |
| Version 3 | `Untitled3.ipynb` | 2024-08-18 19:06 |
| Version 4 | `Untitled3.ipynb` | 2024-08-19 18:07 |
| Version 5 | `Untitled3.ipynb` | 2024-08-19 19:06 |
| Current version | `Untitled3.ipynb` | 2024-08-19 19:18 |

Timezone was not independently extracted from Drive API metadata in this audit step. Therefore these times are preserved exactly as displayed by the user interface and must not be silently normalized to UTC.

## Evidence level

Current classification:

```text
SOURCE_TYPE = GOOGLE_DRIVE_COLAB_VERSION_HISTORY
EVIDENCE_ORIGIN = USER_SUPPLIED_UI_RECORD
DRIVE_FILE_ID = 1VfHaxN14ZKXQRnNxITUCU0nI5yJ_LXZ8
EARLIEST_DISPLAYED_VERSION_TIME = 2024-08-14 01:38
EARLIEST_DISPLAYED_NAME = Untitled
CURRENT_DISPLAYED_TIME = 2024-08-19 19:18
API_METADATA_VERIFIED = NO
HISTORICAL_VERSION_BYTES_RECOVERED = NO
CURRENT_NOTEBOOK_CONTENT_AVAILABLE = PARTIAL/EXPORTED EVIDENCE PRESENT
```

This is stronger than an unsupported recollection because it records a persistent Drive file identifier and explicit version-history timestamps, but it is weaker than a preserved historical notebook byte stream or a Drive API response containing immutable version metadata.

## Current-content evidence associated with this notebook family

The recovered/exported notebook material contains a broad computational-exploration program involving:

- products and inverses of physical constants;
- a 13×13 matrix of pairwise physical-constant ratios;
- PCA, KMeans clustering and outlier detection;
- repeated analysis sections titled `SU vs α (Variação de E/Q/R)`;
- 3D visualization of `SU` over `E`, `Q`, and `R`;
- exploratory gravitational/electrostatic/strong/weak/scalar/vector/tensor force models;
- interactive sliders and iterative debugging output.

The preserved output includes, among other values, a ratio matrix with entries such as `c/h = 4.524e+41`, `h/c = 2.210e-42`, `c/G = 4.492e+18`, and `G/c = 2.226e-19`, demonstrating a reciprocal-ratio construction to rounding precision in many entries.

The same material contains explicit notebook-runtime failures (`IndentationError`, `ValueError`, `NameError`, `AttributeError`) and therefore must be classified as exploratory computational work rather than a completed formal proof.

## Mathematical/proof-status classification

```text
PRIMARY_CLASS = COMPUTATIONAL_EXPLORATION
SECONDARY_CLASS = PARAMETRIC_MODEL
FORMAL_PROOF_STATUS = NOT_FORMAL_PROOF
PHYSICAL_VALIDATION_STATUS = NOT_ESTABLISHED
BUILD/RUNTIME_STATUS = PARTIALLY_EXECUTED_WITH_ERRORS
```

The `SU` family should be treated as a parameterized model. In the later/current code form where `L_U = K_U = 1`, the factor `(L_U / K_U - 1)` vanishes identically, so the displayed formula gives `SU = 0` for all `α,E,Q,R` under those exact parameter assignments. This is a mathematical property of that particular code state, not evidence that every historical notebook version used those same assignments.

## Chronology significance

This evidence materially changes the chronology of the broader research program.

Before this record, the earliest directly recovered Git anchors for the later Navier–Stokes/Cᵢ program were in November 2025. The Drive version history supplies an independently located **2024 notebook lineage** for an earlier computational/unification phase.

Defensible statement:

> A Google Drive/Colab notebook identified by Drive file ID `1VfHaxN14ZKXQRnNxITUCU0nI5yJ_LXZ8` has a user-supplied version-history display beginning on 14 August 2024 and continuing through 19 August 2024. The currently recovered/exported notebook material contains physical-constant ratio matrices, PCA/clustering/outlier experiments, SU parameter studies, force-unification experiments, interactive visualization and iterative debugging. Historical version bytes have not yet been recovered, so the audit does not yet assign each present-day cell or formula to the earliest 2024 version.

This supports an earlier provenance layer for the overall program but **does not by itself establish** that later constructs such as `C_I`, `0/0`, `SBFE`, Navier–Stokes collapse, `Phi_NS`, `epsilon_NS`, or any Millennium-problem bridge were already present in August 2024.

## Remaining forensic obligations

1. Use Google Drive API to retrieve `createdTime`, `modifiedTime`, MIME type, version/revision metadata and file ID for this exact object.
2. Download the current `.ipynb` bytes and compute SHA-256.
3. If historical revisions are downloadable, preserve every available revision byte-for-byte and hash each separately.
4. Extract cell-level content per revision and construct a first-occurrence table for key formulas and terms.
5. Search historical notebook content for `0/0`, `C_I`, `SBFE`, `collapse`, `Navier`, `Stokes`, `Phi_NS`, `epsilon_NS`, `enstrophy`, `vorticity`, `Millennium`, `Riemann`, `Yang-Mills`, `Hodge`, `BSD`, and `P vs NP`.
6. Compare any matching historical formula against Git objects by exact text, normalized syntax and semantic equivalence.
7. Preserve the distinction between `DRIVE_VERSION_TIME`, `DRIVE_CREATED_TIME`, `GIT_COMMIT_TIME`, and later archival-copy time.

## No-overclaim rule

This record establishes evidence for the existence and evolution of a Colab/Drive notebook lineage in August 2024. It does not establish worldwide priority, independent discovery, peer review, physical validity, or a solution to any Millennium Prize Problem.
