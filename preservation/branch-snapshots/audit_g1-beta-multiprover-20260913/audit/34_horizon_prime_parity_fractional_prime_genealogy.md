# 34 — Horizon Prime / Parity / Prime-Ratio Genealogy

## Purpose

This file records a cross-repository genealogy of the Horizon Prime research line and separates standard number theory from repository-specific terminology. It is supporting provenance/context for the broader research program. It is **not** a claim that Riemann, Goldbach, twin primes, P vs NP, dark-sector physics, or any other external problem is solved.

The principal mathematical priority claim in this audit remains restricted to the documented Navier–Stokes research architecture unless a separate theorem is independently closed and verified.

---

## 1. Terminology correction required for scientific publication

### 1.1 Even primes

In standard arithmetic:

```text
Nat.Prime n ∧ Even n  ->  n = 2.
```

Therefore there is exactly one even prime: `2`.

The historical phrase `Parity Prime 2` is compatible with this only when it refers specifically to the integer 2.

A claim such as “many even primes” is false in standard number theory.

### 1.2 Even numbers as sums of primes

A separate object is a Goldbach pair:

```text
GoldbachPair(N,p,q) :<->
  Even N ∧ 4 <= N ∧ Prime p ∧ Prime q ∧ N = p + q.
```

This is not the same as saying `N` itself is prime.

### 1.3 “Fractional prime”

The repository-specific object

```text
p/q, with Prime p and Prime q,
```

is not a prime number in standard arithmetic because primality is ordinarily a property of integers greater than 1.

For audit-safe terminology define:

```text
PrimeRatio(p,q) :<-> Prime p ∧ Prime q ∧ q != 0.

value(p,q) = p/q ∈ Q.
```

We may preserve the historical label `Fractional Prime` as provenance metadata, but scientific exposition should call it a **prime-ratio signature** unless a new algebraic notion of primality is explicitly defined.

### 1.4 Border prime

For an integer truncation/base `C_N`, the repository defines

```text
BorderPrime(C_N)
  = C_N + k_min,

k_min = min { k > 0 : Prime(C_N+k) }.
```

This is a legitimate integer definition once existence of a prime above `C_N` is invoked. It is distinct from both Goldbach pairs and prime-ratio signatures.

---

## 2. Earliest recovered Parity / Prime-Ratio anchor

Repository:

`ShantiDraconis/olympic-symbolic-00`

Commit:

```text
70d36df6b31e12286cc6cd3cef4448ccb6eae089
```

Timestamp:

```text
2025-12-21T16:44:59+02:00
```

Commit title:

```text
Implement Horizon Parity Engineering for prime-based copyright protection
```

The commit explicitly introduces three objects:

1. `Fusion Parity Primes` — the special state `1 + 1 -> 2` called `Parity Prime 2` in the repository-specific semantics;
2. `Fractional Prime Density` — a ratio `p/q` with prime numerator and prime denominator, with examples `13/7`, `101/19`, `97/89`;
3. `Horizon Primes` — a prime-valued count for horizon visual elements.

The source code implements:

```python
validate_fusion_parity(...)
check_fractional_density(...)
validate_horizon_prime(...)
calculate_parity_signature(...)
```

For scientific use the normalized mapping is:

```text
Parity Prime 2         -> EVEN_PRIME_SPECIAL_CASE
Fractional Prime p/q   -> PRIME_RATIO_SIGNATURE
Horizon Prime n        -> PRIME_INTEGER_WITH_APPLICATION_ROLE
```

Classification:

```text
PROVENANCE: VERIFIED COMMIT
MATHEMATICAL STATUS: DEFINITIONS / COMPUTATIONAL VALIDATORS
CLASSICAL NOVEL THEOREM: NOT ESTABLISHED
```

This is currently the earliest directly recovered explicit commit joining `parity`, `prime`, and a fractional prime-ratio object in the Horizon genealogy.

---

## 3. Horizon Prime unified formula origin

Repository:

`ShantiDraconis/Universe-0-0`

