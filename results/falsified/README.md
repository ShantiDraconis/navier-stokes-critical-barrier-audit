# Falsified hypotheses and claims

Claims and hypotheses that have been definitively ruled out during the audit.

## FF-01: Type-I self-similar blow-up is the only possible scenario

**Claim:** The proposed construction must use a type-I self-similar blow-up profile.

**Status: FALSIFIED** — Type-II and non-self-similar blow-ups are not ruled out by
the external construction's public framework.  The NRS (Nečas–Růžička–Šverák 1996)
non-existence result applies to exact type-I self-similar blow-up in the Leray
sense; the construction does not claim this specific form.

## FF-02: The prior corpus contains no object structurally matching the NS residual coupling

**Claim:** No pre-2026 prior-work object structurally matches the external
construction's residual-coupling pipeline.

**Status: FALSIFIED** — Evidence items A-01 through A-14 in
`evidence/lre_evidence_inventory.md`, all dated November–December 2025, establish
structural matching of the spectral projection, closure obstruction, residual
coupling operator \(K(R,\pi(u))\), and projected evolution equation.

## FF-03: The prior-work chronology begins only in 2026

**Claim:** No relevant prior-work documentation pre-dates the 2026 target date.

**Status: FALSIFIED** — The earliest confirmed anchor is commit `64bc633e`
(2025-11-23) in `ShantiDraconis/millennium-navier-stokes-I`.  Zenodo record
`10.5281/zenodo.15164501` is reported as dated 2025-04-06.  Multiple other
documented records pre-date the 2026-09-08 target.

## FF-04: The Lebesgue space \(L^p\) for \(p\neq 3\) is scale-critical for 3D NS

**Claim:** Some \(L^p\) with \(p\neq 3\) is the scale-critical space.

**Status: FALSIFIED** — The rescaling \(u_\lambda(x,t)=\lambda u(\lambda x,\lambda^2 t)\)
gives \(\|u_\lambda\|_{L^p} = \lambda^{1-3/p}\|u\|_{L^p}\).  Only \(p=3\) gives
a scale-invariant norm.  This is a classical result with no ambiguity.

## Notes

This directory records only **definitive falsifications**, not open refutation
attempts (those are in `results/unresolved/` and `audit/11_failed_refutation_attempts.md`).
