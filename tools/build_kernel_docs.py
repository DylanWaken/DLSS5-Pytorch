"""Generate the static GitHub Pages kernel guide. Python standard library only.

Run from any directory: python tools/build_kernel_docs.py
The documented source revision is intentionally pinned in kernel_docs/common.py.
"""
from pathlib import Path
from html import escape
import importlib
import hashlib
import json
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'tools/kernel_docs'))
from common import (CHECKPOINT_API_REVISION, REVISION, REPOSITORY, RUNTIME_REVISION,
                     SNIPPETS, file_provenance, source_url)
from runtime_source_revision import (
    CHECKPOINT_API_CHANGED_PATHS,
    CHECKPOINT_API_HISTORICAL_PATHS,
    CHECKPOINT_API_SOURCE_PATHS,
    RUNTIME_SOURCE_PATHS,
)
from kernel_sources import collect, check_roster, check_entry_layout
from publishing import catalog, render as render_lesson_site, source_appendix, normalize_lesson
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

OUT = ROOT / 'docs/kernel-guide'


def check_pinned_sources():
    """Check every path that existed at the pin; additive files are allowed.

    The historical gate diffed the whole csrc/ and dlssnr/ trees and therefore
    rejected new additive modules.  This preserves the exact old-path check:
    list the pinned tree, then ask Git to compare those exact paths.  New files
    absent from the old tree are not part of this diff; modifications and
    deletions of any old path still fail.

    The checkpoint implementation deliberately changes three loader paths.  It
    is not allowed to rewrite their historical hashes or drop them from the
    122-path census.  The two companions that existed at the historical pin are
    compared against the separately configured checkpoint API commit instead;
    the loader itself is absent from the historical tree and is covered by its
    per-file provenance.  A missing checkpoint pin aborts the build.
    """
    if CHECKPOINT_API_REVISION is None:
        raise SystemExit(
            'CHECKPOINT_API_REVISION is not configured; set DLSSNR_CHECKPOINT_API_REVISION to '
            'the accepted full 40-character checkpoint implementation commit before building '
            'the guide. Historical and runtime pins are unchanged, and no older revision may '
            'own the changed checkpoint API sources.')
    listed = subprocess.run(
        ['git', 'ls-tree', '-r', '--name-only', REVISION, '--', 'csrc', 'dlssnr'],
        cwd=ROOT, check=True, capture_output=True, text=True,
    )
    paths = [line for line in listed.stdout.splitlines() if line]
    if not paths:
        raise SystemExit(f'Pinned source tree is empty at {REVISION}')
    # Keep the command line bounded on Windows while still comparing the exact
    # paths inherited from the pinned tree.  Only the two explicit loader
    # companions changed by the checkpoint implementation are separated; they
    # are still checked, against CHECKPOINT_API_REVISION, below.
    checkpoint_paths = set(CHECKPOINT_API_CHANGED_PATHS)
    historical_paths = [path for path in paths if path not in checkpoint_paths]
    separated = sorted(set(CHECKPOINT_API_HISTORICAL_PATHS).intersection(paths))
    expected_separated = sorted(CHECKPOINT_API_HISTORICAL_PATHS)
    if separated != expected_separated:
        raise SystemExit(
            f'Checkpoint API historical path allowlist does not match the pinned tree: '
            f'found {separated}, expected {expected_separated}')
    for start in range(0, len(historical_paths), 100):
        chunk = historical_paths[start:start + 100]
        try:
            subprocess.run(
                ['git', 'diff', '--exit-code', REVISION, '--', *chunk],
                cwd=ROOT, check=True, stdout=subprocess.DEVNULL,
            )
        except subprocess.CalledProcessError as exc:
            raise SystemExit(
                f'Pinned source drift: git diff exited {exc.returncode} for an existing '
                f'path under csrc/ or dlssnr/ at {REVISION}'
            ) from exc
    # The separated companions must match the checkpoint commit exactly.  This
    # is not an exclusion: a missing commit, missing path or changed blob fails.
    # Check every checkpoint-API path (including the quoted loader) exists at
    # the commit, then compare the companions as well.
    for path in CHECKPOINT_API_CHANGED_PATHS:
        present = subprocess.run(
            ['git', 'cat-file', '-e', f'{CHECKPOINT_API_REVISION}:{path}'],
            cwd=ROOT, capture_output=True,
        )
        if present.returncode != 0:
            raise SystemExit(
                f'{path} is not present at checkpoint API revision '
                f'{CHECKPOINT_API_REVISION}')
    try:
        subprocess.run(
            ['git', 'diff', '--exit-code', CHECKPOINT_API_REVISION, '--', *separated],
            cwd=ROOT, check=True, stdout=subprocess.DEVNULL,
        )
        subprocess.run(
            ['git', 'diff', '--exit-code', CHECKPOINT_API_REVISION, '--',
             *CHECKPOINT_API_SOURCE_PATHS],
            cwd=ROOT, check=True, stdout=subprocess.DEVNULL,
        )
    except subprocess.CalledProcessError as exc:
        raise SystemExit(
            f'Checkpoint API source drift: git diff exited {exc.returncode} for '
            f'{", ".join(CHECKPOINT_API_CHANGED_PATHS)} at {CHECKPOINT_API_REVISION}'
        ) from exc
    if len(paths) != 122:
        raise SystemExit(f'Expected 122 historical csrc/dlssnr paths at {REVISION}, found {len(paths)}')
    return len(paths)



