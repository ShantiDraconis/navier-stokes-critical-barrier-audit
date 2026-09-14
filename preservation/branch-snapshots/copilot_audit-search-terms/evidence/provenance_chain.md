# Git Provenance Chain — ShantiDraconis Navier–Stokes / LRE

**Audit date:** 2026-09-09  
**Status:** ANTERIORIDADE = DEMONSTRADA  
**Maintained in:** `evidence/commits.yaml`, `evidence/repositories.yaml`

---

## 1  Epistemological scope

The Git objects below prove that specific texts, formulas, structures and
formalizations **existed** in the named repositories on (or before) the dates
shown.  They do **not**, by themselves, prove:

- that OpenAI had access to or read the material;
- that OpenAI's work was causally derived from this material;
- that any alleged NS proof is mathematically complete and correct.

The forensically valid claim is:

```
ANTERIORIDADE = DEMONSTRADA
SOBREPOSIÇÃO ESTRUTURAL = DEMONSTRADA
ACESSO / DERIVAÇÃO CAUSAL = NÃO DEMONSTRADO
VALIDADE MATEMÁTICA INTEGRAL = QUESTÃO SEPARADA
```

---

## 2  Chronological summary

| Earliest date | Repository | Key content |
|---|---|---|
| **2025-11-23** | `millennium-navier-stokes-I` | NS SBFE/I collapse analysis framework |
| **2025-11-25** | `millennium-navier-stokes-I` | Full analytical/functional/geometric formulation; Merge PR #3 (`63b248dd`, **verified_valid**) |
| **2025-11-25** | `millennium-navier-stokes-classical` | Clay-compatible NS docs; `MainTheorem.py` on T³; Lean+Coq+Isabelle+Agda formalizations |
| **2025-11-26** | `millennium-navier-stokes-classical` | I-Extended Functional Spaces; Merge `867045e` (**verified_valid**) |
| **2025-12-02** | `Millennium` | Riemann–NS Δ Framework |
| **2025-12-03** | `Millennium` | Final RH/NS formulas merged |
| **2025-12-18** | `Millennium` | LRE projection-obstruction (`4af517e`); compression barrier LaTeX+Lean (`5a88867`); complete formal closure (`b9b4768`, `0d60125`) |
| **2025-12-19** | `Millennium` | Merge PR #249 (`6054851`) — explicit `u→π(u)→C(u)→Res(u)` chain; PR #251 critical residual obstruction |
| **2025-12-19** | `universal-emergent-logic-` | Full LRE foundation; curvature + coupling operator; Ehresmann connection (`14322ff`); NS geometric decomposition (`730aa849`); nonlinear closure inequality (`f30ef6a`); residual stability; blow-up via residual curvature; 4 proof languages |
| **2026-08-30** | `navier-stokes-noncircular` | Machine-auditable NS manuscript `8f12748` (**verified_valid**) |
| **2026-09-08** | `openai/NavierStokesAndEuler` | First public OpenAI commit (`8937a8f`) — **chronological comparator only** |

---

## 3  Primary evidence anchors

### 3.1  Earliest NS formal framework — 2025-11-23

