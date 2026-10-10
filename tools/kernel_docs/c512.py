"""Source-grounded tutorials for the C512 stage and its two C1024 connectors."""
from html import escape
from common import code, svg, note

F = 'csrc/kernel_impl/shared_encoder_decoder_c512_ffn/'
P = 'csrc/kernel_impl/shared_encoder_decoder_c512_attention_ffn_projection/'
A = 'csrc/kernel_impl/shared_encoder_decoder_c512_attention/'
D = 'csrc/kernel_impl/encoder_c512_downsample/'
U = 'csrc/kernel_impl/decoder_c1024_to_c512_upsample/'
S = 'csrc/kernel_impl/shared/common/'


def box(x, y, w, h, lines, kind='tensor'):
    colors = {'tensor': ('#e7f4f2', '#258478'), 'compute': ('#ebefff', '#626fbc'),
              'storage': ('#fff2dc', '#ac7821'), 'accent': ('#fcebea', '#b56b63')}
    fill, stroke = colors[kind]
    ts = ''.join(f'<tspan x="{x+w/2}" dy="{0 if i == 0 else 23}">{escape(t)}</tspan>'
                 for i, t in enumerate(lines))
    return (f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="9" fill="{fill}" stroke="{stroke}" stroke-width="1.5"/>'
            f'<text x="{x+w/2}" y="{y+h/2-(len(lines)-1)*11+5}" text-anchor="middle" font-size="16" fill="#182b3f">{ts}</text>')


def arr(x1, y1, x2, y2, text='', color='#53697a'):
    # All arrows are horizontal or vertical, so their explicit heads need no SVG ids.
    if x2 == x1:
        sign = 1 if y2 > y1 else -1
        head = f'{x2-5},{y2-sign*9} {x2},{y2} {x2+5},{y2-sign*9}'
    else:
        sign = 1 if x2 > x1 else -1
        head = f'{x2-sign*9},{y2-5} {x2},{y2} {x2-sign*9},{y2+5}'
    label = f'<text x="{(x1+x2)/2}" y="{(y1+y2)/2-10}" text-anchor="middle" font-size="14" fill="{color}">{escape(text)}</text>' if text else ''
    return f'<path d="M{x1},{y1} L{x2},{y2}" stroke="{color}" stroke-width="2" fill="none"/><polyline points="{head}" fill="none" stroke="{color}" stroke-width="2"/>{label}'


def label(x, y, text, size=16):
    return f'<text x="{x}" y="{y}" font-size="{size}" fill="#263c50">{escape(text)}</text>'


ffn_arch = svg('The C512 grouped FFN and its two deployment launches', '0 0 1020 395',
    box(15, 25, 150, 75, ['One position X', '512 channels']) +
    arr(165, 62, 225, 62) + box(225, 25, 175, 75, ['Dense premix', '512 → 512'], 'compute') +
    arr(400, 62, 460, 62) + box(460, 15, 250, 95, ['Split 8 distinct groups', 'u[g] = u[64g : 64g+64]', '64 channels per group']) +
    arr(710, 62, 765, 62) + box(765, 15, 235, 95, ['All 8 groups execute', '64 → 256 → φ → 64', 'register hidden panels'], 'compute') +
    arr(882, 110, 882, 170) + box(765, 170, 235, 75, ['Concatenate group outputs', '512 channels in global'], 'storage') +
    arr(765, 207, 710, 207) + box(460, 170, 250, 75, ['Dense postmix + residual', 'Z = mix(B) + scale ⊙ X'], 'compute') +
    arr(460, 207, 400, 207) + box(225, 170, 175, 75, ['Published Z', 'QKV input']) +
    label(22, 296, 'Launch 1: premix + all grouped expand/activate/contract work. Launch 2: postmix + residual.') +
    label(22, 325, 'C64–C256 differ: every branch sees the whole original C-vector; C512 branches see premixed slices.') +
    label(22, 354, 'No routing, top-k choice, neighboring-pixel read, LayerNorm or RMSNorm appears in this FFN.'),
    'Logical architecture from ARCHITECTURE.md; the global branch-output boundary is established by C512BlockOutEntry.')

ffn_owners = svg('CTA, warp and lane ownership in the C512 FFN', '0 0 1020 450',
    label(20, 28, 'One CTA: one 8 × 8 region × four groups. grid.z = 0 or 1 selects groups 0–3 or 4–7.') +
    box(20, 58, 310, 150, ['FP16: 4 warps', 'warp w owns group w + 4z', '4 M16 tiles = 64 positions', '64 output channels per position'], 'compute') +
    box(355, 58, 310, 150, ['FP8 ordinary: 8 warps', 'group = (w % 4) + 4z', 'w / 4 chooses top/bottom', '2 M16 tiles = 32 positions'], 'compute') +
    box(690, 58, 310, 150, ['FP8 input-view: 4 warps', 'group = w + 4z', '4 M16 tiles = 64 positions', 'same math, different loading'], 'compute') +
    box(20, 240, 470, 120, ['Within one N16 accumulator group n', 'r_Words[0,1]: channels 16n + 2(lane%4) + {0,1}', 'r_Words[2,3]: the same channel pair + 8', 'word parity chooses top/bottom 8 fragment rows'], 'storage') +
    box(520, 240, 480, 120, ['Example lane 13, N16 group 2', 'channel pairs {34,35} and {42,43}', 'physical x = (13/4)%4 = 3', 'physical y = floor(13/16) + 2·rowHalf = 0 or 2']) +
    label(20, 402, 'A 16-position fragment represents a physical 4 × 4 tile; its packed row order is not linear BHWC.') +
    label(20, 430, 'MMA output is four Half2 words per lane per N16 group in both FP16 and FP8 paths.'),
    'The position and channel formulas agree with SpatialProjectionPlaneWordAddress and its callers. Integer divisions are truncating divisions.')

ffn_pipe = svg('Two-stage input pipeline and explicit storage hierarchy', '0 0 1020 435',
    box(20, 45, 205, 100, ['Global X', '4 × 4 × 512 tile', '16,384 B Half / 8,192 B E4'], 'storage') +
    arr(225, 94, 305, 94, 'async') + box(305, 30, 295, 140, ['CTA shared: 8,208 bytes', 'stage 0: [0, 4096)', 'stage 1: [4096, 8192)', 'barriers: 8192 and 8200'], 'storage') +
    arr(600, 94, 675, 94) + box(675, 45, 325, 100, ['Lane registers → tensor-core MMA', 'A: uint4 per K subtile', 'C/D: packed Half accumulators'], 'compute') +
    box(675, 220, 325, 75, ['Global packed W → cache → registers', '__ldca; 16 bytes per lane'], 'storage') +
    arr(838, 220, 838, 145) +
    label(20, 221, 'Prologue: load W0, issue X0, arrive/wait stage 0.') +
    label(20, 253, 'Iteration t: issue X[t+1] → compute MMA[t].') +
    label(20, 285, 'Then load W[t+1] → wait stage (t+1)%2.') +
    label(20, 337, 'One stage: 4 spatial tiles × 2 K subtiles × 512 B = 4 KiB.') +
    label(20, 366, 'Half: 2 × K16 = K32, 16 iterations. E4: 2 × K32 = K64, 8 iterations.') +
    label(20, 395, 'Shared staging reuses input across output-group warps; weights are loaded directly into registers.'),
    'Global names are address spaces, not a promise that every access reaches DRAM. Cache hits and physical register spills require measurement.')

