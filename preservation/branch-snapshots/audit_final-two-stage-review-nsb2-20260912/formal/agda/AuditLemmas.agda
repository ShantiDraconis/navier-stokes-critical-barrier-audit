module AuditLemmas where

-- Constructive discrete audit lemmas.
-- These certify logical properties of the audit state machine, not Navier–Stokes.

open import Data.Nat using (ℕ; zero; suc; _≤_; z≤n; s≤s)
open import Data.Product using (_×_; _,_)
open import Relation.Binary.PropositionalEquality using (_≡_; refl)

record Error2 : Set where
  constructor error2
  field
    e₁ : ℕ
    e₂ : ℕ

open Error2 public

zeroError : Error2
zeroError = error2 zero zero

zeroCoordinates : (e : Error2) → e ≡ zeroError → (e₁ e ≡ zero) × (e₂ e ≡ zero)
zeroCoordinates .zeroError refl = refl , refl

record Contracts (old new : Error2) : Set where
  constructor contracts
  field
    first  : e₁ new ≤ e₁ old
    second : e₂ new ≤ e₂ old

-- Componentwise contraction composes.
contracts-trans : {a b c : Error2} → Contracts a b → Contracts b c → Contracts a c
contracts-trans (contracts a₁ a₂) (contracts b₁ b₂) =
  contracts (≤-trans b₁ a₁) (≤-trans b₂ a₂)
  where
    ≤-trans : {m n k : ℕ} → m ≤ n → n ≤ k → m ≤ k
    ≤-trans z≤n _ = z≤n
    ≤-trans (s≤s p) (s≤s q) = s≤s (≤-trans p q)

-- A simple counterexample to the invalid implication
-- "positive monotone error must eventually become zero":
-- constant error 1 is non-increasing forever and never zero.
constantOne : ℕ → ℕ
constantOne _ = suc zero

constantOneNonIncreasing : (n : ℕ) → constantOne (suc n) ≤ constantOne n
constantOneNonIncreasing n = s≤s z≤n
