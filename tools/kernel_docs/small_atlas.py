"""Specialised atlas exports and manifests for the two additive Small31 lessons.

The legacy ``kernel_maps`` renderers draw Half accumulators and one legacy token
trace.  Reusing them for these entries would contradict the persistent FP32
numerator/denominator contract, so the nine lesson-specific figures are exported
verbatim, with only an identity attribute and XML header added.
"""
from pathlib import Path
import hashlib
import json
import re

from common import ROOT
from kernel_map_profiles import profile

SMALL_NAMES = (
    'small_global_attention_chained_c1024_fp16',
    'small_global_attention_chained_c1024_fp8',
)
KINDS = (
    'flow',
    'address-bank',
    'tiling',
    'denominator-gather',
    'ownership',
    'storage',
    'ring',
    'publication-map',
    'token-path',
)
DIAGRAMS = []


def _standalone(svg, name):
    tagged = re.sub(r'<svg\b', f'<svg data-kernel="{name}"', svg, count=1)
    return '<?xml version="1.0" encoding="UTF-8"?>\n' + tagged + '\n'


def attach(lessons, inventory):
    """Export the nine figures, add download links and attach map profiles."""
    del DIAGRAMS[:]
    for lesson in lessons:
        name = lesson['name']
        if name not in SMALL_NAMES:
            raise ValueError(f'unexpected small lesson {name}')
        entry = inventory['entries'][name]
        figures = re.findall(r'<svg\b.*?</svg>', lesson['body'], flags=re.S)
        if len(figures) != len(KINDS):
            raise ValueError(f'{name}: expected {len(KINDS)} specialised SVGs, found {len(figures)}')
        directory = ROOT / 'docs/kernel-guide/assets/kernels' / name
        directory.mkdir(parents=True, exist_ok=True)
        links = []
        for kind, svg in zip(KINDS, figures):
            path = directory / f'{kind}.svg'
            text = _standalone(svg, name)
            path.write_text(text, encoding='utf-8', newline='\n')
            rel = path.relative_to(ROOT / 'docs/kernel-guide').as_posix()
            DIAGRAMS.append(dict(kernel=name, kind=kind, path=rel,
                                 sha256=hashlib.sha256(text.encode()).hexdigest()))
            links.append(f'<p class="atlas-export"><a href="{rel}">Open full-size SVG ↗</a></p>')
        order = iter(links)
        lesson['body'] = re.sub(
            r'(<figure class="diagram".*?</figure>)',
            lambda m: m.group(1) + next(order), lesson['body'], flags=re.S)
        lesson['map_profile'] = profile(name, entry)
        if lesson['map_profile'].get('numerator_format') != 'FP32':
            raise ValueError(f'{name}: profile did not select the FP32 accumulator branch')
    return DIAGRAMS


def write_manifest(lessons):
    target = ROOT / 'docs/kernel-guide/kernel-map-manifest-small.json'
    records = [lesson['map_profile'] for lesson in lessons
               if lesson['name'] in SMALL_NAMES]
    if len(records) != len(SMALL_NAMES):
        raise ValueError(f'expected {len(SMALL_NAMES)} small profiles, found {len(records)}')
    data = dict(profiles=records, diagrams=DIAGRAMS)
    target.write_text(json.dumps(data, indent=2) + '\n', encoding='utf-8', newline='\n')


def write_registry(legacy_lessons, small_lessons):
    """The explicit all-83 map registry; legacy and additive files stay separate."""
    records = []
    for lesson in legacy_lessons:
        records.append(dict(name=lesson['name'], source=lesson['map_profile']['source'],
                            kind=lesson['map_profile']['kind'],
                            manifest='kernel-map-manifest.json'))
    for lesson in small_lessons:
        records.append(dict(name=lesson['name'], source=lesson['map_profile']['source'],
                            kind=lesson['map_profile']['kind'],
                            manifest='kernel-map-manifest-small.json'))
    target = ROOT / 'docs/kernel-guide/kernel-map-registry.json'
    data = dict(total=len(records), legacy=len(legacy_lessons),
                additive=len(small_lessons), profiles=records)
    target.write_text(json.dumps(data, indent=2) + '\n', encoding='utf-8', newline='\n')
