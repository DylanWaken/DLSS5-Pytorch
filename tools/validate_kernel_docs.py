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
        self.feed(path.read_text(encoding='utf-8'))
    def handle_starttag(self, tag, attrs):
        attrs=dict(attrs)
        if 'id' in attrs:self.ids.append(attrs['id'])
        if tag=='h1':self.h1+=1
        if tag=='img':
            self.images+=1
            assert attrs.get('alt'), 'Image needs alt text'
        for attr in ('href','src'):
            if attrs.get(attr):self.links.append(attrs[attr])


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
    for lesson in lessons:
        path=GUIDE/(lesson['slug']+'.html')
        if path not in pages:
            errors.append(f'Missing lesson {lesson["name"]}');continue
        text=path.read_text(encoding='utf-8')
        body=text.split('<article class="content">',1)[-1].split('</article>',1)[0]
        headings=re.findall(r'<h2 id="([^"]+)">(.*?)</h2>',body,re.S)
        if not headings or headings[0][0]!='model':errors.append(f'{path.name}: must start with model operation')
        if 'source-appendix' not in pages[path].ids:errors.append(f'{path.name}: missing complete source appendix')
        if len(headings)<6:errors.append(f'{path.name}: incomplete reading sequence')
        if body.count('<svg')<2:errors.append(f'{path.name}: missing reconstruction diagrams')
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
    if errors:
        raise SystemExit('\n'.join(errors))
    print(f'PASS: {len(pages)} pages, 81 standalone lessons, {diagrams} inline SVGs, {checked_links} local links, {len(manifest["snippets"])} exact excerpts, 81 entries / 56 bodies.')


if __name__=='__main__':main()
