"""Compare compiled C++ geometry with the independent physical-layout oracle.

No CUDA context or tensor allocation is used. This tests every allocation,
launch grid and scalar argument, not just the requested width and height.
"""
import json
import os
from pathlib import Path
import random
import subprocess
import sys
import tempfile
import unittest

from cpp_test_utils import compile_cpp

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tuning"))
from generate_plan import build_plan
from physical_schedule import make


class DynamicGeometryTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        temporary = tempfile.TemporaryDirectory(prefix="dlssnr-geometry-")
        cls.addClassCleanup(temporary.cleanup)
        directory = Path(temporary.name)
        includes = [Path(os.environ[key]) / "include" for key in ("CUDA_HOME", "CUDA_PATH")
                    if os.environ.get(key)]
        includes += [ROOT / ".cuda/Library/include"]
        cuda_include = next((path for path in includes if (path / "cuda_runtime_api.h").is_file()), None)
        if cuda_include is None:
            raise unittest.SkipTest("CUDA headers unavailable; host geometry fixture was not compiled")
        source = directory / "geometry.cpp"
        source.write_text(r'''
#include "plan_geometry.h"
#include "plan_geometry_generated.inl"
#include "plan_geometry_fp16_generated.inl"
#include <iostream>
int main() {
    int Precision;
    int64_t Width, Height;
    while (std::cin >> Precision >> Width >> Height) {
        try {
            const auto Shape = Precision ? SelectGeometryPlan_fp16(Width, Height)
                                         : SelectGeometryPlan_fp8(Width, Height);
            std::cout << "{\"width\":" << Shape.ValidWidth << ",\"height\":" << Shape.ValidHeight;
            std::cout << ",\"buffers\":[";
            for (size_t I = 0; I < Shape.BufferBytes.size(); ++I)
                std::cout << (I ? "," : "") << Shape.BufferBytes[I];
            std::cout << "],\"grids\":[";
            for (size_t I = 0; I < Shape.Grids.size(); ++I) {
                const auto Grid = Shape.Grids[I];
                std::cout << (I ? "," : "") << '[' << Grid.x << ',' << Grid.y << ',' << Grid.z << ']';
            }
            std::cout << "],\"scalars\":[";
            for (size_t I = 0; I < Shape.GeometryArguments.size(); ++I)
                std::cout << (I ? "," : "") << Shape.GeometryArguments[I];
            std::cout << "]}\n";
        } catch (const std::exception&) {
            std::cout << "{\"rejected\":true}\n";
        }
    }
    return std::cin.eof() ? 0 : 1;
}
''', encoding="utf-8")
        cls.executable = compile_cpp(source, directory / ("geometry.exe" if os.name == "nt" else "geometry"),
                                     include_dirs=[ROOT / "csrc/kernel_launcher", cuda_include])

    def evaluate(self, requests):
        process = subprocess.run([str(self.executable)],
                                 input="".join(f"{precision} {width} {height}\n"
                                               for precision, width, height in requests),
                                 text=True, capture_output=True, check=True, timeout=30)
        results = [json.loads(line) for line in process.stdout.splitlines()]
        self.assertEqual(len(results), len(requests))
        return results

    def assert_reference(self, requests):
        for (precision, width, height), actual in zip(requests, self.evaluate(requests)):
            with self.subTest(precision=precision, width=width, height=height):
                plan = build_plan(make(width, height, precision="fp16" if precision else "fp8"))
                self.assertEqual(actual, dict(width=width, height=height,
                    buffers=[buffer["storage_bytes"] for buffer in plan["buffers"].values()],
                    grids=[call["grid"] for call in plan["calls"]],
                    scalars=[int(value) for call in plan["calls"]
                             for _, size, value in call["fields"] if size == 4]))

    def test_anchors_and_nonstandard_aspect_ratios_match_every_reference_field(self):
        shapes = [(1280, 720), (1920, 1080), (2560, 1440), (3840, 2160),
                  (1234, 777), (1080, 1920), (3440, 1440), (640, 360),
                  (3841, 2161), (33, 33), (390, 715), (4096, 4096), (8192, 4320), (65, 4097)]
        self.assert_reference([(precision, *shape) for precision in (0, 1) for shape in shapes])

    def test_rounding_boundaries_and_deterministic_unsampled_shapes(self):
        rng = random.Random(91026)
        shapes = [(base + delta, base // 2 + delta) for base in (320, 512, 1024, 2048)
                  for delta in (-1, 0, 1)]
        shapes += [(rng.randint(33, 8200), rng.randint(33, 4400)) for _ in range(32)]
        self.assert_reference([(precision, *shape) for precision in (0, 1) for shape in shapes])

    def test_invalid_and_overflowing_shapes_are_rejected_without_allocating(self):
        shapes = [(0, 720), (1280, 0), (-1, 720), (1, 1),
                  (65536, 65536), (2**31, 720), (1280, 2**31),
                  (2**63 - 1, 2**63 - 1)]
        self.assertEqual(self.evaluate([(precision, *shape) for precision in (0, 1) for shape in shapes]),
                         [{"rejected": True}] * (2 * len(shapes)))


if __name__ == "__main__":
    unittest.main()
