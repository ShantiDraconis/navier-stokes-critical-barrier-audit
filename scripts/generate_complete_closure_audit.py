import os, datetime

# Exact target constants requested for the closure audit.
# IMPORTANT: these are TARGET constants, not certified proof constants.
C_BERN = 4
C_SOB = 0.62
C_ERROR = C_BERN * C_SOB  # 2.48

def kappa(nu, Lambda):
    return nu * Lambda**2 / 4

# Real gaps that remain OPEN.
gaps = [
    ("B2.8", "Pi >= kappa R - C_error Lambda^{-1/2} R", f"kappa=nu Lambda^2/4={kappa(1,10)}, C_error={C_ERROR}", "OPEN - requires complete LP + CZ R_iR_j L^{3/2} + control ||S_le||_inf <= c* from refined H_repo"),
    ("B2.10", "H_refined => M3 < inf via Gronwall exp(-(nu Lambda^2 - kappa)T)", "C_final=C_Sob/(nu Lambda^2-kappa)", "OPEN - requires a sign-consistent integration of B2.4 with the B2.8 estimate"),
    ("RH G8", "Arb + Rouche for zeta(B(rho,r))", "r=0.01, |zeta|>=1e-20 on boundary, |zeta(rho_model)|<=1e-30", "OPEN - requires rigorous interval arithmetic / argument-principle certificate"),
    ("YM G16", "OS measure + Hilbert + Delta>0", "Delta=1 target normalization", "OPEN - requires lattice construction + continuum limit + reflection positivity + mass-gap proof; Delta=1 is normalization/target, not established value"),
    ("PvsNP G11", "SAT not in P", "Time >= 2^{Omega(n)} target", "OPEN - requires an unconditional complexity lower bound; current barriers apply"),
]

os.makedirs("audit", exist_ok=True)
os.makedirs("Lean/Millennium", exist_ok=True)
os.makedirs("Lean/NavierStokes/B2", exist_ok=True)
os.makedirs("data", exist_ok=True)

with open("audit/49_complete_closure_targets.md", "w", encoding="utf-8") as f:
    f.write(f"""# Audit 49 — Complete Closure Targets

Data: {datetime.datetime.utcnow().isoformat()}Z  
Commit base reported by the research log: `b3630bff406e23afab649965107a1d32d996fe53`

## Objective

Freeze the exact mathematical/formal statements that would close the remaining gaps **if proved**. None of the TARGET axioms below constitutes a proof.

## Target constants

- `C_Bernstein = {C_BERN}`
- `C_Sobolev_R3 = {C_SOB}`
- `C_error = C_Bernstein * C_Sobolev_R3 = {C_ERROR}`
- `kappa(nu,Lambda) = nu*Lambda^2/4`
- `cstar = nu/(4*C_Sobolev_R3) ≈ {1/(4*C_SOB):.6f} * nu`

These numbers are frozen as research targets. They are not automatically sharp or theorem-certified merely because they are explicit.

## Gaps

| ID | CLOSED lemma target | Constant / target | Status |
|---|---|---|---|
""")
    for id_, lemma, const, status in gaps:
        f.write(f"| {id_} | {lemma} | {const} | {status} |\n")
    f.write("""

## B2.9 — finite-dimensional obstruction CLOSED

Take

`S = diag(1,-0.5,-0.5)`, so `trace(S)=0`,

`u1=[1,0,0]`, `u2=[0,1,0]`.

Then

- `R1 = 0.5 ||u1||^2 = 0.5`,
- `R2 = 0.5 ||u2||^2 = 0.5`,
- `Pi1 = -u1^T S u1 = -1`,
- `Pi2 = -u2^T S u2 = 0.5`.

Therefore `R1 = R2` but `Pi1 != Pi2`: a scalar energy residual does not determine the signed strain/flux pairing.

This closes the **matrix obstruction only**. To call the full PDE version closed, one still needs a smooth divergence-free frequency-localized embedding realizing the same obstruction inside the Navier–Stokes admissible class.

## Sign convention release gate

With the convention

`Pi_Lambda = -<P_>(u·∇u),u_>>`

and energy identity

`R' + nu ||∇u_>||_2^2 = Pi_Lambda + forcing`,

a decay proof naturally needs an **upper** bound on `Pi_Lambda`, or an equivalent lower bound after reversing the definition of the flux sign. Any B2.8/B2.10 implementation must make this convention explicit before claiming coercive decay.

## What a real NS-closing commit would need

- `Lean/NavierStokes/B2/B2_8_LowerBound.lean` or sign-corrected `B2_8_FluxControl.lean`, with no `sorry`/`axiom OPEN`, complete LP/paraproduct/CZ hypotheses, and a proved signed estimate.
- `Lean/NavierStokes/B2/B2_10_Gronwall.lean`, deriving the critical-tail / `L^∞_t L^3_x` control without circularly assuming regularity.
- CI/lake build artifact for the exact commit.

No historical SHA currently cited in the audit is classified as that closure commit.
""")

