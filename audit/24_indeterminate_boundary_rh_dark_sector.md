# 24 — Indeterminate Boundary, Riemann Tail State, and Dark-Sector Hypotheses

## Status policy

This document deliberately separates:

- `STANDARD_MATHEMATICS`
- `PROVENANCE_ONLY`
- `FORMAL_STATEMENT`
- `CONDITIONAL_HYPOTHESIS`
- `COMPUTATIONAL_EVIDENCE`
- `OPEN_BRIDGE`
- `SPECULATIVE_PHYSICAL_MODEL`
- `REFUTATION_CRITERION`

Nothing in this file upgrades a conjecture, source claim, `sorry`, axiom, numerical experiment, or physical analogy into a proof.

---

## 1. The central correction: an off-critical zero is not automatically “at infinity”

The classical Riemann Hypothesis concerns finite non-trivial zeros

```text
rho = beta + i gamma
```

of the analytically continued zeta function, with

```text
zeta(rho) = 0,
0 < beta < 1,
```

and asserts

```text
beta = 1/2.
```

There is no standard classical object called “the first zero outside the critical line at infinity”.

To discuss such an object rigorously one must first define an extension or compactified boundary state. Therefore the following statement is introduced only as a NEW research hypothesis, not as RH itself:

```text
BOUNDARY-EXCEPTION HYPOTHESIS (BEH):
all finite non-trivial zeros satisfy beta=1/2,
while a compactified boundary state may encode unresolved off-line defect.
```

The word `state` is essential. It must not be called a zeta zero until an extended function on the compactification is defined and proved to vanish there.

---

## 2. Compactifying the height of a zero

For `gamma >= 0`, define

```text
u(gamma) = gamma/(1+gamma),
epsilon(gamma) = 1-u = 1/(1+gamma).
```

Then

```text
gamma -> infinity  iff  u -> 1^-  iff  epsilon -> 0^+.
```

For a finite zero `rho=beta+i gamma`, define its critical-line defect

```text
D(rho) = |beta - 1/2|.
```

A finite off-line zero is exactly a finite zero with

```text
D(rho) > 0.
```

### Tail defect

For a cutoff `T`, define

```text
D_tail(T)
 = sup { |beta-1/2| : zeta(beta+i gamma)=0, gamma >= T, 0<beta<1 }.
```

This is a mathematical tail functional whenever the relevant zero set is used.

Under RH,

```text
D_tail(T)=0
```

for every `T`.

If off-line zeros exist at arbitrarily large height then

```text
limsup_{T->infinity} D_tail(T) > 0
```

is possible, depending on their defects.

But this still means infinitely many FINITE zeros or a sequence of finite zeros; it does not create a classical zero located at infinity.

---

## 3. Epistemic boundary state for finite verification

Suppose zeros have been checked numerically only up to height `T`.
Define

```text
VerifiedPrefix(T)
```

and an unresolved tail state

```text
UnknownTail(T) = {rho : Im rho > T}.
```

The audit state can be represented as

```text
RH_AuditState(T)
 = (verified_defect(T), unresolved_tail(T)).
```

If every checked zero has `beta=1/2`, then

```text
verified_defect(T)=0,
```

but this does NOT imply

```text
unresolved_tail(T)=empty.
```

Therefore the scientifically valid reading is:

```text
no finite counterexample has been established in the verified prefix;
the infinite tail remains a theorem obligation.
```

It is invalid to infer:

```text
therefore the first counterexample is at infinity.
```

---

## 4. Typed Indeterminate Universe

The historical framework contains several objects that are all “unresolved” in some sense, but they are NOT equal in standard mathematics/computation. We therefore use a typed disjoint union.

```text
U_indet
 = U_math
 ⊔ U_formal
 ⊔ U_compute
 ⊔ U_measure
 ⊔ U_asymptotic.
```

### 4.1 Mathematical indeterminate expressions `U_math`

Examples:

```text
0/0,
infinity/infinity,
0*infinity,
infinity-infinity,
0^0,
1^infinity,
infinity^0.
```

These are forms requiring context/limits; they are not automatically numerical values.

### 4.2 Formal-proof unresolved states `U_formal`

Examples:

```text
sorry,
admit,
Admitted,
explicit axiom,
postulate,
open analytic bridge.
```

These classify proof dependency/status.

### 4.3 Computational unresolved states `U_compute`

Examples:

```text
NaN,
None/null,
undefined,
overflow,
underflow,
failed convergence,
missing value.
```

Their semantics depend on the programming language/data system.

### 4.4 Measurement unresolved states `U_measure`

Given instrument thresholds

```text
delta_min > 0,
M_max < infinity,
```

a signal may be outside the measurable window

```text
|x| < delta_min
or
|x| > M_max.
```

