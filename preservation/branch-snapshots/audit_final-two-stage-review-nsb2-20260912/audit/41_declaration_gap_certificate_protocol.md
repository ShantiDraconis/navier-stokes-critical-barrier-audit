# Declaration-level historical gap certification protocol

Status: normative audit protocol.

## Objective

For every historical formal declaration that contains or inherits a visible proof-gap marker, reconstruct a reproducible certificate for:

`first Git object -> declaration-local gap -> premises -> declaration -> dependents -> attempted resolution -> exact build result`.

The protocol deliberately distinguishes provenance from mathematical validity. A timestamped declaration can establish possession/publication of a statement; it cannot by itself establish that the statement is true.

## Exact pipeline

### Stage A — historical discovery

Run `tools/scan_sorry_certificates.py` against authorized full Git clones, using `git log --all --reverse`. For each Lean/Coq/Isabelle/Agda declaration record:

- repository alias;
- relative path;
- declaration kind/name;
- first seen full SHA and timestamp;
- first declaration-local gap SHA and timestamp;
- first later source-clean SHA, if any;
- latest SHA, blob SHA and declaration-block SHA-256;
- exact line span in that historical blob;
- marker counts.

Absolute local paths and source bodies are excluded from the public certificate ledger.

### Stage B — declaration-locality

A `sorry` elsewhere in a file must not contaminate an unrelated declaration. Certificates are based on the declaration block, not file-global marker counts.

### Stage C — DAG

The automated DAG emits only conservative `TEXTUAL_REFERENCE_CANDIDATE` edges. These are candidate premise edges, not semantic proof-dependency claims. Exact prover dependency extraction is a later certificate layer.

Required semantic edge types after review:

- `PREMISE_OF`;
- `USES_EXTERNAL_THEOREM`;
- `REFINES`;
- `CORRECTS_SPECIFICATION_OF`;
- `CONDITIONAL_ON`;
- `DEPENDENT_OF`.

### Stage D — fixed resolution order

Every unresolved declaration is attempted in this order:

1. `DIRECT_PROOF` — prove from definitions and already certified local premises.
2. `LIBRARY_OR_EXTERNAL_THEOREM` — discharge with Mathlib or an explicitly cited classical theorem, mapping every hypothesis.
3. `SPECIFICATION_CORRECTION` — if the historical statement is false, ill-typed, non-transitive, undefined at a denominator, or otherwise inconsistent, replace it with the strongest true statement and preserve the original as provenance.
4. `EXPLICIT_TYPED_HYPOTHESIS` — if the remaining content is genuinely open/deep, expose it as an assumption/interface. Never replace `sorry` with a hidden axiom while labeling the result proved.

`tools/classify_gap_obligations.py` creates the review ledger but cannot upgrade mathematical proof status automatically.

## Required final statuses

- `PROVED`: exact object compiled and theorem has no unresolved local/nonstandard assumptions in its dependency closure.
- `CONDITIONAL`: proof is valid from an explicit hypothesis that is not discharged.
- `EXTERNAL_THEOREM`: proof delegates to a named external theorem whose hypotheses have been mapped.
- `OPEN_BRIDGE`: decisive mathematical implication remains unproved.
- `INCONSISTENT_SPECIFICATION`: historical statement is false or malformed; certificate must include a counterexample or specification diagnosis and the corrected statement.

Additional source/build statuses may be used internally, but they must not be confused with the five mathematical outcomes above.

## Certificate schema

Each certificate must ultimately contain:

`certificate_id, repository, path, declaration, language, kind, first_seen_sha, first_seen_date, first_gap_sha, first_gap_date, first_source_clean_after_gap_sha, latest_sha, latest_blob_sha, latest_block_sha256, premise_ids, dependent_ids, resolution_attempts, corrected_statement, typed_hypothesis, external_reference, proof_status, exact_build_commit, exact_build_result, prover_version, certificate_sha256`.

## Counterexample rule

A false historical specification is valuable audit evidence. Example: fixed-epsilon closeness `|x-y| < epsilon` is not transitive. The valid graded law is

`Close epsilon x y AND Close delta y z -> Close (epsilon + delta) x z`.

The certificate must therefore be `INCONSISTENT_SPECIFICATION -> CORRECTED_SPECIFICATION`, not a fabricated proof of transitivity.

## Millennium/open-problem rule

Statements equivalent to unresolved Millennium content, independence assertions requiring model-theoretic machinery, or universal analytic bridges are not automatically solvable by repository completion. The software layer can make their exact assumptions, domains, dependency graph, counterexample tests, and downstream consequences complete while leaving the mathematical frontier explicitly `OPEN_BRIDGE` or `CONDITIONAL`.

## Reproduction commands

Example:

```bash
python tools/scan_sorry_certificates.py /authorized/repoA /authorized/repoB \
  --certificates evidence/gap_certificates.csv \
  --nodes evidence/gap_nodes.csv \
  --edges evidence/gap_edges.csv

python tools/classify_gap_obligations.py evidence/gap_certificates.csv \
  --out evidence/gap_resolution_obligations.csv

python -m unittest tests.test_gap_certificate_pipeline -v
```

The example local paths are invocation placeholders only and must never be copied into the public evidence files.

## What constitutes completion

The project is not complete merely when textual `sorry` count reaches zero. Completion requires, declaration by declaration:

1. immutable provenance certificate;
2. normalized statement;
3. premise/dependent DAG;
4. justified mathematical status;
5. exact prover build certificate for formal proofs;
6. explicit assumption closure;
7. no status laundering from `OPEN_BRIDGE`/`CONDITIONAL` to `PROVED`.

This is the standard to use for the historical corpus and for all new formal classes.