ffn_hidden = svg('Stream 32 hidden channels through registers, eight times', '0 0 1020 350',
    box(20, 35, 205, 100, ['Register premix slice u[g]', '16 positions × 64 channels', 'Half accumulator format'], 'storage') +
    arr(225, 84, 280, 84) + box(280, 35, 210, 100, ['Expand panel h', '64 → 32 hidden channels', 'h = 0…7'], 'compute') +
    arr(490, 84, 545, 84) + box(545, 35, 195, 100, ['Packed Half activation', 'clamp / abs / FMA / mul', 'E4 publish if FP8'], 'compute') +
    arr(740, 84, 795, 84) + box(795, 35, 205, 100, ['Contract this panel', '32 → 64', 'accumulate output'], 'compute') +
    box(280, 205, 460, 80, ['Only current hidden panel is live', 'r_Hidden[spatial][2 N16][4 words] per lane'], 'storage') +
    arr(630, 135, 630, 205) +
    label(20, 321, 'Hidden [64 positions, 8 groups, 256] never becomes a full shared-memory or global-memory tensor.'),
    'The accumulator variables are C++ register-oriented arrays with unrolled fragment axes. Actual allocation is a compiler resource property.')

ffn_publish = svg('FP16 and E4 publication rearrange the same Half accumulator', '0 0 1020 390',
    box(20, 45, 265, 120, ['One lane, one N16 group', 'w0: low N8, row half 0', 'w1: low N8, row half 1', 'w2 / w3: upper N8'], 'storage') +
    arr(285, 93, 360, 93) + box(360, 40, 280, 125, ['FP16 A-fragment / store', 'uint4(w0, w1, w2, w3)', '4 × 32 bits = 8 Half values', 'one 512 B stripe per N16']) +
    arr(155, 165, 155, 225) + box(20, 225, 265, 105, ['FP8 consumes two N16 groups', 'E4 pack(w0,w2), pack(w1,w3)', 'repeat for next N16 group', '16 E4 values per lane']) +
    arr(285, 277, 360, 277) + box(360, 225, 280, 105, ['FP8 A-fragment / store', '32 channels in 512 B/warp', 'K32 operand consumes twice', 'the channels of K16 Half']) +
    box(700, 90, 300, 195, ['Quantization boundaries', 'after premix before expand', 'after activation before contract', 'after contracted group output', 'after postmix + residual', 'all intentional in the FP8 path'], 'accent'),
    'PackHalfPairsE4 converts two Half2 words to four E4M3 bytes. No per-tensor scale metadata is used by these calls.')

ffn_views = svg('The block-23 view path gathers channel planes into the native tile layout', '0 0 1020 390',
    box(20, 35, 310, 125, ['Global channel-plane view', '[panel, y, x, 16 bytes]', 'FP16 panel: 8 channels', 'FP8 panel: 16 channels'], 'storage') +
    arr(330, 96, 405, 96, '4 B') + box(405, 35, 265, 125, ['cp.async.ca gather', '128 threads × 8 words', '1,024 × 4 B = 4 KiB', 'destination = stage + 4j'], 'compute') +
    arr(670, 96, 740, 96) + box(740, 35, 260, 125, ['Native shared tile', '4 spatial tiles × 2 K panels', 'then ordinary grouped FFN', '4 warps in both precisions'], 'storage') +
    box(20, 235, 440, 100, ['Residual for postmix still uses the plane view', 'projection_input_view reads residual by pixel', 'and writes native tiled Z for QKV'], 'compute') +
    box(520, 235, 480, 100, ['Example: j=13, reduction tile=0, CTA origin=(0,0)', 'y=2, x=0, channelPack=0, component=3', 'global byte offset = ((0·H+2)·W+0)·16 + 12'], 'tensor'),
    'A view entry fuses a physical layout change into useful work. It is not a no-op reshape or a separate transposition allocation.')


