# 16 — universal-emergent-logic- : Formula Index

**Source repository:** `ShantiDraconis/universal-emergent-logic-`  
**Purpose:** index every formula family reported in the UEL commit chain, with anchor SHA, layer classification, and cross-reference to the public comparator.

---

## Index

### F1 — Law of Structural Residue (Fundamental decomposition)

**Formula family:**

$$u = C(u) + D(u) \qquad C(u) = \pi(u) = P_N u \qquad D(u) = R(u) = (I-P_N)u$$

$$\text{Res}(u) = u - C(u) = R(u)$$

**Anchor commit:** `29e6d1f3a03d39a904fcde7694e3599d8716e8b0` (D1, reported 2025-12-19)  
**Additional anchors:** `c46ce3f`, `46b2799`, `0853ab6`, `c28f84e`  
**Verification:** REPORTED (earliest anchor: 2025-12-19)  
**Cross-reference to public comparator:** Frequency truncation / Galerkin projection splits are standard. The specific C/D/π/R four-letter encoding and naming is distinctive to the LRE framework. Awaiting file-level export to compare naming convention directly with `openai/NavierStokesAndEuler`.

---

### F2 — LRE Axioms

**Formula family:** Axioms reportedly including:
- Residue existence and uniqueness
- Compression map C: X → Y
- Complementarity: C(u) + R(u) = u
- Residue minimality condition

**Anchor commit:** `b457b06584c49554af65b92196860479c33a8276` (D1, reported 2025-12-19)  
**Lean encoding:** confirmed by message "LRE axioms + Lean + applications"  
**Isabelle/HOL encoding:** `5a6dd104` — LRE + Isabelle/HOL  
**Verification:** REPORTED

---

### F3 — Fiber bundle / closure theorem scaffold

**Formula family:** Fiber bundle structure with curvature and closure theorem scaffolding. Specific formulas not yet captured; requires tree export.

**Anchor commit:** `f7f414d2ea66fa7a04d4de390f0e9357dfd980ae` (D1, reported 2025-12-19)  
**Verification:** REPORTED  
**Relevance:** pre-dates D2 Ehresmann formalization; establishes geometric vocabulary at the foundation layer.

---

### F4 — Projected evolution law with residual coupling

**Formula family:**

$$\frac{d}{dt}\pi(u) = F(\pi(u)) + K(R(u), \pi(u))$$

where `F` is the projected NS dynamics and `K` is the residual coupling operator.

**Anchor commits:**
- `ce960a1ba8ce7a893d645131d12d1a7ab06eddd9` (D2) — CurvatureTheory + CouplingCurvature
- `f2feb3a3ed3c1e7f42582b78cbb899dbd5fdd9e7` (D2) — LRE quantitative dynamics

**Verification:** REPORTED  
**Cross-reference:** This evolution law is structurally analogous to a Reynolds-stress correction in turbulence modeling, but formulated in LRE geometric language. It is a key formula for any NS closure argument.

---

### F5 — Ehresmann curvature identification

**Formula family:**

$$R(u) \equiv \text{Ehresmann connection curvature} \quad \Leftrightarrow \quad K(R(u),\pi(u))$$

$$\text{Curv}(\omega)(\xi,\eta) = d\omega(\xi,\eta) + [\omega(\xi),\omega(\eta)]$$

**Anchor commit:** `14322ff2e8f38df302c6f2f6b41754db79d5a900` (D2) — Merge PR #37  
**Additional anchor:** `b6f656254e0933a596613e285cccc06cd316edee` (D2) — explicit residue, curvature, holonomy  
**Verification:** REPORTED  
**Cross-reference:** Holonomy / Ehresmann language has not been identified in the public comparator; this may be a distinctive construction feature of the LRE framework.

---

### F6 — Navier–Stokes closure obstruction (nonlinearity non-commutativity)

**Formula family:**

$$P_N[(u\cdot\nabla)u] \neq (P_N u)\cdot\nabla(P_N u)$$

Equivalently, the commutator:

$$[P_N, (u\cdot\nabla)] \neq 0$$

**Anchor commit (GitHub-verified):** `730aa849b0d76b0202f08b490664aa11c164b2bf` (D3)  
**File created:** `docs/lre-navier-stokes-geometric.md`  
**Verification:** GITHUB_VERIFIED (for SHA; file content pending export)  
**Cross-reference:** This is a well-known PDE fact. The claim is not of exclusive discovery, but of documented organization of this fact within the LRE framework before 2026-09-08.

---

### F7 — Cross-frequency interaction tensor (LRE transfer operator)

**Formula family:**

