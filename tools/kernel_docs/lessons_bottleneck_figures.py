"""Source-derived teaching figures for the ten C1024 kernel lessons.

Sizes in this module are source calculations, never profiler measurements.
"""
from html import escape
from common import code, svg


def label(x, y, value, size=15):
    return f'<text x="{x}" y="{y}" style="font-size:{size}px;font-weight:500">{escape(str(value))}</text>'


def rect(x, y, w, h, lines, kind='tensor'):
    return (f'<rect class="{kind}" x="{x}" y="{y}" width="{w}" height="{h}" rx="7"/>'
            + ''.join(label(x+12, y+25+i*22, s, 14) for i, s in enumerate(lines.split('|'))))


def edge(x1, y1, x2, y2):
    dx, dy = x2-x1, y2-y1
    length = (dx*dx+dy*dy)**.5
    ux, uy = dx/length, dy/length
    return (f'<path d="M{x1},{y1} L{x2},{y2}" stroke="#527487" stroke-width="2" fill="none"/>'
            f'<polygon points="{x2},{y2} {x2-9*ux+4*uy},{y2-9*uy-4*ux} '
            f'{x2-9*ux-4*uy},{y2-9*uy+4*ux}" fill="#527487"/>')


def fig(title, height, body, caption):
    return svg(title, f'0 0 1060 {height}', body, caption)


def cta_geometry(kind, fp8):
    """Show one actual output tile inside the whole tensor and its K slice."""
    if kind == 'attention':
        return fig('C1024 attention: CTA (head 7, query block 1) inside the global problem', 375,
            rect(20,25,310,115,'Whole head-7 interaction matrix|2160 real queries × 2176 key slots|34 iterations of 64 keys|32 output channels per query')+
            edge(330,82,370,82)+rect(370,25,325,115,'CTA block.x=7, block.y=1|queries 256…511 × head 7|every one of the 34 key tiles|final output: 256 × 32 values','compute')+
            edge(695,82,735,82)+rect(735,25,305,115,'Iteration j=2|queries 256…511 × keys 128…191|QKᵀ reduces 32 head channels|E×V reduces these 64 keys','compute')+
            rect(20,190,485,105,'Grid = (32 heads, ceil(2160/256), 1)|= (32, 9, 1): 288 CTA invocations|block = (32 lanes, 4 warps, 1) = 128 threads|last query CTA has 112 real queries','storage')+
            rect(545,190,495,105,'One CTA reuses a key/value panel across 256 queries|Q and output states remain private to that CTA|No inter-CTA numerator or denominator reduction|The 16 traversal-only keys contribute zero V','storage')+
            label(25,345,'This is a concrete 4K workload calculation. Profiler launch evidence is separately labeled in the resource section.'),
            'The selected query 355 lies inside this CTA. The key axis is streamed; the query axis stays assigned to the CTA for the whole kernel.')
    k = 4096 if kind == 'contract' else 1024
    n = 4096 if kind == 'expand' else 3072 if kind == 'qkv' else 1024
    ntile = 192 if kind == 'qkv' else 128
    splits = 1 if kind == 'expand' else 2 if kind == 'qkv' else 4
    sk = k//splits
    cols = n//ntile
    chosen = 'head pair 3: columns 576…767' if kind == 'qkv' else 'channel block 0: columns 0…127'
    splitline = 'complete K0…1023; no split scratch' if splits == 1 else f'one K{sk} slice; {splits} ordered partials'
    inner = rect(20,25,300,115,f'Whole logical result|2160 tokens × {n} columns|reduction width K={k}|FP8 bytes' if fp8 else f'Whole logical result|2160 tokens × {n} columns|reduction width K={k}|FP16 Half values')
    inner += edge(320,82,355,82)+rect(355,25,350,115,f'One CTA: M128 × N{ntile}|token tile 0: rows 0…127|{chosen}|{splitline}','compute')
    inner += edge(705,82,740,82)+rect(740,25,300,115,f'block=(32,4,1)|128 threads / 4 warps|{128*ntile:,} Half partial elements|{128*ntile*2:,} bytes if materialized','storage')
    inner += rect(20,190,485,105,f'Mtiles=ceil(2160/128)=17|{cols} column tiles × 17 token tiles|{cols*17} XY tiles × {splits} K slice(s)|{cols*17*splits} logical CTA invocations','storage')
    inner += rect(545,190,495,105,f'Last token tile starts at 2048|112 real rows: 2048…2159|stored alignment={32 if fp8 else 16} rows|missing groups are predicated or zero-filled','storage')
    inner += label(25,345,'Split kernels may use complete stream-ordered XY launches; logical CTA work does not imply concurrent residency.')
    return fig(f'C1024 {kind} {"FP8" if fp8 else "FP16"}: concrete CTA subproblem',375,inner,
        'Geometry is calculated for T=2160 from the source tile dimensions, rather than inferred from an unrelated matrix multiply benchmark.')


