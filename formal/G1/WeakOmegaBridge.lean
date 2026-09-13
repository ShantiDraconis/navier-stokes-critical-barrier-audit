/-
WeakOmegaBridge.lean

Space-time H^1 bridge for vorticity.  This mirrors WeakDerivBridge and
VectorLocalRep, but keeps the mathematically important distinction between a
4D L2 equivalence class and a 3D fixed-time representative explicit.

No pointwise evaluation of an L2(R^4) class on a time slice is postulated:
{t} x R^3 has four-dimensional measure zero.  Connecting these representatives
to XiEpsPDE.omegaEps therefore requires an actual slicing/Fubini theorem (or a
separate a.e.-in-time spatial Sobolev object), and is recorded as an open
interface rather than hidden as an equality field.
-/

import G1.WeakDerivBridge
import G1.VectorLocalRep

noncomputable section

open MeasureTheory TemperedDistribution
open scoped LineDeriv Laplacian

namespace G1Audit

/-- Componentwise space-time vorticity as tempered distributions in H^1(R^4). -/
structure WeakOmegaSpaceTime where
  omegaDist : Fin 3 → ScalarDist
  hOmegaH1 : ∀ i, MemSobolev 1 2 (omegaDist i)

/-- Weak time derivative of omega_i. -/
def WeakOmegaSpaceTime.dtDist (h : WeakOmegaSpaceTime) (i : Fin 3) : ScalarDist :=
  ∂_{timeDirection} (h.omegaDist i)

/-- Weak spatial derivative d_{x_k} omega_i. -/
def WeakOmegaSpaceTime.dxDist (h : WeakOmegaSpaceTime) (i k : Fin 3) : ScalarDist :=
  ∂_{spatialDirection k} (h.omegaDist i)

/-- H^1 embeds continuously into H^0=L^2 in the Bessel-potential scale. -/
theorem WeakOmegaSpaceTime.memSobolev_zero
    (h : WeakOmegaSpaceTime) (i : Fin 3) :
    MemSobolev 0 2 (h.omegaDist i) := by
  exact (h.hOmegaH1 i).mono (by norm_num)

/-- Every first directional derivative is H^0=L^2. -/
theorem WeakOmegaSpaceTime.lineDeriv_memSobolev_zero
    (h : WeakOmegaSpaceTime) (i : Fin 3) (m : SpaceTime) :
    MemSobolev 0 2 (∂_{m} (h.omegaDist i)) := by
  simpa using (h.hOmegaH1 i).lineDerivOp (m := m)

theorem WeakOmegaSpaceTime.dt_memSobolev_zero
    (h : WeakOmegaSpaceTime) (i : Fin 3) :
    MemSobolev 0 2 (h.dtDist i) := by
  exact h.lineDeriv_memSobolev_zero i timeDirection

theorem WeakOmegaSpaceTime.dx_memSobolev_zero
    (h : WeakOmegaSpaceTime) (i k : Fin 3) :
    MemSobolev 0 2 (h.dxDist i k) := by
  exact h.lineDeriv_memSobolev_zero i (spatialDirection k)

/-- Chosen L2 representative of omega_i itself. -/
def WeakOmegaSpaceTime.omegaL2
    (h : WeakOmegaSpaceTime) (i : Fin 3) :
    Lp ℂ 2 (volume : Measure SpaceTime) :=
  Classical.choose (memSobolev_zero_iff.mp (h.memSobolev_zero i))

theorem WeakOmegaSpaceTime.omegaL2_spec
    (h : WeakOmegaSpaceTime) (i : Fin 3) :
    h.omegaDist i = (h.omegaL2 i : ScalarDist) := by
  exact Classical.choose_spec (memSobolev_zero_iff.mp (h.memSobolev_zero i))

/-- Chosen L2 representative of an arbitrary first directional derivative. -/
def WeakOmegaSpaceTime.weakDirectionalL2
    (h : WeakOmegaSpaceTime) (i : Fin 3) (m : SpaceTime) :
    Lp ℂ 2 (volume : Measure SpaceTime) :=
  Classical.choose (memSobolev_zero_iff.mp (h.lineDeriv_memSobolev_zero i m))

theorem WeakOmegaSpaceTime.weakDirectionalL2_spec
    (h : WeakOmegaSpaceTime) (i : Fin 3) (m : SpaceTime) :
    (∂_{m} (h.omegaDist i)) = (h.weakDirectionalL2 i m : ScalarDist) := by
  exact Classical.choose_spec (memSobolev_zero_iff.mp (h.lineDeriv_memSobolev_zero i m))

/-- Chosen L2 representative of d_t omega_i. -/
def WeakOmegaSpaceTime.weakDtL2
    (h : WeakOmegaSpaceTime) (i : Fin 3) :
    Lp ℂ 2 (volume : Measure SpaceTime) :=
  h.weakDirectionalL2 i timeDirection

theorem WeakOmegaSpaceTime.weakDtL2_spec
    (h : WeakOmegaSpaceTime) (i : Fin 3) :
    h.dtDist i = (h.weakDtL2 i : ScalarDist) := by
  exact h.weakDirectionalL2_spec i timeDirection

/-- Chosen L2 representative of d_{x_k} omega_i. -/
def WeakOmegaSpaceTime.weakDxL2
    (h : WeakOmegaSpaceTime) (i k : Fin 3) :
    Lp ℂ 2 (volume : Measure SpaceTime) :=
  h.weakDirectionalL2 i (spatialDirection k)

theorem WeakOmegaSpaceTime.weakDxL2_spec
    (h : WeakOmegaSpaceTime) (i k : Fin 3) :
    h.dxDist i k = (h.weakDxL2 i k : ScalarDist) := by
  exact h.weakDirectionalL2_spec i (spatialDirection k)

/-- Componentwise L2 weak spatial gradient: component i, direction k. -/
def WeakOmegaSpaceTime.weakSpatialGradientL2
    (h : WeakOmegaSpaceTime) : Fin 3 → Fin 3 → Lp ℂ 2 (volume : Measure SpaceTime) :=
  fun i k => h.weakDxL2 i k

/--
A fixed-time spatial realization must be produced by a genuine slicing theorem.
This proposition deliberately contains no fake evaluation of an L2(R^4) class.
-/
structure WeakOmegaSliceInterface (h : WeakOmegaSpaceTime) where
  /-- Times for which a spatial H1 representative exists. -/
  goodTime : ℝ → Prop
  /-- The slicing theorem holds for almost every time. -/
  goodTime_ae : Prop
  /-- At a good time, omega has a spatial L2 realization. -/
  spatialOmegaL2 : ℝ → Fin 3 → Prop
  /-- At a good time, each spatial weak derivative has an L2 realization. -/
  spatialDxL2 : ℝ → Fin 3 → Fin 3 → Prop
  /-- Fubini/slicing identifies the spatial objects with the space-time class. -/
  sliceCompatible : Prop

/--
The pointwise XiEpsPDE field is R^3-valued, while `omegaL2` is an L2(R^4)
equivalence class.  An a.e.-in-time slice compatibility theorem is therefore a
separate obligation before the nonlinear chain rule can consume `omegaEps`.
-/
inductive WeakOmegaBridgeStatus
  | omegaH1SpaceTimeDefined
  | omegaL2RepresentativeProved
  | weakTimeDerivativeL2Proved
  | threeSpatialDerivativesL2Proved
  | spatialGradientPackaged
  | fixedTimeSliceRequiresFubini
  | xiEpsPointwiseLinkOpen
  | nonlinearChainRuleNotYetPromoted
  deriving DecidableEq, Repr

end G1Audit
