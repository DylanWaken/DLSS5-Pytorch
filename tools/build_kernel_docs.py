"""Generate the static GitHub Pages kernel guide. Python standard library only.

Run from any directory: python tools/build_kernel_docs.py
The documented source revision is intentionally pinned in kernel_docs/common.py.
"""
from pathlib import Path
from html import escape, unescape
import importlib
import hashlib
import json
import re
import shutil
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'tools/kernel_docs'))
from common import REVISION, REPOSITORY, SNIPPETS, source_url
from kernel_sources import collect, check_roster, check_entry_layout

OUT = ROOT / 'docs/kernel-guide'


def anchor(text):
    return re.sub(r'[^\w\- ]', '', text.lower()).replace(' ', '-')


def inline(text):
    saved = []
    def protect(value):
        saved.append(value)
        return f'\x00{len(saved)-1}\x00'
    text = re.sub(r'`([^`]+)`', lambda m: protect('<code>' + escape(m[1]) + '</code>'), text)
    text = escape(text)
    def link(m):
        image, label, url = m.groups()
        if url.startswith('figures/'):
            url = '../' + url
        elif url.startswith('kernel-guide/'):
            url = url.removeprefix('kernel-guide/')
        elif url.startswith('../'):
            url = source_url(url[3:].split('#')[0]) + ('#' + url.split('#',1)[1] if '#' in url else '')
        elif url.split('#')[0].endswith('.md'):
            url = '../' + url
        if image:
            return f'<figure class="diagram"><img src="{url}" alt="{label}" loading="lazy"><figcaption>{label}</figcaption></figure>'
        return f'<a href="{url}">{label}</a>'
    text = re.sub(r'(!?)\[([^\]]+)\]\(([^)]+)\)', link, text)
    text = re.sub(r'\*\*([^*]+)\*\*', r'<strong>\1</strong>', text)
    text = re.sub(r'(?<!\*)\*([^*]+)\*(?!\*)', r'<em>\1</em>', text)
    for i, value in enumerate(saved):
        text = text.replace(f'\x00{i}\x00', value)
    return text


def markdown(text):
    """Render the deliberately small Markdown subset used by ARCHITECTURE.md."""
    out, paragraph, table, listing = [], [], [], []
    fence = None
    fenced = []
    def flush():
        if paragraph:
            out.append('<p>' + inline(' '.join(paragraph)) + '</p>'); paragraph.clear()
        if table:
            rows = [[c.strip() for c in l.strip().strip('|').split('|')] for l in table]
            out.append('<div class="table-scroll"><table><thead><tr>' + ''.join('<th>'+inline(c)+'</th>' for c in rows[0]) + '</tr></thead><tbody>')
            for row in rows[2:]:
                out.append('<tr>'+''.join('<td>'+inline(c)+'</td>' for c in row)+'</tr>')
            out.append('</tbody></table></div>'); table.clear()
        if listing:
            out.append('<ul>'+''.join('<li>'+inline(x)+'</li>' for x in listing)+'</ul>'); listing.clear()
    for line in text.splitlines():
        if line.startswith('```'):
            if fence is None:
                flush(); fence = line[3:]
            else:
                out.append('<pre><code>'+escape('\n'.join(fenced))+'</code></pre>'); fenced.clear(); fence = None
            continue
        if fence is not None:
            fenced.append(line); continue
        if not line.strip():
            flush(); continue
        heading = re.match(r'^(#{1,6}) (.*)', line)
        if heading:
            flush()
            if len(heading[1]) == 1: continue
            level = len(heading[1])
            out.append(f'<h{level} id="{anchor(heading[2])}">{inline(heading[2])}</h{level}>')
        elif line.startswith('|'):
            table.append(line)
        elif line.startswith('- '):
            listing.append(line[2:])
        elif line.startswith('!['):
            flush(); out.append(inline(line))
        else:
            paragraph.append(line)
    flush()
    return '\n'.join(out)


