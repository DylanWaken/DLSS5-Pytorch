"""CPU-only checks for the separate Small31 native plan.

Covers raw-record/role separation, Small-specific phases and grids, trunk input
topology, record/buffer extents at standard and odd geometry, the generated
dynamic-geometry formulas and the frozen legacy generator output.
"""
from __future__ import annotations

import hashlib
import re
from pathlib import Path
import sys
import unittest

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
sys.path.insert(0, str(ROOT / 'tuning'))

from dlssnr.geometry import Geometry, align_up, block_channels, window_shift
from dlssnr.model_specs import SMALL31
from generate_plan import (RESOLUTIONS, SAFE_ATTENTION_ALIASES, build_plan, load_abi_fields,
                           render as render_legacy)
from generate_small_plan import (CLASS_NAME, GEOMETRY_FUNCTION, TABLE_PREFIX, boundary_names,
                                 render as render_small)
from physical_schedule import make

LEGACY_RENDER_SHA256 = {
    'plan_generated.inl': '95e3483fc207a94e5c63c0abda712026066453714ff03e8b491a5b3111fcf97c',
    'plan_geometry_generated.inl': 'f395ff95d3cf9e1ab25e1c3d8d485f5aae06e34468b5f2f477d8756897cac694',
    'plan_fp16_generated.inl': '2ed2c05b4fe45630a77c76980f1b19fc061d5a52041c63262ae3e902ea3f7569',
    'plan_geometry_fp16_generated.inl': '94b634c55307ff3d1de7b50ba69d3b15652ff4d8fd7f988be6dae8381875dc64',
}
LEGACY_DISK_SHA256 = {
    'plan_generated.inl': '8c0afe61aca4c681429be65b337b95f7a21c0116f6c891857b366385be357972',
    'plan_geometry_generated.inl': 'f395ff95d3cf9e1ab25e1c3d8d485f5aae06e34468b5f2f477d8756897cac694',
    'plan_fp16_generated.inl': '9edd2dad4b9057c5e19e0412eac5400e79e88506641f7e5fed1d679f066dd280',
    'plan_geometry_fp16_generated.inl': '94b634c55307ff3d1de7b50ba69d3b15652ff4d8fd7f988be6dae8381875dc64',
}
SMALL_ASSETS = {
    'fp8': ('small_plan_generated.inl', 'small_plan_geometry_generated.inl'),
    'fp16': ('small_plan_fp16_generated.inl', 'small_plan_geometry_fp16_generated.inl'),
}
SMALL_SHAPES = ((1280, 720), (1920, 1080), (1234, 777), (1279, 719))
OUT = ROOT / 'csrc' / 'kernel_launcher'


def _digest(text: str) -> str:
    return hashlib.sha256(text.encode('utf-8')).hexdigest()


def _small_plan(width, height, precision='fp8'):
    schedule = make(width, height, precision=precision, model='small31')
    return schedule, build_plan(schedule, SMALL31)


def _rows(schedule, role, stage=None):
    return [row for row in schedule['positions']
            if row['block'] == role and (stage is None or row['stage'] == stage)]


def _scalar_fields(call, abi_fields):
    names = abi_fields[call['fn']]
    return {names[offset]: int(value) for offset, size, value in call['fields'] if size == 4}


def _split_top_level(text: str):
    parts, depth, start = [], 0, 0
    for index, character in enumerate(text):
        if character == '(':
            depth += 1
        elif character == ')':
            depth -= 1
        elif character == ',' and depth == 0:
            parts.append(text[start:index].strip())
            start = index + 1
    parts.append(text[start:].strip())
    return parts