Core commit:

```text
388fb45b76bffd78c4d6fe42e2b073d6cf7410a5
```

Timestamp:

```text
2026-01-06T03:58:59Z
```

Message:

```text
Implement Horizon Prime unified formula (H_P) - core files
```

Follow-up:

```text
38adc2af1f93c41664aedd9050b2b9cd47903601
2026-01-06T04:02:29Z
```

Merge anchor:

```text
69f2335e6ec54660569ee7c9c9673da90f8d6d26
2026-01-06T05:15:04+01:00
```

The historical document defines a repository-specific Horizon Prime object

```text
H_P(ψ)
```

using a zeta-critical-line factor, a dimensional coefficient, hydrogen-wavefunction terms, projection cascades, and a structural residue. It also explicitly contains:

```text
23D -> 4D -> 2D projection,
R_total = R_23->4 ⊕ R_4->2,
"Infinite Tail Signature",
I = 0/0 as an extended/meta-framework object,
LRE projection / lift / residue vocabulary.
```

Audit classification:

```text
VERY_STRONG_GENEALOGICAL_ANCHOR
EXTENDED_AXIOMATIC/HEURISTIC_FRAMEWORK
NOT A VERIFIED SOLUTION OF THE LISTED MILLENNIUM PROBLEMS
```

The commit's own claims of resolving multiple Millennium Problems must not be repeated as established results without independent theorem-level verification.

---

## 4. Dedicated Horizon Prime formalization repository

Repository:

`ShantiDraconis/horizon-prime---framework`

### 4.1 Initial complete framework

```text
4189b97502b658819967906c480720e53b9e103f
2026-02-04T05:43:02Z
```

Commit message records:

```text
LaTeX documentation
Python implementation
C++ implementation
Lean 4 theorem definitions
Coq verification stubs
CRT
Hensel lifting
Carmichael functions
```

### 4.2 Equivalence / P-vs-NP branch

```text
a9da297a865fef4ff1e63f61b0bf75ca93236166
2026-02-04T02:52:19-03:00
```

### 4.3 Mathematical library/formal verification follow-up

```text
96d0f4b33488c256dda6cea72c5816953a80f109
2026-02-04T02:53:27-03:00
```

Current-source inspection shows that the repository contains:

```text
GoldbachConjectureVerifier
TwinPrimeVerifier
HyperprimeSequence
CRT/profinite compatibility machinery
Riemann/Horizon modules
Lean / Coq / Isabelle / Agda / Python components
```

But proof status is mixed. For example, historical/current formal files contain:

```text
Lean: theorem ... := by sorry
Coq: admit / Admitted
```

for Goldbach/twin-prime-level claims.

Therefore the correct classification is declaration-local, not repository-wide.

---

## 5. Goldbach / even-number branch

Current Horizon Prime source explicitly labels a theorem target equivalent in intent to:

```text
Every even N >= 4 is a sum of two primes.
```

Python implements finite verification routines over tested ranges.

Lean and Coq sources contain theorem statements/sketches but at least the inspected versions retain `sorry` or `Admitted` for the global Goldbach claim.

Therefore:

```text
FINITE COMPUTATIONAL VERIFICATION != PROOF OF GOLDBACH.
```

Audit node schema:

```text
GOLDBACH_STATEMENT
  ├─ Python finite verifier: EXECUTABLE_MODEL / FINITE_TEST
  ├─ Lean theorem target: SORRY_OR_OPEN
  ├─ Coq theorem target: ADMITTED_OR_OPEN
  └─ Documentation: PAPER_CLAIM
```

The mathematically valid object of interest for the user's “even + prime components” idea is the decomposition relation

```text
N = p + q,
Prime p,
Prime q,
Even N.
```

not a new class of even primes.

---

## 6. Prime-ratio / fractional component branch

The earliest explicit recovered repository definition is the 2025-12-21 `olympic-symbolic-00` commit above.

Define a normalized rational coordinate:

```text
ρ(p,q) = p/q,
Prime p,
Prime q,
q > 0.
```

