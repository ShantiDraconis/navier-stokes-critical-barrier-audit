# 26 — Mathematical Bridge Obligations

The purpose of this file is to convert vague statements such as "the framework solves the problem" into explicit propositions that can be proved, falsified, or left unresolved.

---

## B1 — Define the admissible Navier–Stokes solution class

Before any error functional can certify regularity, specify:

- domain (`R^3`, `T^3`, bounded domain, etc.);
- viscosity `ν>0`;
- forcing class;
- initial-data class;
- divergence-free constraint;
- weak/strong/mild solution concept;
- maximal existence interval `[0,T*)`;
- boundary/decay conditions.

**Status:** `REQUIRED_FOUNDATIONAL_BRIDGE`.

---

## B2 — Well-definedness of the NS ratio

For

```text
ε_NS(u) = ||(u·∇)u||_{L²} / (ν ||Δu||_{L²}),
```

prove on the declared solution class:

1. numerator finite;
2. denominator finite;
3. denominator nonzero, or explicitly define the zero-denominator branch;
4. measurability in time;
5. invariance/covariance under the intended NS scaling;
6. behavior for trivial/harmonic states.

**Status:** `OPEN_BRIDGE`.

---

## B3 — Threshold theorem

If a threshold `c_*` is claimed, prove a theorem of the form

```text
For every admissible solution u,
if sup_{t<T} ε_NS(u(t)) ≤ c_*,
then [explicit regularity conclusion].
```

The value `0.65±0.05` cannot be promoted from model calibration/numerical evidence to theorem constant without such a proof.

**Status:** `OPEN_BRIDGE`.

---

## B4 — Error coordinates must control a recognized critical quantity

For a chosen error vector `ε(P,u)`, prove an estimate such as

```text
||u||_{L∞(0,T;L³)} ≤ F(||ε(P,u)||, data),
```

with `F` finite under the claimed solved/controlled regime.

An alternative is to control another classical regularity criterion and then prove the implication to regularity.

**Status:** `OPEN_BRIDGE`.

---

## B5 — Zero error must be equivalent to the intended mathematical state

The model definition

```text
Solved ⇔ ε(P)=0
```

is not sufficient. For Navier–Stokes one needs a theorem connecting the coordinates to the PDE, e.g.

```text
ε_NS_vector(u)=0
⇒ u satisfies all hypotheses of a classical global-regularity criterion.
```

If an equivalence is claimed, prove both directions.

**Status:** `OPEN_BRIDGE`.

---

## B6 — Projection/residual bridge

Given a decomposition such as

```text
u = C(u) + Res(u),
```

prove precisely how `Res(u)` controls:

- nonlinear closure error;
- high-frequency concentration;
- critical L3 behavior;
- pressure reconstruction;
- forcing residual;
- possible singularity formation.

A small residual in one norm does not automatically imply regularity in a critical norm.

**Status:** `PARTIAL_STRUCTURAL_RESULTS / OPEN_ANALYTIC_BRIDGE`.

---

## B7 — Correction dynamics must preserve the PDE constraints

If a correction operator `K(R,d)` or equivalent is used, prove that iteration preserves or appropriately controls:

- divergence-free condition;
- initial data;
- boundary/decay conditions;
- pressure compatibility;
- forcing regularity;
- solution class;
- convergence in a topology strong enough to pass the nonlinear term to the limit.

**Status:** `OPEN_BRIDGE`.

---

## B8 — Monotone error reduction must imply mathematical convergence

Internal monotonicity

```text
||ε_{k+1}|| ≤ ||ε_k||
```

does not alone imply `ε_k→0`, nor convergence of PDE states.

Need, for example:

```text
(a) strict/coercive decrease or summable decrement,
(b) compactness/completeness,
(c) identification of every zero-error limit with the desired PDE state.
```

**Status:** `OPEN_BRIDGE`.

---

## B9 — Percentage decomposition requires calibration semantics

For

