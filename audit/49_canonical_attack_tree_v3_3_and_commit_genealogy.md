# 49 — Canonical Attack Tree v3.3 + historical commit genealogy

## Audit status

This document closes the *audit architecture*, not the Millennium problems. It defines the canonical attack DAG and prevents documentation, numerical evidence, symbolic residue, `sorry`, or imported classical theorems from being conflated.

Canonical registry: `data/attack_tree_v3_3.csv`.

## Rule 0 — the non-negotiable distinction

`mathematical residue != proof gap`.

A residue/defect is a typed mathematical object: `Def`, `Set`, norm, measure, spectrum, obstruction, tail, curvature, etc.

A proof gap is metadata about a declaration: `OPEN`, `CONDITIONAL`, `EXTERNAL_THEOREM`, `INCONSISTENT_SPECIFICATION`, or a source marker such as `sorry/admit/axiom`.

Therefore no audit-safe theorem may use the word residue to hide an incomplete proof, and no `sorry` may be interpreted as a mathematical indeterminacy object.

## Canonical proof-status lattice

1. `PROVED`: kernel/source-clean proof under declared standard dependencies.
2. `PROVED_LOGIC`: abstract logical composition only; does not prove the native mathematical premise.
3. `EXTERNAL_THEOREM`: accepted theorem imported as an interface; exact hypotheses must be mapped.
4. `CONDITIONAL`: theorem follows once explicit hypotheses/open bridges are supplied.
5. `SPECIFIED`: mathematically typed target/definition exists but native theorem is not proved.
6. `OPEN`: decisive mathematical work remains.
7. `INCONSISTENT_SPECIFICATION`: historical statement is false/ill-typed and must be corrected rather than proved.
8. `SOURCE_CLAIM`: source says 'proof/complete/resolved', but audit has not verified the claim.

A file containing `sorry`, `admit`, an undeclared placeholder, or a theorem whose transitive dependency closure reaches one of those markers is not `PROVED`.

## Navier–Stokes canonical chain

The canonical endpoint is not a small-data epsilon theorem. It is the critical endpoint chain

`NS equation -> critical scaling -> HRepo/corrected defect -> coercivity -> L^infinity_t L^3_x -> classical continuation endpoint`.

The historical scalar `epsilon_NS` is retained as a repository observable, not promoted by definition into a sufficient regularity criterion.

### Critical object

`L3NormAtTime(u,t) = ||u(t)||_L3`

`bochnerLInfL3Norm(u,T) = essSup_{0<t<T} ||u(t)||_L3`.

The p=3 exponent is critical under the three-dimensional NS scaling because `1 - 3/p = 0` at p=3.

### Repository observable

`epsilon_NS(u,t) = ||(u.grad)u||_2 / (nu ||Delta u||_2)` on an explicitly defined denominator domain.

`HRepo(u,T,c*)` records an essential-supremum bound on this observable. This is not itself ESS and is not yet known to control the critical norm.

### Decisive bridge

`NS.G4.5 / NS.G5`:

`HRepo(u,T,c*) -> ||u||_{L^infinity(0,T;L^3)} < infinity`.

This is the current NS-B2 target. It must be derived non-circularly from the PDE, not postulated.

The prior audit already found that an L2 residual alone cannot dominate L3 because concentration can send an L2 quantity to zero while L3 diverges. Consequently the corrected defect must retain critical-scale/concentration information.

### Historical genealogy

The attack is not a new September-2026 invention. Relevant recovered anchors include:

- `64bc633ecdb3a90ccfbf1c0863963c4bdd238d0f` — 2025-11-23T02:27:31Z — NS SBFE/I collapse framework.
- `079633d5f7af26576cc9baf0b911e5e0dbdb21f7` — 2025-11-25 — NS numerical class/symbolic formalism.
- `5eee6ce82dda31852cd52db61104c42433ec7ae4` — 2025-11-25 — explicit ESS target in `RegularityCriteria.lean`, historically incomplete.
- `17686f99ff0b79711cbd3d2eac39261ac5d9c6c1`, `09a64f76154950d1180482a3aeca1d3259b64554` — 2025-12-02 — RH/NS Delta correspondence program.
- `f900684c3785ffbd9707291225b2c1751ae3e3eb`, `4af517e3f1ea5d04be1c6bbd8953209fa2139e82`, `54a13fedc2149f4368959d5694fd077010684f58`, `5a888677611ec79eb959f368e941699217487c2d` — 2025-12-18 — projection/obstruction/compression-barrier development.
- `730aa849b0d76b0202f08b490664aa11c164b2bf` — 2025-12-19T17:17:28Z — geometric decomposition + coupling hypothesis.
- `1ed0ded98d26966189fc5936914fd964d42cbd7a`, `0f3ae4e275068f81f516b45b14289dd1a699e659`, `4cb3cd8ae5d24d5b79825346fb59ed47ff95bc9f`, `abdaa41189864f85d3b9f8c8fec6b3ec4431eab5` — 2025-12-19 — residual-stability lineage.
- `469910d3a18d6a2891525da5f1a1a3dd6ec00799` — 2025-12-19T19:53:16Z — NS residual stability + P-vs-NP complexity holonomy.
- `2ceba2ac14e9541561d76307af538ed91817c2af` — 2025-12-19T20:17:38Z — common PNP/NS/YM reformulation module.
- `2469b722f971df80c8a524c696f4c77ceb34817b` — 2025-12-19T20:57:22Z — LRE-UC common projective/residual/curvature schema; historical source itself records axiomatized/open proofs.
- `203ce4ff62809fbcf403ee03e89c3bc70ed608ec` — 2025-12-20T21:16:32+01:00 — historical Lean residual-stability attempt; must be dependency-audited before any `PROVED` classification.
- `6c83e18747fef1faed65a816fa5f4c322d363af9` — 2025-12-27 — Lyapunov/unification/YM infrastructure; recovered diff contains placeholders and `sorry` and is therefore a structural precursor, not a verified NS theorem.

## Riemann canonical chain

The residue is a set, not a numerical counter:

`Residue_RH = {rho | IsNontrivialZero rho and Re(rho) != 1/2}`.

Once `riemannZeta` and `IsNontrivialZero` are exact, `RH <-> Residue_RH = empty` is principally a logical/extensional equivalence. The difficult model-to-mathematics transition is instead zero certification.

The canonical numerical route is:

`candidate rho -> complex ball -> validated zeta enclosure -> argument-principle zero count -> isolated actual zero -> certified Re(rho)`.

A floating-point statement such as `|zeta(rho)| < 1e-100` is evidence of proximity, not a proof that `zeta(rho)=0`.

Historical anchors:

- `b1d2ab7fbdecd7b3acb161d306e23c29f6cc04d8` — 2025-11-23T02:05:34Z — early RH reformulation.
- `dfcab9ce3e216fc7031db42ee5b44341625318e5` — 2025-11-24 — Lean nontrivial-zero/I-collapse framework.
- `2f17a6781c9b5bbe1c3c4609b7dbb9aed78afdcf` — 2025-11-25 — zero-gap/RMT analysis.
- `cd8239300dcd00b384be1e3293ff9638209adf5b` — 2025-11-25 — tail-behavior/formal-verification expansion.
- `f169a3c5955b18eb62e0be98ae52c4bcd59efaa4` — 2025-12-13 — source explicitly calls Rigidity Conjecture the final RH gap; this is strong negative evidence against retroactively calling earlier scaffolds complete proofs.

## P vs NP canonical chain

The corrected residue is propositional:

`Residue_PvsNP := SAT notin P`.

Using Cook-Levin and the standard inclusion `P subset NP`, the classical interface is

`SAT in P <-> P = NP`.

Therefore

`P != NP <-> SAT notin P`.

This fixes the historical temptation to encode P-vs-NP as an arbitrary numerical distance between polynomial and super-polynomial time. The real unresolved obligation is a worst-case lower-bound theorem over the exact computational model/reduction notion.

Historical anchors include:

- current dedicated PNP history rooted in the 2025-11 corpus;
- `3d4d3e51866e03420e97ff3b21dde2a1fca1cc4d` — 2025-12-19 — NS residual stability + PNP formalization;
- `469910d3a18d6a2891525da5f1a1a3dd6ec00799` — 2025-12-19 — complexity holonomy alongside NS.

