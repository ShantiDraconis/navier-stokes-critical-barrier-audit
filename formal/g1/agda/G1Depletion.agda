{-# OPTIONS --safe #-}
module G1Depletion where

open import Agda.Builtin.Sigma

-- Logic-only carrier: arithmetic inequalities are supplied as propositions by the analytic layer.
record G1Interface : Set₁ where
  field
    ClosedDepletion : Set
    EnstrophyBalance : Set
    Decay : Set
    betaHalfCoherence : Set
    coherenceEvidence : betaHalfCoherence
    coherenceToClosed : betaHalfCoherence → ClosedDepletion
    closedAndBalanceToDecay : ClosedDepletion → EnstrophyBalance → Decay

open G1Interface

g1Closed : (G : G1Interface) → ClosedDepletion G
g1Closed G = coherenceToClosed G (coherenceEvidence G)

g1Decay : (G : G1Interface) → EnstrophyBalance G → Decay G
g1Decay G balance = closedAndBalanceToDecay G (g1Closed G) balance
