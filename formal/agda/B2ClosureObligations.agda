module B2ClosureObligations where

open import Agda.Primitive using (Level; lzero)
open import Agda.Builtin.Sigma using (Σ; _,_)

-- Logical target layer only. PDE obligations are explicit function arguments.

record Downstream
  (NS Dep Flux Dom Decay High Low Crit ESS Tinf Smooth : Set) : Set₁ where
  field
    dep→flux : Dep → Flux
    flux→dom : Flux → Dom
    dom→decay : Dom → Decay
    decay→high : Decay → High
    ns→low : NS → Low
    reconstruct : High → Low → Crit
    essMap : Crit → ESS
    continuation : ESS → Σ Tinf (λ _ → Smooth)

open Downstream

closeViaGeometric :
  {NS Dep Flux Dom Decay High Low Crit ESS Tinf Smooth : Set} →
  (NS → Dep) →
  Downstream NS Dep Flux Dom Decay High Low Crit ESS Tinf Smooth →
  NS → Σ Tinf (λ _ → Smooth)
closeViaGeometric route d hNS =
  continuation d
    (essMap d
      (reconstruct d
        (decay→high d
          (dom→decay d
            (flux→dom d
              (dep→flux d (route hNS)))))
        (ns→low d hNS)))

closeViaVectorTensor :
  {NS Dep Flux Dom Decay High Low Crit ESS Tinf Smooth : Set} →
  (NS → Flux) →
  Downstream NS Dep Flux Dom Decay High Low Crit ESS Tinf Smooth →
  NS → Σ Tinf (λ _ → Smooth)
closeViaVectorTensor route d hNS =
  continuation d
    (essMap d
      (reconstruct d
        (decay→high d
          (dom→decay d
            (flux→dom d (route hNS))))
        (ns→low d hNS)))

closeViaEnstrophy :
  {NS Dep Flux Dom Decay High Low Crit ESS Tinf Smooth : Set} →
  (NS → Dom) →
  Downstream NS Dep Flux Dom Decay High Low Crit ESS Tinf Smooth →
  NS → Σ Tinf (λ _ → Smooth)
closeViaEnstrophy route d hNS =
  continuation d
    (essMap d
      (reconstruct d
        (decay→high d
          (dom→decay d (route hNS)))
        (ns→low d hNS)))
