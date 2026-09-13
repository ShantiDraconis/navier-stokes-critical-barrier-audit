"""Forcing scaling exponents from ansatz parameters."""

def forcing_exponents(alpha: float, beta: float):
    return {
        "dt_u": -(alpha + 1.0),
        "advection": -(2.0 * alpha + beta),
        "viscous": -(alpha + 2.0 * beta),
    }


def dominant_term(alpha: float, beta: float):
    exps = forcing_exponents(alpha, beta)
    return min(exps, key=exps.get)


if __name__ == "__main__":
    print(forcing_exponents(1.0, 0.8))
    print({"dominant": dominant_term(1.0, 0.8)})
