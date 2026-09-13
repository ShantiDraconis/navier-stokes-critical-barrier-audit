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

## BLOCKING 1 — the requested far-field estimate is not scale-homogeneous as stated

The proposed pointwise estimate

```text
|S_far| <= C(K) ||grad u_eps||_2
```

with `C(K)` dimensionless and no radius factor cannot be inserted unchanged into a scale-covariant NS proof. Under the NS scaling

```text
u_lambda(x,t) = lambda u(lambda x, lambda^2 t),
```

`S` scales like `lambda^2`, while `||grad u||_2` scales like `lambda^(1/2)` in three dimensions.  A localized average/norm or an explicit scale factor is therefore required.

This does **not** reinstate the previously rejected `rho_*^{-3/2} ||omega||_2` estimate.  It means the exact CZ/localized estimate must be derived with the correct homogeneity and then tested for time integrability.

Status: `BLOCKING_SCALING / OPEN_CZ`.

## BLOCKING 2 — near-field closure cannot assume the desired Hölder estimate

The near-field kernel gain from

```text
|sin angle(xi(x),xi(y))| <= C |x-y|^(1/2)
```

would indeed improve a `|x-y|^{-3}` singularity to `|x-y|^{-5/2}`, which is locally integrable in 3D.  But this half-Hölder estimate is precisely the downstream `hDynamic` target.  Using it to prove DynamicCampanato would be circular.

The PDE test must instead produce the oscillation decay directly from diffusion plus terms controlled by the Leray budget.  If this cannot be done without an assumed `hDynamic`, status remains `BLOCKING_CIRCULARITY`.

## BLOCKING 3 — concrete XiEpsPDE test still must be derived

The formal interface does not yet prove that testing the regularized direction equation against

```text
phi^2 (xi_eps - (xi_eps)_{B_r}) |omega_eps|
```

produces only the accepted terms.  The derivation must explicitly account for:

- differentiation of `|omega_eps|` or its regularized magnitude;
- transport of the local mean `(xi_eps)_{B_r}`;
- derivatives of the spatial/time cutoff;
- diffusion cross terms;
- stretching/strain terms with their sign retained;
- commutators introduced by mollification;
- any motion of `rho_*(t)`;
- boundary terms or periodic localization conventions.

Every resulting remainder must be bounded by the kinetic-energy budget or absorbed with a coefficient independent of epsilon.

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
Caccioppoli interface                         SPECIFIED, PDE derivation OPEN
far-field CZ                                  BLOCKING_SCALING / OPEN_CZ
near-field without hDynamic                   OPEN_BRIDGE
linear dyadic iteration algebra               PROVED_LOGIC
uniform epsilon limit                         OPEN_BRIDGE
PDEToDynamicCampanato                         NOT_ESTABLISHED
FinalF                                        NOT_TOUCHED
```

The next mathematically legitimate target is to derive the exact localized identity from `XiEpsPDE`, term by term, before asserting a CZ bound or choosing `kappa`.