{-# OPTIONS --safe #-}
module MillenniumFinalStructure where

open import Agda.Primitive using (Level; lsuc)
open import Agda.Builtin.String using (String)

data EvidenceStatus : Set where
  VERIFIED REPORTED PENDING-PRIMARY-VERIFICATION MISSING NOT-ESTABLISHED : EvidenceStatus

record ProvenanceAnchor : Set where
  field
    anchor-id : String
    claimed-date : String
    anchor-status : EvidenceStatus
    anchor-note : String

record N7 {ℓ : Level} (A : Set ℓ) : Set ℓ where
  field n1 n2 n3 n4 n5 n6 n7 : A

record NSClosure {ℓ : Level} : Set (lsuc ℓ) where
  field
    State : Set ℓ
    ActualNS DirectionalDepletion SignedFluxControl HighCritical LowL3 UniformL3 ESS Global : State → Set ℓ
    ns→depletion : {s : State} → ActualNS s → DirectionalDepletion s
    depletion→flux : {s : State} → DirectionalDepletion s → SignedFluxControl s
    flux→high : {s : State} → SignedFluxControl s → HighCritical s
    high→low : {s : State} → HighCritical s → LowL3 s
    high+low→uniform : {s : State} → HighCritical s → LowL3 s → UniformL3 s
    uniform→ess : {s : State} → UniformL3 s → ESS s
    ess→global : {s : State} → ESS s → Global s

conditional-global : {ℓ : Level} (M : NSClosure {ℓ}) →
  let open NSClosure M in {s : State} → ActualNS s → Global s
conditional-global M hNS =
  let open NSClosure M
      d = ns→depletion hNS
      f = depletion→flux d
      h = flux→high f
      l = high→low h
      u = high+low→uniform h l
      e = uniform→ess u
  in ess→global e

record ProblemClosure {ℓ : Level} : Set (lsuc ℓ) where
  field
    Primitive Critical Target : Set ℓ
    primitive→bridge : Primitive → Critical
    bridge→target : Critical → Target

problem-conditional : {ℓ : Level} (M : ProblemClosure {ℓ}) →
  let open ProblemClosure M in Primitive → Target
problem-conditional M h =
  let open ProblemClosure M in bridge→target (primitive→bridge h)
