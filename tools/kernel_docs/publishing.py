"""Standalone-kernel catalog, source bundle, and reading-oriented page shell."""
from pathlib import Path
from html import escape, unescape
import re
from common import ROOT, REVISION, REPOSITORY, code, source_url
from highlight import highlight_blocks


def dependencies(path):
    found=set()
    def visit(p):
        p=p.resolve()
        if p in found:return
        if not p.is_relative_to(ROOT/'csrc') or not p.is_file():return
        found.add(p)
        for inc in re.findall(r'^\s*#include\s+"([^"]+)"',p.read_text(encoding='utf-8'),re.M):
            candidate=p.parent/inc
            if not candidate.is_file():candidate=ROOT/'csrc'/inc
            visit(candidate)
    visit(ROOT/path)
    return [p.relative_to(ROOT).as_posix() for p in sorted(found)]


def source_appendix(lesson,entry):
    path='csrc/'+entry['header']
    deps=dependencies(path)
    text=(ROOT/path).read_text(encoding='utf-8')
    body='<h2 id="source-appendix">Source appendix: the complete implementation and ABI</h2>'
    body+=f'<p>Public entry: <code>{escape(lesson["name"])}</code>. Owning definition: <code>{escape(entry["definition"])}</code>.'
    if 'template_arguments' in entry:body+=f' This entry selects template arguments <code>{escape(entry["template_arguments"])}</code> through <code>{escape(entry["resolver"])}</code>.'
    body+=' The complete translation unit is retained below for reconstruction after the walkthrough. Exact excerpts and local source files use the pinned revision shown in the sidebar.</p>'
    body+=code(path,1,len(text.splitlines()),'Complete owning CUDA source').replace('<details class="source" open>','<details class="source">',1)
    abi='csrc/kernel_impl/shared/common/kernel_abi.h'
    abi_text=(ROOT/abi).read_text(encoding='utf-8')
    typename=entry['parameters'].split()[0]
    visited=set()
    aliases=[]
    while typename not in visited:
        visited.add(typename)
        alias=re.search(r'\busing\s+'+re.escape(typename)+r'\s*=\s*(\w+)\s*;',abi_text)
        if alias:
            aliases.append(alias[0]);typename=alias[1];continue
        inherited=re.search(r'\bstruct\s+(?:alignas\([^)]*\)\s+)?'+re.escape(typename)+r'\s*:\s*(\w+)\s*\{\s*\};',abi_text)
        if inherited:
            aliases.append(inherited[0]);typename=inherited[1];continue
        break
    match=re.search(r'\bstruct\s+(?:alignas\([^)]*\)\s+)?'+re.escape(typename)+r'\s*\{.*?\n\};',abi_text,re.S)
    if match:
        start=abi_text[:match.start()].count('\n')+1
        end=start+match[0].count('\n')
        if aliases:body+='<p>The public parameter name resolves through <code>'+escape(' '.join(aliases))+'</code>.</p>'
        body+=code(abi,start,end,'Exact launch parameter record').replace('<details class="source" open>','<details class="source">',1)
    else:
        raise ValueError(f'Cannot resolve ABI for {lesson["name"]}: {typename}')
    body+='<details class="dependency-list"><summary>Read or download the implementation and all repository-local included sources</summary><p>Includes are followed transitively; this list may contain declarations unused by this specialization. CUDA SDK headers are provided by your CUDA toolkit and are not bundled here. File links below open plain source files from this documentation site.</p><ul>'
    body+=''.join(f'<li><a href="source/{p}"><code>{p}</code></a> · <a href="{source_url(p)}">pinned GitHub copy</a></li>' for p in deps)
    body+='</ul></details>'
    return body,deps


def normalize_lesson(page):
    """Number the local reading sequence and isolate every inline SVG's IDs."""
    count=0
    def heading(m):
        nonlocal count
        count+=1
        title=re.sub(r'^\s*\d+[.)]\s*','',m[2])
        return f'<h2 id="{m[1]}">{count:02}. {title}</h2>'
    page['body']=re.sub(r'<h2 id="([^"]+)">(.*?)</h2>',heading,page['body'],flags=re.S)
    return page


def isolate_svgs(body):
    count=0
    def figure(m):
        nonlocal count
        count+=1
        frag=m[0]
        ids=re.findall(r'\bid="([^"]+)"',frag)
        for ident in sorted(set(ids),key=len,reverse=True):
            new=f'figure-{count}-{ident}'
            frag=frag.replace(f'id="{ident}"',f'id="{new}"').replace(f'url(#{ident})',f'url(#{new})').replace(f'aria-labelledby="{ident}"',f'aria-labelledby="{new}"').replace(f'href="#{ident}"',f'href="#{new}"')
        return frag
    return re.sub(r'<svg\b.*?</svg>',figure,body,flags=re.S)


