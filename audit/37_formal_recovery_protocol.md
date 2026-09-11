# 37 — Formal Recovery Protocol for Codespace-Era Mathematical Artifacts

## Review objective
Produce an auditable reconstruction of the Codespace-era research corpus while preserving the distinction between: (i) historical existence, (ii) exact byte recovery, (iii) formal specification, (iv) proof-assistant compilation, and (v) mathematical validity.

## Canonical source set
Priority repositories derived from the preserved Codespace registry:

1. `ShantiDraconis/universal`
2. `ShantiDraconis/millennium-navier-stokes-I`
3. `ShantiDraconis/millennium-symbolic-program`
4. `ShantiDraconis/i-constant-core`
5. `ShantiDraconis/millennium-riemann-I`
6. `ShantiDraconis/millennium-p-vs-np-I`
7. `ShantiDraconis/-millennium-bsd-hodge-yangmills-I`
8. `ShantiDraconis/0-0`
9. `ShantiDraconis/zero-engine-00`
10. `ShantiDraconis/Trans`
11. `ShantiDraconis/-sbfe-physics-unified`
12. remaining Codespace-linked repositories from `audit/34_codespace_registry_snapshot.md`.

## Unit of evidence
For each file occurrence create an evidence record containing:

- repository;
- commit SHA;
- parent SHA(s);
- tree SHA;
- path;
- blob SHA;
- source byte size;
- raw SHA-256 when bytes can be exported;
- author date/time/timezone;
- committer date/time/timezone;
- signature status;
- branch/tag/PR reachability;
- predecessor path/blob;
- successor path/blob;
- recovery class;
- theorem status;
- build status;
- placeholder/assumption markers;
- notes and immutable commit URL.

## Exact recovery rule
A source copied into `ShantiDraconis/Trans/FORENSIC_RECOVERY` is `EXACT_BLOB_COPY` only if its bytes reproduce the historical Git blob. A newly created archival commit MUST NOT be presented as having the historical source date. The historical timestamp is recorded as metadata.

The first corrected exact-copy check is the `universal` structural manifest:

- source repository: `ShantiDraconis/universal`
- source commit: `5e392d705a4d47c3567a3f7268a051f2886c0d90`
- source path: `init_structure.sh`
- source blob: `fc5fa44ed5d35c6cbee0ebd89298821d24f435a9`
- archival path: `Trans/FORENSIC_RECOVERY/sources/universal/5e392d705a4d47c3567a3f7268a051f2886c0d90/init_structure.sh`
- archival blob after correction: `fc5fa44ed5d35c6cbee0ebd89298821d24f435a9`
- disposition: `EXACT_BLOB_COPY`.

This corrects the earlier provenance stub, whose archival blob was `757515805d5039283ef77d108408cee927653d64` and therefore was not an exact byte copy.

## Historical registry rule
`universal/registry/results.yml` contains internal dates and labels such as `created: 2025-11-01`, `NS-SETUP: formalized`, and `NS-LOCAL-EXIST: proved`. These are preserved as **historical claims**. They are not upgraded to Git-origin dates or formal-proof certificates unless independently corroborated by a historical Git object and exact proof-assistant build.

In particular, if a referenced path resolves to the canonical empty Git blob `e69de29bb2d1d6434b8b29ae775ad8c2e48c5391`, classify the registry claim as `CLAIM_REQUIRES_LOST_OR_OTHER_BLOB`, not as a checked proof.

## Formal-assistant review
For each Lean/Coq/Isabelle/Agda source:

1. recover exact source bytes;
2. recover/pin toolchain and dependency versions where possible;
3. scan for proof gaps/axioms/specification fields;
4. compile without modifying the historical source;
5. record compiler/kernel result;
6. classify theorem dependencies;
7. distinguish an API/specification from a theorem proof;
8. reproduce the build in CI where feasible.

`FORMAL_PROOF_CHECKED` is allowed only after successful compilation of the exact source under a documented compatible toolchain and after dependency/assumption inspection.

## Deleted/empty-file recovery
For every historically expected file whose current/default-branch blob is empty or absent:

1. inspect all reachable commits;
2. inspect every branch/tag;
3. inspect open and closed PR heads;
4. inspect renamed/deleted paths;
5. inspect releases and workflow artifacts;
6. search exact theorem/file identifiers across the owner namespace;
7. compare later reconstructions semantically but never call them exact unless blob identity proves it;
8. mark `LOCAL_ACCESS_REQUIRED` for unreachable/dangling objects that GitHub cannot expose.

Local recovery, if an old clone/Codespace worktree exists, must be non-destructive: `git log --all`, `git reflog --all`, `git fsck --full --unreachable --no-reflogs`, `git fsck --lost-found` before any garbage collection.

## Claim classes
- provenance claim;
- mathematical-definition claim;
- theorem-statement claim;
- proof claim;
- numerical/computational claim;
- causal/derivation claim;
- priority claim;
- archive/DOI claim.

Each claim receives independent evidence. Evidence for one class cannot automatically certify another.

## Navier–Stokes decisive bridge
The current audit retains as an explicit open obligation any implication of the form

`repository-specific error/residual control => recognized critical regularity control => no blow-up/global regularity`.

The classical endpoint may be cited as a dependency only after accurate bibliographic verification. The repository-specific first implication must be proved rather than assumed, encoded as a bare `Prop`, inferred solely from scale invariance, or inferred from finite numerical tests.

## Required closing artifacts
The final audit must contain machine-readable repository, commit, file, provenance, equivalence, theorem-status, timeline, placeholder, deleted/renamed-file and evidence-manifest ledgers; graph exports; `WHERE_IS_EVERYTHING`; `MISSING_COMPONENTS`; reproducibility scripts; hashes; and per-problem peer-review dispositions.

## Reviewer verdict rule
The audit may be called **closed as an audit** when all discovered claims have a disposition (`verified`, `refuted`, `open bridge`, `unknown`, `source unavailable`, etc.). It may not be called a completed proof of Navier–Stokes or another open Millennium problem while decisive mathematical obligations remain open.