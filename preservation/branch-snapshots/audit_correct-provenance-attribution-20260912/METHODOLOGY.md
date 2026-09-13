# Methodology

1. Extract external claims and exact hypotheses.
2. Separate classical results from derived consequences and conjectures.
3. Build provenance graph with explicit evidence quality and `UNKNOWN` fields where needed.
4. Build concept-first-occurrence forensic table (`evidence/forensic_first_occurrence.csv`).
5. Test critical \(L^3\) compatibility and ESS blowup alternative consistency.
6. Test energy-concentration scaling constraints.
7. Test forcing smoothness and cancellation requirements.
8. Test pressure nonlocality and elliptic compatibility.
9. Record only three outcomes per branch: CONSISTENT, CONTRADICTION FOUND, or UNRESOLVED.

## Audit principle

No contradiction is declared without explicit derivation of both \(A\) and \(\neg A\) from the same hypothesis set \(H_1,\dots,H_n\), with traceable references.

## Forensic principle

Chronology and causality are separate propositions. Priority evidence can establish predating records but cannot by itself establish derivation by third parties.

## Next comparison step

Extract definition-level objects from external and prior Lean trees, then compare object-by-object with formula-level references (not names only).
Use `python/lean_object_extract.py` as the first pass for object inventory generation.
