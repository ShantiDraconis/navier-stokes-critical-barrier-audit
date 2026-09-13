theory B2_Closure_Obligations
  imports Main
begin

text ‹B2 closure obligations. All unresolved PDE content is explicit in premises.›

locale b2_closure =
  fixes NS :: bool
    and Dep Flux Dom Decay High Low Crit ESS Tinf Smooth :: bool
  assumes dep_flux: "Dep ⟹ Flux"
      and flux_dom: "Flux ⟹ Dom"
      and dom_decay: "Dom ⟹ Decay"
      and decay_high: "Decay ⟹ High"
      and ns_low: "NS ⟹ Low"
      and reconstruct: "High ⟹ Low ⟹ Crit"
      and ess_map: "Crit ⟹ ESS"
      and continuation: "ESS ⟹ Tinf ∧ Smooth"
begin

lemma close_via_geometric_route:
  assumes route: "NS ⟹ Dep" and hNS: NS
  shows "Tinf ∧ Smooth"
proof -
  have d: Dep using route hNS .
  have f: Flux using dep_flux d .
  have dm: Dom using flux_dom f .
  have de: Decay using dom_decay dm .
  have h: High using decay_high de .
  have l: Low using ns_low hNS .
  have c: Crit using reconstruct h l .
  have e: ESS using ess_map c .
  show ?thesis using continuation e .
qed

lemma close_via_vector_tensor_route:
  assumes route: "NS ⟹ Flux" and hNS: NS
  shows "Tinf ∧ Smooth"
proof -
  have f: Flux using route hNS .
  have dm: Dom using flux_dom f .
  have de: Decay using dom_decay dm .
  have h: High using decay_high de .
  have l: Low using ns_low hNS .
  have c: Crit using reconstruct h l .
  show ?thesis using continuation (ess_map c) .
qed

lemma close_via_enstrophy_route:
  assumes route: "NS ⟹ Dom" and hNS: NS
  shows "Tinf ∧ Smooth"
proof -
  have dm: Dom using route hNS .
  have de: Decay using dom_decay dm .
  have h: High using decay_high de .
  have l: Low using ns_low hNS .
  have c: Crit using reconstruct h l .
  show ?thesis using continuation (ess_map c) .
qed

end

end
