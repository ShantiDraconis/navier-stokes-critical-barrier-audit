# 02 — Exact Hypotheses

Extract hypotheses from the external construction and map each to explicit mathematical assumptions before testing.

## Hypotheses extracted from OpenAI CorrectionStep.lean

The correction-cycle architecture in `NavierStokes/CorrectionStep.lean` rests on
the following hypotheses, extracted from the module description and imports:

**H1 (Cycle state decomposition):** The solution state is partitioned as
`CycleState = (field m, covariance W, residual estimate)`.  Each cycle updates
all three components.

**H2 (Additive field increment):** The new field is `m_new = updated(m, h)`,
i.e., an additive increment `h` is applied.  The residual difference is
computed as `R(m+h, W+X) − R(m, W)`.

**H3 (Additive covariance increment):** The new covariance is `W_new = W + X`.
The covariance change decomposes into axial, radial, and theta components.

**H4 (Residual difference decomposition):** The difference
`R(m+h, W+X) − R(m, W)` decomposes as
`fastTime(h) + remainder(m,h) + covarianceChange(X)`.
This is asserted as an exact bookkeeping identity.

**H5 (MovingMomentBounds compatibility):** The correction cycle is compatible
with pre-established bounds on moving moments.  Module import:
`NavierStokes.MovingMomentBounds`.

**H6 (MeanIncrementBounds):** The mean increment `h` satisfies bounds from
`NavierStokes.MeanIncrementBounds`.

**H7 (DefectIncrementBounds):** The defect component of the increment satisfies
`NavierStokes.DefectIncrementBounds`.

**H8 (GaugeDebtIncrement accounting):** There is a gauge-debt quantity tracked
across cycles; module `NavierStokes.GaugeDebtIncrement`.

**H9 (SignedWaveUpdate):** Wave components are updated with a sign convention;
module `NavierStokes.SignedWaveUpdate`.

**H10 (LocalRankDefect):** Local rank-defect conditions constrain the
admissible correction increments; module `NavierStokes.LocalRankDefect`.

**H11 (Reference jets and carrier jets):** The construction uses
`NavierStokes.ReferenceJetBounds` and `ActualCurrentCarrierJets.lean` with
`CorrectionStep.CycleState` and `SameCarrier` conditions.

## Mapping to prior corpus

| Hypothesis | Prior-corpus match | Status |
|---|---|---|
| H1: cycle state as (field, covariance, residual) | `K(R,d)` projected ODE: continuous (state, residual) pair | STRUCTURAL — continuous vs discrete |
| H2: `m_new = m + h` | `φ_new = φ + εv`, `P_Λ(v)=0` (`2854eaf7`) | STRONG STRUCTURAL |
| H3: `W_new = W + X` | Reynolds stress = residual coupling; stress tensor update | STRUCTURAL |
| H4: residual difference decomposition | No exact matching decomposition found | NOT_FOUND |
| H5–H10: MovingMoments / GaugeDebt / SignedWave / LocalRank | No prior-corpus match found | NO_MATCH |
| H11: reference jets + carrier jets unified | `c₀` (reference section, `730aa849`) + critical jets (`4cdb6a61`) exist separately | SEPARATE_PRECURSORS |
