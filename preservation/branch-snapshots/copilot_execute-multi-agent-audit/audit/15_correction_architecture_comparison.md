# 15 — Correction-Architecture Comparison: Prior Corpus vs OpenAI/NavierStokes

## Purpose

This document records the detailed structural comparison between the Fagliari
(ShantiDraconis) prior-work corpus of December 2025 and the OpenAI
`NavierStokesAndEuler` repository published 2026-09-08.  It supersedes informal
notes and makes each claim auditable against a specific commit SHA and file.

**Methodological boundary:** this comparison documents structural overlap and
chronological anteriority only.  It does **not** infer causal derivation, access,
or copying without direct causal evidence.

---

## 1. Primary anchors for the LRE-NS core (18 December 2025)

The oldest confirmed anchor for the full LRE-NS nucleus is:

| SHA (short) | Full SHA | Timestamp | Message |
|---|---|---|---|
| `b033ea87` | `b033ea87fca138224200dd1acf2cf4043315f846` | 2025-12-18T20:26:33Z | Add comprehensive LRE-NS framework with LaTeX dossiê and formal proofs |
| `30bf8c53` | `30bf8c53008c548a8a9dada3fd69d6d2b2b1df2c` | 2025-12-18T20:28:57Z | First commit of `docs/navier-stokes-lre-framework.md` |
| `a992d144` | `a992d144c235572ac2b7413b015e58535a864a41` | 2025-12-18T21:03:13Z | Implement LRE-NS formal closure framework with all theorems |
| `63cc2b21` | `63cc2b2180b9fc9b68e2b1c69d4fc0cf8bd3d169` | 2025-12-18T21:06:41Z | Revision: zero-frequency handling / reproducibility |
| `4cdb6a61` | `4cdb6a61ae7a9189eab551b1099895578a8fbb56` | 2025-12-18T21:07:43Z | Add comprehensive LRE-NS implementation summary |

Commit `b033ea87` introduces:

$$\pi:X\to\mathbb{R}^2,\qquad R:X\to\mathbb{R}$$

with projection, critical residual, fibers with differing residuals, and
compression barrier.

Commit `a992d144` is the introduction commit of `latex/lre_ns_formal_closure.tex`
confirmed by path-history API.  Commit `4cdb6a61` introduces `LRE_NS_SUMMARY.md`,
which contains the phrase **"Microlocal analysis of critical jets"**, confirmed by
single-commit path history.

$$\boxed{
  \text{CRITICAL JETS provenance anchor} = \texttt{4cdb6a61},\;
  18/12/2025\;\text{21:07 UTC}
}$$

---

## 2. CouplingOperator — anchor for (residual, current state) → dynamical correction

**File:** `formalization/lean/LRE/CouplingOperator.lean`
**Repository:** `ShantiDraconis/universal-emergent-logic-`

| SHA | Timestamp | Message |
|---|---|---|
| `f7f414d2` | 2025-12-19T13:56:01Z | Implement LRE geometric foundation: fiber bundles, curvature, and closure theorem |

Path-history API shows a **single** commit for this file.  The file formalises:

$$K:\mathbb{R}\times D\to D$$

with the explicit description: **"K takes the residual magnitude and current
observable state, and produces a correction to the dynamics."**

This yields the dynamical law:

$$\frac{d}{dt}\pi(u)=F(\pi(u))+K(R(u),\pi(u)).$$

$$\boxed{
  \text{COUPLING OPERATOR anchor} = \texttt{f7f414d2},\;
  19/12/2025\;\text{13:56 UTC}
}$$

---

## 3. Reference Section — anchor for c₀, R(c₀) = 0

**File:** `docs/lre-navier-stokes-geometric.md`
**Repository:** `ShantiDraconis/universal-emergent-logic-`

| SHA | Timestamp | Role in path history |
|---|---|---|
| `730aa849` | 2025-12-19T17:17:28Z | Introduction commit |
| `f30ef6a9` | 2025-12-19T17:22:45Z | Revision commit |

The file contains:

$$R(u)=0\iff u\in H_N$$

and a section explicitly titled **"The Reference Section"** with:

$$c_0\in\pi^{-1}(d),\qquad R(c_0)=0.$$

$$\boxed{
  \text{REFERENCE SECTION anchor} = \texttt{730aa849},\;
  19/12/2025\;\text{17:17 UTC}
}$$

---

## 4. Additive high-frequency perturbation — anchor for φ → φ + εv

**File:** `formalization/lean/LRE/NavierStokes/PROOF_ARCHITECTURE.md`
**Repository:** `ShantiDraconis/universal-emergent-logic-`

