module ClosureTargetTree where

open import Agda.Builtin.Sigma
open import Agda.Builtin.Unit

record _×_ (A B : Set) : Set where
  constructor _,_
  field fst : A; snd : B
open _×_ public

record NSChain : Set₁ where
  field
    RepositoryCondition : Set
    CriticalControl : Set
    SmoothGlobal : Set
    B28B210 : RepositoryCondition → CriticalControl
    B212 : CriticalControl → SmoothGlobal
open NSChain

NS-closure : (P : NSChain) → RepositoryCondition P → SmoothGlobal P
NS-closure P h = B212 P (B28B210 P h)

record RHTarget : Set₁ where
  field
    LocalArbRouche : Set
    ExplicitFormula : Set
    GlobalExclusion : Set
    RH : Set
    globalize : LocalArbRouche → ExplicitFormula → GlobalExclusion
    conclude : GlobalExclusion → RH
open RHTarget

RH-closure : (P : RHTarget) → LocalArbRouche P → ExplicitFormula P → RH P
RH-closure P hL hE = conclude P (globalize P hL hE)

record PNPTarget : Set₁ where
  field
    CookLevin : Set
    SATnotP : Set
    PneqNP : Set
    concludePNP : CookLevin → SATnotP → PneqNP
open PNPTarget

PNP-closure : (P : PNPTarget) → CookLevin P → SATnotP P → PneqNP P
PNP-closure P hC hS = concludePNP P hC hS

record BSDTarget : Set₁ where
  field
    RankBridge : Set
    LeadingCoefficientBridge : Set
    BSD : Set
    concludeBSD : RankBridge → LeadingCoefficientBridge → BSD
open BSDTarget

BSD-closure : (P : BSDTarget) → RankBridge P → LeadingCoefficientBridge P → BSD P
BSD-closure P hR hL = concludeBSD P hR hL

record HodgeTarget : Set₁ where
  field
    CycleBridge : Set
    Hodge : Set
    concludeHodge : CycleBridge → Hodge
open HodgeTarget

Hodge-closure : (P : HodgeTarget) → CycleBridge P → Hodge P
Hodge-closure P h = concludeHodge P h

record YMTarget : Set₁ where
  field
    ConstructiveQFT : Set
    OsterwalderSchrader : Set
    PositiveGap : Set
    YMEndpoint : Set
    concludeYM : ConstructiveQFT → OsterwalderSchrader → PositiveGap → YMEndpoint
open YMTarget

YM-closure : (P : YMTarget) → ConstructiveQFT P → OsterwalderSchrader P → PositiveGap P → YMEndpoint P
YM-closure P hQ hOS hG = concludeYM P hQ hOS hG

record ResolutionOperator : Set₁ where
  field
    X : Set
    Admissible : X → Set
    DefectClosed : X → Set
    NativeControl : X → Set
    Endpoint : X → Set
    Correct : X → X
    preserves : (x : X) → Admissible x → Admissible (Correct x)
    bridge : (x : X) → Admissible x → DefectClosed x → NativeControl x
    close : (x : X) → NativeControl x → Endpoint x
open ResolutionOperator

abstract-resolution-law : (R : ResolutionOperator) → (x : X R) →
  Admissible R x → DefectClosed R x → Endpoint R x
abstract-resolution-law R x hA hD = close R x (bridge R x hA hD)
