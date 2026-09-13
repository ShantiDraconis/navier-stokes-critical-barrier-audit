# LRE Evidence Inventory — Consolidated Forensic Record

This document records the full set of 42 probationary units identified during
the read-only audit of the ShantiDraconis archive.  Each entry follows the
canonical unit:

> **concept/formula + file + commit/PR + date**

Evidence is divided into three tiers:

- **ESTABLISHED** — anchor commit identified, content confirmed.
- **STRUCTURAL** — architecture-level match, commit anchored.
- **CLASSICAL / NOT_ESTABLISHED** — present but non-distinctive or not yet found.

---

## Tier A — Established prior LRE–NS framework components

### A-01 · Spectral projection + high-frequency residual

**Formula:**

```
π(u) = P_N u,   u = u_N + u_⊥,   u_⊥ = (I - P_N)u
R(u) = ‖u - P_N u‖²
```

**File:** `docs/lre-navier-stokes-geometric.md`  
**Commit:** `730aa849b0d76b0202f08b490664aa11c164b2bf`  
**Date:** 2025-12-19  
**Message:** "Add complete Navier-Stokes geometric decomposition"  
**Classification:** `STRUCTURAL — FORTE`

---

### A-02 · Closure obstruction of the nonlinearity

**Formula:**

```
P_N[(u·∇)u] ≠ (P_N u)·∇(P_N u)
```

**File:** `docs/lre-navier-stokes-geometric.md`  
**Commit:** `f30ef6a9d19af290a8f461d60d70da091d73d6ed`  
**Date:** 2025-12-19T17:22:45Z  
**Classification:** `STRUCTURAL — FORTE`

---

### A-03 · Resolved/unresolved advection expansion

**Formula:**

```
(u_N·∇)u_N + (u_N·∇)u_⊥ + (u_⊥·∇)u_N + (u_⊥·∇)u_⊥
```

The last three terms produce the residual coupling.

**Anchor:** `730aa849b0d76b0202f08b490664aa11c164b2bf`, 2025-12-19  
**Classification:** `STRUCTURAL — FORTE / NS-SPECIFIC`

---

### A-04 · Explicit residual coupling operator T

**Formula:**

```
T(u_N, u_⊥) = -P_N[(u_⊥·∇)u_N + (u_N·∇)u_⊥ + (u_⊥·∇)u_⊥]
```

**Anchor:** `730aa849b0d76b0202f08b490664aa11c164b2bf`, 2025-12-19  
**Classification:** `STRUCTURAL — FORTE`

---

### A-05 · Residual → dynamical correction pipeline

**Documented chain:**

```
u → P_N u → u_⊥ → R(u) → K(R, π(u)) → dynamical correction
```

Source: LRE index/README — "CouplingOperator K: Residual → dynamical correction"  
**Classification:** `STRUCTURAL — FORTE`

---

### A-06 · Projected dynamics equation with residual

**Formula:**

```
d/dt π(u) = F(π(u)) + K(R(u), π(u))
```

**File:** LRE formalization linked to PR #37  
**Commit:** `14322ff2e8f38df302c6f2f6b41754db79d5a900`  
**PR:** #37 — *Implement geometric foundation for LRE: residual as Ehresmann connection curvature*  
**Date:** 2025-12-19 (opened and merged)  
**Classification:** `STRUCTURAL — MUITO FORTE`

---

### A-07 · CouplingOperator: formally non-factorizable

**Structure:**

```lean
structure CouplingOperator ... where
  K : C → TangentSpace D
  not_factorizable : ¬ ∃ F, ∀ c, K c = F (proj.π c)
```

Meaning: correction term cannot be determined from projected state alone.

**Anchor:** PR #37 / `14322ff2e8f38df302c6f2f6b41754db79d5a900`  
**Classification:** `STRUCTURAL — DISTINTIVO`

---

### A-08 · Reynolds stress = residual coupling (multiple independent files)

**Sources:**

| File | Exact quote |
|------|-------------|
| `formalization/lean/LRE/SUMMARY.md` | "Reynolds stress = residual coupling" |
| `formalization/lean/LRE/QUICKSTART.md` | `R = H^{1/2} small-scale turbulence, Reynolds stress = residual coupling` |
| `README_COMPLETE.md` | "Reynolds stress as residual coupling" |
| `Examples/NavierStokesLRE.lean` | Reynolds tensor is the K(R,·) term that cannot be closed |

**Classification:** `STRUCTURAL — FORTE / REPETIDA EM VÁRIOS ARQUIVOS`

---

### A-09 · High frequencies → K(R) = Reynolds stress

**Source:** `docs/uia-lre-integration.md`  
**Formula:**

```
R(u) = high frequencies,   K(R) = Reynolds stress
```

**Chain:**

```
high frequencies → R(u) → K(R) → Reynolds stress
```