def catalog(lessons,inventory):
    families={}
    for lesson in lessons:
        family=lesson['family'];base=re.sub(r'_fp(?:8|16)$','',lesson['name'])
        families.setdefault(family,{}).setdefault(base,{})['FP8' if lesson['name'].endswith('fp8') else 'FP16' if lesson['name'].endswith('fp16') else 'Common']=lesson
    order={'Input frontend':0,'Local windows':1,'C512 and transitions':2,'C1024 layout':3,'Global bottleneck':4,'Output frontend':5,'Scheduling':6}
    rows=[]
    for family, groups in sorted(families.items(),key=lambda kv:(order.get(kv[0],2),kv[0])):
        def lesson_order(item):
            stem=item[0]
            if family=='Local windows':
                channel=int(re.search(r'_c(\d+)',stem)[1])
                mode=next((i for i,s in enumerate(('input_view','output_view','downsample','upsample'),1) if s in stem),0)
                return channel,mode
            if family=='C1024 layout':return (0 if '2d_to_1d' in stem else 1,0)
            if family=='Global bottleneck':return (next(i for i,s in enumerate(('ffn_expand','ffn_contract','qkv','attention_chained','projection')) if s in stem),0)
            return (list(groups).index(stem),0)
        for base,variants in sorted(groups.items(),key=lesson_order):
            links=[]
            for precision in ('FP16','FP8','Common'):
                if precision in variants:
                    p=variants[precision]
                    links.append(f'<a class="lesson-link" href="{p["slug"]}.html">{precision} lesson →</a>')
            example=variants.get('FP16',next(iter(variants.values())))
            description=re.sub(r'(^FP(?:8|16)\s+|\s+[—·-]\s+FP(?:8|16)$)','',example['title'])
            rows.append(f'<tr><td><span class="family-label">{escape(family)}</span><br><code>{escape(base)}</code><br><span class="operation-description">{escape(description)}</span></td><td>{" ".join(links)}</td></tr>')
    body='''<h2 id="model">Begin with one kernel and finish with a reconstruction</h2><p>DLSS-NR is an encoder–decoder with local window attention, a global-attention bottleneck, and residual connections. Choose the model operation below. Each precision-specific entry has its own complete lesson: architecture and equations, a simple correctness oracle, thread and lane ownership, byte-address derivations, incremental implementation, storage lifetimes, numerical details, optimization tradeoffs, reconstruction steps and targeted checks.</p><p>You do not need to read a family chapter first. Prerequisites are repeated inside each lesson so that the entire reasoning fits into one linear reading session. Template specializations get separate pages because width, precision and boundary mode change the contract even when they share a CUDA body.</p><figure class="diagram"><img src="../figures/architecture/network.svg" alt="The DLSS-NR network with frontend, local encoder, global bottleneck, decoder and output records"><figcaption>Locate an operation with the <a href="architecture.html">rendered architecture document</a> or the original <a href="../ARCHITECTURE.md">docs/ARCHITECTURE.md</a>.</figcaption></figure>
<div class="stats"><div><strong>81</strong><span>standalone kernel lessons</span></div><div><strong>40</strong><span>paired FP16 / FP8 roles</span></div><div><strong>56</strong><span>underlying CUDA definitions</span></div></div>
<h2 id="kernels">Choose one kernel</h2><p>If you want a small complete transformer first, start with <a href="window_block_c32_fp16.html">the ordinary FP16 C32 window block</a>. For an addressing-only exercise, start with <a href="repack_2d_to_1d_c1024_fp16.html">the FP16 spatial-to-token repack</a>. Every other page stands on its own.</p><label for="kernel-filter">Find an operation or channel width</label><p><input class="filter-input" id="kernel-filter" type="search" placeholder="Try: qkv, input_view, downsample, c1024"></p><p id="filter-count" aria-live="polite"></p>'''
    body+='<div class="table-scroll"><table class="inventory"><thead><tr><th>Model operation / public entry stem</th><th>Self-contained walkthrough</th></tr></thead><tbody>'+''.join(rows)+'</tbody></table></div>'
    body+='''<h2 id="reading">How to use a lesson</h2><p>Read it in order once. Then implement its scalar oracle, check one worked address by hand, reconstruct the lane map, and add each optimized stage while preserving the numerical boundaries. Source excerpts sit beside the relevant derivation; the complete source and launch record are at the end. Diagrams distinguish global allocations, hardware-managed caches, explicitly indexed shared memory, register fragments and compute. Wide figures scroll horizontally rather than shrinking their labels.</p><p>The teaching progression is inspired by <a href="https://www.spatters.ca/mma-matmul">the MMA matmul tutorial at spatters.ca</a>: establish the problem, derive ownership and addressing, then explain why an optimization follows. All kernel details, diagrams, formulas and code excerpts here are based on this repository’s implementation.</p>
<h2 id="references">Optional references and provenance</h2><p>The <a href="source-atlas.html">source atlas</a> maps all public names to their owning definitions and lessons. The <a href="foundations.html">tensor/lane primer</a>, <a href="runtime.html">host scheduling reference</a> and <a href="architecture.html">architecture companion</a> provide broader context. Existing family overviews remain at their original URLs for reference; the catalog above is the primary reading path.</p><p>This is a source explanation at the pinned revision, not a new GPU benchmark or correctness certification. Hardware cache residence, allocated register counts, spills and speedups require measurement. <a href="source-manifest.json">The manifest</a> records every kernel lesson, source dependency, excerpt range and source-file hash. Regenerate with <code>python tools/build_kernel_docs.py</code>; check with <code>python tools/validate_kernel_docs.py</code>.</p>'''
    return dict(slug='index',title='One kernel.\nFrom first principles to source.',summary='81 self-contained FP16 and FP8 kernel lessons. Start with the model operation, derive the data layout, and build the optimized implementation one step at a time.',body=body)


