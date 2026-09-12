#!/usr/bin/env python3
"""Executable audit engine for numeric classes and parameter gaps.

This computes model-dependent diagnostics only. It never upgrades an OPEN_BRIDGE
or unresolved Millennium statement to a proof.
"""
from __future__ import annotations
from dataclasses import dataclass
from enum import Enum
from typing import Iterable

class Status(str, Enum):
    PROVED = "PROVED"
    CONDITIONAL = "CONDITIONAL"
    EXTERNAL_THEOREM = "EXTERNAL_THEOREM"
    OPEN_BRIDGE = "OPEN_BRIDGE"
    INCONSISTENT_SPECIFICATION = "INCONSISTENT_SPECIFICATION"

@dataclass(frozen=True)
class WeightedGap:
    sensitivity: float
    gap: float
    def __post_init__(self):
        if self.sensitivity < 0 or self.gap < 0:
            raise ValueError("sensitivity and gap must be nonnegative")
    @property
    def weight(self) -> float:
        return self.sensitivity * self.gap

@dataclass(frozen=True)
class SharedDistinct:
    shared: int
    left_only: int
    right_only: int
    def __post_init__(self):
        if min(self.shared, self.left_only, self.right_only) < 0:
            raise ValueError("feature counts must be nonnegative")
    @property
    def total(self) -> int:
        return self.shared + self.left_only + self.right_only
    def similarity(self) -> float | None:
        return None if self.total == 0 else self.shared / self.total
    def distinctness(self) -> float | None:
        return None if self.total == 0 else (self.left_only + self.right_only) / self.total

def percentages(gaps: Iterable[WeightedGap]) -> tuple[float, ...] | None:
    gs = tuple(gaps)
    total = sum(g.weight for g in gs)
    if total <= 0:
        return None
    return tuple(100.0 * g.weight / total for g in gs)

def can_upgrade_to_proof(status: Status) -> bool:
    return status is Status.PROVED

def tolerance_close(x: float, y: float, epsilon: float) -> bool:
    if epsilon <= 0:
        raise ValueError("epsilon must be positive")
    return abs(x-y) < epsilon

def graded_triangle(x: float, y: float, z: float, eps: float, delta: float) -> bool:
    if not tolerance_close(x,y,eps) or not tolerance_close(y,z,delta):
        return True
    return abs(x-z) < eps + delta

NUMERIC_CLASSES = (
    "IndependenceNumber", "MultiModelNumber", "EquivalenceBreakNumber",
    "ObstructionNumber", "RegularityNumber", "CriticalZeroNumber",
    "MassGapNumber", "RankNumber", "HodgeNumber", "ComplexityNumber",
    "ForcingNumber", "WoodinNumber", "TruthValueNumber", "DualityNumber",
)
