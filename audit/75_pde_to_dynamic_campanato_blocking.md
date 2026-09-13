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

---

## BLOCKING_SCALING — exact power analysis (LocalEnergyIdentity derivation)

_Added after deriving LocalEnergyIdentity in `formal/G1/DynamicCampanato.lean`._

### What the LocalEnergyIdentity records

Testing XiEpsPDE with `Ψ = φ²(ξ_ε − (ξ_ε)_{B_r}) |ω_ε|`, where `φ = w_R`,
`R = K ρ_*`, `|∇φ| ~ 1/(K ρ_*)`, and `(ξ_ε)_{B_r}` is the ball mean, gives the
**exact identity** (no estimates):

```
d/dt[osc energy] + ν ∫ φ² |∇ξ_ε|² |ω_ε|
  = T_stretch + T_transport + T_cutoff + T_visclog + T_remainder + T_rhostar + T_mean
```

where:

| Term | Expression | Origin |
|------|-----------|--------|
| `T_diff` | `ν ∫ φ² |∇ξ_ε|² |ω_ε|` | Diffusion (positive, absorbing) |
| `T_stretch` | `∫ φ² (S_ε ξ_ε − S_ε(ξ_ε)_{B_r}) · (ξ_ε−(ξ_ε)_{B_r}) |ω_ε|` | Strain (contains far-field) |
| `T_transport` | `∫ φ² (u_ε·∇(ξ_ε)_{B_r}) · (ξ_ε−(ξ_ε)_{B_r}) |ω_ε|` | Moving mean |
| `T_cutoff` | `ν ∫ 2φ ∇φ · ∇ξ_ε · (ξ_ε−(ξ_ε)_{B_r}) |ω_ε|` | Cross-diffusion; `|∇φ| ~ 1/(Kρ_*)` |
| `T_visclog` | `ν ∫ φ² 2(∇\|ω\|_ε/\|ω\|_ε)·∇ξ_ε·(ξ_ε−(ξ_ε)_{B_r}) |ω_ε|` | Viscous log-density |
| `T_remainder` | `∫ φ² R_ε · (ξ_ε−(ξ_ε)_{B_r}) |ω_ε|` | ε-regularisation remainder |
| `T_rhostar` | `−(ρ̇_*/ρ_*) ∫ φ² ½\|ξ_ε−(ξ_ε)_{B_r}\|² |ω_ε|` | ρ_*-motion |
| `T_mean` | `(d/dt)(ξ_ε)_{B_r} · ∫ φ² (ξ_ε−(ξ_ε)_{B_r}) |ω_ε|` | Mean evolution |

### Poincaré and γ < 1/2

By the Poincaré inequality on `B_r`:
```
⨍_{B_r} |ξ_ε − (ξ_ε)_{B_r}|² ≤ C_P r² ⨍_{B_r} |∇ξ_ε|²
```

After the Caccioppoli step the cutoff cross-term `T_cutoff` feeds back into the
oscillation with factor `C_cacc C_P / K²`.  Thus:

```
J_{r/2} ≤ γ J_r + A (r/ρ_*),    γ = C_cacc C_P / K².
```

**γ < 1/2 condition (PROVED_LOGIC):**
```
K ≥ sqrt(2 C_cacc C_P)
```

This is a condition on the large constant `K` in `R = K ρ_*`, not on `κ`.
Choosing `K` large enough makes `γ < 1/2`.  The theorem `gamma_diff_lt_half`
proves this algebraically in `DynamicCampanato.lean`.

### BLOCKING_SCALING — far-field power (exact)

After the near/far split of the Biot–Savart strain at scale `ρ_*`:

```
S_far(x) = P.V. ∫_{|x−y| ≥ ρ_*} D_{ij}(x−y) ω(y) dy / |x−y|³
```

the averaged L² integral in `B_r` satisfies (with exponent **β = 0**):

```
⨍_{B_r} |S_far|² ≲ (r/ρ_*)^0 · ρ_*^{-3} ‖ω‖₂²
                  = ρ_*^{-3} ‖ω‖₂²
```

In terms of `ρ_* = κ ‖ω‖₂ / ‖∇ω‖₂`:

```
ρ_*^{-3} ‖ω‖₂² = ‖∇ω‖₂³ / (κ³ ‖ω‖₂)
```

**Time integrability check:**

```
∫₀ᵀ ρ_*^{-3}(t) ‖ω(t)‖₂² dt = (1/κ³) ∫₀ᵀ ‖∇ω(t)‖₂³ / ‖ω(t)‖₂ dt
```

The Leray energy budget provides only:
```
∫₀ᵀ ‖∇u(t)‖₂² dt ≤ ‖u₀‖₂² / (2ν)
```

By Hölder (applied to `‖∇ω‖₂³/‖ω‖₂`), bounding the far-field time integral
requires either:
- `sup_t ‖ω(t)‖₂ < ∞` (enstrophy supremum — **forbidden**), or
- `∫ ‖∇ω‖₂² dt < ∞` (palinstrophy — **forbidden**), or
- a separate regularity argument that is not derivable from Leray alone.

**Verdict: BLOCKING_SCALING, exact exponent β = 0, exact forbidden quantity
`‖∇ω‖₂³ / (κ³ ‖ω‖₂)`, time integral requires palinstrophy/enstrophy.**

No choice of `κ` removes this: larger `κ` decreases `A` pointwise but does not
make `∫₀ᵀ ‖∇ω‖₂³/‖ω‖₂ dt` bounded by the Leray budget.

### Updated verdict table

```text
LocalEnergyIdentity (term-by-term)            SPECIFIED / analytic derivation OPEN_BRIDGE
Poincaré → γ < 1/2 (algebra)                 PROVED_LOGIC (K ≥ sqrt(2 C_cacc C_P))
Far-field β = 0 power                         IDENTIFIED
Far-field time integrability from Leray        BLOCKING_SCALING
  exact blocking: ∫ ‖∇ω‖₂³/‖ω‖₂ not in Leray budget
RemainderCutoffFree -> Leray L1 budget        PROVED_LOGIC
Caccioppoli interface                          SPECIFIED, PDE derivation OPEN_BRIDGE
far-field CZ                                   BLOCKING_SCALING / OPEN_CZ
near-field without hDynamic                    OPEN_BRIDGE
linear dyadic iteration algebra                PROVED_LOGIC
uniform epsilon limit                          OPEN_BRIDGE
PDEToDynamicCampanato                          NOT_ESTABLISHED
FinalF                                         NOT_TOUCHED
```