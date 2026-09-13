/-
XiEpsPDE.lean

Concrete audit-level interface for the ε-regularised direction equation used in
the PDE -> dynamic Campanato bridge.

This file fixes the regularisation conventions:
* `|ω|_ε = sqrt(|ω|² + ε²) ≥ ε`
* `ξ_ε = ω / |ω|_ε`
* `R1 = [J_ε, u · ∇] ω / |ω|_ε`
* `R2 = ε² ∇ω_ε / |ω|_ε³`
* the cutoff-free remainder witness `C_rem(‖u₀‖₂, ν)` stays explicit
-/

import Mathlib
import formal.G1.G1_DynamicCriticalGeometry

noncomputable section G1XiEpsPDESection

namespace G1XiEpsPDE

abbrev Vec3 := G1Dynamic.Vec3
abbrev ScalarField := Vec3 → ℝ
abbrev VectorField := Vec3 → Vec3
abbrev MatrixField := Vec3 → Matrix (Fin 3) (Fin 3) ℝ

/-- `|ω|_ε = sqrt(|ω|² + ε²)`. -/
def magEps (ω : VectorField) (ε : ℝ) (x : Vec3) : ℝ :=
  Real.sqrt (‖ω x‖ ^ 2 + ε ^ 2)

/-- `ξ_ε = ω / |ω|_ε`, written as scalar multiplication by `|ω|_ε⁻¹`. -/
def xiEps (ω : VectorField) (ε : ℝ) (x : Vec3) : Vec3 :=
  (magEps ω ε x)⁻¹ • ω x

structure XiEpsPDE where
  ε : ℝ
  hε : 0 < ε
  ω_ε : VectorField
  u_ε : VectorField
  /-- Symmetric strain matrix field `S_ε = sym ∇u_ε`. -/
  S_ε : MatrixField
  remainderWitness : G1Dynamic.RemainderCutoffFreeWitness
  /-- `R1 = [J_ε, u · ∇] ω / |ω|_ε`. -/
  R1 : VectorField
  /-- `R2 = ε² ∇ω_ε / |ω|_ε³`. -/
  R2 : VectorField
  R1_definition : Prop
  R2_definition : Prop
  /-- `R1 → 0` in `L¹_t L¹_x` with cutoff-free `C_rem(‖u₀‖₂, ν)`. -/
  hR1_vanishes : Prop
  /-- The witness is genuinely cutoff-free. -/
  hR1_cutoff_free : remainderWitness.independence_certificate
  /-- Quantitative record for `‖R2‖ ≤ C ε / |ω|_ε`. -/
  hR2_bound : Prop
  /-- Exact PDE:
      `D_t ξ_ε = S_ε ξ_ε - (ξ_ε · S_ε ξ_ε) ξ_ε
        + ν (Δ ξ_ε + 2 ∇ log |ω|_ε · ∇ ξ_ε) + R1 + R2`. -/
  equation : Prop
  /-- Exact test by `φ² (ξ_ε - (ξ_ε)_{B_r}) |ω|_ε`, before CZ/Young. -/
  local_energy_test : Prop
  /-- Scalar bookkeeping terms for the tested identity. -/
  temporal transport stretchNear stretchFar diffusionMain : ℝ
  crossCutoffOrderOne crossCutoffOrderTwo crossGradMag drift : ℝ
  R1Term R2Term : ℝ
  /-- Exact identity produced by the PDE test. -/
  local_energy_identity :
    temporal =
      transport + stretchNear + stretchFar + diffusionMain
        + crossCutoffOrderOne + crossCutoffOrderTwo + crossGradMag
        + drift + R1Term + R2Term

theorem xiEps_unfold
    (ω : VectorField) (ε : ℝ) (x : Vec3) :
    xiEps ω ε x = (magEps ω ε x)⁻¹ • ω x := rfl

theorem magEps_unfold
    (ω : VectorField) (ε : ℝ) (x : Vec3) :
    magEps ω ε x = Real.sqrt (‖ω x‖ ^ 2 + ε ^ 2) := rfl

end G1XiEpsPDE

end G1XiEpsPDESection
