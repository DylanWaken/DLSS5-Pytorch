"""Standalone-kernel catalog, source bundle, and reading-oriented page shell."""
from pathlib import Path
from html import escape, unescape
import re
from common import ROOT, REVISION, RUNTIME_REVISION, REPOSITORY, code, source_url
from highlight import highlight_blocks
from glossary import annotate


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
    body='<h3 id="source-appendix">Complete implementation and ABI</h3>'
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
        mapping={ident:f'figure-{count}-{ident}' for ident in set(ids)}
        frag=re.sub(r'aria-labelledby="([^"]+)"',lambda a:'aria-labelledby="'+' '.join(mapping.get(i,i) for i in a[1].split())+'"',frag)
        for ident in sorted(set(ids),key=len,reverse=True):
            new=f'figure-{count}-{ident}'
            frag=frag.replace(f'id="{ident}"',f'id="{new}"').replace(f'url(#{ident})',f'url(#{new})').replace(f'aria-labelledby="{ident}"',f'aria-labelledby="{new}"').replace(f'href="#{ident}"',f'href="#{new}"')
        return frag
    return re.sub(r'<svg\b.*?</svg>',figure,body,flags=re.S)


def catalog(lessons,inventory):
    from catalog_tree import render_catalog
    body='''<h2 id="model">Design one kernel from its model contract</h2><p>DLSS-NR is an encoder–decoder with local window attention, a global-attention bottleneck, and residual connections. Choose the model operation below. Every precision-specific lesson follows a forward design process in six sections: <strong>whole problem → one CTA → one warp/thread → resource budget → execution schedule → one token through source</strong>. Start with a correct baseline, identify its cost, derive candidate tiles and ownership, and budget their live state before implementing the schedule. Specialized diagrams make those choices concrete. The final section builds the candidate in milestones and tests its predictions against recorded SM120 evidence.</p><p>You do not need to read a family chapter first. Prerequisites are repeated inside each lesson so that the entire reasoning fits into one linear reading session. Template specializations get separate pages because width, precision and boundary mode change the contract even when they share a CUDA body.</p><p><strong>New as of 2026-10-29:</strong> <a href="runtime-310-9-16.html">the DLSS 310.9.16 / Small31 forward-design chapter</a> documents the separately trained 31-role model, the raw-id → operation-role mapping, the changed window phases and the strict provenance boundary. The 81 legacy kernel lessons below remain the historical 310.8/71-block implementation evidence; the two additive Small31 attention lessons use the new committed source and the explicit Small31 FP32-accumulation contract.</p><figure class="diagram"><img src="assets/architecture/network.svg" alt="The DLSS-NR network with frontend, local encoder, global bottleneck, decoder and output records"><figcaption>Locate an operation in the <a href="architecture.html">network architecture guide</a>.</figcaption></figure>
<div class="stats"><div><strong>83</strong><span>standalone kernel lessons</span></div><div><strong>41</strong><span>paired FP16 / FP8 roles</span></div><div><strong>58</strong><span>underlying CUDA definitions</span></div></div>
<h2 id="kernels">Choose an operator, variant, and channel width</h2><p>The catalog follows <strong>operator type → variant → channels</strong>. FP16 and FP8 lessons sit together under each role. Fused kernels appear once under their complete operation; downsampling and upsampling entries include any fused transformer work described in their variant.</p><p>If you want a small complete transformer first, start with <a href="window_block_c32_fp16.html">the ordinary FP16 C32 window block</a>. For an addressing-only exercise, start with <a href="repack_2d_to_1d_c1024_fp16.html">the FP16 spatial-to-token repack</a>. Every other page stands on its own.</p><label for="kernel-filter">Find an operation or channel width</label><p><input class="filter-input" id="kernel-filter" type="search" placeholder="Try: grouped ffn, global attn, upsample, c128"></p><p id="filter-count" aria-live="polite"></p>'''
    body+=render_catalog(lessons)
    body+='''<h2 id="reading">How to use a lesson</h2><p><a href="measurement-method.html#standard">The six-section standard</a> is shared by all 83 kernel lessons. <a href="measurement-method.html#coverage">The 81 original entries have full and source-counter NCU evidence</a>, with downloadable raw reports, exact metric names, source-correlated SASS, and fixture details. The two additive Small31 attention lessons also record committed source, compiled resources, numerical-reference receipts and four current full/source NCU reports for an isolated replay of one attention call; no legacy report is reused.</p><p>Read in order and make each decision before moving on. Implement the scalar oracle, compare subdivisions, check one worked address by hand, and add each mechanism while preserving the numerical boundaries. Each change needs a correctness test and a falsifiable performance hypothesis; proposed alternatives have no implied benchmark result. Source excerpts sit beside the relevant derivation; the complete source and launch record are at the end. Diagrams distinguish global allocations, hardware-managed caches, explicitly indexed shared memory, register fragments and compute. Wide figures scroll horizontally rather than shrinking their labels.</p><p>The design progression follows the style of <a href="https://medium.com/@emmanuelalo52/anatomy-of-a-cuda-gemm-from-naive-kernels-to-outperforming-cublas-on-blackwell-c394b04b5995">Anatomy of a CUDA GEMM</a>: a limitation of the simpler implementation motivates the next mechanism. <a href="https://www.spatters.ca/mma-matmul">The MMA tutorial at spatters.ca</a> also informs the lane-level teaching style. Read the <a href="measurement-method.html#experiments">experiment ledger</a> to distinguish reconstructed design reasoning, executable arithmetic checks and actual profiler results. The per-kernel tiling atlases use the visual progression of <a href="https://developer.nvidia.com/blog/cutlass-linear-algebra-cuda/">NVIDIA’s CUTLASS hierarchy</a>: logical matrices → CTA tiles → warp tiles → instruction fragments. Their dimensions, storage paths and token traces come from this repository’s individual kernels. Each atlas is also available as a full-size SVG download.</p>
<h2 id="references">Optional references and provenance</h2><p>The <a href="source-atlas.html">source atlas</a> maps all public names to their owning definitions and lessons. The <a href="foundations.html">tensor/lane primer</a>, <a href="runtime.html">host scheduling reference</a> and <a href="architecture.html">architecture companion</a> provide broader context. Existing family overviews remain at their original URLs for reference; the catalog above is the primary reading path.</p><p>The source explanation is pinned; for the 81 original entries, fresh Nsight Compute reports separately verify compiled resources, executed instructions and sampled behavior on SM120. The two additive Small31 entries record committed source, compiler attributes, numerical-reference receipts and current full/source NCU evidence for an isolated replay of one attention call. Source equations establish token addresses; aggregate counters do not trace a semantic token or prove a speedup. See <a href="measurement-method.html#limits">what each kind of evidence supports</a>. <a href="source-manifest.json">The manifest</a> records every kernel lesson, source dependency, excerpt range and source-file hash. The <a href="kernel-map-manifest.json">legacy diagram manifest</a> records the 81 original entries’ tile geometry, storage sizes, and exported SVG hashes; <a href="kernel-map-manifest-small.json">the additive diagram manifest</a> covers the two Small31 attention entries, and <a href="kernel-map-registry.json">the all-83 map registry</a> binds both. Regenerate with <code>python tools/build_kernel_docs.py</code>; check with <code>python tools/validate_kernel_docs.py</code>.</p>'''
    return dict(slug='index',title='One kernel.\nDesign it from first principles.',summary='83 self-contained FP16 and FP8 kernel lessons: 81 original entries plus two additive Small31 FP32-accumulation attention entries. Start with the model operation, derive the data layout, and build the optimized implementation one step at a time.',body=body)


