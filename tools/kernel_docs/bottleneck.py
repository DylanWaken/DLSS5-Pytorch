"""Source-linked C1024 deployment tutorials. Generated HTML is owned by the builder."""
from common import code, svg, note
from html import escape

P = 'csrc/kernel_impl/'
E16 = P+'bottleneck_c1024_ffn/fp16/global_ffn_expand_c1024_fp16.cu'
E8 = P+'bottleneck_c1024_ffn/fp8/global_ffn_expand_c1024_fp8.cu'
C16 = P+'bottleneck_c1024_attention_ffn_projection/fp16/global_ffn_contract_c1024_fp16.cu'
C8 = P+'bottleneck_c1024_attention_ffn_projection/fp8/global_contract_fp8.cu'
Q16 = P+'bottleneck_c1024_attention/fp16/global_qkv_c1024_fp16.cu'
Q8 = P+'bottleneck_c1024_attention/fp8/global_qkv_c1024_fp8.cu'
A8 = P+'bottleneck_c1024_attention/fp8/global_attention_chained_c1024_fp8.cu'
A16 = P+'bottleneck_c1024_attention/fp16/global_attention_chained_c1024_fp16.cu'
S = P+'shared/common/'

def txt(x,y,text,small=False):
    return f'<text x="{x}" y="{y}" class="{"small" if small else "label"}" style="font-size:{14 if small else 15}px;font-weight:500">{escape(text)}</text>'

def box(x,y,w,h,lines,kind='tensor'):
    parts = lines.split('|')
    return f'<rect class="{kind}" x="{x}" y="{y}" width="{w}" height="{h}" rx="8"/>'+''.join(txt(x+12,y+25+i*22,t) for i,t in enumerate(parts))

def edge(x1,y1,x2,y2):
    dx,dy=x2-x1,y2-y1
    length=(dx*dx+dy*dy)**0.5
    ux,uy=dx/length,dy/length
    return f'<path d="M{x1},{y1} L{x2},{y2}" fill="none" stroke="#527487" stroke-width="2"/><polygon points="{x2},{y2} {x2-9*ux+4*uy},{y2-9*uy-4*ux} {x2-9*ux-4*uy},{y2-9*uy+4*ux}" fill="#527487"/>'

def fig(title,height,inner,caption):
    return svg(title,f'0 0 1060 {height}',inner,caption)

linear_arch=fig('The two channel-mixing operations in every C1024 block',320,
    box(20,35,165,74,'X[t, 1024]|one token')+edge(185,72,220,72)+box(220,35,190,74,'W₁: 1024 → 4096|expand + activation','compute')+edge(410,72,450,72)+box(450,35,170,74,'U[t, 4096]|published FP16/FP8')+edge(620,72,660,72)+box(660,35,185,74,'W₂: 4096 → 1024|contract + residual','compute')+edge(845,72,885,72)+box(885,35,155,74,'Z[t, 1024]|QKV input')+
    box(20,200,165,74,'Attention[t, 1024]|joined 32 heads')+edge(185,237,240,237)+box(240,200,235,74,'Wₒ: 1024 → 1024|projection + residual','compute')+edge(475,237,530,237)+box(530,200,190,74,'Y[t, 1024]|next block input')+
    txt(30,149,'X × ffn_scale joins the contraction. Z × attn_scale joins the attention projection.')+txt(30,298,'Records 31–38 repeat this body. Record 39 performs the following up-transition.'),
    'The FFN and attention output projection preserve token identity; only attention exchanges information between tokens.')

repack=fig('A token identity moves between physical layouts',280,
    box(20,30,265,110,'Spatial position (y=5, x=9)|width 60 → t=309|4×4-tile token s=281','tensor')+edge(285,83,335,83)+box(335,30,315,110,'Same channel word cw=13|F(t,cw): token layout|F(s,cw): spatial tile layout','compute')+edge(650,83,705,83)+box(705,30,330,110,'FP16: 557660 → 623448 bytes|FP8: 279132 → 312152 bytes|one 32-bit copy; bits unchanged','storage')+
    box(20,180,360,72,'Grid-stride thread: word index|t = index / wordsPerToken','compute')+edge(380,217,430,217)+box(430,180,300,72,'t < T: read mapped word|t ≥ T: synthesize +0 bits','compute')+edge(730,217,780,217)+box(780,180,255,72,'Store token-layout word|no shared staging or MMA','storage'),
    'Addresses are byte offsets from each allocation base. Channel word 13 is an opaque packed word; the repack does not reinterpret its values.')

linear_tile=fig('A 128-token by 128-channel CTA becomes four register tiles',300,
    box(20,35,350,96,'CTA: tokens 128m … 128m+127|output channels 128n … 128n+127|four warps, 32 lanes each','compute')+
    box(425,25,280,95,'Warp 0: rows 0–63|columns 0–63|4 × M16, 4 × N16')+box(735,25,280,95,'Warp 1: rows 0–63|columns 64–127|same input rows')+
    box(425,145,280,95,'Warp 2: rows 64–127|columns 0–63|same weight columns as W0')+box(735,145,280,95,'Warp 3: rows 64–127|columns 64–127|same weight columns as W1')+
    edge(370,80,415,80)+txt(20,175,'Within each M16 × N16 fragment:')+txt(20,203,'lane L → rows floor(L/4), +8')+txt(20,231,'channel pairs 2(L mod 4), +8')+txt(20,278,'Lane 13: rows 3 and 11; channels {2,3} and {10,11}, relative to its M16/N16 tile.'),
    'Every lane owns four Half2 accumulator words per M16×N16 tile. Matrix operands are distributed across the entire warp; a lane does not independently compute a full dot product.')