def _atlas_row(name, entry):
    path = 'csrc/' + entry['header']
    chapter = name
    precision = 'FP16' if name.endswith('_fp16') else 'FP8' if name.endswith('_fp8') else 'Common'
    args = '<br><code>' + escape(entry['template_arguments']) + '</code>' if 'template_arguments' in entry else ''
    return f'<tr><td><a href="{source_url(path, entry["line"])}"><code>{name}</code></a>{args}</td><td><span class="tag">{precision}</span></td><td><a href="{chapter}.html">Read this kernel from start to finish →</a><br><span class="source-link">{escape(entry["definition"])} · line {entry["line"]}</span></td></tr>'


def atlas(inventory):
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
    body += '''<h2 id="provenance">Provenance and scope</h2><p>The inventory comes from <code>tools/kernel_sources.py</code>; its roster and source-ownership checks run during documentation generation. <a href="source-manifest.json">source-manifest.json</a> records file hashes, excerpt ranges and the public-entry mapping with per-file legacy/runtime provenance. Source excerpts are copied directly from the checked files. Layout calculations marked as examples are derived from those formulas; optimization mechanisms are explained from source. <a href="measurement-method.html">Separate measured evidence</a> accompanies the 81 historical lessons, including compiled resources and source-correlated instruction counts. The two additive lessons have their own <a href="evidence-small/index.json">evidence-small record</a> and <a href="kernel-map-manifest-small.json">small map manifest</a>; <a href="kernel-map-registry.json">the all-83 registry</a> maps both sets.</p><p>The generated HTML is stored in <code>docs/kernel-guide</code>. Its Python content modules and assets live in <code>tools/kernel_docs</code>. Regenerate with <code>python tools/build_kernel_docs.py</code> and validate with <code>python tools/validate_kernel_docs.py</code>. The <a href="architecture.html">network architecture</a> and its diagrams are maintained in the same HTML guide as the kernel lessons.</p>'''
    return dict(slug='source-atlas',title='The complete source atlas',summary='Every public FP16/FP8 configuration, its owning global definition and the walkthrough that explains it.',body=body)