ffn_body = f'''
<h2 id="c512-ffn-model">Target architecture: premix, eight grouped MLPs, postmix</h2>
<p>Records <strong>23–30 and 40–47</strong> are the C512 encoder and decoder blocks. At the 3840 × 2160 input geometry, each sees a logical field <strong>[68, 120, 512]</strong> (batch omitted), or 8,160 position vectors. This chapter implements the first half of each ordinary block: the FFN and its learned residual. Read the <a href="architecture.html#grouped-ffn-c512">architecture’s grouped FFN</a> beside this tutorial. Spatial size does not change inside this operation. A single position can be understood independently of every other position.</p>
<p>Using row vectors for the mathematical description, let <code>u = X Wpre</code>, let <code>u[g] = u[64g:64g+64]</code>, and let <code>b[g] = φ(u[g] Wexpand[g]) Wcontract[g]</code> for <code>g=0…7</code>. The result is <code>Z = publish(concat(b[0],…,b[7]) Wpost + scale_ffn ⊙ X)</code>. Shapes are Wpre and Wpost [512,512], each Wexpand [64,256], and each Wcontract [256,64]. The formula describes connectivity; actual packed arithmetic and publication boundaries follow the source below.</p>
{ffn_arch}
<p>Eight <code>expert</code> groups in the CUDA variable names are eight always-executed channel slices. They have no router. The C64/C128/C256 family instead sends the complete input to every branch. At C512, the initial dense premix lets information from all 512 original channels reach each 64-channel slice, but the expansion itself reads only that slice. The postmix supplies a second all-group communication step.</p>
<p>The implementation deliberately splits this graph between two launches. <code>window_ffn_c512_*</code> performs premix and grouped expansion/activation/contraction, writes a 512-channel branch tensor, and <code>window_ffn_projection_c512_*</code> performs postmix and the FFN residual. Block 23 substitutes the two input-view variants because its incoming state has channel-plane storage. The mathematical FFN is unchanged.</p>
{code('csrc/kernel_launcher/c512_dispatch.inl', 430, 438, 'Which model records use the C512 family and its boundary variants')}
{code('csrc/kernel_launcher/c512_dispatch.inl', 461, 465, 'The FFN launches and their explicit workspace/residual roles')}

<h2 id="c512-ffn-own">Step 1 — give a CTA four groups and an 8 × 8 spatial region</h2>
<p>The grid’s X/Y coordinates select a pair of native 4 × 4 tiles in each direction. Grid Z selects groups 0–3 or 4–7. A group owns 64 output channels. An ordinary FP16 CTA has four warps; each warp computes its group over all four 16-position fragments. Ordinary FP8 uses eight warps: warps 0–3 handle the upper two fragments and warps 4–7 handle the lower two. The warp’s group remains <code>(warp % 4) + 4·blockIdx.z</code>. FP8 input-view returns to four warps and four fragments per warp.</p>
{ffn_owners}
{code(F+'common/window_ffn.cuh', 11, 20, 'The precision and input-view profile controls ownership, K blocking and tile size')}
<p>These choices trade per-thread live state against the number of warps sharing a CTA. FP16 ordinary FFN declares <code>__maxnreg__(255)</code>; FP8 ordinary declares 128. Those are compiler limits, not measured allocations or a guarantee of no spills. The source-level projected/output accumulator contains <code>SpatialFragments × 4 × 4</code> 32-bit words per lane: 64 words for four fragments, 32 for two. Keeping the FP8 ordinary spatial footprint smaller is consistent with its lower register limit. That is an optimization rationale inferred from the code, not an independently timed comparison.</p>
<p>One lane does not own one whole pixel. Four adjacent lanes collectively cover one fragment row’s channel pairs. For channel group n, words 0 and 1 represent the lower N8 result at two row halves; words 2 and 3 represent the upper N8. The physical x coordinate is <code>(lane/4)%4</code>, and the two y coordinates are <code>lane/16</code> and that value plus 2. This mapping is why raw <code>uint4</code> loads can already have the order expected by MMA; a BHWC interpretation of the same bytes would scramble positions and channels.</p>

<h2 id="c512-ffn-stage">Step 2 — stage the premix input, while weights enter registers directly</h2>
<p>Let e be bytes per stored element (2 for FP16, 1 for E4), q the linear index of a native 4 × 4 spatial tile, and t the reduction iteration. Its base is <code>X + q·8192·e</code>. The input stripe address is that base plus <code>(2t+k)·512</code>, for K subtile k=0 or 1. Across 32 lanes a stripe contains 512 bytes: 16 positions × 16 Half channels, or 16 positions × 32 E4 channels. A stage contains four spatial tiles and two stripes per tile, hence exactly 4,096 bytes in either precision.</p>
{ffn_pipe}
<p>The shared allocation is two 4 KiB stages plus two 8-byte barriers. For a valid source tile, <code>CopyBulk</code> transfers 512 bytes and associates completion with the matching barrier. On SM90+ the shared helper emits a bulk copy; on earlier supported targets each participating lane copies its adjacent 16 bytes with <code>cp.async</code>. This distinction lives below the stage algorithm. A one-tile spatial dimension is broadcast by the address resolver; an incomplete larger edge writes zeros. Output clipping later prevents those synthetic tiles becoming published image positions.</p>
<p>The source loads weights using <code>__ldca</code> straight into <code>uint4 r_Weights[2][4]</code>. For group g, lane l, N16 panel n and instruction-K subtile k, the premix address is <code>W + t·ReductionStep·512·e + g·2048 + l·16 + k·16384 + n·512</code>. The 16 KiB K-stride is identical in bytes because 16 Half inputs and 32 E4 inputs both occupy 32 bytes per output column. Packed weight coordinates are not conventional row-major matrix coordinates.</p>
{code(F+'fp16/window_ffn_c512_fp16.cu', 33, 45, 'Premix weight address: one 16-byte vector per lane')}
{code(F+'fp8/window_ffn_c512_fp8.cu', 101, 127, 'Issue the next shared stage before consuming the current one')}
<p>The loop overlaps next input transfer with current MMA work, then prefetches the next weights and waits for the next stage. The last iteration does neither an unnecessary refill nor a wait. Half has sixteen K32 iterations, each internally two K16 operations; E4 has eight K64 iterations, each internally two K32 operations. The order within every accumulator is preserved. Calling these operations “FP8 kernels” does not mean their accumulators are FP8: the exact wrappers use <code>m16n8k32…f16.e4m3.e4m3.f16</code>; the Half counterpart uses <code>m16n8k16…f16.f16.f16.f16</code>.</p>

<h2 id="c512-ffn-hidden">Step 3 — keep the premix and each hidden panel in registers</h2>
<p>After the dense reduction, each warp already holds its 64 premixed channels. The kernel does not publish the entire premix image to global memory. It initializes the contracted output to zero, then iterates over eight 32-channel hidden panels. Each panel expands 64 inputs to 32 hidden outputs, applies the recovered activation, and immediately contracts those 32 hidden values into the same 64-channel output accumulators. Only after all eight panels have contributed is the grouped result stored.</p>
{ffn_hidden}
<p>The first packed record contains 262,144 premix elements, then 131,072 expansion elements, then 131,072 contraction elements: 524,288 elements total. Group g’s expansion starts at <code>W + (262144 + g·16384)·e</code>; its contraction starts at <code>W + (393216 + g·16384)·e</code>. The 16-byte lane displacement is added afterward. For group 5 in E4, expansion starts 344,064 bytes into the record and contraction 475,136 bytes into it; in Half both element-derived offsets double. A hidden panel’s contraction offset advances 4,096 bytes in Half but 2,048 bytes in E4.</p>
{code(F+'fp16/window_ffn_c512_fp16.cu', 130, 163, 'Packed grouped matrices and the first half of the streamed expansion')}
<p>Half expansion reduces four K16 subtiles, arranged as two K pairs. FP8 expansion reduces two K32 subtiles. The FP8 helper intentionally issues one K32 across the M/N tiles before moving to the next K32; the dense premix and Half grouped operations use the common two-K schedule. This is a source-preserved scheduling choice. It is not interchangeable with changing the reduction order under a Half accumulator contract.</p>
<p>The activation is the recovered clamped polynomial, not a library SiLU call. It works on packed Half pairs using the constants from the numerical foundation chapter. In FP8, the premix slice is converted to E4 as it becomes an expansion operand; each activated hidden panel is converted to E4 as it becomes a contraction operand. These conversions happen in registers. Eliminating a global intermediate does not eliminate its required quantization boundary.</p>
{code(F+'fp8/window_ffn_c512_fp8.cu', 141, 179, 'FP8 hidden panel lifetime: expand → packed activation → E4 operand → contract')}
{ffn_publish}
{code(F+'common/window_ffn.cuh', 29, 49, 'Half accumulator words become the next matrix operand without a shared-memory transpose')}
<p>For one 16-position tile, the full logical [8,256] hidden output would contain 32,768 values across its groups. Streaming panels avoids materializing that tensor. The source retains only the current panel and the accumulating contracted output in each group warp. This reduces memory traffic by construction; the resulting performance depends on register allocation, occupancy, input/weight reuse and instruction throughput on the actual GPU.</p>

<h2 id="c512-ffn-postmix">Step 4 — publish branches, then mix all groups and seed the residual</h2>
<p>For native tile q, group g and lane l, contracted publication begins at <code>B + q·8192·e + g·1024·e + l·16</code>. Half writes four 512-byte N16 stripes; E4 packs adjacent N16 accumulator groups and writes two stripes. This gives the next launch a complete 512-channel tiled tensor. The residual remains the original input X, so the postmix launch receives B and X as distinct pointers.</p>
<p>The reusable <code>spatial_projection_*</code> template implements both the FFN postmix and the attention postmix. Its FFN instantiation has four spatial fragments per warp and four warps; its ordinary attention instantiation has two fragments per warp and eight warps. Both cover an 8 × 8 region and 256 output channels per CTA, with a second channel slab covering the other 256. Each has three 4 KiB stages and three barriers, totaling 12,312 bytes of shared storage. It initially issues stages 0, 1 and 2, then consumes in K order and recycles each slot only after the intervening barrier protocol.</p>
{code(P+'fp16/spatial_projection_fp16.cu', 101, 146, 'The residual is multiplied in Half and placed in the accumulator before the matrix reduction')}
<p>The packed projection record is a 512 × 512 matrix followed by 512 Half residual scales. Even FP8 stores the scales in Half. Their byte offset is <code>MatrixBytes + 2·channel</code>. The kernel starts C with <code>HalfMul(residual, scale)</code> and accumulates the matrix product into it. Algebraically this is projection plus residual, but numerically it establishes a different sequence from finishing a zero-seeded matrix product and then adding the residual. A replacement implementation must preserve the intended order, not just the equation.</p>
<p>The matrix and branch input use the same packed 512-byte stripes and two-instruction K scheme as the premix. The residual uses <code>__ldcg</code> loads; FP8 residual bytes are decoded to Half pairs before scaling. Final native publication uses the same Half-direct or E4-pack path shown above. There is no separate residual-add launch, no postmix activation, and no FFN normalization operation.</p>

<h2 id="c512-ffn-view">Step 5 — fuse the block-23 storage conversion into its input and residual reads</h2>
{ffn_views}
<p>A channel-plane state stores one 16-byte pixel packet at <code>((panel·H+y)·W+x)·16</code>. Each packet is eight Half or sixteen E4 channels. The input-view kernel assigns a word index <code>j = warp·32 + lane + copyIndex·128</code>, with copyIndex 0…7. Bitfield-like integer expressions extract destination spatial location, source panel and four-byte component. For example, j=13 at reduction tile zero maps to y=2, x=0, panel zero, component three, and writes shared byte offset 52. The same byte path represents a different number of channel values in Half and E4.</p>
{code(F+'fp8/window_ffn_input_view_c512_fp8.cu', 53, 83, 'Exact view gather and its cp.async group completion protocol')}
<p>The four-byte transfers use <code>cp.async.ca.shared.global</code>. Every thread commits its group, waits until its outstanding group completes, then joins the CTA’s stage barrier so consumers can safely read other threads’ contributions. There is no independent transpose kernel. The grouped arithmetic and tiled branch publication then follow the ordinary algorithm.</p>
<p>Block 23’s <code>window_ffn_projection_input_view_*</code> name refers to the residual input view: the branch input is already tiled. This variant derives each residual pixel address from lane coordinates, reads the correct channel-plane word, seeds the accumulator and writes native tiled Z. That distinction prevents a common misreading: it does not gather the branch tensor from planes. At the other end of C512, block 47’s attention projection performs the reverse publication into planes, described next.</p>
{code(P+'common/spatial_projection.cuh', 36, 51, 'The channel-plane address shared by view projection entries')}
{note('Read optimization claims at two levels: fusion, reduced materialization, reuse and instruction ordering are visible in the source; speedups, cache hit rates, occupancy and absence of local-memory spills require measured evidence. The declarations and array sizes here describe the source snapshot, not an Nsight profile.')}
'''

