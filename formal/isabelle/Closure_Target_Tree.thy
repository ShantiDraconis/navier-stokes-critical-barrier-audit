theory Closure_Target_Tree
  imports Main HOL.Real
begin

record target_constants =
  nu :: real
  Lambda :: real
  C_Bern :: real
  C_CZ :: real
  C_Sob :: real
  C_error :: real
  delta :: real

definition kappa :: "target_constants ⇒ real" where
  "kappa c = nu c * Lambda c ^ 2 / 4"

definition cstar :: "target_constants ⇒ real" where
  "cstar c = nu c / C_error c"

lemma target_constant_arithmetic:
  "(4::real) * (31/50) = 62/25"
  by norm_num

locale ns_chain =
  fixes Repo Critical Smooth :: "'a ⇒ bool"
    and Pi R D :: "'a ⇒ real"
    and c :: target_constants
  assumes b28: "Repo u ⟹ Pi u ≤ (kappa c + delta c) * R u"
      and b24: "Repo u ⟹ nu c * Lambda c^2 * R u ≤ D u"
      and b210: "Repo u ⟹ Critical u"
      and b212: "Critical u ⟹ Smooth u"
begin

lemma NS_closure: "Repo u ⟹ Smooth u"
  using b210 b212 by blast

end

locale rh_chain =
  fixes LocalArbRouche ExplicitFormula GlobalExclusion RH :: bool
  assumes globalize: "LocalArbRouche ⟹ ExplicitFormula ⟹ GlobalExclusion"
      and conclude: "GlobalExclusion ⟹ RH"
begin
lemma RH_closure: "LocalArbRouche ⟹ ExplicitFormula ⟹ RH"
  using globalize conclude by blast
end

locale pnp_chain =
  fixes CookLevin SATnotP PneqNP :: bool
  assumes conclude: "CookLevin ⟹ SATnotP ⟹ PneqNP"
begin
lemma PNP_closure: "CookLevin ⟹ SATnotP ⟹ PneqNP"
  using conclude by blast
end

locale bsd_chain =
  fixes RankBridge LeadingCoefficientBridge BSD :: bool
  assumes conclude: "RankBridge ⟹ LeadingCoefficientBridge ⟹ BSD"
begin
lemma BSD_closure: "RankBridge ⟹ LeadingCoefficientBridge ⟹ BSD"
  using conclude by blast
end

locale hodge_chain =
  fixes CycleClassBridge Hodge :: bool
  assumes conclude: "CycleClassBridge ⟹ Hodge"
begin
lemma Hodge_closure: "CycleClassBridge ⟹ Hodge"
  using conclude by blast
end

locale ym_chain =
  fixes ConstructiveQFT OS PositiveGap YM :: bool
  assumes conclude: "ConstructiveQFT ⟹ OS ⟹ PositiveGap ⟹ YM"
begin
lemma YM_closure: "ConstructiveQFT ⟹ OS ⟹ PositiveGap ⟹ YM"
  using conclude by blast
end

locale resolution_operator =
  fixes admissible native endpoint :: "'a ⇒ bool"
    and defect :: "'a ⇒ real"
    and correct :: "'a ⇒ 'a"
  assumes preserves: "admissible x ⟹ admissible (correct x)"
      and bridge: "admissible x ⟹ defect x ≤ 0 ⟹ native x"
      and close: "native x ⟹ endpoint x"
begin
lemma abstract_resolution_law:
  "admissible x ⟹ defect x ≤ 0 ⟹ endpoint x"
  using bridge close by blast
end

end
