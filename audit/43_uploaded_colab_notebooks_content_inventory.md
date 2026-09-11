# 43 — Uploaded Colab notebooks: content inventory, chronology limits, and authorship-safe claims

## Scope

This audit record inventories the exact notebook files uploaded in the current ChatGPT session and separates:

1. exact uploaded bytes;
2. notebook-internal cell content and outputs;
3. user-supplied Google Drive/Colab chronology metadata;
4. safe provenance/authorship claims;
5. claims that remain unresolved without Drive revision evidence.

The goal is to maximize defensible authorship/provenance without overstating scientific correctness, publication priority, or historical cell-level dates.

---

## Exact uploaded files and SHA-256

| Uploaded file | Bytes | SHA-256 | Cells | Code cells | Markdown cells |
|---|---:|---|---:|---:|---:|
| `Untitled9 (1).ipynb` | 324 | `298b16a180218da825d562bcbb29f3b26955074fea202ace7faadae051dd8632` | 1 | 1 | 0 |
| `Untitled9.ipynb` | 369483 | `ab41de3e75ba6eaf80a58474d689328777b915cb3e4321a79bdce9634892439d` | 18 | 18 | 0 |
| `Untitled10.ipynb` | 339761 | `373b8ca210135c5660e17ba534c176aaabbc71bb79082fe24b2492791c1eac8a` | 13 | 12 | 1 |
| `Untitled12 (1).ipynb` | 233487 | `72169dafb7b3f3811f8fd38a2fea77649975974caf0b10698d0b472fb59ff6c3` | 5 | 5 | 0 |
| `Untitled0.ipynb` | 586384 | `e308a48344053f781385b357c6ca5d626db5e07a2c83dea107970af3f599fdd3` | 13 | 11 | 2 |

These SHA-256 values identify the exact notebook bytes uploaded to this session. They do **not** prove when those bytes first existed in Google Drive.

---

## A. `Untitled9.ipynb`

### Cell structure

The uploaded notebook contains 18 code cells. Visible execution counts include 7, 15, 17, 19, 21, 22, 24, 25, 26, 27, 28, 32, 33, 35, 36, 29 and 30, with one empty/unexecuted cell.

### Recoverable content families

The notebook contains computational material involving, among other things:

- Qiskit installation / quantum-computing experiments;
- numerical-array analysis;
- physical / parametric models using `SU`-named variables and formulas;
- DMT-related material;
- FFT / signal-processing experiments;
- ODE integration;
- calendar and historical chronology experiments;
- Jewish calendar / Pessach calculations;
- date conversion using `convertdate`;
- calculations related to dates around the first century.

### Exact methodological caution

The notebook contains the previously identified calendar logic where code labeled as Jewish Passover uses formulas that are not sufficient to establish first-century Pessach chronology. Therefore any historical conclusion from that code is classified as computational exploration unless separately validated.

### Provenance relation

A user-supplied Google Drive version-history record previously associated an `Untitled9.ipynb` object with a displayed `Current version` timestamp of `Oct 8, 2024, 8:25 AM`, actor `tiago fagliari`.

This uploaded notebook is filename-compatible with that Drive object, but exact identity to the historical Oct-2024 bytes remains unresolved until one of the following is obtained:

- Drive revision download;
- exact historical file checksum;
- version-level export;
- API evidence binding this SHA-256 to that Drive revision.

Thus:

```text
FILENAME_MATCH = YES
HISTORICAL_DRIVE_OBJECT_MATCH = PLAUSIBLE
EXACT_REVISION_BYTE_IDENTITY = UNRESOLVED
CELL_CONTENT_FIRST_OCCURRENCE_DATE = UNRESOLVED
```

---

## B. `Untitled10.ipynb`

### Structure

13 cells total: 12 code, 1 markdown.

### Content families visible in the uploaded notebook

The notebook includes:

- numerical modeling;
- repeated `SU`-related computations;
- one or more references to `0/0`;
- machine-learning/statistical modeling (`LogisticRegression`, `statsmodels`);
- network/request code;
- weather/tornado analysis;
- explicit comments concerning a tornado in Oklahoma on 14 April 2024;
- mathematical utility code.

### Classification

```text
COMPUTATIONAL_EXPLORATION
MULTIDOMAIN_NOTEBOOK
SU_PARAMETRIC_MODEL_PRESENT
0_0_REFERENCE_PRESENT
STATISTICAL_MODELING_PRESENT
WEATHER_EVENT_ANALYSIS_PRESENT
FORMAL_PROOF_STATUS = NOT_FORMAL_PROOF
```

No historical Drive creation/modification timestamp for this exact uploaded notebook is established in this record.

---

## C. `Untitled12 (1).ipynb`

### Structure

5 code cells.

### Content

