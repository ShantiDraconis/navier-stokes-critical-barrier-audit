# 45 — Endpoint closure register

Status: canonical audit closure layer.

## Purpose

This file answers one question: **what exactly remains between the current audited corpus and a defensible theorem-level endpoint?** It does not convert unresolved mathematics into axioms or claims of proof.

The machine-readable source is `data/open_bridge_registry.csv`. The typed formal interfaces are in `formal/lean/CriticalBarrier/EndpointInterfaces.lean`.

## Release invariant

A problem endpoint may be labelled `PROVED` only if every row with `blocks_endpoint=true` for that domain has been discharged by one of:

1. a direct proof from certified premises;
2. an exact external theorem with all hypotheses mapped;
3. a corrected specification followed by a proof of the corrected statement.

An explicit typed hypothesis makes downstream reasoning `CONDITIONAL`; it never upgrades the hypothesis itself to `PROVED`.

## Navier--Stokes closure chain

The shortest currently defensible regularity route is

`repository condition`

`=> [NS-B2: OPEN] bounded critical L^∞_t L^3_x control`

`=> [NS-B3: EXTERNAL THEOREM + exact hypothesis mapping] continuation/regularity`.

Before this chain is valid, NS-B1 must pin the exact Clay-admissible domain, data, forcing and solution class. If the historical epsilon_NS route is used, NS-B4 and NS-B5 must also close. If the projection/residual/correction route is used, NS-B6 and NS-B7 must close, plus forcing/support compatibility where applicable.

The central missing mathematical theorem remains a non-circular estimate of the form

`R(u) <= c_*  =>  sup_{t<T} ||u(t)||_{L^3} < infinity`

for the exact repository condition `R` and exact admissible solution class, or another theorem demonstrably equivalent to a recognized continuation criterion.

Scaling invariance of epsilon_NS, mean closure, percentage normalization, residual reduction, numerical clustering and abstract contraction do not imply this bridge.

## Riemann closure chain

The model identities and symmetry statements are not zero certificates. RH-B1 requires rigorous certification that every candidate used as a zeta zero is actually a zero with controlled error. RH-B2 requires an infinite-tail theorem; finite computation cannot substitute for it.

## P vs NP closure chain

The missing bridge is an unconditional exactification from the repository's approximate/parameter language to a worst-case statement over all deterministic polynomial-time machines, with the known proof barriers explicitly addressed. A finite experiment or parameter collapse is not such a theorem.

## BSD / Hodge / Yang--Mills

Each retains a native bridge that cannot be obtained merely by sharing the UAMF/error-coordinate architecture:

- BSD: analytic order of vanishing equals arithmetic rank in the required class.
- Hodge: construction/algebraicity of rational cycles representing every rational Hodge class.
- Yang--Mills: rigorous nontrivial 4D quantum theory plus positive mass gap.

These are deliberately independent obligations. The corpus's own non-unification branch is therefore a safeguard against false universal closure.

## Historical `sorry` resolution discipline

Every historical formal gap is resolved in this fixed order:

`DIRECT_PROOF -> LIBRARY_OR_EXTERNAL_THEOREM -> SPECIFICATION_CORRECTION -> EXPLICIT_TYPED_HYPOTHESIS`.

The fixed-epsilon transitivity example is classified `INCONSISTENT_SPECIFICATION`: `|x-y|<epsilon` is not transitive for fixed epsilon. `EndpointInterfaces.lean` contains the corrected graded theorem

`Close epsilon x y -> Close delta y z -> Close (epsilon+delta) x z`.

Open Millennium content must remain a typed proposition/interface until discharged.

## Priority closure

Chronology is already useful for account-associated provenance and audited-corpus anteriority. `PRIORITY-B1` remains open for any claim of worldwide first priority. A negative prior-art search is bounded by databases, query design, indexing and inaccessible/unpublished work.

## Causal-access closure

`CAUSAL-B1` is separate from mathematical similarity. Earlier timestamps plus later similarity do not prove that a later author or organization accessed the earlier work. That requires independent access/communication/derivation evidence.

## Formal release gate

For a theorem certificate to be `FORMAL_PROOF_CHECKED`:

- exact commit/blob is fixed;
- prover and dependencies are pinned;
- clean build succeeds;
- no `sorry`, `admit`, `Admitted`, `oops`, hidden replacement axiom, or vacuous `True` stands in the transitive dependency closure;
- nonstandard axioms are enumerated;
- external theorem hypotheses are mapped.

Source-clean is not synonymous with assumption-clean.

## Current verdict

The audit infrastructure can now state the frontier precisely. It **cannot honestly jump over the frontier**. The remaining endpoint-blocking rows in `data/open_bridge_registry.csv` are mathematical research obligations, not missing documentation.

Therefore the current strongest status is:

- provenance: substantial and reproducible within the audited corpus;
- structural genealogy: documented;
- audit logic: formalizable without laundering open assumptions;
- decisive NS/RH/PNP/BSD/Hodge/YM bridges: open unless individually discharged;
- Millennium solution claim: not established by this repository at this checkpoint.
