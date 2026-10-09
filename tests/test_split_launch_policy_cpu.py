"""Compile the production scheduling policy and exercise it without CUDA.

The compiler fixture uses NDEBUG; Python -O therefore cannot disable any check.
No GPU, Torch import, or extension build is needed. A C++17 compiler is required.
"""
import json
import os
from pathlib import Path
import subprocess
import tempfile
import unittest
from cpp_test_utils import compile_cpp


ROOT = Path(__file__).resolve().parents[1]
HEADER = ROOT / "csrc/kernel_launcher/split_launch_policy.h"


def compile_policy(directory):
    source = directory / "policy.cpp"
    executable = directory / ("policy.exe" if os.name == "nt" else "policy")
    source.write_text(
        f'#include "{HEADER.as_posix()}"\n'
        '#include <iostream>\n'
        'int main() {\n'
        '    int dependent, active, sms, limit;\n'
        '    uint64_t plane;\n'
        '    unsigned splits;\n'
        '    while (std::cin >> dependent >> plane >> splits >> active >> sms >> limit) {\n'
        '        const int effective = EffectiveSplitSmCount(sms, limit);\n'
        '        std::cout << effective << " "\n'
        '                  << SelectSplitLaunchCount(dependent != 0, plane, splits, active, effective)\n'
        '                  << "\\n";\n'
        '    }\n'
        '    return std::cin.eof() ? 0 : 1;\n'
        '}\n', encoding="utf-8")

    return compile_cpp(source, executable)


class SplitLaunchPolicyTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        temporary = tempfile.TemporaryDirectory(prefix="dlssnr-split-policy-")
        cls.addClassCleanup(temporary.cleanup)
        cls.executable = compile_policy(Path(temporary.name))

    def check_cases(self, cases):
        """Cases contain six actual policy inputs followed by two expected outputs."""
        result = subprocess.run(
            [str(self.executable)], input="".join(" ".join(map(str, inputs)) + "\n"
                                                 for inputs, _ in cases),
            capture_output=True, text=True, check=True, timeout=10)
        actual = [tuple(map(int, line.split())) for line in result.stdout.splitlines()]
        self.assertEqual(actual, [expected for _, expected in cases])

    def test_capacity_limit_can_only_reduce_device_capacity(self):
        self.check_cases([
            ((1, 24, 4, 4, 32, 0), (32, 1)),
            ((1, 24, 4, 4, 32, 1), (1, 4)),
            ((1, 24, 4, 4, 32, 24), (24, 1)),
            ((1, 24, 4, 4, 32, 23), (23, 4)),
            ((1, 24, 4, 4, 32, 32), (32, 1)),
            ((1, 24, 4, 4, 32, 33), (32, 1)),
            ((1, 24, 4, 4, 32, 2147483647), (32, 1)),
            ((1, 24, 4, 4, 32, -1), (32, 1)),
        ])

    def test_actual_network_grids_require_every_dependent_split_to_fit(self):
        for precision in ("fp8", "fp16"):
            suffix = "_fp16" if precision == "fp16" else ""
            for width, height in ((1280, 720), (1920, 1080), (2560, 1440), (3840, 2160)):
                plan = json.loads((ROOT / f"tuning/plan{suffix}_{width}_{height}.json").read_text())
                dependent = [call for call in plan["calls"] if call["all_resident"]]
                self.assertEqual(len(dependent), 25)
                families = {call["fn"]: call for call in dependent}
                self.assertEqual(len(families), 4)
                for name, call in families.items():
                    with self.subTest(precision=precision, width=width, height=height, kernel=name):
                        x, y, splits = call["grid"]
                        plane, total = x * y, x * y * splits
                        self.check_cases([
                            # Exact capacity is sufficient; one missing resident block is not.
                            ((1, plane, splits, 1, total, 0), (total, 1)),
                            ((1, plane, splits, 1, total - 1, 0), (total - 1, splits)),
                            # The previous FP16 XY-only gate admitted this unsafe configuration.
                            ((1, plane, splits, 1, plane, 0), (plane, splits)),
                            # A plane may itself run in waves; ordered phases need no residency gate.
                            ((1, plane, splits, 1, total, 1), (1, splits)),
                        ])

    def test_independent_z_and_single_split_kernels_keep_one_launch(self):
        self.check_cases([
            ((0, 1000000, 4, 1, 1, 0), (1, 1)),
            ((0, 1000000, 8, 0, 1, 0), (1, 1)),
            ((1, 1000000, 1, 1, 1, 0), (1, 1)),
        ])

    def test_large_grids_do_not_overflow_into_false_admission(self):
        self.check_cases([
            ((1, (1 << 64) - 1, 4, 2147483647, 2147483647, 0), (2147483647, 4)),
            ((1, 1 << 63, 2, 1, 1, 0), (1, 2)),
            ((1, (1 << 64) - 1, (1 << 32) - 1, 1, 1, 0), (1, (1 << 32) - 1)),
        ])

    def test_zero_or_negative_occupancy_never_admits_a_dependent_grid(self):
        # The host separately rejects kernels with no executable occupancy.
        self.check_cases([
            ((1, 1, 4, 0, 32, 0), (32, 4)),
            ((1, 1, 4, -1, 32, 0), (32, 4)),
            ((1, 1, 2, 1, 0, 0), (0, 2)),
        ])


if __name__ == "__main__":
    unittest.main()
