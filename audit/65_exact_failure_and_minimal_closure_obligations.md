# Audit 65 — Exact failure points and minimal closure obligations

Status: `EXACT_GAP_ISOLATION_COMPLETE__PDE_CLOSURE_OPEN`

Date: `2026-09-13`

## Executive statement

The current audit can rigorously demonstrate the downstream logical chain **conditional on explicit premises**, and it can rigorously falsify several proposed sufficient shortcuts. It cannot yet demonstrate the missing PDE theorem that would make the chain unconditional.

The exact stopping point is not vague. It is the absence of a theorem deriving, from the admissible 3D Navier–Stokes dynamics alone, a quantitative mechanism strong enough to control the **signed high-frequency nonlinear flux** with a strictly sub-dissipative coefficient.

The central missing theorem may be written schematically as either

```text
NSHypotheses(u)
  -> DirectionalDepletion(u, Lambda, eta)
```

plus

```text
DirectionalDepletion(u, Lambda, eta)
  -> Pi_Lambda(u)
       <= [nu Lambda^2/4 + Err_Lambda(u)] R_Lambda(u),
```

or directly as

```text
NSHypotheses(u)
  -> Pi_Lambda(u)
       <= [nu Lambda^2/4 + Err_Lambda(u)] R_Lambda(u)
```

with

```text
Err_Lambda(u) < (3/4) nu Lambda^2
```

uniformly on the maximal interval.

No theorem currently in the repository derives this unconditionally for all admissible smooth solutions.

---

## 1. What is actually proved

### 1.1 Algebraic decay implication

The Lean file `formal/lean/CriticalBarrier/B2_DeterministicParameterChain.lean` proves:

```text
Rdot + D <= Pi
nu Lambda^2 R <= D
Pi <= (kappa + perturbation) R
---------------------------------
Rdot <= -decayRate R
```

where

```text
kappa = nu Lambda^2 / 4,
decayRate = nu Lambda^2 - kappa - perturbation.
```

This implication is valid algebra. The unresolved issue is proving its hypotheses for the actual PDE quantities.

### 1.2 Correct critical interpolation composition

The same file proves, from supplied interpolation and Sobolev premises,

```text
highL3^2 <= C_Sob * highL2 * highGradL2.
```

This corrects the invalid shortcut `L3 <= C_Sob * gradL2` on R^3.

What remains is a **uniform PDE estimate** controlling the right-hand side strongly enough on `[0,T*)`.

### 1.3 Low/high reconstruction implication

The file proves that if

```text
totalL3 <= lowL3 + highL3,
lowL3 <= lowBound,
highL3 <= H,
```

then

```text
totalL3 <= lowBound + H.
```

Again, this is a valid implication. It does not prove a uniform `H` or a uniform low-frequency bound at the required critical scale by itself.

### 1.4 Endpoint composition

The repository encodes the endpoint as an explicit interface:

```text
CriticalBound -> GlobalRegularity.
```

This is deliberately not treated as an internally reproved ESS theorem. The exact hypothesis map remains external/open until formalized at theorem level.

---

## 2. Exact failure of the proposed B2.8 scalar/strain route

The file `B2_8_SignedFlux_GapIsolation.lean` proves that the proposed coefficient

```text
C_CZ * C_Bern * 10^(3/2) * cstar
```

with the displayed audit constants is strictly larger than `25`.

Numerically the proposed chain is approximately

```text
111.0193 > 25.
```

Therefore the displayed estimate does **not** prove the desired target `strain <= 25`.

This is a failed sufficient estimate, not evidence of blow-up.

### Exact missing replacement

One needs a sharper estimate that uses information absent from the scalar norm chain. For example:

```text
||S_low||_infinity
  <= effective_directional_constant * Lambda^(3/2) * ||u_low||_3
```

with a quantitatively smaller *effective* coefficient produced by a real geometric cancellation/depletion theorem, not by changing constants ad hoc.

Equivalently, bypass strain entirely and estimate the signed flux directly.

---

## 3. Exact failure of `traceless + concentration -> alignment <= 0.9`

The finite model

```text
S = diag(1,-1/2,-1/2)
```

is trace-free.

If all normalized high-frequency weight lies in the expansive eigenvector, then

```text
Alignment = 1.
```

Thus

```text
trace(S)=0
and scalar concentration >= 1/2
```

do not imply

```text
Alignment <= 0.9.
```

### Exact missing replacement

A theorem must rule out sustained concentration of the high-frequency state in the expansive strain direction. It must contain **directional information**, for example an estimate of the form

```text
integral weight_expansive <= (1-delta) * total_weight
```