def chapter_for(name, path):
    if 'completion_counter' in name: return 'runtime'
    if '/input_c32/' in path or '/output_c32/' in path: return 'frontend'
    if 'c32_c64_c128_c256_fused' in path: return 'fused-windows'
    if 'c32_c64_c128_c256_downsample' in path or 'c32_c64_c128_c256_upsample' in path: return 'local-transitions'
    if 'bottleneck_c1024_attention/' in path and 'attention_chained' in name: return 'global-attention'
    if 'bottleneck_c1024' in path: return 'bottleneck-linear'
    if 'c512_ffn/' in path: return 'c512-ffn'
    if 'c512_attention_ffn_projection/' in path: return 'c512-attention' if 'attention' in name else 'c512-ffn'
    if 'c512' in path: return 'c512-attention'
    raise ValueError(f'No tutorial covers {name}: {path}')


def atlas(inventory):
    rows = []
    for name, entry in inventory['entries'].items():
        path = 'csrc/' + entry['header']
        chapter = chapter_for(name, path)
        precision = 'FP16' if name.endswith('_fp16') else 'FP8' if name.endswith('_fp8') else 'Common'
        args = '<br><code>' + escape(entry['template_arguments']) + '</code>' if 'template_arguments' in entry else ''
        rows.append(f'<tr><td><a href="{source_url(path, entry["line"])}"><code>{name}</code></a>{args}</td><td><span class="tag">{precision}</span></td><td><a href="{chapter}.html">{chapter.replace("-", " ")}</a><br><span class="source-link">{escape(entry["definition"])} · line {entry["line"]}</span></td></tr>')
    body = '''<h2 id="model">The model piece: all deployment entry families</h2><p>The architecture has 71 numbered records, while the CUDA interface exposes 81 public configurations: 40 paired FP8/FP16 roles plus completion-counter clearing. Many records reuse the same role with different weights, and templates let several public roles share one complete global body. This atlas maps every public configuration to its actual source definition and its teaching chapter.</p><p>Read the <a href="architecture.html">architecture guide</a> to identify the tensor operation, then use this table to reach the exact implementation. Entries link to a fixed source revision. The source census finds 56 complete global definitions; it does not establish runtime or performance coverage.</p>
<h2 id="entries">Find a kernel</h2><label for="kernel-filter">Filter by operation, precision or channel width</label><p><input class="filter-input" id="kernel-filter" type="search" placeholder="For example: qkv fp16, c512, downsample"></p><p id="filter-count" aria-live="polite">81 of 81 public entries shown</p>'''
    body += '<div class="table-scroll"><table class="inventory"><thead><tr><th>Public name / template arguments</th><th>Precision</th><th>Walkthrough / owning definition</th></tr></thead><tbody>' + '\n'.join(rows) + '</tbody></table></div>'
    body += '''<h2 id="provenance">Provenance and scope</h2><p>The inventory comes from <code>tools/kernel_sources.py</code>; its roster and source-ownership checks run during documentation generation. <a href="source-manifest.json">source-manifest.json</a> records file hashes, excerpt ranges and the public-entry mapping. Source excerpts are copied directly from the checked files. Layout calculations marked as examples are derived from those formulas; optimization mechanisms are explanations of the implementation, not new timing experiments.</p><p>The generated HTML is stored in <code>docs/kernel-guide</code>. Its Python content modules and assets live in <code>tools/kernel_docs</code>. Regenerate with <code>python tools/build_kernel_docs.py</code> and validate with <code>python tools/validate_kernel_docs.py</code>. The existing architecture Markdown is rendered here as a companion, while <a href="../ARCHITECTURE.md">the original document</a> remains available.</p>'''
    return dict(slug='source-atlas',title='The complete source atlas',summary='Every public FP16/FP8 configuration, its owning global definition and the walkthrough that explains it.',body=body)


