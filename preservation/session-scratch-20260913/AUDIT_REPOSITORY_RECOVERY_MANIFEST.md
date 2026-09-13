# Recovery manifest — navier-stokes-critical-barrier-audit

Date of reconstruction: 2026-09-13 UTC

## Incident statement

The historical Git repository was not mounted in runtime
`/workspace/scratch/e81d06aa5ae7`. No deletion command was executed in this
runtime. A separate empty repository named `navier-stokes-perelman` was created;
it contains no object from the historical audit repository and must not be used
as a replacement for its history.

This manifest records paths and commit identifiers previously observed in the
conversation. Entries are `HISTORICALLY_REPORTED`, not locally reverified,
until the original clone or bundle is restored.

## Expected top-level structure

```text
navier-stokes-critical-barrier-audit/
├── INDEX.md
├── README.md
├── audit/
│   ├── 59_*.md
│   ├── 60_*.md
│   ├── 61_*.md
│   ├── 62_*.md
│   ├── 63_*.md
│   ├── 64_*.md
│   ├── 65_exact*.md
│   ├── 66_g1_g4_expanded_closure_program.md
│   ├── 67_universal_millennium_node_crosswalk.md
│   └── 68_g1*_joint_tail*.md
├── formal/
│   ├── lean/
│   │   ├── CriticalBarrier/
│   │   │   └── G1G4ClosureBlueprint.lean
│   │   └── MillenniumAudit/
│   │       ├── G1Audit.lean
│   │       ├── G1G4ClosureBlueprint.lean
│   │       ├── G1_PrizeStandard_v4.lean
│   │       ├── HypothesesComplete_v2.lean
│   │       └── HypothesesComplete_v3.lean
│   ├── coq/
│   │   └── G1G4ClosureBlueprint.v
│   ├── isabelle/
│   │   └── G1G4_Closure_Blueprint.thy
│   └── agda/
│       └── G1G4ClosureBlueprint.agda
├── scripts/
│   ├── g1_componentwise_ch_test.py
│   ├── g1_joint_tail_diagnostic.py
│   └── proof-escape audit scripts
├── results/
│   ├── g1_componentwise_ch_results.csv
│   ├── g1_componentwise_ch_results.json
│   ├── g1_joint_tail_diagnostic.csv
│   └── g1_joint_tail_diagnostic.json
└── .github/workflows/
    └── Lean/multiprover audit workflows
```

Names containing `*` must be recovered from Git, not guessed.

## Historically reported commits

| SHA | Reported role | Local verification |
|---|---|---|
| `9e8647ae` | Correct classification of the logical/PDE gap | NOT PRESENT |
| `d17975a0e39bff872fda91302294ea732815a885` | Audit 66 expanded G1--G4 closure programme | NOT PRESENT |
| `a2a9f45c4ff6aba333100b43c05e6ceab0bedff2` | Lean G1/G4 closure blueprint | NOT PRESENT |
| `ae9f2a598661f960cf7b404ce3a0347542ec0de2` | Coq closure blueprint | NOT PRESENT |
| `e9452a4b46f0416ee39ee26e3ce17e0837e4511d` | Isabelle closure blueprint | NOT PRESENT |
| `51b27e039f2248bc288fb3ff3439056ca9423522` | Agda closure blueprint | NOT PRESENT |
| `ce84b32e225b4e0c88cadc45d718dc13f868aca0` | INDEX update for audits 65/66 | NOT PRESENT |
| `bd78f7c30dd9bf48ee379ef5400f9ededf7c1dd0` | Universal Millennium node crosswalk | NOT PRESENT |
| `c636c4b4e202e2a2337b95b21c3dc7a40d035270` | Lean `dsimp` correction and scalar-estimate cleanup | NOT PRESENT |
| `60c9261986666bb5d6e181cefbd67b9610d28442` | Declaration-local gap policy test fix | NOT PRESENT |
| `cfc07a97e53776cffb0fab656c126049455cc75e` | G1 Prize Standard v4 branch formalization | NOT PRESENT |
| `ad73df0cf52c4df2ee54b140a25512d6fa890c2a` | Connect bridge outputs to Grönwall closure | NOT PRESENT |
| `4f92995ac5fdc4830205b12cc44c180d402e4923` | Isolated Lean `lakefile.toml` | NOT PRESENT |
| `1fc333590fb8bdcb605ec23925d43be3e5d7e821` | Lean toolchain pin | NOT PRESENT |
| `deb564be365634eca4789964fccb26b4105ebae6` | Lean root import | NOT PRESENT |
| `4b4ab50bdd5365d3a72b897e7e2b5d9fc417f9e8` | G1-v4 Lean CI workflow | NOT PRESENT |
| `82e90f668182305f2a41d4882eed0f0d71b0a089` | Explicit v3 budget unfolding fix | NOT PRESENT |
| `61c11fccf0c2cae0233ad0b001d182e9623f4f48` | Restrict proof-escape scan to project sources | NOT PRESENT |
| `639c79fe` | Componentwise `C_H` diagnostic script | NOT PRESENT |
| `15a3d737` | Componentwise numerical CSV | NOT PRESENT |
| `9d031df7` | Componentwise JSON result | NOT PRESENT |
| `32bf0d17` | Audit 67 numerical/structural record | NOT PRESENT |
| `e4cd96b0` | HypothesesComplete v3 | NOT PRESENT |
| `e513958e` | Joint-tail diagnostic script | NOT PRESENT |
| `b254a3aa` | Joint-tail CSV | NOT PRESENT |
| `b933a20e` | Joint-tail JSON | NOT PRESENT |
| `20376716` | Audit 68 | NOT PRESENT |

## Historically reported branches/runs

```text
branch: audit/g1-prize-standard-v4-20260913

GitHub Actions:
34730934002  failed: v3 unfolding problem
34731029086  failed: scan entered .lake/packages
34731110397  success: v3/v4 build and project-source escape scan
```

Run URL historically reported:

```text
https://github.com/ShantiDraconis/navier-stokes-critical-barrier-audit/actions/runs/34731110397
```

## Files surviving in the current runtime

```text
HypothesesComplete_v3.lean
G1_KAdmissible_to_SignedDepletion.lean
PerelmanLikeStabilizationSpec.lean
MillenniumAudit.lean
audit_67.md
audit_68.md
g1_componentwise_ch_test.py
g1_joint_tail_diagnostic.py
results/*
rerun_results/*
ESTABILIZADO_Como_Seria_CORRIGIDO.md
FORMAL_CORPUS_MANIFEST.md
G1_FORMALIZATION_STATUS.md
RUN_REPORT_2026-09-13.md
```

These surviving files are filesystem artifacts. They are not evidence that the
historical Git objects or timestamps are present.

## Recovery procedure

1. Obtain the original repository as a Git clone, Git bundle, or GitHub export.
2. Verify the remote URL before writing anything.
3. Run `git fsck --full` and preserve its output.
4. Verify every SHA above with `git cat-file -t <sha>`.
5. Export `git log --all --date=iso-strict --decorate --stat`.
6. Check out the historical branch in a new worktree; do not overwrite current
   files.
7. Compare surviving runtime files by SHA-256 before copying or merging.
8. Run the historical CI-equivalent build and proof-escape scans.
9. Only after verification, decide whether the new hypothetical files belong on
   a separate branch.

## Non-destruction declaration for this runtime

```text
rm/rm -rf executed on audit repository       NO
git reset --hard executed                     NO
git clean executed                            NO
historical repository found locally           NO
new empty repository created separately       YES
historical GitHub repository modified         NO
```
