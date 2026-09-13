# 21 — Integral Multiprover Declaration DAG Protocol

## Scope

The audit now treats the corpus as a declaration-level provenance graph spanning:

- Lean 4 (`.lean`)
- Coq (`.v`)
- Isabelle/HOL (`.thy`)
- Agda (`.agda`)
- Python (`.py`)
- LaTeX (`.tex`)
- Markdown (`.md`, supporting exposition only)

The scanner is `tools/scan_formal_history.py`; the graph builder is
`tools/build_declaration_dag.py`.

## Why declaration-level rather than commit-level

A commit can simultaneously contain:

1. a proved elementary theorem,
2. a new axiom,
3. a conjectural bridge,
4. a Python numerical model,
5. a LaTeX argument,
6. translations of the same abstract statement into several assistants.

Therefore `commit contains proof` is too coarse. Every declaration is a separate
node with its own status.

## Node schema

Each node records:

```text
node_id
repository
commit_sha
author_date
committer_date
tree_sha
path
blob_sha
content_sha256
language
kind
name
normalized_name
status
```

The historical scanner also retains commit parents, signature status, file-level
imports/includes and formal-gap counters.

## Edge schema

Automatic edges are deliberately conservative:

- `SAME_NAME_LINEAGE` — same normalized declaration name reappears historically.
- `CROSS_LANGUAGE_CANDIDATE` — same normalized declaration name appears in a
  different language. This is **not** yet mathematical equivalence.
- file import/include information is retained as metadata and can be promoted to
  `FILE_IMPORT` edges in the review layer.

Mathematical edges require manual or separately verified normalization:

- `DEFINITIONAL_DEPENDENCY`
- `USES_LEMMA`
- `IMPLIES`
- `EQUIVALENT`
- `SPECIALIZES`
- `GENERALIZES`
- `TRANSLATION_EQUIVALENT`
- `AXIOM_DEPENDENCY`
- `NUMERICAL_EVIDENCE_FOR`
- `LATEX_DERIVATION_OF`

No mathematical edge may be inferred merely from filenames, theorem names or
commit messages.

## Proof-status policy

Recommended declaration labels:

- `KERNEL_VERIFIED_STANDARD_DEPS`
- `KERNEL_VERIFIED_NONSTANDARD_DEPS`
- `PROVED_FROM_EXPLICIT_HYPOTHESIS`
- `DECLARED_ASSUMPTION`
- `SORRY_OR_ADMIT`
- `POSTULATE`
- `PAPER_DERIVATION`
- `NUMERICAL_EVIDENCE`
- `EXECUTABLE_MODEL_NOT_PROOF`
- `STATEMENT_ONLY`
- `UNKNOWN_REQUIRES_BUILD`

The automated scanner uses weaker preliminary labels until historical builds and
dependency reports are actually checked.

## First confirmed multiprover anchors

### Riemann anomalous-zero module — 2025-11-25

Commit:

`ad94a4fff4ca6288b16d1a0085e7e75df46f21e6`

Repository:

`millennium-riemann-I`

Commit message explicitly records a cross-language module in Python, Lean, Coq,
Isabelle, Agda, TPTP and LaTeX. This is a high-value provenance anchor for
cross-language statement comparison.

### P vs NP — 2025-11-25

`47244f48d77d9ced0549c44c20b2fe2aa6c5a044` records a P-vs-NP theorem
formalization across Lean4, Coq, Isabelle and Agda. `2cc08bee...` adds formal
foundations. These are provenance anchors, not automatic proof certificates.

### Navier–Stokes — 2025-11-25

`cca881c665f67c67d96a4f84371fb51cd9c858a0` records comprehensive Lean/Coq/
Isabelle formalizations; `ee504cc804e205a9a2e76c6c86689aaea4c6ea84` adds Agda and extended
Python modules. Earlier theorem-level audit already shows that parts of the Lean
regularity/energy layer contained `True`, `sorry`, or later explicit axioms, so
the DAG must attach status per declaration rather than inherit the commit title.

### Unified Local→Global framework — 2025-12-04

Commit:

`1fe08034de23623c23de6437cc54905382165549`

This is especially useful because one commit contains parallel implementations:

- `Framework.lean`
- `Framework.v`
- `Framework.thy`
- `Framework.agda`
- `framework.py`
- Python tests

