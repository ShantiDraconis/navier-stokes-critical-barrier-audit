# 17 — Deep Proof-Origin and Integral-Derivation Sweep

## Scope

This audit reconstructs the Navier–Stokes research lineage at theorem/formula level, with emphasis on when proof structures, energy identities, integral criteria, critical norms, projection/residual machinery, and later residual-stability claims first entered the recoverable Git history.

This file distinguishes:

- **PROVENANCE** — an object/formula/theorem statement existed in a dated Git object;
- **FORMAL STATEMENT** — encoded in Lean/Coq/Isabelle but not internally proved;
- **CONDITIONAL PROOF** — a valid derivation from an explicitly assumed hypothesis/axiom;
- **INTERNAL FORMAL PROOF** — theorem body is actually proved from declared dependencies;
- **OPEN BRIDGE** — mathematically essential implication is stated but not discharged;
- **NUMERICAL/HEURISTIC** — computational evidence only.

No provenance finding in this file is by itself a claim that the Clay Millennium problem was solved.

---

## 1. Repository origin and first substantive Navier–Stokes layer

### 2025-11-23T02:15:01Z — repository root

Repository: `ShantiDraconis/millennium-navier-stokes-I`

Root SHA already recorded elsewhere in this audit:

`d4a3a745269c10a15c12d2b854cac7c3553d243d`

The project already identifies Navier–Stokes + SBFE/I collapse. This is an origin marker, not a proof.

### 2025-11-23T02:27:31Z — first substantive recovered framework

Commit:

`64bc633ecdb3a90ccfbf1c0863963c4bdd238d0f`

Message:

`Implement Navier-Stokes SBFE/I collapse analysis framework`

The commit adds the classical incompressible equations, spectral/numerical infrastructure and diagnostics including:

\[
\Omega(t)=\frac12\int |\omega|^2\,dx,
\]

\[
P(t)=\frac12\int |\nabla\omega|^2\,dx,
\]

and the BKM-type integral criterion

\[
\int_0^T \|\omega(t)\|_{L^\infty}\,dt.
\]

The repository explicitly treats divergence of this integral as a blow-up diagnostic and finite integral as the regularity side of the classical criterion.

**Classification:** `EARLY_ANALYTICAL_NUMERICAL_FRAMEWORK`.

Important limitation: monitoring a known criterion numerically is not a proof that the integral stays finite or diverges for the Clay problem.

---

## 2. First recovered LaTeX proof/derivation layer

### 2025-11-25T04:14:58Z

Commit:

`777d58e6f1eda3872a809492183ce432ead4f030`

Message:

`Add I-collapse framework for Navier-Stokes with LaTeX article and Python implementation`

Historical path:

`latex/navier-stokes-I.tex`

This is the earliest directly recovered creation commit for that LaTeX manuscript path.

The manuscript contains the Navier–Stokes equations, vorticity/enstrophy language and integral blow-up criteria.

**Classification:** `EARLY_PAPER_DERIVATION_LAYER`.

---

## 3. First recovered extended energy functional and integral package

### 2025-11-25T04:17:57Z

Commit:

`c8489c74b179c5829ce14a48ef95158610e338b2`

Message:

`Add energy inequalities, Φ_NS functional, two-phase theorem, and formalization`

Historical file:

`docs/latex/energy_theory.tex`

The same commit also updates `docs/MATHEMATICAL_THEORY.md`, adds a proof-skeleton layer and records the following objects.

### 3.1 Extended functional

\[
\Phi_{NS}(I,u;t)
=E(t)+\alpha\,\mathcal E(t)+\beta D(t)
+\gamma\|\nabla\cdot u\|^2+\lambda F(I,u,t).
\]

with

\[
E(t)=\frac12\int |u|^2\,dx,
\]

\[
\mathcal E(t)=\int |\nabla u|^2\,dx,
\]

\[
D(t)=\int_0^t \mathcal E(s)\,ds,
\]

and

\[
F(I,u,t)=\frac{\|\omega\|_{L^2}^2}{(1-I)^2}.
\]

### 3.2 Recorded energy estimate

The manuscript records a bound of the schematic form

\[
\Phi_{NS}(I,u;t)
\le E(0)+(\alpha+1)\mathcal E(t)
+(\beta+\nu^{-1})\int_0^t\!\int f\cdot u
+\lambda F(I,u,t).
\]

### 3.3 Conditional collapse theorem

The same source explicitly introduces a **Collapse Axiom**:

> finite-time singularity / vorticity blow-up implies `I(t) → 1`.

