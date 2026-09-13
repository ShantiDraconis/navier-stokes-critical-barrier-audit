import importlib.util
import pathlib
import sys
import unittest

ROOT = pathlib.Path(__file__).resolve().parents[1]


def load(name, path):
    """Load a repository tool exactly as a normal import would.

    Python 3.12's dataclasses implementation expects the module being executed
    to already be present in sys.modules.  Register it before exec_module so
    decorated classes can resolve their module namespace deterministically.
    """
    spec = importlib.util.spec_from_file_location(name, ROOT / path)
    if spec is None or spec.loader is None:
        raise ImportError(f"cannot create import spec for {path}")
    mod = importlib.util.module_from_spec(spec)
    sys.modules[name] = mod
    try:
        spec.loader.exec_module(mod)
    except Exception:
        sys.modules.pop(name, None)
        raise
    return mod


class GapPipelineTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.scan = load('scan_sorry_certificates', 'tools/scan_sorry_certificates.py')
        cls.route = load('classify_gap_obligations', 'tools/classify_gap_obligations.py')

    def test_declaration_local_gap_not_file_global(self):
        text = '''theorem clean : True := by trivial\n\ntheorem gap : True := by\n  sorry\n'''
        ds = self.scan.declaration_blocks(text, 'lean')
        self.assertEqual(len(ds), 2)
        self.assertFalse(self.scan.has_gap(ds[0]))
        self.assertTrue(self.scan.has_gap(ds[1]))

    def test_false_or_open_claim_not_auto_proved(self):
        d = {
            'kind': 'theorem',
            'block': 'theorem x : True := by sorry -- open problem',
            'markers': {
                'sorry': 1,
                'admit': 0,
                'admitted': 0,
                'postulate': 0,
                'axiom': 0,
                'true_placeholder': 0,
            },
        }
        self.assertEqual(self.scan.classify(d), 'OPEN_BRIDGE_CANDIDATE')
        action, _ = self.route.route('OPEN_BRIDGE_CANDIDATE')
        self.assertEqual(action, 'EXPLICIT_TYPED_HYPOTHESIS')

    def test_proof_debt_routes_to_direct_proof(self):
        action, _ = self.route.route('PROOF_DEBT_CANDIDATE')
        self.assertEqual(action, 'DIRECT_PROOF')

    def test_specification_gap_routes_to_correction(self):
        action, _ = self.route.route('SPECIFICATION_GAP_CANDIDATE')
        self.assertEqual(action, 'SPECIFICATION_CORRECTION')

    def test_source_clean_still_requires_build(self):
        action, _ = self.route.route('SOURCE_CLEAN_REQUIRES_BUILD')
        self.assertEqual(action, 'BUILD_EXACT_OBJECT')


if __name__ == '__main__':
    unittest.main()
