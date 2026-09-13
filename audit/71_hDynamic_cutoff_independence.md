# Audit 71 — hDynamic cutoff-independent constant isolation

Status: `OPEN_BRIDGE / NOT_ESTABLISHED`

## Objective

Isolate the hDynamic constant so that the local half-Hölder coherence target is formulated with a constant `C0` depending only on fixed data and not on an arbitrary cutoff radius or on the regularization parameter `ε`.

## Scale-covariant normalization fixed in the Lean interface

The updated file `formal/G1/G1_DynamicCriticalGeometry.lean` now exposes the target objects explicitly:

- `xiEps(ε,t,x) = ω(t,x) / sqrt(|ω(t,x)|^2 + ε^2)`
- `OmegaTheta(θ,t) = { x : |ω(x,t)| ≥ θ ||ω(t)||_∞ }`
- `rhoStarAt(κ,t) = κ ||ω(t)||_2 / ||∇ω(t)||_2`
- `cutoffRadius(κ,K,t) = K rhoStarAt(κ,t)` with `K` fixed in the cutoff structure, so there is no free arbitrary `R` parameter
- `wR` is only the profile attached to that fixed derived radius

This removes the interface-level ambiguity in which a coherence constant could silently depend on a separately chosen cutoff. The Lean structure also records the dependence claim concretely through a `boundProfile` field and the equality `C0 = boundProfile(K, ||u0||_2, nu, kappa, theta)`.

## Isolation of C0

Desired implication on the intense-vorticity set:

```text
N7 cone on OmegaTheta  =>  |sin angle(xi(x,t), xi(y,t))|
                            <= C0 (|x-y| / rhoStarAt(κ,t))^(1/2)
```

for `x,y ∈ OmegaTheta(θ,t)` with `|x-y| < rhoStarAt(κ,t)`.

Target dependency list:

```text
C0 = C0(K, ||u0||_2, nu, kappa, theta)
```

Forbidden dependency list:

```text
C0 must not depend on the arbitrary cutoff radius R
C0 must not depend on epsilon
```

To reach this target one needs a Calderón-Zygmund estimate that is uniform in `ε` and performed at the fixed scale lock `R = K rhoStarAt`, without replacing the integral estimate by a `sup_y` bound that reintroduces cutoff dependence.

## Regularized xi_eps evolution recorded explicitly

The Lean interface now keeps the desired regularized PDE in explicit audit form:

```text
D_t xi_eps
  = S_eps xi_eps - (xi_eps · S_eps xi_eps) xi_eps
    + nu (Delta xi_eps + 2 (grad|omega| / |omega|_eps) · grad xi_eps)
    + R_eps
```

where the explicit first-order term is encoded literally as `strainAction - (inner xiEps strainAction) • xiEps`, the viscosity contribution is grouped in `viscosityContribution`, and the remaining obligation

```text
||R_eps||_{L1} -> 0 uniformly in epsilon
```

is kept explicit as `remainder_uniform_L1_vanishes_from_leray_hopf`, now stated as a concrete uniform small-`ε` bound on `remainderL1` rather than a bare placeholder proposition. This avoids any hidden division by `|omega|` without regularization.

## Constantin-Fefferman connection

The intended bridge remains:

```text
local half-Hölder coherence on OmegaTheta
=> kernel-weighted directional control
=> |∫ D(...) |omega(x)| |omega(y)| / |x-y|^3| <= gamma nu Z + a(t) Q
```

with target `gamma = 1/2 < 1`. At that point the signed stretching estimate would feed the existing `GeometricDepletion` interface.

## Exact breakpoints still open

1. Derive the `xi_eps` PDE from the Leray-Hopf/vorticity equations with every regularized term justified in the formal setting.
2. Prove the uniform `L1` decay of `R_eps` from energy-level Leray-Hopf information alone.
3. Prove the Calderón-Zygmund/Constantin-Fefferman estimate with `C0` depending only on `K`, `||u0||_2`, `nu`, `kappa`, and `theta`, not on `R` or `ε`.
4. Upgrade the current interface from `OPEN_BRIDGE` to a theorem only after those analytic steps are discharged.

## Current verdict

The repository now isolates the cutoff-independent target at the specification/interface level, but the decisive PDE and harmonic-analysis arguments are still not proved here. Therefore the bridge remains `OPEN_BRIDGE / NOT_ESTABLISHED`.
