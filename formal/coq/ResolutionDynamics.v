Require Import Reals.
Require Import Lia.
Open Scope R_scope.

Section ResolutionDynamics.

Variables RepositoryCondition NativeControl Endpoint : Prop.

Theorem endpoint_from_native_control :
  (RepositoryCondition -> NativeControl) ->
  (NativeControl -> Endpoint) ->
  RepositoryCondition -> Endpoint.
Proof.
  intros Hbridge Hendpoint Hrepo.
  apply Hendpoint, Hbridge, Hrepo.
Qed.

Theorem coercive_bound : forall D N alpha beta M : R,
  0 <= alpha -> D <= M -> N <= alpha * D + beta ->
  N <= alpha * M + beta.
Proof.
  intros D N alpha beta M Halpha HD Hcoerce.
  eapply Rle_trans; [exact Hcoerce|].
  apply Rplus_le_compat_r.
  apply Rmult_le_compat_l; assumption.
Qed.

Theorem contraction_coercivity_bound : forall D0 Dn N qn alpha beta : R,
  0 <= alpha -> Dn <= qn * D0 -> N <= alpha * Dn + beta ->
  N <= alpha * (qn * D0) + beta.
Proof.
  intros.
  eapply coercive_bound; eauto.
Qed.

Definition Close (eps x y : R) : Prop := Rabs (x-y) < eps.

Theorem close_triangle : forall eps delta x y z : R,
  Close eps x y -> Close delta y z -> Close (eps+delta) x z.
Proof.
  intros eps delta x y z Hxy Hyz.
  unfold Close in *.
  replace (x-z) with ((x-y)+(y-z)) by ring.
  eapply Rle_lt_trans.
  - apply Rabs_triang.
  - lra.
Qed.

End ResolutionDynamics.
