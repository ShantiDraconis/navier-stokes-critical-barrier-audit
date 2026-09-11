# 29 — Test and CI Evidence Record

## Purpose

This document records what has actually been executed, what passed, and what those passes do and do not establish.

---

## GitHub Actions verified run

```text
workflow: Audit integrity
run id: 34636992823
run number: 2
head branch: main
head SHA: cdbe509ed011584484cfaa4085b9e46f3bf5a23c
created: 2026-09-11T19:06:05Z
completed/update: 2026-09-11T19:06:23Z
status: completed
conclusion: success
```

Workflow file:

```text
.github/workflows/audit-integrity.yml
```

The workflow performs:

```text
python -m unittest discover -s tests -p 'test_*.py' -v
python scripts/audit_integrity.py > audit-integrity-report.txt
```

and uploads the integrity report as a workflow artifact.

---

## Executable invariant tests

`tests/test_audit_invariants.py` currently tests:

1. weighted contribution percentages sum to 100%;
2. sensitivity contribution percentages sum to 100%;
3. declared progress is monotone when the error norm contracts;
4. Euclidean norm zero iff all tested coordinates are zero;
5. a pure non-zero periodic mode has zero whole-period average numerically to tolerance;
6. zero denominator/total in the weighted model is rejected;
7. zero denominator in the sensitivity model is rejected.

The corresponding mathematical proofs are in `proofs/audit_bridge_lemmas.md`.

---

## Integrity scanner

`scripts/audit_integrity.py`:

- checks required audit-package files;
- computes SHA-256 over repository files in the checked-out tree;
- reports formalization markers including `sorry`, `axiom`, `Admitted`, `admit`, `oops`, `True`, `False.elim`, `TODO`, `FIXME`;
- reports markers instead of automatically treating every occurrence as invalid, because audit documents legitimately mention placeholders while documenting them.

---

## New provenance-table tests

`tests/test_provenance_tables.py` validates the machine-readable chronology and edge tables added by this audit phase:

- required CSV columns exist;
- chronology timestamps are parseable ISO-8601 where known;
- full SHA fields, when marked verified, have 40 hexadecimal characters;
- provenance edge types belong to the declared vocabulary;
- every edge has source and target identifiers;
- no row silently labels an `OPEN_BRIDGE` as `PROVED`.

---

## What `success` establishes

A successful run establishes that, for the checked commit:

- the Python audit tests executed without failure;
- the required audit-package files known to that version were present;
- the static integrity scanner exited successfully.

## What `success` does NOT establish

It does not establish:

- global regularity of 3D Navier–Stokes;
- existence of a finite-time singularity;
- correctness of every theorem in every source repository;
- absence of placeholders from repositories not checked out by the workflow;
- global priority;
- causal access or derivation by a third party.

These require separate evidence and, for the PDE theorem, separate mathematics.

---

## CI evidence policy

Every future audit claim that depends on executable code should record:

```text
repository
commit SHA
workflow/run ID or local command
runtime/toolchain
exit status
artifact/checksum if produced
scope of what the test proves
scope explicitly not proved
```
