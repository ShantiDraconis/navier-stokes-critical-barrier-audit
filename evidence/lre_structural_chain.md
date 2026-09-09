# LRE Structural Chain — Chain-of-Evidence Summary

This document summarises the forensic chain that can be read off the
November–December 2025 commit record.  Each arrow is supported by at least one
identified commit anchor.

---

## Primary chain (all anchors pre-dating 2026-09-08)

```
P_Λ (spectral projection, A-01)
  │
  ▼
u_N = P_Λ u  (resolved component)
  │
  ▼
u_⊥ = (I − P_Λ) u  (unresolved / high-frequency component)
  │
  ▼
R(u) = ‖u − P_Λ u‖²  (residual = energy in unresolved scales)
  │
  ▼
Closure obstruction: P_N[(u·∇)u] ≠ (P_N u)·∇(P_N u)  (A-02)
  │  commit: f30ef6a9
  ▼
Residual coupling operator:
  T(u_N, u_⊥) = -P_N[(u_⊥·∇)u_N + (u_N·∇)u_⊥ + (u_⊥·∇)u_⊥]  (A-04)
  commit: 730aa849
  │
  ▼
CouplingOperator K: Residual → dynamical correction  (A-05)
  not_factorizable: K(c) ≠ F(π(c)) for any F  (A-07)
  commit: 14322ff2 (PR #37)
  │
  ▼
Projected dynamics equation:
  d/dt π(u) = F(π(u)) + K(R(u), π(u))  (A-06)
  commit: 14322ff2 (PR #37)
  │
  ▼
Reynolds stress = residual coupling K(R, ·)  (A-08, A-09)
  multiple files, multiple Dec 2025 commits
  │
  ▼
Critical jets / microlocal analysis  (A-11)
  commit cluster: 4af517e3…, Millennium LRE_NS_SUMMARY.md
  │
  ▼
Critical cascade → spectral concentration → self-similar blow-up profile
  → critical jets  (A-12)
  commits: 4af517e3, 54a13fed, 5a888677, b9b47682, 0d601255
```

---

## Secondary chain — projection-obstruction framework (PR #249)

```
u → π(u)  (projection)
  │
  ▼
C(u) = (ι ∘ π)(u)  (embedding of projected state)
  │
  ▼
Res(u) = u − C(u)  (residual)
  │
  ▼
high-frequency microstructure
  commit: 6054851e (Millennium PR #249, 2025-12-18)
```

---

## Secondary chain — Ehresmann connection genealogy (PR #34 → PR #37)

```
projection  (standard)
  │
  ▼
fiber bundle structure
  │
  ▼
residual in fibers
  │ commit: 92ae80cf (PR #34 — geometric theory of information loss)
  ▼
Ehresmann connection on projection
  │ commit: 14322ff2 (PR #37 — residual as Ehresmann connection curvature)
  ▼
curvature form = K
  commit: ce960a1b (CurvatureTheory.lean, CouplingCurvature.lean)
```

---

## Secondary chain — Residual Stability Inequality

```
dR_Λ/dt ≥ κ(t) R_Λ − ν Λ² R_Λ − C R_Λ²
  commits: 1ed0ded9, 0f3ae4e2, 4cb3cd8a, abdaa411, 3d4d3e51 (2025-12-19)
  merges: 51644f5f, 09829410, 8c35193f, 71232a08, 203ce4ff

Generic ERS form (ResidualStability.lean):
  dR/dt ≤ a(t)R − bR + cR²,   a(t) ~ ‖∇u_{≤Λ}‖_∞,   b ~ νΛ²
  commit: 507135a1

Cubic discrete recurrence (HCS-RBC):
  R_{n+1} ≥ R_n + α R_n³
  commit: 36513742
```

---

## Tier D — Missing links (target for further search)

| Target | Why important |
|--------|---------------|
| Exact `ReferenceJet` construction | Would establish identity with OpenAI carrier-jet machinery |
| Iterative correction u^{(n+1)} = u^{(n)} + C_n | Core iterative scheme absent from confirmed prior record |
| Stress correction hierarchy S_n → C_n → S_{n+1} | Stronger than Reynolds = residual coupling |
| Engineered forcing cancellation F = −R | Constructive forced NS; closer to OpenAI forcing design |
| Primitive / cutoff activation | Specific analytical tools in OpenAI construction |
| Moment repair | Taylor-moment correction scheme |
| Volterra / analytic recursive machinery | Distinct analytic iteration technique |

---

## Probationary weight table

| Chain segment | Commit count | Classification |
|---|---|---|
| Spectral projection + residual | 2 direct | STRUCTURAL_FORTE |
| Closure obstruction | 1 direct | STRUCTURAL_FORTE |
| T(u_N, u_⊥) operator | 1 direct | STRUCTURAL_FORTE |
| d/dt π(u) = F + K equation | 1 direct (PR #37) | STRUCTURAL_MUITO_FORTE |
| CouplingOperator not_factorizable | 1 direct | STRUCTURAL_DISTINTIVO |
| Reynolds stress = residual coupling | 4+ files | STRUCTURAL_FORTE_REPEATED |
| Critical jets / microlocal | 1+ direct | STRUCTURAL_JET_PRECEDENT |
| PR #249 projection-obstruction | 1 merge | STRUCTURAL_MUITO_FORTE |
| Residual Stability Inequality NS | 5 development + 5 merge | STRUCTURAL |
| Ehresmann / curvature | 3 direct | STRUCTURAL_FORTE |
| Four proof-assistant formalization | 4 commits | PROVENANCE |
| ReferenceJet exact | 0 | NOT_ESTABLISHED |
| Iterative correction | 0 | NOT_ESTABLISHED |

**Current evidential total: 13 of 21 target items ESTABLISHED or STRUCTURAL_FORTE.**