attn_arch = svg('C512 window attention and the two resolution connectors', '0 0 1020 440',
    box(20, 35, 150, 80, ['Published Z', 'H × W × 512']) + arr(170, 75, 220, 75) +
    box(220, 25, 220, 100, ['QKV 512 → 1536', '16 heads × 32 channels', 'normalize Q and K'], 'compute') +
    arr(440, 75, 495, 75) + box(495, 25, 235, 100, ['One 8 × 8 window/head', 'QKᵀ + learned bias', '64 × 64 Half scores'], 'compute') +
    arr(730, 75, 785, 75) + box(785, 25, 215, 100, ['E(scores) / row sum', 'multiply V[64,32]', 'publish attended A'], 'compute') +
    arr(894, 125, 894, 190) + box(615, 190, 385, 85, ['Mix heads: A Wout + scale_attn ⊙ Z', 'Publish C512 output; save skip at record 30'], 'compute') +
    arr(615, 232, 560, 232) + box(20, 190, 540, 85, ['Record 30: raw result → 2 × 2 pool → 512 → 1024', 'At 4K: [68,120,512] → [36,60,512] → [36,60,1024]'], 'tensor') +
    box(20, 325, 980, 85, ['Record 39: [36,60,1024] → pointwise 1024 → 512 → repeat 2 × 2 → crop [68,120,512]', 'Then add scaled record-30 skip and publish. Record 39 has no ordinary FFN or attention.'], 'tensor'),
    'The main line is records 23–30 and 40–47; the last two lines are the bottleneck entry and exit connectors.')

attn_window = svg('A shifted window is four native 4 × 4 tiles and four heads per CTA', '0 0 1020 375',
    box(20, 40, 210, 95, ['q0: upper left', '16 query positions', 'native tile [ty,tx]']) +
    box(250, 40, 210, 95, ['q1: upper right', '16 query positions', 'native tile [ty,tx+1]']) +
    box(20, 155, 210, 95, ['q2: lower left', '16 query positions', 'native tile [ty+1,tx]']) +
    box(250, 155, 210, 95, ['q3: lower right', '16 query positions', 'native tile [ty+1,tx+1]']) +
    box(520, 40, 480, 100, ['warp w owns head h = 4·blockIdx.z + w', 'one warp retains Q/K/V for all four tiles', 'every query reads 64 keys in this window'], 'compute') +
    box(520, 170, 480, 110, ['Origin phase: (0,0), (−4,−4), (−4,0), (0,−4)', 'ty = (8·blockIdx.y + OriginY)/4', 'tx = (8·blockIdx.x + OriginX)/4', 'zero input tiles outside the field; no cyclic wrap'], 'storage') +
    label(20, 325, 'At 4K phase 1: first CTA covers physical y,x = −4…3. Only its lower-right native tile is valid.') +
    label(20, 353, 'All 64 attention slots still participate; publication discards out-of-field query tiles.'),
    'This is positive padding and cropping. It is not a roll operation or a masked standard Swin attention kernel.')

attn_storage = svg('QKV data movement: shared inputs, register outputs, global bias', '0 0 1020 420',
    box(20, 35, 250, 100, ['Global tiled Z', '4 native tiles × 512 channels', '1 stripe = 512 bytes'], 'storage') +
    arr(270, 85, 330, 85) + box(330, 25, 330, 120, ['Two shared input stages', 'FP16: 2 × 2048 + 16 = 4112 B', 'FP8: 2 × 4096 + 16 = 8208 B', 'barriers count 128 threads'], 'storage') +
    arr(660, 85, 720, 85) + box(720, 25, 280, 120, ['MMA per head warp', '4 M16 × 6 N16 panels', 'Q0,Q1,K0,K1,V0,V1', 'Half output words'], 'compute') +
    box(20, 205, 300, 120, ['Global weight record', 'matrix: 3·512·512·e bytes', 'bias: 16·8192 bytes (Half)', 'scales: 16·4 bytes (float bits)'], 'storage') +
    arr(320, 265, 400, 265) + box(400, 205, 300, 120, ['Cache → lane registers', 'QKV W: __ldca uint4', 'bias: __ldca uint4', 'head scale → Half2'], 'storage') +
    arr(700, 265, 760, 265) + box(760, 205, 240, 120, ['Normalize + attention', 'entirely warp-local', 'Q/K/V are not global', 'score panels are not global'], 'compute') +
    label(20, 382, 'Only attended [H,W,512] is published to global memory before the separate output projection.'),
    'Per warp, r_Projected contains 4×6×4 words per lane. The compiler may shorten live ranges after conversion; source arrays are not measured register counts.')

