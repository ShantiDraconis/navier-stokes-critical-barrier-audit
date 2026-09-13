module B2_8_AlignmentTarget where

-- Agda target layer: logical dependency graph only.  Analytic inequalities
-- remain certificates supplied by a future real-analysis formalization.

data _×_ (A B : Set) : Set where
  _,_ : A → B → A × B

record B28Certificates : Set₁ where
  field
    Bernstein : Set
    CalderonZygmund : Set
    Sobolev : Set
    StrainControl : Set
    AlignmentConstraint : Set
    SignedFluxBound : Set
    deriveSignedFlux :
      Bernstein → CalderonZygmund → Sobolev → StrainControl →
      AlignmentConstraint → SignedFluxBound

b28-close : (C : B28Certificates) →
  B28Certificates.Bernstein C →
  B28Certificates.CalderonZygmund C →
  B28Certificates.Sobolev C →
  B28Certificates.StrainControl C →
  B28Certificates.AlignmentConstraint C →
  B28Certificates.SignedFluxBound C
b28-close C = B28Certificates.deriveSignedFlux C

record NSChain : Set₁ where
  field
    RepositoryCondition : Set
    FluxBound : Set
    DifferentialDecay : Set
    CriticalL3Bound : Set
    ESSEndpoint : Set
    GlobalSmoothness : Set
    b28 : RepositoryCondition → FluxBound
    b24 : FluxBound → DifferentialDecay
    b210 : DifferentialDecay → CriticalL3Bound
    b212 : CriticalL3Bound → ESSEndpoint
    ess : ESSEndpoint → GlobalSmoothness

ns-chain-close : (C : NSChain) → NSChain.RepositoryCondition C → NSChain.GlobalSmoothness C
ns-chain-close C h =
  NSChain.ess C
    (NSChain.b212 C
      (NSChain.b210 C
        (NSChain.b24 C
          (NSChain.b28 C h))))
