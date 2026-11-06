"""Focused CPU tests for immutable documentation source providers.

These tests exercise only provider/verifier helpers.  They do not execute the
documentation builders on import, do not write the public guide and do not
create a CUDA context.
"""
from pathlib import Path
import hashlib
import json
import subprocess
import sys

import pytest

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'tools'))
sys.path.insert(0, str(ROOT / 'tools/kernel_docs'))

import common
import output_paths
import runtime_source_revision
import source_providers
import validate_kernel_docs as validator


def _git_text(revision, path):
    raw = subprocess.run(
        ['git', 'cat-file', 'blob', f'{revision}:{path}'], cwd=ROOT,
        capture_output=True, check=True,
    ).stdout
    return raw.decode('utf-8').replace('\r\n', '\n').replace('\r', '\n')


def _baseline():
    text, manifest = validator._baseline_manifest()
    assert text is not None and manifest is not None
    return text, manifest


def test_original_provider_is_isolated_and_matches_committed_blob(monkeypatch, tmp_path):
    provider = source_providers.ORIGINAL
    path = 'dlssnr/model.py'
    committed = _git_text(source_providers.ORIGINAL_REFERENCE, path)
    assert provider.text(path) == committed
    assert not provider.root.is_relative_to(ROOT)

    # Even if the process's repository root is redirected to a directory that
    # does not contain the source, an explicit provider still reads its
    # immutable tree.  This is the regression guard against worktree fallback.
    monkeypatch.setattr(common, 'ROOT', tmp_path)
    registry = []
    common.code(path, 1, 3, provider=provider, registry=registry)
    assert registry[0]['source_provider'] == 'original'
    expected = '\n'.join(committed.splitlines()[:3])
    assert registry[0]['sha256'] == hashlib.sha256(expected.encode()).hexdigest()
    assert common.CURRENT_SNIPPETS == []


def test_original_provenance_is_explicit_and_preserves_93_22_3():
    _, baseline = _baseline()
    provenance = {
        path: source_providers.ORIGINAL.provenance(path)
        for path in baseline['file_revisions']
    }
    assert provenance == baseline['file_revisions']
    counts = {}
    for info in provenance.values():
        counts[info['kind']] = counts.get(info['kind'], 0) + 1
    assert counts == {'legacy-commit': 93, 'runtime-commit': 22,
                      'checkpoint-api-commit': 3}
    with pytest.raises(ValueError):
        # Exists in the original snapshot but is owned by none of the frozen
        # revisions; it must fail rather than silently becoming working-tree.
        source_providers.ORIGINAL.provenance('tools/extract_model_checkpoint.py')
    with pytest.raises(FileNotFoundError):
        source_providers.ORIGINAL.text('csrc/does-not-exist.cuh')


def test_validator_baseline_literals_and_blob_excerpt_identity():
    baseline_text, baseline = _baseline()
    assert validator.check_baseline_literals(baseline_text, baseline) == []
    assert len(baseline['files']) == validator.EXPECTED_OLD_FILE_COUNT
    assert len(baseline['snippets']) == validator.EXPECTED_OLD_SNIPPET_COUNT

    manifest = dict(baseline)
    manifest['original_source_reference_revision'] = validator.EXPECTED_ORIGINAL_REFERENCE
    manifest['snippets'] = [dict(row, source_provider='original')
                            for row in baseline['snippets']]
    assert validator.check_old_namespace(manifest, baseline) == []

    mutated = json.loads(json.dumps(manifest))
    mutated['snippets'][0]['sha256'] = '0' * 64
    errors = validator.check_old_namespace(mutated, baseline)
    assert any('excerpt' in message for message in errors)

    mutated = json.loads(json.dumps(manifest))
    path = sorted(mutated['file_revisions'])[0]
    mutated['file_revisions'][path]['kind'] = 'working-tree'
    errors = validator.check_old_namespace(mutated, baseline)
    assert any('93/22/3' in message or 'differs' in message for message in errors)


def test_validator_rejects_changed_source_copy(tmp_path):
    _, baseline = _baseline()
    dependency = baseline['lessons'][0]['dependencies'][0]
    info = baseline['file_revisions'][dependency]
    committed = _git_text(info['revision'], dependency)
    manifest = {
        'file_revisions': {dependency: info},
        'lessons': [{'name': 'probe', 'dependencies': [dependency]}],
    }
    copy = tmp_path / 'source' / dependency
    copy.parent.mkdir(parents=True)
    copy.write_text(committed, encoding='utf-8', newline='\n')
    assert validator.check_source_copies(tmp_path, manifest) == []

    copy.write_text(committed + '\n// mutated source copy\n', encoding='utf-8',
                    newline='\n')
    errors = validator.check_source_copies(tmp_path, manifest)
    assert any('changed source dependency' in message for message in errors)


def test_current_provider_requires_a_real_commit(monkeypatch):
    monkeypatch.setenv('DLSSNR_REFACTOR_REVISION', 'not-a-commit')
    with pytest.raises(ValueError):
        runtime_source_revision.configured_refactor_revision()

    monkeypatch.setenv('DLSSNR_REFACTOR_REVISION', '0' * 40)
    with pytest.raises(source_providers.SourceProviderError):
        source_providers.current_provider()

    absent = source_providers.Provider('current', '0' * 40)
    with pytest.raises(source_providers.SourceProviderError):
        absent.text('setup.py')

    commit = source_providers.ORIGINAL_REFERENCE
    current = source_providers.Provider('current', commit)
    assert current.text('setup.py') == _git_text(commit, 'setup.py')
    assert current.provenance('setup.py')['kind'] == 'refactor-commit'
    assert current.provenance('setup.py')['revision'] == commit
    assert current.root != source_providers.ORIGINAL.root


