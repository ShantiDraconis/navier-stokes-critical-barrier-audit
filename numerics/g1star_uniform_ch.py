#!/usr/bin/env python3
"""G1* falsification-oriented diagnostic.

Measures real vector-vorticity angular coherence from a supplied NumPy array.
It does NOT simulate Navier–Stokes and does NOT prove G1*.

Input .npy shape: (N,N,N,3), containing vorticity vectors on a periodic cube.
For each threshold c and dyadic distance bin it estimates q50/q90/q95 of
sin(theta), beta_q from log-log regression, and
    C_H^q = sup_r q(r)/sqrt(r/rho)
where rho = kappa ||omega||_2 / ||grad omega||_2.

A resolution study should compare C_H across N. Stabilization is numerical
support only; systematic growth is evidence against the tested uniform form.
"""
from __future__ import annotations
import argparse, csv, json
from pathlib import Path
import numpy as np


def norms(w):
    return np.linalg.norm(w, axis=-1)


def sin_angle(a, b, eps=1e-30):
    return np.linalg.norm(np.cross(a, b), axis=-1) / (
        np.linalg.norm(a, axis=-1) * np.linalg.norm(b, axis=-1) + eps
    )


def periodic_delta(i, j, N):
    d = np.abs(i-j)
    return np.minimum(d, N-d)


def rho_star(w, box_length, kappa):
    N = w.shape[0]
    dx = box_length/N
    w_l2 = np.sqrt(np.sum(w*w) * dx**3)
    grad_sq = 0.0
    for axis in range(3):
        dw = (np.roll(w, -1, axis=axis)-np.roll(w, 1, axis=axis))/(2*dx)
        grad_sq += np.sum(dw*dw)*dx**3
    grad_l2 = np.sqrt(grad_sq)
    return kappa*w_l2/grad_l2 if grad_l2 > 0 else np.inf, w_l2, grad_l2


def sample_pairs(w, c, rho, box_length, samples, bins, rng):
    N = w.shape[0]
    mag = norms(w)
    M = float(mag.max())
    active = np.argwhere(mag >= c*M)
    if len(active) < 2:
        return []
    ia = rng.integers(0, len(active), size=samples)
    ib = rng.integers(0, len(active), size=samples)
    aidx, bidx = active[ia], active[ib]
    dgrid = np.sqrt(sum(periodic_delta(aidx[:,k], bidx[:,k], N)**2 for k in range(3)))
    r = dgrid * box_length/N
    good = (r > 0) & np.isfinite(r) & (r < rho)
    aidx, bidx, r = aidx[good], bidx[good], r[good]
    if len(r) == 0:
        return []
    sa = w[tuple(aidx.T)]
    sb = w[tuple(bidx.T)]
    s = np.clip(sin_angle(sa, sb), 0.0, 1.0)
    rmin = max(box_length/N, float(r.min()))
    rmax = min(rho, float(r.max())*(1+1e-12))
    if rmax <= rmin:
        return []
    edges = np.geomspace(rmin, rmax, bins+1)
    rows=[]
    for lo,hi in zip(edges[:-1],edges[1:]):
        q=(r>=lo)&(r<hi)
        if q.sum()<20: continue
        rc=float(np.sqrt(lo*hi))
        vals=s[q]
        rows.append(dict(r=rc,n=int(q.sum()),q50=float(np.quantile(vals,.50)),
                         q90=float(np.quantile(vals,.90)),q95=float(np.quantile(vals,.95))))
    return rows


def slope(rows, key):
    rr=np.array([x['r'] for x in rows]); aa=np.array([x[key] for x in rows])
    good=(rr>0)&(aa>0)
    if good.sum()<3: return float('nan')
    return float(np.polyfit(np.log(rr[good]),np.log(aa[good]),1)[0])


def main():
    p=argparse.ArgumentParser()
    p.add_argument('field', type=Path)
    p.add_argument('--box-length',type=float,default=2*np.pi)
    p.add_argument('--kappa',type=float,default=1.0)
    p.add_argument('--thresholds',type=float,nargs='+',default=[.1,.25,.5,.75,.9])
    p.add_argument('--samples',type=int,default=1_000_000)
    p.add_argument('--bins',type=int,default=12)
    p.add_argument('--seed',type=int,default=0)
    p.add_argument('--out',type=Path,default=Path('g1star_results.csv'))
    args=p.parse_args()
    w=np.load(args.field)
    if w.ndim!=4 or w.shape[-1]!=3 or len(set(w.shape[:3]))!=1:
        raise ValueError('expected cubic array (N,N,N,3)')
    N=w.shape[0]; rng=np.random.default_rng(args.seed)
    rho,l2,gl2=rho_star(w,args.box_length,args.kappa)
    summary=[]
    with args.out.open('w',newline='') as f:
        writer=csv.DictWriter(f,fieldnames=['N','c','rho_star','r','n','q50','q90','q95','Qhalf50','Qhalf90','Qhalf95'])
        writer.writeheader()
        for c in args.thresholds:
            rows=sample_pairs(w,c,rho,args.box_length,args.samples,args.bins,rng)
            for row in rows:
                scale=np.sqrt(row['r']/rho) if np.isfinite(rho) and rho>0 else np.nan
                writer.writerow(dict(N=N,c=c,rho_star=rho,**row,
                    Qhalf50=row['q50']/scale,Qhalf90=row['q90']/scale,Qhalf95=row['q95']/scale))
            summary.append(dict(N=N,c=c,rho_star=rho,beta50=slope(rows,'q50'),
                beta90=slope(rows,'q90'),beta95=slope(rows,'q95'),
                CH95=max((x['q95']/np.sqrt(x['r']/rho) for x in rows),default=float('nan'))))
    print(json.dumps({'N':N,'omega_L2':l2,'gradOmega_L2':gl2,'rho_star':rho,'summary':summary},indent=2))
    print(f'wrote {args.out}')

if __name__=='__main__':
    main()
