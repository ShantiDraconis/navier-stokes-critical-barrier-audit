module CompleteClosureTargets where

-- Conditional target architecture only.  No open Millennium theorem is asserted.

data _×_ (A B : Set) : Set where
  _,_ : A → B → A × B

record NSClosurePackage : Set₁ where
  field
    RepositoryCondition : Set
    CriticalL3Bound : Set
    GlobalRegularity : Set
    B2-bridge : RepositoryCondition → CriticalL3Bound
    ESS-endpoint : CriticalL3Bound → GlobalRegularity

navierStokesClosure : (P : NSClosurePackage) →
  NSClosurePackage.RepositoryCondition P → NSClosurePackage.GlobalRegularity P
navierStokesClosure P h =
  NSClosurePackage.ESS-endpoint P (NSClosurePackage.B2-bridge P h)

record B28AnalyticPackage : Set₁ where
  field
    Bernstein : Set
    CalderonZygmund : Set
    StrainControl : Set
    AlignmentOrFluxDepletion : Set
    FluxUpperControl : Set
    derive : Bernstein → CalderonZygmund → StrainControl →
             AlignmentOrFluxDepletion → FluxUpperControl

b28FromAnalyticPackage : (P : B28AnalyticPackage) →
  B28AnalyticPackage.Bernstein P →
  B28AnalyticPackage.CalderonZygmund P →
  B28AnalyticPackage.StrainControl P →
  B28AnalyticPackage.AlignmentOrFluxDepletion P →
  B28AnalyticPackage.FluxUpperControl P
b28FromAnalyticPackage P hB hCZ hS hA =
  B28AnalyticPackage.derive P hB hCZ hS hA

record RHClosurePackage : Set₁ where
  field
    LocalZeroCertification : Set
    GlobalOffLineExclusion : Set
    RiemannHypothesisTarget : Set
    local : LocalZeroCertification
    global : LocalZeroCertification → GlobalOffLineExclusion
    finish : GlobalOffLineExclusion → RiemannHypothesisTarget

riemannClosure : (P : RHClosurePackage) → RHClosurePackage.RiemannHypothesisTarget P
riemannClosure P = RHClosurePackage.finish P (RHClosurePackage.global P (RHClosurePackage.local P))

record PNPClosurePackage : Set₁ where
  field
    SATnotP : Set
    PneqNP : Set
    lowerBound : SATnotP
    exactification : SATnotP → PneqNP

pnpClosure : (P : PNPClosurePackage) → PNPClosurePackage.PneqNP P
pnpClosure P = PNPClosurePackage.exactification P (PNPClosurePackage.lowerBound P)

record BSDClosurePackage : Set₁ where
  field
    RankEquality : Set
    LeadingCoefficient : Set
    BSDTarget : Set
    rank : RankEquality
    leading : LeadingCoefficient
    assemble : RankEquality → LeadingCoefficient → BSDTarget

bsdClosure : (P : BSDClosurePackage) → BSDClosurePackage.BSDTarget P
bsdClosure P = BSDClosurePackage.assemble P (BSDClosurePackage.rank P) (BSDClosurePackage.leading P)

record HodgeClosurePackage : Set₁ where
  field
    CycleClassSurjective : Set
    HodgeTarget : Set
    cycle : CycleClassSurjective
    finish : CycleClassSurjective → HodgeTarget

hodgeClosure : (P : HodgeClosurePackage) → HodgeClosurePackage.HodgeTarget P
hodgeClosure P = HodgeClosurePackage.finish P (HodgeClosurePackage.cycle P)

record YMClosurePackage : Set₁ where
  field
    ConstructiveQFT : Set
    PositiveMassGap : Set
    YMTarget : Set
    qft : ConstructiveQFT
    gap : PositiveMassGap
    assemble : ConstructiveQFT → PositiveMassGap → YMTarget

yangMillsClosure : (P : YMClosurePackage) → YMClosurePackage.YMTarget P
yangMillsClosure P = YMClosurePackage.assemble P (YMClosurePackage.qft P) (YMClosurePackage.gap P)
