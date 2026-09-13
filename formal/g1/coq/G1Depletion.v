From Coq Require Import Reals Lra.
Open Scope R_scope.

Record G1Data := { stretching : R -> R; palinstrophy : R -> R; enstrophy_derivative : R -> R }.

Definition ClosedDepletion (D:G1Data) (delta:R) : Prop :=
  0 < delta /\ forall t, stretching D t <= (1-delta) * palinstrophy D t.

Definition EnstrophyBalance (D:G1Data) : Prop :=
  forall t, enstrophy_derivative D t / 2 + palinstrophy D t = stretching D t.

Record AnalyticBridge (D:G1Data) := {
  beta_half_coherence : Prop;
  delta : R;
  delta_pos : 0 < delta;
  coherence_evidence : beta_half_coherence;
  coherence_to_closed : beta_half_coherence -> ClosedDepletion D delta
}.

Theorem G1_closed_of_depletion : forall (D:G1Data) (B:AnalyticBridge D),
  ClosedDepletion D (delta D B).
Proof. intros D B. apply (coherence_to_closed D B). exact (coherence_evidence D B). Qed.

Theorem closed_implies_decay : forall (D:G1Data) delta,
  (forall t, 0 <= palinstrophy D t) -> EnstrophyBalance D -> ClosedDepletion D delta ->
  forall t, enstrophy_derivative D t + 2*delta*palinstrophy D t <= 0.
Proof.
  intros D delta Hz Hb [Hd Hc] t. specialize (Hz t). specialize (Hb t). specialize (Hc t). lra.
Qed.
