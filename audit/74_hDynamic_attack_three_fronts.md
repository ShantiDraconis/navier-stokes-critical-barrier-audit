# Audit 74 — hDynamic attack: three-front proof programme and noncircularity audit

Status: `TARGET_SHARPENED__TWO_PROPOSED_FRONTS_CURRENTLY_CIRCULAR_OR_UNSUPPORTED`

Date: `2026-09-13`

## Target

For a 3D incompressible Navier–Stokes solution, define

```text
omega = curl u
xi = omega/|omega| on {omega != 0}
Omega_theta(t) = {x : |omega(x,t)| >= theta ||omega(t)||_infinity}, theta=1/2
rho_star(t) = kappa ||omega(t)||_2 / ||grad omega(t)||_2
```

and seek

```text
x,y in Omega_theta(t), |x-y|<rho_star(t)
=> |sin angle(xi(x),xi(y))|
   <= C (|x-y|/rho_star(t))^(1/2)
```

with C independent of epsilon in an approximation/regularization scheme.

The scaling of `rho_star` is correct under 3D NS scaling:

```text
u_lambda(x,t)=lambda u(lambda x,lambda^2 t)
omega_lambda=lambda^2 omega(lambda x,lambda^2 t)
||omega_lambda||_2=lambda^(1/2)||omega||_2
||grad omega_lambda||_2=lambda^(3/2)||grad omega||_2
rho_star -> lambda^(-1) rho_star.
```

---

## 1. First formulation issue: generic Leray–Hopf is too weak for the target as written

A generic Leray–Hopf solution provides the kinetic-energy estimate

```text
sup_t ||u(t)||_2^2
+ 2nu integral ||grad u||_2^2 dt
<= ||u0||_2^2.
```

Hence one obtains, schematically,

```text
omega in L^2_t L^2_x.
```

But the target additionally uses

```text
||omega(t)||_infinity,
||grad omega(t)||_2,
pointwise xi(x,t),
pointwise angle(xi(x),xi(y)).
```

These are not available for an arbitrary Leray–Hopf solution.

Therefore the prize-level theorem must be stated on one of the following legitimate classes:

```text
(A) maximal smooth solution u on [0,T*) and all t<T*;
(B) a smooth Galerkin/mollified approximation u_epsilon with estimates uniform in epsilon, followed by a justified limit;
(C) a suitable weak solution restricted to times/regions for which the required quantities are separately proved to exist.
```

The cleanest continuation formulation is `(A)` plus an epsilon approximation used only inside the proof.

---

# FRONT 1 — direction equation and Biot–Savart

## 2. Exact direction equation

On `{|omega|>0}`, writing `omega=r xi`, `r=|omega|`, one obtains from

```text
D_t omega = S omega + nu Delta omega
```

the exact identity

```text
D_t xi
= S xi - (xi dot S xi) xi
  + nu (Delta xi + 2 grad(log r) dot grad xi).
```

Equivalently,

```text
D_t xi = P_{xi^perp} S xi
       + nu (Delta xi + 2 grad(log r) dot grad xi).
```

Thus

```text
alpha := xi dot S xi
```

is the actual stretching scalar determined by the PDE. It is not a free cancellation parameter.

Status: `VALID_IDENTITY_ON_NONZERO_VORTICITY_SET`.

## 3. Far-field Biot–Savart estimate

For the strain kernel `K_S(z) ~ |z|^{-3}`, split at `rho=rho_star`:

```text
S = S_near + S_far.
```

By Cauchy–Schwarz,

```text
|S_far(x)|
<= C (integral_{|z|>=rho} |z|^{-6} dz)^(1/2) ||omega||_2
<= C rho^(-3/2) ||omega||_2.
```

This estimate is correct.

However, substituting

```text
rho_star = kappa ||omega||_2 / ||grad omega||_2
```

gives

```text
rho_star^(-3/2)||omega||_2
= kappa^(-3/2)
  ||grad omega||_2^(3/2)
  ||omega||_2^(-1/2).
```

Its square is

```text
kappa^(-3) ||grad omega||_2^3 / ||omega||_2.
```

This is **not** controlled by the Leray energy inequality.

Therefore the statement

```text
S_far in L^2_t via HLS + Leray energy
```

