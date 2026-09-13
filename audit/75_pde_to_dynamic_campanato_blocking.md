# Audit 75 — PDEToDynamicCampanato attack

Base commit audited: `631a230acfddcc57d805cc58b9c06124318153d6`
Branch: `audit/pde-to-dynamic-campanato-20260913`

## Requested target

Derive, uniformly in epsilon and without `sup_t ||omega||_2^2` or `int ||grad omega||_2^2`, a dynamic Campanato estimate

```text
J_r(x,t) <= C r / rho_*(t),   0 < r <= rho_*(t),
```

from the regularized direction equation `XiEpsPDE`, the Leray kinetic-energy budget, and a cutoff-free remainder

```text
a_eps(t) <= C_kappa ||grad u_eps(t)||_2^2.
```

## What is closed formally

1. The cutoff-free time budget is noncircular once the analytic pointwise estimate is available:

```text
int a_eps <= C_kappa int ||grad u_eps||_2^2
          <= C_kappa ||u0||_2^2/(2 nu).
```

2. The requested Caccioppoli inequality has been isolated as an exact interface:

```text
lhs <= C_cacc r^{-2} osc2 + aTerm + R1 + R2.
```

3. The one-step Campanato algebra is proved.  For

```text
J_{r/2} <= gamma J_r + A r/rho,
```

the linear target `J_r <= C r/rho` is preserved provided

```text
2 gamma C + 2 A <= C.
```

This exposes an important quantitative condition: `gamma < 1` by itself is not sufficient for a linear Campanato exponent under this recurrence.  A standard sufficient regime is `gamma < 1/2` with `C` large enough relative to `A`, or a sharper recurrence/remainder.

## New step — exact localized XiEps identity is now isolated before estimates

`formal/G1/DynamicCampanato.lean` now contains `LocalEnergyIdentityData` and the extraction theorem

```text
LocalEnergyIdentity
```

for the test

```text
psi = phi^2 (xi_eps - (xi_eps)_{B_r}) |omega_eps|,
phi = w_R,
R = K rho_*.
```

The exact signed bookkeeping is recorded in the form

```text
(time derivative)
+ (time weight / moving mean)
+ (transport)
+ nu * diffusionBulk
=
  stretchNear
+ stretchFar
- nu * diffusionCutoffCross
- nu * diffusionWeightCross
+ nu * logDrift
+ R1 + R2.
```

Here

```text
diffusionBulk
  = ∫ phi^2 |grad xi_eps|^2 |omega_eps|
```

is isolated explicitly as the positive diffusion quantity, while `stretchFar` is the exact signed slot where the `S_eps^far` pairing appears.

No CZ estimate, absolute-value estimate, Young inequality, or Hölder assumption is used in this identity layer.

Important limitation: the branch does not currently contain a formal definition of `XiEpsPDE`. Therefore the Lean theorem only extracts the equality from an explicit `LocalEnergyIdentityData.identity` field; the actual analytic derivation from the PDE remains an obligation and is not fabricated.

Status: `OPEN_PDE_IDENTITY`, but the term ledger is now explicit.

## Exact scale ledger before CZ

The localization ledger records

```text
R = K rho_*
|grad phi|      ~ (K rho_*)^{-1}
|D^2 phi|       ~ (K rho_*)^{-2}
ball averaging  ~ |B_r|^{-1}
|B_r|           ~ c_3 r^3
```

Thus the raw localized identity itself exposes only cutoff powers `rho_*^{-1}` and `rho_*^{-2}` before any far-field singular-integral estimate is applied.

The Poincaré step is recorded as

```text
fint_{B_r} |xi - (xi)_{B_r}|^2
  <= C_P r^2 fint_{B_r} |grad xi|^2.
```

This gives the required `r^2` conversion between oscillation and gradient energy. It does **not** by itself produce a numerical Campanato contraction.

If the completed PDE estimate yields

```text
gamma = C(K) * kappa,
```

then the new theorem

```text
gamma_lt_half_of_CK_kappa
```

shows that the sufficient choice

```text
kappa < 1 / (2 C(K))
```

gives

```text
gamma < 1/2.
```

This is the correct quantitative target for the linear recurrence, stronger than merely `gamma < 1`.

## BLOCKING 1 — exact far-field scaling after the naive pointwise route

The proposed pointwise estimate

```text
|S_far| <= C(K) ||grad u_eps||_2
```

with dimensionless `C(K)` and no radius factor cannot be inserted unchanged into a scale-covariant NS proof. Under

```text
u_lambda(x,t) = lambda u(lambda x, lambda^2 t),
```

`S` scales like `lambda^2`, while `||grad u||_2` scales like `lambda^(1/2)` in three dimensions.

For a far-field Biot–Savart kernel with magnitude `|x-y|^{-3}`, the direct Cauchy–Schwarz scale calculation outside `R = K rho_*` is

```text
∫_{|x-y|>R} |omega(y)| / |x-y|^3 dy
  <= ||omega||_2
     (∫_{|z|>R} |z|^{-6} dz)^{1/2}
  ~ C R^{-3/2} ||omega||_2.
```

