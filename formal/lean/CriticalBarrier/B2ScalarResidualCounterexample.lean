import Mathlib

/-!
B2ScalarResidualCounterexample.lean

Axiom-free finite Fourier-triad certificate for the NS-B2 audit.
It proves that equal scalar high-frequency energy does not determine the signed
high-low interaction coefficient. This is an algebraic obstruction only; it is
not a Navier--Stokes regularity theorem.
-/

namespace CriticalBarrier.B2ScalarResidualCounterexample

abbrev Vec3Z := Fin 3 → ℤ

def dotZ (x y : Vec3Z) : ℤ := ∑ i, x i * y i

def energyCoeff (b c : Vec3Z) : ℤ := dotZ b b + dotZ c c

/-- Fourier wavevectors: k + m + n = 0. -/
def k : Vec3Z := ![0, 1, 0]
def m : Vec3Z := ![10, 0, 0]
def n : Vec3Z := ![-10, -1, 0]

/-- Low-mode polarization. -/
def a : Vec3Z := ![1, 0, 0]

/-- State A: same scalar high-mode energy as State B, zero triad coupling. -/
def bA : Vec3Z := ![0, 1, 1]
def cA : Vec3Z := ![0, 0, 10]

/-- State B: same scalar high-mode energy, nonzero triad coupling. -/
def bB : Vec3Z := ![0, 1, 0]
def cB : Vec3Z := ![1, -10, 0]

/-- Algebraic coefficient for the resonant high-low-high channel
    (b·k)(a·c) + (c·k)(a·b). -/
def triadCoeff (b c : Vec3Z) : ℤ :=
  dotZ b k * dotZ a c + dotZ c k * dotZ a b

theorem wavevector_resonance : ∀ i, k i + m i + n i = 0 := by
  native_decide

/-- Each Fourier polarization is perpendicular to its own wavevector. -/
theorem stateA_divergence_free_modes :
    dotZ k a = 0 ∧ dotZ m bA = 0 ∧ dotZ n cA = 0 := by
  native_decide

theorem stateB_divergence_free_modes :
    dotZ k a = 0 ∧ dotZ m bB = 0 ∧ dotZ n cB = 0 := by
  native_decide

/-- Both high-frequency states carry the same scalar Fourier energy coefficient. -/
theorem equal_scalar_energy :
    energyCoeff bA cA = energyCoeff bB cB := by
  native_decide

theorem common_energy_value :
    energyCoeff bA cA = 102 ∧ energyCoeff bB cB = 102 := by
  native_decide

/-- The resonant high-low-high interaction differs despite equal scalar energy. -/
theorem triad_flux_differs :
    triadCoeff bA cA = 0 ∧ triadCoeff bB cB = 1 := by
  native_decide

/-- Exact finite certificate: scalar energy alone cannot determine this signed
    triadic interaction coefficient on the divergence-free resonant class. -/
theorem scalar_energy_does_not_determine_triad :
    ∃ b₁ c₁ b₂ c₂ : Vec3Z,
      dotZ m b₁ = 0 ∧ dotZ n c₁ = 0 ∧
      dotZ m b₂ = 0 ∧ dotZ n c₂ = 0 ∧
      energyCoeff b₁ c₁ = energyCoeff b₂ c₂ ∧
      triadCoeff b₁ c₁ ≠ triadCoeff b₂ c₂ := by
  refine ⟨bA, cA, bB, cB, ?_⟩
  native_decide

end CriticalBarrier.B2ScalarResidualCounterexample
