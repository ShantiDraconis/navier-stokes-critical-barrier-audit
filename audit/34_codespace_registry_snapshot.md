# Codespace registry snapshot and recovery map

Status: forensic preservation record
Date of audit capture: 2026-09-11
Owner namespace: ShantiDraconis

## Purpose

This file preserves the Codespace registry information supplied by the account owner and maps each Codespace to the associated GitHub repository or branch. The Codespace containers themselves are ephemeral compute environments. Their Git repositories, commits, trees, blobs, pull-request heads, branch refs, workflow artifacts, and any surviving exported files are the recoverable forensic evidence. Files that existed only inside an uncommitted Codespace filesystem cannot be reconstructed from GitHub unless an independent copy, cache, archive, workflow artifact, backup, or dangling Git object survives.

## Codespaces visible in the owner-provided registry

| Repository | Codespace display name | Branch | Machine | Storage shown | Registry status supplied |
|---|---|---|---:|---:|---|
| ShantiDraconis/Trans | zany garbanzo | main | 16-core | usage report | last used 9 months ago |
| ShantiDraconis/universal | jubilant space umbrella | main | 2-core | 0.76 GB | last used 10 months ago |
| ShantiDraconis/music-harmonic-00 | miniature fortnight | main | 2-core | 0.64 GB | last used 10 months ago |
| ShantiDraconis/music-harmonic-00 | legendary guide | copilot/add-musical-theory-articles | 16-core | 0.64 GB | last used 10 months ago |
| ShantiDraconis/psychology-symbolic-00 | improved dollop | main | 2-core | 0.64 GB | last used 10 months ago |
| ShantiDraconis/zero-engine-00 | cautious succotash | main | 2-core | 0.64 GB | last used 10 months ago |
| ShantiDraconis/0-0 | friendly space broccoli | main | 2-core | usage report | last used 10 months ago |
| ShantiDraconis/olympic-00-chama | scaling couscous | main | 2-core | 0.64 GB | last used 10 months ago |
| ShantiDraconis/Trans | literate pancake | main | 4-core | usage report | last used 10 months ago |
| ShantiDraconis/symbolic-linguistics-00 | zany cod | main | 2-core | 0.64 GB | last used 10 months ago |
| ShantiDraconis/latex-library-global | animated engine | main | 2-core | 0.64 GB | last used 10 months ago |
| ShantiDraconis/-sbfe-physics-unified | cautious tribble | main | 2-core | 0.64 GB | last used 10 months ago |
| ShantiDraconis/-millennium-bsd-hodge-yangmills-I | literate yodel | main | 2-core | 0.64 GB | last used 10 months ago |
| ShantiDraconis/millennium-navier-stokes-I | verbose winner | main | 2-core | 0.64 GB | last used 10 months ago |
| ShantiDraconis/millennium-p-vs-np-I | curly rotary-phone | main | 2-core | 0.64 GB | last used 10 months ago |
| ShantiDraconis/millennium-symbolic-program | crispy cod | main | 2-core | 0.64 GB | last used 10 months ago |
| ShantiDraconis/millennium-riemann-I | redesigned space trout | main | 2-core | 0.64 GB | last used 10 months ago |
| ShantiDraconis/i-constant-core | literate adventure | main | not shown | not shown | last used 10 months ago |

## Directly verified repository evidence

### ShantiDraconis/Trans
GitHub repository metadata currently records creation at `2025-07-04T09:26:14Z`, update at `2025-11-23T04:09:10Z`, push at `2025-11-23T04:09:05Z`, default branch `main`, repository id `1013673995`, and language `Shell`. This is repository metadata, not the Codespace creation timestamp.

### ShantiDraconis/universal
The current tree is a surviving forensic goldmine. It contains the original `init_structure.sh` for `universal-variational-millennium-framework`, a complete directory skeleton spanning Lean 4, Coq, Isabelle/HOL, Python, notebooks, LaTeX, Clay submission plans, spectral operators, gravity/Hawking material, and all six unsolved Millennium problems. Many files in the original skeleton point to the canonical empty Git blob `e69de29bb2d1d6434b8b29ae775ad8c2e48c5391`, proving that their names and intended locations survived while their original bytes were not committed.

The historical import anchor previously recovered is commit `c0db40b7a1291fd8e6df0f7982346ec281b75954`, dated `2025-11-25T23:33:12Z`, message `Importação completa do Codespace`. The later structural import `5e392d...` preserved `init_structure.sh`. These anchors should be treated as evidence of a Codespace-to-Git transfer, not as proof that every uncommitted file inside the Codespace was captured.

## Recovery rule

For every Codespace above the audit must preserve, in order of evidentiary strength:

1. immutable commit SHA, parent SHA(s), tree SHA, author/committer timestamp and timezone, signature status;
2. exact blob SHA and byte length for every relevant source file;
3. raw-byte SHA-256 for exported copies placed in this audit repository;
4. deleted/renamed paths across reachable history;
5. pull-request heads and unmerged branches;
6. releases, workflow artifacts, ZIP/TAR snapshots, and uploaded PDFs;
7. local-only evidence such as `.git/objects`, reflogs, `.vscode`, browser downloads, and old cloned worktrees if the account owner can provide them.

## Important limitation

A Codespace display name, core count, storage figure, or `last used` label is provenance evidence for the environment, but it does not establish mathematical validity. Likewise, a formal-looking file is not a checked proof until its exact source and exact toolchain compile successfully and the theorem does not merely assume the target statement as a `Prop`, `Axiom`, `Hypothesis`, `Parameter`, `sorry`, `Admitted`, or equivalent.
