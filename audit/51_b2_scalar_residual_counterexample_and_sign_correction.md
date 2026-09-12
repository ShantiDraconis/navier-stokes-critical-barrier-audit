# 51 — B2 scalar-residual counterexample and correction of the proposed B2.8/B2.10 closure target

Date: 2026-09-12

Trigger: R4 (`Internal bridge falsification/specification correction`).

This reopens only the affected NS-B2 branch of the frozen audit. It does not change any Millennium endpoint to solved.

## Result status

`B2_SCALAR_RESIDUAL_SUFFICIENCY = FALSIFIED_AT_FINITE_FOURIER_TRIAD_LEVEL`

`B2_REFINED_RESIDUAL_REQUIREMENT = STRENGTHENED`

`NS_B2_ENDPOINT = OPEN`

## 1. Exact Fourier certificate

Work on the periodic 3-torus and use the resonant wavevectors

- low: `k=(0,1,0)`,
- high: `m=(10,0,0)`,
- high: `n=(-10,-1,0)`,

so `k+m+n=0`.

Fix low polarization `a=(1,0,0)`, hence `k·a=0`.

Two divergence-free high-mode states are:

### State A

`b_A=(0,1,1)`, `c_A=(0,0,10)`.

Then `m·b_A=0`, `n·c_A=0`.

### State B

`b_B=(0,1,0)`, `c_B=(1,-10,0)`.

Then `m·b_B=0`, `n·c_B=0`.

Define the scalar Fourier energy coefficient

`E(b,c)=|b|^2+|c|^2`.

Both states satisfy

`E_A=E_B=102`.

Define the resonant high-low-high coefficient

`Q(b,c)=(b·k)(a·c)+(c·k)(a·b)`.

Then

`Q_A=0`,

`Q_B=1`.

Therefore equal scalar high-frequency energy does not determine the signed triadic interaction.

This finite statement is certified axiom-free in:

`formal/lean/CriticalBarrier/B2ScalarResidualCounterexample.lean`.

## 2. Corresponding explicit periodic fields

A real field realizing State B is

`u_low(x,y,z) = (cos y,0,0)`

and

`u_high^B(x,y,z) = (cos(10x+y), cos(10x)-10 cos(10x+y), 0)`.

Both pieces are divergence-free:

`div u_low = 0`,

`div u_high^B = -10 sin(10x+y)+10 sin(10x+y)=0`.

For the non-cancelling channel

`I_B = ∫_{T^3} (u_high^B · ∇)u_low · u_high^B dx`,

direct trigonometric integration gives

`I_B = 2 π^3 ≠ 0`.

State A can be chosen with the same scalar Fourier energy coefficient and zero corresponding resonant coefficient, as certified by the finite Fourier algebra above.

The Lean file currently certifies the discrete Fourier algebra; a future analytic file may formalize torus integration itself.

## 3. Why the proposed B2.8 target is not yet a theorem

The proposed implication

`high-frequency concentration + ||S_≤||∞ bound -> Π_Λ >= κ R_Λ`

is not justified.

High-frequency concentration says where the energy sits in **scale**. It does not determine how the high-frequency vector aligns with the eigenvectors of the low-frequency symmetric strain tensor. A trace-zero symmetric strain has positive and negative eigendirections. Equal high-frequency energy can therefore produce different signs of the quadratic interaction.

The missing hypothesis/theorem is an **alignment/depletion/positive-part control**, not merely concentration.

Accordingly, `R_Λ` must be refined to retain information such as

`Rcal_Λ = (E_>, Π_Λ, Ω_>, Triad/Alignment data)`.

## 4. Sign correction in the B2.10 energy inequality

Suppose the projected high-frequency energy identity is written as

`dR/dt + D = Π`.

If `Π` is on the right-hand side with this convention, then a lower bound

`Π >= κ R - error`

does **not** imply decay. It supplies a lower bound on an energy-input term.

For a Gronwall decay estimate one instead needs, depending on sign convention, an upper bound such as

`Π <= κ R + error`

with dissipation coefficient strictly larger than `κ`, or equivalently define the flux with the opposite sign and use the corresponding coercive lower bound.

Every future B2.8/B2.10 file must freeze one sign convention before combining inequalities.

## 5. Dimensional/scaling warning for κ = ν Λ² / 4

The value `κ=νΛ²/4` is not presently derived from the nonlinear flux geometry. It is a candidate target coefficient tied to the dissipative scale. It cannot be promoted to an exact universal NS flux constant until the relevant estimate is proved with consistent units/scaling and hypotheses.

Similarly, `C_Sobolev_R3=0.62`, `C_Bernstein=4`, and `C_error=2.48` must be attached to exact Fourier-transform conventions, domains, and norm normalizations before being called universal exact constants.

## 6. Correct next theorem target

The next mathematically defensible B2.8 target is not an unconditional signed lower bound. It should have a form such as

`AlignmentCondition(u,Λ,η) -> |Π_Λ| <= C_align(η) E_> + Err_Λ`

or, if the sign convention is chosen for dissipative flux,

`DissipativeAlignment(u,Λ,η) -> Π_diss,Λ >= κ(η,ν,Λ) E_> - Err_Λ`.

The repository condition must then be proved to imply the alignment/depletion condition without assuming the desired L∞_t L3_x bound.

That implication is a refined form of the still-open NS-B2 bridge.

## 7. What is genuinely closed by this revision

Closed:

- resonant wavevector identity;
- mode-wise divergence-free constraints;
- equal scalar high-frequency energy for two explicit states;
- different resonant triadic interaction coefficients;
- therefore scalar high-frequency energy is insufficient to determine the signed triadic interaction.

Not closed:

- full PDE B2.8;
- HRepo -> alignment;
- HRepo -> critical-tail control;
- HRepo -> L∞_t L3_x;
- ESS hypothesis mapping;
- global Navier–Stokes regularity.

This is a real specification advance: it removes an impossible scalar-only closure route and identifies the additional geometric information the refined residual must encode.
