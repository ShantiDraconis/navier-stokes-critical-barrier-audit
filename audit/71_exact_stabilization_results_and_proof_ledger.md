# Audit 71 — Exact stabilization results, commits, and proof ledger

Status: `STABILIZATION_EVIDENCE_LEDGER_COMPLETE__ANALYTIC_BRIDGE_STILL_OPEN`

Date: `2026-09-13`

## 0. Scope

This note isolates exactly what is meant by “the part that stabilizes” in the current G1 programme.

Three different things must not be conflated:

1. **numerical stabilization** of sampled quantities such as `C_H^95`;
2. **formal stabilization** of the implication graph, where all open mathematics is exposed as hypotheses/certificates and no `sorry`/`axiom` is hidden;
3. **analytic stabilization of the Navier–Stokes PDE**, meaning a theorem `ActualNS -> signed depletion` with fixed constants and an `L1` defect derived non-circularly.

Items 1 and 2 have concrete evidence below. Item 3 remains open.

---

## 1. Chronology of the stabilization chain

### 1.1 Formal G1 hypothesis decomposition

Commit:

```text
4243b76b561f0a9b30c59c33d33bc3ac034c7cd9
2026-09-13T03:06:31+02:00
formal: add G1 hypotheses-complete v2 with CH95 audit and kernel bridge
```

Primary file:

```text
formal/G1/HypothesesComplete_v2.lean
```

This file explicitly separates:

```text
UniformCH95
PercentileToKernelBridge
DynamicCoherenceBridge
KernelToDepletionBridge
EndpointBridge
```

and proves only the compositions once the analytic bridges are supplied.

The file states that it contains no `axiom`, no `sorry`, and no `True` endpoint placeholder.

### 1.2 Deterministic componentwise diagnostic

Commit:

```text
639c79febf36832493d0fcdbb8923489082192ee
2026-09-13T03:09:45+02:00
test: add deterministic componentwise CH packet harness
```

This introduced the deterministic packet harness used to test componentwise coherence under refinement and under `kappa` variation.

### 1.3 First stabilization result table

Commit:

```text
15a3d737215fa29926d6658e235f2e793668e875
2026-09-13T03:09:53+02:00
results: add CH refinement and kappa covariance CSV
```

Primary result:

```text
results/g1_componentwise_ch_results.csv
```

### 1.4 Machine-readable packet audit

Commit:

```text
9d031df772df6cf83acda49c0c19bc23b22ac115
2026-09-13T03:10:00+02:00
results: add machine-readable CH packet audit
```

### 1.5 Classification of the stabilization and kappa obstruction

Commit:

```text
32bf0d17b559ad345f8e7345975d85e36211f943
2026-09-13T03:10:07+02:00
audit: classify componentwise CH test and kappa obstruction
```

This is the point where the repository stopped treating numerical stabilization as an analytic theorem and explicitly classified the missing bridge.

### 1.6 Joint coherence + exceptional-tail diagnostic

Commit:

```text
e513958e79ef2b02127ff22729c89b09a77ff8b5
2026-09-13T03:18:11+02:00
numerics: add joint CH and exceptional-tail diagnostic
```

### 1.7 Joint-tail numerical results

Commit:

```text
b254a3aa970db430e0730f3ac8ad2d88bf7db141
2026-09-13T03:18:18+02:00
results: record joint CH and kernel-tail proxy data
```

Primary files:

```text
results/g1_joint_tail_diagnostic.csv
results/g1_joint_tail_diagnostic.json
```

### 1.8 Machine-readable joint-tail record

Commit:

```text
b933a20e4135092b07b3cc8e6598bcb1747a7ad3
2026-09-13T03:18:24+02:00
results: add machine-readable G1 joint-tail diagnostic
```

### 1.9 Exact analytic classification after the joint-tail test

Commit:

```text
20376716ab6b6fda3daa91723eab71013294c91b
2026-09-13T03:18:32+02:00
audit: classify G1 v3 joint-law and exceptional-tail obligations
```

Primary audit:

```text
audit/68_g1star_v3_joint_tail_decomposition.md
```

### 1.10 Stabilized Perelman-like hypothetical programme

