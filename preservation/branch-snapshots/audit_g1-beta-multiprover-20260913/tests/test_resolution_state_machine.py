import unittest

from tools.resolution_state_machine import (
    Certificate,
    Stage,
    State,
    adversarial_decaying_defect_diverging_native,
    all_certified,
    bridge_distance,
    coercive_upper,
    epsilon_ns,
    geometric_bound,
    iterate,
)


class ResolutionStateMachineTests(unittest.TestCase):
    def test_geometric_bound(self):
        self.assertAlmostEqual(geometric_bound(8.0, 0.5, 3), 1.0)

    def test_invalid_q_rejected(self):
        with self.assertRaises(ValueError):
            geometric_bound(1.0, 1.0, 2)

    def test_coercive_upper(self):
        self.assertEqual(coercive_upper(2.0, 3.0, 5.0), 11.0)

    def test_closed_contracting_loop(self):
        def step(s: State) -> State:
            d = 0.5 * s.defect
            return State((0.5 * s.value[0],), d, 2.0 * d + 1.0, True, Stage.CONTRACTIVE)

        states, certs = iterate(State((8.0,), 8.0, 17.0), step, 4, 0.5, 2.0, 1.0)
        self.assertTrue(all_certified(certs))
        self.assertAlmostEqual(states[-1].defect, 0.5)

    def test_adversarial_defect_decay_does_not_control_native_quantity(self):
        states = [adversarial_decaying_defect_diverging_native(n) for n in range(100)]
        self.assertLess(states[-1].defect, states[0].defect)
        self.assertGreater(states[-1].native_control, states[0].native_control)
        # This is the exact reason a coercive bridge such as NS-B2 is required.
        self.assertFalse(states[-1].native_control <= 10.0 * states[-1].defect + 1.0)

    def test_epsilon_ns_degenerate_branch_is_explicit(self):
        self.assertIsNone(epsilon_ns(1.0, 1.0, 0.0))
        self.assertEqual(epsilon_ns(2.0, 0.5, 4.0), 1.0)

    def test_open_bridge_count(self):
        self.assertEqual(bridge_distance([True, False, False, True]), 2)

    def test_certificate_requires_every_gate(self):
        certs = [Certificate(True, True, False, True)]
        self.assertFalse(all_certified(certs))


if __name__ == "__main__":
    unittest.main()
