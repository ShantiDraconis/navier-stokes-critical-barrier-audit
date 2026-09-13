"""cosmological_constant.py — compute Lambda * l_P^2 and the reciprocal.

Source for cosmological parameters: Planck 2018 (arXiv:1807.06209).
Source for fundamental constants: CODATA/NIST.
"""

from __future__ import annotations

import math

# ---------------------------------------------------------------------------
# CODATA / NIST fundamental constants (2018 CODATA recommended values)
# ---------------------------------------------------------------------------
c = 2.99792458e8        # m/s           exact
hbar = 1.054571817e-34  # J·s
G = 6.67430e-11         # m³/(kg·s²)

MPC_TO_M = 3.0856775814913673e22  # 1 Mpc in metres

# ---------------------------------------------------------------------------
# Planck length
# ---------------------------------------------------------------------------
l_P = math.sqrt(hbar * G / c**3)

# ---------------------------------------------------------------------------
# Planck 2018 base-ΛCDM central values
# ---------------------------------------------------------------------------
H0_km_s_Mpc = 67.4          # km/s/Mpc
Omega_m = 0.315
Omega_Lambda = 1.0 - Omega_m  # flat Universe assumption

# ---------------------------------------------------------------------------
# Hubble constant in SI
# ---------------------------------------------------------------------------
H0 = H0_km_s_Mpc * 1e3 / MPC_TO_M  # s^{-1}

# ---------------------------------------------------------------------------
# Critical density
# ---------------------------------------------------------------------------
rho_c = 3.0 * H0**2 / (8.0 * math.pi * G)  # kg/m³

# ---------------------------------------------------------------------------
# Cosmological constant from Omega_Lambda
# ---------------------------------------------------------------------------
rho_Lambda_SI = Omega_Lambda * rho_c  # kg/m³
Lambda = 3.0 * Omega_Lambda * H0**2 / c**2  # m^{-2}

# ---------------------------------------------------------------------------
# Dimensionless ratio Lambda * l_P^2
# ---------------------------------------------------------------------------
ratio = Lambda * l_P**2
log10_ratio = math.log10(ratio)
log10_reciprocal = math.log10(1.0 / ratio)

# ---------------------------------------------------------------------------
# Report
# ---------------------------------------------------------------------------
if __name__ == "__main__":
    print("=" * 60)
    print("Cosmological-constant Planck-unit calculation")
    print("Source: Planck 2018 arXiv:1807.06209 + CODATA/NIST")
    print("=" * 60)
    print(f"  H0               = {H0:.6e} s^-1")
    print(f"  rho_c            = {rho_c:.6e} kg/m^3")
    print(f"  Omega_Lambda     = {Omega_Lambda:.4f}")
    print(f"  Lambda           = {Lambda:.6e} m^-2")
    print(f"  l_P              = {l_P:.6e} m")
    print(f"  l_P^2            = {l_P**2:.6e} m^2")
    print(f"  Lambda * l_P^2   = {ratio:.4e}")
    print(f"  log10(Lambda l_P^2)          = {log10_ratio:.3f}")
    print(f"  log10(1 / Lambda l_P^2)      = {log10_reciprocal:.3f}")
    print()
    print("Interpretation:")
    print(f"  Lambda l_P^2 ~ 10^{log10_ratio:.1f}  (Padmanabhan notation: ~10^-123)")
    print(f"  (Lambda l_P^2)^-1 ~ 10^{log10_reciprocal:.1f}")
    print()
    print("Reference: Padmanabhan (2003) arXiv:hep-th/0212290")
    print("  writes explicitly: Lambda(G hbar/c^3) ~ 10^{-123}")
    print("  This is identical to Lambda * l_P^2.")