def render(page,pages):
    lesson='name' in page
    headings=re.findall(r'<h2 id="([^"]+)">(.*?)</h2>',page['body'],re.S)
    toc_links=''.join(f'<a href="#{ident}">{title}</a>' for ident,title in headings)
    nav=''.join(f'<a href="{slug}.html"'+(' aria-current="page"' if page['slug']==slug else '')+f'>{label}</a>' for slug,label in [('index','All 81 kernel lessons'),('architecture','Model architecture'),('source-atlas','Public entry → source'),('foundations','Tensor / lane reference'),('runtime','Host scheduling reference')])
    localnav=f'<hr><nav class="local-nav" aria-label="This lesson"><p class="nav-kicker">Inside this lesson</p>{toc_links}</nav>' if lesson else ''
    body=isolate_svgs(highlight_blocks(page['body']))
    prose=re.sub(r'<(?:pre|details)\b.*?</(?:pre|details)>',' ',body,flags=re.S)
    words=len(re.sub(r'<[^>]+>',' ',prose).split())
    diagrams=body.count('<svg')+body.count('<img')
    precision='FP8 E4M3' if page['slug'].endswith('_fp8') else 'FP16' if page['slug'].endswith('_fp16') else 'Integer state' if page['slug']=='completion_counter_clear' else 'Deployment internals'
    identity=f'<p class="kernel-identity"><code>{escape(page["name"])}</code></p>' if lesson else ''
    bodyclass=' class="kernel-lesson"' if lesson else ''
    toc=f'<details class="toc"><summary>Reading sequence · {len(headings)} sections</summary><div>{toc_links}</div></details>'
    pair=''
    if lesson and re.search('_fp(?:8|16)$',page['slug']):
        other=re.sub('_fp(?:8|16)$','_fp16' if page['slug'].endswith('_fp8') else '_fp8',page['slug'])
        pair=f'<a href="{other}.html">Read the other precision →</a>'
    return f'''<!doctype html>
<html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><meta name="description" content="{escape(page['summary'],quote=True)}"><meta name="color-scheme" content="light"><title>{escape(page['title'].replace(chr(10),' '))} · DLSS-NR Kernel Lessons</title><link rel="stylesheet" href="assets/site.css"><script defer src="assets/site.js"></script></head>
<body{bodyclass}><a class="skip" href="#main">Skip to content</a><aside class="sidebar"><a class="brand" href="index.html">DLSS<span>NR</span></a><p class="nav-kicker">One document per kernel</p><nav aria-label="Guide">{nav}</nav>{localnav}<hr><div class="meta">Source snapshot<br><a href="{REPOSITORY}/tree/{REVISION}">{REVISION[:12]}</a><br><a href="../ARCHITECTURE.md">Architecture Markdown</a><br><a href="{REPOSITORY}">Repository ↗</a></div></aside>
<div class="topbar"><a href="index.html#kernels">Browse kernels</a><button id="toggle-code" type="button">Collapse code</button></div><main id="main" class="page"><header><p class="eyebrow">{'A complete kernel reconstruction' if lesson else 'DLSS-NR / deployment internals'}</p><h1>{escape(page['title']).replace(chr(10),'<br>')}</h1>{identity}<p class="lede">{escape(page['summary'])}</p><div class="reading-meta"><span>{precision}</span><span>~{max(3,round(words/190))} min of explanation + source study</span><span>{diagrams} {'diagram' if diagrams==1 else 'diagrams'}</span></div></header>{toc}<article class="content">{body}</article><nav class="next-prev" aria-label="Related reading"><a href="index.html#kernels">← Kernel catalog</a>{pair}</nav><footer class="footer">DLSS-NR kernel lessons · source {REVISION[:12]} · <a href="source-atlas.html#provenance">Provenance</a> · <a href="architecture.html">Architecture companion</a></footer></main></body></html>'''
