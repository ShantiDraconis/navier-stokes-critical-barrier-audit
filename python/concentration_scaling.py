"""Concentration scaling helper for (alpha, beta) constraints."""

def admissible_window(alpha: float, beta: float) -> bool:
    return (2.0 / 3.0) * alpha <= beta < alpha


if __name__ == "__main__":
    examples = [(1.0, 0.8), (1.0, 0.6), (1.2, 1.25)]
    for alpha, beta in examples:
        print(f"alpha={alpha:.3f}, beta={beta:.3f}, admissible={admissible_window(alpha, beta)}")