is not presently justified.

Status: `OPEN_BRIDGE / CURRENTLY UNSUPPORTED`.

## 4. Near-field geometric depletion

If one already has

```text
|sin angle(xi(x),xi(y))|
<= C (|x-y|/rho_star)^(1/2),
```

then the effective singularity in the vortex-stretching representation drops from

```text
|z|^{-3}
```

to

```text
rho_star^{-1/2}|z|^{-5/2},
```

which is locally integrable in 3D because

```text
integral_0^rho r^2 r^(-5/2) dr
= integral_0^rho r^(-1/2) dr < infinity.
```

This is exactly the classical geometric depletion mechanism.

But using this estimate to **prove hDynamic itself** is circular unless a bootstrap scheme is supplied.

A legitimate bootstrap would need to establish:

```text
if [xi]_{C^{1/2}(Omega_theta;rho_star)} <= M
at an initial/bootstrap time,
then PDE evolution improves/preserves it with a strictly smaller or closed bound
M -> F(M) <= M,
```

with constants independent of epsilon.

No such contraction estimate has yet been derived.

Status: `CIRCULAR_AS_CURRENTLY_STATED`.

## 5. What Front 1 actually has to prove

A noncircular Front 1 must produce one of the following independently of hDynamic:

```text
(A) a Campanato estimate for xi;
(B) a Morrey estimate for xi with exponent 1/2;
(C) a De Giorgi/Nash-type oscillation decay for xi on high-vorticity cylinders;
(D) a bootstrap contraction on a scale-invariant xi-oscillation seminorm.
```

Because ordinary H^1 control in three dimensions does not imply C^{0,1/2}, an `H^1` estimate for `xi` alone is insufficient.

---

# FRONT 2 — weighted quantity and epsilon-uniform estimate

## 6. Proposed inequality

The proposed form is

```text
d/dt Q_e + nu Z_e
<= gamma nu Z_e + a_e(t) Q_e,
gamma=1/2<1,
```

with

```text
a_e(t)=C_kappa/nu^3 ||omega_e(t)||_2^4.
```

Algebraically, if `a_e in L^1` uniformly in epsilon and `gamma<1` uniformly, Gronwall works.

The issue is the claimed derivation of `a_e in L^1`.

## 7. Leray does NOT provide the claimed enstrophy/palinstrophy budget

The proposed argument invokes

```text
sup_t ||omega_e||_2^2
+ nu integral ||grad omega_e||_2^2 dt
<= C
```

“via Leray”.

That estimate is not the Leray energy inequality in 3D.

Leray gives

```text
sup_t ||u_e||_2^2
+ nu integral ||grad u_e||_2^2 dt
<= C,
```

so, schematically,

```text
integral ||omega_e||_2^2 dt <= C/nu.
```

It does **not** give, uniformly in epsilon,

```text
sup_t ||omega_e||_2^2
```

nor

```text
integral ||grad omega_e||_2^2 dt.
```

Those are enstrophy/palinstrophy controls whose uniform derivation is essentially part of the regularity problem.

Therefore one cannot conclude from Leray alone that

```text
integral ||omega_e||_2^4 dt < infinity.
```

Status: `FRONT_2_CURRENT_L1_ARGUMENT_FALSE`.

## 8. Noncircular coefficient target

To remain within the actual kinetic-energy budget, the preferred remainder is of the form

```text
a_e(t) <= C ||grad u_e(t)||_2^2,
```

or another quantity already known uniformly in `L^1_t` from the energy inequality.

This is why the modern flexible-depletion target

```text
stretching <= theta nu z + a(t)y,
a in L^1
```

is useful only if `a` is traced to an independent budget.

A quartic enstrophy coefficient is not automatically acceptable.

## 9. Aubin–Lions limit

To pass epsilon -> 0 with a weighted `Q_e`, one needs at minimum:

```text
uniform spatial compactness/boundedness in a Banach space X,
uniform time-derivative bound in a weaker space Y,
compact embedding X -> B,
continuous embedding B -> Y,
```

plus lower semicontinuity for `Z_e` and enough convergence for the weighted kernel term.

The epsilon-independent `gamma<1` must survive the limit.

None of this follows merely from the formal differential inequality.