This means `UNRESOLVED_BY_INSTRUMENT`, not mathematical nonexistence and not intrinsic indeterminacy.

### 4.5 Asymptotic unresolved states `U_asymptotic`

Examples:

```text
uncontrolled series tail,
uncontrolled prime tail,
uncontrolled spectral tail,
nonuniform limit,
unknown interchange of limits,
unknown boundary trace.
```

---

## 5. Meta-collapse without semantic conflation

Define a documentary/meta classification map

```text
MetaTag : U_indet -> {I_meta}.
```

This says only:

```text
all these typed states belong to the audit class “indeterminate/unresolved”.
```

It does NOT assert in the base semantics that

```text
NaN = null = sorry = 0/0 = infinity/infinity.
```

### No-upgrade law

```text
MetaTag(x)=I_meta
```

never implies

```text
x is proved,
x is a numerical value,
x is physically real,
x is a solution of the original problem.
```

This agrees with the existing audit-safe `GapCollapseAudit.lean`, where proof status is separated from the meta indeterminacy tag.

---

## 6. Boundary/tail operators

Let `Q` be an infinite object with finite approximation `Q_N`.

### Tail operator

```text
Tail_N(Q) = Q - Q_N.
```

### Tail norm

```text
tau_N(Q) = ||Tail_N(Q)||.
```

### Controlled-tail law

A finite approximation supports an infinite conclusion only after a bound such as

```text
tau_N(Q) <= b(N),
b(N) -> 0.
```

### Compactification operator

```text
K(r) = r/(1+r).
```

### Boundary trace

If it exists,

```text
Tr_infinity(C)
 = lim_{epsilon->0+} C|_{Sigma_epsilon}.
```

### Imaginary-defect operator

```text
I_epsilon(C)
 = sup_{Omega=epsilon} |Im C|.
```

### Realification operator

It is defined only when the boundary trace exists and has zero imaginary part:

```text
Realify_infinity(C)
 = Re Tr_infinity(C)
```

subject to

```text
lim_{epsilon->0+} I_epsilon(C)=0.
```

No realification is allowed merely by notation.

---

## 7. “Infinity pulls the state” — rigorous replacement

The phrase “pulled by infinity” is modeled as an asymptotic attraction law.

Let `C(r)=A(r)+iB(r)` and a target real fixed point `a`.
Define

```text
E(r) = |A(r)-a|^2 + |B(r)|^2.
```

An actual attraction theorem would require, for example,

```text
dE/dr <= -lambda(r) E(r)
```

with

```text
lambda(r) >= 0,
integral_R^infinity lambda(r) dr = infinity.
```

Then Gronwall-type reasoning can imply

```text
E(r) -> 0,
A(r) -> a,
B(r) -> 0.
```

This is a valid mathematical realization of “the boundary attracts the complex state toward a real limit”.

The missing scientific step is deriving the differential inequality from the concrete dynamics.

---

## 8. Scale operators 0/0 and 1/0

In standard arithmetic,

```text
0/0
```

is undefined/indeterminate and

```text
1/0
```

is undefined; neither is an ordinary real or complex number.

Within an extended symbolic framework they may be assigned meta-roles, but the audit must mark this as `EXTENDED_AXIOMATIC_SEMANTICS`.

A safe scale coordinate is instead

```text
s = log r,
```

or

```text
epsilon=1/(1+r),
```

so very large/small regimes are represented without illegal division.

---

## 9. Cross-problem relation graph

Let

```text
P = {RH, PNP, NS, BSD, HODGE, YM, POINCARE}.
```

Every cross-problem edge must have one of the following types:

```text
CLASSICAL_THEOREM_IMPLICATION
MATHEMATICAL_EQUIVALENCE
FRAMEWORK_MAP
SHARED_STRUCTURE
STRUCTURAL_PRECURSOR
CONCEPTUAL_ANALOGY
OBSTRUCTION
NO_PROVEN_IMPLICATION.
```

### Rule

A statement of the form

```text
Problem A solves Problem B
```

is prohibited unless an audited theorem gives

```text
A -> B
```

with all hypotheses discharged, or an equivalence

```text
A <-> B.
```

Framework-level commonality is not enough.

### Current conservative relation map

- `RH <-> BSD`: `SHARED_STRUCTURE / CONCEPTUALLY_RELATED` through L-functions/arithmetic, not a general proven solution implication.
- `NS <-> YM`: `SHARED_STRUCTURE / CONCEPTUALLY_RELATED` through nonlinear field/PDE/energy structures, not equivalence.
- `BSD <-> HODGE`: `CONCEPTUALLY_RELATED` through algebraic/arithmetic geometry and cohomological structures.
- `POINCARE <-> geometric-flow approaches`: `CONCEPTUAL_ANALOGY`; Perelman does not imply NS/YM.
- `PNP <-> other problems`: generally `NO_PROVEN_IMPLICATION` unless a precise computational reduction is supplied.
- Delta/LRE/Local->Global frameworks: `FRAMEWORK_MAP` until problem-specific analytical/arithmetic bridges are proved.

