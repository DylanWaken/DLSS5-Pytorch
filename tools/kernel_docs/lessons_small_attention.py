"""Two additive Small31 global-attention lessons for the 83-entry guide.

The module imports the existing ``common`` and ``lesson_support`` helpers from
this directory.  It never edits the legacy 81 lesson modules, their source
excerpts, maps or NCU records.

Contract:
    build_lessons(inventory)               -> exactly two lesson dictionaries
    build_lessons(inventory, evidence=...) -> same, with explicit per-entry evidence
    render_lesson(name, fp8, evidence=...) -> one body string for one entry

The evidence argument is the measured per-entry record.  ``build_lessons`` accepts
either the whole ``evidence-small/index.json`` mapping or a name-keyed mapping and
selects each entry explicitly, so FP16 and FP8 never share one record by accident.
Compiled resources, the sampled numerical reference and the current isolated
full/source NCU replay remain distinct evidence classes in section 6.
"""
from pathlib import Path
from html import escape
import sys

_here = Path(__file__).resolve()
if str(_here.parent) not in sys.path:
    sys.path.insert(0, str(_here.parent))

from common import ROOT, code  # noqa: E402
from lesson_support import pseudo  # noqa: E402
from lessons_small_attention_figures import build_all  # noqa: E402

FP16_NAME = 'small_global_attention_chained_c1024_fp16'
FP8_NAME = 'small_global_attention_chained_c1024_fp8'
SMALL_NAMES = (FP16_NAME, FP8_NAME)
FAMILY = 'Small31 attention'

P16 = 'csrc/kernel_impl/small_c1024_attention/fp16/small_global_attention_chained_c1024_fp16.cu'
P8 = 'csrc/kernel_impl/small_c1024_attention/fp8/small_global_attention_chained_c1024_fp8.cu'
HELPER = 'csrc/kernel_impl/small_c1024_attention/common/intrinsics.cuh'
ABI = 'csrc/kernel_impl/small_c1024_attention/common/small_attention_abi.h'

EVIDENCE_PENDING = {
    'state': 'compiler-and-reference-measured; ncu-pending',
    'runtime_commit': '266d69acf52dda413df3a874572f1156461f89ff',
    'compiled_resources': 'measured in the SM120 native build; see section 6.8',
    'ncu_reports': [],
}
EVIDENCE_SCHEMA = {
    'state': 'compiler-and-reference-measured; ncu-pending | measured',
    'runtime_commit': 'full 40-character commit containing the four new sources, or None',
    'compiled_resources': 'dict of launch__registers_per_thread, allocated, shared static/dynamic/driver, '
                          'block/grid, local loads/stores, sass__inst_executed_register_spilling',
    'ncu_reports': 'list of {kind: full|source, path, sha256, fixture} for the same entry',
}


def _cfg(fp8):
    if fp8:
        return dict(
            name=FP8_NAME, path=P8, e=1, typ='E4M3', half='Half', prec='FP8',
            qk='mma.sync.aligned.m16n8k32.row.col.f16.e4m3.e4m3.f16',
            pv='mma.sync.aligned.m16n8k32.row.col.f32.e4m3.e4m3.f32',
            qchunks=1, pchunks=2, stage=2048, shared=8208, qwords=16,
            qk_mma=32, pv_mma=32, warp_mma=64, cta_mma=256, all_mma=8704,
            vecbase=20032, c9byte=20035,
            groups=136, local_padded=2176,
            publish='Half, then E4M3',
            registers=195, stack=0, spill_stores=0, spill_loads=0,
            occupancy=2, max_threads=256, launch_threads=128,
        )
    return dict(
        name=FP16_NAME, path=P16, e=2, typ='Half', half='Half', prec='FP16',
        qk='mma.sync.aligned.m16n8k16.row.col.f16.f16.f16.f16',
        pv='mma.sync.aligned.m16n8k16.row.col.f32.f16.f16.f32',
        qchunks=2, pchunks=4, stage=4096, shared=16400, qwords=32,
        qk_mma=64, pv_mma=64, warp_mma=128, cta_mma=512, all_mma=17408,
        vecbase=40000, c9byte=40010,
        groups=135, local_padded=2160,
        publish='Half',
        registers=208, stack=24, spill_stores=44, spill_loads=56,
        occupancy=2, max_threads=256, launch_threads=128,
    )


def cut(path, needle, count, before=0, caption=''):
    lines = (ROOT / path).read_text(encoding='utf-8').splitlines()
    index = next(i for i, line in enumerate(lines) if needle in line)
    start = max(1, index + 1 - before)
    return code(path, start, min(len(lines), start + count - 1), caption)


def six_parts(problem, cta, warp, resources, schedule, trace):
    headings = [
        ('problem', '1. The whole problem and the target precision contract'),
        ('cta', '2. One CTA: one head, 256 queries, a 64-key stream'),
        ('warp', '3. Warp and lane ownership: 64 FP32 numerators, two FP32 denominators'),
        ('resources', '4. Resource budget before implementation'),
        ('schedule', '5. Execution: two-stage ring, persistent state and construction milestones'),
        ('trace', '6. Trace query 17, head 7, channel 9 through the source'),
    ]
    return ''.join(f'<h2 id="{key}">{title}</h2>{body}'
                   for (key, title), body in zip(headings, (problem, cta, warp, resources, schedule, trace)))


def _metric(ev, name):
    for row in ev.get('metrics', []):
        if row.get('name') == name:
            return row.get('value')
    return None


def _fmt(value, digits=4):
    if value is None:
        return '—'
    if isinstance(value, bool):
        return 'yes' if value else 'no'
    if isinstance(value, int):
        return f'{value:,}'
    if isinstance(value, float):
        if value.is_integer() and abs(value) >= 1000:
            return f'{value:,.0f}'
        text = f'{value:,.{digits}f}'
        return text.rstrip('0').rstrip('.') if '.' in text else text
    return escape(str(value))


_MMA_ROWS = {
    'FP16': dict(qk='HMMA.16816.F16', qk_file='csrc/kernel_impl/shared/common/intrinsics.cuh',
                 qk_line=221, pv='HMMA.16816.F32',
                 pv_file='csrc/kernel_impl/small_c1024_attention/common/intrinsics.cuh', pv_line=17),
    'FP8': dict(qk='QMMA.16832.F16.E4M3.E4M3', qk_file='csrc/kernel_impl/shared/common/intrinsics.cuh',
                qk_line=195, pv='QMMA.16832.F32.E4M3.E4M3',
                pv_file='csrc/kernel_impl/small_c1024_attention/common/intrinsics.cuh', pv_line=31),
}


def _hotspot_table(ev):
    totals = ev.get('hotspot_line_totals') or []
    rows = ev.get('source_hotspots') or []
    grouped = {}
    for row in rows:
        grouped.setdefault((row.get('file'), row.get('line')), []).append(row)
    body = []
    for item in totals:
        key = (item.get('file'), item.get('line'))
        cells = sorted(grouped.get(key, []), key=lambda r: -r.get('count', 0))
        category_text = ', '.join(
            f"{c.get('metric', '').replace('smsp__pcsamp_warps_issue_stalled_', '')} {c.get('count')}"
            for c in cells)
        sass = cells[0].get('sass_example', '') if cells else ''
        body.append(
            f'<tr><td><code>{escape(str(key[0]))}:{key[1]}</code></td>'
            f'<td>{item.get("base_samples")}</td>'
            f'<td>{escape(category_text)}</td><td><code>{escape(sass)}</code></td></tr>')
    return ''.join(body)


def _design_review(ev, cfg, measured):
    ncu_cell = ('<td>Not collected for this additive entry</td><td>Pending; see '
                '<a href="#ncu-evidence">the additive NCU record</a>.</td>'
                if not measured else
                '<td>Isolated full/source replay recorded in section 6.10</td>'
                '<td>Measured for one attention call; not a full-network timing.</td>')
    if measured:
        opening = ('These are additive checks for this entry. They do not reuse a timing or counter '
                   'from the legacy 81-entry NCU set. The isolated replay in section 6.10 measures '
                   'this launch; it is not a full-network timing.')
    else:
        opening = ('These are additive checks for this entry. They do not reuse a timing or counter '
                   'from the legacy 81-entry NCU set, and they do not establish achieved occupancy '
                   'or speed.')
    return f"""<div class="design-review" id="design-review">
<h3>6.7 Review the source design against the compiled and reference results</h3>
<p>{opening}</p>
<div class="table-scroll"><table><thead><tr><th>Design prediction</th><th>Recorded result</th><th>Decision</th></tr></thead><tbody>
<tr><td>Static shared is four K/V slots plus two 8-byte barriers</td><td>Source {cfg['shared']:,} B; compiled {cfg['shared']:,} B static/CTA</td><td>Matched; the cuobjdump figure also includes 1,024 B reserved space.</td></tr>
<tr><td>Registers respect the <code>__maxnreg__(208)</code> cap</td><td>{cfg['registers']} registers/thread for {cfg['prec']}</td><td>FP16 is at the cap; FP8 is below it. The cap is not an occupancy result.</td></tr>
<tr><td>66 persistent FP32 words/lane are intentional live state</td><td>Compiled attributes do not map arrays to physical registers</td><td>Keep the logical budget; do not claim every value stays in registers.</td></tr>
<tr><td>Each Half probability widens before its first FP32 add</td><td>Selected denominator error vs native reference ≤ 0.0001220703</td><td>Consistent with the source order; sampled, not an all-query proof.</td></tr>
<tr><td>Final publication performs the stated rounding</td><td>FP8 100% exact; FP16 99.2228% exact on 98,304 selected values</td><td>Fixture-level agreement; no quality claim beyond these values.</td></tr>
<tr><td>NCU activity, spills traffic and latency</td>{ncu_cell}</tr>
</tbody></table></div>
<p>No performance number is inferred from PTX call counts or from the legacy evidence set.</p>
</div>"""


