theory G1_Depletion
  imports Main "HOL-Analysis.Analysis"
begin

locale g1 =
  fixes stretching palinstrophy yderiv :: "real ⇒ real"
    and delta :: real
  assumes delta_pos: "0 < delta"
    and z_nonneg: "⋀t. 0 ≤ palinstrophy t"
    and balance: "⋀t. yderiv t / 2 + palinstrophy t = stretching t"
    and closed: "⋀t. stretching t ≤ (1-delta) * palinstrophy t"
begin

theorem closed_implies_decay:
  "yderiv t + 2*delta*palinstrophy t ≤ 0"
  using balance[of t] closed[of t] z_nonneg[of t] by linarith

end

text ‹The unresolved analytic theorem is intentionally not postulated here: a future locale
interpretation must supply `closed` from an independently proved beta-coherence/Biot-Savart bridge.›

end
