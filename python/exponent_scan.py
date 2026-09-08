"""Scan alpha-beta concentration constraints."""

from concentration_window import in_window


def scan(alpha_min=0.1, alpha_max=3.0, step=0.1):
    alphas = []
    x = alpha_min
    while x <= alpha_max + 1e-12:
        alphas.append(round(x, 10))
        x += step

    out = []
    for alpha in alphas:
        for beta in alphas:
            if in_window(alpha, beta):
                out.append({"alpha": alpha, "beta": beta})
    return out


if __name__ == "__main__":
    pairs = scan()
    print({"admissible_pairs": len(pairs), "sample": pairs[:5]})
