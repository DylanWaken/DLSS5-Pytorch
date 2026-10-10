"""One reconstructable, precision-specific lesson for every local-window entry."""
from pathlib import Path
from html import escape
import re
from common import code, svg, note
from lesson_support import pseudo, mma_primer, storage_legend

ROOT = Path(__file__).resolve().parents[2]
BASE = 'csrc/kernel_impl/shared/common/'
WIDE = BASE + 'warp_window_wide.cuh'
W32 = BASE + 'warp_window32.cuh'


def excerpt(path, needle, after=20, before=0, caption=''):
    lines = (ROOT / path).read_text(encoding='utf-8').splitlines()
    found = [i for i,line in enumerate(lines) if needle in line]
    if not found:
        raise ValueError(f'Missing lesson source anchor {path}: {needle}')
    start = max(0, found[0] - before)
    return code(path, start+1, min(len(lines), found[0]+after+1), caption)


def text(x,y,s,size=15):
    return f'<text x="{x}" y="{y}" fill="#183447" font-family="system-ui,sans-serif" font-size="{size}">{escape(str(s))}</text>'


def box(x,y,w,h,lines,fill='#e9f2fb'):
    return f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="8" fill="{fill}" stroke="#668296"/>'+''.join(text(x+12,y+25+22*i,s) for i,s in enumerate(lines))


def arrow(x1,y1,x2,y2):
    import math
    a=math.atan2(y2-y1,x2-x1)
    p=(x2-9*math.cos(a)+4*math.sin(a),y2-9*math.sin(a)-4*math.cos(a))
    q=(x2-9*math.cos(a)-4*math.sin(a),y2-9*math.sin(a)+4*math.cos(a))
    return f'<path d="M{x1},{y1} L{x2},{y2}" stroke="#4c6d80" stroke-width="2" fill="none"/><polygon points="{x2},{y2} {p[0]},{p[1]} {q[0]},{q[1]}" fill="#4c6d80"/>'


def architecture(c, fp8, mode):
    fmt='E4M3' if fp8 else 'Half'
    branch='Dense 32 → 128 → 32' if c==32 else f'{c//32} full-input {c} → 128 → 32 branches'
    intro= {'upsample':[f'Low [4,4,{2*c}] + skip [8,8,{c}]',f'{2*c} → {c}; repeat; scaled skip add'],
            'downsample':[f'Input [8,8,{c}]',f'save high skip; pool + {c} → {2*c}'],
            'input_view':[f'Input spatial planes: logical [8,8,{c}]','word gather directly into MMA fragments'],
            'output_view':[f'Input physical tiles: logical [8,8,{c}]','final words stored into spatial planes'],
            'ordinary':[f'Input physical tiles: logical [8,8,{c}]','ordinary size-preserving block']}[mode]
    s=box(20,25,490,80,intro)+arrow(510,65,565,65)+box(565,25,485,80,[branch,'scale × input seeds the FFN accumulator'],'#e6f4e9')
    s+=box(20,160,300,110,[f'Published Z [64,{c}] ({fmt})',f'QKV: {c} → {3*c}',f'{c//32} heads × 32 channels','Q/K channel norm; Q scale'])
    s+=box(380,160,310,110,['Each head: Q[64,32] × Kᵀ','scores + learned bias [64,64]','surrogate → row normalization','P[64,64] × V[64,32]'],'#fff0d5')
    s+=box(750,160,300,110,[f'Join heads → {c} channels',f'output projection {c} → {c}','add scaled attention residual',f'Publish {fmt}; final destination'])
    s+=arrow(805,105,170,160)+arrow(320,215,380,215)+arrow(690,215,750,215)
    s+=text(20,314,'The diagram is a tensor graph. The following construction decides which arrows stay in registers or shared memory.')
    return svg(f'C{c} {fmt} {mode}: model operation','0 0 1080 345',s,'One 8 × 8 window is the working unit. Logical tensor shapes do not imply global allocations.')


