"""Render the comparison chapter only from accepted, hash-verified public assets.

It performs no inference, media conversion, downloading, or publication.
The page is absent until the complete accepted media mapping is available.
"""
from __future__ import annotations

import hashlib
from html import escape
import json
import math
from pathlib import Path
import statistics
import sys

for _parent in Path(__file__).resolve().parents:
    if (_parent / 'tools/kernel_docs/common.py').is_file():
        sys.path.insert(0, str(_parent / 'tools/kernel_docs'))
        break
from common import ROOT, RUNTIME_REVISION

MEDIA_REL = 'media/cyberpunk-20261030'
REQUIRED = (
    'still_fp16_face', 'still_fp8_face',
    'video_fp16_overview', 'video_fp8_overview',
    'video_fp16_face', 'video_fp8_face',
    'benchmark_still', 'benchmark_video',
    'render_still_fp16', 'render_still_fp8',
    'render_video_fp16', 'render_video_fp8', 'source_still', 'source_video',
)
ARMS = ('legacy71/fp16', 'small31/fp16', 'legacy71/fp8', 'small31/fp8')
SCOPES = {
    'trunk_only': 'trunk_only_b69_plane16_on_precomputed_pooled',
    'full_gpu': 'full_gpu_pre_trunk_post_with_d2d_copies',
    'cpu_still': 'cpu_wall_same_frame_replay_h2d_fullgpu_d2h_no_decode_no_encode',
    'cpu_video': 'cpu_wall_decode_convert_h2d_fullgpu_d2h_no_encode',
}


def require(condition, message):
    if not condition:
        raise ValueError('Cyberpunk publication gate: ' + message)


def read_json(path):
    return json.loads(path.read_text(encoding='utf-8-sig'))


def digest(path):
    h = hashlib.sha256()
    with path.open('rb') as handle:
        for block in iter(lambda: handle.read(1 << 20), b''):
            h.update(block)
    return h.hexdigest()


def validate_benchmark(document, fixture, binary):
    require(document.get('schema') == 'dlssnr.video-harness.v1', fixture + ' manifest schema')
    require(document.get('environment', {}).get('extension_sha256') == binary, fixture + ' binary identity')
    require(set(document.get('arms', {})) == set(ARMS), fixture + ' requires all four arms')
    expected_extent = (3024, 1890) if fixture == 'still' else (3840, 2160)
    source = document.get('frame_source', {})
    require((source.get('width'), source.get('height')) == expected_extent, fixture + ' source geometry')
    count = 50 if fixture == 'still' else 180
    for key in ARMS:
        arm = document['arms'][key]
        require(key == arm['model'] + '/' + arm['precision'], key + ' identity')
        require(arm.get('guards_intact_after_timing') is True, key + ' guards')
        require(arm.get('validation', {}).get('deterministic') is True, key + ' deterministic preflight')
        require(arm.get('pipeline', {}).get('trunk_output_layout', '').lower() == 'plane16', key + ' timed layout')
        require(arm.get('same_frame_replay') is (fixture == 'still'), key + ' replay scope')
        for scope in ('trunk_only', 'full_gpu', 'cpu_wall'):
            sample = arm['measurements'][scope]
            expected = SCOPES['cpu_' + fixture] if scope == 'cpu_wall' else SCOPES[scope]
            require(sample.get('scope') == expected, key + ' ' + scope + ' scope')
            require(sample.get('unit') == 'ms', key + ' timing unit')
            require(sample.get('warmup') == 10 and sample.get('iterations') == count, key + ' timing protocol')
            values = sample.get('samples_ms', [])
            require(len(values) == count and all(isinstance(x, (int, float)) and math.isfinite(x) and x > 0 for x in values), key + ' samples')
            median = statistics.median(values)
            require(math.isclose(median, sample['median_ms'], rel_tol=1e-9, abs_tol=1e-9), key + ' median disagrees with samples')
            require(math.isclose(1000 / median, sample['fps_from_median'], rel_tol=1e-9), key + ' derived FPS')
    return document