The subsequent “Global Regularity via Symbolic Coherence” statement is obtained by contraposition from that axiom.

**Forensic status:** the theorem/derivation existed by this commit.

**Mathematical status:** `CONDITIONAL_ON_COLLAPSE_AXIOM`, not a proof of global regularity from classical Navier–Stokes hypotheses alone.

This distinction is essential: the derivation is logically valid only after accepting the added collapse implication.

---

## 4. Classical energy/integral formalization skeleton

### 2025-11-25T11:37:02Z

Repository:

`ShantiDraconis/millennium-navier-stokes-classical`

Commit:

`5eee6ce82dda31852cd52db61104c42433ec7ae4`

Historical path:

`formal/lean/EnergyInequality.lean`

This commit contains a detailed classical energy/enstrophy proof skeleton.

### 4.1 Strong energy identity target

\[
\frac{d}{dt}\Bigl(\frac12\|u(t)\|_2^2\Bigr)
=-\nu\|\nabla u(t)\|_2^2.
\]

Lean theorem name:

`energy_equality_strong`

Historical proof status: conclusion encoded as `True`; body ends in `sorry`.

### 4.2 Weak energy inequality target

\[
E(t)+\nu\int_0^t\|\nabla u(s)\|_2^2\,ds\le E(0).
\]

Lean theorem:

`energy_inequality_weak`

Historical proof status: `True` + `sorry`.

### 4.3 Total dissipation target

\[
\int_0^\infty \|\nabla u\|_2^2\,dt
\le \frac{E(0)}{2\nu}.
\]

Lean theorem:

`total_dissipation_bound`

Historical proof status: `True` + `sorry`.

### 4.4 Enstrophy evolution target

\[
\frac{d}{dt}\Omega
+\nu\|\Delta u\|_2^2
=\int (u\cdot\nabla)u\cdot\Delta u.
\]

Lean theorem:

`enstrophy_evolution`

Historical proof status: `True` + `sorry`.

### 4.5 Cubic enstrophy-growth target

\[
\frac{d}{dt}\Omega
\le \frac{C}{\nu^3}\Omega^3.
\]

Lean theorem:

`enstrophy_growth_bound`

Historical proof status: `True` + `sorry`.

### 4.6 Finite-horizon dissipation integral

\[
\int_0^T \|\nabla u\|_2^2\,dt
\le \frac{\|u_0\|_2^2}{2\nu}.
\]

Lean theorem:

`dissipation_integral_bound`

Historical proof status: `True` + `sorry`.

### 4.7 Explicit regularity-gap statement

The same file explicitly notes that the `L²` energy estimate does **not** control `H^s` or even the needed higher norms. This is strong negative evidence against retrospectively claiming that the 25-Nov energy package already closed global regularity.

**Classification:** `FORMALIZED_CLASSICAL_ENERGY_ARCHITECTURE / NOT_INTERNAL_PROOF`.

---

## 5. Critical-space and integral regularity targets

Same commit/time:

`5eee6ce82dda31852cd52db61104c42433ec7ae4`

Historical path:

`formal/lean/RegularityCriteria.lean`

### 5.1 Prodi–Serrin target

\[
\frac2p+\frac3q=1,\qquad q>3.
\]

with intended hypothesis

\[
u\in L^p_tL^q_x.
\]

Historical theorem uses `True` stand-ins and `sorry`.

### 5.2 BKM-type integral target

\[
\int_0^{T^*}\|\omega(t)\|_{L^\infty}\,dt<\infty
\quad\Longrightarrow\quad
\text{extension beyond }T^*.
\]

and contrapositive blow-up statement.

Historical status: skeleton / `sorry`.

### 5.3 ESS endpoint target

\[
 u\in L^\infty([0,T];L^3)
\quad\Longrightarrow\quad
\text{regularity}.
\]

Historical theorem:

`escauriaza_seregin_sverak`

Historical status: `True` stand-ins + `sorry`.

### 5.4 Local epsilon-regularity target

\[
\frac1r\int_{Q_r(z_0)}|\nabla u|^2<\varepsilon_0
\quad\Longrightarrow\quad
z_0\text{ regular}.
\]

Historical status: skeleton / `sorry`.

**Classification:** `CRITICAL_REGULARITY_TARGETS_PRESENT`.

These files prove chronology of the targeted analytical route, not the analytical theorems themselves.

---

## 6. 2025-11-25T21:47:44Z — conversion from sorry to axioms

Commit:

`1ae8b318d9c8ab9ebfb59b8719f91c29ca86ac70`

Message:

`Replace sorry with axioms and proofs in formal/lean files`