def home(chapters, inventory):
    rows = ''.join(f'<a class="chapter-row" href="{c["slug"]}.html"><span class="num">{i:02}</span><div><strong>{escape(c["title"])}</strong><p>{escape(c["summary"])}</p></div><span>↗</span></a>' for i,c in enumerate(chapters,1))
    body = '''<h2 id="model">Start with the model, then follow the bytes</h2><p>DLSS-NR is a multiscale encoder–decoder with local window attention, a global-attention bottleneck and additive skip connections. Every walkthrough begins with the architecture piece it implements, then moves into tensor ownership, physical addresses, storage lifetimes, precision boundaries and the source instructions that realize them.</p><figure class="diagram"><img src="../figures/architecture/network.svg" alt="Full DLSS-NR network: input, encoder, global bottleneck, decoder and output with numbered record ranges"><figcaption>The existing <a href="architecture.html">architecture guide</a> supplies the model-level map. This field guide expands its nodes into deployment kernels.</figcaption></figure>
<div class="stats"><div><strong>71</strong><span>model records · 0–70</span></div><div><strong>81</strong><span>public CUDA configurations</span></div><div><strong>56</strong><span>complete global definitions</span></div><div><strong>2</strong><span>deployment precision paths</span></div></div>
<h2 id="route">A reading route through the implementation</h2><p>Begin with the tensor-to-warp primer. Follow the network from frontend through local blocks, C512 and the C1024 bottleneck, then read how the host schedules the work. Every excerpt has real line numbers and a pinned source link. SVG diagrams remain sharp when zoomed; wide diagrams and code scroll horizontally on small screens.</p>'''
    body += '<div class="chapter-list">'+rows+'</div>'
    body += '''<h2 id="scope">What this guide establishes</h2><p>This is a source-grounded explanation of the deployment implementation at the revision shown below. It distinguishes logical tensors from physical allocations and explains which numerical intermediates remain Half in the FP8 route. It also distinguishes software-controlled global/shared/register storage from hardware-managed cache behavior. The guide contains no fresh GPU timing or correctness qualification; reported benchmark scope remains the one documented in the repository.</p><p>Use the lane/address explorer in <a href="foundations.html#addressing">the primer</a> to test your understanding, and the searchable <a href="source-atlas.html">source atlas</a> to jump from any of the 81 public names to its body. Read <a href="../SETUP.md">SETUP.md</a> for actual build and deployment instructions.</p>'''
    return dict(slug='index',title='DLSS-NR kernels,\nfrom model to memory.',summary='A step-by-step field guide to the FP16 and FP8 deployment kernels—with tensor diagrams, lane maps, address calculations and the code beside each idea.',body=body)


def render(page, pages):
    idx = next(i for i,p in enumerate(pages) if p['slug'] == page['slug'])
    short = {'foundations':'Tensors, lanes & storage', 'frontend':'Input & output C32', 'fused-windows':'Fused C32–C256 windows', 'local-transitions':'Local down/up transitions', 'c512-ffn':'C512 grouped FFN', 'c512-attention':'C512 attention & transitions', 'bottleneck-linear':'C1024 FFN & layouts', 'global-attention':'Global QKV & attention', 'runtime':'Launches & optimization', 'architecture':'Architecture companion', 'source-atlas':'Complete source atlas'}
    nav = ''.join(f'<a href="{p["slug"]}.html"'+(' aria-current="page"' if p==page else '')+f'><span>{i:02}</span>{escape(short[p["slug"]])}</a>' for i,p in enumerate(pages) if p['slug']!='index')
    headings = re.findall(r'<h2 id="([^"]+)">(.*?)</h2>',page['body'],re.S)
    toc = '<div class="toc"><strong>On this page</strong>'+''.join(f'<a href="#{ident}">{title}</a>' for ident,title in headings)+'</div>'
    prev = f'<a href="{pages[idx-1]["slug"]}.html">← {escape(pages[idx-1]["title"].split(",")[0])}</a>' if idx>0 else '<span></span>'
    nxt = f'<a href="{pages[idx+1]["slug"]}.html">{escape(pages[idx+1]["title"].split(",")[0])} →</a>' if idx+1<len(pages) else '<a href="index.html">Back to the guide ↑</a>'
    words = len(re.sub(r'<[^>]+>',' ',page['body']).split())
    svg_count = page['body'].count('<svg') + page['body'].count('<img')
    return f'''<!doctype html>
<html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><meta name="description" content="{escape(page['summary'],quote=True)}"><meta name="color-scheme" content="light"><title>{escape(page['title'].replace(chr(10),' '))} · DLSS-NR Kernel Field Guide</title><link rel="stylesheet" href="assets/site.css"><script defer src="assets/site.js"></script></head>
<body><a class="skip" href="#main">Skip to content</a><aside class="sidebar"><a class="brand" href="index.html">DLSS<span>NR</span></a><p class="nav-kicker">Kernel field guide / FP16 + FP8</p><nav aria-label="Chapters">{nav}</nav><hr><div class="meta">Source snapshot<br><a href="{REPOSITORY}/tree/{REVISION}">{REVISION[:12]}</a><br>Local CUDA source + architecture docs<br><br><a href="../ARCHITECTURE.md">Original architecture Markdown</a><br><a href="{REPOSITORY}">Repository ↗</a></div></aside>
<div class="topbar"><span>DLSS-NR / DEPLOYMENT INTERNALS</span><div><button id="toggle-code" type="button">Collapse code</button></div></div><main id="main" class="page"><header><p class="eyebrow">{'A source-grounded learning companion' if idx==0 else f'Chapter {idx:02} / Model → tensor → storage → instruction'}</p><h1>{escape(page['title']).replace(chr(10),'<br>')}</h1><p class="lede">{escape(page['summary'])}</p><div class="reading-meta"><span>{max(3,round(words/210))} min with source excerpts</span><span>{svg_count} {'diagram' if svg_count==1 else 'diagrams'}</span><span>FP16 · E4M3 FP8 · Half accumulators</span></div></header>{toc}<article class="content">{page['body']}</article><nav class="next-prev" aria-label="Reading sequence">{prev}{nxt}</nav><footer class="footer">DLSS-NR kernel field guide · source {REVISION[:12]} · Generated from repository sources. <a href="source-atlas.html#provenance">Provenance</a> · <a href="architecture.html">Architecture companion</a></footer></main></body></html>'''


