"""Minimal pressure compatibility checks for audit bookkeeping."""

def pressure_poisson_rhs_terms(include_forcing_divergence=True):
    terms = ["d_i d_j (u_i u_j)"]
    if include_forcing_divergence:
        terms.append("- div(f)")
    return terms


if __name__ == "__main__":
    print({"rhs": pressure_poisson_rhs_terms()})
