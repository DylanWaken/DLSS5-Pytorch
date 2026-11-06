"""Generate the static GitHub Pages kernel guide. Python standard library only.

Run from any directory: python tools/build_kernel_docs.py [--output PATH]
The historical source revision is read from the immutable original snapshot in
``kernel_docs/source_providers.py``; the output root may be overridden with
``--output`` or ``DLSSNR_DOCS_OUTPUT`` without changing any source root.
"""
from pathlib import Path
from html import escape
import argparse
import importlib
import hashlib
import json
import os
import shutil
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'tools/kernel_docs'))
from common import (CHECKPOINT_API_REVISION, CURRENT_SNIPPETS, REVISION, REPOSITORY,
                     RUNTIME_REVISION, SNIPPETS, file_provenance, source_url)
from runtime_source_revision import (
    CHECKPOINT_API_CHANGED_PATHS,
    CHECKPOINT_API_HISTORICAL_PATHS,
    CHECKPOINT_API_SOURCE_PATHS,
    RUNTIME_SOURCE_PATHS,
)
from source_providers import (LEGACY_REVISION, ORIGINAL, ORIGINAL_REFERENCE,
                              current_provider, normalized_lf, read_blob)
from output_paths import DEFAULT_OUTPUT, configure_output_root, repository_guide_root
from kernel_sources import collect, check_roster, check_entry_layout, compare_exports
from publishing import (catalog, render as render_lesson_site, source_appendix,
                        normalize_lesson, current_dependencies)
from flashlight import build_chapter as build_flashlight_chapter
from flashlight_evidence import (
    EVIDENCE_ENVIRONMENT_VARIABLE,
    EvidenceError,
    canonical_acceptance_path,
    copy_acceptance_bundle,
    load_acceptance,
    resolve_acceptance_path,
)
from token_visuals import enrich
from glossary import glossary_page
from kernel_maps import enrich as enrich_kernel_maps, write_manifest as write_map_manifest
from evidence import load as load_evidence, enrich as enrich_evidence, method_page
from design_checks import run as check_design_models
from evidence_small import (run_design_checks as check_small_design_models,
                            write_index as write_small_evidence, lesson_evidence)
from lessons_small_attention import SMALL_NAMES
import small_atlas
from runtime_update import CHAPTER as RUNTIME_UPDATE
from cyberpunk_comparison import build_chapter as build_comparison_chapter

INPUT_GUIDE = repository_guide_root()
OWNED_VALIDATION_SITE = (ROOT / 'profile/flashlight-refactor-20261105/docs/validation-site').resolve()


def _baseline_manifest():
    """Read the frozen manifest from the immutable original commit."""
    result = subprocess.run(
        ['git', 'cat-file', 'blob',
         f'{ORIGINAL_REFERENCE}:docs/kernel-guide/source-manifest.json'],
        cwd=ROOT, capture_output=True,
    )
    if result.returncode != 0:
        raise SystemExit(
            f'Cannot read the baseline manifest at {ORIGINAL_REFERENCE}; the historical '
            'source inventory cannot be verified')
    return json.loads(normalized_lf(result.stdout.decode('utf-8')))