def load_accepted(root=ROOT):
    folder = root / 'docs/kernel-guide' / MEDIA_REL
    mapping_path = folder / 'assets.json'
    if not mapping_path.exists():
        return None
    mapping = read_json(mapping_path)
    require(mapping.get('schema') == 'dlssnr.docs.cyberpunk.v1', 'assets mapping schema')
    require(mapping.get('status') == 'accepted', 'media has not passed acceptance')
    require(mapping.get('source_revision') == RUNTIME_REVISION and bool(RUNTIME_REVISION), 'runtime source pin')
    binary = mapping.get('binary_sha256', '')
    require(len(binary) == 64 and all(c in '0123456789abcdef' for c in binary), 'binary hash')
    files = mapping.get('files', {})
    require(set(REQUIRED).issubset(files), 'missing required media or evidence')
    paths = {}
    for key, item in files.items():
        relative = Path(item['path'])
        target = (folder / relative).resolve()
        require(not relative.is_absolute() and target.is_relative_to(folder.resolve()), key + ' path escapes media directory')
        require(target.is_file(), key + ' missing file')
        require(target.suffix.lower() in ('.png', '.jpeg', '.jpg', '.webp', '.mp4', '.json', '.txt', '.md', '.csv'), key + ' forbidden publication type')
        require(target.stat().st_size == item['bytes'], key + ' file size mismatch')
        require(0 < item['bytes'] < 90_000_000, key + ' is empty or at least 90 MB')
        require(digest(target) == item['sha256'], key + ' SHA-256 mismatch')
        paths[key] = target
    documents = {key: read_json(paths[key]) for key in REQUIRED if paths[key].suffix == '.json'}
    for fixture in ('still', 'video'):
        validate_benchmark(documents['benchmark_' + fixture], fixture, binary)
        for precision in ('fp16', 'fp8'):
            render = documents[f'render_{fixture}_{precision}']
            require(render.get('environment', {}).get('extension_sha256') == binary, fixture + '/' + precision + ' render binary')
            expected_extent = (3024, 1890) if fixture == 'still' else (3840, 2160)
            source = render.get('frame_source', {})
            require((source.get('width'), source.get('height')) == expected_extent, fixture + '/' + precision + ' render geometry')
            require({(model['model'], model['precision']) for model in render['models']} ==
                    {('legacy71', precision), ('small31', precision)}, fixture + '/' + precision + ' render arms')
            output_map = ({'face': 'comparison_3way_roi'} if fixture == 'still'
                          else {'overview': 'comparison', 'face': 'comparison_roi'})
            for kind, output in output_map.items():
                entry = render['outputs'][output]
                key = f'{fixture}_{precision}_{kind}'
                require(entry['sha256'] == files[key]['sha256'], key + ' is not the accepted render output')
                if fixture == 'video':
                    require(entry['frames'] == 180 and float(entry['fps']) == 30 and entry['audio'] is False, key + ' clip protocol')
    return mapping, documents


def href(mapping, key):
    return MEDIA_REL + '/' + Path(mapping['files'][key]['path']).as_posix()


def timings(document, fixture):
    rows = []
    for key in ARMS:
        arm = document['arms'][key]
        m = arm['measurements']
        def cell(scope):
            s = m[scope]
            return f'<strong>{s["median_ms"]:.3f}</strong><br><small>{s["p10_ms"]:.3f}–{s["p90_ms"]:.3f}</small>'
        model = 'Legacy71' if arm['model'] == 'legacy71' else 'Small31'
        rows.append(f'<tr><th scope="row">{model}</th><td>{arm["precision"].upper()}</td>'
                    f'<td>{cell("trunk_only")}</td><td>{cell("full_gpu")}</td>'
                    f'<td>{m["full_gpu"]["fps_from_median"]:.2f}</td><td>{cell("cpu_wall")}</td></tr>')
    ratios = []
    for precision in ('fp16', 'fp8'):
        old = document['arms'][f'legacy71/{precision}']['measurements']['full_gpu']['median_ms']
        new = document['arms'][f'small31/{precision}']['measurements']['full_gpu']['median_ms']
        ratios.append(f'{precision.upper()}: Legacy71 median / Small31 median = <strong>{old/new:.3f}×</strong>')
    cpu = 'predecoded H2D → GPU → D2H' if fixture == 'still' else 'PNG decode → H2D → GPU → D2H'
    return ('<div class="table-scroll"><table><caption>Milliseconds: median, with p10–p90 below. '
            'FPS is derived only from the full GPU median.</caption><thead><tr><th>Model</th><th>Precision</th>'
            '<th>RGB trunk ms</th><th>Full GPU ms</th><th>Full GPU FPS</th>'
            f'<th>CPU wall ms<br><small>{cpu}</small></th></tr></thead><tbody>' + ''.join(rows) +
            '</tbody></table></div><p>' + '; '.join(ratios) +
            '. A ratio above one means lower measured Small31 GPU time on this fixture.</p>')


