"""Focused CPU tests for the additive FlashLight documentation chapter.

These tests exercise pure token/address math, anchor rejection, evidence
validation and the chapter structure oracle.  They do not run the documentation
builder, do not load CUDA, do not write the public guide and do not create or
mock a Git commit.
"""
from pathlib import Path
import copy
import hashlib
import importlib
import json
import math
import re
import subprocess
import sys
import xml.etree.ElementTree as ET

import pytest

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'tools'))
sys.path.insert(0, str(ROOT / 'tools/kernel_docs'))

import build_kernel_docs
import common
import flashlight
import flashlight_evidence
import runtime_source_revision
import source_providers
import validate_kernel_docs as validator

#: Two real repository commits used by the synthetic acceptance fixtures.  The
#: candidate is a later real commit; no fake commit is ever constructed.
CANDIDATE_COMMIT = '266d69acf52dda413df3a874572f1156461f89ff'
ORIGINAL_COMMIT = source_providers.ORIGINAL_REFERENCE
FFN_SOURCE = ('csrc/kernel_impl/bottleneck_c1024_ffn/fp16/'
              'global_ffn_expand_c1024_fp16.cu')


def _git_text(revision, path):
    raw = subprocess.run(
        ['git', 'cat-file', 'blob', f'{revision}:{path}'], cwd=ROOT,
        capture_output=True, check=True,
    ).stdout
    return raw.decode('utf-8').replace('\r\n', '\n').replace('\r', '\n')


def _sha(data):
    if isinstance(data, str):
        data = data.encode('utf-8')
    return hashlib.sha256(data).hexdigest()


def _write_bundle_file(root, relative, data):
    target = root / relative
    target.parent.mkdir(parents=True, exist_ok=True)
    if isinstance(data, str):
        data = data.encode('utf-8')
    target.write_bytes(data)
    return target


def _make_acceptance_fixture(tmp_path):
    """Create a clearly synthetic acceptance bundle in a temporary directory.

    The numerical values and receipt bytes are test data only; they are never
    written to the repository guide or presented as measurements.  The source
    provenance and candidate/build commits are real existing Git commits.
    """
    root = tmp_path / 'bundle'
    root.mkdir(parents=True)
    artifacts = []

    def add(relative, kind, identity, data):
        _write_bundle_file(root, relative, data)
        ref = {'path': relative, 'sha256': _sha(data)}
        artifacts.append(dict(ref, kind=kind, identity=identity))
        return ref

    build_filename = '_C_sm120.cp311-win_amd64.pyd'
    original_binary_sha = '1' * 64
    candidate_binary_sha = '2' * 64
    original_note = 'Synthetic test receipt records the original build checkout.'
    candidate_note = 'Synthetic test receipt records the frozen dirty build checkout.'
    toolchain = {
        'nvcc_version': 'Cuda compilation tools release 12.8, V12.8.93',
        'nvcc_sha256': '1' * 64,
        'ptxas_version': 'Cuda compilation tools release 13.4, V13.4.59',
        'ptxas_sha256': '2' * 64,
        'cuda_version': '13.4',
        'pytorch_version': '2.8.0',
    }
    original_receipt = add(
        'receipts/original/build-receipt.json', 'build-receipt', 'original',
        json.dumps({
            'schema': flashlight_evidence.BUILD_RECEIPT_SCHEMA,
            'provenance': {
                'basis': 'preserved-receipt',
                'note': original_note,
                'build_time_HEAD': ORIGINAL_COMMIT,
                'dirty': False,
            },
            'binary': {'filename': build_filename, 'sha256': original_binary_sha},
            'toolchain': toolchain,
        }, indent=2) + '\n')
    candidate_receipt = add(
        'receipts/candidate/build-receipt.json', 'build-receipt', 'candidate',
        json.dumps({
            'schema': flashlight_evidence.BUILD_RECEIPT_SCHEMA,
            'provenance': {
                'basis': 'preserved-receipt',
                'note': candidate_note,
                'build_time_HEAD': ORIGINAL_COMMIT,
                'dirty': True,
            },
            'binary': {'filename': build_filename, 'sha256': candidate_binary_sha},
            'toolchain': toolchain,
        }, indent=2) + '\n')
    committed = _git_text(CANDIDATE_COMMIT, FFN_SOURCE)
    normalized = _sha(committed)
    raw_crlf = _sha(committed.replace('\n', '\r\n'))
    blob_oid = subprocess.run(
        ['git', 'rev-parse', f'{CANDIDATE_COMMIT}:{FFN_SOURCE}'], cwd=ROOT,
        capture_output=True, text=True, check=True,
    ).stdout.strip()
    source_row = {
        'path': FFN_SOURCE,
        'raw_file_sha256': raw_crlf,
        'normalized_lf_sha256': normalized,
        'git_blob_oid': blob_oid,
    }
    original_manifest = add(
        'receipts/original/input-manifest.json', 'input-manifest', 'original',
        json.dumps({
            'schema': flashlight_evidence.MEASURED_MANIFEST_SCHEMA,
            'files': [{
                'path': FFN_SOURCE,
                'raw_file_sha256': '3' * 64,
                'normalized_lf_sha256': '4' * 64,
            }],
        }, indent=2) + '\n')
    candidate_manifest = add(
        'receipts/candidate/input-manifest.json', 'input-manifest', 'candidate',
        json.dumps({
            'schema': flashlight_evidence.MEASURED_MANIFEST_SCHEMA,
            'files': [source_row],
        }, indent=2) + '\n')
    timing_receipt = add(
        'receipts/timing/paired.json', 'timing-receipt', 'timing',
        'SYNTHETIC TEST DATA paired timing analyzer report\n')
    check_receipts = {
        category: add(
            f'receipts/checks/{category}.json', 'check-receipt', f'check:{category}',
            json.dumps({'note': f'SYNTHETIC TEST DATA {category} check receipt', 'proof': {}}) + '\n')
        for category in flashlight_evidence.REQUIRED_CHECK_CATEGORIES
    }
    ptxas_log = add(
        'receipts/ptxas/ffn-sm120.log', 'ptxas-log', 'ptxas',
        'SYNTHETIC TEST DATA ptxas -v log\n')
    cuobjdump = add(
        'receipts/cuobjdump/ffn-sm120.txt', 'cuobjdump', 'ptxas',
        'SYNTHETIC TEST DATA cuobjdump resource usage\n')

    original_build = {
        'provenance_basis': 'preserved-receipt',
        'provenance_note': original_note,
        'build_time_HEAD': ORIGINAL_COMMIT,
        'dirty': False,
        'build_receipt': original_receipt,
        'input_manifest': original_manifest,
        'binary_filename': build_filename,
        'binary_sha256': original_binary_sha,
        'toolchain': toolchain,
    }
    candidate_build = {
        'provenance_basis': 'preserved-receipt',
        'provenance_note': candidate_note,
        'build_time_HEAD': ORIGINAL_COMMIT,
        'dirty': True,
        'build_receipt': candidate_receipt,
        'input_manifest': candidate_manifest,
        'binary_filename': build_filename,
        'binary_sha256': candidate_binary_sha,
        'toolchain': toolchain,
    }
    provenance = {
        'manifest': candidate_manifest,
        'files': [dict(source_row)],
    }

    cases = []
    index = 0
    for model in flashlight_evidence.MODELS:
        for precision in flashlight_evidence.PRECISIONS:
            for size, width, height in flashlight_evidence.SIZES:
                base = 10.0 + index
                original_medians = [base + 0.1, base + 0.2, base + 0.3, base + 0.4]
                candidate_medians = [base - 0.2, base - 0.1, base, base + 0.05]
                cases.append({
                    'id': f'{model}-{precision}-{size}',
                    'model': model,
                    'precision': precision,
                    'size': size,
                    'width': width,
                    'height': height,
                    'original': {'process_medians_ms': original_medians},
                    'candidate': {'process_medians_ms': candidate_medians},
                    'uncertainty': {
                        'method': 'process-median min/max range',
                        'original_range_ms': [min(original_medians), max(original_medians)],
                        'candidate_range_ms': [min(candidate_medians), max(candidate_medians)],
                    },
                    'decision': {
                        'status': 'no-detected-slowdown',
                        'rationale': 'Synthetic test fixture only.',
                    },
                })
                index += 1

    checks = [{
        'category': category,
        'status': 'pass',
        'covered_cases': ['all'],
        'receipt': check_receipts[category],
        'summary': f'Synthetic test fixture check: {category}.',
    } for category in flashlight_evidence.REQUIRED_CHECK_CATEGORIES]

    payload = {
        'schema_version': 1,
        'state': 'accepted',
        'acceptance_id': 'flashlight-synthetic-test-fixture',
        'original_source_revision': ORIGINAL_COMMIT,
        'candidate_source_revision': CANDIDATE_COMMIT,
        'original_build': original_build,
        'candidate_build': candidate_build,
        'source_provenance': provenance,
        'environment': {
            'gpu_name': 'Synthetic test GPU',
            'gpu_uuid': 'GPU-SYNTHETIC-TEST-ONLY',
            'driver': '000.00',
            'cuda': '13.4',
            'pytorch': '2.8.0',
            'timing_method': 'Synthetic test timing method (not a measurement)',
            'seed': 3108,
            'warmup': 20,
            'samples': 30,
            'iterations': 10,
            'rounds': 2,
            'methodology': 'Synthetic test fixture only; root owns real measurements.',
        },
        'protocol': {
            'child_processes_per_case': 8,
            'original_processes': 4,
            'candidate_processes': 4,
            'process_order': ['original', 'candidate', 'candidate', 'original',
                              'candidate', 'original', 'original', 'candidate'],
            'methodology': 'Synthetic ABBA/BAAB paired test protocol.',
        },
        'timing': {
            'receipt': timing_receipt,
            'decision': {
                'status': 'accepted',
                'methodology': 'Synthetic test decision metadata.',
                'rationale': 'Synthetic test fixture only.',
            },
            'cases': cases,
        },
        'checks': checks,
        'ptxas': {
            'rows': [{
                'architecture': 'SM120',
                'kernel': 'global_ffn_expand_c1024_fp16',
                'sm_target': 'sm_120',
                'registers_per_thread': 140,
                'static_shared_bytes': 24600,
                'spill_bytes': 0,
                'log': ptxas_log,
            }],
            'cuobjdump': cuobjdump,
            'cuobjdump_reserved_bytes': 1024,
        },
        'ncu': {
            'state': 'absent',
            'reason': 'Synthetic test fixture has no NCU run.',
        },
        'limitations': [
            'Synthetic unit fixture; never published as a measurement.',
            'No current NCU counter evidence is attached.',
        ],
        'decision': {
            'status': 'accepted',
            'rationale': 'Synthetic test fixture only; root owns final acceptance.',
        },
        'artifacts': artifacts,
    }
    path = root / 'acceptance.json'
    path.write_text(json.dumps(payload, indent=2) + '\n', encoding='utf-8', newline='\n')
    return path, payload, root