expand_pipe=fig('Expansion storage lifetime: a three-slot input ring',390,
    box(20,30,190,90,'Device global input|16-token groups|packed native A layout','storage')+edge(210,75,265,75)+box(265,30,230,90,'Async copy path|SM90+: bulk issuer|SM80/89: lane stripes','compute')+edge(495,75,545,75)+box(545,30,225,90,'Shared slot 0: 8192 B|slot 1: 8192 B|slot 2: 8192 B','storage')+edge(770,75,820,75)+box(820,30,220,90,'uint4 A registers|four M16 tiles|two K subtiles','storage')+
    box(20,180,280,78,'Packed weights → .ca load|B registers; no shared B tile','storage')+edge(300,219,355,219)+box(355,180,255,78,'mma.sync Tensor Cores|K16 Half / K32 E4M3','compute')+edge(610,219,660,219)+box(660,180,380,78,'Half accumulators remain in registers|φ → publication directly to global U','storage')+
    edge(928,120,928,158)+edge(928,158,482,158)+edge(482,158,482,180)+txt(25,307,'Prime A0, A1, A2 and B0 → wait slot 0 → consume A0×B0 → load B1 → wait slot 1')+txt(25,338,'→ refill slot 0 with A3 → consume A1×B1 → … → drain. A slot is reused only after prior readers advance.')+txt(25,369,'Input slabs: 8 groups × 1024 B. FP16 slab K32; FP8 slab K64. Three barrier objects: 24 B.'),
    'The same byte capacity covers twice as many reduction channels in FP8. Source synchronization, rather than cache residency, makes each shared stage usable.')

split=fig('Four K splits publish one numerically ordered output',360,
    box(20,40,220,95,'Split 0|K 0…1023 (FFN)|seed scale × residual','compute')+edge(240,88,285,88)+box(285,40,220,95,'Split 1|K 1024…2047|Half-add partial','compute')+edge(505,88,550,88)+box(550,40,220,95,'Split 2|K 2048…3071|Half-add partial','compute')+edge(770,88,815,88)+box(815,40,220,95,'Split 3|K 3072…4095|final Half-add','compute')+
    box(200,195,650,72,'Global Half partial tensor persists across split boundaries|FP16: output allocation itself. FP8: separate SplitAccumulator.','storage')+edge(130,135,130,231)+edge(130,231,200,231)+edge(925,135,925,231)+edge(850,231,925,231)+txt(28,311,'Projection uses the same four phases with K ranges 0…255, 256…511, 512…767, 768…1023.')+txt(28,340,'Only final FP8 publication converts Half to E4M3; intermediate partial sums are never rounded to FP8.'),
    'The arrows describe publication order, not simultaneous resident execution. The launcher can serialize split planes as separate stream-ordered launches.')

linear_address=fig('A concrete expansion vector address: warp 2, lane 13',335,
    box(20,30,480,92,'Token tile 0, output block 0, reduction tile 3|warp 2 consumes token groups 4,5,6,7|choose spatial fragment 1 → token group 5','tensor')+edge(500,76,550,76)+box(550,30,490,92,'Stage index = 3 mod 3 = 0|shared base = 0 + (2/2)×4096 + 13×16|choose K subtile 1: +1024 +512 → 5840 B','storage')+
    box(20,180,480,95,'FP16 output U vector|5×65536×2 + 0 + 0 +13×16|N16 fragment 2 adds 2×512 → 656592 B','storage')+edge(500,228,550,228)+box(550,180,490,95,'Same register tile, logical values|tokens 83 and 91; channels 34/35, 42/43|four Half2 words store one uint4 per lane','tensor')+txt(25,314,'FP8 publication combines two N16 groups per uint4; channel order and element byte size both change.'),
    'The input shared vector is the warp-distributed A operand. The output example follows r_MTile=1, r_NTile=2 in the FP16 store loop.')

