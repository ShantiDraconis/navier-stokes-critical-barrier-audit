# Formal corpus manifest — honest expansion target

## Current deliverable

The Lean and Coq sources encode the same conditional dependency graph.  They do
not contain a construction of the prize-level bridge from the Navier--Stokes
equations.

## Why the repository is not padded to 8,000 lines

A line target is not a mathematical target. Repeating definitions, splitting a
single proof into hundreds of aliases, or inserting `True` lemmas would make the
repository larger while reducing its evidentiary value. The admissible expansion
is indexed by mathematical obligations and kernel-checked proofs.

## Planned Lean allocation after analytic results exist

| Module | Expected substantive lines | Required content |
|---|---:|---|
| `Geometry/RegularizedDirection.lean` | 500 | vector calculus for `xi_epsilon` |
| `Geometry/WeightedGradient.lean` | 500 | exact weighted derivative identity |
| `Compactness/LowerSemicontinuity.lean` | 900 | measurability, Fatou, defect measure |
| `Kernel/BiotSavartPV.lean` | 1,000 | principal value and angular cancellation |
| `Evolution/JointFunctional.lean` | 1,200 | differentiated joint functional |
| `Evolution/Commutator.lean` | 700 | epsilon-uniform commutator bounds |
| `Evolution/Transport.lean` | 600 | localized transport and moving cutoffs |
| `Tail/WeightedNoncollapse.lean` | 900 | analytic noncollapse theorem |
| `Entropy/TypedDefect.lean` | 900 | typed entropy and square identity |
| `Closure/EnstrophyToESS.lean` | 500 | Gronwall, reconstruction, endpoint map |
| **Total** | **7,700** | plus approximately 300 lines of indices/tests |

These are estimates, not fabricated line commitments.  The modules cannot be
honestly filled until their analytic statements are proved on paper.

## Proposed 200-page manuscript allocation

| Part | Pages | Purpose |
|---|---:|---|
| Definitions, scaling, and solution classes | 20 | eliminate dimensional ambiguity |
| Regularized direction and zero set | 25 | K0/K1 |
| Biot--Savart principal-value representation | 30 | exact kernel geometry |
| Joint functional evolution | 35 | six-term differentiation |
| Commutator and transport absorption | 30 | strict budget below one |
| Weighted tail and noncollapse | 25 | exceptional set theorem |
| Time-integrable coefficient | 15 | non-circular `a in L1` |
| Enstrophy, critical reconstruction, ESS | 10 | conditional closure |
| Formalization correspondence and audit | 10 | Lean/Coq theorem map |
| **Total** | **200** | only after the open analytic sections are proved |

## Present status

```text
Lean conditional core       = WRITTEN; KERNEL NOT AVAILABLE LOCALLY
Coq conditional core        = WRITTEN; KERNEL NOT AVAILABLE LOCALLY
proof-escape scan           = REQUIRED/PERFORMED BY scripts/test.sh
ActualNS -> certificates    = OPEN_BRIDGE
unconditional regularity    = NOT ESTABLISHED
```

