"""Validate generated documentation links, SVGs, source excerpts and coverage."""
from html.parser import HTMLParser
from pathlib import Path
from urllib.parse import urlsplit, unquote
from collections import Counter
import hashlib
import json
import re
import subprocess
import sys
import xml.etree.ElementTree as ET

ROOT = Path(__file__).resolve().parents[1]
GUIDE = ROOT/'docs/kernel-guide'
sys.path.insert(0, str(ROOT/'tools/kernel_docs'))
from runtime_source_revision import RUNTIME_REVISION, RUNTIME_SOURCE_PATHS
from lessons_small_attention import SMALL_NAMES

LEGACY_REVISION = 'fc3276497f866bdad639cd443e75743f5d19b749'
EXPECTED_RUNTIME_REVISION = '266d69acf52dda413df3a874572f1156461f89ff'
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


def _git_blob(revision, path):
    result = subprocess.run(
        ['git', 'show', f'{revision}:{path}'], cwd=ROOT,
        capture_output=True, text=True, encoding='utf-8', errors='replace',
    )
    return result.stdout if result.returncode == 0 else None


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


def main():
    pages={path:Page(path) for path in GUIDE.glob('*.html')}
    errors=[]; diagrams=0; checked_links=0
    from cyberpunk_comparison import load_accepted
    comparison_accepted = load_accepted() is not None
    expected_pages = 99 if comparison_accepted else 98
    if len(pages) != expected_pages:
        errors.append(f'Expected {expected_pages} guide pages from accepted inputs, found {len(pages)}')
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
    manifest=json.loads((GUIDE/'source-manifest.json').read_text(encoding='utf-8'))
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
        for dependency in lesson['dependencies']:
            copy=GUIDE/'source'/dependency
            if not copy.is_file() or copy.read_text(encoding='utf-8')!=(ROOT/dependency).read_text(encoding='utf-8'):
                errors.append(f'{path.name}: missing or changed source dependency {dependency}')
    for path,digest in manifest['files'].items():
        if hashlib.sha256((ROOT/path).read_text(encoding='utf-8').encode('utf-8')).hexdigest()!=digest:errors.append(f'Source drift: {path}')
    for snip in manifest['snippets']:
        lines=(ROOT/snip['path']).read_text(encoding='utf-8').splitlines()
        excerpt='\n'.join(lines[snip['start']-1:snip['end']])
        if hashlib.sha256(excerpt.encode()).hexdigest()!=snip['sha256']:errors.append(f'Excerpt drift: {snip}')
    file_revisions=manifest.get('file_revisions')
    if not isinstance(file_revisions,dict) or not file_revisions:
        errors.append('Manifest is missing per-file provenance (file_revisions)')
        file_revisions={}
    runtime_revision=manifest.get('runtime_source_revision')
    runtime_paths=set(RUNTIME_SOURCE_PATHS)
    if len(runtime_paths)!=len(RUNTIME_SOURCE_PATHS):
        errors.append('RUNTIME_SOURCE_PATHS contains duplicate paths')
    for path in sorted(runtime_paths):
        if not (ROOT/path).is_file():
            errors.append(f'Declared runtime source is missing: {path}')
        if path not in manifest['files']:
            errors.append(f'Declared runtime source is missing from manifest files: {path}')
        if path not in file_revisions:
            errors.append(f'Declared runtime source is missing per-file provenance: {path}')
    for path,info in file_revisions.items():
        source=ROOT/path
        if not source.is_file():
            errors.append(f'Missing recorded source: {path}');continue
        work=_normalized_lf(source.read_text(encoding='utf-8'))
        digest=hashlib.sha256(work.encode()).hexdigest()
        if info.get('sha256')!=digest or manifest['files'].get(path)!=digest:
            errors.append(f'Per-file provenance hash drift: {path}')
        kind=info.get('kind'); revision=info.get('revision')
        if kind=='legacy-commit':
            if revision!=manifest['source_revision']:errors.append(f'{path}: legacy provenance uses the wrong revision')
            committed=_git_blob(revision,path)
            if committed is None or _normalized_lf(committed)!=work:
                errors.append(f'{path}: working tree does not match historical revision {revision}')
        elif kind=='runtime-commit':
            if not runtime_revision or revision!=runtime_revision:
                errors.append(f'{path}: runtime provenance does not match runtime_source_revision')
            committed=_git_blob(revision,path) if runtime_revision else None
            if committed is None or _normalized_lf(committed)!=work:
                errors.append(f'{path}: working tree does not match runtime revision {revision}')
        elif kind=='working-tree':
            if runtime_revision is not None:
                errors.append(f'{path}: a runtime commit is configured but provenance is working-tree')
            copy=GUIDE/'source'/path
            if not copy.is_file() or _normalized_lf(copy.read_text(encoding='utf-8'))!=work:
                errors.append(f'{path}: missing or changed exact working-tree source copy')
        else:
            errors.append(f'{path}: unknown provenance kind {kind!r}')
    for snip in manifest['snippets']:
        info=file_revisions.get(snip['path'])
        if info is None:
            errors.append(f'Snippet has no file provenance: {snip["path"]}');continue
        if snip.get('source_kind')!=info.get('kind') or snip.get('revision')!=info.get('revision'):
            errors.append(f'Snippet provenance disagrees with its file: {snip["path"]}')
        if info.get('kind')=='working-tree':
            if not snip.get('url','').startswith('source/'):
                errors.append(f'Uncommitted snippet must link to its local copy: {snip["path"]}')
        elif info.get('revision') is None or f'/{info["revision"]}/' not in snip.get('url',''):
            errors.append(f'Committed snippet must link to its exact revision: {snip["path"]}')
    if runtime_revision is None:
        update_text=(GUIDE/'runtime-310-9-16.html').read_text(encoding='utf-8')
        if 'working-tree provenance' not in update_text and 'working tree' not in update_text:
            errors.append('runtime-310-9-16.html: must disclose working-tree runtime provenance')
        if 'working tree (uncommitted)' not in update_text:
            errors.append('runtime-310-9-16.html: sidebar/footer must disclose uncommitted runtime sources')
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
            pin_path = ROOT/pin.get('path', '')
            if not pin_path.is_file():
                errors.append(f'{name}: missing pinned source {pin.get("path")}')
                continue
            digest = hashlib.sha256(_normalized_lf(pin_path.read_text(encoding='utf-8')).encode()).hexdigest()
            raw_digest = hashlib.sha256(pin_path.read_bytes()).hexdigest()
            if pin.get('sha256') not in (digest, raw_digest):
                errors.append(f'{name}: pinned source hash drift: {pin.get("path")}')
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
    print(f'PASS: {len(pages)} pages, 83 standalone lessons (81 legacy + 2 additive), {diagrams} inline SVGs '
          f'({len(maps["diagrams"])+len(small_maps["diagrams"])} specialized exports), {checked_links} local links, '
          f'{len(manifest["snippets"])} exact excerpts, 83 entries / 58 bodies.')


if __name__=='__main__':main()
