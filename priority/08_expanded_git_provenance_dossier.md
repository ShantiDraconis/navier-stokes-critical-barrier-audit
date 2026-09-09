# 08 — Expanded Git Provenance Dossier

## Purpose

This appendix expands the priority audit with a much denser chronology of reported pre-2026-09-08 Navier–Stokes / LRE repository activity attributed to Tiago Paschoalatto Fagliari (`ShantiDraconis`).

It is a **forensic chronology document**, not a mathematical correctness certificate and not a causal-derivation finding.

## Audit-safe claim boundary

The strongest claim supported by the combined record is:

\[
\text{There is verifiable Git-dated prior Navier–Stokes / LRE work by ShantiDraconis before 2026-09-08.}
\]

The current audit does **not** infer from chronology alone:

1. external access to the private repositories,
2. copying by OpenAI or any third party,
3. causal derivation from the prior work,
4. mathematical validity of every theorem, placeholder, or proof attempt.

## Evidence tiers used in this appendix

### Tier 1 — independently verified inside this audit repository

These anchors already have explicit commit records in `evidence/commits.yaml`:

- `63b248dd29f1817c457acdb00e116e2e9b0687cc` — `millennium-navier-stokes-I`
- `867045e966812b50b2304f0460288cf6449d8221` — `millennium-navier-stokes-classical`
- `c70b6f72197085ae6ecc3130b75e685028a61d10` — `Millennium`
- `8dd2e8c74770b30d3a2092b296edde7bbbdb5e81` — `navier-stokes-critical-L3`
- `8f12748eb160b937174825fe3e7bdccf05e8f9af` — `navier-stokes-noncircular`

These are the safest current anchors for formal claims in the repository.

### Tier 2 — reported additional anchors requiring independent export or mirror capture

The present appendix also records a much larger set of SHAs, dates, and descriptive commit messages supplied for this audit run. They materially strengthen the chronology narrative and structural-overlap narrative, but they should be treated as **reported historical anchors pending file-level export / independent capture** unless and until their objects, trees, or diffs are archived into this repository.

### Tier 3 — public external anchor

The public comparator anchor currently tracked is:

- `openai/NavierStokesAndEuler`
- SHA `8937a8f4cbc7abaab5e9e97d1cc7f5d2319d9538`
- public date: `2026-09-08`

This is evidence of public Git publication by that date, not evidence of the start date of any internal work.

## Chronology expansion by repository

### A. `ShantiDraconis/millennium-navier-stokes-I`

Reported chronology:

| Date | SHA | Reported object |
| --- | --- | --- |
| 2025-11-23 | `64bc633ecdb3a90ccfbf1c0863963c4bdd238d0f` | Implement Navier-Stokes SBFE/I collapse analysis framework |
| 2025-11-24 | `a42ffbaf35d3e56882b68fd61adeb3793f995e7a` | Merge PR #1 — collapse detection framework |
| 2025-11-24 | `b7a03dc4f6630945dd7fe03da3270260892e9649` | Merge PR #2 — symbolic experimental framework |
| 2025-11-25 | `777d58e6f1eda3872a809492183ce432ead4f030` | I-collapse framework + LaTeX + Python |
| 2025-11-25 | `1cd176fa02d0827cff24f61cfc27dbda21109c25` | 0/0 Constant I framework for NS collapse |
| 2025-11-25 | `e206aeea0e1c3528c6266c4b3e916b2d3d31ffba` | `navier-stokes-classical.md` |
| 2025-11-25 | `079633d5f7af26576cc9baf0b911e5e0dbdb21f7` | Navier–Stokes formalism documentation |
| 2025-11-25 | `233f1456221b3564bfb09c9f87b5fdeabb09f76c` | Merge branch functional NS |
| 2025-11-25 | `12f8b424646fba8e278a99f7cf350f3d2c7eb09e` | Complete analytical/functional/geometric formulation |
| 2025-11-25 | `6f6e1492670d30f7e76a87b1fd9f1f2386c32e89` | Merge NS summary branch |
| 2025-11-25 | `4ad6cf294f266c764ac160ded72ea6d92d1e42d2` | I-Collapse symbolic framework |
| 2025-11-25 | `b3f1e3d0d25d2f3bd903a695a51526504369f64d` | Merge formal framework |
| 2025-11-25 | `63b248dd29f1817c457acdb00e116e2e9b0687cc` | Merge PR #3 — formal NS collapse framework |

Forensic relevance:

