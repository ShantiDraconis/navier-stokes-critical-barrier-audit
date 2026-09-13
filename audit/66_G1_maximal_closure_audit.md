# Audit 66 — G1 maximal closure audit

Status: `G1_OPEN_BRIDGE_ISOLATED`

## Executive result

The deterministic endpoint architecture is valid as conditional composition, but the decisive Navier–Stokes PDE implication remains:

`ActualNS -> G1ClosedForActualNS`.

The audit must not replace that implication with a scalar interpolation estimate, an alignment constant, a traceless-strain statement, or a topology narrative.

## Exact CLOSED target used by the formal audit

With `y = ||omega||_2^2`, `z = ||grad omega||_2^2`, and normalized viscosity, the target is a uniform `delta > 0` such that

`stretching(t) <= (1-delta) z(t)`

for every admissible state/time in the target class.

Together with the exact enstrophy balance

`(1/2)y'(t) + z(t) = stretching(t)`,

this gives

`y'(t) + 2 delta z(t) <= 0`.

The Lean file `MillenniumAudit/G1Audit.lean` proves this implication algebraically without asserting the PDE premise.

## Important correction: no automatic `-c0 ||omega||_2^2` term on R^3

The stronger proposed formula

`stretching <= (1-delta) z - c0 y`

is not adopted as the universal target. On the whole space `R^3`, arbitrary data do not come with a global Poincare spectral gap that would automatically produce a uniform positive `c0`. Such a term requires a separately proved mechanism or a restricted setting.

## OPEN versus CLOSED

The scalar route has the schematic form

`y' + z <= C y^3`.

This does not imply

`y' + delta z <= 0`

for arbitrary nonnegative `y,z`; the positive cubic term is the unresolved supercritical contribution. Changing constants does not change that logical fact.

## Geometry/topology claims that remain hypotheses, not consequences

The following must not be used as already-proved replacements for G1:

- traceless strain implies favorable alignment;
- helicity forces the stretching integral to change sign strongly enough;
- Kelvin circulation alone supplies a uniform depletion constant;
- vortex tubes cannot develop the geometry required for blow-up because of a finite knot/link invariant;
- `Lk = Tw + Wr` supplies the analytic coercivity needed for the enstrophy estimate.

Any such route needs its own theorem mapping the geometric/topological quantity to the signed stretching integral with constants and admissible hypotheses.

## Minimal theorem genealogy required for unconditional closure

1. `G1A_NS_TO_GEOMETRY`: derive a quantitative geometric property from the actual NS equations and admissible data, without assuming a critical norm bound or regularity conclusion.
2. `G1B_GEOMETRY_TO_SIGNED_STRETCHING`: prove that property yields `stretching <= (1-delta) z` with a uniform positive delta.
3. `G1C_ENSTROPHY_DECAY`: exact balance + G1B -> `y' + 2 delta z <= 0`. This is algebraic and is formalized.
4. `G2_CRITICAL_HIGH_FREQUENCY`: derive the exact fixed-scale high-frequency critical estimate from the resulting analytic controls. No claim is promoted until the precise Littlewood–Paley theorem is proved for the selected function spaces.
5. `G3_FIXED_SCALE_RECONSTRUCTION`: combine low and high frequencies at one fixed scale without a small-data assumption hidden in the constants.
6. `G4_ESS_HYPOTHESIS_MAP`: map the resulting bound to the exact Escauriaza–Seregin–Šverák hypotheses and maximal-lifespan formulation.
7. `TSTAR_INFINITY`: exclude every finite maximal time and conclude global smoothness in the official target class.

## Current verdict

- `G1C_ENSTROPHY_DECAY = PROVED_LOGIC_GIVEN_G1`
- `G1A_NS_TO_GEOMETRY = OPEN_BRIDGE`
- `G1B_GEOMETRY_TO_SIGNED_STRETCHING = OPEN_BRIDGE`
- `G2_CRITICAL_HIGH_FREQUENCY = NOT_YET_KERNEL_PROVED_AS_CONCRETE_PDE_THEOREM`
- `G3_FIXED_SCALE_RECONSTRUCTION = CONDITIONAL`
- `G4_ESS_HYPOTHESIS_MAP = EXTERNAL_THEOREM_MAPPING_PENDING`
- `NAVIER_STOKES_GLOBAL_REGULARITY = NOT_ESTABLISHED`

## Promotion rule

No audit status may be promoted from `OPEN_BRIDGE` to `PROVED` because an assumption was renamed `G1_closed`, moved into a structure field, or represented as an axiom. Promotion requires a proof from previously certified primitive hypotheses and successful kernel checking of the concrete statement.