attn_norm = svg('One token’s 32-channel normalization stays within four lanes', '0 0 1020 375',
    box(20, 35, 225, 105, ['lane group base + 0', 'channels 0,1; 8,9', '16,17; 24,25']) +
    box(270, 35, 225, 105, ['lane group base + 1', 'channels 2,3; 10,11', '18,19; 26,27']) +
    box(520, 35, 225, 105, ['lane group base + 2', 'channels 4,5; 12,13', '20,21; 28,29']) +
    box(770, 35, 225, 105, ['lane group base + 3', 'channels 6,7; 14,15', '22,23; 30,31']) +
    box(20, 205, 310, 115, ['Packed squares and Half FMA', 'sum in each lane', 'XOR 2 then XOR 1 shuffles', 'swap/add Half components'], 'compute') +
    arr(330, 263, 390, 263) + box(390, 205, 265, 115, ['Scalar norm replicated', 'clamp squared norm', 'FP32 approximate rsqrt', 'round inverse to Half2'], 'compute') +
    arr(655, 263, 715, 263) + box(715, 205, 280, 115, ['Multiply Q or K by inverse', 'Q also receives head scale', 'then publish operand', 'V bypasses normalization'], 'compute'),
    'Channel numbers are local to one 32-channel head. The four lanes share a token row; no neighboring token participates in this normalization.')

attn_scores = svg('Attention streams query panels, with a paired FP8 denominator schedule', '0 0 1020 480',
    box(20, 30, 230, 100, ['Query panel Q[q]', '16 query rows × 32', 'FP16 two K16 chunks', 'FP8 one K32 chunk']) +
    arr(250, 80, 310, 80) + box(310, 20, 330, 120, ['Q × all Kᵀ + bias', '16 × 64 scores in Half', '8 N8 columns × 2 Half2 words', 'per lane: 64 bytes of scores'], 'compute') +
    arr(640, 80, 705, 80) + box(705, 20, 295, 120, ['Clamped affine + bit shift', 'normalize all 64 keys', 'publish probability operand', 'P × V → 16 × 32 output'], 'compute') +
    label(20, 192, 'FP16: q0 → q1 → q2 → q3, each with its own SoftmaxWindow.') +
    box(20, 225, 270, 145, ['FP8 pair: q0+q1, then q2+q3', '2 × 16 query rows', '4 row-half partial vectors', 'each MMA token uses 4 lanes', 'sums initially distributed'], 'storage') +
    arr(290, 298, 350, 298) + box(350, 225, 310, 145, ['Transpose row ownership', 'src = ((lane & 7) << 2)', '      | (lane >> 3)', '4 shuffles + permutations', 'lane L gets logical row L'], 'compute') +
    arr(660, 298, 720, 298) + box(720, 225, 280, 145, ['32 lanes → 32 inverses', 'add contributors 0,1,2,3', 'round reciprocal to Half', 'shuffle inverse back', 'to each row’s 4 MMA lanes'], 'compute') +
    label(20, 425, 'The paired path removes duplicate inverses while keeping the Half sum order used by independent rows.') +
    label(20, 454, 'The score matrix is local to the current query panel(s); there is no global [windows,heads,64,64] allocation.'),
    'FP8’s specialized SoftmaxWindowPair is a real scheduling difference from the FP16 path, not merely a storage dtype substitution.')

attn_pool = svg('Record 30 branches before E4 quantization and pools raw Half words', '0 0 1020 430',
    box(20, 35, 285, 110, ['Projection + residual registers', '4 spatial tiles × 64 channels', 'per warp; packed Half', '4 warps → 256-channel CTA'], 'storage') +
    arr(305, 90, 385, 90) + box(385, 35, 285, 110, ['Publish high-resolution skip', 'Half words / E4 conversion', '[68,120,512]', 'saved for record 39'], 'storage') +
    arr(160, 145, 160, 225) + box(20, 225, 285, 140, ['Pool raw register values', 'shuffle top-left / top-right', 'shuffle bottom-left / right', '(TL+TR) + (BL+BR)', 'then × 0.25, all Half'], 'compute') +
    arr(305, 295, 385, 295) + box(385, 235, 285, 120, ['Publish pooled tile', '8 × 8 → 4 × 4', '[36,60,512] including pad', 'Half / E4 working storage'], 'storage') +
    arr(670, 295, 730, 295) + box(730, 235, 270, 120, ['Separate channel projection', '512 → 1024 per position', '[36,60,1024]', 'no extra spatial mixing'], 'compute') +
    label(20, 408, 'The pool is not reconstructed by reading the already-published FP8 skip. Its quantization point is later.'),
    'At 4K the actual half-height is 34; the downsample allocation pads it to 36, preserving the next stage’s 4×4 tile geometry.')

channel_diagram = svg('Channel expansion reuses one input stage across four output-channel warps', '0 0 1020 365',
    box(20, 35, 280, 125, ['Global pooled C512 tiles', 'stage covers 8 × 8 positions', '8 warps copy one 512 B stripe', 'shared: 3×4096 + 3×8 B'], 'storage') +
    arr(300, 98, 360, 98) + box(360, 30, 310, 135, ['8-warp CTA: 256 output channels', 'w%4 → 64-channel group', 'w/4 → upper/lower 4 rows', 'each warp: 2 M16 × 4 N16', 'zero-initialized Half accumulators'], 'compute') +
    arr(670, 98, 730, 98) + box(730, 35, 270, 125, ['Global C1024 tiled output', 'Half: 32,768 B per 4×4 tile', 'E4: 16,384 B per 4×4 tile', 'four 256-channel grid slabs'], 'storage') +
    label(20, 225, 'Input address = X + (tileIndex·512 + reductionChannel)·16·e.') +
    label(20, 262, 'Weight address = W + reductionStart·1024·e + outputChannel·32 + lane·16') +
    label(20, 293, '                 + kSubtile·32768 + channelGroup·512.') +
    label(20, 338, 'The input reduction remains 512; doubling output width doubles the packed weight K-subtile byte stride.'),
    'Ordinary attention projection and channel expansion share the reuse pattern, but the latter has 1024 output channels and no residual seeding.')