def _load_fixture(tmp_path):
    path, payload, root = _make_acceptance_fixture(tmp_path)
    acceptance = flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)
    return acceptance, payload, path, root


def _guide_for_acceptance(base, acceptance):
    """Build the minimal generated current page plus manifest for validation."""
    guide = base / 'guide'
    flashlight_evidence.copy_acceptance_bundle(
        acceptance, guide / 'evidence-flashlight')
    page = guide / 'flashlight.html'
    page.write_text(
        '<article class="content">'
        + flashlight._acceptance_html(acceptance)
        + flashlight._evidence_html(acceptance)
        + '</article>', encoding='utf-8', newline='\n')
    manifest = {
        'refactor_source_revision': CANDIDATE_COMMIT,
        'flashlight_evidence': {
            'path': 'evidence-flashlight/acceptance.json',
            'sha256': acceptance.sha256,
            'acceptance_id': acceptance.acceptance_id,
            'schema_version': 1,
            'state': 'accepted',
            'original_source_revision': ORIGINAL_COMMIT,
            'candidate_source_revision': CANDIDATE_COMMIT,
            'artifacts': [dict(path=artifact.path, sha256=artifact.sha256,
                               kind=artifact.kind, identity=artifact.identity)
                          for artifact in acceptance.artifacts],
            'case_rows_sha256': acceptance.case_rows_sha256(),
            'gate_rows_sha256': acceptance.gate_rows_sha256(),
        },
        'flashlight_chapter': {
            'evidence_sha256': acceptance.sha256,
            'evidence_acceptance_id': acceptance.acceptance_id,
            'candidate_source_revision': CANDIDATE_COMMIT,
            'evidence_case_rows_sha256': acceptance.case_rows_sha256(),
            'evidence_gate_rows_sha256': acceptance.gate_rows_sha256(),
            'evidence_artifacts': [dict(path=artifact.path, sha256=artifact.sha256,
                                        kind=artifact.kind, identity=artifact.identity)
                                   for artifact in acceptance.artifacts],
        },
    }
    return guide, page, manifest


def _case_row_cells(row):
    assert row.startswith('<tr>') and row.endswith('</tr>')
    parts = row[len('<tr>'):-len('</tr>')].split('<td>')
    assert parts[0] == ''
    return parts[1:]


def _swap_case_row_values(html, first_id, second_id):
    """Swap the visible values of two rows while leaving their case ids in place."""
    pattern = re.compile(r'<tr><td><span data-case="([^"]+)"[^>]*>.*?</tr>', re.S)
    rows = {match.group(1): match.group(0) for match in pattern.finditer(html)}
    first = _case_row_cells(rows[first_id])
    second = _case_row_cells(rows[second_id])
    first_new = '<tr>' + ''.join(
        '<td>' + cell for cell in [first[0]] + second[1:]) + '</tr>'
    second_new = '<tr>' + ''.join(
        '<td>' + cell for cell in [second[0]] + first[1:]) + '</tr>'
    return (html.replace(rows[first_id], first_new)
                .replace(rows[second_id], second_new))


def _rewrite_payload(path, payload):
    path.write_text(json.dumps(payload, indent=2, allow_nan=True) + '\n',
                    encoding='utf-8', newline='\n')
    return path


def _refresh_artifact_refs(node, relative, digest):
    if isinstance(node, dict):
        if node.get('path') == relative and 'sha256' in node:
            node['sha256'] = digest
        for value in node.values():
            _refresh_artifact_refs(value, relative, digest)
    elif isinstance(node, list):
        for value in node:
            _refresh_artifact_refs(value, relative, digest)


def _replace_artifact(root, payload, relative, data):
    """Rewrite a fixture artifact and keep every fixture reference consistent."""
    target = _write_bundle_file(root, relative, data)
    digest = _sha(target.read_bytes())
    for entry in payload['artifacts']:
        if entry['path'] == relative:
            entry['sha256'] = digest
    _refresh_artifact_refs(payload, relative, digest)
    return digest


def _rewrite_candidate_manifest(root, payload, mutate):
    """Mutate the candidate manifest and mirror the change into the source rows."""
    relative = payload['candidate_build']['input_manifest']['path']
    document = json.loads((root / relative).read_text(encoding='utf-8'))
    mutate(document)
    payload['source_provenance']['files'] = copy.deepcopy(document['files'])
    _replace_artifact(root, payload, relative,
                      json.dumps(document, indent=2) + '\n')


def _rewrite_build_receipt(root, payload, role, *, basis, note, head, dirty,
                           filename=None, sha256=None):
    build = payload[f'{role}_build']
    relative = build['build_receipt']['path']
    document = json.loads((root / relative).read_text(encoding='utf-8'))
    document['provenance'] = {
        'basis': basis,
        'note': note,
        'build_time_HEAD': head,
        'dirty': dirty,
    }
    if filename is not None:
        document['binary']['filename'] = filename
    if sha256 is not None:
        document['binary']['sha256'] = sha256
    _replace_artifact(root, payload, relative,
                      json.dumps(document, indent=2) + '\n')


def _rewrite_build_toolchain(root, payload, role, toolchain):
    """Bind a build receipt and its acceptance record to the same toolchain object."""
    build = payload[f'{role}_build']
    build['toolchain'] = copy.deepcopy(toolchain)
    relative = build['build_receipt']['path']
    document = json.loads((root / relative).read_text(encoding='utf-8'))
    document['toolchain'] = copy.deepcopy(toolchain)
    _replace_artifact(root, payload, relative,
                      json.dumps(document, indent=2) + '\n')


def _svg(index, title=None):
    return (f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 10 10" role="img">'
            f'<title>figure {index if title is None else title}</title>'
            f'<desc>figure description {index}</desc></svg>')


def _valid_body():
    parts = []
    for index, ident in enumerate(flashlight.SECTION_IDS):
        heading = f'{index}. Section'
        narrative = 'Narrative text.'
        if ident == 'resources':
            heading = '4. Resource budget: shared bytes and registers'
            narrative = ('24,600 shared bytes, a declared register payload and a separate '
                         'ptxas allocation.')
        parts.append(f'<h2 id="{ident}">{heading}</h2>')
        parts.append(f'<h3 id="{ident}-detail">Detail</h3>')
        parts.append(f'<p>{narrative}</p>')
    parts.extend(_svg(index) for index in range(flashlight.MIN_DIAGRAMS))
    parts.append('<h3 id="trace-acceptance">Accepted runtime evidence</h3>')
    parts.append('<h3 id="trace-checks">Receipt-backed checks</h3>')
    parts.append('<h3 id="trace-provenance">Identity and artifacts</h3>')
    parts.append('<a href="architecture.html">architecture</a>')
    parts.append('<a href="global_ffn_expand_c1024_fp16.html">historical lesson</a>')
    return "".join(parts)


def test_import_does_not_register_or_read_source(monkeypatch):
    before = list(common.CURRENT_SNIPPETS)
    calls = []
    monkeypatch.setattr(common, 'code', lambda *args, **kwargs: calls.append(args))

    def _no_read(*args, **kwargs):
        raise AssertionError('chapter import must not read a source file')

    monkeypatch.setattr(Path, 'read_text', _no_read)
    importlib.reload(flashlight)
    assert calls == []
    assert common.CURRENT_SNIPPETS == before
    assert flashlight.SECTION_IDS == ('problem', 'cta', 'warp', 'resources',
                                      'schedule', 'trace')
    monkeypatch.undo()
    importlib.reload(flashlight)


def test_worked_trace_exact_coordinates():
    fragment = flashlight.ffn_input_fragment(37, 146)
    assert fragment['token_group'] == 2
    assert fragment['local_row'] == 5
    assert fragment['iteration'] == 4
    assert fragment['k_sub'] == 1
    assert fragment['local_k'] == 2
    assert (fragment['producer_warp'], fragment['copy_group']) == (2, 0)
    assert fragment['lane'] == 21
    assert (fragment['word'], fragment['half']) == ('x', 'low')
    assert fragment['relative'] == 848
    assert fragment['global_slab'] == 69632
    assert fragment['shared_slab'] == 10240
    assert fragment['global_byte'] == 70480
    assert fragment['shared_byte'] == 11088
    assert flashlight.shared_lane_byte(1, 2, 0, 1, 21) == 11088

    weight = flashlight.ffn_weight_fragment(146, 81)
    assert weight['panel'] == 9
    assert weight['n16_group'] == 1
    assert weight['lane'] == 5
    assert (weight['word'], weight['half']) == ('x', 'low')
    assert weight['relative'] == 80
    assert weight['global_byte'] == 1182288

    output = flashlight.ffn_output_location(37, 81)
    assert output['warp'] == 1
    assert output['m_fragment'] == 2
    assert output['n16_group'] == 1
    assert (output['lane'], output['word'], output['half']) == (20, 0, 'high')
    assert output['uint4_start'] == 265024
    assert output['byte'] == 265026


def test_a_fragment_packs_two_tokens_and_four_channels():
    coordinates = flashlight.a_uint4_coordinates(21, 32, 144)
    assert coordinates == [
        ('x', 37, 146, 147),
        ('y', 45, 146, 147),
        ('z', 37, 154, 155),
        ('w', 45, 154, 155),
    ]


def test_b_uint4_carries_adjacent_n8_fragments():
    coordinates = flashlight.b_uint4_coordinates(5, 80, 144)
    assert coordinates == [
        ('x', 81, 146, 147),
        ('y', 81, 154, 155),
        ('z', 89, 146, 147),
        ('w', 89, 154, 155),
    ]


def test_lane_fragment_derivations():
    a = flashlight.mma_a_lane_map(21)
    assert (a['group'], a['thread']) == (5, 1)
    assert a['rows'] == (5, 13)
    assert a['k'] == (2, 3, 10, 11)
    b = flashlight.mma_b_lane_map(5)
    assert (b['group'], b['thread'], b['column']) == (1, 1, 1)
    assert b['k'] == (2, 3, 10, 11)
    c = flashlight.mma_c_lane_map(20)
    assert (c['group'], c['thread']) == (5, 0)
    assert c['rows'] == (5, 13)
    assert c['columns'] == (0, 1)


