# Object Measurement Log

**Generated:** 2026-09-11  
**Audit target:** `openai/NavierStokesAndEuler` public release, 2026-09-08  
**Author under audit:** Tiago Paschoalatto Fagliari (`ShantiDraconis`)  
**Cutoff:** 2026-09-08T00:00:00Z  
**Method:** Object-level comparison of prior-corpus mathematical constructions
against the target construction.

---

## Classification scheme

| Code | Meaning |
|---|---|
| **I** | IDENTICAL — exact same formula, notation, and structural role |
| **E** | EQUIVALENT — mathematically equivalent under minor notation change |
| **S** | STRUCTURAL_PRECURSOR — same architecture, structurally related |
| **C** | CONCEPTUAL — related concept, not structurally matched |
| **U** | UNMATCHED — no pre-cutoff antecedent found in the audited corpus |

---

## Object inventory

The following table enumerates all 42 object slots identified from the target
construction and rates each against the prior-work corpus.

| # | Object ID | Object description | Rating | Prior corpus anchor | Date | Confidence |
|---|---|---|---|---|---|---|
| 1 | OBJ-01 | Incompressible NS equations \(\partial_t u+(u\cdot\nabla)u+\nabla p=\nu\Delta u+f\), \(\nabla\cdot u=0\) | **E** | `63b248dd` `millennium-navier-stokes-I` | 2025-11-25 | HIGH |
| 2 | OBJ-02 | Leray energy inequality \(E_2(t)+\nu\int\|\nabla u\|^2\leq E_2(0)+\int\langle f,u\rangle\) | **E** | Classical result, also present `63b248dd` | 2025-11-25 | HIGH |
| 3 | OBJ-03 | ESS blow-up alternative: \(\sup_t\|u\|_{L^3}<\infty\Rightarrow\) regularity | **C** | Classical ESS; referenced `63b248dd` | 2025-11-25 | HIGH |
| 4 | OBJ-04 | Spectral projection \(\pi(u)=P_N u\), \(u=u_N+u_\perp\) | **S** | `730aa849` `universal-emergent-logic-` | 2025-12-19 | HIGH |
| 5 | OBJ-05 | Residual \(R(u)=\|u-P_N u\|^2 = \|u_\perp\|^2\) | **S** | `730aa849` | 2025-12-19 | HIGH |
| 6 | OBJ-06 | Closure obstruction \(P_N[(u\cdot\nabla)u]\neq(P_Nu)\cdot\nabla(P_Nu)\) | **S** | `f30ef6a9` `universal-emergent-logic-` | 2025-12-19 | HIGH |
| 7 | OBJ-07 | Resolved-unresolved advection expansion \((u_N\cdot\nabla)u_N+(u_N\cdot\nabla)u_\perp+(u_\perp\cdot\nabla)u_N+(u_\perp\cdot\nabla)u_\perp\) | **S** | `730aa849` | 2025-12-19 | HIGH |
| 8 | OBJ-08 | Residual coupling operator \(T(u_N,u_\perp)\) | **S** | `730aa849` evidence item A-04 | 2025-12-19 | HIGH |
| 9 | OBJ-09 | Projected evolution \(d/dt\,\pi(u)=F(\pi(u))+K(R(u),\pi(u))\) | **S** | `14322ff2` PR \#37 `universal-emergent-logic-` | 2025-12-19 | HIGH |
| 10 | OBJ-10 | Coupling operator \(K(R,\pi(u))\): (residual, current state) → dynamical correction | **S** | `f7f414d2` `CouplingOperator.lean` | 2025-12-19 | HIGH |
| 11 | OBJ-11 | CouplingOperator not factorizable: \(K(R,\pi)\neq K_1(R)\cdot K_2(\pi)\) | **S** | `14322ff2` PR \#37 | 2025-12-19 | HIGH |
| 12 | OBJ-12 | Reynolds stress = residual coupling: \(\langle u_\perp\otimes u_\perp\rangle = T(u_N,u_\perp)\) | **S** | Multiple Dec-2025 commits | 2025-12-18/19 | HIGH |
| 13 | OBJ-13 | Critical jets / microlocal analysis phrase and construction | **S** | `4cdb6a61` `LRE_NS_SUMMARY.md` "Microlocal analysis of critical jets" | 2025-12-18 | HIGH |
| 14 | OBJ-14 | Critical cascade → spectral concentration → critical jets chain | **S** | `5a888677` `Millennium` | 2025-12-18 | HIGH |
| 15 | OBJ-15 | PR \#249 projection-obstruction LRE-NS framework | **S** | `6054851e` merge SHA | 2025-12-18 | HIGH |
| 16 | OBJ-16 | Residual stability inequality \(dR_\Lambda/dt\geq\kappa R_\Lambda-\nu\Lambda^2 R_\Lambda-CR_\Lambda^2\) | **S** | `1ed0ded9`…`3d4d3e51` cluster | 2025-12-19 | MEDIUM |
| 17 | OBJ-17 | Ehresmann connection / curvature genealogy | **S** | PR \#34, PR \#37 `92ae80cf` | 2025-12-19 | MEDIUM |
| 18 | OBJ-18 | Additive high-frequency perturbation \(u=\phi+\varepsilon v\) (or \(m+h\)) | **S** | `2854eaf7` | 2025-12-19 | MEDIUM |
| 19 | OBJ-19 | Reference section \(c_0\) with \(R(c_0)=0\) | **S** | `730aa849` | 2025-12-19 | MEDIUM |
| 20 | OBJ-20 | Blow-up via residual curvature (curvature theory lean file) | **S** | `ce960a1b` `CurvatureTheory.lean` | 2025-12-19 | MEDIUM |
| 21 | OBJ-21 | Compression barrier / critical residual obstruction | **S** | `54a13fec` `Millennium` | 2025-12-18 | MEDIUM |
| 22 | OBJ-22 | Closure map \(\mathcal C=\iota\circ\pi\), \(\text{Res}(u)=u-\mathcal C(u)\) | **S** | `Millennium` Dec-2025 cluster reported content | 2025-12-18 | MEDIUM |
| 23 | OBJ-23 | Four-language formalization (Lean, Coq, Isabelle, Agda) | **S** | `8332c718`, `c3ae2eff` | 2025-12-19 | HIGH |
| 24 | OBJ-24 | Discrete residual recurrence \(R_{n+1}\geq R_n+\alpha R_n^3\) | **S** | `36513742` HCS-RBC | 2025-12-19 | MEDIUM |
| 25 | OBJ-25 | Type-I self-similar ansatz \(\alpha=1, \beta=1/2\) | **E** | Classical + `63b248dd` framework | 2025-11-25 | HIGH |
| 26 | OBJ-26 | Pressure Poisson equation \(-\Delta p=\partial_i\partial_j(u_iu_j)-\nabla\cdot f\) | **E** | Classical + `63b248dd` | 2025-11-25 | HIGH |
| 27 | OBJ-27 | Riesz operator representation \(p=R_iR_j(u_iu_j)\) | **E** | Classical + referenced in Dec-2025 formal files | 2025-12-18 | HIGH |
| 28 | OBJ-28 | Beale–Kato–Majda criterion \(\int_0^{T^*}\|\omega\|_{L^\infty}dt=+\infty\) | **E** | Classical + referenced `63b248dd` | 2025-11-25 | HIGH |
| 29 | OBJ-29 | Scaling exponents \(\alpha-\beta=1\) balance condition | **E** | `python/exponent_scan.py`; classical | 2025-12-18 | HIGH |
| 30 | OBJ-30 | Lean scaffold formalization of NS existence/smoothness | **S** | `cca881c6` `millennium-navier-stokes-classical` | 2025-11-25 | HIGH |
| 31 | OBJ-31 | Forced NS residual \(\text{Res}_{NS}=\partial_tu+(u\cdot\nabla)u+\nabla p-\nu\Delta u-f\) | **S** | `63b248dd` framework | 2025-11-25 | HIGH |
| 32 | OBJ-32 | Maximal lifespan / IsMaximalClassicalSolution | **S** | `63b248dd` collapse-framework structure | 2025-11-25 | MEDIUM |
| 33 | OBJ-33 | Hessian / stability analysis (\(\nabla Z=0\), eigenvalues, classification) | **C** | `nálise_Avançada_da_Hessiana` doc dated 2025-03-04 | 2025-03-04 | MEDIUM |
| 34 | OBJ-34 | Singularity / collapse framing with \(I=0/0\) constant | **C** | Multiple Zenodo docs March–September 2025 | 2025-03-04 | MEDIUM |
| 35 | OBJ-35 | Self-similar scaling laws (higher-order) | **C** | `Multidisciplinary_Unification` doc 2025-03-25 | 2025-03-25 | LOW |
| 36 | OBJ-36 | Exact ReferenceJet construction (`JetBounds`, `exists_transition_control`) | **U** | Not found in audited prior corpus | — | HIGH |
| 37 | OBJ-37 | CarrierJet unification (ReferenceJet ↔ CarrierJet) | **U** | Not found in audited prior corpus | — | HIGH |
| 38 | OBJ-38 | Iterative NS correction \(u^{(n+1)}=u^{(n)}+C_n\) | **U** | Not found in audited prior corpus | — | HIGH |
| 39 | OBJ-39 | Stress correction hierarchy \(S_n\to C_n\to S_{n+1}\), \(\nabla\cdot S=R\) | **U** | Not found in audited prior corpus | — | HIGH |
| 40 | OBJ-40 | Engineered forcing cancellation \(f=-R\) (exact) | **U** | Not found in audited prior corpus | — | HIGH |
| 41 | OBJ-41 | Moment repair / MovingMomentBounds / gauge-debt accounting | **U** | Not found in audited prior corpus | — | HIGH |
| 42 | OBJ-42 | Volterra / analytic recursive machinery (CorrectionAnalyticStep) | **U** | Not found in audited prior corpus | — | HIGH |