The recovered Agda source shows the abstract `Framework` record and `HasBridge`
construction. It also explicitly uses `postulate` for base numeric types and for
several Millennium-problem propositions/bridges. At the same time, some bridge
objects are proved trivially by identity/refl because the local and invariant
maps were defined identically. The DAG must therefore separate:

```text
Framework definition
  -> HasBridge definition
  -> master-conjecture-schema (abstract proof from supplied implications)

problem-specific proposition
  -> POSTULATE / assumption

identity bridge
  -> formal proof of the abstract encoding
  != proof of the original Millennium problem
```

This distinction is central to the audit.

### Fragmentation theorem — 2025-12-04

Commit:

`3f099f98160a5dad401fd4f585bbbee637a9e08a`

The same object appears in Lean, Coq, Isabelle, Agda and Python. Historical source
inspection is decisive:

- Lean declares `axiom Fragmentation`.
- Coq declares `Axiom Fragmentation` and comments that it is assumed for now.
- Isabelle uses `axiomatization`.
- Agda uses `postulate Fragmentation`.
- Python's `ClassicalFragmentation.holds_in` operationally returns `True` for a
  classical system and explicitly describes this as an assumption/encoding.

Therefore the correct graph is:

```text
FRAGMENTATION_CLAIM
  ├─ Lean:      DECLARED_ASSUMPTION
  ├─ Coq:       DECLARED_ASSUMPTION
  ├─ Isabelle:  DECLARED_ASSUMPTION
  ├─ Agda:      POSTULATE
  └─ Python:    EXECUTABLE_MODEL_NOT_PROOF
```

not five independent proofs.

This example demonstrates why the cross-language DAG is necessary.

## Example of the required final graph for Navier–Stokes

A final audited chain should look structurally like:

```text
NS equations / solution definitions
        |
        v
energy identity / weak energy inequality
        |
        +--> finite-horizon dissipation bound
        |
        +--> enstrophy evolution
                 |
                 v
          growth / residual estimates
                 |
                 v
spectral projection + unresolved residual
                 |
                 v
abstract coupling hypothesis
                 |
                 v
quantitative_closure_obstruction
 [generic theorem with proof body]
                 |
                 v
NS-specific coupling estimate  <--- MUST BE PROVED
                 |
                 v
critical regularity bridge      <--- MUST BE PROVED
                 |
                 v
L^∞_t L^3_x bound / ESS criterion
                 |
                 v
global regularity / continuation
```

Every arrow must carry its own evidence object: repository, SHA, path, blob,
statement normalization, dependency status and verification result.

## Cross-language equivalence protocol

Two declarations are marked `TRANSLATION_EQUIVALENT` only after comparing:

1. quantified variables and domains;
2. hypotheses;
3. conclusion;
4. equality/inequality direction;
5. constants and normalization conventions;
6. hidden typeclass/context assumptions;
7. whether one version weakened the theorem into a Boolean/model-level claim;
8. whether either version introduced an axiom/postulate.

The audit classification for statement comparison remains:

`IDENTICAL / MATHEMATICALLY_EQUIVALENT / STRUCTURAL_PRECURSOR / CONCEPTUALLY_RELATED / NO_MATCH`.

## Reproducible execution

After cloning every repository that the operator is authorized to inspect:

```bash
python tools/scan_formal_history.py <authorized-clone-1> <authorized-clone-2> ... \
  --out evidence/formal_history.jsonl

python tools/build_declaration_dag.py evidence/formal_history.jsonl \
  --nodes data/declaration_nodes.csv \
  --edges data/declaration_edges.csv
```

Then run language-specific verification on historically important commits:

```text
Lean:     build + #print axioms <declaration>
Coq:      coqc + Print Assumptions <declaration>.
Isabelle: session build + inspect axiomatization/oracles
Agda:     agda type-check + enumerate postulates/primitives
Python:   tests/numerics only; never promote to proof certificate
LaTeX:    proof-dependency extraction/manual mathematical review
```

## Current conclusion

The corpus already contains genuine cross-language provenance anchors. It also
contains cases where the same mathematical-looking claim is represented as an
axiom/postulate in every proof assistant and merely simulated in Python. The DAG
therefore must answer two separate questions:

1. **When and where did the declaration/idea appear?**
2. **At what point, if any, did it become a proof from acceptable dependencies?**

Only the second question can support a formal-proof claim. The first supports
provenance and derivational history.