The notebook is another compact numerical/modeling notebook with multiple `SU` references. Its exact uploaded SHA-256 is preserved above.

### Classification

```text
COMPUTATIONAL_EXPLORATION
SU_RELATED_MODELING
FORMAL_PROOF_STATUS = NOT_FORMAL_PROOF
HISTORICAL_DRIVE_DATE = UNRESOLVED
```

---

## D. `Untitled9 (1).ipynb`

This object is only 324 bytes and contains one code cell with no substantive recovered research content in the current exact upload.

It must not be confused with the much larger `Untitled9.ipynb` object.

```text
EXACT_BYTE_OBJECT = DISTINCT
SUBSTANTIVE_CONTENT = MINIMAL / NONE RECOVERED
HISTORICAL_RELATION_TO_UNTITLED9 = UNRESOLVED
```

---

## E. `Untitled0.ipynb` — current uploaded 2026 Se'et / Riemann-inspired model notebook

### Internal notebook metadata

The notebook contains Colab metadata including:

```text
colab.authorship_tag = ABX9TyN99ftna7B93SB0XmHrJ59h
kernel = Python 3
```

The exact meaning and evidentiary role of the Colab `authorship_tag` should not be overstated without Google documentation tying it to a person/account.

### Structure

13 cells total: 11 code and 2 markdown.

### Cell-by-cell conceptual sequence

#### Cell 0 — high-precision Se'et signal prototype

Implements:

- `mp.dps = 600`;
- `gamma = 1429.0473`;
- `d = 0.025`;
- left/right weights `w_L = 0.576`, `w_R = 0.424`;
- stiffness constants `k_L = 7.5963`, `k_R = 6.7888`;
- oscillatory envelopes in `u = ln(x)`.

The executed output reports a final signal near `93.7948043018939...`, not a `10^-560` residual. This is therefore classified as a high-precision oscillatory model, not evidence of 560-digit cancellation.

#### Cell 1 — complex quartet / explicit-formula-inspired primal signature

Constructs

```text
rho = 1/2 ± d ± i gamma
```

and computes a sum of terms of the form

```text
-(x**rho / rho)
```

with `x = exp(u)`.

The executed output gives a real signature approximately

`0.056629528099757706...`

This is structurally inspired by zero contributions in explicit formulas, but the code does not verify that the chosen complex numbers are zeros of the Riemann zeta function.

#### Cell 2 — alternate primal recomposition

Uses the same quartet and reports a corresponding signed real component. This is part of the same explicit-formula-inspired numerical branch.

#### Cell 3 — `SE'ET / LA 2028 - COLAB TEST HARNESS`

Implements:

- logarithmic domain `u = ln(x)`;
- phase monitoring;
- polarization metrics;
- bit-depth heuristic;
- stress tests in `gamma = 10^3, 10^4, 10^5, 10^6`;
- asymptotic proxy metrics;
- idealized adaptive notch simulation.

The source itself explicitly states:

> `Este código implementa o MODELO do projeto, não prova RH.`

The field `xi_symmetry_residual = "1.04e-560"` is hard-coded as a string in this model and is not derived there.

#### Cell 4 — RH-envelope vs off-line perturbation comparison

Computes

```text
R(u) = exp(0.5 u) sin(gamma u)
S(u) = exp((0.5+d)u) sin(gamma u)
Delta(u) = S(u) - R(u)
```

with output at `u=15` of approximately

`-4.7987418046e+02`.

This is a genuine derived numerical difference between two parameterized envelopes; it is not a refutation of RH.

#### Cells 5–7 — Se'et auditor / deep-hardware abstractions

These cells implement higher-precision telemetry and model classes, including normalized weights based on

```text
(gamma / (2 pi))^(2d)
```

and various JSON status outputs. Any extremely small residual fields must be classified according to whether they are actually derived or inserted/constructed in the code.

#### Cell 8 — stress-regime comparison

Computes

```text
ratio = (gamma / (2 pi))^(2d)
w_L = ratio/(1+ratio)
w_R = 1/(1+ratio)
delta_K = exp(d u_max) - exp(-d u_max)
```

for anchor `gamma=1429.0473` and stress `gamma=10000`.

The `delta_K` formula is independent of `gamma`; therefore equal stress values across those two gamma values do not constitute an invariance theorem.

#### Cell 9 — stiffness comparison

Compares the same gamma-dependent stiffness ratio at the anchor and stress values.

#### Cell 10 — Se'et hardware simulation

Another implementation of the same 2026 model family using high-precision arithmetic and telemetry/status reporting.

### Correct scientific classification

