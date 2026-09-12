# Audit 63 — Two-layer final-proof closure protocol

Status: `FINAL_PROOF_PROTOCOL_NOT_YET_SATISFIED`

Date: `2026-09-13`

## 1. Purpose

This note fixes the only audit-safe way to express a future positive Navier–Stokes closure along the current B2 architecture.

It deliberately does **not** begin with the words `FINAL PROOF`. The mathematical theorem must come first, with the exact PDE-derived hypothesis that eliminates the present open bridge. Only after that theorem, and only if every dependency is independently discharged, may the audit verdict be upgraded to `NAVIER_STOKES_GLOBAL_REGULARITY=ESTABLISHED`.

This protocol continues the logical separation already recorded in:

- `91d2ef3325bcf2ae043081abaf6702b69a9c8e3a` — `audit: isolate admissible scenarios after B2.8 countercertificates`;
- `13c41ff1cdddfbd981c37132fb5b280f8b5492a7` — `audit: record intermediate closure ladder and external precedents`.

The first commit isolates the surviving logical scenarios after the B2.8/B2.9 countercertificates. The second records the proof-completion ladder in which `DirectionalDepletion` is a formalized target but its derivation from actual Navier–Stokes dynamics remains an `OPEN_BRIDGE`.

---

## 2. Two-layer rule

A future closure document must contain two logically separate layers.

```text
+LAYER 1 = precise mathematical theorem and proof
+LAYER 2 = audit verdict derived from Layer 1
+```
+
Layer 2 may never be used to manufacture Layer 1. In particular, CI status, a DOI, a repository tag, a theorem name, or a green formal build cannot substitute for the analytic derivation required in Layer 1.

---

# LAYER 1 — MATHEMATICAL THEOREM

## 3. Exact solution class

Fix either

```text
+Omega = R^3
+```
+
or

```text
+Omega = T^3.
+```
+
Let

```text
+u : [0,T*) x Omega -> R^3
+```
+
be the maximal smooth solution of the three-dimensional incompressible Navier–Stokes system

\[
\partial_t u +(u\cdot\nabla)u + \nabla p = \nu \Delta u,
\qquad \nabla\cdot u = 0,
\qquad \nu>0,
\]

with admissible smooth divergence-free initial datum \(u_0\) and finite energy.

Every theorem below must state explicitly:

- the domain;
- the solution class;
- the maximal existence interval \([0,T^*)\);
- the Fourier/Littlewood–Paley convention;
- the normalization of the high-frequency residual;
- the sign convention for the nonlinear flux;
- the exact external endpoint theorem being invoked.

No convention may remain implicit.

---

## 4. High-frequency residual and signed flux

For a sufficiently large cutoff \(\Lambda\), define

\[
 u_{>\Lambda}=P_{>\Lambda}u,
 \qquad
 R_\Lambda(t)=\frac12\|u_{>\Lambda}(t)\|_{L^2}^2.
\]

Use the signed high-frequency flux convention

\[
\Pi_\Lambda(t)
= -\left\langle
P_{>\Lambda}\big((u\cdot\nabla)u\big),
 u_{>\Lambda}
\right\rangle.
\]

The projected energy identity must be proved in the exact normalization being used:

\[
\dot R_\Lambda(t)
+\nu\|\nabla u_{>\Lambda}(t)\|_{L^2}^2
=\Pi_\Lambda(t)
\]

for the unforced case, or with every forcing/error term written explicitly if another setting is used.

The sign convention is part of the theorem statement. It cannot be altered after the flux estimate is derived.

---

## 5. Directional depletion must be an actual PDE consequence

The decisive missing theorem is not an arbitrary numerical alignment assumption. The required object is a property

```text
+DirectionalDepletion(u, S_{<=Lambda}, Lambda, eta)
+```
+
that is derived from the actual Navier–Stokes equations and whose content is strictly weaker than the desired global-regularity conclusion.

It must contain genuine geometric/directional information controlling the interaction of the high-frequency component with the low-frequency strain eigendirections.

The following are **not** sufficient substitutes:

```text
+trace(S)=0
+scalar frequency concentration alone
+R_Lambda below a scalar threshold alone
+Alignment := 0.5 by definition
+uniform L^3 control assumed in disguised form
+regularity assumed inside DirectionalDepletion
+```
+
The countercertificate

\[
S=\operatorname{diag}(1,-1/2,-1/2),
\qquad v=e_1
\]

has

\[
\operatorname{tr}S=0
\]

while normalized quadratic alignment equals \(1\). Therefore trace-freeness plus a frequency predicate containing no orientation information cannot establish a universal bound such as `Alignment <= 0.9`.

Accordingly, the theorem that eliminates the present gap must be derived from the PDE and must contain enough directional information to exclude that obstruction for actual Navier–Stokes trajectories.

