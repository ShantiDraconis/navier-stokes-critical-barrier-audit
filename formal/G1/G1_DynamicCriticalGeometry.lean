/-
G1_DynamicCriticalGeometry.lean

Cutoff-free audit interface connecting the regularized xi equation,
DynamicCampanato, hDynamic, and the signed-depletion programme.

hDynamic remains OPEN_BRIDGE / NOT_ESTABLISHED.
No axiom and no sorry are introduced.
-/

import Mathlib
import «DynamicCampanato»

noncomputable section

namespace G1Audit

/--
Regularized direction-field PDE interface.  `R1` and `R2` are kept explicit;
this structure does not declare that either remainder vanishes.
-/
structure XiEpsPDE (State : Type*) where
  xiEps : State
  materialDerivative : State
  strainProjection : State
  diffusion : State
  R1 : State
  R2 : State
  pde_identity : Prop

/--
Concrete cutoff-free witness requested by the audit.  `C_rem` depends only on
allowed macroscopic data (||u0||_2 and nu through the eventual construction),
not on epsilon or a hidden enstrophy supremum.
-/
structure RemainderCutoffFreeWitness where
  u0L2 : ℝ
  nu : ℝ
  C_rem : ℝ
  hnu_pos : 0 < nu
  hC_rem_nonneg : 0 ≤ C_rem

/-- Dynamic critical geometry data with a cutoff-free constant. -/
structure DynamicCriticalGeometryData (Point : Type*) where
  campanato : DynamicCampanatoData Point
  C0_cutoff_free : ℝ
  hC0_nonneg : 0 ≤ C0_cutoff_free

/--
The actual analytic PDE-to-Campanato estimate.  This is the new theorem that
must be proved; the interface makes it impossible to silently replace it by
hDynamic itself.
-/
structure PDEToDynamicCampanato
    {Point State : Type*}
    (pde : XiEpsPDE State)
    (geom : DynamicCriticalGeometryData Point)
    (rem : RemainderCutoffFreeWitness) where
  pde_to_campanato : DynamicCampanatoTarget geom.campanato

/-- hDynamic is deliberately an external proposition. -/
structure HDynamicOpenBridge
    {Point : Type*}
    (geom : DynamicCriticalGeometryData Point)
    (hDynamic : Prop) where
  campanato_embedding : DynamicCampanatoTarget geom.campanato → hDynamic

/--
Conditional composition.  This theorem proves no PDE estimate: it only shows
that a completed PDE-to-Campanato theorem plus the concrete Campanato embedding
would establish hDynamic.
-/
theorem hDynamic_if_campanato_closes
    {Point State : Type*}
    (pde : XiEpsPDE State)
    (geom : DynamicCriticalGeometryData Point)
    (rem : RemainderCutoffFreeWitness)
    (hDynamic : Prop)
    (analytic : PDEToDynamicCampanato pde geom rem)
    (embedding : HDynamicOpenBridge geom hDynamic) :
    hDynamic :=
  embedding.campanato_embedding analytic.pde_to_campanato

/--
Downstream signed-depletion bridge.  Keeping this separate prevents the
near-field depletion theorem from being smuggled into the proof of hDynamic.
-/
structure HDynamicToSignedDepletion
    (hDynamic signedDepletion : Prop) where
  depletion_from_hDynamic : hDynamic → signedDepletion

theorem signed_depletion_if_dynamic_geometry_closes
    {Point State : Type*}
    (pde : XiEpsPDE State)
    (geom : DynamicCriticalGeometryData Point)
    (rem : RemainderCutoffFreeWitness)
    (hDynamic signedDepletion : Prop)
    (analytic : PDEToDynamicCampanato pde geom rem)
    (embedding : HDynamicOpenBridge geom hDynamic)
    (downstream : HDynamicToSignedDepletion hDynamic signedDepletion) :
    signedDepletion :=
  downstream.depletion_from_hDynamic
    (hDynamic_if_campanato_closes pde geom rem hDynamic analytic embedding)

/-
Status certificate:

XiEpsPDE with R1,R2                         = INTERFACE
RemainderCutoffFreeWitness C_rem            = INTERFACE
C0_cutoff_free                              = PRESERVED FIELD
PDE -> DynamicCampanato                     = OPEN_BRIDGE
DynamicCampanato -> hDynamic                = OPEN/CONCRETE EMBEDDING NEEDED
hDynamic                                    = NOT_ESTABLISHED
hDynamic -> signed depletion                = DOWNSTREAM INTERFACE
unconditional G1                            = NOT_ESTABLISHED

Forbidden inputs absent:
- no uniform sup ||omega||_2^2;
- no uniform integral ||grad omega||_2^2;
- no hDynamic premise in PDEToDynamicCampanato;
- no far-field rhoStar^(-3/2)||omega||_2 premise.
-/

end G1Audit