Commit:

```text
68144cd9347de4a54680684f7e9546a2df1a297a
2026-09-13T13:47:45Z
2026-09-13T15:47:45+02:00
audit: add stabilized Perelman-like hypothetical closure program
```

This commit adds the 650-line

```text
audit/70_stabilized_perelman_like_program_and_three_open_obligations.md
```

and preserves the stabilized formal corpus including:

```text
G1_KAdmissible_to_SignedDepletion.lean
PerelmanLikeStabilizationSpec.lean
MillenniumAudit/StabilizedHypothetical.lean
G1_FORMALIZATION_STATUS.md
RUN_REPORT_2026-09-13.md
```

---

## 2. Exact numerical stabilization observed

### 2.1 Fixed-field refinement

For `kappa = 1`, the observed `C_H^95` values were:

```text
N=64   : 0.5984092316893435
N=128  : 0.5986319218175409
N=256  : 0.5970172856520107
N=512  : 0.5904267122702500
```

The range is approximately

```text
0.5904 <= C_H^95 <= 0.5987
```

across the four tested resolutions.

This is the strongest direct evidence for **fixed-field finite-resolution stabilization** in the current dataset.

It is evidence only for the sampled synthetic field and normalization.

### 2.2 Shrinking-packet family

The corresponding `C_H^95` values were:

```text
N=64   : 0.6078156912478048
N=128  : 0.5966655774428620
N=256  : 0.5970172856520107
N=512  : 0.5837769915345352
```

Again, the values remain O(1) and close to roughly `0.6`, but there is visible drift.

Therefore:

```text
FINITE_RESOLUTION_O1_STABILITY = OBSERVED
UNIVERSAL_LIMIT = NOT ESTABLISHED
```

### 2.3 Kappa covariance / normalized signature

For the `kappa_covariance` run at `N=256`:

```text
kappa=0.25 : C_H^95 = 0.15492750632385413
kappa=1    : C_H^95 = 0.59455665003323700
kappa=4    : C_H^95 = 1.21884065580425570
```

Thus

```text
C_H^95 / sqrt(kappa)
```

is approximately

```text
0.3098550126477083
0.5945566500332370
0.6094203279021279
```

This is the precise origin of the numerical sequence often summarized as

```text
0.309 -> 0.594 -> 0.609.
```

It shows that the chosen normalized quantity becomes O(1) over this three-point sample. It does not establish a universal constant.

### 2.4 Expanded six-kappa joint-tail diagnostic

The later joint-tail test produced:

| kappa | C_H^95 | C_H^95/sqrt(kappa) | exceptional pairs | kernel proxy share |
|---:|---:|---:|---:|---:|
| 0.25 | 0.1489 | 0.2978 | 5% | 11.67% |
| 0.5  | 0.2974 | 0.4206 | 5% | 10.00% |
| 1    | 0.5781 | 0.5781 | 5% | 8.46% |
| 2    | 0.9966 | 0.7047 | 5% | 8.65% |
| 4    | 1.2177 | 0.6089 | 5% | 15.65% |
| 8    | 1.6419 | 0.5805 | 5% | 18.82% |

This gives two simultaneous results:

```text
normalized CH95 remains O(1) over the sampled kappa range = OBSERVED
exceptional 5% is not negligible under the singular-kernel proxy = OBSERVED COUNTEREVIDENCE
```

The second point is decisive: percentile stabilization alone does not close the Biot–Savart tail.

---

## 3. What is formally proved in the stabilized corpus

### P1 — depletion implies dissipative differential inequality

Given

```text
(1/2) y' + nu z = S
```

and

```text
S <= (1-delta) nu z,
0 < delta <= 1,
```

Lean proves

```text
y' + 2 delta nu z <= 0.
```

This is `depletion_to_differential` / `closed_depletion_implies_decay` logic.

Status:

```text
PROVED_LOGIC
```

### P2 — flexible signed depletion implies exact differential inequality

Given

```text
S <= theta nu z + a(t)y,
theta < 1,
```

and the enstrophy balance, the stabilized specification proves

```text
y' + 2(1-theta)nu z <= 2 a(t)y.
```

