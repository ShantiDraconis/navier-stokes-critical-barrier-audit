# 41 — Colab 2024 provenance: DMT / particle-interaction computational models

## Provenance record

User-supplied Google Drive / Google Colab metadata for:

- Colab URL: `https://colab.research.google.com/drive/1LGPZNfdjlZ146onTA_Jk-jvs3jcfZZzP?usp=drive_link`
- Google Drive file ID: `1LGPZNfdjlZ146onTA_Jk-jvs3jcfZZzP`
- Access: `Private to you`
- Security limitations: `No limitations applied`
- Type: `Google Colab`
- Size: `332 KB`
- Storage used: `365 KB`
- Location: `Colab Notebooks`
- Owner: `me`
- Created: `Oct 24, 2024 with Google Colaboratory`
- Modified: `Oct 25, 2024 by me`
- Opened: `Oct 25, 2024 by me`

These timestamps are preserved exactly as displayed by the user-supplied Google Drive interface. No timezone normalization is asserted because the source UI timezone has not been independently verified.

```text
SOURCE_TYPE = GOOGLE_DRIVE_COLAB_FILE_DETAILS
EVIDENCE_ORIGIN = USER_SUPPLIED_UI_RECORD
DRIVE_FILE_ID = 1LGPZNfdjlZ146onTA_Jk-jvs3jcfZZzP
ACCESS = PRIVATE_TO_USER
CREATED_DISPLAYED = Oct 24, 2024
MODIFIED_DISPLAYED = Oct 25, 2024
OPENED_DISPLAYED = Oct 25, 2024
API_METADATA_VERIFIED = NO
RAW_IPYNB_RECOVERED = NO
HISTORICAL_REVISION_BYTES_RECOVERED = NO
```

## Recovered / supplied computational content

The user supplied code associated with this notebook context. The code belongs to two broad computational branches:

1. a stylized 3D DMT / molecular-force visualization;
2. a stylized particle / force / entropy analysis and visualization framework.

The source is preserved as evidence of computational exploration. It is not treated as a chemically faithful DMT model, a quantum-field-theoretic calculation, or a validated force model.

---

## A. DMT / molecular visualization logic

### A.1 Declared element palette

The code defines colors for:

- Carbono;
- Hidrogênio;
- Nitrogênio;
- Oxigênio;
- `Receptor_5HT2A`.

The 5-HT2A receptor color is declared, but the receptor itself is not actually instantiated as a molecular or receptor structure in the supplied code.

### A.2 Atom-sphere renderer

`esfera_molecula(radius, cor, nome)` parameterizes a sphere by

```text
x = r cos(u) sin(v)
y = r sin(u) sin(v)
z = r cos(v)
```

and returns a Plotly `go.Surface` object with fixed opacity and lighting parameters.

This is a generic sphere renderer, not an atom-specific electronic-density calculation.

### A.3 Bond renderer

`criar_ligacoes(coords, ligacoes, cor)` draws straight `Scatter3d` line segments between coordinate pairs.

This is a geometric connectivity visualization only. It does not calculate bond lengths, bond orders, orbital hybridization, molecular energy, or force constants.

### A.4 Force / entropy surface renderer

`criar_superficie_forca_entropia(funcao, cor, nome)` constructs a radial grid and applies a supplied scalar function to `sqrt(x^2+y^2)`. In the supplied notebook code:

- `np.sin` is labeled `Força Eletromagnética`;
- `np.cos` is labeled `Entropia`.

These surfaces are visualization ansätze only. No Maxwell equation, electrostatic potential, thermodynamic entropy functional, partition function, or statistical-mechanical derivation is implemented.

### A.5 DMT coordinates and connectivity

The code supplies simplified arrays named `carbonos`, `hidrogenios`, `nitrogenios`, and `oxigenios`, and simplified index lists for C-H, C-N, and C-O connections.

Important correctness limitation:

- N,N-dimethyltryptamine (DMT) has molecular formula `C12H16N2` and contains **no oxygen atoms**. Therefore the supplied `oxigenios` array and carbon-oxygen bonds cannot represent DMT correctly.
- The code defines only six carbon coordinate rows and a few other atoms, far fewer than the full molecular composition of DMT.
- The atom-sphere calls do not translate individual spheres to the declared atomic coordinates; each call creates one sphere centered at the origin. Therefore the declared atomic coordinate arrays are not actually used to position the rendered atom surfaces.
- The connection indexing operates over concatenated coordinate arrays while bond-pair indices are written as if local arrays were being addressed. This means several displayed bonds are not a faithful mapping of the stated chemistry.

### A.6 DMT visualization verdict

```text
CLASSIFICATION = COMPUTATIONAL_EXPLORATION
SUBCLASS = STYLIZED_MOLECULAR_VISUALIZATION
CHEMICAL_FIDELITY = LOW / INCORRECT_FOR_DMT
FORCE_MODEL = VISUAL_ANSATZ
ENTROPY_MODEL = VISUAL_ANSATZ
5HT2A_RECEPTOR_MODEL = NOT_IMPLEMENTED
FORMAL_PROOF_STATUS = NOT_FORMAL_PROOF
```

---

## B. Particle statistics / matrices logic

A second supplied block defines a `data` dictionary for particle categories such as proton and neutron, with fields:

- `mean_position`;
- `std_dev`;
- `distance_matrix`;
- `forces_matrix`.

Plotting functions then produce:

- mean position with error bars;
- distance-matrix heatmaps;
- force-matrix heatmaps;
- cross-particle bar-chart comparisons of mean positions and standard deviations.

### B.1 Statistical meaning

As written, the code visualizes already-supplied summary statistics. It does not derive the particle distributions from a physical model, experimental dataset, quantum state, or Monte Carlo process.

