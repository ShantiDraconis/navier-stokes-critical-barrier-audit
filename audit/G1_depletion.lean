/-
G1_depletion.lean
Audit skeleton for a geometric-depletion route to 3D Navier–Stokes.

IMPORTANT:
* This file does NOT prove G1.
* The original scale choice rho = c / ||ω||₂ is rejected by the scaling audit.
* The scale-covariant conjecture is exposed explicitly as an assumption.
-/

import Mathlib

noncomputable section
open Real Set

abbrev Vec3 := Fin 3 → ℝ
abbrev VorticityField := ℝ → Vec3 → Vec3

def omegaNorm (ω : VorticityField) (t : ℝ) (x : Vec3) : ℝ := ‖ω t x‖

/-- Dimensionless high-vorticity threshold. -/
def OmegaTheta (ω : VorticityField) (t θ omegaInf : ℝ) : Set Vec3 :=
  {x | omegaNorm ω t x > θ * omegaInf}

/-- Scale-covariant candidate length rho* = kappa ||omega||_2 / ||grad omega||_2. -/
def rhoStar (κ omegaL2 gradOmegaL2 : ℝ) : ℝ :=
  κ * omegaL2 / gradOmegaL2

/-- Audit-level geometric depletion hypothesis. Analytic objects remain to be instantiated. -/
structure GeometricDepletionHypothesis where
  β : ℝ
  κ : ℝ
  C : ℝ
  hβ : β = (1 : ℝ) / 2
  hκ : 0 < κ
  hC : 0 < C

/-- The signed/coercive G1 bridge. -/
def G1Closed (Stretch z y : ℝ → ℝ) : Prop :=
  ∃ δ c₀ : ℝ,
    0 < δ ∧ 0 ≤ c₀ ∧
    ∀ t, Stretch t ≤ (1 - δ) * z t - c₀ * y t

/-- This proposition names, rather than assumes, the remaining proof obligation. -/
def DepletionImpliesG1 : Prop :=
  ∀ (Stretch z y : ℝ → ℝ),
    GeometricDepletionHypothesis →
    G1Closed Stretch z y

/- No theorem proving `DepletionImpliesG1` appears here. That is the remaining G1 gap. -/

end
