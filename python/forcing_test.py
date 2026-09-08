"""Term-exponent tracker for forcing smoothness audits."""

def forcing_exponents(alpha: float, beta: float):
    return {
        "dt_u": -(alpha + 1.0),
        "advective": -(2.0 * alpha + beta),
        "viscous": -(alpha + 2.0 * beta),
    }


if __name__ == "__main__":
    ex = forcing_exponents(1.0, 0.8)
    for k, v in ex.items():
        print(k, v)
