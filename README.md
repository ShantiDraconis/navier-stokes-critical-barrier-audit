# Critical-Barrier Audit of a Proposed Finite-Time Navier–Stokes Breakdown

This repository provides an independent mathematical and machine-auditable analysis of a proposed finite-time breakdown construction for the three-dimensional Navier–Stokes equations.

It investigates compatibility with critical \(L^3\) regularity, energy bounds, spatial concentration, smooth forcing, pressure nonlocality, and scale-critical estimates.

**Status:** No refutation is claimed unless and until a contradiction is established rigorously.

## Repository Scope

- Post-publication audit of a proposed finite-time breakdown mechanism
- Separated priority record and mathematical audit process
- Reproducible track for symbolic, formal, and numerical checks

## Logical Pipeline

```text
PUBLIC CONSTRUCTION
        |
        v
Extract exact hypotheses
        |
        |-------------|
        v             v
   Energy test    L3 / ESS test
        |             |
        |------|------|
               v
      Concentration regime
               |
        |------|------|
        v             v
  Pressure test   Forcing test
        |             |
        |------|------|
               v
      Formal verification
               |
       |-------|--------|
       v                v
  CONSISTENT       CONTRADICTION
                        |
                        v
                  REFUTATION
```

## Key Files

- `PRIORITY.md`: historical precedence record
- `CLAIMS.md`: auditable claims ledger and status
- `TIMELINE.md`: chronology of prior and new work
- `audit/`: claim-by-claim verification work
- `theory/`: mathematical framework notes
- `lean/`: formal verification scaffold
- `python/`: numerical/constraint checks
- `evidence/`: provenance material and integrity records