---

## 6. Theorem A — global regularity from PDE-derived directional depletion

### Proposed exact form

**Theorem A — Global regularity from PDE-derived directional depletion.**

Let \(u\) be a maximal smooth finite-energy divergence-free solution of the three-dimensional incompressible Navier–Stokes equations on \(\mathbb R^3\) or \(\mathbb T^3\), with maximal time \(T^*\).

Assume that there exists \(\Lambda_0>0\) such that, for every sufficiently large \(\Lambda\ge\Lambda_0\), the Navier–Stokes dynamics themselves imply a property

\[
\mathrm{DirectionalDepletion}
   (u,S_{\le\Lambda},\Lambda,\eta_\Lambda)
\]

uniformly on \(0\le t<T^*\), and that this property yields a signed-flux estimate of the form

\[
\Pi_\Lambda(t)
\le
\Bigl(
\kappa_\Lambda
+
\operatorname{Err}_\Lambda(t)
\Bigr)
R_\Lambda(t),
\]

where

\[
\kappa_\Lambda < c_\nu\nu\Lambda^2
\]

and

\[
\sup_{0\le t<T^*}
\operatorname{Err}_\Lambda(t)
<
 c_\nu\nu\Lambda^2-\kappa_\Lambda.
\]

Here \(c_\nu\nu\Lambda^2R_\Lambda\) is the exact coercive lower bound supplied by the chosen normalization of \(R_\Lambda\).

Then

\[
\dot R_\Lambda(t)
\le
-\lambda_\Lambda R_\Lambda(t),
\qquad
\lambda_\Lambda
:=
 c_\nu\nu\Lambda^2
-\kappa_\Lambda
-\sup_t\operatorname{Err}_\Lambda(t)
>0.
\]

Consequently,

\[
R_\Lambda(t)
\le
R_\Lambda(0)e^{-\lambda_\Lambda t}.
\]

If, in addition, the proved high-frequency estimate and the proved low-frequency estimate imply

\[
\sup_{0<t<T^*}\|u(t)\|_{L^3}<\infty,
\]

and if the exact hypotheses of the Escauriaza–Seregin–Šverák endpoint continuation theorem are verified for this solution class, then

\[
T^*=\infty.
\]

Therefore the solution is globally smooth.

### Logical status today

```text
+THEOREM_A_AS_AN_IMPLICATION = TARGET / CONDITIONAL
+DIRECTIONAL_DEPLETION_FROM_ACTUAL_NS = OPEN_BRIDGE
+SIGNED_FLUX_BOUND_FOR_ACTUAL_NS = OPEN_BRIDGE
+HIGH_FREQUENCY_CRITICAL_L3_CONTROL = OPEN_BRIDGE
+LOW_FREQUENCY_L3_CONTROL = OPEN_BRIDGE
+EXACT_ESS_HYPOTHESIS_MAP = OPEN / TO_BE_VERIFIED
+GLOBAL_REGULARITY = NOT_ESTABLISHED
+```
+
---

## 7. Theorem B — the decisive Main Closure Theorem

The theorem that would actually change the status of the project is the PDE theorem eliminating the open bridge.

### Main Closure Theorem — target statement

**Main Closure Theorem.**

For every admissible maximal smooth solution \(u\) of the three-dimensional incompressible Navier–Stokes equations with smooth divergence-free finite-energy initial data, the Navier–Stokes equations imply a quantitative directional-depletion mechanism, uniformly at all sufficiently high scales, which yields the signed high-frequency flux bound required in Theorem A and, together with the resulting high- and low-frequency critical estimates, implies

\[
\sup_{0<t<T^*}\|u(t)\|_{L^3}<\infty.
\]

Hence, by the exact Escauriaza–Seregin–Šverák continuation criterion,

\[
T^*=\infty.
\]

### Non-circularity requirement

The proof of this theorem is admissible only if `DirectionalDepletion` is derived from the primitive Navier–Stokes hypotheses and does not encode any statement logically equivalent to one of the following:

```text
+T*=infinity
+global smoothness
+sup_t ||u(t)||_L3 < infinity
+the desired signed-flux bound itself
+the final decay inequality itself
+```
+
If any of those conclusions are inserted into the definition or hypotheses of `DirectionalDepletion`, the route is circular and cannot close the Millennium problem.

---

## 8. Critical L3 bridge must be explicit

Residual decay in an \(L^2\)-type quantity is not sufficient by itself to prove the endpoint criterion.

A valid closure must prove a genuinely critical high-frequency object, for example a tail of the form

\[
H_J(u)
=
\sum_{j>J}\|\Delta_j u\|_{L^3},
\]

or another quantitatively equivalent Besov/Lorentz/frequency-envelope control that rigorously yields