$$\mathcal{T}(u_N, u_\perp) = -P_N\!\left[(u_\perp\cdot\nabla)u_N + (u_N\cdot\nabla)u_\perp + (u_\perp\cdot\nabla)u_\perp\right]$$

This captures all nonlinear cross-scale interactions excluded by the truncation.

**Anchor commit (GitHub-verified):** `730aa849b0d76b0202f08b490664aa11c164b2bf` (D3)  
**Additional anchor:** `a762e7b76464656236075548343f596ab8bc6815` (D3) — Quantitative Obstruction formalization  
**Verification:** GITHUB_VERIFIED (for SHA; formula content pending file export)  
**Cross-reference:** The three-term cross-interaction split `(u_⊥·∇)u_N + (u_N·∇)u_⊥ + (u_⊥·∇)u_⊥` is structurally analogous to the energy-transfer decomposition in the turbulence literature. Its specific LRE encoding and naming as `T` is distinctive.

---

### F8 — Residual Stability Inequality

**Formula family (reported):**

$$\frac{d}{dt}\|R(u(t))\|^2 \leq -\alpha\|R(u)\|^2 + \beta\,\|R(u)\|\cdot f(\|u\|,\|\nabla u\|,\ldots)$$

Three-phase structure:
- Phase 1: basic L² estimate
- Phase 2: intermediate Sobolev coupling
- Phase 3: full inequality with coupling terms

**Anchor commits:**
- `1ed0ded98d26966189fc5936914fd964d42cbd7a` (D4) — NS Residual Stability Inequality
- `0f3ae4e275068f81f516b45b14289dd1a699e659` (D4) — Phase 1–3 residual stability
- `3d4d3e51866e03420e97ff3b21dde2a1fca1cc4d` (D4) — Complete NS Residual Stability
- `203ce4ff62809fbcf403ee03e89c3bc70ed608ec` (D4) — Merge PR #54 Residual Stability Lean

**Verification:** REPORTED  
**Cross-reference:** Standard energy-method inequalities are classical. The specific LRE residual functional `R(u) = ‖u − P_N u‖²` as the subject of a stability inequality is the distinctive component.

---

### F9 — NS κ-reformulation

**Formula family (reported):**

$$\partial_t u + (u\cdot\nabla)u + \nabla p = \nu\Delta u + \kappa(\pi(u), R(u))$$

where `κ` is the residual coupling coefficient encoding the LRE transfer.

**Anchor commit:** `2ceba2ac14e9541561d76307af538ed91817c2af` (D5) — NS κ reformulation  
**Verification:** REPORTED  
**Cross-reference:** The explicit introduction of a residual coupling coefficient `κ` into the NS momentum equation is a distinctive LRE-specific reformulation.

---

### F10 — ODE ResidualStability (reduced model)

**Formula family (reported):** ODE reduction of the residual stability problem:

$$\dot{r} = -\alpha r + g(t,r,c) \qquad r = R(u),\quad c = C(u)$$

**Anchor commit:** `507135a16a64116e7baf15154e03dc40740b08bb` (D4) — LRE meta-framework + ODE ResidualStability  
**Verification:** REPORTED

---

## Formula-level audit status

| Formula | Verified anchor | Content verified | Cross-ref to public | Action |
|---------|----------------|-----------------|---------------------|--------|
| F1 — LSR decomposition | SHA `29e6d1f` (reported) | NO | PENDING | Export D1 files |
| F2 — LRE axioms | SHA `b457b06` (reported) | NO | PENDING | Export Lean file |
| F3 — Fiber bundle / closure | SHA `f7f414d` (reported) | NO | PENDING | Export D1 tree |
| F4 — Projected evolution law | SHA `ce960a1` (reported) | NO | PENDING | Export D2 files |
| F5 — Ehresmann curvature | SHA `14322ff` (reported) | NO | PENDING | Export D2 diff |
| F6 — Closure obstruction | SHA `730aa849` (GH-verified) | NO | PENDING | Export `docs/lre-navier-stokes-geometric.md` |
| F7 — Transfer tensor T | SHA `730aa849` (GH-verified) | NO | PENDING | Export `docs/lre-navier-stokes-geometric.md` |
| F8 — Residual Stability Ineq | SHA `1ed0ded` (reported) | NO | PENDING | Export D4 files |
| F9 — κ-reformulation | SHA `2ceba2a` (reported) | NO | PENDING | Export D5 files |
| F10 — ODE ResidualStability | SHA `507135a` (reported) | NO | PENDING | Export D4/meta file |

**No formula has yet been content-verified from exported file text.**  
All "content verified = NO" rows require the archival actions listed in `evidence/user_prior_work/uel_verification_table.md`.