def render(page,pages):
    lesson='name' in page
    headings=re.findall(r'<h2 id="([^"]+)">(.*?)</h2>',page['body'],re.S)
    toc_links=''.join(f'<a href="#{ident}">{title}</a>' for ident,title in headings)
    nav=''.join(f'<a href="{slug}.html"'+(' aria-current="page"' if page['slug']==slug else '')+f'>{label}</a>' for slug,label in [('index','All 83 kernel lessons'),('glossary','Glossary / key terms'),('architecture','Model architecture'),('measurement-method','Design process / experiments'),('source-atlas','Public entry → source'),('foundations','Tensor / lane reference'),('runtime','Host scheduling reference'),('runtime-310-9-16','310.9.16 / Small31 update')])
    if any(p['slug'] == 'cyberpunk-comparison' for p in pages):
        nav += '<a href="cyberpunk-comparison.html"' + (' aria-current="page"' if page['slug'] == 'cyberpunk-comparison' else '') + '>Cyberpunk comparison / speed</a>'
    localnav=f'<hr><nav class="local-nav" aria-label="This lesson"><p class="nav-kicker">Inside this lesson</p>{toc_links}</nav>' if lesson else ''
    body=isolate_svgs(highlight_blocks(page['body']))
    if page['slug'] != 'glossary':
        body=annotate(body)
    prose=re.sub(r'<(?:pre|details)\b.*?</(?:pre|details)>',' ',body,flags=re.S)
    words=len(re.sub(r'<[^>]+>',' ',prose).split())
    diagrams=body.count('<svg')+body.count('<img')
    precision='FP8 E4M3' if page['slug'].endswith('_fp8') else 'FP16' if page['slug'].endswith('_fp16') else 'Integer state' if page['slug']=='completion_counter_clear' else 'Deployment internals'
    identity=f'<p class="kernel-identity"><code>{escape(page["name"])}</code></p>' if lesson else ''
    bodyclass=' class="kernel-lesson"' if lesson else ''
    toc=f'<details class="toc"><summary>Reading sequence · {len(headings)} sections</summary><div>{toc_links}</div></details>'
    if page['slug'] != 'glossary':
        toc+='<p class="glossary-hint">Dotted terms: hover or focus for a definition; follow the link for context in the <a href="glossary.html">glossary</a>.</p>'
    pair=''
    if lesson and re.search('_fp(?:8|16)$',page['slug']):
        other=re.sub('_fp(?:8|16)$','_fp16' if page['slug'].endswith('_fp8') else '_fp8',page['slug'])
        pair=f'<a href="{other}.html">Read the other precision →</a>'
    if RUNTIME_REVISION is None:
        runtime_meta='<br>Runtime sources<br><a href="runtime-310-9-16.html#implementation">working tree (uncommitted)</a>'
        runtime_footer='runtime sources working tree (uncommitted)'
    else:
        runtime_meta=(f'<br>Runtime sources<br><a href="{REPOSITORY}/tree/{RUNTIME_REVISION}">'
                      f'{RUNTIME_REVISION[:12]}</a>')
        runtime_footer=f'runtime sources <a href="{REPOSITORY}/tree/{RUNTIME_REVISION}">{RUNTIME_REVISION[:12]}</a>'
    return f'''<!doctype html>
<html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><meta name="description" content="{escape(page['summary'],quote=True)}"><meta name="color-scheme" content="light"><title>{escape(page['title'].replace(chr(10),' '))} · DLSS-NR Kernel Lessons</title><link rel="stylesheet" href="assets/site.css"><script defer src="assets/site.js"></script></head>
<body{bodyclass}><a class="skip" href="#main">Skip to content</a><aside class="sidebar"><a class="brand" href="index.html">DLSS<span>NR</span></a><p class="nav-kicker">One document per kernel</p><nav aria-label="Guide">{nav}</nav>{localnav}<hr><div class="meta">Legacy source snapshot<br><a href="{REPOSITORY}/tree/{REVISION}">{REVISION[:12]}</a>{runtime_meta}<br><a href="source-atlas.html#provenance">Mixed provenance</a><br><a href="architecture.html">Network architecture</a><br><a href="{REPOSITORY}">Repository ↗</a></div></aside>
<div class="topbar"><a href="index.html#kernels">Browse kernels</a><button id="toggle-code" type="button">Collapse code</button></div><main id="main" class="page"><header><p class="eyebrow">{'Design → implement → test → revise' if lesson else 'DLSS-NR / deployment internals'}</p><h1>{escape(page['title']).replace(chr(10),'<br>')}</h1>{identity}<p class="lede">{escape(page['summary'])}</p><div class="reading-meta"><span>{precision}</span><span>~{max(3,round(words/190))} min of explanation + source study</span><span>{diagrams} {'diagram' if diagrams==1 else 'diagrams'}</span></div></header>{toc}<article class="content">{body}</article><nav class="next-prev" aria-label="Related reading"><a href="index.html#kernels">← Kernel catalog</a>{pair}</nav><footer class="footer">DLSS-NR kernel lessons · legacy source {REVISION[:12]} · {runtime_footer} · <a href="source-atlas.html#provenance">Provenance</a> · <a href="architecture.html">Architecture companion</a></footer></main></body></html>'''