def lane_ownership(kind, fp8):
    """Draw named register words instead of a generic thread-block banner."""
    attention = kind == 'attention'
    qkv = kind == 'qkv'
    token = 355 if attention else 83
    base = 352 if attention else 80
    channel = 18 if qkv else 2 if attention else 34
    rows = [(0,token,channel,channel+1),(1,token+8,channel,channel+1),
            (2,token,channel+8,channel+9),(3,token+8,channel+8,channel+9)]
    inner = rect(20,20,340,110,f'Warp {1 if attention else 3 if qkv else 2}, lane L=13|g=L//4=3; q=L%4=1|selected M16 base row={base}|selected result: token {token}, channel {channel}','compute')
    for i,(word,t,c0,c1) in enumerate(rows):
        inner += rect(400+(i%2)*325,20+(i//2)*105,305,90,f'D word {word}: one Half2|low: ({t},{c0})|high: ({t},{c1})','storage')
    inner += rect(20,180,340,100,('Persistent denominator ownership|lane 3: low=query 323|high=query 355|shuffle high value back to lane 13' if attention else 'One token crosses four adjacent lanes|lanes 12–15 own its channel pieces|lane 13 is not a scalar dot-product worker|all 32 lanes issue one MMA together'),'storage')
    inner += rect(400,255,630,110,f'Native A word i: row=3+8(i mod2)|native K coordinates={"4 + 16 floor(i/2) + byte(0…3)" if fp8 else "2 + 8 floor(i/2) + half(0…1)"}|B operand ownership uses column=floor(L/4), not D’s column pair|Separate operand maps make the same warp-wide matrix product possible.','tensor')
    inner += label(25,403,('FP8 operand K coordinates must also be decoded through the model-channel packing permutation.' if fp8 else 'For Half, the native panel K coordinate directly names the channel inside that K16 panel.'))
    return fig(f'{kind}: token {token} in the actual lane-13 register words',430,inner,
        'Word numbers 0/1 are the first N8 result and 2/3 are the second. The neighboring token is shown only because Half2 fragment ownership couples their register containers.')


def resource_budget(kind, fp8, path):
    E = 1 if fp8 else 2
    rows = []
    if kind == 'attention':
        stage = 2048*E
        shared = 4*stage+16
        cap = 168
        rows = [('Shared K slots',f'2 × {stage:,} = {2*stage:,} bytes'),
                ('Shared V slots',f'2 × {stage:,} = {2*stage:,} bytes'),
                ('Barriers','2 × 8 = 16 bytes'),
                ('Persistent Q','4 × '+str(1 if fp8 else 2)+' × 4 = '+str(16*E)+' 32-bit words/lane'),
                ('Persistent numerator / denominator','32 words + 1 Half2 word per lane'),
                ('Current score / exponent tile','4 × 8 × 2 = 64 32-bit words per lane'),
                ('Current K / V arrays',f'{16*E} / {16*E} 32-bit words per lane; phase-local lifetimes')]
        profile = 'csrc/kernel_impl/bottleneck_c1024_attention/common/global_attention.cuh'
        lines=(12,21)
    else:
        subt = 2
        stages = 3 if kind=='expand' or (kind=='contract' and not fp8) else 2
        step = 64 if fp8 and kind in ('expand','contract') else 32
        subt=step//(32 if fp8 else 16)
        stage=step*16*E*8
        shared=stages*(stage+8)
        ng=6 if kind=='qkv' else 4
        cap=255 if kind=='qkv' and not fp8 else 168
        rows=[('A stage',f'8 groups × 16 tokens × K{step} × {E} bytes = {stage:,} bytes'),
              ('A ring',f'{stages} × {stage:,} = {stages*stage:,} data bytes'),
              ('Barriers',f'{stages} × 8 = {stages*8} bytes'),
              ('Accumulator array',f'4 × {ng} × 4 = {16*ng} 32-bit Half2 words per lane'),
              ('A register array',f'4 × {subt} uint4 = {16*subt} 32-bit words per lane'),
              ('B register array',f'{subt} × {ng} uint4 = {4*subt*ng} 32-bit words per lane')]
        if kind in ('contract','projection'):
            rows += [('Residual scale array','4 × 2 = 8 words/lane, only in split 0; residual vectors are temporary'),
                     ('Global partial allocation','Tstored × 1024 × 2 bytes; output aliases it in FP16, separate scratch in FP8')]
        if kind=='qkv':
            rows += [('Global split partials','3 × Tstored × 1024 × 2 bytes; three output aliases in FP16, separate scratch in FP8')]
        profile='csrc/kernel_impl/bottleneck_c1024_ffn/common/global_ffn_expand.cuh' if kind=='expand' else 'csrc/kernel_impl/bottleneck_c1024_attention_ffn_projection/common/global_contract.cuh'
        lines=(11,21) if kind=='expand' else (12,29)
    table='<div class="table-scroll"><table><thead><tr><th>Source object</th><th>Exact source-derived size</th></tr></thead><tbody>'
    table+=''.join(f'<tr><td>{escape(a)}</td><td>{escape(b)}</td></tr>' for a,b in rows)
    table+=f'<tr><td>Total declared shared allocation</td><td><strong>{shared:,} bytes/CTA</strong>, aligned to 512 bytes</td></tr>'
    table+=f'<tr><td>Register directive</td><td>__maxnreg__({cap}): compiler cap, not a measured count</td></tr></tbody></table></div>'
    return (f'<p>The budget starts from the actual arrays. A uint4 is four 32-bit words; a Half2 word holds two values. This entry declares exactly <strong>{shared:,} shared bytes</strong> per CTA, including every 8-byte barrier. Alignment constrains the base address; it does not add 512 bytes to the declared size.</p>'+table+
        '<p>Do not sum the rows into a claimed hardware register count. Inlining, scheduling, temporary values, lifetime overlap and spilling determine the compiled allocation. The source cap can force different code generation and does not establish occupancy. A resource report must identify this entry, precision, target GPU and binary; achieved occupancy additionally depends on the launch and runtime behavior.</p>'+
        code(profile,*lines,'The profile expressions behind the budget')+code(path,6,18 if kind in ('contract','projection') else 12,'Public entry: register directive and shared storage declaration')+
        '<!-- RESOURCE_EVIDENCE -->')


def execution_flow(kind, fp8):
    """Control-flow, not an operand-lifetime diagram; loops have explicit back edges."""
    if kind=='attention':
        stages=2; steps=34
        nodes=['Initialize two barriers|Wait Q predecessor; load Q once',
               'Wait predecessors for K/V 0 and 1|issue paired copies; wait stage 0',
               'Read K[j] → QKᵀ → exponent E|D += row sum(E); N += Publish(E)×V',
               'If j+2<34: predecessor wait|retires readers; refill slot j mod2',
               'If j+1<34: wait that K/V slot|advance j; keep Q, N and D live',
               'Correct 16 padded-key weights|reciprocal → scale N → store output']
    else:
        stages=3 if kind=='expand' or (kind=='contract' and not fp8) else 2
        steps=(16 if fp8 else 32) if kind in ('expand','contract') else 16 if kind=='qkv' else 8
        nodes=[f'Initialize {stages} mbarriers; CTA barrier|decode token/channel/split owner',
               f'Load B0; stage {"A0, A1, A2" if stages==3 else "A0"}|'+('wait A0; seed C with residual in split 0' if kind in ('contract','projection') else 'wait A0; initialize Half C'),
               'All 32 lanes cooperate|read A[i] → ordered mma.sync into C',
               ('Load B[i+1]; wait A[i+1]|refill retired slot with A[i+3]' if stages==3 else 'Other slot receives A[i+1]|load B[i+1]; wait that slot'),
               f'Advance i through {steps} K steps|'+('stop refills and drain the ring' if stages==3 else 'peel last ready tile out of loop'),
               ('Half activation → final format|valid-group no-allocation stores' if kind=='expand' else 'Order global split publication|'+('final split: norm Q/K, transpose V' if kind=='qkv' else 'first store / middle add / final store'))]
        if kind in ('contract','projection') and stages==2:
            nodes[2]='SM<90: issue next A[i+1] copy|all targets: read current A[i]|ordered MMA consumes current B[i]'
            nodes[3]='SM90+: issue next A[i+1] copy|all targets: load B[i+1]|wait completed stage (i+1) mod2'
    positions=[(20,25),(375,25),(730,25),(730,175),(375,175),(20,175)]
    inner=''
    for i,((x,y),value) in enumerate(zip(positions,nodes)):
        inner+=rect(x,y,310,95,f'{i+1}. '+value,'compute')
    inner+=edge(330,72,370,72)+edge(685,72,725,72)+edge(885,120,885,170)+edge(730,222,690,222)+edge(375,222,335,222)
    inner+='<path d="M530,175 L530,145 L710,145 L710,105 L730,105" stroke="#c77b32" stroke-width="2" fill="none"/><polygon points="730,105 721,101 721,109" fill="#c77b32"/>'
    inner+=label(550,140,'next iteration',13)
    inner+=label(25,315,('Contraction/projection two-slot kernels: SM<90 prefetches before current MMA; SM90+ after.' if kind in ('contract','projection') and stages==2 else 'Readiness waits include copy completion. Refill additionally needs all old readers to have advanced.'),14)
    inner+=label(25,345,'This diagram expresses dependencies and instruction order; it is not a measured GPU-cycle timeline.',14)
    return fig(f'{kind} {"FP8" if fp8 else "FP16"}: execution and ring control flow',370,inner,
        'The back edge means the same resident CTA repeats work. It is not a new kernel launch or a new warp.')


def bank_trace(kind, fp8):
    E=1 if fp8 else 2
    if kind=='attention':
        shared=512*E+208; vector=9*16384*E+7*512*E+208
        selected='key tile 2, K group 9, chunk 0'
        globaldesc=f'K vector +{vector:,} bytes'
        token='query 355 meets keys 144…159'
        producer=(2 if not fp8 else 1)
        route=f'For the selected K group 9/chunk 0 in key tile 2, copySlot={2 if not fp8 else 1}, so producer warp {producer} writes its panel. All four query warps can consume that staged K data; query 355 uses warp 1. Q itself takes the separate cached global-to-register path.'
    else:
        step=64 if fp8 and kind in ('expand','contract') else 32
        group=step*16*E
        subt=step//(32 if fp8 else 16)
        stages=3 if kind=='expand' or kind=='contract' and not fp8 else 2
        i=3 if kind=='expand' else 2
        k=4096 if kind=='contract' else 1024
        split=0 if kind=='expand' else 512 if kind=='qkv' else k//4
        shared=(i%stages)*group*8+5*group+208+(subt-1)*512
        vector=(5*k+split+i*step)*16*E+208+(subt-1)*512
        selected=f'group 5; step {i}; native K panel {subt-1}'
        globaldesc=f'A vector +{vector:,} bytes'
        token='token 83 is row 3 of group 5'
        producer=3 if kind in ('qkv','projection') and not fp8 else 1
        copy=2 if producer==3 else 1
        consumer=3 if kind=='qkv' else 2
        route=(f'The selected group 5/native panel {subt-1} is written by producer warp {producer}, copy-loop index {copy}. '
               f'On the portable path its lane 13 issues the selected 16-byte packet; consumer warp {consumer}, lane 13 later loads it into A registers. '
               +('For the 1024-byte copy this packet is the second 512-byte stripe.' if group==1024 and kind not in ('qkv','projection') else 'The producer operation is one 512-byte native panel.'))
    inner=rect(20,25,325,110,f'{token}|{selected}|{globaldesc}|16-byte lane vector, L=13','tensor')
    inner+=edge(345,80,385,80)+rect(385,25,315,110,f'Shared byte offset={shared:,}|unchanged native packed fragment|lane-vector stride=16 bytes|no XOR address swizzle here','storage')
    inner+=edge(700,80,735,80)+rect(735,25,305,110,'Aligned uint4 read|four 32-bit register words|already in operand order|no ldmatrix or shared transpose','storage')
    for i in range(4):
        off=shared+4*i; bank=(off//4)%32
        inner+=rect(20+260*i,200,245,100,f'word {i}: byte {off:,}|word address={off//4}|bank={off//4} mod32={bank}','compute')
    inner+=label(25,345,'Bank IDs repeat across larger warp requests. Transaction partitioning and broadcast rules determine conflicts.',14)
    inner+=label(25,375,'Use source-correlated shared transactions / bank-conflict evidence before claiming a conflict-free execution.',14)
    return fig(f'{kind} {"FP8" if fp8 else "FP16"}: numerical shared address and bank map',400,inner,
        'The storage trick is to preserve a prepacked MMA layout. An XOR swizzle would be an invented operation for these C1024 bodies.')+f'<p>{route} On SM90+, one elected lane issues the whole bulk transfer; the consuming register ownership is unchanged. The producer warp and the compute warp are separate coordinates in the design.</p>'


def trace_start(kind, fp8):
    if kind=='attention':
        return '''<p>Follow <strong>query token 355, head 7, output channel 2</strong>. Its CTA is (7,1), warp 1, M16 tile 2, lane 13, low Half of output Pair[0][0]. The full 32-channel token is distributed over lanes 12–15 and four N8 fragments; the worked scalar makes one path concrete. First keep Q in registers, then inspect key tile 2 (keys 128–191), accumulate the same token’s numerator/denominator over all 34 tiles, and finally return its denominator from lane 3’s high Half to the output owners.</p>'''
    out='Q[83,7,18]' if kind=='qkv' else ('U' if kind=='expand' else 'Z' if kind=='contract' else 'Y')+'[83,34]'
    return f'''<p>Follow <strong>token 83</strong> and, within it, <strong>{out}</strong>. Token 83 is group 5, row 3; it belongs to token CTA 0, warp {3 if kind=='qkv' else 2}, M16 fragment 1, lane 13’s first output row. Lane 13 also carries token 91 because the instruction’s output fragment has two row halves. We retain token 83 as the trace identity throughout: global packed input → shared operand stage → A/B registers → Half accumulator → {'split partial → normalized Q publication' if kind=='qkv' else 'activation → final output' if kind=='expand' else 'ordered split partials → final output'}. Adjacent channels and lanes appear only when the collective instruction requires them.</p>'''


def mma_trace(kind, fp8):
    if kind=='attention':
        return ''
    ng=6 if kind=='qkv' else 4
    subt=1 if fp8 and kind in ('qkv','projection') else 2
    n=18 if kind=='qkv' else 34
    bowner=9
    E=1 if fp8 else 2
    i=3 if kind=='expand' else 2
    step=64 if fp8 and kind in ('expand','contract') else 32
    K=4096 if kind=='contract' else 1024
    split=0 if kind=='expand' else 512 if kind=='qkv' else K//4
    nativek=split+i*step+(subt-1)*(32 if fp8 else 16)+(4 if fp8 else 2)
    modelk=nativek-2 if fp8 else nativek
    aaddr=(5*K+split+i*step)*16*E+208+(subt-1)*512
    N=4096 if kind=='expand' else 3072 if kind=='qkv' else 1024
    nbase=672 if kind=='qkv' else 0
    ngroup=1 if kind=='qkv' else 2
    baddr=(128 if kind=='qkv' else 0)+(split+i*step)*N*E+nbase*32+144+(subt-1)*N*32+ngroup*512
    modelnote=('Native K slot 4 belongs to model slot 2 within this packed K32 panel; the input and weight packers perform the matching channel permutation.' if fp8 else 'Native K slot 2 is model channel 2 within this K16 panel.')
    body=f'''<h3>Follow one multiplication into the token’s accumulator</h3>
<p>Within the selected native panel, choose A row 3 and native K slot {4 if fp8 else 2}. Lane 13 owns that A scalar in word 0’s lowest {'byte' if fp8 else 'Half'}. The matching B scalar for {'head-7 local output column '+str(n)+' (matrix column '+str(672+n)+')' if kind=='qkv' else 'output column '+str(n)} is owned by <strong>lane {bowner}</strong> (its g=2 and q=1), also in the lowest {'byte' if fp8 else 'Half'} of its first B word. The output scalar is lane 13’s low Half. The A owner, B owner and result owner therefore need not be the same lane. The Tensor Core instruction consumes the warp’s distributed operands collectively; an individual lane does not calculate a private {K}-element dot. {modelnote}</p>
<p>Carry the earlier byte calculation down to one scalar: A’s selected value is the lowest {'byte' if fp8 else 'Half'} at input offset <strong>{aaddr:,}</strong>, so its model coordinate is <strong>(token 83, channel {modelk})</strong>. The matched weight is at offset <strong>{baddr:,}</strong> from the weight-record base, in lane 9’s vector. The earlier lane-13 B-vector example is a different operand fragment; it must not be mistaken for this selected weight. {'The native reduction coordinate is '+str(nativek)+' and the model channel is '+str(modelk)+', after undoing the input permutation.' if fp8 else 'The K16 panel and scalar coordinates add directly to the model input channel.'}</p>
<p>For this token’s row, A is reused across {ng*2} N8 panels. Each B fragment is reused across four M16 token panels. The unrolled helper iterates M16, then N16, then K subtile, issuing the lower N8 before the upper N8. That gives <code>4 × {ng} × {subt} × 2 = {4*ng*subt*2}</code> warp-level MMA instructions per reduction step. Counts are source-derived instruction invocations, not SASS counts or timing measurements.</p>'''
    return body+code('csrc/kernel_impl/shared/common/tiled_mma.cuh',24,46,'The exact operand reuse and lower/upper N8 instruction order')+code('csrc/kernel_impl/shared/common/intrinsics.cuh',189 if fp8 else 216,202 if fp8 else 229,'The precision-specific MMA instruction consumes register fragments')


def instruction_evidence(kind, fp8):
    rows=[('Packed input → shared','SM80/89: cp.async.cg.shared.global, 16 bytes/lane; SM90+: ordinary-address cp.async.bulk with completion bytes','Coalesced lane stripes or elected bulk issuer; avoids a register-mediated copy.'),
          ('Shared stage → operand registers','Aligned uint4 C++ load; inspect compiled LDS instructions','The producer already supplied native MMA word order; there is no XOR swizzle or ldmatrix in this source path.'),
          ('Weights / Q → registers','__ldca vector load','Permits all-level caching. Source alone cannot establish a hit rate.'),
          ('Half compute','mma.sync + packed Half scalar/vector helpers','Keeps partial sums in registers. Check SASS contraction before assigning a rounding boundary to each inline helper.'),
          ('Output → global','st.global.L1::no_allocate.b128','Publishes one 16-byte vector without requesting a new L1 line; this hint is not a fence.'),
          ('Stage dependency','mbarrier arrival token + copy completion','Prevents consumption of unfinished asynchronous transactions; slot retirement is a separate dependency.')]
    if kind!='expand':
        rows += [('Cross-kernel/split readiness','relaxed counter loads, CTA barrier, release stores; acquire only where present','The host launch protocol and exact source branch define visibility and progress.')]
    table='<h3>Instruction claims and how to evaluate them</h3><div class="table-scroll"><table><thead><tr><th>Trace transition</th><th>Source instruction or operation</th><th>Mechanism to check</th></tr></thead><tbody>'
    table+=''.join('<tr>'+''.join('<td>'+escape(v)+'</td>' for v in row)+'</tr>' for row in rows)
    return table+'</tbody></table></div><p>Each mechanism above is established by its source excerpt; performance consequences require the accompanying profile. A low cache-hit rate, spills or a bank-conflict count would change the optimization assessment without changing the logical ownership derivation. Inspect the reported workload and binary identity before treating a measurement as evidence for this lesson.</p><!-- NCU_EVIDENCE -->'


def token_reduction(kind, fp8):
    if kind=='attention':
        inner=label(25,25,'Query 355, head 7: the exact denominator ownership transfer for the upper 32-query half')
        for j in range(4):
            x=20+j*260
            inner+=rect(x,55,245,110,f'Lane {12+j}: query 355|E keys 128+2×{j}, +1|plus its other seven N8 pairs|local query-row register 0','tensor')
            inner+=edge(x+120,165,520,218)
        inner+=rect(310,220,430,110,'Destination lane 3: sourceLane=12|read shuffled register j from lane 12 XOR j|source first permutes registers by lane mod4|all four reads now carry query 355 pieces','compute')
        inner+=edge(520,330,520,365)+rect(310,370,430,95,'Add register 0+1, then 2, then 3|add low/high Half components|D.high in lane 3 accumulates query 355','storage')
        inner+=edge(310,417,270,417)+rect(20,370,250,95,'After all 34 key tiles|correct padding; reciprocal|ShuffleIdx from lane 3|select high Half','compute')
        inner+=rect(780,370,260,95,'Back to lane 13|Pair[0][0].low: query 355|multiply numerator channel 2|publish the traced output','tensor')
        inner+='<path d="M145,465 L145,480 L910,480 L910,465" stroke="#527487" stroke-width="2" fill="none"/>'
        inner+=label(25,503,'No shared reduction array is allocated. The register permutation preserves the recorded Half addition order.',14)
        return fig('Trace query 355 through the register-ownership transpose',530,inner,
            'The sourceLane equation is evaluated in destination lane 3. At source lane 13, XOR permutation moves original row-register 0 into register 1, which destination lane 3 reads from lane 13.')
    inner=label(25,25,'Token 83, head 7: normalize the complete Q vector only after split 1 adds split 0')
    for j in range(4):
        x=20+j*260
        inner+=rect(x,55,245,110,f'Lane {12+j}, row 3|channels {2*j}/{2*j+1}, {8+2*j}/{9+2*j}|and {16+2*j}/{17+2*j}, {24+2*j}/{25+2*j}|SM120: HMUL2 → HFMA2','tensor')
    inner+=rect(20,205,315,115,'Within lanes 12–15|XOR2: 13 exchanges with 15|XOR1: then 13 exchanges with 12|add swapped Half components','compute')
    inner+=edge(335,263,375,263)+rect(375,205,315,115,'Both Half fields now equal|sum of this token’s 32 squares|max with epsilon 0x0410|rsqrt approximation → Half','compute')
    inner+=edge(690,263,730,263)+rect(730,205,310,115,'Return inverse to local channels|Half-multiply Q[83,7,18]|then Half sqrt(32), then scale[7]|K omits the two Q-only scales','tensor')
    inner+=label(25,370,('FP8 uses one inverse calculation because the squared-sum word has identical Half components.' if fp8 else 'FP16 uses RsqrtHalf2; V bypasses this reduction and instead uses movmatrix register transposition.'),14)
    return fig('Trace token 83 through the Q/K head reduction',400,inner,
        'Lane 13’s channel 18 is one of the selected token’s 32 channels. In the captured binary, one square rounds in HMUL2 and the other square contracts with its paired add in HFMA2. Four adjacent lanes then reduce this token/head’s channel pieces.')


def value_transpose(fp8):
    inner=label(25,25,'Follow V[83, head 7, channel 18] through movmatrix: the value survives; its owner changes.')
    for panel,x in enumerate((55,590)):
        inner+=label(x,58,'Before: row 3, column 2' if panel==0 else 'After: row 2, column 3')
        for r in range(8):
            for c in range(8):
                hit=(r,c)==((3,2) if panel==0 else (2,3))
                inner+=f'<rect x="{x+c*42}" y="{80+r*25}" width="39" height="23" fill="{"#e8a14d" if hit else "#e9f0f7"}" stroke="#829caf"/>'
                if hit: inner+=label(x+c*42+3,97+r*25,'V',13)
        inner+=label(x,310,'lane = 4×3 + floor(2/2) = 13' if panel==0 else 'lane = 4×2 + floor(3/2) = 9',14)
        inner+=label(x,337,'component = column mod2 = 0 (low Half)' if panel==0 else 'component = column mod2 = 1 (high Half)',14)
    inner+=edge(425,180,550,180)+label(437,165,'transpose',13)
    inner+=rect(20,375,490,90,'The same operation runs for every V word|M16 tile 1, upper N16 panel, word 0|the selected scalar moves lane 13 → lane 9','compute')
    inner+=rect(550,375,490,90,('FP8 final V: vector base 73,360 bytes|odd token group is output word 1; byte 1|selected scalar is byte offset 73,365' if fp8 else 'FP16 final V: vector base 171,664 bytes|selected scalar is word 0 high Half|selected scalar is byte offset 171,666'),'storage')
    return fig('Token 83: register-to-register V transpose with exact lane ownership',490,inner,
        'The highlighted 8×8 submatrix is inside the selected M16/N16 tile. The row-major per-lane packing follows the <a href="https://docs.nvidia.com/cuda/parallel-thread-execution/index.html#warp-level-matrix-instructions-movmatrix">PTX movmatrix specification</a>; no shared transpose buffer is allocated.')