linear_body=f'''
<h2 id="architecture">Model piece: dense FFN and the attention output projection</h2>
<p>Records <strong>31–38</strong> operate on the C1024 bottleneck. For the architecture document’s 3840×2160 example, its field is <strong>H=36, W=60, T=2160</strong>. A row X[t,:] has 1024 channels. The dense FFN computes U[t,:]=Publish(φ(X[t,:]W₁)), with W₁ logically [1024,4096], followed by Z[t,:]=Publish(U[t,:]W₂ + ffn_scale⊙X[t,:]), W₂ logically [4096,1024]. Later the attention projection computes Y[t,:]=Publish(A[t,:]Wₒ + attn_scale⊙Z[t,:]), Wₒ logically [1024,1024]. Packed weight orientation differs from this explanatory row-vector notation.</p>
<p>Each of these matrices mixes <em>channels of one token</em>. There is no neighbor read, routing decision, pre-FFN LayerNorm, or hidden pooling in these kernels. The spatial exchange occurs in the <a href="global-attention.html">global attention chapter</a>. See the original <a href="architecture.html#dense-ffn-c32-and-c1024">architecture’s dense FFN</a> and <a href="../ARCHITECTURE.md">Markdown architecture source</a> for its place in the full network.</p>
{linear_arch}
<h2 id="repack">Step 1 — preserve tensor values while changing token order</h2>
<p>The encoder’s C1024 tensor arrives in physical 4×4 spatial-tile order. The bottleneck wants consecutive linear tokens grouped by 16. <code>repack_spatial_to_token</code> changes this placement using 32-bit loads and stores. It performs no conversion, multiplication, or transpose through shared memory. A word contains two FP16 or four FP8 values, but the copier treats its bits as an opaque unit.</p>
<p>Let q be the packed channel-word index and B be words per token: B=512 for FP16, B=256 for FP8. The common physical word map is <code>F(t,q)=floor(t/16)·16B + floor(q/8)·128 + (t mod 8)·16 + (q mod 4)·4 + floor((q mod 8)/4)·2 + floor((t mod 16)/8)</code>. The spatial token corresponding to t=yW+x is <code>s=((floor(y/4)·(W/4)+floor(x/4))·16)+(y mod 4)·4+(x mod 4)</code>. Forward repack copies input[F(s,q)] to output[F(t,q)]. This is a packed layout permutation, not conversion to a dense BHWC buffer.</p>
{repack}
<p>For W=60, t=309 means y=5,x=9 and s=281. With q=13, the within-group word terms are 151 for s and 214 for t. FP16 gives F(s,q)=17·8192+151=139415 and F(t,q)=19·8192+214=155862; multiply by four for the diagram’s byte addresses. FP8 instead uses 4096-word groups and gives 69783 and 78038. A linear grid-stride loop assigns successive words to threads; the addresses determine the actual memory request pattern. Neither a repack-specific L1 policy nor explicit cache management appears in this source.</p>
{code(P+'bottleneck_c1024_layout/common/global_repack_layout.cuh',15,29,'The exact token and word maps')}
<p>Forward repack rounds token capacity to 16 in FP16 and 32 in FP8 and writes exact zero bits for its added rows without reading the input. Inverse repack only processes the real T rows. Keep this storage alignment distinct from attention’s 64-key traversal boundary. The host may allocate a larger common capacity; the kernel’s bounds and the host’s allocation policy are separate facts.</p>
{code(P+'bottleneck_c1024_layout/common/repack_spatial_to_token.cu',20,40,'Forward repack writes a defined zero tail')}
<h2 id="tile">Step 2 — assign a matrix tile to four warps</h2>
<p>Expansion launches a 128-token×128-output-channel CTA tile. <code>blockIdx.x</code> is decoded with <code>ceil(T/128)</code>: quotient chooses the channel block, remainder chooses eight 16-token groups. Warp parity chooses the lower or upper 64 columns; warp/2 chooses the lower or upper 64 tokens. Two warps can therefore reuse each staged input row group, while the two row groups use the same weight-column panels.</p>
{linear_tile}
<p>An <code>FMmaAccumulatorTile&lt;4,4&gt;</code> holds 4 M16 tiles × 4 N16 tiles × 4 packed 32-bit words per lane. These are 64 words, or 128 Half accumulator elements per lane, representing the warp’s 64×64 result collectively. Two N8 MMA instructions build one N16 panel. The FP16 instruction uses M16N8K16; FP8 uses M16N8K32 with E4M3 operands. <strong>Both expose FP16 accumulators and outputs</strong>; FP8 here does not imply FP32 accumulation.</p>
{code(S+'tiled_mma.cuh',9,44,'A register tile is a set of warp-distributed MMA fragments')}
<p>For lane 13, floor(13/4)=3 and 13 mod 4=1. Within one output M16×N16 tile, its four Half2 words correspond to rows 3/11 and channel pairs 2–3/10–11. Those channels are offsets inside the selected N16 group. The input fragment’s four words are operand registers distributed under the MMA instruction’s layout; do not apply the output channel-pair rule to A or B indiscriminately.</p>
<h2 id="expand-pipeline">Step 3 — overlap staged A input with register B weights</h2>
<p>The expansion profile has three 8192-byte shared slots and three 8-byte barriers. One stage contains eight 16-token groups, each with a 1024-byte K slab. That slab is K32 in FP16 and K64 in FP8. The complete 1024-channel reduction therefore takes 32 steps in FP16 and 16 in FP8. A step still consists of two reduction subtiles in both precisions.</p>
{expand_pipe}
<p><code>StageInput</code> assigns each warp two group copies, at shared offsets <code>stage·8192+warp·1024+copyGroup·4096</code>. Invalid groups are filled by per-lane stores, so every later register load sees initialized bits. On SM90+ one elected lane submits a bulk transfer and registers its byte count with an mbarrier. On earlier supported devices all 32 lanes issue adjacent 16-byte <code>cp.async.cg</code> stripes, then attach their copies to the barrier. A 1024-byte slab requires two stripes per lane. Every CTA thread arrives at the barrier; completion tracks both the arrivals and asynchronous transfers.</p>
{code(E16,28,65,'Stage construction and phase-aware waiting')}
<p>Weights follow a different path: <code>__ldca</code> loads 16-byte vectors directly into B registers. Its address is the packed matrix base plus outputBlock·4096 + (warp mod 2)·2048 + lane·16 + (2·reductionTile+kSubtile)·131072 + nTile·512. The 128-KiB jump is the packed record’s stride, not a conventional row-major matrix stride. Avoid introducing an extra weight transpose or shared B allocation: the producer’s packed record already serves the consumer’s MMA operand order.</p>
{code(E16,78,125,'Register weight prefetch and the three-stage ring')}
<p>The native schedule loads B for the next iteration, waits for the next A stage, and only then refills the consumed slot three iterations ahead. The phase token in <code>ArriveAndWait</code> distinguishes repeated reuse of the same barrier address. Counting a ring slot as “ready once” would be incorrect when it wraps. The source-level aim is to retain operand reuse and permit copying to overlap arithmetic; realized overlap and bandwidth require profiling.</p>
{linear_address}
<h2 id="publication">Step 4 — fuse activation into the expansion publication</h2>
<p>The entire dot product remains in Half accumulator registers. <code>FfnActivation</code> applies the recovered clamped polynomial there: b=clamp(x,−4,4), then φ(x)=x·(b·(−0.055908203125·abs(b)+0.447265625)+0.89453125). Deployment uses the original ordered Half operations. Replacing the sequence with standard SiLU or a single FP32 evaluation changes its numerical contract.</p>
<p>There is no full pre-activation [T,4096] tensor in global memory. The <em>activated, published</em> U is materialized because the contraction runs separately. FP16 writes its accumulator words directly. FP8 converts and combines two neighboring N16 groups into a uint4 of E4M3 bytes. In both paths the output is already the native physical layout required by the contraction. The store helper requests <code>L1::no_allocate</code>; this is an allocation policy, not a guarantee that every store reaches DRAM immediately.</p>
{code(E8,128,162,'Activation and FP8 packing happen before the single output publication')}
<h2 id="contract">Step 5 — reduce the expanded channels in four publication phases</h2>
<p>Contraction reuses M128×N128 tiles but splits K into four 1024-channel regions. Attention projection uses four 256-channel regions. Each split independently computes a register tile. Only split zero initializes its accumulators from the scaled residual. The learned residual scales are 1024 Half values appended after the packed matrix, including in the FP8 path. This fuses the residual addition into the first reduction phase and avoids a standalone residual kernel.</p>
<table><thead><tr><th>Operation</th><th>Input width / split width</th><th>K step</th><th>Stages / bytes per stage</th><th>Steps per split</th></tr></thead><tbody>
<tr><td>FP16 contraction</td><td>4096 / 1024</td><td>32</td><td>3 / 8192</td><td>32</td></tr>
<tr><td>FP8 contraction</td><td>4096 / 1024</td><td>64</td><td>2 / 8192</td><td>16</td></tr>
<tr><td>FP16 attention projection</td><td>1024 / 256</td><td>32</td><td>2 / 8192</td><td>8</td></tr>
<tr><td>FP8 attention projection</td><td>1024 / 256</td><td>32</td><td>2 / 4096</td><td>8</td></tr></tbody></table>
{code(P+'bottleneck_c1024_attention_ffn_projection/common/global_contract.cuh',11,29,'These sizes are profile constants, not inferred performance figures')}
{split}
<p>FP16 uses its output allocation as the Half partial tensor. FP8 has a separate Half <code>g_SplitAccumulator</code> and only packs the final result into its byte-sized output. Split 0 stores, splits 1 and 2 add to the prior Half partial, and split 3 loads that partial, performs a final Half add, and publishes. Thus the four split results do not combine in an arbitrary atomic order or one wide final sum. The order and intermediate Half rounding are part of the reproduced implementation.</p>
<p>On SM90+ the intermediate reduction uses vector Half2 global reductions. The portable FP8 path instead uses exclusive per-address load–Half-add–store after predecessor completion; its loads use <code>.cg</code> to avoid stale L1 copies of scratch. The FP16 path retains the reduction helper, which falls back to four scalar Half2 reductions before SM90. The final FP8 write is distinct from scratch traffic, so reducing final output precision does not halve every buffer in this phase.</p>
{code(C8,216,248,'Half scratch survives until the fourth FP8 split')}
{code(S+'packed_math.cuh',58,82,'Portable exclusive Half scratch updates preserve the ordered reduction')}
<h2 id="ordering">Step 6 — order publication, then retire buffers</h2>
<p>The kernel has two launch protocols. With <code>OrderedSplit=0</code>, grid-Z identifies the split and a later split polls a global predecessor counter before publication. A CTA synchronization precedes publication, and a final synchronization precedes the release counter store. With an explicit ordered split, the host runs separate split planes in one stream; each plane completes before its successor enters. This avoids occupying SMs with consumers waiting for producers that have not been scheduled. The <a href="runtime.html">runtime chapter</a> explains the host selection and allocation policy.</p>
{code('csrc/kernel_launcher/split_launch.cpp',40,66,'The ordered launch changes scheduling, while retaining split arithmetic')}
<p>U is live from the expansion’s store through all contraction splits. The residual X must remain live through split 0. Half partials remain live through split 3; counters remain live across all phases. The final Z becomes both QKV input and the later attention residual. After attention, the projection repeats the same pattern with A as matrix input and Z as residual. Returning from the bottleneck uses the inverse token-to-spatial repack before the C1024→C512 decoder transition.</p>
<p>The cache distinction matters when reading these diagrams. Global allocations are device-addressed storage; L2 and L1 are hardware-managed caches rather than explicit tensor buffers. <code>.ca</code> permits caching at all levels, <code>.cg</code> targets the global cache level, and no-allocate stores request no new L1 allocation. Cache hints do not replace memory ordering. These meanings follow the <a href="https://docs.nvidia.com/cuda/parallel-thread-execution/#cache-operators">NVIDIA PTX cache-operator specification</a>. Shared-memory ownership, register lifetimes, copy completion and split sequencing are explicitly expressed in this source.</p>
{note('Optimization reading checklist: identify reused A rows and B columns, count the bytes staged per K step, follow the barrier phase before every shared read, and locate every precision boundary. Do not infer achieved occupancy from __maxnreg__(168): it is a compile constraint, not a measured register count or performance result.')}
'''

