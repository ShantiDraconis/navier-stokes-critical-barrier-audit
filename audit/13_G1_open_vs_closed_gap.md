# G1 — OPEN vs CLOSED geometric-depletion bridge

## Status

This note isolates the exact nonlinear obstruction in the 3D Navier–Stokes enstrophy balance. It **does not claim a proof of global regularity**. The purpose is forensic: distinguish what follows from standard scalar inequalities from the additional signed/coercive estimate that would be required to close the argument.

**Current classification**

- `G1_SCALAR_OPEN_ESTIMATE`: standard/derivable in the smooth setting.
- `G1_GEOMETRIC_DEPLETION_CLOSED`: **NOT ESTABLISHED** here.
- `G1 ⇒ downstream decay`: conditional implication only.
- `NAVIER_STOKES_GLOBAL_REGULARITY`: **NOT ESTABLISHED**.

---

## 1. Enstrophy variables

For a smooth divergence-free solution, let

\[
y(t):=\|\omega(t)\|_{L^2}^2,
\qquad
z(t):=\|\nabla\omega(t)\|_{L^2}^2,
\]

with vorticity \(\omega=\nabla\times u\) and strain

\[
S=\frac12(\nabla u+\nabla u^T).
\]

The enstrophy identity (for viscosity \(\nu=1\), modulo the conventional normalization of the strain invariant) is

\[
\frac12 y'(t)+z(t)
=\int_{\mathbb R^3}\omega\cdot S\omega\,dx.
\]

The stretching term is signed and is the core obstruction.

---

## 2. OPEN scalar estimate

A standard scalar route is

\[
\left|\int \omega\cdot S\omega\,dx\right|
\le \|S\|_{L^3}\,\|\omega\|_{L^3}^2.
\]

Using interpolation/Sobolev estimates of the schematic form

\[
\|f\|_{L^3}
\le C_0\,\|f\|_{L^2}^{1/2}\,\|\nabla f\|_{L^2}^{1/2},
\]

one obtains an estimate of the generic form

\[
\left|\int \omega\cdot S\omega\,dx\right|
\le C\, y(t)^{3/4} z(t)^{3/4},
\tag{OPEN}
\]

where the exact numerical constant depends on the precise normalization and on which Sobolev/Calderón–Zygmund constants are inserted.

Young's inequality then gives, for every \(\varepsilon>0\),

\[
C y^{3/4}z^{3/4}
\le \varepsilon z + C_\varepsilon y^3.
\]

Hence the scalar argument produces at best

\[
y'(t) + c\,z(t)
\le C' y(t)^3,
\]

