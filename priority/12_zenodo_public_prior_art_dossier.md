# 12 — Zenodo ↔ GitHub ↔ SHA ↔ Formula Dossier

## Scope

This dossier adds a **public-publication layer** to the existing commit chronology.
It does **not** convert Zenodo deposits into Git commits, and it does **not**
attribute later December 2025 LRE machinery to the April 2025 Zenodo deposit
without content comparison.

The new classification introduced here is: `ZENODO_PUBLIC_PRIOR_ART`.

This category is stronger than a private-commit timestamp for the narrow question
of **public availability**, but weaker than a file-level Git comparison for the
question of **which exact formulas were already present**.

---

## A. Public anchor now added

| Field | Value | Status |
|---|---|---|
| DOI | `10.5281/zenodo.15164501` | REPORTED (identifier known; primary source not directly fetched here) |
| Record URL | <https://zenodo.org/records/15164501> | REPORTED (URL known; primary source not directly fetched here) |
| Title | *Equations of Major Unsolved Problems in Mathematics* | REPORTED |
| Creator | `Tiago Fagliari aka Draconis Shanti` | REPORTED |
| Zenodo creation date | `2025-04-06` | REPORTED |
| Type | preprint | REPORTED |
| License | `CC-BY-4.0` | REPORTED |
| Subjects | `Navier-Stokes`, `Millennium` | REPORTED |
| Version note | preserves the original April 2025 version | REPORTED |
| File list | `UNKNOWN_IN_CURRENT_ENVIRONMENT` | direct Zenodo fetch pending |
| Zenodo checksum / MD5 | `UNKNOWN_IN_CURRENT_ENVIRONMENT` | direct Zenodo fetch pending |

**Audit consequence:** this record is now the earliest currently logged
**reported public** anchor tied to the Fagliari Navier–Stokes/Millennium line.

---

## B. Separation rule

The April 2025 Zenodo deposit proves only that the **deposited content** was
publicly registered by that date. It does **not** by itself prove that the later
December 2025 LRE package already contained:

- the full LRE residual-coupling hierarchy,
- the exact iterative correction update,
- the full stress/cancellation chain,
- or the later formalized 2026 manuscript package.

Therefore the audit rule for this dossier is:

> **No December-only construction is backdated to April unless the deposited
> Zenodo content is directly captured and compared.**

---

## C. Expanded chronology spine with the new public layer

```text
Reported Zenodo public candidate
  2025-04-06  DOI 10.5281/zenodo.15164501
      ↓
Private GitHub NS framework line
  2025-11-23  millennium-navier-stokes-I
  2025-11-25  millennium-navier-stokes-classical
      ↓
Dense LRE / projection / closure / residual cluster
  2025-12-18  Millennium
  2025-12-19  Millennium PR #249 merge
      ↓
Residual-coupling / curvature / NS geometric decomposition
  2025-12-19  universal-emergent-logic-
      ↓
Packaged article / dossier layer
  UNKNOWN date  Universe-0-0
      ↓
Machine-auditable formalization layer
  2026-08-30  navier-stokes-noncircular
      ↓
Public external comparator
  2026-09-08  openai/NavierStokesAndEuler
```

---

## D. Expanded evidence tree

```text
ZENODO_PUBLIC_PRIOR_ART
└── DOI 10.5281/zenodo.15164501
    ├── date: 2025-04-06
    ├── title: Equations of Major Unsolved Problems in Mathematics
    ├── creator: Tiago Fagliari aka Draconis Shanti
    ├── type: preprint
    ├── license: CC-BY 4.0
    ├── subjects: Navier-Stokes; Millennium
    ├── public-strength:
    │   ├── REPORTED public registration by 2025-04-06
    │   └── candidate stronger-than-private publicity anchor if verified
    ├── missing-direct-capture:
    │   ├── Zenodo file list
    │   ├── Zenodo checksums
    │   ├── archived PDF/source snapshot
    │   └── exact internal section/formula map
    └── chain targets requiring comparison:
        ├── projection / closure / residual language
        ├── K(R,d) or K(R,π(u)) coupling layer
        ├── stress / coupling identification
        ├── perturbation / correction layer
        ├── residual evolution
        └── exact q-indexed iteration formulas

GitHub chronology already logged in this repository
├── 2025-11-23 → millennium-navier-stokes-I
│   └── early NS collapse / projection-adjacent framework
├── 2025-11-25 → millennium-navier-stokes-classical
│   └── classical / functional-space / proof-assistant layer
├── 2025-12-18 → Millennium
│   ├── 4af517e3  projection-obstruction
│   ├── 54a13fed  compression barrier
│   ├── 5a888677  LaTeX + Lean / critical jets adjacency
│   ├── b9b47682  formal closure
│   └── 0d601255  complete formal closure
├── 2025-12-19 → Millennium PR #249
│   └── 6054851e  projection → closure → residual merge anchor
├── 2025-12-19 → universal-emergent-logic-
│   ├── 730aa849  geometric decomposition / closure obstruction
│   ├── f30ef6a9  non-closure inequality
│   ├── ce960a1b  curvature / coupling K
│   ├── 14322ff2  projected evolution with residual coupling
│   ├── 4cb3cd8a  residual stability
│   └── 507135a1  residual-stability meta-framework candidate
├── UNKNOWN date → Universe-0-0
│   ├── f900684c  projection framework article + Clay dossier
│   ├── d35d6b02  NS regularity merge
│   └── 073a9d80  discrete geometric correction
└── 2026-08-30 → navier-stokes-noncircular
    └── 8f12748e  machine-auditable manuscript anchor
```