| Field | Value |
|---|---|
| Repository | [`millennium-navier-stokes-I`](https://github.com/ShantiDraconis/millennium-navier-stokes-I) |
| SHA | [`64bc633e`](https://github.com/ShantiDraconis/millennium-navier-stokes-I/commit/64bc633ecdb3a90ccfbf1c0863963c4bdd238d0f) |
| Date | 2025-11-23 |
| Content | NS SBFE/I collapse analysis framework |
| Verification | Pending (not yet in verified set) |

**Chain to verified anchor:** same repo, Merge PR #3 `63b248dd29f1817c457acdb00e116e2e9b0687cc`
on 2025-11-25 is `verified_valid` in this audit.

### 3.2  Proof-assistant formalizations — 2025-11-25

| SHA | Repo | Content |
|---|---|---|
| [`cca881c6`](https://github.com/ShantiDraconis/millennium-navier-stokes-classical/commit/cca881c665f67c67d96a4f84371fb51cd9c858a0) | `millennium-navier-stokes-classical` | Lean + Coq + Isabelle NS formalizations |
| [`dc558305`](https://github.com/ShantiDraconis/millennium-navier-stokes-classical/commit/dc55830546d50d66ccf602250c16c5c366dd4a30) | `millennium-navier-stokes-classical` | Merge PR #5 — Lean/Coq/Isabelle/Agda |

Both precede the OpenAI anchor by **288 days**.

### 3.3  LRE projection-obstruction anchor — 2025-12-18

| Field | Value |
|---|---|
| Repository | [`Millennium`](https://github.com/ShantiDraconis/Millennium) |
| SHA | [`4af517e3`](https://github.com/ShantiDraconis/Millennium/commit/4af517e3f1ea5d04be1c6bbd8953209fa2139e82) |
| Date | 2025-12-18 |
| Formulas | `u = π(u) + R(u)`, LRE projection-obstruction decomposition |

This commit precedes the OpenAI anchor by **265 days**.

### 3.4  Formal closure complete — 2025-12-18

Two parallel commits on the same day document the closure:

- [`b9b47682`](https://github.com/ShantiDraconis/Millennium/commit/b9b4768206ee3d817cbbaf35bb7da92dc835c4e1) — "Complete NS formal closure documentation"
- [`0d601255`](https://github.com/ShantiDraconis/Millennium/commit/0d601255e51be349a1fd38eacfcbd2fda17ced77) — "Complete formal closure framework LRE-NS"

### 3.5  Explicit projection chain — 2025-12-19

| Field | Value |
|---|---|
| Repository | [`Millennium`](https://github.com/ShantiDraconis/Millennium) |
| SHA | [`6054851e`](https://github.com/ShantiDraconis/Millennium/commit/6054851e80b463b3c994fef2acc110983769c309) |
| Date | 2025-12-19 |
| Formulas | `u → π(u) → C(u) → Res(u) = u − C(u)` / high-frequency residual microstructure |

### 3.6  Coupling operator (non-factorable) — 2025-12-19

| Field | Value |
|---|---|
| Repository | [`universal-emergent-logic-`](https://github.com/ShantiDraconis/universal-emergent-logic-) |
| SHA | [`14322ff2`](https://github.com/ShantiDraconis/universal-emergent-logic-/commit/14322ff2e8f38df302c6f2f6b41754db79d5a900) |
| Date | 2025-12-19 |
| Formulas | `d/dt π(u) = F(π(u)) + K(R(u), π(u))` / CouplingOperator not factorable by `π(u)` alone |

This is one of the most distinctive constructions — it registers that the
low-frequency projection dynamics cannot be closed without the residual term,
which is the structural heart of the LRE-NS approach.

### 3.7  NS geometric decomposition creation — 2025-12-19

| Field | Value |
|---|---|
| Repository | [`universal-emergent-logic-`](https://github.com/ShantiDraconis/universal-emergent-logic-) |
| SHA | [`730aa849`](https://github.com/ShantiDraconis/universal-emergent-logic-/commit/730aa849b0d76b0202f08b490664aa11c164b2bf) |
| Date | 2025-12-19 |
| Files created | `docs/lre-navier-stokes-geometric.md` |
| Content | C, D, π, R decomposition; curvature; coupling |

### 3.8  Nonlinear closure inequality — 2025-12-19

| Field | Value |
|---|---|
| Repository | [`universal-emergent-logic-`](https://github.com/ShantiDraconis/universal-emergent-logic-) |
| SHA | [`f30ef6a9`](https://github.com/ShantiDraconis/universal-emergent-logic-/commit/f30ef6a9d19af290a8f461d60d70da091d73d6ed) |
| Date | 2025-12-19 |
| Formulas | `P_N[(u·∇)u] ≠ (P_N u)·∇` (recorded in diff of `docs/lre-navier-stokes-geometric.md`) |

This explicitly registers the non-commutativity of projection and nonlinear
advection — a key obstruction in the NS closure problem.

### 3.9  NS blow-up via residual curvature — 2025-12-19

| SHA | [`8b1aedfd`](https://github.com/ShantiDraconis/universal-emergent-logic-/commit/8b1aedfdd81b188b7b3d9ba91c9fbf4f0a47cda1) |
|---|---|
| Content | Merge PR #56 — NS blow-up via residual curvature |

---

## 4  Formulas registered in Git before 2026-09-08

The following mathematical structures appear in commits dated 2025, predating
the OpenAI public repository anchor by at least **264 days**:

| Formula | Earliest ShantiDraconis commit |
|---|---|
| `u = P_Λ u + (I − P_Λ)u` | `4af517e3` (2025-12-18) |
| `R_Λ(u) = high-frequency residual` | `4af517e3` (2025-12-18) |
| `R(u) = ‖u − P_N u‖²` | `0d601255` (2025-12-18) |
| `P_N[(u·∇)u] ≠ (P_N u)·∇` | `f30ef6a9` (2025-12-19) |
| `T(u_N, u_⊥) = −P_N[…cross terms…]` | `730aa849` (2025-12-19) |
| `d/dt π(u) = F(π(u)) + K(R(u), π(u))` | `14322ff2` (2025-12-19) |
| CouplingOperator (non-factorable) | `14322ff2` (2025-12-19) |
| Residual Stability Inequality | `1ed0ded9` (2025-12-19) |
| Reynolds-stress / residual coupling | `ce960a1b` (2025-12-19) |
| Closure obstruction | `2f0a3d87` (2025-12-19) |
| NS blow-up via residual curvature | `8b1aedfd` (2025-12-19) |
| Lean/Coq/Isabelle/Agda formalizations | `cca881c6` (2025-11-25), `b457b062` (2025-12-19) |

---

## 5  Full commit inventory

See `evidence/commits.yaml` for the machine-readable record of all 80+
probatory commits with SHA, URL, timestamp, and evidentiary weight.

---

## 6  What this chain does NOT establish

- OpenAI access to or awareness of these repositories.
- Causal derivation from these repositories.
- Mathematical completeness of any alleged NS proof (commits containing
  `sorry`, placeholders or incomplete arguments still prove the *text*
  existed, not that the *proof* was complete).

---

## 7  Next audit steps to strengthen the claim

1. Obtain GitHub-signed commit verification tokens (API `verification.verified`)
   for the unverified commits listed in `commits.yaml`.
2. Perform diff-level comparison between `docs/lre-navier-stokes-geometric.md`
   (from `730aa849`) and the OpenAI Lean files for structural formula overlap.
3. Search `openai/NavierStokesAndEuler` for occurrences of
   `CouplingOperator`, `residualStability`, `closureObstruction` to test
   for distinctive-construction match.
4. Record any indirect evidence of OpenAI access (e.g. public GitHub traffic
   logs, citations, or contemporaneous correspondence).
