import Mathlib

/-!
EntropyObstruction.lean

Axiom-free algebraic certificate for the Beltrami obstruction to the naive
Navier--Stokes entropy candidate. This file does not formalize the PDE itself;
it certifies the sign calculation once the exact Beltrami reduction gives
`W₀' = volume * rho * q * (q - 2*nu)` with positive prefactors.
-/

namespace CriticalBarrier.EntropyObstruction

/-- In the sub-threshold regime 0 < q < 2ν, the Beltrami derivative factor is negative. -/
theorem beltrami_naive_entropy_negative
    {ν q : ℝ}
    (hν : 0 < ν)
    (hq : 0 < q)
    (hq2 : q < 2 * ν) :
    q * (q - 2 * ν) < 0 := by
  have hneg : q - 2 * ν < 0 := by
    linarith
  exact mul_neg_of_pos_of_neg hq hneg

/-- At q = 2ν the derivative factor vanishes. -/
theorem beltrami_naive_entropy_threshold
    {ν q : ℝ}
    (hq : q = 2 * ν) :
    q * (q - 2 * ν) = 0 := by
  rw [hq]
  ring

/-- Above threshold the factor is positive. -/
theorem beltrami_naive_entropy_positive
    {ν q : ℝ}
    (hq : 0 < q)
    (hq2 : 2 * ν < q) :
    0 < q * (q - 2 * ν) := by
  have hpos : 0 < q - 2 * ν := by
    linarith
  exact mul_pos hq hpos

/-- Exact numerical certificate for ν = 0.01 and q = 0.01. -/
example :
    (0.01 : ℝ) * ((0.01 : ℝ) - 2 * (0.01 : ℝ)) < 0 := by
  norm_num

end CriticalBarrier.EntropyObstruction
