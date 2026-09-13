# Exact closure blockers for the stabilized NS program

Status: **NOT A PROOF OF GLOBAL REGULARITY**. This file isolates exactly what must be proved, with no circular use of the desired a priori bound.

## Target DAG

```text
ActualNS
  -> K0 regularization / degenerate-case hygiene
  -> K1 weighted low-vorticity control + compactness/liminf
  -> G1a uniform Q_joint evolution/coherence
  -> G1d2 integrable coefficient a(t)
  -> G1 signed depletion
  -> Psi_NS derived correction
  -> Wcorr almost-monotonicity
  -> weighted noncollapse
  -> critical decomposition preserving the coercive inequality
  -> uniform enstrophy
  -> L^infty_t L^3_x
  -> ESS continuation
  -> global smooth continuation
```

## BLOCKER 0 — Exact `ActualNS` interface

Need a single formal structure containing, on a maximal smooth interval `[0,T*)`:

- incompressibility;
- Navier–Stokes momentum equation;
- viscosity `nu > 0`;
- energy inequality;
- `u in L^infty_t L^2_x cap L^2_t H^1_x`;
- `omega = curl u`;
- strain tensor `S = (grad u + grad u^T)/2`;
- enstrophy identity while smooth:
  `y' + 2 nu z = 2 int omega · S omega`;
- all domain/decay/periodicity assumptions needed for integrations by parts.

**Success criterion:** every later lemma consumes only this structure plus explicitly listed numerical/geometric hypotheses.

## BLOCKER 1 — `K1a_WeightedLow`

Target:

```text
eta_low(delta) := int_{|omega|<delta} r^2 |grad xi|^2 W
eta_low(delta) <= C_low sqrt(delta)
eta_low(delta) -> 0
```

with weighted kernel

```text
W = |omega|^2 |omega| |K|
```

and no use of `sup_t y(t)`.

The proof must justify all of:

1. regularized direction `xi_eps = omega / sqrt(|omega|^2 + eps^2)`;
2. exact relation between `grad xi_eps` and `grad omega`;
3. integrability of the singular kernel on the actual truncated/localized region;
4. coarea or layer-cake step, if used;
5. the claimed quantitative `sqrt(delta)` rate;
6. independence of constants from `eps`, time, and the unknown `sup y`;
7. compatibility with the available energy budget `int ||grad u||_2^2 <= E0/(2nu)`.

**Disallowed shortcut:** plain Chebyshev measure control.

**Failure mode:** if the singular kernel produces a logarithmic or worse divergence that cannot be absorbed, the proposed `C sqrt(delta)` bound is false in this form.

## BLOCKER 2 — `K1b_Compactness` and `K1c_Liminf`

Need to pass `eps -> 0` without losing the weighted estimate.

Required statements:

```text
xi_eps -> xi a.e. on {omega != 0}
Q_joint,eps >= 0
liminf int Q_joint,eps W >= int Q_joint W
Comm_eps bounded uniformly in L1
```

Need an explicit dominating/tightness argument for the commutator and weighted kernel terms.

**Success criterion:** no hidden dependence on a norm stronger than what `ActualNS` supplies.

## BLOCKER 3 — `G1a_Qjoint`: derive the evolution inequality

Define

```text
Q_joint = r^2 |grad xi|^2 + alpha (xi · S xi)_+
```

with `alpha = 1` for the current audit normalization.

Need a rigorous evolution/transport inequality from NS:

```text
D_t Q_joint
  <= - coercive_term
     + commutator
     + cutoff_term
     + scale_motion_term
     + lower_order_term
```

The derivation must control:

- directional term;
- strain-positive term;
- derivatives of `r` if `r` is variable;
- cutoff derivatives;
- nonlocal Biot–Savart contribution;
- scale-motion term;
- regularization error as `eps -> 0`.

The expansive test `S = diag(2,-1,-1), xi=e1` must be detected:

```text
Q_dir = 0
Q_strain = 2
Q_joint = 2
```

so the joint diagnostic does not miss this mode.

**Success criterion:** obtain constants independent of the unknown enstrophy supremum.

## BLOCKER 4 — strict absorption / weighted-tail theorem

Need to prove a strict inequality of the form

```text
Comm <= gamma * c0 * nu * r^(-2) * Q + b(t) Q
```

