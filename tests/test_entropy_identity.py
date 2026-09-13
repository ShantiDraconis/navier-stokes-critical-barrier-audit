import math
import unittest


class EntropyIdentityTests(unittest.TestCase):
    @staticmethod
    def q(t: float, A: float, nu: float) -> float:
        return A * A * math.exp(-2.0 * nu * t)

    @classmethod
    def derivative_factor(cls, t: float, A: float, nu: float) -> float:
        q = cls.q(t, A, nu)
        return q * (q - 2.0 * nu)

    def test_user_parameters_negative(self):
        self.assertLess(self.derivative_factor(0.0, 0.1, 0.01), 0.0)

    def test_threshold_zero(self):
        A = math.sqrt(0.02)
        self.assertAlmostEqual(self.derivative_factor(0.0, A, 0.01), 0.0, places=12)

    def test_supercritical_positive(self):
        self.assertGreater(self.derivative_factor(0.0, 0.2, 0.01), 0.0)

    def test_q_ode(self):
        A, nu, t = 0.1, 0.01, 0.7
        q = self.q(t, A, nu)
        exact = -2.0 * nu * q
        h = 1.0e-6
        fd = (self.q(t + h, A, nu) - self.q(t - h, A, nu)) / (2.0 * h)
        self.assertAlmostEqual(fd, exact, places=8)


if __name__ == "__main__":
    unittest.main()