decoder_diagram = svg('Decoder record 39: ordered split-K scratch and final spatial publication', '0 0 1020 530',
    box(20, 35, 220, 100, ['Split 0: input c=0…255', '16 low pixels × 256 outputs', '2 warps / CTA', 'store Half scratch'], 'compute') +
    arr(240, 85, 280, 85) + box(280, 35, 220, 100, ['Split 1: c=256…511', 'same output ownership', 'Half reduction into scratch', 'publish counter 1'], 'compute') +
    arr(500, 85, 540, 85) + box(540, 35, 220, 100, ['Split 2: c=512…767', 'same output ownership', 'Half reduction into scratch', 'publish counter 2'], 'compute') +
    arr(760, 85, 800, 85) + box(800, 35, 200, 100, ['Split 3: c=768…1023', 'load prior Half scratch', 'HalfAdd own partial', 'final output only'], 'compute') +
    box(20, 205, 480, 100, ['Global scratch: 16 pixels × 512 × 2 = 16,384 B / tile', 'Same Half layout in FP16 and FP8 kernels', 'counter: one int32 per low-tile / 256-channel slab'], 'storage') +
    box(560, 205, 440, 100, ['Each split’s shared memory: 2 × 1024 + 16 = 2064 B', 'Two K stripes staged; packed W goes to registers', 'Half: eight K32 iterations; FP8: four K64'], 'storage') +
    box(20, 370, 290, 105, ['Final projected low 4 × 4', 'lane shuffles repeat each pixel', '2× in X and 2× in Y', 'no upsample temporary'], 'compute') +
    arr(310, 422, 370, 422) + box(370, 370, 285, 105, ['Four high 4 × 4 tiles', 'add scale ⊙ saved skip', 'Half math before publication', 'crop output bounds'], 'compute') +
    arr(655, 422, 715, 422) + box(715, 370, 285, 105, ['Published [68,120,512]', 'Half direct / E4 pack', 'feeds ordinary block 40', 'no FFN in record 39'], 'storage'),
    'Arrows show the required scratch update order. It can be implemented as ordered stream launches; the native grid-Z path uses completion-counter polling.')


