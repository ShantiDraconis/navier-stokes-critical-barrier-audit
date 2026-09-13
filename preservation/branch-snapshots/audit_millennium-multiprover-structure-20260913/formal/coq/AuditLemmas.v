(** AuditLemmas.v
    Constructive internal lemmas for the audit framework.
    No Millennium-problem theorem is asserted here. *)

From Coq Require Import Reals Lra.
Open Scope R_scope.

Section AuditLemmas.

Variables a b E : R.

Theorem two_component_normalization :
  E = a + b -> E <> 0 -> a / E + b / E = 1.
Proof.
  intros HE Hnz.
  field_simplify.
  lra.
Qed.

Theorem progress_monotone :
  forall e0 e1 e2 : R,
    0 < e0 -> 0 <= e2 -> e2 <= e1 ->
    1 - e1 / e0 <= 1 - e2 / e0.
Proof.
  intros e0 e1 e2 H0 H2 H21.
  apply Rplus_le_compat_l.
  apply Ropp_le_contravar.
  apply Rmult_le_compat_r.
  - left. apply Rinv_0_lt_compat. exact H0.
  - exact H21.
Qed.

Theorem square_sum_zero :
  forall x y : R,
    x*x + y*y = 0 -> x = 0 /\ y = 0.
Proof.
  intros x y H.
  assert (Hx : 0 <= x*x) by nra.
  assert (Hy : 0 <= y*y) by nra.
  split; nra.
Qed.

(** Counterexample: strict monotone decrease does not force zero limit.
    The sequence 1 + 1/(n+1) stays strictly above 1. *)
Theorem monotone_not_zero_witness :
  forall n : nat,
    1 < 1 + / INR (S n).
Proof.
  intro n.
  assert (H : 0 < INR (S n)).
  { apply lt_0_INR. lia. }
  assert (Hinv : 0 < / INR (S n)).
  { apply Rinv_0_lt_compat. exact H. }
  lra.
Qed.

End AuditLemmas.