def launch_census(document):
    rows = []
    expected = {'legacy71/fp16': (185, 193), 'small31/fp16': (109, 117),
                'legacy71/fp8': (185, 185), 'small31/fp8': (109, 109)}
    for key in ARMS:
        pipeline = document['arms'][key]['pipeline']
        require(pipeline.get('trunk_launch_census_matches_plan') is True, key + ' launch census')
        require(pipeline.get('trunk_extra_repack') is False, key + ' trunk repack')
        logical = pipeline.get('trunk_logical_calls')
        split = pipeline.get('trunk_split_launches')
        require((logical, split) == expected[key], key + ' split-launch counts')
        model = 'Legacy71' if key.startswith('legacy71') else 'Small31'
        rows.append(f'<tr><th scope="row">{model}</th><td>{key.split("/")[1].upper()}</td>'
                    f'<td>{logical}</td><td>{split}</td><td>{split - logical}</td>'
                    '<td>preprocess + postprocess + D2D copies (outside trunk)</td></tr>')
    return ('<div class="table-scroll"><table><caption>Trunk launch census recorded by both accepted '
            'benchmark manifests. Logical calls are schedule facts, not timings.</caption><thead><tr>'
            '<th>Model</th><th>Precision</th><th>Logical trunk calls</th><th>Physical split launches</th>'
            '<th>Extra launches</th><th>Separate timed work</th></tr></thead><tbody>'
            + ''.join(rows) + '</tbody></table></div>')


