"""Generate the separate Small31 native FP8/FP16 plan tables.

The legacy ``plan*_generated.inl`` files are never read or written here.  This
module emits the Small31-only assets with explicit host-class and table names so
the next host step can include them next to the legacy tables in one TU.
"""
from pathlib import Path
import json
import sys

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / 'csrc' / 'kernel_launcher'
REPORT = ROOT / 'profile' / 'dlss-update-20261029' / 'native-generate'
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

try:
    from .generate_plan import (build_precision_plans, load_abi_fields, load_template_resolvers,
                                plan_source, runtime_geometry_source)
except ImportError:
    from generate_plan import (build_precision_plans, load_abi_fields, load_template_resolvers,
                              plan_source, runtime_geometry_source)

from dlssnr.model_specs import SMALL31

CLASS_NAME = 'FSmallDeploymentPlan'
TABLE_PREFIX = 'Small'
GEOMETRY_FUNCTION = 'SelectSmallGeometryPlan'

ASSETS = {
    'fp8': ('small_plan_generated.inl', 'small_plan_geometry_generated.inl'),
    'fp16': ('small_plan_fp16_generated.inl', 'small_plan_geometry_fp16_generated.inl'),
}

_FINAL_STAGES = ('fused', 'output', 'projection', 'down')


def boundary_names(schedule):
    """Trunk boundaries: each retained role's high output plus downsample tails."""
    names = []
    for row in schedule['positions']:
        if row['stage'] in _FINAL_STAGES:
            high = row['output_buffers'].get('high')
            if high is not None and high not in names:
                names.append(high)
        down = row['output_buffers'].get('down')
        if down is not None and down not in names:
            names.append(down)
    return names


def render(precision='fp8'):
    """Render the two Small31 assets for one precision without writing files."""
    if precision not in ASSETS:
        raise ValueError(f'unsupported precision {precision!r}')
    abi_fields, parameter_types = load_abi_fields()
    resolvers = load_template_resolvers()
    spec, schedules, plans = build_precision_plans(precision, 'small31')
    reference = plans[-1]
    call_count = len(reference['calls'])
    title = (f'// Generated separate Small31 native FP8 schedule. Every resolution uses '
             f'the same {call_count} calls.')
    plan_name, geometry_name = ASSETS[precision]
    return {
        plan_name: plan_source(
            precision, reference, abi_fields, parameter_types, resolvers,
            class_name=CLASS_NAME, table_prefix=TABLE_PREFIX, title=title,
            boundary_names=boundary_names(schedules[-1])),
        geometry_name: runtime_geometry_source(
            precision, reference, abi_fields, function_prefix=GEOMETRY_FUNCTION),
    }, schedules, plans


def generate(precision='fp8', *, write=True):
    assets, schedules, plans = render(precision)
    if write:
        OUT.mkdir(parents=True, exist_ok=True)
        for filename, text in assets.items():
            (OUT / filename).write_text(text, encoding='utf-8', newline='\n')
    return assets, schedules, plans


def generate_all():
    summary = dict(
        model=SMALL31.id,
        class_name=CLASS_NAME,
        table_prefix=TABLE_PREFIX,
        geometry_function=GEOMETRY_FUNCTION,
        assets={},
        precisions={},
    )
    for precision in ('fp8', 'fp16'):
        assets, schedules, plans = generate(precision)
        reference = plans[-1]
        summary['assets'][precision] = sorted(assets)
        summary['precisions'][precision] = dict(
            calls=len(reference['calls']),
            records=len(reference['records']),
            buffers=len(reference['buffers']),
            unique_symbols=len({call['fn'] for call in reference['calls']}),
            output_buffer=schedules[-1]['output_buffer'],
            census=schedules[-1]['census'],
            boundary_names=boundary_names(schedules[-1]),
            record_names=list(reference['records']),
            buffer_names=list(reference['buffers']),
        )
    REPORT.mkdir(parents=True, exist_ok=True)
    (REPORT / 'small_plan_census.json').write_text(
        json.dumps(summary, indent=2) + '\n', encoding='utf-8', newline='\n')
    print(json.dumps(summary))
    return summary


if __name__ == '__main__':
    generate_all()
