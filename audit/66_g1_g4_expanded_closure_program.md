# Audit 66 — Expanded G1–G4 closure program

Status: `MAXIMAL_SAFE_CLOSURE_PROGRAM__FINAL_THEOREM_CONDITIONAL`

Date: `2026-09-13`

## Core correction

For smooth incompressible 3D Navier–Stokes,

```text
(1/2) d/dt ||omega||_2^2 + nu ||grad omega||_2^2
  = integral omega · S omega.
```

Do not identify pointwise `omega·S omega`, `det S`, and `tr(S^3)`. Betchov-type integral identities require exact domain/decay conventions and constants and must be proved separately.

## G1 — exact PDE obstruction

The scalar route gives only a supercritical comparison of the schematic form

```text
y' + 2 nu z <= C y^(3/4) z^(3/4),
y = ||omega||_2^2,
z = ||grad omega||_2^2.
```

Young reduces this to a cubic ODE upper bound `y' <= C_nu y^3`, which does not preclude finite-time growth. Improving decimal constants does not change the supercritical exponent structure.

A useful closure theorem must instead produce a genuinely coercive form, for example

```text
integral omega · S omega
  <= theta nu ||grad omega||_2^2 + a(t)||omega||_2^2,
```

with `theta<1` and `a in L1(0,T*)`, or directly a signed high-frequency flux bound with strict dissipative margin. Then Gronwall yields a uniform enstrophy bound.

### Route A: geometric depletion

Target: derive dangerous-set vorticity-direction coherence from the NS dynamics themselves, then convert the nonlocal Biot–Savart representation into depleted vortex stretching. Classical Constantin–Fefferman type hypotheses are conditional regularity criteria; the universal derivation of sufficient coherence is the open step.

### Route B: vector/tensor defect

Replace scalar residual information by an anisotropic state such as trace-free high-frequency Reynolds stress, paraproduct-resolved flux, or `u × omega`. Required: a coercive functional whose evolution closes and which controls the critical tail. Defining the tensor is not enough.

### Route C: integrable enstrophy production

Target an estimate

```text
integral omega · S omega
 <= theta nu ||grad omega||_2^2 + a(t)||omega||_2^2,
int_0^T* a(t) dt < infinity.
```

This gives uniform `L^infinity_t L2_x` control of vorticity without a cubic comparison term.

## G2 — high-frequency critical control

The clean non-PDE implication is:

```text
uniform ||omega(t)||_2 <= M
+ homogeneous Sobolev H^(1/2) -> L3
+ high-frequency spectral inequality
  ||P_{>Lambda}u||_{Ḣ^(1/2)}
    <= Lambda^(-1/2)||P_{>Lambda}u||_{Ḣ^1}
+ div-curl identity/control ||grad u||_2 <= C||omega||_2
----------------------------------------------------------------
||P_{>Lambda}u(t)||_3 <= C Lambda^(-1/2) M.
```

Hence a single fixed `Lambda0` can make the high-frequency `L3` tail arbitrarily small.

Important: this is a theorem only after the projector normalization, homogeneous Sobolev embedding, and div-curl estimate are stated and proved in the concrete functional setting. The audit therefore records G2 as `FORMALIZATION_TARGET`, not silently `PROVED` merely from an informal dyadic calculation.

## G3 — fixed-scale reconstruction

For fixed `Lambda0`, Bernstein + energy give

```text
||P_{<=Lambda0}u(t)||_3
 <= C_low Lambda0^(1/2)||u(t)||_2
 <= C_low Lambda0^(1/2)||u0||_2.
```

Together with G2,

```text
sup_{t<T*} ||u(t)||_3
 <= C_low Lambda0^(1/2)||u0||_2 + epsilon < infinity.
```

No smallness of the total global `L3` norm is required for the standard ESS endpoint theorem; boundedness in `L^infinity_t L3_x` is the relevant endpoint regularity criterion. Therefore the low-frequency term may be large but finite. This removes an unnecessary small-data restriction from the reconstruction stage.

## G4 — ESS hypothesis map

The repository must map its exact maximal smooth/suitable weak solution object to the precise Escauriaza–Seregin–Sverak endpoint statement. This requires explicit domain, pressure, time-essential-supremum, solution-class, and continuation hypotheses. A formal interface is not a machine proof of ESS.

## Minimal chain

```text
G1: actual NS -> uniform enstrophy (or equivalent critical coercivity)
G2: uniform enstrophy -> fixed-cutoff high-frequency L3 bound
G3: energy + Bernstein low frequencies + G2 -> uniform total L3 bound
G4: exact ESS endpoint map -> continuation
---------------------------------------------------------------
T* = infinity.
```

## Current classification

```text
G1_SIGNED_NONLINEAR_CONTROL = OPEN_BRIDGE
G2_HIGH_FREQUENCY_L3 = FORMALIZATION_TARGET
G3_FIXED_SCALE_RECONSTRUCTION = PROVED_LOGIC_ON_EXPLICIT_PREMISES
G4_ESS_HYPOTHESIS_MAP = OPEN/EXTERNAL
FINAL_THEOREM_STATEMENT = SPECIFIED
NAVIER_STOKES_GLOBAL_REGULARITY = NOT_ESTABLISHED
```

This note deliberately separates a proof architecture from a proof of the missing PDE theorem.