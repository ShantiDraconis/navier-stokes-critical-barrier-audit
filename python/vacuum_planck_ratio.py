"""vacuum_planck_ratio.py — compute M_Pbar^4 / rho_Lambda (Formulation A, ~10^120).

Source for cosmological parameters: Planck 2018 (arXiv:1807.06209).
Source for fundamental constants: CODATA/NIST.
"""

from __future__ import annotations

import math

# ---------------------------------------------------------------------------
# CODATA / NIST fundamental constants
# ---------------------------------------------------------------------------
c = 2.99792458e8        # m/s           exact
hbar = 1.054571817e-34  # J·s
G = 6.67430e-11         # m³/(kg·s²)

MPC_TO_M = 3.0856775814913673e22  # 1 Mpc in metres

# Conversion: 1 GeV = 1.602176634e-10 J  (exact)
J_PER_GEV = 1.602176634e-10

# ---------------------------------------------------------------------------
# Reduced Planck mass in GeV
# ---------------------------------------------------------------------------
# M_Pbar = 1 / sqrt(8 pi G)  in natural units
# In SI: M_Pbar [kg] = sqrt(hbar c / (8 pi G))
M_Pbar_kg = math.sqrt(hbar * c / (8.0 * math.pi * G))
M_Pbar_J = M_Pbar_kg * c**2                     # rest-energy in J
M_Pbar_GeV = M_Pbar_J / J_PER_GEV               # in GeV

# Conventional (unmodified) Planck mass
M_P_kg = math.sqrt(hbar * c / G)
M_P_GeV = M_P_kg * c**2 / J_PER_GEV

# ---------------------------------------------------------------------------
# Planck 2018 base-ΛCDM central values
# ---------------------------------------------------------------------------
H0_km_s_Mpc = 67.4
Omega_m = 0.315
Omega_Lambda = 1.0 - Omega_m  # flat

H0 = H0_km_s_Mpc * 1e3 / MPC_TO_M  # s^{-1}

rho_c = 3.0 * H0**2 / (8.0 * math.pi * G)   # kg/m³

# ---------------------------------------------------------------------------
# rho_Lambda in GeV^4
# ---------------------------------------------------------------------------
# Natural units: rho [GeV^4] = rho [J/m^3] / (J_per_GeV * c^2 / hbar / c)^3 / J_per_GeV
# Simpler: use energy density u = rho * c^2 in J/m^3, then convert to GeV/m^3,
# then multiply by (hbar c)^3 to get dimensionless GeV^4.

rho_Lambda_kg = Omega_Lambda * rho_c  # kg/m^3
u_Lambda_J_m3 = rho_Lambda_kg * c**2  # J/m^3   (energy density)

# 1 GeV/m^3 = J_PER_GEV / m^3
# Energy density in GeV^4 (natural units, hbar=c=1):
#   [E]^4 = [E/m^3] * [length^3] = [E/m^3] * (hbar*c/E)^3
# rho [GeV^4] = u_Lambda [J/m^3] * (hbar c)^3 [J^3 m^3] / J_PER_GEV^4
hbar_c = hbar * c   # J·m
rho_Lambda_GeV4 = u_Lambda_J_m3 * hbar_c**3 / J_PER_GEV**4

# ---------------------------------------------------------------------------
# Ratios
# ---------------------------------------------------------------------------
R_Pbar = M_Pbar_GeV**4 / rho_Lambda_GeV4
R_P    = M_P_GeV**4    / rho_Lambda_GeV4

log10_R_Pbar = math.log10(R_Pbar)
log10_R_P    = math.log10(R_P)

# Shift between reduced and conventional
log10_shift = math.log10((8.0 * math.pi)**2)  # = 2*log10(8pi)

if __name__ == "__main__":
    print("=" * 60)
    print("Vacuum-energy / Planck-scale ratio (Formulation A)")
    print("Source: Planck 2018 arXiv:1807.06209 + CODATA/NIST")
    print("=" * 60)
    print(f"  M_Pbar              = {M_Pbar_GeV:.4e} GeV  (reduced Planck mass)")
    print(f"  M_P                 = {M_P_GeV:.4e} GeV  (conventional Planck mass)")
    print(f"  rho_Lambda          = {rho_Lambda_GeV4:.4e} GeV^4")
    print()
    print(f"  M_Pbar^4 / rho_Lam  = {R_Pbar:.4e}")
    print(f"  log10(R_Pbar)       = {log10_R_Pbar:.3f}  ← Formulation A ('~10^120')")
    print()
    print(f"  M_P^4 / rho_Lam     = {R_P:.4e}")
    print(f"  log10(R_P)          = {log10_R_P:.3f}  ← using unmodified Planck mass")
    print()
    print(f"  log10((8π)²) = {log10_shift:.4f} — explains ~2.8 order shift between")
    print("  formulations using reduced vs conventional Planck mass")
    print()
    print("Note: Formulation A measures a ratio of energy densities (GeV^4/GeV^4).")
    print("It is NOT the same quantity as Lambda * l_P^2 (Formulation B).")
    print("See audit/16_cosmology_baseline.md for the full explanation.")
