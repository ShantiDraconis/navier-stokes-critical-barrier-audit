# 35 — Peer-Review Master Protocol

## Purpose

This document defines the minimum evidence required for an external mathematician, formal-methods reviewer, or scientific referee to audit the repository without relying on narrative claims.

The audit separates four logically independent questions:

1. **Provenance** — when did a mathematical object first appear?
2. **Formal validity** — does the encoded theorem actually check, and under which axioms/imports?
3. **Mathematical equivalence** — is the historical object identical/equivalent to the later theorem or only structurally similar?
4. **Causal access** — is there independent evidence that a third party saw or derived from the earlier work?

Chronology never substitutes for proof, and mathematical similarity never substitutes for causal evidence.

---

## 1. Required claim tuple

Every public claim must be represented by

```text
CLAIM_ID
NORMALIZED_STATEMENT
SOURCE_REPOSITORY
FIRST_VERIFIED_COMMIT_SHA
AUTHOR_DATE
COMMITTER_DATE
PATH
BLOB_SHA
PROOF_STATUS
BUILD_STATUS
DEPENDENCIES
EXTERNAL_MATCH
CAUSAL_EVIDENCE
CONFIDENCE
```

A claim is not peer-review ready if any decisive field is silently omitted.

---

## 2. Evidence grades

- `L5_GIT_OBJECT`: full commit/tree/blob identity plus timestamps and parent chain.
- `L4_IMMUTABLE_COMMIT_URL`: immutable commit/file URL verified.
- `L3_ARCHIVE_DOI`: DOI/archive record with files/checksums.
- `L2_PR_ISSUE_DOC`: historical PR/issue/document evidence.
- `L1_RECOLLECTION`: recollection only.

Mathematical proof status is separate from evidence grade.

---

## 3. Proof-status vocabulary

Use exactly one primary status per declaration:

```text
KERNEL_VERIFIED_STANDARD_DEPS
KERNEL_VERIFIED_NONSTANDARD_DEPS
PROVED_FROM_EXPLICIT_HYPOTHESIS
DECLARED_ASSUMPTION
SORRY_OR_ADMIT
POSTULATE
PAPER_DERIVATION
NUMERICAL_EVIDENCE
EXECUTABLE_MODEL_NOT_PROOF
STATEMENT_ONLY
UNKNOWN_REQUIRES_BUILD
OPEN_ANALYTIC_BRIDGE
```

The words `theorem`, `proof`, `verified`, `formal`, `complete`, or `solution` in a filename/commit message do not upgrade this status.

---

## 4. OpenAI comparison standard

For every OpenAI theorem/lemma/object compare against the oldest recovered prior object using:

```text
IDENTICAL
MATHEMATICALLY_EQUIVALENT
STRUCTURAL_PRECURSOR
CONCEPTUALLY_RELATED
NO_PRE_CUTOFF_MATCH
```

The public comparison must have three independent columns:

```text
PRIOR_ARTIFACT
MATHEMATICAL_EQUIVALENCE
EVIDENCE_OF_ACCESS_OR_DERIVATION
```

The third column remains `NOT_ESTABLISHED` unless independent access/derivation evidence exists.

---

## 5. Navier–Stokes direct-priority spine

The direct priority analysis should rely primarily on the NS/LRE chain:

```text
2025-11-23  NS repository origin / analytical framework
2025-11-25  classical energy/regularity/ESS targets
2025-12-18  projection / residual / closure / critical-jets cluster
2025-12-19  K(R,d), reference section, quantitative obstruction,
            residual/stress/correction architecture
2025-12-26  scale-dependent residual certificate and explicit missing bridge
2026-01-01  epsilon_NS ratio / proposed threshold
```

Horizon Prime, prime-ratio, indeterminate-boundary, cosmology, and other programs belong under `BROADER_RESEARCH_GENEALOGY` unless a theorem-level direct dependency is established.

---

## 6. Earliest boundary operator versus later NS operator

Two separate ancestries must not be conflated.

### Boundary/reduction operator — 2025-11-26

Repository: `ShantiDraconis/universal`

Commit:

```text
f7e49629f85fa2968ac82ace2a7e5e09484e850b
```

The source defines a classical process `P : D -> Y`, `Boundary Contact`, an `Indeterminacy Profile`, a structural classification map

