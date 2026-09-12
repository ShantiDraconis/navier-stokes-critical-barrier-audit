module BridgeLogic where

-- Constructive logical skeleton for the audit.
-- No Navier–Stokes theorem is asserted here.

open import Data.Empty using (⊥)

bridge-compose : {A B C : Set} → (A → B) → (B → C) → A → C
bridge-compose f g a = g (f a)

target-failure-forces-critical-failure :
  {Critical Target : Set} →
  (Critical → Target) →
  (Target → ⊥) →
  Critical → ⊥
target-failure-forces-critical-failure hTarget notTarget critical =
  notTarget (hTarget critical)

exact-counterexample-refutes :
  {Hypotheses Conclusion : Set} →
  (Hypotheses → Conclusion) →
  Hypotheses →
  (Conclusion → ⊥) →
  ⊥
exact-counterexample-refutes claim hypotheses counterexample =
  counterexample (claim hypotheses)
