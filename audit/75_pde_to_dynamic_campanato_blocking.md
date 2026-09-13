# Audit 75 — PDE to dynamic Campanato blocking note

Status: `OPEN_BRIDGE / CIRCULARITY_BLOCK`

## Scope

This note records the precise blocking point for the route

```text
XiEpsPDE
-> LocalEnergyIdentity
-> far-field averaged scaling
-> Campanato iteration with gamma < 1/2
-> dynamic half-Hölder coherence
```

implemented at the interface level in `formal/G1/DynamicCampanato.lean`.

`FinalF.lean` remains untouched.

## What is now explicit

The Lean file keeps the following items explicit and non-hidden:

- the exact test field `φ² (ξ_ε - (ξ_ε)_{B_r}) |ω_ε|` with `φ = w_R`;
- the fixed cutoff scale `R = K ρ_* = K κ ||ω||₂ / ||∇ω||₂`;
- the exact local identity with explicit `R1`, `R2`, and a cutoff-free remainder witness `C_rem(||u0||₂, ν)`;
- the far-field target only in averaged scaling form
  `⨍_{B_r} |S_far,ε|² ≤ C ρ_*^{-3} ||ω_ε||₂² (r / ρ_*)^β`;
- the dyadic barrier condition
  `J_{r/2} ≤ γ J_r + A r / ρ_*`
  together with the algebraic preservation requirement
  `2 γ C + 2 A ≤ C`.

## Exact blocking point

The missing step is the non-circular near-field gain needed to convert the
kernel singularity `|z|^{-3}` into the stronger Campanato-scale structure

```text
rho_*^(-1/2) |z|^(-5/2)
```

without assuming beforehand the very dynamic half-Hölder coherence that this
program is supposed to prove.

If one inserts hDynamic or any equivalent half-Hölder coherence hypothesis at
this point, then the route becomes circular:

```text
hDynamic
=> near-field gain
=> Campanato iteration
=> dynamic half-Hölder coherence
```

That does not close the bridge from Leray-Hopf energy information alone.

## Far-field scaling issue

The invalid estimate

```text
|S_far| <= C(K) ||∇u||_2
```

is excluded because it breaks scaling. The only admissible far-field statement
recorded here is the averaged one with `ρ_*^{-3}` and exponent `β`.

At present this file does **not** claim that the selected `β` is sufficient to
make the time integral close using only Leray energy

```text
∫ ||∇u||_2^2 dt < ∞
```

and no palinstrophy. That remains an open analytic obligation.

## Current verdict

The interface now isolates the correct exact identity, the scaling-covariant
far-field target, and the strict `γ < 1/2` iteration threshold. The proof still
breaks at the non-circular near-field singularity gain, so the bridge remains

```text
PDE_TO_DYNAMIC_CAMPANATO = OPEN_BRIDGE
CIRCULARITY_STATUS = BLOCKED_IF_hDynamic_IS_USED
```