Possible derived operators:

```text
numPrime(ρ) = p
denPrime(ρ) = q
ratioValue(ρ) = p/q
fractionalPart(ρ) = ρ - floor(ρ)
```

Important distinction:

```text
Prime p ∧ Prime q
```

does not imply

```text
p/q is a prime number.
```

The `fractionalPart` operator is ordinary real/rational arithmetic and is a separate notion from the repository's historical “Fractional Prime” label.

This normalized representation gives a scientifically defensible way to preserve the historical idea while avoiding a category error.

---

## 7. Hyperprime / CRT / profinite branch

The Horizon repository contains `HyperprimeSequence`-type structures in Lean and Coq, represented schematically as:

```text
stages : List (N × N)
primes : List N
length compatibility
all_prime property
CRT / pairwise-coprime compatibility
```

The broader implementation contains profinite projection / CRT compatibility machinery.

Scientifically this should be classified as a **structured sequence of ordinary primes with modular compatibility**, unless and until an independent definition/theory of “hyperprime” is established.

This branch is relevant to the audit because it reinforces the recurring research architecture:

```text
finite modular projections
 -> compatibility constraints
 -> inverse/profinite horizon
 -> unresolved/infinite tail.
```

That architecture is structurally related to the projection/residual/tail program elsewhere in the corpus, but it is not a theorem-level bridge to Navier–Stokes.

---

## 8. Conditional Riemann two-state branch

Repository:

`ShantiDraconis/horizon-prime---framework`

Commit:

```text
355e2e5086ded70e8d05b366284335c4c750078a
2026-04-23T14:26:30Z
```

Introduces a Python `RiemannOperator` conditional exceptional-zero analysis with:

```text
ResidualObservable O_res(ρ) = |Re(ρ)-1/2| + composite terms
CriticalState |C>, E_C = 0
DeformedState |D>, E_D > 0
2×2 effective operator H_eff
```

It also includes a finite test suite.

Classification:

```text
CONDITIONAL_COMPUTATIONAL_MODEL
NOT AN EXISTENCE PROOF OF AN OFF-LINE ZERO
NOT A REFUTATION/PROOF OF RH
```

This is nevertheless relevant provenance for the later multistate/residual interpretation.

---

## 9. Modular RH research scaffold

Repository:

`ShantiDraconis/Horizon_Prime_-framework`

Important commits:

```text
e3d57cdbc5367c6d4d9832803a964c323434d80e
2026-04-23T14:42:30Z
```

```text
1901ab3768a6e2c2a951925f44b2a91a0a482a22
2026-04-23T14:50:19Z
```

Merge:

```text
9aa4ca2446cc3e6ad1a82db76d470514db829378
2026-05-06T00:18:45-03:00
```

Current README correctly states that the package is a research-organisation tool and does **not** claim proof/refutation of RH. Its roadmap explicitly marks the RH bridges as open theorems.

This is a stronger scientific presentation model for the overall audit: definitions/classical facts can be closed while decisive bridges remain visibly open.

---

## 10. Pi Border Primes branch

Repository:

`ShantiDraconis/pi-border-primes`

Earliest directly recovered repository commit:

```text
d7e71b022d580862121310c5f3f2e5c06ba0f456
2026-08-25T14:21:01Z
```

Message:

```text
Add full Pi Border Primes repo: L1-L5 code, data, proofs, docs
```

Merge anchor:

```text
42d9dbbe96bb8adc9eaead0217bf707ac1148916
2026-08-25T16:32:57+02:00
```

Pi-314T extension:

```text
475ee332ced174876bf5129b1d204e21908d7164
2026-08-25T22:02:50+02:00
```

The project defines

```text
BorderPrime(C_N)=C_N+k_min
```

with the nearest positive offset leading to a prime. The repository also contains tail/digit statistics, primality verification, Python, and later Lean/Coq/Isabelle statistical layers.

