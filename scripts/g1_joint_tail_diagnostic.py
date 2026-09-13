#!/usr/bin/env python3
"""Empirical joint-law and kernel-tail diagnostic for the synthetic G1 packet.

This program does not estimate the Navier--Stokes stretching integral and does not
prove an analytic tail inequality. It quantifies the sampled proxy that motivated
the two explicit v3 proof obligations.
"""

from __future__ import annotations

import argparse
import csv
import json
import math
from pathlib import Path

import numpy as np

from g1_componentwise_ch_test import packet, quantize


def run(n: int, ell: float, kappa: float, samples: int, pairs: int, seed: int) -> dict:
    rng = np.random.default_rng(seed + n + round(1000 * kappa))
    box = 0.5
    xq = quantize(rng.uniform(-box, box, size=(samples, 3)), n, box)
    wq, jq = packet(xq, ell)
    magq = np.linalg.norm(wq, axis=1)
    l2 = math.sqrt(float(np.mean(magq**2)))
    grad_l2 = math.sqrt(float(np.mean(np.sum(jq * jq, axis=(1, 2)))))
    rho = kappa * l2 / grad_l2
    threshold = 0.25 * float(np.max(magq))
    active = xq[magq >= threshold]

    ch_parts, weight_parts = [], []
    need, attempts = pairs, 0
    while need > 0 and attempts < 40:
        m = min(max(5 * need, 5000), 300000)
        x = active[rng.integers(0, len(active), size=m)]
        direction = rng.normal(size=(m, 3))
        direction /= np.linalg.norm(direction, axis=1)[:, None]
        radius = rho * rng.random(m) ** (1 / 3)
        y = quantize(x + radius[:, None] * direction, n, box)
        wx, _ = packet(x, ell)
        wy, _ = packet(y, ell)
        mx, my = np.linalg.norm(wx, axis=1), np.linalg.norm(wy, axis=1)
        r = np.linalg.norm(y - x, axis=1)
        good = (mx >= threshold) & (my >= threshold) & (r > 0) & (r < rho)
        if np.any(good):
            s = np.linalg.norm(np.cross(wx[good], wy[good]), axis=1) / (mx[good] * my[good])
            c = s / np.sqrt(r[good] / rho)
            # Proxy for |omega(x)|^2 |omega(y)| sin(theta) / |x-y|^3.
            weight = mx[good] ** 2 * my[good] * s / r[good] ** 3
            take = min(need, len(c))
            ch_parts.append(c[:take])
            weight_parts.append(weight[:take])
            need -= take
        attempts += 1
    ch = np.concatenate(ch_parts)
    weight = np.concatenate(weight_parts)
    q95 = float(np.quantile(ch, 0.95))
    exceptional = ch > q95
    tail_share = float(np.sum(weight[exceptional]) / np.sum(weight))
    return {
        "N": n, "ell": ell, "kappa": kappa, "rho": rho,
        "accepted_pairs": int(len(ch)), "ch95": q95,
        "ch95_over_sqrt_kappa": q95 / math.sqrt(kappa),
        "exceptional_pair_fraction": float(np.mean(exceptional)),
        "exceptional_kernel_proxy_share": tail_share,
        "classification": "empirical_proxy_not_analytic_bound",
    }


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--out", default="results")
    ap.add_argument("--samples", type=int, default=200_000)
    ap.add_argument("--pairs", type=int, default=100_000)
    args = ap.parse_args()
    rows = [run(256, 1 / 16, k, args.samples, args.pairs, 2609)
            for k in (0.25, 0.5, 1.0, 2.0, 4.0, 8.0)]
    out = Path(args.out)
    out.mkdir(parents=True, exist_ok=True)
    with (out / "g1_joint_tail_diagnostic.csv").open("w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=rows[0].keys())
        w.writeheader(); w.writerows(rows)
    payload = {
        "warning": "synthetic sampled proxy; not a Navier-Stokes theorem",
        "rows": rows,
    }
    (out / "g1_joint_tail_diagnostic.json").write_text(json.dumps(payload, indent=2) + "\n")
    print(json.dumps(payload, indent=2))


if __name__ == "__main__":
    main()
