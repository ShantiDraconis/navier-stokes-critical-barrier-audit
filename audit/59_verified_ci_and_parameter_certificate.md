# Audit 59 — Verified CI and Parameter Certificate

Date: 2026-09-12

## Scope

This certificate records deterministic arithmetic, direct GitHub Actions log verification, and adversarial logical tests. It is **not** a certificate of a Navier–Stokes solution.

## GitHub Actions verification

PR #22 head:

`aff4dbbb0bb805fda4979b3233908723c45368f6`

Workflow run:

`34702215837`

GitHub reports the overall workflow conclusion as `success`, but the workflow uses `continue-on-error: true` on substantive test/build steps. Therefore the overall green badge cannot be interpreted as “all verifiers passed”. Direct log inspection gives:

- unit tests: **FAIL** — `GapPipelineTests.setUpClass` raised an error; unittest command exited `1`;
- Lean build: **FAIL** — `lake build` reported `CriticalBarrier: some modules have bad imports`; step exited `1`;
- Lean proof-escape grep scan: **PASS for the explicitly listed target files** — output `CLEAN`;
- Coq build: **FAIL** — `formal/coq/ResolutionDynamics.v` failed because `lra` was not found; step exited `1`;
- Coq proof-escape grep scan: **PASS for `formal/coq/B2_8_AlignmentTarget.v`** — output `CLEAN`;
- canonical bridge registry: **PASS** — 20 endpoint obligations validated;
- static audit integrity: `PASS_WITH_REPORTED_MARKERS`;
- Isabelle: `SOURCE_PRESENT_NOT_EXECUTED_IN_THIS_WORKFLOW`;
- Agda: `SOURCE_PRESENT_NOT_EXECUTED_IN_THIS_WORKFLOW`.

Diagnostic artifact uploaded by the run:

- artifact id: `10300034857`
- artifact SHA-256: `86e3fff08e12c29d1d5b174776cb260d8b8ed1fd5cc9cfdd8e413f144f6ccc5e`

## Deterministic parameter tracks

Common inputs:

- `nu = 1`
- `Lambda = 10`
- `R = 51`
- `C_Bern = 4`
- `C_CZ = 1.5`
- `kappa = nu*Lambda^2/4 = 25`
- `D = nu*Lambda^2*R = 5100`
- homogeneous coefficient `nu*Lambda^2-kappa = 75`.

### Track A — frozen `C_Sob = 0.62`, error `Lambda^(-1/2)`

- `C_error = 2.48`
- `c* = 1/2.48 = 0.403225806451...`
- `Lambda^(-1/2) = 0.316227766016...`
- perturbation coefficient `= 0.784244859722...`
- `Pi_max(R=51) = 1314.9964878458...`
- `dR/dt <= -3785.0035121542...`
- effective proportional rate `= 74.2157551403...`
- arithmetic target `0.62*(102+c*) = 63.49`.

### Track B — literal formula `4^(1/3)/(sqrt(3)*(2*pi)^(2/3))`

The literal formula evaluates to

`0.269157275871...`

not `0.6203503`.

Consequently:

- `C_error = 1.076629103484...`
- `c* = 0.928824974899...`
- perturbation coefficient `= 0.340460016223...`
- `Pi_max(R=51) = 1292.3634608274...`
- `dR/dt <= -3807.6365391726...`
- effective rate `= 74.6595399838...`.

Therefore any file equating that exact formula to `0.6203503` fails the deterministic arithmetic check.

### Track C — PR #22 B2.8 target file

`formal/lean/CriticalBarrier/B2_8_AlignmentTarget.lean` fixes

- `C_Sob = 31/50 = 0.62`
- `C_error = 62/25 = 2.48`
- error exponent `Lambda^(-1)` rather than `Lambda^(-1/2)`.

At `Lambda=10`, `R=51`:

- error coefficient `= 0.248`
- `Pi_max = 1287.648`
- `dR/dt <= -3812.352`
- effective rate `= 74.752`.

This is a different specification from Track A and must not be silently merged with it.

### Track D — PR #22 deterministic parameter file

`formal/lean/CriticalBarrier/B2_DeterministicParameterChain.lean` defines the decimal target

`C_Sob_decimal = 4272605429 / 10000000000 = 0.4272605429`

and uses a square-root perturbation.

Thus:

- `C_error = 1.7090421716`
- `c* = 0.585123069...`
- perturbation coefficient `= 0.540446588...`
- `Pi_max(R=51) = 1302.5627759856...`
- `dR/dt <= -3797.4372240144...`
- effective rate `= 74.4595534120...`.

This is a third normalization/specification and must also be reconciled.

## B2.9 arithmetic certificate

For the audited equal-energy comparison:

- `E_A = E_B = 102`
- `R_A = R_B = 51`
- `Q_A = 0`, hence `Pi_A = 0`
- `Q_B = 1`, hence `Pi_B = 2*pi^3 = 62.0125533606...`.

Therefore equal scalar `R` does not determine signed `Pi`.

## Alignment adversarial test

Take

`S = diag(1,-0.5,-0.5)`

and

`u = (1,0,0)`.

Then

- `trace(S)=0`;
- normalized quadratic alignment is exactly `1`.

Hence trace-freeness plus a frequency-concentration predicate that contains no orientation information cannot imply `Alignment <= 0.9`. An additional geometric/PDE hypothesis controlling orientation relative to the strain eigenspaces is required.

## Certified status

- deterministic arithmetic under each stated convention: **PASS**;
- single consistent Sobolev/error convention across current files: **FAIL / unresolved**;
- PR #22 Lean build at run 34702215837: **FAIL**;
- PR #22 Coq build at run 34702215837: **FAIL**;
- Lean/Coq grep-based proof-escape scans: **PASS only in their listed file scope**;
- Isabelle/Agda kernel checks: **NOT EXECUTED**;
- B2.8 signed-flux derivation: **OPEN**;
- critical `L^infinity_t L^3_x` bridge: **OPEN**;
- ESS formal endpoint: **OPEN**;
- Navier–Stokes global regularity: **NOT ESTABLISHED**.