Hence

```text
|S_far|^2
  ~ C K^{-3} rho_*^{-3} ||omega||_2^2.
```

This is the exact candidate bad power requested in the blocking criterion.

The Leray energy inequality controls

```text
∫_0^T ||omega(t)||_2^2 dt
```

(up to the standard whole-space div–curl normalization), but it does **not** by itself control

```text
∫_0^T rho_*(t)^{-3} ||omega(t)||_2^2 dt.
```

Therefore, if the eventual signed/localized estimate really leaves a coefficient of the form

```text
K^{-3} rho_*^{-3} ||omega||_2^2
```

with no compensating positive factor `(r/rho_*)^beta`, no cancellation, and no independent lower bound on `rho_*`, then the branch is blocked by scaling using only Leray energy.

Status: `BLOCKING_SCALING` for the naive pointwise far-field route.

This does **not** prove that every scale-correct localized/CZ estimate is blocked. A signed or averaged estimate may recover additional powers of `r/rho_*` or cancellation. Those must be derived from the exact identity before this status can be upgraded from “naive route blocked” to a universal obstruction.

## BLOCKING 2 — near-field closure cannot assume the desired Hölder estimate

The near-field kernel gain from

```text
|sin angle(xi(x),xi(y))| <= C |x-y|^(1/2)
```

would indeed improve a `|x-y|^{-3}` singularity to `|x-y|^{-5/2}`, which is locally integrable in 3D.  But this half-Hölder estimate is precisely the downstream `hDynamic` target.  Using it to prove DynamicCampanato would be circular.

The PDE test must instead produce the oscillation decay directly from diffusion plus terms controlled by the Leray budget.  If this cannot be done without an assumed `hDynamic`, status remains `BLOCKING_CIRCULARITY`.

## BLOCKING 3 — concrete XiEpsPDE derivation still must be proved

The new term ledger makes explicit what must be derived analytically from the regularized direction equation:

- differentiation of `|omega_eps|` or its regularized magnitude;
- transport of the local mean `(xi_eps)_{B_r}`;
- derivatives of the spatial/time cutoff;
- the positive diffusion term `∫ phi^2 |grad xi_eps|^2 |omega_eps|`;
- the diffusion cutoff cross term;
- the `grad |omega_eps|` cross term;
- the `2 grad log|omega|_eps · grad xi_eps` contribution;
- signed near/far strain pairings;
- commutators `R1`, `R2`;
- any time dependence of `rho_*(t)` through the cutoff;
- boundary/localization conventions.

A particularly important check is whether the `grad |omega_eps|` cross term from integration by parts partially cancels the `2 grad log |omega|_eps · grad xi_eps` drift when the same regularized magnitude is used. The current formal interface deliberately keeps both terms separate until this is proved.

Every surviving remainder must be bounded by the kinetic-energy budget or absorbed with a coefficient independent of epsilon.

Status: `OPEN_PDE_DERIVATION`.

## BLOCKING 4 — epsilon limit

Even after an epsilon-uniform one-step inequality is obtained, passing to epsilon=0 requires compactness/tightness for the weighted/nonlocal terms.  Aubin–Lions alone does not automatically preserve a singular weighted commutator.  A concrete lower-semicontinuity or uniform-integrability theorem is required.

Status: `OPEN_EPS_LIMIT`.

## Explicit forbidden exits

If the derivation requires any of

```text
sup_t ||omega_eps(t)||_2^2,
int ||grad omega_eps||_2^2,
||grad omega||_2^3 / ||omega||_2,
hDynamic as an input,
```

then `PDEToDynamicCampanato` is **BLOCKING**, not proved.

## Current verdict

```text
RemainderCutoffFree -> Leray L1 budget       PROVED_LOGIC / analytic witness required
LocalEnergyIdentity term ledger               FORMALIZED / PDE derivation OPEN
positive weighted diffusion term              EXPLICIT
far-field signed slot                          EXPLICIT
R = K rho_* cutoff powers                      EXPLICIT: rho_*^-1, rho_*^-2
Poincare r^2 oscillation conversion             EXPLICIT
kappa choice for gamma < 1/2                   PROVED_LOGIC if gamma=C(K)kappa
naive pointwise far-field route                BLOCKING_SCALING: K^-3 rho_*^-3 ||omega||_2^2
scale-correct signed/averaged far-field CZ      OPEN_CZ
near-field without hDynamic                    OPEN_BRIDGE
linear dyadic iteration algebra                PROVED_LOGIC
uniform epsilon limit                          OPEN_BRIDGE
PDEToDynamicCampanato                          NOT_ESTABLISHED
FinalF                                         NOT_TOUCHED
```

The next mathematically legitimate target is now narrower: derive the `LocalEnergyIdentityData.identity` field from the actual regularized `XiEpsPDE`, with the precise choice of `|omega|_eps`, mean, cutoff, and boundary convention, and then inspect whether the signed far-field term gains a compensating power before any CZ/Young estimate is applied.