with open("Lean/Millennium/CompleteClosure_Targets.lean", "w", encoding="utf-8") as f:
    f.write(f"""import Mathlib.Data.Matrix.Basic

noncomputable section
open Matrix

/-!
# Complete Closure Targets

These declarations deliberately distinguish a proved finite-dimensional B2.9 obstruction
from OPEN research targets. `axiom ..._TARGET` means the target is NOT proved.
-/

def C_Bernstein : ℝ := {C_BERN}
def C_Sobolev_R3 : ℝ := {C_SOB}
def C_error : ℝ := {C_ERROR}
def kappa (ν Λ : ℝ) : ℝ := ν * Λ^2 / 4
def cstar (ν : ℝ) : ℝ := ν / (4 * C_Sobolev_R3)

def S_divFree : Matrix (Fin 3) (Fin 3) ℝ := !![1,0,0; 0,-0.5,0; 0,0,-0.5]
def u1 : Fin 3 → ℝ := ![1,0,0]
def u2 : Fin 3 → ℝ := ![0,1,0]
def R_Lambda (norm2 : ℝ) : ℝ := (1/2 : ℝ) * norm2
def Pi_Lambda (S : Matrix (Fin 3) (Fin 3) ℝ) (u : Fin 3 → ℝ) : ℝ := -(u ⬝ᵥ (S *ᵥ u))

theorem B2_9_R_equal :
    R_Lambda (u1 ⬝ᵥ u1) = R_Lambda (u2 ⬝ᵥ u2) := by
  simp [R_Lambda, u1, u2, dotProduct]

theorem B2_9_Pi_different :
    Pi_Lambda S_divFree u1 ≠ Pi_Lambda S_divFree u2 := by
  simp [Pi_Lambda, S_divFree, u1, u2, dotProduct, mulVec]
  norm_num

/- OPEN TARGETS: these axioms are specifications, not proofs. -/
axiom B2_8_TARGET : ∀ Λ ν u,
  Λ ≥ 1 → ν > 0 →
  ∃ κ : ℝ, κ = kappa ν Λ ∧
    Pi_Lambda S_divFree u ≥
      κ * R_Lambda (u ⬝ᵥ u) - C_error * Λ⁻¹ * R_Lambda (u ⬝ᵥ u)

axiom B2_10_TARGET : ∀ Λ ν T,
  ν * Λ^2 > kappa ν Λ → True

axiom RH_G8_TARGET : ∀ (ρ_model : ℂ) (r : ℝ), r = 0.01 → True
axiom YM_G16_TARGET : ∀ (G : Type), ∃ Δ : ℝ, Δ = 1 ∧ Δ > 0
axiom PvsNP_G11_TARGET : True
axiom BSD_TARGET : True
axiom HODGE_TARGET : True

def Final_Residues : List (String × String) :=
  [("NS", "0 target — M3<inf"),
   ("RH", "empty target — Re=0.5"),
   ("PvsNP", "SAT not in P target"),
   ("YM", "Delta=1>0 target normalization")]
""")

with open("audit/B2_9_counterexample.py", "w", encoding="utf-8") as f:
    f.write("""import numpy as np
S = np.diag([1.0, -0.5, -0.5])
u1 = np.array([1., 0., 0.])
u2 = np.array([0., 1., 0.])
R1 = 0.5 * np.dot(u1, u1)
R2 = 0.5 * np.dot(u2, u2)
Pi1 = -u1 @ S @ u1
Pi2 = -u2 @ S @ u2
print(f"R1={R1} R2={R2} Pi1={Pi1} Pi2={Pi2}")
print(f"B2.9 matrix obstruction: R1==R2={R1==R2} Pi1!=Pi2={Pi1!=Pi2}")
assert R1 == R2
assert Pi1 != Pi2
""")

with open("data/gap_matrix_closure_targets.csv", "w", encoding="utf-8") as f:
    f.write("ID,STATUS,RESIDUE_MATH,CONSTANTE\n")
    f.write('B2.9,PROVED_MATRIX_OBSTRUCTION,"R1=R2; Pi1!=Pi2","S=diag(1,-0.5,-0.5)"\n')
    f.write('B2.8,TARGET,"signed flux control; sign convention must be frozen","kappa=nu Lambda^2/4; C_error=2.48"\n')
    f.write('B2.10,TARGET,"critical-tail/Gronwall bridge to M3<inf","C_final target=0.62/(nu Lambda^2/2)"\n')
    f.write('G8,TARGET,"Res_RH=empty","r=0.01; boundary |zeta|>=1e-20 target"\n')
    f.write('G16,TARGET,"mass gap >0","Delta=1 target normalization; area-law/OS proof absent"\n')
    f.write('G11,TARGET,"SAT not in P","unconditional lower bound absent"\n')

print("Generated:")
print("- audit/49_complete_closure_targets.md")
print("- Lean/Millennium/CompleteClosure_Targets.lean")
print("- audit/B2_9_counterexample.py")
print("- data/gap_matrix_closure_targets.csv")
print("Run: python audit/B2_9_counterexample.py && lake build")
