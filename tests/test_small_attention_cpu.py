"""CPU/source contracts for the Small31 numerically safe attention route.

These checks are structural, not numerical mirrors of the kernels: they prove
that the two safe exports exist once in the reviewed source layout, share the
unchanged canonical attention parameter structs, route exactly the eight
Small31 global-attention calls, and register boxed CUDA/Meta operators with the
same strict prepared-kernel contract as the canonical81 entries. No CUDA module
is imported or launched.
"""
from __future__ import annotations

import json
import re
from pathlib import Path
import sys
import unittest

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
sys.path.insert(0, str(ROOT / 'tuning'))

from tools.kernel_sources import SAFE_ATTENTION_EXPORTS, check_entry_layout, check_roster, collect

CSRC = ROOT / 'csrc'
SMALL_DIR = CSRC / 'kernel_impl' / 'small_c1024_attention'
SAFE_SOURCES = {
    'fp8': SMALL_DIR / 'fp8' / 'small_global_attention_chained_c1024_fp8.cu',
    'fp16': SMALL_DIR / 'fp16' / 'small_global_attention_chained_c1024_fp16.cu',
}
ABI_HEADER = SMALL_DIR / 'common' / 'small_attention_abi.h'
SMALL_PLANS = {
    'fp8': CSRC / 'kernel_launcher' / 'small_plan_generated.inl',
    'fp16': CSRC / 'kernel_launcher' / 'small_plan_fp16_generated.inl',
}
LEGACY_ATTENTION = {
    'fp8': 'global_attention_chained_c1024_fp8',
    'fp16': 'global_attention_chained_c1024_fp16',
}
PARAMETER_TYPES = {
    'fp8': 'FGlobalAttentionChainedC1024Fp8Parameters',
    'fp16': 'FGlobalAttentionChainedC1024Fp16Parameters',
}


def _compact(text: str) -> str:
    return re.sub(r'\s+', ' ', text).strip()


def _function_body(text: str, name: str) -> str:
    """Return one braced C++ function body from source text."""
    start = text.index(f'static void {name}(')
    opening = text.index('{', start)
    depth = 0
    for index in range(opening, len(text)):
        if text[index] == '{':
            depth += 1
        elif text[index] == '}':
            depth -= 1
            if depth == 0:
                return text[opening + 1:index]
    raise AssertionError(f'unclosed function body: {name}')


