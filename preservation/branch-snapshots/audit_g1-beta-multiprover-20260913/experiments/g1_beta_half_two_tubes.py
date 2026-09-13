#!/usr/bin/env python3
"""G1 beta diagnostic -- falsifiable toy experiment, NOT DNS and NOT proof.

Builds two smooth intersecting/near-colliding analytic vortex-tube profiles on a 3-D grid,
selects a high-vorticity region Omega_M, samples point pairs, and fits
    sin(angle(xi(x),xi(y))) ~ C |x-y|^beta.

A measured beta is evidence about this chosen finite-resolution toy field only. It cannot certify
Navier--Stokes evolution, a uniform-in-time Holder estimate, or G1.
"""
from __future__ import annotations
import argparse, csv, json, math
from pathlib import Path
import numpy as np


def two_tubes(n: int, L: float, sep: float, sigma: float, tilt: float):
    xs = np.linspace(-L, L, n)
    X, Y, Z = np.meshgrid(xs, xs, xs, indexing="ij")
    r1 = (X + sep / 2) ** 2 + Y ** 2
    a1 = np.exp(-r1 / (2 * sigma ** 2))
    w1 = np.stack([np.zeros_like(a1), tilt * a1 * np.tanh(Z), a1], axis=-1)
    r2 = (X - sep / 2) ** 2 + Z ** 2
    a2 = np.exp(-r2 / (2 * sigma ** 2))
    w2 = np.stack([tilt * a2 * np.tanh(Y), -a2, np.zeros_like(a2)], axis=-1)
    return xs, w1 + w2


def estimate(xs, w, threshold_frac, rho, samples, seed):
    rng = np.random.default_rng(seed)
    mag = np.linalg.norm(w, axis=-1)
    ids = np.argwhere(mag > threshold_frac * mag.max())
    coords = np.column_stack([xs[ids[:, 0]], xs[ids[:, 1]], xs[ids[:, 2]]])
    dirs = w[ids[:, 0], ids[:, 1], ids[:, 2]] / mag[ids[:, 0], ids[:, 1], ids[:, 2], None]
    m = len(ids)
    ia, ib = rng.integers(0, m, samples), rng.integers(0, m, samples)
    dist = np.linalg.norm(coords[ia] - coords[ib], axis=1)
    sintheta = np.linalg.norm(np.cross(dirs[ia], dirs[ib]), axis=1)
    keep = (dist > 1e-12) & (dist < rho) & (sintheta > 1e-12)
    x, y = np.log(dist[keep]), np.log(sintheta[keep])
    if len(x) < 10:
        raise RuntimeError("insufficient admissible pairs")
    beta, logC = np.polyfit(x, y, 1)
    pred = beta * x + logC
    ss_res = float(np.sum((y - pred) ** 2))
    ss_tot = float(np.sum((y - y.mean()) ** 2))
    r2 = 1.0 - ss_res / ss_tot if ss_tot else float("nan")
    return {"beta_hat": float(beta), "C_hat": float(np.exp(logC)), "r2_loglog": r2,
            "admissible_pairs": int(len(x)), "omega_region_points": int(m),
            "max_omega": float(mag.max())}


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--n", type=int, default=24); p.add_argument("--L", type=float, default=2.5)
    p.add_argument("--sep", type=float, default=.7); p.add_argument("--sigma", type=float, default=.45)
    p.add_argument("--tilt", type=float, default=.35); p.add_argument("--threshold-frac", type=float, default=.25)
    p.add_argument("--rho", type=float, default=.8); p.add_argument("--samples", type=int, default=200000)
    p.add_argument("--seed", type=int, default=0); p.add_argument("--out", default="g1_beta_result.json")
    a = p.parse_args(); xs, w = two_tubes(a.n, a.L, a.sep, a.sigma, a.tilt)
    result = estimate(xs, w, a.threshold_frac, a.rho, a.samples, a.seed)
    result.update({"model":"analytic_two_tube_toy_not_DNS", "n":a.n, "L":a.L, "sep":a.sep,
                   "sigma":a.sigma, "tilt":a.tilt, "threshold_frac":a.threshold_frac,
                   "rho":a.rho, "samples":a.samples, "seed":a.seed,
                   "beta_half_abs_error":abs(result["beta_hat"]-.5),
                   "interpretation":"toy finite-resolution diagnostic only; not evidence of a uniform PDE theorem"})
    Path(a.out).write_text(json.dumps(result, indent=2)+"\n")
    print(json.dumps(result, indent=2))

if __name__ == "__main__": main()
