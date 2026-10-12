"""Generate the static GitHub Pages kernel guide. Python standard library only.

Run from any directory: python tools/build_kernel_docs.py
The documented source revision is intentionally pinned in kernel_docs/common.py.
"""
from pathlib import Path
from html import escape
import importlib
import hashlib
import json
import shutil
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'tools/kernel_docs'))
from common import REVISION, REPOSITORY, SNIPPETS, source_url
from kernel_sources import collect, check_roster, check_entry_layout
from publishing import catalog, render as render_lesson_site, source_appendix, normalize_lesson
from token_visuals import enrich
from glossary import glossary_page

OUT = ROOT / 'docs/kernel-guide'


def atlas(inventory):
    rows = []
    for name, entry in inventory['entries'].items():
        path = 'csrc/' + entry['header']
        chapter = name
        precision = 'FP16' if name.endswith('_fp16') else 'FP8' if name.endswith('_fp8') else 'Common'
        args = '<br><code>' + escape(entry['template_arguments']) + '</code>' if 'template_arguments' in entry else ''
        rows.append(f'<tr><td><a href="{source_url(path, entry["line"])}"><code>{name}</code></a>{args}</td><td><span class="tag">{precision}</span></td><td><a href="{chapter}.html">Read this kernel from start to finish →</a><br><span class="source-link">{escape(entry["definition"])} · line {entry["line"]}</span></td></tr>')
    body = '''<h2 id="model">The model piece: all deployment entry families</h2><p>The architecture has 71 numbered records, while the CUDA interface exposes 81 public configurations: 40 paired FP8/FP16 roles plus completion-counter clearing. Many records reuse the same role with different weights, and templates let several public roles share one complete global body. This atlas maps every public configuration to its actual source definition and its self-contained lesson.</p><p>Read the <a href="architecture.html">architecture guide</a> to identify the tensor operation, then use this table to reach the exact implementation and its standalone reconstruction. Entries link to a fixed source revision. The source census finds 56 complete global definitions; it does not establish runtime or performance coverage.</p>
<h2 id="entries">Find a kernel</h2><label for="kernel-filter">Filter by operation, precision or channel width</label><p><input class="filter-input" id="kernel-filter" type="search" placeholder="For example: qkv fp16, c512, downsample"></p><p id="filter-count" aria-live="polite">81 of 81 public entries shown</p>'''
    body += '<div class="table-scroll"><table class="inventory"><thead><tr><th>Public name / template arguments</th><th>Precision</th><th>Walkthrough / owning definition</th></tr></thead><tbody>' + '\n'.join(rows) + '</tbody></table></div>'
    body += '''<h2 id="provenance">Provenance and scope</h2><p>The inventory comes from <code>tools/kernel_sources.py</code>; its roster and source-ownership checks run during documentation generation. <a href="source-manifest.json">source-manifest.json</a> records file hashes, excerpt ranges and the public-entry mapping. Source excerpts are copied directly from the checked files. Layout calculations marked as examples are derived from those formulas; optimization mechanisms are explanations of the implementation, not new timing experiments.</p><p>The generated HTML is stored in <code>docs/kernel-guide</code>. Its Python content modules and assets live in <code>tools/kernel_docs</code>. Regenerate with <code>python tools/build_kernel_docs.py</code> and validate with <code>python tools/validate_kernel_docs.py</code>. The <a href="architecture.html">network architecture</a> and its diagrams are maintained in the same HTML guide as the kernel lessons.</p>'''
    return dict(slug='source-atlas',title='The complete source atlas',summary='Every public FP16/FP8 configuration, its owning global definition and the walkthrough that explains it.',body=body)


def main():
    subprocess.run(['git','diff','--exit-code',REVISION,'--','csrc','dlssnr'],cwd=ROOT,check=True,stdout=subprocess.DEVNULL)
    inventory = collect(ROOT/'csrc')
    check_roster(inventory); check_entry_layout(inventory,ROOT/'csrc')
    parts = {name: importlib.import_module(name).CHAPTERS for name in ('foundations','windows','c512','bottleneck')}
    chapters = [parts['foundations'][0], *parts['windows'], *parts['c512'], *parts['bottleneck'], parts['foundations'][1]]
    arch = dict(slug='architecture',title='The network architecture',summary='The complete encoder–decoder: FFN and attention variants, tensor shapes, normalization, resolution transitions and precision boundaries.',body=(ROOT/'tools/kernel_docs/architecture.html').read_text(encoding='utf-8'))
    chapters += [arch, atlas(inventory), glossary_page()]
    lessons=[]
    for module in ('lessons_frontend','lessons_windows','lessons_c512','lessons_layout','lessons_bottleneck'):
        lessons.extend(importlib.import_module(module).build_lessons(inventory))
    names=[p['name'] for p in lessons]
    if len(set(names)) != len(names) or set(names) != set(inventory['entries']):
        raise ValueError(f'Incomplete standalone coverage: {set(inventory["entries"])-set(names)}; duplicate or extra names: {len(names)-len(set(names))}')
    source_bundle=set()
    for lesson in lessons:
        lesson['slug']=lesson['name']
        enrich(lesson, inventory['entries'][lesson['name']])
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
    pages = [catalog(lessons,inventory), *lessons, *chapters]
    OUT.mkdir(parents=True,exist_ok=True); (OUT/'assets').mkdir(exist_ok=True)
    for page in pages:
        (OUT/f'{page["slug"]}.html').write_text(render_lesson_site(page,pages),encoding='utf-8',newline='\n')
    for path in source_bundle:
        destination=OUT/'source'/path
        destination.parent.mkdir(parents=True,exist_ok=True)
        destination.write_text((ROOT/path).read_text(encoding='utf-8'),encoding='utf-8',newline='\n')
    for name in ('site.css','site.js'):
        shutil.copyfile(ROOT/'tools/kernel_docs'/name,OUT/'assets'/name)
    source_paths = {row['path'] for row in SNIPPETS} | source_bundle | {'csrc/'+entry['header'] for entry in inventory['entries'].values()}
    files = {path: hashlib.sha256((ROOT/path).read_text(encoding='utf-8').encode('utf-8')).hexdigest() for path in sorted(source_paths)}
    manifest = dict(source_revision=REVISION,repository=REPOSITORY,file_hash_encoding='UTF-8 with normalized LF newlines',inventory=inventory,files=files,snippets=SNIPPETS,pages=[dict(slug=p['slug'],title=p['title']) for p in pages],lessons=[dict(name=p['name'],slug=p['slug'],family=p['family'],dependencies=p['dependencies']) for p in lessons])
    (OUT/'source-manifest.json').write_text(json.dumps(manifest,indent=2)+'\n',encoding='utf-8',newline='\n')
    (ROOT/'docs/.nojekyll').write_text('',encoding='utf-8')
    (ROOT/'docs/index.html').write_text('''<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><meta http-equiv="refresh" content="0;url=kernel-guide/index.html"><title>DLSS-NR Kernel Field Guide</title></head><body><h1>DLSS-NR Kernel Field Guide</h1><p><a href="kernel-guide/index.html">Open the FP16 / FP8 kernel documentation</a></p><p><a href="kernel-guide/architecture.html">Network architecture</a></p></body></html>''',encoding='utf-8',newline='\n')
    print(f'Generated {len(pages)} guide pages; {len(SNIPPETS)} exact excerpts; {inventory["entry_count"]} entries; {inventory["definition_count"]} bodies.')


if __name__ == '__main__':
    main()
