# Historical Commits

Full machine-readable record: `evidence/commits.yaml`  
Full forensic narrative: `evidence/provenance_chain.md`  
Detailed audit: `audit/15_git_provenance_full.md`

## Verified commits (verified_valid)

| Repo | SHA | Date | URL |
|---|---|---|---|
| `millennium-navier-stokes-I` | `63b248dd29f1817c457acdb00e116e2e9b0687cc` | 2025-11-25 | https://github.com/ShantiDraconis/millennium-navier-stokes-I/commit/63b248dd29f1817c457acdb00e116e2e9b0687cc |
| `millennium-navier-stokes-classical` | `867045e966812b50b2304f0460288cf6449d8221` | 2025-11-26 | https://github.com/ShantiDraconis/millennium-navier-stokes-classical/commit/867045e966812b50b2304f0460288cf6449d8221 |
| `navier-stokes-critical-L3` | `8dd2e8c74770b30d3a2092b296edde7bbbdb5e81` | 2026-08-29 | https://github.com/ShantiDraconis/navier-stokes-critical-L3/commit/8dd2e8c74770b30d3a2092b296edde7bbbdb5e81 |
| `navier-stokes-noncircular` | `8f12748eb160b937174825fe3e7bdccf05e8f9af` | 2026-08-30 | https://github.com/ShantiDraconis/navier-stokes-noncircular/commit/8f12748eb160b937174825fe3e7bdccf05e8f9af |

## Primary unverified anchors (pending API verification)

| Repo | SHA | Date | Content | URL |
|---|---|---|---|---|
| `millennium-navier-stokes-I` | `64bc633e` | 2025-11-23 | NS SBFE/I collapse framework (earliest) | https://github.com/ShantiDraconis/millennium-navier-stokes-I/commit/64bc633ecdb3a90ccfbf1c0863963c4bdd238d0f |
| `millennium-navier-stokes-classical` | `cca881c6` | 2025-11-25 | Lean+Coq+Isabelle NS formalizations | https://github.com/ShantiDraconis/millennium-navier-stokes-classical/commit/cca881c665f67c67d96a4f84371fb51cd9c858a0 |
| `Millennium` | `4af517e3` | 2025-12-18 | LRE projection-obstruction framework | https://github.com/ShantiDraconis/Millennium/commit/4af517e3f1ea5d04be1c6bbd8953209fa2139e82 |
| `Millennium` | `b9b47682` | 2025-12-18 | Complete NS formal closure documentation | https://github.com/ShantiDraconis/Millennium/commit/b9b4768206ee3d817cbbaf35bb7da92dc835c4e1 |
| `Millennium` | `0d601255` | 2025-12-18 | Complete formal closure framework LRE-NS | https://github.com/ShantiDraconis/Millennium/commit/0d601255e51be349a1fd38eacfcbd2fda17ced77 |
| `Millennium` | `6054851e` | 2025-12-19 | PR #249 — u→π(u)→C(u)→Res(u) chain | https://github.com/ShantiDraconis/Millennium/commit/6054851e80b463b3c994fef2acc110983769c309 |
| `universal-emergent-logic-` | `14322ff2` | 2025-12-19 | PR #37 — d/dt π(u)=F(π(u))+K(R(u),π(u)); CouplingOperator | https://github.com/ShantiDraconis/universal-emergent-logic-/commit/14322ff2e8f38df302c6f2f6b41754db79d5a900 |
| `universal-emergent-logic-` | `730aa849` | 2025-12-19 | LRE Theorem 1 + complete NS geometric decomposition | https://github.com/ShantiDraconis/universal-emergent-logic-/commit/730aa849b0d76b0202f08b490664aa11c164b2bf |
| `universal-emergent-logic-` | `f30ef6a9` | 2025-12-19 | Nonlinear NS closure inequality P_N[(u·∇)u]≠(P_Nu)·∇ | https://github.com/ShantiDraconis/universal-emergent-logic-/commit/f30ef6a9d19af290a8f461d60d70da091d73d6ed |
| `universal-emergent-logic-` | `8b1aedfd` | 2025-12-19 | PR #56 — NS blow-up via residual curvature | https://github.com/ShantiDraconis/universal-emergent-logic-/commit/8b1aedfdd81b188b7b3d9ba91c9fbf4f0a47cda1 |

## Verification note

Keep SHA, timestamp, and verification state snapshots in `user_prior_work/` when exported.
To obtain `verified_valid` status, query the GitHub API for
`repos/{owner}/{repo}/commits/{sha}` and confirm `verification.verified = true`.
