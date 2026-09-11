theory AuditLemmas
  imports Complex_Main
begin

text ‹Internal audit lemmas only; no open Millennium theorem is asserted.›

lemma two_component_normalization:
  fixes a b E :: real
  assumes "E = a + b" "E ≠ 0"
  shows "a / E + b / E = 1"
  using assms by (field_simp; simp)

lemma progress_monotone:
  fixes e0 e1 e2 :: real
  assumes "0 < e0" "e2 ≤ e1"
  shows "1 - e1 / e0 ≤ 1 - e2 / e0"
  using assms by (simp add: divide_le_cancel)

lemma square_sum_zero:
  fixes x y :: real
  assumes "x*x + y*y = 0"
  shows "x = 0 ∧ y = 0"
  using assms by (smt (verit) mult_self_nonneg)

text ‹Counterexample schema: a strictly decreasing positive sequence may converge to a nonzero value.›

definition audit_seq :: "nat ⇒ real" where
  "audit_seq n = 1 + 1 / real (Suc n)"

lemma audit_seq_above_one:
  "1 < audit_seq n"
  unfolding audit_seq_def by simp

lemma audit_seq_decreasing:
  "audit_seq (Suc n) < audit_seq n"
  unfolding audit_seq_def
  by (simp add: frac_less)

end