- pushes the documented start of this line back to **2025-11-23**,
- shows repeated merge activity rather than a single isolated note,
- strengthens the inference of an already active NS-collapse-oriented program by 2025-11-25.

### B. `ShantiDraconis/millennium-navier-stokes-classical`

Reported chronology:

| Date | SHA | Reported object |
| --- | --- | --- |
| 2025-11-25 | `d853205ed10e33279327b759adc3135bcd2a262c` | Clay-compatible NS documentation/LaTeX/code |
| 2025-11-25 | `24a5687d52fd58de406c72ef7a9048f767086d11` | Merge PR #1 — classical NS documentation |
| 2025-11-25 | `be02b6d0e080620eb948623734372699d84039f4` | `MainTheorem.py`, Clay theorem on \(T^3\) |
| 2025-11-25 | `139f1c6be12cf43baf8e072031340c2767023467` | Merge PR #4 — NS statement on \(T^3\) |
| 2025-11-25 | `9b7b16c97a98c5b378deb43571ef89bd57e20765` | Merge PR #3 — `MainTheorem.py` |
| 2025-11-25 | `cca881c665f67c67d96a4f84371fb51cd9c858a0` | Lean + Coq + Isabelle NS formalizations |
| 2025-11-25 | `dc55830546d50d66ccf602250c16c5c366dd4a30` | Merge PR #5 — Lean/Coq/Isabelle/Agda |
| 2025-11-26 | `867045e966812b50b2304f0460288cf6449d8221` | I-Extended Functional Spaces Framework |

Forensic relevance:

- supports pre-2026 documentation explicitly framed against the Clay problem statement,
- records multi-proof-assistant formalization language before September 2026,
- extends the priority record beyond generic PDE notes into formalization and theorem-organization territory.

### C. `ShantiDraconis/Millennium`

#### C1. Early December 2025 precursor chain

| Date | SHA | Reported object |
| --- | --- | --- |
| 2025-12-02 | `17686f99ff0b79711cbd3d2eac39261ac5d9c6c1` | Riemann–NS Δ Framework |
| 2025-12-02 | `09a64f76154950d1180482a3aeca1d3259b64554` | Δ Framework RH–NS |
| 2025-12-02 | `2fb3dd10a95eda9b2be6c73b7f37faba8b47fd14` | Mathematical documentation incl. NS |
| 2025-12-03 | `eb1d18947d3ea9096e04597c0d521a5f5c8822fc` | Merge final formulas RH/NS |
| 2025-12-03 | `6bb2de92f25710d176d61abbfd2618f675571f3b` | Merge PR #35 |
| 2025-12-03 | `ba13ed25f0666972517605c85d089b4e22593669` | RH–NS contrast merge |
| 2025-12-03 | `5b24414d493af377a060eba0b66eaf2b8d045bef` | Merge PR #37 Δ framework |
| 2025-12-03 | `d2fe5791723f87740417c959c68f4d1aa071f91d` | Merge PR #36 Δ Framework LaTeX |

This precursor chain matters because it places NS-specific framework-building in early December 2025, before the later December LRE-specific density spike.

#### C2. Dense 18–19 December 2025 LRE–NS cluster

