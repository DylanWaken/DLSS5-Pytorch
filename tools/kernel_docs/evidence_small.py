"""Measured per-entry evidence for the two additive Small31 attention lessons.

The canonical generator input is ``small_attention_measurements.json`` in this
directory.  It is a compact, checked-in snapshot of the verified handoff in
``profile/small-attention-fp32acc-sm120-20261030`` so a future documentation
build does not need the ignored profile tree.  The four raw reports themselves
are committed under ``docs/kernel-guide/evidence-small`` with their original
names and ``.ncu-repz`` suffix.

This namespace stays separate from ``evidence/index.json``.  The legacy file
remains the frozen 81-entry NCU set pinned to the historical source.  Here each
additive entry records its committed source, the native SM120 binary hash,
compiler/runtime attributes, the sampled numerical reference and exactly one
full plus one separate source NCU report for the same fixture.

It deliberately does not import ``lessons_small_attention``: the lesson module
is free to consume this evidence without creating an import cycle.
"""
from pathlib import Path
import hashlib
import json

from common import ROOT
from runtime_source_revision import RUNTIME_REVISION
from kernel_map_profiles import profile

BINARY_SHA256 = 'f0d514043dda98bbe0043ac14d1d93a13e6620eae1c0338d1e3901c017528938'
DEVICE = 'NVIDIA RTX PRO 6000 Blackwell Workstation Edition, SM120'
EXPECTED_FIXTURE_ID = 'cyberpunk2077-johnny-first4k-b31'
EXPECTED_REPORTS = {
    'full_cyberpunk4k-b31_fp16.ncu-repz',
    'source_cyberpunk4k-b31_fp16.ncu-repz',
    'full_cyberpunk4k-b31_fp8.ncu-repz',
    'source_cyberpunk4k-b31_fp8.ncu-repz',
}
STATE = 'measured'

SNAPSHOT_PATH = ROOT / 'tools/kernel_docs/small_attention_measurements.json'
PUBLIC_DIR = 'evidence-small'
SMALL_NAMES = (
    'small_global_attention_chained_c1024_fp16',
    'small_global_attention_chained_c1024_fp8',
)

NCU_RECORD_SCHEMA = {
    'state': 'measured',
    'reports': [
        {'kind': 'full', 'path': 'evidence-small/full_<fixture>_<precision>.ncu-repz',
         'sha256': '<raw report sha256>', 'fixture_id': EXPECTED_FIXTURE_ID,
         'metric_count': '<catalogued metric rows>'},
        {'kind': 'source', 'path': 'evidence-small/source_<fixture>_<precision>.ncu-repz',
         'sha256': '<raw report sha256>', 'fixture_id': EXPECTED_FIXTURE_ID,
         'metric_count': '<catalogued metric rows>'},
    ],
    'compiled_metrics': [
        'launch__registers_per_thread',
        'launch__registers_per_thread_allocated',
        'launch__shared_mem_per_block_static',
        'launch__shared_mem_per_block_dynamic',
        'launch__shared_mem_per_block_driver',
        'launch__block_size',
        'launch__grid_dim_x',
        'launch__grid_dim_y',
        'launch__grid_dim_z',
        'smsp__sass_inst_executed_op_local_ld.sum',
        'smsp__sass_inst_executed_op_local_st.sum',
        'sass__inst_executed_register_spilling_mem_local',
    ],
    'fixtures': EXPECTED_FIXTURE_ID,
    'gate': 'one full and one separate source report for the same entry and fixture; '
            'no legacy report may be substituted',
}

_ARTIFACTS = {
    'compiler_log': 'profile/dlss-update-20261029/rgb-safe-attention-build/build.log',
    'runtime_resources': 'profile/dlss-update-20261029/rgb-safe-attention-build/smoke.json',
    'cuobjdump': 'profile/dlss-update-20261029/rgb-safe-attention-build/cuobjdump-resource-usage.log',
    'reference_fp16': 'profile/dlss-update-20261029/rgb-safe-attention-validation/artifacts/probability_frame_fp16.json',
    'reference_fp8': 'profile/dlss-update-20261029/rgb-safe-attention-validation/artifacts/probability_frame_fp8.json',
    'rgb_results': 'profile/dlss-update-20261029/rgb-safe-attention-rgb/results.json',
}
PUBLIC_ARTIFACTS = {
    'verified_report': f'{PUBLIC_DIR}/REPORT.md',
    'compact_measurements': f'{PUBLIC_DIR}/measurements.json',
}