def check_original_reference():
    """Verify the immutable original snapshot against committed blobs.

    The old worktree ``git diff`` is gone.  Every historical file and excerpt is
    checked against the immutable ``e2741a7`` snapshot and its recorded owning
    revision; the 122-path legacy census and the explicit three-path checkpoint
    allowlist remain unchanged.  A missing or unowned blob fails.
    """
    if CHECKPOINT_API_REVISION is None:
        raise SystemExit(
            'CHECKPOINT_API_REVISION is not configured; set DLSSNR_CHECKPOINT_API_REVISION to '
            'the accepted full 40-character checkpoint implementation commit before building '
            'the guide. Historical and runtime pins are unchanged, and no older revision may '
            'own the changed checkpoint API sources.')
    listed = subprocess.run(
        ['git', 'ls-tree', '-r', '--name-only', LEGACY_REVISION, '--', 'csrc', 'dlssnr'],
        cwd=ROOT, check=True, capture_output=True, text=True,
    )
    paths = [line for line in listed.stdout.splitlines() if line]
    if not paths:
        raise SystemExit(f'Pinned source tree is empty at {LEGACY_REVISION}')
    separated = sorted(set(CHECKPOINT_API_HISTORICAL_PATHS).intersection(paths))
    expected_separated = sorted(CHECKPOINT_API_HISTORICAL_PATHS)
    if separated != expected_separated:
        raise SystemExit(
            f'Checkpoint API historical path allowlist does not match the pinned tree: '
            f'found {separated}, expected {expected_separated}')
    if tuple(CHECKPOINT_API_SOURCE_PATHS) != tuple(CHECKPOINT_API_CHANGED_PATHS):
        raise SystemExit('Checkpoint API source allowlist is not the exact three-path set')
    if len(paths) != 122:
        raise SystemExit(f'Expected 122 historical csrc/dlssnr paths at {LEGACY_REVISION}, '
                         f'found {len(paths)}')

    # Materialize exactly once, then verify every required path and every
    # checkpoint/runtime blob against the snapshot bytes.
    ORIGINAL.materialize()
    missing = [path for path in (*RUNTIME_SOURCE_PATHS, *CHECKPOINT_API_SOURCE_PATHS)
               if not ORIGINAL.exists(path)]
    if missing:
        raise SystemExit(f'Original snapshot is missing required paths: {missing}')
    for path in CHECKPOINT_API_SOURCE_PATHS:
        committed = read_blob(CHECKPOINT_API_REVISION, path)
        if committed is None:
            raise SystemExit(f'{path} is not present at checkpoint API revision '
                             f'{CHECKPOINT_API_REVISION}')
        if ORIGINAL.text(path) != committed:
            raise SystemExit(
                f'{path} differs between the immutable original snapshot and checkpoint '
                f'API revision {CHECKPOINT_API_REVISION}')
    for path in RUNTIME_SOURCE_PATHS:
        if path in CHECKPOINT_API_SOURCE_PATHS:
            # Checkpoint API ownership takes precedence; the runtime pin does
            # not own this path even though the runtime chapter quotes it.
            continue
        if RUNTIME_REVISION is None:
            raise SystemExit(f'{path} needs an explicit runtime commit; none is configured')
        committed = read_blob(RUNTIME_REVISION, path)
        if committed is None:
            raise SystemExit(f'{path} is not present at runtime revision {RUNTIME_REVISION}')
        if ORIGINAL.text(path) != committed:
            raise SystemExit(
                f'{path} differs between the immutable original snapshot and runtime '
                f'revision {RUNTIME_REVISION}')

    baseline = _baseline_manifest()
    if len(baseline['files']) != 118 or len(baseline['snippets']) != 1570:
        raise SystemExit(
            f'Baseline manifest is not the frozen 118-file/1,570-snippet state: '
            f'{len(baseline["files"])}/{len(baseline["snippets"])}')
    texts = {}
    for path, digest in baseline['files'].items():
        texts[path] = ORIGINAL.text(path)
        if hashlib.sha256(texts[path].encode('utf-8')).hexdigest() != digest:
            raise SystemExit(f'Original snapshot file hash differs from the baseline: {path}')
    for snippet in baseline['snippets']:
        path = snippet['path']
        lines = texts[path].splitlines()
        excerpt = '\n'.join(lines[snippet['start'] - 1:snippet['end']])
        if hashlib.sha256(excerpt.encode()).hexdigest() != snippet['sha256']:
            raise SystemExit(f'Original snapshot excerpt differs from the baseline: '
                             f'{path}:{snippet["start"]}-{snippet["end"]}')
    provenance = {path: file_provenance(path, ORIGINAL) for path in baseline['files']}
    if provenance != baseline['file_revisions']:
        raise SystemExit('Original snapshot per-file provenance differs from the baseline')
    kinds = {}
    for info in provenance.values():
        kinds[info['kind']] = kinds.get(info['kind'], 0) + 1
    if kinds != {'legacy-commit': 93, 'runtime-commit': 22,
                 'checkpoint-api-commit': 3}:
        raise SystemExit(f'Historical provenance ownership is not 93/22/3: {kinds}')
    return len(paths), baseline


def _copy_input_tree(source, destination):
    """Copy an unchanged public input tree without deleting the source."""
    if not source.is_dir():
        return
    shutil.copytree(source, destination, dirs_exist_ok=True, copy_function=shutil.copy2)


def prepare_output(guide):
    """Create the output root and copy unchanged evidence/assets into it.

    When the output is the production guide, its evidence and media already live
    there.  A temporary validation site receives non-destructive copies of the
    unchanged public inputs so every evidence/raw-report/media link stays
    meaningful.
    """
    guide = Path(guide).resolve()
    source_root = ORIGINAL.root
    if guide.is_relative_to(source_root) or source_root.is_relative_to(guide):
        raise SystemExit('The output root must stay separate from the immutable source tree')
    guide.mkdir(parents=True, exist_ok=True)
    if guide == DEFAULT_OUTPUT:
        return guide
    for name in ('assets', 'evidence', 'evidence-small', 'evidence-checkpoints', 'media'):
        _copy_input_tree(INPUT_GUIDE / name, guide / name)
    if guide.is_relative_to(OWNED_VALIDATION_SITE):
        # The generated pages link to ``../SETUP.md``.  A temporary site lives
        # below the repository docs directory, so copy that unchanged public
        # input beside it to keep the relative link meaningful.
        for name in ('SETUP.md',):
            source = INPUT_GUIDE.parent / name
            if source.is_file():
                shutil.copy2(source, guide.parent / name)
    return guide


