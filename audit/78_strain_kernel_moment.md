# Audit 78 — tensorial strain-kernel signed moment investigation

Branch: `audit/pde-to-dynamic-campanato-20260913`

Purpose: investigate cancellation mechanisms for the signed far-field route without using, assuming, or upgrading the still-open localized PDE identity.

## Frozen logical boundary

The following remain unchanged:

- `A2 weighted diffusion IBP = OPEN_ANALYTIC_LEMMA`
- `A3 time/material lhs expansion = OPEN_ANALYTIC_LEMMA`
- `OPEN_PDE_IDENTITY = OPEN`
- `PDEToDynamicCampanato = NOT_ESTABLISHED`
- `hDynamic = NOT_ESTABLISHED`
- `G1_flex = NOT_ESTABLISHED`
- `G1 = NOT_ESTABLISHED`
- `FinalF = NOT_TOUCHED`
- `main = NOT_TOUCHED`

Audit 76/77 scaling obstruction remains frozen:

\[
\|S^{far}\|_\infty^2
\lesssim
K^{-3}\rho_*^{-3}\|\omega\|_2^2.
\]

Hence the pointwise `L^∞` route remains `BLOCKING_SCALING`. No statement in this audit pays the missing dimensional factor `rho_*^3`.

## 1. Tensorial kernel architecture

`formal/G1/StrainKernel.lean` now isolates the tensor kernel as data with independently auditable properties:

- symmetry in the strain indices;
- trace-free structure;
- odd parity;
- homogeneity of degree `-3`;
- pointwise `|z|^{-3}` size envelope.

The file does **not** claim principal-value existence or Calderón–Zygmund boundedness. Those remain `OPEN_CZ`.

Classification:

```text
DEFINITIONAL_KERNEL            FORMALIZED_ARCHITECTURE
KERNEL_SYMMETRY                PROVED_LOGIC_FROM_KERNEL_DATA
KERNEL_TRACE_FREE              PROVED_LOGIC_FROM_KERNEL_DATA
KERNEL_HOMOGENEITY             RECORDED_AS_KERNEL_PROPERTY
PRINCIPAL_VALUE_EXISTENCE      OPEN_CZ
CZ_BOUNDEDNESS                 OPEN_CZ
```

## 2. Signed far-field bilinear form

`formal/G1/SignedFarField.lean` defines the direct route at the level of the double integral, retaining both vorticity weights:

\[
\mathcal F_{far}
=
\iint_{|x-y|\ge K\rho_*}
D_{K_S}(x-y;\xi_\varepsilon(x),\xi_\varepsilon(y))
|\omega_\varepsilon(x)|
|\omega_\varepsilon(y)|
\phi(x)^2\,dy\,dx.
\]

The contraction `D` is kept explicit so that no unverified tensor formula is silently hard-coded.

The route intentionally does **not** perform

\[
S^{far}\to \|S^{far}\|_{L^\infty_x}\to |S^{far}|^2,
\]

because that is the route already known to produce the unpaid `K^{-3} rho_*^{-3}` factor.

Classification:

```text
SIGNED_FAR_FIELD_DOMAIN              FORMALIZED
SIGNED_DOUBLE_INTEGRAND              FORMALIZED
FUBINI_PREREQUISITES                 EXPLICIT / NOT AUTOMATIC
POINTWISE_LINF_ROUTE                 FALSE_ROUTE_FOR_CURRENT_BUDGET
DIRECT_WEIGHTED_BILINEAR_ROUTE       TARGET_ISOLATED
DIRECT_WEIGHTED_BILINEAR_ESTIMATE    NOT_PROVED
```

## 3. Spherical mean cancellation

Candidate identity:

\[
\int_{S^2} K_S(\theta)\,d\sigma(\theta)=0.
\]

Oddness alone gives cancellation over a centrally symmetric sphere for an integrable odd integrand. However, for the actual tensor kernel this must be checked component-by-component and with the correct surface measure and tensor contraction. The current formal layer records odd parity as kernel data but does not yet instantiate the exact Biot–Savart strain kernel or prove this surface integral.

Status:

```text
SPHERICAL_MEAN_ZERO = OPEN_SIGNED_CANCELLATION
```

Even if proved, this is a cancellation identity, not by itself a `rho_*^3` compensation theorem.

## 4. Annular mean cancellation

Candidate:

\[
\int_{R<|z|<2R} K_S(z)\,dz=0.
\]

For a genuinely odd integrable tensor kernel on a symmetric annulus, the formal cancellation should follow from the map `z -> -z`. But because the singular kernel is currently represented by an audit-safe structure rather than an instantiated Biot–Savart formula, this has not been promoted to a theorem about the physical strain operator.

