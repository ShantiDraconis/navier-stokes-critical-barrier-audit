# Multiprover run report

Date: 2026-09-13 UTC

## Commands

```text
bash -n scripts/test.sh
bash scripts/test.sh
```

## Results

```text
Python syntax                         PASS
Lean proof-escape scan                PASS
Coq proof-escape scan                 PASS
Synthetic componentwise diagnostic   PASS_SYNTHETIC_ONLY
Synthetic joint-tail diagnostic       PASS_SYNTHETIC_ONLY
Lean kernel                           NOT_RUN_ENVIRONMENT_MISSING
Coq kernel                            NOT_RUN_ENVIRONMENT_MISSING
```

## Verified numerical identities

```text
C = 2, Phi = 0.6, E0/(2 nu) = 50
C Phi^2 E0/(2 nu) = 36
theta = Phi/(1+Phi) = 0.375
2(1-theta)nu = 0.0125
exp(72) = 1.8586717452841279e31
integral_a required for exp(2 integral_a)=4.17:
0.7139580179053551
```

## Interpretation

The scans establish that the local sources do not contain the listed proof
escapes. They do not establish that either prover accepts the files. Kernel
verification requires environments containing Lean/Mathlib and Coq.

The synthetic diagnostics test sampled packets, not Navier--Stokes solutions.
They provide no certificate for `ActualNS -> TwentyFiveObligations`.