or a vorticity-direction coherence condition strong enough to imply a corresponding signed-production reduction.

Crucially, that estimate must be derived from Navier–Stokes dynamics; it cannot simply be assumed if it is of comparable strength to regularity.

---

## 4. Exact failure of scalar residual sufficiency (B2.9)

The finite Fourier countercertificate exhibits states with equal scalar high-frequency energy but different signed nonlinear interaction.

Therefore a scalar residual such as

```text
R = ||u_high||_2^2
```

cannot determine the sign or magnitude of the relevant nonlinear flux.

### Exact missing replacement

The defect state must retain enough directional/tensorial information to determine or bound the signed interaction. Candidate representations include:

```text
u_high tensor u_high,
trace-free Reynolds stress,
paraproduct-resolved flux tensors,
u cross omega,
frequency-localized strain-vorticity alignment variables.
```

The required theorem is not merely to define these objects, but to prove a coercive estimate from their PDE evolution.

---

## 5. Route A — Constantin–Fefferman type geometric depletion

A valid Route A closure would require the following sequence:

```text
A1. NS solution -> quantitative vorticity-direction coherence
A2. coherence -> depletion of vortex stretching / signed flux
A3. depletion -> sub-dissipative production bound
A4. production bound -> residual/critical-tail decay
A5. decay -> uniform L^infinity_t L3_x
A6. endpoint theorem -> continuation.
```

### Where Route A currently fails

The repository does not prove `A1` unconditionally for every admissible smooth solution.

Classical geometric criteria prove regularity **if** sufficient direction coherence holds. Using such a criterion as an assumption does not solve the global problem.

### Minimal new theorem for Route A

A genuinely new theorem would have to show that every potentially singular admissible solution automatically acquires enough directional coherence/depletion to satisfy the required signed estimate before singularity formation.

That is the central nontrivial PDE content.

---

## 6. Route B — vector/tensor defect

A valid Route B closure would replace scalar `R` by a state carrying anisotropy.

One possible schematic state is

```text
Q = P_{>Lambda}(u tensor u) - isotropic_part,
J = u x omega.
```

### What must be proved

One needs an evolution/coercivity theorem of the form

```text
NSHypotheses
  -> d/dt Phi(Q,J)
       + c * Dissipation(Q,J)
       <= subcritical_error * Phi(Q,J)
```

with a coercive functional `Phi` that also controls the critical `L3` obstruction.

### Where Route B currently fails

No such functional and evolution inequality has yet been derived in the repository for the actual NS PDE.

Merely retaining vector/tensor information fixes the **information-loss problem**, but not the **closure problem**.

---

## 7. Route C — enstrophy-production depletion

The vorticity equation yields the formal production/dissipation competition

```text
(1/2) d/dt ||omega||_2^2
  + nu ||grad omega||_2^2
  = integral omega · S omega.
```

### What must be proved

A global closure would require a bound strong enough to prevent the stretching term from defeating viscosity in the critical regime, for example schematically

```text
integral omega · S omega
  <= theta * nu ||grad omega||_2^2 + controlled_lower_order_term,
```

with `theta < 1`, plus a route from the resulting estimates to a recognized critical norm.

### Where Route C currently fails

Such a uniform coercive estimate for arbitrary admissible 3D data is precisely part of the hard global-regularity problem. The repository does not currently derive it.

A bound obtained only after assuming a priori bounded critical norms would be circular.

---

## 8. Failure of residual decay -> uniform L3 without additional control

Even if

```text
R_Lambda(t) = ||P_{>Lambda}u(t)||_2^2
```

decays exponentially for fixed `Lambda`, this alone does not give a uniform high-frequency `L3` bound.

The correct interpolation requires both an `L2` and a derivative/`L6` control:

```text
||u_high||_3^2
  <= C_Sob ||u_high||_2 ||grad u_high||_2.
```

Thus one still needs a uniform estimate for the high-frequency gradient factor or a stronger critical-tail norm.

### Exact missing theorem

One acceptable bridge would be

```text
sup_{t<T*}
  [ ||P_{>Lambda}u(t)||_2 * ||grad P_{>Lambda}u(t)||_2 ]
  < infinity,
```

with the bound obtained independently of the desired `L3` endpoint.

Alternatively, directly control a critical Besov/Littlewood–Paley tail such as

```text
sum_{j>J} ||Delta_j u||_3.
```

---

## 9. Low-frequency L3 is easier but must be fixed-scale and uniform

For fixed cutoff `Lambda`, Bernstein plus the energy inequality can control low frequencies:

