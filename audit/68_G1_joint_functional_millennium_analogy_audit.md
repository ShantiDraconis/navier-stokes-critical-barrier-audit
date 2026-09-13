# G1 joint-functional and Millennium-analogy audit

Date: 2026-09-13

## Status firewall

This note records a proposed G1 refinement and several cross-Millennium analogies. The analogies are **heuristic research prompts only**. They are not implications, reductions, imported theorems, or evidence that solving another Millennium problem proves the Navier–Stokes bridge.

## Joint obstruction diagnostic

Proposed diagnostic

\[
Q_{\rm joint}=Q^{\rm dir}+\alpha Q^{\rm strain},\qquad \alpha>0.
\]

A reported adversarial test has `Qdir = 0`, `Qstrain = 2`, `alpha = 1`, hence `Qjoint = 2`. This demonstrates only that the joint diagnostic detects a strain obstruction deliberately invisible to the direction-only diagnostic. It does **not** prove `ActualNS -> Qjoint bounded`, `Qjoint -> KWC`, or signed depletion.

## Flexible signed-control target

The target is

\[
\mathcal S(t)\le \theta\nu z(t)+a(t)y(t),\qquad 0\le\theta<1,
\]

with

\[
y=\|\omega\|_2^2,\qquad z=\|\nabla\omega\|_2^2,
\qquad a(t)=C\Phi(\kappa,t)^2\|\nabla u(t)\|_2^2.
\]

If `Phi` is uniformly bounded and the energy inequality supplies `||grad u||_2^2 in L1_t`, then `a in L1_t`. Energy alone does not bound `Phi`. Any claim that `a in L1` follows from energy therefore carries the additional hypothesis `Phi in L-infinity_t` (or directly `Phi^2 ||grad u||_2^2 in L1_t`).

The dependence on fixed-a-priori `kappa` must remain visible: if `Phi = C_H / sqrt(kappa)`, the coefficient scales as `Phi^2 = C_H^2/kappa`, so the Gronwall exponent deteriorates as `kappa -> 0`. `kappa` may not be fitted after observing `C_H`.

## Current theorem DAG

A. Exact angular/kernel identity: NEARLY_COMPLETE / exact hypotheses still audited.

B. `ActualNS -> DynamicJointControl`: OPEN_BRIDGE.

C. `DynamicJointControl -> KernelWeightedCoherence`: OPEN_BRIDGE.

D. `KWC + WeightedTail -> FlexibleSignedControl`: OPEN_ANALYTIC_BRIDGE.

E. `Phi^2 ||grad u||_2^2 in L1_t` from noncircular PDE/geometric hypotheses: OPEN_BRIDGE.

K1. `epsilon -> 0` passage for regularized vorticity direction: OPEN_ANALYTIC_LEMMA. In particular, no Chebyshev argument may assert that `{|omega| < delta}` has small measure from an L2 bound.

ETA. Zero denominator shells: `NULL_WEIGHT_SHELL`; ratio undefined. When numerator and denominator use the same nonnegative weight and the exceptional set is a subset of the shell, denominator zero implies numerator zero, but this does not assign a value to `0/0`.

FINAL_CONDITIONAL: established only as implication composition once A--E and endpoint hypotheses are supplied.

UNCONDITIONAL_GLOBAL_REGULARITY: NOT_ESTABLISHED.

## Cross-Millennium analogy registry

### Poincare / Ricci-flow analogy

Candidate analogy: define a weighted quantity `W_joint` and investigate whether a monotonicity inequality analogous in *role* to an entropy can be derived from Navier--Stokes.

Status: **ANALOGY_ONLY / NEW_PDE_THEOREM_REQUIRED**.

The Ricci-flow monotonicity theorem does not imply

\[
\partial_t W_{\rm joint}+c_0\nu r^{-2}Q_{\rm joint}\le0.
\]

That inequality must be derived independently from the Navier--Stokes equations.

### Yang--Mills analogy

Candidate analogy: epsilon-regularity and spectral/coercive gaps motivate searching for a smallness threshold for `Qjoint`.

Status: **ANALOGY_ONLY**.

Yang--Mills epsilon-regularity does not establish `Qjoint < epsilon -> Phi bounded` for Navier--Stokes. A proposed strain eigenvalue gap is likewise a new hypothesis/theorem, not a consequence of the Yang--Mills mass gap.

### Hodge analogy

Actual Hodge/Helmholtz decompositions may be mathematically relevant only after the domain, boundary conditions, function spaces, and orthogonality identities are stated. A weighted nonlinear tail with weight involving products of vorticity is not automatically a Hodge norm merely because an L2 decomposition is orthogonal.

Status: **POTENTIALLY_RELEVANT_EXTERNAL_TOOL / WEIGHTED IDENTIFICATION NOT_ESTABLISHED**.

### Riemann analogy

The traceless strain identity

\[
\lambda_1+\lambda_2+\lambda_3=0,
\qquad
\xi\cdot S\xi=\sum_i\lambda_i(\xi\cdot e_i)^2
\]

is genuine linear algebra. Comparing a bound on `Phi` with a zeta zero-free region is metaphorical and supplies no inequality.

Status: **LINEAR_ALGEBRA_VALID; RIEMANN LINK = ANALOGY_ONLY**.

### P versus NP / quantum analogy

Naively checking all discrete pairs is quadratic in the number of sample points. This does not by itself prove NP-hardness. Grover search or amplitude estimation requires a precise oracle model and does not turn numerical verification into a mathematical proof.

Status: **COMPUTATIONAL_HEURISTIC; NP_HARDNESS_NOT_ESTABLISHED; QUANTUM_SPEEDUP_NOT_CERTIFIED FOR THIS PROBLEM**.

Reported weighted-tail percentages such as 8.46%--18.82% remain `EVIDENCE_ONLY` until their exact CSV, code, checksum, weighting measure, and run metadata are independently reproduced.

### BSD analogy

Kernel dimension/rank and Laplace-type generating functions can motivate diagnostics, but Mordell--Weil rank and elliptic-curve L-functions do not imply statements about the strain kernel or time-integrability of `a(t)`.

Status: **ANALOGY_ONLY**.

## Historical/provenance direction

The audit should search earlier commits for structural precursors, not retroactively label analogies as proofs. Existing recovered chronology already includes a 2025-11-25 explicit ESS target, a 2025-12-19 projection/residual architecture, a 2025-12-26 multiscale residual bridge, and a 2026-01-01 epsilon_NS proposal. These are provenance anchors; exact declaration-level first SHAs remain a separate genealogy task.

## CI observation

Run `34731330992` at head `9df87f272aee5b849c8a95f246d3949c09753596` completed with failure. Unit tests, syntax checks, open-bridge registry validation, static integrity scan, Lean installation, and dependency resolution passed. `Build Lean audit library` failed; subsequent G1 Lean and Coq stages were skipped in that run. Therefore no PASS certificate for the new G1 interface may be issued from this run.
