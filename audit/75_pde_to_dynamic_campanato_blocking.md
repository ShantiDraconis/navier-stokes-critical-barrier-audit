# Audit 75 — PDE → Dynamic Campanato blocking note

## Scope

This note records the non-circular boundary for the new
`/home/runner/work/navier-stokes-critical-barrier-audit/navier-stokes-critical-barrier-audit/formal/G1/DynamicCampanato.lean`
interface.

`FinalF.lean` remains **NOT_TOUCHED**.

## What is now fixed at interface level

1. The local-energy step is recorded as an **exact identity**, not as an
   already-absorbed estimate.
2. The test is fixed as
   `φ² (ξ_ε - (ξ_ε)_{B_r}) |ω|_ε` with `φ = w_R` and
   `R = K ρ_* = K κ ‖ω‖₂ / ‖∇ω‖₂`.
3. The commutator channels `R1`, `R2`, and the cutoff-free remainder witness
   `C_rem(‖u₀‖₂, ν)` stay explicit.
4. The far-field statement is kept only in the scaling-correct averaged form

   `⨍_{B_r} |S^{far}_ε|² ≤ C ρ_*^{-3} ‖ω_ε‖₂² (r/ρ_*)^β`

   with `β = 1`, i.e. the linear Campanato error scale.
5. The iteration bookkeeping is fixed at

   `J_{r/2} ≤ γ J_r + A r/ρ_*`,

   and preserving `J_r ≤ C r/ρ_*` requires

   `2γC + 2A ≤ C`,

   hence any genuine inhomogeneous step forces `γ < 1/2`.

## Non-circularity boundary

The near-field improvement

`|z|^{-3}  ->  ρ_*^{-1/2} |z|^{-5/2}`

must be derived directly from the tested `XiEpsPDE` identity and the diffusion
term. It must **not** be imported from `hDynamic` or any already-available
1/2-Hölder statement, because that would use the target regularity to prove the
Campanato bridge that is supposed to generate it.

## CIRCULARIDADE status

**CIRCULARIDADE if violated:** any proof of the near-field gain that inserts
`hDynamic` as a hypothesis should be rejected and treated as OPEN_BRIDGE.

At this commit, no such insertion was made. The remaining open item is the
analytic derivation of the near-field gain from the PDE identity itself.

## Integrability check

With `β = 1`, the far-field factor is only `r/ρ_*`, so for `0 ≤ r ≤ ρ_*` it is
dimensionless and bounded by `1`. This is compatible with a Leray-energy level
budget and does **not** force the forbidden palinstrophy-type coefficient
`ρ_*^{-2} = κ^{-2} ‖∇ω‖₂² / ‖ω‖₂²`.
