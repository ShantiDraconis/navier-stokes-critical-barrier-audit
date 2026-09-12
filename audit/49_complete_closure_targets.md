# Audit 49 — Complete Closure Targets

Data da auditoria: 2026-09-12  
Base histórica reportada: `b3630bff406e23afab649965107a1d32d996fe53`

## Objetivo

Congelar a forma exata dos lemas que **fechariam** os gaps se fossem provados. Este arquivo não afirma que B2.8, B2.10, RH G8, YM G16, P vs NP G11, BSD ou Hodge estejam resolvidos.

## Constantes-alvo explícitas

- `C_Bernstein = 4`
- `C_Sobolev_R3 = 0.62`
- `C_error = C_Bernstein * C_Sobolev_R3 = 2.48`
- `kappa(nu,Lambda) = nu*Lambda^2/4`
- `cstar = nu/(4*C_Sobolev_R3) ≈ 0.403226 nu`

Os números acima ficam congelados como **TARGETS de pesquisa**. Ser explícito não os torna automaticamente constantes ótimas ou certificadas por teorema.

## Gap matrix

| ID | Lemma CLOSED hipotético | Constante / alvo | Status |
|---|---|---|---|
| B2.8 | signed `Pi` control by `kappa R` plus LP/CZ error | `kappa=nu Lambda^2/4`, `C_error=2.48` | TARGET / OPEN |
| B2.10 | refined hypothesis → critical-tail/Gronwall control → `M3 < ∞` | `C_final` target `0.62/(nu Lambda^2/2)` | TARGET / OPEN |
| RH G8 | Arb/interval arithmetic + Rouché/argument principle on `zeta(B(rho,r))` | `r=0.01`, boundary `|zeta|>=1e-20`, model residual `<=1e-30` | TARGET / OPEN |
| YM G16 | constructive OS measure + Hilbert reconstruction + positive spectral gap | `Delta=1` target normalization | TARGET / OPEN |
| PvsNP G11 | `SAT ∉ P` | unconditional super-polynomial/exponential lower bound target | TARGET / OPEN |
| BSD | algebraic rank = analytic rank plus full leading coefficient statement | residue zero | TARGET / OPEN |
| Hodge | image of cycle class = rational Hodge classes | residue zero | TARGET / OPEN |

## B2.9 — finite-dimensional obstruction proved

Take

`S = diag(1,-0.5,-0.5)`, with `trace(S)=0`, and

`u1=[1,0,0]`, `u2=[0,1,0]`.

Then

- `R1 = 0.5 ||u1||^2 = 0.5`,
- `R2 = 0.5 ||u2||^2 = 0.5`,
- `Pi1 = -u1^T S u1 = -1`,
- `Pi2 = -u2^T S u2 = 0.5`.

Thus `R1 = R2` while `Pi1 != Pi2`. A scalar energy residual does not determine the signed strain/flux pairing.

**Scope:** this closes the matrix obstruction. A full PDE-level B2.9 requires embedding the construction into smooth divergence-free, frequency-localized fields in the admissible Navier–Stokes class.

## Sign-convention release gate

For

`Pi_Lambda = -<P_>(u·∇u),u_>>`

and

`R' + nu ||∇u_>||_2^2 = Pi_Lambda + forcing`,

a coercive decay proof naturally consumes an **upper bound** on `Pi_Lambda`. A lower bound can be used only after consistently reversing the definition/sign convention of flux. Therefore B2.8 and B2.10 must freeze one convention before a closure claim.

Under an upper-bound convention,

`Pi_Lambda <= kappa R_Lambda + E_Lambda`

and spectral coercivity

`||∇u_>||_2^2 >= 2 Lambda^2 R_Lambda`

give

`R'_Lambda + (2 nu Lambda^2-kappa)R_Lambda <= E_Lambda`.

If `a_Lambda=2 nu Lambda^2-kappa>0`, the target Gronwall estimate is

`R_Lambda(T) <= exp(-a_Lambda T)R_Lambda(0) + ∫_0^T exp(-a_Lambda(T-s)) E_Lambda(s) ds`.

Bounded scalar `R_Lambda` alone still does not imply the ESS endpoint. The critical-tail bridge must separately establish the required `L^∞_t L^3_x` control.

## Historical anchors already verified in the audit

- `64bc633ecdb3a90ccfbf1c0863963c4bdd238d0f` — first recovered substantive NS ancestor, 2025-11-23T02:27:31Z.
- `f7f414d2ea66fa7a04d4de390f0e9357dfd980ae` — residual/curvature/coupling foundation, 2025-12-19T13:56:01Z.
- `730aa849b0d76b0202f08b490664aa11c164b2bf` — LRE theorem + NS application/reference-section stage, 2025-12-19T17:17:28Z.
- `2ceba2ac14e9541561d76307af538ed91817c2af` — cross-problem Millennium reformulation infrastructure, 2025-12-19T20:17:38Z; definitions explicitly simplified and requiring heavy integration.
- `2469b722f971df80c8a524c696f4c77ceb34817b` — LRE-UC implementation/template, 2025-12-19T20:57:22Z; master/RBC and equivalences remain axiomatized or unfinished.
- `6c83e18747fef1faed65a816fa5f4c322d363af9` — Lyapunov/circuit/YM infrastructure, 2025-12-27T00:16:32Z; includes `1.0`, `True`, and `sorry` placeholders.

Classification: these are documentary/structural ancestors or conditional formalizations. None is classified here as a Millennium closure proof.

## Closure-commit acceptance criterion

A future closure commit must contain the relevant real definitions and proof chain with:

1. no `sorry` on the closure dependency path;
2. no `axiom ... OPEN/TARGET` consumed by the final theorem;
3. no `True`/constant placeholders standing in for mathematical obligations;
4. no circular assumption of the desired regularity/gap/conjecture;
5. `lake build`/CI green at the exact SHA;
6. dependency audit showing the final theorem's complete axiom footprint.

For NS specifically, the decisive files would be a sign-consistent B2.8 flux-control proof and B2.10 critical-tail/ESS bridge. No historical SHA currently catalogued satisfies this criterion.