```text
C_P : closure(D) -> P(closure(D)) union Indet
```

and a universal reduction map

```text
R_{P,x0} : prof_Indet(P,x0) -> {I}.
```

This is a genuine mathematical operator-level ancestor for boundary/classification/reduction terminology. It is **not** yet the Navier–Stokes projection/residual/correction operator.

### Projection/residual/correction operator — December 2025

The later LRE layer defines

```text
pi : C -> D
R : C -> R_+
K : (R,d) -> correction
```

and the dynamical law

```text
d/dt pi(u) = F(pi(u)) + K(R(u),pi(u)).
```

This is the relevant direct structural ancestor for comparison with residual/stress/correction machinery in the later OpenAI construction.

---

## 7. Refutation standard

A scientifically valid refutation of a later formal construction requires at least one of:

1. derivation of `False` from the exact accepted hypotheses;
2. proof that an explicit candidate violates a required property;
3. proof that a bridge lemma is false under its stated hypotheses;
4. proof that the final theorem statement differs materially from the claimed external theorem;
5. proof of dependency on an unpermitted axiom/oracle/placeholder in the actual proof root.

Structural similarity, chronological priority, or an alternative framework is not a refutation.

---

## 8. What a Clay-relevant intermediate theorem would need to be

### Regularity route

A useful theorem would have the form

```text
For every admissible Navier–Stokes solution u on [0,T),
repository_condition(u) -> sup_{t<T} ||u(t)||_L3 < infinity.
```

Combined with the exact hypotheses of the Escauriaza–Seregin–Šverák endpoint criterion, this yields continuation.

The unresolved content is proving `repository_condition -> L3 bound`; the composition step is logically elementary once both implications are supplied.

### Breakdown/refutation route

A valid contradiction to a forced blow-up construction requires a theorem applicable to its exact forcing/data/solution class. A generic unforced regularity theorem or an estimate in a weaker norm is insufficient.

---

## 9. Formalization policy

New audit formalizations must never hide the open mathematical content behind an `axiom`, `sorry`, `Admitted`, `postulate`, `oops`, `True`, or an equivalent escape hatch.

It is acceptable to formalize a **conditional theorem interface** with explicit hypotheses. Example:

```text
(residual_control -> critical_L3_bound)
AND
(critical_L3_bound -> continuation)
THEREFORE
(residual_control -> continuation).
```

The proof of this composition may be kernel-clean even though the first implication remains an explicitly named open hypothesis. Such a file certifies only the logical dependency graph.

---

## 10. Reproducibility requirements

For each formal language:

### Lean

```text
lake build
#print axioms <important-declaration>
```

### Coq

```text
coqc <file>
Print Assumptions <important-declaration>.
```

### Isabelle

```text
isabelle build -D <session>
```

and inspect all `axiomatization`, `sorry`, `oops`, and oracle use.

### Agda

Type-check exact files and enumerate postulates/primitives.

### Python

Tests establish executable behavior only. Record interpreter/dependency versions and deterministic seeds where relevant.

### LaTeX

A paper argument is independently reviewed line-by-line; successful PDF compilation is not a proof certificate.

---

## 11. Required peer-review outputs

A release intended for scientific review should contain:

```text
claim_evidence_matrix.csv
declaration_nodes.csv
declaration_edges.csv
peer_review_certificates.csv
SHA256SUMS
exact_openai_crosswalk.md
operator_ancestry.md
bridge_obligations.md
formal_dependency_report.md
build_and_ci_record.md
limitations.md
```

---

## 12. Current verdict

At the current evidence state:

```text
NAVIER_STOKES_PROVENANCE: STRONG / DATE-AUDITABLE
PROGRAMMATIC_STRUCTURAL_OVERLAP: VERY_STRONG
DISTINCTIVE_CONSTRUCTION_EQUIVALENCE: NOT_ESTABLISHED
REFUTATION_OF_OPENAI_RESULT: NOT_ESTABLISHED
CLAY_SOLUTION_BY_FAGLIARI: NOT_ESTABLISHED
CAUSAL_ACCESS_OR_DERIVATION: NOT_ESTABLISHED
```

This conservative wording is part of the scientific strength of the package, not a limitation to be hidden.