def _compiler_resources(cfg, measured):
    smoke = 'runtimeResources.fp8.candidateSafeRows' if cfg['prec'] == 'FP8' else 'runtimeResources.fp16.candidateSafeRows'
    return f"""<aside class="note measured-evidence" id="measured-resources">
<h3>6.8 Validate the design against the compiled SM120 binary</h3>
<p>The source cap is 208 registers/thread. Compilation and CUDA function attributes independently
report <strong>{cfg['registers']} registers/thread</strong> and <strong>{cfg['shared']:,} B static
shared/CTA</strong> for this {cfg['prec']} entry. The block still launches 128 threads; the function
attribute <code>maxThreadsPerBlock=256</code> is a limit, not the chosen block size.</p>
<table><thead><tr><th>Measured compiler / runtime quantity</th><th>{cfg['prec']} result</th></tr></thead><tbody>
<tr><td>Registers per thread</td><td>{cfg['registers']}</td></tr>
<tr><td>Application static shared</td><td>{cfg['shared']:,} B / CTA</td></tr>
<tr><td>Stack / function local-size attribute</td><td>{cfg['stack']} B / thread</td></tr>
<tr><td>ptxas spill stores / loads</td><td>{cfg['spill_stores']} B / {cfg['spill_loads']} B</td></tr>
<tr><td>CUDA occupancy API capacity</td><td>2 active CTAs / SM at the actual launch shape</td></tr>
</tbody></table>
<p>The spill byte figures describe compiler-generated code, not measured traffic per frame.
FP16 has a real local-memory spill path backed by device memory and caches; the compiler may choose
which values to spill. Do not assign those spills to a particular array without disassembly and
source counters. FP8 reports no spills. The capacity result is not achieved occupancy.
The cuobjdump shared figure adds 1,024 B of reserved space; the table uses application static shared.</p>
<p>Evidence: <a href="evidence-small/validation/compiler-build.log"><code>compiler-build.log</code></a> (FP8 lines 8–11; FP16 lines 17–20),
<a href="evidence-small/validation/runtime-resources.json"><code>runtime-resources.json</code></a> → <code>{smoke}</code>.
Binary SHA-256: <code>f0d514043dda98bbe0043ac14d1d93a13e6620eae1c0338d1e3901c017528938</code>.
Device: NVIDIA RTX PRO 6000 Blackwell Workstation Edition, SM120.</p>
</aside>"""


def _numerical_evidence(measured):
    separate = ("""<p><strong>Separately measured:</strong> full-network eager timing and the
Cyberpunk comparison media are published in the
<a href="cyberpunk-comparison.html">accepted comparison chapter</a>; they were measured outside
NCU and are not established by NCU alone. Per-query aggregation, bank-conflict cost and overlap
remain unmeasured here. The reports in section 6.10 measure one isolated attention
call on this fixture. Source is committed at
<code>266d69acf52dda413df3a874572f1156461f89ff</code>. No legacy
NCU report is attributed to these additive entries.</p>""" if measured else
"""<p><strong>Still separate:</strong> new-entry NCU activity, dynamic local-memory traffic,
bank-conflict cost, latency and overlap. Full-network eager timing and comparison media are
measured separately in the <a href="cyberpunk-comparison.html">accepted comparison chapter</a>
and are not established by NCU alone. Source is committed at
<code>266d69acf52dda413df3a874572f1156461f89ff</code>. No legacy
NCU report is attributed to these additive entries.</p>""")
    return f"""<h3>6.9 Validate values separately from layouts and resource capacity</h3>
<p>The independent probability reference checks 96 selected queries × 32 heads × 32 channels
(98,304 output values per precision), including boundaries and interiors. FP8 publication matches
exactly for all selected values. FP16 matches exactly for 99.2228%; maximum absolute error is 0.125,
maximum error 14 Half ULPs, p99 absolute error zero, and no value exceeds the predeclared FP32 bound.
This is a sampled numerical oracle, not a proof for every query or bitwise FP16 equality.</p>
<p>The full typed output finite census checks 2,228,224 values separately. Selected native
numerators include 723 FP16 and 640 FP8 values above 65,504, while maximum denominator error is
0.0001220703. Diagnostic instrumentation on/off and production outputs are bitwise consistent.
See the published <a href="evidence-small/validation/probability-frame-fp16.json">FP16 probability reference</a>
and the <a href="evidence-small/validation/probability-frame-fp8.json">FP8 twin</a>.</p>
<p>The RGB integration checks eight source/model/precision cases. Each phase-3 output-view bridge
is byte-for-byte equivalent to explicit TILE4→PLANE16 permutation; b69 is finite in all arms, Small b31 is finite, and
Small FP8 has zero ±448 values at b31. The 320² wrappers pass four graph replay/guard cases.
Evidence: <a href="evidence-small/validation/rgb-validation.json"><code>rgb-validation.json</code></a>. This validates these fixtures; it does not
establish official DLL equivalence or gameplay quality.</p>
{separate}"""


def _pending_ncu():
    return """<aside class="note" id="ncu-evidence">
<h3>6.10 NCU evidence: pending additive record</h3>
<p><strong>No NCU report is attached to this entry.</strong> The historical 81 lessons keep their
full + SourceCounters pairs at the legacy snapshot. Those reports are not evidence for this
different source, binary or accumulation contract and must not be reused here.</p>
<p>The additive record in <code>evidence-small/index.json</code> reserves one measured extension per
entry. Each record must gain one <code>-full</code> and one separate <code>-source</code> report with
its raw hash, fixture receipt, register/shared metrics, local loads/stores/spills and source-mapped
SASS. Until then, <code>ncu_reports</code> stays empty and no measured activity, bank-conflict,
occupancy or latency value is printed.</p>
<div class="table-scroll"><table><thead><tr><th>Extension field</th><th>Required for this entry</th></tr></thead><tbody>
<tr><td><code>binary_sha256</code></td><td><code>f0d514043dda98bbe0043ac14d1d93a13e6620eae1c0338d1e3901c017528938</code></td></tr>
<tr><td><code>ncu_reports[]</code></td><td><code>-full</code> plus <code>-source</code> for the same fixture; <code>path</code>, <code>sha256</code>, <code>fixture</code></td></tr>
<tr><td><code>compiled_resources</code></td><td>launch registers/allocated, static/dynamic/driver shared, block and grid, local loads/stores, spill counters</td></tr>
<tr><td><code>numerical_reference</code></td><td>sampled oracle and full finite-census receipts; already populated</td></tr>
<tr><td><code>state</code></td><td><code>compiler-and-reference-measured; ncu-pending</code> until the report pair exists</td></tr>
</tbody></table></div>
<p>This is the explicit extension point; it does not weaken the legacy 81-entry coverage gate.</p>
</aside>"""


