"""Scan (alpha, beta) for baseline energy/L3 window constraints."""

from concentration_scaling import admissible_window


def scan(alpha_values, beta_values):
    out = []
    for alpha in alpha_values:
        for beta in beta_values:
            if admissible_window(alpha, beta):
                out.append((alpha, beta))
    return out


if __name__ == "__main__":
    alphas = [x / 10 for x in range(1, 31)]
    betas = [x / 10 for x in range(1, 31)]
    pairs = scan(alphas, betas)
    print(f"admissible_pairs={len(pairs)}")
