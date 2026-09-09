"""higgs_vacuum.py — compute tree-level Higgs vacuum energy and comparison with rho_Lambda.

Source for Higgs parameters: PDG 2025 listing.
Source for cosmological parameters: Planck 2018 (arXiv:1807.06209).
Source for fundamental constants: CODATA/NIST.

Audit note: |V_min| computed here is the CLASSICAL TREE-LEVEL Higgs potential
energy at its minimum.  It is NOT "the Standard Model prediction for the
cosmological constant".  The relationship between renormalized vacuum energy and
gravity is the conceptual core of the cosmological constant problem.
Reference: Weinberg (1989) Rev. Mod. Phys. 61, 1.
"""

from __future__ import annotations

import math

# ---------------------------------------------------------------------------
# CODATA / NIST fundamental constants
# ---------------------------------------------------------------------------
c = 2.99792458e8        # m/s
hbar = 1.054571817e-34  # J·s
G = 6.67430e-11         # m³/(kg·s²)

MPC_TO_M = 3.0856775814913673e22
J_PER_GEV = 1.602176634e-10

# ---------------------------------------------------------------------------
# PDG 2025 Higgs parameters
# ---------------------------------------------------------------------------
m_H_GeV = 125.20    # GeV  (PDG 2025; ±0.11 GeV)
v_GeV   = 246.22    # GeV  (electroweak vev)

# Tree-level relations
lambda_quartic = m_H_GeV**2 / (2.0 * v_GeV**2)
mu_GeV         = m_H_GeV / math.sqrt(2.0)

# Classical Higgs vacuum energy at minimum: |V_min| = m_H^2 v^2 / 8
V_min_GeV4 = m_H_GeV**2 * v_GeV**2 / 8.0

# ---------------------------------------------------------------------------
# rho_Lambda in GeV^4  (from Planck 2018, same computation as vacuum_planck_ratio.py)
# ---------------------------------------------------------------------------
H0 = 67.4e3 / MPC_TO_M   # s^{-1}
rho_c = 3.0 * H0**2 / (8.0 * math.pi * G)  # kg/m³
Omega_Lambda = 1.0 - 0.315
u_Lambda = Omega_Lambda * rho_c * c**2      # J/m³
hbar_c = hbar * c
rho_Lambda_GeV4 = u_Lambda * hbar_c**3 / J_PER_GEV**4

# ---------------------------------------------------------------------------
# Ratios
# ---------------------------------------------------------------------------
ratio = V_min_GeV4 / rho_Lambda_GeV4
log10_ratio = math.log10(ratio)

if __name__ == "__main__":
    print("=" * 60)
    print("Tree-level Higgs vacuum vs cosmological constant")
    print("Higgs: PDG 2025 | Cosmology: Planck 2018")
    print("=" * 60)
    print(f"  m_H                   = {m_H_GeV:.2f} GeV  (PDG 2025, ±0.11 GeV)")
    print(f"  v (electroweak vev)   = {v_GeV:.2f} GeV")
    print(f"  lambda (tree-level)   = {lambda_quartic:.4f}")
    print(f"  mu (tree-level)       = {mu_GeV:.2f} GeV")
    print()
    print(f"  |V_min|               = {V_min_GeV4:.4e} GeV^4")
    print(f"  rho_Lambda            = {rho_Lambda_GeV4:.4e} GeV^4")
    print()
    print(f"  |V_min| / rho_Lambda  = {ratio:.4e}")
    print(f"  log10(ratio)          = {log10_ratio:.2f}")
    print()
    print("AUDIT NOTE: This is a tree-level comparison, NOT the SM prediction")
    print("for the cosmological constant.  See Weinberg (1989) for the correct")
    print("conceptual framing of the cosmological constant problem.")