with

```text
gamma < 1
b in L1_t
```

from `ActualNS` plus the weighted low-tail estimate and whatever high-vorticity coherence hypothesis is genuinely derivable.

This is the location where a mere 95% unweighted coherence statement is insufficient: the exceptional 5% may dominate the singular kernel.

**Success criterion:** a weighted exceptional-tail estimate strong enough to make the coefficient strictly subcritical.

## BLOCKER 5 — `G1d2_aL1`: coefficient bookkeeping

The numerical identity is easy and must remain separate from the analytic theorem:

```text
C = 2
Phi = 0.6
E0/(2nu) = 50
C * Phi^2 * E0/(2nu) = 36
```

Need to prove that the actual coefficient satisfies

```text
a(t) <= C * Phi^2 * ||grad u(t)||_2^2
```

(or the exact derived variant), hence

```text
int_0^T a(t) dt <= 36.
```

**Critical firewall:** deriving `a(t)` may not use `z/y`, `sup y`, or any quantity whose boundedness is the desired conclusion.

## BLOCKER 6 — `G1_SignedDepletion`

Target theorem:

```text
int omega · S omega
  <= theta * nu * z + a(t) * y

theta = 0.375 < 1
int a <= 36
```

Need an explicit decomposition of the vortex-stretching trilinear form into the controlled high-vorticity, low-vorticity, weighted-tail, and commutator pieces.

**Success criterion:** all coefficients add up to a number strictly below `1` in front of `nu z`.

This is the primary analytic closure target. If this theorem fails, the rest of the NS chain does not close.

## BLOCKER 7 — derive `Psi_NS`; do not postulate it

Known naive identity:

```text
rho = exp(-f)
f_t = -Delta f + |grad f|^2 - Q
rho_t = -Delta rho + Q rho

W0 = int (|grad f|^2 + Q) rho
W0' = 2 int |Hess f|^2 rho
      + int [Q_t + Q^2 + Q|grad f|^2 - 3 Delta Q] rho
```

Beltrami test gives

```text
Q(Q-2nu) < 0
```

at `Q=nu=0.01`, hence the naive monotonicity fails.

The algebraic identity

```text
q(q-2 lambda) + 2 lambda q = q^2 >= 0
```

is proved, but this does **not** derive a PDE correction.

Need to solve/construct a correction satisfying an inequality of the form

```text
Psi_t - Delta Psi + Q Psi
  >= -Q_t + 3 Delta Q - Q^2 - Q|grad f|^2 - controlled_remainder
```

using only previously proved evolution/coercivity estimates.

**Success criterion:** `Psi_NS` is produced by a theorem from the PDE data, not chosen post hoc to cancel the Beltrami polynomial.

## BLOCKER 8 — `Wcorr_AlmostMonotone`

Target:

```text
Wcorr := int (|grad f|^2 + Q_joint + Psi_NS) rho
Wcorr' + a(t) Wcorr >= int |D_NS|^2 rho
```

with

```text
a in L1_t.
```

Need exact definition of `D_NS`, all boundary terms, and positivity/coercivity of the RHS.

**Success criterion:** Gronwall-controlled almost monotonicity with constants derived independently of `sup y`.

## BLOCKER 9 — weighted noncollapse

The proposed object must be defined precisely. A candidate is

```text
Vol_W(B_r) := double_integral_{B_r} W
```

but dimensions, normalization, and finiteness must be checked.

Need a theorem

```text
Vol_W(B_r) >= kappa r^3
```

for the relevant scales with `kappa > 0`, derived from NS quantities and `Wcorr`, not imported by analogy with Ricci flow.

**Critical check:** as written, `W = |omega|^3 |K|` may not have the dimensions of a volume density. If dimensional normalization is required, modify the definition before proving the theorem.

## BLOCKER 10 — `SurgeryOmega` / critical decomposition

Need a mathematical operation `D_r` with explicit properties:

1. localizes high-vorticity regions;
2. decomposes into finitely or summably many components;
3. preserves/divides the energy and enstrophy bookkeeping;
4. preserves the `Q_joint` estimates;
5. does not create a new uncontrolled commutator;
6. preserves the signed-depletion inequality after cutoff/gluing;
7. is compatible with continuation and the weighted noncollapse scale.