class _Shape:
    def __init__(self, geometry):
        self._geometry = geometry

    def Width(self, level):
        return self._geometry.levels[level][0]

    def Height(self, level):
        return self._geometry.levels[level][1]

    def Tokens(self):
        return self.Width(5) * self.Height(5)

    def PaddedTokens(self):
        return align_up(self.Tokens(), 32)

    def SpatialBytes(self, level, channels, element_bytes):
        return self.Height(level) * self.Width(level) * channels * element_bytes

    def TokenBytes(self, channels, element_bytes, components=1):
        return self.PaddedTokens() * channels * components * element_bytes

    def DownsampleBytes(self, level, channels, element_bytes):
        padded = (self.Width(level) != 2 * self.Width(level + 1) or
                  self.Height(level) != 2 * self.Height(level + 1))
        return self.SpatialBytes(level + 1, channels * 2, element_bytes) * (2 if padded else 1)

    def CounterBytes(self, counters_per_tile):
        return align_up(self.Tokens(), 128) // 128 * counters_per_tile * 4

    def DecoderCounterBytes(self):
        return ((self.Height(5) + 3) // 4) * ((self.Width(5) + 3) // 4) * 2 * 4


def _block_text(text, marker):
    start = text.index(marker) + len(marker)
    end = text.index('\n    };', start)
    return text[start:end].strip('\n').splitlines()


def _evaluate_geometry(text, width, height, element_bytes):
    """Execute the emitted C++ geometry table with Python integer semantics."""
    shape = _Shape(Geometry.from_valid(width, height))

    def divide_up(value, divisor):
        return value // divisor + (value % divisor != 0)

    environment = {'Shape': shape, 'ElementBytes': element_bytes,
                   'GeometryDivideUp': divide_up}

    def evaluate(expression):
        return int(eval(expression.replace(' / ', ' // '), {'__builtins__': {}}, environment))

    buffers = {}
    for line in _block_text(text, 'Geometry.BufferBytes = {'):
        match = re.match(r'^\s*(.*?), // (\S+)$', line)
        if not match:
            raise AssertionError(f'unparsed buffer line: {line!r}')
        buffers[match[2]] = evaluate(match[1])

    boundaries = {'Geometry': type('GeometryNamespace', (), {'BufferBytes': list(buffers.values())})()}
    environment.update(boundaries)

    def scalar_expressions(line):
        payload = line.split(', // ')[0].strip()
        values, cursor = [], 0
        token = 'GeometryScalar('
        while True:
            start = payload.find(token, cursor)
            if start < 0:
                return values
            index = start + len(token)
            depth = 1
            while depth:
                if payload[index] == '(':
                    depth += 1
                elif payload[index] == ')':
                    depth -= 1
                index += 1
            values.append(payload[start + len(token):index - 1])
            cursor = index

    grids = []
    for line in _block_text(text, 'Geometry.Grids = {'):
        match = re.match(r'^\s*GeometryGrid\((.*)\), // \S+$', line)
        if not match:
            raise AssertionError(f'unparsed grid line: {line!r}')
        grids.append([evaluate(part) for part in _split_top_level(match[1])])

    scalars = []
    for line in _block_text(text, 'Geometry.GeometryArguments = {'):
        scalars.append([evaluate(expression) for expression in scalar_expressions(line)])

    return buffers, grids, scalars


class SmallPlanCPUTest(unittest.TestCase):
    def test_small_role_record_and_buffer_namespaces_do_not_collide(self):
        schedule, plan = _small_plan(1280, 720)
        self.assertEqual(len(plan['calls']), 109)
        self.assertEqual(len(plan['records']), 66)

        vit_layer3 = {f'block{raw}.layer3.layer' for raw in range(11, 19)}
        post_records = {'block30.layer0.layer', 'block30.layer0.blend_scale'}
        pre_records = {'block0.layer0.layer'}
        expected_records = SMALL31.expected_record_names() - vit_layer3 - post_records - pre_records
        self.assertEqual(set(plan['records']), expected_records)
        self.assertNotIn('block30.layer0.layer', plan['records'])
        self.assertNotIn('block30.layer0.blend_scale', plan['records'])
        self.assertIn('block10.layer4.layer', plan['records'])
        self.assertEqual({name: size for name, size in plan['records'].items()
                          if name in expected_records},
                         {name: SMALL31.record_spec(name).byte_length for name in expected_records})

        for row in schedule['positions']:
            if isinstance(row['block'], int):
                self.assertEqual(row['raw_block'], SMALL31.raw_for_role(row['block']))
        self.assertIn('b31.output', plan['buffers'])
        self.assertNotIn('b11.output', plan['buffers'])
        self.assertIn('b23.branches', plan['buffers'])
        self.assertNotIn('b9.branches', plan['buffers'])
        self.assertNotIn('block31.layer0.layer', plan['records'])
        self.assertIn('block11.layer0.layer', plan['records'])

    def test_small_phase_and_grid_changes_cover_every_retained_role(self):
        schedule = make(1280, 720, precision='fp8', model='small31')
        legacy = make(1280, 720, precision='fp8')
        legacy_phases = {(row['block'], row['stage']): row['phase']
                         for row in legacy['positions'] if isinstance(row['block'], int)}
        changed = {}
        for row in schedule['positions']:
            if not isinstance(row['block'], int):
                continue
            role, stage = row['block'], row['stage']
            expected = SMALL31.phase_for_role(role)
            if role in (23, 30, 40, 47):
                self.assertEqual(row['phase'], expected if stage == 'attended' else None)
            elif 31 <= role <= 38 or role == 39:
                self.assertIsNone(row['phase'])
            else:
                self.assertEqual(row['phase'], expected)
            if row['phase'] is not None and legacy_phases.get((role, stage)) != row['phase']:
                changed[(role, stage)] = (legacy_phases.get((role, stage)), row['phase'])

            if stage in ('fused', 'attended'):
                if role in (23, 30, 40, 47):
                    level = 4
                else:
                    level = {32: 0, 64: 1, 128: 2, 256: 3}[block_channels(role)]
                height, width = schedule['levels'][level][1], schedule['levels'][level][0]
                sx, sy = window_shift(row['phase'])
                grid = [(width + sx + 7) // 8, (height + sy + 7) // 8, 1]
                self.assertEqual(row['grid'][:2], grid[:2])
                if stage == 'attended':
                    self.assertEqual(row['grid'], [*grid[:2], 4])

        self.assertEqual(changed, {
            (4, 'fused'): (3, 1),
            (8, 'fused'): (3, 1),
            (22, 'fused'): (3, 1),
            (30, 'attended'): (3, 1),
            (40, 'attended'): (0, 2),
            (48, 'fused'): (0, 2),
            (62, 'fused'): (0, 2),
            (66, 'fused'): (0, 2),
        })

    def test_small_trunk_input_dependency_topology(self):
        for precision in ('fp8', 'fp16'):
            schedule, plan = _small_plan(1920, 1080, precision)
            produced = {'input'}
            for row in schedule['positions']:
                for name in row['input_buffers'].values():
                    self.assertIn(name, produced, f'{row["original_symbol"]} consumes {name} before production')
                produced.update(row['output_buffers'].values())
            self.assertEqual(schedule['output_buffer'], 'b69.output')

            edges = {
                (23, 'branches'): ('state', 'b22.down'),
                (30, 'branches'): ('state', 'b23.output'),
                ('repack-30-31', 'repack'): ('input', 'b30.down'),
                (31, 'expand'): ('state', 'repack-30-31'),
                ('repack-38-39', 'repack'): ('input', 'b38.output'),
                (39, 'output'): ('low', 'repack-38-39'),
                (40, 'branches'): ('state', 'b39.output'),
                (47, 'branches'): ('state', 'b40.output'),
                (48, 'fused'): ('state', 'b47.output'),
                (55, 'fused'): ('state', 'b48.output'),
                (56, 'fused'): ('state', 'b55.output'),
                (61, 'fused'): ('state', 'b56.output'),
                (62, 'fused'): ('state', 'b61.output'),
                (65, 'fused'): ('state', 'b62.output'),
                (66, 'fused'): ('state', 'b65.output'),
                (69, 'fused'): ('state', 'b66.output'),
            }
            for (role, stage), (key, buffer) in edges.items():
                row = _rows(schedule, role, stage)[0]
                self.assertEqual(row['input_buffers'][key], buffer)
            self.assertEqual(_rows(schedule, 39, 'output')[0]['input_buffers']['skip'], 'b30.output')
            for role, skip in ((48, 'b22.output'), (56, 'b14.output'), (62, 'b8.output'), (66, 'b4.output')):
                self.assertEqual(_rows(schedule, role, 'fused')[0]['input_buffers']['skip'], skip)
            self.assertEqual(plan['buffers']['b69.output']['shape_hwc'],
                             list(reversed(schedule['levels'][0])) + [32])

    def test_small_record_and_buffer_extents_are_shape_invariant(self):
        for precision, element_bytes in (('fp8', 1), ('fp16', 2)):
            reference_schedule, reference = _small_plan(1280, 720, precision)
            reference_names = list(reference['buffers'])
            for width, height in SMALL_SHAPES:
                with self.subTest(precision=precision, width=width, height=height):
                    schedule, plan = _small_plan(width, height, precision)
                    self.assertEqual(list(plan['buffers']), reference_names)
                    self.assertEqual(plan['records'], reference['records'])
                    shape = Geometry.from_valid(width, height)
                    levels = shape.levels
                    padded_tokens = align_up(levels[5][0] * levels[5][1], 32)
                    expected = {
                        'input': levels[0][0] * levels[0][1] * 32 * element_bytes,
                        'repack-30-31': padded_tokens * 1024 * element_bytes,
                        'repack-38-39': levels[5][0] * levels[5][1] * 1024 * element_bytes,
                        'b31.expanded': padded_tokens * 4096 * element_bytes,
                        'b30.pool': levels[5][0] * levels[5][1] * 512 * element_bytes,
                        'b30.down': levels[5][0] * levels[5][1] * 1024 * element_bytes,
                    }
                    for name, size in expected.items():
                        self.assertEqual(plan['buffers'][name]['storage_bytes'], size)
                    padded_downsample = (levels[0][0] != 2 * levels[1][0] or
                                         levels[0][1] != 2 * levels[1][1])
                    self.assertEqual(plan['buffers']['b4.down']['storage_bytes'],
                                     levels[1][0] * levels[1][1] * 64 * element_bytes *
                                     (2 if padded_downsample else 1))
                    for name, value in plan['records'].items():
                        self.assertEqual(value, reference['records'][name])
                    expected_input = SMALL31.expected_record_sizes()
                    if precision == 'fp8':
                        self.assertEqual(plan['records'], {name: expected_input[name]
                                                          for name in plan['records']})
                    else:
                        legacy = build_plan(make(width, height, precision='fp16'))
                        for name, size in plan['records'].items():
                            raw = int(name[5:].split('.')[0])
                            layer = int(name.split('.layer')[1].split('.')[0])
                            role = SMALL31.raw_to_role[raw]
                            self.assertEqual(size, legacy['records'][f'block{role}.layer{layer}.layer'])

    def test_generated_dynamic_geometry_matches_every_plan_field(self):
        for precision, element_bytes in (('fp8', 1), ('fp16', 2)):
            assets, _, _ = render_small(precision)
            geometry_text = assets[SMALL_ASSETS[precision][1]]
            for width, height in SMALL_SHAPES:
                with self.subTest(precision=precision, width=width, height=height):
                    schedule, plan = _small_plan(width, height, precision)
                    buffers, grids, scalars = _evaluate_geometry(geometry_text, width, height, element_bytes)
                    self.assertEqual(buffers, {name: value['storage_bytes']
                                               for name, value in plan['buffers'].items()})
                    self.assertEqual(grids, [list(call['grid']) for call in plan['calls']])
                    expected_scalars = [[int(value) for _, size, value in call['fields'] if size == 4]
                                        for call in plan['calls']]
                    self.assertEqual(scalars, expected_scalars)

    def test_generated_small_assets_and_native_symbols(self):
        for precision, (plan_name, geometry_name) in SMALL_ASSETS.items():
            assets, schedules, plans = render_small(precision)
            for name, text in assets.items():
                self.assertEqual((OUT / name).read_text(encoding='utf-8'), text)
            self.assertEqual(schedules[-1]['output_buffer'], 'b69.output')
            self.assertEqual(len(plans[-1]['calls']), 109)
            self.assertEqual(len(plans[-1]['records']), 66)
            table = TABLE_PREFIX
            template_argument = 'true' if precision == 'fp16' else 'false'
            self.assertIn(f'static const char* {table}BufferNameTable_{precision}[]', assets[plan_name])
            self.assertIn(f'static const FBufferSpec {table}RecordSpecs_{precision}[]', assets[plan_name])
            self.assertIn(f'template <> void {CLASS_NAME}<{template_argument}>::BuildCalls()',
                          assets[plan_name])
            self.assertIn(f'static const char* {table}BoundaryNames_{precision}[]', assets[plan_name])
            self.assertIn(f'static FGeometryPlanSpec {GEOMETRY_FUNCTION}_{precision}(int64_t Width, int64_t Height)',
                          assets[geometry_name])
            self.assertNotIn('void FDeploymentPlan<', assets[plan_name])
            boundaries = boundary_names(schedules[-1])
            self.assertEqual(len(boundaries), 34)
            self.assertEqual(boundaries[0], 'b1.output')
            self.assertEqual(boundaries[-1], 'b69.output')
            self.assertIn('b4.down', boundaries)
            self.assertIn('b30.down', boundaries)
            self.assertIn(f'"{boundaries[-1]}",', assets[plan_name])

    def test_small_routes_exactly_eight_attention_calls_to_safe_exports(self):
        abi_fields, parameter_types = load_abi_fields()
        for precision in ('fp8', 'fp16'):
            with self.subTest(precision=precision):
                schedule, plan = _small_plan(3840, 2160, precision)
                safe = f'small_global_attention_chained_c1024_{precision}'
                legacy = f'global_attention_chained_c1024_{precision}'
                self.assertEqual(SAFE_ATTENTION_ALIASES[safe], legacy)
                attention = [call for call in plan['calls']
                             if call['symbol'].startswith('cc_vit_1d_attention_chained')]
                self.assertEqual(len(attention), 8)
                self.assertEqual({call['fn'] for call in attention}, {safe})
                self.assertNotIn(legacy, {call['fn'] for call in plan['calls']})
                self.assertEqual(len(plan['calls']), 109)
                self.assertEqual(len(plan['records']), 66)
                # 33 compute/repack symbols plus the completion-counter clear.
                self.assertEqual(len({call['fn'] for call in plan['calls']}), 34)
                self.assertEqual(len({call['fn'] for call in plan['calls']
                                      if call['fn'] != 'completion_counter_clear'}), 33)
                # The safe export reuses the unchanged canonical parameter ABI.
                self.assertEqual(parameter_types[safe], parameter_types[legacy])
                self.assertEqual(abi_fields[safe], abi_fields[legacy])
                safe_rows = [row for row in schedule['positions'] if 'safe_export' in row]
                self.assertEqual(len(safe_rows), 8)
                self.assertEqual({row['safe_export'] for row in safe_rows}, {safe})

                # Legacy generation and schedules carry no safe alias.
                legacy_plan = build_plan(make(1280, 720, precision=precision))
                self.assertFalse(any(call['fn'].startswith('small_') for call in legacy_plan['calls']))
                self.assertFalse(any('safe_export' in row for row in
                                     make(1280, 720, precision=precision)['positions']))

                # Rendering is deterministic and the on-disk Small assets match.
                plan_name = SMALL_ASSETS[precision][0]
                first, _, _ = render_small(precision)
                second, _, _ = render_small(precision)
                self.assertEqual(first[plan_name], second[plan_name])
                self.assertEqual((OUT / plan_name).read_text(encoding='utf-8'), first[plan_name])
                self.assertEqual(first[plan_name].count(f'KernelCall.Name = "{safe}"'), 8)
                self.assertNotIn(f'KernelCall.Name = "{legacy}"', first[plan_name])

    def test_legacy_generator_output_and_files_are_byte_identical(self):
        counts = {}
        for precision, suffix in (('fp8', ''), ('fp16', '_fp16')):
            assets, schedules, plans = render_legacy(precision)
            counts[precision] = (len(plans[-1]['calls']), len(plans[-1]['records']))
            for name in (f'plan{suffix}_generated.inl', f'plan_geometry{suffix}_generated.inl'):
                self.assertEqual(_digest(assets[name]), LEGACY_RENDER_SHA256[name], name)
        self.assertEqual(counts, {'fp8': (185, 142), 'fp16': (185, 142)})
        for name, digest in LEGACY_DISK_SHA256.items():
            self.assertEqual(hashlib.sha256((OUT / name).read_bytes()).hexdigest(), digest, name)

        spec = SMALL31
        self.assertEqual(len(spec.roles), 31)
        self.assertEqual(spec.record_count, 77)
        for width, height in RESOLUTIONS:
            self.assertEqual(len(make(width, height, precision='fp8')['positions']), 152)


if __name__ == '__main__':
    unittest.main()
