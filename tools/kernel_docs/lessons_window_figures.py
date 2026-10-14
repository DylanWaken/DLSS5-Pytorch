"""Source-derived construction diagrams and the six-section local-kernel contract."""
from html import escape
import re
from common import svg, code


def subordinate(fragment):
    """Retain stable deep links while making source steps children of a contract section."""
    fragment = re.sub(r'(<h2\b[^>]*>)(?:\d+\.\s*)?', lambda m: m[1].replace('<h2', '<h3'), fragment)
    return fragment.replace('</h2>', '</h3>')


def _label(x, y, value, size=15):
    return f'<text x="{x}" y="{y}" font-family="system-ui,sans-serif" font-size="{size}" fill="#183447">{escape(str(value))}</text>'


def _box(x, y, w, lines, fill='#e9f2fb', h=110):
    return f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="8" fill="{fill}" stroke="#6b8192"/>' + ''.join(_label(x+12, y+26+24*i, line) for i, line in enumerate(lines))


def _edge(x, y, xx, yy):
    return f'<path d="M{x} {y} L{xx} {yy}" stroke="#576c83" stroke-width="2" fill="none" marker-end="url(#arrow)"/>'


def design_choice(title, baseline, pressure, decision):
    """Draw a derivation, explicitly distinct from a benchmark/tuning history."""
    inner = ''
    for i, (label, lines, fill) in enumerate((('Correct starting point', baseline, '#e9f2fb'),
            ('Cost to account for', pressure, '#fff1cf'), ('Construction to try', decision, '#dff1e5'))):
        x = 20 + i*375
        inner += _box(x, 25, 340, [label] + list(lines), fill, 155)
        if i < 2:
            inner += _edge(x+340, 102, x+367, 102)
    return svg(title, '0 0 1130 210', inner,
               'An analytical design comparison. The alternatives are proposed constructions, not recorded benchmark runs.')


def milestone_steps(fragment, specifications):
    """Turn source explanation into build/verify milestones without losing deep links."""
    for ident, title, motivation, check in specifications:
        pattern = r'(<h[23] id="' + re.escape(ident) + r'">).*?(</h[23]>)(.*?)(?=<h[23] |$)'
        def replace(m):
            return (m[1] + title + m[2] + '<p><strong>Build next.</strong> ' + motivation + '</p>' + m[3] +
                    '<p class="note"><strong>Before proceeding.</strong> ' + check + '</p>')
        fragment, count = re.subn(pattern, replace, fragment, count=1, flags=re.S)
        if count != 1:
            raise ValueError('Missing source milestone: ' + ident)
    return fragment