attention_arch=fig('Global attention: logical graph and deployed fusion boundaries',355,
    box(20,25,180,72,'Z[T,1024]|FFN + residual')+edge(200,61,245,61)+box(245,25,240,72,'QKV projection|1024 → 32 × (Q32,K32,V32)','compute')+edge(485,61,535,61)+box(535,25,500,72,'Q: L2 norm × √32 × learned head scale|K: L2 norm; V: no normalization','compute')+
    box(20,160,255,85,'Q[h,T,32] × K[h,P,32]ᵀ|logical scores [32,T,P]','compute')+edge(275,202,325,202)+box(325,160,270,85,'clamped Half surrogate E|local 64-key register tiles','compute')+edge(595,202,645,202)+box(645,160,390,85,'numerator: Publish(E) × V|denominator: sum E − (P−T)E(0)','compute')+
    edge(830,245,830,285)+box(400,285,635,55,'divide → A[T,1024] → output projection + scaled Z residual','tensor')+txt(22,311,'P = ceil(T/64)×64'),
    'The global score and exponential matrices are logical objects. Deployment retains one small tile at a time and never allocates [32,T,P].')

qkv_diagram=fig('Two QKV splits become normalized consumer-ready fragments',340,
    box(20,35,220,98,'CTA: 128 tokens × 192|two heads × Q/K/V ×32|split 0: input K0…511','compute')+edge(240,83,285,83)+box(285,35,220,98,'Half partial Q/K/V|global scratch|first split stores only','storage')+edge(505,83,550,83)+box(550,35,215,98,'split 1: K512…1023|load prior Half partial|Half-add both slices','compute')+edge(765,83,810,83)+box(810,35,225,98,'final Q/K norm|V register transpose|precision publication','compute')+
    box(20,205,320,90,'Warp 0/2 → first head|Warp 1/3 → second head|each warp: 64 tokens × 96 values')+box(365,205,320,90,'Q and K: 16-token groups|K reorders fragment words|FP8: one 512 B head tile')+box(710,205,325,90,'V: transpose m8n8 register tiles|FP8 joins two M16 into M32|one M32/head occupies 1024 B'),
    'Normalization waits for the full 1024-channel projection sum. The normalized Q and transposed V go straight into their final consumer buffers.')