Status: `OPEN_BRIDGE`.

---

# FRONT 3 — Gronwall and geometric volume

## 10. Gronwall

If

```text
Q'(t) <= a(t)Q(t),
a in L^1(0,T),
```

then

```text
Q(T) <= Q(0) exp(integral_0^T a).
```

No numerical factor such as `4.17` may be inserted unless it follows from the actual value of the integral.

Status: `PROVED_STANDARD_LOGIC`.

## 11. Effective volume

The quantity

```text
V_eff = ||omega||_2^2 / ||omega||_infinity^2
```

has volume scaling in 3D.

A candidate nondegeneracy statement

```text
V_eff >= kappa rho_star^3
```

is dimensionally compatible because both sides scale like `lambda^{-3}`.

But dimensional compatibility is not proof.

Substitution gives

```text
||omega||_2^2 / ||omega||_infinity^2
>= kappa^4 ||omega||_2^3 / ||grad omega||_2^3,
```

or, after rearrangement,

```text
||grad omega||_2^3
>= kappa^4 ||omega||_2 ||omega||_infinity^2.
```

This resembles a Gagliardo–Nirenberg-type inequality only in direction/scaling; the desired universal lower bound is not automatic from standard Sobolev estimates.

Therefore:

```text
GeometricNonDegeneracy = OPEN_BRIDGE
```

unless separately proved.

---

# 12. Central theorem audit

The requested theorem

```text
Leray-Hopf -> dynamic 1/2-Hölder coherence on Omega_theta
```

is stronger than the regularity available for a generic Leray–Hopf solution and, if established uniformly up to a putative singular time in the appropriate classical/suitable setting, would be a major regularity theorem.

At present the proposed proof does not close because:

```text
BLOCKER A:
Near-field estimate assumes the hDynamic coherence it is meant to prove.

BLOCKER B:
Far-field rho_star substitution creates
||grad omega||_2^(3/2)||omega||_2^(-1/2),
not controlled by Leray energy.

BLOCKER C:
a_e ~ ||omega_e||_2^4 is not uniformly L1 from Leray energy.

BLOCKER D:
Aubin-Lions requires additional epsilon-uniform spatial/time derivative estimates.

BLOCKER E:
V_eff >= kappa rho_star^3 is not automatic.
```

---

# 13. Minimal noncircular prize-level route

The route should be rewritten as:

```text
MaximalSmoothNS on [0,T*)
   |
   | prove independently
   v
DynamicCampanato:
  sup_{x in Omega_theta}
  average_{B_r(x)} |xi-xi_{B_r}|^2
  <= C (r/rho_star)
  for 0<r<rho_star
   |
   | Campanato embedding
   v
hDynamic C^{0,1/2}
   |
   | Constantin–Fefferman geometric depletion
   v
signed stretching bound
   |
   | with remainder a(t) traced to kinetic energy budget
   v
enstrophy Gronwall
   v
L^infinity_t L^3_x
   v
ESS continuation.
```

The genuinely new PDE theorem would therefore be `DynamicCampanato`, not the downstream geometric-depletion algebra.

A useful target is:

```text
exists C universal such that for every t<T*,
for every x in Omega_{1/2}(t),
for every 0<r<=rho_star(t),

(1/|B_r|) integral_{B_r(x) intersect Omega_{1/2}}
  |xi - xi_{B_r}|^2
<= C r/rho_star(t).
```

This is equivalent in proof role to the desired `1/2`-Hölder coherence but is better adapted to energy estimates and compactness.

---

# 14. Deliverable status

```text
hDynamic theorem itself = NOT PROVED
Front 1 exact xi equation = DERIVED
Front 1 far-field estimate = DERIVED, but time-integrability not closed
Front 1 near-field depletion = CONDITIONAL ON hDynamic
Front 2 proposed quartic a_e L1 from Leray = FALSE
Front 2 epsilon compactness = OPEN
Front 3 Gronwall = CLOSED STANDARD LOGIC
Front 3 geometric nondegeneracy = OPEN
```

The correct next attack is to derive `DynamicCampanato` or an equivalent scale-invariant oscillation-decay theorem for the direction field without inserting the target coherence estimate into the near-field Biot–Savart bound.
