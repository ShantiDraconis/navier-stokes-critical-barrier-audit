import Mathlib

/-!
# B2 deterministic parameter chain (audit target)

This file formalizes the algebraic consequences of the corrected B2 parameter
chain.  It does NOT prove the missing PDE/functional-analytic premises.

Important correction: Aubin--Talenti controls L6 by grad-L2.  The L3 bridge on
R^3 requires interpolation between L2 and L6.  Therefore no theorem below uses
`L3 <= C_Sob * gradL2` directly.
-/

namespace CriticalBarrier.B2Deterministic

abbrev Scalar := ℝ

/-- Target parameters.  `C_Sob` is left symbolic at the theorem level so that
its exact normalization can be certified separately. -/
structure Parameters where
  nu : Scalar
  Lambda : Scalar
  C_Bern : Scalar
  C_Sob : Scalar
  C_CZ : Scalar
  deriving Repr

namespace Parameters

def kappa (p : Parameters) : Scalar := p.nu * p.Lambda^2 / 4

def C_error (p : Parameters) : Scalar := p.C_Bern * p.C_Sob

def perturbation (p : Parameters) : Scalar := p.C_error / Real.sqrt p.Lambda

def decayRate (p : Parameters) : Scalar :=
  p.nu * p.Lambda^2 - p.kappa - p.perturbation

end Parameters

/-- One-time high-frequency observables.  These are abstract numeric shadows of
actual PDE quantities and are not definitions of the Navier--Stokes objects. -/
structure Snapshot where
  R : Scalar
  Pi : Scalar
  D : Scalar
  dRdt : Scalar
  highL2 : Scalar
  highL3 : Scalar
  highL6 : Scalar
  highGradL2 : Scalar

/-- Exact balance and sign assumptions needed for the scalar decay estimate. -/
structure BalanceCertificates (p : Parameters) (s : Snapshot) : Prop where
  R_nonneg : 0 ≤ s.R
  balance : s.dRdt + s.D ≤ s.Pi
  dissipation : p.nu * p.Lambda^2 * s.R ≤ s.D
  flux : s.Pi ≤ (p.kappa + p.perturbation) * s.R

/-- Pure algebra: once the balance/dissipation/flux premises are proved for the
actual PDE quantities, the differential decay coefficient follows. -/
theorem differential_decay
    (p : Parameters) (s : Snapshot) (h : BalanceCertificates p s) :
    s.dRdt ≤ -(p.decayRate) * s.R := by
  dsimp [Parameters.decayRate, Parameters.kappa, Parameters.perturbation,
    Parameters.C_error]
  linarith [h.balance, h.dissipation, h.flux]

/-- Correct high-frequency L3 reconstruction interface:
    L3 <= sqrt(L2 * L6), followed by Sobolev L6 <= C_Sob * gradL2.
    Both analytic premises must be supplied for the concrete field. -/
structure CriticalInterpolationCertificates (p : Parameters) (s : Snapshot) : Prop where
  high_nonneg : 0 ≤ s.highL2
  grad_nonneg : 0 ≤ s.highGradL2
  interpolation : s.highL3^2 ≤ s.highL2 * s.highL6
  sobolev : s.highL6 ≤ p.C_Sob * s.highGradL2

/-- Algebraic composition of interpolation and Sobolev. -/
theorem high_L3_squared_bound
    (p : Parameters) (s : Snapshot)
    (h : CriticalInterpolationCertificates p s) :
    s.highL3^2 ≤ p.C_Sob * s.highL2 * s.highGradL2 := by
  calc
    s.highL3^2 ≤ s.highL2 * s.highL6 := h.interpolation
    _ ≤ s.highL2 * (p.C_Sob * s.highGradL2) := by
      exact mul_le_mul_of_nonneg_left h.sobolev h.high_nonneg
    _ = p.C_Sob * s.highL2 * s.highGradL2 := by ring

/-- Low + high critical-space reconstruction is a separate bridge. -/
structure L3Reconstruction (p : Parameters) where
  lowL3 : Scalar
  totalL3 : Scalar
  snap : Snapshot
  lowBound : Scalar
  low_nonneg : 0 ≤ lowL3
  high_nonneg : 0 ≤ snap.highL3
  split : totalL3 ≤ lowL3 + snap.highL3
  low_control : lowL3 ≤ lowBound

/-- If a high-frequency L3 bound H is independently proved, total L3 follows. -/
theorem total_L3_from_low_high
    (p : Parameters) (r : L3Reconstruction p) (H : Scalar)
    (hH : r.snap.highL3 ≤ H) :
    r.totalL3 ≤ r.lowBound + H := by
  linarith [r.split, r.low_control, hH]

/-- Target normalization nu=1, Lambda=10 gives kappa=25 exactly. -/
def targetParams (C_sob C_cz : ℝ) : Parameters where
  nu := 1
  Lambda := 10
  C_Bern := 4
  C_Sob := C_sob
  C_CZ := C_cz

theorem target_kappa (C_sob C_cz : ℝ) :
    (targetParams C_sob C_cz).kappa = 25 := by
  norm_num [targetParams, Parameters.kappa]

/-- Decimal target used only as an auditable numerical approximation; it is not
identified here with the sharp Sobolev constant. -/
def C_Sob_decimal : ℝ := 4272605429 / 10000000000

def C_CZ_target : ℝ := 3 / 2

def pDecimal : Parameters := targetParams C_Sob_decimal C_CZ_target

/-- Exact rational arithmetic for the decimal target. -/
theorem C_error_decimal_exact :
    pDecimal.C_error = 17090421716 / 10000000000 := by
  norm_num [pDecimal, targetParams, C_Sob_decimal, C_CZ_target,
    Parameters.C_error]

/-- The PDE-number R=51 is NOT inferred from the finite Fourier counterexample.
This theorem only performs arithmetic if R=51 is supplied as an independent
snapshot value. -/
theorem arithmetic_at_R51
    (s : Snapshot)
    (hR : s.R = 51)
    (hD : s.D = 100 * s.R) :
    s.D = 5100 := by
  rw [hD, hR]
  norm_num

/-- Endpoint interface: ESS is invoked only after a genuine uniform critical
L3 bound has been established for the actual admissible solution. -/
structure ESSEndpoint where
  CriticalBound : Prop
  GlobalRegularity : Prop
  endpoint : CriticalBound → GlobalRegularity

theorem use_ess (E : ESSEndpoint) (h : E.CriticalBound) : E.GlobalRegularity :=
  E.endpoint h

end CriticalBarrier.B2Deterministic
