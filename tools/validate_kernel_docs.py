"""Validate generated documentation links, SVGs, source excerpts and coverage."""
from html.parser import HTMLParser
from html import escape as html_escape
from pathlib import Path
from urllib.parse import urlsplit, unquote
from collections import Counter
import argparse
import hashlib
import json
import re
import subprocess
import sys
import xml.etree.ElementTree as ET

ROOT = Path(__file__).resolve().parents[1]
GUIDE = ROOT/'docs/kernel-guide'
sys.path.insert(0, str(ROOT/'tools/kernel_docs'))
from runtime_source_revision import (
    CHECKPOINT_API_HISTORICAL_PATHS,
    CHECKPOINT_API_SOURCE_PATHS,
    RUNTIME_REVISION,
    RUNTIME_SOURCE_PATHS,
    configured_checkpoint_api_revision,
    configured_refactor_revision,
)
from output_paths import configure_output_root
from lessons_small_attention import SMALL_NAMES
import flashlight_evidence as evidence_model

LEGACY_REVISION = 'fc3276497f866bdad639cd443e75743f5d19b749'
EXPECTED_RUNTIME_REVISION = '266d69acf52dda413df3a874572f1156461f89ff'
#: Independent preservation oracle for the immutable original snapshot.  These
#: literals are deliberately not imported from the producer/provider modules.
EXPECTED_ORIGINAL_REFERENCE = 'e2741a72b390f830de810e6f1180369ed52eb325'
EXPECTED_OLD_FILE_COUNT = 118
EXPECTED_OLD_SNIPPET_COUNT = 1570
EXPECTED_OLD_KIND_COUNTS = {
    'legacy-commit': 93,
    'runtime-commit': 22,
    'checkpoint-api-commit': 3,
}
EXPECTED_OLD_FILE_MAP_SHA256 = '4b5c884f2b3d656aba0668fb3ad29e7009933f1bef410bf13ea00a17c3fa2fa2'
EXPECTED_OLD_SNIPPET_TUPLE_SHA256 = 'a364c2ac836d49521ff3e9441a8076c290e01d26bfe2023b8637dae175e50184'
EXPECTED_BASELINE_MANIFEST_SHA256 = '40e62d31f53d648614673eb33265ff616cfaa926dadbf0b54cccbb36a13bd2c5'
#: The exact three paths changed by the checkpoint API commit.  All three must be
#: listed, hashed and classified as ``checkpoint-api-commit``; only the first two
#: belong to the historical 122-path gate.
EXPECTED_CHECKPOINT_API_SOURCE_PATHS = (
    'dlssnr/__init__.py',
    'dlssnr/checkpoint.py',
    'dlssnr/small_deployment.py',
)
EXPECTED_CHECKPOINT_API_HISTORICAL_PATHS = (
    'dlssnr/__init__.py',
    'dlssnr/checkpoint.py',
)
EXPECTED_REFACTOR_ENVIRONMENT_VARIABLE = 'DLSSNR_REFACTOR_REVISION'
#: The producer's real source-link convention.  The validator rebuilds this URL
#: itself instead of importing the producer helper as its oracle.
EXPECTED_SOURCE_REPOSITORY = 'https://github.com/DylanWaken/DLSS5-Pytorch'
#: Independent FlashLight chapter oracle.  These are not imported from the
#: producer: the validator derives page presence from the recorded namespace and
#: re-checks the rendered structure, sources and links itself.
EXPECTED_FLASHLIGHT_SECTIONS = ('problem', 'cta', 'warp', 'resources', 'schedule', 'trace')
EXPECTED_FLASHLIGHT_SVGS = 6
EXPECTED_RESOURCE_BUDGET_MARKERS = ('24,600', 'shared', 'register', 'ptxas')
#: Independent acceptance-matrix/gate oracle.  These literals are deliberately
#: not imported from the producer's evidence module; the validator only reuses
#: the shared typed parser for schema/files and applies its own expected matrix.
EXPECTED_ACCEPTANCE_SCHEMA_VERSION = 1
EXPECTED_CASE_MODELS = ('legacy71', 'small31')
EXPECTED_CASE_PRECISIONS = ('fp16', 'fp8')
EXPECTED_CASE_SIZES = (('720p', 1280, 720), ('1080p', 1920, 1080),
                       ('2k', 2560, 1440), ('4k', 3840, 2160))
EXPECTED_PROCESSES_PER_CASE = 8
EXPECTED_ARM_PROCESSES = 4
EXPECTED_CHECK_CATEGORIES = ('cpu', 'native-bitwise', 'cuda-graphs', 'guards',
                             'checkpoint', 'training', 'rgb', 'primitives')
EXPECTED_CURRENT_ENTRY_COUNT = 83
EXPECTED_CURRENT_DEFINITION_COUNT = 58
EXPECTED_CURRENT_EMISSION_UNIT_COUNT = 58
EXPECTED_CURRENT_TEMPLATE_COUNT = 40
#: The configured constant or its validated environment override; ``None`` is
#: an error during strict validation, never a fallback.
CHECKPOINT_API_REVISION = configured_checkpoint_api_revision()
EXPECTED_SMALL_BINARY = 'f0d514043dda98bbe0043ac14d1d93a13e6620eae1c0338d1e3901c017528938'
EXPECTED_SMALL_FIXTURE = 'cyberpunk2077-johnny-first4k-b31'
EXPECTED_SMALL_REPORTS = {
    'full_cyberpunk4k-b31_fp16.ncu-repz',
    'source_cyberpunk4k-b31_fp16.ncu-repz',
    'full_cyberpunk4k-b31_fp8.ncu-repz',
    'source_cyberpunk4k-b31_fp8.ncu-repz',
}
EXPECTED_SMALL_REGISTERS = {
    'small_global_attention_chained_c1024_fp16': 208,
    'small_global_attention_chained_c1024_fp8': 195,
}
SUBSTANTIVE_SMALL_METRICS = {
    'gpu__time_duration.sum',
    'launch__registers_per_thread',
    'launch__shared_mem_per_block_static',
    'smsp__pcsamp_sample_count',
    'smsp__sass_inst_executed_op_local_ld.sum',
    'smsp__sass_inst_executed_op_local_st.sum',
    'l1tex__data_bank_conflicts_pipe_lsu_mem_shared_op_ld.sum',
}


def _normalized_lf(text):
    return text.replace('\r\n', '\n').replace('\r', '\n')


def configured_current_revision(historical_only=False):
    """Return the module/env current pin, or ``None`` for historical-only mode.

    This is a local execution/configuration branch; it never mutates the
    process environment.
    """
    if historical_only:
        return None
    return configured_refactor_revision()


_BLOB_CACHE = {}


def _git_blob(revision, path):
    """Read a committed blob directly as normalized-LF text.

    The validator never uses the producer's helpers, the generated source
    copies or the working tree as its oracle.
    """
    key = (revision, path)
    if key in _BLOB_CACHE:
        return _BLOB_CACHE[key]
    result = subprocess.run(
        ['git', 'cat-file', 'blob', f'{revision}:{path}'], cwd=ROOT,
        capture_output=True,
    )
    text = None
    if result.returncode == 0:
        text = _normalized_lf(result.stdout.decode('utf-8'))
    _BLOB_CACHE[key] = text
    return text


def _canonical_json(value):
    return json.dumps(value, sort_keys=True, separators=(',', ':'),
                      ensure_ascii=False).encode('utf-8')


def _file_map_digest(file_revisions):
    return hashlib.sha256(_canonical_json(file_revisions)).hexdigest()


def _snippet_tuple_digest(snippets):
    tuples = sorted((row['path'], row['start'], row['end'], row['sha256'])
                    for row in snippets)
    return hashlib.sha256(_canonical_json(tuples)).hexdigest()


def _baseline_manifest():
    """Read the frozen manifest from the immutable original commit."""
    result = subprocess.run(
        ['git', 'cat-file', 'blob',
         f'{EXPECTED_ORIGINAL_REFERENCE}:docs/kernel-guide/source-manifest.json'],
        cwd=ROOT, capture_output=True,
    )
    if result.returncode != 0:
        return None, None
    text = _normalized_lf(result.stdout.decode('utf-8'))
    return text, json.loads(text)


def check_baseline_literals(baseline_text, baseline):
    """Verify the independent baseline count/hash literals."""
    errors = []
    digest = hashlib.sha256(baseline_text.encode('utf-8')).hexdigest()
    if digest != EXPECTED_BASELINE_MANIFEST_SHA256:
        errors.append('Baseline manifest normalized digest moved')
    files = baseline.get('files', {})
    file_revisions = baseline.get('file_revisions', {})
    snippets = baseline.get('snippets', [])
    if len(files) != EXPECTED_OLD_FILE_COUNT:
        errors.append(f'Baseline file map is not {EXPECTED_OLD_FILE_COUNT} files: {len(files)}')
    if len(file_revisions) != EXPECTED_OLD_FILE_COUNT:
        errors.append(f'Baseline file revisions are not {EXPECTED_OLD_FILE_COUNT}: '
                      f'{len(file_revisions)}')
    if len(snippets) != EXPECTED_OLD_SNIPPET_COUNT:
        errors.append(f'Baseline excerpt tuples are not {EXPECTED_OLD_SNIPPET_COUNT}: '
                      f'{len(snippets)}')
    if _file_map_digest(file_revisions) != EXPECTED_OLD_FILE_MAP_SHA256:
        errors.append('Baseline per-file provenance map digest moved')
    if _snippet_tuple_digest(snippets) != EXPECTED_OLD_SNIPPET_TUPLE_SHA256:
        errors.append('Baseline excerpt tuple digest moved')
    kinds = {}
    for info in file_revisions.values():
        kinds[info.get('kind')] = kinds.get(info.get('kind'), 0) + 1
    if kinds != EXPECTED_OLD_KIND_COUNTS:
        errors.append(f'Baseline provenance ownership is not 93/22/3: {kinds}')
    return errors


