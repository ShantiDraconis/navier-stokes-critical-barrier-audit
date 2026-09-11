# 27 — Reproducibility Protocol

An independent reviewer should be able to reproduce the audit without relying on narrative assertions.

## A. Repository acquisition

For every repository in `evidence/repositories.yaml`:

```bash
git clone --mirror <repository-url> <repo>.git
cd <repo>.git
git fsck --full
git show-ref
git for-each-ref --format='%(refname) %(objectname) %(creatordate:iso-strict)'
```

For private repositories the reviewer must have authorized access.

## B. Complete reachable-history inventory

```bash
git rev-list --all --parents --timestamp > all-commits.txt
git log --all --date=iso-strict --pretty=fuller --name-status > full-log.txt
git log --all --diff-filter=ADR --summary > path-history.txt
```

Do not use only the current `main` branch.

## C. Per-commit evidence

For each significant commit:

```bash
git cat-file -p <commit-sha>
git show --format=fuller --raw <commit-sha>
git ls-tree -r <commit-sha>
```

Record:

```text
full commit SHA
parent SHA(s)
tree SHA
author timestamp + timezone
committer timestamp + timezone
path
blob SHA
immutable GitHub commit/blob URL
```

## D. Raw-byte SHA-256

For every important historical file:

```bash
git show <commit>:<path> > exact-file.bin
sha256sum exact-file.bin
```

Git blob SHA and SHA-256 are separate identifiers and must never be conflated.

## E. Search historical formalizations

Lean:

```bash
grep -RInE '\bsorry\b|\baxiom\b|False\.elim|\bby\?|\bexact\?' .
```

Coq:

```bash
grep -RInE '\bAdmitted\b|\badmit\b|\bAxiom\b|\bParameter\b|\bHypothesis\b' .
```

Isabelle:

```bash
grep -RInE '\bsorry\b|\boops\b|\baxiomatization\b' .
```

The scanner is a triage tool. Every occurrence must be interpreted in context.

## F. Compile exact formal source

Use the toolchain pinned by the historical repository if available. If none is pinned, record the selected version and classify the result as a modern reproduction rather than exact historical reproduction.

A successful build proves only that the encoded theorem checks under its imports/axioms. Compare the encoded statement to the intended classical theorem separately.

## G. Run audit tests

From this repository root:

```bash
python -m unittest discover -s tests -p 'test_*.py' -v
python scripts/audit_integrity.py
```

GitHub Actions repeats these checks on push/PR.

## H. Verify the error-decomposition identities

Check independently:

```text
E = Σ_i w_i g_i(Δ_i)
C_i = 100 w_i g_i(Δ_i)/E
Σ_i C_i = 100, E>0.
```

Then verify separately that the chosen `w_i`, `g_i`, `Δ_i` have documented semantics. The normalization identity does not validate the calibration.

## I. Verify the error-coordinate model

Check:

```text
ε(P) ∈ R_+^n
||ε||₂ = sqrt(Σ ε_i²)
||ε||₂=0 iff ε_i=0 for every i.
```

Then separately search for the theorem connecting `ε=0` to the classical target statement.

## J. Verify phase claims

For every phase-cancellation claim identify:

```text
function/mode
frequency
integration interval
measure
periodicity/ergodicity hypothesis
norm in which cancellation is claimed
PDE quantity controlled after cancellation
```

Do not infer general cancellation from a single Fourier-mode identity.

## K. Navier–Stokes classical bridge

For every proposed proof path produce a dependency graph ending in an accepted regularity or singularity criterion. Every edge must be either:

```text
CLASSICAL_THEOREM
PROVED_LEMMA
FORMAL_PROOF_CHECKED
EXPLICIT_ASSUMPTION
OPEN_BRIDGE
```

A proof path containing `OPEN_BRIDGE` is not complete.

## L. Archive verification

For each Zenodo record retrieve authoritative metadata/API response and save:

```text
record id
concept record id
DOI
publication date
version
creators
file names
file sizes
checksums
related identifiers
```

Download each file and SHA-256 it. Compare to historical Git file bytes.

## M. Reproducibility verdict

Use exactly one:

- `REPRODUCED_EXACTLY`
- `REPRODUCED_WITH_MODERN_TOOLCHAIN`
- `PARTIALLY_REPRODUCED`
- `SOURCE_AVAILABLE_NOT_REPRODUCED`
- `SOURCE_UNAVAILABLE`
- `FAILED_REPRODUCTION`

Never convert a failed reproduction into a mathematical refutation without determining why it failed.