attn_body = f'''
<h2 id="c512-attn-model">Target architecture: sixteen local heads, plus bottleneck entry and exit</h2>
<p>After the C512 FFN publishes Z, records <strong>23–30 and 40–47</strong> compute local window attention with sixteen 32-channel heads. At 4K the logical input and output are <strong>[68,120,512]</strong>. QKV expands one position’s 512 channels to 1,536 channels; each head receives 32 Q, 32 K and 32 V channels. Positions exchange information only inside their phase-dependent 8 × 8 windows. This chapter also follows record 30’s down-transition and record 39’s transition-only return from C1024.</p>
<p>For one head and window, <code>Q,K,V ∈ R[64,32]</code>. The graph is <code>Q = publish(headScale·normalize(Qraw))</code>, <code>K = publish(normalize(Kraw))</code>, <code>S = QKᵀ + bias</code>, <code>P[i,j] = E(S[i,j])/Σk E(S[i,k])</code>, then <code>A = publish(PV)</code>. The joined 512-channel attended result becomes <code>Y = publish(A Wout + scale_attn ⊙ Z)</code>. E is the recovered clamped exponential surrogate. It is not a call to PyTorch SDPA, and Q does not receive the extra √32 multiplier used by the global bottleneck.</p>
{attn_arch}
<p>Compare the <a href="architecture.html#window-attention-c32-through-c512">window-attention graph</a>, the <a href="architecture.html#window-layout-how-windows-cover-the-image">padding/phase layout</a> and <a href="architecture.html#moving-between-resolutions">transition diagrams</a>. Those describe mathematical dependencies. The CUDA mapping fuses QKV, normalization and attention into one kernel, but uses a separate output-projection launch. Q, K, V and score panels remain inside the head warp; attended features cross a global-memory boundary before the output projection.</p>

<h2 id="c512-attn-window">Step 1 — turn a phase-dependent window into four native spatial tiles</h2>
{attn_window}
<p>A QKV/attention CTA has four warps. Warp w owns head <code>4·blockIdx.z+w</code>; grid Z has four slabs to cover sixteen heads. All four warps reuse the same staged input positions but load their own adjacent Q/K/V weight panels. The origin is zero or minus four in each axis, according to the phase. For phase 1 the first window starts at (−4,−4), so it includes three outside-field native tiles and one real native tile. Those outside inputs are zero; attention still has all 64 slots. There is no added mask that removes padded keys from the row sum.</p>
<p>At the right and bottom boundary, the kernel checks both lower and upper tile bounds before copying or storing. It emits only real output tiles. Shifting therefore changes which positions share a window without wrapping opposite edges together. The source’s singleton-tile broadcast rule is separate from this ordinary phase padding. The deployed 4K C512 field has 17 × 30 native tiles, so its bottom boundary is particularly useful when tracing partial CTAs.</p>
{code(A+'fp16/window_qkv_c512_fp16.cu', 13, 27, 'Window origin, head ownership and the shared barrier arrival count')}

<h2 id="c512-attn-qkv">Step 2 — project all 512 input channels into one warp’s Q/K/V</h2>
{attn_storage}
<table><thead><tr><th>QKV property</th><th>FP16</th><th>FP8 E4M3</th></tr></thead><tbody>
<tr><td>Reduction step per input stage</td><td>16 channels; one K16 instruction per N8</td><td>64 channels; two K32 instructions per N8</td></tr>
<tr><td>Iterations for K=512</td><td>32</td><td>8</td></tr>
<tr><td>Stage bytes</td><td>4 × 512 = 2,048</td><td>4 × 2 × 512 = 4,096</td></tr>
<tr><td>Shared allocation including barriers</td><td>4,112 bytes</td><td>8,208 bytes</td></tr>
<tr><td>Per-warp projected register tile</td><td colspan="2">4 spatial M16 fragments × 6 N16 groups × 4 Half2 words per lane</td></tr>
</tbody></table>
{code(A+'common/window_qkv.cuh', 10, 24, 'QKV has a different FP16 K schedule from the C512 FFN and projection')}
<p>This is why “halve the element size” does not fully explain the FP8 design. Unlike the FFN’s two K16 operations per Half stage, QKV Half processes only one K16, using half as much shared memory per stage. E4 processes two K32 operations. Both ping-pong their stages: issue the next input, compute current fragments, load next weights, then wait. Each warp owns six N16 panels: Q-low, Q-high, K-low, K-high, V-low and V-high.</p>
<p>Let h be the head, l the lane, t the reduction iteration and e the element size. The QKV weight base is <code>W + t·ReductionStep·1536·e + h·3072 + l·16</code>. N16 panel n adds <code>n·512</code>; FP8’s second K32 adds 49,152 bytes. The learned bias starts after <code>3·512·512·e</code> matrix bytes. Each head’s 64 × 64 Half table occupies 8,192 bytes in both precisions, followed by a sixteen-element FP32 head-scale array. The load converts each head scale to replicated Half before applying it.</p>
{code(A+'fp16/window_qkv_c512_fp16.cu', 34, 46, 'Head-interleaved QKV matrix addresses')}
<p>The QKV accumulator holds 96 32-bit words per lane before transformations, representing 64 positions × 96 outputs across the warp. This is a logical source footprint, not a report of simultaneously live hardware registers. Reinterpreting the six N16 panels as three 32-channel tensors is a register assignment: there is no global write and reload between projection and normalization.</p>

<h2 id="c512-attn-norm">Step 3 — normalize a token’s channels with warp shuffles</h2>
{attn_norm}
<p>For one token row, four lanes hold its 32 channels. Each lane holds four Half2 pairs corresponding to channels spaced by eight. The squared-norm tree is deliberately specified: channels 16–31 are multiplied first, then lower channels are fused into them, then the two column groups combine. XOR-2 and XOR-1 shuffles exchange the four channel partitions while preserving the token row. A swap/add combines the two halves of each packed word, producing the same scalar twice.</p>
<p>The implementation clamps this squared norm to a packed epsilon, converts one replicated Half value to float, uses approximate reciprocal square root, rounds that inverse back to Half, and multiplies the channels. Q subsequently multiplies the head scale; K does not. V bypasses the entire normalization. The architecture equation expresses an L2 norm; the deployment result is defined more precisely by this Half reduction tree and its intermediate rounding points.</p>
{code(S+'warp_window32.cuh', 161, 192, 'The exact Q/K square tree, shuffle reduction and scale placement')}
<p>Q and K are then published as MMA operands: two K16 fragments for Half, one K32 fragment for E4. “Published” here means converted/repacked in registers, not stored globally. V is transformed with <code>TransposeM8n8</code> into the right-operand layout used by probability-times-value MMA. FP8 packs the two transposed halves into one E4 word; FP16 retains both Half words. These layout changes make the next computation consume the output immediately.</p>
{code(A+'fp8/window_qkv_c512_fp8.cu', 115, 144, 'Q/K normalization and V transpose occur before attention, still in registers')}

<h2 id="c512-attn-score">Step 4 — produce 16 × 64 score panels, then normalize and multiply V</h2>
{attn_scores}
<p>For a selected 16-query spatial fragment q, the score accumulator contains eight N8 column fragments, covering all 64 keys. Bias is loaded directly into the accumulator before QKᵀ is added. The exact bias fragment address within a head is <code>headBias + 2048·q + 512·keyTile + 16·lane</code>. Thus query tile, physical key tile and lane select an already-packed 16-byte fragment. The recovered K/V ordering and bias layout must agree; treating bias columns as an unrelated row-major table would attach the wrong positional bias.</p>
{code(S+'warp_window_wide.cuh', 142, 171, 'FP16 attention seeds the score accumulator with bias, then accumulates QKᵀ')}
<p>The source replaces each score with a clamped Half affine expression followed by a packed exponent-bit shift and offset. The whole-word shift matters because carries can affect the upper Half lane. It then sums the 64 positive weights. Within each lane it combines the eight N8 fragment pairs; across the four channel/key partitions it adds lanes in order 0, then 1, then 2, then 3, then combines Half components. This is neither a generic stable softmax routine nor an arbitrary associative reduction. No max-subtraction pass appears.</p>
<p>FP16’s <code>AttendWithBias</code> calls <code>SoftmaxWindow</code> independently for q0 through q3. The FP8 entry instead computes two adjacent query tiles at once and calls <code>SoftmaxWindowPair</code>. The two panels contain 32 query rows, enough to give each of the 32 lanes one row denominator. It permutes the four partial vectors, gathers through <code>((lane &amp; 7)&lt;&lt;2) | (lane&gt;&gt;3)</code>, restores the 0/1/2/3 contributor order, and computes one reciprocal per row. A final shuffle broadcasts that reciprocal back to the four lanes holding each row’s score fragments.</p>
{code(S+'warp_window32.cuh', 282, 310, 'FP8 paired denominator transpose: fewer duplicate inverses, preserved Half addition order')}
<p>For example, lane 13 in the transposed denominator phase receives logical row 13. Its gather source is <code>((13 &amp; 7)&lt;&lt;2)|(13&gt;&gt;3) = 21</code>, with the per-vector XOR selecting each contributor. Later, for the first row-half vector, an original MMA lane with <code>lane/4=5</code> fetches inverse lane 5; for vector three it fetches lane 29. The source uses fixed array indices and unrolled loops so this ownership transpose is expressed in registers and shuffles.</p>
<p>After division, probabilities are published to the working operand precision. P×V reduces over four K16 chunks in Half or two K32 chunks in E4. The output has 32 channels per query, accumulated in Half and published again. Each real native tile/head writes <code>output + tileIndex·8192·e + head·512·e + chunk·512 + lane·16</code>. Half writes two chunks; E4 writes one. No full score matrix or QKV tensor is allocated in global memory by this kernel.</p>
{code(A+'fp8/window_qkv_c512_fp8.cu', 151, 188, 'The FP8 paired score/value path and its only global publication')}

<h2 id="c512-attn-project">Step 5 — mix heads, apply the residual, and select the output layout</h2>
<p>The attended tensor now contains all sixteen head outputs, concatenated into C512. A dense 512→512 projection mixes those heads; the separate learned channelwise attention scale multiplies published Z. The reusable projection template seeds Half accumulators with this scaled residual before its K loop, just as in the FFN postmix. Ordinary attention projection uses eight warps and two M16 spatial tiles per warp. Each warp owns 64 channels, while the two groups of four warps cover upper/lower halves of the 8 × 8 region.</p>
<table><thead><tr><th>Projection entry</th><th>Warps / spatial tiles per warp</th><th>Shared ring</th><th>Special output</th></tr></thead><tbody>
<tr><td>Ordinary attention projection</td><td>8 / 2</td><td>3 × 4 KiB + 24 B</td><td>Native C512 tiled tensor</td></tr>
<tr><td>Block 47 output-view projection</td><td>4 / 4</td><td>3 × 4 KiB + 24 B</td><td>Channel-plane view</td></tr>
<tr><td>Block 30 projection + pool</td><td>4 / 4</td><td>2 × 4 KiB + 16 B</td><td>High skip plus pooled tensor</td></tr>
</tbody></table>
<p>Block 47 must hand its result to the next decoder family. Instead of writing a native tiled image then transposing it, its output-view kernel writes each accumulator word directly to <code>((panel·H+y)·W+x)·16 + (lane&amp;3)·4</code>. Panel width is eight Half or sixteen E4 channels. Physical y is <code>4·tileY + lane/16 + 2·rowHalf</code> and x is <code>4·tileX + (lane/4)%4</code>. Half needs two panel halves per N16 group; E4 packs the group’s two N8 pairs into one word. This is the inverse boundary convention of block 23’s residual/input-plane reads.</p>
{code(A+'fp16/window_attention_projection_output_view_c512_fp16.cu', 183, 212, 'Direct per-pixel channel-plane publication avoids a separate conversion pass')}

<h2 id="c512-attn-pool">Step 6 — record 30 forks into a skip and a raw-value pool</h2>
{attn_pool}
<p>The encoder tail must preserve the high-resolution result for decoder record 39 while reducing the field for the global bottleneck. Its dedicated projection-pool entry assigns all four spatial fragments to each warp. This ownership makes the entire 8 × 8 patch available for 2 × 2 pooling using register shuffles. The kernel writes the high output in working precision, then pools its still-live Half accumulators. It does not reload or average the already-quantized high output.</p>
<p><code>PoolHorizontalWords</code> routes adjacent source tiles and row halves using lane-bit swaps, then swaps lane bits 2 and 3. Four indexed shuffles obtain top-left, top-right, bottom-left and bottom-right at XOR offsets 0,4,16,20. Its arithmetic is exactly <code>HalfMul(HalfAdd(HalfAdd(TL,TR),HalfAdd(BL,BR)), 0.25)</code>. Replacing this with an FP32 average, or pooling E4 values read from the skip, changes the rounding/quantization contract.</p>
{code(S+'window_pool.cuh', 29, 40, 'Four neighborhood gathers and the exact rounded Half averaging tree')}
{code(D+'fp8/window_attention_projection_pool_c512_fp8.cu', 238, 260, 'Pool the raw projection accumulators before E4 publication')}
<p>One input 8 × 8 region becomes one output 4 × 4 tile. At 4K, halving [68,120] gives [34,60], then the geometry supplies the padded [36,60] field. The bottom synthetic rows follow the kernel’s bounded-input zero filling. The pooled output retains 512 channels; a separate kernel doubles channel width.</p>

<h2 id="c512-attn-channel">Step 7 — channel projection turns pooled C512 into C1024</h2>
{channel_diagram}
<p><code>channel_projection_c512_to_c1024_*</code> is a pointwise matrix multiply at the lower spatial resolution. It has eight warps, a three-stage 4 KiB input ring and one 256-channel output slab per CTA. Four grid-X channel slabs cover C1024. Warps 0–3 compute the upper half of the spatial region; warps 4–7 compute its lower half. Each has two M16 spatial fragments and four N16 output groups. Unlike the residual projection, the accumulator is zero-initialized and there is no skip input.</p>
<p>Each producer warp copies one 512-byte input stripe; four consumer warps reuse the same two spatial tiles. After current MMA, the code prefetches next weights and waits for the next stage before refilling the old slot. The weight K-subtile stride is now 32,768 bytes rather than the C512 projection’s 16,384, because there are 1,024 output columns. Both precisions still use 32 packed bytes per output column per instruction-K slice. Output tile stride becomes <code>16·1024·e</code>: 32 KiB Half or 16 KiB E4.</p>
{code(D+'fp16/channel_projection_c512_to_c1024_fp16.cu', 104, 137, 'Consume shared fragments, wait before ring reuse and preserve sequential K accumulation')}
<p>FP16 stores four direct N16 accumulator vectors per lane; FP8 pairs adjacent N16 groups, converts to E4 and stores two vectors. The packed source’s matrix has 512 × 1024 elements; this kernel does not add a bias or scale. Its native tile output becomes the C1024 stage input described in the bottleneck chapter.</p>

<h2 id="c512-attn-decoder">Step 8 — record 39 reduces channels, expands positions, and merges the skip</h2>
<p>Record 39 is solely the connector <code>1024→512 projection → nearest 2× upsample → scaled skip addition → publish</code>. For the 4K example, a [36,60,1024] input becomes a [68,120,512] output after cropping the doubled height. Its projection is split into four reductions over 256 input channels each. Grid X also has two 256-output-channel slabs. Each CTA has two warps; each warp handles 128 output channels for one low-resolution 4 × 4 tile.</p>
{decoder_diagram}
<p>The source shared allocation is 2,064 bytes: two 1 KiB stages and two 8-byte barriers, with arrival count 64. Half executes eight K32 iterations per split; E4 executes four K64 iterations. The input address starts at <code>X + lowTile·16384·e + split·4096·e</code>, then adds the current 512-byte K stripes. The weight base contains <code>(split·256 + t·ReductionStep)·512·e</code>, output-channel stripe <code>outputChannel·32</code>, and lane displacement <code>lane·16</code>.</p>
<p>All four splits accumulate Half partials. Scratch is also Half in the FP8 path: <code>scratch + lowTile·16384 + outputChannel·32 + lane·16 + N16·512</code>. Split 0 stores it; splits 1 and 2 use <code>ReduceHalf4</code> to add their partials in order. Split 3 reads the previous three-split sum and combines its own accumulator with <code>HalfAdd</code>, without writing scratch again. For the full 4K low field, scratch occupies 2,160 × 512 × 2 = 2,211,840 bytes before any allocator alignment. Each low-tile/256-channel slab has a four-byte completion counter.</p>
{code(U+'fp8/decoder_upsample_c1024_to_c512_fp8.cu', 110, 149, 'Native split waiting and Half scratch publication in the FP8 kernel')}
<p>The entries expose two execution modes. In native grid-Z mode, later splits poll a relaxed counter until their predecessor has reached its expected value, then synchronize their CTA; the producer publishes a GPU-scope release counter after its final CTA barrier. In ordered mode, the launcher submits one logical split at a time on a stream, so no CTA occupies an SM waiting for an unscheduled predecessor. This description follows the actual entry bodies; it does not infer an acquire instruction merely because another shared helper has that name. The launch/synchronization chapter discusses this protocol and its scheduling constraints.</p>
<p>Only split 3 performs upsampling and skip addition. A low 4 × 4 tile produces four high 4 × 4 quadrants. For quadrant offsets ox,oy, destination row half r and lane l, the source lane is <code>(l&amp;3) | ((l&gt;&gt;1)&amp;4) | (ox·8) | (r·16)</code>, while oy chooses the source accumulator row-half word. This gathers the same low value into its four nearest-neighbor destinations. It preserves the packed channel-pair ownership, avoiding both a shared transpose and an intermediate upsampled global image.</p>
{code(U+'fp16/decoder_upsample_c1024_to_c512_fp16.cu', 210, 224, 'Lane-indexed nearest-neighbor expansion followed by the scaled skip merge')}
<p>The skip pointer refers to the published record-30 C512 tensor, not its pooled value. Scales follow the 1024 × 512 matrix and remain Half in both storage modes. The kernel multiplies the skip by its scale in Half, adds the projected nearest value in Half, clips high-tile bounds, and only then stores Half words or converts to E4. Consequently the FP8 path has a Half split scratch and Half merge math, while its input, matrix, saved skip and final output are E4. Record 40 consumes the published result and begins the ordinary grouped FFN cycle again.</p>
{note('A useful tracing exercise: choose high pixel (y,x)=(17,25), channel 137. Its low projection source is (8,12), its 256-channel slab is zero and its warp is one. Its skip comes from record 30 at the same high pixel (17,25), channel 137. The projection reduces all 1024 low-input channels through four ordered splits; the skip addition is performed only once, after split 3.')}
'''


CHAPTERS = [
    dict(slug='c512-ffn', title='C512 grouped FFN: from model slices to register panels',
         summary='Premix, eight grouped MLPs, postmix, Half/E4 fragments, two-stage staging and the block-23 input view.', body=ffn_body),
    dict(slug='c512-attention', title='C512 attention and its C1024 transitions',
         summary='QKV and window attention, paired FP8 normalization, output views, raw pooling, channel expansion and split-K decoder upsampling.', body=attn_body),
]