class SmallAttentionCPUTest(unittest.TestCase):
    def test_safe_exports_are_one_owned_definition_each(self):
        inventory = collect(CSRC)
        check_roster(inventory)
        check_entry_layout(inventory, CSRC)
        self.assertEqual(inventory['entry_count'], 83)
        self.assertEqual(inventory['definition_count'], 58)
        self.assertEqual(inventory['emission_unit_count'], 58)
        self.assertEqual(inventory['template_entry_count'], 40)
        for precision, path in SAFE_SOURCES.items():
            name = f'small_global_attention_chained_c1024_{precision}'
            with self.subTest(name=name):
                relative = path.relative_to(CSRC).as_posix()
                entry = inventory['entries'][name]
                self.assertEqual(entry['header'], relative)
                self.assertEqual(entry['emission_unit'], relative)
                self.assertEqual(entry['linkage'], 'C')
                self.assertEqual(entry['parameters'],
                                 f'{PARAMETER_TYPES[precision]} Parameters')
                self.assertTrue(path.is_file())

    def test_denominator_reduction_is_fp32_from_each_native_half_term(self):
        helper = SMALL_DIR / 'common' / 'intrinsics.cuh'
        self.assertTrue(helper.is_file())
        self.assertFalse((SMALL_DIR / 'common' / 'small_attention_intrinsics.cuh').exists())
        helper_code = helper.read_text(encoding='utf-8')
        for name in ('WidenHalfPairFloat2', 'AddFloat2Componentwise',
                     'PermuteGlobalAttentionQuadFloat2', 'ShuffleFloat2Idx', 'TotalFloat2'):
            with self.subTest(helper=name):
                self.assertIn(name, helper_code)
        self.assertIn('__half2float', helper_code)
        for precision, path in SAFE_SOURCES.items():
            with self.subTest(precision=precision):
                text = path.read_text(encoding='utf-8')
                self.assertIn('#include "../common/intrinsics.cuh"', text)
                self.assertNotIn('small_attention_intrinsics', text)
                self.assertIn('float r_Denominator[2]', text)
                start = text.index('// Sum the current score tile')
                end = text.index('// Multiply the current probability tile by V')
                reduction = text[start:end]
                # Every one of the eight packed probability words per row is
                # widened term-by-term; no packed Half addition may survive.
                self.assertEqual(reduction.count('WidenHalfPairFloat2(r_Pairs['), 8)
                self.assertNotIn('HalfAdd', reduction)
                self.assertNotIn('PermuteGlobalAttentionQuad(', reduction)
                self.assertIn('r_LocalProbabilitySums[4]', reduction)
                self.assertIn('r_GatheredProbabilitySums[4]', reduction)
                self.assertIn('float r_QuerySums[2];', reduction)
                self.assertIn('r_Denominator[0] += r_QuerySums[0];', reduction)
                self.assertIn('r_Denominator[1] += r_QuerySums[1];', reduction)

    def test_small_plans_route_exactly_eight_safe_attention_calls(self):
        for precision, path in SMALL_PLANS.items():
            safe = f'small_global_attention_chained_c1024_{precision}'
            with self.subTest(precision=precision):
                text = path.read_text(encoding='utf-8')
                self.assertEqual(text.count(f'KernelCall.Name = "{safe}"'), 8)
                self.assertNotIn(f'KernelCall.Name = "{LEGACY_ATTENTION[precision]}"', text)
                self.assertEqual(text.count('Calls.push_back(KernelCall);'), 109)
                self.assertEqual(text.count(f'using FParameters = {PARAMETER_TYPES[precision]};'), 8)
                self.assertNotIn('small_global_attention_chained_c1024_'
                                 + ('fp16' if precision == 'fp8' else 'fp8'), text)

    def test_abi_header_adds_only_the_two_declarations(self):
        header = ABI_HEADER.read_text(encoding='utf-8')
        code = _compact(header)
        for precision in ('fp8', 'fp16'):
            name = f'small_global_attention_chained_c1024_{precision}'
            declaration = f'extern "C" void {name}({PARAMETER_TYPES[precision]} Parameters);'
            with self.subTest(name=name):
                self.assertIn(declaration, code)
        self.assertNotRegex(code, r'struct\s+\w*GlobalAttention\w*Parameters')
        deployment = (CSRC / 'kernel_launcher' / 'small_deployment.cpp').read_text(encoding='utf-8')
        self.assertIn('#include "kernel_impl/small_c1024_attention/common/small_attention_abi.h"',
                      deployment)
        canonical = (CSRC / 'kernel_impl' / 'shared' / 'common' / 'kernel_abi.h').read_text(
            encoding='utf-8')
        for legacy in LEGACY_ATTENTION.values():
            self.assertIn(f'extern "C" void {legacy}(', canonical)

    def test_boxed_registration_matches_prepared_ops_contract(self):
        prepared = (CSRC / 'torch_api' / 'prepared_ops.cpp').read_text(encoding='utf-8')
        small = (CSRC / 'torch_api' / 'small_extension.cpp').read_text(encoding='utf-8')
        self.assertEqual(_compact(_function_body(prepared, 'InvokePreparedKernel')),
                         _compact(_function_body(small, 'InvokeSmallSafeAttention')))
        self.assertIn('FindPreparedKernel', small)
        self.assertIn('Operator.schema().name() == "dlssnr::" + Descriptor->Name', small)
        self.assertIn('Descriptor->Validate(Inputs, Outputs, bMeta);', small)
        self.assertIn('(Tensor[] inputs, Tensor(a!)[] outputs, int handle) -> ()', small)
        for name in sorted(SAFE_ATTENTION_EXPORTS):
            self.assertEqual(small.count(f'"{name}"'), 1)
        self.assertIn('TORCH_LIBRARY_IMPL(dlssnr, CUDA, Library)', small)
        self.assertIn('TORCH_LIBRARY_IMPL(dlssnr, Meta, Library)', small)
        for weak in ('CompositeImplicitAutograd', 'catchAll', 'BackendSelect', 'CPU, Library',
                     'Autograd, Library'):
            self.assertNotIn(weak, small)

    def test_safe_names_stay_out_of_the_canonical81_tables(self):
        canonical = json.loads(
            (ROOT / 'tuning' / 'canonical_kernel_names.json').read_text(encoding='utf-8'))
        self.assertEqual(len(canonical), 81)
        names = set(canonical.values())
        self.assertFalse(names & SAFE_ATTENTION_EXPORTS)
        prepared = (CSRC / 'kernel_launcher' /
                    'prepared_kernel_names_generated.inl').read_text(encoding='utf-8')
        self.assertNotIn('small_global_attention', prepared)
        self.assertEqual(len(re.findall(r'^\s*"[a-z0-9_]+",$', prepared, re.M)), 81)
        for legacy in LEGACY_ATTENTION.values():
            self.assertIn(f'"{legacy}"', prepared)


if __name__ == '__main__':
    unittest.main()
