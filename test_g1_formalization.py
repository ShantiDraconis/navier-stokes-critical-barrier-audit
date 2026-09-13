#!/usr/bin/env python3
"""Static and numerical checks for the audit-safe G1 formalization.

This script does not claim to replace the Lean kernel.  It fails if a proof
escape or an unconditional global-regularity declaration is introduced, checks
the scalar identities used by the formal layer, and runs the deterministic
synthetic diagnostics already present in the audit workspace.
"""

from __future__ import annotations

import json
import math
import re
import subprocess
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parent
LEAN_FILES = [
    ROOT / "G1_KAdmissible_to_SignedDepletion.lean",
    ROOT / "PerelmanLikeStabilizationSpec.lean",
    ROOT / "MillenniumAudit" / "StabilizedHypothetical.lean",
]
FORBIDDEN = {
    "sorry": re.compile(r"\bsorry\b"),
    "admit": re.compile(r"\badmit\b"),
    "axiom": re.compile(r"^\s*axiom\b", re.MULTILINE),
    "unsafe": re.compile(r"^\s*unsafe\b", re.MULTILINE),
}


def source_without_comments(text: str) -> str:
    text = re.sub(r"/-.*?-/", "", text, flags=re.DOTALL)
    return re.sub(r"--.*?$", "", text, flags=re.MULTILINE)


def static_checks() -> dict[str, object]:
    raw = "\n".join(path.read_text(encoding="utf-8") for path in LEAN_FILES)
    src = source_without_comments(raw)
    hits = {name: bool(pattern.search(src)) for name, pattern in FORBIDDEN.items()}
    assert not any(hits.values()), hits
    assert "theorem ActualNS_global_regularity" not in src
    assert "theorem F_conditional_global_regularity" in src
    assert "theorem Perelman_like_22_25_3_1" in src
    assert "structure K1LowerSemicontinuityCertificate" in src
    assert "structure JointEvolutionCertificate" in src
    return {"forbidden_tokens": hits, "unconditional_theorem": False}


def algebra_checks() -> dict[str, float]:
    # Representative strict budget.
    bulk, tail = 0.63, 0.18
    theta = bulk + tail
    delta = 1.0 - theta
    assert 0.0 < delta < 1.0

    # Gronwall values discussed in the audit.
    a_small = math.log(4.17) / 2.0
    assert math.isclose(math.exp(2.0 * a_small), 4.17, rel_tol=1e-12)
    a_large = 36.0
    large_factor = math.exp(2.0 * a_large)
    assert large_factor > 1e31

    # Scaling of Phi = ||omega||_2 ||u||_3 /(nu ||grad u||_2).
    lam = 7.0
    omega_l2, u_l3, grad_u_l2, nu = 2.0, 3.0, 2.5, 1.0
    phi = omega_l2 * u_l3 / (nu * grad_u_l2)
    phi_scaled = ((lam ** 0.5) * omega_l2) * u_l3 / (
        nu * (lam ** 0.5) * grad_u_l2
    )
    assert math.isclose(phi, phi_scaled)

    return {
        "theta": theta,
        "strict_margin": delta,
        "integral_a_for_factor_4_17": a_small,
        "exp_72": large_factor,
        "phi": phi,
        "phi_scaled": phi_scaled,
        "explicit_C2_time_budget": 2.0 * 0.6**2 * 50.0,
        "theta_from_phi": 0.6 / 1.6,
        "dissipative_margin_nu_001": 2.0 * (1.0 - 0.375) * 0.01,
    }


def run_diagnostic(script: str, out: str, samples: int, pairs: int) -> None:
    subprocess.run(
        [sys.executable, str(ROOT / script), "--out", str(ROOT / out),
         "--samples", str(samples), "--pairs", str(pairs)],
        check=True,
        stdout=subprocess.DEVNULL,
    )


def main() -> None:
    report = {
        "static": static_checks(),
        "algebra": algebra_checks(),
        "lean_kernel": "NOT_RUN_ENVIRONMENT_MISSING" if not shutil_which("lean") else "AVAILABLE",
    }
    run_diagnostic("g1_componentwise_ch_test.py", "test_results", 20_000, 5_000)
    run_diagnostic("g1_joint_tail_diagnostic.py", "test_results", 20_000, 5_000)
    if shutil_which("lean"):
        for lean_file in LEAN_FILES:
            subprocess.run([shutil_which("lean"), str(lean_file)], check=True)
        report["lean_kernel"] = "PASS"
    report["numerical_diagnostics"] = "PASS_SYNTHETIC_ONLY"
    destination = ROOT / "test_results" / "formalization_test_report.json"
    destination.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(report, indent=2))


def shutil_which(command: str) -> str | None:
    from shutil import which
    return which(command)


if __name__ == "__main__":
    main()