def cta_diagram(c, fp8, mode='ordinary', frontend=False):
    b = 1 if fp8 else 2
    title = f'C{c} {"FP8" if fp8 else "FP16"} {mode}: one CTA owns one 8 × 8 window'
    inner = _label(20, 26, 'Example: unshifted window at image origin; orange pixel is token 13 = (5,1)', 18)
    for y in range(8):
        for x in range(8):
            tile = 2*(y//4)+x//4
            fill = '#ffc877' if (x,y)==(5,1) else ['#d9ebf9','#dff1e5','#eee4f6','#fff1cf'][tile]
            inner += f'<rect x="{20+x*40}" y="{52+y*35}" width="37" height="32" fill="{fill}" stroke="#8293a0"/>'
            inner += _label(25+x*40, 74+y*35, 8*y+x, 12)
    inner += _box(385, 52, 325, [f'CTA: 32 × {c//32} threads', f'4 tiles × 16 rows × {c} channels', f'{64*c:,} block feature values',f'{64*c*b:,} B in published precision'],h=128)
    inner += _box(745, 52, 335, [f'{c//32} attention heads', 'Each head: Q[64,32] × Kᵀ', '64 × 64 scores → P × V', 'Each query attends all 64 slots'], '#fff1cf',128)
    if mode in ('upsample','output'):
        tail = ['Input low patch: 4 × 4 tokens',f'{32 if frontend else 2*c} low channels + {c} skip channels', 'repeat after low load/projection', 'token (2,0) feeds high (5,1)']
    elif mode in ('downsample','input-down'):
        tail = ['Also retain a full-resolution skip','Pool 8 × 8 → 4 × 4 tokens',f'low output: {c if frontend else 2*c} channels', 'token (5,1) joins cell at low (2,0)']
    elif frontend and mode=='input':
        tail = ['Renderer extent may be smaller', 'reflect image sampling coordinates', 'noise still uses original coordinates', 'two shared Half feature planes']
    else:
        tail = ['No token exchange across CTAs', 'grid partitions image windows', 'Origin can shift the window by −4', 'out-of-field slots load zero']
    inner += _box(385, 211, 695, tail, '#f0e8fa',128)
    return svg(title,'0 0 1110 365',inner,'The proposed whole-window decomposition is now concrete. Section 6 checks this construction against the source and recorded launch.')


def ownership_diagram(c, fp8, frontend=None):
    if frontend=='input':
        first=['Feature producer: lane 13','samples pixel (5,1)','writes shared plane 0, slot 13','feature 4/5 word: byte 216']
    elif frontend=='output':
        first=['Low token (2,0) + skip (5,1)','shuffle source lane 10','raw merge: tile 1, row 5','channels 20/21 in lane 22']
    else:
        first=['Natural token 13: pixel (5,1)','tile 1; physical token 21','tile row 5 = laneGroup 5','lanes 20…23 span channels']
    second=['Lane 22: group 5, pair 2','C.r_Pair[2][0] → c20/c21','rowHalf 1 belongs to token 29','all 32 lanes execute each MMA']
    last=(['C32: one warp owns all stages','4 X tiles; hidden panels stream','Q/K/V + scores in registers','no transformer shared exchange'] if c==32 else
          ['C64 FFN: warp 0 tiles 0/1','warp 1 tiles 2/3; both panels','barrier changes ownership','attention: warp h owns head h'] if c==64 else
          [f'C{c}: {c//32} branch warps','each branch reads all channels','shared panels exchange branches','attention: warp h owns head h'])
    inner=_box(20,35,335,first,'#fff1cf',140)+_box(390,35,335,second,'#dff1e5',140)+_box(760,35,335,last,'#e9f2fb',140)
    inner+=_edge(355,105,384,105)+_edge(725,105,754,105)
    inner+=_label(20,222, 'A scalar has an owner at each boundary; a Tensor Core operation is collective, never one lane doing the entire dot product.',14)
    return svg(f'C{c} {"FP8" if fp8 else "FP16"}: token 13 ownership across stages','0 0 1120 250',inner)


def scheduling_diagram(c, fp8, mode='ordinary', frontend=None):
    fmt='E4M3' if fp8 else 'Half'
    if frontend=='input':
        nodes=[('texture → features','lane L owns pixels L,L+32'),('shared feature barrier','2048 B: producers → MMA'),('Half adapter 16 → 32','four tiles; retain raw result')]
    elif frontend=='output':
        nodes=[('global low + skip','spatial words + packed uint4'),('shuffle nearest expansion','low product; HalfFma skip'),('raw merge → FFN','publish separate operand copy')]
    elif mode=='upsample':
        nodes=[('low projection 2C → C','4 × 4 tokens before repeat'),('shuffle repeat + skip merge','bound raw merge; check contraction'),('publish merge; CTA barrier' if c>32 else 'publish merged X',f'{fmt} operand + residual lifetime')]
    else:
        nodes=[('gather spatial view words' if mode=='input_view' else 'load four physical tiles','predicate loads; every lane stays'),('establish operand ownership',f'{fmt} working representation'),('publish X; CTA barrier' if c>64 else 'seed FFN residual','complete shared input for all branches' if c>64 else 'round scale × X before MMA')]
    if c==32:
        nodes += [('4 hidden panels, in order','expand → activate → contract'),('QKV + channel norm','publish Q/K; transpose V'),('QKᵀ + bias → surrogate', 'paired query tiles' if fp8 else 'single query tile; 64 keys'),('row sum → reciprocal → P','P × V; no global score tensor'),('projection + raw residual','weights reused across token tiles')]
    elif c==64:
        nodes += [('2 branches per token warp','stream hidden; immediately mix'),('publish Z; CTA barrier','token ownership → head ownership'),('QKV; reader barrier','keep scaled Z residual in registers'),('2 query tiles per batch','normalize; P × V; publish heads'),('CTA barrier → projection','all heads; barrier before slab reuse')]
    else:
        nodes += [('X shared → branch per warp','save residual before overwrite'),('reader barrier; publish branches','store-done barrier → branch mix'),('reader barrier; publish Z','store-done barrier → QKV'),(f'{4 if c==256 else 2} query tiles per batch','publish attended head panels'),('CTA barrier → projection','all heads; barrier before slab reuse')]
    if frontend=='output': nodes += [('Half 32 → 4 head','consume raw tile immediately'),('head shuffles → float pixels','compose; bounded surface stores')]
    elif mode in ('downsample','input-down'):
        nodes += [('publish high skip; keep raw Y','shuffle-pool raw Half 2 × 2'),('publish pooled operands', 'store C32 planes' if frontend else f'project {c} → {2*c}; store planes')]
    else: nodes += [('publish final result', 'spatial word stores' if mode=='output_view' else 'bounded no-allocate uint4 stores')]
    inner=''
    for i,(a,b) in enumerate(nodes):
        row,col=divmod(i,3); x=20+370*col; y=25+145*row
        inner+=_box(x,y,335,[f'{i+1}. {a}',b], '#fff1cf' if 'barrier' in (a+b).lower() else '#e9f2fb',105)
        if col<2 and i+1<len(nodes):inner+=_edge(x+335,y+52,x+362,y+52)
        elif i+1<len(nodes):
            inner+=f'<path d="M{x+167} {y+105} V{y+126} H{20+167} V{y+139}" fill="none" stroke="#576c83" stroke-width="2" marker-end="url(#arrow)"/>'
    height=145*((len(nodes)+2)//3)+20
    return svg(f'C{c} {"FP8" if fp8 else "FP16"} {mode}: execution dependencies','0 0 1130 '+str(height),inner,'Read left-to-right, then follow the long return arrow to the next row. These are source dependencies, not measured cycle timings or a promise of concurrent warp execution.')


def resource_section(c, fp8, path, frontend=None, down=False):
    chunks=1 if fp8 else 2; b=1 if fp8 else 2
    shared=2048 if frontend=='input' else (0 if c==32 else 64*c*b)
    shared_desc=('2 planes × 64 pixels × 16 B; one producer/consumer barrier' if frontend=='input' else
                 'No shared declaration; communication uses registers and warp instructions' if c==32 else
                 f'4 tiles × {c//32} panels × {chunks} K chunks × 32 lanes × 16 B; reused, not multiplied by stage count')
    rows=[('Threads / warps in this construction',f'{c} / {c//32}','Ownership derived in section 3'),
          ('Shared tensor budget',f'{shared:,} B',shared_desc),('Async barrier budget','0 B','The proposed synchronous schedule needs no mbarrier objects or copy-ring stages'),
          ('One C32 accumulator','8 × uint32 per lane','4 N8 groups × 2 token-row halves = 16 Half scalars'),
          ('One published C32 tile',f'{4*chunks} × uint32 per lane',f'{chunks} K{32 if fp8 else 16} fragments × 4 operand words'),
          ('One C32 weight tile',f'{8*chunks} × uint32 per lane',f'{chunks} K chunks × 4 N8 groups × 2 B words'),
          ('Persistent Q/K/V arrays',f'{48*chunks} × uint32 per lane','4 Q tiles + 4 K tiles + 4 transposed V tiles; source-level storage shape')]
    if c==32:
        rows += [('Four FFN accumulators','32 × uint32 per lane','Retained for the attention residual'),('Four input tiles',f'{16*chunks} × uint32 per lane','Reused over four streamed hidden panels')]
    elif c==64:
        rows += [('FFN input / output arrays',f'{16*chunks} / 32 × uint32 per lane','2 token tiles × 2 channel panels; both branches computed in same warp')]
    else:
        rows += [('Branch / mixed-output arrays','32 / 32 × uint32 per lane','Four C32 token tiles of each; their live ranges overlap only as source requires'),('Wide QKV projection array','96 × uint32 per lane','3 components × 4 tiles × 8 accumulator words')]
    if frontend=='input':rows.append(('Raw adapter array','32 × uint32 per lane','Four C32 tiles, retained as raw Half residuals'))
    if frontend=='output':rows.append(('Image head array','8 × uint32 per lane','4 tiles × 2 words, useful 4-channel results inside N8 output'))
    if down:rows.append(('Retained raw output','32 × uint32 per lane','Four C32 panels for exact Half pooling; wider CTAs distribute channel panels'))
    table='<div class="table-scroll"><table><thead><tr><th>Resource</th><th>Amount</th><th>Derivation / lifetime</th></tr></thead><tbody>'+''.join('<tr>'+''.join('<td>'+escape(v)+'</td>' for v in row)+'</tr>' for row in rows)+'</tbody></table></div>'
    if frontend == 'input':
        derivation = ('A separate feature kernel would materialize 64×16×2=2048 bytes and its adapter consumer would read them again: 4096 logical global bytes per window. A shared plane needs the same 2048-byte capacity, but can die immediately after the adapter. Double buffering would reserve 4096 shared bytes without providing a second window of independent work in this single-window construction. First use one plane pair and one producer/consumer barrier.')
    elif frontend == 'output':
        derivation = ('Retaining all four raw C32 output tiles costs 4×8=32 accumulator words per lane. Applying the Half image head immediately reduces the retained result to 4×2=8 words per lane, one quarter of that source-array footprint. The latter includes padded N8 channels: its warp-wide capacity is 1024 bytes even though only 64×4×2=512 bytes of head values are useful. No cross-warp consumer exists, so a shared copy would add traffic and capacity without solving an ownership dependency.')
    elif c == 32:
        derivation = (f'A fully retained hidden activation needs 64×128×{b}={64*128*b:,} published bytes. Stream one hidden C32 panel across the four token tiles instead: 64×32×{b}={64*32*b:,} bytes of logical operand extent, a fourfold reduction. The implementation can consume one token tile at a time within that panel. This does not make the kernel free of register pressure: the four input tiles, raw FFN residuals and later Q/K/V still have overlapping lifetimes. A shared spill candidate would trade that pressure for explicit loads and stores; compilation and measurement must decide whether that trade is useful.')
    else:
        ownership = ('The token-parallel C64 FFN avoids shared branch outputs; only Z and attended heads require exchange.' if c == 64 else f'All {c//32} branches read X, then all output panels read branch results. Keeping separate shared X, branch, Z and attended arrays would cost {4*shared:,} bytes; their sequential lifetimes permit one {shared:,}-byte slab if reader completion is enforced.')
        derivation = ownership + f' A two-stage copy ring would double the slab to {2*shared:,} bytes before any barrier metadata. It is a different candidate, not a free improvement. For attention, two retained attended C32 tiles cost 2×8=16 accumulator words per lane; four cost 32. C{c} uses the '+('four-tile candidate' if c == 256 else 'two-tile candidate')+' in the construction below. Larger batches reduce exchange rounds but lengthen live ranges; the budget alone cannot select the faster batch.'
    figure = design_choice(f'C{c} {"FP8" if fp8 else "FP16"}: derive the live-storage budget',
        ['Keep every intermediate', 'hidden: 64 × 128 per branch', 'Q/K/V plus score matrices'],
        [f'published C32 tile: {4*chunks} words/lane', 'Half accumulator: 8 words/lane', 'overlap, not total declarations'],
        [f'shared capacity: {shared:,} B', 'stream hidden panels in order', 'reuse only after last reader'])
    return ('<h2 id="resources">4. Resource budget</h2><p>'+derivation+'</p>'+figure+
            '<p>Translate the ownership into the source-array budget below. Each register entry counts 32-bit words per thread; the shared entry counts bytes per CTA. This is a liveness worksheet, not a sum to call the hardware register count. A compiler can eliminate, reuse or spill words. Keep a lifetime diagram when deciding which entries overlap.</p>'+table+
            '<p>A compiler register ceiling is a separate constraint, not the resource consumption predicted here; inspect the declaration and compiled allocation in section 6. L1 and L2 are hardware-managed and have no private per-CTA capacity declaration. The design question is whether the saved global intermediates outweigh longer live ranges, shared transactions and synchronization; only the recorded binary and a matched alternative measurement can resolve that question.</p><!-- RESOURCE_EVIDENCE -->')


def trace_intro(c, fp8, mode='ordinary', frontend=None):
    b=1 if fp8 else 2; tilebytes=16*c*b
    offset=tilebytes+(360 if fp8 else 864)
    pub=('word 2, low E4M3 byte; native K24 corresponds to model channel 20' if fp8 else 'chunk 1, word 0, low Half; native K4 + chunk base16 = channel 20')
    lead='<h2 id="trace">6. Trace one token through the source</h2><p>Fix an interior, unshifted window at origin (0,0), with an 8×8 field for the byte examples. Follow natural token 13, pixel (5,1), through tile 1 and physical token 21. Its tile row is 5. For C32 panel zero, accumulator lane 22 owns channels 20/21 in <code>r_Pair[2][0]</code>. Other channels of this token are distributed across lanes 20–23; matrix products mix channels, and attention then mixes token values. Following a token means following this output row and its dependencies, not preserving one scalar unchanged.</p>'
    if frontend=='input':
        incoming=['Texture pixel (5,1)','producer lane 13 → features','shared c4/5 word byte 216']
    elif frontend=='output':incoming=['Low (2,0), skip (5,1)','source lane 10 → lane 22','HalfMul then HalfFma']
    else:incoming=['Global token (5,1)',f'c20 fragment word: +{offset} B','packed tile index 1, panel 0']
    inner=_box(20,30,320,incoming,'#fff1cf',115)+_box(395,30,320,['Lane 22: tile 1 / row 5','FFN output → Q row 5','attention sees all 64 keys'],'#dff1e5',115)+_box(770,30,320,['P × V → projection','same output token (5,1)','packed store / transition'],'#eee4f6',115)
    inner+=_edge(340,87,388,87)+_edge(715,87,763,87)
    lead+=svg(f'C{c} {"FP8" if fp8 else "FP16"} {mode}: the concrete token followed below','0 0 1120 180',inner)
    lead+=f'<p>Whenever this token is in the native published A layout, channel 20 is in {pub}. For an ordinary packed allocation, its containing uint32 starts at <code>tileBytes + {360 if fp8 else 864} = {offset}</code> bytes. The allocation base is excluded. View inputs, low planes, feature planes and surfaces use their own equations below; this packed offset must not be applied to those storage layouts.</p>'
    if c>32:
        lead+=f'<p>The same local tile/panel/chunk/lane map addresses the shared exchange slab: <code>((((tile×{c//32}+panel)×{1 if fp8 else 2}+chunk)×32+lane)×16)+4·word</code>. Our selected word again begins at shared byte {offset}; its 32-bit bank index is <code>({offset}//4) mod32 = {(offset//4)%32}</code>. There is no XOR swizzle in this slab. A full uint4 accesses four successive bank words; a bank-index diagram alone cannot establish a bank conflict without the instruction transaction grouping and measured wavefront counts.</p>'
    else:lead+='<p>The transformer keeps this path in thread registers. It has no shared-memory swizzle. The feature-plane gather in an input frontend is a separate, real shared layout and is derived below.</p>'
    return lead


def trace_checkpoint(stage,c,fp8,mode='ordinary'):
    if stage=='ffn':
        msg=('Warp 0 retains tile 1 and streams the four hidden panels.' if c==32 else 'Warp 0 owns this token during C64 FFN, computes both branches and both output panels; only afterward does head ownership change.' if c==64 else f'The token is read by every one of the {c//32} branch warps. Each publishes its branch panel; the mixing matrix combines them into output panel zero, including lane 22 channel 20.')
        return '<p class="note"><strong>Token checkpoint — FFN.</strong> '+msg+' The selected pair lives in r_Ffn or r_Output tile 1/column2/rowHalf 0. Each hidden panel contributes before it dies; the raw full hidden vector is never materialized in global memory.</p>'
    if stage=='qkv':return '<p class="note"><strong>Token checkpoint — attention.</strong> Query tile 1,row 5 represents pixel(5,1). Lane22 holds Q channels 20/21. In its score accumulator, column group2 instead means key positions20/21: the column axis changed from channels to keys. Bias and all 64 K rows contribute to this same query row. The row-sum shuffles use lanes20–23, preserving query identity while combining columns. P×V restores a 32-channel result for that query.</p>'
    msg='The final projection restores this same tile 1,row 5/channel 20 location. '
    if mode in ('downsample','input-down'):msg+='Its published high skip remains at pixel(5,1), while raw Y(5,1) is the bottom-right member of the cell [(4,0),(5,0),(4,1),(5,1)] producing low pixel(2,0). The three Half adds and multiply by 1/4 happen before pooled publication.'
    elif mode=='output_view':msg+='For an 8×8 output view, its word is at plane 2,pixel(5,1),component 2 (FP16) or plane 1,pixel(5,1),component 2 (FP8), before applying the actual view extents.'
    else:msg+='Publication changes the fragment representation; the bounded vector store changes storage. These are distinct operations.'
    return '<p class="note"><strong>Token checkpoint — final consumer.</strong> '+msg+'</p>'


def instruction_ledger(c,fp8,frontend=None,mode='ordinary'):
    """Separate an emitted/source operation from a measured performance assertion."""
    mma='mma.sync.aligned.m16n8k32.row.col.f16.e4m3.e4m3.f16' if fp8 else 'mma.sync.aligned.m16n8k16.row.col.f16.f16.f16.f16'
    input_load=('feature textures → shared words; __ldca(uint4) packed B/bias' if frontend=='input' else
                'ordinary uint32 spatial input words; __ldca(uint4) packed B/bias' if mode=='input_view' else
                '__ldcg(uint4) native tile/skip inputs; __ldca(uint4) packed B/bias')
    rows=[('Packed operands and weights',input_load,
           'One aligned 16-byte vector per lane. Reusing B over token tiles removes repeated source loads; cache hit rate must be measured.'),
          ('Matrix work',mma,'A: 4 words/lane; B: 2; accumulator: 2 Half 2 words per N8. All32 lanes collectively execute one instruction.'),
          ('Activation / residual','HalfMin → HalfMax → HalfAbs → two HalfFma → HalfMul; HalfMul residual seed','The activation uses packed Half arithmetic; ordinary FFN/attention residual products seed the MMA accumulator. A transition merge has a separate contraction check below.'),
          ('Channel reduction','shfl.sync.bfly.b32 + rsqrt.approx.ftz.f32','XOR2 then XOR1 gathers the four lanes for one token; the widened inverse rounds back to Half.'),
          ('Attention row reduction','shfl.sync.idx.b32 + rcp.approx.ftz.f32','Keep the ordered lane sum over all 64 keys. '+('Paired C32 query tiles redistribute reciprocal ownership.' if fp8 and c==32 else 'Single-query normalization preserves each row’s source reduction tree.')),
          ('V orientation','movmatrix.sync.trans.aligned.m8n8.b16','Transpose register-held Half values before making the probability × value B operand; no global V transpose.'),
          ('Publication', 'cvt.rn.satfinite.e4m3x2.f16x2 + mov.b32' if fp8 else 'register word selection',
           'FP8 round-and-pack obeys the model/native-K permutation; Half publication preserves value bits.'),
          ('Shared lifetime', '__syncthreads()' if c>32 or frontend=='input' else 'no CTA shared exchange',
           'Synchronizes producer/read/overwrite lifetimes. A cached global load is not a synchronization operation.')]
    if mode in ('downsample','input-down'):
        rows.append(('Raw pooling','shfl.sync.idx.b32 at XOR offsets0,4,16,20; three HalfAdd + HalfMul(¼)','Retains raw Y before publication. This is a lane/tile permutation, not a shared-memory swizzle.'))
    if mode=='upsample' or frontend=='output':
        rows.append(('Nearest repetition','shfl.sync.idx.b32 with the explicit source-lane equation','Reuses each low result for four high pixels; no globally materialized expanded field.'))
    if mode=='upsample':
        rows.append(('Transition contraction','source HalfMul + HalfAdd → measured SM120 HFMA2','The source helper boundary does not preserve a separately rounded skip product. The emitted fused merge has one Half rounding for this multiply-add.'))
    if frontend:
        rows.append(('Renderer sampling','NativeTexture2d → tex.2d.v4.f32.f32','Opaque texture object + floating coordinates; filtering/address modes come from host configuration.'))
        if frontend=='output':rows.append(('Final pixel','sust.p.2d.v4.b32.zero','Formatted surface sample coordinate; float4 bits, not the native feature-buffer layout.'))
    if frontend!='output':rows.append(('Packed publication store','st.global.L1::no_allocate.b128','Aligned16-byte output. The hint avoids L1 allocation; it is not proof that a write bypasses all caches.'))
    table='<div class="table-scroll"><table><thead><tr><th>Stage / trick</th><th>Source instruction or operation</th><th>Data movement and claim to check</th></tr></thead><tbody>'+''.join('<tr>'+''.join('<td>'+escape(x)+'</td>' for x in row)+'</tr>' for row in rows)+'</tbody></table></div>'
    return '<h3 id="instruction-ledger">Instruction and optimization ledger</h3><p>Use this ledger while following the excerpts. Source establishes the operation and its data contract; the measurement panel must establish instruction counts, transaction efficiency, stalls and duration. An optimization mechanism alone does not prove a speedup over an alternative implementation.</p>'+table
