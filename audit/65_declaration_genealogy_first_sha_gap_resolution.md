# Audit 65 — Declaration genealogy: first SHA -> gap -> resolution -> dependents

Status: `DEEP_RECOVERED_LEDGER / FULL_ALL-REF_SCAN_STILL_REQUIRED`

Date: 2026-09-13

Machine-readable ledger: `data/declaration_genealogy.csv`.

## Objective

Separate historical formalization debt from genuinely open mathematics by tracking, declaration or theorem-cluster by declaration/theorem-cluster:

`first_gap_sha -> gap_kind -> attempted/resolved_sha -> resolution_status -> dependents`.

This audit does not infer that removal of a literal `sorry` constitutes a proof. In particular, replacing `sorry` by `axiom`, `postulate`, `Parameter`, `Admitted`, a vacuous `True`, or a hypothesis equivalent to the conclusion is not classified as mathematical closure.

## Recovered high-value genealogy

### Classical Navier-Stokes skeleton

Commit `5eee6ce82dda31852cd52db61104c42433ec7ae4` (2025-11-25T11:37:02Z) contains the recovered Lean skeleton for:

- `energy_equality_strong` — `True` + `sorry`;
- `energy_inequality_weak` — `True` + `sorry`;
- `total_dissipation_bound` — `True` + `sorry`;
- `enstrophy_evolution` — `True` + `sorry`;
- `enstrophy_growth_bound` — `True` + `sorry`;
- `dissipation_integral_bound` — `True` + `sorry`;
- Prodi-Serrin target — placeholder/sorry;
- BKM-type continuation target — placeholder/sorry;
- ESS endpoint `escauriaza_seregin_sverak` — `True` stand-ins + `sorry`;
- local epsilon-regularity target — skeleton/sorry.

Commit `1ae8b318d9c8ab9ebfb59b8719f91c29ca86ac70` later says `Replace sorry with axioms and proofs in formal/lean files`. For audit purposes, each declaration must be split into one of two cases: actual proof term vs promoted axiom. A promoted axiom is `REPLACED_BY_AXIOM`, not `PROVED`.

### Abstract obstruction vs concrete PDE bridge

Commit `a762e7b76464656236075548343f596ab8bc6815` contains an important split:

- the abstract theorem `quantitative_closure_obstruction` has an explicit Lean proof under a coupling hypothesis;
- its corollary at the reference point is derived;
- `toy_coupling_holds` still ends in `sorry` for the concrete derivative/norm calculation.

Thus the abstract implication is formalization debt already substantially discharged, whereas establishing the required coupling for a concrete Navier-Stokes object is a separate mathematical obligation.

Commit `730aa849b0d76b0202f08b490664aa11c164b2bf` maps the abstract projection/residual geometry into Navier-Stokes but explicitly retains hard analytic work. It is classified `OPEN_BRIDGE`, not `PROVED`.

### Current endpoint register

The current open-bridge registry contains independent endpoint blockers including:

- `NS-B2`: repository condition -> uniform critical L3;
- `NS-B3`: exact ESS hypothesis map (`EXTERNAL_THEOREM`);
- `NS-B4`: epsilon_NS denominator-degenerate states;
- `NS-B5`: epsilon_NS threshold -> recognized critical norm;
- `NS-B6`: correction iteration invariants + contraction;
- `NS-B7`: pressure compatibility;
- `NS-B9`: mean/phase/error -> critical estimate;
- `RH-B1`, `RH-B2`;
- `PNP-B1`;
- `BSD-B1`;
- `HODGE-B1`;
- `YM-B1`.

`META-B1` is not a proof gap: fixed-epsilon closeness is not transitive as stated. It must be repaired to a graded triangle statement. This is `INCONSISTENT_SPECIFICATION`.

## Resolution taxonomy

Every recovered declaration is assigned one of:

- `PROVED`: explicit proof from audited dependencies;
- `EXTERNAL_THEOREM`: named external theorem with all hypotheses mapped;
- `FORMALIZATION_DEBT`: mathematics known/available but encoding incomplete;
- `REPLACED_BY_AXIOM`: literal placeholder removed by adding an assumption;
- `OPEN_BRIDGE`: new substantive mathematics still required;
- `INCONSISTENT_SPECIFICATION`: historical statement false/malformed and must be corrected;
- `META_FORMAL_ONLY`: provenance/meta-language object, not an endpoint proof;
- `NOT_ESTABLISHED`: evidential/causal claim lacking independent evidence.

## What this ledger establishes

It establishes a reproducible *recovered* genealogy from the already-audited Git corpus. It identifies concrete first-gap SHAs for several high-value declarations and separates the abstract obstruction theorem from the unresolved Navier-Stokes application.

It does **not yet establish exhaustive first-SHA coverage of every declaration on every ref of every repository**. Existing GitHub/code-search evidence is capped/index-dependent. Exhaustiveness requires executing `tools/scan_formal_history.py` and `tools/scan_sorry_certificates.py` against complete authorized clones with `git rev-list --all --reverse` / `git log --all --reverse`, then merging those outputs into this ledger.

## Completion criterion for the exhaustive pass

For each Lean/Coq/Isabelle/Agda declaration, record:

1. repository;
2. path;
3. declaration name and language;
4. first SHA where declaration exists;
5. first SHA where a proof escape appears;
6. marker (`sorry`, `axiom`, `Admitted`, `postulate`, `oops`, vacuous payload, circular assumption, etc.);
7. last SHA retaining the gap;
8. first SHA changing/removing it;
9. exact replacement classification;
10. direct dependencies;
11. reverse dependents;
12. build/kernel status at the resolution SHA;
13. theorem-level mathematical status;
14. evidence pointer/checksum.

Only after that all-ref scan may the ledger be labelled `EXHAUSTIVE_AUTHORIZED_CORPUS`.
