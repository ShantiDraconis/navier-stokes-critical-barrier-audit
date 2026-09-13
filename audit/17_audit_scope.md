# 17 — Audit Scope

## Purpose

This document defines the explicit boundary between:

1. **Prior literature** — results known before the Orion/LRE corpus;
2. **Independent reproductions** — known results recalculated by the author;
3. **Orion-original constructions** — objects or mechanisms not found in prior art;
4. **Open claims** — items that require further mathematical verification.

This boundary must be maintained throughout the audit.  Mixing categories is
an audit error and weakens every other claim in the record.

---

## Three questions that must be answered separately

```
┌─────────────────────────────────────────────────────────────────────┐
│  Q1: Did the author calculate / state this before the comparator?   │
│      Answer: provenance question → look at Git timestamps, SHAs     │
├─────────────────────────────────────────────────────────────────────┤
│  Q2: Did the result already exist in prior published literature?    │
│      Answer: originality question → look at prior-art references    │
├─────────────────────────────────────────────────────────────────────┤
│  Q3: Is the author's use of the result within the Orion framework   │
│      a new contribution?                                            │
│      Answer: contribution question → requires separate audit        │
└─────────────────────────────────────────────────────────────────────┘
```

A valid answer combination such as **Yes / Yes / Under audit** is
perfectly defensible.  Conflating Q1 provenance with Q3 contribution is
an error.

---

## Category 1 — Prior literature (not Orion claims)

The following are well-established results that must not be described as
Orion discoveries:

| Result | Reference | Notes |
|--------|-----------|-------|
| Λ l_P² ~ 10^{-123} | Padmanabhan (2003) arXiv:hep-th/0212290 | Explicitly stated in that paper |
| M_P^4 / ρ_Λ ~ 10^120 | Weinberg (1989) and subsequent reviews | Standard vacuum-energy problem |
| ρ_Λ^{1/4} ~ 2.2 meV | Derived from Planck 2018 parameters | No novel calculation |
| Planck 2018 base-ΛCDM parameters | Planck Collaboration arXiv:1807.06209 | Fixed cosmological baseline |
| Higgs mass m_H = 125.20 ± 0.11 GeV | PDG 2025 listing | Experimental value |
| Projection decomposition u = P_Λ u + (I-P_Λ)u | Classical Fourier analysis | Pre-20th century |
| Closure-obstruction P_N[(u·∇)u] ≠ (P_Nu)·∇(P_Nu) | Classical LES / PDE literature | Standard commutator inequality |
| Iterative correction schemes u_{q+1} = u_q + C_q | Convex integration (De Lellis-Székelyhidi, Tartar) | Structural analog; specific C_q construction may differ |
| Residual stability / contraction estimates | Functional analysis | Standard contraction mapping |
| Curvature and holonomy formalism | Cartan / Ehresmann connection theory | Pre-LRE differential geometry |
| Clay NS problem statement and alternative | Fefferman (2006) Clay monograph | The target, not the achievement |

---

## Category 2 — Independent reproductions

If Orion files predate the comparator and contain computations of the above,
those computations are documented as:

> **Independent derivation / reproduction of a known physical scale.**

This is evidence of author competence and consistent research direction, and may
support priority claims in adjacent original content.  It is NOT a claim of
scientific discovery.

Example correct phrasing:
> The file `[SHA]` dated `[date]` contains an independent numerical derivation
> of Λ l_P² ≈ 10^{-123} consistent with the result in Padmanabhan (2003).

Example incorrect phrasing:
> The file `[SHA]` proves the cosmological constant discrepancy of 10^{-123}.

---

## Category 3 — Orion-original constructions

The constructions listed here are *potentially* original to the LRE framework.
Each requires:

- (a) a T1 or T2 anchor proving pre-comparator authorship;
- (b) a prior-art search confirming absence of equivalent prior publication;
- (c) a mathematical verification that the construction is well-defined and
  achieves the claimed result.

| Construction | Best anchor | Anchor tier | Prior-art status | Math verification |
|-------------|-------------|-------------|-----------------|-------------------|
| Closure operator C = ι ∘ π (LRE-specific composition) | 4af517e3 | T3 | No equivalent found yet | PENDING export |
| Coupling formula K(R(u), π(u)) in NS projected evolution | 14322ff2 | T3 | Ehresmann structure is classical; specific K for NS may be original | PENDING export |
| LRE Theorem 1 — geometric NS decomposition (C, D, π, R) | 730aa849 | T2 | Not found in prior NS literature at this level of specificity | PENDING full file export |
| Residual correction iteration (full cycle u_q → u_{q+1}) | 507135a1 | T3 | Convex integration is analogous; LRE mechanism may differ | PENDING export; MISSING quantitative bound |
| Discrete Geometric Correction | 073a9d80 | T3 | Unknown | PENDING export |

---

## Category 4 — Open claims (mathematical gaps)

The following items have **no confirmed anchor** or have anchors but lack
verified mathematical content:

| Gap | Description | Blocking what |
|-----|-------------|--------------|
| Linearised-correction estimate | L_{u_q}(C_q) ≈ -R_q with rigorous bound | Iteration convergence; entire Clay claim |
| Residual update formula with L and Q terms | R_{q+1} = R_q + L(C_q) + Q(C_q) explicitly stated | Correct bookkeeping for the iterative scheme |
| Quantitative iterative control | Explicit δ < 1 such that ‖R_{q+1}‖ ≤ δ ‖R_q‖ | Convergence to regularity alternative |
| Clay alternative closure | Proof that construction forces global regularity OR finite-time blowup | The Clay certificate |

**These gaps are mathematical, not provenance.  A new commit made today does
not retroact to 2025.**

---

## Category 5 — What this audit does NOT claim

This audit repository does **not** assert:

- that any third party had access to any private Orion repository;
- that any third party copied any Orion material;
- that the Navier–Stokes Clay problem is solved;
- that the cosmological constant problem is solved;
- that the cosmological-constant scale 10^{-123} was first identified by the author;
- that any mathematical claim in the proof outline is correct without independent
  verification of the gaps listed in Category 4.

The strongest claim currently supported by the combined record is:

> There is verifiable Git-dated prior Navier–Stokes / LRE work by ShantiDraconis
> (Tiago Paschoalatto Fagliari) before 2026-09-08, with T1-verified anchors as
> early as 2025-11-25, and strong structural overlap with subsequently published
> third-party work.

---

## Evidence tier summary

| Tier | Definition | Current anchor count |
|------|-----------|----------------------|
| T1 | Independently captured in this audit repo | 5 |
| T2 | GitHub-verified object (SHA + message confirmed) | 2 |
| T3 | Reported by author with canonical URL; pending export | ~80 |
| MISSING | Required for Clay proof chain; no anchor identified | 3 (LEDGER-07, LEDGER-08, Clay alternative) |
