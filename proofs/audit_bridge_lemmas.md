# Audit Bridge Lemmas

These are the elementary statements that can be proved rigorously from the definitions used by the audit. They are **not** proofs of any open Millennium problem. Their purpose is to separate what is already derivable from the repository's definitions from what still requires a substantive bridge theorem.

## Lemma 1 — weighted contributions normalize to 100%

Let

\[
E=\sum_{j=1}^{n} w_j g_j(\Delta_j),
\]

with \(E>0\). Define

\[
C_i=100\frac{w_i g_i(\Delta_i)}{E}.
\]

Then

\[
\sum_{i=1}^{n}C_i=100.
\]

### Proof

\[
\sum_i C_i
=\sum_i100\frac{w_i g_i(\Delta_i)}{E}
=\frac{100}{E}\sum_iw_i g_i(\Delta_i)
=\frac{100}{E}E
=100.
\]

No claim about the *correctness* or *canonicity* of the weights follows from this identity.

---

## Lemma 2 — sensitivity contributions normalize to 100%

Assume

\[
s_i=\left|\frac{\partial E}{\partial\theta_i}\right|\ge0,
\qquad \Delta_i\ge0,
\]

and

\[
D=\sum_js_j\Delta_j>0.
\]

Define

\[
C_i^{(s)}=100\frac{s_i\Delta_i}{D}.
\]

Then

\[
\sum_iC_i^{(s)}=100.
\]

The proof is identical to Lemma 1. This establishes normalization only; it does not establish equivalence between the sensitivity model and the weighted structural model.

---

## Lemma 3 — norm-based progress is monotone under norm contraction

Let an error trajectory satisfy

\[
\|\varepsilon^{(k+1)}\|\le\|\varepsilon^{(k)}\|
\]

for every \(k\), and suppose \(\|\varepsilon^{(0)}\|>0\). Define

\[
P_k=100\left(1-\frac{\|\varepsilon^{(k)}\|}{\|\varepsilon^{(0)}\|}\right).
\]

Then

\[
P_{k+1}\ge P_k.
\]

### Proof

Since the denominator is positive,

\[
\frac{\|\varepsilon^{(k+1)}\|}{\|\varepsilon^{(0)}\|}
\le
\frac{\|\varepsilon^{(k)}\|}{\|\varepsilon^{(0)}\|}.
\]

Multiplying by \(-100\) reverses the inequality and adding 100 yields \(P_{k+1}\ge P_k\).

Again, this proves a property of the chosen progress functional, not that the error coordinates are canonical for a classical mathematical problem.

---

## Lemma 4 — exact whole-period mean of a non-zero Fourier mode

Let

\[
f(t)=A e^{i\omega t},\qquad \omega\ne0.
\]

For any positive integer \(m\), take

\[
T=m\frac{2\pi}{|\omega|}.
\]

Then

\[
\frac1T\int_0^T f(t)\,dt=0.
\]

### Proof

\[
\frac1T\int_0^T A e^{i\omega t}\,dt
=\frac{A}{i\omega T}(e^{i\omega T}-1).
\]

Because \(T\) is an integer number of periods, \(e^{i\omega T}=1\). Hence the expression vanishes.

This justifies phase cancellation for an explicitly periodic zero-mean mode. It does **not** justify replacing an arbitrary imaginary contribution in a Millennium-problem formulation by zero.

---

## Lemma 5 — zero error norm iff every coordinate is zero

For \(\varepsilon=(\varepsilon_1,\dots,\varepsilon_n)\in\mathbb R^n\),

\[
\|\varepsilon\|_2=0
\quad\Longleftrightarrow\quad
\forall i,\ \varepsilon_i=0.
\]

### Proof

\[
\|\varepsilon\|_2^2=\sum_i\varepsilon_i^2.
\]

Every summand is nonnegative, so the sum is zero exactly when every summand is zero.

This says nothing about whether \(\varepsilon_i=0\) is equivalent to the corresponding classical theorem; that is a separate bridge obligation.

---

# Bridge obligations that remain unproved

The following cannot be obtained by algebraic normalization or by repository chronology:

1. that a selected error vector is canonical for Navier–Stokes;
2. that vanishing of the selected coordinates is equivalent to global smoothness/existence for all admissible 3D data;
3. that a phase decomposition corresponds to a mathematically intrinsic decomposition of the PDE obstruction;
4. that eliminating a phase component implies the Escauriaza–Seregin–Šverák critical \(L^3\) criterion;
5. that a numerical threshold or finite computation proves a universal theorem over all admissible initial data;
6. that Git or Zenodo chronology establishes worldwide priority or mathematical correctness.

These are therefore tracked as `OPEN_BRIDGE` items rather than silently promoted to theorem status.
