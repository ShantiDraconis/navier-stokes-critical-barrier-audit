"""Executable tests for algebraic invariants used by the audit.

These tests validate the audit's scalarization/progress/phase identities only.
They do not constitute a proof of the Navier–Stokes Millennium problem.
"""

import cmath
import math
import unittest


def weighted_contributions(weights, transformed_gaps):
    terms = [w * g for w, g in zip(weights, transformed_gaps)]
    total = sum(terms)
    if total <= 0:
        raise ValueError("positive total required")
    return [100.0 * x / total for x in terms]


def sensitivity_contributions(sensitivities, gaps):
    terms = [abs(s) * abs(d) for s, d in zip(sensitivities, gaps)]
    total = sum(terms)
    if total <= 0:
        raise ValueError("positive denominator required")
    return [100.0 * x / total for x in terms]


def progress(initial_norm, current_norm):
    if initial_norm <= 0:
        raise ValueError("initial norm must be positive")
    return 100.0 * (1.0 - current_norm / initial_norm)


def periodic_mode_average(amplitude, omega, periods):
    if omega == 0:
        raise ValueError("omega must be non-zero")
    if periods <= 0 or int(periods) != periods:
        raise ValueError("periods must be a positive integer")
    T = periods * 2.0 * math.pi / abs(omega)
    return amplitude * (cmath.exp(1j * omega * T) - 1.0) / (1j * omega * T)


class AuditInvariantTests(unittest.TestCase):
    def test_weighted_contributions_sum_to_100(self):
        c = weighted_contributions([0.45, 0.30, 0.15, 0.10], [0.2, 0.3, 0.4, 0.5])
        self.assertAlmostEqual(sum(c), 100.0, places=12)

    def test_sensitivity_contributions_sum_to_100(self):
        c = sensitivity_contributions([2.0, -3.0, 5.0], [0.1, 0.2, 0.4])
        self.assertAlmostEqual(sum(c), 100.0, places=12)

    def test_progress_monotone_when_norm_contracts(self):
        initial = 10.0
        norms = [10.0, 8.0, 4.0, 1.0, 0.0]
        p = [progress(initial, n) for n in norms]
        self.assertTrue(all(a <= b for a, b in zip(p, p[1:])))
        self.assertAlmostEqual(p[-1], 100.0)

    def test_zero_euclidean_norm_iff_all_coordinates_zero(self):
        zero = [0.0, 0.0, 0.0]
        nonzero = [0.0, 1e-12, 0.0]
        self.assertEqual(math.sqrt(sum(x*x for x in zero)), 0.0)
        self.assertGreater(math.sqrt(sum(x*x for x in nonzero)), 0.0)

    def test_periodic_nonzero_mode_has_zero_whole_period_average(self):
        avg = periodic_mode_average(3.0 + 2.0j, 7.0, 11)
        self.assertLess(abs(avg), 1e-12)

    def test_weighted_zero_total_is_rejected(self):
        with self.assertRaises(ValueError):
            weighted_contributions([0.5, 0.5], [0.0, 0.0])

    def test_sensitivity_zero_denominator_is_rejected(self):
        with self.assertRaises(ValueError):
            sensitivity_contributions([0.0, 0.0], [1.0, 2.0])


if __name__ == "__main__":
    unittest.main()
