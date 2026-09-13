import unittest
from tools.numeric_class_os import (
    Status, WeightedGap, SharedDistinct, percentages,
    can_upgrade_to_proof, tolerance_close, graded_triangle, NUMERIC_CLASSES,
)

class NumericClassOSTests(unittest.TestCase):
    def test_fourteen_classes(self):
        self.assertEqual(len(NUMERIC_CLASSES), 14)
        self.assertEqual(len(set(NUMERIC_CLASSES)), 14)

    def test_percentages_sum_to_100(self):
        p = percentages([
            WeightedGap(0.8, 0.4),
            WeightedGap(2.0, 1.0),
            WeightedGap(0.6, 0.3),
        ])
        self.assertIsNotNone(p)
        self.assertAlmostEqual(sum(p), 100.0)

    def test_zero_weight_vector_is_undefined(self):
        self.assertIsNone(percentages([WeightedGap(0, 1), WeightedGap(1, 0)]))

    def test_similarity_plus_distinctness(self):
        s = SharedDistinct(7, 2, 1)
        self.assertAlmostEqual(s.similarity() + s.distinctness(), 1.0)

    def test_empty_comparison_is_undefined(self):
        s = SharedDistinct(0, 0, 0)
        self.assertIsNone(s.similarity())
        self.assertIsNone(s.distinctness())

    def test_fixed_epsilon_is_not_transitive(self):
        self.assertTrue(tolerance_close(0, 0.75, 1))
        self.assertTrue(tolerance_close(0.75, 1.5, 1))
        self.assertFalse(tolerance_close(0, 1.5, 1))

    def test_graded_triangle(self):
        self.assertTrue(graded_triangle(0, 0.75, 1.5, 1, 1))

    def test_status_cannot_be_upgraded(self):
        for s in Status:
            self.assertEqual(can_upgrade_to_proof(s), s is Status.PROVED)

if __name__ == "__main__":
    unittest.main()