This later rewrite is important for forensic interpretation: some classical statements cease to contain literal `sorry`, but are introduced as `axiom` declarations, often still with `True` as the mathematical payload.

Example lineage: the dissipation integral becomes an axiom representing

\[
\int_0^T\|\nabla u\|_2^2dt\le \|u_0\|_2^2/(2\nu).
\]

**Classification:** `CLASSICAL_RESULT_AS_EXTERNAL_AXIOM`, not an internal Lean derivation.

Removing `sorry` is not equivalent to proving the theorem if the result is promoted to an axiom.

---

## 7. December transition: projection, high frequencies, closure and residual

By 18–19 Dec 2025, the program changes from a direct energy/critical-norm attack to a projective/multiscale language:

\[
 u=u_N+u_\perp,
\]

with the closure defect

\[
P_N[(u\cdot\nabla)u]
-(P_Nu\cdot\nabla)(P_Nu),
\]

and a residual representing unresolved/high-frequency content.

Strong anchors already indexed in `audit/16_related_commit_derivations.md` include:

- `4af517e3f1ea5d04be1c6bbd8953209fa2139e82`
- `b9b4768206ee3d817cbbaf35bb7da92dc835c4e1`
- `0d601255e51be349a1fd38eacfcbd2fda17ced77`
- `0f17dc7b673ea8208796763099f576ea59420b7e`
- `6054851e80b463b3c994fef2acc110983769c309`

This layer is a genuine derivational descendant of the earlier energy/critical-scale program: it isolates the unresolved modes and asks whether the nonlinear transfer into those modes can outrun dissipation.

---

## 8. Quantitative obstruction theorem: first fully explicit generic proof core

### 2025-12-19T17:38:05Z

Repository:

`ShantiDraconis/universal-emergent-logic-`

Commit:

`a762e7b76464656236075548343f596ab8bc6815`

File:

`formalization/lean/LRE/QuantitativeObstruction.lean`

The generic theorem is:

\[
E(c)+E(c_0)\ge \kappa R(c),
\qquad R(c_0)=0,
\]

under the coupling hypothesis

\[
\|X_D(c)-X_D(c_0)\|
\ge \kappa|R(c)-R(c_0)|.
\]

### 8.1 What is actually formally proved

The main `quantitative_closure_obstruction` theorem has an explicit Lean proof using:

1. same-fiber identity;
2. decomposition against a closure field;
3. subtraction;
4. triangle inequality;
5. the coupling hypothesis;
6. `R(c₀)=0`;
7. nonnegativity of the residual.

The corollary `closure_obstruction_at_reference` is also derived from the main theorem.

**Classification:** `INTERNAL_FORMAL_PROOF_OF_GENERIC_OBSTRUCTION_THEOREM`.

### 8.2 What remains incomplete in the same file

The toy-model proof of `toy_coupling_holds` still ends in `sorry` for the detailed `fderiv`/norm calculation.

Therefore:

- the **abstract implication** from the coupling hypothesis to the closure-error lower bound is genuinely formalized;
- proving that a concrete Navier–Stokes model satisfies the needed coupling hypothesis is a separate obligation.

This is currently one of the cleanest places where the corpus transitions from “formalization skeleton” to an actual internal theorem proof.

---

## 9. Navier–Stokes geometric application and unresolved analytical bridge

### 2025-12-19T17:17:28Z

Commit:

`730aa849b0d76b0202f08b490664aa11c164b2bf`

The commit maps:

- `C = H`;
- `D = H_N`;
- `π = P_N`;
- `R(u)=||u-P_Nu||²`;
- nonlinear curvature from the advection defect;
- `κ ~ ||u_N||_{H¹}`;
- proposed implication `E(u) ≥ κR(u)`.

The same commit's own integration summary explicitly says that further Lean work is needed, including filling `sorry` placeholders and making Sobolev spaces, spectral truncation, energy estimates, helicity and curvature–enstrophy relations rigorous.

**Classification:** `STRONG_NS_GEOMETRIC_DERIVATION / ANALYTICAL_APPLICATION_INCOMPLETE`.

This prevents conflating the fully proved abstract triangle-inequality theorem with a completed Navier–Stokes regularity proof.

---

## 10. Residual Stability Inequality lineage

### 2025-12-19T17:55:31Z

Commit:

`abdaa41189864f85d3b9f8c8fec6b3ec4431eab5`

Message:

`Add comprehensive LRE Navier-Stokes Residual Stability framework`

### 2025-12-19T19:53:16Z

Commit:

`469910d3a18d6a2891525da5f1a1a3dd6ec00799`