def check_old_namespace(manifest, baseline):
    """Verify the regenerated historical namespace against blobs and baseline."""
    errors = []
    if manifest.get('original_source_reference_revision') != EXPECTED_ORIGINAL_REFERENCE:
        errors.append('Manifest does not name the immutable original source reference')
    if manifest.get('source_revision') != LEGACY_REVISION:
        errors.append('Legacy source_revision moved away from the historical pin')
    if manifest.get('runtime_source_revision') != EXPECTED_RUNTIME_REVISION:
        errors.append('Runtime source revision is not the committed Small31 pin')
    files = manifest.get('files')
    file_revisions = manifest.get('file_revisions')
    snippets = manifest.get('snippets')
    if not isinstance(files, dict) or len(files) != EXPECTED_OLD_FILE_COUNT:
        errors.append(f'Manifest file map is not exactly {EXPECTED_OLD_FILE_COUNT} files')
        files = files if isinstance(files, dict) else {}
    if not isinstance(file_revisions, dict) or len(file_revisions) != EXPECTED_OLD_FILE_COUNT:
        errors.append(f'Manifest file_revisions is not exactly {EXPECTED_OLD_FILE_COUNT} entries')
        file_revisions = file_revisions if isinstance(file_revisions, dict) else {}
    if not isinstance(snippets, list) or len(snippets) != EXPECTED_OLD_SNIPPET_COUNT:
        errors.append(f'Manifest snippets is not exactly {EXPECTED_OLD_SNIPPET_COUNT} entries')
        snippets = snippets if isinstance(snippets, list) else []
    if files != baseline.get('files'):
        errors.append('Regenerated historical file map differs from the frozen baseline')
    if file_revisions != baseline.get('file_revisions'):
        errors.append('Regenerated historical file_revisions differ from the frozen baseline')
    snippet_keys = ('path', 'start', 'end', 'sha256', 'source_kind', 'revision',
                    'source_sha256', 'url')
    try:
        regenerated = [tuple(row[key] for key in snippet_keys) for row in snippets]
        frozen = [tuple(row[key] for key in snippet_keys)
                  for row in baseline.get('snippets', [])]
    except (KeyError, TypeError):
        errors.append('Regenerated snippets are missing a frozen provenance field')
        regenerated, frozen = [], [None]
    if regenerated != frozen:
        errors.append('Regenerated historical excerpt tuples differ from the frozen baseline')
    kinds = {}
    for info in file_revisions.values():
        kinds[info.get('kind')] = kinds.get(info.get('kind'), 0) + 1
    if kinds != EXPECTED_OLD_KIND_COUNTS:
        errors.append(f'Regenerated provenance ownership is not 93/22/3: {kinds}')
    if _file_map_digest(file_revisions) != EXPECTED_OLD_FILE_MAP_SHA256:
        errors.append('Regenerated per-file provenance map digest moved')
    if _snippet_tuple_digest(snippets) != EXPECTED_OLD_SNIPPET_TUPLE_SHA256:
        errors.append('Regenerated excerpt tuple digest moved')
    for path, digest in files.items():
        info = file_revisions.get(path) or {}
        revision = info.get('revision')
        if not isinstance(revision, str) or re.fullmatch(r'[0-9a-f]{40}', revision) is None:
            errors.append(f'{path}: invalid recorded source revision')
            continue
        committed = _git_blob(revision, path)
        actual = (hashlib.sha256(committed.encode('utf-8')).hexdigest()
                  if committed is not None else None)
        if actual != digest or info.get('sha256') != digest:
            errors.append(f'{path}: manifest hash disagrees with committed blob {revision}')
    for snippet in snippets:
        if snippet.get('source_provider') != 'original':
            errors.append(f'{snippet.get("path")}: historical snippet is not original-provider')
        info = file_revisions.get(snippet.get('path'))
        if info is None:
            errors.append(f'Snippet has no file provenance: {snippet.get("path")}')
            continue
        if snippet.get('source_kind') != info.get('kind') or snippet.get('revision') != info.get('revision'):
            errors.append(f'Snippet provenance disagrees with its file: {snippet.get("path")}')
            continue
        committed = _git_blob(info['revision'], snippet['path'])
        if committed is None:
            errors.append(f'Snippet source is absent at its recorded revision: {snippet["path"]}')
            continue
        lines = committed.splitlines()
        if not 1 <= snippet['start'] <= snippet['end'] <= len(lines):
            errors.append(f'Snippet range is outside its committed blob: {snippet["path"]}')
            continue
        excerpt = '\n'.join(lines[snippet['start'] - 1:snippet['end']])
        if hashlib.sha256(excerpt.encode('utf-8')).hexdigest() != snippet['sha256']:
            errors.append(f'Snippet excerpt hash disagrees with its committed blob: '
                          f'{snippet["path"]}')
        if f'/{info["revision"]}/' not in snippet.get('url', ''):
            errors.append(f'Committed snippet must link to its exact revision: '
                          f'{snippet["path"]}')
    return errors


def check_source_copies(guide, manifest):
    """Verify every public source copy against its committed blob."""
    errors = []
    file_revisions = manifest.get('file_revisions') or {}
    for lesson in manifest.get('lessons', []):
        for dependency in lesson.get('dependencies', []):
            info = file_revisions.get(dependency)
            if info is None:
                errors.append(f'{lesson.get("name")}: dependency has no recorded provenance: '
                              f'{dependency}')
                continue
            committed = _git_blob(info['revision'], dependency)
            copy = guide / 'source' / dependency
            if committed is None:
                errors.append(f'{lesson.get("name")}: dependency source is absent at its '
                              f'recorded revision: {dependency}')
            elif not copy.is_file() or _normalized_lf(
                    copy.read_text(encoding='utf-8')) != committed:
                errors.append(f'{lesson.get("name")}: missing or changed source dependency '
                              f'{dependency}')
    return errors


def check_current_namespace(manifest, configured_revision=None):
    """Validate the separate, optional current-provider namespace."""
    errors = []
    revision = manifest.get('refactor_source_revision')
    current_files = manifest.get('current_files')
    current_revisions = manifest.get('current_file_revisions')
    current_snippets = manifest.get('current_snippets')
    providers = manifest.get('source_providers') or []
    provider_names = {row.get('name'): row for row in providers if isinstance(row, dict)}
    original = provider_names.get('original') or {}
    if original.get('revision') != EXPECTED_ORIGINAL_REFERENCE:
        errors.append('source_providers does not attribute the original snapshot')
    if current_files is None or current_revisions is None or current_snippets is None:
        errors.append('Manifest is missing the additive current-provider namespaces')
        current_files = current_files or {}
        current_revisions = current_revisions or {}
        current_snippets = current_snippets or []
    if revision is None:
        if current_files or current_revisions or current_snippets:
            errors.append('Current namespace exists without a configured implementation commit')
        if configured_revision is not None:
            errors.append('A current implementation commit is configured but the manifest '
                          'does not name it')
        if any(row.get('source_provider') != 'original'
               for row in manifest.get('snippets', [])):
            errors.append('Historical snippets must remain original-provider only')
        if manifest.get('current_inventory') is not None:
            errors.append('Current inventory exists without a configured implementation commit')
        if manifest.get('current_dependencies'):
            errors.append('Current dependency bundles exist without a configured commit')
        if manifest.get('current_source_paths'):
            errors.append('Current source copies exist without a configured commit')
        if manifest.get('flashlight_chapter') is not None:
            errors.append('FlashLight chapter metadata exists without a configured commit')
        return errors
    if not isinstance(revision, str) or re.fullmatch(r'[0-9a-f]{40}', revision) is None:
        errors.append(f'Current implementation revision is malformed: {revision!r}')
        return errors
    if configured_revision is not None and configured_revision != revision:
        errors.append('Current implementation revision does not match the configured commit')
    present = subprocess.run(
        ['git', 'cat-file', '-e', f'{revision}^{{commit}}'], cwd=ROOT,
        capture_output=True,
    )
    if present.returncode:
        errors.append(f'Current implementation commit is absent: {revision}')
    if set(current_files) != set(current_revisions):
        errors.append('current_files and current_file_revisions have different paths')
    current = provider_names.get('current') or {}
    if current.get('revision') != revision:
        errors.append('source_providers does not attribute the current implementation commit')
    for path, digest in current_files.items():
        committed = _git_blob(revision, path)
        actual = (hashlib.sha256(committed.encode('utf-8')).hexdigest()
                  if committed is not None else None)
        info = current_revisions.get(path) or {}
        if actual is None:
            errors.append(f'{path}: current source is absent at {revision}')
        elif actual != digest or info.get('sha256') != digest:
            errors.append(f'{path}: current source hash disagrees with {revision}')
        if info.get('kind') != 'refactor-commit' or info.get('revision') != revision:
            errors.append(f'{path}: current provenance is not refactor-commit at {revision}')
    for snippet in current_snippets:
        path = snippet.get('path')
        if path not in current_files:
            errors.append(f'{path}: current snippet source is missing from current_files')
        elif snippet.get('source_sha256') != current_files[path]:
            errors.append(f'{path}: current snippet source hash disagrees with current_files')
        if snippet.get('source_provider') != 'current':
            errors.append(f'{path}: current snippet is not current-provider')
        if snippet.get('source_kind') != 'refactor-commit' or snippet.get('revision') != revision:
            errors.append(f'{path}: current snippet provenance is not its refactor commit')
        committed = _git_blob(revision, path)
        if committed is None:
            errors.append(f'{path}: current snippet source is absent at {revision}')
            continue
        lines = committed.splitlines()
        start, end = snippet.get('start'), snippet.get('end')
        if (not isinstance(start, int) or not isinstance(end, int)
                or not 1 <= start <= end <= len(lines)):
            errors.append(f'{path}: current snippet range is outside its committed blob')
            continue
        excerpt = '\n'.join(lines[start - 1:end])
        if hashlib.sha256(excerpt.encode('utf-8')).hexdigest() != snippet.get('sha256'):
            errors.append(f'{path}: current excerpt hash disagrees with {revision}')
        expected_url = (f'{EXPECTED_SOURCE_REPOSITORY}/blob/{revision}/{path}'
                        f'#L{start}-L{end}')
        if snippet.get('url') != expected_url:
            errors.append(
                f'{path}: current snippet URL must be exactly {expected_url}, '
                f'found {snippet.get("url")!r}')
    if any(row.get('source_provider') == 'current'
           for row in manifest.get('snippets', [])):
        errors.append('Current snippets must not inflate the historical snippet registry')

    # Separate current inventory and dependency ownership.  A focused legacy
    # current-snippet fixture that predates the chapter namespace has none of
    # these keys; final chapter publication always records all four.  The
    # rendered-page oracle separately requires ``flashlight_chapter`` for a
    # current revision, so skipping an entirely absent additive namespace here
    # cannot let a final guide pass.
    if not any(key in manifest for key in ('current_inventory', 'current_dependencies',
                                           'current_source_paths', 'flashlight_chapter')):
        return errors

    # The logical roster must equal the immutable historical roster; only the
    # commit namespace and the body paths/models may differ.
    current_inventory = manifest.get('current_inventory')
    if not isinstance(current_inventory, dict):
        errors.append('Current inventory is missing from the manifest')
        current_inventory = {}
    else:
        if current_inventory.get('entry_count') != EXPECTED_CURRENT_ENTRY_COUNT:
            errors.append(f'Current inventory is not {EXPECTED_CURRENT_ENTRY_COUNT} entries: '
                          f'{current_inventory.get("entry_count")}')
        if current_inventory.get('definition_count') != EXPECTED_CURRENT_DEFINITION_COUNT:
            errors.append(f'Current inventory is not {EXPECTED_CURRENT_DEFINITION_COUNT} bodies')
        if current_inventory.get('emission_unit_count') != EXPECTED_CURRENT_EMISSION_UNIT_COUNT:
            errors.append(f'Current inventory is not {EXPECTED_CURRENT_EMISSION_UNIT_COUNT} emission units')
        if current_inventory.get('template_entry_count') != EXPECTED_CURRENT_TEMPLATE_COUNT:
            errors.append(f'Current inventory is not {EXPECTED_CURRENT_TEMPLATE_COUNT} templates')
    new_entries = current_inventory.get('entries') or {}
    old_entries = (manifest.get('inventory') or {}).get('entries') or {}
    def _logical(entries):
        return {(name, entry.get('namespace', ''), entry.get('parameters', ''))
                for name, entry in entries.items()}
    if _logical(new_entries) != _logical(old_entries):
        errors.append('Current logical export roster does not equal the immutable historical roster')
    current_headers = {'csrc/' + entry['header'] for entry in new_entries.values()
                       if entry.get('header')}
    missing_headers = sorted(current_headers - set(current_files))
    if missing_headers:
        errors.append(f'Current entry headers lack manifest hashes: {missing_headers}')
    current_dependencies_map = manifest.get('current_dependencies')
    if not isinstance(current_dependencies_map, dict) or not current_dependencies_map:
        errors.append('Current dependency bundles are missing from the manifest')
        current_dependencies_map = {}
    for path, dependencies in current_dependencies_map.items():
        if path not in current_files:
            errors.append(f'{path}: current dependency bundle owner lacks a manifest hash')
        if not isinstance(dependencies, list) or not dependencies:
            errors.append(f'{path}: current dependency bundle is empty')
            continue
        for dependency in dependencies:
            if dependency not in current_files:
                errors.append(f'{path}: current dependency lacks a manifest hash: {dependency}')
            if _git_blob(revision, dependency) is None:
                errors.append(f'{path}: current dependency is absent at {revision}: {dependency}')
    current_source_paths = manifest.get('current_source_paths')
    if not isinstance(current_source_paths, list) or not current_source_paths:
        errors.append('Current source copy list is missing from the manifest')
        current_source_paths = []
    for path in current_source_paths:
        if path not in current_files:
            errors.append(f'{path}: current source copy lacks a manifest hash')
    source_path_set = set(current_source_paths)
    for path, dependencies in current_dependencies_map.items():
        for dependency in dependencies:
            if dependency not in source_path_set:
                errors.append(f'{path}: dependency is not in the current source bundle: '
                              f'{dependency}')
    chapter = manifest.get('flashlight_chapter')
    if not isinstance(chapter, dict):
        errors.append('FlashLight chapter metadata is missing from the manifest')
    else:
        if chapter.get('slug') != 'flashlight':
            errors.append('FlashLight chapter metadata names the wrong slug')
        if tuple(chapter.get('sections') or ()) != EXPECTED_FLASHLIGHT_SECTIONS:
            errors.append('FlashLight chapter metadata does not record the six required sections')
        if chapter.get('source_revision') != revision:
            errors.append('FlashLight chapter metadata names a different implementation revision')
    return errors


