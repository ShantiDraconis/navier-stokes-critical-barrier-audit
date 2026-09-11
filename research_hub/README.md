# Research Hub / Mathematical Audit Operating Environment

This directory turns the audit corpus into a research environment rather than a collection of disconnected manuscripts.

## Design rule

Every output must carry an epistemic status. A calculator may return a number, but it must also say whether that number is:

- `MATHEMATICAL_DEFINITION`
- `MATHEMATICAL_DERIVATION`
- `MODEL_DERIVED`
- `COMPUTATIONAL_EVIDENCE`
- `DIAGNOSTIC_NOT_REGULARITY_THEOREM`
- `MODEL_CLASSIFICATION_ONLY`
- `FORMAL_PROOF_CHECKED`
- `OPEN_BRIDGE`

No UI or export layer may silently convert a model result into a theorem claim.

## Architecture

```text
Git/Zenodo evidence
       ↓
provenance engine
       ↓
claim registry ───────────────┐
       ↓                      │
theorem-status engine         │
       ↓                      │
mathematical calculators      │
       ↓                      │
counterexample/test engine    │
       ↓                      │
formal adapters               │
Lean / Coq / Isabelle / Agda  │
       ↓                      │
CI/kernel results             │
       └──────────────→ evidence graph
                              ↓
                     manuscript/export layer
```

## Initial calculator

`calculator.py` implements:

- structural percentage normalization;
- sensitivity × gap percentages;
- Euclidean error norm;
- norm-reduction progress;
- Navier–Stokes diagnostic ratio;
- exact R³ NS scaling factors for the two L² terms in the ratio;
- threshold classification with explicit non-theorem status.

## Next modules

```text
provenance.py       # query SHA/date/blob/DOI evidence
claims.py           # typed claim objects
bridges.py          # dependency graph and OPEN_BRIDGE tracker
counterexamples.py  # falsification library
ns_scaling.py       # symbolic dimensional/scaling calculations
formal_runner.py    # prover/toolchain execution records
archive.py          # Zenodo/Git checksum mapping
manuscript.py       # generate tables/appendices from evidence ledgers
cli.py              # unified command-line interface
```

## Why this architecture is useful

The project contains history, mathematics, numerical models, proof-assistant code and archival evidence. Keeping them in one typed research environment makes contradictions visible and prevents a later numerical or formal result from losing its provenance/status metadata.
