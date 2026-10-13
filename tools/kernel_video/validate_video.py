"""Decode the published film and check its captions, timings and local resources."""
from html.parser import HTMLParser
import json
from pathlib import Path
import re
import struct
from urllib.parse import unquote, urlsplit

import av

ROOT = Path(__file__).resolve().parents[2]
ASSETS = ROOT / 'docs/kernel-guide/assets/video'


def seconds(value):
    h, m, s = value.split(':')
    return 3600 * int(h) + 60 * int(m) + float(s)


class Links(HTMLParser):
    def __init__(self, path):
        super().__init__()
        self.path = path
        self.links = []
        self.ids = set()
        self.feed(path.read_text(encoding='utf-8'))

    def handle_starttag(self, tag, attrs):
        attrs = dict(attrs)
        if 'id' in attrs:
            assert attrs['id'] not in self.ids, f'Duplicate id in {self.path}'
            self.ids.add(attrs['id'])
        self.links.extend(attrs[a] for a in ('src', 'href', 'poster') if a in attrs)


def main():
    manifest = json.loads((ASSETS / 'chapters.json').read_text(encoding='utf-8'))
    film = ASSETS / manifest['video']
    assert film.stat().st_size < 95 * 1024 ** 2
    atom_offsets = {}
    with film.open('rb') as f:
        while f.tell() < film.stat().st_size:
            offset = f.tell()
            size, kind = struct.unpack('>I4s', f.read(8))
            if size == 1:
                size = struct.unpack('>Q', f.read(8))[0]
            if size == 0:
                size = film.stat().st_size - offset
            assert size >= 8
            atom_offsets[kind] = offset
            f.seek(offset + size)
    assert atom_offsets[b'moov'] < atom_offsets[b'mdat'], 'Missing fast-start layout'
    with av.open(str(film)) as container:
        stream = container.streams.video[0]
        assert len(container.streams.audio) == 0
        assert (stream.width, stream.height) == (1920, 1080)
        assert float(stream.average_rate) == 30
        assert stream.codec_context.name == 'h264'
        assert stream.codec_context.format.name == 'yuv420p'
        duration = float(stream.duration * stream.time_base)
        last_pts, count = -1, 0
        for frame in container.decode(video=0):
            assert frame.pts > last_pts, 'Non-monotonic decoded frames'
            last_pts = frame.pts
            count += 1
        assert abs(count / 30 - duration) < .04
    assert abs(duration - manifest['duration']) < .04
    chapters = manifest['chapters']
    assert [c['number'] for c in chapters] == list(range(1, 16))
    previous = 0
    for chapter in chapters:
        assert abs(chapter['start'] - previous) < .001
        assert chapter['end'] > chapter['start']
        assert (ASSETS / chapter['still']).is_file()
        previous = chapter['end']
    assert abs(previous - duration) < .04
    vtt = (ASSETS / 'captions.vtt').read_text(encoding='utf-8')
    assert vtt.startswith('WEBVTT\n')
    matches = re.findall(r'(\d{2}:\d{2}:\d{2}\.\d{3}) --> (\d{2}:\d{2}:\d{2}\.\d{3})\n([^\n]+)', vtt)
    assert len(matches) == manifest['caption_count']
    previous = 0
    for start, end, text in matches:
        start, end = seconds(start), seconds(end)
        assert start >= previous - .002 and end > start and end <= duration + .002
        assert text.strip()
        previous = end
    transcript = Links(ASSETS / 'transcript.html')
    checked = 0
    for link in transcript.links:
        url = urlsplit(link)
        if url.scheme or url.netloc:
            continue
        target = (ASSETS / unquote(url.path)).resolve() if url.path else transcript.path
        assert target.is_file(), link
        if target.suffix == '.html' and url.fragment:
            ids = transcript.ids if target == transcript.path else Links(target).ids
            assert url.fragment in ids, link
        elif url.fragment.startswith('t='):
            assert 0 <= float(url.fragment[2:]) < duration, link
        checked += 1
    print(f'PASS: {count:,} frames decoded; {duration:.3f}s, H.264 1080p30 yuv420p, fast-start; {film.stat().st_size/1024**2:.2f} MiB.')
    print(f'PASS: 15 contiguous chapters, {len(matches)} ordered caption cues, 15 stills and {checked} local transcript resources.')


if __name__ == '__main__':
    main()
