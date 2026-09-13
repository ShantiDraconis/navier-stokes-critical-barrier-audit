theory Millennium_Final_Structure
  imports Main
begin

datatype evidence_status = VERIFIED | REPORTED | PENDING_PRIMARY_VERIFICATION | MISSING | NOT_ESTABLISHED

record provenance_anchor =
  anchor_id :: string
  claimed_date :: string
  anchor_status :: evidence_status
  anchor_note :: string

locale navier_stokes_closure =
  fixes ActualNS DirectionalDepletion SignedFluxControl HighCritical LowL3 UniformL3 ESS Global :: "'s \<Rightarrow> bool"
  assumes ns_to_depletion: "ActualNS s \<Longrightarrow> DirectionalDepletion s"
      and depletion_to_flux: "DirectionalDepletion s \<Longrightarrow> SignedFluxControl s"
      and flux_to_high: "SignedFluxControl s \<Longrightarrow> HighCritical s"
      and high_to_low: "HighCritical s \<Longrightarrow> LowL3 s"
      and high_low_to_uniform: "\<lbrakk>HighCritical s; LowL3 s\<rbrakk> \<Longrightarrow> UniformL3 s"
      and uniform_to_ess: "UniformL3 s \<Longrightarrow> ESS s"
      and ess_to_global: "ESS s \<Longrightarrow> Global s"
begin

theorem conditional_global_regularity:
  assumes "ActualNS s"
  shows "Global s"
proof -
  from assms have d: "DirectionalDepletion s" by (rule ns_to_depletion)
  from d have f: "SignedFluxControl s" by (rule depletion_to_flux)
  from f have h: "HighCritical s" by (rule flux_to_high)
  from h have l: "LowL3 s" by (rule high_to_low)
  from h l have u: "UniformL3 s" by (rule high_low_to_uniform)
  from u have e: "ESS s" by (rule uniform_to_ess)
  from e show ?thesis by (rule ess_to_global)
qed

end

locale problem_closure =
  fixes Primitive Critical Target :: bool
  assumes primitive_to_bridge: "Primitive \<Longrightarrow> Critical"
      and bridge_to_target: "Critical \<Longrightarrow> Target"
begin

theorem conditional: "Primitive \<Longrightarrow> Target"
  using primitive_to_bridge bridge_to_target by blast
end

end
