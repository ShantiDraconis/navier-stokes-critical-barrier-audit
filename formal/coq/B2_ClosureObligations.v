(* B2 closure obligations. Open PDE content is represented by explicit hypotheses. *)

Section B2Closure.

Variables NSHypotheses DirectionalDepletion SignedFluxBound : Prop.
Variables DissipativeDomination ResidualDecay : Prop.
Variables HighCriticalL3 LowCriticalL3 UniformCriticalL3 : Prop.
Variables ESSHypotheses TstarInfinite GlobalSmoothness : Prop.

Record DownstreamCertificates : Prop := {
  depletion_to_flux : DirectionalDepletion -> SignedFluxBound;
  flux_to_domination : SignedFluxBound -> DissipativeDomination;
  domination_to_decay : DissipativeDomination -> ResidualDecay;
  decay_to_highL3 : ResidualDecay -> HighCriticalL3;
  lowL3 : NSHypotheses -> LowCriticalL3;
  reconstruct : HighCriticalL3 -> LowCriticalL3 -> UniformCriticalL3;
  ess_map : UniformCriticalL3 -> ESSHypotheses;
  continuation : ESSHypotheses -> TstarInfinite /\ GlobalSmoothness
}.

Theorem close_via_geometric_route :
  (NSHypotheses -> DirectionalDepletion) ->
  DownstreamCertificates ->
  NSHypotheses -> TstarInfinite /\ GlobalSmoothness.
Proof.
  intros route D hNS.
  destruct D as [d2f f2d d2r r2h low rec ess cont].
  apply cont, ess.
  apply rec.
  - apply r2h, d2r, f2d, d2f, route, hNS.
  - apply low, hNS.
Qed.

Theorem close_via_vector_tensor_route :
  (NSHypotheses -> SignedFluxBound) ->
  DownstreamCertificates ->
  NSHypotheses -> TstarInfinite /\ GlobalSmoothness.
Proof.
  intros route D hNS.
  destruct D as [d2f f2d d2r r2h low rec ess cont].
  apply cont, ess.
  apply rec.
  - apply r2h, d2r, f2d, route, hNS.
  - apply low, hNS.
Qed.

Theorem close_via_enstrophy_route :
  (NSHypotheses -> DissipativeDomination) ->
  DownstreamCertificates ->
  NSHypotheses -> TstarInfinite /\ GlobalSmoothness.
Proof.
  intros route D hNS.
  destruct D as [d2f f2d d2r r2h low rec ess cont].
  apply cont, ess.
  apply rec.
  - apply r2h, d2r, route, hNS.
  - apply low, hNS.
Qed.

End B2Closure.
