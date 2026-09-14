/-
StrainKernel.lean

Preparatory tensorial strain-kernel architecture for the signed far-field audit.
This file is independent of the localized PDE identity and does not assert
principal-value existence or Calderon-Zygmund boundedness.
-/

import Mathlib

noncomputable section

namespace G1Audit

abbrev Vec3 := EuclideanSpace ℝ (Fin 3)
abbrev Matrix3 := Matrix (Fin 3) (Fin 3) ℝ
abbrev StrainKernelTensor := Vec3 → Fin 3 → Fin 3 → Fin 3 → ℝ

/--
Audit-safe interface for the tensorial Biot-Savart strain kernel.
The exact kernel may later instantiate this structure once its formula and
properties are formally verified.
-/
structure StrainKernelData where
  kernel : StrainKernelTensor
  /-- Symmetry of the strain indices i,j. -/
  symmetricIJ : ∀ z i j k, kernel z i j k = kernel z j i k
  /-- Trace-free strain kernel in the first two indices. -/
  traceFree : ∀ z k, (∑ i : Fin 3, kernel z i i k) = 0
  /-- Odd parity expected for the third-order strain kernel. -/
  odd : ∀ z i j k, kernel (-z) i j k = - kernel z i j k
  /-- Homogeneity of degree -3, stated away from zero scaling. -/
  homogeneousMinusThree : ∀ (a : ℝ) (ha : a ≠ 0) z i j k,
    kernel (a • z) i j k = a⁻¹ ^ 3 * kernel z i j k
  /-- Pointwise size envelope.  No boundedness theorem is inferred from it. -/
  sizeConstant : ℝ
  hSizeConstant : 0 ≤ sizeConstant
  sizeBound : ∀ z, z ≠ 0 → ∀ i j k,
    |kernel z i j k| ≤ sizeConstant * ‖z‖⁻¹ ^ 3

/-- Tensor action of the kernel on vorticity. -/
def StrainKernelData.apply (K : StrainKernelData) (z : Vec3) (ω : Vec3) : Matrix3 :=
  fun i j => ∑ k : Fin 3, K.kernel z i j k * ω k

/-- Symmetry of the matrix produced by the kernel is purely algebraic. -/
theorem StrainKernelData.apply_symmetric
    (K : StrainKernelData) (z ω : Vec3) (i j : Fin 3) :
    K.apply z ω i j = K.apply z ω j i := by
  simp only [StrainKernelData.apply]
  apply Finset.sum_congr rfl
  intro k hk
  rw [K.symmetricIJ]

/-- Trace-freeness of the tensor action is also algebraic. -/
theorem StrainKernelData.apply_trace_zero
    (K : StrainKernelData) (z ω : Vec3) :
    ∑ i : Fin 3, K.apply z ω i i = 0 := by
  simp only [StrainKernelData.apply]
  rw [Finset.sum_comm]
  apply Finset.sum_eq_zero
  intro k hk
  rw [← Finset.sum_mul]
  rw [K.traceFree]
  exact zero_mul (ω k)

/--
Principal-value strain realization remains an analytic object.  This structure
stores only the data needed to state that realization; it is not a proof of
existence.
-/
structure StrainPrincipalValueTarget where
  kernelData : StrainKernelData
  omega : Vec3 → Vec3
  strain : Vec3 → Matrix3
  principalValueExists : Prop
  identifiesPV : Prop

/-- Separate audit statuses: definitions do not close singular-integral theory. -/
inductive StrainKernelStatus
  | definitionalKernelArchitecture
  | kernelSymmetryProvedFromData
  | kernelTraceFreeProvedFromData
  | kernelHomogeneityRecorded
  | principalValueExistenceOpenCZ
  | czBoundednessOpenCZ
  deriving DecidableEq, Repr

end G1Audit
