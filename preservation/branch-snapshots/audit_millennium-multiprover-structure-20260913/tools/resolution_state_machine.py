"""Audit-safe state/transition simulator.

This module tests logical properties of a proposed solver architecture.  It
cannot prove a Millennium problem from numerical experiments.
"""
from __future__ import annotations

from dataclasses import dataclass
from enum import Enum, auto
from math import isfinite
from typing import Callable, Iterable


class Stage(Enum):
    OBSERVED = auto()
    TYPED = auto()
    PROJECTED = auto()
    RESIDUALIZED = auto()
    CORRECTED = auto()
    CONTRACTIVE = auto()
    CRITICAL_CONTROLLED = auto()
    ENDPOINT_CERTIFIED = auto()
    FORMAL_PROOF_CHECKED = auto()
    DEGENERATE = auto()
    INCONSISTENT_SPECIFICATION = auto()
    OPEN_BRIDGE = auto()
    FALSIFIED = auto()


@dataclass(frozen=True)
class State:
    value: tuple[float, ...]
    defect: float
    native_control: float
    admissible: bool = True
    stage: Stage = Stage.RESIDUALIZED


@dataclass(frozen=True)
class Certificate:
    invariant_preserved: bool
    contracted: bool
    coercive_bound_holds: bool
    finite: bool


def geometric_bound(d0: float, q: float, n: int) -> float:
    if d0 < 0 or not 0 <= q < 1 or n < 0:
        raise ValueError("require d0>=0, 0<=q<1, n>=0")
    return (q ** n) * d0


def coercive_upper(defect: float, alpha: float, beta: float) -> float:
    if defect < 0 or alpha < 0:
        raise ValueError("defect and alpha must be nonnegative")
    return alpha * defect + beta


def iterate(
    initial: State,
    step: Callable[[State], State],
    n: int,
    q: float,
    alpha: float,
    beta: float,
    tol: float = 1e-12,
) -> tuple[list[State], list[Certificate]]:
    if not 0 <= q < 1:
        raise ValueError("q must lie in [0,1)")
    states = [initial]
    certs: list[Certificate] = []
    for _ in range(n):
        before = states[-1]
        after = step(before)
        finite = all(isfinite(v) for v in (*after.value, after.defect, after.native_control))
        certs.append(
            Certificate(
                invariant_preserved=(not before.admissible) or after.admissible,
                contracted=after.defect <= q * before.defect + tol,
                coercive_bound_holds=after.native_control <= coercive_upper(after.defect, alpha, beta) + tol,
                finite=finite,
            )
        )
        states.append(after)
    return states, certs


def all_certified(certs: Iterable[Certificate]) -> bool:
    return all(
        c.invariant_preserved and c.contracted and c.coercive_bound_holds and c.finite
        for c in certs
    )


def adversarial_decaying_defect_diverging_native(n: int) -> State:
    """Counterexample pattern to the invalid inference 'defect -> 0 implies native control bounded'."""
    return State(value=(float(n),), defect=1.0 / (n + 1), native_control=float(n + 1))


def epsilon_ns(nonlinear_l2: float, nu: float, laplacian_l2: float) -> float | None:
    """Repository-style epsilon diagnostic with an explicit degenerate branch."""
    denominator = nu * laplacian_l2
    if denominator == 0:
        return None
    return nonlinear_l2 / denominator


def bridge_distance(open_edges: Iterable[bool]) -> int:
    """Number of unresolved semantic edges. True means discharged."""
    return sum(1 for discharged in open_edges if not discharged)