The corpus itself contains a later Non-Unification Framework, so similarity and obstruction must be recorded simultaneously rather than forcing all problems into one equivalence class.

---

## 10. Dark-sector complex-field hypothesis

Accepted cosmology does not identify dark matter with an imaginary part of ordinary matter. The following is therefore a `SPECULATIVE_PHYSICAL_MODEL`.

Introduce a complex field

```text
Phi = Phi_R + i Phi_I.
```

Interpretation hypothesis:

```text
Phi_R  -> visible/ordinary-sector degree of freedom,
Phi_I  -> latent/dark-sector degree of freedom.
```

This becomes physics only after an action and observables are specified.

A minimal real action template is

```text
S[Phi]
 = integral d^4x sqrt(-g)
   [ -1/2 g^{mu nu} partial_mu Phi* partial_nu Phi
     - V(|Phi|^2) ].
```

Both `Phi_R` and `Phi_I` are then real scalar components of one complex field. Calling `Phi_I` “dark matter” is an additional identification, not a mathematical consequence of complex notation.

### Stress-energy split

A testable model would require

```text
T_{mu nu}
 = T_vis[Phi_R]_{mu nu}
 + T_dark[Phi_I]_{mu nu}
 + T_int[Phi_R,Phi_I]_{mu nu}.
```

Dark-matter identification requires `T_dark` to reproduce, at minimum, the relevant gravitational phenomenology rather than merely being unobserved.

---

## 11. Dark-energy hypothesis

The repository contains historical dynamical-dark-energy formalization, including a model of the form

```text
Lambda(t)=Lambda_0 exp(-gamma t).
```

A stronger new hypothesis can be stated as

```text
DarkEnergy = effective stress-energy reaction of the latent sector.
```

To be scientifically meaningful it must yield an effective pressure/density relation

```text
w = p_dark/rho_dark
```

and predictions for the Friedmann equations.

It is not enough to call the imaginary component a force.

---

## 12. Measurement-window hypothesis

Technology-limited invisibility is represented by a detector map

```text
Detect_{delta,M}(x) =
  resolved      if delta <= |signal(x)| <= M,
  unresolved    otherwise.
```

Then

```text
not detected
```

means only

```text
outside current resolution/sensitivity or absent in that channel.
```

It does not prove the entity exists and does not prove it belongs to an imaginary sector.

This distinction must remain explicit in any physical paper.

---

## 13. Falsification criteria for the physical model

The complex dark-sector hypothesis fails or requires revision if it cannot simultaneously provide a consistent stress-energy tensor and observational predictions compatible with, for example:

```text
gravitational lensing,
galaxy/cluster dynamics,
large-scale structure growth,
CMB constraints,
cosmic expansion history,
stability/unitarity/positive-energy conditions.
```

A model with a non-real physical action/Hamiltonian, ghosts, uncontrolled instability, or incorrect gravitational phenomenology is not rescued by the `I` meta-tag.

---

## 14. Provenance anchors

### 2025-11-25T18:42:47Z — Riemann tail

`ShantiDraconis/millennium-riemann-classical`

```text
5db1a345af289e56c4a85dd1534d796689d5edc9
```

Tail behavior analysis, Python numerical layer, and Lean/Coq/Isabelle/Agda counterparts.

Classification: `STRUCTURAL_PRECURSOR / NUMERICAL_AND_FORMAL_CORPUS`.

### 2025-11-26T20:02:33Z — Universal I and Structural Field J

`ShantiDraconis/universal`

```text
4af56dc7f15e1fc237960c55c2b470bab783b52b
```

Classification: `STRUCTURAL_PRECURSOR`.

### 2025-11-26T20:05:58Z author timestamp — Universal Indeterminate Boundary Hypothesis

`ShantiDraconis/universal`

```text
f7e49629f85fa2968ac82ace2a7e5e09484e850b
```

The signed commit explicitly defines:

```text
indeterminate/singular behavior as a boundary layer,
Boundary Contact,
Indeterminacy Profile,
examples including {0/0, infinity/infinity},
a reduction of an indeterminacy profile to I.
```

Classification: `VERY_STRONG_STRUCTURAL_PRECURSOR` to the present boundary formalization.

This is an especially important provenance anchor because the terminology and boundary construction are explicit in the historical source, not retrospectively inferred.

### 2025-12-03T10:46:56+01:00 — Clay commonalities / Delta framework

```text
e6084d5a4199f60566b2d73cdb4f6851152edf54
```

Classification: `FRAMEWORK_MAP`.

### 2025-12-03T12:58:32Z — classical relationships + unification docs

