import math


def weighted_percentages(weights, values):
    e = sum(w * v for w, v in zip(weights, values))
    assert e > 0
    return [100.0 * w * v / e for w, v in zip(weights, values)]


def test_weighted_percentages_sum_to_100():
    c = weighted_percentages([0.2, 0.3, 0.5], [1.0, 2.0, 4.0])
    assert math.isclose(sum(c), 100.0, rel_tol=0, abs_tol=1e-12)


def test_l2_zero_iff_coordinates_zero():
    v = [0.0, 0.0, 0.0]
    assert math.sqrt(sum(x*x for x in v)) == 0.0
    w = [0.0, 1e-9, 0.0]
    assert math.sqrt(sum(x*x for x in w)) > 0.0


def test_uniform_contraction_geometric_bound():
    q = 0.7
    e = 5.0
    for n in range(1, 20):
        e *= q
        assert e <= (q**n) * 5.0 + 1e-15


def test_monotone_reduction_not_zero_counterexample():
    vals = [1.0 + 1.0/(n+1) for n in range(1, 10000)]
    assert all(vals[i+1] < vals[i] for i in range(len(vals)-1))
    assert vals[-1] > 1.0


def test_seet_residual_factorization():
    gamma, d, u = 1429.0473, 0.025, 15.0
    r = math.exp(0.5*u) * math.sin(gamma*u)
    s = math.exp((0.5+d)*u) * math.sin(gamma*u)
    direct = s-r
    factored = math.exp(0.5*u)*(math.exp(d*u)-1.0)*math.sin(gamma*u)
    assert math.isclose(direct, factored, rel_tol=1e-12, abs_tol=1e-12)
    assert math.isclose(direct, -479.874180460152, rel_tol=1e-10, abs_tol=1e-8)


def test_seet_envelope_ratio():
    gamma, d, u = 1429.0473, 0.025, 15.0
    phase = math.sin(gamma*u)
    assert abs(phase) > 1e-12
    r = math.exp(0.5*u)*phase
    s = math.exp((0.5+d)*u)*phase
    assert math.isclose(s/r, math.exp(d*u), rel_tol=1e-12)


def stiffness_ratio(gamma, d=0.025):
    return (gamma/(2*math.pi))**(2*d)


def test_stiffness_ratio_increases_with_gamma():
    assert stiffness_ratio(10000.0) > stiffness_ratio(1429.0473)


def test_left_right_weights_normalize():
    k = stiffness_ratio(1429.0473)
    assert math.isclose(k/(1+k) + 1/(1+k), 1.0, abs_tol=1e-15)


def delta_k(d=0.025, u_max=15.0):
    return math.exp(d*u_max)-math.exp(-d*u_max)


def test_delta_k_is_gamma_independent_by_definition():
    assert math.isclose(delta_k(), 0.767702135827229, rel_tol=1e-12)


def quartet(d=0.025, gamma=1429.0473):
    return {0.5+d+1j*gamma, 0.5+d-1j*gamma, 0.5-d+1j*gamma, 0.5-d-1j*gamma}


def test_quartet_closed_under_conjugation():
    q = quartet()
    for z in list(q):
        assert z.conjugate() in q


def test_quartet_closed_under_critical_line_reflection():
    q = quartet()
    for z in list(q):
        assert 1-z.conjugate() in q


def test_ns_scaling_exponents_cancel():
    lam = 3.7
    assert math.isclose(lam**1.5/lam**1.5, 1.0, abs_tol=1e-15)


def test_zero_period_mean_not_pointwise_smallness():
    n = 200000
    dt = 2*math.pi/n
    integral = sum(math.sin((i+0.5)*dt)*dt for i in range(n))
    assert abs(integral) < 1e-10
    assert math.isclose(max(abs(math.sin(i*dt)) for i in range(n)), 1.0, rel_tol=1e-9)


def test_reparameterization_changes_percentages():
    base = weighted_percentages([0.5,0.5],[1.0,2.0])
    transformed = weighted_percentages([0.5,0.5],[1.0,4.0])
    assert base != transformed
    assert math.isclose(base[0], 100/3, rel_tol=1e-12)
    assert math.isclose(transformed[0], 20.0, rel_tol=1e-12)