---

## E. Ledger rows required for the April anchor chain

| Public/Repo node | DOI | Zenodo date | Version | File | Checksum | Repo | Path | First SHA | Parent SHA | Author/committer UTC | PR | Formula | Mathematical function | Classification |
|---|---|---:|---|---|---|---|---|---|---|---|---|---|---|---|
| April Zenodo public anchor | `10.5281/zenodo.15164501` | `2025-04-06` | original April 2025 version preserved | `UNKNOWN_IN_CURRENT_ENVIRONMENT` | `UNKNOWN_IN_CURRENT_ENVIRONMENT` | `REQUIRES_CONTENT_COMPARISON` | `REQUIRES_CONTENT_COMPARISON` | `REQUIRES_CONTENT_COMPARISON` | `REQUIRES_CONTENT_COMPARISON` | `REQUIRES_CONTENT_COMPARISON` | `REQUIRES_CONTENT_COMPARISON` | deposited content not yet line-mapped | public preprint anchor | `ZENODO_PUBLIC_PRIOR_ART` |
| `Millennium` projection cluster | — | — | — | `UNKNOWN_PENDING_ARCHIVAL_EXPORT` | — | `REPO:MILLENNIUM` | pending line export | `4af517e3f1ea5d04be1c6bbd8953209fa2139e82` | parent pending | `2025-12-18T20:25:00Z` | — | `u → π(u) → C(u) → Res(u)` | projection / closure / residual decomposition | `FOUND_T3_PENDING_ARCHIVAL` |
| `Millennium` merge anchor | — | — | — | `UNKNOWN_PENDING_ARCHIVAL_EXPORT` | — | `REPO:MILLENNIUM` | pending line export | `6054851e80b463b3c994fef2acc110983769c309` | merge parents pending | `2025-12-19T03:17:00Z` | `#249` | `C(u) = (ι∘π)(u)`, `Res(u)=u-C(u)` | merge-level packaging of the chain | `FOUND_T3_PENDING_ARCHIVAL` |
| `UEL` geometric decomposition | — | — | — | `docs/lre-navier-stokes-geometric.md` | pending archival checksum | `REPO:UEL` | `docs/lre-navier-stokes-geometric.md` | `730aa849b0d76b0202f08b490664aa11c164b2bf` | pending archival | `2025-12-19T17:17:00Z` | — | `P_N[(u·∇)u] ≠ (P_Nu)·∇(P_Nu)` | closure obstruction | `FOUND_T2_URL_VERIFIED` |
| `UEL` coupling layer | — | — | — | `UNKNOWN_PENDING_ARCHIVAL_EXPORT` | — | `REPO:UEL` | pending line export | `14322ff2e8f38df302c6f2f6b41754db79d5a900` | pending archival | `2025-12-19T22:36:36Z` | `#37` | `d/dt π(u) = F(π(u)) + K(R(u), π(u))` | projected evolution with residual coupling | `FOUND_T3_PENDING_ARCHIVAL` |
| Explicit iteration formula | — | — | — | `NOT_LOCATED` | — | `SEARCH_ALL_PRIOR_REPOS` | `NOT_LOCATED` | `NONE_IDENTIFIED` | `NONE_IDENTIFIED` | `UNKNOWN` | — | `u_{q+1}=u_q+C_q` | explicit iterative correction | `MISSING` |
| Explicit residual update | — | — | — | `NOT_LOCATED` | — | `SEARCH_ALL_PRIOR_REPOS` | `NOT_LOCATED` | `NONE_IDENTIFIED` | `NONE_IDENTIFIED` | `UNKNOWN` | — | `R_{q+1}=R(u_{q+1})` or stronger update formula | residual evolution | `MISSING` |

---

## F. What the April Zenodo anchor now proves

The canonical status layer in `audit/evidence/` now separates two results:

### VERIFIED-only result

1. The current environment did **not** independently verify the Zenodo metadata for
   record `15164501`.
2. Therefore the Zenodo layer does **not yet** supply a VERIFIED public timestamp.
3. No VERIFIED mathematical equivalence is established between the April deposit and
   the December 2025 LRE chain.

### VERIFIED + REPORTED context

1. Existing repository materials **report** that a Fagliari/Draconis-Shanti
   Navier–Stokes/Millennium Zenodo item existed by **2025-04-06**.
2. In that REPORTED context, the audit has a **candidate** public anchor earlier
   than the currently logged November 2025 private-commit chain.
3. This supports further verification work on **public availability**, not exact
   formula identity.

## G. What it still does not prove

1. That the later December 2025 LRE package was already present in the April deposit.
2. That any external party accessed the deposit.
3. That the missing links
   `R_q → C_q`, `u_{q+1}=u_q+C_q`, and `R_{q+1}=R(u_{q+1})`
   were already present in the deposited content.
4. That the “specific experimental validation of Navier-Stokes N7” has not
   yet been identified with a DOI and archived metadata in this repository.

---

## H. Immediate next capture targets

1. Direct Zenodo metadata capture for record `15164501`:
   file names, checksums, version string, and related identifiers.
2. Exact identification of the later Zenodo record alluded to as a
   “specific experimental validation of Navier-Stokes N7”.
3. File-level comparison of the April deposit against:
   - `Millennium` PR #249 cluster,
   - `UEL` geometric decomposition cluster,
   - `Universe-0-0` packaged article layer.
4. Promotion of `REQUIRES_CONTENT_COMPARISON` cells in the ledger to concrete
   `repo/path/SHA/formula` values only after direct content capture.
