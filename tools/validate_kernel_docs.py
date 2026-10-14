"""Validate generated documentation links, SVGs, source excerpts and coverage."""
from html.parser import HTMLParser
from pathlib import Path
from urllib.parse import urlsplit, unquote
from collections import Counter
import hashlib
import json
import re
import xml.etree.ElementTree as ET

ROOT = Path(__file__).resolve().parents[1]
GUIDE = ROOT/'docs/kernel-guide'


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
    entries=manifest['inventory']['entries']
    assert len(entries)==81
    assert len({e['definition'] for e in entries.values()})==56
    lessons=manifest.get('lessons',[])
    if len(lessons)!=81 or {p['name'] for p in lessons}!=set(entries):
        errors.append('Expected exactly one standalone lesson for every public entry')
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
    maps=json.loads((GUIDE/'kernel-map-manifest.json').read_text(encoding='utf-8'))
    design_checks=json.loads((GUIDE/'evidence/design-checks.json').read_text(encoding='utf8'))
    if set(design_checks['kernels'])!=set(entries):errors.append('Design checks must cover every resource prediction')
    if design_checks['source_revision']!=manifest['source_revision']:errors.append('Design checks use a different source revision')
    for name,record in design_checks['kernels'].items():
        if record['source_shared_bytes']!=record['measured_static_shared_bytes']:errors.append(f'Design resource prediction mismatch: {name}')
        for count in record.get('tensor_instruction_counts',[]):
            if count['predicted']!=count['observed']:errors.append(f'Design MMA prediction mismatch: {name}')
    profiles={p['name']:p for p in maps['profiles']}
    if set(profiles)!=set(entries):errors.append('Per-kernel SVG profiles do not cover the public roster')
    by_kernel={name:[] for name in entries}
    for record in maps['diagrams']:
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
    evidence=json.loads((GUIDE/'evidence/index.json').read_text(encoding='utf8'))
    if set(evidence['kernels'])!=set(entries):errors.append('NCU evidence must cover all 81 public entries')
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
    print(f'PASS: {len(pages)} pages, 81 standalone lessons, {diagrams} inline SVGs ({len(maps["diagrams"])} specialized exports), {checked_links} local links, {len(manifest["snippets"])} exact excerpts, 81 entries / 56 bodies.')


if __name__=='__main__':main()