norm_diagram=fig('A head norm reduces channels without mixing tokens',295,
    box(20,30,240,92,'One query token, one head|32 projected Half channels|four participating lanes')+edge(260,76,305,76)+box(305,30,220,92,'square + pairwise sum|lower/upper N16 panels|packed Half order','compute')+edge(525,76,570,76)+box(570,30,215,92,'shuffle XOR 2, XOR 1|swap Half lanes + add|max(sum, ε)','compute')+edge(785,76,825,76)+box(825,30,210,92,'rsqrt → Half|multiply vector|Q also × √32 × scale','compute')+
    txt(30,180,'At fixed row, lanes 12–15 jointly cover the channel pairs of token row 3 (and row 11).')+txt(30,213,'The same row is preserved through the butterfly. No other token, head, or shared array enters its norm.')+txt(30,246,'ε bits 0x0410 = 6.198883056640625e−5; this deployment floor differs from training’s 1e−12 rule.'),
    'FP8 normalization still runs in packed Half before E4M3 publication. The replicated sum allows one scalar reciprocal-square-root path to supply both Half lanes.')

attn_memory=fig('One attention CTA: keep Q, stream K and V, retain sums',370,
    box(20,25,245,90,'Global Q[h,256,32]|.ca 16-byte loads|four warps ×64 queries','storage')+edge(265,70,310,70)+box(310,25,270,90,'Q registers persist|4 × M16 per warp|1 FP8 /2 FP16 K chunks','storage')+edge(580,70,635,70)+box(635,25,400,90,'Tensor Core QKᵀ → Half E registers|per warp: 64 queries ×64 keys|tile dies after denominator + PV','compute')+
    box(20,185,245,90,'Global K/V for one head|64 keys per iteration|32 channels per key','storage')+edge(265,230,310,230)+box(310,160,270,140,'Shared K slot 0 / slot 1|Shared V slot 0 / slot 1|FP8 total: 8192 +16 B|FP16 total: 16384 +16 B','storage')+edge(580,230,635,230)+box(635,185,400,90,'Register K and transposed V fragments|Tensor Core E×V → Half numerator|denominator: one Half2 per lane','compute')+
    edge(835,115,835,185)+txt(25,337,'Each K/V tile is reused by all 256 CTA queries. Only O(T×32) Q/K/V and output storage persist globally.'),
    'The two barrier objects govern matched K and V slots. L2/L1 are hardware-managed caches, not an extra named tensor allocation.')

address_diagram=fig('Trace query token 355, head 7, through one lane',345,
    box(20,25,480,118,'CTA query block=1; warp=1; M16 tile=2|group=1×16+1×4+2=22; group base=352|lane 13 owns rows 3/11 → tokens 355/363|head=7; choose local channel pair 2/3')+edge(500,84,550,84)+box(550,25,485,118,'Q vector byte address, FP8|22×16384 +7×512 +13×16 =364240|FP16 first chunk: 728272 bytes|FP16 second chunk: +512 bytes','storage')+
    box(20,200,480,96,'For key tile j=2: keys 128…191|slot=j mod 2=0; lane13 shared base=208|FP8 K panel 1: +512 → shared offset720','storage')+edge(500,248,550,248)+box(550,200,485,96,'Denominator return for token355|QueryRow=2×16+13/4=35|shuffle lane=35 mod32=3, high Half|same inverse scales all 32 output channels','compute')+txt(25,328,'Byte addresses exclude the allocation base. Channel/row identities shown are output-fragment ownership.'),
    'One query has 32 channels spread across lanes and column fragments. The denominator transpose assigns one scalar to each query, then shuffles it back to its output owners.')

attention_tile=fig('One 64-key iteration produces two different reductions',330,
    box(20,30,205,92,'Q[64,32] registers|K[64,32] staged|one warp’s view','tensor')+edge(225,76,270,76)+box(270,30,250,92,'QKᵀ → E[64,64]|Half fragment registers|no row-max subtraction','compute')+
    edge(520,75,570,75)+box(570,30,465,92,'Denominator branch: Half sums of E|sum columns within lane → warp ownership transpose|accumulate one 64-key chunk into d','compute')+
    edge(400,122,400,180)+box(270,180,250,95,'Publish E as MMA A|FP8: pack E4M3|FP16: retain Half','compute')+edge(520,227,570,227)+box(570,180,465,95,'Numerator branch: Epublished × V|FP8: 2 K32 chunks; FP16: 4 K16 chunks|accumulate into persistent O[64,32] Half registers','compute')+
    txt(25,312,'The denominator uses the Half surrogate before FP8 packing; the numerator consumes the published precision.'),
    '“Probability” is the source variable name. At this point E is unnormalized; division occurs after all key tiles have been consumed.')