def test_static_shared_budget_is_source_byte_arithmetic():
    assert flashlight.STAGE_BYTES == 8192
    assert flashlight.STAGE_COUNT == 3
    assert flashlight.BARRIER_BASE == 24576
    assert flashlight.SHARED_BYTES == 24600
    assert flashlight.shared_slot_base(0) == 0
    assert flashlight.shared_slot_base(1) == 8192
    assert flashlight.shared_slot_base(2) == 16384


def test_anchor_span_requires_a_unique_exact_match():
    assert flashlight._anchor_span('a\nb\nc\n', 'b') == (2, 2)
    with pytest.raises(flashlight.ChapterError):
        flashlight._anchor_span('a\nb\n', 'missing')
    with pytest.raises(flashlight.ChapterError):
        flashlight._anchor_span('a\na\n', 'a')
    with pytest.raises(flashlight.ChapterError):
        flashlight._anchor_span('a\n', '')


def test_chapter_structure_oracle_accepts_and_rejects():
    body = _valid_body()
    flashlight.validate_chapter_body(body)

    with pytest.raises(flashlight.ChapterError):
        flashlight.validate_chapter_body(
            body.replace('<h2 id="trace">5. Section</h2>', ''))
    with pytest.raises(flashlight.ChapterError):
        flashlight.validate_chapter_body(
            body.replace('<desc>figure description 0</desc>', ''))
    with pytest.raises(flashlight.ChapterError):
        flashlight.validate_chapter_body(
            body.replace('<title>figure 1</title>', '<title>figure 0</title>'))
    with pytest.raises(flashlight.ChapterError):
        flashlight.validate_chapter_body(
            body.replace('<h3 id="cta-detail">Detail</h3>', ''))
    with pytest.raises(flashlight.ChapterError):
        flashlight.validate_chapter_body(
            body.replace('24,600 shared bytes', 'the shared bytes'))
    with pytest.raises(flashlight.ChapterError):
        flashlight.validate_chapter_body(
            body.replace('4. Resource budget: shared bytes and registers',
                         '4. Responsibilities and dependency direction'))


def test_build_chapter_rejects_non_current_providers_before_reading():
    with pytest.raises(flashlight.ChapterError):
        flashlight.build_chapter(None)
    with pytest.raises(flashlight.ChapterError):
        flashlight.build_chapter(source_providers.ORIGINAL)
    assert common.CURRENT_SNIPPETS == []


def test_build_chapter_rejects_a_duck_typed_worktree_provider():
    class WorktreeProvider:
        name = 'current'
        revision = 'a' * 40

        def exists(self, path):
            return True

        def text(self, path):
            raise AssertionError('a rejected provider must never be read')

    with pytest.raises(flashlight.ChapterError, match='source_providers.Provider'):
        flashlight.build_chapter(WorktreeProvider())
    assert common.CURRENT_SNIPPETS == []


def test_require_current_provider_checks_class_name_and_real_commit():
    real = source_providers.Provider('current', source_providers.ORIGINAL_REFERENCE)
    assert flashlight._require_current_provider(real) == source_providers.ORIGINAL_REFERENCE
    with pytest.raises(flashlight.ChapterError):
        flashlight._require_current_provider(source_providers.ORIGINAL)
    absent = source_providers.Provider('current', 'f' * 40)
    with pytest.raises(flashlight.ChapterError, match='not a real repository commit'):
        flashlight._require_current_provider(absent)


def test_worktree_preflight_is_anchor_only_and_never_emits_source(tmp_path):
    path = 'csrc/example.cuh'
    target = tmp_path / path
    target.parent.mkdir(parents=True)
    target.write_text('header\nneedle\n', encoding='utf-8')
    anchors = {'example': (path, 'needle')}
    before = list(common.CURRENT_SNIPPETS)
    assert flashlight.preflight_worktree_anchors(tmp_path, anchors) == []
    assert common.CURRENT_SNIPPETS == before

    target.write_text('needle\nneedle\n', encoding='utf-8')
    problems = flashlight.preflight_worktree_anchors(tmp_path, anchors)
    assert any('occurs 2 times' in problem for problem in problems)
    assert common.CURRENT_SNIPPETS == before


def test_ptxas_only_sketch_is_not_runtime_acceptance():
    row = {'architecture': 'SM120', 'registers_per_thread': 140,
           'shared_bytes': 24600, 'spill_bytes': 0}
    with pytest.raises(flashlight.EvidenceError, match='ptxas-only'):
        flashlight._validated_evidence(
            {'revision': ORIGINAL_COMMIT, 'state': 'accepted', 'ptxas': [row]},
            ORIGINAL_COMMIT)
    with pytest.raises(flashlight.EvidenceError):
        flashlight._validated_evidence(
            {'revision': ORIGINAL_COMMIT, 'state': 'pending', 'ptxas': [row]},
            ORIGINAL_COMMIT)


def test_full_acceptance_schema_and_derived_rows(tmp_path):
    acceptance, payload, path, _ = _load_fixture(tmp_path)
    assert acceptance.schema_version == 1
    assert acceptance.state == 'accepted'
    assert acceptance.candidate_source_revision == CANDIDATE_COMMIT
    assert acceptance.original_source_revision == ORIGINAL_COMMIT
    assert len(acceptance.timing.cases) == 16
    assert len({case.id for case in acceptance.timing.cases}) == 16
    assert len(acceptance.artifacts) == len(payload['artifacts'])
    assert acceptance.ptxas.cuobjdump_reserved_bytes == 1024
    assert acceptance.ptxas.rows[0].static_shared_bytes == 24600
    assert acceptance.ncu.state == 'absent'
    assert acceptance.sha256 == _sha(path.read_bytes())
    for case in acceptance.timing.cases:
        assert len(case.original_process_medians_ms) == 4
        assert len(case.candidate_process_medians_ms) == 4
        assert case.original_range_ms == (min(case.original_process_medians_ms),
                                         max(case.original_process_medians_ms))
        assert case.candidate_range_ms == (min(case.candidate_process_medians_ms),
                                          max(case.candidate_process_medians_ms))
        assert case.original_median_ms == pytest.approx(
            sum(case.original_process_medians_ms) / 4)
        assert case.speedup == pytest.approx(
            case.original_median_ms / case.candidate_median_ms)
    provenance = acceptance.provenance_files[0]
    assert provenance.raw_file_sha256 != provenance.normalized_lf_sha256
    assert provenance.git_blob_oid is not None
    assert acceptance.provenance_manifest == acceptance.candidate_build.input_manifest
    assert acceptance.provenance_files == acceptance.candidate_build.input_files
    assert acceptance.original_build.build_receipt.kind == 'build-receipt'
    assert acceptance.candidate_build.build_receipt.kind == 'build-receipt'
    assert acceptance.original_build.input_manifest.kind == 'input-manifest'
    assert all(artifact.kind != 'binary' for artifact in acceptance.artifacts)


def test_acceptance_rejects_pending_wrong_state_and_revision(tmp_path):
    path, payload, _ = _make_acceptance_fixture(tmp_path)
    for mutate in (
            lambda value: value.__setitem__('state', 'development'),
            lambda value: value.__setitem__('schema_version', 2),
            lambda value: value.__setitem__('candidate_source_revision', 'f' * 40),
            lambda value: value.__setitem__('original_source_revision',
                                            'fc3276497f866bdad639cd443e75743f5d19b749'),
            lambda value: value.__setitem__('candidate_source_revision', ORIGINAL_COMMIT),
            lambda value: value['candidate_build'].__setitem__('dirty', False),
            lambda value: value['candidate_build'].__setitem__(
                'build_time_HEAD', CANDIDATE_COMMIT),
            lambda value: value['candidate_build'].__setitem__(
                'provenance_basis', 'inferred'),
            lambda value: value['original_build'].__setitem__(
                'provenance_basis', 'unknown')):
        mutated = copy.deepcopy(payload)
        mutate(mutated)
        _rewrite_payload(path, mutated)
        with pytest.raises(flashlight_evidence.EvidenceError):
            flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)


def test_original_build_facts_are_recorded_not_forced(tmp_path):
    # The frozen source-replay revision and the original binary's build checkout
    # are different facts.  A real, differently recorded checkout and dirty state
    # must be preserved rather than rejected or rewritten to e2741a7.
    honest_note = 'Inferred from a preserved log; not receipt-verified.'
    path, payload, root = _make_acceptance_fixture(tmp_path / 'honest')
    honest = copy.deepcopy(payload)
    honest['original_build'].update({
        'provenance_basis': 'inferred',
        'provenance_note': honest_note,
        'build_time_HEAD': source_providers.LEGACY_REVISION,
        'dirty': True,
    })
    _rewrite_build_receipt(root, honest, 'original', basis='inferred',
                           note=honest_note,
                           head=source_providers.LEGACY_REVISION, dirty=True)
    _rewrite_payload(path, honest)
    acceptance = flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)
    assert acceptance.original_build.build_time_head == source_providers.LEGACY_REVISION
    assert acceptance.original_build.dirty is True
    assert acceptance.original_build.provenance_basis == 'inferred'
    assert acceptance.original_source_revision == ORIGINAL_COMMIT

    unknown_note = 'No preserved original build receipt records this checkout.'
    path, payload, root = _make_acceptance_fixture(tmp_path / 'unknown')
    unknown = copy.deepcopy(payload)
    unknown['original_build'].update({
        'provenance_basis': 'unknown',
        'provenance_note': unknown_note,
        'build_time_HEAD': None,
        'dirty': None,
    })
    _rewrite_build_receipt(root, unknown, 'original', basis='unknown',
                           note=unknown_note, head=None, dirty=None)
    _rewrite_payload(path, unknown)
    acceptance = flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)
    assert acceptance.original_build.build_time_head is None
    assert acceptance.original_build.dirty is None

    path, payload, root = _make_acceptance_fixture(tmp_path / 'invented')
    invented = copy.deepcopy(payload)
    invented['original_build']['provenance_basis'] = 'unknown'
    _rewrite_build_receipt(root, invented, 'original', basis='unknown',
                           note='Synthetic note', head=ORIGINAL_COMMIT, dirty=False)
    _rewrite_payload(path, invented)
    with pytest.raises(flashlight_evidence.EvidenceError, match='unknown provenance'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    path, payload, root = _make_acceptance_fixture(tmp_path / 'candidate')
    candidate_checkout = copy.deepcopy(payload)
    candidate_checkout['candidate_build']['build_time_HEAD'] = \
        source_providers.LEGACY_REVISION
    _rewrite_build_receipt(
        root, candidate_checkout, 'candidate', basis='preserved-receipt',
        note=candidate_checkout['candidate_build']['provenance_note'],
        head=source_providers.LEGACY_REVISION, dirty=True)
    _rewrite_payload(path, candidate_checkout)
    acceptance = flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)
    assert acceptance.candidate_build.build_time_head == source_providers.LEGACY_REVISION
    assert acceptance.candidate_build.build_time_head != CANDIDATE_COMMIT