def check_current_source_copies(guide, manifest):
    """Verify the separate source-current tree against committed blobs."""
    errors = []
    revision = manifest.get('refactor_source_revision')
    root = guide / 'source-current'
    expected = set(manifest.get('current_source_paths') or [])
    if revision is None:
        if root.is_dir() and any(root.rglob('*')):
            errors.append('source-current/ exists without a configured implementation commit')
        return errors
    if not isinstance(revision, str) or re.fullmatch(r'[0-9a-f]{40}', revision) is None:
        return errors
    for path in sorted(expected):
        committed = _git_blob(revision, path)
        copy = root / path
        if committed is None:
            errors.append(f'source-current/{path}: source is absent at {revision}')
        elif not copy.is_file() or _normalized_lf(copy.read_text(encoding='utf-8')) != committed:
            errors.append(f'source-current/{path}: copy differs from its committed blob')
    if root.is_dir():
        for candidate in root.rglob('*'):
            if not candidate.is_file():
                continue
            relative = candidate.relative_to(root).as_posix()
            if relative not in expected:
                errors.append(f'source-current/{relative}: unexpected current source copy')
    return errors


def check_flashlight_chapter(guide, manifest, pages):
    """Validate the rendered current chapter, its links and its evidence state."""
    errors = []
    revision = manifest.get('refactor_source_revision')
    page_path = guide / 'flashlight.html'
    if revision is None:
        if page_path in pages:
            errors.append('flashlight.html exists without a recorded current namespace')
        return errors
    if not isinstance(revision, str) or re.fullmatch(r'[0-9a-f]{40}', revision) is None:
        return errors
    if page_path not in pages:
        errors.append('Missing flashlight.html for the recorded current implementation commit')
        return errors
    text = page_path.read_text(encoding='utf-8')
    body = text.split('<article class="content">', 1)[-1].split('</article>', 1)[0]
    headings = re.findall(r'<h2 id="([^"]+)">(.*?)</h2>', body, re.S)
    if tuple(ident for ident, _ in headings) != EXPECTED_FLASHLIGHT_SECTIONS:
        errors.append('flashlight.html: expected exactly the six forward-design sections')
    fragments = dict(zip(EXPECTED_FLASHLIGHT_SECTIONS,
                         re.split(r'<h2 id="[^"]+">.*?</h2>', body)[1:]))
    for identifier, fragment in fragments.items():
        if '<h3' not in fragment:
            errors.append(f'flashlight.html: section {identifier} has no real subheading')
        if '<p' not in fragment:
            errors.append(f'flashlight.html: section {identifier} has no narrative paragraph')
    resource_heading = dict(headings).get('resources', '')
    if 'resource budget' not in resource_heading.lower():
        errors.append('flashlight.html: section 4 must be the resource budget')
    resource_section = fragments.get('resources', '').lower()
    missing = [marker for marker in EXPECTED_RESOURCE_BUDGET_MARKERS
               if marker.lower() not in resource_section]
    if missing:
        errors.append('flashlight.html: resource-budget section is missing '
                      + ', '.join(missing))
    figures = re.findall(r'<svg\b.*?</svg>', body, re.S)
    if len(figures) < EXPECTED_FLASHLIGHT_SVGS:
        errors.append(f'flashlight.html: expected at least {EXPECTED_FLASHLIGHT_SVGS} bespoke SVGs, '
                      f'found {len(figures)}')
    titles = set()
    for fragment in figures:
        try:
            root = ET.fromstring(fragment)
        except ET.ParseError as exc:
            errors.append(f'flashlight.html: malformed SVG: {exc}')
            continue
        if not root.get('viewBox'):
            errors.append('flashlight.html: SVG is missing viewBox')
        title = root.find('{http://www.w3.org/2000/svg}title')
        desc = root.find('{http://www.w3.org/2000/svg}desc')
        if title is None or not (title.text or '').strip():
            errors.append('flashlight.html: SVG is missing a title')
        elif title.text in titles:
            errors.append(f'flashlight.html: duplicate SVG title {title.text!r}')
        else:
            titles.add(title.text)
        if desc is None or not (desc.text or '').strip():
            errors.append('flashlight.html: SVG is missing a desc')
    for target in ('architecture.html', 'global_ffn_expand_c1024_fp16.html'):
        if f'href="{target}"' not in body:
            errors.append(f'flashlight.html: missing required link {target}')
    if 'href="source-current/' not in body:
        errors.append('flashlight.html: missing source-current bundle links')
    if f'<a href="flashlight.html" aria-current="page">' not in text:
        errors.append('flashlight.html: navigation does not mark the current chapter')
    for source_name in ('index.html', 'source-atlas.html'):
        source_page = guide / source_name
        if source_page not in pages:
            errors.append(f'{source_name}: missing page for the FlashLight link audit')
        elif 'href="flashlight.html"' not in source_page.read_text(encoding='utf-8'):
            errors.append(f'{source_name}: missing FlashLight chapter link')
    if not any(page.get('slug') == 'flashlight'
               for page in manifest.get('pages', [])):
        errors.append('Manifest pages do not include the FlashLight chapter')
    if text.count(f'/tree/{revision}') < 2:
        errors.append('flashlight.html: sidebar and footer must both display the current '
                      'implementation revision')
    if f'{revision[:12]}' not in text:
        errors.append('flashlight.html: current implementation revision is not displayed')
    for forbidden in ('href="evidence/', 'href="evidence-small/', 'href="source/',
                      'class="measured-evidence"'):
        if forbidden in body:
            errors.append(f'flashlight.html: current chapter reuses historical evidence '
                          f'content {forbidden!r}')
    chapter = manifest.get('flashlight_chapter') or {}
    evidence_state = chapter.get('evidence_state')
    if evidence_state != 'accepted':
        errors.append(
            'flashlight.html: final current-chapter publication requires accepted '
            f'evidence; recorded state is {evidence_state!r}')
    else:
        if not isinstance(manifest.get('flashlight_evidence'), dict):
            errors.append('flashlight.html: accepted state has no bound acceptance bundle '
                          'metadata')
        for ident in ('trace-acceptance', 'trace-checks', 'trace-provenance'):
            if f'id="{ident}"' not in body:
                errors.append(f'flashlight.html: accepted evidence is missing #{ident}')
    if 'id="accepted-allocations"' not in body:
        errors.append('flashlight.html: accepted ptxas allocation evidence was not rendered')
    if not isinstance(manifest.get('flashlight_evidence'), dict) and (
            re.search(r'\b(?:speedup|GB/s|TB/s)\b', body)
            or re.search(r'\b\d+(?:\.\d+)?\s*(?:ns|µs|us|ms)\b', body)):
        errors.append('flashlight.html: timing/throughput claim appears without an '
                      'accepted paired measurement record')
    return errors


class _CaseTableRows(HTMLParser):
    """Group the generated accepted timing table into rows and cells.

    The chapter renders one plain ``<tr>`` per case and marks the identity with
    ``data-case`` on a span in the first cell.  This small standard-library
    grouping parser only recovers those table cells and their links; it is not a
    general DOM and it does not guess at any other page structure.
    """

    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.case_rows = []
        self.errors = []
        self._row = None
        self._cell = None

    def handle_starttag(self, tag, attrs):
        attributes = dict(attrs)
        if tag == 'tr':
            if self._row is not None:
                self.errors.append('nested accepted per-case table row')
            self._row = {'case_ids': [], 'cells': []}
            self._cell = None
        elif tag == 'td':
            if self._row is None:
                self.errors.append('accepted timing cell outside a table row')
            elif self._cell is not None:
                self.errors.append('nested accepted timing cell')
            else:
                self._cell = {'text': [], 'links': []}
        elif tag == 'br' and self._cell is not None:
            self._cell['text'].append('\n')
        elif tag == 'span':
            case_id = attributes.get('data-case')
            if case_id is not None:
                if self._row is None or self._cell is None:
                    self.errors.append(
                        'accepted case identity outside a timing table cell')
                else:
                    self._row['case_ids'].append(case_id)
        elif tag == 'a' and self._cell is not None:
            href = attributes.get('href')
            if href is not None:
                self._cell['links'].append(href)

    def handle_startendtag(self, tag, attrs):
        self.handle_starttag(tag, attrs)
        self.handle_endtag(tag)

    def handle_data(self, data):
        if self._cell is not None:
            self._cell['text'].append(data)

    def handle_endtag(self, tag):
        if tag == 'td' and self._cell is not None:
            if self._row is None:
                self.errors.append('accepted timing cell without a table row')
            else:
                self._row['cells'].append({
                    'text': ''.join(self._cell['text']),
                    'links': tuple(self._cell['links']),
                })
            self._cell = None
        elif tag == 'tr' and self._row is not None:
            if self._row['case_ids']:
                self.case_rows.append(self._row)
            self._row = None
            self._cell = None