def clean_owned_validation_site(guide):
    """Remove only an owned temporary site, after checking its resolved path."""
    target = Path(guide).resolve()
    if not target.is_relative_to(OWNED_VALIDATION_SITE):
        raise SystemExit(
            f'Refusing to clean {target}; an owned temporary output must stay under '
            f'{OWNED_VALIDATION_SITE}')
    if target.exists():
        shutil.rmtree(target)
    return target


def _existing_current_namespace(guide):
    """Detect a previously generated current chapter before any destructive step."""
    guide = Path(guide)
    if (guide / 'flashlight.html').is_file():
        return True
    source_current = guide / 'source-current'
    if source_current.is_dir() and any(source_current.rglob('*')):
        return True
    manifest_path = guide / 'source-manifest.json'
    if manifest_path.is_file():
        try:
            manifest = json.loads(manifest_path.read_text(encoding='utf-8'))
        except (OSError, ValueError):
            return True
        if manifest.get('refactor_source_revision') or manifest.get('flashlight_evidence'):
            return True
        if manifest.get('flashlight_chapter') is not None:
            return True
    return False


def preflight_current(*, historical_only, explicit_evidence, output, inventory,
                      snapshot_roster):
    """Resolve and validate the current provider and evidence before any write.

    This function performs only reads and in-memory chapter construction.  It is
    called before ``--clean`` or ``prepare_output`` so bad or misattributed
    evidence cannot erase a previously generated current chapter.  Returning
    ``None`` for the provider is the explicit historical-only configuration.
    """
    if historical_only:
        if explicit_evidence not in (None, ''):
            raise SystemExit('--historical-only cannot be combined with explicit evidence')
        if _existing_current_namespace(output):
            raise SystemExit(
                'Refusing to generate a historical-only site over an output that '
                'contains a previously configured current chapter; choose a fresh '
                '--output')
        return None, None, None, None

    try:
        current = current_provider()
    except Exception as exc:
        raise SystemExit(f'FlashLight current provider is misconfigured: {exc}') from exc
    if current is None:
        environment_evidence = os.environ.get(EVIDENCE_ENVIRONMENT_VARIABLE)
        if explicit_evidence not in (None, '') or environment_evidence not in (None, ''):
            raise SystemExit(
                'FlashLight evidence was supplied without a configured implementation '
                'commit; final publication cannot proceed')
        if _existing_current_namespace(output):
            raise SystemExit(
                'The output already contains a configured current FlashLight chapter, '
                'but no implementation pin is configured. Refusing to erase or omit it; '
                'restore the pin or use an explicit --historical-only temporary output.')
        return None, None, None, None

    evidence_path = resolve_acceptance_path(
        explicit_evidence, guide_root=repository_guide_root())
    if evidence_path is None:
        raise SystemExit(
            'A current FlashLight implementation commit is configured, but no accepted '
            f'evidence bundle was found. Supply --flashlight-evidence, set '
            f'{EVIDENCE_ENVIRONMENT_VARIABLE}, or place the canonical bundle at '
            f'{canonical_acceptance_path()}. Final current-chapter publication requires '
            'the full accepted record, not a ptxas-only sketch.')
    try:
        acceptance = load_acceptance(evidence_path, current.revision)
    except EvidenceError as exc:
        raise SystemExit(f'FlashLight acceptance evidence cannot be published: {exc}') from exc
    current.materialize()
    current_inventory = collect(current.root / 'csrc')
    check_roster(current_inventory)
    check_entry_layout(current_inventory, current.root / 'csrc')
    if (current_inventory['entry_count'] != 83
            or current_inventory['definition_count'] != 58
            or current_inventory['emission_unit_count'] != 58
            or current_inventory['template_entry_count'] != 40):
        raise SystemExit(
            'Current FlashLight inventory is not 83 entries / 58 bodies / '
            '58 emission units / 40 template entries: '
            f'{current_inventory["entry_count"]}/'
            f'{current_inventory["definition_count"]}/'
            f'{current_inventory["emission_unit_count"]}/'
            f'{current_inventory["template_entry_count"]}')
    current_roster = current.text('tuning/canonical_kernel_names.json')
    if current_roster != snapshot_roster:
        raise SystemExit('The current canonical roster differs from the immutable '
                         'original roster; the logical exports may not change silently')
    compare_exports(current_inventory, inventory, allow_template_migration=True)
    try:
        current_chapter = build_flashlight_chapter(current, evidence=acceptance)
    except ValueError as exc:
        raise SystemExit(f'FlashLight current chapter cannot be published: {exc}') from exc
    return current, current_inventory, current_chapter, acceptance