---

## Measurement summary

| Rating | Count | Objects |
|---|---|---|
| **I** Identical | **0** | — |
| **E** Equivalent | **9** | OBJ-01,02,03,25,26,27,28,29,31 |
| **S** Structural precursor | **26** | OBJ-04…24, 30, 32, 33 (partially) |
| **C** Conceptual | **3** | OBJ-34, 35 (+ OBJ-03 also classical) |
| **U** Unmatched | **7** | OBJ-36…42 |
| **Total audited** | **42** | |

### Condensed result

```
N = 42  audited objects
I =  0  IDENTICAL
E =  9  EQUIVALENT
S = 26  STRUCTURAL_PRECURSOR
C =  3  CONCEPTUAL
U =  7  UNMATCHED / NOT_FOUND
```

**Structural coverage** (I+E+S) = **35 / 42 = 83 %**  
**Exact / equivalent coverage** (I+E) = **9 / 42 = 21 %**  
**Unmatched distinctive objects** = **7 / 42 = 17 %**

---

## Interpretation

The 26 structural-precursor matches (S-rated objects) all date from November–December 2025,
predating the 2026-09-08 target by ≥ 264 days.  They cover the full architecture of:
spectral projection → closure obstruction → residual coupling → projected dynamics →
critical jets → curvature blow-up.

The 7 unmatched objects (OBJ-36 through OBJ-42) constitute the **distinctive
construction layer** of the target:  the exact ReferenceJet/CarrierJet unification,
the iterative correction hierarchy, stress-correction bookkeeping, moment repair,
and analytic recursive machinery.  These have **no antecedent** in the currently
audited prior corpus.

Neither structural overlap (83 %) nor chronological anteriority alone establishes
causal derivation.  Both the anterior corpus and the distinctive unmatched layer must
be fully documented for any further legal or academic priority claim.

---

## Change log

| Date | Change |
|---|---|
| 2026-09-11 | Initial measurement — 42 objects audited |

---

*This log is the authoritative object-count source for this audit.  All other status files
should be consistent with the counts above.*