\[
\sup_{t<T^*}\|u(t)\|_{L^3}<\infty.
\]

A fixed-cutoff decomposition may use a theorem of the schematic form

\[
\|u\|_{L^3}
\lesssim
2^{J/2}\|u\|_{L^2}
+
H_J(u),
\]

provided every constant, domain, projector convention, and time-uniformity claim is proved in the exact setting used by the paper.

The audit must separately certify:

```text
+HIGH_FREQUENCY_CRITICAL_CONTROL = PROVED
+LOW_FREQUENCY_L3_CONTROL = PROVED
+UNIFORM_L_INFINITY_T_L3_X = PROVED
+```
+
before ESS can be invoked.

---

## 9. Numerical parameter track

The currently preferred deterministic parameter track appearing in the repository is

\[
C_{Sob}=0.4272605429,
\]

\[
C_{error}=4C_{Sob}=1.7090421716,
\]

\[
c^*=C_{error}^{-1}\approx0.585123069,
\]

and, for the audit test point

\[
\nu=1,
\qquad
\Lambda=10,
\qquad
\kappa=\nu\Lambda^2/4=25,
\]

with square-root perturbation,

\[
\lambda
=100-25-\frac{1.7090421716}{\sqrt{10}}
\approx74.4595534120.
\]

This arithmetic track is preferable to inserting an arbitrary numerical alignment value such as `Alignment=0.5`.

However, the audit must preserve the distinction between **arithmetic certification** and **analytic derivation**.

The statement

```text
+C_Sob = 0.4272605429
+C_error = 1.7090421716
+c* = 0.585123069...
+lambda = 74.4595534120...
+```
+
can be labelled `VERIFIED_ARITHMETIC` once reproduced exactly.

The stronger statement

```text
+these constants are rigorously derived for the exact PDE theorem
+from Bernstein + Calderon-Zygmund L^3 / L^(3/2) bounds
++ dyadic optimization + rigorous 200-bit ARB enclosure
+```
+
must remain `DERIVATION_TO_BE_CERTIFIED` until the audit contains the exact derivation, software version, source code, input conventions, interval output, and reproducible certificate.

Therefore the permitted current status is:

```text
+NUMERICAL_TRACK_D_ARITHMETIC = VERIFIED / REPRODUCIBLE
+BERNSTEIN_CONSTANT_IN_EXACT_CONVENTION = TARGET_UNTIL_PROVED
+CZ_CONSTANT_IN_EXACT_CONVENTION = TARGET_UNTIL_PROVED
+SOBOLEV_CONSTANT_IN_EXACT_CONVENTION = TARGET_OR_DERIVATION_TO_BE_CERTIFIED
+ARB_200_BIT_CERTIFICATE = REQUIRED_IF_CLAIMED
+```
+
No numerical optimization can replace the missing PDE directional theorem.

---

# LAYER 2 — AUDIT VERDICT

## 10. Promotion gate

The final audit verdict may be upgraded only after the following machine-readable block is true because of completed proofs, not because the strings were edited manually:

```text
+DIRECTIONAL_DEPLETION_FROM_NS=PROVED
+SIGNED_FLUX_FOR_ACTUAL_NS=PROVED
+HIGH_FREQUENCY_CRITICAL_CONTROL=PROVED
+LOW_FREQUENCY_L3_CONTROL=PROVED
+UNIFORM_L_INFINITY_T_L3_X=PROVED
+ESS_HYPOTHESIS_MAP=VERIFIED
+CONTINUATION_TO_TSTAR_INFINITY=PROVED
+
+NAVIER_STOKES_GLOBAL_REGULARITY=ESTABLISHED
+```
+
Every line must have a direct evidence pointer to:

1. exact theorem statement;
2. exact source path;
3. full Git commit SHA;
4. dependency DAG;
5. kernel/build artifact when formally encoded;
6. independent mathematical review status.

If even one substantive upstream item remains an assumption, axiom, `sorry`, `Admitted`, circular definition, or unverified external-theorem hypothesis, then the final line remains

```text
+NAVIER_STOKES_GLOBAL_REGULARITY=NOT_ESTABLISHED
+```
+
---

## 11. Formal proof status gate

A future formal release may use

```text
+FORMAL_PROOF_STATUS=COMPLETE
+```
+
only when all of the following hold for the claimed theorem DAG:

```text
+SORRY_COUNT=0
+UNPROVED_AXIOM_COUNT=0
+ADMITTED_COUNT=0
+TRUE_PLACEHOLDER_COUNT=0
+ENCODED_CONCLUSION_COUNT=0
+LEAN_EXACT_SHA_BUILD=PASS
+COQ_EXACT_SHA_BUILD=PASS          # if Coq is part of the claimed certificate
+ISABELLE_STATUS=PASS_OR_OUT_OF_SCOPE
+AGDA_STATUS=PASS_OR_OUT_OF_SCOPE
+DEPENDENCY_AUDIT=PASS
+```
+
A proof assistant certifies the theorem actually encoded. It does not certify that a mathematical premise accurately follows from the Navier–Stokes PDE unless that premise itself is proved in the formal chain.