def check_flashlight_evidence(guide, manifest, pages):
    """Independently re-check the accepted bundle and its rendered rows/links.

    The shared typed parser owns schema/identity/artifact-file checks.  This
    function independently asserts the exact 16-case matrix, the eight-child
    protocol, the required gate set, the ptxas/FFN/reserved split, and that each
    rendered per-case table row carries that case's unique identity, visible
    values and timing-receipt link.
    """
    errors = []
    revision = manifest.get('refactor_source_revision')
    recorded = manifest.get('flashlight_evidence')
    if revision is None:
        if recorded is not None:
            errors.append('flashlight_evidence exists without a current implementation commit')
        return errors
    if not isinstance(recorded, dict):
        errors.append('Manifest is missing the bound flashlight_evidence metadata')
        recorded = {}
    path = guide / 'evidence-flashlight' / 'acceptance.json'
    if not path.is_file():
        errors.append('Missing canonical evidence-flashlight/acceptance.json')
        return errors
    raw = path.read_bytes()
    sha = hashlib.sha256(raw).hexdigest()
    if sha != recorded.get('sha256'):
        errors.append('Acceptance report SHA-256 disagrees with the manifest')
    try:
        acceptance = evidence_model.load_acceptance(
            path, revision, bundle_root=path.parent)
    except Exception as exc:
        errors.append(f'Acceptance bundle cannot be validated: {exc}')
        return errors

    if acceptance.sha256 != sha:
        errors.append('Acceptance loader reported a different report SHA-256')
    if acceptance.schema_version != EXPECTED_ACCEPTANCE_SCHEMA_VERSION:
        errors.append('Acceptance schema version is not the expected version')
    if acceptance.state != 'accepted':
        errors.append('Acceptance state is not accepted')
    if acceptance.original_source_revision != EXPECTED_ORIGINAL_REFERENCE:
        errors.append('Acceptance does not name the frozen source-replay snapshot')
    if acceptance.candidate_source_revision != revision:
        errors.append('Acceptance candidate revision differs from the configured chapter')
    for key, value in (('acceptance_id', acceptance.acceptance_id),
                       ('schema_version', acceptance.schema_version),
                       ('state', acceptance.state),
                       ('original_source_revision', acceptance.original_source_revision),
                       ('candidate_source_revision', acceptance.candidate_source_revision)):
        if recorded.get(key) != value:
            errors.append(f'Manifest flashlight_evidence.{key} disagrees with the bundle')

    # Public portability: no native/executable/checkpoint payload may be
    # registered or copied, and binary identity must come from a receipt.
    if any(artifact.kind == 'binary' for artifact in acceptance.artifacts):
        errors.append('Acceptance publishes a native binary payload artifact')
    for artifact in acceptance.artifacts:
        if Path(artifact.path).suffix.lower() in evidence_model.FORBIDDEN_ARTIFACT_SUFFIXES:
            errors.append(
                f'Acceptance publishes a forbidden payload artifact: {artifact.path}')
    evidence_dir = guide / 'evidence-flashlight'
    if evidence_dir.is_dir():
        payloads = sorted(
            path.relative_to(guide).as_posix()
            for path in evidence_dir.rglob('*')
            if path.is_file()
            and path.suffix.lower() in evidence_model.FORBIDDEN_ARTIFACT_SUFFIXES)
        if payloads:
            errors.append(
                'Acceptance output contains native/executable/checkpoint payloads: '
                + ', '.join(payloads))
    for role, build in (('original', acceptance.original_build),
                        ('candidate', acceptance.candidate_build)):
        if build.provenance_basis not in evidence_model.PROVENANCE_BASES:
            errors.append(f'{role} build provenance basis is not recognized')
        if role == 'candidate':
            if build.provenance_basis != 'preserved-receipt':
                errors.append('Candidate build provenance is not a preserved receipt')
            if build.build_time_head is None or build.dirty is not True:
                errors.append('Candidate build-time checkout/dirty state is not recorded')
            if build.build_time_head == acceptance.candidate_source_revision:
                errors.append(
                    'Candidate build-time HEAD is relabelled as the later implementation '
                    'commit')
        elif build.provenance_basis == 'unknown' and (
                build.build_time_head is not None or build.dirty is not None):
            errors.append('Unknown original build provenance invents HEAD/dirty facts')
        elif build.provenance_basis == 'inferred' and (
                build.build_time_head is None and build.dirty is None):
            errors.append('Inferred original build provenance records no inferred fact')
        if build.build_time_head == acceptance.candidate_source_revision:
            errors.append(
                f'{role} build-time HEAD is relabelled as the later implementation commit')
        if not build.binary_filename or not build.binary_sha256:
            errors.append(f'{role} binary identity is missing')
    if acceptance.provenance_manifest != acceptance.candidate_build.input_manifest:
        errors.append('Source provenance is not bound to the candidate input manifest')
    if acceptance.provenance_files != acceptance.candidate_build.input_files:
        errors.append('Source provenance rows do not equal the candidate input manifest')

    # Exact expected Cartesian matrix, independent of the producer's ordering.
    expected_cases = {
        (model, precision, size, width, height)
        for model in EXPECTED_CASE_MODELS
        for precision in EXPECTED_CASE_PRECISIONS
        for size, width, height in EXPECTED_CASE_SIZES
    }
    actual_cases = {
        (case.model, case.precision, case.size, case.width, case.height)
        for case in acceptance.timing.cases
    }
    if len(acceptance.timing.cases) != 16:
        errors.append('Acceptance timing is not exactly 16 cases')
    if actual_cases != expected_cases or len(actual_cases) != 16:
        errors.append('Acceptance timing is not the exact 16-case Cartesian set')
    if (acceptance.protocol.child_processes_per_case,
            acceptance.protocol.original_processes,
            acceptance.protocol.candidate_processes) != (
            EXPECTED_PROCESSES_PER_CASE, EXPECTED_ARM_PROCESSES,
            EXPECTED_ARM_PROCESSES):
        errors.append('Acceptance protocol is not 8 children with 4 + 4 process medians')
    if (len(acceptance.protocol.process_order),
            acceptance.protocol.process_order.count('original'),
            acceptance.protocol.process_order.count('candidate')) != (
            EXPECTED_PROCESSES_PER_CASE, EXPECTED_ARM_PROCESSES,
            EXPECTED_ARM_PROCESSES):
        errors.append('Acceptance process order does not preserve 4 + 4 child pairing')
    expected_orders = (
        ('original', 'candidate', 'candidate', 'original',
         'candidate', 'original', 'original', 'candidate'),
        ('candidate', 'original', 'original', 'candidate',
         'original', 'candidate', 'candidate', 'original'),
    )
    if tuple(acceptance.protocol.process_order) not in expected_orders:
        errors.append('Acceptance process order is not the fixed ABBA/BAAB pairing')
    for case in acceptance.timing.cases:
        if len(case.original_process_medians_ms) != EXPECTED_ARM_PROCESSES:
            errors.append(f'{case.id}: original arm is not four process medians')
        if len(case.candidate_process_medians_ms) != EXPECTED_ARM_PROCESSES:
            errors.append(f'{case.id}: candidate arm is not four process medians')
        if (case.original_range_ms != (min(case.original_process_medians_ms),
                                       max(case.original_process_medians_ms))
                or case.candidate_range_ms != (min(case.candidate_process_medians_ms),
                                               max(case.candidate_process_medians_ms))):
            errors.append(f'{case.id}: process uncertainty is inconsistent with the medians')
        if case.decision_status not in ('accepted', 'no-detected-slowdown'):
            errors.append(f'{case.id}: accepted timing contains decision '
                          f'{case.decision_status!r}')
    if acceptance.timing.decision_status != 'accepted':
        errors.append('Acceptance timing decision is not accepted')
    if acceptance.decision_status != 'accepted':
        errors.append('Acceptance overall decision is not accepted')

    categories = tuple(check.category for check in acceptance.checks)
    if set(categories) != set(EXPECTED_CHECK_CATEGORIES) or len(categories) != 8:
        errors.append('Acceptance does not contain exactly the eight required check categories')
    for check in acceptance.checks:
        if check.status != 'pass':
            errors.append(f'{check.category}: required check is not passing')
        if not check.covered_cases:
            errors.append(f'{check.category}: check does not record covered cases')
    native = next((check for check in acceptance.checks
                   if check.category == 'native-bitwise'), None)
    if native is None or (native.covered_cases != ('all',)
                          and set(native.covered_cases) != {case.id for case in acceptance.timing.cases}):
        errors.append('native-bitwise check does not cover all 16 timing cases')

    ffn_rows = [row for row in acceptance.ptxas.rows
                if 'global_ffn_expand' in row.kernel and row.architecture == 'SM120']
    if not ffn_rows:
        errors.append('Acceptance lacks the final FFN kernel SM120 ptxas row')
    if acceptance.ptxas.cuobjdump_reserved_bytes != 1024:
        errors.append('Acceptance does not preserve the separate 1024-byte SM120 reserved region')

    if acceptance.case_rows_sha256() != recorded.get('case_rows_sha256'):
        errors.append('Accepted timing row digest disagrees with the manifest')
    if acceptance.gate_rows_sha256() != recorded.get('gate_rows_sha256'):
        errors.append('Accepted gate row digest disagrees with the manifest')
    recorded_artifacts = recorded.get('artifacts')
    actual_artifacts = [
        dict(path=artifact.path, sha256=artifact.sha256,
             kind=artifact.kind, identity=artifact.identity)
        for artifact in acceptance.artifacts
    ]
    if recorded_artifacts != actual_artifacts:
        errors.append('Manifest artifact registry disagrees with the validated bundle')

    page_path = guide / 'flashlight.html'
    if page_path not in pages:
        errors.append('Missing flashlight.html for the accepted evidence bundle')
        return errors
    body = page_path.read_text(encoding='utf-8').split(
        '<article class="content">', 1)[-1].split('</article>', 1)[0]

    for role, build in (('original', acceptance.original_build),
                        ('candidate', acceptance.candidate_build)):
        if build.provenance_basis not in body:
            errors.append(f'flashlight.html: {role} provenance basis is not rendered')
        if html_escape(build.provenance_note) not in body:
            errors.append(f'flashlight.html: {role} provenance note is not rendered')
        if build.binary_filename not in body:
            errors.append(f'flashlight.html: {role} binary filename is not displayed')
        if build.binary_sha256 not in body:
            errors.append(f'flashlight.html: {role} binary SHA-256 is not displayed')
        if build.build_time_head is None:
            if 'unknown (not recorded)' not in body:
                errors.append(f'flashlight.html: {role} unknown build HEAD is not stated')
        elif build.build_time_head not in body:
            errors.append(f'flashlight.html: {role} build-time HEAD is not displayed')
        if build.dirty is None:
            if 'unknown (not recorded)' not in body:
                errors.append(f'flashlight.html: {role} unknown worktree state is not stated')
        else:
            expected_worktree = 'dirty' if build.dirty else 'clean'
            if expected_worktree not in body:
                errors.append(f'flashlight.html: {role} worktree state is not displayed')
        for ref, label in ((build.build_receipt, 'build receipt'),
                           (build.input_manifest, 'input manifest')):
            if f'evidence-flashlight/{ref.path}' not in body:
                errors.append(f'flashlight.html: {role} {label} is not linked')
            if ref.sha256 not in body:
                errors.append(f'flashlight.html: {role} {label} SHA-256 is not displayed')
    for item in acceptance.provenance_files:
        if item.path not in body:
            errors.append(f'flashlight.html: measured source path {item.path} is not displayed')
        if item.raw_file_sha256 not in body:
            errors.append(f'flashlight.html: {item.path} raw digest is not displayed')
        if item.normalized_lf_sha256 not in body:
            errors.append(f'flashlight.html: {item.path} normalized digest is not displayed')

    if acceptance.sha256 not in body:
        errors.append('flashlight.html: acceptance report SHA-256 is not displayed')
    if acceptance.acceptance_id not in body:
        errors.append('flashlight.html: acceptance identity is not displayed')
    if 'href="evidence-flashlight/acceptance.json"' not in body:
        errors.append('flashlight.html: acceptance report is not linked')
    case_rows = _CaseTableRows()
    case_rows.feed(body)
    for message in case_rows.errors:
        errors.append(f'flashlight.html: {message}')
    rendered_rows = case_rows.case_rows
    accepted_by_id = {case.id: case for case in acceptance.timing.cases}
    rendered_ids = [case_id for row in rendered_rows for case_id in row['case_ids']]
    if len(rendered_rows) != len(accepted_by_id):
        errors.append(
            f'flashlight.html: accepted per-case table has {len(rendered_rows)} rows, '
            f'expected {len(accepted_by_id)}')
    if len(rendered_ids) != len(set(rendered_ids)):
        errors.append('flashlight.html: accepted per-case rows repeat a case identity')
    missing = sorted(set(accepted_by_id) - set(rendered_ids))
    if missing:
        errors.append('flashlight.html: missing accepted row(s) ' + ', '.join(missing))
    unexpected = sorted(set(rendered_ids) - set(accepted_by_id))
    if unexpected:
        errors.append('flashlight.html: unexpected accepted row identity/identities '
                      + ', '.join(unexpected))
    timing_receipt_href = f'evidence-flashlight/{acceptance.timing.receipt.path}'
    for row in rendered_rows:
        case_ids = row['case_ids']
        if len(case_ids) != 1:
            errors.append(
                'flashlight.html: accepted per-case row must carry exactly one case '
                f'identity, found {case_ids}')
            continue
        case = accepted_by_id.get(case_ids[0])
        if case is None:
            continue
        expected_cells = (
            f'{case.model} {case.precision.upper()} · {case.width}×{case.height} '
            f'({case.size})',
            ', '.join(evidence_model.format_ms(item)
                      for item in case.original_process_medians_ms),
            evidence_model.format_ms(case.original_median_ms),
            ', '.join(evidence_model.format_ms(item)
                      for item in case.candidate_process_medians_ms),
            evidence_model.format_ms(case.candidate_median_ms),
            evidence_model.format_speedup(case.speedup),
            (evidence_model.format_range(*case.original_range_ms) + '\n'
             + evidence_model.format_range(*case.candidate_range_ms)),
            case.decision_status,
            'timing receipt',
        )
        if len(row['cells']) != len(expected_cells):
            errors.append(
                f'flashlight.html: {case.id} per-case row has {len(row["cells"])} '
                f'cells, expected {len(expected_cells)}')
            continue
        for index, (cell, wanted) in enumerate(zip(row['cells'], expected_cells)):
            if cell['text'] != wanted:
                errors.append(
                    f'flashlight.html: {case.id} per-case row column {index} shows '
                    f'{cell["text"]!r}, expected {wanted!r}')
        if timing_receipt_href not in row['cells'][-1]['links']:
            errors.append(
                f'flashlight.html: {case.id} per-case row does not link the accepted '
                'timing receipt')
    for check in acceptance.checks:
        if f'data-check="{check.category}"' not in body:
            errors.append(f'flashlight.html: missing check category {check.category}')
        if f'evidence-flashlight/{check.receipt.path}' not in body:
            errors.append(f'flashlight.html: missing {check.category} receipt link')
    for artifact in acceptance.artifacts:
        if f'evidence-flashlight/{artifact.path}' not in body:
            errors.append(f'flashlight.html: missing artifact link {artifact.path}')
    for row in ffn_rows:
        for value in (row.kernel, f'{row.static_shared_bytes:,}', str(row.spill_bytes)):
            if value not in body:
                errors.append(f'flashlight.html: missing ptxas value {value!r}')
    if '1,024' not in body:
        errors.append('flashlight.html: separate SM120 reserved 1,024 bytes is not displayed')
    if acceptance.ncu.state == 'current':
        for report in acceptance.ncu.reports:
            if f'evidence-flashlight/{report.path}' not in body:
                errors.append('flashlight.html: current NCU report is not linked')
    elif 'No current NCU evidence' not in body:
        errors.append('flashlight.html: absent current NCU evidence is not stated')
    for pending_phrase in ('evidence is pending', 'evidence state is pending',
                           'runtime evidence: pending', 'accepted evidence is pending'):
        if pending_phrase in body.lower():
            errors.append('flashlight.html: accepted chapter contains pending-evidence wording')
    chapter = manifest.get('flashlight_chapter') or {}
    if chapter.get('evidence_sha256') != acceptance.sha256:
        errors.append('Manifest chapter metadata does not bind the report SHA-256')
    if chapter.get('evidence_acceptance_id') != acceptance.acceptance_id:
        errors.append('Manifest chapter metadata does not bind the acceptance identity')
    if chapter.get('candidate_source_revision') != revision:
        errors.append('Manifest chapter metadata names a different candidate revision')
    if chapter.get('evidence_case_rows_sha256') != acceptance.case_rows_sha256():
        errors.append('Manifest chapter metadata does not bind the case-row digest')
    if chapter.get('evidence_gate_rows_sha256') != acceptance.gate_rows_sha256():
        errors.append('Manifest chapter metadata does not bind the gate-row digest')
    if chapter.get('evidence_artifacts') != actual_artifacts:
        errors.append('Manifest chapter artifact registry disagrees with the validated bundle')
    return errors