padding_diagram=fig('Two padding boundaries and a corrected denominator',330,
    box(20,30,325,95,'T = H×W real bottleneck tokens|includes network spatial padding|example T=2160','tensor')+edge(345,77,395,77)+box(395,30,300,95,'Storage alignment S|FP16: ceil(T/16)×16|FP8: ceil(T/32)×32','storage')+edge(695,77,745,77)+box(745,30,290,95,'Traversal boundary P|ceil(T/64)×64|remaining K/V staged as zero','storage')+
    box(20,180,470,95,'Each padded key: K=0 ⇒ score=0 ⇒ E(0)>0|V=0 ⇒ numerator contribution=0|denominator still gains E(0)','compute')+edge(490,228,540,228)+box(540,180,495,95,'4K: P−T=16; E(0)=0.083984375|correction=16×E(0)=1.34375|d ← HalfSub(d, Half(FP32 correction))','compute')+txt(25,311,'The correction removes traversal padding only. It does not mask spatial padding already included in T.'),
    'S and P happen to coincide for FP8 at T=2160. They are different rules; staged zeros cover traversal slots outside the stored token groups.')

attention_body=f'''
<h2 id="architecture">Model piece: C1024 global attention, records 31–38</h2>
<p>After the dense FFN and its residual, each bottleneck token Z[t,:] contains 1024 channels. The QKV projection creates <strong>32 heads with 32 channels each</strong>: Qraw, Kraw, V logically have shape [32,T,32]. Q and K are independently L2-normalized across one token’s 32 channels. Q is then multiplied by √32 and the learned per-head scale; V is unchanged. Every real query reads all T tokens in the padded bottleneck image. No window restriction or relative-bias table is applied.</p>
<p>For head h, let P=ceil(T/64)·64 and fill the additional K/V rows with zeros. The conceptual score is s[q,k]=Q[q,:]·K[k,:]. The kernel computes an exponential surrogate E(s), then a numerator N[q,:]=Σₖ Publish(E(s[q,k]))·V[k,:] and denominator D[q]=Σₖ E(s[q,k])−(P−T)E(0). Its result is Publish(N/max(D,ε)). This precision-aware description matters: the FP8 numerator sees E4M3 exponentials, while the denominator is accumulated from Half exponentials before that conversion.</p>
<p>The <a href="architecture.html#global-attention-c1024-bottleneck">architecture document</a> gives the network-level explanation. This chapter follows the actual deployment buffers, fragments and rounding points. At 4K, [H,W,C]=[36,60,1024], T=2160 and P=2176; one head’s conceptual [T,P] matrix has 4,700,160 elements, but no such matrix allocation appears in this tiled kernel.</p>
{attention_arch}
<h2 id="qkv">Step 1 — form two heads’ Q/K/V in one matrix tile</h2>
<p>The QKV CTA covers 128 tokens and 192 output values: two heads × three components ×32 channels. It is a close relative of the <a href="bottleneck-linear.html#contract">global contraction</a>, with six N16 accumulator groups per warp instead of four. Warp parity selects which of the two heads it owns; warp/2 selects the lower or upper 64 tokens. The weight record starts with 128 bytes containing 32 FP32 head scales, then interleaves Q32,K32,V32 for each head.</p>
{qkv_diagram}
<p>Two K512 slices make up the complete 1024-input-channel projection. Each slice takes 16 steps of K32, with a two-slot input ring. FP16 uses two K16 MMA subtiles per step and 8192-byte stages; FP8 uses one K32 MMA subtile and 4096-byte stages. Thus this FP8 kernel does not double the K step as the FFN expansion does. Input staging and register weight prefetch reuse the contraction primitives, but its final publication is different.</p>
{code(Q8,87,120,'QKV loads one interleaved weight panel and drains its staged reduction')}
<p>Split 0 publishes ordinary Half partials. Split 1 reads and adds them before normalization or V transposition. FP16 temporarily uses the Q/K/V output allocations as its partial tensors. FP8 reserves separate Half scratch, with components separated by <code>paddedGroups·32768</code> bytes. For group g, head h, N16 panel n and lane L, a Half partial vector is at <code>base+g·32768+h·1024+n·512+L·16</code>. This produces a clear lifetime: the first split’s values must remain intact until the second split consumes them.</p>
{code(Q8,127,168,'The FP8 QKV intermediate is Half, with an explicit component stride')}
<h2 id="normalization">Step 2 — finish the full-head norm in registers</h2>
<p>The final Q/K epilogue squares the lower and upper N16 panels, adds paired results, and reduces the 32-channel head through packed Half operations. A butterfly with XOR 2 then XOR 1 combines four lanes; adding the swapped low/high Half components finishes the scalar sum. The sum is floored at <code>0x0410</code>, or 6.198883056640625×10⁻⁵, before reciprocal square root. This is the deployment rule; the training architecture’s 10⁻¹² normalization floor describes its floating PyTorch path.</p>
{norm_diagram}
<p>The Q path multiplies by the approximate √32 rounded to Half, then by the FP32 header scale converted to Half. K only receives its inverse norm. The FP8 specialization notices that the final sum is replicated in both Half lanes, performs one FP32 approximate-rsqrt path, rounds once to Half and duplicates that value. It avoids duplicate scalar work without changing which head or token is normalized. V skips all this arithmetic.</p>
{code(P+'bottleneck_c1024_attention/common/global_qkv.cuh',18,39,'Reduction order and the replicated FP8 inverse-norm path')}
{code(P+'bottleneck_c1024_attention/common/global_qkv.cuh',54,80,'Normalize Q/K only after combining both K512 slices')}
<h2 id="consumer-layout">Step 3 — publish Q, K and V in different consumer layouts</h2>
<p>Q becomes the MMA A operand for QKᵀ; K must supply its B fragments; V must later supply B fragments for E×V. Their logical shape equality therefore does not imply interchangeable storage. Q/K use 16-token groups. K swaps the middle fragment words during publication. V first applies <code>movmatrix.sync.trans.aligned.m8n8.b16</code> to its Half register fragments. FP8 then combines adjacent M16 tiles into M32 groups, while FP16 retains M16 groups with two N16 panels.</p>
<p>In FP8 Q and K each use <code>g·16384+h·512+L·16</code> per lane vector, but K’s vector order is [word0,word2,word1,word3]. FP8 V uses <code>floor(g/2)·32768+h·1024+(g mod2)·512+L·16</code>, with words assembled from neighboring token groups. This fused transpose/pack prevents a standalone global V-transpose pass. It also means dumping these buffers and reshaping them as dense [T,1024] will not reconstruct the tensor correctly.</p>
{code(Q8,175,216,'V transposes in registers and packs neighboring M16 groups')}
<p>The Half entry preserves two N16 panels rather than packing them together. Its K store still changes word order to [0,2,1,3], while Q/V store the two panels at offsets 0 and 512. Each head therefore occupies 1024 bytes per M16 group instead of FP8 Q/K’s 512. Comparing these stores is the most direct way to understand why the attention consumer’s <code>QueryChunks</code> changes from two to one.</p>
{code(Q16,203,228,'The FP16 publication retains two panels and explicitly permutes K')}
<h2 id="cta">Step 4 — give one head and 256 queries to a CTA</h2>
<p>For the attention kernel, <code>blockIdx.x</code> selects the head and <code>blockIdx.y</code> selects a 256-query block. Each of four warps keeps 64 query rows, expressed as four M16 A fragments. Q is loaded once with cache-all 16-byte loads and remains in registers for the entire traversal. The kernel initializes four output accumulator tiles and a packed Half2 denominator per lane; these also survive every key iteration.</p>
{attn_memory}
<p>K and V stream through shared memory in 64-token tiles. The profile has two K slots and two V slots. Each slot is 2048 bytes in FP8 or 4096 bytes in FP16. Shared V begins after the two K slots; two 8-byte barriers follow all four data slots. K and V copies for the same stage attach to the same barrier, so readiness covers both operands. All CTA queries reuse the staged K/V block, rather than each warp issuing an independent global load for every query.</p>
{code(P+'bottleneck_c1024_attention/common/global_attention.cuh',7,24,'The storage budget and ownership are explicit profile values')}
{code(A8,103,134,'Load Q once, prime two K/V stages, and allocate persistent register results')}
<p>The kernel waits for predecessor counter groups before loading Q or a future K/V tile. A counter index is <code>(queryBlock128·16 + head/2)·4</code>; the local wait exits when it observes a nonnegative value. This source condition is not “wait for split 1”: host launch order supplies the full QKV-before-attention dependency in the deployment plan. The name <code>chained</code> alone does not establish concurrent producer/consumer execution. Completion publication at the end uses a separate per-128-token, per-head index.</p>
{address_diagram}
<h2 id="staging">Step 5 — decode a K/V tile’s addresses and shared slot</h2>
<p>For key tile j, the shared K base is <code>(j mod2)·stageBytes</code>. FP8 has one query chunk, so warp w copies token group 4j+w into a 512-byte shared panel. FP16 has two chunks: <code>copySlot=w+4·copy</code>, group <code>4j+floor(copySlot/2)</code>, and chunk <code>copySlot mod2</code>. K’s global byte address is <code>group·16384·elementBytes + head·512·elementBytes + chunk·512</code>. This recovers 64 key rows with all 32 channels in either precision.</p>
<p>For V the address uses its published transposed layout: <code>valueGroup·32768+head·1024+(copySlot mod2)·512</code>. FP8 uses <code>valueGroup=2j+floor(copySlot/2)</code>; FP16 uses the M16 key group. The recovered tiny-profile branches need separate attention: FP16 remaps Q/K/V groups to zero for 1–16 tokens, while FP8 broadcasts V group zero if there is only one M32 value group. The ordinary multi-group deployment geometry used in these diagrams does not take those branches. Otherwise, out-of-range groups write zero uint4s into the same shared destinations that a valid copy would fill. The current slot is consumed, then j+2 is staged into that slot and the CTA waits for j+1 before the next iteration.</p>
{code(A8,32,87,'K and V use different global maps but share stage completion')}
<p>On SM90+ these are ordinary-address bulk copies, not tensor-map descriptor loads and not TMA coordinate swizzles. Before SM90 the shared helper expands each 512-byte copy into one coalesced 16-byte copy per lane using <code>cp.async.cg</code>. The completed mbarrier phase makes the copy visible to consuming threads; an ordinary thread arrival alone would not prove that an asynchronous transfer finished. These mechanisms follow the <a href="https://docs.nvidia.com/cuda/parallel-thread-execution/#data-movement-and-conversion-instructions-cp-async-bulk">PTX asynchronous-copy completion rules</a>.</p>
<h2 id="scores">Step 6 — compute a score tile, then apply the exact surrogate</h2>
<p>Each warp forms four [16,64] score tiles: four query M16 fragments times eight key N8 fragments. In FP16 the 32-channel dot product needs two K16 MMA calls per score fragment; FP8 needs one K32 call. The score result is Half in both cases. For an output fragment lane L, row-half r and N8 column tile c, the query row is <code>16·queryTile+floor(L/4)+8r</code>, and its two key columns are <code>8c+2(L mod4)+{{0,1}}</code> within the current 64-key tile.</p>
{attention_tile}
<p>The exponential surrogate uses a Half fused affine operation <code>z=HalfFma(score,0.08953857421875,1.708984375)</code>, clamps z into [1.439453125,1.9775390625], then reinterprets the two packed Half encodings using <code>(packed_z&lt;&lt;4)+0x3ffc4000</code>. The entire 32-bit shift and add are intentional: carries between packed lanes are compensated by the constant. Splitting the lanes, calling <code>exp</code>, or substituting conventional softmax changes the kernel. There is no row-maximum subtraction or online softmax rescaling here.</p>
{code(A8,149,175,'The global exponent is an exact packed-bit program')}
<h2 id="denominator">Step 7 — reduce denominators while preserving Half add order</h2>
<p>Eight column-pair groups contribute to each score row. The code first builds four local partial sums per query half using a fixed Half addition tree. Its two-way register transpose changes ownership: previously four lanes shared one row’s channel pieces; afterward lane L owns a complete row L (and the corresponding second 32-query half). It permutes four registers by XOR, shuffles from <code>((L&amp;7)&lt;&lt;2)+(L&gt;&gt;3)</code> XOR the register index, reverses the local permutation, adds in the recorded order, and combines the two Half components.</p>
<p>Consequently a single Half2 denominator per lane holds two independent queries: the warp’s rows L and L+32. The sum of each 64-key tile is Half-added to this running pair. It is neither an FP32 sum over all P keys nor a shared-memory reduction. Fixed register indices in <code>PermuteGlobalAttentionQuad</code> expose compile-time register selection, helping avoid turning a tiny permutation into dynamically indexed local storage. That is a source-level optimization rationale; compiler output is needed to confirm actual spills.</p>
{code(A8,197,215,'A warp transpose gives one query denominator to each lane')}
<h2 id="numerator">Step 8 — reuse E immediately as the left operand of E×V</h2>
<p>The same E register tiles now feed a second Tensor Core product. <code>PublishWindowChunk</code> keeps Half words in FP16 and converts/merges them to E4M3 in FP8. Two K32 chunks span 64 keys in FP8; four K16 chunks do so in FP16. V was transposed during QKV publication, so its staged vectors already supply the needed column fragments. Four persistent [16,32] Half output accumulators receive the weighted values for the warp’s 64 queries.</p>
<p>After denominator and numerator consumption, that iteration’s E and K/V registers can be overwritten. Q, the numerator and denominator remain. This lifetime split removes the quadratic score allocation and traffic: the expensive logical [T,P] objects are represented by bounded per-warp fragments, while only Q/K/V and final output scale with token count. It does not eliminate the quadratic number of query–key products; every query still reads the global key domain.</p>
{code(A8,218,253,'Consume exponentials immediately, refill the retired stage, and wait for the next')}
<h2 id="padding">Step 9 — remove only the artificial traversal-key mass</h2>
{padding_diagram}
<p>There are three distinct counts. T is the real bottleneck field, including any network spatial padding. A precision-specific storage count S rounds T to 16 or 32 in the kernel (the common host allocation can round to 32 for either precision). The attention traversal count P rounds T to 64. If P exceeds stored groups, staging fills the extra groups with zeros. For T=2160, FP16 kernel storage alignment is 2160, FP8 is 2176, and traversal is 2176; the common host allocation may reserve 2176 in both modes.</p>
<p>A padded key has dot product zero, but its surrogate E(0) is nonzero. From the exact constants, z(0) bits are 0x3ed6 and the scalar transform <code>((0x3ed6&lt;&lt;4)+0x4000) mod65536</code> yields 0x2d60, or 0.083984375. With 16 padding keys, correction is 1.34375. The code computes E(0) from those same Half operations, converts it and the integer count to FP32, multiplies with FTZ, rounds the correction to Half, then uses one Half subtraction. Zero V adds nothing to the numerator, so only the denominator is corrected.</p>
{code(A8,256,277,'Correct padding before reciprocal normalization')}
<h2 id="finish">Step 10 — return each denominator to its output fragments</h2>
<p>The corrected denominator is floored at the deployment epsilon and inverted using <code>RcpHalf2</code>. For each output row, <code>QueryRow=queryTile·16+lane/4+rowHalf·8</code> identifies which lane owns its denominator. A shuffle selects lane QueryRow mod32, then chooses the low or high Half using floor(QueryRow/32). Duplicating that Half scales the two channel values in each output word. This return shuffle connects the row-sum ownership layout back to the MMA accumulator layout.</p>
<p>Publication uses Q’s token/head physical layout. FP8 packs its final normalized Half accumulator into E4M3; FP16 retains Half. After fragment stores, a CTA synchronization precedes clearing invalid tail rows of the last stored group. A further synchronization precedes optional completion-counter release. A must remain live until the output projection consumes it; the projection also needs the published FFN residual Z. Neither denominators nor exponential tiles survive as global tensors.</p>
{code(A8,280,310,'Fetch the right query scalar and publish the normalized output')}
<table><thead><tr><th>Property</th><th>FP16</th><th>FP8</th></tr></thead><tbody>
<tr><td>Q/K/V publication</td><td>Half</td><td>E4M3 after Half normalization/transpose</td></tr>
<tr><td>QK reduction channels per MMA</td><td>16; two calls per dot</td><td>32; one call per dot</td></tr>
<tr><td>Scores, surrogate, sums, output accumulator</td><td>Half</td><td>Half</td></tr>
<tr><td>E used by numerator</td><td>Half</td><td>Converted E4M3</td></tr>
<tr><td>V token group</td><td>M16, two N16 panels</td><td>M32, packed neighboring M16 panels</td></tr>
<tr><td>Shared K/V storage</td><td>16384 data +16 barrier bytes</td><td>8192 data +16 barrier bytes</td></tr>
<tr><td>Final normalization/output</td><td>Half multiply, Half store</td><td>Half multiply, E4M3 pack/store</td></tr></tbody></table>
{note('Read “optimized” as a concrete mechanism: packed consumer-ready layouts, register-resident Q and sums, 256-query K/V reuse, asynchronous two-slot copies, fused normalization/transposition, and eliminated global score tensors. This chapter establishes those mechanisms from source; it does not invent speedups, cache-hit rates, occupancy, or bandwidth measurements.')}
'''

CHAPTERS = [
    dict(slug='bottleneck-linear', title='C1024 dense FFN, layouts and output projection', summary='Follow spatial-to-token addressing, triple-buffered expansion, ordered Half split reductions, residual fusion and FP8 publication.', body=linear_body),
    dict(slug='global-attention', title='C1024 global QKV and streaming attention', summary='Trace head normalization, per-lane Q/K/V layouts, two-stage K/V streaming, exponentials, row-sum shuffles and padding correction.', body=attention_body),
]
