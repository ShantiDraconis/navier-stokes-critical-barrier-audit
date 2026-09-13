# 47 — NS-B2 critical-tail derivation and cross-problem source map

Status: rigorous derivation of what can and cannot follow from the current defect architecture. No Millennium-problem solution is claimed.

## 1. Decisive obstruction: an L2 projection residual cannot by itself control L3

Take a nonzero smooth compactly supported scalar profile `phi` on R^3 and define

`f_n(x) = n^alpha phi(nx)`.

Then for every `1 <= p < infinity`,

`||f_n||_Lp = n^(alpha - 3/p) ||phi||_Lp`.

Choose `1 < alpha < 3/2`, for example `alpha = 5/4`. Then

`||f_n||_L2 = n^(-1/4) ||phi||_L2 -> 0`,

while

`||f_n||_L3 = n^(1/4) ||phi||_L3 -> infinity`.

The same scaling mechanism can be embedded in smooth divergence-free vector fields by choosing a smooth compactly supported vector potential `A` and setting

`u_n = curl(n^(alpha-1) A(nx))`,

so `u_n` has the same amplitude/length scaling and `div u_n = 0`.

Therefore no universal estimate of the form

`||u||_L3 <= F(||u - Pi_N u||_L2, energy-data)`

can hold for arbitrary concentrated states unless `F` also contains concentration/frequency information strong enough to rule out this scaling.

Audit consequence:

`R_N(u) = ||u-Pi_Nu||_L2`

is a useful approximation residual but is not by itself a critical coercive defect for NS-B2.

## 2. Littlewood-Paley repair

Let `Delta_j` denote dyadic Littlewood-Paley projectors and choose an integer cutoff J. Split

`u = P_{<=J}u + P_{>J}u`.

For the low-frequency component, Bernstein gives in dimension 3

`||Delta_j u||_L3 <= C 2^(j/2) ||Delta_j u||_L2`.

Summing `j<=J` yields a bound of the schematic form

`||P_{<=J}u||_L3 <= C 2^(J/2) ||u||_L2`.

Define the critical high-frequency tail

`H_J(u) = sum_{j>J} ||Delta_j u||_L3`.

Then

`||u||_L3 <= C 2^(J/2)||u||_L2 + H_J(u)`.

Hence the energy inequality controls the low-frequency term, while a uniform critical-tail estimate controls the high-frequency term.

This is a genuine coercive architecture because both sides have the correct critical information. It does not yet prove the required uniform bound on `H_J`.

## 3. Candidate corrected defect

A useful corrected defect is not a single L2 number. Use a vector

`D_crit(u,p;J,r) = (H_J, C_r, P_r, N_r, F_r, A_r)`

where, schematically:

- `H_J = sum_{j>J} ||Delta_j u||_L3` — critical high-frequency tail;
- `C_r = r^{-2} int_{Q_r} |u|^3` or another scale-invariant concentration coordinate;
- `P_r = r^{-2} int_{Q_r} |p|^(3/2)` — pressure coordinate;
- `N_r` — nonlinear/paraproduct interaction defect;
- `F_r` — forcing/support/scaling defect;
- `A_r` — admissibility defect (divergence, solution class, local energy inequality, etc.).

A scalarization may be used for optimization,

`Phi = sum_i w_i D_i`,

but the proof must preserve the individual critical coordinates because a weighted scalar can hide a diverging component.

## 4. A provable bridge skeleton

Assume for every `t<T`:

1. energy bound: `||u(t)||_L2 <= E0`;
2. a fixed cutoff J exists with `H_J(u(t)) <= H0`.

Then

`||u(t)||_L3 <= C 2^(J/2) E0 + H0`.

Therefore

`sup_{t<T} ||u(t)||_L3 < infinity`.

At this point the critical endpoint regularity theorem may be invoked provided its exact solution/domain hypotheses are satisfied.

This reduces NS-B2 to a sharper obligation:

**NS-B2a — Critical-tail theorem.** Prove that the repository dynamics/defect architecture yields a uniform bound on `H_J` for some admissible cutoff mechanism without presupposing regularity.

## 5. Why a moving cutoff is dangerous

If `J=J(t)->infinity`, then the low-frequency factor `2^(J(t)/2)E0` can diverge. Thus frequency localization alone does not close NS-B2. A successful criterion must either:

- control the moving low-frequency contribution more sharply;
- control only a finite critical window known to contain all dangerous frequencies;
- use a scale-invariant Besov/Lorentz quantity;
- or derive an epsilon-regularity/critical-element rigidity argument that excludes concentration.

This is consistent with known frequency-localized regularity criteria: dangerous frequencies can be isolated, but ruling out their growth remains the substantive step.

## 6. Pressure and nonlinearity

For incompressible NS,

`-Delta p = partial_i partial_j (u_i u_j)`

in the standard whole-space setting. Calderon-Zygmund/Riesz transform estimates therefore place pressure naturally at the scale

`u in L3  =>  p in L^(3/2)`.

The critical local pair is consequently

`|u|^3 + |p|^(3/2)`.

This is the same dimensional pairing that appears in epsilon-regularity theory. A corrected defect should track pressure rather than assume it can be canceled independently.

For the nonlinearity, Bony's paraproduct decomposition

`u dot grad u = T_u grad u + T_{grad u}u + R(u,grad u)`

splits low-high, high-low and high-high interactions. A candidate proof must show that the chosen critical-tail coordinates control every interaction channel.

## 7. Concentration-compactness/rigidity route

The strongest reusable architecture from other critical PDE is:

1. Assume the desired critical-tail bound fails.
2. Construct a minimal bad/critical element by profile decomposition.
3. Prove precompactness modulo the Navier-Stokes scaling/translation symmetries.
4. Derive a rigidity theorem excluding the critical element.
5. Conclude the critical-tail bound.

This is structurally close to the audit language:

`projection -> residual -> minimal obstruction -> compact state -> correction/rigidity -> obstruction=0`.

The rigidity step is problem-specific and cannot be imported for free.

## 8. What the other Millennium problems can contribute

No unresolved Millennium problem currently supplies a theorem that solves Navier-Stokes. Their value is methodological/structural.

### Yang-Mills mass gap

Strongest analogy. Yang-Mills and Yang-Mills heat flow exhibit critical scaling, epsilon-regularity, concentration/bubbling, gauge constraints, and spectral/coercive gaps. Useful imported ideas:

- gauge fixing as admissibility preservation;
- epsilon-regularity;
- concentration quantization/bubbling;
- coercivity modulo symmetry;
- spectral gap as a rigidity mechanism.

This can inspire NS critical-defect design but does not prove NS.

### Hodge conjecture

Hodge theory contributes the language of orthogonal decomposition, elliptic projection and harmonic representatives. The Helmholtz-Leray projection used in incompressible flow is itself a close analytic relative of Hodge decomposition. Useful imported ideas:

- split exact/coexact/harmonic components;
- project onto divergence-free states;
- isolate topological/nullspace obstructions;
- use elliptic estimates on the projected complement.

Again, this is structural, not a solution transfer.

### Riemann hypothesis

The most relevant transferable ideas are spectral positivity/coercivity and trace-formula style decomposition, not zero locations themselves. A hypothetical positive operator whose quadratic form dominates a critical NS defect would be useful, but no RH result currently provides such an operator for NS.

### P vs NP

Useful for certificate architecture and adversarial verification:

- distinguish witness search from proof verification;
- search for finite counterexamples efficiently;
- encode dependency DAGs and proof certificates.

It contributes methodology, not an analytic estimate.

### BSD

Local-to-global and rank-defect philosophies are useful audit analogies: many local conditions do not automatically imply the global arithmetic statement. This mirrors the warning that local or mean NS defect closure needs a theorem to reach global critical control.

## 9. Other mathematical problems/theories that are more directly useful than the other Millennium problems

### Critical dispersive PDE

NLS, nonlinear wave and wave maps supply the Kenig-Merle concentration-compactness/rigidity paradigm. This is one of the strongest direct sources for a corrected NS-B2 strategy.

### Harmonic-map and Yang-Mills heat flows

These parabolic geometric flows supply monotonicity, epsilon-regularity and blow-up rescaling mechanisms that are structurally close to NS singularity analysis.

### Calderon-Zygmund harmonic analysis

Needed for pressure reconstruction and singular-integral estimates.

### Littlewood-Paley/Besov theory

Needed to distinguish low/high frequencies and encode scale-critical information.

### Geometric measure theory / partial regularity

CKN-type singular-set analysis and epsilon-regularity show how small scale-invariant local quantities exclude singularities.

### Unique continuation / Carleman estimates

Backward uniqueness is central in the classical `L^infinity_t L^3_x` endpoint route.

### Renormalization / critical phenomena

Useful conceptual language for tracking quantities invariant under NS scaling; not itself a proof method unless translated into rigorous estimates.

### Optimal control / Lyapunov theory

Useful for constructing correction operators and monotone diagnostics, but contraction of an arbitrary defect is insufficient without coercivity to a critical PDE norm.

## 10. Scientific evidence hierarchy

1. **Theorem-level evidence**: endpoint regularity, epsilon-regularity, frequency-localized criteria, profile decomposition.
2. **Formal proof evidence**: kernel-checked logical/finite-dimensional parts.
3. **Rigorous numerical evidence**: interval/validated numerics for finite subproblems.
4. **Ordinary numerical evidence**: stress tests and counterexample searches; never proof of the infinite theorem.
5. **Physical/biological analogies**: useful for proposing operators and invariants; no theorem status.

## 11. Current candidate resolution program

The most defensible next theorem chain is:

`energy + admissibility`

`=> dyadic decomposition`

`=> critical-tail/concentration defect`

`=> profile decomposition if defect becomes unbounded`

`=> minimal critical element`

`=> rigidity/unique-continuation contradiction`

`=> uniform critical-tail control`

`=> uniform L3 control`

`=> endpoint continuation`.

The currently proved new fact is the negative one: **L2 residual control alone is insufficient**. The positive critical-tail bridge remains an open theorem target.

## 12. Sources to cite in the manuscript

- Escauriaza, Seregin, Sverak, `L_{3,infinity}` solutions and backward uniqueness, Russian Math. Surveys 58 (2003), DOI 10.1070/RM2003v058n02ABEH000609.
- Gallagher, Koch, Planchon, profile decomposition approach to the `L^infinity_t(L^3_x)` criterion, Math. Ann. 355 (2013), DOI 10.1007/s00208-012-0830-0.
- Kenig, Koch, critical-space concentration-compactness approach, Ann. IHP 28 (2011), DOI 10.1016/j.anihpc.2010.10.004.
- Bradshaw, Grujic, frequency localized regularity criteria, Arch. Ration. Mech. Anal., DOI 10.1007/s00205-016-1069-9.
- Caffarelli, Kohn, Nirenberg, partial regularity/epsilon regularity for suitable weak solutions.
- Perelman, entropy formula for Ricci flow, arXiv:math/0211159, as a methodological example of monotone quantity + non-collapsing + singularity control, not as an NS theorem.