Status:

```text
ANNULAR_MEAN_ZERO_GENERIC_ODD_KERNEL   PROVABLE_TARGET
ANNULAR_MEAN_ZERO_BIOT_SAVART_STRAIN   OPEN_SIGNED_CANCELLATION
```

Dimensional test: annular mean-zero removes the constant mode but does not automatically create a factor with dimension `length^3`.

## 5. First moments

Candidate family:

\[
\int_{R<|z|<2R} z_\ell K_S(z)\,dz.
\]

Because `z_ell K_S(z)` is even when `K_S` is odd, parity alone does **not** force first-moment cancellation. Any vanishing must come from the exact tensor algebra, incompressibility, or spherical harmonic structure.

Status:

```text
FIRST_MOMENT_ZERO_FROM_ODDNESS = FALSE_ROUTE
FIRST_MOMENT_TENSOR_CANCELLATION = OPEN_SIGNED_CANCELLATION
```

This is important: an argument claiming the first moment vanishes merely because `K_S` is odd is invalid.

## 6. Use of div omega = 0

Incompressibility gives `div omega = 0` distributionally for vorticity fields arising as `curl u`. A useful cancellation would need an exact integration-by-parts identity in the `y` variable that transfers derivatives onto the kernel or onto an admissible cutoff without creating an uncontrolled boundary/principal-value term.

Required bridge:

1. distributional `div omega = 0` in the same function/distribution class used by the kernel realization;
2. justified signed integration by parts in truncated annuli;
3. control of inner/outer boundary terms;
4. a limit as truncations are removed;
5. a resulting estimate that does not reintroduce `rho_*^{-3}`.

Status:

```text
DIV_OMEGA_CANCELLATION = OPEN_CZ / OPEN_SIGNED_CANCELLATION
```

## 7. Mean subtraction before absolute values

The structurally promising operation is to use a kernel moment identity to replace a factor by a fluctuation before taking absolute values, schematically

\[
\omega(y)\mapsto \omega(y)-\omega_A
\]

or

\[
\xi(y)\mapsto \xi(y)-m_A,
\]

where the subtracted mode is annihilated exactly by the signed kernel integral.

This is materially different from applying an absolute-value estimate first. It may expose oscillation factors, but any gain `(r/rho_*)^beta` is dimensionless.

Status:

```text
MEAN_SUBTRACTION_ARCHITECTURE = PLAUSIBLE_REORGANIZATION
EXACT_KERNEL_ANNIHILATION      = OPEN_SIGNED_CANCELLATION
```

## 8. Dimensional audit

The existing obstruction has the dimensions encoded by

\[
K^{-3}\rho_*^{-3}\|\omega\|_2^2.
\]

A factor

\[
(r/\rho_*)^\beta
\]

is dimensionless and therefore cannot, by itself, pay `rho_*^{-3}`.

Thus every proposed signed cancellation must pass the following audit question:

> Does the transformed bilinear estimate remove the pointwise `L^∞` squaring step entirely, or introduce an independently justified quantity with dimensions compensating `rho_*^{-3}`?

Current answer:

```text
RHO_STAR_CUBED_COMPENSATION = NOT_ESTABLISHED
```

## 9. Direct weighted target

The target remains

\[
|\mathcal F_{far}|
\le
\gamma\nu\int \phi^2|\nabla\xi_\varepsilon|^2|\omega_\varepsilon|
+C_\kappa\|\nabla u_\varepsilon\|_2^2J_r
+R_\varepsilon,
\qquad \gamma<\frac12,
\]

with constants uniform in `epsilon`, no unpaid `rho_*^{-3}`, and no intermediate `||S^far||_infty` estimate.

This remains:

```text
DIRECT_WEIGHTED_BILINEAR_ROUTE = TARGET_ISOLATED
DIRECT_WEIGHTED_BILINEAR_PROOF = NOT_ESTABLISHED
```

## 10. Final classification for Audit 78

```text
spherical kernel cancellation             OPEN_SIGNED_CANCELLATION
annular kernel cancellation               OPEN_SIGNED_CANCELLATION
first moment from parity alone             FALSE_ROUTE
first moment from tensor structure         OPEN_SIGNED_CANCELLATION
div omega signed cancellation              OPEN_CZ
mean subtraction before absolute values    POSSIBLE_REORGANIZATION
Campanato beta gain                        DIMENSIONLESS_GAIN_ONLY
rho_*^3 dimensional compensation           NOT_ESTABLISHED
pointwise far-field L-infinity route        BLOCKING_SCALING
direct weighted bilinear route             TARGET_ISOLATED / NOT_PROVED
```

No conclusion of FASE A or FASE B is promoted by this audit.
