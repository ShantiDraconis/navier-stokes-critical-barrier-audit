# 23 — Derivation History: How the Research Program Reached the Current Framework

## Purpose

This document answers a specific forensic question:

> **How did the research program arrive at the current error/parameter/phase/critical-barrier architecture?**

It reconstructs the sequence from timestamped repository evidence. It does not claim that every later concept was logically forced by every earlier concept. The edge labels distinguish chronology, refinement, formalization, and genuine mathematical implication.

---

# Stage 0 — Public pre-repository / archival background

## 2025-04-06 — reported Zenodo prior-art candidate

The current `TIMELINE.md` records Zenodo DOI candidate `10.5281/zenodo.15164501`, *Equations of Major Unsolved Problems in Mathematics*, as a reported public prior-art candidate.

**Audit status:** `ARCHIVE_CAPTURE_PENDING`.

This is background only until file-level checksums and metadata are captured.

---

# Stage 1 — Navier–Stokes becomes an explicit collapse/regularity target

## 2025-11-23 — `millennium-navier-stokes-I`

Earliest currently linked anchor:

```text
repo: ShantiDraconis/millennium-navier-stokes-I
commit: 64bc633ecdb3a90ccfbf1c0863963c4bdd238d0f
reported content: SBFE / I-collapse analysis
```

This is the first currently linked point in the audit where Navier–Stokes is treated as an explicit mathematical program rather than merely as one item in a list of open problems.

**Status:** `EARLIEST_CURRENTLY_LINKED`; independent complete-history verification remains required.

## 2025-11-25 — expansion of the collapse/formal framework

Recorded commits:

```text
777d58e6f1eda3872a809492183ce432ead4f030
1cd176fa02d0827cff24f61cfc27dbda21109c25
63b248dd29f1817c457acdb00e116e2e9b0687cc
```

The research now has explicit mathematical/formal objects and a reproducible Git lineage.

### Conceptual transition

```text
open PDE problem
→ identify collapse / singularity / regularity obstruction
→ attempt to encode the obstruction in explicit mathematical objects
```

This is a `REFINES` transition, not yet the later percentage-error model.

---

# Stage 2 — classical compatibility and proof-assistant representation

## 2025-11-25 to 2025-11-26 — `millennium-navier-stokes-classical`

Recorded anchors include:

```text
d853205ed10e33279327b759adc3135bcd2a262c
cca881c665f67c67d96a4f84371fb51cd9c858a0
dc55830546d50d66ccf602250c16c5c366dd4a30
867045e966812b50b2304f0460288cf6449d8221
```

The audit associates this cluster with classical/functional-space documentation and Lean/Coq/Isabelle/Agda formalization attempts.

### Conceptual transition

```text
symbolic/collapse formulation
→ ask what must survive translation to classical functional analysis
→ encode definitions/theorem targets in proof assistants
```

This transition is essential because it creates the distinction used throughout the later audit:

```text
repository-specific symbolic statement ≠ automatically classical Clay statement.
```

---

# Stage 3 — local-to-global and blow-up profile strategy

## 2025-12-04 — `Millennium`

The forensic table records `problems/NavierStokes/local-global-bridge.md` at commit

```text
c70b6f72197085ae6ecc3130b75e685028a61d10
```

with smooth compact divergence-free data, finite-time singularity branch, and self-similar/asymptotically self-similar blow-up strategy in the research path.

### Conceptual transition

```text
local PDE control
→ identify a local/global bridge problem
→ characterize a possible singularity profile
→ ask which critical quantities distinguish regularity from breakdown
```

This is the beginning of the later critical-barrier logic.

---

# Stage 4 — projection, residual, closure obstruction

## 2025-12-18 — `Millennium`

Recorded LRE/projection cluster:

```text
4af517e3f1ea5d04be1c6bbd8953209fa2139e82
54a13fedc2149f4368959d5694fd077010684f58
5a888677611ec79eb959f368e941699217487c2d
b9b4768206ee3d817cbbaf35bb7da92dc835c4e1
0d601255e51be349a1fd38eacfcbd2fda17ced77
6054851e80b463b3c994fef2acc110983769c309
```

A key decomposition recorded by the audit is

```text
u → π(u) → C(u) → Res(u)
```

with residual/high-frequency microstructure and nonlinear closure obstruction.

### Why this matters for the later error framework

Once a state is decomposed into a represented/projected component and a residual,

```text
state = represented component + unresolved component,
```

the unresolved component becomes a natural candidate for a measurable **gap** or **error coordinate**.