**Classification:** `STRUCTURAL — FORTE`

---

### A-10 · Physical interpretation of K as Reynolds stress

**Source:** LRE foundational paper — "Turbulence: K represents Reynolds stress"  
**Classification:** `STRUCTURAL — CONSISTENCY EVIDENCE`

---

### A-11 · Critical jets / microlocal analysis

**Source:** `Millennium/LRE_NS_SUMMARY.md`  
**Contents:**

- geometric vorticity control
- microlocal analysis of critical jets

**Classification:** `STRUCTURAL JET PRECEDENT = FOUND`  
*Note: exact OpenAI ReferenceJet construction not yet matched.*

---

### A-12 · Critical cascade → spectral concentration → self-similar profile → critical jets

**Chain documented:**

```
critical cascade → spectral concentration → self-similar blow-up profile → critical jets
```

**Millennium commits (2025-12-18):**

```
4af517e3f1ea5d04be1c6bbd8953209fa2139e82
54a13fedc2149f4368959d5694fd077010684f58
5a888677611ec79eb959f368e941699217487c2d
b9b4768206ee3d817cbbaf35bb7da92dc835c4e1
0d601255e51be349a1fd38eacfcbd2fda17ced77
```

**Classification:** `STRUCTURAL`

---

### A-13 · PR #249 — projection → closure → residual

**PR:** `ShantiDraconis/Millennium` #249 —  
*Add LRE projection-obstruction framework for Navier-Stokes Clay problem*  
**Created:** 2025-12-18  
**Merge commit:** `6054851e80b463b3c994fef2acc110983769c309`

**Formulas:**

```
C(u) = (ι ∘ π)(u)
Res(u) = u - C(u)
```

Residual situated in the high-frequency microstructure.

**Chain:**

```
u → π(u) → C(u) → u - C(u) → microstructure
```

**Classification:** `STRUCTURAL — MUITO FORTE`

---

### A-14 · Residual Stability Inequality (NS-specific)

**Formula:**

```
dR_Λ/dt ≥ κ(t)R_Λ - ν Λ² R_Λ - C R_Λ²
```

**Development commits (2025-12-19):**

```
1ed0ded98d26966189fc5936914fd964d42cbd7a
0f3ae4e275068f81f516b45b14289dd1a699e659
4cb3cd8ae5d24d5b79825346fb59ed47ff95bc9f
abdaa41189864f85d3b9f8c8fec6b3ec4431eab5
3d4d3e51866e03420e97ff3b21dde2a1fca1cc4d
```

**Merge commits:**

```
51644f5f8def81905637b59a8834f18b1192b3b3
0982941f39312ab0496d0112c796a0539ee76151
8c35193f7b0bc12efe6416b1fda0291f3734300f
71232a08bd4fa8a6af702c64fb99c4d0360802aa
203ce4ff62809fbcf403ee03e89c3bc70ed608ec
```

**Classification:** `STRUCTURAL`

---

### A-15 · Generic ERS with NS interpretation

**Commit:** `507135a16a64116e7baf15154e03dc40740b08bb` — 2025-12-19  
**Message:** "Implement LRE meta-framework core and ODE modules"  
**File:** `ResidualStability.lean`

**Formula:**

```
dR/dt ≤ a(t)R - bR + cR²,   a(t) ~ ‖∇u_{≤Λ}‖_∞,   b ~ νΛ²
```

**Classification:** `STRUCTURAL` (ODE form non-distinctive per se)

---

### A-16 · HCS–RBC continuous and discrete

**Commit:** `36513742ecf2c3568d6e429689bb2b74d195fd7d` — 2025-12-19

**Formulas:**

```
R' ≥  α R³
R' ≤ -α R³
R' ≤  δR - α R³
R_{n+1} ≥ R_n + α R_n³    (discrete recurrence)
```

**Classification:** `ALGEBRAICALLY_IDENTICAL` to abstract state+correction architecture.  
*Note: not yet the exact NS iteration u^(n+1) = u^(n) + C_n.*

---

### A-17 · Generation / dissipation / cubic residual law

**Formula:**

```
d/dt R(u(t)) ≤ [κ(u,t) - D(u,t)] R(u(t)) - α R(u(t))³
```

Combined generation − dissipation − nonlinear correction in one law.

**Anchor:** `36513742ecf2c3568d6e429689bb2b74d195fd7d`, 2025-12-19  
**Classification:** `STRUCTURAL`

---

### A-18 · Formalization in four proof assistants

**Languages:** Lean, Coq/Rocq, Isabelle/HOL, Agda

**Key commits:**

```
cca881c665f67c67d96a4f84371fb51cd9c858a0  — NS Lean/Coq/Isabelle, 2025-11-25
dc55830546d50d66ccf602250c16c5c366dd4a30  — merge NS formalizations
8332c7183e6418c7c878270b24a66bbb29e8340d  — LRE-UC four languages
c3ae2eff9e7d870effc03bb54b8f03b54e4a08c4  — merge PR #67, four proof languages
```