def main():
    pinned_paths = check_pinned_sources()
    # Audit the real source tree directly.  The exact 83-entry / 58-body
    # inventory must see every file, including the additive Small host and
    # generated plan sources; no temporary copy or exclusion list is used.
    inventory = collect(ROOT / 'csrc')
    check_roster(inventory); check_entry_layout(inventory,ROOT/'csrc')
    if inventory['entry_count'] != 83 or inventory['definition_count'] != 58:
        raise ValueError(f'Expected 83 entries / 58 definitions, found '
                         f'{inventory["entry_count"]} / {inventory["definition_count"]}')
    parts = {name: importlib.import_module(name).CHAPTERS for name in ('foundations','windows','c512','bottleneck')}
    chapters = [parts['foundations'][0], *parts['windows'], *parts['c512'], *parts['bottleneck'], parts['foundations'][1], RUNTIME_UPDATE]
    arch = dict(slug='architecture',title='The network architecture',summary='The complete encoder–decoder: FFN and attention variants, tensor shapes, normalization, resolution transitions and precision boundaries.',body=(ROOT/'tools/kernel_docs/architecture.html').read_text(encoding='utf-8'))
    chapters += [arch, atlas(inventory), glossary_page()]
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
        appendix,deps=source_appendix(lesson,inventory['entries'][lesson['name']])
        lesson['dependencies']=deps
        source_bundle.update(deps)
        lesson['body']+=appendix
        normalize_lesson(lesson)
    # Export the nine specialised figures for each additive lesson and bind the
    # all-83 map registry; the legacy map renderers are not used for these two.
    small_atlas.attach(small_lessons, inventory)
    index_page = catalog(lessons,inventory)
    if comparison is not None:
        index_page['body'] = '<p class="note"><a href="cyberpunk-comparison.html"><strong>Cyberpunk character comparison and measured speed</strong></a> — Original / Legacy71 / Small31, with FP16 and FP8 views and separately scoped timings.</p>' + index_page['body']
    pages = [index_page, *lessons, *chapters]
    OUT.mkdir(parents=True,exist_ok=True); (OUT/'assets').mkdir(exist_ok=True)
    for page in pages:
        (OUT/f'{page["slug"]}.html').write_text(render_lesson_site(page,pages),encoding='utf-8',newline='\n')
    for path in source_bundle:
        destination=OUT/'source'/path
        destination.parent.mkdir(parents=True,exist_ok=True)
        destination.write_text((ROOT/path).read_text(encoding='utf-8'),encoding='utf-8',newline='\n')
    source_paths = ({row['path'] for row in SNIPPETS} | source_bundle
                    | {'csrc/'+entry['header'] for entry in inventory['entries'].values()}
                    | set(RUNTIME_SOURCE_PATHS)
                    | set(CHECKPOINT_API_SOURCE_PATHS))
    file_revisions = {path: file_provenance(path) for path in sorted(source_paths)}
    # Files that are not present at the historical pin must link to an exact
    # normalized-LF local copy rather than to an old commit that lacks them.
    local_runtime_paths = {path for path, info in file_revisions.items()
                           if info['kind'] == 'working-tree'}
    for path in sorted(local_runtime_paths):
        destination=OUT/'source'/path
        destination.parent.mkdir(parents=True,exist_ok=True)
        destination.write_text((ROOT/path).read_text(encoding='utf-8'),encoding='utf-8',newline='\n')
    for name in ('site.css','site.js'):
        (OUT/'assets'/name).write_text((ROOT/'tools/kernel_docs'/name).read_text(encoding='utf8'),encoding='utf8',newline='\n')
    files = {path: hashlib.sha256((ROOT/path).read_text(encoding='utf-8').encode('utf-8')).hexdigest() for path in sorted(source_paths)}
    manifest = dict(source_revision=REVISION,runtime_source_revision=RUNTIME_REVISION,
                    checkpoint_api_source_revision=CHECKPOINT_API_REVISION,
                    provenance_policy='per-file: checkpoint-api-commit, legacy-commit, runtime-commit, or exact working-tree copy',
                    repository=REPOSITORY,file_hash_encoding='UTF-8 with normalized LF newlines',
                    lesson_counts=dict(total=len(lessons),legacy=len(legacy_lessons),additive=len(small_lessons)),
                    evidence_sets=dict(legacy='evidence/index.json',additive='evidence-small/index.json'),
                    map_manifests=dict(legacy='kernel-map-manifest.json',additive='kernel-map-manifest-small.json',
                                       registry='kernel-map-registry.json'),
                    inventory=inventory,files=files,file_revisions=file_revisions,snippets=SNIPPETS,
                    pages=[dict(slug=p['slug'],title=p['title']) for p in pages],
                    lessons=[dict(name=p['name'],slug=p['slug'],family=p['family'],dependencies=p['dependencies']) for p in lessons])
    (OUT/'source-manifest.json').write_text(json.dumps(manifest,indent=2)+'\n',encoding='utf-8',newline='\n')
    write_map_manifest(legacy_lessons)
    small_atlas.write_manifest(small_lessons)
    small_atlas.write_registry(legacy_lessons, small_lessons)
    (ROOT/'docs/.nojekyll').write_text('',encoding='utf-8')
    (ROOT/'docs/index.html').write_text('''<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><meta http-equiv="refresh" content="0;url=kernel-guide/index.html"><title>DLSS-NR Kernel Field Guide</title></head><body><h1>DLSS-NR Kernel Field Guide</h1><p><a href="kernel-guide/index.html">Open the FP16 / FP8 kernel documentation</a></p><p><a href="kernel-guide/architecture.html">Network architecture</a></p></body></html>''',encoding='utf-8',newline='\n')
    print(f'Generated {len(pages)} guide pages; {len(SNIPPETS)} exact excerpts; {inventory["entry_count"]} entries; {inventory["definition_count"]} bodies; '
          f'{len(legacy_lessons)} legacy + {len(small_lessons)} additive lessons.')
    print(f'Pinned historical paths checked: {pinned_paths}; runtime source revision: '
          f'{RUNTIME_REVISION or "working tree (uncommitted)"}; checkpoint API source revision: '
          f'{CHECKPOINT_API_REVISION or "unconfigured"}; '
          f'local runtime source copies: {len(local_runtime_paths)}.')


if __name__ == '__main__':
    main()