```text
||P_{<=Lambda}u||_3
  <= C * Lambda^(1/2) ||u||_2.
```

Since the energy norm is controlled for Leray/smooth solutions, this is finite for fixed `Lambda`.

### Exact caveat

If `Lambda` is allowed to drift to infinity as `t -> T*`, the low-frequency bound may also grow. Therefore the final proof must either:

1. choose one fixed sufficiently large `Lambda` and close the high-frequency estimate there; or
2. prove a moving-scale estimate whose cutoff growth is itself quantitatively controlled.

The current audit has not yet proved that a single fixed cutoff suffices for all dangerous times.

---

## 10. ESS endpoint map

The target endpoint is a uniform critical bound of the form

```text
u in L^infinity(0,T*; L3(R3))
```

under the exact admissibility/solution hypotheses of the Escauriaza–Seregin–Sverak theory.

### Exact missing formal work

The repository still needs a theorem-level map proving that its concrete solution object, domain, pressure class, time interval, and norm notion satisfy the precise hypotheses of the external endpoint theorem.

Calling a proposition `CriticalBound` and assuming `CriticalBound -> GlobalRegularity` is only an interface, not a formal proof of ESS.

---

## 11. Minimal independent gaps

After eliminating duplicate or downstream obligations, the unresolved content can be reduced to four independent mathematical gaps:

```text
G1 — SIGNED NONLINEAR CONTROL
Derive a coercive signed-flux / vortex-stretching estimate from actual NS dynamics.

G2 — CRITICAL HIGH-FREQUENCY CONTROL
Convert the dissipative/defect estimate into a uniform critical high-frequency norm.

G3 — FIXED-SCALE RECONSTRUCTION
Combine high-frequency control with a uniform low-frequency estimate at a cutoff that does not degenerate near T*.

G4 — ENDPOINT HYPOTHESIS MAP
Verify the exact ESS hypotheses for the repository's solution object and deduce continuation.
```

Everything else in the current B2 chain is either already algebraically formalized, an external theorem, or downstream composition.

---

## 12. Strongest single theorem that would collapse G1–G3

A direct theorem of the form

```text
For every admissible maximal smooth 3D NS solution u,
there exists a fixed Lambda0 < infinity such that

sup_{t<T*} ||P_{>Lambda0} u(t)||_3 < infinity.
```

would, together with fixed-cutoff low-frequency Bernstein/energy control, yield

```text
sup_{t<T*} ||u(t)||_3 < infinity.
```

This would bypass the need to prove the intermediate directional mechanism explicitly.

But proving this theorem is itself essentially the critical regularity problem. It cannot be inserted as an assumption and counted as closure.

---

## 13. Exact final proof form

A legitimate positive proof can be compressed to:

```text
THEOREM.
Let u be any admissible maximal smooth solution of the 3D incompressible
Navier–Stokes equations with maximal time T*.
Then

    sup_{0 <= t < T*} ||u(t)||_L3 < infinity.

By the exact ESS endpoint theorem, T* cannot be finite.
Therefore T* = infinity, and the solution remains smooth globally.
```

The entire research problem is therefore reduced to proving the displayed uniform `L3` statement without assuming an equivalent regularity condition.

---

## 14. Current verdict

```text
ALGEBRAIC_DECAY_CHAIN = PROVED_LOGIC
B2_8_NUMERICAL_STRAIN_ROUTE = FALSIFIED_PROPOSED_IMPLICATION
TRACELESS_PLUS_CONCENTRATION_ALIGNMENT_ROUTE = FALSIFIED_PROPOSED_IMPLICATION
SCALAR_RESIDUAL_DETERMINES_SIGNED_FLUX = FALSIFIED_PROPOSED_IMPLICATION
CORRECT_L2_L6_TO_L3_INTERPOLATION = PROVED_LOGIC
LOW_PLUS_HIGH_L3_RECONSTRUCTION = PROVED_LOGIC

G1_SIGNED_NONLINEAR_CONTROL = OPEN_BRIDGE
G2_CRITICAL_HIGH_FREQUENCY_CONTROL = OPEN_BRIDGE
G3_FIXED_SCALE_RECONSTRUCTION = OPEN_BRIDGE
G4_ESS_HYPOTHESIS_MAP = OPEN/EXTERNAL

GLOBAL_REGULARITY = NOT_ESTABLISHED
FINITE_TIME_BLOWUP = NOT_ESTABLISHED
```

This document is the exact nonclosure certificate: it demonstrates every currently available implication, identifies every falsified shortcut, and reduces the remaining Navier–Stokes content to the minimal unresolved obligations above.