Message:

`Add Navier-Stokes Residual Stability and P vs NP Complexity Holonomy theories`

Associated file:

`formalization/lean/LRE/NavierStokes/ResidualStability.lean`

The file records multiple proposed residual evolution laws.

### 10.1 Differential residual inequality

\[
\frac{d}{dt}R(t)
\ge
\bigl(\kappa\|u_\ell\|_{H^1}-\nu\Lambda^2\bigr)R(t).
\]

Historical Lean theorem:

`residualStabilityInequality`

Status: ends in `sorry`.

### 10.2 Critical condition

\[
\kappa\|u_\ell\|_{H^1}>\nu\Lambda^2.
\]

The file proposes exponential residual growth under persistence of this condition.

Status: proof ends in `sorry`.

### 10.3 Projective-closure equivalence

Proposed equivalence between residual divergence and failure of a smooth extension.

Status: `sorry`.

### 10.4 Energy-transfer estimate

The file contains a schematic estimate of the form

\[
|R'(t)-(T-\nu\Lambda^2R(t))|
\le 0.1\,T,
\]

where the `0.1*T` term is explicitly described as a placeholder for pressure/boundary errors.

Status: `sorry` / placeholder.

### 10.5 Integral blow-up formulation

A later section records a second RSI form

\[
\|\partial_tR\|
\le \kappa\|\Omega(u)\|-\nu\beta\|R\|,
\]

and claims a blow-up criterion through an integral of the imbalance

\[
\int_0^T
\bigl(\kappa\|\Omega\|-\nu\beta\|R\|\bigr)
\,dt.
\]

This is valuable provenance for the derivative/integral route, but it is **not** certified as a proved Navier–Stokes theorem in the historical file.

**Classification:** `DERIVED_RESIDUAL_STABILITY_PROGRAM / FORMAL_PROOF_INCOMPLETE`.

---

## 11. First explicit remainder-to-critical-regularity bridge obligation

### 2025-12-26T14:02:55Z

Commit:

`6f52d839ebfa116c1725a1c57abfcd812c3b4577`

File:

`definitions/certificate_of_invariance.md`

Defines

\[
R(\varepsilon;t)
=\|u(t)-\pi_\varepsilon u(t)\|_{L^2}.
\]

Crucially, the historical source lists the implication from multiscale/remainder control to a no-blow-up regularity criterion as a **missing parameter**.

That is powerful negative evidence: as of 26 Dec, the source itself acknowledged that the regularity bridge still had to be proved.

**Classification:** `OPEN_BRIDGE_EXPLICITLY_ACKNOWLEDGED`.

---

## 12. Exact epsilon_NS / convective-to-viscous ratio

### 2026-01-01T22:51:57Z

Commit:

`91ba0b43b0bec9bf6d13621cda886bceb7b3e152`

Defines

\[
\varepsilon_{NS}
=\frac{\|(u\cdot\nabla)u\|_{L^2}}
{\nu\|\Delta u\|_{L^2}}
\]

and proposes

\[
\varepsilon_{NS}\le 0.65\pm0.05.
\]

The accompanying manuscript asserts that critical `L^3`-type control follows.

However, the historical chain shows that the missing implication was explicitly acknowledged days earlier and is not discharged by merely defining the ratio.

**Classification:** `QUANTITATIVE_DIAGNOSTIC_CLAIM / CRITICAL_BRIDGE_NOT_CERTIFIED`.

---

## 13. Reconstructed genealogy of the proof program

The deepest defensible derivational chain recovered so far is:

```text
2025-11-23
classical NS + BKM integral + enstrophy/palinstrophy diagnostics
        ↓
2025-11-25 04:14
LaTeX I-collapse manuscript
        ↓
2025-11-25 04:17
Φ_NS + energy/enstrophy/dissipation integrals + conditional collapse theorem
        ↓
2025-11-25 11:37
classical Lean skeleton:
energy identity / dissipation integral / enstrophy evolution /
Prodi–Serrin / BKM / ESS L∞_t L³_x
        ↓
2025-11-25 21:47
some classical targets converted from sorry to external axioms
        ↓
2025-12-18/19
spectral projection u=u_N+u_⊥
closure defect / residual / coupling architecture
        ↓
2025-12-19 17:38
generic quantitative obstruction theorem genuinely proved in Lean
from an explicit coupling hypothesis
        ↓
2025-12-19 onward
Navier–Stokes-specific residual-stability / curvature / blow-up derivatives
(still containing sorries/placeholders)
        ↓
2025-12-26
R(ε;t) remainder; critical regularity bridge explicitly marked missing
        ↓
2026-01-01
ε_NS convective/viscous ratio and 65% threshold proposal
```