def _measured_ncu(ev, cfg):
    reports = ev.get('ncu_reports') or []
    report_rows = ''.join(
        f'<tr><td>{escape(str(r.get("kind", "")))}</td>'
        f'<td><a href="{escape(str(r.get("path", "")))}"><code>{escape(str(r.get("path", "")))}</code></a></td>'
        f'<td><code>{escape(str(r.get("sha256", "")))}</code></td>'
        f'<td>{escape(str(r.get("fixture_id") or r.get("fixture", "")))}</td>'
        f'<td>{_fmt(r.get("metric_count"))}</td></tr>'
        for r in reports)
    compiled = ev.get('compiled_resources') or {}
    contract = ev.get('contract') or {}
    derived = ev.get('derived') or {}
    duration = _metric(ev, 'gpu__time_duration.sum')
    grid = _metric(ev, 'launch__grid_size')
    block = _metric(ev, 'launch__block_size')
    waves = _metric(ev, 'launch__waves_per_multiprocessor')
    regs = _metric(ev, 'launch__registers_per_thread')
    alloc_regs = _metric(ev, 'launch__registers_per_thread_allocated')
    static_shared = _metric(ev, 'launch__shared_mem_per_block_static')
    driver_shared = _metric(ev, 'launch__shared_mem_per_block_driver')
    occ_regs = _metric(ev, 'launch__occupancy_limit_registers')
    occ_smem = _metric(ev, 'launch__occupancy_limit_shared_mem')
    occ_warps = _metric(ev, 'launch__occupancy_limit_warps')
    achieved = _metric(ev, 'sm__warps_active.avg.pct_of_peak_sustained_active')
    ceiling = _metric(ev, 'sm__maximum_warps_per_active_cycle_pct')
    issue = _metric(ev, 'smsp__issue_active.avg.pct_of_peak_sustained_active')
    local_ld = _metric(ev, 'smsp__sass_inst_executed_op_local_ld.sum')
    local_st = _metric(ev, 'smsp__sass_inst_executed_op_local_st.sum')
    spill_inst = _metric(ev, 'sass__inst_executed_register_spilling_mem_local')
    local_hit = _metric(ev, 'l1tex__t_sector_pipe_lsu_mem_local_op_ld_hit_rate.pct')
    samples = _metric(ev, 'smsp__pcsamp_sample_count')
    spill_pcs = ev.get('local_spill_pcs') or []
    direct_samples = sum(row.get('direct_base_samples', 0) for row in spill_pcs)
    direct_pct = (100.0 * direct_samples / samples) if samples else 0.0
    if local_ld:
        local_text = (
            f'<strong>FP16 local traffic is real but not established as the dominant cost.</strong> '
            f'The full report records {_fmt(local_ld)} local loads and {_fmt(local_st)} local stores '
            f'({_fmt(spill_inst)} total spill instructions), with a <code>{_fmt(local_hit)}%</code> '
            f'local-load sector hit rate. Source sampling attributes only {_fmt(direct_samples)} of '
            f'{_fmt(samples)} base PC samples ({_fmt(direct_pct, 2)}%) to {len(spill_pcs)} direct '
            f'<code>LDL</code>/<code>STL</code> PCs; that small direct share is not the total spill '
            f'runtime share, and aggregate local metrics have no PC instances.')
    else:
        local_text = (
            '<strong>FP8 removes the local-memory path.</strong> The full report records zero local '
            'loads, zero local stores, zero local sectors and zero spill instructions, and the source '
            'run has no direct <code>LDL</code>/<code>STL</code> PCs. There is therefore no FP8 spill '
            'runtime share to attribute; this does not imply that FP16 spills dominate its own time.')
    shared_wave = _metric(ev, 'l1tex__data_pipe_lsu_wavefronts_mem_shared_op_ld.sum')
    shared_inst = _metric(ev, 'smsp__sass_inst_executed_op_shared_ld.sum')
    bank_conf = _metric(ev, 'l1tex__data_bank_conflicts_pipe_lsu_mem_shared_op_ld.sum')
    wave_ratio = derived.get('shared_ld_wavefronts_per_lds128_instruction')
    wait = _metric(ev, 'smsp__pcsamp_warps_issue_stalled_wait')
    barrier = _metric(ev, 'smsp__pcsamp_warps_issue_stalled_barrier')
    long_sb = _metric(ev, 'smsp__pcsamp_warps_issue_stalled_long_scoreboard')
    math_pipe = _metric(ev, 'smsp__pcsamp_warps_issue_stalled_math_pipe_throttle')
    tensor_elapsed = _metric(ev, 'sm__pipe_tensor_cycles_active.avg.pct_of_peak_sustained_elapsed')
    tensor_active = _metric(ev, 'sm__pipe_tensor_cycles_active.avg.pct_of_peak_sustained_active')
    sample_pct = lambda value: (100.0 * value / samples) if samples else None
    hotspot_count = ev.get('source_hotspot_count') or len(ev.get('source_hotspots') or [])
    unavailable = ev.get('unavailable') or []
    unavailable_items = ''.join(
        f'<li><code>{escape(str(item.get("name", "")))}</code> — {escape(str(item.get("reason", "")))}</li>'
        for item in unavailable[:4])
    warning = ev.get('report_identity', {}).get('warning', '')
    mma_rows = ''
    for label in ('FP16', 'FP8'):
        row = _MMA_ROWS[label]
        mma_rows += (
            f'<tr><td>{label}</td>'
            f'<td><code>{row["qk"]}</code> at <code>{row["qk_file"]}:{row["qk_line"]}</code></td>'
            f'<td>Half</td>'
            f'<td><code>{row["pv"]}</code> at <code>{row["pv_file"]}:{row["pv_line"]}</code></td>'
            f'<td>FP32</td><td>FP32</td></tr>')
    if cfg['prec'] == 'FP8':
        twin_text = ('The FP16 twin reports <strong>208 registers, 16,400 B static shared, a 24 B '
                     'stack and 44 / 56 B spill stores / loads</strong>; this FP8 entry records '
                     '<strong>zero local loads, stores and spills</strong>.')
        local_summary = 'the absence of FP8 local-memory traffic'
    else:
        twin_text = ('The FP8 twin reports <strong>195 registers and 8,208 B static shared</strong> '
                     'with <strong>zero local loads, stores and spills</strong>; this FP16 entry is '
                     'the one with the real stack and spill path.')
        local_summary = 'the FP16 local-memory traffic'
    artifacts = ('<p>Reader evidence: <a href="evidence-small/measurements.json">compact measurement '
                 'snapshot</a>, <a href="evidence-small/REPORT.md">verified report prose</a>, and the '
                 'four raw reports above. Hashes and fixture identity are recorded in '
                 '<a href="evidence-small/index.json">evidence-small/index.json</a>.</p>')
    return f"""<aside class="note measured-evidence" id="ncu-evidence">
<h3>6.10 NCU validation: an isolated replay of one attention call</h3>
<p><strong>Measured state.</strong> The {cfg['prec']} entry has exactly one full and one separate
source report for fixture <code>{escape(str(ev.get("fixture_id", "")))}</code>; both were collected
from the accepted source <code>{escape(str(ev.get("runtime_source_revision", "")))}</code> and binary
<code>{escape(str(ev.get("runtime_binary_sha256", "")))}</code>. Reports keep their actual
<code>.ncu-repz</code> names and raw SHA-256 values. The full and source passes are different runs:
aggregate metrics come from the full report, PC-stall samples from the source report, and their
sample counts are never combined.</p>
<p><strong>Scope.</strong> This is an isolated profiled replay of one attention call on the captured
real 3840×2160 fixture (<code>T=2,160</code>, batch 1, 32 heads, C1024, head channels 32), not a
full-network timing, not eager video throughput, and not a speedup claim. Nsight Compute's kernel
replay and cache control flush between passes, so the duration is an instrumented reference for this
launch only. The device is an SM120 RTX PRO 6000 Blackwell (188 SMs); no B200/TMEM/<code>sm_100</code>
assumption is used.</p>
<p><code>{escape(str(warning))}</code></p>
<div class="table-scroll"><table><thead><tr><th>Pass</th><th>Relative public report</th><th>Raw SHA-256</th><th>Fixture</th><th>Catalogued rows</th></tr></thead><tbody>
{report_rows}
</tbody></table></div>
<h3>6.10.1 Compiler budget, launch geometry and occupancy</h3>
<div class="table-scroll"><table><thead><tr><th>Quantity</th><th>{cfg['prec']} measured value</th><th>Scope</th></tr></thead><tbody>
<tr><td>Isolated replay duration</td><td>{_fmt(duration)} ns</td><td>one call, instrumented; not network timing</td></tr>
<tr><td>Grid / block</td><td>{_fmt(grid)} / {_fmt(block)}</td><td>32×9×1 CTAs / 32×4×1 threads</td></tr>
<tr><td>Launched threads / <code>maxThreadsPerBlock</code></td><td>{_fmt(block)} / {_fmt(compiled.get("max_threads_per_block_attribute"))}</td><td>chosen launch shape vs function-attribute limit</td></tr>
<tr><td>Waves per multiprocessor</td><td>{_fmt(waves, 6)}</td><td>launch metric</td></tr>
<tr><td>Registers / thread</td><td>{_fmt(regs)} (allocated {_fmt(alloc_regs)})</td><td>compiled and launch-reported</td></tr>
<tr><td>Source static-shared budget / compiled / NCU</td><td>{cfg['shared']:,} / {_fmt(static_shared)} / {_fmt(static_shared)} B</td><td>four K/V slots + two barriers; source prediction matched</td></tr>
<tr><td>CUDA occupancy API capacity</td><td>{_fmt(compiled.get("cuda_occupancy_api_capacity_ctas_per_sm"))} CTAs/SM</td><td>capacity, not achieved occupancy</td></tr>
<tr><td>Driver-reserved shared</td><td>{_fmt(driver_shared)} B</td><td>not application state</td></tr>
<tr><td>ptxas stack / spill stores / spill loads</td><td>{_fmt(compiled.get("ptxas_stack_frame_bytes"))} / {_fmt(compiled.get("ptxas_spill_store_bytes"))} / {_fmt(compiled.get("ptxas_spill_load_bytes"))} B</td><td>compiler resources, not runtime traffic</td></tr>
<tr><td>Occupancy limits: registers / shared / warps (CTAs/SM)</td><td>{_fmt(occ_regs)} / {_fmt(occ_smem)} / {_fmt(occ_warps)}</td><td>registers bind at 2 CTAs/SM</td></tr>
<tr><td>Achieved occupancy</td><td>{_fmt(achieved)}%</td><td>measured resident warps</td></tr>
<tr><td>Theoretical occupancy ceiling</td><td>{_fmt(ceiling)}%</td><td>8 of 48 warps at 2 CTAs/SM</td></tr>
<tr><td>Issue-active</td><td>{_fmt(issue)}%</td><td>measured issue utilization</td></tr>
<tr><td>Tensor-pipe active (elapsed / active)</td><td>{_fmt(tensor_elapsed)}% / {_fmt(tensor_active)}%</td><td>one signal, not independent confirmations</td></tr>
</tbody></table></div>
<p><strong>Labelled geometry inference.</strong> The device identity reports 188 SMs. With 288 CTAs and
the measured 2-CTA/SM register capacity, uniform admission gives
<code>288 / (188 × 2) = {_fmt(derived.get("waves_arithmetic_288_over_188x2"), 6)}</code> waves,
matching the measured launch value. The 16.667% ceiling is
<code>2 CTAs × 4 warps / 48 warp slots = 8/48</code>; achieved
<code>{_fmt(achieved)}%</code> is below it, while the uniform-admission arithmetic
<code>288 × 4 / (188 × 48) = {_fmt(derived.get("uniform_admission_occupancy_pct_288x4_over_188x48"))}%</code>
is not a measured admission trace. The register limit is
<code>floor(65,536 / (208 × 128)) = 2</code> CTAs for FP16 and
<code>floor(65,536 / (195 × 128)) = 2</code> for FP8; allocated FP8 registers are 200, which also
gives 2. Shared would allow 5 / 7 CTAs and warps 12, so registers are binding. These arithmetic
results explain the reported capacity; they are not extra measurements. {twin_text}</p>
<h3>6.10.2 Tensor instructions: Half QK in both precisions, FP32 only for PV and the denominator</h3>
<div class="table-scroll"><table><thead><tr><th>Precision</th><th>QK opcode / source pin</th><th>QK accumulator</th><th>PV opcode / source pin</th><th>PV accumulator</th><th>Denominator</th></tr></thead><tbody>
{mma_rows}
</tbody></table></div>
<p>The measured SASS at these sites confirms the opcode families and source locations. Source PTX
loop counts are program counts, not measured dynamic SASS units: FP16 is
<code>4 query tiles × 8 N8 groups × 2 reduction chunks = 64</code> QK and
<code>4 × 4 × 4 = 64</code> PV <code>mma.sync</code> calls per warp per key tile
(<code>128</code> per warp, <code>512</code> per CTA, <code>17,408</code> per CTA over 34 tiles).
FP8 is <code>4 × 8 × 1 = 32</code> and <code>4 × 4 × 2 = 32</code>
(<code>64</code> per warp, <code>256</code> per CTA, <code>8,704</code> over 34 tiles). The report
does not expose a dynamic per-opcode HMMA/QMMA count; tensor-pipe activity above is a different
measured signal, so do not equate PTX call counts with executed SASS instructions.</p>
<h3>6.10.3 K/V shared vectors, banks and the local-memory path</h3>
<p>SASS shows <code>LDS.128</code> for the K and V shared loads. A 128-bit per-lane load over 32 lanes
is a 512 B warp request, which legitimately needs four 128 B shared wavefronts. The measured
shared-load wavefronts per instruction are
<code>{_fmt(wave_ratio, 4)}</code> ({_fmt(shared_wave)} wavefronts /
{_fmt(shared_inst)} instructions) for this entry; the derived excessive-wavefront count is
<code>{_fmt(_metric(ev, "derived__memory_l1_wavefronts_shared_excessive"))}</code> and the ideal
equals the observed wavefront count. The separate hardware counters report
<code>{_fmt(bank_conf)}</code> shared-load bank conflicts. The source-derived ideal and the hardware
bank-conflict counter have different scopes: zero derived excess does not erase the measured
conflicts or establish their runtime cost. The source has no XOR shared-memory swizzle; the producer
writes a prepacked 16-byte panel per lane and the consumer reads it at a 512-byte stride. Do not infer
conflicts merely from repeated bank numbers in a whole-warp 512 B request.</p>
<p>{local_text} The sampled categories are wait {_fmt(wait)}
({_fmt(sample_pct(wait), 2)}%), barrier {_fmt(barrier)} ({_fmt(sample_pct(barrier), 2)}%),
math-pipe throttle {_fmt(math_pipe)} ({_fmt(sample_pct(math_pipe), 2)}%) and long scoreboard
{_fmt(long_sb)} ({_fmt(sample_pct(long_sb), 2)}%). These samples identify candidate dependencies;
they do not prove that spills dominate total time, and cap 224 is an untested follow-up, not an
implemented optimization.</p>
<p>The sampled native reference measured final numerator magnitudes up to
<strong>94,402.390625</strong> (FP16) and <strong>87,855.625</strong> (FP8). These are final-numerator
sample maxima from the 96-query oracle, not all-query maxima or every-prefix maxima. They are not used
as an overflow proof.</p>
<h3>6.10.4 Source-correlated PC hotspots</h3>
<p>Base stall categories only; the <code>*_not_issued</code> subsets are excluded. Each row is out of
the source-run denominator, {_fmt(samples)} warp samples for this entry. {hotspot_count} pinned
source hotspot rows are retained in the compact evidence; the largest are below. The full
per-line/per-metric table, file SHA-256, PC examples and SASS text are in
<a href="evidence-small/measurements.json">the compact snapshot</a>.</p>
<div class="table-scroll"><table><thead><tr><th>File:line</th><th>Base samples</th><th>Categories</th><th>Dominant sampled SASS</th></tr></thead><tbody>
{_hotspot_table(ev)}
</tbody></table></div>
<h3>6.10.5 What this replay establishes and what remains open</h3>
<p><strong>Established for this launch:</strong> the compiled register/shared/spill budget, the actual
128-thread block and 288-CTA grid, the 2-CTA/SM register capacity, achieved occupancy
{_fmt(achieved)}%, issue-active {_fmt(issue)}%, the MMA opcode families and source pins, the 512 B
shared-vector geometry, {local_summary} and the sampled PC distribution. The dominant
sampled categories are dependency wait, barrier and math-issue pressure around the MMA/staging path,
not a single proven causal bottleneck. <strong>Not established:</strong> full-network or eager video
timing, asynchronous overlap inferred from source arrows, vendor DLL host-descriptor parity, quality
equivalence, or the benefit of any register-cap change. cap 224 was not run.</p>
<ul>{unavailable_items}</ul>
{artifacts}
</aside>"""


