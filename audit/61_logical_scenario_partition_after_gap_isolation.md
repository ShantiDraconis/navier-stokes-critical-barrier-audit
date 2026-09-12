# Audit 61 — Logical scenario partition after B2.8 gap isolation

Status: `SCENARIO_PARTITION_NOT_DICHOTOMY_PROOF`

Date: `2026-09-13`

## Purpose

This note isolates what remains logically admissible after the B2.8/B2.9 countercertificates. It does **not** claim that Navier–Stokes has two physically coexisting quantum states, does **not** prove a small/large-data bifurcation for the 3D Millennium problem, and does **not** derive finite-time blow-up from failure of the proposed closure route.

The audit distinction is:

```text
failure of a sufficient proof route != proof of the negation of the target theorem.
```

## 1. What the deterministic chain actually proves

`B2_DeterministicParameterChain.lean` proves an implication of the form

```text
Rdot + D <= Pi
nu Lambda^2 R <= D
Pi <= (kappa + perturbation) R
---------------------------------
Rdot <= -decayRate R.
```

For the displayed target normalization, the arithmetic decay-rate expression is approximately `74.4596`. Therefore exponential decay is available **conditionally when the required flux/dissipation premises hold**. The repository does not currently prove that a scalar threshold `R0 < Rcrit` alone forces those premises for every actual 3D Navier–Stokes solution.

Consequently the statement

```text
R0 below threshold -> T*=infinity
R0 above threshold -> T*<infinity
```

is **not established** by the current audit.

## 2. What the gap certificate removes

`B2_8_SignedFlux_GapIsolation.lean` isolates two failures of proposed sufficient routes:

```text
proposed strain coefficient > kappa=25
```

for the stated parameter chain, and

```text
trace-free strain + scalar concentration -/-> Alignment <= 0.9.
```

The finite alignment model

```text
S = diag(1,-1/2,-1/2)
```

can place normalized high-frequency weight entirely in the expansive direction and obtain alignment `1`.

This proves insufficiency of the proposed implication. It does **not** prove that an actual Navier–Stokes trajectory realizes finite-time blow-up, `R(t)->infinity`, or vorticity blow-up.

Likewise B2.9 proves that scalar high-frequency energy alone does not determine signed triadic flux. It does not prove singularity formation.

## 3. Remove the unsupported bifurcation claim: what remains

After deleting the unsupported assertion that one branch *must* be regular and the other *must* blow up according to a scalar threshold, the audit leaves a set of logically distinct research scenarios.

### S1 — Global regularity

```text
T* = infinity
```

for all admissible smooth finite-energy initial data. This remains compatible with the current audit.

### S2 — Finite-time singularity

There exists admissible smooth initial data with finite maximal time

```text
T* < infinity.
```

This also remains logically open. The current countercertificates do not construct such data.

### S3 — Conditional directional-depletion regime

For a class of states/solutions, a genuine PDE theorem establishes sufficient directional depletion, yielding the signed-flux estimate and then the already formalized decay implication. This may be useful even without settling all initial data.

### S4 — Partial/intermittent depletion

Directional depletion may hold only on selected scales, times, spatial regions, or directions. The present audit does not show that such partial control closes the global critical norm.

### S5 — Alternative critical mechanism

Global regularity could be true while the current B2 directional-depletion route is not the correct mechanism. A vector/tensor defect, paraproduct-resolved flux control, concentration-compactness/rigidity argument, or another critical estimate could replace B2.8.

### S6 — Nonuniqueness in weaker solution classes

Nonuniqueness phenomena for weak/rough solution concepts are logically distinct from the Clay smooth-data global regularity question. They must not be used as a direct `FALSE` certificate for the Millennium statement without matching the exact solution class and hypotheses.

### S7 — Anomalous-dissipation / inviscid-limit behavior

Onsager-type anomalous dissipation concerns rough Euler behavior and/or inviscid limits. It is a related turbulence scenario, not by itself a proof of finite-time singularity for positive-viscosity 3D Navier–Stokes with the Clay hypotheses.

### S8 — Critical/type-II concentration scenario

A hypothetical type-II or other critical concentration mechanism is a legitimate blow-up scenario to test. It remains a hypothesis until an actual Navier–Stokes construction or exclusion theorem is supplied. A formal scaling ansatz alone is neither existence nor blow-up proof.

## 4. Why quantum superposition is not the mathematical conclusion

The notation

```text
|psi> = alpha |regular> + beta |blowup>
```

may be used as a **visual metaphor** for unresolved alternatives, but classical Navier–Stokes solutions are not thereby placed in a quantum superposition. The rigorous audit language is:

```text
both global-regularity and finite-time-singularity outcomes remain logically unresolved by this proof route.
```

This is epistemic coexistence of hypotheses, not physical quantum coexistence.

## 5. Hypothetical FALSE branch

If the Millennium regularity assertion were false, an acceptable negative resolution would require an actual admissible smooth initial datum and a rigorous demonstration that the corresponding solution cannot remain smooth globally (or the exact alternative allowed by the official formulation).

The following features can motivate a candidate mechanism:

```text
strong expansive alignment,
insufficient directional depletion,
failure of the proposed kappa=25 strain estimate,
scalar residual failing to determine signed flux.
```

But the current finite countercertificates establish only the failure of those proposed estimates. Therefore the chain

```text
Alignment=1
and proposed coefficient >25
=> T*<infinity
=> R(t)->infinity
=> |omega|->infinity
```

is **NOT PROVED**.

## 6. Hypothetical TRUE/closed branch

A genuine closure along the current architecture would need, at minimum:

```text
actual NS hypotheses
 -> PDE-derived directional depletion / equivalent critical mechanism
 -> signed flux upper bound
 -> dissipation dominates production
 -> residual decay
 -> rigorous high- and low-frequency critical L3 control
 -> uniform L^infinity_t L^3_x bound
 -> exact ESS hypothesis map
 -> continuation/global regularity.
```

Numbers such as `Alignment=0.5`, `L^infinity L^3=43.8305`, or `Pi_max=1302.56` are **not established audit outputs** merely by specifying them. They require independent derivations from the PDE hypotheses.

Likewise a green Lean build can certify the formal theorem actually encoded, but cannot convert an assumed/open premise into a proved PDE theorem.

## 7. Isolated remainder

After removing both unsupported declarations — `CLOSED` and `BLOWUP` — the central unresolved object is:

```text
derive, from actual 3D Navier–Stokes dynamics, a critical mechanism strong enough to control the signed high-frequency flux without assuming the desired endpoint.
```

One audit-safe target remains

```text
DirectionalDepletion(u,S_low,Lambda,eta)
  -> Pi_Lambda(u)
       <= [nu Lambda^2/4 + Err_Lambda(u)] R_Lambda(u),
```

followed by a separate theorem deriving `DirectionalDepletion` from the PDE.

Status:

```text
DIRECTIONAL_DEPLETION_FROM_NS = OPEN_BRIDGE
SIGNED_FLUX_FOR_ACTUAL_NS = OPEN_BRIDGE
GLOBAL_REGULARITY = NOT_ESTABLISHED
FINITE_TIME_BLOWUP = NOT_ESTABLISHED
```

## 8. Audit interpretation

The value of the gap-isolation certificate is not that it proves `TRUE` and `FALSE` simultaneously. It does something more precise: it removes invalid sufficient arguments while preserving every global outcome not excluded by a valid theorem.

Thus the correct post-countercertificate research state is a **partition of admissible hypotheses and mechanisms**, with explicit obligations for eliminating each scenario.