This appears as

```text
signedDepletion_to_differential
```

in `PerelmanLikeStabilizationSpec.lean`.

Status:

```text
PROVED_LOGIC
```

### P3 — bulk + exceptional tail + strict budget implies signed depletion

If

```text
B <= c_bulk nu z,
E <= delta_tail nu z,
c_bulk + delta_tail < 1,
S = B + E,
```

then, defining

```text
delta = 1 - c_bulk - delta_tail > 0,
```

one gets

```text
S <= (1-delta) nu z.
```

The stabilized v3 audit states that this algebra is encoded without `axiom` or `sorry` in

```text
formal/millennium/lean/MillenniumAudit/HypothesesComplete_v3.lean.
```

Status:

```text
PROVED_LOGIC
```

### P4 — conditional G1 composition

`HypothesesComplete_v2.lean` proves that if

```text
ActualNS -> KernelWeightedCoherence
```

and

```text
KernelWeightedCoherence -> GeometricDepletion,
```

then

```text
UniformEnstrophyDifferential
```

follows.

It also proves the optional numerical route when an explicit

```text
UniformCH95 -> KernelWeightedCoherence
```

bridge is supplied.

The bridge itself is not manufactured by Lean.

Status:

```text
CONDITIONAL COMPOSITION PROVED
```

### P5 — energy-integrable multiplier arithmetic

For the illustrative constants

```text
C = 2
Phi = 0.6
E0 = 1
nu = 0.01
E0/(2nu) = 50
```

and

```text
a(t) = C Phi^2 y(t),
```

one has

```text
integral a <= 2 * 0.36 * 50 = 36.
```

This arithmetic is correct.

The stabilized audit also corrects the associated Gronwall factor:

```text
y(t) <= y0 exp(2 integral a)
```

so `integral a = 36` gives

```text
exp(72) = 1.8586717452841279e31,
```

not `4.17`.

The run report records that obtaining a factor `4.17` would require

```text
integral a ~= 0.7139580179053551.
```

Status:

```text
ARITHMETIC VERIFIED
USEFUL SMALLNESS NOT PROVED
```

### P6 — conditional endpoint composition

The formal corpus contains typed interfaces showing

```text
signed depletion
-> enstrophy differential control
-> uniform enstrophy certificate
-> critical L3 certificate
-> ESS endpoint certificate
-> GlobalRegularity.
```

The endpoint conclusion is therefore formally composable once the certificates are supplied.

Status:

```text
CONDITIONAL LOGIC PROVED
ACTUAL ANALYTIC CERTIFICATES STILL REQUIRED
```

---

## 4. What exactly stabilizes and what does not

The following has stabilized in a defensible sense:

```text
A. the numerical fixed-field C_H^95 statistic is nearly resolution-stable;
B. the normalized C_H^95/sqrt(kappa) is O(1) in the sampled regime;
C. the proof DAG is stable: every missing implication is exposed explicitly;
D. the arithmetic downstream of signed depletion is stable;
E. the fixed-delta scalar route and direction-only route have explicit countercertificates;
F. the weighted-tail issue is now isolated as an independent obligation;
G. the non-circular L1-defect route is isolated from rho_*^{-2}=z/y.
```

The following has **not** stabilized analytically:

```text
ActualNS -> uniform Q_joint
ActualNS -> weighted tail eta <= delta_tail
ActualNS -> uniform analytic Phi bound
ActualNS -> Perelman-like entropy monotonicity
ActualNS -> weighted noncollapse
ActualNS -> integrable defect with fixed constants
ActualNS -> signed depletion
```

---

## 5. Exact stabilized formal specification

`PerelmanLikeStabilizationSpec.lean` defines three proposed stabilizing objects:

```text
TypedEntropyCertificate
CriticalNoncollapseCertificate
CriticalDecompositionCertificate
```

plus

```text
SignedDepletionCertificate
EnstrophyBalance
GronwallOutput
CriticalEndpoint
ActualNSToStabilization
ConditionalClosure.
```

The theorem

```text
signedDepletion_to_differential
```

is genuinely proved by algebra.

The theorem

```text
F_of_complete_stabilization
```