def evidence_block(ev, cfg):
    """Render the design review, compiler/numerical evidence and measured NCU aside.

    The rich 6.7–6.9 teaching block is always retained.  Only the NCU content
    changes: the pending branch is used when no measured record is supplied, and
    the measured branch replaces it with the current isolated replay.
    """
    measured = bool(ev and ev.get('state') == 'measured' and ev.get('ncu_state') == 'measured')
    if measured:
        cfg = dict(cfg)
        cfg['registers'] = (ev.get('compiled_resources', {})
                            .get('launch__registers_per_thread', cfg['registers']))
        ncu = _measured_ncu(ev, cfg)
    else:
        ncu = _pending_ncu()
    return (_design_review(ev, cfg, measured)
            + _compiler_resources(cfg, measured)
            + _numerical_evidence(measured)
            + ncu)


def problem(cfg):
    fp8 = cfg['prec'] == 'FP8'
    weight_term = 'E4M3(E(q,k))' if fp8 else 'E(q,k)'
    return f'''<p><strong>Target model operation.</strong> Small31's C1024 bottleneck contains eight
global-attention blocks (scheduler operation-role labels 31–38, distinct from archive raw IDs 0–30),
each with 32 heads of 32 channels. This {cfg['prec']} kernel
connects their QKV producer to the attention-output projection: each query reads every key and
combines the associated V features. The worked 4K case has 2,160 model positions, including spatial
padding; the key stream extends to 2,176 positions to fill its final tile.</p>
<p><strong>Derive the token count from the model geometry.</strong> A 3840×2160 frame first uses
a 3840×2176 frontend field. Each encoder level applies <code>align_up(ceil(previous/2), 4)</code>
independently to width and height. Levels 0…5 are <code>1920×1088 → 960×544 → 480×272 →
240×136 → 120×68 → 60×36</code>. The last height is <code>ceil(68/2)=34</code>, then rounded
to 36, so the bottleneck has <code>T=60×36=2,160</code> model positions. This includes level-5
spatial padding. The separate 32-token host allocation rounds T to 2,176; the attention kernel's
256-query CTA grid covers 2,304 query slots. These are three different extents.</p>
{cut('csrc/kernel_launcher/plan_geometry.h', 'for (int Level = 0; Level < 6; ++Level)', 7, before=1, caption='The model geometry pads each encoder field after halving; do not divide the frontend area by 64² to infer T.')}
<p>Consider one head of non-causal global attention.
For head <code>h</code>, query row <code>q</code>, and output channel <code>c</code> inside the
32-channel head:</p>
<p class="formula"><code>D[q] = Σ<sub>k</sub> E(q,k)</code>, &nbsp;
<code>u[q,c] = Σ<sub>k</sub> {weight_term} · V[k,c]</code>, &nbsp;
<code>y[q,c] = publish( u[q,c] / max(D[q], ε) )</code>.</p>
<p><strong>Hardware target.</strong> Map this operation to an SM120-class GPU with 128-thread
CTAs, <code>mma.sync</code> tensor instructions and explicitly addressed shared storage. The source
uses <code>__maxnreg__(208)</code>; the Half entry admits SM80+ and the E4M3 entry SM89+, while the
measured binary is SM120. Derive the tile and live-state budget first, then compare it with the
compiler and experiment results in section 6.</p>
<p><code>Q</code> and <code>K</code> are normalized per 32-channel head upstream. <code>Q</code> is
then multiplied by <code>sqrt(32)</code> and a learned per-head Half scale; <code>K</code> is not
scaled by that head factor. <code>V</code> is not normalized and is not unit-bounded; the QKV
producer transposes its fragments before publication. This entry does not change Q, K, V, the ABI,
the token addresses or the padded-key obligation. It changes only the finite-precision accumulation
contract of <code>u</code> and <code>D</code>.</p>
<table>
<thead><tr><th>Stage</th><th>FP16 entry</th><th>FP8 entry</th></tr></thead>
<tbody>
<tr><td>QK score</td><td><code>{_cfg(False)['qk']}</code>; Half C/D</td><td><code>{_cfg(True)['qk']}</code>; Half C/D</td></tr>
<tr><td>Surrogate E</td><td>packed Half affine, clamp, word shift</td><td>same packed Half affine, clamp, word shift</td></tr>
<tr><td>P in the numerator</td><td>the Half E itself</td><td><code>E4M3(E)</code>; a separate conversion</td></tr>
<tr><td>P×V</td><td><code>{_cfg(False)['pv']}</code>; FP32 D</td><td><code>{_cfg(True)['pv']}</code>; FP32 D</td></tr>
<tr><td>Denominator</td><td>each Half E widened before its first FP32 add; FP32 tree and carry</td><td>the same, using the original Half E</td></tr>
<tr><td>Publication</td><td>one Half rounding after the FP32 multiply</td><td>one Half rounding, then E4M3</td></tr>
</tbody></table>
<p>The QK accumulator is Half in <strong>both</strong> entries. The surrogate is a fixed positive
map, not a row-max softmax: no max subtraction, no <code>exp</code>, no normalization inside E. Each
Half lane of a score pair gets its own affine transform and clamp; the whole-word shift and offset
then act on the packed pair, so the native carry between lanes is part of the encoding. The exact
positive interval is <code>[0.0040283203125, 1.640625]</code>; a zero score encodes to
<code>E<sub>0</sub> = 0.083984375</code>.</p>
<p><strong>Why widen the accumulator?</strong> E is positive, so <code>D</code> is positive and the
ideal FP16-path result before arithmetic rounding is a convex mixture of V rows with weights <code>E/D</code>. The final value can be
modest while a prefix is huge: <code>u<sub>j</sub> = Σ<sub>k≤j</sub> E·V</code> is unnormalized, and
every prefix must stay finite. Later opposite-sign terms cannot repair an earlier Inf or NaN. Half
has largest finite magnitude 65,504; overflow can produce infinity. FP8 satfinite publication is a
separate conversion rule. FP32 has a far larger exponent range. This is a forward-range decision, not a
tuning history.</p>
<p>A diagnostic on the recorded 4K fixture — same Q/K, surrogate, weights and
phases, with only the attention call's V divided by 16 and then multiplied back — makes the risk
concrete:</p>
<table>
<thead><tr><th>Diagnostic observation</th><th>FP16</th><th>FP8</th></tr></thead>
<tbody>
<tr><td>Baseline <code>b31.attended</code></td><td>18,319 non-finite (+inf 10,185 / −inf 8,134)</td><td>finite, but 16,322 entries exactly ±448 (E4M3 maximum)</td></tr>
<tr><td>V/16 run, raw finite range before compensation</td><td>−6.0508 … 8.2969</td><td>−6.0 … 8.0</td></tr>
<tr><td>After diagnostic scale-back</td><td>all 18,319 former non-finite entries finite; 99.25% bit-exact on baseline-finite entries, MAE 0.00245, max 0.33</td><td>all 16,322 ±448 entries removed</td></tr>
</tbody></table>
<p>The −6.0508…8.2969 interval is the <em>raw V/16 run</em>, not a compensated range; the probe
report's header is ambiguous. This early V/16 probe did not measure an all-query maximum over
every intermediate numerator prefix. The later sampled native reference measured final numerator
magnitudes up to 94,402.390625 (FP16) and 87,855.625 (FP8), as discussed in section 6; these are
measured sample maxima, not the all-query prefix maximum. The FP16 non-finite entries
plus the finite inverse bound already prove a Half numerator above 65,504. FP8 ±448 is a
post-normalization E4M3 limit and by itself does <strong>not</strong> prove a Half overflow.</p>
<p><strong>FP8 is not an exact convex hull.</strong> The denominator sums the original Half E, but
the numerator's P operand is <code>E4M3(E)</code>. If <code>E4(E)=E+δ</code>, then
<code>u = ΣE·V + Σδ·V</code> while <code>D = ΣE</code>. The output is a convex mixture plus a
perturbation bounded by the E4M3 allowance: about half an E4M3 ulp per normal term (≈6.25% relative),
with an absolute allowance below the normal range. Do not use an FP16 convex-hull oracle for FP8
without that allowance. Padding uses <code>E(0)=0.083984375</code>; at T=2,160 the 16 padded keys add
<code>16 × 0.083984375 = 1.34375</code> to each denominator, removed in FP32, and zero to the
numerator because their V is zero.</p>
{build_all(cfg['name'], fp8)[0]}'''


