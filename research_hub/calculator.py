"""Research Hub calculator.

Every numerical result carries an epistemic status.  The module intentionally
refuses to convert model outputs into theorem claims.
"""
from __future__ import annotations

from dataclasses import dataclass
from math import sqrt
from typing import Iterable, Sequence


@dataclass(frozen=True)
class Result:
    value: object
    status: str
    statement: str


def weighted_percentages(terms: Sequence[float]) -> Result:
    if any(x < 0 for x in terms):
        raise ValueError("weighted terms must be non-negative")
    total = sum(terms)
    if total <= 0:
        raise ValueError("positive total required")
    values = tuple(100.0 * x / total for x in terms)
    return Result(values, "MODEL_DERIVED", "Normalized structural contributions; not probabilities of theorem correctness.")


def sensitivity_percentages(sensitivities: Sequence[float], gaps: Sequence[float]) -> Result:
    if len(sensitivities) != len(gaps):
        raise ValueError("dimension mismatch")
    if any(s < 0 for s in sensitivities) or any(g < 0 for g in gaps):
        raise ValueError("non-negative sensitivities and gaps required")
    terms = [s * g for s, g in zip(sensitivities, gaps)]
    result = weighted_percentages(terms)
    return Result(result.value, "MODEL_DERIVED", "Local sensitivity × gap decomposition; distinct from fixed structural weights.")


def error_norm(error: Iterable[float]) -> Result:
    xs = tuple(float(x) for x in error)
    if any(x < 0 for x in xs):
        raise ValueError("error coordinates must be non-negative")
    return Result(sqrt(sum(x*x for x in xs)), "MATHEMATICAL_DEFINITION", "Euclidean magnitude of the declared error vector.")


def progress(initial: Iterable[float], current: Iterable[float]) -> Result:
    a = error_norm(initial).value
    b = error_norm(current).value
    if a <= 0:
        raise ValueError("nonzero initial norm required")
    return Result(100.0 * (1.0 - b/a), "MODEL_DERIVED", "Norm-reduction progress inside the declared coordinate model.")


def ns_ratio(nonlinear_l2: float, laplacian_l2: float, viscosity: float) -> Result:
    if nonlinear_l2 < 0 or laplacian_l2 < 0:
        raise ValueError("norms must be non-negative")
    if viscosity <= 0:
        raise ValueError("viscosity must be positive")
    if laplacian_l2 == 0:
        raise ZeroDivisionError("NS diagnostic undefined when ||Δu||_2 = 0 unless a separate branch is specified")
    value = nonlinear_l2 / (viscosity * laplacian_l2)
    return Result(value, "DIAGNOSTIC_NOT_REGULARITY_THEOREM", "Scale-invariant R^3 diagnostic under classical NS scaling; no universal threshold is certified here.")


def ns_scaled_l2_terms(nonlinear_l2: float, laplacian_l2: float, scale: float) -> Result:
    """Classical R^3 NS scaling: both L2 terms acquire lambda^(3/2)."""
    if scale <= 0:
        raise ValueError("positive scale required")
    factor = scale ** 1.5
    return Result((factor * nonlinear_l2, factor * laplacian_l2), "MATHEMATICAL_DERIVATION", "R^3 scaling factors for nonlinear and Laplacian L2 terms.")


def classify_threshold(value: float, threshold: float = 0.65) -> Result:
    relation = "below_or_equal" if value <= threshold else "above"
    return Result(relation, "MODEL_CLASSIFICATION_ONLY", "Threshold classification is not a proof of regularity or blow-up.")
