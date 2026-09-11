# 12 — Open Questions

- Are required forcing cancellations structurally stable under derivatives?
- Can pressure nonlocal terms be canceled without violating support/regularity assumptions?
- Which hypotheses are indispensable versus redundant?

## Additional open questions from the correction-architecture comparison

**Q1 (Full residual ledger):** Does a pre-2026 commit in the prior corpus contain
an explicit iterative NS residual decomposition of the form
`R_{q+1} − R_q = cross terms` at the full NS-field level (not only in the RBC
shell-model context)?

**Q2 (CycleState unification):** Is there a prior-corpus commit that unifies
the reference section `c₀` with `R(c₀)=0` and the critical-jets language
(`4cdb6a61`) into a single formal object comparable to `ReferenceJetBounds`?

**Q3 (Discrete iteration vs continuous ODE):** The prior K(R,d) coupling
operator yields a continuous projected ODE.  Is there a prior-corpus
construction that discretises this into a step-by-step correction cycle
comparable to `CorrectionStep.CycleState`?

**Q4 (Covariance bookkeeping):** The prior Reynolds-stress / residual-coupling
language is qualitatively similar to the OpenAI covariance-change decomposition.
Is there a prior-corpus commit that explicitly decomposes the stress or covariance
update into axial, radial, and theta components?

**Q5 (MovingMomentBounds):** Does any prior-corpus commit introduce a
moving-moment repair step (an explicit bound on moment quantities updated across
correction cycles), or is only classical momentum conservation present?

**Q6 (StressActivation / TransitionRamp):** The prior spectral cutoff `P_Λ` is
structurally related to the OpenAI activation/ramp machinery.  Is there a
prior-corpus commit that introduces a stress-activation or transition-ramp
function connecting the cutoff to the forcing or correction?

**Q7 (Engineered forcing):** Is there a prior-corpus commit that defines the
correction force as precisely `f_correction = −Residual(u)`, i.e., designed to
cancel the deficit produced by the previous stage?

**Q8 (Tier-2 elevation):** Which of the file-level anchors in `evidence/commits.yaml`
(b033ea87, a992d144, 4cdb6a61, f7f414d2, 730aa849, 2854eaf7) can be elevated
from Tier 2 (reported) to Tier 1 (independently verified) by obtaining diff/tree
exports or notarised mirrors?
