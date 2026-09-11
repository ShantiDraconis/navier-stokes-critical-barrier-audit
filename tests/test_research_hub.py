import math
import unittest

from research_hub.calculator import (
    weighted_percentages, sensitivity_percentages, error_norm, progress,
    ns_ratio, ns_scaled_l2_terms, classify_threshold,
)


class ResearchHubTests(unittest.TestCase):
    def test_weighted_normalization(self):
        r = weighted_percentages([45, 30, 15, 10])
        self.assertAlmostEqual(sum(r.value), 100.0)
        self.assertEqual(r.status, "MODEL_DERIVED")

    def test_sensitivity_normalization(self):
        r = sensitivity_percentages([2, 1, 3], [0.5, 1, 0.25])
        self.assertAlmostEqual(sum(r.value), 100.0)

    def test_zero_error_norm(self):
        self.assertEqual(error_norm([0, 0, 0]).value, 0.0)
        self.assertGreater(error_norm([0, 0.1, 0]).value, 0.0)

    def test_progress(self):
        r = progress([3, 4], [0, 2.5])
        self.assertAlmostEqual(r.value, 50.0)

    def test_ns_ratio_scaling_invariant(self):
        N, L, nu = 7.0, 5.0, 0.25
        base = ns_ratio(N, L, nu).value
        for lam in (0.1, 0.5, 2.0, 10.0):
            Ns, Ls = ns_scaled_l2_terms(N, L, lam).value
            self.assertAlmostEqual(ns_ratio(Ns, Ls, nu).value, base)

    def test_ns_zero_denominator_rejected(self):
        with self.assertRaises(ZeroDivisionError):
            ns_ratio(1.0, 0.0, 1.0)

    def test_threshold_never_claims_theorem(self):
        r = classify_threshold(0.4)
        self.assertEqual(r.value, "below_or_equal")
        self.assertEqual(r.status, "MODEL_CLASSIFICATION_ONLY")

    def test_counterexample_monotone_not_zero(self):
        seq = [1.0 + 1.0/(n+1) for n in range(1, 100)]
        self.assertTrue(all(seq[i+1] < seq[i] for i in range(len(seq)-1)))
        self.assertGreater(seq[-1], 1.0)

    def test_counterexample_zero_mean_not_small(self):
        xs = [math.sin(2*math.pi*k/1000) for k in range(1000)]
        self.assertAlmostEqual(sum(xs)/len(xs), 0.0, places=12)
        self.assertGreater(max(abs(x) for x in xs), 0.99)


if __name__ == "__main__":
    unittest.main()