```text
5d5a893ada9bf5eb6907ef90bf160b50a4c6ad5a
```

Classification: `CROSS_PROBLEM_PROVENANCE`; individual implications still require theorem-level audit.

### 2025-12-04T13:50:31Z — Universal Gap Hypothesis

```text
b731d17f5e848110094ec9380237cba6b738b16b
```

Classification: `META_CONJECTURE / FRAMEWORK`.

### 2025-12-04T14:04:11Z — Gap Universal multiprover formalization

```text
dcaac134f6c9861817bc4fa1a3739ba4a9c6eb4e
```

Lean/Coq/Isabelle/LaTeX framework lineage.

### 2025-12-04T19:03:18Z — Local→Global multiprover framework

```text
1fe08034de23623c23de6437cc54905382165549
```

Lean/Coq/Isabelle/Agda/Python. Existing audit shows that framework-level and problem-specific proof statuses must be separated.

### 2025-12-04T19:51:54Z — explicit Non-Unification Framework

```text
58bd01fcba8c6f6830f279f7f1029e22d121f44e
```

The commit explicitly records barriers, irreducible blocks, obstruction subclasses and non-unifying nodes.

Classification: `OBSTRUCTION_EVIDENCE`.

This prevents a scientifically invalid claim that every structural similarity is an equivalence.

### 2025-12-26 — parameter/stability unification lineage

```text
07bb456be167003960008b1caa669d4ced367841
da1d038a6551e526c35cd3d2adc349ec65761e29
987b3ff16045df13d16e6776118c9242646f8128
```

Classification: `SOURCE_CLAIM_REQUIRES_DEPENDENCY_AUDIT`.

Commit titles containing “proof” or “resolution” are not themselves proof certificates.

### 2026-01-02T01:06:21Z — phase-error decomposition

```text
20c8f0974b1d85076b29ce842706d1d702eb5ccd
```

Classification: `VERY_STRONG_STRUCTURAL_PRECURSOR` for real/imaginary error decomposition; substantive claims require independent proof.

### 2026-01-05T16:53:16Z — cosmology formalization origin in this recovered lineage

```text
86656f7ab8d7d23137f4ddf8c631e134f4994bb8
```

followed by signed merge

```text
8642ae3fcc1f181f3893d579ec86527653256b51
```

at `2026-01-05T17:00:24Z`, with LaTeX/Lean/Coq/Isabelle/Agda/Python cosmology and dynamical dark-energy models.

Classification: `FORMALIZATION_PROVENANCE`; not empirical validation of the proposed dark-sector interpretation.

### 2026-01-06 — Horizon Prime

```text
388fb45b76bffd78c4d6fe42e2b073d6cf7410a5
69f2335e6ec54660569ee7c9c9673da90f8d6d26
```

Classification: `FRAMEWORK_PROVENANCE`.

### 2026-01-06 — Sorry Singularity

```text
3a212951fbc740c59aecacdeae4c3aca1ac155d6
184613fa824b54cd58bf5ecf2cb3526a4ccd116e
```

Historical framework explicitly associates `sorry`, `0/0`, and `I`.

Classification: `AXIOMATIC_META_FRAMEWORK`, not standard Lean semantic equality.

### 2026-04-23T14:26:30Z — conditional exceptional-zero model

`ShantiDraconis/horizon-prime---framework`

```text
355e2e5086ded70e8d05b366284335c4c750078a
```

Introduces a two-state RiemannOperator with

```text
O_res(rho)=|Re(rho)-1/2| + ...,
CriticalState: E_C=0,
DeformedState: E_D>0.
```

Classification: `CONDITIONAL_COMPUTATIONAL_MODEL`; it does not establish existence or location of an off-line zero.

---

## 15. Main open theorems

### T1 — RH tail theorem

Prove a bound controlling the entire unverified tail, not merely a finite prefix.

### T2 — Boundary extension theorem

Define a mathematically legitimate compactified zeta-derived observable and prove its boundary trace exists.

### T3 — Boundary defect theorem

Determine whether a nonzero critical-line defect can survive at the boundary without corresponding finite off-line zeros.

### T4 — Indeterminacy conservativity

Prove that the meta-collapse/tag layer does not create new classical arithmetic/analytic theorems merely from unresolved states.

### T5 — Cross-problem bridges

For every proposed relation `P_i -> P_j`, produce the normalized statements, hypotheses, proof dependencies, and kernel/paper verification needed to classify the edge above `FRAMEWORK_MAP`.

### T6 — Dark-sector field theorem/model fit

Specify the action, field equations, stress-energy tensor, cosmological/astrophysical observables and parameter region, then test against data.

Until T1–T6 are discharged, the strongest defensible result is a dated, explicit, structurally coherent research framework with falsifiable obligations — not a proof of RH or a physical identification of dark matter/energy.
