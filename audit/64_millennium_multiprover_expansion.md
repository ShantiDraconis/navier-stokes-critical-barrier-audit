# Audit 64 — Millennium multi-prover expansion without proof escapes

Status: `CONDITIONAL_FORMALIZATION_PENDING_CI`

Date: `2026-09-13`

This audit expands the proposed multi-problem architecture into Lean, Coq, Isabelle/HOL and Agda while removing `sorry`, `axiom`, `Admitted`, and equivalent proof escapes from the new source.

Open mathematics is not silently promoted to proof. Instead every missing bridge is represented as an explicit field/assumption of a structure, record, or locale. Successful kernel checking therefore certifies the **conditional composition** only.

For Navier–Stokes the explicit ladder is:

```text
actual NS
 -> DirectionalDepletion
 -> SignedFluxControl
 -> HighFrequencyCriticalControl
 -> LowFrequencyL3Control
 -> UniformLinfL3
 -> ESSHypotheses
 -> GlobalRegularity
```

The theorem `conditional_global_regularity` proves the composition with no proof escapes. The field `ns_to_depletion` remains the substantive PDE bridge until replaced by a genuine theorem derived from the Navier–Stokes equations. The same discipline is applied to Riemann, BSD, P vs NP, Hodge and Yang–Mills: each has a primitive-to-critical and critical-to-target interface, not a claim that the bridge is solved.

Poincaré is separated as an externally solved theorem map; this repository does not claim to re-prove Perelman.

Provenance is tracked separately in `audit/evidence/EVIDENCE_STATUS_LEDGER.csv`. Verified Git commit timestamps and public Zenodo metadata are distinguished from user-reported dates that still require primary-source verification.

A successful multi-prover workflow should update the formal status to:

```text
LEAN_CONDITIONAL_STRUCTURE=VERIFIED
COQ_CONDITIONAL_STRUCTURE=VERIFIED
ISABELLE_CONDITIONAL_STRUCTURE=VERIFIED
AGDA_CONDITIONAL_STRUCTURE=VERIFIED
PROOF_ESCAPE_SCAN=PASS
MILLENNIUM_TARGETS=NOT_ESTABLISHED
```

No build result may change the final line without a proof of the missing mathematical bridges.