```text
E = Σ w_i g_i(Δ_i),
```

specify and justify:

- what physical/mathematical quantity `E` measures;
- why each `Δ_i` is normalized to `[0,1]`;
- why each `g_i` is chosen;
- how weights are identified;
- uncertainty/confidence intervals;
- sensitivity to reparameterization.

Without this, percentages are internally normalized structural contributions, not objective probabilities of correctness.

**Status:** `MODEL_CALIBRATION_OPEN`.

---

## B10 — Structural and sensitivity scalarizations

Determine conditions under which

```text
w_i g_i(Δ_i)
```

and

```text
|∂E/∂θ_i| Δ_i
```

produce equivalent rankings/contributions.

In general they need not.

**Status:** `OPEN_EQUIVALENCE`.

---

## B11 — Phase decomposition theorem

If

```text
ε = ε_R + i ε_I,
```

is used, define:

- the complex vector space;
- the operator generating phase evolution;
- the measure/interval used for averaging;
- periodicity or ergodicity assumptions;
- why the imaginary component corresponds to a removable obstruction rather than physical/mathematical information.

**Status:** `OPEN_FOUNDATIONAL_BRIDGE`.

---

## B12 — Phase cancellation to regularity

The proved fact

```text
average of Ae^{iωt} over whole periods = 0
```

must be supplemented by a theorem showing that the relevant PDE error is representable by controlled zero-mean modes and that cancellation controls a recognized regularity norm.

**Status:** `OPEN_BRIDGE`.

---

## B13 — ESS endpoint bridge

Record exact hypotheses of the Escauriaza–Seregin–Šverák endpoint result and prove that the repository's solution class satisfies them.

Then establish either:

```text
repository condition ⇒ bounded L∞_t L³_x,
```

or, for a singularity construction,

```text
T*<∞ ⇒ the required critical L3 blow-up behavior is realized without violating other hypotheses.
```

**Status:** `OPEN_APPLICATION_BRIDGE`.

---

## B14 — Pressure compatibility

Using

```text
-Δp = ∂_i∂_j(u_i u_j)
```

in the appropriate setting, verify that any proposed local correction/compact-support construction has globally compatible pressure and the required regularity/decay.

**Status:** `UNDER_AUDIT`.

---

## B15 — Smooth forcing compatibility

For a forced construction, compute the exact residual

```text
f = ∂_t u - νΔu + (u·∇)u + ∇p
```

and prove that `f` belongs to the exact forcing class claimed, including at the proposed singular time/transition.

**Status:** `UNDER_AUDIT`.

---

## B16 — Universal quantification

Every computational test is finite. To prove the Clay-style universal statement, replace finite sampling with estimates valid for all admissible initial data/solutions in the theorem's domain.

**Status:** `OPEN_BRIDGE`.

---

## B17 — Formal proof audit

For every Lean/Coq/Isabelle/Agda theorem claimed as completed:

1. identify exact commit/blob;
2. pin compiler/prover versions;
3. compile from clean environment;
4. scan transitive imports for `sorry`, `Admitted`, axioms/postulates and equivalent escape hatches;
5. classify legitimate classical axioms separately from placeholders;
6. inspect theorem statement for equivalence to the intended classical statement.

**Status:** `IN_PROGRESS`.

---

## B18 — Provenance completeness

Enumerate all branches, tags, PR heads and reachable commits for all relevant repositories. Recover deleted/renamed/moved files and record full SHA, parent SHA, tree SHA, blob SHA, author date, committer date, and immutable URL.

**Status:** `IN_PROGRESS`.

---

## B19 — Archive mapping

For each Zenodo/DOI object, record exact file list and checksums and compare raw bytes against Git blobs/files.

**Status:** `OPEN`.

---

# Completion criterion

The audit may only promote a classical Navier–Stokes result to `PROVED` when all bridges actually used in that proof path are discharged. Internal identities and successful unit tests are necessary quality controls but cannot substitute for B1–B16.