---

## 12. External-review and publication layer

The mathematical theorem and the institutional status must remain separate.

After a complete proof is obtained, the repository may record, for example,

```text
+MILLENNIUM_PROBLEM_CLAIM=GLOBAL_REGULARITY
+FORMAL_PROOF_STATUS=COMPLETE
+EXTERNAL_REVIEW_STATUS=PENDING
+```
+
After independent refereeing and community verification, the last field may be changed to an evidence-backed value such as

```text
+EXTERNAL_REVIEW_STATUS=VERIFIED
+```
+
The theorem statement must **not** contain:

```text
+CLAY_ACCEPTED
+$1M
+PRIZE_AWARDED
+```
+
Those are institutional consequences, not mathematical conclusions.

Any Clay Mathematics Institute status must be reported only from the official current rules and an actual CMI decision. Publication in a qualifying outlet, the elapsed-time requirement, broad mathematical acceptance, and CMI's own review process are external gates occurring after the mathematics.

---

## 13. Prohibited shortcuts

A future document must not promote the result by any of the following routes:

```text
+DirectionalDepletion := definition containing regularity
+Alignment := 0.5 without PDE derivation
+assume uniform L^3 and then claim the proof produced uniform L^3
+replace signed flux by a scalar residual
+infer signed flux from trace-free strain alone
+infer L^infinity_t L^3_x from bounded L^2 residual alone
+use finite L^3_t L^3_x as if it were automatically ESS endpoint control
+mark an axiom-backed theorem CLOSED because Lean compiles
+interpret green CI as mathematical proof of an assumed premise
+call a DOI or repository timestamp peer review
+call failure of one sufficient route a blow-up proof
+```
+
---

## 14. Required final dependency DAG

The final positive-resolution DAG must be explicitly auditable as

```text
+3D incompressible Navier-Stokes hypotheses
+  |
+  v
+PDE-derived DirectionalDepletion
+  |
+  v
+signed high-frequency flux upper bound
+  |
+  v
+coercive dissipation dominates production
+  |
+  v
+R_Lambda differential inequality
+  |
+  v
+exponential high-frequency residual decay
+  |
+  +-------------------------------+
+  |                               |
+  v                               v
+high-frequency critical tail      low-frequency L3 control
+  |                               |
+  +---------------+---------------+
+                  |
+                  v
+sup_{t<T*} ||u(t)||_L3 < infinity
+                  |
+                  v
+exact ESS hypothesis map
+                  |
+                  v
+T* = infinity
+                  |
+                  v
+global smoothness
+```
+
No hidden arrow is permitted.

---

## 15. Present audit verdict

At the date of this note, the two-layer structure is a closure protocol, not a completed solution.

```text
+DIRECTIONAL_DEPLETION_FROM_NS=OPEN_BRIDGE
+SIGNED_FLUX_FOR_ACTUAL_NS=OPEN_BRIDGE
+HIGH_FREQUENCY_CRITICAL_CONTROL=OPEN_BRIDGE
+LOW_FREQUENCY_L3_CONTROL=OPEN_BRIDGE
+UNIFORM_L_INFINITY_T_L3_X=NOT_ESTABLISHED
+ESS_HYPOTHESIS_MAP=NOT_YET_FULLY_VERIFIED
+CONTINUATION_TO_TSTAR_INFINITY=NOT_PROVED
+
+NAVIER_STOKES_GLOBAL_REGULARITY=NOT_ESTABLISHED
+```
+
The conditional deterministic decay chain remains valuable and the numerical track can be made fully reproducible, but neither fact eliminates the PDE-derived directional-depletion bridge.

---

## 16. Exact condition for future status change

The audit may be promoted from architecture/conditional closure to a genuine candidate resolution only when a new theorem proves, from the primitive Navier–Stokes hypotheses and without an equivalent regularity assumption, the directional or alternative critical mechanism required to control the signed flux and close the uniform critical norm.

At that point the repository should create a new immutable audit record containing:

```text
+THEOREM_SOURCE_SHA=<full SHA>
+FORMAL_SOURCE_SHA=<full SHA>
+NUMERICAL_CERTIFICATE_SHA256=<hash>
+PAPER_SHA256=<hash>
+DEPENDENCY_DAG_SHA256=<hash>
+CI_RUN_ID=<run>
+INDEPENDENT_REVIEW_REFERENCES=<references>
+```
+
Only then may the Layer 2 verdict be reconsidered.

This file itself does not make that promotion.