## Yang–Mills and cross-problem bridge

The canonical audit does not assert `NS = YM`. The shared safe schema is

`state -> constraints/symmetry -> projection/scale decomposition -> critical defect/concentration -> coercivity modulo symmetry -> rigidity/spectral control -> native endpoint`.

For NS the endpoint is a regularity/continuation criterion. For YM the Clay endpoint additionally requires construction of the quantum theory and a positive mass gap. A classical Yang-Mills PDE estimate alone is not the Clay mass-gap theorem.

Historical anchors:

- `8c23634bbb5206d31d127316ceedd9c35627ea9d` — 2025-11-23T02:28:21Z — BSD/Hodge/YM branch.
- `ada0092ee7b3d94232cfbc9f4b9883746d29a484` — 2025-11-23T02:34:36Z — instanton refinement.
- `2ceba2ac14e9541561d76307af538ed91817c2af` — explicit common NS/YM architecture.
- `2469b722f971df80c8a524c696f4c77ceb34817b` — universal LRE-UC schema.
- `6c83e18747fef1faed65a816fa5f4c322d363af9` — later unification/Lyapunov/YM infrastructure with formal gaps.

## Other Millennium bridges

BSD and Hodge remain native bridges, not corollaries of NS/YM. The audit may compare common abstract patterns (local/global, projection, obstruction, spectral/algebraic defect) but must not transfer truth values between unresolved problems without an actual theorem.

The corpus's own Non-Unification Framework is a guardrail: common architecture does not erase irreducible problem-specific obligations.

## Canonical repository layout

The audit-safe target layout is:

- `formal/lean/Common/Measure.lean`
- `formal/lean/Common/Topology.lean`
- `formal/lean/NavierStokes/G0_Foundation.lean`
- `formal/lean/NavierStokes/G1_L3.lean`
- `formal/lean/NavierStokes/G2_Scaling.lean`
- `formal/lean/NavierStokes/G3_HRepo.lean`
- `formal/lean/NavierStokes/G4_Coercivity.lean`
- `formal/lean/NavierStokes/G5_Bridge.lean`
- `formal/lean/NavierStokes/G6_Endpoint.lean`
- `formal/lean/Riemann/G0_Zeta.lean`
- `formal/lean/Riemann/G1_ZeroCert.lean`
- `formal/lean/Riemann/G2_Interval.lean`
- `formal/lean/PvsNP/G0_Complexity.lean`
- `formal/lean/PvsNP/G1_SAT.lean`
- `formal/lean/PvsNP/G2_Residue.lean`
- `formal/lean/YangMills/G0_Foundation.lean`
- `formal/lean/YangMills/G1_CriticalGeometry.lean`
- `formal/lean/YangMills/G2_Coercivity.lean`
- `formal/lean/YangMills/G3_MassGapEndpoint.lean`

This layout is a target. A listed path must not be represented as existing until actually committed.

## Immediate mathematical attack order

1. NS.G4.1: exact nonlinear estimate and types.
2. NS.G4.2: pressure estimate at critical scaling.
3. NS.G4.3: critical-tail/concentration control.
4. NS.G4.4: show HRepo controls the corrected defect, or construct a counterexample and replace HRepo.
5. NS.G4.5: derive `HRepo -> LInfL3`.
6. NS.G6: map exact hypotheses to the external endpoint theorem.
7. Independently: RH rigorous zero certificate, PNP exact machine lower-bound bridge, YM constructive/spectral bridge.

## What is closed and what is not

Closed by this audit revision:

- terminology and status semantics;
- residue-versus-proof-gap distinction;
- canonical IDs/dependencies;
- historical genealogy for the recovered central commits;
- corrected mathematical targets for NS, RH and PNP;
- explicit separation of shared architecture from native Millennium obligations.

Not closed:

- NS.G4.1--G4.5;
- a kernel-clean end-to-end NS proof;
- RH zero/tail certification sufficient for RH;
- a P-vs-NP worst-case lower bound;
- BSD/Hodge native bridges;
- constructive four-dimensional YM plus positive mass gap.

Any future claim of `SOLVED`, `PROVED`, `REFUTED`, or `CLAY_READY` must point to the exact node(s) above that changed status and provide a reproducible proof/build certificate.