It should be called `CriticalDecomposition` in the theorem statement unless an actual surgery operation is constructed.

## BLOCKER 11 — uniform enstrophy

Once G1 is actually proved:

```text
y' + 2(1-theta) nu z <= 2 a(t) y
```

and Gronwall gives

```text
y(t) <= y(0) exp(2 int a).
```

Do not hard-code `4.17` unless `y(0)` and `int a` actually imply it. With `int a = 36`, the raw factor is `exp(72)`, not `4.17`.

**Success criterion:** all numerical bounds are recomputed from the exact normalized initial data; no inconsistent legacy constant remains.

## BLOCKER 12 — `L3Bound`

Need a correct interpolation/Sobolev chain. A typical route in 3D is

```text
||u||_6 <= C_S ||grad u||_2
||u||_3 <= ||u||_2^(1/2) ||u||_6^(1/2)
```

so

```text
||u||_3 <= C_S^(1/2) ||u||_2^(1/2) ||grad u||_2^(1/2).
```

To replace `||grad u||_2` by `||omega||_2`, prove the domain-dependent identity/equivalence for divergence-free fields.

**Success criterion:** a uniform `L^infty_t L^3_x` bound with the exact Sobolev constant assumptions stated.

## BLOCKER 13 — ESS interface

Need a faithful statement of the Escauriaza–Seregin–Sverak endpoint theorem with all hypotheses mapped:

- domain (`R^3`, periodic, or bounded variant);
- suitable weak / Leray-Hopf solution requirements;
- time interval;
- endpoint space exactly `L^infty_t L^3_x`;
- localization/boundary conditions if applicable.

Do not encode ESS as an unexplained axiom in the final no-escape proof tree. Either formalize the theorem from an accepted library/source or mark it as an explicit external theorem interface in the certificate.

## BLOCKER 14 — final continuation theorem

Need to show that the uniform endpoint bound excludes finite `T*` and permits continuation of the smooth solution beyond every candidate maximal time.

The conclusion should match the precise Clay formulation being targeted; avoid writing `exists! u C-infinity global` unless uniqueness/existence hypotheses exactly support that statement.

## Engineering blockers

The mathematical tree is not certified until all of the following hold at the same frozen HEAD:

```text
Lean version                 = frozen
Mathlib commit               = frozen
lake build                   = SUCCESS
Python tests                 = SUCCESS
proof-escape scan            = 0 unapproved sorry/axiom/admit
external theorem interfaces  = enumerated
HEAD SHA                      = recorded
workflow run ID               = recorded
job ID                        = recorded
source checksums              = recorded
```

Note: an allowed external theorem interface is not the same as an untracked axiom. Every such interface must name the theorem, source, hypotheses, and exact role in the DAG.

## Exact order of work

```text
P0  ActualNS exact interface
P1  K1a weighted low-vorticity estimate
P2  K1b/K1c eps -> 0 compactness + weighted liminf
P3  G1a Q_joint evolution
P4  strict weighted-tail absorption
P5  a(t) derivation + L1 bound
P6  G1 signed depletion
P7  Psi_NS derived PDE correction
P8  Wcorr almost-monotonicity
P9  weighted noncollapse
P10 critical decomposition
P11 uniform enstrophy
P12 L^infty L^3 endpoint
P13 ESS hypothesis map
P14 continuation / final theorem
P15 frozen reproducibility certificate
```

## Closure criterion

The program is stabilized only if the proof graph contains a path

```text
ActualNS -> ... -> FinalF
```

such that every edge is one of:

```text
PROVED_INTERNAL
PROVED_EXTERNAL_WITH_EXACT_HYPOTHESIS_MAP
```

and no edge is one of:

```text
ASSUMED_BRIDGE
POSTULATED_IDENTITY
NUMERICAL_EVIDENCE_ONLY
STRUCTURAL_ANALOGY_ONLY
CIRCULAR_BOUND
UNTRACKED_AXIOM
```

At present the dominant unresolved edge remains:

```text
ActualNS -> weighted joint coherence / strict signed depletion (G1_NS)
```

and the second independent unresolved edge is:

```text
G1_NS / Q-evolution -> PDE-derived Psi_NS -> Wcorr almost-monotonicity.
```
