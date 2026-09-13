"""Minimal verifier wrapper for current audit helper scripts."""

from exponent_scan import scan


def run():
    alphas = [x / 10 for x in range(1, 21)]
    betas = [x / 10 for x in range(1, 21)]
    pairs = scan(alphas, betas)
    return {"admissible_count": len(pairs)}


if __name__ == "__main__":
    print(run())