class Page(HTMLParser):
    def __init__(self, path):
        super().__init__(convert_charrefs=True)
        self.ids=[]; self.links=[]; self.h1=0; self.images=0
        self.stack=[]; self.glossary_terms=0
        self.feed(path.read_text(encoding='utf-8'))
    def handle_starttag(self, tag, attrs):
        attrs=dict(attrs)
        if 'glossary-term' in attrs.get('class','').split():
            assert tag=='a' and attrs.get('href','').startswith('glossary.html#'), 'Glossary term must link to its entry'
            assert attrs.get('data-term') and attrs.get('data-definition'), 'Glossary tooltip needs a label and definition'
            assert not {'a','pre','code','svg'}.intersection(self.stack), 'Glossary annotation inside protected source, diagram or link'
            self.glossary_terms+=1
        if tag not in {'area','base','br','col','embed','hr','img','input','link','meta','param','source','track','wbr'}:
            self.stack.append(tag)
        if 'id' in attrs:self.ids.append(attrs['id'])
        if tag=='h1':self.h1+=1
        if tag=='img':
            self.images+=1
            assert attrs.get('alt'), 'Image needs alt text'
        for attr in ('href','src'):
            if attrs.get(attr):self.links.append(attrs[attr])

    def handle_endtag(self, tag):
        if tag in self.stack:
            del self.stack[len(self.stack)-1-self.stack[::-1].index(tag):]

    def handle_startendtag(self, tag, attrs):
        self.handle_starttag(tag, attrs)
        self.handle_endtag(tag)


