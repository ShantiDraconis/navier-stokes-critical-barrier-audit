# 19 — Cross-Problem Provenance Research Map

## Purpose

Open the theorem-level provenance audit beyond Navier–Stokes without converting research claims into proof claims.

The shared historical indeterminacy vocabulary (`I = 0/0`, gap/collapse language, residuals, obstructions, critical boundaries) appears across multiple repositories and Millennium-problem workstreams. This document defines the next search space.

## Confirmed cross-problem source families currently indexed

### Riemann Hypothesis

Repositories/files currently visible include:

- `millennium-riemann-I`
- `Millennium`
- `universal`

Recovered public paths include:

- `docs/connections-to-i-constant-core.md`
- `docs/i-collapse-proof.md`
- `latex/i-collapse-proof.tex`
- `latex/rh-i-symbolic.tex`
- `docs/13-riemann/13-11-conexao-I-RH-millennium.md`

The historical Riemann material explicitly uses `I = 0/0` as a symbolic entity. Some sources themselves state that operations are defined axiomatically rather than constructively. Therefore the audit must separate symbolic-framework provenance from a proof of RH.

### P vs NP

Recovered source family:

- `universal/docs/19-P-vs-NP/19-11-interpretacao-I-em-complexidade.md`
- `Singulariity` Lean/P-vs-NP branches
- `Millennium` formalization work

Audit targets:

- exact first definition of the verifier/solver boundary;
- complexity obstruction/collapse object;
- whether any theorem proves a standard complexity-class separation rather than encoding it as an assumption;
- all `sorry`, `axiom`, `True`, synthetic complexity measures and unproved bridge functions.

### Yang–Mills mass gap

Recovered source family:

- `universal/docs/23-Yang-Mills-gap/23-07-I-e-gap-em-YM.md`
- `src/python/yang_mills_interface.py`
- Millennium/Yang–Mills formalization repositories to be enumerated.

Audit targets:

- rigorous definition of QFT model;
- Hilbert space / Hamiltonian;
- spectral gap statement;
- constructive vs axiomatic uses of `I`;
- exact proof obligations linking symbolic indeterminacy to a positive mass gap.

### Hodge / BSD / Poincaré-related framework

Recovered source family:

- `universal/docs/29-BSD-Hodge-Poincare/29-07-unificacao-das-fronteiras-em-I.md`
- related Millennium repositories to be enumerated.

Audit targets:

- Hodge: algebraic-cycle realization bridge;
- BSD: rank/order-of-vanishing bridge and arithmetic invariants;
- Poincaré: distinguish already-solved classical theorem from independent framework analogies.

## Shared theorem-DAG schema

Every problem will receive nodes with:

```text
problem
claim_id
normalized_statement
repository
commit_sha
parent_sha
author_timestamp
committer_timestamp
path
blob_sha
formal_language
proof_status
assumptions
classical_dependencies
gap_state
meta_I_tag
derivation_parents
derivation_children
build_status
external_equivalence
confidence
```

Allowed `proof_status` values:

```text
PROVED
EXTERNAL_CLASSICAL_THEOREM
AXIOM
SORRY
ADMIT
TRUE_PLACEHOLDER
NUMERICAL_ONLY
OPEN_BRIDGE
CONJECTURAL
```

`meta_I_tag` is documentary metadata only and cannot upgrade proof status.

## Public/private boundary

Public audit evidence should expose:

- repository-relative paths;
- immutable full Git SHAs;
- blob/tree hashes where recovered;
- UTC timestamps;
- normalized formulas;
- theorem names;
- proof-status classifications;
- verification commands;
- public DOI/release anchors.

Do **not** expose merely for provenance:

- local filesystem paths;
- credentials/tokens;
- private email bodies or conversation dumps;
- private URLs or drive identifiers;
- unnecessary personal identifiers;
- unpublished raw source material whose hash is sufficient to establish possession/integrity.

For confidential source evidence, publish only a content hash, evidence ID, date anchor and a statement that the underlying object is retained privately for controlled verification.

## Research order

1. Finish Navier–Stokes theorem DAG.
2. Audit the common `I / gap-state` foundation.
3. Riemann theorem DAG.
4. P vs NP theorem DAG.
5. Yang–Mills theorem DAG.
6. Hodge theorem DAG.
7. BSD theorem DAG.
8. Cross-problem equivalence graph.
9. Multi-prover build and axiom scan.
10. DOI/release freeze of the resulting audit version.

## Scientific constraint

The objective is to establish exactly what was formulated, when, where, how it evolved, and which statements were actually proved. It is not permissible to infer that a Millennium problem was solved merely because an analogous symbolic framework, placeholder, axiom, numerical experiment, or meta-level collapse rule predates later work.