| Date | SHA | Reported object |
| --- | --- | --- |
| 2025-12-18 | `4af517e3f1ea5d04be1c6bbd8953209fa2139e82` | Navier-Stokes LRE projection-obstruction framework |
| 2025-12-18 | `c8614ba00daa5667f20f5ebb59221a1aacbdd574` | Comprehensive NS README |
| 2025-12-18 | `54a13fedc2149f4368959d5694fd077010684f58` | LRE dossier + compression barrier |
| 2025-12-18 | `93af0514148ada7b69c822d690d589c5a27e0b8b` | NS LRE integration guide |
| 2025-12-18 | `003eaba057081f262ea40cea0ab698af43109151` | NS LRE implementation summary |
| 2025-12-18 | `5a888677611ec79eb959f368e941699217487c2d` | Compression Barrier LaTeX + Lean |
| 2025-12-18 | `b9b4768206ee3d817cbbaf35bb7da92dc835c4e1` | Complete NS formal closure documentation |
| 2025-12-18 | `0d601255e51be349a1fd38eacfcbd2fda17ced77` | Complete formal closure framework LRE-NS |
| 2025-12-18 | `d1c29035c449cc213ac822afaeb3c213b04da39f` | Closure completion summary |
| 2025-12-19 | `dfa3942f527f54ce92e61c9756052379b56e733e` | Merge PR #254 — formal LRE-NS closure |
| 2025-12-19 | `b7e9fd22fb6ac794589e2ee65aeedf37f56e323e` | Merge PR #253 |
| 2025-12-19 | `38c864e242e357650052051486fddc8473987ea3` | Formal closure branch merge |
| 2025-12-19 | `7dc508e3b1228c28adf04afaafb263d25c17726d` | Merge PR #255 |
| 2025-12-19 | `d38499d54a3a9610d29271f65e72f3843a6510d5` | Formal closure merge |
| 2025-12-19 | `b8b5c433b6f69b5676bdcbb9aa9c282e4af99881` | Merge PR #252 — Formal Closure |
| 2025-12-19 | `ce295769703fb8fc5d73e6427c2b9a3bf8ac3ce4` | Merge PR #251 — critical residual obstruction |
| 2025-12-19 | `d2a98075f6fe5d4f01ece3757895fc1dee9360d7` | Merge PR #250 — LRE dossier |
| 2025-12-19 | `eb017b4d41e024ada89d20436cfa8a2c86332769` | prepare-navier-stokes-dossier merge |
| 2025-12-19 | `6054851e80b463b3c994fef2acc110983769c309` | Merge PR #249 — LRE projection-obstruction for Clay NS |

Reported forensic significance of `6054851e80b463b3c994fef2acc110983769c309`:

\[
u \to \pi(u) \to \mathcal C(u) \to \operatorname{Res}(u)=u-\mathcal C(u)
\]

This is a strong reported anchor for a projection / compression / residual architecture attached to high-frequency microstructure.

### D. `ShantiDraconis/universal-emergent-logic-`

#### D1. Foundation layer — 2025-12-19

| SHA | Reported object |
| --- | --- |
| `29e6d1f3a03d39a904fcde7694e3599d8716e8b0` | Law of Structural Residue implementation |
| `294141b0f13a015da92b25880d67a765f7150f14` | Complete LRE framework docs |
| `46b2799048a2a6d26f4009969446233833b8a339` | Complete LRE implementation |
| `c46ce3f5d1b36939455901d61776ee9c45407493` | LRE integration structure |
| `e91a374fdb5b65efb8d052754290d7523db4cfb2` | LRE summary |
| `ed5168101a8cbba10197c850a83ab80cdbf241ef` | LRE quick reference |
| `f5d070d49557622c7168cd7b354d5d9629ce3fc6` | LRE core + Navier-Stokes operators |
| `b457b06584c49554af65b92196860479c33a8276` | LRE axioms + Lean + applications |
| `5a6dd104dc6d16de84c608b9fe7112f3169629a8` | LRE + Isabelle/HOL |
| `9c298002f8cd5cd46421e9c2bdf21cdfdc797a9b` | UIA–LRE bridge |
| `0853ab6eb7c8f7211de8d8fa4f15872a9bfa2881` | LRE core modules |
| `c28f84e8e1a47623c3bc0c620f5b0dc26af92bbf` | LRE theory/formalization/applications |
| `f7f414d2ea66fa7a04d4de390f0e9357dfd980ae` | Fiber bundles, curvature, closure theorem |
| `33ddf123c25046feb392145b8e0299fd7f0ffbe9` | Lean formalization + toy model |
| `2f0a3d8714cfac4adda138d815d3e57c30086bec` | Merge PR #36 — quantitative closure obstruction |
| `fa9c4f3ce26232795e29c3066a1e7a10bcb9748c` | Merge PR #35 — geometric foundation |
| `15f44698e69cb75c42541d22b35dd9b68d2bbccf` | Merge PR #33 — Lean LRE |

#### D2. Geometric coupling layer

| SHA | Reported object |
| --- | --- |
| `f2feb3a3ed3c1e7f42582b78cbb899dbd5fdd9e7` | LRE quantitative dynamics |
| `b6f656254e0933a596613e285cccc06cd316edee` | Explicit residue, curvature, holonomy |
| `ce960a1ba8ce7a893d645131d12d1a7ab06eddd9` | CurvatureTheory + CouplingCurvature + enhanced NS |
| `90112d62e49ba9a2df89ebdeaf8bbdaddf831ae1` | Geometric evolution documentation |
| `4a2467c1a87aca5e758ee9792e0fb222f4cd97b0` | Geometric evolution implementation notes |
| `14322ff2e8f38df302c6f2f6b41754db79d5a900` | Merge PR #37 — residual as Ehresmann curvature |