The audit classifies this as a **structural precursor**, not as proof that the later error vector is uniquely determined by the residual.

---

# Stage 5 — residual dynamics and coupling/correction architecture

## 2025-12-19 to 2025-12-20 — `universal-emergent-logic-`

Recorded cluster includes:

```text
f5d070d49557622c7168cd7b354d5d9629ce3fc6
730aa849b0d76b0202f08b490664aa11c164b2bf
f30ef6a9d19af290a8f461d60d70da091d73d6ed
1ed0ded98d26966189fc5936914fd964d42cbd7a
0f3ae4e275068f81f516b45b14289dd1a699e659
4cb3cd8ae5d24d5b79825346fb59ed47ff95bc9f
abdaa41189864f85d3b9f8c8fec6b3ec4431eab5
ace0acc3abd1067cd63bd94adfeffa962977bc9b
693554152c69d7ecaae4924c2fab129d205175b9
203ce4ff62809fbcf403ee03e89c3bc70ed608ec
```

The existing provenance dossier associates this line with spectral projection, residual, coupling operator, residual stability and correction dynamics.

### Conceptual transition

```text
residual is not just a remainder
→ residual becomes a dynamical object
→ define correction/coupling responses to residual state
→ track whether correction reduces the obstruction
```

This is the key precursor to the later idea of **proof as error reduction**.

---

# Stage 6 — error becomes an explicit organizing quantity

By late December 2025 the research program has accumulated:

- residuals;
- deviations from projected/ideal state;
- missing parameters;
- stability quantities;
- thresholds;
- correction trajectories.

The conceptual compression is:

```text
many heterogeneous obstructions
→ represent each obstruction by a non-negative gap/error parameter
→ compare states by their collection of gaps
```

This is where the later percentage and coordinate models become natural *within the declared framework*.

---

# Stage 7 — canonical weighted error decomposition

## 2025-12-31 18:12:37Z — `universal-emergent-logic-`

Directly verified historical anchor:

```text
commit: f7b51f6ac1cc95d357888aa60e4eeeaea24a49cf
parent: 9e2f64eb9eaa4bdc3751881e2033bf01cf80438f
tree:   1dab403b7f0ad3307100ee76373807bf1a2a3011
file:   DECOMPOSICAO_CANONICA_ERROS_MILLENNIUM.md
blob:   18d095e75c115bb94a139bda65396b7d77759355
```

Declared model:

```text
E_total = Σ_i w_i g_i(Δ_i)
```

with normalized contribution

```text
C_i = 100 · w_i g_i(Δ_i) / E_total.
```

The historical source itself explicitly recognizes that there is no unique numerical decomposition unless the error function and parameter gaps are fixed.

### What changed here

Before this point, error/gap language organized the unresolved structure. Here it becomes an explicit **scalar decomposition with percentage contributions**.

### Important distinction

The identity `Σ C_i = 100%` is mathematically provable from the definition when `E_total > 0`. The choice of `w_i`, `g_i`, and `Δ_i` is model-dependent and is not made canonical by the normalization identity.

---

# Stage 8 — parameter object becomes `(value,error)`

A subsequent directly verified commit in the same repository introduces the `Π=(π,ε)` layer. The historical audit records this as the point where error is no longer only an external score but part of the parameter object itself.

Conceptually:

```text
π = parameter estimate / state value
ε = uncertainty, gap or error attached to π
Π = (π, ε)
```

This is the bridge from scalar error bookkeeping to a state-space representation.

---

# Stage 9 — sensitivity-based contribution model

## 2025-12-31 18:13:57Z — `universal-emergent-logic-`

Directly verified anchor:

```text
commit: 08d468c32fd0ba600488887b4c325d6f1b4222dc
parent: 7fa6c094d8f8f8cee915d52d7bd5368c9d0803f2
tree:   8a7cbc99757e39d75a665d693d6476b56cef9225
file: problems/missing_parameters/ERROR_DECOMPOSITION_README.md
```

Model:

```text
contribution_i
  = (|∂E/∂θ_i| · gap_i)
    / Σ_j (|∂E/∂θ_j| · gap_j)
```