def build_chapter(root=ROOT):
    accepted = load_accepted(root)
    if accepted is None:
        return None
    mapping, docs = accepted
    def link(key, label):
        return f'<a href="{escape(href(mapping, key), quote=True)}">{escape(label)}</a>'

    def png(key, label):
        if key not in mapping['files']:
            return ''
        return f'<a href="{escape(href(mapping, key), quote=True)}">{escape(label)}</a>'

    media = []
    for precision in ('fp16', 'fp8'):
        face = href(mapping, f'still_{precision}_face')
        overview = href(mapping, f'video_{precision}_overview')
        close = href(mapping, f'video_{precision}_face')
        poster_key = f'video_{precision}_poster'
        poster = (f' poster="{escape(href(mapping, poster_key), quote=True)}"'
                  if poster_key in mapping['files'] else '')
        still_native = ' · '.join(item for item in (
            png('still_original', 'original downloaded pixels (3024×1890 PNG)'),
            png(f'still_legacy71_{precision}', 'Legacy71 reconstruction (PNG)'),
            png(f'still_small31_{precision}', 'Small31 reconstruction (PNG)')) if item)
        video_native = ' · '.join(item for item in (
            png('video_original_frame90', 'original downloaded pixels (3840×2160 PNG)'),
            png(f'video_legacy71_{precision}_frame90', 'Legacy71 reconstruction (PNG)'),
            png(f'video_small31_{precision}_frame90', 'Small31 reconstruction (PNG)')) if item)
        media.append(f'''<section class="cp-panel cp-{precision}" aria-label="{precision.upper()} comparison">
<h3>{precision.upper()} · Original / Legacy71 reconstruction / Small31 reconstruction</h3>
<figure><a href="{escape(face, quote=True)}"><img src="{escape(face, quote=True)}" loading="lazy"
alt="{precision.upper()} three-way Cyberpunk character face crop: original downloaded pixels, Legacy71 reconstruction and Small31 reconstruction"></a>
<figcaption>V face detail, left to right: original downloaded pixels, Legacy71 reconstruction, Small31 reconstruction. Identical 960×960 crop at source coordinate (1030,80); each model processed the full 3024×1890 still. Open the PNG to inspect all three panels at 1:1.</figcaption></figure>
<p class="cp-native"><strong>Native lossless still PNGs.</strong> {still_native}. The original file is shared by FP16 and FP8 after a byte-equality check.</p>
<h3>Johnny Silverhand · six seconds, 180 distinct frames (30 fps, no audio)</h3>
<video controls preload="none" playsinline{poster} aria-label="{precision.upper()} Johnny three-way overview"><source src="{escape(overview, quote=True)}" type="video/mp4"></video>
<p class="cp-native"><strong>Native lossless frame 90 PNGs.</strong> {video_native}. Frame 90 is excerpt PTS 3.0 s, original source PTS 13.0 s; the original file is shared by FP16 and FP8 after a byte-equality check.</p>
<p>The full 3840×2160 frames were processed. The overview has three 1280×720 display panels; that resize happens only after inference. The poster is a display frame from index 90; playback still starts at excerpt time 0.</p>
<details><summary>Watch the same clip at the 1024×1024 face crop</summary>
<video controls preload="none" playsinline aria-label="{precision.upper()} Johnny three-way face detail"><source src="{escape(close, quote=True)}" type="video/mp4"></video>
<p>Same source-pixel crop (1240,560), 1024×1024 in all three arms. The H.264 videos are lossy display encodes; the still PNG panels preserve their decoded RGB pixels.</p></details></section>''')
    still_source = docs['source_still']['source']
    video_source = docs['source_video']['source']
    device = docs['benchmark_still']['environment'].get('device_name', 'NVIDIA RTX PRO 6000 Blackwell Workstation Edition')
    frames_links = ' · '.join(link(key, mapping['files'][key].get('label', key))
                              for key in ('frames_video_fp16', 'frames_video_fp8')
                              if key in mapping['files'])
    body = f'''<style>
.cp-switch{{border:1px solid var(--line);border-radius:12px;padding:20px;margin:22px 0}}
.cp-switch>label{{display:inline-block;padding:7px 18px;margin-right:20px;border:1px solid var(--line);border-radius:6px;font-weight:700}}
.cp-panel{{display:none}}#cp-fp16:checked~.cp-fp16,#cp-fp8:checked~.cp-fp8{{display:block}}
.cp-panel img,.cp-panel video{{width:100%;height:auto;border-radius:8px;display:block;background:#10293c}}
.cp-panel figure{{margin:20px 0}}.cp-panel figcaption{{font-size:14px;color:var(--muted)}}
.cp-panel .cp-native{{font-size:14px;color:var(--muted)}}
</style>
<p>Compare the same downloaded Cyberpunk 2077 character pixels with our older Legacy71 reconstruction and newer Small31 reconstruction. Both reconstructed arms execute native CUDA kernels; precision is selected below.</p>
<aside class="note"><strong>RGB-only, stateless research comparison.</strong> Engine motion vectors, depth, temporal history and conditioning are absent. The downloaded still and clip are source pixels, with unknown pre-existing rendering/upscaling settings; they are neither native-render ground truth nor an official NVIDIA DLL reference. These results do not establish vendor parity or that either reconstruction has better image quality.</aside>
<fieldset class="cp-switch"><legend>Choose the precision used by both reconstructed arms</legend>
<input id="cp-fp16" type="radio" name="cp-precision" checked><label for="cp-fp16">FP16</label>
<input id="cp-fp8" type="radio" name="cp-precision"><label for="cp-fp8">FP8</label>{''.join(media)}</fieldset>
<p><strong>Credit:</strong> Unofficial research comparison; not approved or endorsed by CD PROJEKT RED. Cyberpunk 2077 imagery © CD PROJEKT RED. Source imagery is not relicensed under this repository’s code license.
<a href="{escape(still_source['page_url'], quote=True)}">Official still source</a> ·
<a href="{escape(video_source['page_url'], quote=True)}">Official video source</a> ·
<a href="https://www.cdprojektred.com/en/fan-content">Fan-content guidelines</a> ·
<a href="https://www.cdprojektred.com/en/videopolicy">Video policy</a>.</p>
<h2 id="speed">Measured speed: separate the three timing scopes</h2>
<p>Device: {escape(str(device))}. CUDA events bracket each eager launch sequence and synchronize its end; exposed host enqueue gaps can be included. These are not captured CUDA-graph replay timings. CPU wall time uses host timing across explicit synchronization. Records, plans, buffers, weights and validation are prepared outside the timed intervals; no NCU run overlaps these measurements. Graph-capture correctness is a separate acceptance check.</p>
<ol><li><strong>RGB trunk:</strong> the prepared PLANE16-output sequence on a precomputed pooled input, including the final phase-3 C32 output view.</li>
<li><strong>Full GPU:</strong> preprocess → RGB trunk → post, including texture/surface device-to-device copies. Host upload/download, decode and encode are excluded.</li>
<li><strong>CPU wall:</strong> includes upload, full GPU, synchronization and RGB download. Still decode is excluded; video PNG decode/convert is included. Encoding and output-file writes are excluded in both.</li></ol>
<p>Only these three scopes were timed independently. Do not subtract the CPU wall time from a GPU scope to claim a separately measured host-time percentage or a causal host bottleneck.</p>
<h3>3024×1890 still · 10 warmups, 50 measurements per arm</h3>
<p>The same already-decoded still is replayed. Physical dimensions are 3072×1920. This measures a same-frame workload, not complete video throughput.</p>
{timings(docs['benchmark_still'], 'still')}
<h3>3840×2160 clip fixture · 10 warmups, 180 measurements per arm</h3>
<p>Physical dimensions are 3840×2176. Both GPU scopes replay the first frame; the CPU wall scope cycles the 180 decoded-source PNG files, measuring indices 10…179 then 0…9 after warmup. The table therefore keeps these different workloads separate.</p>
{timings(docs['benchmark_video'], 'video')}
{launch_census(docs['benchmark_video'])}
<p>Logical calls are not physical launch counts. At 4K FP16, eight logical calls split into two launches each: Legacy71 records 185 logical / 193 split launches and Small31 records 109 / 117. FP8 records 185 / 185 and 109 / 109. The 33 completion-counter clears are already part of each logical census. Preprocess, postprocess and device-to-device copies are timed in the full-GPU and CPU-wall scopes but stay outside this trunk census. These are schedule facts, not timings, and they do not predict the measured ratios.</p>
<h2 id="implementation">What was reused, and what changed?</h2>
<p>Most operators reuse the existing CUDA math. Small31 adds its own weight loader, phase/role schedule and native host plan. Its eight global-attention calls select two new precision-specific kernels with FP32 persistent P×V accumulation and full FP32 denominator reduction. The original 81 kernels and legacy plans remain supported.</p>
<p>Both RGB paths reuse the existing phase-3 C32 output-view kernel for their final descriptor. That writes the PLANE16 layout expected by postprocessing without an extra repack call. The base plan’s TILE4 contract remains separate. Small has 109 logical trunk calls (76 compute/repack +33 clear), versus Legacy71’s 185 (152 +33); at 4K FP16 those become 117 and 193 physical split launches. The counts do not predict the speed ratio, and pre/post work is outside them.</p>
<p>Read the <a href="runtime-310-9-16.html">model and runtime design</a>,
<a href="small_global_attention_chained_c1024_fp16.html">new FP16 attention lesson</a>, and
<a href="small_global_attention_chained_c1024_fp8.html">new FP8 attention lesson</a>. The newer DLL also carries unchanged HT weights; this page compares Legacy71 with the separately trained Small31 resource, not two different HT models.</p>
<h2 id="reproduce">Reproduce and inspect the evidence</h2>
<p>Source revision <code>{escape(mapping['source_revision'])}</code>; extension SHA-256 <code>{escape(mapping['binary_sha256'])}</code>. The exact command arrays, model/resource identities, input hashes, raw timing samples and preflight/guard results remain in the manifests. A failed typed-finiteness check aborts execution; display clamping is not a repair mechanism.</p>
<p>{link('benchmark_still', 'Still benchmark manifest')} · {link('benchmark_video', 'Video benchmark manifest')} ·
{link('source_still', 'Still provenance')} · {link('source_video', 'Video provenance')} ·
<a href="{MEDIA_REL}/assets.json">Published asset hashes and sizes</a>.</p>
<p>{' · '.join(link('render_'+fixture+'_'+precision, fixture.title()+' '+precision.upper()+' render manifest') for fixture in ('still','video') for precision in ('fp16','fp8'))}</p>
<p>Per-frame evidence: {frames_links}.</p>
'''
    return dict(slug='cyberpunk-comparison', title='Cyberpunk characters: Legacy71 and Small31 in motion',
                summary='The same official source imagery, two reconstructed native models, FP16/FP8 selectors and separately scoped measured timings.', body=body)