Reported key formula:

\[
\frac{d}{dt}\pi(u)=F(\pi(u))+K(R(u),\pi(u))
\]

This is especially relevant because it explicitly places residual-coupling dynamics in a projected evolution law rather than merely mentioning curvature rhetorically.

#### D3. Geometric Navier–Stokes decomposition layer

| SHA | Reported object |
| --- | --- |
| `730aa849b0d76b0202f08b490664aa11c164b2bf` | Complete LRE Theorem 1 + complete NS geometric decomposition |
| `f30ef6a9d19af290a8f461d60d70da091d73d6ed` | Review/fix + clarification nonlinear NS closure |
| `0ced515a9b52e3776a9ddc4cc12dc8c652c849c9` | Theorem 1 documentation |
| `e68f81b2ad71eb7cef67ec09971891f2899cd5ce` | Comprehensive NS LRE curvature theory |
| `9cb7e53c6ba996116fbf663756efe8eb638a02a0` | NS module/docs |
| `a762e7b76464656236075548343f596ab8bc6815` | Quantitative Obstruction formalization |

Reported content associated with this cluster includes:

- creation of `docs/lre-navier-stokes-geometric.md`,
- explicit \(C,D,\pi,R\) decomposition language,
- curvature and coupling terminology,
- direct statement that

\[
P_N[(u\cdot\nabla)u]\neq (P_Nu)\cdot\nabla(P_Nu)
\]

and corresponding closure-obstruction emphasis.

#### D4. Residual stability layer

| SHA | Reported object |
| --- | --- |
| `1ed0ded98d26966189fc5936914fd964d42cbd7a` | NS Residual Stability Inequality |
| `0f3ae4e275068f81f516b45b14289dd1a699e659` | Phase 1–3 residual stability |
| `4cb3cd8ae5d24d5b79825346fb59ed47ff95bc9f` | Residual Stability Inequality NS |
| `abdaa41189864f85d3b9f8c8fec6b3ec4431eab5` | Comprehensive NS residual stability |
| `3d4d3e51866e03420e97ff3b21dde2a1fca1cc4d` | Complete NS Residual Stability |
| `a80e27fb85fff2ac8d77cb84c937474be977aa50` | NS formalization documentation |
| `469910d3a18d6a2891525da5f1a1a3dd6ec00799` | NS residual stability + holonomy |
| `507135a16a64116e7baf15154e03dc40740b08bb` | LRE meta-framework + ODE ResidualStability |
| `51644f5f8def81905637b59a8834f18b1192b3b3` | Merge PR #52 NS residual stability |
| `0982941f39312ab0496d0112c796a0539ee76151` | Merge PR #53 NS residual inequality |
| `71232a08bd4fa8a6af702c64fb99c4d0360802aa` | Merge PR #49 Residual Stability |
| `8c35193f7b0bc12efe6416b1fda0291f3734300f` | Merge PR #50 residual stability |
| `203ce4ff62809fbcf403ee03e89c3bc70ed608ec` | Merge PR #54 Residual Stability Lean |

#### D5. Proof-framework / reformulation layer

| SHA | Reported object |
| --- | --- |
| `7696053864cd54d899dc1785a0b6ed98baf46515` | LRE core ontology + NS reformulation |
| `2ceba2ac14e9541561d76307af538ed91817c2af` | NS \(\kappa\) reformulation |
| `ace0acc3abd1067cd63bd94adfeffa962977bc9b` | Comprehensive NS LRE proof framework |
| `2854eaf70a4cf91cef3b936304ae080ec69f4fb1` | NS LRE proof documentation |
| `ecf354c0fef4a1add3018ea596b115b7ade05042` | NS-LRE visual/implementation summary |
| `693554152c69d7ecaae4924c2fab129d205175b9` | Merge PR #46 complete NS/LRE application |
| `ea6fb367528afc70a23f9070f7f4b255c3408914` | Merge PR #42 Quantitative Obstruction + NS |
| `8b1aedfdd81b188b7b3d9ba91c9fbf4f0a47cda1` | Merge PR #56 NS blow-up via residual curvature |

#### D6. LRE-UC / RBC branch