def test_unknown_original_build_renders_honestly_and_validates(tmp_path):
    path, payload, root = _make_acceptance_fixture(tmp_path)
    note_text = 'No preserved original build receipt records this checkout.'
    payload['original_build'].update({
        'provenance_basis': 'unknown',
        'provenance_note': note_text,
        'build_time_HEAD': None,
        'dirty': None,
    })
    _rewrite_build_receipt(root, payload, 'original', basis='unknown',
                           note=note_text, head=None, dirty=None)
    _rewrite_payload(path, payload)
    acceptance = flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)
    assert acceptance.original_build.build_time_head is None
    assert acceptance.original_build.dirty is None

    guide = tmp_path / 'guide'
    flashlight_evidence.copy_acceptance_bundle(
        acceptance, guide / 'evidence-flashlight')
    page = guide / 'flashlight.html'
    page.write_text(
        '<article class="content">'
        + flashlight._acceptance_html(acceptance)
        + flashlight._evidence_html(acceptance)
        + '</article>', encoding='utf-8', newline='\n')
    manifest = {
        'refactor_source_revision': CANDIDATE_COMMIT,
        'flashlight_evidence': {
            'path': 'evidence-flashlight/acceptance.json',
            'sha256': acceptance.sha256,
            'acceptance_id': acceptance.acceptance_id,
            'schema_version': 1,
            'state': 'accepted',
            'original_source_revision': ORIGINAL_COMMIT,
            'candidate_source_revision': CANDIDATE_COMMIT,
            'artifacts': [dict(path=artifact.path, sha256=artifact.sha256,
                               kind=artifact.kind, identity=artifact.identity)
                          for artifact in acceptance.artifacts],
            'case_rows_sha256': acceptance.case_rows_sha256(),
            'gate_rows_sha256': acceptance.gate_rows_sha256(),
        },
        'flashlight_chapter': {
            'evidence_sha256': acceptance.sha256,
            'evidence_acceptance_id': acceptance.acceptance_id,
            'candidate_source_revision': CANDIDATE_COMMIT,
            'evidence_case_rows_sha256': acceptance.case_rows_sha256(),
            'evidence_gate_rows_sha256': acceptance.gate_rows_sha256(),
            'evidence_artifacts': [dict(path=artifact.path, sha256=artifact.sha256,
                                        kind=artifact.kind, identity=artifact.identity)
                                   for artifact in acceptance.artifacts],
        },
    }
    assert validator.check_flashlight_evidence(
        guide, manifest, {page: None}) == []
    body = page.read_text(encoding='utf-8')
    assert 'unknown (not recorded)' in body
    assert 'No preserved original build receipt records this checkout.' in body
    assert not list(guide.rglob('*.pyd'))
    stray = guide / 'evidence-flashlight' / 'stray.pyd'
    stray.write_bytes(b'not a portable public receipt')
    errors = validator.check_flashlight_evidence(guide, manifest, {page: None})
    assert any('payloads' in message for message in errors)
    stray.unlink()


