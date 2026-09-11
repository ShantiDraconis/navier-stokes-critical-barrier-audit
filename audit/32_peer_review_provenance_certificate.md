# Peer-Review Provenance Certificate — Navier–Stokes Formalization Lineage

**Audit status:** forensic/peer-review dossier, not a certificate that the Millennium problem is solved.

**Repository under audit:** `ShantiDraconis` repository corpus, with emphasis on the Navier–Stokes lineage.

## 1. Review question

Determine the oldest recoverable repository evidence for the Navier–Stokes research/formalization program; separate repository origin, computational framework, classical regularity targets, multiscale bridge obligations, and later quantitative `epsilon_NS` claims.

## 2. Evidence standard

Evidence is graded as follows:

- **L5:** Git object with immutable full SHA, tree/blob evidence, timestamp and parent chain.
- **L4:** immutable GitHub commit permalink.
- **L3:** release/DOI/Zenodo record.
- **L2:** historical issue/PR/document reference.
- **L1:** recollection or unsupported narrative.

No chronology claim is upgraded into a mathematical-validity claim.

## 3. Oldest recovered repository object

### Certificate ORIGIN-NS-000

Repository: `ShantiDraconis/millennium-navier-stokes-I`

Commit SHA:

`d4a3a745269c10a15c12d2b854cac7c3553d243d`

Author timestamp:

`2025-11-23T02:15:01Z`

Committer timestamp:

`2025-11-23T02:15:01Z`

Author recorded by Git:

`ShantiDraconis`

Commit message:

`Initial commit`

Tree SHA:

`05981b0ee6f1f8a52c21b886b7302d8f558d40a4`

Parents:

none — root commit.

Signature status:

`verified: true`, GitHub verification reason `valid`.

Initial README blob:

`6c3a30de34bb75d50394804fde55e865f6c0fd7c`

The initial README already names the project as `millennium-navier-stokes-I` and states `Equações de Navier–Stokes + colapso SBFE/I`.

**Classification:** `EARLIEST_DIRECTLY_RECOVERED_REPOSITORY_ORIGIN`.

**Evidence grade:** L5.

This is presently the strongest directly recovered timestamp for the repository lineage. It is not, by itself, a mathematical formalization.

## 4. Oldest recovered substantive framework

### Certificate ORIGIN-NS-001

Commit SHA:

`64bc633ecdb3a90ccfbf1c0863963c4bdd238d0f`

Timestamp:

`2025-11-23T02:27:31Z`

Parent:

`44ca2524898c1f19d830e63b16dadf1d01874178`

Tree SHA:

`34701bd279355ef4895a722c9631b046ec976983`

Commit message:

`Implement Navier-Stokes SBFE/I collapse analysis framework`

Verification:

unsigned.

The commit adds approximately 2140 lines and contains a computational/research framework for 3D incompressible Navier–Stokes. It explicitly records:

- the 3D equations;
- global smoothness versus finite-time singularity as the target question;
- energy, enstrophy and palinstrophy diagnostics;
- vorticity monitoring;
- a BKM-type regularity diagnostic;
- self-similar collapse analysis;
- critical scaling;
- numerical spectral methods;
- an explicit disclaimer that Millennium claims require rigorous proof and peer review.

**Classification:** `EARLIEST_DIRECTLY_RECOVERED_SUBSTANTIVE_NS_FRAMEWORK`.

**Proof status:** `COMPUTATIONAL_AND_ANALYTICAL_RESEARCH_FRAMEWORK`, not a proof.

**Evidence grade:** L5.

## 5. Earliest recovered classical critical-L3 formalization target

Repository: `ShantiDraconis/millennium-navier-stokes-classical`.

Historical commit containing the skeleton:

`5eee6ce82dda31852cd52db61104c42433ec7ae4`

Timestamp:

`2025-11-25T11:37:02Z`

Historical file:

`formal/lean/RegularityCriteria.lean`

Blob:

`80827b62bc11cfb987147f08809d8436075c49e3`

The file explicitly encodes the intended Escauriaza–Seregin–Šverák endpoint:

`u ∈ L^∞([0,T]; L³) implies regularity`.

However, the substantive propositions are represented by `True` and proofs by `sorry` in this historical version.

**Classification:** `THEOREM_STATEMENT_TARGET / PLACEHOLDER`.

It is evidence that the critical-L3 endpoint was part of the program by this date. It is not evidence that the theorem was formally derived in Lean.

A later commit, `1ae8b318d9c8ab9ebfb59b8719f91c29ca86ac70` at `2025-11-25T21:47:44Z`, replaced such placeholders with axioms/proofs. The indexed ESS form is an axiom with `True`-typed stand-ins. Accordingly it is classified as `FORMAL_PROOF_DEPENDS_ON_ASSUMPTIONS / SKELETON`, not kernel-level proof of the analytic theorem.

## 6. Multiscale/residual lineage

By `2025-12-19`, repository `ShantiDraconis/universal-emergent-logic-` contains a dense sequence of commits explicitly developing Structural Residue Logic and Navier–Stokes residual stability, including:

- `f5d070d49557622c7168cd7b354d5d9629ce3fc6` — LRE structural residue framework;
- `730aa849b0d76b0202f08b490664aa11c164b2b3` — quantitative obstruction + NS application;
- `e68f81b2ad71eb7cef67ec09971891f2899cd5ce` — NS LRE formalization with curvature;
- `1ed0ded98d26966189fc5936914fd964d42cbd7a` — residual stability inequality;
- `ace0acc3abd1067cd63bd94adfeffa962977bc9b` — NS LRE proof framework with three lemmas.

These commits establish a provenance bridge from the November collapse/regularity program into the later residual/multiscale language. Their theorem-level validity requires source-by-source proof-dependency and build audits and must not be inferred from commit messages.

## 7. Explicit canonical remainder bridge

PR #117 in `universal-emergent-logic-` was opened `2025-12-26T03:27:09Z`.

Substantive commit:

`6f52d839ebfa116c1725a1c57abfcd812c3b4577`

Timestamp:

`2025-12-26T14:02:55Z`

The source defines a spectral remainder for Navier–Stokes,

`R(epsilon;t) = ||u(t) - pi_epsilon(u(t))||_L2`,

and explicitly identifies the desired implication

`sup_{t<T*} E^(3)(t) < infinity => no blow-up at T*`

as a **missing regularity criterion**.

**Classification:** `OPEN_BRIDGE_EXPLICITLY_IDENTIFIED`.

This is important negative evidence: the historical source itself did not regard the multiscale-to-global-regularity bridge as already proved at that stage.

## 8. Explicit epsilon_NS / 65% lineage

PR #183 was opened `2026-01-01T22:44:57Z`.

Substantive commit:

`91ba0b43b0bec9bf6d13621cda886bceb7b3e152`

Timestamp:

`2026-01-01T22:51:57Z`.

The source introduces

`epsilon_NS = ||(u·grad)u||_L2 / (nu ||Delta u||_L2)`

and the proposed numerical threshold `0.65 +/- 0.05`, with claims connecting this diagnostic to critical regularity/global solution.

**Classification:** `QUANTITATIVE_THEOREM_CLAIM_WITH_UNDISCHARGED_CLASSICAL_BRIDGE`.

The chronology proves that the diagnostic and threshold were present in the repository at this time. It does not prove that the threshold is universal or sufficient for global regularity.

## 9. Peer-review reconstruction of the research lineage

The evidence supports the following chronology:

1. **2025-11-23 02:15:01 UTC — project origin.** Root Git commit, directly authored under `ShantiDraconis`, already names Navier–Stokes + SBFE/I collapse.
2. **2025-11-23 02:27:31 UTC — first substantive recovered implementation.** Collapse diagnostics, scaling, energy/enstrophy/palinstrophy and BKM-style monitoring.
3. **2025-11-25 — classical/formal layer.** Classical NS formulation and formal-assistant skeletons; critical `L^∞_t L^3_x` endpoint appears explicitly.
4. **2025-12-19 — residual/LRE layer.** Residual stability and multiscale/curvature language developed in a sequence of commits.
5. **2025-12-26 — canonical remainder layer.** `R(epsilon;t)` and a multiscale energy are defined, while the key implication to no blow-up is explicitly listed as missing.
6. **2026-01-01 — quantitative epsilon layer.** The convective/dissipative ratio `epsilon_NS` and 65% threshold are proposed.
7. **2026-08/09 — noncircular/critical-barrier audit layer.** Later repositories attempt to isolate the bridge and distinguish classical results from new obligations.

## 10. Mathematical dependency certificate

A defensible proof architecture is:

`Repository-specific diagnostic bound`

→ **NEW BRIDGE THEOREM REQUIRED**

`critical norm boundedness`, e.g. `sup_{t<T} ||u(t)||_L3 < infinity`

→ **CLASSICAL ENDPOINT REGULARITY RESULT**

`no finite-time singularity at T`.

The second implication belongs to classical PDE theory. The first implication is the central new obligation for the proposed diagnostic framework.

Therefore a peer reviewer should reject any proof that silently substitutes the desired `L3` conclusion as an assumption, encodes it as `True`, declares it as an axiom, or derives it solely from finite numerical experiments.

## 11. Certificate verdict

### Provenance

**PASS, with bounded scope.** There is immutable Git evidence for a continuous Navier–Stokes research lineage beginning no later than `2025-11-23T02:15:01Z` in the recovered corpus.

### Earliest substantive framework

**PASS.** `64bc633...`, `2025-11-23T02:27:31Z`.

### Formal proof of the Millennium theorem in the earliest material

**NOT ESTABLISHED.** The earliest material is computational/analytical research code; later November formalizations include placeholders/axiomatic stand-ins.

### Critical-L3 bridge

**OPEN in the historical lineage unless a still-earlier/later exact source discharges it without assumptions.**

### 65% threshold as universal theorem

**NOT CERTIFIED.** Repository provenance exists; universal mathematical validity is not established by the evidence audited here.

## 12. Scope limitation

`2025-11-23T02:15:01Z` is the **earliest directly recovered Git record in the currently searched Navier–Stokes repository lineage**, not a claim of worldwide priority and not yet a proof that no older object exists in another owner repository, deleted ref, local reflog, unreachable object, external archive, Zenodo record, or earlier non-Navier-named repository.

A final absolute-origin certificate requires exhaustive enumeration of all owner repositories, all reachable refs/PR heads, deleted/renamed historical paths where recoverable, Zenodo mapping, and any local-only Git object recovery.