def test_current_snippets_use_their_own_registry(monkeypatch):
    commit = source_providers.ORIGINAL_REFERENCE
    current = source_providers.Provider('current', commit)
    monkeypatch.setenv('DLSSNR_REFACTOR_REVISION', commit)
    assert source_providers.current_provider().revision == commit

    before = list(common.SNIPPETS)
    registry = []
    common.code('setup.py', 1, 2, provider=current, registry=registry)
    assert common.SNIPPETS == before
    assert common.CURRENT_SNIPPETS == []
    assert registry[0]['source_provider'] == 'current'
    assert registry[0]['source_kind'] == 'refactor-commit'
    assert f'/{commit}/' in registry[0]['url']


def test_validator_rejects_malformed_current_and_relabelled_old_sources():
    _, baseline = _baseline()
    original = {'name': 'original', 'revision': validator.EXPECTED_ORIGINAL_REFERENCE}
    manifest = dict(baseline)
    manifest['original_source_reference_revision'] = validator.EXPECTED_ORIGINAL_REFERENCE
    manifest['refactor_source_revision'] = None
    manifest['source_providers'] = [original]
    manifest['current_files'] = {}
    manifest['current_file_revisions'] = {}
    manifest['current_snippets'] = []
    manifest['snippets'] = [dict(row, source_provider='original')
                            for row in baseline['snippets']]
    assert validator.check_current_namespace(manifest) == []

    relabelled = json.loads(json.dumps(manifest))
    relabelled['snippets'][0]['source_provider'] = 'current'
    errors = validator.check_current_namespace(relabelled)
    assert any('Historical snippets' in message or 'historical snippet' in message
               for message in errors)

    malformed = json.loads(json.dumps(manifest))
    malformed['refactor_source_revision'] = 'f' * 40
    malformed['source_providers'] = [original,
                                     {'name': 'current', 'revision': 'f' * 40}]
    malformed['current_files'] = {'setup.py': '0' * 64}
    malformed['current_file_revisions'] = {
        'setup.py': {'kind': 'refactor-commit', 'revision': 'f' * 40,
                     'sha256': '0' * 64}}
    errors = validator.check_current_namespace(malformed)
    assert any('absent' in message for message in errors)

    missing = json.loads(json.dumps(manifest))
    missing['refactor_source_revision'] = 'not-a-commit'
    errors = validator.check_current_namespace(missing)
    assert any('malformed' in message for message in errors)


def test_output_root_is_independent_of_source_root(tmp_path):
    root = output_paths.resolve_output_root(tmp_path)
    assert root == tmp_path.resolve()
    assert root != source_providers.ORIGINAL.root
    assert not root.is_relative_to(source_providers.ORIGINAL.root)


@pytest.mark.parametrize('path', [
    'C:/outside.py', 'C:outside.py', 'setup.py:stream', '../setup.py',
    '/setup.py', 'csrc/../setup.py', 'csrc//file.cuh', './setup.py',
    r'csrc\file.cuh', '.',
])
def test_provider_rejects_non_repository_paths(path):
    with pytest.raises(ValueError):
        source_providers.ORIGINAL.text(path)
    assert not source_providers.ORIGINAL.exists(path)


def test_current_validator_accepts_multiple_excerpts_but_checks_manifest_identity():
    commit = source_providers.ORIGINAL_REFERENCE
    provider = source_providers.Provider('current', commit)
    registry = []
    common.code('setup.py', 1, 2, provider=provider, registry=registry)
    common.code('setup.py', 3, 4, provider=provider, registry=registry)
    info = provider.provenance('setup.py')
    manifest = {
        'refactor_source_revision': commit,
        'source_providers': [
            {'name': 'original', 'revision': validator.EXPECTED_ORIGINAL_REFERENCE},
            {'name': 'current', 'revision': commit},
        ],
        'current_files': {'setup.py': info['sha256']},
        'current_file_revisions': {'setup.py': info},
        'current_snippets': registry,
    }
    assert validator.check_current_namespace(manifest) == []

    changed = json.loads(json.dumps(manifest))
    changed['current_file_revisions'] = {'another.py': info}
    assert any('different paths' in message
               for message in validator.check_current_namespace(changed))
    changed = json.loads(json.dumps(manifest))
    changed['current_snippets'][0]['source_sha256'] = '0' * 64
    assert any('source hash' in message
               for message in validator.check_current_namespace(changed))
    changed = json.loads(json.dumps(manifest))
    changed['current_files'] = {}
    changed['current_file_revisions'] = {}
    assert any('missing from current_files' in message
               for message in validator.check_current_namespace(changed))


def test_validator_rejects_absent_current_commit_even_without_excerpts():
    manifest = {
        'refactor_source_revision': '0' * 40,
        'source_providers': [
            {'name': 'original', 'revision': validator.EXPECTED_ORIGINAL_REFERENCE},
            {'name': 'current', 'revision': '0' * 40},
        ],
        'current_files': {}, 'current_file_revisions': {}, 'current_snippets': [],
    }
    assert any('commit is absent' in message
               for message in validator.check_current_namespace(manifest))


def test_provider_cleanup_refuses_non_owned_directory(tmp_path):
    (tmp_path / 'keep.txt').write_text('keep', encoding='utf-8')
    with pytest.raises(source_providers.SourceProviderError):
        source_providers._remove_materialized_tree(tmp_path)
    assert (tmp_path / 'keep.txt').read_text(encoding='utf-8') == 'keep'