def test_acceptance_rejects_duplicate_and_missing_cases(tmp_path):
    path, payload, _ = _make_acceptance_fixture(tmp_path)
    duplicate = copy.deepcopy(payload)
    duplicate['timing']['cases'].append(copy.deepcopy(duplicate['timing']['cases'][0]))
    _rewrite_payload(path, duplicate)
    with pytest.raises(flashlight_evidence.EvidenceError, match='exactly 16'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    duplicate_id = copy.deepcopy(payload)
    duplicate_id['timing']['cases'][1] = copy.deepcopy(duplicate_id['timing']['cases'][0])
    _rewrite_payload(path, duplicate_id)
    with pytest.raises(flashlight_evidence.EvidenceError, match='duplicate timing case'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    missing = copy.deepcopy(payload)
    missing['timing']['cases'].pop()
    _rewrite_payload(path, missing)
    with pytest.raises(flashlight_evidence.EvidenceError):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    wrong_size = copy.deepcopy(payload)
    wrong_size['timing']['cases'][0]['width'] = 1920
    _rewrite_payload(path, wrong_size)
    with pytest.raises(flashlight_evidence.EvidenceError, match='must have exactly'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)


def test_acceptance_rejects_nonfinite_times_and_wrong_process_counts(tmp_path):
    path, payload, _ = _make_acceptance_fixture(tmp_path)
    nonfinite = copy.deepcopy(payload)
    nonfinite['timing']['cases'][0]['original']['process_medians_ms'][0] = math.nan
    _rewrite_payload(path, nonfinite)
    with pytest.raises(flashlight_evidence.EvidenceError, match='finite'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    short_arm = copy.deepcopy(payload)
    short_arm['timing']['cases'][0]['candidate']['process_medians_ms'].pop()
    _rewrite_payload(path, short_arm)
    with pytest.raises(flashlight_evidence.EvidenceError, match='exactly 4'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    wrong_children = copy.deepcopy(payload)
    wrong_children['protocol']['child_processes_per_case'] = 7
    _rewrite_payload(path, wrong_children)
    with pytest.raises(flashlight_evidence.EvidenceError, match='8 child processes'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    wrong_order = copy.deepcopy(payload)
    wrong_order['protocol']['process_order'] = ['original'] * 8
    _rewrite_payload(path, wrong_order)
    with pytest.raises(flashlight_evidence.EvidenceError, match='four original'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    unpaired = copy.deepcopy(payload)
    unpaired['protocol']['process_order'] = ['original'] * 4 + ['candidate'] * 4
    _rewrite_payload(path, unpaired)
    with pytest.raises(flashlight_evidence.EvidenceError, match='ABBA/BAAB'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)


def test_acceptance_rejects_inconsistent_uncertainty_and_decision(tmp_path):
    path, payload, _ = _make_acceptance_fixture(tmp_path)
    bad_range = copy.deepcopy(payload)
    bad_range['timing']['cases'][0]['uncertainty']['original_range_ms'] = [0.0, 1.0]
    _rewrite_payload(path, bad_range)
    with pytest.raises(flashlight_evidence.EvidenceError, match='exactly the min/max'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    slowdown = copy.deepcopy(payload)
    slowdown['timing']['cases'][1]['decision']['status'] = 'reproducible-slowdown'
    _rewrite_payload(path, slowdown)
    with pytest.raises(flashlight_evidence.EvidenceError, match='unresolved or reproducible'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    empty_rationale = copy.deepcopy(payload)
    empty_rationale['timing']['decision']['rationale'] = ''
    _rewrite_payload(path, empty_rationale)
    with pytest.raises(flashlight_evidence.EvidenceError):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    mixed_method = copy.deepcopy(payload)
    mixed_method['timing']['cases'][1]['uncertainty']['method'] = 'a different interval'
    _rewrite_payload(path, mixed_method)
    with pytest.raises(flashlight_evidence.EvidenceError, match='same fixed uncertainty'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)


def test_acceptance_rejects_wrong_artifact_hashes_paths_and_files(tmp_path):
    path, payload, root = _make_acceptance_fixture(tmp_path)

    wrong_registry_hash = copy.deepcopy(payload)
    wrong_registry_hash['artifacts'][0]['sha256'] = '0' * 64
    _rewrite_payload(path, wrong_registry_hash)
    with pytest.raises(flashlight_evidence.EvidenceError, match='hash mismatch'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    wrong_ref_hash = copy.deepcopy(payload)
    wrong_ref_hash['checks'][0]['receipt']['sha256'] = '0' * 64
    _rewrite_payload(path, wrong_ref_hash)
    with pytest.raises(flashlight_evidence.EvidenceError, match='hash disagrees'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    escaping = copy.deepcopy(payload)
    escaping['artifacts'][0]['path'] = '../escape.json'
    _rewrite_payload(path, escaping)
    with pytest.raises(flashlight_evidence.EvidenceError, match='escapes'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    absolute = copy.deepcopy(payload)
    absolute['artifacts'][0]['path'] = 'C:/private/receipt.json'
    _rewrite_payload(path, absolute)
    with pytest.raises(flashlight_evidence.EvidenceError):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    _rewrite_payload(path, payload)
    (root / payload['artifacts'][0]['path']).unlink()
    with pytest.raises(flashlight_evidence.EvidenceError, match='missing'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    _write_bundle_file(root, payload['artifacts'][0]['path'], 'corrupt')
    with pytest.raises(flashlight_evidence.EvidenceError, match='hash mismatch'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)


def test_public_registry_rejects_native_payloads_and_build_receipt_mismatch(tmp_path):
    path, payload, root = _make_acceptance_fixture(tmp_path)

    binary_kind = copy.deepcopy(payload)
    binary_kind['artifacts'].append({
        'path': 'receipts/original/binary-record.json',
        'sha256': '0' * 64,
        'kind': 'binary',
        'identity': 'original',
    })
    _rewrite_payload(path, binary_kind)
    with pytest.raises(flashlight_evidence.EvidenceError, match='kind'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    payload_path = copy.deepcopy(payload)
    payload_path['artifacts'].append({
        'path': 'receipts/original/native.pyd',
        'sha256': '0' * 64,
        'kind': 'build-receipt',
        'identity': 'original',
    })
    _rewrite_payload(path, payload_path)
    with pytest.raises(flashlight_evidence.EvidenceError, match='payload'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    mismatched = copy.deepcopy(payload)
    mismatched['candidate_build']['binary_sha256'] = 'f' * 64
    _rewrite_payload(path, mismatched)
    with pytest.raises(flashlight_evidence.EvidenceError, match='build receipt'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    missing_receipt = copy.deepcopy(payload)
    missing_receipt['original_build']['build_receipt']['path'] = \
        'receipts/original/missing-receipt.json'
    _rewrite_payload(path, missing_receipt)
    with pytest.raises(flashlight_evidence.EvidenceError):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)


def test_acceptance_rejects_wrong_provenance_hashes_and_blob_oid(tmp_path):
    # The acceptance rows must cover the complete measured manifest, not an
    # arbitrary subset with one convenient FFN path.
    path, payload, root = _make_acceptance_fixture(tmp_path / 'coverage')
    relative = payload['candidate_build']['input_manifest']['path']
    coverage = copy.deepcopy(payload)
    document = json.loads((root / relative).read_text(encoding='utf-8'))
    document['files'].append({
        'path': 'setup.py',
        'raw_file_sha256': '5' * 64,
        'normalized_lf_sha256': '6' * 64,
    })
    _replace_artifact(root, coverage, relative,
                      json.dumps(document, indent=2) + '\n')
    _rewrite_payload(path, coverage)
    with pytest.raises(flashlight_evidence.EvidenceError, match='must equal'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    path, payload, root = _make_acceptance_fixture(tmp_path / 'normalized')
    bad_norm = copy.deepcopy(payload)
    _rewrite_candidate_manifest(root, bad_norm,
                                lambda value: value['files'][0].__setitem__(
                                    'normalized_lf_sha256', '0' * 64))
    _rewrite_payload(path, bad_norm)
    with pytest.raises(flashlight_evidence.EvidenceError, match='normalized-LF'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    path, payload, root = _make_acceptance_fixture(tmp_path / 'blob')
    bad_oid = copy.deepcopy(payload)
    _rewrite_candidate_manifest(root, bad_oid,
                                lambda value: value['files'][0].__setitem__(
                                    'git_blob_oid', '0' * 40))
    _rewrite_payload(path, bad_oid)
    with pytest.raises(flashlight_evidence.EvidenceError, match='git_blob_oid'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    path, payload, root = _make_acceptance_fixture(tmp_path / 'raw')
    bad_raw = copy.deepcopy(payload)
    bad_raw['source_provenance']['files'][0]['raw_file_sha256'] = 'not-a-hash'
    _rewrite_payload(path, bad_raw)
    with pytest.raises(flashlight_evidence.EvidenceError, match='64-character SHA-256'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    path, payload, root = _make_acceptance_fixture(tmp_path / 'ffn')
    no_ffn = copy.deepcopy(payload)
    _rewrite_candidate_manifest(root, no_ffn,
                                lambda value: value['files'][0].__setitem__(
                                    'path', 'setup.py'))
    _rewrite_payload(path, no_ffn)
    with pytest.raises(flashlight_evidence.EvidenceError, match='C1024 FFN'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    path, payload, root = _make_acceptance_fixture(tmp_path / 'schema')
    bad_schema = copy.deepcopy(payload)
    _rewrite_candidate_manifest(root, bad_schema,
                                lambda value: value.__setitem__('schema', 'opaque'))
    _rewrite_payload(path, bad_schema)
    with pytest.raises(flashlight_evidence.EvidenceError, match='schema'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)


def test_acceptance_rejects_missing_or_failed_required_check(tmp_path):
    path, payload, _ = _make_acceptance_fixture(tmp_path)
    missing = copy.deepcopy(payload)
    missing['checks'] = [check for check in missing['checks']
                         if check['category'] != 'cpu']
    _rewrite_payload(path, missing)
    with pytest.raises(flashlight_evidence.EvidenceError):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    failed = copy.deepcopy(payload)
    failed['checks'][0]['status'] = 'fail'
    _rewrite_payload(path, failed)
    with pytest.raises(flashlight_evidence.EvidenceError, match='failed'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    duplicate = copy.deepcopy(payload)
    duplicate['checks'][1]['category'] = duplicate['checks'][0]['category']
    _rewrite_payload(path, duplicate)
    with pytest.raises(flashlight_evidence.EvidenceError, match='duplicate check'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    narrow_native = copy.deepcopy(payload)
    native = next(check for check in narrow_native['checks']
                  if check['category'] == 'native-bitwise')
    native['covered_cases'] = [narrow_native['timing']['cases'][0]['id']]
    _rewrite_payload(path, narrow_native)
    with pytest.raises(flashlight_evidence.EvidenceError, match='all 16'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)


def test_check_coverage_is_native_strict_and_category_specific_elsewhere(tmp_path):
    path, payload, _ = _make_acceptance_fixture(tmp_path)
    labels = {
        'cpu': ['cpu-suite:cpu-only', 'setup-import-smoke'],
        'training': ['small-fixture-training:legacy71-fp16'],
        'primitives': ['activation-clamp-fp16', 'packed-half-fma'],
    }
    labelled = copy.deepcopy(payload)
    for check in labelled['checks']:
        if check['category'] in labels:
            check['covered_cases'] = labels[check['category']]
    _rewrite_payload(path, labelled)
    acceptance = flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)
    by_category = {check.category: check.covered_cases
                   for check in acceptance.checks}
    for category, expected in labels.items():
        assert by_category[category] == tuple(expected)
    assert by_category['native-bitwise'] == ('all',)

    guide, page, manifest = _guide_for_acceptance(tmp_path / 'labelled', acceptance)
    assert validator.check_flashlight_evidence(guide, manifest, {page: None}) == []
    html = page.read_text(encoding='utf-8')
    assert 'Recorded coverage' in html
    assert 'Actual covered cases' not in html
    assert 'cpu-suite:cpu-only' in html
    assert 'small-fixture-training:legacy71-fp16' in html
    assert 'activation-clamp-fp16' in html

    # Native bitwise may not narrow to a subset, invent a label, or mix 'all'.
    for bad_cases in (
            [labelled['timing']['cases'][0]['id']],
            ['native-case-that-does-not-exist'],
            ['all', labelled['timing']['cases'][0]['id']]):
        broken = copy.deepcopy(labelled)
        native = next(check for check in broken['checks']
                      if check['category'] == 'native-bitwise')
        native['covered_cases'] = bad_cases
        _rewrite_payload(path, broken)
        with pytest.raises(flashlight_evidence.EvidenceError,
                           match='native|all 16|explicit labels'):
            flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    duplicate = copy.deepcopy(labelled)
    cpu = next(check for check in duplicate['checks']
               if check['category'] == 'cpu')
    cpu['covered_cases'] = ['cpu-suite:cpu-only', 'cpu-suite:cpu-only']
    _rewrite_payload(path, duplicate)
    with pytest.raises(flashlight_evidence.EvidenceError, match='duplicates'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)


def test_build_receipt_binds_toolchain_identity(tmp_path):
    path, payload, root = _make_acceptance_fixture(tmp_path)
    acceptance = flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)
    for role in ('original', 'candidate'):
        build = getattr(acceptance, f'{role}_build')
        receipt = json.loads(
            (root / build.build_receipt.path).read_text(encoding='utf-8'))
        assert receipt['toolchain'] == payload[f'{role}_build']['toolchain']
        assert build.toolchain == payload[f'{role}_build']['toolchain']
    html = flashlight._acceptance_html(acceptance) + flashlight._evidence_html(acceptance)
    assert payload['candidate_build']['toolchain']['nvcc_sha256'] in html
    assert payload['candidate_build']['toolchain']['ptxas_sha256'] in html

    relative = payload['candidate_build']['build_receipt']['path']
    document = json.loads((root / relative).read_text(encoding='utf-8'))
    document['toolchain']['pytorch_version'] = '9.9.9'
    _replace_artifact(root, payload, relative, json.dumps(document, indent=2) + '\n')
    _rewrite_payload(path, payload)
    with pytest.raises(flashlight_evidence.EvidenceError, match='toolchain identity'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    path, payload, root = _make_acceptance_fixture(tmp_path / 'acceptance-side')
    payload['candidate_build']['toolchain'] = dict(
        payload['candidate_build']['toolchain'], cuda_version='99.9')
    _rewrite_payload(path, payload)
    with pytest.raises(flashlight_evidence.EvidenceError, match='toolchain identity'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    path, payload, root = _make_acceptance_fixture(tmp_path / 'missing')
    relative = payload['original_build']['build_receipt']['path']
    document = json.loads((root / relative).read_text(encoding='utf-8'))
    del document['toolchain']
    _replace_artifact(root, payload, relative, json.dumps(document, indent=2) + '\n')
    _rewrite_payload(path, payload)
    with pytest.raises(flashlight_evidence.EvidenceError, match='missing keys'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)


def test_original_unknown_toolchain_nulls_require_field_specific_qualification(tmp_path):
    # A null historical toolchain fact is not an invitation to borrow a current
    # value.  Without a field-specific qualification it is refused.
    path, payload, root = _make_acceptance_fixture(tmp_path / 'unqualified')
    original = copy.deepcopy(payload['original_build']['toolchain'])
    original.update({
        'nvcc_version': '12.8.93',
        'nvcc_sha256': None,
        'ptxas_version': '13.4',
        'ptxas_sha256': None,
        'cuda_version': '12.8',
        'pytorch_version': None,
    })
    _rewrite_build_toolchain(root, payload, 'original', original)
    _rewrite_payload(path, payload)
    with pytest.raises(flashlight_evidence.EvidenceError,
                       match='field-specific qualification'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    # A qualification must name the exact field; qualifying the two hashes does
    # not license an unqualified null build-time PyTorch version.
    path, payload, root = _make_acceptance_fixture(tmp_path / 'partial')
    partial = copy.deepcopy(original)
    partial['qualifications'] = {
        'nvcc_sha256': 'not recorded by the preserved original link receipt',
        'ptxas_sha256': 'not recorded by the preserved original link receipt',
    }
    _rewrite_build_toolchain(root, payload, 'original', partial)
    _rewrite_payload(path, payload)
    with pytest.raises(flashlight_evidence.EvidenceError,
                       match='pytorch_version is null'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    # Explicit, per-field qualifications are accepted, stay null, and are bound
    # to the same public build receipt.
    path, payload, root = _make_acceptance_fixture(tmp_path / 'qualified')
    qualified = copy.deepcopy(partial)
    qualified['qualifications']['pytorch_version'] = (
        'baseline runtime pip_freeze is measurement-time, not build-time')
    _rewrite_build_toolchain(root, payload, 'original', qualified)
    _rewrite_payload(path, payload)
    acceptance = flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)
    assert acceptance.original_build.toolchain == qualified
    assert acceptance.original_build.toolchain['nvcc_sha256'] is None
    assert acceptance.original_build.toolchain['ptxas_sha256'] is None
    assert acceptance.original_build.toolchain['pytorch_version'] is None
    assert acceptance.original_build.toolchain['ptxas_version'] == '13.4'
    assert acceptance.original_build.toolchain['nvcc_sha256'] != \
        acceptance.candidate_build.toolchain['nvcc_sha256']
    receipt = json.loads(
        (root / payload['original_build']['build_receipt']['path']).read_text(
            encoding='utf-8'))
    assert receipt['toolchain'] == qualified
    html = flashlight._acceptance_html(acceptance) + flashlight._evidence_html(acceptance)
    assert html.count('unknown (not recorded)') >= 4
    assert qualified['qualifications']['nvcc_sha256'] in html
    assert qualified['qualifications']['pytorch_version'] in html
    assert acceptance.candidate_build.toolchain['nvcc_sha256'] in html
    assert 'None' not in html

    # The receipt parser is role-aware too: removing a required field
    # qualification from the receipt alone is refused, not silently accepted.
    relative = payload['original_build']['build_receipt']['path']
    document = json.loads((root / relative).read_text(encoding='utf-8'))
    del document['toolchain']['qualifications']['pytorch_version']
    _replace_artifact(root, payload, relative,
                      json.dumps(document, indent=2) + '\n')
    _rewrite_payload(path, payload)
    with pytest.raises(flashlight_evidence.EvidenceError,
                       match='pytorch_version is null'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    # Mutating only the receipt's null to a concrete candidate-like hash breaks
    # the receipt/acceptance binding instead of silently replacing history.
    _rewrite_build_toolchain(root, payload, 'original', qualified)
    relative = payload['original_build']['build_receipt']['path']
    document = json.loads((root / relative).read_text(encoding='utf-8'))
    document['toolchain']['nvcc_sha256'] = 'f' * 64
    _replace_artifact(root, payload, relative,
                      json.dumps(document, indent=2) + '\n')
    _rewrite_payload(path, payload)
    with pytest.raises(flashlight_evidence.EvidenceError,
                       match='toolchain identity'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)


def test_candidate_toolchain_nulls_are_rejected(tmp_path):
    path, payload, root = _make_acceptance_fixture(tmp_path)
    candidate = copy.deepcopy(payload['candidate_build']['toolchain'])
    candidate.update({
        'nvcc_sha256': None,
        'ptxas_sha256': None,
        'pytorch_version': None,
        'qualifications': {
            'nvcc_sha256': 'not a valid candidate qualification',
            'ptxas_sha256': 'not a valid candidate qualification',
            'pytorch_version': 'not a valid candidate qualification',
        },
    })
    _rewrite_build_toolchain(root, payload, 'candidate', candidate)
    _rewrite_payload(path, payload)
    with pytest.raises(flashlight_evidence.EvidenceError,
                       match='candidate build'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    # Candidate values must remain concrete even when only a qualifications
    # annotation is supplied.
    path, payload, root = _make_acceptance_fixture(tmp_path / 'annotation')
    annotated = copy.deepcopy(payload['candidate_build']['toolchain'])
    annotated['qualifications'] = {
        'nvcc_sha256': 'annotation-only block is not a candidate weakening'}
    _rewrite_build_toolchain(root, payload, 'candidate', annotated)
    _rewrite_payload(path, payload)
    with pytest.raises(flashlight_evidence.EvidenceError,
                       match='only valid for the original'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    # A null in the candidate receipt alone is also refused by the shared
    # role-aware parser, even when the acceptance copy is concrete.
    path, payload, root = _make_acceptance_fixture(tmp_path / 'receipt-null')
    relative = payload['candidate_build']['build_receipt']['path']
    document = json.loads((root / relative).read_text(encoding='utf-8'))
    document['toolchain']['nvcc_sha256'] = None
    _replace_artifact(root, payload, relative,
                      json.dumps(document, indent=2) + '\n')
    _rewrite_payload(path, payload)
    with pytest.raises(flashlight_evidence.EvidenceError,
                       match='candidate build'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)


def test_acceptance_requires_ffn_ptxas_and_separate_reserved_region(tmp_path):
    path, payload, _ = _make_acceptance_fixture(tmp_path)
    no_ffn = copy.deepcopy(payload)
    no_ffn['ptxas']['rows'][0]['kernel'] = 'global_projection_c1024_fp16'
    _rewrite_payload(path, no_ffn)
    with pytest.raises(flashlight_evidence.EvidenceError, match='FFN expansion'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    merged = copy.deepcopy(payload)
    merged['ptxas']['cuobjdump_reserved_bytes'] = 25624
    _rewrite_payload(path, merged)
    with pytest.raises(flashlight_evidence.EvidenceError, match='driver-reserved'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)

    wrong_target = copy.deepcopy(payload)
    wrong_target['ptxas']['rows'][0]['sm_target'] = 'sm_89'
    _rewrite_payload(path, wrong_target)
    with pytest.raises(flashlight_evidence.EvidenceError, match='disagrees with target'):
        flashlight_evidence.load_acceptance(path, CANDIDATE_COMMIT)


def test_current_namespace_rejects_missing_inventory_and_dependencies():
    manifest = {
        'refactor_source_revision': source_providers.ORIGINAL_REFERENCE,
        'source_providers': [
            {'name': 'original', 'revision': validator.EXPECTED_ORIGINAL_REFERENCE},
            {'name': 'current', 'revision': source_providers.ORIGINAL_REFERENCE},
        ],
        'inventory': {'entries': {}},
        'current_files': {}, 'current_file_revisions': {}, 'current_snippets': [],
        'current_inventory': None, 'current_dependencies': {},
        'current_source_paths': [], 'flashlight_chapter': None,
    }
    errors = validator.check_current_namespace(manifest)
    assert any('Current inventory is missing' in message for message in errors)
    assert any('Current dependency bundles are missing' in message for message in errors)
    assert any('Current source copy list is missing' in message for message in errors)
    assert any('FlashLight chapter metadata is missing' in message for message in errors)


def test_current_namespace_requires_the_exact_source_url():
    commit = source_providers.ORIGINAL_REFERENCE
    provider = source_providers.Provider('current', commit)
    registry = []
    common.code('setup.py', 1, 2, provider=provider, registry=registry)
    info = provider.provenance('setup.py')

    def manifest_with(url):
        snippet = dict(registry[0], url=url)
        return {
            'refactor_source_revision': commit,
            'source_providers': [
                {'name': 'original', 'revision': validator.EXPECTED_ORIGINAL_REFERENCE},
                {'name': 'current', 'revision': commit},
            ],
            'current_files': {'setup.py': info['sha256']},
            'current_file_revisions': {'setup.py': info},
            'current_snippets': [snippet],
        }

    assert validator.check_current_namespace(manifest_with(registry[0]['url'])) == []
    correct = registry[0]['url']
    mutations = (
        correct.replace(validator.EXPECTED_SOURCE_REPOSITORY,
                        'https://github.com/SomeoneElse/OtherRepo'),
        correct.replace('/setup.py#', '/README.md#'),
        correct.replace('#L1-L2', '#L1-L3'),
    )
    for mutated in mutations:
        assert mutated != correct
        errors = validator.check_current_namespace(manifest_with(mutated))
        assert any('URL must be exactly' in message for message in errors), (mutated, errors)


def test_current_source_copies_are_checked_against_the_commit(tmp_path):
    revision = source_providers.ORIGINAL_REFERENCE
    path = 'setup.py'
    committed = _git_text(revision, path)
    copy = tmp_path / 'source-current' / path
    copy.parent.mkdir(parents=True)
    copy.write_text(committed, encoding='utf-8', newline='\n')
    manifest = {
        'refactor_source_revision': revision,
        'current_source_paths': [path],
    }
    assert validator.check_current_source_copies(tmp_path, manifest) == []

    copy.write_text(committed + '\n# mutated current copy\n', encoding='utf-8',
                    newline='\n')
    errors = validator.check_current_source_copies(tmp_path, manifest)
    assert any('differs from its committed blob' in message for message in errors)


def test_rendered_chapter_oracle_rejects_missing_section_and_pending_evidence(tmp_path):
    revision = source_providers.ORIGINAL_REFERENCE
    page = tmp_path / 'flashlight.html'
    body = _valid_body()
    body += ('<div id="accepted-allocations"></div>'
             '<a href="source-current/csrc/include/flashlight/core.cuh">source</a>'
             '<a href="evidence-flashlight/acceptance.json">acceptance</a>')
    page.write_text(
        f'<article class="content">{body}</article>'
        f'<a href="flashlight.html" aria-current="page">nav</a>'
        f'<a href="https://example.invalid/tree/{revision}">x</a>'
        f'<a href="https://example.invalid/tree/{revision}">y</a>'
        f'<span>{revision[:12]}</span>',
        encoding='utf-8')
    index = tmp_path / 'index.html'
    atlas = tmp_path / 'source-atlas.html'
    index.write_text('<a href="flashlight.html">chapter</a>', encoding='utf-8')
    atlas.write_text('<a href="flashlight.html">chapter</a>', encoding='utf-8')
    manifest = {
        'refactor_source_revision': revision,
        'pages': [{'slug': 'index'}, {'slug': 'source-atlas'},
                  {'slug': 'flashlight'}],
        'flashlight_evidence': {'sha256': '0' * 64},
        'flashlight_chapter': {
            'slug': 'flashlight',
            'sections': list(flashlight.SECTION_IDS),
            'evidence_state': 'accepted',
            'source_revision': revision,
        },
    }
    pages = {page: None, index: None, atlas: None}
    assert validator.check_flashlight_chapter(tmp_path, manifest, pages) == []

    historical_link = page.read_text(encoding='utf-8').replace(
        'href="evidence-flashlight/acceptance.json"', 'href="evidence/index.json"')
    page.write_text(historical_link, encoding='utf-8', newline='\n')
    errors = validator.check_flashlight_chapter(tmp_path, manifest, pages)
    assert any('historical evidence content' in message for message in errors)
    page.write_text(
        page.read_text(encoding='utf-8').replace(
            'href="evidence/index.json"', 'href="evidence-flashlight/acceptance.json"'),
        encoding='utf-8', newline='\n')

    pending = json.loads(json.dumps(manifest))
    pending['flashlight_chapter']['evidence_state'] = 'pending'
    errors = validator.check_flashlight_chapter(tmp_path, pending, pages)
    assert any('requires accepted evidence' in message for message in errors)

    for state in (None, 'development', 'unrecognized'):
        mutated = json.loads(json.dumps(manifest))
        mutated['flashlight_chapter']['evidence_state'] = state
        errors = validator.check_flashlight_chapter(tmp_path, mutated, pages)
        assert any('requires accepted evidence' in message for message in errors)

    page.write_text(
        page.read_text(encoding='utf-8').replace('<h2 id="trace">5. Section</h2>', ''),
        encoding='utf-8')
    errors = validator.check_flashlight_chapter(tmp_path, manifest, pages)
    assert any('six forward-design sections' in message for message in errors)


def test_module_table_paths_and_names_are_unique():
    paths = [row[0] for row in flashlight.MODULES]
    assert len(paths) == len(set(paths))
    assert 'csrc/include/flashlight/core.cuh' in paths
    assert 'csrc/kernel_impl/bottleneck_c1024_ffn/fp16/global_ffn_expand_c1024_fp16.cu' in paths
    for _, _, _, names in flashlight.MODULES:
        assert names and len(names) == len(set(names))


def test_diagram_preview_is_source_free_and_labelled():
    html = flashlight.diagram_preview_html()
    assert flashlight.DIAGRAM_PREVIEW_LABEL in html
    assert html.count('<svg') == flashlight.MIN_DIAGRAMS
    assert '<pre' not in html
    assert 'source-current' not in html
    assert re.search(r'[0-9a-f]{40}', html) is None
    figures = re.findall(r'<svg\b.*?</svg>', html, re.S)
    assert len(figures) == flashlight.MIN_DIAGRAMS
    for figure in figures:
        assert '<title' in figure and '<desc' in figure and 'viewBox=' in figure


def test_chapter_renders_all_acceptance_rows_checks_and_links(tmp_path):
    acceptance, _, _, _ = _load_fixture(tmp_path)
    html = flashlight._acceptance_html(acceptance) + flashlight._evidence_html(acceptance)
    assert html.count('data-case="') == 16
    assert html.count('data-check="') == 8
    assert acceptance.sha256 in html
    assert acceptance.acceptance_id in html
    assert 'No current NCU evidence' in html
    assert '24,600' in html
    assert '1,024' in html
    assert 'global_ffn_expand_c1024_fp16' in html
    assert 'legacy71' in html and 'small31' in html
    assert 'fp16' in html and 'fp8' in html
    assert '1280×720 (720p)' in html
    assert 'kernel-implementation baseline' in html
    for case in acceptance.timing.cases:
        assert f'data-case="{case.id}"' in html
        assert flashlight_evidence.format_ms(case.original_median_ms) in html
        assert flashlight_evidence.format_ms(case.candidate_median_ms) in html
        assert flashlight_evidence.format_speedup(case.speedup) in html
        assert flashlight_evidence.format_range(*case.original_range_ms) in html
    for artifact in acceptance.artifacts:
        assert f'evidence-flashlight/{artifact.path}' in html
    for check in acceptance.checks:
        assert f'data-check="{check.category}"' in html


def test_rgb_table_groups_session_medians_by_arm(tmp_path):
    """Synthetic numbers distinguish arm medians from the combined-session median."""
    from types import SimpleNamespace
    from flashlight_results import rgb_measurements_html
    key = 'legacy71/fp16/full_gpu'
    rows = [{'session_arm': arm, 'median_ms': value}
            for arm, value in zip('ABBA', (10, 13, 15, 12))]
    (tmp_path / 'rgb.json').write_text(json.dumps({'proof': {'timing_summary': {
        'arms_scopes': {key: {'sessions': rows}},
        'paired_sessions': [{'key': key, 'b_minus_a_ms': 3}] * 2,
    }}}), encoding='utf-8')
    record = SimpleNamespace(bundle_root=tmp_path, checks=[SimpleNamespace(
        category='rgb', receipt=SimpleNamespace(path='rgb.json'))])
    tables = []
    rgb_measurements_html(record, lambda headers, body: tables.append(body) or '')
    assert tables[0][0][2:6] == ('11.0000', '14.0000', '+3000.00', '+27.27')
    assert tables[1][0][2:] == ('10.00000', '13.00000', '15.00000', '12.00000')


def test_native_effects_keep_headline_and_paired_median_distinct():
    """Synthetic skew makes paired mean, paired median and headline disagree."""
    from types import SimpleNamespace
    from flashlight_results import paired_effects_html
    case = SimpleNamespace(id='synthetic', original_process_medians_ms=(10, 20, 100, 101),
                           candidate_process_medians_ms=(21, 22, 102, 201))
    tables = []
    paired_effects_html(SimpleNamespace(timing=SimpleNamespace(cases=[case])),
                        lambda headers, rows: tables.append(rows) or '')
    assert tables[0][0][1] == '+2000.00'
    assert tables[0][0][3] == '+6500.00'
    assert tables[0][0][4] == '+11000.00, +2000.00, +2000.00, +100000.00'


def test_rendered_acceptance_validator_detects_changed_row_report_and_link(tmp_path):
    acceptance, _, _, source_root = _load_fixture(tmp_path)
    guide = tmp_path / 'guide'
    flashlight_evidence.copy_acceptance_bundle(
        acceptance, guide / 'evidence-flashlight')
    page = guide / 'flashlight.html'
    original_body = ('<article class="content">'
                     + flashlight._acceptance_html(acceptance)
                     + flashlight._evidence_html(acceptance)
                     + '</article>')
    page.write_text(original_body, encoding='utf-8', newline='\n')
    manifest = {
        'refactor_source_revision': CANDIDATE_COMMIT,
        'flashlight_evidence': {
            'path': 'evidence-flashlight/acceptance.json',
            'sha256': acceptance.sha256,
            'acceptance_id': acceptance.acceptance_id,
            'schema_version': 1,
            'state': 'accepted',
            'original_source_revision': ORIGINAL_COMMIT,
            'candidate_source_revision': CANDIDATE_COMMIT,
            'artifacts': [dict(path=artifact.path, sha256=artifact.sha256,
                               kind=artifact.kind, identity=artifact.identity)
                          for artifact in acceptance.artifacts],
            'case_rows_sha256': acceptance.case_rows_sha256(),
            'gate_rows_sha256': acceptance.gate_rows_sha256(),
        },
        'flashlight_chapter': {
            'evidence_sha256': acceptance.sha256,
            'evidence_acceptance_id': acceptance.acceptance_id,
            'candidate_source_revision': CANDIDATE_COMMIT,
            'evidence_case_rows_sha256': acceptance.case_rows_sha256(),
            'evidence_gate_rows_sha256': acceptance.gate_rows_sha256(),
            'evidence_artifacts': [dict(path=artifact.path, sha256=artifact.sha256,
                                        kind=artifact.kind, identity=artifact.identity)
                                   for artifact in acceptance.artifacts],
        },
    }
    pages = {page: None}
    assert validator.check_flashlight_evidence(guide, manifest, pages) == []

    # Glossary markup splits prose into HTML nodes but must preserve the full note.
    note = validator.html_escape(acceptance.original_build.provenance_note)
    first, rest = note.split(' ', 1)
    marked = original_body.replace(note, f'<a href="glossary.html#source">{first}</a> {rest}')
    page.write_text(marked, encoding='utf-8', newline='\n')
    assert validator.check_flashlight_evidence(guide, manifest, pages) == []
    page.write_text(original_body.replace(note, ''), encoding='utf-8', newline='\n')
    errors = validator.check_flashlight_evidence(guide, manifest, pages)
    assert any('original provenance note is not rendered' in message for message in errors)

    page.write_text(original_body.replace(
        f'data-case="{acceptance.timing.cases[0].id}"', 'data-case="missing"'),
        encoding='utf-8', newline='\n')
    errors = validator.check_flashlight_evidence(guide, manifest, pages)
    assert any('missing accepted row' in message for message in errors)

    page.write_text(original_body, encoding='utf-8', newline='\n')
    changed = copy.deepcopy(manifest)
    changed['flashlight_evidence']['sha256'] = '0' * 64
    errors = validator.check_flashlight_evidence(guide, changed, pages)
    assert any('report SHA-256' in message for message in errors)

    link = f'evidence-flashlight/{acceptance.artifacts[0].path}'
    page.write_text(original_body.replace(f'href="{link}"', 'href="removed"'),
                    encoding='utf-8', newline='\n')
    errors = validator.check_flashlight_evidence(guide, manifest, pages)
    assert any('missing artifact link' in message for message in errors)


def test_rendered_case_rows_bind_visible_values_to_each_identity(tmp_path):
    acceptance, _, _, _ = _load_fixture(tmp_path)
    guide, page, manifest = _guide_for_acceptance(tmp_path, acceptance)
    pages = {page: None}
    assert validator.check_flashlight_evidence(guide, manifest, pages) == []
    body = page.read_text(encoding='utf-8')
    first, second = [case.id for case in acceptance.timing.cases[:2]]

    swapped = _swap_case_row_values(body, first, second)
    assert swapped != body
    page.write_text(swapped, encoding='utf-8', newline='\n')
    errors = validator.check_flashlight_evidence(guide, manifest, pages)
    assert any('per-case row column' in message and first in message
               for message in errors)
    assert any('per-case row column' in message and second in message
               for message in errors)

    # The page mutation did not touch the accepted report or manifest metadata.
    assert hashlib.sha256(
        (guide / 'evidence-flashlight' / 'acceptance.json').read_bytes()
    ).hexdigest() == acceptance.sha256
    assert manifest['flashlight_evidence']['case_rows_sha256'] == \
        acceptance.case_rows_sha256()

    page.write_text(
        body.replace(f'data-case="{second}"', f'data-case="{first}"', 1),
        encoding='utf-8', newline='\n')
    errors = validator.check_flashlight_evidence(guide, manifest, pages)
    assert any('repeat a case identity' in message for message in errors)

    receipt_href = f'evidence-flashlight/{acceptance.timing.receipt.path}'
    page.write_text(body.replace(f'href="{receipt_href}"', 'href="removed"', 1),
                    encoding='utf-8', newline='\n')
    errors = validator.check_flashlight_evidence(guide, manifest, pages)
    assert any('does not link the accepted timing receipt' in message
               for message in errors)


def test_chapter_duplicate_metadata_binds_accepted_digests_and_artifacts(tmp_path):
    acceptance, _, _, _ = _load_fixture(tmp_path)
    guide, page, manifest = _guide_for_acceptance(tmp_path, acceptance)
    pages = {page: None}
    report_path = guide / 'evidence-flashlight' / 'acceptance.json'
    report_sha256 = hashlib.sha256(report_path.read_bytes()).hexdigest()

    # The synthetic guide fixture mirrors the builder's existing chapter fields.
    chapter = manifest['flashlight_chapter']
    assert chapter['evidence_case_rows_sha256'] == acceptance.case_rows_sha256()
    assert chapter['evidence_gate_rows_sha256'] == acceptance.gate_rows_sha256()
    assert chapter['evidence_artifacts'] == [
        dict(path=artifact.path, sha256=artifact.sha256,
             kind=artifact.kind, identity=artifact.identity)
        for artifact in acceptance.artifacts
    ]
    assert validator.check_flashlight_evidence(guide, manifest, pages) == []

    forged_artifact = dict(chapter['evidence_artifacts'][0], sha256='f' * 64)
    mutations = (
        ('evidence_case_rows_sha256', '0' * 64, 'case-row digest'),
        ('evidence_gate_rows_sha256', '0' * 64, 'gate-row digest'),
        ('evidence_artifacts', [forged_artifact], 'artifact registry'),
    )
    for field, value, expected in mutations:
        mutated = copy.deepcopy(manifest)
        mutated['flashlight_chapter'][field] = value
        errors = validator.check_flashlight_evidence(guide, mutated, pages)
        assert any('chapter' in message and expected in message for message in errors), \
            (field, errors)
        # Only the duplicate under flashlight_chapter changed: the accepted
        # report bytes and the canonical flashlight_evidence metadata did not.
        assert mutated['flashlight_evidence'] == manifest['flashlight_evidence']
        assert hashlib.sha256(report_path.read_bytes()).hexdigest() == report_sha256
        assert not any('Accepted timing row digest disagrees' in message
                       for message in errors)


def test_evidence_resolution_precedence_and_bundle_copy_are_safe(tmp_path):
    guide_root = tmp_path / 'guide'
    canonical = flashlight_evidence.canonical_acceptance_path(guide_root)
    canonical.parent.mkdir(parents=True)
    canonical.write_text('{"canonical": true}\n', encoding='utf-8')
    env_path = tmp_path / 'env.json'
    env_path.write_text('{"env": true}\n', encoding='utf-8')
    explicit = tmp_path / 'explicit.json'
    explicit.write_text('{"explicit": true}\n', encoding='utf-8')
    assert flashlight_evidence.resolve_acceptance_path(
        None, guide_root=guide_root,
        env={flashlight_evidence.ENVIRONMENT_VARIABLE: str(env_path)}) == env_path
    assert flashlight_evidence.resolve_acceptance_path(
        explicit, guide_root=guide_root,
        env={flashlight_evidence.ENVIRONMENT_VARIABLE: str(env_path)}) == explicit
    assert flashlight_evidence.resolve_acceptance_path(
        None, guide_root=guide_root, env={}) == canonical
    assert flashlight_evidence.resolve_acceptance_path(
        None, guide_root=tmp_path / 'empty', env={}) is None

    fixture = tmp_path / 'fixture'
    fixture.mkdir()
    acceptance, _, _, source_root = _load_fixture(fixture)
    source_hashes = {
        artifact.path: _sha((source_root / artifact.path).read_bytes())
        for artifact in acceptance.artifacts
    }
    destination = tmp_path / 'copied'
    copied_path = flashlight_evidence.copy_acceptance_bundle(acceptance, destination)
    assert copied_path.read_bytes() == acceptance.path.read_bytes()
    for artifact in acceptance.artifacts:
        copied = destination / artifact.path
        assert copied.is_file()
        assert _sha(copied.read_bytes()) == artifact.sha256
        assert _sha((source_root / artifact.path).read_bytes()) == source_hashes[artifact.path]
    assert not list(destination.rglob('*.pyd'))
    assert not list(destination.rglob('*.pt'))
    assert all(artifact.kind != 'binary' for artifact in acceptance.artifacts)


def test_builder_preflights_bad_evidence_and_protects_existing_current_output(
        tmp_path, monkeypatch):
    output = tmp_path / 'out'
    output.mkdir()
    sentinel = output / 'sentinel.txt'
    sentinel.write_text('unchanged\n', encoding='utf-8')
    bad = tmp_path / 'bad.json'
    bad.write_text('{}', encoding='utf-8')
    monkeypatch.setenv('DLSSNR_REFACTOR_REVISION', CANDIDATE_COMMIT)
    monkeypatch.delenv(flashlight_evidence.ENVIRONMENT_VARIABLE, raising=False)
    with pytest.raises(SystemExit):
        build_kernel_docs.preflight_current(
            historical_only=False, explicit_evidence=str(bad), output=output,
            inventory={}, snapshot_roster='')
    assert sentinel.read_text(encoding='utf-8') == 'unchanged\n'
    assert not (output / 'evidence-flashlight').exists()

    if not flashlight_evidence.canonical_acceptance_path().exists():
        with pytest.raises(SystemExit):
            build_kernel_docs.preflight_current(
                historical_only=False, explicit_evidence=None, output=output,
                inventory={}, snapshot_roster='')
        assert sentinel.read_text(encoding='utf-8') == 'unchanged\n'

    (output / 'flashlight.html').write_text('previous chapter\n', encoding='utf-8')
    with pytest.raises(SystemExit):
        build_kernel_docs.preflight_current(
            historical_only=True, explicit_evidence=None, output=output,
            inventory={}, snapshot_roster='')
    assert (output / 'flashlight.html').read_text(encoding='utf-8') == 'previous chapter\n'
    assert sentinel.read_text(encoding='utf-8') == 'unchanged\n'


def test_validator_uses_module_pin_and_has_an_explicit_historical_branch(monkeypatch):
    monkeypatch.setattr(validator, 'configured_refactor_revision',
                        lambda: CANDIDATE_COMMIT)
    assert validator.configured_current_revision() == CANDIDATE_COMMIT
    assert validator.configured_current_revision(historical_only=True) is None
    assert validator.EXPECTED_CASE_MODELS == ('legacy71', 'small31')
    assert validator.EXPECTED_CHECK_CATEGORIES == flashlight_evidence.REQUIRED_CHECK_CATEGORIES

    # The default validator must read the configured module pin, not only the
    # environment override.  With the env unset, the module constant is enough.
    monkeypatch.delenv(runtime_source_revision.REFACTOR_ENVIRONMENT_VARIABLE,
                       raising=False)
    monkeypatch.setattr(runtime_source_revision, 'REFACTOR_REVISION', CANDIDATE_COMMIT)
    assert validator.configured_current_revision() == CANDIDATE_COMMIT
    assert validator.configured_current_revision(historical_only=True) is None


def test_figures_do_not_name_removed_helpers():
    figures = "".join(figure() for figure in flashlight._SVG_FIGURES)
    for removed in ('StageRing', 'StridedByteLayout', 'mma_k', 'make_packed'):
        assert removed not in figures
    assert 'ByteStrides' in figures
    assert 'StagedSharedLayoutView' in figures


def test_corrected_svg_data_flow_geometry():
    namespace = '{http://www.w3.org/2000/svg}'

    figure3 = ET.fromstring(flashlight._svg3())
    texts3 = [node.text or '' for node in figure3.iter(namespace + 'text')]
    assert any('three 8-byte barriers occupy [24576, 24600)' in text for text in texts3)
    assert not any('24 reserved bytes' in text for text in texts3)

    figure4 = ET.fromstring(flashlight._svg4())
    captions = [node for node in figure4.iter(namespace + 'text')
                if (node.text or '').startswith(('Selected A uint4', 'x/y feed', 'First accumulator'))]
    assert [node.get('x') for node in captions] == ['32', '400', '770']

    figure5 = ET.fromstring(flashlight._svg5())
    texts5 = [node.text or '' for node in figure5.iter(namespace + 'text')]
    assert 'round 0 · dst +0 … +496' in texts5
    assert 'round 1 · dst +512 … +1008' in texts5
    assert 'StageInput(0..2)' in texts5
    assert 'refill 3' in texts5 and 'read 0' in texts5
    assert any('Orange cells are reads; blue cells are same-iteration refills'
               in text for text in texts5)
    assert not any('Blue cells are reads' in text for text in texts5)
    row0 = [node for node in figure5.iter(namespace + 'rect')
            if node.get('y') == '582' and node.get('width') == '12']
    row1 = [node for node in figure5.iter(namespace + 'rect')
            if node.get('y') == '616' and node.get('width') == '12']
    assert len(row0) == 32 and len(row1) == 32
    refill3 = next(node for node in figure5.iter(namespace + 'text')
                   if node.text == 'refill 3')
    read0 = next(node for node in figure5.iter(namespace + 'text')
                 if node.text == 'read 0')
    assert abs(float(refill3.get('x')) - float(read0.get('x'))) == 62
    assert float(refill3.get('x')) < 300

    figure6 = ET.fromstring(flashlight._svg6())
    texts6 = [node.text or '' for node in figure6.iter(namespace + 'text')]
    assert any(text.startswith('A path:') for text in texts6)
    assert any(text.startswith('B path:') for text in texts6)
    assert 'MMA + accumulator' in texts6
    weight = next(node for node in figure6.iter(namespace + 'text')
                  if node.text == 'weight B')
    mma_text = next(node for node in figure6.iter(namespace + 'text')
                    if node.text == 'MMA + accumulator')
    assert float(weight.get('y')) < float(mma_text.get('y'))

    a2 = next(text for text in texts6 if 'cp.async.bulk (SM90+)' in text)
    assert 'cp.async.cg' in a2
    assert 'ld.ca' not in a2
    assert any(text.startswith('ld.ca → register') for text in texts6)

    rects6 = [node for node in figure6.iter(namespace + 'rect')]
    mma = next(node for node in rects6
               if node.get('x') == '54' and node.get('y') == '454')
    output = next(node for node in rects6
                  if node.get('x') == '54' and node.get('y') == '554')
    mma_x, mma_y = float(mma.get('x')), float(mma.get('y'))
    mma_right = mma_x + float(mma.get('width'))
    output_y = float(output.get('y'))
    branch = next(node for node in figure6.iter(namespace + 'polyline')
                  if (node.get('points') or '').startswith('880,220'))
    points = [tuple(float(part) for part in pair.split(','))
              for pair in branch.get('points').split()]
    assert points[0] == (880.0, 220.0)
    assert points[-1][1] == mma_y
    assert mma_x <= points[-1][0] <= mma_right
    lines6 = [node for node in figure6.iter(namespace + 'line')]
    connector = next(
        node for node in lines6
        if node.get('x1') == node.get('x2')
        and float(node.get('y1')) == mma_y + float(mma.get('height'))
        and float(node.get('y2')) == output_y)
    assert mma_x <= float(connector.get('x1')) <= mma_right