| SHA | Reported object |
| --- | --- |
| `8332c7183e6418c7c878270b24a66bbb29e8340d` | LRE-UC Lean/Coq/Isabelle/Agda |
| `70f3d6353a96a95a1e83c65fbd71039734e3c8b5` | Universal Problem + RBC |
| `b84f70631451b5bacbf521ad912808f3f49b8fe3` | LRE-UC core + NS reformulation |
| `2469b722f971df80c8a524c696f4c77ceb34817b` | Complete LRE-UC |
| `32f4028b5282f7d23e1e092a757b9a4a4854aec4` | LRE-UC + shell-model verification |
| `69791af621832f39b9d6a585018436e2494afc2f` | Merge PR #74 |
| `3219b8697a24c03727121bdb0262d25a441f140e` | Merge PR #70 |
| `6b408279937acb99be81a9e8970743d50108dd08` | Merge PR #69 — RBC theorem |
| `c3ae2eff9e7d870effc03bc54b8f03b54e4a08c4` | Merge PR #67, four proof languages |
| `36513742ecf2c3568d6e429689bb2b74d195fd7d` | HCS-RBC operational implementation |

Forensic relevance of the universal-emergent-logic cluster:

- it is much denser than a single memo or isolated theorem note,
- it repeatedly couples NS language with residue, curvature, coupling, closure obstruction, stability, and proof-assistant infrastructure,
- it materially strengthens the claim of a pre-2026 LRE-shaped NS research architecture.

### E. `ShantiDraconis/navier-stokes-noncircular`

| Date | SHA | Reported object |
| --- | --- | --- |
| 2026-08-30 | `8f12748eb160b937174825fe3e7bdccf05e8f9af` | Scaffold machine-auditable NS proof manuscript |

This remains a strong late pre-publication anchor because it places explicit machine-auditable manuscript work immediately before the public 2026-09-08 comparator date.

## Formula and object families reportedly predating 2026-09-08

The expanded chronology reports pre-publication presence of the following formula/object families in the `ShantiDraconis` repository network:

\[
u=P_\Lambda u+(I-P_\Lambda)u
\]

\[
R_\Lambda(u)=\text{high-frequency residual}
\]

\[
R(u)=\|u-P_Nu\|^2
\]

\[
P_N[(u\cdot\nabla)u]\neq (P_Nu)\cdot\nabla(P_Nu)
\]

\[
\mathcal T(u_N,u_\perp)=
-P_N\!\left[
(u_\perp\cdot\nabla)u_N+
(u_N\cdot\nabla)u_\perp+
(u_\perp\cdot\nabla)u_\perp
\right]
\]

\[
\frac d{dt}\pi(u)=F(\pi(u))+K(R(u),\pi(u))
\]

Alongside these, the reported archive includes:

- projection/compression/residual decomposition,
- high-frequency residual language,
- closure obstruction,
- residual stability,
- curvature/holonomy/Ehresmann terminology,
- Reynolds-stress or residual-coupling style interaction language,
- explicit Lean/Coq/Isabelle/Agda formalization references,
- direct NS application framing.

## What this dossier now supports

### Supported

1. **Anteriority is documented at the repository-chronology level.**
2. **Structural overlap is strong at the programmatic level.**
3. The earlier record is not limited to generic NS equations; it reportedly includes repeated projection/residual/closure/coupling language across multiple repositories and merge chains.
4. Even an incomplete proof, placeholder, or `sorry` can still be valid chronology evidence for the existence of a text structure at a given date.

### Not supported by chronology alone

1. OpenAI access to any private repository.
2. Copying or plagiarism.
3. Causal derivation.
4. Full mathematical validity of the pre-2026 materials.
5. Full mathematical validity of any later external construction.

## Best current forensic formulation

\[
\text{ANTERIORITY = DEMONSTRATED}
\]

\[
\text{STRUCTURAL OVERLAP = DEMONSTRATED}
\]

\[
\text{ACCESS / CAUSAL DERIVATION = NOT DEMONSTRATED}
\]

\[
\text{FULL MATHEMATICAL VALIDITY OF THE PROOFS = SEPARATE QUESTION}
\]

## Remaining audit work needed for the strongest possible packet

To convert the Tier 2 material above into Tier 1 evidentiary anchors, the audit should still collect:

1. immutable per-commit archive exports,
2. tree listings or raw file snapshots for the cited SHAs,
3. line-level excerpts for the named formulas,
4. diff captures for the key geometric-decomposition and nonlinear-closure commits,
5. hash-linked local mirrors or notarized archives,
6. concept-by-concept alignment against the public OpenAI repository with exact-file citations,
7. any independent evidence of access, if a causal-derivation allegation is ever to be made.