(up to the source's sign/absolute-value convention).

### Conceptual transition

```text
structural weights
→ ask how strongly E responds to each parameter
→ weight the current parameter gap by local sensitivity
```

This is mathematically distinct from the fixed structural-weight model and is therefore preserved as a parallel branch rather than silently identified with it.

---

# Stage 10 — error-coordinate geometry

## 2025-12-31 18:23:49Z — `Millennium`

Directly verified anchor:

```text
commit: bfc4cf5b804bc58348efe930651512bc079c33d4
parent: 993550da0283bb2dca298ef6fdc6b4f1d1c96699
tree:   af84c91442c181e6cf55dc6a54bfc1fd5af3a2e5
file:   ERROR_COORDINATE_SYSTEM.md
blob:   236e9875e3d93a70c8fe6676ff7b5a5c73a966aa
```

Core representation:

```text
ε(P) = (ε₁, ε₂, ..., εₙ) ∈ R_+^n
```

with framework states:

```text
Solved:  ε(P) = 0
Open:    ∃ i, ε_i > 0
Refuted: ∃ i, inf ε_i > 0
```

and proof/reduction trajectory:

```text
ε₀ → ε₁ → ... → ε_n = 0.
```

### Conceptual transition

The scalar percentage question

```text
"how much of the declared total error belongs to component i?"
```

becomes a geometric question

```text
"where is the current proof/problem state in a non-negative error-coordinate space?"
```

The L2 norm then supplies an internal magnitude/distance measure.

Again: calling the norm a "distance from proof" is an interpretation of this model. Equivalence to the classical theorem requires an independent bridge theorem.

---

# Stage 11 — convergence / threshold specialization for Navier–Stokes

Current `universal-emergent-logic-` material contains the Navier–Stokes ratio

```text
ε_NS = ||(u·∇)u||_{L²} / [ν ||Δu||_{L²}]
```

and associates a threshold near

```text
0.65 ± 0.05.
```

This is a later specialization of the general error/parameter idea to a concrete PDE ratio.

### Audit classification

- formula existence: `SOURCE_VERIFIED_CURRENT_BRANCH`;
- dimensional/functional meaning: requires mathematical audit;
- universality of threshold: `NOT_ESTABLISHED`;
- equivalence to Clay regularity/blow-up: `OPEN_BRIDGE`.

A threshold observed or declared in a model is not automatically a universal theorem.

---

# Stage 12 — phase-error decomposition

Later repository layers decompose error into real and imaginary/phase components and introduce phase cancellation/nullification and stochastic-resonance language.

Conceptual transition:

```text
ε as magnitude/vector
→ ε as multi-component dynamical state
→ separate amplitude/real contribution from oscillatory/phase contribution
→ ask whether averaging/cancellation removes a component
```

The audit proves one narrow analytic fact: a pure non-zero Fourier mode has zero average over an integer number of periods. That fact does not prove that an arbitrary PDE obstruction is a removable phase mode.

Therefore the bridge

```text
phase cancellation → classical Navier–Stokes regularity
```

remains open.

---

# Stage 13 — 2026 critical-L3 and noncircular maturation

By 2026-08-30, `navier-stokes-noncircular` contains a machine-auditable manuscript line including profile decomposition and critical-element extraction, with currently recorded anchor

```text
8f12748eb160b937174825fe3e7bdccf05e8f9af
```

The research program has therefore moved from:

```text
symbolic collapse
→ classical compatibility
→ local/global bridge
→ projection/residual obstruction
→ residual correction
→ error parameters
→ percentage decomposition
→ error coordinates
→ phase/error dynamics
→ critical-L3 / profile-decomposition / noncircular audit
```

---

# Stage 14 — September 2026 forensic separation

The current audit repository deliberately separates:

```text
A. what existed historically;
B. what is mathematically proved;
C. what is only computationally supported;
D. what remains conjectural;
E. what resembles later external work;
F. whether any causal derivation exists.
```

This separation is necessary because a Git timestamp can establish chronology but cannot prove a PDE theorem or third-party access.

---

# Exact chain in one line

```text
collapse/singularity target
→ classical/formal translation
→ local-global bridge
→ critical quantities
→ projection/residual
→ closure obstruction
→ correction dynamics
→ residual as measurable gap
→ gap/error parameters
→ weighted percentage decomposition
→ sensitivity decomposition
→ error-coordinate vector
→ norm/progress trajectory
→ NS-specific critical ratio
→ phase decomposition
→ critical-L3/profile/noncircular program
→ forensic audit of bridges and provenance.
```

---

# What this reconstruction establishes

It establishes a **documented development path inside the repository corpus**. It does not establish that every transition is a theorem, that the percentages are objective probabilities, that the error coordinates are canonical, or that the final classical Navier–Stokes bridge has been proved.

Those remaining obligations are enumerated separately in `audit/26_bridge_obligations.md`.