is also a genuine logical composition, but its input is a complete `ConditionalClosure`; the file does not construct that object from Navier–Stokes.

Therefore

```text
F_of_complete_stabilization = PROVED CONDITIONAL THEOREM
ActualNS -> ConditionalClosure = OPEN
```

---

## 6. Exact stabilized programme from Audit 70

The strongest current programme is

```text
ActualNS
  -/-> [OPEN]
{backward f_NS, weighted noncollapse, ancient-limit/compactness classification}
  -/-> [OPEN]
Q_joint + weighted TailControl
  -/-> [OPEN]
G1_flex:
S <= theta nu z + a(t)y,
theta<1,
a in L1
  -> [PROVED LOGIC]
uniform enstrophy
  -> [CONDITIONAL ANALYSIS]
L^infinity_t L3_x
  -> [EXTERNAL ENDPOINT]
ESS continuation.
```

The three compressed open obligations recorded by the stabilized programme are:

```text
O1 = derive uniform joint coherence from ActualNS;
O2 = prove weighted exceptional-tail smallness;
O3 = improve the nonlinear remainder to an energy-integrable coefficient.
```

---

## 7. Numerical test execution status

The preserved run report records:

```text
Python syntax                         PASS
Lean proof-escape scan                PASS
Coq proof-escape scan                 PASS
Synthetic componentwise diagnostic   PASS_SYNTHETIC_ONLY
Synthetic joint-tail diagnostic       PASS_SYNTHETIC_ONLY
Lean kernel                           NOT_RUN_ENVIRONMENT_MISSING
Coq kernel                            NOT_RUN_ENVIRONMENT_MISSING
```

Therefore proof-escape scans are positive evidence that the inspected local sources do not contain the listed escapes, but they are not kernel compilation certificates.

Any later successful Lean/Coq workflow must be cited by exact run ID, job ID, commit SHA, and step conclusions before changing this status.

---

## 8. Final evidence matrix

| Object/result | Evidence | Status |
|---|---|---|
| fixed-field `C_H^95 ~ 0.59` over N=64..512 | `15a3d737`, CSV | `OBSERVED_NUMERICAL` |
| normalized sequence `0.309,0.594,0.609` | `15a3d737`, kappa covariance | `OBSERVED_NUMERICAL` |
| six-kappa O(1) normalized CH95 | `b254a3aa`, joint-tail results | `OBSERVED_NUMERICAL` |
| exceptional 5% carries 8.46–18.82% kernel proxy | `b254a3aa` / audit `20376716` | `OBSERVED_COUNTEREVIDENCE_TO_NAIVE_PERCENTILE` |
| `CH95 -> kernel coherence` | explicit bridge field | `OPEN` |
| `kernel coherence -> depletion` | explicit bridge field | `OPEN` |
| bulk+tail+budget -> depletion | Lean v3 | `PROVED_LOGIC` |
| signed depletion -> differential inequality | Lean | `PROVED_LOGIC` |
| `int a <= 36` for illustrative constants | run report/audit70 | `ARITHMETIC_VERIFIED` |
| `int a=36 -> y<=4.17` | corrected | `FALSE` |
| correct factor for `int a=36` | `e^72` | `ARITHMETIC_VERIFIED` |
| complete Perelman-like stabilization from ActualNS | no construction | `OPEN` |
| unconditional global regularity | no proof | `NOT_ESTABLISHED` |

---

## 9. Audit conclusion

The word **stabilization** is justified for the following limited claims:

1. a sampled finite-resolution statistic is numerically stable near an O(1) value;
2. the conditional algebraic proof architecture is formally stabilized;
3. all known hidden jumps have been moved into named open obligations;
4. the main naive routes have countercertificates preventing accidental promotion.

It is **not** justified to say that the Navier–Stokes PDE itself has been stabilized in the prize-level sense.

The exact prize-level missing theorem remains:

```text
ActualNS -> G1_flex
```

or an equivalent theorem strong enough to produce

```text
S(t) <= theta nu z(t) + a(t)y(t),
theta<1,
a in L1(0,T*),
```

with all constants fixed independently of the critical endpoint being proved.