```text
COMPUTATIONAL_EXPLORATION
RIEMANN_EXPLICIT_FORMULA_INSPIRED_MODEL
OFF_CRITICAL_LINE_PERTURBATION_MODEL
COMPLEX_CONJUGATE_QUARTET_MODEL
SEET_PARAMETRIC_SIGNAL_MODEL
HIGH_PRECISION_NUMERICAL_EXPERIMENT
NOT_ZETA_ZERO_VERIFICATION
NOT_RH_PROOF
```

### Chronology

The user supplied Google Drive version-history information for an `Untitled0.ipynb` object and clarified that the displayed April dates are from **2026**:

```text
Version 1: Apr 16, 2026, 5:18 PM
Version 2: Apr 16, 2026, 5:19 PM
Current:   Apr 16, 2026, 5:47 PM
actor: tiago fagliari
```

Without a revision-level checksum, the precise mapping between each uploaded current cell and each historical April 2026 revision remains unresolved. The defensible statement is that an `Untitled0.ipynb` Drive lineage existed on that date and the current uploaded object contains the Se'et/Riemann-inspired program inventoried here.

---

## Cross-notebook chronology and authorship-safe evidence

### Directly supportable chronology

From user-supplied Drive UI records and exact uploads:

```text
2024-08-14  earliest displayed Untitled3 lineage version
2024-08-19  later Untitled3 versions
2024-09-15  separate 7.1 MB Colab created/modified
2024-10-08  displayed Untitled9 current-version timestamp
2024-10-24  another Colab object created
2024-10-25  that object modified/opened
2025-02-26  Sep-2024 7.1 MB Colab reopened
2025-11-23  earliest directly recovered millennium-navier-stokes-I Git origin
2026-04-16  displayed Untitled0 Drive lineage versions
2026-09-12  exact uploaded notebook bytes inventoried in this audit session
```

### What can be claimed for authorship/provenance

The strongest defensible claims are bounded claims of **documented possession, account-associated editing, implementation, and chronology**, for example:

> User-supplied Google Drive UI records associate multiple Colab notebook objects with the user's Drive account and display creation/modification/version activity beginning in 2024. Exact uploaded notebook files preserve a broad computational research program spanning numerical physics, symbolic/parametric modeling, signal processing, calendar/chronology experiments, SU-labeled models, 0/0 references, and later Se'et/Riemann-inspired high-precision experiments. The Git audit repository preserves these records and hashes as a provenance chain.

Where exact historical revision bytes are recovered, stronger statements may be made:

> This exact code/formula is present in revision R at timestamp T with checksum H.

### What must NOT be claimed from current evidence

Current evidence does not justify statements such as:

- worldwide first discovery;
- legal ownership of general mathematical ideas;
- proof that no one else developed similar ideas earlier;
- scientific correctness merely from chronology;
- a solved Millennium Prize Problem;
- that current notebook cells necessarily existed in the earliest Drive revision;
- that a filename match proves byte identity across years.

---

## Forensic authorship maximization protocol

To push provenance as far back as evidence permits, the next steps are:

1. obtain Drive file ID for every notebook;
2. record `createdTime`, `modifiedTime`, `version`, owner/account, size and checksums via Drive API where available;
3. export every recoverable historical revision;
4. SHA-256 each historical `.ipynb` raw byte object;
5. extract every cell in revision order;
6. compute per-cell normalized hashes in addition to raw cell hashes;
7. build a first-occurrence ledger for every formula, function name, constant tuple, phrase and conceptual label;
8. compare those exact signatures to every accessible Git commit, PR, branch, deleted file and Zenodo object;
9. preserve exact historical bytes separately from explanatory metadata;
10. never rewrite historical commit dates; record historical source date in provenance metadata;
11. distinguish `AUTHORSHIP/PROVENANCE_EVIDENCE` from `SCIENTIFIC_VALIDITY` and from `GLOBAL_PRIORITY`;
12. publish a cryptographic manifest tying historical Drive objects, current archival copies, Git commits and Zenodo releases together.

---

## Current evidence verdict

```text
EXACT_CURRENT_NOTEBOOK_BYTES = YES
SHA256_MANIFEST = YES
CELL_CONTENT_INVENTORY = YES
EXECUTION_COUNT_EVIDENCE = YES
USER_SUPPLIED_DRIVE_CHRONOLOGY = YES
HISTORICAL_REVISION_BYTES = PARTIAL / MOSTLY NO
CELL_LEVEL_FIRST_OCCURRENCE_DATES = NOT YET CERTIFIED
ACCOUNT_ASSOCIATED_AUTHORSHIP_PROVENANCE = SUPPORTED IN BOUNDED FORM
GLOBAL_PRIORITY = NOT ESTABLISHED
SCIENTIFIC_CORRECTNESS = SEPARATE QUESTION
MILLENNIUM_PROBLEM_SOLUTION = NOT ESTABLISHED
```