def cta(cfg):
    fp8 = cfg['prec'] == 'FP8'
    e = cfg['e']
    figs = build_all(cfg['name'], fp8)
    fig = figs[1]
    return f'''<p>Choose one head per CTA. The launch grid is
<code>(blockIdx.x = 32 heads, blockIdx.y = ceil(T/256) = 9 query blocks)</code> with
<code>block = (32 lanes, 4 warps)</code>. A CTA owns 256 queries of one head, divided into four warps
of 64 queries; each warp owns four M16 query tiles. For block 0, warp 0, query tile 1, the 16-token
group is <code>0·16 + 0·4 + 1 = 1</code>, covering global queries 16…31; query 17 is local row 1.</p>
<p>Keys stream through a two-slot ring. Each stage holds 64 keys × 32 channels × {e} byte =
<strong>{cfg['stage']:,} bytes</strong> for K and the same for V. The four slots K0, K1, V0, V1
occupy <code>4 × {cfg['stage']:,} = {4*cfg['stage']:,} bytes</code>, followed by two 8-byte barriers,
so the static shared declaration is <strong>{cfg['shared']:,} bytes</strong> per CTA. There is no
XOR shared-memory swizzle in this kernel: the producer writes a prepacked 16-byte panel per lane and
the consumer reads the same panel at a 512-byte stride.</p>
<p>Q is loaded once with <code>__ldca</code> into registers. K and V are bulk-copied into
<code>s_Storage</code> and read back as <code>uint4</code> vectors. These are three storage layers:
a hardware-managed global route for Q, a bulk global-to-shared copy for K/V, and explicit shared
addressing for the ring. The source does not promise that the bulk copy allocates an L1 line.</p>
<h3>2.1 The exact K and V publication maps</h3>
<p>K uses Q's 16-token-group × 32-channel-head layout:
<code>group·16384·E + head·512·E + keyChunk·512</code>. FP16 has a 32,768-byte group and a 1,024-byte
head plane; FP8 has 16,384 and 512. V deliberately does <strong>not</strong> use that map. Its
transposed fragments are addressed by
<code>group·32768 + head·1024 + (CopySlot &amp; 1)·512</code>, independent of element size. The
32,768-byte V group holds 16 tokens in FP16 and 32 in FP8, so its head plane is 1,024 bytes in both.
Treating V as dense token×channel, or as byte-identical to Q, gives wrong offsets.</p>
{cut(cfg['path'], 'const auto StageKeyValue', 61, 0, 'K and V staging: two layouts, one ring slot')}
<p>For key tile 0, head 7, CopySlot 0, K group 0/chunk 0 gives
<code>7·512·E</code>: <strong>7,168 bytes FP16</strong> or <strong>3,584 bytes FP8</strong>. The V
address uses value group 0, giving <code>7·1024 = 7,168 bytes</code> in both. The K destination is
<code>s_Copy</code>; V goes to <code>s_ValueOffset + s_Copy</code>, so the halves never alias.</p>
{figs[5]}
<h3>2.2 T=2,160: two different padding paths</h3>
<p>The host rounds tokens to 32, so <code>PaddedTokens() = 2,176</code> for both. The kernels derive
their own local count from alignment 16 (FP16) or 32 (FP8):</p>
<table>
<thead><tr><th>Quantity at T=2,160</th><th>FP16</th><th>FP8</th></tr></thead>
<tbody>
<tr><td>Kernel local <code>g_PaddedTokens</code></td><td>2,160</td><td>2,176</td></tr>
<tr><td>16-token groups</td><td>135</td><td>136</td></tr>
<tr><td>Key tiles of 64</td><td>34</td><td>34</td></tr>
<tr><td>Keys in the stream</td><td>34×64 = 2,176</td><td>34×64 = 2,176</td></tr>
<tr><td>Padded keys</td><td>16</td><td>16</td></tr>
<tr><td>Zero source</td><td>shared zero fill for the last 16-key group</td><td>upstream repack +0 tail; QKV group 135 publishes zero</td></tr>
</tbody></table>
<p>Both kernels have 34 key tiles, covering keys 0…2,175. There are <strong>no fictional keys beyond
2,175</strong>. In the last tile, keys 2,160…2,175 are the 16 pad keys. FP16 zero-fills the last
K/V group in shared memory because group 135 is not below <code>g_Groups16=135</code>. FP8 has
<code>g_Groups16=136</code>, so group 135 is a valid copy of the upstream QKV output. That output is
zero there because the upstream repack explicitly writes +0 for tokens beyond the real count
(<code>r_CopiedWord = 0</code> guarded by <code>g_TokenIndex &lt; g_TokenCount</code>), and QKV
group 135 consumes exactly that tail. The downstream arithmetic is identical: encoded zero score
gives E<sub>0</sub> for those keys, and V is zero.</p>
{fig}
<p>The last query block (blockIdx.y = 8) owns global queries 2,048…2,159: 112 real queries, not 256.
The kernel does not add an early-exit branch for invalid query tiles: each warp computes its four
M16 query tiles (16 per CTA), and groups outside <code>g_Groups16</code> do not store. FP16 stores
through row 2,159. FP8 also stores its padded group at rows 2,160…2,175, then clears those rows
after the fragment stores and before releasing completion counters. Rows 2,176…2,303 do not store
in either entry. Count the executed tail work when reasoning about instruction totals; do not
count 2,304 model queries.</p>'''