**Classification:** `PROVENANCE — STRONG`

---

### A-19 · Geometric curvature / coupling theory

**Commit:** `ce960a1ba8ce7a893d645131d12d1a7ab06eddd9` — 2025-12-19

**Contents documented in commit message:**

- `CurvatureTheory.lean`
- `ResidualCurvatureForm`
- `CouplingCurvature.lean`
- Relation K ≤ α Ω
- `NavierStokes.lean` extended with topological blow-up theory

**Classification:** `STRUCTURAL — FORTE`

---

### A-20 · Ehresmann connection / residual curvature genealogy

**Commits:**

```
92ae80cf78bf7d94c78795ea0929dc73cd145a97  — geometric theory of information loss in projective systems
14322ff2e8f38df302c6f2f6b41754db79d5a900  — residual as Ehresmann connection curvature
```

**Git genealogy:**

```
projection → fiber → residual → connection → curvature → K
```

**PR #34 and PR #37** document this evolution.

---

### A-21 · Quantitative obstruction theorem

**Formula:**

```
E(c) + E(c₀) ≥ κ R(c)
```

**Commits:**

```
730aa849b0d76b0202f08b490664aa11c164b2bf   (primary)
a762e7b76464656236075548343f596ab8bc6815   (NS application)
```

**Classification:** `STRUCTURAL`

---

### A-22 · Closure error from fiber information

**Architecture:** states c, c₀ ∈ π⁻¹(d) share the same observed state d but
have different projected dynamics due to the residual.

Conceptually important for comparing with later correction/residual-state schemes.

---

### A-23 · Formal LRE–NS closure in Millennium (sequence)

**Commit sequence 2025-12-18/19:**

```
b9b4768206ee3d817cbbaf35bb7da92dc835c4e1
0d601255e51be349a1fd38eacfcbd2fda17ced77
d1c29035c449cc213ac822afaeb3c213b04da39f
dfa3942f527f54ce92e61c9756052379b56e733e
b7e9fd22fb6ac794589e2ee65aeedf37f56e323e
b8b5c433b6f69b5676bdcbb9aa9c282e4af99881
```

Forensic value: sequential development + documentation + formalization + merges —
not a single isolated file.

---

### A-24 · Compression Barrier / critical residual obstruction

**Commits:**

```
54a13fedc2149f4368959d5694fd077010684f58
5a888677611ec79eb959f368e941699217487c2d
ce295769703fb8fc5d73e6427c2b9a3bf8ac3ce4
d2a98075f6fe5d4f01ece3757895fc1dee9360d7
```

Document information-loss from projection → formal closure barrier.

**Classification:** `STRUCTURAL`

---

## Tier B — Pre-LRE NS framework (November 2025 — chronological anchors)

### B-01 · NS framework in `millennium-navier-stokes-I`, 2025-11-23

**Commit:** `64bc633ecdb3a90ccfbf1c0863963c4bdd238d0f` — 2025-11-23

**Further commits:**

```
777d58e6f1eda3872a809492183ce432ead4f030
1cd176fa02d0827cff24f61cff24f61cff24f61c
079633d5f7af26576cc9baf0b911e5e0dbdb21f7
12f8b424646fba8e278a99f7cf350f3d2c7eb09e
63b248dd29f1817c457acdb00e116e2e9b0687cc
```

**Classification:** `CHRONOLOGICAL — NS WORK PREDATES LRE CLUSTER`

---

### B-02 · Classical NS in `millennium-navier-stokes-classical`, November 2025

**Commits:**

```
d853205ed10e33279327b759adc3135bcd2a262c
be02b6d0e080620eb948623734372699d84039f4
cca881c665f67c67d96a4f84371fb51cd9c858a0
dc55830546d50d66ccf602250c16c5c366dd4a30
867045e966812b50b2304f0460288cf6449d8221
```

**Contents:** T³, weak solutions, Sobolev/Besov, BKM, pressure/Riesz, scaling.

**Classification:** `PROVENANCE STRONG / DISTINCTIVENESS LOW`

---

## Tier C — Classical content (chronological but non-distinctive)

### C-01 · Self-similar blow-up profile

```
u(x,t) ≈ (T*-t)^{-α} U((x-x₀)/(T*-t)^β)
```

Present before September 2026; classical material.  
**Classification:** `CLASSICAL_GENERIC`

---

### C-02 · Critical H^{1/2} / L³ structures

Present before September 2026; classical regularity theory.  
**Classification:** `CLASSICAL_GENERIC`

---

### C-03 · Littlewood–Paley / spectral tail