for positive constants \(c,C'\) after choosing \(\varepsilon\) small enough.

This is **not a global a priori enstrophy bound for arbitrary data**. The comparison ODE \(Y'=C'Y^3\) permits finite-time blow-up. Therefore the scalar interpolation route does not close G1.

### Audit conclusion

`OPEN` is a valid inequality class, but it leaves a superlinear positive remainder. Re-optimizing constants does not change this exponent structure.

---

## 3. The CLOSED estimate that would actually close G1

The missing bridge must exploit the **signed geometry** of vortex stretching, not merely an absolute-value estimate.

A sufficiently strong target statement is:

> **G1-CLOSED — geometric depletion (target, unproved here).** There exist constants \(\delta>0\) and \(c_0\ge 0\), uniform on the interval of existence, such that
>
> \[
> \int_{\mathbb R^3}\omega\cdot S\omega\,dx
> \le (1-\delta)\,z(t)-c_0 y(t).
> \tag{CLOSED}
> \]

Inserted into the enstrophy identity, this yields

\[
\frac12 y'(t)+\delta z(t)+c_0y(t)\le 0.
\]

Therefore

\[
y(t)\le y(0)
\]

and

\[
\int_0^T z(t)\,dt\le \frac{y(0)}{2\delta}
\]

for every \(T\) before the putative singular time.

This is the qualitative change required by the audit: the right-hand side becomes **coercive/linear in the dissipative quantity** rather than \(y^{3/4}z^{3/4}\) plus a \(y^3\) remainder.

### Important

`CLOSED` is **not proved in this repository by the scalar inequalities above**. Treating it as a theorem without an independent argument would simply encode the Millennium gap as an axiom.

---

## 4. Why tracelessness alone cannot prove CLOSED

For a traceless symmetric matrix, sign is not fixed. For \(\lambda>0\), define

\[
S_+=\operatorname{diag}(2\lambda,-\lambda,-\lambda),
\qquad
S_-=\operatorname{diag}(\lambda,\lambda,-2\lambda).
\]

Both satisfy

\[
\operatorname{tr}S_\pm=0,
\qquad
|S_+|_F=|S_-|_F=\sqrt6\,\lambda,
\]

while

\[
\operatorname{tr}(S_+^3)=6\lambda^3,
\qquad
\operatorname{tr}(S_-^3)=-6\lambda^3.
\]

Therefore neither incompressibility/tracelessness nor a norm bound alone supplies the sign/coercivity required by `CLOSED`.

---

## 5. Geometric-depletion interpretation

The unresolved mathematical content can be represented abstractly by a depletion factor \(D(t)\) measuring how strongly the actual signed stretching falls below the worst scalar estimate. A safe audit definition is

\[
D(t):=
\begin{cases}
\dfrac{\left|\int \omega\cdot S\omega\,dx\right|}
{C\,y(t)^{3/4}z(t)^{3/4}}, & y(t)z(t)>0,\\[1ex]
0, & y(t)z(t)=0.
\end{cases}
\]

Then the scalar theory only gives

\[
0\le D(t)\le 1.
\]

To close the argument one needs **additional structure** strong enough to convert this dimensionless depletion information into a uniform coercive estimate of type `CLOSED`. A bound \(D(t)<1\) by itself is not enough unless it has the correct scale dependence to absorb the full stretching term into dissipation.

---

## 6. Conditional cascade if G1-CLOSED were proved

The following statements are conditional consequences, not independent proofs of G1.

### 6.1 Uniform enstrophy

`CLOSED` implies

\[
\|\omega\|_{L_t^\infty L_x^2}\le \|\omega_0\|_{L^2}.
\]

### 6.2 Integrated higher derivative control

It also implies

\[
\nabla\omega\in L_t^2L_x^2
\]

with an explicit bound depending on \(\delta\) and the initial enstrophy.

### 6.3 Frequency consequences

Any Littlewood–Paley high-frequency estimate used downstream must be checked separately. In particular, the audit must not infer an \(L_t^\infty L_x^3\) high-frequency bound merely from the time-integrated quantity \(\nabla\omega\in L_t^2L_x^2\) without an additional argument.

### 6.4 ESS endpoint

The Escauriaza–Seregin–Šverák endpoint criterion is an external regularity theorem whose hypotheses must be mapped exactly. A claimed implication

\[
G1\Rightarrow \text{uniform critical }L^3\text{ control}\Rightarrow \text{ESS}\Rightarrow\text{regularity}
\]

is valid only after the intermediate critical bound has been proved with the correct time and space norms.

---

## 7. Lean audit interface

The safe formal architecture is to keep the missing statement explicit:

```lean
/-- Open scalar estimate: schematic audit interface. -/
def G1OpenEstimate : Prop :=
  ∀ t, Stretch t ≤ C * (y t)^(3/4 : ℝ) * (z t)^(3/4 : ℝ)

/-- Missing geometric/coercive bridge. This is NOT proved here. -/
def G1Closed : Prop :=
  ∃ δ c₀ : ℝ,
    0 < δ ∧ 0 ≤ c₀ ∧
    ∀ t, Stretch t ≤ (1 - δ) * z t - c₀ * y t

/-- Pure implication from the enstrophy identity plus G1Closed. -/
theorem g1_closed_implies_enstrophy_decay
    (hbalance : EnstrophyBalance)
    (hG1 : G1Closed) :
    EnstrophyDecay := by
  -- algebraic consequence only
  sorry
```

The theorem above should eventually contain no `sorry`; the `G1Closed` assumption must remain visible until a genuine PDE proof is supplied.

---

## 8. Audit verdict

| Item | Status |
|---|---|
| Enstrophy identity | STANDARD / TO FORMALIZE PRECISELY |
| Scalar interpolation route | PROVED-LOGIC / STANDARD |
| `OPEN`: \(C y^{3/4}z^{3/4}\) structure | ESTABLISHED SCHEMATICALLY |
| Young reduction to \(\varepsilon z+C_\varepsilon y^3\) | PROVED-LOGIC |
| Uniform sign from `tr S = 0` | FALSIFIED |
| Uniform geometric depletion `CLOSED` | OPEN BRIDGE |
| Global regularity from current repository | NOT ESTABLISHED |

---

## 9. Next proof obligation

The next mathematically meaningful task is **not another optimization of scalar constants**. It is one of:

1. prove a non-circular geometric coherence/depletion theorem for vortex stretching that implies `CLOSED`; or
2. weaken `CLOSED` to the sharpest scale-critical signed estimate that is still sufficient to derive a verified ESS hypothesis; or
3. construct a counterexample to the proposed `CLOSED` statement within the class of admissible smooth divergence-free fields, which would force a different bridge.

Until one of those is completed, `G1` remains the unique principal PDE obstruction in this branch of the audit.