This branch is chronologically pre-2026-09-08 and therefore can be included as supporting evidence for the broader **border/tail/finite-prefix** research motif. It should not be represented as an antecedent of the OpenAI Navier–Stokes construction unless a concrete mathematical bridge is identified.

---

## 11. Research-program DAG

The cross-repository chronology now supports the following research genealogy:

```text
2025-12-21
PARITY PRIME 2 / PRIME-RATIO SIGNATURE / HORIZON PRIME
olympic-symbolic-00
        |
        v
2026-01-06
HORIZON PRIME H_P
critical-line + projection + residue + infinite-tail vocabulary
Universe-0-0
        |
        v
2026-02-04
DEDICATED HORIZON PRIME FORMALIZATION
CRT / Hensel / Carmichael / Lean / Coq / Python / C++
horizon-prime---framework
        |
        +--> Goldbach pair branch
        +--> twin-prime branch
        +--> hyperprime / profinite branch
        |
        v
2026-04-23
RIEMANN TWO-STATE RESIDUAL OPERATOR
conditional computational model
        |
        v
2026-04-23 to 2026-05-06
MODULAR RH RESEARCH SCAFFOLD
explicitly marks decisive theorems open
        |
        v
2026-08-25
PI BORDER PRIMES
finite prefix / nearest-prime boundary / tail statistics
```

Parallel Navier–Stokes genealogy remains separately anchored in Nov–Dec 2025.

---

## 12. Relation to Navier–Stokes audit

The Horizon/prime corpus may be used to establish that the larger research program repeatedly used the following motifs before the OpenAI public release:

```text
boundary/horizon
projection
residual
finite observable prefix
unresolved/infinite tail
state transition
compatibility across scales
quantitative defect/error
```

These are useful for intellectual genealogy.

They are **not sufficient** to establish mathematical equivalence with OpenAI's concrete Navier–Stokes slow-recursion, jet, stress, correction, or blow-up construction.

The Navier–Stokes priority argument should continue to rely primarily on the direct NS/LRE commits:

```text
2025-11-23 NS root/framework
2025-11-25 classical NS / ESS targets
2025-12-18 projection/residual/critical-jets cluster
2025-12-19 K(R,d), reference section, quantitative obstruction,
           residual/stress/correction architecture
```

Horizon Prime and prime-ratio material should appear under a heading such as:

```text
BROADER RESEARCH GENEALOGY / SUPPORTING CONTEXT
```

not under:

```text
DIRECT NAVIER-STOKES PRIOR ART
```

unless a theorem-level direct edge is later established.

---

## 13. Recommended public claim scope

### Safe principal claim

```text
I claim dated authorship/provenance of the specific Navier–Stokes research
architecture and mathematical objects demonstrated by the audited commits.
```

### Safe contextual claim

```text
Earlier and parallel repositories document a broader research program involving
boundaries, tails, projection, residuals, prime/modular structures, and
indeterminacy; these provide genealogy and context but are not claimed as
solutions of their associated open problems.
```

### Claims that should NOT be made without further proof

```text
Goldbach is solved.
Twin primes are solved.
RH is solved/refuted.
P vs NP is solved.
Horizon Prime proves all Millennium Problems.
Prime ratios are prime numbers in standard arithmetic.
The OpenAI construction was copied/derived from these repositories.
```

---

## 14. High-value next forensic work

1. Extract declaration-level histories for `HorizonPrime.lean`, `HorizonPrime.v`, `HorizonPrime.thy`, Agda files, and Python modules.
2. Attach exact proof status per declaration (`proved`, `sorry`, `Admitted`, `axiom`, numerical-only).
3. Trace the introduction commit of every `HyperprimeSequence`, Goldbach, twin-prime, parity, and prime-ratio declaration.
4. Normalize `Fractional Prime` -> `PrimeRatio` in the scientific layer while preserving original historical terminology in provenance fields.
5. Link only those cross-problem nodes that have explicit mathematical maps; leave metaphorical links as `CONCEPTUALLY_RELATED`.
6. Keep the principal external-priority claim limited to Navier–Stokes until another problem has its own complete proof audit.