```
‖u‖_{Ḣ^{1/2}}² ≃ Σ_j 2^j ‖Δ_j u‖_2²
w^(J) = Σ_{j≥J} Δ_j w
```

Bridge to high-frequency residual.  
**Classification:** `CLASSICAL + STRUCTURAL APPLICATION`

---

### C-04 · Forced Navier–Stokes

```
∂_t u + (u·∇)u - νΔu + ∇p = f
```

**Classification:** `CLASSICAL_GENERIC`

---

### C-05 · Pressure / Riesz machinery

```
m_{ij}(ξ) = -ξ_i ξ_j / |ξ|²
```

**Classification:** `CLASSICAL_GENERIC`

---

### C-06 · Maximal lifespan / T* / continuation criterion

Present in multiple repositories (November 2025 – August 2026).  
**Classification:** `PROVENANCE STRONG / DISTINCTIVENESS LOW`

---

### C-07 · Profile decomposition / critical element (August 2026)

**Repository:** `navier-stokes-noncircular`  
**Commit:** `8f12748eb160b937174825fe3e7bdccf05e8f9af` — 2026-08-30

Contains: profile decomposition, critical element, local-global bridge,
continuation, critical norm.

Close to September 2026 and based on classical literature.

---

### C-08 · Machine-auditable proof manuscript (before 2026-09-08)

**Commit:** `8f12748eb160b937174825fe3e7bdccf05e8f9af`  
**Message:** "Scaffold machine-auditable Navier-Stokes proof manuscript in LaTeX"

Contextual relevance: formal activity immediately before the OpenAI publication.

---

## Tier D — Distinctive elements: search in progress

### D-01 · OpenAI module families identified

Later public repository contains:

```
ReferenceJetBounds / JetBounds / ActualCurrentCarrierJets
ActualPhaseJetBounds / CorrectionInitialization / CorrectionState
CorrectionStep / CorrectionAnalyticStep / ActualCorrectionModels
residual/error modules / stress hierarchy / pressure/Riesz
energy / forcing/localization
```

**Architectural comparison:**

```
Prior side:  projection → residual → K → closure/correction → critical jets
OpenAI side: reference/current jets → correction hierarchy → stress/error → forcing
```

Status: parallel architectures identified; integral identity not yet established.

---

### D-02 · Exact ReferenceJet construction — NOT_ESTABLISHED

`critical jets` found (A-11, A-12); exact OpenAI `ReferenceJet` construction not
yet matched in prior corpus.  
**Status:** `NOT_ESTABLISHED`

---

### D-03 · Iterative NS correction — NOT_ESTABLISHED

Target formulas:

```
u^{(n+1)} = u^{(n)} + C_n
R^{(n+1)} = R^{(n)} + L(C_n) + N(C_n, u^{(n)})
```

Prior `u_{n+1}` found was a shell index, not an iteration index.  
**Status:** `NOT_ESTABLISHED`

---

### D-04 · Stress correction hierarchy — NOT_ESTABLISHED

Target:

```
S_n → C_n → S_{n+1}   or   ∇·S = R
```

Found: Reynolds stress = residual coupling (A-08, A-09). Full iterative
hierarchy not yet matched.  
**Status:** `NOT_ESTABLISHED`

---

### D-05 · Engineered forcing cancellation — NOT_ESTABLISHED

Target:

```
f := ∂_t u + (u·∇)u - νΔu + ∇p   constructed so that F = -R
```

Prior material has forced NS (C-04) but not this specific constructive
architecture.  
**Status:** `NOT_ESTABLISHED`

---

### D-06 · Primitive / cutoff activation — NOT_ESTABLISHED

OpenAI uses specific activation/cutoff/primitive constructions.  
Prior: bump functions, Taylor integral remainder, analysis material present.  
Exact combination not yet found.  
**Status:** `NOT_ESTABLISHED`

---

### D-07 · Moment repair machinery — NOT_ESTABLISHED

**Status:** `NOT_ESTABLISHED`

---

### D-08 · Volterra / analytic recursive machinery — NOT_ESTABLISHED

**Status:** `NO_MATCH_FOUND`

---

## Summary chain (currently established)

```
P_Λ → u_h → R_Λ → residual dynamics → K(R, π(u)) → Reynolds stress
     → closure obstruction → critical jets
```

Git records: **November – December 2025**

---

## Probationary conclusions (current state)

| Claim | Status |
|-------|--------|
| Documentary precedence | **DEMONSTRATED** |
| Relevant structural overlap | **DEMONSTRATED** |
| Multiple NS-specific components pre-existing in 2025 | **DEMONSTRATED** |
| Access / copying / derivation by OpenAI | **NOT_DEMONSTRATED** |

The four missing links that would most strengthen the causal hypothesis:
**iterative correction** (D-03), **stress correction hierarchy** (D-04),
**engineered forcing cancellation** (D-05), and
**exact carrier/reference jets** (D-02).