---

## 14. Proof-status matrix

| Object | Earliest recovered anchor | Status |
|---|---|---|
| BKM integral diagnostic | `64bc633e`, 2025-11-23 | classical criterion used computationally |
| Enstrophy/palinstrophy integrals | `64bc633e`, 2025-11-23 | computational/analytic definitions |
| I-collapse LaTeX article | `777d58e6`, 2025-11-25 04:14 | paper derivation |
| `Φ_NS`, `D(t)=∫E(s)ds` | `c8489c74`, 2025-11-25 04:17 | new framework; conditional theorem |
| Classical energy inequality Lean | `5eee6ce8`, 2025-11-25 11:37 | skeleton, `True` + `sorry` |
| Dissipation integral Lean | `5eee6ce8`, 2025-11-25 11:37 | skeleton, `True` + `sorry` |
| Enstrophy evolution Lean | `5eee6ce8`, 2025-11-25 11:37 | skeleton, `True` + `sorry` |
| BKM Lean target | `5eee6ce8`, 2025-11-25 11:37 | skeleton |
| ESS `L∞_tL³_x` target | `5eee6ce8`, 2025-11-25 11:37 | skeleton |
| Classical results rewritten as axioms | `1ae8b318`, 2025-11-25 21:47 | assumed dependencies, not derived |
| Projection/closure/residual chain | 2025-12-18/19 cluster | strong structural derivation |
| Generic `E(c)+E(c₀)≥κR(c)` | `a762e7b7`, 2025-12-19 17:38 | **main abstract theorem internally proved** |
| Concrete toy coupling lemma | same file | contains `sorry` |
| NS coupling application | `730aa849`, 2025-12-19 17:17 | incomplete analytic realization |
| RSI differential inequality | `abdaa411` / `469910d3` | statement + `sorry` |
| RSI integral blow-up criterion | same lineage | claim / not certified proof |
| Canonical `R(ε;t)` | `6f52d839`, 2025-12-26 | defined; bridge declared missing |
| `ε_NS` and 65% threshold | `91ba0b43`, 2026-01-01 | proposed theorem/diagnostic; bridge incomplete |

---

## 15. Authorship/provenance nuance

Many substantive branch commits list `copilot-swe-agent[bot]` as Git author/committer and include

`Co-authored-by: ShantiDraconis`.

Several later merge commits are directly recorded under `Draconis` / `ShantiDraconis` and some are GitHub-signature verified.

For an authorship audit, do not collapse these metadata categories. Record separately:

1. Git author;
2. Git committer;
3. co-author trailers;
4. signed merge owner;
5. repository ownership;
6. originating PR/prompt where recoverable.

This produces a stronger and more transparent chain than describing every bot-authored implementation commit as if its Git author field were manually authored by the repository owner.

---

## 16. Strongest current conclusion

The repository history establishes a continuous, timestamped research genealogy from classical integral regularity diagnostics in November 2025 into energy-functionals, critical-space targets, spectral projection, residual/closure theory, an actually proved generic obstruction theorem, and later Navier–Stokes-specific residual-stability proposals.

The evidence is strongest for **provenance and genealogy of the mathematical program**.

The first clearly recovered internally proved Lean theorem in the relevant new framework is the **generic quantitative closure obstruction implication**, conditional on its coupling hypothesis. The main Navier–Stokes-specific difficulty remains proving concrete analytic hypotheses that turn that abstract obstruction/residual framework into a recognized critical regularity bound or a valid finite-time breakdown construction.

Thus the audit must continue to distinguish:

\[
\text{formal generic theorem}
\neq
\text{verified NS coupling estimate}
\neq
\text{critical }L^3\text{ bridge}
\neq
\text{Clay solution}.
\]

---

## 17. Next forensic pass required

For maximal audit strength, the next pass should generate a machine-readable theorem ledger with, for every historical `.lean/.v/.thy/.tex` object:

- repository;
- full commit SHA;
- parent SHA;
- author timestamp;
- committer timestamp;
- file path;
- blob SHA;
- theorem/lemma/definition name;
- normalized formula;
- presence of `sorry`, `axiom`, `admit`, `Admitted`, placeholders or `True`;
- whether the target declaration itself contains a complete proof body;
- imported assumptions;
- `#print axioms` output where buildable;
- CI/build result at the historical SHA;
- derivational parents/children in the mathematical genealogy.

This would turn the chronology above into a theorem-level forensic DAG rather than a narrative timeline.