def _atlas_row(name, entry):
    path = 'csrc/' + entry['header']
    chapter = name
    precision = 'FP16' if name.endswith('_fp16') else 'FP8' if name.endswith('_fp8') else 'Common'
    args = '<br><code>' + escape(entry['template_arguments']) + '</code>' if 'template_arguments' in entry else ''
    return f'<tr><td><a href="{source_url(path, entry["line"])}"><code>{name}</code></a>{args}</td><td><span class="tag">{precision}</span></td><td><a href="{chapter}.html">Read this kernel from start to finish →</a><br><span class="source-link">{escape(entry["definition"])} · line {entry["line"]}</span></td></tr>'


def atlas(inventory, current=None, current_inventory=None):
    legacy = [(name, entry) for name, entry in inventory['entries'].items()
              if name not in SMALL_NAMES]
    additive = [(name, entry) for name, entry in inventory['entries'].items()
                if name in SMALL_NAMES]
    if len(legacy) != 81 or len(additive) != 2:
        raise ValueError(f'Expected 81 legacy + 2 additive atlas rows, found {len(legacy)} + {len(additive)}')
    body = '''<h2 id="model">The model piece: all deployment entry families</h2><p>The architecture has 71 numbered records, while the CUDA interface exposes 81 public configurations: 40 paired FP8/FP16 roles plus completion-counter clearing. Many records reuse the same role with different weights, and templates let several public roles share one complete global body. This atlas maps every public configuration to its actual source definition and its self-contained lesson.</p><p>Read the <a href="architecture.html">architecture guide</a> to identify the tensor operation, then use this table to reach the exact implementation and its standalone reconstruction. Entries link to a fixed source revision. The source census finds 56 complete global definitions; it does not establish runtime or performance coverage.</p><p><strong>Additive 310.9.16 entries:</strong> two further public configurations bring the guide to 83 entries, 41 paired roles and 58 owning definitions. They are listed in a separate section below and do not alter the 81-row historical mapping or its evidence.</p>
<h2 id="entries">Find a kernel</h2><label for="kernel-filter">Filter by operation, precision or channel width</label><p><input class="filter-input" id="kernel-filter" type="search" placeholder="For example: qkv fp16, c512, downsample"></p><p id="filter-count" aria-live="polite">83 of 83 public entries shown</p>'''
    body += '<div class="table-scroll"><table class="inventory"><thead><tr><th>Public name / template arguments</th><th>Precision</th><th>Walkthrough / owning definition</th></tr></thead><tbody>' + '\n'.join(_atlas_row(name, entry) for name, entry in legacy) + '</tbody></table></div>'
    body += '<h2 id="additive">Additive Small31 attention entries</h2><p>These two entries are pinned to the committed runtime source <code>' + RUNTIME_REVISION[:12] + '</code>, not to the historical 310.8 pin. They use the same public ABI but a distinct numerical contract: persistent FP32 numerator and row denominator. Their source, compiler/runtime attributes, sampled numerical-reference artifacts and four current full/source NCU reports are recorded separately; no legacy NCU report is attached to them. The replay is isolated to one attention call and is not a full-network timing.</p>'
    body += '<div class="table-scroll"><table class="inventory"><thead><tr><th>Public name / template arguments</th><th>Precision</th><th>Walkthrough / owning definition</th></tr></thead><tbody>' + '\n'.join(_atlas_row(name, entry) for name, entry in additive) + '</tbody></table></div>'
    if current is not None and current_inventory is not None:
        current_rows = []
        for name, entry in sorted(current_inventory['entries'].items()):
            path = 'csrc/' + entry['header']
            args = ('<br><code>' + escape(entry['template_arguments']) + '</code>'
                    if 'template_arguments' in entry else '')
            current_rows.append(
                f'<tr><td><a href="{source_url(path, entry["line"], provider=current)}">'
                f'<code>{escape(name)}</code></a>{args}</td>'
                f'<td><span class="source-link">{escape(entry["definition"])} · line '
                f'{entry["line"]}</span></td>'
                f'<td><a href="flashlight.html">Forward-design, fragments and worked trace →</a></td></tr>')
        body += ('<h2 id="current-flashlight">Current FlashLight implementation atlas</h2>'
                 f'<p>These 83 current rows are pinned to the real implementation commit '
                 f'<code>{current.revision[:12]}</code>, not to the historical 81+2 lesson pins. '
                 f'The current census is 83 entries / 58 bodies / 58 emission units / 40 template '
                 f'entries, and its logical roster equals the immutable original roster. The '
                 f'historical rows above keep their own source, evidence and lesson definitions; '
                 f'this table adds no historical lesson, NCU record or design check.</p>'
                 '<div class="table-scroll"><table class="inventory"><thead><tr>'
                 '<th>Current public name / template arguments</th>'
                 '<th>Current owning definition</th><th>Chapter</th></tr></thead><tbody>'
                 + '\n'.join(current_rows) + '</tbody></table></div>')
    body += '''<h2 id="provenance">Provenance and scope</h2><p>The inventory comes from <code>tools/kernel_sources.py</code>; its roster and source-ownership checks run during documentation generation. <a href="source-manifest.json">source-manifest.json</a> records file hashes, excerpt ranges and the public-entry mapping with per-file legacy/runtime provenance. Source excerpts are copied directly from the checked files. Layout calculations marked as examples are derived from those formulas; optimization mechanisms are explained from source. <a href="measurement-method.html">Separate measured evidence</a> accompanies the 81 historical lessons, including compiled resources and source-correlated instruction counts. The two additive lessons have their own <a href="evidence-small/index.json">evidence-small record</a> and <a href="kernel-map-manifest-small.json">small map manifest</a>; <a href="kernel-map-registry.json">the all-83 registry</a> maps both sets.</p><p>The generated HTML is stored in <code>docs/kernel-guide</code>. Its Python content modules and assets live in <code>tools/kernel_docs</code>. Regenerate with <code>python tools/build_kernel_docs.py</code> and validate with <code>python tools/validate_kernel_docs.py</code>. The <a href="architecture.html">network architecture</a> and its diagrams are maintained in the same HTML guide as the kernel lessons.</p>'''
    if current is not None:
        body += (f'<p><strong>Additive current implementation.</strong> '
                 f'<a href="flashlight.html">The FlashLight chapter</a> and the current atlas '
                 f'above are pinned to commit <code>{current.revision[:12]}</code>. Their '
                 f'excerpts and <code>source-current/</code> copies use that separate namespace; '
                 f'the 81+2 historical rows, their lesson definitions and their evidence are '
                 f'unchanged.</p>')
    return dict(slug='source-atlas',title='The complete source atlas',summary='Every public FP16/FP8 configuration, its owning global definition and the walkthrough that explains it.',body=body)


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', help='documentation output root '
                        '(default: DLSSNR_DOCS_OUTPUT or docs/kernel-guide)')
    parser.add_argument('--clean', action='store_true',
                        help='remove only an owned temporary validation-site output first')
    parser.add_argument('--historical-only', action='store_true',
                        help='generate the historical guide without the current FlashLight '
                             'chapter; requires an explicit --output')
    parser.add_argument('--flashlight-evidence',
                        help='explicit full accepted acceptance.json for the current '
                             'FlashLight implementation commit (defaults to the evidence '
                             'environment variable, then the canonical checked-in bundle)')
    args = parser.parse_args(argv)
    if args.historical_only:
        if args.output in (None, ''):
            raise SystemExit('--historical-only requires an explicit separate --output')
        if args.flashlight_evidence not in (None, ''):
            raise SystemExit('--historical-only cannot be combined with --flashlight-evidence')
    out = configure_output_root(args.output)

    # Preflight every input, including bad evidence and a mismatched current
    # identity, before --clean or any generated output write.
    pinned_paths, baseline = check_original_reference()
    inventory = collect(ORIGINAL.root / 'csrc')
    live_roster = normalized_lf((ROOT / 'tuning/canonical_kernel_names.json').read_text(encoding='utf-8'))
    snapshot_roster = ORIGINAL.text('tuning/canonical_kernel_names.json')
    if live_roster != snapshot_roster:
        raise SystemExit('The live canonical roster differs from the immutable original '
                         'snapshot; the historical audit must not silently use either copy')
    check_roster(inventory); check_entry_layout(inventory, ORIGINAL.root / 'csrc')
    if inventory['entry_count'] != 83 or inventory['definition_count'] != 58:
        raise ValueError(f'Expected 83 entries / 58 definitions, found '
                         f'{inventory["entry_count"]} / {inventory["definition_count"]}')
    if inventory['emission_unit_count'] != 58 or inventory['template_entry_count'] != 40:
        raise ValueError(f'Expected 58 emission units / 40 templates, found '
                         f'{inventory["emission_unit_count"]} / '
                         f'{inventory["template_entry_count"]}')

    # Optional current implementation.  The chapter is generated only after a
    # real commit and a fully verified acceptance bundle exist.  This call is
    # read-only and happens before destructive cleanup or output preparation.
    current, current_inventory, current_chapter, acceptance = preflight_current(
        historical_only=args.historical_only,
        explicit_evidence=args.flashlight_evidence,
        output=out,
        inventory=inventory,
        snapshot_roster=snapshot_roster,
    )
    if args.clean:
        clean_owned_validation_site(out)
    prepare_output(out)
    if acceptance is not None:
        # Copy only the verified acceptance file and its registered artifacts.
        # The canonical source bundle is never modified.
        copy_acceptance_bundle(acceptance, out / 'evidence-flashlight')

    parts = {name: importlib.import_module(name).CHAPTERS for name in ('foundations','windows','c512','bottleneck')}
    chapters = [parts['foundations'][0], *parts['windows'], *parts['c512'], *parts['bottleneck'], parts['foundations'][1], RUNTIME_UPDATE]
    arch = dict(slug='architecture',title='The network architecture',summary='The complete encoder–decoder: FFN and attention variants, tensor shapes, normalization, resolution transitions and precision boundaries.',body=(ROOT/'tools/kernel_docs/architecture.html').read_text(encoding='utf-8'))
    chapters += [arch, atlas(inventory, current=current,
                             current_inventory=current_inventory), glossary_page()]
    evidence = load_evidence()
    check_design_models(inventory,evidence)
    check_small_design_models(inventory)
    small_index = write_small_evidence()
    small_lesson_evidence = lesson_evidence(small_index)
    chapters += [method_page(evidence)]
    comparison = build_comparison_chapter()
    if comparison is not None:
        chapters.append(comparison)
    for chapter in chapters:
        if chapter['slug'] not in ('architecture','source-atlas','glossary','measurement-method','runtime-310-9-16','cyberpunk-comparison'):
            chapter['body'] = '<aside class="note">This is a family reference. For the forward design process, implementation milestones and measured validation, choose an individual entry in the <a href="index.html#kernels">kernel catalog</a>. <a href="measurement-method.html">Read the evidence method</a>.</aside>' + chapter['body']
    if current_chapter is not None:
        chapters.append(current_chapter)
    lessons=[]
    for module in ('lessons_frontend','lessons_windows','lessons_c512','lessons_layout','lessons_bottleneck','lessons_small_attention'):
        builder = importlib.import_module(module).build_lessons
        if module == 'lessons_small_attention':
            lessons.extend(builder(inventory, evidence=small_lesson_evidence))
        else:
            lessons.extend(builder(inventory))
    names=[p['name'] for p in lessons]
    if len(set(names)) != len(names) or set(names) != set(inventory['entries']):
        raise ValueError(f'Incomplete standalone coverage: {set(inventory["entries"])-set(names)}; duplicate or extra names: {len(names)-len(set(names))}')
    small_lessons=[lesson for lesson in lessons if lesson['name'] in SMALL_NAMES]
    legacy_lessons=[lesson for lesson in lessons if lesson['name'] not in SMALL_NAMES]
    if len(legacy_lessons) != 81 or len(small_lessons) != 2:
        raise ValueError(f'Expected 81 legacy + 2 additive lessons, found {len(legacy_lessons)} + {len(small_lessons)}')
    source_bundle=set()
    for lesson in lessons:
        lesson['slug']=lesson['name']
        additive=lesson['name'] in SMALL_NAMES
        if not additive:
            enrich(lesson, inventory['entries'][lesson['name']])
            enrich_kernel_maps(lesson, inventory['entries'][lesson['name']])
            enrich_evidence(lesson, evidence)
        if lesson['family']=='Global bottleneck':
            precision='FP8' if lesson['name'].endswith('fp8') else 'FP16'
            roles={'global_ffn_expand':'FFN expansion: 1024 → 4096','global_ffn_contract':'FFN contraction: 4096 → 1024','global_projection':'attention output projection','global_qkv':'QKV projection and normalization','global_attention_chained':'streamed global attention'}
            role=next(label for prefix,label in roles.items() if lesson['name'].startswith(prefix))
            lesson['title']=f'{precision} C1024 {role}'
        appendix,deps=source_appendix(lesson,inventory['entries'][lesson['name']],
                                      provider=ORIGINAL)
        lesson['dependencies']=deps
        source_bundle.update(deps)
        lesson['body']+=appendix
        normalize_lesson(lesson)
    # Export the nine specialised figures for each additive lesson and bind the
    # all-83 map registry; the legacy map renderers are not used for these two.
    small_atlas.attach(small_lessons, inventory)
    index_page = catalog(lessons,inventory,current=current_chapter)
    if comparison is not None:
        index_page['body'] = '<p class="note"><a href="cyberpunk-comparison.html"><strong>Cyberpunk character comparison and measured speed</strong></a> — Original / Legacy71 / Small31, with FP16 and FP8 views and separately scoped timings.</p>' + index_page['body']
    pages = [index_page, *lessons, *chapters]
    out.mkdir(parents=True,exist_ok=True); (out/'assets').mkdir(exist_ok=True)
    for page in pages:
        (out/f'{page["slug"]}.html').write_text(render_lesson_site(page,pages),encoding='utf-8',newline='\n')
    for path in sorted(source_bundle):
        destination=out/'source'/path
        destination.parent.mkdir(parents=True,exist_ok=True)
        destination.write_text(ORIGINAL.text(path),encoding='utf-8',newline='\n')
    source_paths = ({row['path'] for row in SNIPPETS} | source_bundle
                    | {'csrc/'+entry['header'] for entry in inventory['entries'].values()}
                    | set(RUNTIME_SOURCE_PATHS)
                    | set(CHECKPOINT_API_SOURCE_PATHS))
    if len(source_paths) != 118 or set(source_paths) != set(baseline['files']):
        raise SystemExit(
            f'Historical source set changed: {len(source_paths)} paths versus the frozen '
            f'118-file baseline; unexpected={sorted(set(source_paths)-set(baseline["files"]))}, '
            f'missing={sorted(set(baseline["files"])-set(source_paths))}')
    file_revisions = {path: file_provenance(path, ORIGINAL) for path in sorted(source_paths)}
    if file_revisions != baseline['file_revisions']:
        raise SystemExit('Regenerated per-file provenance differs from the frozen baseline')
    files = {path: ORIGINAL.sha256(path) for path in sorted(source_paths)}
    if files != baseline['files']:
        raise SystemExit('Regenerated historical file hashes differ from the frozen baseline')
    snippet_keys = ('path','start','end','sha256','source_kind','revision',
                    'source_sha256','url')
    regenerated_tuples = [tuple(row[key] for key in snippet_keys) for row in SNIPPETS]
    baseline_tuples = [tuple(row[key] for key in snippet_keys)
                       for row in baseline['snippets']]
    if len(SNIPPETS) != 1570 or regenerated_tuples != baseline_tuples:
        raise SystemExit(
            f'Historical excerpt registry changed: {len(SNIPPETS)} excerpts versus the '
            'frozen 1,570 tuples')
    if any(row.get('source_provider') != 'original' for row in SNIPPETS):
        raise SystemExit('An historical excerpt is not attributed to the original provider')
    for name in ('site.css','site.js'):
        (out/'assets'/name).write_text((ROOT/'tools/kernel_docs'/name).read_text(encoding='utf8'),encoding='utf8',newline='\n')

    current_snippets = list(CURRENT_SNIPPETS)
    current_source_paths = []
    current_dependencies_map = {}
    stale_current_tree = out / 'source-current'
    if stale_current_tree.is_dir():
        # Generated current copies are rewritten from the configured commit; a
        # build without a pin must not leave a stale current namespace behind.
        shutil.rmtree(stale_current_tree)
    if current is None:
        if current_snippets:
            raise SystemExit('Current-provider excerpts exist without a configured commit')
        current_files = {}
        current_file_revisions = {}
    else:
        if current_chapter is None:
            raise SystemExit('A current implementation commit is configured but the '
                             'FlashLight chapter was not built')
        # Current source copies live in a distinct tree; the historical
        # ``source/`` copies are never overwritten or extended with current code.
        current_source_paths = sorted(set(current_chapter['source_paths']))
        for path in current_source_paths:
            destination = out / 'source-current' / path
            destination.parent.mkdir(parents=True, exist_ok=True)
            destination.write_text(current.text(path), encoding='utf-8', newline='\n')
            current_dependencies_map[path] = current_dependencies(path, current)
        entry_headers = {'csrc/' + entry['header']
                         for entry in current_inventory['entries'].values()}
        current_paths = sorted(set(current_source_paths) | entry_headers
                               | set(current_chapter['linked_paths'])
                               | {row['path'] for row in current_snippets})
        current_files = {path: current.sha256(path) for path in current_paths}
        current_file_revisions = {path: file_provenance(path, current)
                                  for path in current_paths}
        missing = sorted(set(current_source_paths) - set(current_files))
        if missing:
            raise SystemExit(f'Current source bundle paths lack a manifest hash: {missing}')
    providers = [dict(name='original', revision=ORIGINAL_REFERENCE,
                      mode='immutable-snapshot', archive_paths=list(ORIGINAL.paths))]
    if current is not None:
        providers.append(dict(name='current', revision=current.revision,
                              mode='immutable-snapshot', archive_paths=list(current.paths)))
    flashlight_evidence = None
    if acceptance is not None:
        flashlight_evidence = dict(
            path='evidence-flashlight/acceptance.json',
            sha256=acceptance.sha256,
            acceptance_id=acceptance.acceptance_id,
            schema_version=acceptance.schema_version,
            state=acceptance.state,
            original_source_revision=acceptance.original_source_revision,
            candidate_source_revision=acceptance.candidate_source_revision,
            artifacts=[dict(path=artifact.path, sha256=artifact.sha256,
                            kind=artifact.kind, identity=artifact.identity)
                       for artifact in acceptance.artifacts],
            case_rows_sha256=current_chapter['evidence_case_rows_sha256'],
            gate_rows_sha256=current_chapter['evidence_gate_rows_sha256'],
        )
    manifest = dict(source_revision=REVISION,runtime_source_revision=RUNTIME_REVISION,
                    checkpoint_api_source_revision=CHECKPOINT_API_REVISION,
                    original_source_reference_revision=ORIGINAL_REFERENCE,
                    refactor_source_revision=(current.revision if current is not None else None),
                    source_providers=providers,
                    provenance_policy='explicit per-file: checkpoint-api-commit, legacy-commit '
                                      'and runtime-commit read from the immutable original '
                                      'snapshot; current sources use their own commit namespace',
                    repository=REPOSITORY,file_hash_encoding='UTF-8 with normalized LF newlines',
                    lesson_counts=dict(total=len(lessons),legacy=len(legacy_lessons),additive=len(small_lessons)),
                    evidence_sets=dict(legacy='evidence/index.json',additive='evidence-small/index.json'),
                    map_manifests=dict(legacy='kernel-map-manifest.json',additive='kernel-map-manifest-small.json',
                                       registry='kernel-map-registry.json'),
                    inventory=inventory,files=files,file_revisions=file_revisions,snippets=SNIPPETS,
                    current_files=current_files,current_file_revisions=current_file_revisions,
                    current_snippets=current_snippets,
                    current_inventory=current_inventory,
                    current_dependencies=current_dependencies_map,
                    current_source_paths=current_source_paths,
                    flashlight_evidence=flashlight_evidence,
                    flashlight_chapter=(
                        dict(slug=current_chapter['slug'], title=current_chapter['title'],
                             sections=current_chapter['sections'],
                             evidence_state=current_chapter['evidence_state'],
                             evidence_sha256=current_chapter['evidence_sha256'],
                             evidence_acceptance_id=current_chapter['evidence_acceptance_id'],
                             candidate_source_revision=current_chapter['source_revision'],
                             evidence_case_rows_sha256=current_chapter['evidence_case_rows_sha256'],
                             evidence_gate_rows_sha256=current_chapter['evidence_gate_rows_sha256'],
                             evidence_artifacts=current_chapter['evidence_artifacts'],
                             source_revision=current_chapter['source_revision'])
                        if current_chapter is not None else None),
                    pages=[dict(slug=p['slug'],title=p['title']) for p in pages],
                    lessons=[dict(name=p['name'],slug=p['slug'],family=p['family'],dependencies=p['dependencies']) for p in lessons])
    (out/'source-manifest.json').write_text(json.dumps(manifest,indent=2)+'\n',encoding='utf-8',newline='\n')
    write_map_manifest(legacy_lessons)
    small_atlas.write_manifest(small_lessons)
    small_atlas.write_registry(legacy_lessons, small_lessons)
    if out == DEFAULT_OUTPUT:
        (ROOT/'docs/.nojekyll').write_text('',encoding='utf-8')
        (ROOT/'docs/index.html').write_text('''<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><meta http-equiv="refresh" content="0;url=kernel-guide/index.html"><title>DLSS-NR Kernel Field Guide</title></head><body><h1>DLSS-NR Kernel Field Guide</h1><p><a href="kernel-guide/index.html">Open the FP16 / FP8 kernel documentation</a></p><p><a href="kernel-guide/architecture.html">Network architecture</a></p></body></html>''',encoding='utf-8',newline='\n')
    print(f'Generated {len(pages)} guide pages; {len(SNIPPETS)} exact excerpts; '
          f'{len(files)} source files; {inventory["entry_count"]} entries; '
          f'{inventory["definition_count"]} bodies; '
          f'{len(legacy_lessons)} legacy + {len(small_lessons)} additive lessons; '
          f'{1 if current_chapter is not None else 0} FlashLight chapter.')
    print(f'Output root: {out}; immutable original snapshot: {ORIGINAL_REFERENCE}; '
          f'historical paths checked: {pinned_paths}; runtime source revision: '
          f'{RUNTIME_REVISION}; checkpoint API source revision: {CHECKPOINT_API_REVISION}; '
          f'current provider: {current.revision if current is not None else "not configured"}; '
          f'current excerpts: {len(current_snippets)}; current source copies: '
          f'{len(current_source_paths)}.')


if __name__ == '__main__':
    main()