def main():
    subprocess.run(['git','diff','--exit-code',REVISION,'--','csrc','dlssnr'],cwd=ROOT,check=True,stdout=subprocess.DEVNULL)
    inventory = collect(ROOT/'csrc')
    check_roster(inventory); check_entry_layout(inventory,ROOT/'csrc')
    parts = {name: importlib.import_module(name).CHAPTERS for name in ('foundations','windows','c512','bottleneck')}
    chapters = [parts['foundations'][0], *parts['windows'], *parts['c512'], *parts['bottleneck'], parts['foundations'][1]]
    arch = dict(slug='architecture',title='The network architecture',summary='The existing architecture document, rendered as a readable HTML companion with its original tensor-flow diagrams.',body='<aside class="note">Rendered from <a href="../ARCHITECTURE.md">docs/ARCHITECTURE.md</a>. Model diagrams describe logical computation; the kernel chapters explain the actual deployment allocations and precision boundaries.</aside>'+markdown((ROOT/'docs/ARCHITECTURE.md').read_text(encoding='utf-8')))
    chapters += [arch, atlas(inventory)]
    pages = [home(chapters,inventory), *chapters]
    OUT.mkdir(parents=True,exist_ok=True); (OUT/'assets').mkdir(exist_ok=True)
    for page in pages:
        (OUT/f'{page["slug"]}.html').write_text(render(page,pages),encoding='utf-8',newline='\n')
    for name in ('site.css','site.js'):
        shutil.copyfile(ROOT/'tools/kernel_docs'/name,OUT/'assets'/name)
    source_paths = {row['path'] for row in SNIPPETS} | {'csrc/'+entry['header'] for entry in inventory['entries'].values()}
    files = {path: hashlib.sha256((ROOT/path).read_text(encoding='utf-8').encode('utf-8')).hexdigest() for path in sorted(source_paths)}
    manifest = dict(source_revision=REVISION,repository=REPOSITORY,file_hash_encoding='UTF-8 with normalized LF newlines',inventory=inventory,files=files,snippets=SNIPPETS,pages=[dict(slug=p['slug'],title=p['title']) for p in pages])
    (OUT/'source-manifest.json').write_text(json.dumps(manifest,indent=2)+'\n',encoding='utf-8',newline='\n')
    (ROOT/'docs/.nojekyll').write_text('',encoding='utf-8')
    (ROOT/'docs/index.html').write_text('''<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><meta http-equiv="refresh" content="0;url=kernel-guide/index.html"><title>DLSS-NR Kernel Field Guide</title></head><body><h1>DLSS-NR Kernel Field Guide</h1><p><a href="kernel-guide/index.html">Open the FP16 / FP8 kernel documentation</a></p><p><a href="kernel-guide/architecture.html">Network architecture</a></p></body></html>''',encoding='utf-8',newline='\n')
    print(f'Generated {len(pages)} guide pages; {len(SNIPPETS)} exact excerpts; {inventory["entry_count"]} entries; {inventory["definition_count"]} bodies.')


if __name__ == '__main__':
    main()