def main(argv=None):
    global GUIDE
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', help='documentation output root '
                        '(default: DLSSNR_DOCS_OUTPUT or docs/kernel-guide)')
    parser.add_argument('--historical-only', action='store_true',
                        help='validate a historical-only site; ignore the configured '
                             'current pin and require no current FlashLight chapter')
    args = parser.parse_args(argv)
    GUIDE = configure_output_root(args.output)
    pages={path:Page(path) for path in GUIDE.glob('*.html')}
    errors=[]; diagrams=0; checked_links=0
    historical_only = args.historical_only
    try:
        configured_refactor = configured_current_revision(historical_only)
    except ValueError as exc:
        configured_refactor = None
        errors.append(str(exc))
    baseline_text, baseline = _baseline_manifest()
    if baseline is None:
        errors.append('Cannot read the frozen baseline source manifest at the immutable '
                      'original reference')
        baseline_text, baseline = '', {'files': {}, 'file_revisions': {}, 'snippets': []}
    else:
        errors.extend(check_baseline_literals(baseline_text, baseline))
    from cyberpunk_comparison import load_accepted
    comparison_accepted = load_accepted() is not None
    manifest = json.loads((GUIDE/'source-manifest.json').read_text(encoding='utf-8'))
    recorded_revision = manifest.get('refactor_source_revision')
    current_present = configured_refactor is not None
    if historical_only:
        if recorded_revision is not None:
            errors.append('Historical-only validation cannot accept a manifest with a '
                          'current implementation namespace')
        if manifest.get('flashlight_evidence') is not None:
            errors.append('Historical-only validation cannot accept a bound current '
                          'acceptance bundle')
        if (GUIDE/'flashlight.html') in pages:
            errors.append('Historical-only validation cannot accept flashlight.html')
    elif configured_refactor is None:
        if recorded_revision is not None:
            errors.append('Manifest records a current FlashLight chapter, but no module '
                          'implementation pin is configured; the configured current '
                          'chapter cannot be silently omitted')
        if manifest.get('flashlight_evidence') is not None:
            errors.append('Manifest binds current acceptance evidence without a module pin')
        if (GUIDE/'flashlight.html') in pages:
            errors.append('flashlight.html exists without a configured implementation pin')
    else:
        if recorded_revision != configured_refactor:
            errors.append('Manifest current implementation revision does not equal the '
                          'configured module pin')
        if subprocess.run(['git', 'cat-file', '-e', f'{configured_refactor}^{{commit}}'],
                          cwd=ROOT, capture_output=True).returncode != 0:
            errors.append('The configured module implementation pin is not a real commit')
        if (GUIDE/'flashlight.html') not in pages:
            errors.append('A current implementation pin is configured but flashlight.html '
                          'is missing')
    expected_pages = (99 if comparison_accepted else 98) + (1 if current_present else 0)
    if len(pages) != expected_pages:
        errors.append(f'Expected {expected_pages} guide pages from accepted inputs, found {len(pages)}')
    if ((GUIDE/'flashlight.html') in pages) != current_present:
        errors.append('flashlight.html must exist exactly when the configured current '
                      'implementation pin requires it')
    if ((GUIDE/'cyberpunk-comparison.html') in pages) != comparison_accepted:
        errors.append('Comparison page must exist only with accepted, hash-verified media and timings')
    update_page = GUIDE/'runtime-310-9-16.html'
    if update_page not in pages:
        errors.append('Missing runtime-310-9-16.html model update chapter')
    else:
        update_text = update_page.read_text(encoding='utf-8')
        update_body = update_text.split('<article class="content">',1)[-1].split('</article>',1)[0]
        for ident in ('what-changed','model-choice','schedule','mapping','implementation','validation'):
            if ident not in pages[update_page].ids:
                errors.append(f'runtime-310-9-16.html: missing required section #{ident}')
        update_svgs = re.findall(r'<svg\b.*?</svg>',update_body,re.S)
        if len(update_svgs) < 4:
            errors.append(f'runtime-310-9-16.html: expected at least 4 specialized inline SVGs, found {len(update_svgs)}')
        for fragment in update_svgs:
            root = ET.fromstring(fragment)
            children = {child.tag.rsplit('}',1)[-1]: child for child in root}
            if not root.get('viewBox'):
                errors.append('runtime-310-9-16.html: SVG is missing viewBox')
            if children.get('title') is None or not (children['title'].text or '').strip():
                errors.append('runtime-310-9-16.html: SVG is missing a title')
            if children.get('desc') is None or not (children['desc'].text or '').strip():
                errors.append('runtime-310-9-16.html: SVG is missing a desc')
        for source_name in ('index.html','architecture.html','runtime.html'):
            if 'href="runtime-310-9-16.html"' not in (GUIDE/source_name).read_text(encoding='utf-8'):
                errors.append(f'{source_name}: missing prominent link to runtime-310-9-16.html')
        if 'href="runtime-310-9-16.html"' not in update_text:
            errors.append('runtime-310-9-16.html: missing self-discovery link')
    for path,page in pages.items():
        if page.h1!=1: errors.append(f'{path.name}: expected one H1, found {page.h1}')
        dup=[x for x,n in Counter(page.ids).items() if n>1]
        if dup: errors.append(f'{path.name}: duplicate ids {dup}')
        text=path.read_text(encoding='utf-8')
        for link in page.links:
            url=urlsplit(link)
            if url.scheme or url.netloc:continue
            target=(path.parent/unquote(url.path)).resolve() if url.path else path
            checked_links+=1
            if not target.is_file(): errors.append(f'{path.name}: missing {link}');continue
            if target.suffix=='.html' and url.fragment:
                other=pages.get(target) or Page(target)
                if unquote(url.fragment) not in other.ids: errors.append(f'{path.name}: missing anchor {link}')
        for fragment in re.findall(r'<svg\b.*?</svg>',text,re.S):
            diagrams+=1
            try: ET.fromstring(fragment)
            except ET.ParseError as exc: errors.append(f'{path.name}: SVG {exc}')
        refs=re.findall(r'url\(#([^)]*)\)',text)
        for ref in refs:
            if ref not in page.ids: errors.append(f'{path.name}: missing SVG reference #{ref}')
    if len(manifest.get('pages',[])) != expected_pages:
        errors.append(f'Manifest expected {expected_pages} guide pages, found {len(manifest.get("pages",[]))}')
    if not any(p.get('slug')=='runtime-310-9-16' for p in manifest.get('pages',[])):
        errors.append('Manifest is missing runtime-310-9-16')
    entries=manifest['inventory']['entries']
    if len(entries)!=83:
        errors.append(f'Expected 83 public entries, found {len(entries)}')
    if len({e['definition'] for e in entries.values()})!=58:
        errors.append('Expected 58 owning CUDA definitions')
    small_names=set(SMALL_NAMES)
    legacy_names=set(entries)-small_names
    if len(small_names)!=2 or not small_names.issubset(entries):
        errors.append('Inventory does not contain exactly the two additive Small31 attention entries')
    if len(legacy_names)!=81:
        errors.append(f'Expected 81 legacy entries after the additive split, found {len(legacy_names)}')
    lessons=manifest.get('lessons',[])
    if len(lessons)!=83 or {p['name'] for p in lessons}!=set(entries):
        errors.append('Expected exactly one standalone lesson for every public entry (83)')
    counts=manifest.get('lesson_counts',{})
    if counts.get('total')!=83 or counts.get('legacy')!=81 or counts.get('additive')!=2:
        errors.append(f'Manifest lesson counts are not 83/81/2: {counts}')
    if manifest.get('source_revision')!=LEGACY_REVISION:
        errors.append('Legacy source_revision moved away from the historical 310.8 pin')
    if manifest.get('runtime_source_revision')!=EXPECTED_RUNTIME_REVISION or RUNTIME_REVISION!=EXPECTED_RUNTIME_REVISION:
        errors.append('Runtime source revision is not the committed Small31 pin')
    checkpoint_api_revision=manifest.get('checkpoint_api_source_revision')
    if tuple(CHECKPOINT_API_SOURCE_PATHS) != EXPECTED_CHECKPOINT_API_SOURCE_PATHS:
        errors.append(f'CHECKPOINT_API_SOURCE_PATHS must be exactly '
                      f'{EXPECTED_CHECKPOINT_API_SOURCE_PATHS}, found '
                      f'{CHECKPOINT_API_SOURCE_PATHS}')
    if tuple(CHECKPOINT_API_HISTORICAL_PATHS) != EXPECTED_CHECKPOINT_API_HISTORICAL_PATHS:
        errors.append(f'CHECKPOINT_API_HISTORICAL_PATHS must stay the two-file historical '
                      f'subset {EXPECTED_CHECKPOINT_API_HISTORICAL_PATHS}, found '
                      f'{CHECKPOINT_API_HISTORICAL_PATHS}')
    if not set(EXPECTED_CHECKPOINT_API_HISTORICAL_PATHS) < set(EXPECTED_CHECKPOINT_API_SOURCE_PATHS):
        errors.append('Checkpoint API historical paths are not a strict subset of the '
                      'three API source paths')
    if CHECKPOINT_API_REVISION is None:
        errors.append('Checkpoint API source revision is unconfigured; set '
                      'DLSSNR_CHECKPOINT_API_REVISION to the accepted full 40-character '
                      'checkpoint implementation commit before publishing the guide')
    elif (checkpoint_api_revision!=CHECKPOINT_API_REVISION
          or not re.fullmatch(r'[0-9a-f]{40}',str(checkpoint_api_revision))):
        errors.append('Checkpoint API source revision does not match the configured '
                      'checkpoint implementation commit')
    index=(GUIDE/'index.html').read_text(encoding='utf-8')
    glossary=GUIDE/'glossary.html'
    if glossary not in pages or 'publish' not in pages[glossary].ids:
        errors.append('Missing glossary or publish definition')
    for lesson in lessons:
        path=GUIDE/(lesson['slug']+'.html')
        if path not in pages:
            errors.append(f'Missing lesson {lesson["name"]}');continue
        text=path.read_text(encoding='utf-8')
        if not pages[path].glossary_terms:errors.append(f'{path.name}: missing glossary annotations')
        body=text.split('<article class="content">',1)[-1].split('</article>',1)[0]
        headings=re.findall(r'<h2 id="([^"]+)">(.*?)</h2>',body,re.S)
        expected_sections=['problem','cta','warp','resources','schedule','trace']
        if [h[0] for h in headings]!=expected_sections:errors.append(f'{path.name}: expected the exact six-section learning sequence')
        if 'source-appendix' not in pages[path].ids:errors.append(f'{path.name}: missing complete source appendix')
        sections=dict((m[1],m[2]) for m in re.finditer(r'<h2 id="([^"]+)">.*?</h2>(.*?)(?=<h2 |\Z)',body,re.S))
        for section in ('problem','cta','warp','schedule','trace'):
            if '<svg' not in sections.get(section,''):errors.append(f'{path.name}: {section} needs a specialized SVG')
        if 'measured-resources' not in pages[path].ids or 'ncu-evidence' not in pages[path].ids:errors.append(f'{path.name}: missing measured evidence')
        for ident in ('design-review','measured-resources','ncu-evidence'):
            if f'id="{ident}"' not in sections.get('trace',''):errors.append(f'{path.name}: {ident} must validate the implementation in section 6')
        if 'id="design-review"' in body and body.rfind('data-kernel-map=')>body.index('id="design-review"'):
            errors.append(f'{path.name}: finish the storage/tiling construction before final validation')
        if any('class="measured-evidence"' in sections.get(key,'') for key in expected_sections[:-1]):
            errors.append(f'{path.name}: measured tables precede the design/implementation sequence')
        if '<!-- RESOURCE_EVIDENCE -->' in body or '<!-- NCU_EVIDENCE -->' in body:errors.append(f'{path.name}: unfilled evidence placeholder')
        if f'href="{lesson["slug"]}.html"' not in index:errors.append(f'{path.name}: not discoverable in catalog')
        if 'class="pseudocode"' not in body:errors.append(f'{path.name}: missing teaching algorithm')
    errors.extend(check_old_namespace(manifest, baseline))
    errors.extend(check_source_copies(GUIDE, manifest))
    if historical_only:
        # Historical-only mode still audits the complete historical namespace
        # and rejects any stray additive current namespace, but it deliberately
        # ignores the configured current pin and its evidence.
        errors.extend(check_current_namespace(manifest, None))
        errors.extend(check_current_source_copies(GUIDE, manifest))
    else:
        errors.extend(check_current_namespace(manifest, configured_refactor))
        errors.extend(check_current_source_copies(GUIDE, manifest))
        errors.extend(check_flashlight_chapter(GUIDE, manifest, pages))
        errors.extend(check_flashlight_evidence(GUIDE, manifest, pages))
    file_revisions=manifest.get('file_revisions')
    if not isinstance(file_revisions,dict) or not file_revisions:
        errors.append('Manifest is missing per-file provenance (file_revisions)')
        file_revisions={}
    runtime_paths=set(RUNTIME_SOURCE_PATHS)
    checkpoint_paths=set(CHECKPOINT_API_SOURCE_PATHS)
    if len(runtime_paths)!=len(RUNTIME_SOURCE_PATHS):
        errors.append('RUNTIME_SOURCE_PATHS contains duplicate paths')
    if len(checkpoint_paths)!=len(CHECKPOINT_API_SOURCE_PATHS):
        errors.append('CHECKPOINT_API_SOURCE_PATHS contains duplicate paths')
    for path in sorted(runtime_paths):
        if path not in manifest.get('files', {}):
            errors.append(f'Declared runtime source is missing from manifest files: {path}')
        if path not in file_revisions:
            errors.append(f'Declared runtime source is missing per-file provenance: {path}')
        if path in checkpoint_paths:
            # Checkpoint API ownership takes precedence for the shared path.
            continue
        info = file_revisions.get(path) or {}
        if info.get('kind') != 'runtime-commit' or info.get('revision') != EXPECTED_RUNTIME_REVISION:
            errors.append(f'{path}: runtime source must use runtime-commit provenance')
    for path in sorted(checkpoint_paths):
        if path not in manifest.get('files', {}):
            errors.append(f'Declared checkpoint API source is missing from manifest files: {path}')
        if path not in file_revisions:
            errors.append(f'Declared checkpoint API source is missing per-file provenance: {path}')
        info = file_revisions.get(path) or {}
        if info.get('kind') != 'checkpoint-api-commit':
            errors.append(f'{path}: checkpoint API source must use checkpoint-api-commit '
                          f'provenance, found {info.get("kind")!r}')
        elif not CHECKPOINT_API_REVISION or info.get('revision') != CHECKPOINT_API_REVISION:
            errors.append(f'{path}: checkpoint API provenance does not match the '
                          'configured checkpoint implementation commit')
    for path in EXPECTED_CHECKPOINT_API_SOURCE_PATHS:
        info = file_revisions.get(path) or {}
        if info.get('kind') != 'checkpoint-api-commit':
            errors.append(f'{path}: declared checkpoint API source is missing or misclassified')
            continue
        committed = _git_blob(CHECKPOINT_API_REVISION, path) if CHECKPOINT_API_REVISION else None
        if committed is None:
            errors.append(f'{path}: checkpoint API source is absent at its commit')
    maps=json.loads((GUIDE/'kernel-map-manifest.json').read_text(encoding='utf-8'))
    small_maps=json.loads((GUIDE/'kernel-map-manifest-small.json').read_text(encoding='utf-8'))
    design_checks=json.loads((GUIDE/'evidence/design-checks.json').read_text(encoding='utf8'))
    small_checks=json.loads((GUIDE/'evidence-small/design-checks.json').read_text(encoding='utf8'))
    if set(design_checks['kernels'])!=legacy_names:
        errors.append('Legacy design checks must cover exactly the 81 historical entries')
    if design_checks['source_revision']!=manifest['source_revision']:
        errors.append('Legacy design checks use a different source revision')
    for name,record in design_checks['kernels'].items():
        if record['source_shared_bytes']!=record['measured_static_shared_bytes']:errors.append(f'Design resource prediction mismatch: {name}')
        for count in record.get('tensor_instruction_counts',[]):
            if count['predicted']!=count['observed']:errors.append(f'Design MMA prediction mismatch: {name}')
    if set(small_checks['kernels'])!=small_names:
        errors.append('Additive design checks must cover exactly the two Small31 entries')
    if small_checks.get('source_revision')!=EXPECTED_RUNTIME_REVISION:
        errors.append('Additive design checks use a different runtime source revision')
    if small_checks.get('state')!='measured' or small_checks.get('ncu_state')!='measured':
        errors.append('Additive design checks are not in the measured state')
    if small_checks.get('fixture_id')!='cyberpunk2077-johnny-first4k-b31':
        errors.append('Additive design checks use the wrong fixture identity')
    if small_checks.get('runtime_binary_sha256')!='f0d514043dda98bbe0043ac14d1d93a13e6620eae1c0338d1e3901c017528938':
        errors.append('Additive design checks use the wrong native binary')
    for name,record in small_checks['kernels'].items():
        if record.get('status')!='measured':
            errors.append(f'Additive design check state is not measured: {name}')
        if record.get('ncu_measured') is not True:
            errors.append(f'Additive design check does not record the NCU measurement: {name}')
        if record.get('source_shared_bytes')!=record.get('compiled_static_shared_bytes'):
            errors.append(f'Additive static shared prediction mismatch: {name}')
        if record.get('compiled_static_shared_bytes') in (None,0) or record.get('compiled_registers_per_thread') in (None,0):
            errors.append(f'Additive design check is missing compiled resources: {name}')
        if record.get('source_sha256') != manifest['files'].get(record.get('source')):
            errors.append(f'Additive design check source hash disagrees with the manifest: {name}')
        if len(record.get('reports') or []) != 2:
            errors.append(f'Additive design check must carry the full/source pair: {name}')
        measured=record.get('measured') or {}
        if not measured.get('duration_ns') or not measured.get('pcsamp_samples'):
            errors.append(f'Additive design check lacks substantive measured values: {name}')
        if record.get('tensor_instruction_counts'):
            errors.append(f'Additive design check invented per-opcode NCU instruction counts: {name}')
    profiles={p['name']:p for p in maps['profiles']}
    small_profiles={p['name']:p for p in small_maps['profiles']}
    if set(profiles)!=legacy_names:errors.append('Legacy SVG profiles must cover exactly the 81 historical entries')
    if set(small_profiles)!=small_names:errors.append('Additive SVG profiles must cover exactly the two Small31 entries')
    if set(profiles)|set(small_profiles)!=set(entries):errors.append('Per-kernel SVG profiles do not cover all 83 entries')
    by_kernel={name:[] for name in entries}
    for record in maps['diagrams']+small_maps['diagrams']:
        target=GUIDE/record['path']
        if not target.is_file():errors.append(f'Missing standalone SVG: {target}');continue
        data=target.read_bytes()
        if hashlib.sha256(data).hexdigest()!=record['sha256']:errors.append(f'SVG hash drift: {target}')
        root=ET.fromstring(data)
        if root.get('data-kernel')!=record['kernel']:errors.append(f'SVG identity mismatch: {target}')
        by_kernel[record['kernel']].append(record['kind'])
        page=(GUIDE/(record['kernel']+'.html')).read_text(encoding='utf-8')
        if f'href="{record["path"]}"' not in page:errors.append(f'SVG missing export link: {target}')
    for name,p in profiles.items():
        expected={'ownership'} if p['kind'] in ('counter','repack') else {'flow','tiling','storage'}
        if not expected.issubset(by_kernel[name]):errors.append(f'Incomplete specialized atlas: {name}')
        if p['source']!='csrc/'+entries[name]['header']:errors.append(f'Incorrect atlas source: {name}')
        if p['kind'] not in ('counter','repack'):
            if p['warps']*p['wm']*p['wn']!=p['cm']*p['cn']:errors.append(f'Warp ownership does not cover CTA: {name}')
            if p['shared_kind'] in ('ring','gather'):
                if p['slotbytes']!=p['cm']*p['step']*p['e']:errors.append(f'Input staging byte count mismatch: {name}')
                if p['shared']!=p['slots']*(p['slotbytes']+8):errors.append(f'Barrier allocation mismatch: {name}')
            if p['splits']>1 and 'split' not in by_kernel[name]:errors.append(f'Missing split diagram: {name}')
    small_kinds={'flow','tiling','ownership','storage','ring','address-bank','denominator-gather','token-path','publication-map'}
    for name,p in small_profiles.items():
        if p['kind']!='small-global-attention':errors.append(f'Additive profile fell into a legacy map kind: {name}')
        if p['numerator_format']!='FP32' or p['denominator_format']!='FP32' or p.get('accumulator')!='FP32':
            errors.append(f'Additive map profile does not declare the FP32 accumulators: {name}')
        if p['source']!='csrc/'+entries[name]['header']:errors.append(f'Incorrect additive atlas source: {name}')
        if p['warps']*p['wm']*p['wn']!=p['cm']*p['cn']:errors.append(f'Additive warp ownership does not cover CTA: {name}')
        if p['slotbytes']!=2048*p['e'] or p['shared']!=4*p['slotbytes']+16 or p['slots']!=2:
            errors.append(f'Additive K/V shared geometry mismatch: {name}')
        if p['splits']!=1:errors.append(f'Additive profile should not claim splits: {name}')
        if set(by_kernel[name])!=small_kinds:errors.append(f'Incomplete additive nine-figure atlas: {name}')
    registry=json.loads((GUIDE/'kernel-map-registry.json').read_text(encoding='utf-8'))
    registry_names=[r['name'] for r in registry.get('profiles',[])]
    if registry.get('total')!=83 or registry.get('legacy')!=81 or registry.get('additive')!=2:
        errors.append(f'All-83 map registry has wrong counts: {registry.get("total")}/{registry.get("legacy")}/{registry.get("additive")}')
    if len(registry_names)!=83 or set(registry_names)!=set(entries) or len(set(registry_names))!=83:
        errors.append('All-83 map registry does not cover every public entry exactly once')
    for record in registry.get('profiles',[]):
        expected_manifest='kernel-map-manifest-small.json' if record['name'] in small_names else 'kernel-map-manifest.json'
        if record.get('manifest')!=expected_manifest:errors.append(f'Registry manifest split is wrong: {record.get("name")}')
        manifest_names={p['name'] for p in (small_maps if expected_manifest.endswith('small.json') else maps)['profiles']}
        if record['name'] not in manifest_names:errors.append(f'Registry entry is absent from its manifest: {record.get("name")}')
    evidence=json.loads((GUIDE/'evidence/index.json').read_text(encoding='utf8'))
    if set(evidence['kernels'])!=legacy_names:errors.append('Legacy NCU evidence must cover exactly the 81 historical entries and no additive entry')
    for name,relative in evidence['kernels'].items():
        actions=json.loads((GUIDE/'evidence'/relative).read_text(encoding='utf8'))
        if not any(a['report'].endswith('-full') for a in actions) or not any(a['report'].endswith('-source') for a in actions):errors.append(f'{name}: requires full and SourceCounters evidence')
        for action in actions:
            fixture=evidence['reports'][action['report']]['fixtures'].get(name)
            if not fixture:errors.append(f'{name}: missing workload receipt')
            if not action['metrics'].get('launch__registers_per_thread'):errors.append(f'{name}: missing compiled register allocation')
            samples=action['metrics'].get('smsp__pcsamp_sample_count',{}).get('value')
            if samples is not None and sum(action['stall_totals'].values())!=samples:errors.append(f'{name}: source sample denominator does not match states')
            for line in action['lines']:
                if any(op=='?' or re.fullmatch(r'U?P\d+',op) for op in line['opcodes']):errors.append(f'{name}: invalid parsed SASS opcode')
        full=next(a for a in actions if a['report'].endswith('-full'))
        if full['metrics']['launch__shared_mem_per_block_static']['value']!=profiles[name]['shared']:errors.append(f'{name}: declared static shared budget differs from the captured binary')
    for name,record in evidence['reports'].items():
        report=GUIDE/'evidence'/(name+'.ncu-repz')
        if not report.is_file() or hashlib.sha256(report.read_bytes()).hexdigest()!=record['sha256']:errors.append(f'Missing or changed raw NCU report: {name}')
    small_evidence=json.loads((GUIDE/'evidence-small/index.json').read_text(encoding='utf8'))
    if set(small_evidence.get('kernels',{}))!=small_names:
        errors.append('Additive evidence record must cover exactly the two Small31 entries')
    if small_evidence.get('runtime_source_revision')!=EXPECTED_RUNTIME_REVISION:
        errors.append('Additive evidence record does not name the committed runtime revision')
    if small_evidence.get('runtime_binary_sha256')!=EXPECTED_SMALL_BINARY:
        errors.append('Additive evidence record has the wrong native binary hash')
    if small_evidence.get('fixture_id')!=EXPECTED_SMALL_FIXTURE:
        errors.append('Additive evidence record names the wrong fixture')
    if small_evidence.get('state')!='measured':
        errors.append('Additive evidence state must be measured')
    if small_evidence.get('ncu_state') != 'measured':
        errors.append('Final publication pending: fresh full + source NCU evidence is required for both Small31 attention entries')
    snapshot_path = ROOT/'tools/kernel_docs/small_attention_measurements.json'
    if not snapshot_path.is_file():
        errors.append('Missing canonical Small31 measurement snapshot')
        snapshot = {}
    else:
        snapshot_bytes = snapshot_path.read_bytes()
        snapshot = json.loads(snapshot_bytes.decode('utf-8'))
        snapshot_pin = small_evidence.get('measurement_snapshot') or {}
        if snapshot_pin.get('sha256') != hashlib.sha256(snapshot_bytes).hexdigest():
            errors.append('Additive evidence record does not pin the current measurement snapshot')
        if snapshot_pin.get('path') != 'tools/kernel_docs/small_attention_measurements.json':
            errors.append('Additive evidence record points at the wrong measurement snapshot path')
        public_measurements = GUIDE/'evidence-small/measurements.json'
        if not public_measurements.is_file() or public_measurements.read_bytes() != snapshot_bytes:
            errors.append('Public compact measurement copy does not match the canonical snapshot')
        if snapshot.get('fixture_id')!=EXPECTED_SMALL_FIXTURE:
            errors.append('Measurement snapshot names the wrong fixture')
        if snapshot.get('provenance',{}).get('source_commit')!=EXPECTED_RUNTIME_REVISION:
            errors.append('Measurement snapshot names the wrong runtime source revision')
        if snapshot.get('provenance',{}).get('native_module',{}).get('sha256')!=EXPECTED_SMALL_BINARY:
            errors.append('Measurement snapshot names the wrong native binary')
        if set(snapshot.get('kernels',{}))!=small_names:
            errors.append('Measurement snapshot must cover exactly the two Small31 entries')
    seen_small_reports=set()
    source_pin_total=0
    hotspot_total=0
    for name,record in small_evidence['kernels'].items():
        if record.get('ncu_state') != 'measured' or record.get('state') != 'measured':
            errors.append(f'{name}: current NCU acceptance state is missing; pending state cannot pass final publication')
        reports = record.get('ncu_reports', [])
        if len(reports) != 2 or {r.get('kind') for r in reports} != {'full', 'source'}:
            errors.append(f'{name}: exactly one full and one separate source report are required')
        fixtures = {r.get('fixture_id') or r.get('fixture') for r in reports}
        if fixtures != {EXPECTED_SMALL_FIXTURE}:
            errors.append(f'{name}: NCU reports must share the declared fixture')
        if len({r.get('path') for r in reports}) != 2:
            errors.append(f'{name}: full and source reports must be distinct files')
        for report in reports:
            public = str(report.get('path',''))
            if not public.startswith('evidence-small/') or public.startswith('/') or '\\' in public:
                errors.append(f'{name}: NCU report path must be a relative public path')
                continue
            if Path(public).name not in EXPECTED_SMALL_REPORTS or not public.endswith('.ncu-repz'):
                errors.append(f'{name}: unexpected NCU report filename or suffix: {public}')
            seen_small_reports.add(Path(public).name)
            path = (GUIDE/public).resolve()
            if not path.is_relative_to((GUIDE/'evidence-small').resolve()) or not path.is_file():
                errors.append(f'{name}: missing or incorrectly located current NCU report')
            elif hashlib.sha256(path.read_bytes()).hexdigest() != report.get('sha256'):
                errors.append(f'{name}: current NCU report hash mismatch')
        source=record.get('source')
        if source!=small_profiles[name]['source']:errors.append(f'{name}: additive evidence points at the wrong source')
        if record.get('source_sha256')!=manifest['files'].get(source):
            errors.append(f'{name}: additive source hash does not match the manifest')
        compiled=record.get('compiled_resources',{})
        if compiled.get('launch__registers_per_thread')!=EXPECTED_SMALL_REGISTERS[name]:
            errors.append(f'{name}: additive register evidence is not the verified compiled value')
        if compiled.get('launch__registers_per_thread')!=small_checks['kernels'][name].get('compiled_registers_per_thread'):
            errors.append(f'{name}: additive register evidence disagrees with its design check')
        if compiled.get('launch__shared_mem_per_block_static')!=small_profiles[name]['shared']:
            errors.append(f'{name}: additive static shared evidence disagrees with the map profile')
        metrics = record.get('metrics') or []
        metric_names = {m.get('name') for m in metrics}
        if len(metrics) < 90 or not SUBSTANTIVE_SMALL_METRICS.issubset(metric_names):
            errors.append(f'{name}: additive metrics are not substantive')
        if record.get('metric_count') != len(metrics):
            errors.append(f'{name}: metric count does not match the retained metric rows')
        sampling = record.get('sampling') or {}
        category_total = sum((m.get('value') or 0) for m in metrics
                             if m.get('name') in set(sampling.get('base_stall_categories') or []))
        if category_total != sampling.get('denominator'):
            errors.append(f'{name}: source sample denominator does not match the base stall categories')
        pins = (record.get('source_pins') or {}).get('files') or []
        if len(pins) != 13:
            errors.append(f'{name}: expected 13 pinned source files')
        source_pin_total += len(pins)
        for pin in pins:
            pin_path = pin.get('path', '')
            committed = _git_blob(EXPECTED_RUNTIME_REVISION, pin_path)
            if committed is None:
                errors.append(f'{name}: missing pinned source {pin_path} at the committed '
                              f'runtime revision')
                continue
            digest = hashlib.sha256(committed.encode('utf-8')).hexdigest()
            checkout_digest = hashlib.sha256(
                committed.replace('\n', '\r\n').encode('utf-8')).hexdigest()
            if pin.get('sha256') not in (digest, checkout_digest):
                errors.append(f'{name}: pinned source hash drift: {pin_path}')
        identity = record.get('report_identity') or {}
        if identity.get('kernel') != name or identity.get('range_count') != 1 or identity.get('action_count') != 1:
            errors.append(f'{name}: report action identity is not one range/one action for this kernel')
        if identity.get('separate_runs') is not True:
            errors.append(f'{name}: full and source reports must be separate runs')
        if (record.get('source_hotspot_count') or 0) < 1 or not record.get('source_hotspots'):
            errors.append(f'{name}: additive evidence lacks source-correlated hotspot rows')
        if record.get('source_hotspot_count') != len(record.get('source_hotspots') or []):
            errors.append(f'{name}: source hotspot count does not match the retained rows')
        hotspot_total += len(record.get('source_hotspots') or [])
        numerical = record.get('numerical_reference') or {}
        if numerical.get('sampled_outputs') != 98304 or numerical.get('full_output_census_values') != 2228224:
            errors.append(f'{name}: additive numerical-reference receipts are incomplete')
        snapshot_record = (snapshot.get('kernels') or {}).get(name, {})
        if snapshot_record:
            if snapshot_record.get('source_sha256') != record.get('source_sha256'):
                errors.append(f'{name}: index source hash differs from the canonical snapshot')
            if [r.get('sha256') for r in snapshot_record.get('ncu_reports', [])] != [r.get('sha256') for r in reports]:
                errors.append(f'{name}: index report hashes differ from the canonical snapshot')
        if not isinstance(record.get('ncu_extension'),dict) or 'reports' not in record['ncu_extension']:
            errors.append(f'{name}: additive NCU extension schema is missing')
        if any(str(r.get('path', '')).startswith('evidence/') for r in record.get('ncu_reports', [])):
            errors.append(f'{name}: a legacy NCU report was attached to an additive entry')
    if seen_small_reports != EXPECTED_SMALL_REPORTS:
        errors.append(f'Exactly the four current Small31 raw reports are required; found {sorted(seen_small_reports)}')
    if source_pin_total != 26:
        errors.append(f'Expected 26 source pin records across the two entries, found {source_pin_total}')
    if hotspot_total != 83:
        errors.append(f'Expected 83 source hotspot rows across the two entries, found {hotspot_total}')
    for name in small_names:
        page=GUIDE/(name+'.html')
        if not page.is_file():
            continue
        text=page.read_text(encoding='utf-8')
        if 'ncu-pending' in text or 'No NCU report is attached' in text or 'NCU evidence: pending' in text:
            errors.append(f'{name}: measured lesson still contains pending-NCU wording')
        for fragment in ('94,402.390625','87,855.625','HMMA.16816.F16','QMMA.16832.F32.E4M3.E4M3','LDS.128','6.10.1','6.10.4'):
            if fragment not in text:
                errors.append(f'{name}: measured walkthrough is missing {fragment!r}')
        if 'measured-evidence' not in text or 'ncu-evidence' not in text:
            errors.append(f'{name}: measured evidence sections are missing')
    for path in GUIDE.glob('*.html'):
        text=path.read_text(encoding='utf-8')
        for fragment in re.findall(r'<svg\b.*?</svg>',text,re.S):
            root=ET.fromstring(fragment)
            ids={n.get('id') for n in root.iter() if n.get('id')}
            for n in root.iter():
                for ref in n.get('aria-labelledby','').split():
                    if ref not in ids:errors.append(f'{path.name}: missing SVG accessibility label {ref}')
    if errors:
        raise SystemExit('\n'.join(errors))
    print(f'PASS: {len(pages)} pages, 83 standalone lessons (81 legacy + 2 additive), '
          f'{1 if (GUIDE/"flashlight.html") in pages else 0} current FlashLight chapter, {diagrams} inline SVGs '
          f'({len(maps["diagrams"])+len(small_maps["diagrams"])} specialized exports), {checked_links} local links, '
          f'{len(manifest["snippets"])} exact excerpts, 83 entries / 58 bodies.')


if __name__=='__main__':main()