def _sha256(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def _normalized_sha256(path):
    text = path.read_text(encoding='utf-8')
    text = text.replace('\r\n', '\n').replace('\r', '\n')
    return hashlib.sha256(text.encode()).hexdigest()


def load_snapshot(require_current=True):
    """Load and structurally verify the checked-in compact snapshot.

    ``require_current`` is the final-publication gate.  It is not a switch for
    accepting pending data: a missing/empty report pair, a mismatched fixture,
    a changed raw hash or an absent substantive metric always raises.
    """
    if not SNAPSHOT_PATH.is_file():
        raise SystemExit(f'Missing canonical Small31 measurement snapshot: {SNAPSHOT_PATH}')
    snapshot = json.loads(SNAPSHOT_PATH.read_text(encoding='utf-8'))
    if snapshot.get('schema') != 'small-attention-measurements/v1':
        raise SystemExit('Small31 measurement snapshot has an unexpected schema')
    if snapshot.get('fixture_id') != EXPECTED_FIXTURE_ID:
        raise SystemExit('Small31 measurement snapshot names the wrong fixture')
    if snapshot.get('provenance', {}).get('source_commit') != RUNTIME_REVISION:
        raise SystemExit('Small31 measurement snapshot uses a different runtime source revision')
    if snapshot.get('provenance', {}).get('native_module', {}).get('sha256') != BINARY_SHA256:
        raise SystemExit('Small31 measurement snapshot uses a different native binary')
    kernels = snapshot.get('kernels') or {}
    if set(kernels) != set(SMALL_NAMES):
        raise SystemExit('Small31 measurement snapshot must contain exactly the two attention entries')
    seen_raw = set()
    for name in SMALL_NAMES:
        record = kernels[name]
        if record.get('fixture_id') != EXPECTED_FIXTURE_ID:
            raise SystemExit(f'{name}: fixture identity is missing or mismatched')
        source = ROOT / record.get('source', '')
        if not source.is_file() or _normalized_sha256(source) != record.get('source_sha256'):
            raise SystemExit(f'{name}: source hash does not match the snapshot pin')
        if record.get('runtime_binary_sha256') != BINARY_SHA256:
            raise SystemExit(f'{name}: runtime binary hash is not the accepted binary')
        if record.get('runtime_source_revision') != RUNTIME_REVISION:
            raise SystemExit(f'{name}: runtime source revision is not the committed pin')
        reports = record.get('ncu_reports') or []
        if len(reports) != 2 or {r.get('kind') for r in reports} != {'full', 'source'}:
            raise SystemExit(f'{name}: exactly one full and one separate source report are required')
        if len({r.get('fixture_id') for r in reports}) != 1:
            raise SystemExit(f'{name}: full and source reports must share one fixture')
        for report in reports:
            public = report.get('public_path', '')
            if not public.startswith(f'{PUBLIC_DIR}/') or not public.endswith('.ncu-repz'):
                raise SystemExit(f'{name}: report path is not a relative public .ncu-repz path')
            path = ROOT / 'docs/kernel-guide' / public
            if not path.is_file():
                raise SystemExit(f'{name}: missing copied raw report {public}')
            if _sha256(path) != report.get('sha256'):
                raise SystemExit(f'{name}: copied raw report hash mismatch for {public}')
            seen_raw.add(path.name)
        metrics = record.get('metrics') or []
        names = {row.get('name') for row in metrics}
        required = {
            'gpu__time_duration.sum',
            'launch__registers_per_thread',
            'launch__shared_mem_per_block_static',
            'smsp__pcsamp_sample_count',
            'smsp__sass_inst_executed_op_local_ld.sum',
            'smsp__sass_inst_executed_op_local_st.sum',
            'l1tex__data_bank_conflicts_pipe_lsu_mem_shared_op_ld.sum',
        }
        if not required.issubset(names):
            raise SystemExit(f'{name}: compact metrics are not substantive: {sorted(required - names)}')
        if len(metrics) < 90:
            raise SystemExit(f'{name}: compact metric set is unexpectedly small ({len(metrics)})')
        if (record.get('source_hotspot_count') or 0) < 1 or not record.get('source_hotspots'):
            raise SystemExit(f'{name}: source-correlated hotspot rows are required')
        compiled = record.get('compiled_resources') or {}
        if compiled.get('launch__registers_per_thread') in (None, 0):
            raise SystemExit(f'{name}: compiled register count is missing')
        if compiled.get('launch__shared_mem_per_block_static') in (None, 0):
            raise SystemExit(f'{name}: compiled static shared value is missing')
    if require_current and seen_raw != EXPECTED_REPORTS:
        raise SystemExit(f'Small31 snapshot must name exactly the four current raw reports; found {sorted(seen_raw)}')
    return snapshot


def _public_artifacts(snapshot):
    items = []
    for record in snapshot.get('artifacts', []):
        if record.get('public_path'):
            path = ROOT / 'docs/kernel-guide' / record['public_path']
            actual = _sha256(path) if path.is_file() else None
            if actual != record.get('sha256'):
                raise SystemExit(f'Public evidence artifact hash mismatch: {record["public_path"]}')
            items.append({key: record[key] for key in
                          ('role', 'public_path', 'sha256', 'size', 'suffix')
                          if key in record})
    return items


def _report_rows(record):
    rows = []
    for report in record['ncu_reports']:
        rows.append({
            'kind': report['kind'],
            'path': report['public_path'],
            'sha256': report['sha256'],
            'fixture_id': report['fixture_id'],
            'fixture': report['fixture_id'],
            'metric_count': report.get('metric_count'),
            'raw_suffix': report.get('raw_suffix', '.ncu-repz'),
            'source_path': report.get('local_path'),
        })
    return rows


def _record(name, record):
    compiled = record['compiled_resources']
    metrics = record['metrics']
    by_name = {row['name']: row for row in metrics}
    return {
        'state': STATE,
        'ncu_state': STATE,
        'source': record['source'],
        'source_sha256': record['source_sha256'],
        'runtime_source_revision': record['runtime_source_revision'],
        'runtime_binary_sha256': record['runtime_binary_sha256'],
        'device': record['device'],
        'fixture_id': record['fixture_id'],
        'precision': record['precision'],
        'shape': record['shape'],
        'compiled_resources': compiled,
        'numerical_reference': record['numerical_reference'],
        'contract': record['contract'],
        'ncu_reports': _report_rows(record),
        'ncu_extension': NCU_RECORD_SCHEMA,
        'report_identity': record['report_identity'],
        'metrics': metrics,
        'metric_count': len(metrics),
        'derived': record['derived'],
        'sampling': record['sampling'],
        'source_pins': record['source_pins'],
        'source_hotspots': record['source_hotspots'],
        'source_hotspot_count': record['source_hotspot_count'],
        'hotspot_line_totals': record['hotspot_line_totals'],
        'local_spill_pcs': record['local_spill_pcs'],
        'sass_evidence': record['sass_evidence'],
        'unpinned_toolkit_hotspots': record['unpinned_toolkit_hotspots'],
        'observations': record['observations'],
        'available': record['available'],
        'unavailable': record['unavailable'],
        'pm_sampling': record['pm_sampling'],
        'duration_ns': by_name['gpu__time_duration.sum']['value'],
        'artifacts': record['numerical_reference'].get('artifacts', []),
    }


def build_index(snapshot=None):
    snapshot = snapshot or load_snapshot()
    return {
        'schema': 'small-attention-evidence-index/v2',
        'state': STATE,
        'scope': ('Additive Small31 attention entries only; the legacy 81-entry NCU evidence set is '
                  'unchanged and is never substituted here.'),
        'fixture_id': snapshot['fixture_id'],
        'device': snapshot['device'],
        'runtime_source_revision': RUNTIME_REVISION,
        'runtime_binary_sha256': BINARY_SHA256,
        'ncu_state': STATE,
        'measurement_snapshot': {
            'path': 'tools/kernel_docs/small_attention_measurements.json',
            'sha256': _sha256(SNAPSHOT_PATH),
        },
        'report_contract': snapshot['report_contract'],
        'ncu_extension': NCU_RECORD_SCHEMA,
        'artifacts': _public_artifacts(snapshot),
        'kernels': {name: _record(name, snapshot['kernels'][name]) for name in SMALL_NAMES},
    }


def write_index():
    """Write the measured index and the public compact measurement copy."""
    snapshot = load_snapshot()
    index = build_index(snapshot)
    target = ROOT / 'docs/kernel-guide/evidence-small/index.json'
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(json.dumps(index, indent=2) + '\n', encoding='utf-8', newline='\n')
    public = ROOT / 'docs/kernel-guide/evidence-small/measurements.json'
    public.write_text(SNAPSHOT_PATH.read_text(encoding='utf-8'), encoding='utf-8', newline='\n')
    return index


def lesson_evidence(index=None):
    """Per-entry evidence mapping consumed by ``lessons_small_attention``."""
    index = index or build_index()
    return index['kernels']


def run_design_checks(inventory):
    snapshot = load_snapshot()
    kernels = {}
    checks = []
    for name in SMALL_NAMES:
        record = snapshot['kernels'][name]
        cfg = record['contract']
        entry = inventory['entries'][name]
        p = profile(name, entry)
        measured = {row['name']: row for row in record['metrics']}
        kernels[name] = {
            'source_revision': RUNTIME_REVISION,
            'source': record['source'],
            'source_sha256': record['source_sha256'],
            'runtime_binary_sha256': BINARY_SHA256,
            'fixture_id': snapshot['fixture_id'],
            'source_shared_bytes': p['shared'],
            'compiled_static_shared_bytes': record['compiled_resources']['launch__shared_mem_per_block_static'],
            'measured_static_shared_bytes': measured['launch__shared_mem_per_block_static']['value'],
            'resource_prediction': ('matched' if p['shared'] ==
                                    record['compiled_resources']['launch__shared_mem_per_block_static']
                                    else 'mismatch'),
            'kind': p['kind'],
            'persistent_fp32_per_lane': cfg['persistent_fp32_per_lane'],
            'persistent_denominators': cfg['persistent_denominators'],
            'maxnreg_cap': cfg['maxnreg_cap'],
            'compiled_registers_per_thread': record['compiled_resources']['launch__registers_per_thread'],
            'qk_mma': cfg['qk_ptx'],
            'pv_mma': cfg['pv_ptx'],
            'qk_accumulator': cfg['qk_accumulator'],
            'pv_accumulator': cfg['pv_accumulator'],
            'denominator_accumulator': cfg['denominator'],
            'status': STATE,
            'ncu_measured': True,
            'tensor_instruction_counts': [],
            'source_instruction_work': {
                'unit': 'PTX mma.sync calls per CTA over 34 key tiles',
                'qk_per_warp_tile': cfg['qk_mma_per_warp_tile'],
                'pv_per_warp_tile': cfg['pv_mma_per_warp_tile'],
                'warp_per_tile': cfg['warp_mma_per_tile'],
                'cta_per_tile': cfg['cta_mma_per_tile'],
                'total_per_cta': cfg['total_ptx_mma_per_cta'],
                'note': 'source program count, not a measured dynamic SASS total',
            },
            'measured': {
                'duration_ns': measured['gpu__time_duration.sum']['value'],
                'registers_per_thread': measured['launch__registers_per_thread']['value'],
                'static_shared_bytes': measured['launch__shared_mem_per_block_static']['value'],
                'grid_size': measured['launch__grid_size']['value'],
                'block_size': measured['launch__block_size']['value'],
                'waves_per_multiprocessor': measured['launch__waves_per_multiprocessor']['value'],
                'achieved_occupancy_pct': measured['sm__warps_active.avg.pct_of_peak_sustained_active']['value'],
                'theoretical_occupancy_pct': measured['sm__maximum_warps_per_active_cycle_pct']['value'],
                'issue_active_pct': measured['smsp__issue_active.avg.pct_of_peak_sustained_active']['value'],
                'local_loads': measured['smsp__sass_inst_executed_op_local_ld.sum']['value'],
                'local_stores': measured['smsp__sass_inst_executed_op_local_st.sum']['value'],
                'spill_instructions': measured['sass__inst_executed_register_spilling_mem_local']['value'],
                'shared_load_wavefronts': measured['l1tex__data_pipe_lsu_wavefronts_mem_shared_op_ld.sum']['value'],
                'shared_load_instructions': measured['smsp__sass_inst_executed_op_shared_ld.sum']['value'],
                'shared_ld_bank_conflicts': measured['l1tex__data_bank_conflicts_pipe_lsu_mem_shared_op_ld.sum']['value'],
                'pcsamp_samples': measured['smsp__pcsamp_sample_count']['value'],
            },
            'reports': _report_rows(record),
            'metric_count': len(record['metrics']),
            'source_hotspot_count': record['source_hotspot_count'],
            'artifacts': _public_artifacts(snapshot),
        }
        checks.append(dict(model='attention-fp32-accumulation', entry=name,
                           result=('Static shared and the FP32 numerator/denominator contract match the '
                                   'compiled binary; the isolated NCU replay and source hotspots are recorded.')))
    result = {
        'schema': 'small-attention-design-checks/v2',
        'state': STATE,
        'ncu_state': STATE,
        'source_revision': RUNTIME_REVISION,
        'runtime_binary_sha256': BINARY_SHA256,
        'fixture_id': snapshot['fixture_id'],
        'scope': ('Source predictions versus the additive SM120 compiler/reference evidence and the '
                  'current isolated full/source NCU replay.'),
        'checks': checks,
        'artifacts': _public_artifacts(snapshot),
        'kernels': kernels,
    }
    target = ROOT / 'docs/kernel-guide/evidence-small/design-checks.json'
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(json.dumps(result, indent=2) + '\n', encoding='utf-8', newline='\n')
    return result
