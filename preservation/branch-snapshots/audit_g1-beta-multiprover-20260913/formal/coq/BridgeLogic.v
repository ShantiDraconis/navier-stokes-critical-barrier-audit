(** BridgeLogic.v

    Axiom-free logical skeleton for the audit.
    This file proves dependency composition and contradiction rules only;
    it does not prove Navier-Stokes regularity or singularity. *)

Section BridgeLogic.

Variables RepositoryCondition CriticalCriterion Target : Prop.

Theorem bridge_compose :
  (RepositoryCondition -> CriticalCriterion) ->
  (CriticalCriterion -> Target) ->
  RepositoryCondition -> Target.
Proof.
  intros Hcritical Htarget Hrepo.
  apply Htarget.
  apply Hcritical.
  exact Hrepo.
Qed.

Theorem target_failure_forces_critical_failure :
  (CriticalCriterion -> Target) ->
  ~ Target ->
  ~ CriticalCriterion.
Proof.
  intros Htarget HnotTarget Hcritical.
  apply HnotTarget.
  apply Htarget.
  exact Hcritical.
Qed.

Theorem exact_counterexample_refutes :
  forall Hypotheses Conclusion : Prop,
  (Hypotheses -> Conclusion) ->
  Hypotheses ->
  ~ Conclusion ->
  False.
Proof.
  intros Hypotheses Conclusion Hclaim Hhyp Hcounter.
  apply Hcounter.
  apply Hclaim.
  exact Hhyp.
Qed.

End BridgeLogic.
