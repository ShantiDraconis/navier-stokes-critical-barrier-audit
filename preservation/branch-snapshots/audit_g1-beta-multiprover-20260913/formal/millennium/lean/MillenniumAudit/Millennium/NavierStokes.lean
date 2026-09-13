import MillenniumAudit.Core

namespace MillenniumAudit.Millennium.NavierStokes

structure Closure where
  State : Type
  ActualNS : State → Prop
  DirectionalDepletion : State → Prop
  SignedFluxControl : State → Prop
  HighFrequencyCriticalControl : State → Prop
  LowFrequencyL3Control : State → Prop
  UniformLinfL3 : State → Prop
  ESSHypotheses : State → Prop
  GlobalRegularity : State → Prop
  ns_to_depletion : ∀ s, ActualNS s → DirectionalDepletion s
  depletion_to_flux : ∀ s, DirectionalDepletion s → SignedFluxControl s
  flux_to_high : ∀ s, SignedFluxControl s → HighFrequencyCriticalControl s
  high_to_low : ∀ s, HighFrequencyCriticalControl s → LowFrequencyL3Control s
  high_low_to_uniform : ∀ s, HighFrequencyCriticalControl s → LowFrequencyL3Control s → UniformLinfL3 s
  uniform_to_ess : ∀ s, UniformLinfL3 s → ESSHypotheses s
  ess_to_global : ∀ s, ESSHypotheses s → GlobalRegularity s

/-- Fully checked composition of the entire closure ladder. The open mathematics sits
in the fields of Closure; this theorem only certifies that those bridges suffice. -/
theorem conditional_global_regularity (M : Closure) (s : M.State) (hNS : M.ActualNS s) :
    M.GlobalRegularity s := by
  have hD := M.ns_to_depletion s hNS
  have hF := M.depletion_to_flux s hD
  have hH := M.flux_to_high s hF
  have hL := M.high_to_low s hH
  have hU := M.high_low_to_uniform s hH hL
  have hE := M.uniform_to_ess s hU
  exact M.ess_to_global s hE

end MillenniumAudit.Millennium.NavierStokes
