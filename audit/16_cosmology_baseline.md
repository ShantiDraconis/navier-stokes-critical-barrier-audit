# 16 — Cosmological Baseline and Vacuum Energy Scales

## Purpose

This file documents the cosmological parameters, fundamental constants, and the
two principal vacuum-energy ratios used in the Orion audit.  It explains why
the literature uses 120, 122, and 123 as the order of magnitude and freezes the
exact conventions used in the Orion calculations.

**This is an accounting document, not a new physical claim.**

---

## 1. Frozen cosmological baseline

Source: Planck Collaboration 2018, arXiv:1807.06209, Table 2 (base-ΛCDM, Planck TT,TE,EE+lowE+lensing).

```
COSMOLOGY_BASELINE = Planck 2018 base-LambdaCDM
H0      = 67.4 km/s/Mpc          (± 0.5)
Omega_m = 0.315                   (± 0.007)
omega_c = Omega_c * h^2 = 0.120  (± 0.001)
omega_b = Omega_b * h^2 = 0.0224 (± 0.0001)
h       = 0.674
assumption: spatially flat base-LambdaCDM
```

Derived quantities at these central values:

```
Omega_b    ≈ 0.0224 / 0.674² ≈ 0.0493
Omega_c    ≈ 0.120  / 0.674² ≈ 0.264
Omega_Lambda ≈ 1 - Omega_m ≈ 0.685   (flat Universe)
```

---

## 2. Fundamental constants (CODATA/NIST)

Source: NIST CODATA Fundamental Constants, https://physics.nist.gov/cgi-bin/cuu/

```
c      = 2.99792458e8   m/s        (exact)
hbar   = 1.054571817e-34 J·s
G      = 6.67430e-11   m³/(kg·s²)
1 Mpc  = 3.0856775814913673e22 m
1 GeV  = 1.602176634e-10 J       (exact, via eV definition)
```

Planck units:

```
l_P    = sqrt(hbar G / c³)   ≈ 1.6163e-35 m
M_P    = sqrt(hbar c / G)    ≈ 2.176e-8 kg  ≈ 1.221e19 GeV
M_Pbar = 1/sqrt(8π G)        ≈ 2.435e18 GeV    (reduced Planck mass)
```

Note:
```
M_P = sqrt(8π) · M_Pbar
M_P^4 = (8π)² · M_Pbar^4
(8π)² ≈ 631.65  →  log10(631.65) ≈ 2.80
```

---

## 3. Vacuum energy density reconstruction

Step 1 — Hubble constant in SI:

```
H0 = 67.4e3 / 3.0856775814913673e22  s⁻¹
   ≈ 2.1843e-18 s⁻¹
```

Step 2 — Critical density:

```
rho_c = 3 H0² / (8π G)
      ≈ 3 × (2.1843e-18)² / (8π × 6.67430e-11)
      ≈ 8.53e-27 kg/m³
```

Step 3 — Vacuum energy density:

```
rho_Lambda = Omega_Lambda × rho_c
           ≈ 0.685 × 8.53e-27
           ≈ 5.84e-27 kg/m³
```

Step 4 — Energy density (×c²):

```
u_Lambda = rho_Lambda × c²
         ≈ 5.25e-10 J/m³
```

Step 5 — In natural units (1 GeV⁴ = 1.602e-10 J × (2.998e8/1.602e-10)³ m⁻³):

```
rho_Lambda ≈ 2.52e-47 GeV⁴
rho_Lambda^(1/4) ≈ 2.2e-3 eV = 2.2 meV
```

---

## 4. The two principal vacuum ratios — WHY 120 and 123

These are **not the same quantity**.  Recording both prevents future inconsistency
accusations.

### Formulation A — Reduced-Planck-mass ratio (order 10^120)

```
R_Pbar = M_Pbar^4 / rho_Lambda
       = (2.435e18 GeV)^4 / (2.52e-47 GeV^4)
```

Numerator:
```
(2.435e18)^4 ≈ 3.52e73 GeV^4
```

Ratio:
```
R_Pbar ≈ 3.52e73 / 2.52e-47 ≈ 1.40e120
log10(R_Pbar) ≈ 120.15
```

**This is the origin of "approximately 120 orders of magnitude" in modern
cosmological constant discussions.**