| SHA | Timestamp | Role |
|---|---|---|
| `2854eaf7` | 2025-12-19T20:24:44Z | Introduction commit |
| `e7f2e95e` | 2025-12-20 | Revision commit |

The file introduces:

$$\phi_{\text{new}}=\phi+\varepsilon v,\qquad P_\Lambda(v)=0$$

and proves:

$$P_\Lambda(\phi+\varepsilon v)=P_\Lambda(\phi)$$

so the projection is invariant but the full field differs.  This is a genuine
NS-level additive high-frequency perturbation schema, used to prove
non-injectivity / closure obstruction.

$$\boxed{
  \text{ADDITIVE HF PERTURBATION anchor} = \texttt{2854eaf7},\;
  19/12/2025\;\text{20:24 UTC}
}$$

---

## 5. Full prior-work chain: 18–19 December 2025

The ordered sequence of confirmed file-level introduction commits is:

$$
b033ea87 \;\xrightarrow{+2\text{m}}\; 30bf8c53 \;\xrightarrow{+34\text{m}}\;
a992d144 \;\xrightarrow{+3\text{m}}\; 4cdb6a61
$$
*(18/12/2025 — Millennium repo)*

$$
f7f414d2 \;\xrightarrow{+3\text{h}}\; 730aa849 \;\xrightarrow{+5\text{m}}\;
f30ef6a9 \;\xrightarrow{+3\text{h}}\; 2854eaf7
$$
*(19/12/2025 — universal-emergent-logic- repo)*

Complete antecedent formulated by the audit:

$$
\boxed{
\begin{aligned}
u &\to P_\Lambda u,\\
u_h &= (I-P_\Lambda)u,\\
R &= R(u_h),\\
c_0 &= \text{reference section, }R(c_0)=0,\\
u &\to u+\varepsilon v_h,\\
R &\to K(R,\text{current state}),\\
K &\sim \text{Reynolds-stress coupling},\\
\dot{\pi(u)} &= F(\pi(u))+K(R,\pi(u)).
\end{aligned}
}
$$

---

## 6. Comparison with OpenAI/NavierStokes construction

### 6.1 OpenAI CorrectionStep.lean

The OpenAI file `NavierStokes/CorrectionStep.lean` (public anchor SHA
`8937a8f4cbc7abaab5e9e97d1cc7f5d2319d9538`, date 2026-09-08) is described as
**"Exact field bookkeeping for one correction cycle"** and uses:

$$m_{\text{new}}=\operatorname{updated}(m,h),\qquad W_{\text{new}}=W+X$$

with residual difference:

$$R(m+h,W+X)-R(m,W)=\operatorname{fastTime}(h)+\operatorname{remainder}(m,h)+\operatorname{covarianceChange}(X).$$

### 6.2 Structural ranking

| Rank | Prior antecedent (ShantiDraconis) | OpenAI counterpart | Degree |
|---|---|---|---|
| 1 | `K(R,d)`: residual + current state → dynamical correction (`f7f414d2`, 19/12/2025) | `CorrectionStep.CycleState` + increments → corrected state | **VERY STRONG STRUCTURAL** |
| 2 | `φ_new = φ + εv`, v high-frequency perturbation (`2854eaf7`, 19/12/2025) | `updated(m,h)`, `m_new = m + h` | **STRONG STRUCTURAL / ALGEBRAIC ADDITIVE** |
| 3 | Reynolds stress = residual coupling; `K(R) ~ stress` | covariance increment `X` → residual change via `covarianceChange(X)` | **STRONG STRUCTURAL** |
| 4 | Reference Section `c₀`, `R(c₀)=0` (`730aa849`) + critical jets (`4cdb6a61`) | `ReferenceJetBounds.lean` / `section ReferenceJets` in `PhaseJetBounds.lean` | **MODERATE–STRONG STRUCTURAL** |
| 5 | spectral projection `P_Λ` + unresolved component `(I-P_Λ)u` | carrier / current spectral structures | **STRUCTURAL** |
| 6 | discrete residual recurrence RBC: `R_{n+1}-R_n ≥ α R_n³` | correction-cycle residual ledger | **ABSTRACT ALGEBRAIC ONLY** |
| 7 | forced NS / nonlinear forcing from resolved scales | engineered forcing modules | **GENERIC / PARTIAL** |
| 8 | cutoff `P_Λ`, `|ξ|≤Λ` | `StressActivation` / `TransitionRamp` | **WEAK STRUCTURAL** |
| 9 | conservation of momentum (classical) | `MovingMomentBounds` / moment repair | **NO SPECIFIC MATCH** |

---

## 7. Similarity rationale for Rank 1 pair

**Prior side:** `CouplingOperator.lean` defines $K:\mathbb{R}\times D\to D$
and the projected evolution:

$$\dot\pi(u)=F(\pi(u))+K(R(u),\pi(u)).$$

The residual serves as the observable deficit; the coupling operator converts it
into a dynamic correction applied to the projected flow.

**OpenAI side:** `CorrectionStep.lean` maintains `CycleState` containing the
current field, covariance, and residual estimate.  One correction cycle:
(i) applies an increment field `h`, (ii) updates covariance by `X`, (iii)
computes the full residual difference.

**Shared logic:** both organize state as (current observable, residual) and
define a mechanism to produce a corrected state from the residual.

**Essential difference:** the prior side uses a continuous projected ODE; the
OpenAI side is a discrete bookkeeping step.  The purpose also differs: the prior
uses `φ+εv` to prove non-injectivity; the OpenAI `m+h` is a constructive
correction step.

Classification: `STRUCTURAL_VERY_STRONG` — not `EXACT_DISTINCTIVE`.

---

## 8. Similarity rationale for stress/covariance pair (Rank 3)

Prior corpus states in multiple places:

- **"Reynolds stress = residual coupling"**
- **"R(u) = high frequencies, K(R) = Reynolds stress"**
- Python: **"The residue is the Reynolds stress tensor."**

OpenAI `CorrectionStep.lean` decomposes the residual difference as:

$$\theta\text{CovarianceChange}(X),\quad
  \text{axialCovarianceChange}(X),\quad
  \text{radialCovarianceChange}(X).$$

These covariance increments enter directly into the old/new residual difference.

Chain comparison:

| | Chain |
|---|---|
| Prior | unresolved/HF → `R` → Reynolds stress → `K` → dynamical correction |
| OpenAI | `X` = covariance increment → covariance/stress change → residual change |

Classification: `STRESS_RESIDUAL_CORRECTION_STRONG`.

---

## 9. NOT FOUND or NOT MATCHED items

The following OpenAI-specific constructions were searched in the prior corpus and
were **not** matched at the distinctive-construction level:

| OpenAI construct | Search result | Status |
|---|---|---|
| Full old/new NS residual ledger: `R_{q+1} - R_q = all cross terms` | Not found; closest: `φ→φ+εv`, `π̇ = F+K`, `R_{n+1}-R_n ≥ αR_n³` (RBC context) | `NOT_FOUND` |
| `MovingMomentBounds` + mean/defect/wave increments + gauge debt | Only classical momentum conservation found | `NO_MATCH` |
| `StressActivation` / `TransitionRamp` / `ActivationHolomorphic` | Cutoff `P_Λ` found; stress-activation primitive machinery not matched | `NOT_MATCHED` |
| Engineered forcing cancellation `f_correction = -Residual` | Residual feedback coupling and oscillatory forcing found; precise cancellation definition not found | `NOT_ESTABLISHED` |
| Full reference-jet structure uniting `c₀` and jet hierarchy in one formal object | `c₀` (reference section) and critical jets exist **separately**; not unified in one jet structure | `SEPARATE_PRECURSORS` |
| `CorrectionStep.CycleState` as a discrete algebraic type with typed increment fields | Continuous ODE formulation `K(R,d)` found; no matching discrete CycleState record type | `NOT_FOUND` |

---

## 10. Auditable summary of strengths and limits

### What this audit can now assert

1. By 18 December 2025 there existed a documented LRE-NS framework containing
   projection, critical residual, compression barrier, and critical jets.
2. By 19 December 2025 there existed:
   - a formal coupling operator `K(R,d) → dynamical correction`,
   - an explicit reference section `c₀` with `R(c₀)=0`,
   - an additive high-frequency perturbation `φ+εv` in a NS context.
3. The structural overlap between the prior architecture and the OpenAI
   correction-cycle architecture is **strong at the programmatic level** for
   items ranked 1–3 in the table above.
4. The Reynolds-stress / residual-coupling language is materially similar to the
   covariance-increment / residual-change language in `CorrectionStep.lean`.

### What this audit cannot assert

1. That OpenAI accessed, read, or derived from any prior private repository.
2. That the distinctive discrete CycleState bookkeeping is present in the prior corpus.
3. That `c₀` and critical jets were unified into a single formal jet structure.
4. That a full iterative `R_{q+1} - R_q` residual ledger exists in the prior corpus.
5. Causal derivation, plagiarism, or prize entitlement.

---

## 11. Evidentiary-tier status of anchors in this document

All new anchors above are currently **Tier 2 (reported)** — confirmed by
path-history API responses.  They require independent diff/tree export or
notarised archival capture to be elevated to **Tier 1 (independently verified)**
within this audit's evidence standards.

See `priority/08_expanded_git_provenance_dossier.md` and
`evidence/commits.yaml` for the full commit registry.