def token_map(c,fp8):
    s=text(20,25,'Natural token / physical token inside the 8 × 8 window',18)
    for y in range(8):
        for x in range(8):
            p=(y//4)*32+(x//4)*16+(y%4)*4+x%4
            fill=['#e5f4e9','#e9f2fb','#fff0d5','#f0e8fa'][(y//4)*2+x//4]
            s+=box(20+x*70,50+y*40,65,35,[f'{8*y+x}/{p}'],fill)
    s+=box(615,65,430,130,['Accumulator C32 panel, lane L','row = L/4 + 8 × rowHalf','channel = 32×panel + 8×column + 2(L%4)','lane 6: physical rows 1 and 9','column 2: panel-relative channels 20,21'])
    s+=box(615,230,430,130,[f'{c//32} C32 panels; {1 if fp8 else 2} K chunks per panel',f'4 words × 4 bytes × 32 lanes = 512 B/chunk',f'C32 physical tile: {512 if fp8 else 1024} bytes',f'C{c} physical tile: {16*c*(1 if fp8 else 2)} bytes','natural token 13 (5,1) → physical token 21'])
    return svg(f'C{c} token-to-fragment map','0 0 1080 390',s,'Lane and accumulator equations are defined in warp_window32.cuh; tiled_token in weights.py defines the physical token permutation.')


def addresses(c,fp8,mode):
    b=1 if fp8 else 2; chunks=1 if fp8 else 2; p=0 if c==32 else 1; ch=chunks-1
    tile=7*16*c*b+p*512*b+ch*512+6*16
    plane=p*2*chunks+2*ch+1; spatial=((plane*8+2)*16+1)*16+8
    weight=32//(32 if fp8 else 16)*128*32+512+6*16
    s=box(20,25,490,116,['Physical tile example: tile 7; lane 6',f'panel {p}; chunk {ch}; C={c}; elementBytes={b}',f'7×{16*c*b} + {p}×{512*b} + {ch}×512 + 96',f'= allocation base + {tile} bytes'])
    s+=box(565,25,490,116,['Spatial view example: H=8,W=16,word=2',f'x=1,y=2; lane=6; panel={p},chunk={ch}',f'plane={plane}; (((plane×8+2)×16+1)×16)+8',f'= allocation base + {spatial} bytes'],'#fff0d5')
    s+=box(20,205,490,116,['Weight vector example: N=128',f'reductionBase=32; outputBase=16; lane=6',f'({32//(32 if fp8 else 16)}×128×32) + (1×512) + 96',f'= matrix base + {weight} bytes'])
    s+=box(565,205,490,116,['Different address spaces, same token values','tile layout: neighboring lanes → uint4 vectors','view layout: four lanes → one pixel vector','weights: prepacked MMA B, not row-major'],'#e5f4e9')
    s+=arrow(265,141,265,205)+arrow(815,141,815,205)
    return svg(f'{mode} address derivation in {"FP8" if fp8 else "FP16"}','0 0 1080 350',s,'All examples exclude allocation bases. The tile, view, and matrix are independent examples; addresses cannot be copied between their layouts.')


def timeline(c,fp8,mode):
    n=64*c*(1 if fp8 else 2)
    if c==32:
        steps=[('global input → registers','four tile A fragments'),('register FFN panels','raw FFN stays Half'),('register Q/K/V + scores','shuffles; MMA; projection'),('publication → global','raw tile retained if pooling')]
        title='One warp: register lifetimes, no shared exchange slab'
    elif c==64:
        steps=[('FFN token ownership','2 tiles × 2 panels/warp'),('shared published Z','barrier → head ownership'),('register Q/K/V; shared A','barrier → cross-head mix'),('global publication','barrier before slab reuse')]
        title=f'Two warps: {n:,}-byte shared slab changes ownership'
    else:
        steps=[('shared X','all branch warps read'),('shared branch outputs','read-done; store; barrier'),('shared Z','mix; publish; barrier'),('shared attended heads','barrier; all-head projection')]
        title=f'{c//32} warps: {n:,}-byte shared slab changes tensor lifetime'
    s=text(20,25,title,18)
    for i,(a,b) in enumerate(steps):
        x=20+265*i
        s+=box(x,65,245,100,[a,b,'Half accumulators in registers'],'#fff0d5' if c>32 else '#e9f2fb')
        if i<3:s+=arrow(x+245,112,x+265,112)
    s+=box(20,225,495,90,['Global weights → cache-all loads → B registers','Global activations → cache-global loads → A','view reads use explicit 32-bit spatial addresses'])
    s+=box(565,225,490,90,['Tensor Core MMA consumes register fragments','shared is software-owned; caches are hardware-owned','no cp.async / TMA pipeline in these local bodies'])
    if mode=='upsample':tail='Before this timeline: low projection + repeated skip merge; C32 keeps raw merge, wider widths publish shared merge.'
    elif mode=='downsample':tail='After this timeline: raw Half tiles → shuffle pool → publication → channel projection → spatial output planes.'
    else:tail='A barrier protects shared tensor readers before overwrite; a later barrier makes the new publication available.'
    s+=text(20,365,tail,14)
    return svg(title,'0 0 1100 390',s,'A source register array is an ownership model; actual register count and spills require compiled resource information.')


def attention_picture(fp8,c):
    s=text(20,25,'One query row: four lanes own its 64 key columns',18)
    for l in range(4):
        vals=', '.join(f'{8*j+2*l}/{8*j+2*l+1}' for j in range(2))
        s+=box(20+265*l,60,245,100,[f'group lane {l}',f'key pairs {vals}','also add 16, 32, 48 to each pair'])
    s+=box(20,210,490,115,['Q/K norm across 32 CHANNELS','Half square tree → XOR2 → XOR1','swap Half components → sum → rsqrt','one inverse per token; learned scale on Q'],'#e5f4e9')
    s+=box(565,210,490,115,['Attention norm across 64 KEYS','surrogate → local pair sums','lane 0+1, then +2, then +3; reciprocal',f'publish P as {"E4M3" if fp8 else "Half"} → P × V'],'#fff0d5')
    s+=text(20,367,('C32 FP8 computes two query tiles together, transposing row sums so one lane computes one reciprocal.' if fp8 and c==32 else 'This entry normalizes one query tile at a time; output tiles may still be retained in larger projection batches.'),14)
    return svg('Two reductions over different tensor axes','0 0 1100 395',s,'The denominator uses the fixed Half addition order; replacing it by the norm butterfly changes rounding.')


def transition_picture(mode,c,fp8):
    if mode=='upsample':
        s=box(20,30,300,115,[f'Low tile [4,4,{2*c}]',f'{2*c} → {c} projection','16 tokens computed once','result: Half accumulator pairs'])
        s+=box(380,30,325,115,['low token (0,0), source lane 0','destination lanes 0,4,16,20','high pixels (0,0),(1,0),(0,1),(1,1)','same channel pair four times'],'#e5f4e9')
        s+=box(765,30,295,115,['Global high-resolution skip','round(skip × learned scale)','HalfAdd(repeated, scaled skip)','mask; publish; ordinary block'])
        s+=arrow(320,85,380,85)+arrow(705,85,765,85)
        s+=text(20,210,'sourceLane = (L & 3) | ((L >> 1) & 4) | 8(tile & 1) | 16×rowHalf',17)
        s+=text(20,248,'Read projected rowHalf = tile >> 1. No expanded 8 × 8 global projection tensor is needed.',16)
    else:
        s=box(20,30,300,115,[f'Raw output [8,8,{c}] Half','published full skip → global','pool uses the raw register branch','four 4 × 4 source tiles'])
        s+=box(380,30,325,115,['2 × 2 cell: a,b / c,d','HalfAdd(a,b); HalfAdd(c,d)','HalfAdd(two sums); HalfMul(¼)',f'Publish {"E4M3" if fp8 else "Half"} pooled operands'],'#fff0d5')
        s+=box(765,30,295,115,[f'C{c} → C{2*c} channel projection','one 4 × 4 pooled token tile','publish spatial channel planes','write zero in padded cells'])
        s+=arrow(320,85,380,85)+arrow(705,85,765,85)
        s+=text(20,210,'Pool routing swaps tile/row words, then lane bits 2↔3; gathers XOR offsets 0,4,16,20.',17)
        s+=text(20,248,'For a=1,b=2,c=3,d=4, the exact Half tree yields (3+7)×¼=2.5 before publication.',16)
    return svg(f'C{c} {mode}: reconstruct the spatial change','0 0 1100 285',s,'Token repetition and pooling are warp-register exchange operations; channel projections use Tensor Core fragments.')


def mode_intro(c,mode):
    ordinary={32:'records 0–4 and 66–70',64:'records 5–8 and 62–65',128:'records 9–14 and 56–61',256:'records 15–22 and 48–55'}[c]
    tails={32:4,64:8,128:14,256:22}; starts={32:66,64:62,128:56,256:48}
    if mode=='downsample':
        return f'This is encoder tail record {tails[c]}. It computes the full ordinary block, saves its published [H,W,{c}] skip, pools the raw result to [ceil(H/2),ceil(W/2),{c}], then projects to {2*c} channels. The paired decoder later reads this saved skip at record {starts[c]}.'
    if mode=='upsample':
        return f'This is decoder entry record {starts[c]}. It reads a low-resolution {2*c}-channel field, projects to {c} channels, repeats each low token to a high-resolution 2 × 2 patch, and adds the scaled skip from record {tails[c]}. Its ordinary FFN/attention body then produces [H,W,{c}].'
    if mode=='input_view':
        return f'This entry implements the ordinary C{c} block used in {ordinary}, reading a spatial channel-plane view directly. The view changes addressing, not the mathematical block; it lets a preceding transition feed this kernel without a separate repacking pass.'
    if mode=='output_view':
        return f'This entry implements the ordinary C{c} block used in {ordinary}, but publishes into spatial channel planes. The result still has logical shape [H,W,{c}]. Its output layout is designed for a consumer that addresses individual spatial positions.'
    return f'This entry implements the ordinary C{c} block used in {ordinary}. Its logical input and output are both [H,W,{c}], with four physical 4 × 4 tiles forming each 8 × 8 attention window. Frontend and transition records wrap this same operation with additional work.'


def scalar_oracle(c,fp8,mode):
    lines=['# Shape/index oracle. Ordinary sums show mathematics, not bitwise MMA rounding.',
           'P(v) = publish_to_' + ('E4M3' if fp8 else 'Half') + '(v)',
           'for each 8x8 window, using origin = 8*block + configured_origin:']
    if mode=='upsample':
        lines += [f'  lowProjected[y,x,:] = low[y,x,:] @ Wup  # {2*c} -> {c}',
                  '  rawX[y,x,:] = repeat2x2(lowProjected)[y,x,:] + skipScale[:] * skip[y,x,:]',
                  '  rawX = mask_outside_field(rawX)  # clear padding before BOTH FFN consumers',
                  '  X = P(rawX); residualX = ' + ('rawX' if c==32 else 'X')]
    else:
        lines += ['  X = gather_window_from_' + ('spatial_planes' if mode=='input_view' else 'physical_tiles') + '()', '  residualX = X']
    if c==32:lines+=['  Zraw[t,:] = sum_j(P(phi(X[t,:] @ Wexpand[:,j])) * Wcontract[j,:]) + ffnScale * residualX[t,:]']
    else:lines += [f'  for e in range({c//32}):  # every branch reads all {c} input channels',
                    '    branch[e,t,:] = P(P(phi(X[t,:] @ We[e])) @ Wc[e])',
                    '  Zraw[t,:] = concatenate(branch[:,t,:]) @ Wmix + ffnScale * residualX[t,:]']
    lines+=['  Z = P(Zraw)',f'  for head in range({c//32}):',
            '    Qraw,Kraw,Vraw = Z @ Wqkv[head]  # each component has 32 channels',
            '    Q = P(norm32(Qraw) * headScale[head]); K = P(norm32(Kraw)); V = P(Vraw)',
            '    for query in range(64):',
            '      E[key] = surrogate(dot(Q[query],K[key]) + bias[head,query,key])',
            '      Prob = P(E / sum_over_64_keys(E))',
            '      A[query,head,:] = P(Prob @ V)',
            '  Yraw = concatenate_heads(A) @ Wout + attnScale * ' + ('Zraw' if c==32 else 'Z'),
            '  store_valid(P(Yraw), layout=' + ('spatial_planes' if mode=='output_view' else 'physical_tiles') + ')']
    if mode=='downsample': lines += ['  pooled = P(avg2x2_from_raw_Half(Yraw))',f'  low = P(pooled @ Wdown)  # {c} -> {2*c}', '  store_spatial_planes(low); clear_required_padding()']
    return '\n'.join(lines)


def build_body(name,entry,c,fp8,mode,core_only=False):
    path='csrc/'+entry['header']; fmt='E4M3' if fp8 else 'Half'; prec='FP8' if fp8 else 'FP16'
    b=1 if fp8 else 2; chunks=1 if fp8 else 2; k=32 if fp8 else 16; heads=c//32
    tilebytes=16*c*b; panelbytes=512*b; slabbytes=64*c*b; querybatch=4 if c==256 else 2
    model_ffn='a dense 32 → 128 → 32 map' if c==32 else f'{heads} complete-input branches, each {c} → 128 → 32, followed by a {c} → {c} mixing matrix'
    arch=f'''<h2 id="model">1. Define the model operation and the observable outputs</h2>
<p>Target entry: <strong>{escape(name)}</strong>. {mode_intro(c,mode)} The FFN is {model_ffn}. The attention has {heads} head{'s' if heads!=1 else ''}, each with 32 channels. There is no pre-FFN LayerNorm and no sparse routing decision. Every FFN works independently at each token; the attention is where 64 positions exchange information. The <a href="architecture.html">architecture document</a> is useful context, but all mechanics needed for this entry are developed below.</p>
<p>Write the ordinary block as Zraw=FFN(X)+sffn⊙R; Z=Publish(Zraw); Q,K,V=project(Z); A=Publish(normalize_keys(E(QKᵀ+bias))V); Yraw=project(A)+sattn⊙{'Zraw' if c==32 else 'Z'}. This entry publishes working operands as <strong>{fmt}</strong>, while the matrix accumulators, residual products, activation and reductions use packed Half arithmetic. “Raw” identifies a value before the next publication, not an FP32 promise. The model equation alone leaves reduction order and physical placement unspecified; those are the kernel-design problem.</p>
{architecture(c,fp8,mode)}
<h2 id="oracle">2. Write the simple correctness oracle before tiling</h2>
<p>Start with the following nested-loop interpretation. A token index denotes a spatial position, a channel index selects its feature, and a head index selects one 32-channel attention space. The oracle is deliberately expensive: it can materialize every hidden tensor and the 64 × 64 score matrix. It establishes which values may communicate and where publication belongs. To validate the final bit pattern, replace its abstract dot products and sums with the exact Half instruction/reduction order introduced below; a generic FP32 PyTorch implementation is only a mathematical and shape check.</p>
{pseudo(scalar_oracle(c,fp8,mode),'Scalar/reference construction for this exact entry')}
<p>A fully staged implementation would write the hidden FFN tensor, branch concatenation, QKV, scores, probabilities and attended values to global memory, then read them back in separate launches. For one head, a score tensor alone is 4096 Half values, or 8192 bytes; a separate write and read would transfer 16384 logical bytes before considering cache effects. The implementation removes these particular intermediate transfers by choosing an ownership map that keeps their producers and consumers together. The tradeoff is longer register lifetimes, and for multiple warps, explicit shared-memory synchronization.</p>'''
    mapping=f'''<h2 id="ownership">3. Derive the CTA, warp, tile and lane ownership</h2>
<p>Use a CTA shaped (32,{heads},1): x is the warp lane, y is the warp number. One CTA covers an 8 × 8 window whose origin is (8·blockIdx.x+OriginX,8·blockIdx.y+OriginY). Split it into four 4 × 4 tiles, indexed left-to-right then top-to-bottom. A physical tile has 16 token rows, matching the M dimension of the MMA instruction. Each C32 channel panel occupies {panelbytes} bytes, so a C{c} tile occupies {tilebytes} bytes and a whole window holds {slabbytes} published data bytes.</p>
{token_map(c,fp8)}
<p>Natural token t=8y+x is mapped to p=32⌊y/4⌋+16⌊x/4⌋+4(y mod4)+(x mod4). Thus natural token 13, pixel (5,1), is physical token 21 in tile 1. For the output accumulator, lane L owns token rows L/4 and L/4+8 within a tile. In column group j it owns channel pair 8j+2(L mod4), plus the following channel. Lane 6 owns rows 1 and 9; column group 2 gives channels 20 and 21 within its C32 panel. Four neighboring lanes together represent one token's channels. Do not reinterpret these per-lane words as four neighboring BHWC channels.</p>
{code(W32,10,33,'Fragment ownership and complete C32 base-profile offsets')}
{mma_primer(fp8)}
<p><code>FWindowAFragment</code> is four 32-bit operand words per lane. <code>FWindowAccumulatorTile&lt;32&gt;</code> is four N8 column groups, each with two Half2 words for the two row halves. <code>MmaWindowFragment</code> combines a warp-wide A fragment, a two-word-per-lane B fragment, and that accumulator. <code>LinearWindow32</code> performs all four N8 columns and all {chunks} reduction chunk{'s' if chunks!=1 else ''} needed for a C32 input panel. Repeating this helper over input panels extends the K reduction without changing the output ownership.</p>'''
    if c==32:
        ownership='<p>There is one warp, so it can retain all four input token tiles. The FFN and attention do not need a shared exchange slab. The complete logical window is distributed across lanes, and warp shuffles move only the values whose ownership changes. This saves block-wide exchange traffic but requires the warp to keep multiple tensor fragments live. The register cap in the declaration is not a guarantee that a compiler emits no spills.</p>'
    elif c==64:
        ownership='<p>The two warps initially split tokens: warp 0 handles upper tiles 0/1 and warp 1 handles lower tiles 2/3. Each retains both C32 input panels and computes both FFN branches for its own tokens. Once Z is published into shared memory, warp 0 becomes attention head 0 and warp 1 becomes head 1 across all four tiles. The shared boundary is therefore a token-to-head ownership transpose, not merely a convenient cache.</p>'
    else:
        ownership=f'<p>The {heads} warps initially split FFN branches: warp e computes branch e for all four token tiles. Every branch reads all {heads} input channel panels, so X must be available across warps in shared memory. After branch mixing, warp h owns Q/K/V for head h across the complete window. The same number of branches and heads makes the warp count convenient, but their numerical roles and weight matrices remain distinct.</p>'
    p=0 if c==32 else 1; chunk=chunks-1; off=7*tilebytes+p*panelbytes+chunk*512+96
    layout=f'''<h2 id="addresses">4. Derive all three address maps, then implement the input</h2>
<p>For normal activation tiles use <code>G + tileIndex·({tilebytes}) + panel·({panelbytes}) + chunk·512 + lane·16</code>, with <code>tileIndex=tileY·(Width/4)+tileX</code>. The final term makes adjacent lanes load adjacent aligned 16-byte vectors. Tile 7, panel {p}, chunk {chunk}, lane 6 therefore begins at byte {off} from G. A whole warp obtains 512 bytes for one K{k} fragment panel. The packed producer layout removes the need to fetch a dense image and perform a separate runtime packing pass.</p>
<p>The spatial channel-plane map is different: <code>G + (((plane·H+y)·W+x)·16) + 4(lane&amp;3)</code>, where <code>plane=panel·{2*chunks}+2·chunk+word/2</code>, <code>x=originX+((lane/4)&amp;3)</code>, and <code>y=originY+lane/16+2(word&amp;1)</code>. Four lanes gather one 16-byte pixel vector, and the word's low bit changes the token row rather than the channel plane. Half-word or byte order remains the native fragment order inside that vector. This formula is needed {'on the input path' if mode in ('input_view','upsample') else 'on the output path' if mode in ('output_view','downsample') else 'to distinguish this packed-tile entry from a spatial view; this entry itself loads and stores tiles'}.</p>
{addresses(c,fp8,mode)}
<p><code>LoadWindowWeights</code> reads the prepacked B operand. With output count N, reduction base r, output base o, chunk q and 16-output subpanel j, its byte offset is <code>(r/{k}+q)·N·32 + (o/16+j)·512 + lane·16</code>. Each K{k} panel occupies 32 bytes per output column in this precision. For N=128,r=32,o=16,j=0,q=0,lane=6 the offset is {32//k*128*32+512+96}. This is a packed matrix address, not <code>(r·N+o)·sizeof(element)</code>. Load weights once and reuse them across the owned token tiles; the cost is retaining B fragments in registers while A tiles are consumed.</p>
{code(W32,105,128,'Packed B-panel addressing: each lane receives one uint4')}
{record_layout(c,fp8,mode)}
<p><code>MakeWindowFragment</code> names the four loaded words without changing their bits. Normal activation loads use <code>__ldcg</code>, requesting an L2 path that bypasses L1; weight and bias loads use <code>__ldca</code>, allowing L1 and L2 reuse. Spatial-view words are ordinary explicit loads. The policies are performance hints, not evidence of a hit rate or proof of synchronization. These local kernels do not stage an asynchronous cp.async/TMA pipeline: their operand placement is direct register loading plus the shared exchanges described next. <a href="https://docs.nvidia.com/cuda/parallel-thread-execution/#cache-operators">The PTX cache rules</a> define those requests.</p>'''
    if core_only:input_part=''
    elif mode=='upsample':input_part=upsample(c,fp8,path)
    elif mode=='input_view':
        input_part=f'''<h2 id="input">5. Construct the direct spatial-view input</h2><p>This input-view specialization chooses ViewHeight/ViewWidth when positive, otherwise Height/Width. For a non-singleton dimension it tests each computed coordinate and substitutes zero outside the view. A dimension of one broadcasts coordinate zero. These tests happen before a load is dereferenced. This eliminates a separate gather/repack buffer, but each lane executes the more detailed word-address arithmetic instead of the ordinary single-vector tile load.</p>{excerpt(path,'const int g_Plane =',11,7,'Read the spatial input view directly into native A words')}'''
    else:
        input_part=f'''<h2 id="input">5. Construct the bounded physical-tile input</h2><p>The entry reads physical tiles. The window origin is divided by four to obtain its first tile; the tile index selects one of the four 4 × 4 regions. If a tile-grid dimension is one, its reads broadcast tile zero; otherwise invalid tiles produce zero fragments. Stores remain bounded independently. All lanes still participate in the subsequent collective arithmetic, so a padded token must not make one lane exit before shuffles or MMA.</p>{excerpt(path,'const bool bValid =',17,6,'Bound the physical input tile and load packed fragments')}'''
    ffn=ffn_section(c,fp8,mode,path)
    norms=f'''<h2 id="qkv">7. Build QKV, then normalize channels without changing token identity</h2>
<p>The QKV input is the published Z. {'The one head has consecutive Q32, K32, V32 output groups.' if c==32 else f'Warp h computes one head, but each Q/K/V component reads all {heads} input panels. The record interleaves outputs as [head][Q,K,V][32], giving output base 96h+32component.'} For each projection, initialize a Half accumulator to zero and visit input panels in order with <code>LinearWindow32</code>. This fuses three logical projections into the window kernel while retaining their separate output fragments; no global QKV tensor is required.</p>
{excerpt(path,'// Project the FFN output into Q/K/V',25,0,'Construct the QKV fragments in the owning entry')}
<p><code>NormalizeWindow</code> implements the 32-channel L2 normalization in packed Half. It forms separate even/odd column square trees, with channels 16–31 rounded before channels 0–15 are fused into them, then combines them. XOR-2 and XOR-1 shuffles gather the four lanes belonging to the same token; adding a word to its swapped Half components gives a replicated scalar sum. Clamp it to the Half epsilon 0x0410, or 0.00006198883056640625, compute an approximate reciprocal square root through <code>InvertReplicatedHalf&lt;true&gt;</code>, convert back to Half, and multiply every channel. Only Q receives the learned head scale. This is a channel norm; it does not subtract a mean or mix different token rows. The deployment clamp is on the squared sum and differs from the training document's floating norm floor.</p>
{code(W32,153,191,'Exact norm tree, replicated inverse and optional query scale')}
<p>Publish the normalized Q and K as {fmt}. V skips normalization but needs a different fragment orientation for the later P×V product. <code>TransposeM8n8</code> executes a warp-wide <code>movmatrix.sync.trans.aligned.m8n8.b16</code> on the Half result. {'The resulting low/high row words are packed into E4M3 together only after this transpose.' if fp8 else 'Both transposed Half words are retained separately; there is no E4M3 conversion.'} This register transpose replaces a separate V-transpose memory pass. The transpose exchanges lane ownership, so all participating lanes must execute it together.</p>
{excerpt(path,'TransposeM8n8',9,3,'Convert V accumulator ownership into the B-fragment layout')}
<h2 id="attention">8. Construct biased scores, the exact surrogate and the 64-key normalization</h2>
<p>One query tile is 16 rows. Initialize its eight N8 score groups from the packed Half bias, then accumulate QKᵀ against the four key tiles. The bias address within a head is <code>2048·queryTile + 512·keyTile + lane·16</code>, covering 8192 bytes per complete 64 × 64 head table. A score pair in column group j belongs to keys <code>8j+2(lane mod4)</code> and the following key. The physical token ordering is shared by K, V and bias columns. The input gather gives Q its physical row order; the bias payload is packed with that same query-row order. The relative-bias decoder in weights.py explicitly maps natural query coordinates through tiled_token before indexing this payload.</p>
{code(W32,319,348,'How a query tile seeds bias and multiplies all four key tiles')}
<p><code>AttentionExponential</code> is not a call to exp or standard softmax. It computes the Half affine value <code>0.044921875·score+1.30078125</code>, clamps it to [1.03125,1.5693359375], then computes <code>(packedClampedBits&lt;&lt;5)+0x7ff88000</code> on the <em>whole packed 32-bit word</em>. The encoding constant compensates cross-Half carry behavior. Therefore reproduce the packed operation as shown; separately shifting two 16-bit lanes or swapping in a library exponential changes the result. This local branch does not subtract a row maximum or apply a standard shifted-window mask. All 64 slots, including zero-padded spatial slots, participate.</p>
{code(W32,194,204,'The exact packed-word exponential surrogate')}
{attention_picture(fp8,c)}
<p>Normalize over keys with a second, different reduction. First sum column pairs locally in Half. Then preserve the native lane order: lane 0 plus lane 1, then lane 2, then lane 3, and finally combine the two Half components. Floor the denominator, use approximate reciprocal via <code>InvertReplicatedHalf&lt;false&gt;</code>, and multiply each score pair in Half. Replacing this order with the norm's butterfly changes the rounding tree. {'This C32 FP8 entry computes two query tiles together. Its four row halves are transposed so each lane owns one complete row sum, computes one reciprocal, then sends that inverse back to the four MMA column lanes. This saves duplicated scalar reciprocal work at the cost of the extra shuffle/permutation schedule.' if fp8 and c==32 else 'This entry uses SoftmaxWindow on one query tile at a time. It keeps the original per-row lane reduction and does not use the paired C32 FP8 reciprocal schedule.'}</p>
{code(W32,261,311,'Paired query-tile denominator ownership') if fp8 and c==32 else code(W32,206,237,'Single-query-tile denominator reduction and probability normalization')}
<h2 id="projection">9. Consume probabilities immediately, then mix heads and add the residual</h2>
<p>Publish the normalized probabilities as {fmt}; this is a numerical boundary, even though it stays in registers. Reduce P×V over all 64 keys using {64//k} K{k} chunks. <code>ProbabilityValues</code> or the corresponding part of <code>AttendWithBias</code> selects two B words from the transposed V fragments and accumulates a 16 × 32 Half result. The score tensor dies after this use; it never becomes a global allocation. Publish attended values again before the output projection, since the next MMA expects working-precision A operands.</p>
{code(W32,346,374,'Probability publication and value-fragment selection')}
<p>{'The one warp scales its retained raw FFN accumulator by sattn, then accumulates the output projection directly into it. In FP8, decoding the already published Z instead would introduce an additional rounding on this residual branch.' if c==32 else f'Each warp first saves its scaled published-Z residual in registers. It writes its attended head panel into shared memory, then all {heads} warps synchronize and read all head panels for the C → C projection. The projection accumulator starts from the residual. C{c} retains {querybatch} attended query tiles per outer iteration; '+('all four tiles are exchanged together.' if c==256 else 'the slab is reused for the other two tiles after a final reader barrier.')} The multiplication by a residual scale rounds separately before the projection MMA contributions. A standalone post-projection addition can alter this accumulation sequence, even if it matches the real-number equation.</p>
{excerpt(path,'// Evaluate attention in tile batches',32,0,'Head outputs and residual seeds in this entry') if c>32 else excerpt(path,'// FP8 follows the native two-query-tile',30,0,'Query scheduling and residual-seeded projection in this entry')}
'''
    if core_only:
        return ffn+norms
    out=output_section(c,fp8,mode,path)
    reconstruction=f'''<h2 id="assemble">11. Assemble the complete kernel from the pieces</h2>
<p>The following schedule is the implementation checklist, not another mathematical graph. Distinguish publication (a conversion or packed-fragment rearrangement) from a global store. They often occur independently. Keep every named accumulator alive until its residual or transition consumer has finished, and place shared barriers according to read lifetimes rather than merely according to loop boundaries. The full owning source appended below supplies the ABI, dispatch specialization and exact syntax after this construction is understood.</p>
{pseudo(reconstruct(c,fp8,mode),'Complete high-level reconstruction for '+name)}
<h2 id="checks">12. Test indexing first, then numerical boundaries</h2>
<p>Use deliberately small exact values to separate a misplaced tensor from a rounding discrepancy. The following are construction tests to run against a candidate reimplementation, not claims that an unexecuted GPU test passed. Initialize guard bytes around allocations and compare only the declared output region. Test the source's actual supported geometries; a singleton view dimension exercises a loader rule and does not automatically authorize a smaller exported launch.</p>
{tests(c,fp8,mode)}
<p>After these identity/shape checks, compare random packed operands against the deployment reference at every publication boundary. Use adversarial values near Half and {'E4M3' if fp8 else 'Half'} rounding boundaries, normalization underflow, and the exponential clamp thresholds. Inspect NaN behavior separately if it belongs to your admitted inputs. For performance, measure the proposed change with identical geometry, weights, clocks and launch sequence. The improvements argued here remove specific intermediate traffic or duplicate work; their benefit must still outweigh register pressure, shared barriers and instruction overhead on the tested GPU.</p>
{note('You can now rebuild this one entry without opening a companion kernel page: the model, reference loop, ownership map, byte addresses, arithmetic helpers, storage lifetimes, publication path and checks are all specified above. The source and dependencies below are the exact implementation, not a substitute for the construction.')}
'''
    return arch+mapping+ownership+layout+input_part+ffn+norms+out+reconstruction


def record_layout(c,fp8,mode):
    if c==32:
        return '<p>The complete C32 base profile shown above fixes the expansion at byte zero and lists the contraction, FFN residual scale, QKV, bias, head scale, projection and attention residual scale offsets. '+('This upsample record inherits the contraction offset, but inserts its transition matrix and overrides the later offsets as derived in the next section.' if mode=='upsample' else 'Use the constants for this precision; Half matrix storage is larger while bias tables and residual scales remain Half.')+'</p>'
    h=c//32; b=1 if fp8 else 2
    return f'''<h3>Lay out the complete packed weight record</h3>
<p>Let C={c}, H=C/32={h}, and b={b} bytes per matrix operand. Put H expansion matrices first, each C×128×b bytes, followed by H contraction matrices, each 128×32×b bytes. Thus ContractOffset=H·C·128·b={h*c*128*b}, and MixOffset=ContractOffset+H·128·32·b={h*c*128*b+h*128*32*b}. The C×C mixing matrix follows. For the ordinary profile, 16 padding bytes precede the C Half FFN scales, and another 16 precede QKV. QKV occupies 3·C²·b bytes; the H Half attention-bias tables occupy H·8192 bytes. The H FP32 head scales are rounded up to a 16-byte allocation before the C×C projection. Finally come C Half attention-residual scales. These sizes derive every later pointer from the record base instead of relying on unexplained offsets.</p>
{code(WIDE,9,31,'Complete wide base profile: packed matrices, scales, bias tables and attention batch')}
<p>{'The upsample profile inherits the expansion, contraction and mixing locations from this base, but inserts the 2C→C transition matrix after the FFN matrices and overrides the following scale/QKV/bias/projection offsets. Use its override formulas in the next section for those later fields.' if mode=='upsample' else 'This entry uses these base offsets directly.'} {'The down-projection matrix is appended after the C Half attention-scale values, at AttentionScaleOffset+2C, and has C×2C×b bytes.' if mode=='downsample' else ''}</p>'''


def upsample(c,fp8,path):
    raw='Keep the raw Half merge for the FFN residual, and separately publish its FFN operand.' if c==32 else 'Publish the merge into shared panels before the ordinary block; its residual reads that publication.'
    return f'''<h2 id="merge">5. Construct this decoder entry's low projection and skip merge</h2>
<p>Before the ordinary block, read a 4 × 4 low region in spatial planes. Its field dimensions are {'Height/2 and Width/2' if c==32 else 'ceil(Height/2) and ceil(Width/2), each rounded up to a multiple of four'}. Warp h computes projected channels 32h…32h+31 and visits all {2*c//32} input C32 panels. Each panel enters <code>LinearWindow32</code> with the up-projection matrix and accumulates into one Half <code>r_LowProjection</code>. This computes {2*c} → {c} once per low token; repeating first would evaluate the same linear transform four times.</p>
{('<p>This C32 entry has three distinct extent contracts. Low input planes use Height/2 and Width/2; the raw merged tensor is masked against output Height and Width. The skip uses positive ResidualHeight and ResidualWidth overrides independently, falling back to Height and Width otherwise. Its tile grid is ResidualHeight/4 by ResidualWidth/4, so the skip tile index is tileY·(ResidualWidth/4)+tileX and that residual width determines the byte stride in the packed-tile equation. Singleton skip tile dimensions broadcast tile zero for reads. Do not substitute the output width when a residual override is active.</p>'+code(path,25,31,'C32 skip extent overrides are separate from low and output extents')) if c==32 else '<p>The wider entry uses matching output and residual extents for its packed skip; its low input alone uses the rounded half-resolution extents above.</p>'}
{excerpt(path,'const auto r_Weights = LoadWindowWeights',32,3,'Gather the low spatial planes and project them before repetition')}
{transition_picture('upsample',c,fp8)}
<p>Now load each high skip tile from its own packed allocation. <code>ScaledWindowResidual</code> {'decodes the E4M3 words to Half, then ' if fp8 else ''}multiplies its channel pairs by the learned transition scales in Half. The repetition shuffle selects source lane <code>(L&amp;3)|((L&gt;&gt;1)&amp;4)|8(tile&amp;1)|16·rowHalf</code> from projected row half <code>tile&gt;&gt;1</code>. Destination lanes 0,4,16,20 in tile 0,row-half 0 all read source lane 0; these are high pixels (0,0),(1,0),(0,1),(1,1). Add the repeated projection to the already rounded skip product, then clear positions outside the destination field. {raw}</p>
{excerpt(path,'// Each low-resolution value repeats',24,2,'Nearest-repeat lane routing, separate Half addition and spatial masking')}
<p>The projection and transition scale live inside this record's weight payload. <code>FWindowUpsampleProfile</code> inserts a 2C×C matrix after the FFN matrices and locates the transition scale between the FFN scale and QKV matrix. Using ordinary-record offsets would point at the wrong values even though most of the block's math is unchanged. The profile excerpt defines those byte boundaries from Channels and ElementBytes; the source specialization fixes both at compile time.</p>
{code('csrc/kernel_impl/decoder_c32_c64_c128_c256_upsample/common/window_upsample.cuh',16,32,'Upsample record offsets include the inserted projection and scale')}
'''


def publication_mapping(fp8):
    if not fp8:
        return '''<p>For this Half path, the accumulator-to-A map preserves the model channel order. With q=lane mod4, publication chunk 0, word 0 contains channels 2q and 2q+1; word 2 contains 8+2q and 9+2q. Chunk 1 adds 16 to those channel indices. Odd words select the same channels for the token row eight places later. For lane 6, chunk 0 therefore supplies channels 4/5 in word 0 and 12/13 in word 2, exactly the instruction's K coordinates. This is a register-word rearrangement, not another quantization step.</p>'''
    return f'''<p>The E4M3 publication introduces a crucial distinction between a native MMA K coordinate and a model channel. Word 0 packs accumulator column groups 0 and 1 together. Lane 6 (q=2) therefore places model channels [4,5,12,13] in its four bytes, while the instruction consumes that word as native K coordinates [8,9,10,11]. Define k within a C32 panel, a=k&amp;15. The producer's native-K-to-model-channel permutation is <code>(k&amp;16)+2·floor(a/4)+(a&amp;1)+8·((a&amp;2)!=0)</code>. Add the C32 panel base for a wider tensor. This is exactly <code>packed_input_index</code>; it leaves the upper/lower 16-channel half separate while interleaving channel pairs inside each half.</p>
{code('dlssnr/weights.py',53,69,'The model-channel permutation and packed E4M3 B-matrix addressing')}
<p>The B payload compensates for this same permutation. To create the natural matrix W, write W[modelChannel,output] into the packed slot whose native K index is <code>inverse_packed_input_index(modelChannel)</code>. For model channel 12, that native index is 10, so lane 6's third A byte multiplies the weight for model channel 12, not the natural row 10. The matrix decoder applies the inverse permutation before <code>packed_weight_index</code> for exactly this reason. Copying a dense row-major matrix into the payload, or packing the A bytes in consecutive natural-channel order without changing B, breaks the dot product even though all tensor dimensions look correct. The paired publication avoids a runtime cross-lane channel shuffle; its cost is a nontrivial, precision-specific packing contract.</p>'''


def ffn_section(c,fp8,mode,path):
    pub='E4M3 bytes' if fp8 else 'the same Half words'; c32=c==32
    opening=f'''<h2 id="ffn">6. Stream the FFN and make its storage lifetime explicit</h2>
<p><code>PublishWindow32</code> turns a C32 Half accumulator into the next A operand. In this entry it produces {pub}. <code>PublishWindowChunk</code> selects the words for one K{'32' if fp8 else '16'} reduction slice; {'PackHalfPairsE4 converts two Half2 pairs into four E4M3 bytes.' if fp8 else 'no numeric conversion is needed, but word placement still must match the A fragment.'} Publication is not inherently a memory write. <code>ScaledWindowResidual</code>, where used, loads one learned Half scale pair and multiplies it by the corresponding decoded input pair. This seeds the output accumulator before matrix contributions arrive.</p>
{code(W32,74,105,'Publication constructs the next MMA A fragment')}
{publication_mapping(fp8)}
'''
    if c32:
        content=f'''<p>Initialize four <code>r_Ffn</code> tiles from the scaled input{' raw merge' if mode=='upsample' else ''}. Retain all four published input tiles. Visit hidden panels 0…3; each has 32 of the 128 expanded channels. Load its expansion and contraction B fragments once, then for each owned token tile: zero a hidden accumulator, multiply the input, apply the activation, publish the hidden panel, and immediately contract it into r_Ffn. The complete [64,128] hidden tensor would occupy {'8192' if fp8 else '16384'} working bytes; streaming means it does not need a global write/read or a complete persistent hidden allocation. The price is retaining input and final accumulators while each panel is computed.</p>
{excerpt(path,'// Stream four 32-channel hidden panels',29,0,'C32 streams expansion, activation and contraction panel by panel')}
'''
    elif c==64:
        content=f'''<p>Use <code>FRegisterWindow&lt;precision,2,2&gt;</code>: two token tiles and two C32 input panels per warp. For branch 0 then branch 1, <code>ComputeWindowExpert</code> reads both input panels, streams four hidden C32 panels, applies activation, and contracts to one C32 branch result. Publish that result, then multiply it by its contribution to each output panel of the 64 → 64 mixing matrix. Accumulate directly into the scaled residual. Because both branches for a token stay in its owning warp, no intermediate branch exchange is necessary. Publish the final two-panel Z of each token tile into shared memory and synchronize before head-based attention ownership.</p>
{excerpt(path,'// Accumulate the two expert contributions',24,0,'Both full-input branches contribute to each C64 output panel')}
'''
    else:
        content=f'''<p>Use <code>FSharedWindow&lt;{c},precision&gt;</code> to expose the complete X to all {c//32} branch warps. Warp e runs <code>ComputeWindowExpert</code> for branch e: for each hidden C32 panel, visit every input C32 panel, accumulate the expansion, apply activation, publish it, and contract into the branch's C32 output. The word “expert” only names a dense full-input branch. Each warp also saves its own scaled X residual in registers. A reader barrier is required before any branch overwrites the X slab. Store all published branch outputs, synchronize again, then each warp reads all branch panels for its output rows of the mixing matrix. Publish Z only after all branch readers have finished.</p>
{excerpt(path,'// All experts must finish reading X',23,0,'Protect the old X lifetime before reusing the slab for branch outputs') if mode!='upsample' else excerpt(path,'ComputeWindowExpert<Channels',29,3,'Decoder-wide branch computation and shared-slab reuse')}
'''
    helper='' if c32 else code(WIDE,101,139,'ComputeWindowExpert streams each full-input branch through 128 hidden channels')
    return opening+content+helper+f'''<p><code>ActivateWindow</code> calls <code>FfnActivation</code>. Let t=clamp(x,−4,4). The gate is <code>t·(−0.055908203125·abs(t)+0.447265625)+0.89453125</code>, evaluated by the shown two Half FMAs, then multiplied by the original x in Half. The exact min/max order, Half constants and intermediate rounding belong to the learned-network arithmetic. A familiar SiLU/GELU call is not an equivalent replacement. Both the source operation order and the publication immediately after activation matter when constructing the contraction input.</p>
{code(BASE+'packed_math.cuh',141,164,'The activation helper used inside every streamed hidden panel')}
{timeline(c,fp8,mode)}
<p>{'No shared tensor slab exists in this one-warp body: its cross-lane communication is through warp instructions. Avoid adding unnecessary CTA barriers between register-only stages.' if c32 else f'The shared declaration is uint4[4][{c//32}][{1 if fp8 else 2}][32], exactly {64*c*(1 if fp8 else 2)} bytes. Its byte address is ((((tile×{c//32}+panel)×{1 if fp8 else 2}+chunk)×32+lane)×16). A uint4 is one lane fragment, with no BHWC staging conversion or additional bank swizzle. A barrier before overwrite protects the old tensor; the barrier after stores exposes the new tensor. The slab is reused because the previous tensor is dead, not because two unrelated tensors can safely coexist at the same addresses.'} QKV and the scaled attention residual both require the published FFN result to remain available until their reads finish. Register/shared lifetimes are therefore driven by the model's residual branches as well as its main forward chain.</p>
{storage_legend()}
'''


def output_section(c,fp8,mode,path):
    start='<h2 id="publication">10. Publish to this entry’s actual destination</h2>'
    if mode=='output_view':
        return start+f'''<p>This specialization stores spatial-view words directly. ViewHeight/ViewWidth override Height/Width only when positive. For each tile, chunk and word, compute the spatial x,y and plane with the equation already derived, then write one uint32 only if x,y lie in the selected view. Output writes do not use the input loader's singleton broadcast rule. A conventional implementation would first write packed tiles then launch a conversion kernel; this epilogue removes that intermediate copy at the cost of per-word addressing and boundary predicates.</p>
{excerpt(path,'// Publish final packed fragments directly to their physical output layout.',32,0,'Output-view epilogue: direct word stores, no intermediate tile-layout output')}
<p>To validate this optimization, unpack the ordinary tile-output result and the view-output result to the same logical [H,W,{c}] tensor. With the same weights, geometry, and valid view they should contain identical published element bits. Comparing the raw allocations without decoding their different layouts is not a meaningful equality test.</p>'''
    ordinary=f'''<p>For each valid physical output tile, <code>PublishWindowChunk</code> creates the final {'E4M3' if fp8 else 'Half'} A-fragment word order. Store one 16-byte vector per lane at the packed address derived earlier. <code>StoreNoAllocate</code> emits <code>st.global.L1::no_allocate.b128</code>; it requests that streaming output not allocate an L1 line. It does not mean the data bypasses all caches or has already reached DRAM. Boundary stores are skipped only after the warp has completed all collective computation.</p>
{excerpt(path,'StoreNoAllocate',5,9,'Publish bounded final fragments to the packed tile allocation')}
'''
    if mode!='downsample':return start+ordinary
    pooled='The single warp keeps the pooled panel in registers and projects twice, once for each 32-channel output panel.' if c==32 else f'Each warp stores its published pooled C32 panel in shared slot zero and synchronizes. Warp h then computes output panels h and h+{c//32}, each reading all {c//32} pooled input panels.'
    return start+ordinary+f'''<p>This downsample entry has a second output. Retain all four raw Half output tiles in <code>r_WindowOutput</code>, independently of the published skip store. <code>PoolWindow</code> calls <code>PoolHorizontalWords</code> for tiles 0/1 then 2/3. Conditional word swaps route tile-X and row-half ownership; a lane-bit permutation exchanges bits 2 and 3; indexed shuffles with XOR offsets 0,4,16,20 collect the 2 × 2 cell. The exact average is <code>HalfMul(HalfAdd(HalfAdd(a,b),HalfAdd(c,d)),¼)</code>. Pooling an already {'E4M3-published' if fp8 else 'rearranged'} skip is not the implemented dataflow; consume the retained raw branch.</p>
{transition_picture('downsample',c,fp8)}
{code(BASE+'window_pool.cuh',7,42,'The actual neighbor routing and three-add Half averaging tree')}
<p>Publish the pooled tile to {'E4M3' if fp8 else 'Half'} before the {c} → {2*c} matrix. {pooled} The down-projection matrix begins after the attention-scale array. The output uses spatial channel planes, not the skip's physical-tile layout. The two allocations have different shapes and addresses even though both descend from the same Yraw.</p>
{excerpt(path,'const auto r_Pooled =',24,0,'Project the pooled working-precision tile into doubled channels')}
<p>Valid low dimensions are ceil(H/2),ceil(W/2). {'C32 uses compact H/2,W/2 extents for its admitted geometry.' if c==32 else 'This wider entry rounds the low extents up to multiples of four.'} Projected stores immediately zero their own padded cells. The later clear covers caller-provided target padding and assigns uncovered bottom/right borders to CTA zero. It must not race a valid projection write. The documented clear footprint is Half-sized C → 2C even for FP8, so shrinking every workspace in proportion to operand byte width breaks the contract. Preserve both the local producer mask and the auxiliary target dimensions.</p>
{excerpt(path,'// Clear the caller-provided padded border',28,0,'Padding clear has a distinct allocation footprint and validity test')}
'''


def reconstruct(c,fp8,mode):
    p='true' if fp8 else 'false'
    steps=[f'constexpr Channels={c}, bFp8={p}; launch 32 lanes × {c//32} warps',
           'derive CTA window origin and four physical tile coordinates; keep every lane participating']
    if mode=='upsample':steps += ['read 4×4 low spatial planes; project 2C→C into Half registers','shuffle-repeat low projection; load/scalewise multiply skip; Half-add; mask','preserve raw merge if C32; publish merge for FFN operands']
    else:steps+=['gather '+('spatial view words' if mode=='input_view' else 'packed tile uint4s')+'; zero invalid loads; honor singleton read rules']
    if c==32:steps += ['keep four X fragments; seed raw FFN accumulators with scaled input','for hidden panel 0..3: expand, Half activate, publish, contract in K order']
    elif c==64:steps += ['each warp owns two token tiles and both channel panels','seed FFN residual; for branch 0..1: stream hidden panels, publish branch, mix','publish all Z panels into shared; CTA barrier changes ownership to attention heads']
    else:steps += ['publish X shared; barrier; warp e streams branch e and saves own residual','barrier before overwrite; store branch outputs; barrier','mix every branch panel into own output panel; barrier; publish Z; barrier']
    steps += ['publish Z; QKV projects all input channels into each owned 32-channel head','Q/K: exact Half square tree, lane XOR reductions, epsilon, rsqrt; scale Q','publish Q/K; transpose V in Half registers, then pack to working precision','for owned query batches: seed score fragments from packed bias; Q×Kᵀ','clamped packed-word exponential; exact 64-key row sum; reciprocal; normalize',
              ('C32 FP8: paired query-tile transpose amortizes reciprocal' if fp8 and c==32 else 'single-query-tile SoftmaxWindow uses ordered lane sums'),
              'publish normalized probabilities; P×V over 64 keys; publish attended values',
              ('seed projection with scaled raw FFN result; project attended tile' if c==32 else 'save scaled published-Z residual; publish head outputs shared; barrier; all-head projection; reader barrier'),
              'publish Y; bounded '+('spatial view word stores' if mode=='output_view' else 'packed uint4 tile stores')]
    if mode=='downsample':steps+=['retain raw Y tiles; shuffle-pool in Half; publish pooled panel','project C→2C; store spatial planes; zero producer padding; clear uncovered target border']
    return '\n'.join(steps)


def tests(c,fp8,mode):
    bits='E4M3' if fp8 else 'Half'
    rows=[('Zero tensor','Set all matrices and input/skip to zero; finite bias and scales.','All valid output values are zero; Q/K normalization remains finite through epsilon, and V is zero.'),
          ('Residual identity','Zero FFN/QKV/output-projection matrices; set both ordinary residual scales to one; use representable input values.','Ordinary body output equals its input publication bit-for-bit; this isolates addressing from learned transforms.'),
          ('Lane ownership','Populate one valid 8×8 input window with small representable token/channel labels; use the residual identity weights.','After unpacking, natural token 13 remains pixel (5,1); lane 6 column 2 maps to channels 20/21 in its panel.'),
          ('Shifted boundary','Use supported aligned dimensions and OriginX=−4; identity body; sentinel-fill output padding.','Out-of-field input tiles are zero, valid spatial values preserve their coordinates, and bounded stores leave unrelated guard bytes untouched.'),
          ('Numeric stress',f'Choose values near {bits} publication and Half-add rounding thresholds; compare each stage with the exact source-order reference.','Matching shapes alone is insufficient: publication, residual and row-sum boundaries must also match.')]
    if mode=='upsample':
        rows.insert(2,('Transition-only check','Zero Wup; transition scale=one; ordinary body identity; use a representable skip.','Final high output equals the skip. With skip scale zero and Wup selecting a low channel, each low projected token repeats to exactly four high positions.'))
    if mode=='downsample':
        rows.insert(2,('Pool/project check',f'Identity ordinary body; Wdown=[I,I] duplicates the C{c} vector; each 2×2 channel cell contains 1,2,3,4.','Published high skip keeps 1,2,3,4; each low output channel in both halves is 2.5. Output shape is the selected low field with 2C channels; padding is zero.'))
    if mode in ('input_view','output_view'):
        rows.insert(2,('View equivalence','Encode the same supported logical tensor into tile and spatial-plane layouts; use identical weights and matching positive view extents.','Decode both results to [H,W,C]: published values match bit-for-bit. A nonpositive view extent selects the fallback Height/Width.'))
    return '<div class="table-scroll"><table><thead><tr><th>Test</th><th>Setup</th><th>Expected outcome</th></tr></thead><tbody>'+''.join('<tr>'+''.join('<td>'+escape(x)+'</td>' for x in row)+'</tr>' for row in rows)+'</tbody></table></div>'


def build_lessons(inventory):
    entries=inventory.get('entries',inventory)
    result=[]
    for name,entry in sorted(entries.items()):
        match=re.fullmatch(r'window_block_c(32|64|128|256)(?:_(input_view|output_view|downsample|upsample))?_(fp16|fp8)',name)
        if not match:continue
        c=int(match.group(1)); mode=match.group(2) or 'ordinary'; fp8=match.group(3)=='fp8'
        title=f'{match.group(3).upper()} C{c}: '+{'ordinary':'construct a fused window block','input_view':'construct a block with direct spatial input','output_view':'construct a block with spatial output','downsample':'construct the encoder block, pool and projection','upsample':'construct the decoder projection, merge and block'}[mode]
        action={'ordinary':'a fused FFN and local attention block','input_view':'a fused block that reads spatial channel planes','output_view':'a fused block that writes spatial channel planes','downsample':'an encoder block with pooling and doubled-channel projection','upsample':'a decoder projection, repeated skip merge and fused block'}[mode]
        result.append(dict(name=name,title=title,summary=f'Build {action} for {c} channels in {match.group(3).upper()}, from tensor equations through lane ownership, byte addresses, precision boundaries and complete storage lifetimes.',family='Local windows',body=build_body(name,entry,c,fp8,mode)))
    if len(result)!=40:
        raise ValueError(f'Expected 40 local window entries, found {len(result)}')
    return result


def c32_core_lesson(fp8, residual_input_description='raw Half adapter/merge', source_path=None):
    """Inline the complete C32 body in a frontend lesson, with local source excerpts."""
    precision='fp8' if fp8 else 'fp16'
    path=source_path or f'csrc/kernel_impl/shared_encoder_decoder_c32_c64_c128_c256_fused_window/{precision}/window_block_compact_{precision}.cu'
    if path.startswith('csrc/'):
        path=path[5:]
    body=build_body(f'inline C32 {precision} body',dict(header=path),32,fp8,'ordinary',core_only=True)
    body=body.replace('Initialize four <code>r_Ffn</code> tiles from the scaled input.',
                      f'Initialize four <code>r_Ffn</code> tiles from the scaled {escape(residual_input_description)}. Publish that same raw input separately for the FFN matrix operand; the residual must retain its pre-publication Half values.')
    return body
