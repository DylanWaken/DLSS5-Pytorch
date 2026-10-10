"""Repeated *local* prerequisites for independently readable kernel lessons."""
from html import escape
from common import svg


def pseudo(text, caption='Teaching pseudocode'):
    return ('<figure class="pseudocode"><figcaption>' + escape(caption) +
            ' — an algorithmic outline, not a compiled replacement</figcaption><pre><code>' +
            escape(text.strip()) + '</code></pre></figure>')


def storage_legend():
    return '''<p>A <strong>global allocation</strong> is device memory addressed by a pointer; loads can be served by hardware-managed L2 and, depending on the instruction, L1. A cache hit is not another program-visible tensor and the source does not guarantee cache residency. <code>__ldca</code> permits caching at all levels; <code>__ldcg</code> and PTX <code>.cg</code> select global-level caching that bypasses L1. An eviction or <code>no_allocate</code> hint is a performance policy, not a publication barrier.</p><p><strong>Shared memory</strong> is an explicitly indexed block-local allocation. Another warp may read a producer's values only after the required block barrier or completed asynchronous-copy protocol. A warp shuffle exchanges <strong>register</strong> values among its active lanes; it does not address shared memory. Arrays named <code>r_…</code> express per-thread values, but only compiler output establishes whether they stay in physical registers or spill to local memory. Tensor-core accumulator fragments are also register operands. These kernels use <code>mma.sync</code>, not TMEM.</p>'''


def mma_primer(fp8):
    k, lanes, scalar, instr = (32, 4, 'E4M3 bytes', 'mma.sync.aligned.m16n8k32.row.col.f16.e4m3.e4m3.f16') if fp8 else (16, 2, 'Half values', 'mma.sync.aligned.m16n8k16.row.col.f16.f16.f16.f16')
    a = '4q + 16⌊i/2⌋ + b, b = 0…3' if fp8 else '2q + 8⌊i/2⌋ + h, h = 0…1'
    b = '4q + 16j + b, b = 0…3' if fp8 else '2q + 8j + h, h = 0…1'
    body = f'''<p>One instruction computes a <strong>16-token × 8-output-channel</strong> tile with a reduction of <strong>{k}</strong> channels. All 32 lanes participate in the same matrix operation. Each lane supplies four 32-bit A words, two 32-bit B words, and two 32-bit C words. Each C word contains two Half accumulators, so a lane owns four output elements. A source loop over output groups or reduction panels repeats this operation; it does not launch a new warp.</p><p>The exact instruction on this path is <code>{instr}</code>. Both the accumulator input and output are <strong>Half</strong>. Do not replace its numerical contract with FP32 accumulation when constructing an exact oracle. For the FP8 path, packing to E4M3 is a distinct rounding step; for the FP16 path a packed word simply holds two Half values.</p><p>Let lane <code>L</code> run from 0 to 31, <code>g = L // 4</code> and <code>q = L % 4</code>. The matrix coordinates below describe instruction operands <em>after</em> any kernel-specific loads and shuffles. Storage layouts are designed to supply these coordinates cheaply.</p>
<div class="table-scroll"><table><thead><tr><th>Per-lane operand</th><th>Logical matrix coordinates</th></tr></thead><tbody>
<tr><td>A word i = 0…3</td><td>token row g + 8(i % 2); reduction channels {a}</td></tr>
<tr><td>B word j = 0…1</td><td>output column g; reduction channels {b}</td></tr>
<tr><td>C / D word 0</td><td>token g, output columns 2q and 2q + 1</td></tr>
<tr><td>C / D word 1</td><td>token g + 8, output columns 2q and 2q + 1</td></tr>
</tbody></table></div>'''
    fragment_anchor = 'warp-level-matrix-fragment-mma-16832' if fp8 else 'warp-level-matrix-fragment-mma-16816-float'
    body += f'<p>The operand and accumulator coordinates follow the <a href="https://docs.nvidia.com/cuda/parallel-thread-execution/#{fragment_anchor}">NVIDIA PTX matrix-fragment specification</a>. A kernel may permute model channels before supplying these instruction coordinates; its publication and weight-packing rules must agree.</p>'
    body += svg(f'{"FP8" if fp8 else "FP16"} matrix instruction ownership', '0 0 920 285', f'''
<rect class="tensor" x="15" y="35" width="245" height="155" rx="8"/><text class="label" x="32" y="64">A: 16 × {k}</text><text class="small" x="32" y="94">4 packed words per lane</text><text class="small" x="32" y="120">{lanes} {scalar} per word</text><text class="small" x="32" y="150">two token rows per lane</text>
<path class="edge" d="M265 112 H318"/><rect class="compute" x="325" y="55" width="225" height="125" rx="8"/><text class="label" x="343" y="85">32 lanes: D = A B + C</text><text class="small" x="343" y="115">B: {k} × 8</text><text class="small" x="343" y="141">2 B words per lane</text>
<path class="edge" d="M555 112 H610"/><rect class="storage" x="620" y="35" width="280" height="155" rx="8"/><text class="label" x="636" y="64">D: 16 × 8 Half</text><text class="small" x="636" y="96">lane 13: g = 3, q = 1</text><text class="small" x="636" y="124">word 0: D[3,2], D[3,3]</text><text class="small" x="636" y="152">word 1: D[11,2], D[11,3]</text>
<text class="small" x="20" y="227">For output group n, add 8n to the two output-channel coordinates.</text>
<text class="small" x="20" y="255">The whole warp owns 32 × 4 = 128 outputs: exactly the 16 × 8 tile.</text>''', 'Instruction fragment map. Lane 13 is one example; the map covers every token and channel exactly once.')
    from token_visuals import mma_cells
    return body + mma_cells(fp8)
