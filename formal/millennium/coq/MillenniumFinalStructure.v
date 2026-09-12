From Coq Require Import String List.
Import ListNotations.

Inductive EvidenceStatus :=
| VERIFIED | REPORTED | PENDING_PRIMARY_VERIFICATION | MISSING | NOT_ESTABLISHED.

Record ProvenanceAnchor := {
  anchor_id : string;
  claimed_date : string;
  anchor_status : EvidenceStatus;
  anchor_note : string
}.

Record IModel := { ICarrier : Type; Ivalue : ICarrier }.

Record N7 (A : Type) := {
  n1 : A; n2 : A; n3 : A; n4 : A; n5 : A; n6 : A; n7 : A
}.

Record NSClosure := {
  State : Type;
  ActualNS : State -> Prop;
  DirectionalDepletion : State -> Prop;
  SignedFluxControl : State -> Prop;
  HighFrequencyCriticalControl : State -> Prop;
  LowFrequencyL3Control : State -> Prop;
  UniformLinfL3 : State -> Prop;
  ESSHypotheses : State -> Prop;
  GlobalRegularity : State -> Prop;
  ns_to_depletion : forall s, ActualNS s -> DirectionalDepletion s;
  depletion_to_flux : forall s, DirectionalDepletion s -> SignedFluxControl s;
  flux_to_high : forall s, SignedFluxControl s -> HighFrequencyCriticalControl s;
  high_to_low : forall s, HighFrequencyCriticalControl s -> LowFrequencyL3Control s;
  high_low_to_uniform : forall s, HighFrequencyCriticalControl s -> LowFrequencyL3Control s -> UniformLinfL3 s;
  uniform_to_ess : forall s, UniformLinfL3 s -> ESSHypotheses s;
  ess_to_global : forall s, ESSHypotheses s -> GlobalRegularity s
}.

Theorem ns_conditional_global_regularity :
  forall (M : NSClosure) (s : State M), ActualNS M s -> GlobalRegularity M s.
Proof.
  intros M s Hns.
  pose proof (ns_to_depletion M s Hns) as Hd.
  pose proof (depletion_to_flux M s Hd) as Hf.
  pose proof (flux_to_high M s Hf) as Hh.
  pose proof (high_to_low M s Hh) as Hl.
  pose proof (high_low_to_uniform M s Hh Hl) as Hu.
  pose proof (uniform_to_ess M s Hu) as He.
  exact (ess_to_global M s He).
Qed.

Record ProblemClosure := {
  PrimitiveHypotheses : Prop;
  CriticalBridge : Prop;
  Target : Prop;
  primitive_to_bridge : PrimitiveHypotheses -> CriticalBridge;
  bridge_to_target : CriticalBridge -> Target
}.

Theorem problem_conditional : forall M : ProblemClosure,
  PrimitiveHypotheses M -> Target M.
Proof.
  intros M H.
  apply (bridge_to_target M).
  apply (primitive_to_bridge M).
  exact H.
Qed.