def warp(cfg):
    fp8 = cfg['prec'] == 'FP8'
    figs = build_all(cfg['name'], fp8)
    return f'''<p>One warp owns 64 queries × 32 channels = 2,048 values, or 64 per lane. The source stores them as
<code>float r_Output[4][4][4]</code>: four M16 query tiles × four N8 output groups × four native D
registers. D0/D1 are the two lane-owned columns of row <code>Lane/4</code>; D2/D3 are the same
columns of row <code>Lane/4+8</code>. The row denominator is <code>float r_Denominator[2]</code>
(low 32, high 32 queries). That is <strong>66 persistent FP32 words per lane</strong>.</p>
<p>QK uses <code>MmaWindowFragment&lt;bFp8&gt;</code> and accumulates Half C/D. PV uses
<code>MmaWindowFragmentF32&lt;bFp8&gt;</code>: FP16 selects
<code>{_cfg(False)['pv']}</code>; FP8 selects <code>{_cfg(True)['pv']}</code>. Operand and D layouts
match, so the P/V lane map is unchanged; only the accumulation format of PV changes.</p>
<h3>3.1 The worked query: q17, head 7, channel 9</h3>
<p>Query 17 is global token 17. CTA <code>(7,0)</code>, warp 0, query tile 1, local row 1. With
<code>g = Lane/4 = 1</code>, <code>q = Lane%4 = 0</code>, lane 4 owns the row. Channel 9 is N8 group
1, column pair 0, so the value is <code>r_Output[1][1][1]</code>; channel 8 is
<code>[1][1][0]</code>. The query's 32 channels are spread over lanes 4…7.</p>
<p>Final normalization computes <code>QueryRow = 1·16 + 4/4 + 0 = 17</code>, selects the low FP32
denominator because <code>r_QueryTile &lt; 2</code>, and calls
<code>ShuffleIdx(..., 17, 31, 0xffffffff)</code>. Output owner: lane 4. Denominator owner: lane 17.
The PV fragment is distributed by output column; the row reduction is transposed to one query per
lane.</p>
{cut(cfg['path'], 'FWindowAFragment r_Query', 19, 0, 'Q is loaded once, with the group/head/chunk/lane address')}
<p>The Q fragment address is <code>group·16384·E + head·512·E + chunk·512 + lane·16</code>. For
group 1, head 7, chunk 0, lane 4 this is <strong>{cfg['vecbase']:,} bytes</strong>:
<code>1·16384·{cfg['e']} + 7·512·{cfg['e']} + 0 + 64</code>. The same expression with the output
pointer is the final output vector base. The 16-byte vector holds eight Half values in FP16 or
sixteen E4 bytes in FP8; it is the lane's packed fragment, not a contiguous channel range.</p>
{cut(HELPER, 'void MmaHalfF32', 43, 0, 'Two FP32-accumulating PV contracts behind one dispatch')}
<p><code>MmaHalfF32</code> and <code>MmaE4F32</code> both read four A words and two B words and update
four FP32 D registers. The FP8 body is guarded by <code>__CUDA_ARCH__ &gt;= 890</code>; the entry is
rejected before that target. The comment matters for the lane map: D0/D1 are row
<code>Lane/4</code>, D2/D3 are row <code>Lane/4+8</code>.</p>
<h3>3.2 The FP32 denominator gather and lane 17</h3>
<p>The row reduction is the only place where the warp's query halves are recombined. Each lane has
four local <code>float2</code> sums per query half; each local sum holds 16 keys. The q17 partial is <code>r_LocalProbabilitySums[2]</code> in each of lanes 4,5,6,7;
its float2 components hold even/odd key columns of the same query. The receiving lane 17 uses
<code>sourceLane = ((17 &amp; 7) &lt;&lt; 2) + (17 &gt;&gt; 3) = 6</code>. The gathers read source lanes
<code>6,7,4,5</code>; the second permutation with <code>Lane &gt;&gt; 3 = 2</code> swaps words 0↔2 and
1↔3, so the addition order is <code>4,5,6,7</code>. Four sources × 16 keys = 64 keys = one key tile.
The even/odd key-component combine is one FP32 <code>TotalFloat2</code>, and <code>r_Denominator[0] +=</code> carries
it across tiles.</p>
{figs[6]}
<p>The P operand for FP8 is the E4M3 conversion of the same Half probabilities, but the denominator
uses the <em>original</em> Half E widened to two FP32 components. There is no path in which the E4
values are summed into D. That is why the FP8 ratio is not an exact convex hull and why an FP16
oracle cannot be reused unchanged.</p>
{figs[2]}
<p>The lane map is a logical register plan, not a compiler allocation. The 208 cap is an admission
limit; it does not mean 208 registers were assigned. The next section sizes the intentional live
state before comparing it with the compiled result in section 6.</p>'''