### Formulation B — Cosmological constant in Planck units (order 10^−123)

```
Lambda l_P² ≈ (1.09e-52 m⁻²) × (1.6163e-35 m)²
            = (1.09e-52) × (2.612e-70)
            ≈ 2.85e-122
```

Reciprocal:
```
(Lambda l_P²)^{-1} ≈ 3.51e121
```

Padmanabhan (arXiv:hep-th/0212290) writes explicitly:
```
Λ (G ħ / c³) ≈ 10^{-123}
```

With slightly different rounding conventions:
```
Lambda l_P² ~ 10^{-122} to 10^{-123}
```

**This is the origin of "approximately 123 orders of magnitude" in Padmanabhan
and related vacuum-energy discussions.**

### Why 120 vs 123 differs by ~3 orders

1. The two quantities are dimensionally distinct:
   - Formulation A: a ratio of energy densities (GeV⁴/GeV⁴)
   - Formulation B: a dimensionless cosmological constant in Planck units (m⁻²·m²)

2. Using the unmodified Planck mass M_P instead of M_Pbar adds:
   ```
   log10((8π)²) ≈ 2.80  →  R_P ≈ 10^{122.95}
   ```

3. Rounding and parameter variation (Omega_Lambda, h) can shift results by ±1.

The apparent contradiction between 120 and 123 is therefore entirely explained
by the choice of normalization, and **neither number supersedes the other**.

---

## 5. Higgs vacuum comparison

Source: Particle Data Group 2025, Higgs Boson listing.

```
m_H = 125.20 ± 0.11 GeV
v   = 246.22 GeV    (electroweak vev)
```

Tree-level quartic coupling:
```
lambda = m_H² / (2 v²) ≈ 125.20² / (2 × 246.22²) ≈ 0.1293
mu     = m_H / sqrt(2) ≈ 88.53 GeV
```

Classical Higgs vacuum energy at the minimum:
```
|V_min| = m_H² v² / 8
        ≈ 125.20² × 246.22² / 8
        ≈ 1.19e8 GeV^4
```

Comparison with rho_Lambda:
```
|V_min| / rho_Lambda ≈ 1.19e8 / 2.52e-47 ≈ 4.7e54
log10(4.7e54) ≈ 54.67
```

**Audit note:** This is the classical tree-level Higgs contribution comparison.
It is NOT "the Standard Model prediction for the cosmological constant".
The relationship between renormalized vacuum energy and gravity is the conceptual
core of the cosmological constant problem (Weinberg, Rev. Mod. Phys. 61, 1989).

---

## 6. What is pre-existing and what must not be claimed as original

| Quantity | Value | Status |
|---------|-------|--------|
| Λ l_P² ~ 10^{-123} | `≈ 2.85e-122` | **Prior literature** — Padmanabhan (2002/2003) and many others |
| M_Pbar^4 / ρ_Λ ~ 10^120 | `≈ 1.40e120` | **Prior literature** — standard vacuum energy problem |
| ρ_Λ^{1/4} ~ meV | `≈ 2.2 meV` | **Prior literature** — classical result |
| Planck 2018 cosmological parameters | see section 1 | **Prior literature** — Planck Collaboration |
| Higgs mass and couplings | see section 5 | **Prior literature** — PDG |
| Calculation of these numbers by Fagliari | see evidence/ | **Independent reproduction**, not discovery |

If Orion files show earlier calculation of these numbers, that is documented as:
> independent derivation/reproduction of a known physical scale.

It is NOT:
> discovery of the 10^{-123} cosmological-constant discrepancy.

---

## 7. References

- Planck Collaboration 2018: arXiv:1807.06209 — source for H0, Omega_m, omega_b, omega_c
- NIST CODATA: https://physics.nist.gov/cgi-bin/cuu/ — source for G, ħ, c, Planck units
- Padmanabhan 2003: arXiv:hep-th/0212290 — explicitly states Λ(Għ/c³) ≈ 10^{-123}
- Weinberg 1989: Rev. Mod. Phys. 61, 1 — classical review of cosmological constant problem; distinction between theoretical vacuum energy and observed Λ
- PDG 2025: Higgs Boson listing — m_H = 125.20 ± 0.11 GeV
