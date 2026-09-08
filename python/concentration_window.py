"""Concentration window utilities."""

def in_window(alpha: float, beta: float) -> bool:
    return (2.0 / 3.0) * alpha <= beta < alpha


def classify(alpha: float, beta: float) -> str:
    if in_window(alpha, beta):
        return "ADMISSIBLE"
    return "OUTSIDE"