### B.2 Incomplete matrix literals

The pasted matrices include Python ellipsis notation such as:

```python
np.array([[0., 0.05704216, 0.08919718, ...]])
```

This does not encode the omitted numerical matrix. It creates an array containing an `Ellipsis` object and therefore is not a complete numeric matrix suitable for quantitative heatmap analysis.

Thus:

```text
MATRIX_DATA_STATUS = PARTIAL / PLACEHOLDER-LIKE
NUMERIC_REPRODUCIBILITY = NOT ESTABLISHED
```

### B.3 Bar-chart limitation

Multiple `sns.barplot` calls are overlaid on the same axes for X/Y/Z components. Without reshaping the data into long form or explicit offsets, these are not a rigorous grouped comparison and may visually overwrite one another.

### B.4 Particle-statistics verdict

```text
CLASSIFICATION = COMPUTATIONAL_EXPLORATION
SUBCLASS = PARTICLE_SUMMARY_STATISTICS_VISUALIZATION
DATA_PROVENANCE = UNSPECIFIED
DISTANCE_FORCE_MATRICES = PARTIAL / INCOMPLETE
PHYSICAL_DERIVATION = NOT PRESENT
FORMAL_PROOF_STATUS = NOT_FORMAL_PROOF
```

---

## C. Related uploaded particle-interaction visualization

A related supplied source file contains a separate Plotly-based 3D visualization of:

- protons;
- neutrons;
- electron trajectories;
- muon trajectories;
- tau trajectories;
- up/down-quark trajectories;
- a rendered `Singularidade` sphere;
- surfaces labeled `Força Forte` and `Força Fraca`.

The trajectories are generated from elementary functions (`sin`, `cos`, `tanh`, linear ramps) over arbitrary coordinates. They are not solutions of Standard Model equations, Dirac equations, QCD, electroweak field equations, geodesic equations, or measured particle trajectories.

The strong/weak-force surfaces are likewise produced from trigonometric geometry, not gauge-field dynamics.

The code also repeats substantial blocks, indicating iterative notebook development rather than a finalized physical model.

```text
CLASSIFICATION = COMPUTATIONAL_EXPLORATION
SUBCLASS = STYLIZED_PARTICLE_INTERACTION_VISUALIZATION
STANDARD_MODEL_DERIVATION = NOT IMPLEMENTED
QCD_DERIVATION = NOT IMPLEMENTED
ELECTROWEAK_DERIVATION = NOT IMPLEMENTED
SINGULARITY_PHYSICS = NOT IMPLEMENTED
FORMAL_PROOF_STATUS = NOT_FORMAL_PROOF
```

---

## D. Logical structure of the October 2024 notebook program

The supplied code demonstrates a concrete 2024 computational pattern:

```text
objects / particles / molecules
    -> assign coordinates or summary statistics
    -> define synthetic scalar or geometric functions
    -> visualize in 2D/3D
    -> label surfaces or trajectories with physical concepts
    -> compare force / entropy / position / spread proxies
```

This is a legitimate record of exploratory computational modeling, but the labels must be distinguished from derivations. In particular, words such as `Força Forte`, `Força Fraca`, `Força Eletromagnética`, `Entropia`, `Singularidade`, or `Receptor_5HT2A` do not by themselves establish implementation of the corresponding physical or biochemical theory.

The most defensible historical characterization is:

> By 24–25 October 2024, the documented Colab research period included multidomain computational visualization experiments involving molecular structure labels, receptor terminology, particle classes, interaction labels, force/entropy surfaces, distance/force matrices, and comparative statistics. The supplied implementations are exploratory and largely synthetic; they do not constitute validated molecular dynamics, Standard Model calculations, or formal proofs.

---

## E. Relationship to later research program

This notebook is chronologically significant because it predates the directly recovered late-2025 Git formalization period. It may therefore contribute to the genealogy of later interests in:

- multidomain unification;
- particle and force representations;
- entropy / interaction terminology;
- visualization-driven hypothesis generation;
- later symbolic/formal frameworks.

However, **conceptual similarity is not provenance identity**. A direct lineage to later `0/0`, `C_I`, SBFE, Se'et, Navier–Stokes, Riemann, Yang–Mills, Hodge, BSD, or P-vs-NP structures must be established by exact formulas, names, code signatures, revision history, or other direct evidence.

---

## F. Chronology update

Current documented pre-Git Colab anchors include:

```text
2024-08-14  — earliest displayed version in Untitled3 lineage
2024-08-19  — later Untitled3 versions
2024-10-08  — Untitled9 current-version timestamp shown
2024-10-24  — this Colab file created
2024-10-25  — this Colab file modified/opened
2025-11-23  — earliest directly recovered millennium-navier-stokes-I Git origin
```

This supports a substantial pre-Git computational-exploration period in 2024.

---

## G. Remaining forensic obligations

To elevate this record beyond user-supplied UI and pasted-code evidence:

1. export/download the exact `.ipynb` bytes;
2. calculate raw SHA-256;
3. obtain Drive API `createdTime`, `modifiedTime`, `version`, size and checksum where available;
4. recover historical revisions if available;
5. inventory every cell, output and execution count;
6. map first occurrence of each concept/code signature;
7. compare exact formulas and code signatures against later Git repositories;
8. preserve the original notebook bytes without modification and store provenance metadata separately.

## No-overclaim rule

This record does not establish scientific correctness, worldwide priority, a validated theory of consciousness or unification, a chemically correct DMT simulation, a Standard Model calculation, or a solution to any Millennium Prize Problem. It establishes a dated Colab research object and the computational logic present in user-supplied associated code, with limitations explicitly documented.