def resources(cfg):
    figs = build_all(cfg['name'], cfg['prec'] == 'FP8')
    return f'''<p>Start with the threads and the intentional live state, not with a profiler number.
A CTA has 128 threads (32 lanes × 4 warps) and owns 256 queries. The persistent per-lane state is 66
FP32 words; the per-CTA logical total is <code>128 × 66 × 4 = 33,792 bytes</code>. The legacy Half
body's comparable logical state was 16,896 bytes, so the persistent delta is 16,896 bytes. That
delta is a live-value calculation, not a compiler register-file delta, not local-memory traffic, and
not occupancy.</p>
<table>
<thead><tr><th>Resource</th><th>Source-derived value</th><th>Validation to perform after implementation</th></tr></thead>
<tbody>
<tr><td>Threads per CTA</td><td>128 (32 × 4)</td><td>see section 6; do not infer from source</td></tr>
<tr><td>Persistent numerator</td><td>64 FP32 words/lane</td><td>see section 6; do not infer from source</td></tr>
<tr><td>Persistent denominator</td><td>2 FP32 words/lane</td><td>see section 6; do not infer from source</td></tr>
<tr><td>Logical persistent state</td><td>33,792 B/CTA</td><td>see section 6; do not infer from source</td></tr>
<tr><td>Static shared declaration</td><td>{cfg['shared']:,} B/CTA</td><td>see section 6; do not infer from source</td></tr>
<tr><td>Q / K / V register fragments</td><td>{cfg['qwords']} words each/lane</td><td>see section 6; do not infer from source</td></tr>
<tr><td>Transient FP32 reduction tree</td><td>4 local float2 + 4 gathered float2 + 2 sums</td><td>see section 6; do not infer from source</td></tr>
<tr><td>Admission cap</td><td><code>__maxnreg__(208)</code></td><td>see section 6; do not infer from source</td></tr>
<tr><td>Registers / local loads / spills</td><td>not inferable from source</td><td>see section 6; do not infer from source</td></tr>
</tbody></table>
<p>The shared declaration is four K/V slots of {cfg['stage']:,} bytes plus two 8-byte barriers:
<code>4 × {cfg['stage']:,} + 16 = {cfg['shared']:,}</code>. It is a static reservation, not an
occupancy result. The 512-byte copy unit and the 16-byte lane vector are visible in the source; the
number of resident CTAs is not.</p>
{figs[3]}
<p>Instruction work is also source-derived. Per warp per key tile, QK issues
<code>4 query tiles × 8 N8 groups × {cfg['qchunks']} reduction chunks = {cfg['qk_mma']}</code> MMA
calls. PV issues <code>4 query tiles × 4 N8 outputs × {cfg['pchunks']} probability chunks =
{cfg['pv_mma']}</code>. That is <strong>{cfg['warp_mma']} PTX <code>mma.sync</code> calls per warp
per key tile</strong>, or {cfg['cta_mma']} per CTA per tile. Across 34 key tiles, one CTA's four warps
issue <strong>{cfg['all_mma']:,} PTX calls</strong> in this source program. These are PTX program
counts, not measured SASS instruction totals; NCU SourceCounters is the only evidence that can
replace them. Tail query tiles still execute the loops and are suppressed only at the store; the
count above already includes that work.</p>
<p>Before measuring anything, require four correctness gates: (1) a scalar FP32 oracle that validates
connectivity and token/channel ownership; (2) a one-key-tile version that checks the Half QK/E path
and the FP32 denominator tree against the same terms in the same order; (3) a streamed 34-tile
version that checks the cross-tile FP32 carry and both ring wraps; (4) a tail fixture at
16/32/64/128/256 tokens that checks zero fill, the explicit FP8 zero tail, the pad correction and
the completion counters. The compiled-resource check follows those gates; it does not substitute for
them.</p>'''


def schedule(cfg):
    figs = build_all(cfg['name'], cfg['prec'] == 'FP8')
    pseudo_text = f'''initialize two 8-byte shared barriers; CTA-wide sync
wait for the Q/K/V predecessor groups needed by this CTA
load all {cfg['qchunks']} Q chunks for each of 4 query tiles once
for keyTile in 0..1: if it exists: wait its group; stage K and V
wait stage 0 if any key tile exists
u[4][4][4] = 0; D[2] = 0
for keyTile in 0..{34-1}:
    read K stage into registers
    form QK Half scores; apply E; reduce the row denominator in FP32
    read V stage into registers
    accumulate P x V into the persistent FP32 u
    if keyTile + 2 exists: wait group; stage keyTile + 2 into the retired slot
    if keyTile + 1 exists: wait stage keyTile + 1
apply the FP32 padded-key correction; clamp epsilon; approximate reciprocal
for each query tile: y = u * inverse; round once; publish valid rows
sync; clear only padded query rows; sync; release completion counters'''
    return f'''<p>The schedule has one non-negotiable dependency: the persistent <code>u</code> and
<code>D</code> must survive every key tile, while K, V, score and E tiles are consumed and replaced.
The ring exists to keep the key axis moving without making the score tile persistent. It is not a
throughput claim and it does not create a fixed warp/CTA timeline.</p>
{cut(cfg['path'], '// Initialize the shared copy barriers', 35, 0, 'Barrier initialization, predecessor wait, Q load and prefill')}
<p>Both barriers are initialized by lane 0/warp 0 and then made visible by a CTA barrier. The
predecessor wait is executed only by lane 0/warp 0, after which every thread passes the CTA barrier;
that second barrier is what carries visibility to the consumers. The wait covers the Q/K/V groups
needed by the next copy, not the whole tensor. Q is loaded once. The two initial K/V stages are
prefilled in source order 0 then 1; stage 0 is waited before the first score tile.</p>
<p>In steady state, tile <code>j</code> has already been waited. The loop reads its K and V into
registers, forms scores/E, reduces the denominator, and runs the FP32 PV updates. It then issues the
copy for <code>j+2</code> into slot <code>(j+2)&amp;1 = j&amp;1</code>, which is the slot just consumed,
and waits for <code>j+1</code> in the other slot. The refill is therefore a retire-then-refill
protocol, not an overwrite-ahead guess. Slot parity alone is not a readiness test; each stage has its
own barrier and each copy has its own expected byte count.</p>
{cut(cfg['path'], 'if (g_KeyTile + 2 <', 14, 0, 'Retire the current slot, refill two ahead, then wait for the next stage')}
<p>The order is deliberate: refill <code>j+2</code> before waiting for <code>j+1</code> gives the
copy a window that includes the next-stage wait, without allowing the refill to overwrite data still
being read. At the final tile there is no refill and no next-stage wait. The final normalization,
tail clear and completion-counter release happen after the loop.</p>
{figs[4]}
<h3>5.1 Construction milestones</h3>
<p>Build the entry in this order; each milestone has a falsifier and none of them requires a
performance measurement.</p>
<ol>
<li><strong>Scalar oracle.</strong> Compute <code>D</code> and <code>u</code> in FP32 from decoded
Q/K/V for tagged queries including q17/head7/c9. Falsifier: a transposed V, wrong head plane or wrong
<code>q</code> pair. This proves connectivity, not bitwise packed-E equality.</li>
<li><strong>One key tile.</strong> Check the Half QK/E path and the FP32 denominator tree against the
same terms. Falsifier: a Half tile total, an E4 denominator term, or a lost low/high lane.</li>
<li><strong>Stream all tiles.</strong> Enable 34 tiles and both ring wraps; check the FP32 carry order
and that no tile is consumed twice. Falsifier: parity-only waits or an overwrite of unread K/V.</li>
<li><strong>Numerical budget.</strong> Add the pad correction and epsilon clamp; the 16 padded keys
must add 1.34375 to each denominator and zero to the numerator. Falsifier: a Half-rounded correction.</li>
<li><strong>Ring pipeline.</strong> Replace synchronous copies with the two-ahead ring and compare
the full output. Falsifier: a stale slot, missing barrier arrival, or a final-tile wait.</li>
<li><strong>Publish and count.</strong> Add the FP32 multiply, one Half publication, optional E4
conversion, tail clear and release counter. Falsifier: an unrounded store or an early counter.</li>
<li><strong>Validation.</strong> Re-run the oracle, tail fixture, both ring wraps and the counter
dependency test before requesting a compiled-resource/NCU handoff.</li>
</ol>
{pseudo(pseudo_text, 'Source-order execution outline')}
<p>The pseudocode is an algorithmic outline, not a compiled replacement. It intentionally preserves
the source's wait/refill order and does not imply that any copy overlaps any arithmetic by a measured
amount. Warp and CTA launch order remain unspecified; the dependency counters express readiness, not
a timeline.</p>'''


