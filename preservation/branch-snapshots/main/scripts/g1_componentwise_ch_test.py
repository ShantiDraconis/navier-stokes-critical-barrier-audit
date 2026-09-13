#!/usr/bin/env python3
"""Deterministic synthetic audit of global versus componentwise C_H.

This is a falsification/convergence harness, not a Navier--Stokes solver.
It uses an analytic divergence-free vorticity packet omega = curl(0,0,psi)
and Monte Carlo quadrature/pair sampling on quantized N^3 grids.
"""

from __future__ import annotations

import argparse
import csv
import json
import math
from dataclasses import asdict, dataclass
from pathlib import Path

import numpy as np


@dataclass
class Result:
    experiment: str
    N: int
    ell: float
    cells_per_ell: float
    kappa: float
    l2: float
    grad_l2: float
    rho: float
    accepted_pairs: int
    ch95: float
    ch99: float
    chmax: float


def packet(x: np.ndarray, ell: float) -> tuple[np.ndarray, np.ndarray]:
    """Return omega and its analytic Jacobian for psi=ell*exp(-|x|^2/(2ell^2))."""
    q = np.sum(x * x, axis=1) / (ell * ell)
    e = np.exp(-0.5 * q)
    # omega=(d_y psi,-d_x psi,0)=e*(-y/ell,x/ell,0)
    w = np.column_stack((-x[:, 1] / ell * e, x[:, 0] / ell * e, np.zeros(len(x))))
    j = np.zeros((len(x), 3, 3))
    # derivatives of omega_i with respect to x_j
    j[:, 0, 0] = x[:, 0] * x[:, 1] / ell**3 * e
    j[:, 0, 1] = (-1 / ell + x[:, 1] ** 2 / ell**3) * e
    j[:, 0, 2] = x[:, 1] * x[:, 2] / ell**3 * e
    j[:, 1, 0] = (1 / ell - x[:, 0] ** 2 / ell**3) * e
    j[:, 1, 1] = -x[:, 0] * x[:, 1] / ell**3 * e
    j[:, 1, 2] = -x[:, 0] * x[:, 2] / ell**3 * e
    return w, j


def quantize(x: np.ndarray, n: int, box: float) -> np.ndarray:
    dx = 2 * box / n
    return np.clip((np.floor((x + box) / dx) + 0.5) * dx - box, -box + dx / 2, box - dx / 2)


def estimate(n: int, ell: float, kappa: float, samples: int, pairs: int, seed: int,
             experiment: str) -> Result:
    rng = np.random.default_rng(seed + n + round(1e6 * ell) + round(100 * kappa))
    box = 0.5
    x = quantize(rng.uniform(-box, box, size=(samples, 3)), n, box)
    w, jac = packet(x, ell)
    l2 = math.sqrt(float(np.mean(np.sum(w * w, axis=1))))
    grad_l2 = math.sqrt(float(np.mean(np.sum(jac * jac, axis=(1, 2)))))
    rho = kappa * l2 / grad_l2

    # Draw base points from the intense-vorticity component and local displacements.
    mag = np.linalg.norm(w, axis=1)
    active = x[mag >= 0.25 * np.max(mag)]
    vals: list[np.ndarray] = []
    remaining = pairs
    attempts = 0
    while remaining > 0 and attempts < 30:
        m = min(max(4 * remaining, 2000), 250000)
        xb = active[rng.integers(0, len(active), size=m)]
        dirs = rng.normal(size=(m, 3))
        dirs /= np.linalg.norm(dirs, axis=1)[:, None]
        # Uniform in volume, exclude sub-grid separations.
        rr = rho * rng.random(m) ** (1 / 3)
        y = quantize(xb + dirs * rr[:, None], n, box)
        wy, _ = packet(y, ell)
        wx, _ = packet(xb, ell)
        mx = np.linalg.norm(wx, axis=1)
        my = np.linalg.norm(wy, axis=1)
        dist = np.linalg.norm(y - xb, axis=1)
        good = (my >= 0.25 * np.max(mag)) & (dist > 0) & (dist < rho) & (mx > 0) & (my > 0)
        if np.any(good):
            sinth = np.linalg.norm(np.cross(wx[good], wy[good]), axis=1) / (mx[good] * my[good])
            ch = sinth / np.sqrt(dist[good] / rho)
            vals.append(ch[:remaining])
            remaining -= min(remaining, len(ch))
        attempts += 1
    if not vals:
        arr = np.array([math.nan])
    else:
        arr = np.concatenate(vals)[:pairs]
    return Result(experiment, n, ell, n * ell, kappa, l2, grad_l2, rho, len(arr),
                  float(np.quantile(arr, .95)), float(np.quantile(arr, .99)), float(np.max(arr)))


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--out", default="results")
    ap.add_argument("--samples", type=int, default=200_000)
    ap.add_argument("--pairs", type=int, default=50_000)
    args = ap.parse_args()
    out = Path(args.out)
    out.mkdir(parents=True, exist_ok=True)
    rows: list[Result] = []
    for n in (64, 128, 256, 512):
        rows.append(estimate(n, 1 / 16, 1.0, args.samples, args.pairs, 1701, "fixed_field_refinement"))
        rows.append(estimate(n, 16 / n, 1.0, args.samples, args.pairs, 1701, "shrinking_packet_family"))
    # Kappa covariance check on one fixed resolved packet.
    for kappa in (0.25, 1.0, 4.0):
        rows.append(estimate(256, 1 / 16, kappa, args.samples, args.pairs, 991, "kappa_covariance"))
    with (out / "g1_componentwise_ch_results.csv").open("w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=Result.__annotations__.keys())
        writer.writeheader()
        writer.writerows(asdict(r) for r in rows)
    summary = {
        "classification": "synthetic_falsification_only",
        "not_a_navier_stokes_simulation": True,
        "rows": [asdict(r) for r in rows],
    }
    (out / "g1_componentwise_ch_results.json").write_text(json.dumps(summary, indent=2) + "\n")
    print(json.dumps(summary, indent=2))


if __name__ == "__main__":
    main()
