# Audit 76 — stretchFar signed blocking

## Status

`stretchFar` remains **OPEN_CZ** in
`/home/runner/work/navier-stokes-critical-barrier-audit/navier-stokes-critical-barrier-audit/formal/G1/DynamicCampanato.lean`.

## What was closed

- `formal/G1/XiEpsPDE.lean` now fixes the concrete ε-regularised conventions
  `|ω|_ε = sqrt(|ω|² + ε²)`, `ξ_ε = ω/|ω|_ε`,
  `R1 = [J_ε, u·∇]ω / |ω|_ε`, and `R2 = ε²∇ω_ε / |ω|_ε³`.
- `LocalEnergyIdentityData.ofXiEpsPDE` now instantiates the exact tested
  identity from the concrete `XiEpsPDE` record, without Calderón-Zygmund or
  Young absorption.

## Blocking point

The missing analytic step is a **signed** far-field cancellation of the form

`∫_{|x-y|≥Kρ_*} K(x-y) D(ξ(x), ξ(y)) |ω(x)| |ω(y)| φ²`

that gains a positive power `(r/ρ_*)^β` from the Campanato iteration data
itself, without importing `hDynamic`.

## Exact missing power

The interface is normalized so that the needed gain is the linear Campanato
power

`β = 1`,

i.e. one full factor `r/ρ_*`. Without that extra dimensionless gain, the raw
scale

`ρ_*^{-3} ‖ω‖₂²`

does not convert to the Leray-controlled budget

`∫ ‖∇u‖₂²`

and falls back toward the forbidden derivative-loss mechanism behind
`ρ_*^{-2} = κ^{-2} ‖∇ω‖₂² / ‖ω‖₂²`.

## Non-circularity requirement

Do **not** use

`hDynamic -> near-field 1/2-Hölder -> stretchFar gain -> hDynamic`.

That loop is circular. The signed gain must come directly from the PDE-tested
identity plus an independent cancellation argument.