def trace(cfg, ev):
    fp8 = cfg['prec'] == 'FP8'
    figs = build_all(cfg['name'], fp8)
    return f'''<p>Follow one value end to end: query 17, head 7, output channel 9, global channel
<code>7×32 + 9 = 233</code>. The CTA is <code>(7,0)</code>, warp 0, query tile 1, local row 1. Lane 4
owns the output pair; lane 17 owns the low denominator. For the key side, use key tile 0 and key 0 as
the single annotated contribution.</p>
<h3>6.1 Form the Half score and encode E</h3>
<p>The score loop runs four query tiles × eight N8 column tiles. Each column tile uses two K words
from the staged lane vector; Q is reused. The result is a Half score pair; both halves then get the
fixed affine, clamp and packed encoding. For query q17 and key k0, lane 4 owns local row 1 in query tile 1 and the low Half
of N8 key tile 0. The output channel c9 is a separate axis used later by PV. Encoded E(q17,k0) lies
in <code>[0.0040283203125, 1.640625]</code>; a zero score gives <code>0.083984375</code>. There is no
row maximum, exponential or per-row normalization here.</p>
{cut(cfg['path'], '// Form Q times K-transpose scores', 41, 0, 'Half QK score, independent Half-lane affine/clamp, packed E')}
<p>The line <code>r_Score</code> is a packed pair of Half scores, not two FP32 values. The affine and
clamp names are inherited from the native surrogate; the final shift/add is a whole-word operation
whose carry is part of the encoding. Do not replace it with <code>exp</code> or with two independent
16-bit shifts and expect the same E.</p>
<h3>6.2 Widen each probability and build the FP32 denominator</h3>
<p>The denominator block widens every packed Half term with <code>WidenHalfPairFloat2</code> before
its first addition. The local tree is a balanced four-pair sum, then a three-level FP32 combine; the
warp transpose permutes whole <code>float2</code> pairs; the final low/high pair is one FP32 add.
For lane 17 and query 17, the source lanes are 6, 7, 4, 5 and the post-permutation addition order is
4, 5, 6, 7. Each source owns 16 keys, so the 64-key tile contributes 64 terms exactly once.</p>
{cut(cfg['path'], '// Sum the current score tile', 55, 0, 'FP32 denominator tree: widen, local tree, transpose, gather, carry')}
<p>There is no Half tile total and no later widening. The running carry is
<code>r_Denominator[0] += r_QuerySums[0]</code> and <code>[1] += r_QuerySums[1]</code>, both FP32.
The two components are the low/high 32-query halves of the warp, not the halves of a packed Half word.
FP8 still reduces the original Half E; the E4 conversion is only for PV.</p>
<h3>6.3 One P×V contribution into the persistent FP32 numerator</h3>
<p>The V block reads two uint4 vectors per probability chunk; each uint4 supplies two B-fragment
pairs, one per N8 output group. For key 0 and output channel 9, the annotated contribution is
<code>P(q17,0) · V(0,9)</code>. In FP16, <code>P</code> is the Half E. In FP8, <code>P</code> is
<code>E4M3(E)</code>; <code>V(0,9)</code> comes from the transposed V panel, not a row-major dense
array. The pair of MMA calls writes <code>r_Output[1][0]</code> and <code>r_Output[1][1]</code> for
column-tile 0; c9 is the second call (<code>r_UpperValueFragment</code>) into
<code>r_Output[1][1][1]</code>. The numerator is never rounded to Half between key tiles.</p>
{cut(cfg['path'], '// Multiply the current probability tile by V', 27, 0, 'PV accumulation into persistent FP32 D registers')}
<p>The call is <code>MmaWindowFragmentF32&lt;bFp8&gt;</code>; its D operand is an array of four FP32
values with <code>+f</code> PTX constraints. This is where the two entries change accumulation format
while the P and V operand bytes stay native.</p>
<h3>6.4 Remove padded mass, clamp and invert in FP32</h3>
<p>At T=2,160 the loop has 34 key tiles and 2,176 streamed keys, so <code>PaddingKeys = 16</code>.
Those keys have zero V and E<sub>0</sub>=0.083984375. The correction is the exact Half zero-score
encoding, widened to FP32, multiplied by 16 and subtracted from both denominators. The epsilon is the
widened Half value <code>6.198883056640625e-5</code>; the clamp selects it for NaN, then
<code>ApproxRcp</code> produces the reciprocal.</p>
{cut(cfg['path'], '// Remove padded-key probability mass', 32, 0, 'FP32 padding correction, epsilon clamp and approximate reciprocal')}
<p>The correction is not rounded through Half, and the reciprocal is not a Half reciprocal. The
1.34375 mass leaves the same FP32 denominator that received the encoded terms.</p>
<h3>6.5 Normalize once and publish the exact c9 byte</h3>
<p>For query tile 1, <code>QueryRow = 17</code>; <code>r_QueryTile &lt; 2</code> selects the low
inverse, and <code>ShuffleIdx(..., 17, 31, 0xffffffff)</code> reads lane 17. Lane 4 multiplies
<code>r_Output[1][1][1]</code> by it. <code>PackFloatColumnsHalf2</code> applies
<code>__float2half_rn</code>, the single Half rounding of the normalized FP16 result. For FP8,
<code>PublishWindowChunk&lt;true&gt;</code> then applies
<code>cvt.rn.satfinite.e4m3x2.f16x2</code>: publication has two boundaries, FP32→Half then
Half→E4.</p>
{cut(cfg['path'], '// Apply row normalization in FP32', 35, 0, 'FP32 normalization, one Half pack and the final fragment store')}
<p>The output vector base for q17/head7/chunk0/lane4 is
<code>1·16384·{cfg['e']} + 7·512·{cfg['e']} + 0 + 64 = {cfg['vecbase']:,} bytes</code>. The exact c9
byte is <strong>{cfg['c9byte']:,}</strong>: FP16 puts it in word 2's high Half (byte 10), FP8 in word
0's fourth byte (byte 3) because two N8 groups merge before the E4 pack. The CPU fixture derives both
from <code>PublishWindowChunk</code>, not from channel-major order.</p>
{figs[8]}
<p>The output store is a 16-byte no-allocate vector; group/head/chunk/lane stores are disjoint, so no
atomics are needed. The tail clear then zeroes only rows
<code>g_Tokens ≤ row &lt; g_PaddedTokens</code>. A CTA barrier follows, then lane 0/warp 0 releases
the completion counters.</p>
{cut(cfg['path'], '// Native outputs include a padded last token group', 35, 0, 'Padded-row clear, CTA barrier and release counter')}
<p>The two completion stores cover the two 128-token groups of this CTA's 256-query block. The
release happens after the tail clear, so a consumer cannot observe a completion counter while a
padded row is still being zeroed. This is the publication endpoint of the forward design.</p>
{figs[7]}
<h3>6.6 What is proven by this trace, and what is not</h3>
<p>Proven from source and the CPU fixture: the q17 group/warp/tile/row map; lane 4 output owner and
lane 17 low-denominator owner; the 40,000/20,032-byte vector base; the 40,010/20,035-byte c9 scalar;
the 6/7/4/5 gather then 4/5/6/7 sum; 66 persistent words; 16,400/8,208 shared bytes; and the 34-tile
padding arithmetic. Not proven by this trace or NCU: the all-query native FP32 numerator maximum, the total runtime
share of spills, a single causal bottleneck, or a network timing. Measured eager network timing is published
separately in the <a href="cyberpunk-comparison.html">comparison chapter</a>. The isolated replay in
section 6.10 measures this launch's occupancy, duration, local traffic and bank-conflict counters;
it does not turn those counters into a full-network claim.</p>
{evidence_block(ev, cfg)}'''


def render_lesson(name, fp8, evidence=None):
    cfg = _cfg(fp8)
    if name != cfg['name']:
        raise ValueError(f'name {name!r} does not match precision configuration {cfg["name"]!r}')
    if fp8:
        title = 'FP8 Small31 global attention: persistent FP32 numerator and denominator'
        summary = ('Build the additive E4M3 global-attention entry from Half QK/E through the '
                   'FP32 P×V numerator, the FP32 row denominator, the padded-key correction and '
                   'one Half-then-E4 publication.')
    else:
        title = 'FP16 Small31 global attention: persistent FP32 numerator and denominator'
        summary = ('Build the additive Half global-attention entry from Half QK/E through the '
                   'FP32 P×V numerator, the FP32 row denominator, the padded-key correction and '
                   'one Half publication.')
    ev = evidence if evidence is not None else EVIDENCE_PENDING
    body = six_parts(
        problem(cfg), cta(cfg), warp(cfg), resources(cfg), schedule(cfg), trace(cfg, ev))
    return dict(name=name, title=title, summary=summary, family=FAMILY, body=body)


def _select_evidence(evidence, name):
    """Select one entry's record from an index or a name-keyed mapping.

    A bare record is accepted only for ``render_lesson``; ``build_lessons`` must
    never forward the same object to both precisions by accident.
    """
    if evidence is None:
        return None
    if isinstance(evidence, dict):
        if isinstance(evidence.get('kernels'), dict):
            return evidence['kernels'].get(name)
        if isinstance(evidence.get(name), dict):
            return evidence[name]
    return evidence


def build_lessons(inventory, evidence=None):
    """Return exactly the two Small31 attention lesson dictionaries.

    ``inventory`` is the existing kernel-docs inventory.  This module does not
    construct a new inventory or edit an existing one; it only requires the two
    public names to be present.  ``evidence`` may be the whole
    ``evidence-small/index.json`` or a name-keyed mapping; each lesson receives
    its own explicit record.
    """
    entries = inventory.get('entries', inventory)
    missing = [name for name in SMALL_NAMES if name not in entries]
    if missing:
        raise ValueError('Missing Small31 attention public entries: ' + ', '.join(missing))
    return [render_lesson(FP16_NAME, False, _select_evidence(evidence, FP16_NAME)),
            render_lesson(FP8_NAME, True, _select_evidence(evidence, FP8_NAME))]
