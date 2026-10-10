"""Ten standalone, constructive lessons for the C1024 public kernel entries."""
from html import escape
from common import code, svg, note, source_url
from lesson_support import pseudo, mma_primer, storage_legend

P = 'csrc/kernel_impl/'
S = P + 'shared/common/'
ARCH = source_url('docs/ARCHITECTURE.md')


def text(x, y, value, size=15):
    return f'<text x="{x}" y="{y}" style="font-size:{size}px;font-weight:500">{escape(str(value))}</text>'


def box(x, y, w, h, value, kind='tensor'):
    return (f'<rect class="{kind}" x="{x}" y="{y}" width="{w}" height="{h}" rx="8"/>'
            + ''.join(text(x+12, y+25+i*23, line) for i, line in enumerate(value.split('|'))))


def arrow(x1, y1, x2, y2):
    dx, dy = x2-x1, y2-y1
    length = (dx*dx+dy*dy)**.5
    ux, uy = dx/length, dy/length
    return (f'<path d="M{x1},{y1} L{x2},{y2}" stroke="#527487" stroke-width="2" fill="none"/>'
            f'<polygon points="{x2},{y2} {x2-9*ux+4*uy},{y2-9*uy-4*ux} '
            f'{x2-9*ux-4*uy},{y2-9*uy+4*ux}" fill="#527487"/>')


def figure(title, height, inner, caption):
    return svg(title, f'0 0 1060 {height}', inner, caption)


def graph(operation, fp8):
    fmt = 'E4M3 FP8' if fp8 else 'FP16'
    if operation == 'expand':
        pieces = [('X[t,1024]', fmt+' physical input'), ('dot with W₁[:,n]', '1024-channel reduction'),
                  ('Half φ(x)', 'clamped polynomial'), ('U[t,4096]', fmt+' publication')]
    elif operation == 'contract':
        pieces = [('U[t,4096]', fmt+' activated FFN'), ('dot with W₂[:,n]', 'four K1024 splits'),
                  ('+ scale[n]×X[t,n]', 'residual seeded once'), ('Z[t,1024]', fmt+' QKV input')]
    elif operation == 'projection':
        pieces = [('A[t,1024]', fmt+' attended heads'), ('dot with Wₒ[:,n]', 'four K256 splits'),
                  ('+ scale[n]×Z[t,n]', 'attention residual'), ('Y[t,1024]', fmt+' block output')]
    else:
        pieces = [('Z[t,1024]', fmt+' FFN result'), ('QKV dot products', 'two K512 splits'),
                  ('Q/K norm; V transpose', '32 heads ×32 channels'), ('Q, K and V buffers', fmt+' consumer layouts')]
    content = ''
    for i, (a,b) in enumerate(pieces):
        x = 20+i*260
        content += box(x,35,240,80,a+'|'+b,'compute' if i in (1,2) else 'tensor')
        if i < 3:
            content += arrow(x+240,75,x+255,75)
    content += text(25,160,'One t is one spatial position. These matrix projections do not mix positions; they mix that token’s channels.')
    content += text(25,190,'Records 31–38 use this operation. At 4K: H=36, W=60, T=2160, C=1024.')
    return figure(operation+' logical model operation in '+fmt,220,content,
                  'The logical equation comes first. Subsequent diagrams explain how each value is distributed across physical vectors and lanes.')


def ownership(n=128):
    wn = n//2
    inner = box(20,25,340,100,f'CTA result: M128 × N{n}|threadIdx.x = lane L, 0…31|threadIdx.y = warp w, 0…3','compute')
    for w in range(4):
        x,y=400+(w%2)*320,20+(w//2)*112
        inner += box(x,y,300,90,f'Warp {w}: M{64*(w//2)}…{64*(w//2)+63}|N{wn*(w%2)}…{wn*(w%2)+wn-1}|4 M16 × {wn//16} N16 fragments')
    inner += text(25,173,'Every N16 = two m16n8 outputs.')+text(25,203,'Each output word = two Half values.')
    inner += text(25,270,'Lane 13: row pair 3/11; channel pairs 2/3 and 10/11, relative to one M16×N16 tile.')
    inner += text(25,300,'A and B fragments use their own operand maps; the output ownership rule must not be reused as an input map.')
    return figure(f'Derive M128 N{n} ownership from four warps',330,inner,
                  'Warp parity chooses output columns; floor(warp/2) chooses token rows. Both row warps reuse the same weight panel.')


def address_figure(title, values):
    a,b,c,d=values
    return figure(title,300,
        box(20,25,495,95,a,'tensor')+arrow(515,72,550,72)+box(550,25,490,95,b,'storage')+
        box(20,160,495,95,c,'storage')+arrow(515,207,550,207)+box(550,160,490,95,d,'tensor'),
        'All offsets are bytes relative to the named allocation base. The unit conversions are part of the algorithm.')


def pipeline(stages, stage_bytes, step, initial, name):
    return figure(f'{name}: operand lifetime in a {stages}-stage ring',345,
        box(20,25,210,90,'Global A tensor|packed 16-token groups|K slabs per group','storage')+arrow(230,70,270,70)+
        box(270,25,220,90,'Asynchronous copies|SM90+: issuer per warp|SM80/89: lane stripes','compute')+arrow(490,70,530,70)+
        box(530,25,230,90,f'{stages} shared slots|{stage_bytes} bytes per slot|K{step} per reduction step','storage')+arrow(760,70,800,70)+
        box(800,25,240,90,'A register fragments|reuse across N panels|no shared transpose','storage')+
        box(20,185,250,85,'Packed W → .ca loads|B fragments in registers|reuse across four M16 tiles','storage')+arrow(270,226,310,226)+
        box(310,185,270,85,'mma.sync A×B + C|C stays in Half registers|CTA owns its current partial','compute')+arrow(580,226,630,226)+
        box(630,185,410,85,'Epilogue: apply this kernel’s math|publish global output or ordered Half partials|L1 no-allocation stores','storage')+
        arrow(920,115,920,148)+arrow(920,148,445,148)+arrow(445,148,445,185)+
        text(25,317,f'Prefill {initial} stage(s). Wait for the matching barrier phase before reading. Recycle only after old consumers advance.'),
        'L2/L1 caching is hardware-managed. Shared slot addresses and register reuse are explicitly controlled by the kernel.')


def split_figure(count, split_width, fp8, qkv=False):
    width = 960//count
    inner=''
    for s in range(count):
        x=30+s*(width+10)
        phase=('first Half store' if s==0 else 'final add + epilogue' if s==count-1 else 'ordered Half add')
        inner += box(x,30,width-10,100,f'Split {s}: K{s*split_width}…{(s+1)*split_width-1}|{phase}|'+('no normalization yet' if qkv and s==0 else 'residual only in split 0' if not qkv else 'Q/K norm, V transpose'),'compute')
        if s<count-1: inner+=arrow(x+width-10,80,x+width+7,80)
    target = 'separate FP16 scratch; final output is E4M3' if fp8 else 'FP16 destination used as scratch until final publication'
    inner+=box(70,190,920,80,'Partial tensor lifetime spans all split publications|'+target,'storage')
    inner+=text(25,315,'Resident mode: predecessor counter orders publication. Ordered mode: one complete split plane per stream-ordered launch.')
    return figure('Split work and global partial-tensor lifetime',345,inner,
                  'Separate split CTAs compute independently, but Half partial updates have a required order. The final epilogue runs after the full sum exists.')


def precision_figure(fp8, activation=False):
    return figure('The epilogue is a precision boundary',265,
        box(20,35,300,95,'Half accumulator words|two values per 32-bit word|'+('apply φ with Half operations' if activation else 'add ordered Half partials'),'storage')+
        arrow(320,83,370,83)+box(370,35,300,95,('E4M3 conversion|round-to-nearest, finite saturation|join four bytes into one word' if fp8 else 'Retain Half bits|no E4M3 conversion|four words form one uint4'),'compute')+
        arrow(670,83,720,83)+box(720,35,320,95,'Publish a 16-byte lane vector|consumer-ready native layout|one store, no extra transpose','storage')+
        text(25,184,'A global publication survives the kernel. Register intermediates end here.')+
        text(25,216,'A materialized pre-epilogue tensor would add another global write/read pass; this kernel fuses that pass.'),
        'The format at publication is independent from the accumulator format used inside the Tensor Core instruction.')


def scalar_matmul(kind, fp8):
    fmt='E4M3' if fp8 else 'Half'
    if kind=='expand':
        return pseudo(f'''for token t in 0 .. T-1:
    for output n in 0 .. 4095:
        sum = 0
        for input k in 0 .. 1023:
            sum += decode(X[t,k]) * decode(W1[k,n])
        b = clamp(sum, -4, 4)
        U[t,n] = round_to_{fmt}(sum * (b*(-0.055908203125*abs(b)+0.447265625)+0.89453125))''',
                      'Scalar mathematical baseline: correct dependency graph, not a bit-exact replacement for Half MMA')
    k=4096 if kind=='contract' else 1024
    inp,res,out=('U','X','Z') if kind=='contract' else ('A','Z','Y')
    return pseudo(f'''for token t in 0 .. T-1:
    for output n in 0 .. 1023:
        sum = scale[n] * decode({res}[t,n])
        for input k in 0 .. {k-1}:
            sum += decode({inp}[t,k]) * decode(W[k,n])
        {out}[t,n] = round_to_{fmt}(sum)''',
                  'Scalar mathematical baseline: introduce split rounding and fragment arithmetic in later steps')


def physical_primer(fp8, nout):
    kfrag=32 if fp8 else 16
    extra=('''<p>The FP8 matrix’s natural-channel decoder first applies <code>inverse_packed_input_index(k)</code>, then <code>packed_weight_index</code>. This permutation is essential: a native MMA K coordinate and a model channel are different labels. The input producer’s packing and the weight row permutation agree. When building fixtures, use those maps together; blindly writing natural-channel rows into the raw byte record does not create the intended matrix.</p>'''
           if fp8 else '''<p>For FP16 weights, <code>packed_f16_weight_index(k,n,N)</code> returns a Half-element offset: panel=(k//16)·ceil(N/16)+n//16; lane=4·(n mod8)+floor((k mod8)/2); within-lane index=4·floor((n mod16)/8)+2·[k mod16≥8]+(k mod2). Multiply the result by two to obtain bytes. This gives you a scalar packer independent of the kernel’s vector-load formula.</p>''')
    return f'''<h3>Define the packed layout before optimizing memory traffic</h3>
<p>The public pointers address opaque packed buffers. A token group contains 16 rows. One native M16×K{kfrag} A panel consumes 512 bytes, distributed as 32 lanes ×16 bytes. For input width K and element size E, group g begins at <code>g·16·K·E</code>. A reduction step advances along K in whole panels. Within a panel, lane L reads the vector at <code>L·16</code>. The publication layout arranges token rows and channel pairs to make those four words immediately usable by MMA.</p>
<p>A packed B panel for 16 output channels also occupies 512 bytes. One lane’s uint4 supplies two N8 fragments: the first two words belong to the first N8, the next two words to the second. Across K panels, the record advances by <code>N·32</code> bytes, where this kernel’s N is {nout}. The equality follows from {kfrag} reduction values × {1 if fp8 else 2} bytes per value =32 bytes per output column. A cache-all vector load fetches those words directly to registers.</p>
{extra}
{code('dlssnr/weights.py',54,77,'Scalar channel and weight index maps used to decode the packed record')}
<p>The C/D accumulator has an easier map. In one M16×N8 result, lane L owns token rows floor(L/4) and floor(L/4)+8, and output channels 2·(L mod4) and 2·(L mod4)+1. Two packed Half words hold those four elements. An N16 tile contains two such fragments and therefore four words per lane. Logical output ownership, native A operand ownership and native B operand ownership are separate maps.</p>'''


def async_explanation(stages):
    return f'''<h3>Make the copy barrier part of the construction</h3>
<p>Allocate {stages} shared data slots and one 8-byte mbarrier per slot. Lane 0 of warp 0 initializes each barrier with 128 expected thread arrivals, then the CTA synchronizes before any producer can issue copies. On SM90+, <code>IsCopyProducer</code> elects one lane per participating warp; it issues an ordinary-address <code>cp.async.bulk</code> and registers the transferred byte count. On SM80/89, every lane issues 16-byte <code>cp.async.cg</code> stripes and attaches its own copies with <code>cp.async.mbarrier.arrive</code>. A 512-byte transfer needs one stripe per lane, a 1024-byte transfer needs two.</p>
<p><code>ArriveAndWait</code> makes every thread arrive, obtains the current phase token, and polls until that exact phase completes. Reusing the same barrier address next iteration requires a new token; readiness from a previous cycle is insufficient. Completion also accounts for attached asynchronous transfers. Ordinary thread arrival alone cannot establish copy completion. The schedule must separately establish that the previous tile’s readers have finished before a slot is overwritten. No tensor-map descriptor, TMEM allocation, warp-group MMA or shared-to-register <code>ldmatrix</code> operation is used in this path: its shared vectors already have the correct MMA fragment order.</p>
{code(S+'memoryops.cuh',9,19,'Wait for this arrival phase, not a permanent ready flag')}
<p>Global storage is backed by device memory; L2 and L1 are hardware-managed caches on relevant load/store paths. The source’s <code>.ca</code> weight loads permit all-level caching. Its pre-SM90 <code>.cg</code> asynchronous copies use the global cache level. <code>L1::no_allocate</code> output stores request no new L1 allocation. None of these hints implies a guaranteed hit rate or replaces synchronization. <a href="https://docs.nvidia.com/cuda/parallel-thread-execution/#cache-operators">NVIDIA’s PTX cache specification</a> defines those distinctions.</p>'''


def split_ordering(fp8, count, family):
    acquire=('''The portable FP8 contraction/projection path additionally calls <code>AcquireSplitPublication</code> after successfully polling, then uses a CTA barrier to pass that visibility to the other lanes.''' if fp8 and family=='contract' else '''This entry polls relaxed counters and uses a CTA barrier, but does not call the separate acquire helper in this source snapshot. The description records that protocol; it is not a new formal memory-order proof.''')
    return f'''<h3>Order split publication independently of computation</h3>
<p>The source supports two protocols. With <code>OrderedSplit=0</code>, <code>blockIdx.z</code> is the logical split. A later split may compute its matrix partial while its predecessor runs, but before touching the predecessor’s global partial it polls the corresponding counter until the recorded split is available. The counter starts at −1, and each producer performs a release counter store after its publication and a CTA synchronization. {acquire}</p>
<p>With <code>OrderedSplit=s+1</code>, the host launches only the XY plane for split s, with grid.z=1. The same stream completes that plane before entering the next split. The kernel skips the resident predecessor wait. The launcher selects this path when the complete dependent grid cannot fit its occupancy-derived capacity; otherwise waiting consumers could occupy resources needed by unscheduled producers. It preserves all {count} partials and their Half rounding rather than replacing them with a different reduction.</p>
{code('csrc/kernel_launcher/split_launch.cpp',51,66,'Each ordered split completes before its successor is launched in the same stream')}
<p>Keep scratch, output, residual and counter allocations live until their final consumers finish. Registers and shared memory belong to one CTA invocation and cannot carry a result into the next split launch. The partial tensor is the explicit storage bridge. Counters govern publication, not the mathematical value of a matrix element.</p>'''


def expand_lesson(name, fp8):
    fmt='FP8' if fp8 else 'FP16'
    elem=1 if fp8 else 2
    step=64 if fp8 else 32
    steps=1024//step
    path=P+f'bottleneck_c1024_ffn/{fmt.lower()}/{name}.cu'
    example_a=5*16384*elem+3*1024+13*16+512
    example_out=5*65536*elem+13*16+(512 if fp8 else 1024)
    return dict(name=name,title=f'{name}: build the 1024→4096 expansion',family='Global bottleneck',
      summary=f'A standalone {fmt} derivation: scalar FFN, packed operands, a 128×128 CTA, three input stages, Half activation and exact output publication.',
      body=f"""
<h2 id="model">1. Start with the exact model operation</h2>
<p><code>{name}</code> implements the first matrix and activation of the dense FFN in bottleneck records 31–38. Let T be the token count and X be logically [T,1024]. W₁ is [1024,4096], and the result U is [T,4096]. The equation is <code>U[t,n]=Publish(φ(Σₖ X[t,k]W₁[k,n]))</code>. Its recovered activation uses b=clamp(x,−4,4) and <code>φ(x)=x·(b·(−0.055908203125·abs(b)+0.447265625)+0.89453125)</code>. There is no matrix bias or residual addition in this entry. The second FFN matrix will later contract U and join the residual.</p>
<p>At the architecture’s 4K example the bottleneck field is 36×60, so T=2160. This entry defines T as <code>BatchCount·TokensPerBatch</code>; its physical processing treats that product as one token extent. The prepared deployment uses batch one. Working inputs and outputs are {fmt}; all Tensor Core accumulators and activation arithmetic here are Half. The <a href="{ARCH}">model architecture</a> supplies the surrounding network, but this page defines everything required for this kernel.</p>
{graph('expand',fp8)}
<h2 id="baseline">2. Build a scalar correctness baseline</h2>
{scalar_matmul('expand',fp8)}
<p>Use this baseline to check which tensor elements influence an output: token t depends only on X[t,:], never on another position. A literal GPU translation gives each output an independent 1024-element loop, rereading the same input for thousands of output channels. It also leaves the matrix work on scalar instructions. First preserve this dependency graph; then change how groups of outputs share operands. A high-precision scalar sum is a mathematical reference, not an exact oracle for the deployed instruction sequence. Bitwise reproduction also requires the same Half MMA groups, activation rounding and {'E4M3' if fp8 else 'Half'} publication.</p>
{mma_primer(fp8)}
<h2 id="tiling">3. Derive the CTA and register tile</h2>
<p>A warp-wide MMA computes 16 query/token rows by eight output columns per instruction, reducing {32 if fp8 else 16} channels. Grow that primitive in M and N: four M16 fragments cover 64 tokens; eight N8 fragments cover 64 output channels. A warp now owns 64×64 outputs. Four warps arranged 2×2 cover a 128×128 CTA. Warp parity selects the column half and floor(warp/2) the token half. A register array <code>Accumulator[4][4][4]</code> holds four spatial fragments, four N16 groups and four Half2 words per group, or 64 32-bit accumulator words per lane.</p>
{ownership()}
<p>Let Mtiles=ceil(T/128). For CTA index b, nBlock=floor(b/Mtiles) and firstGroup=(b modMtiles)·8. Warp w owns groups firstGroup+4·floor(w/2)+m for m=0…3 and output columns 128·nBlock+64·(w mod2) through the next 63. The grid spans 32 output blocks because 4096/128=32. Tail storage is rounded to {'32' if fp8 else '16'} tokens; groups past that extent are explicitly zero-filled and omitted from output stores. {'There is no small-Half broadcast branch in this specialization.' if fp8 else 'For T≤16 the source broadcasts input group zero into its virtual tile positions, while output publication remains group-bounded.'}</p>
{physical_primer(fp8,4096)}
<h2 id="addresses">4. Derive A, B and output addresses</h2>
<p>One reduction step covers K{step}. Eight token groups each need a 1024-byte slab, making one 8192-byte shared stage. Group g’s global slab address is <code>X+g·16384·{elem}+i·1024</code>, where i is the reduction-step index. Producer warp w copies groups firstGroup+w and firstGroup+w+4 to <code>stage·8192+w·1024</code> and that address+4096. Invalid groups receive zero uint4 stores from all lanes.</p>
<p>Here X and W name the adjusted bases used by the body: <code>X=Parameters.g_Input+blockIdx.z·16384·{elem}</code> and <code>W=Parameters.g_PackedWeights+blockIdx.z·(1024·4096)·{elem}</code>. The worked example takes blockIdx.z=0. Preserve these ABI-level offsets when reconstructing a nonzero-Z invocation; they are separate from the block.x token/channel decomposition.</p>
<p>Consumer warp w starts at shared <code>(i mod3)·8192+floor(w/2)·4096+L·16</code>. M16 tile m and K subtile k add <code>m·1024+k·512</code>. These loads need no transpose. W’s lane-vector address is <code>W+nBlock·4096+(w mod2)·2048+L·16+(2i+k)·131072+n16·512</code>. The factor 131072 equals 4096 output columns ×32 bytes per native K panel. The input reduction tile has two native subtiles, each reused across every output tile.</p>
{address_figure(fmt+' expansion: one lane vector traced numerically',[
 'CTA token tile 0, output block 0|warp 2, lane 13, reduction step 3|M16 fragment 1; K subtile 1',
 f'A global source vector: group 5|5×16384×{elem}+3×1024+13×16+512|= {example_a} bytes; shared offset 5840',
 f'B vector: N16 group 2, K subtile 1|(2×3+1)×131072+2×512+13×16|= {7*131072+1024+208} bytes',
 ('Output packs N16 groups 2 and 3|' if fp8 else 'Output N16 group 2|')+f'group 5 vector starts at {example_out} bytes|tokens 83/91 own channel pairs 34/35,42/43'])}
<p>The output address is group·65536·{elem}+nBlock·2048·{elem}+(w mod2)·1024·{elem}+L·16 plus the publication-panel offset. {'A publication panel combines two N16 groups, so its offset is pairIndex·512.' if fp8 else 'An N16 panel’s offset is n16·512.'} For the example, the first two channel pairs named in the diagram belong to N16 group 2; {'the same vector also includes the neighboring group 3 pairs after E4M3 packing.' if fp8 else 'four Half2 words cover the two token rows and both N8 halves.'} This is why replacing the vector store with a naive dense row-major store is incorrect.</p>
{code(path,78,89,'Derive the weight stride from the actual load expression')}
<h2 id="synchronous">5. Construct a synchronous tiled kernel first</h2>
{pseudo(f'''C[4][4][4] = Half zeros
for i in 0 .. {steps-1}:
    copy eight token-group K{step} slabs into one shared slot
    fill invalid groups with zero
    CTA_barrier()                       # all producers finished
    A = shared vectors for this warp's four M16 tiles and two K subtiles
    B = cached global weight vectors for this warp's four N16 tiles
    for m in 0..3:
        for n16 in 0..3:
            for kSubtile in 0..1:        # preserve this reduction order
                C[m,n16].N8low  = MMA(A[m,kSubtile], B[kSubtile,n16].low, C.low)
                C[m,n16].N8high = MMA(A[m,kSubtile], B[kSubtile,n16].high,C.high)
    CTA_barrier()                       # safe to overwrite the slot''','A derivation scaffold: one slot, blocking copies, and unchanged mathematical tile')}
<p>This stage already explains the large improvement in operand reuse relative to the scalar baseline. Each input fragment serves multiple output columns, and each weight fragment serves four M16 token tiles. The C tensor stays in registers through all {steps} steps. Its cost is long-lived accumulator state; increasing tile size further could force spills or reduce resident blocks. The source sets a 168-register maximum, but that declaration is neither a measured allocation nor an occupancy guarantee.</p>
<h2 id="pipeline">6. Replace blocking staging with the real three-slot pipeline</h2>
{pipeline(3,8192,step,3,name)}
{async_explanation(3)}
<p>The actual body primes B₀ and all three A slots. It waits for A₀, consumes one register tile, preloads the next B, waits for the next A stage, then refills the consumed slot with Aᵢ₊₃. Waiting for the next stage includes every thread’s arrival after the preceding consumption, so recycling the old stage occurs after readers have advanced. The last steps stop issuing beyond-the-end copies and drain existing stages. It takes {steps} K steps; the stage ring retains byte capacity while the reduction width follows this precision.</p>
{code(path,92,125,'The actual prefill, consume, next-stage wait and three-ahead refill')}
<h2 id="epilogue">7. Fuse the activation and exact publication</h2>
<p>After the final MMA, every lane runs <code>FfnActivation</code> on its 64 packed Half accumulator words. The helper clamps Half values, takes their absolute values, evaluates two ordered Half FMAs, and performs the final Half multiplication. It keeps x for that final multiplication; the clamped b only controls the gate. Values below the lower clamp therefore follow the recovered zero gate, while values above the upper clamp retain the unbounded x multiplied by the saturated gate. This is not the standard SiLU function.</p>
{precision_figure(fp8,True)}
<p>{'For E4M3 publication, PackHalfPairsE4 converts two Half2 words with round-to-nearest finite saturation, then joins the byte pairs. It joins accumulator words 0 and 2, then 1 and 3, for each N16 group, and includes a neighboring N16 group in the same uint4. This preserves the native channel permutation expected by the next MMA consumer. The Half preactivation and activated values never become separate global allocations.' if fp8 else 'For Half publication, the four accumulator words of an N16 group are assembled directly into a uint4. There is no E4M3 conversion and no wider post-activation buffer. The exact Half activation values are written once into the next kernel’s native input layout.'} <code>StoreNoAllocate</code> writes one aligned 16-byte vector with an L1 no-allocation hint. Only groups below the precision-specific bound are written; the source does not clear the caller’s entire allocation.</p>
{code(path,128,162 if fp8 else 160,'Activation and final precision-specific output packing')}
<h2 id="reconstruct">8. Put every phase together</h2>
{pseudo(f'''derive T, Mtiles, nBlock, firstGroup, paddedGroupCount, lane and warp
Xbase = input + blockIdx.z*16384*{elem}
Wbase = weights + blockIdx.z*(1024*4096)*{elem}
allocate shared[3*8192 + 3*8]; initialize all 3 barriers; CTA_barrier()
load B(0) into registers
for stage in 0..2: issue StageInput(stage, stage) including zero fills
arrive_and_wait(stage 0)
C = Half zeros
for i in 0..{steps-1}:
    read A from stage i%3 using warp/M16/K-subtile/lane addresses
    for m=0..3, n16=0..3, kSubtile=0..1 in that order:
        issue lower-N8 then upper-N8 {fmt} MMA into Half C
    if i+1 < {steps}:
        load B(i+1); arrive_and_wait((i+1)%3)
    if i+3 < {steps}: issue StageInput(i+3, i%3)
for each C Half2 word: apply exact clamped Half polynomial
for each valid M16 group:
    {'pack pairs of N16 groups to E4M3 vectors' if fp8 else 'assemble each N16 group as four Half2 words'}
    store native output vectors with L1::no_allocate''','Complete reconstruction outline; the full owning source below resolves every symbolic helper')}
<h2 id="tests">9. Check the reconstruction at meaningful boundaries</h2>
<ol><li><strong>Address injectivity:</strong> enumerate one valid CTA’s output locations; every published byte should have one owner, including the two rows of each lane fragment. Place canaries immediately outside the declared output extent; they should remain unchanged.</li><li><strong>Single contributing input channel:</strong> pack a one-hot X row and a single nonzero weight row using the scalar packer. Only the chosen token should change, and output values should equal the activation of the intended W row after the documented precision operations.</li><li><strong>Pipeline wrap:</strong> compare the synchronous tiled scaffold with the staged version over all {steps} steps. This exercises each slot repeatedly; poison unused shared storage in a diagnostic build so a missing zero fill or wait cannot silently look correct.</li><li><strong>Numerical checkpoints:</strong> compare preactivation Half fragments, activated Half fragments, then {'the final E4M3 bytes' if fp8 else 'the final Half words'} separately. Test values around ±4 and conversion ties; replacing the activation by FP32 should not be accepted as a bit-exact oracle.</li><li><strong>Token tails:</strong> test legal extents around 16,32 and 128. Valid rows must match the reference; no out-of-range group may be read. {'FP8 alignment creates complete pairs of M16 groups.' if fp8 else 'Include the T≤16 broadcast path separately from ordinary multi-group inputs.'}</li></ol>
<p>The optimization sequence is explicit: independent scalar dots repeatedly load operands; tiling shares those operands; a register C tile removes intermediate result traffic; asynchronous input stages may hide load latency; fused activation removes a global preactivation pass. Larger live register state, three shared slots and barrier instructions are the corresponding costs. Establish speed with compiled resource reports and measurements of this actual kernel and geometry, not with timings from another matrix multiply.</p>
""")


def contract_lesson(name, fp8, projection):
    fmt='FP8' if fp8 else 'FP16'
    elem=1 if fp8 else 2
    kind='projection' if projection else 'contract'
    K=1024 if projection else 4096
    splitK=K//4
    step=64 if fp8 and not projection else 32
    subt=step//(32 if fp8 else 16)
    stages=2 if fp8 or projection else 3
    groupbytes=step*16*elem
    stagebytes=8*groupbytes
    copybytes=512 if projection else groupbytes
    producers=groupbytes//copybytes
    steps=splitK//step
    initial=3 if stages==3 else 1
    path=P+('bottleneck_c1024_attention_ffn_projection/fp8/global_contract_fp8.cu' if fp8 else f'bottleneck_c1024_attention_ffn_projection/fp16/{name}.cu')
    A,R,C=('A','Z','Y') if projection else ('U','X','Z')
    scale='attn_scale' if projection else 'ffn_scale'
    aval=(5*K+splitK+2*step)*16*elem+208+(subt-1)*512
    bval=(splitK+2*step)*1024*elem+208+(subt-1)*32768+1024
    smem=(2%stages)*stagebytes+4*groupbytes+208+groupbytes+(subt-1)*512
    prefetch=('''for i=0..steps-1:
    consume A(i), B(i) into C
    if i+1 < steps: load B(i+1); wait stage(i+1)
    if i+3 < steps: stage A(i+3) in the retired slot'''
              if stages==3 else '''for i=0..steps-2:
    on SM<90: stage A(i+1) before computing current tile
    consume A(i), B(i) into C
    on SM>=90: stage A(i+1) after computing current tile
    load B(i+1); wait stage(i+1)
consume the last ready A(steps-1), B(steps-1) tile''')
    interim=('exclusive .cg load → HalfAdd → no-allocate store on SM<90; vector Half reduction on SM90+'
             if fp8 else 'Half2 global reductions: four scalar operations before SM90, one vector operation on SM90+')
    return dict(name=name,title=f'{name}: build the {K}→1024 {kind}',family='Global bottleneck',
      summary=f'Construct the exact {fmt} matrix/residual kernel, including four ordered K splits, packed operands, stage reuse and publication rounding.',
      body=f"""
<h2 id="model">1. Define the model piece before choosing a GPU tile</h2>
<p><code>{name}</code> belongs to the C1024 bottleneck, records 31–38. {'It projects the 32 attention heads, concatenated into A[T,1024], through Wₒ[1024,1024] and adds the separately scaled FFN residual Z.' if projection else 'It contracts the activated dense-FFN intermediate U[T,4096] through W₂[4096,1024] and adds the separately scaled original block input X.'} With row-vector notation the equation is <code>{C}[t,n]=Publish(Σₖ {A}[t,k]W[k,n]+{scale}[n]·{R}[t,n])</code>. The result is logically [T,1024]. The scale has 1024 channel values and broadcasts over tokens. There is no activation or matrix bias in this entry.</p>
<p>The architecture’s 4K example has H=36,W=60,T=2160. This body uses <code>T=BatchCount·TokensPerBatch</code>; the prepared plan runs batch one. Inputs, matrix operands and final output use {fmt}. Residual scales, accumulators and intermediate split sums use Half. {'The entry instantiates global_contract_fp8 with bAttentionProjection=true.' if fp8 and projection else 'The entry instantiates global_contract_fp8 with bAttentionProjection=false.' if fp8 else 'This public FP16 entry owns its complete kernel body.'} The <a href="{ARCH}">architecture document</a> locates this operation in the block, while this lesson derives its implementation locally.</p>
{graph(kind,fp8)}
<h2 id="baseline">2. Write a scalar baseline and identify the repeated work</h2>
{scalar_matmul(kind,fp8)}
<p>This baseline says one output reads all {K} channels at one token plus one residual value. There is no communication between token t and token t+1. Assigning one thread to each output would reread each input row for many output columns, and reread the same W columns for every token. Separate residual and publication kernels would add further global reads/writes. Those costs suggest grouping outputs, reusing operand panels and fusing the residual. The scalar equation is a dependency reference; exact deployment equivalence additionally requires the recovered split order and Half rounding described below.</p>
{mma_primer(fp8)}
<h2 id="tile">3. Grow a warp primitive into the source CTA</h2>
<p>Four M16 fragments and eight N8 fragments give one warp a 64×64 output. Represent it as four M16 groups × four N16 groups × four Half2 accumulator words per lane. Arrange four warps as two token halves and two channel halves to cover M128×N128. This keeps each output fragment in registers while reusing one A fragment across multiple N panels and one B fragment across four M panels. A CTA contains 128 threads, with lane=threadIdx.x and warp=threadIdx.y.</p>
{ownership()}
<p>Let Mtiles=ceil(T/128). For block.x=b, channelBlock=floor(b/Mtiles), firstGroup=(b modMtiles)·8 and outputChannel=128·channelBlock+64·(warp mod2). The warp consumes groups firstGroup+4·floor(warp/2)+m, m=0…3. Split selection is <code>OrderedSplit ? OrderedSplit−1 : blockIdx.z</code>. Unlike an ordinary complete GEMM, this CTA computes only {splitK} of the {K} input channels. Four such partial computations contribute to the same output addresses.</p>
{physical_primer(fp8,1024)}
<h2 id="split-design">4. Introduce four K splits without losing the residual or rounding order</h2>
<p>Partition K into ranges [0,{splitK}),[{splitK},{2*splitK}),[{2*splitK},{3*splitK}),[{3*splitK},{4*splitK}). Split s computes its own Half MMA result Cₛ. Only s=0 starts its accumulator from <code>HalfMul(scale,residual)</code>; later splits start from zero. Adding the residual in all four splits would multiply that path by four. Adding it after all dots instead would change the existing Half accumulation sequence.</p>
{split_figure(4,splitK,fp8)}
<p>After independent computation, publish in order: P₀=C₀; P₁=HalfAdd(P₀,C₁); P₂=HalfAdd(P₁,C₂); final=HalfAdd(P₂,C₃). {'P is a separate global Half tensor; only final is converted to E4M3 and stored in the FP8 output. Three intermediate E4M3 publications would be numerically wrong.' if fp8 else 'The output allocation itself holds P, and becomes the final tensor after split 3 writes its final Half result.'} This is not an arbitrary-order atomic sum and not one FP32 reduction. The structure reproduces the recorded publication boundaries.</p>
<h2 id="addresses">5. Derive input, weight, residual and partial addresses</h2>
<p>Within one split, the reduction advances by K{step}, giving {steps} steps. One 16-token group’s slab contains <code>{step}·16·{elem}={groupbytes}</code> bytes. Its global base is <code>{A}+(g·{K}+s·{splitK}+i·{step})·16·{elem}</code>. The eight groups together occupy {stagebytes} bytes per shared stage. This specialization copies {copybytes} bytes per producer operation, so {producers} producer warp positions cooperate per group. In the source’s unified copy loop, <code>copySlot=warp+4·Copy</code>, group=firstGroup+floor(copySlot/{producers}), and destination=stage·{stagebytes}+copySlot·{copybytes}. {'Projection’s 512-byte copies separate the native K panels across producer positions.' if projection else 'Contraction coalesces the two K fragments in each 1024-byte group slab.'}</p>
<p>The consumer A vector is at shared <code>(i mod{stages})·{stagebytes}+floor(warp/2)·4·{groupbytes}+lane·16+m·{groupbytes}+kSubtile·512</code>. W’s register vector starts at <code>W+(s·{splitK}+i·{step})·1024·{elem}+outputChannel·32+lane·16+kSubtile·32768+n16·512</code>. There are {subt} native K subtiles per step. The fixed 32768 stride is 1024 output columns ×32 bytes per native K panel; it is independent of the scalar element width.</p>
{address_figure(fmt+' '+kind+': one input, weight and result vector',[
 'Token tile 0; channelBlock 0; split 1|warp 2, lane 13; step 2, M16 group 1|global token group 5; N16 group 2',
 f'A vector global byte offset = {aval}|shared vector byte offset = {smem}|K subtile={subt-1}; E={elem} byte(s)',
 f'B vector byte offset = {bval}|Half partial: 5×1024×32+13×16+2×512|=165072 bytes, independent of output format',
 'C fragment: tokens 83 and 91|output channels 34/35 and 42/43|residual scale pair begins at matrixBytes+68'])}
<p>For a Half partial, the address is <code>partial+(g·1024+outputChannel)·32+lane·16+n16·512</code>. The factor 32 is 16 tokens ×2 bytes. A residual vector instead uses the working element width: <code>{R}+(g·1024+outputChannel)·16·{elem}+lane·16+publicationPanel·512</code>. Scale pairs are always Half, appended at <code>W+{K}·1024·{elem}</code>; within that tail, the byte offset is <code>2·(outputChannel+16·n16+8·n8+2·(lane mod4))</code>. The example’s n16=2,n8=0,lane 13 therefore selects scale channels 34/35, beginning 68 bytes beyond the matrix.</p>
{code(path,94 if fp8 else 96 if projection else 90,107 if fp8 else 109 if projection else 103,'The register weight address in this precise entry')}
<p>{'The FP8 residual load decodes E4M3 byte pairs to Half before multiplying by those Half scale pairs. Two adjacent N16 groups share each published uint4, so the epilogue unpacks its low and high halves into the four accumulator words explicitly.' if fp8 else 'The FP16 residual load already contains four Half2 accumulator words and can multiply them directly by the two scale pairs for each N16 group.'} Out-of-range groups supply zeros. {'There is no Half-only small-input broadcast condition in this specialization.' if fp8 else 'For T≤16, the input and residual read group is broadcast to zero; the output remains bounded by the logical group extent.'}</p>
<h2 id="synchronous">6. Build a one-slot synchronous split kernel</h2>
{pseudo(f'''s = selected K split
C = Half zeros
if s == 0:
    load residual in {fmt}; {'decode E4M3 to Half; ' if fp8 else ''}load Half scale pairs
    C = HalfMul(residual, scale)
for i in 0..{steps-1}:
    copy eight K{step} input slabs into a single shared slot
    zero invalid groups; CTA_barrier()
    read four M16 A fragments and {subt} K subtiles per fragment
    load B panels with .ca into registers
    for m=0..3, n16=0..3, kSubtile=0..{subt-1}:
        update lower-N8 then upper-N8 Half accumulators with MMA
    CTA_barrier()    # permit the next write to the same shared bytes
wait for predecessor publication if required
publish C according to split index''','A synchronous construction isolates layout and split correctness before pipelining')}
<p>At this point the arithmetic, addresses, residual and partial-tensor lifetime are complete. The remaining bottleneck in the scaffold is exposed copy latency between repeated matrix tiles. The source adds {stages} shared stages, totaling {stages*stagebytes} data bytes plus {stages*8} barrier bytes. {'This FP16 contraction retains a three-slot pipeline with three initial fills.' if stages==3 else 'This two-slot specialization begins with one ready stage and peels its final MMA out of the loop.'} B remains in registers rather than occupying another shared ring.</p>
<h2 id="pipeline">7. Replace the scaffold with the actual stage schedule</h2>
{pipeline(stages,stagebytes,step,initial,name)}
{async_explanation(stages)}
{pseudo('prime B(0)'+chr(10)+f'prime A stages 0..{initial-1}; wait stage 0'+chr(10)+prefetch,'The exact high-level prefetch order for this specialization')}
<p>{'The three-slot body consumes the current tile, loads B(i+1), waits for A(i+1), then refills the retired slot with A(i+3). The last iterations stop refilling and drain the already staged tiles. The next-stage arrival provides the point at which all threads have advanced beyond the preceding shared reads.' if stages==3 else 'Below SM90 the body issues A(i+1) before consuming the current tile. The prior stage wait has already carried all threads past the old slot’s consumption, so this early prefetch can overlap current MMA work. On SM90+ it preserves the recovered placement after consumption. In both branches B(i) remains in registers until its MMA finishes; only then does LoadWeights replace it with B(i+1). The loop stops at steps−2, and the last ready tile is consumed once outside it.'} Reordering waits and refills based only on modulo arithmetic can overwrite a stage before every reader has finished.</p>
{code(path,178 if fp8 else 164 if projection else 158,203 if fp8 else 195 if projection else 175,'Precision-specific pipeline and final drain')}
<h2 id="publication">8. Publish partials and the final tensor</h2>
<p>Split 0 stores its Half partial with no L1 allocation. Splits 1/2 use {interim}. Split 3 loads the accumulated predecessor partial, performs four Half2 adds per N16 tile, then writes {'E4M3 output bytes by pairing two N16 groups' if fp8 else 'the final Half words directly back to the output allocation'}. {'The portable FP8 scratch load uses .cg to avoid retrieving a prior phase’s stale L1 copy; on SM90+ the helper retains its cache-all load.' if fp8 else 'The Half implementation uses its global-reduction helper for intermediate phases and a cache-all load before the final Half add.'} These choices affect instruction and cache behavior, but do not change the required ownership: one lane in the current split owns each published vector.</p>
{code(path,216 if fp8 else 202 if projection else 192,248 if fp8 else 239 if projection else 229,'The first-store, intermediate-add and final-add publication cases')}
{split_ordering(fp8,4,'contract')}
<p>For this entry the four-byte counter address is <code>g_SplitCounters+(firstGroup+channelBlock)·4</code>. There are eight 128-channel output blocks; firstGroup=8·tokenTile, so this indexes one counter per token tile/output-channel block. Later resident splits wait until the signed counter is at least s−1. After all lane stores and the CTA synchronization, lane 0/warp 0 releases the current split number s.</p>
<h2 id="reconstruction">9. Complete reconstruction pseudocode</h2>
{pseudo(f'''derive T, token tile, channel block, lane/warp, paddedGroups and split s
allocate {stages} shared slots of {stagebytes} bytes plus {stages} barriers
initialize barriers for 128 arrivals; CTA_barrier()
load B(0); prime {initial} A stage(s); wait stage 0
C = Half zeros
if s==0: load {R}, {'decode E4M3, ' if fp8 else ''}load appended Half scales, seed C=HalfMul(R,scale)
steps = {steps}
{prefetch}
partialBase = {'separate Half SplitAccumulator' if fp8 else 'output allocation (Half)'}
if resident mode and s>0:
    lane 0/warp 0 polls counter until predecessor split is published
    {'on SM<90: acquire publication fence; ' if fp8 else ''}CTA_barrier()
for valid groups and every N16 lane vector:
    if s==0: store C to Half partial
    if s==1 or s==2: ordered Half-add C into partial
    if s==3:
        C = HalfAdd(load partial, C)
        {'pack neighboring N16 groups to E4M3 and store output' if fp8 else 'store final Half output'}
CTA_barrier()
lane 0/warp 0 release-stores counter=s
# Ordered mode runs s=0,1,2,3 as complete XY launches in one stream.''','All phases, including residual seeding and the global publication dependency')}
<h2 id="validation">10. Test the properties that define this kernel</h2>
<ol><li><strong>Residual once:</strong> set W to zero. Valid output rows should equal the documented publication of HalfMul(scale,residual), with no factor of four and no contribution from other tokens.</li><li><strong>Each split contributes:</strong> place one nonzero input/weight pair in each K region and compare saved P₀,P₁,P₂ and final. They must follow the specified Half addition order. Values chosen near Half rounding boundaries distinguish this from a reassociated or FP32 sum.</li><li><strong>Scratch format:</strong> {'inspect the first three partials as Half, not E4M3, and verify no final FP8 vector is considered ready before split 3.' if fp8 else 'verify the output buffer holds valid Half partials before it becomes the final tensor; consumers must not read it early.'}</li><li><strong>Address ownership:</strong> use the worked token 83/channel 34 example and nearby lane/channel groups. Every output vector must be written once per publication phase, and guard bytes must remain unchanged.</li><li><strong>Schedule equivalence:</strong> run both admitted resident mode and forced ordered split mode on supported hardware; final bytes should agree. Include more XY blocks than fit in one wave to exercise the host’s capacity fallback.</li><li><strong>Tail and ring behavior:</strong> use legal token extents around group and CTA boundaries; exercise all {steps} K steps so the {stages} slots wrap repeatedly. Invalid groups must be zero during computation and omitted from output publication.</li></ol>
<p>The optimization argument follows the construction: grouped MMA shares A across columns and B across tokens; the residual seed removes a separate pass; the staged A ring can overlap transfer with work; register B avoids a shared weight copy; split-specific epilogues avoid converting partials too early. Splitting also creates global scratch traffic and synchronization, and extra stages consume shared capacity. Those tradeoffs need measurements for this precision and geometry; this lesson reports no invented speedup.</p>
""")


def norm_figure(fp8):
    return figure('One 32-channel head norm stays inside its token',300,
        box(20,30,235,100,'Projected Q or K Half values|two N16 accumulator panels|four lanes share one row')+arrow(255,80,295,80)+
        box(295,30,235,100,'square each Half pair|combine lower/upper panels|preserve recorded add tree','compute')+arrow(530,80,570,80)+
        box(570,30,220,100,'shuffle XOR2, XOR1|add swapped Half lanes|max(squared sum, ε)','compute')+arrow(790,80,825,80)+
        box(825,30,215,100,'rsqrt → Half inverse|multiply 32 channels|Q also ×√32 ×scale','compute')+
        text(25,185,'Lane 13 belongs to lanes 12–15: they exchange channel pieces of token row 3 and row 11, never another token.')+
        text(25,218,'ε=0x0410=6.198883056640625e−5 applies to the squared sum. It is not the training normalization floor.')+
        text(25,252,('FP8 specialization computes one scalar inverse of a replicated Half pair, then duplicates it.' if fp8 else 'FP16 specialization calls RsqrtHalf2 for the two packed components.')),
        'Both precision entries normalize in Half after combining their two K512 split results. V bypasses normalization.')


def qkv_layout_figure(fp8):
    return figure('Publish three equal logical tensors in three consumer layouts',345,
        box(20,30,320,95,'Q: MMA A for QKᵀ|natural accumulator word order|'+('M16/head:512 bytes' if fp8 else 'M16/head:1024 bytes'),'tensor')+
        box(365,30,320,95,'K: MMA B for QKᵀ|swap vector words 1 and 2|'+('M16/head:512 bytes' if fp8 else 'two N16 panels of 512 bytes'),'tensor')+
        box(710,30,330,95,'V: MMA B for E×V|movmatrix m8n8 transpose|'+('join two M16 into one M32' if fp8 else 'retain M16 with two N16 panels'),'tensor')+
        arrow(175,125,175,180)+arrow(525,125,525,180)+arrow(875,125,875,180)+
        box(20,180,1020,92,('FP8 Q/K offset = g×16384 +head×512 +lane×16|FP8 V offset = floor(g/2)×32768 +head×1024 +(g mod2)×512 +lane×16' if fp8 else 'FP16 Q/K/V group base = g×32768 +head×1024 +lane×16|N16 panel 1 adds512 bytes; K uses [word 0,word 2,word 1,word 3] inside each vector'),'storage')+
        text(25,318,'The output is ready for its consumer’s operand role; no standalone global transpose or normalization pass follows.'),
        'Equal logical shapes do not imply equal byte layouts. The Q/K/V publication code is part of the next kernel’s operand contract.')


def qkv_lesson(name, fp8):
    fmt='FP8' if fp8 else 'FP16'; E=1 if fp8 else 2
    path=P+f'bottleneck_c1024_attention/{fmt.lower()}/{name}.cu'
    subt=1 if fp8 else 2; groupbytes=512*E; stagebytes=4096*E
    a=(5*1024+512+2*32)*16*E+208+(subt-1)*512
    b=128+(512+2*32)*3072*E+672*32+208+(subt-1)*98304+512
    body=f"""
<h2 id="model">1. Define the projection that creates global-attention operands</h2>
<p><code>{name}</code> follows the dense FFN residual in C1024 bottleneck records 31–38. Its input Z is logically [T,1024]. A [1024,3072] matrix produces 32 heads, each containing adjacent Q32,K32,V32 columns. For each token t and head h, <code>Qraw[t,h,:],Kraw[t,h,:],V[t,h,:] = Z[t,:]·W[:,h·96:h·96+96]</code>. Q and K are independently normalized over 32 channels; Q also receives √32 and a learned head scale. V is not normalized. Outputs Q,K,V each have logical shape [T,32,32].</p>
<p>At 4K the bottleneck has 36×60 tokens, T=2160. The kernel uses <code>BatchCount·TokensPerBatch</code> as one physical token extent; the prepared plan uses batch one. This entry’s matrix operands and final publications use {fmt}; intermediate matrix sums and norm arithmetic are Half. The packed weight record starts with 32 FP32 head scales (128 bytes), followed by the Q/K/V matrix. There is no relative-position bias or attention score calculation in this entry. Its job ends when consumer-ready Q/K/V are published. The surrounding model is described by the <a href="{ARCH}">architecture document</a>.</p>
{graph('qkv',fp8)}
<h2 id="baseline">2. Establish scalar projection and normalization first</h2>
{pseudo('''for t in real_tokens:
    for head h in 0..31:
        for component p in {Q,K,V}:
            for channel c in 0..31:
                raw[p,c] = sum_k decode(Z[t,k]) * decode(W[k,96*h+32*p+c])
        Q = raw[Q] / sqrt(max(sum_c raw[Q,c]^2, epsilon))
        K = raw[K] / sqrt(max(sum_c raw[K,c]^2, epsilon))
        Q = Q * sqrt(32) * learned_head_scale[h]
        publish Q, K and raw[V] into their respective consumer layouts''','Scalar dependency baseline; recover Half split/reduction order before requiring exact bytes')}
<p>This makes two independent reductions visible. Projection reduces 1024 input channels separately for each output value. Normalization then reduces the 32 projected channels of one token/head, separately for Q and K. A norm computed on either half of the projection would be wrong: normalization is nonlinear, so the two split projections must be combined first. A straightforward multi-kernel implementation would materialize raw QKV, launch norm kernels, then transpose V. The source fuses these epilogues into the final projection split.</p>
{mma_primer(fp8)}
<h2 id="ownership">3. Choose a CTA that keeps two heads complete</h2>
<p>The CTA covers 128 tokens and 192 output columns, which is exactly two heads ×three components ×32 channels. Warp 0/2 owns the first head; warp 1/3 the second. Warp 0/1 covers the lower 64 tokens; warp 2/3 the upper 64. Each warp therefore owns four M16 fragments and six N16 channel groups, represented by <code>Accumulator[4][6][4]</code>. That is 96 packed accumulator words per lane. Keeping a complete head’s Q/K/V in one warp allows its normalization and transpose to finish without cross-warp exchange.</p>
{ownership(192)}
<p>Let Mtiles=ceil(T/128). Decode <code>headPair=block.x//Mtiles</code>, <code>firstGroup=(block.x modMtiles)·8</code>, and <code>head=2·headPair+(warp mod2)</code>. This warp’s matrix column base is <code>headPair·192+(warp mod2)·96</code>. N16 groups 0/1 are Q,2/3 are K,4/5 are V. Four M16 groups represent its 64 tokens. The block.x grid covers 16 head pairs; each result element belongs to one head/token owner.</p>
{physical_primer(fp8,3072)}
<h2 id="split">4. Split the input channels, keeping the full-head epilogue last</h2>
<p>Two K512 slices cover the input width. Split 0 starts at channel 0 and split 1 at 512. Each slice takes 16 K32 steps. This entry uses {subt} native MMA K subtiles per step: {'one K32 E4M3 operation' if fp8 else 'two K16 Half operations'}. The first split stores ordinary Half Q/K/V fragments; the second loads and Half-adds them before applying either norm or transpose. {'FP8 reserves a separate Half scratch tensor because an E4M3 output allocation cannot hold the required intermediate values.' if fp8 else 'The FP16 Q/K/V output allocations temporarily hold their own Half partials, then the final split overwrites them in consumer layout.'}</p>
{split_figure(2,512,fp8,True)}
<p>The final mathematical sum is associated as <code>HalfAdd(first 512,last 512)</code>, where each side is a sequence of Half-accumulating MMA operations. Replacing that with one 1024-wide FP32 GEMM followed by a cast is not the same numerical program. Split 0 returns from each component’s publication routine before normalization. Split 1 runs Q then K then V publication in the recovered order.</p>
<h2 id="addressing">5. Derive the input, matrix and partial-tensor addresses</h2>
<p>A group contains 16 tokens. At split s and step i, A’s slab begins at <code>Z+(g·1024+s·512+i·32)·16·{E}</code>. Its {groupbytes}-byte group slab feeds {subt} native panels. The shared stage contains eight groups, or {stagebytes} bytes. Producer copies are 512 bytes: copySlot=warp+4·Copy; group=firstGroup+floor(copySlot/{E}); subpanel=copySlot mod{E}. Destination is stage·{stagebytes}+copySlot·512. Invalid groups receive zero vectors in exactly those shared locations.</p>
<p>For the warp’s register A vectors use <code>(i mod2)·{stagebytes}+floor(warp/2)·4·{groupbytes}+lane·16+m·{groupbytes}+kSubtile·512</code>. Its B vector is <code>W+128+(s·512+i·32)·3072·{E}+outputChannel·32+lane·16+kSubtile·98304+n16·512</code>. The 128 skips head scales. The 98304 stride is 3072 columns ×32 bytes per native K panel. There are six N16 panels to load, rather than a normal projection’s four.</p>
{address_figure(fmt+' QKV: head 7, token 83 and one N16 panel',[
 'headPair 3, warp 3, lane 13|token tile 0, m1 → group 5|split 1, step 2, Q panel 1',
 f'A byte offset={a}|B byte offset={b}|B includes 128-byte head-scale header',
 'Q Half partial offset:|5×32768+7×1024+1×512+13×16|=171728 bytes from Q partial base',
 ('Final Q group vector:85712 bytes|V group vector:73424 bytes|' if fp8 else 'Final Q panel 1 vector:171728 bytes|same group stride; K changes word order|')+'logical output includes tokens 83/91'])}
<p>For component p, {'its Half scratch base is SplitAccumulator+p·paddedGroups·32768.' if fp8 else 'its Half partial base is the corresponding Q,K or V allocation.'} Group g/head h/N16 n/lane L writes at <code>base+g·32768+h·1024+n·512+L·16</code>. The second split reads this same map before changing it. That ordering is especially important for V: its first split uses ordinary accumulator order, not the final transposed order. The example’s Q output includes token 83 because group 5 starts at 80 and lane 13’s first row is 3.</p>
{code(path,87,101,'The source-specific interleaved QKV weight panel')}
<h2 id="pipeline">6. Build a synchronous tile, then add two asynchronous slots</h2>
{pseudo(f'''C[4][6][4] = Half zeros
for i=0..15:
    stage the eight K32 input groups, or fill invalid groups with zero
    CTA_barrier()
    load this warp's four M16 A panels and six N16 B panels
    for m=0..3, n16=0..5, kSubtile=0..{subt-1}:
        issue lower-N8 then upper-N8 MMA into Half C
    CTA_barrier()       # permit the next shared overwrite
# replace these blocking stage/barrier steps by the ring below''','Synchronous construction: same fragments and arithmetic before introducing overlap')}
{pipeline(2,stagebytes,32,1,name)}
{async_explanation(2)}
<p>The actual entry initializes two barriers, primes B₀ and A₀, and waits for stage 0. For i=0…14 it consumes the current A/B fragments, stages Aᵢ₊₁ into the other slot, loads Bᵢ₊₁ and waits for that stage. Then it explicitly consumes tile 15. The wait includes all 128 threads, so when a slot is reused two iterations later its previous readers have advanced. Unlike some contraction variants, this QKV body does not move the prefetch before current consumption on SM89; reproduce this source’s sequence. The register cap is {168 if fp8 else 255}; actual resource usage must be inspected after compilation.</p>
{code(path,104,120,'Prime one stage, alternate two slots, then drain the final tile')}
<h2 id="normalization">7. Reduce exactly 32 channels after combining the two partials</h2>
<p>For Q or K, select the component’s lower and upper N16 groups. For each packed word, square both groups with Half multiplication and add them. Combine words 2+0 for one token row and 3+1 for the other. Then <code>SumHeadChannels</code> performs Half-add butterflies with lane XOR2 and XOR1 and adds the word with its Half components swapped. This is a reduction across four lanes’ channel pieces of the same row, followed by the two scalar components. It does not exchange tokens or heads.</p>
{norm_figure(fp8)}
<p>The squared sum is floored at 0x0410 (6.198883056640625×10⁻⁵) before approximate reciprocal square root. {'The FP8 specialization exploits the replicated low/high sum: one Half-to-FP32 conversion and approximate rsqrt, rounded back to Half, provides both normalization components.' if fp8 else 'The FP16 specialization calls RsqrtHalf2, which converts each packed component to FP32 for the approximate reciprocal square root and rounds back to Half.'} Each projected channel is Half-multiplied by its row’s inverse norm. Q is then Half-multiplied by the approximate √32 rounded to Half and the header’s FP32 head scale converted to Half, in that order. The floor and ordering differ from the simplified floating training formula.</p>
{code(P+'bottleneck_c1024_attention/common/global_qkv.cuh',18,39,'Channel reduction and the inverse-norm specialization')}
{code(P+'bottleneck_c1024_attention/common/global_qkv.cuh',54,80,'Apply the inverse and Q-only scale to the correct accumulator words')}
<h2 id="layout">8. Construct the three final layouts rather than adding transpose kernels</h2>
{qkv_layout_figure(fp8)}
<p>Q will be A in a QKᵀ product. Its final lane words therefore preserve the publication’s A-fragment order. K supplies that product’s B fragment, so its middle vector words are exchanged. V supplies B for the later E×V product; the source applies <code>movmatrix.sync.trans.aligned.m8n8.b16</code> to every V Half word while its values are still in registers. These choices are part of the output contract, not optional reshapes.</p>
<p>{'After V transposition, FP8 combines neighboring M16 token tiles into one M32 storage group. Its store address is floor(g/2)·32768+head·1024+(g mod2)·512+lane·16. Each output vector combines even/odd token-group words from the correct N16 panel and converts them with PackHalfPairsE4. Q/K instead use g·16384+head·512+lane·16, joining the lower/upper N16 channel panels. Consequently Q/K and V have different group strides despite the same logical dimensions.' if fp8 else 'FP16 keeps M16 groups. Each group occupies 32768 bytes across 32 heads; one head is 1024 bytes. Within that head, each lane has two uint4 vectors separated by 512 bytes, one per N16 panel. K publishes its first panel for all M16 tiles before the second and swaps word 1/2; Q and already-transposed V store their two panels in ordinary order.'} Only valid padded groups are published. The split partials are global, but there is no additional complete raw-QKV allocation followed by standalone normalization and transpose passes.</p>
{code(path,175 if fp8 else 176,216 if fp8 else 228,'Fuse normalization, register transpose and the exact precision-specific stores')}
{split_ordering(fp8,2,'qkv')}
<p>The counter address is <code>counter+((firstGroup/8)·16+headPair)·4</code>. Split 1’s resident wait requires split 0’s published value 0, then the final split releases 1. A consumer attention kernel has its own predecessor-ready condition; the prepared plan’s launch ordering must supply the full projection-before-attention dependency. A nonnegative counter alone is not a universal statement that every QKV split has completed.</p>
<h2 id="reconstruct">9. Complete reconstruction pseudocode</h2>
{pseudo(f'''decode token tile, head pair, warp head, paddedGroups, lane and split s
initialize two shared barriers; CTA_barrier()
load B(0); stage A(0); wait stage 0; C[4][6][4]=Half zeros
for i=0..14:
    consume current A/B with four M16 ×six N16 ×{subt} K subtile loops
    stage A(i+1); load B(i+1); wait stage(i+1)
consume tile 15 once
if resident mode and s==1: poll split 0 counter; CTA_barrier()
for component in Q, K, V:
    if s==0:
        store valid groups as ordinary Half fragments to component partial tensor
        continue to next component
    load valid previous partials (zero for invalid groups); HalfAdd into C
    if component is Q or K:
        for every M16 group and each token row:
            Half squares/add tree → XOR2 → XOR1 → swapped-pair add
            max with epsilon; approximate rsqrt rounded to Half
            Half-multiply channel pairs by inverse norm
            if Q: Half-multiply by sqrt32, then learned Half-converted scale
    else: transpose every V word with movmatrix m8n8.b16
    {'pack Q/K N16 neighbors, or V neighboring M16 groups, to E4M3' if fp8 else 'retain Half panels; swap K middle words'}
    store valid groups in this component's final physical layout
CTA_barrier(); lane 0/warp 0 release-stores counter=s''','Complete algorithm: normalization and layout conversion occur only in the final split')}
<h2 id="checks">10. Validate the projection, norm and consumer layout independently</h2>
<ol><li><strong>Projection before norm:</strong> use weights with nonzero rows in both K512 halves and compare the raw Half sum after split 1. Normalizing each half independently must fail this test.</li><li><strong>Head isolation:</strong> make only head 7’s matrix nonzero. Only head 7 Q/K/V should change. Set two different learned scales; Q changes, while K/V remain unchanged.</li><li><strong>Norm domain:</strong> use a single nonzero channel, an all-zero head, and values near the epsilon floor. The inverse is based on the 32-channel squared sum and remains finite for zero input; zero projected vectors remain zero.</li><li><strong>Transpose identity:</strong> populate V with distinct token/channel tags in representable values. Decode the final {'M32' if fp8 else 'M16'} V layout using the consumer’s load map; each tag must return to the intended token/channel, with no accidental Q/K permutation applied.</li><li><strong>Precision boundary:</strong> compare Half partials, Half-normalized Q/K and final {'E4M3 bytes' if fp8 else 'Half words'} separately. Check Q’s two scale multiplications in order.</li><li><strong>Tail/scheduling:</strong> exercise legal group tails, two ring wraps, and resident versus ordered launch modes. Keep canaries beyond Q/K/V and Half scratch. {'FP8 group pairing must not read an unallocated odd partner.' if fp8 else 'The tiny T≤16 broadcast behavior needs a separate fixture.'}</li></ol>
<p>The construction replaces three scalar projections with one interleaved matrix tile, reuses Z across Q/K/V columns, and fuses final norm and V transpose. Half scratch and split counters are its costs; a larger 96-word per-lane accumulator also increases register pressure. None of those source mechanisms alone establishes a speedup. Test the compiled entry and its exact device/shape/precision when evaluating changes.</p>
"""
    return dict(name=name,title=f'{name}: derive Q, K and V from one packed projection',summary=f'A complete {fmt} lesson from scalar QKV through two K512 slices, head normalization, register V transposition and consumer-ready publication.',family='Global bottleneck',body=body)


def attention_model_figure(fp8):
    fmt='E4M3' if fp8 else 'Half'
    return figure('The model equation before deciding where to store it',305,
        box(20,25,235,90,'Q[h,T,32], K[h,P,32]|already normalized upstream|V[h,P,32] unnormalized')+arrow(255,70,295,70)+
        box(295,25,260,90,'S[q,k]=dot(Q[q],K[k])|E=clamped Half bit surrogate|all global keys participate','compute')+arrow(555,70,600,70)+
        box(600,25,440,90,f'N[q,:]=Σ Publish_{fmt}(E[q,k])×V[k,:]|D[q]=Σ E[q,k]−(P−T)E(0)|output=Publish(N/max(D,ε))','compute')+
        box(20,175,1020,82,'Records 31–38: 32 heads ×32 channels. At 4K: T=2160, traversal P=2176.|This kernel computes attention only. Q/K normalization is already done; output projection and residual occur later.','tensor'),
        'The full [T,P] score matrix is a useful mathematical object. The implementation below never allocates it globally.')


def attention_memory_figure(fp8):
    E=1 if fp8 else 2
    return figure('Derive the CTA tile and keep only the tensors with reuse',390,
        box(20,25,260,100,'CTA: head=block.x|query block=block.y, 256 rows|four warps,64 queries each','compute')+arrow(280,75,325,75)+
        box(325,25,300,100,'Load Q once into registers|four M16 query tiles per warp|'+('one K32 chunk;16 words/lane' if fp8 else 'two K16 chunks;32 words/lane'),'storage')+arrow(625,75,665,75)+
        box(665,25,375,100,'QKᵀ → four [16,64] score tiles|64 Half2 score words per lane|E tile dies after denominator and PV','compute')+
        box(20,185,260,110,'Global K/V:64 keys per tile|32 channels per key|.cg copy / SM90+ bulk|same tile serves 256 queries','storage')+arrow(280,240,325,240)+
        box(325,170,300,140,f'Shared K0:0…{2048*E-1}|K1:{2048*E}…{4096*E-1}|V0/V1:{4096*E}…{8192*E-1}|two barriers:16 bytes','storage')+arrow(625,240,665,240)+
        box(665,185,375,110,'K/V register fragments → MMA|persistent N:32 words/lane|persistent D:one Half2/lane|D holds query rows L and L+32','storage')+
        arrow(855,125,855,185)+text(25,349,'Global buffers live across kernels; shared K/V slots live across two iterations; Q, numerator and denominator span all keys.'),
        'L1/L2 are hardware-managed caches on the routes. The byte offsets shown are explicit shared allocations and do not denote cache capacity.')


def attention_score_figure(fp8):
    return figure('One score tile feeds two precision-distinct reductions',335,
        box(20,25,245,100,'Warp view:64 queries ×64 keys|score via QKᵀ Tensor Cores|Half score accumulators','compute')+arrow(265,75,305,75)+
        box(305,25,270,100,'HalfFma → clamp → bit shift|E in Half2 registers|unnormalized positive weights','compute')+arrow(575,75,615,75)+
        box(615,25,425,100,'D branch: fixed Half-add tree|local partials → shuffle ownership transpose|one full query sum per lane / row half','compute')+
        arrow(440,125,440,180)+box(305,180,270,100,('N branch: pack E to E4M3|two K32 chunks over 64 keys|published E becomes MMA A' if fp8 else 'N branch: retain E as Half|four K16 chunks over 64 keys|published E becomes MMA A'),'compute')+arrow(575,230,615,230)+
        box(615,180,425,100,'Transposed V supplies MMA B|accumulate N[64,32] in Half registers|the next iteration reuses N and D','storage')+
        text(25,317,'Do not normalize E before E×V. The complete numerator is divided after every key tile contributes.'),
        'The denominator sees the Half surrogate. '+('The numerator sees rounded E4M3 values, so its scalar reference must include that conversion.' if fp8 else 'Both branches retain Half E, but they still use different reduction structures.'))


def attention_padding_figure(fp8):
    align=32 if fp8 else 16; S=2176 if fp8 else 2160
    return figure('Separate the stored-token and traversed-key boundaries',320,
        box(20,25,300,95,'T=2160 real field tokens|36×60 bottleneck positions|includes model spatial padding')+arrow(320,72,365,72)+
        box(365,25,315,95,f'Kernel group bound S=ceil(T/{align})×{align}|S={S} at this example|host may reserve extra rows','storage')+arrow(680,72,725,72)+
        box(725,25,315,95,'Traversal P=ceil(T/64)×64|P=2176;34 K/V tiles|out-of-bound groups stage zero','storage')+
        box(20,175,465,95,'Zero K ⇒ score 0 ⇒ E(0)=0.083984375|Zero V ⇒ no numerator contribution|16 extra keys add1.34375 to denominator','compute')+arrow(485,222,535,222)+
        box(535,175,505,95,'correction = Half(FP32(E(0))×FP32(P−T))|Dcorrected=HalfSub(D,correction)|floor at ε; approximate reciprocal; scale N','compute'),
        'Correct only the extra traversal slots. A spatially padded position already counted in T is part of the model’s attention domain.')


def attention_lesson(name, fp8):
    fmt='FP8' if fp8 else 'FP16'; E=1 if fp8 else 2
    fmtval='E4M3' if fp8 else 'Half'
    path=P+f'bottleneck_c1024_attention/{fmt.lower()}/{name}.cu'
    qchunks=1 if fp8 else 2; pchunks=2 if fp8 else 4; align=32 if fp8 else 16
    delta=0 if fp8 else 6
    qaddr=22*16384*E+7*512*E+208
    kval=9*16384*E+7*512*E+208
    body=f"""
<h2 id="model">1. Define this kernel’s exact attention problem</h2>
<p><code>{name}</code> performs global attention inside C1024 bottleneck records 31–38. There are 32 heads of 32 channels. For one head h, the logical inputs are Q[T,32], K[T,32], V[T,32]. Q and K have already been independently normalized across their 32 channels by the upstream QKV kernel, and Q already includes √32 and the learned head scale. This kernel does not repeat those operations. It computes one updated 32-channel vector for every query, then publishes all heads into an output logically [T,1024]. The later output projection and scaled residual are outside this entry.</p>
<p>Every query reads all T bottleneck positions, with no window restriction or relative-position bias. For the <a href="{ARCH}">architecture’s 4K example</a>, H=36,W=60,T=2160. The traversal rounds to P=ceil(T/64)·64=2176 keys. Its extra K/V rows are zero. Define <code>s[q,k]=Σd Q[q,d]K[k,d]</code>; the recovered Half surrogate produces E(s). The kernel returns <code>Publish(Σₖ Publish(E(s[q,k]))V[k,:] / max(Σₖ E(s[q,k])−(P−T)E(0), ε))</code>. Publication uses {fmtval}; numerator and denominator reduction are Half. This formula deliberately shows a publication inside the numerator.</p>
{attention_model_figure(fp8)}
<h2 id="baseline">2. Start with a scalar algorithm, including the padding correction</h2>
{pseudo(f'''P = round_up(T,64)
for head h in 0..31:
    for real query q in 0..T-1:
        numerator[32] = 0; denominator = 0
        for key k in 0..P-1:
            key_vector   = K[h,k,:] if k<T else zeros(32)
            value_vector = V[h,k,:] if k<T else zeros(32)
            score = dot(Q[h,q,:], key_vector)
            e = global_half_exponent_surrogate(score)
            denominator += e
            e_operand = round_to_{fmtval}(e)
            for d in 0..31: numerator[d] += e_operand * value_vector[d]
        denominator -= (P-T) * global_half_exponent_surrogate(0)
        output[h,q,:] = round_to_{fmtval}(numerator / max(denominator,epsilon))''','Scalar dependency baseline; subsequent steps derive the exact fragment and Half reduction order')}
<p>This baseline is intentionally explicit about artificial keys. Zero K does not give zero exponential, so simply summing over P would dilute valid attention. Zero V does eliminate their numerator contribution. The mathematical baseline also separates two goals: reproducing which values are used, and reproducing the deployed rounding sequence. A scalar floating loop generally sums in a different order from MMA fragments and warp shuffles. Use it first for dependency/layout tests, then add the exact Half chunk/reduction boundaries for stricter numerical comparison.</p>
<p>A naive implementation can allocate scores[T,P], exponentials[T,P], and perhaps normalized probabilities[T,P], then launch separate matrix multiplication, transform, normalization and value-product kernels. At T=2160, one head’s score matrix has 4,700,160 entries. This source retains only a 64-key tile per query warp. That removes quadratic <em>storage</em> and intermediate traffic, while preserving the quadratic count of query–key interactions. Do not confuse streamed storage with a linear-time attention approximation.</p>
{mma_primer(fp8)}
<h2 id="tiling">3. Derive a useful query/key tile from MMA fragments</h2>
<p>A QKᵀ MMA computes 16 query rows by 8 key columns, reducing {'32' if fp8 else '16'} head channels. Since the head width is 32, one score fragment needs {qchunks} native K chunk(s). Four M16 query tiles give a warp 64 queries; eight N8 key tiles give it 64 keys. Its score state is <code>Probability[4].Pair[8][2]</code>,64 packed Half2 words per lane. Four warps share one head and K/V tile, so the CTA covers 256 queries×64 keys per iteration.</p>
<p>Choose <code>head=blockIdx.x</code>, <code>queryBlock256=blockIdx.y</code>, <code>lane=threadIdx.x</code> and <code>warp=threadIdx.y</code>. The warp’s first query is 256·queryBlock+64·warp. For its M16 tile m, row-half r and lane L, the query index is <code>256·queryBlock+64·warp+16m+floor(L/4)+8r</code>. The score fragment’s key pair in N8 tile c is <code>64·keyTile+8c+2·(L mod4)+{{0,1}}</code>. Those equations explain exactly which query–key interactions one packed score word represents.</p>
{attention_memory_figure(fp8)}
<p>The output numerator has 32 columns, so it requires four N8 fragments for each M16 query tile: <code>Output[4].Pair[4][2]</code>,32 words per lane. The denominator uses just one Half2 per lane, representing warp query rows L and L+32 after a register-ownership transpose. Q uses four M16×32 fragments, with {qchunks} 512-byte native chunks per M16, or {16*qchunks} register words per lane. These three objects survive all key iterations. Current scores and K/V register fragments have shorter lifetimes and can be replaced after each tile contributes.</p>
<h2 id="addresses">4. Derive Q, K, V and output physical addresses</h2>
<p>Inputs are already in their consumer layouts. A16-token group contains all 1024 channels across 32 heads. Let E={E} bytes per working element. A Q lane vector for group g/head h/chunk c is <code>Q+g·16384·E+h·512·E+c·512+L·16</code>. This entry has {qchunks} chunks. Its producer placed Q directly into the MMA A layout, so the consumer uses an aligned uint4 load without transposing. K uses the same group/head byte strides but its producer swapped the middle words, making it ready for the B operand of QKᵀ.</p>
<p>For key tile j, copySlot=warp+4·Copy with Copy=0…{qchunks-1}. The K group is <code>4j+floor(copySlot/{qchunks})</code> and its chunk is <code>copySlot mod{qchunks}</code>. The global base follows K+group·16384·E+h·512·E+chunk·512. Shared destination is <code>(j mod2)·{2048*E}+copySlot·512</code>. Each copy writes 512 bytes, covering one native M16×K panel. K groups beyond the kernel’s stored-group count are synthesized as zeros.</p>
<p>V has been register-transposed upstream for E×V. {'FP8 combines adjacent M16 tiles into M32 groups; valueGroup=2j+floor(copySlot/2).' if fp8 else 'FP16 retains M16 token groups; valueGroup equals the K group.'} Its global base is <code>V+valueGroup·32768+h·1024+(copySlot mod2)·512</code>. Its shared destination adds the V region offset {4096*E} to the matching stage/copy offset. These maps are not dense [T,32] array strides, and V cannot be replaced by a byte-identical copy of the Q layout.</p>
{address_figure(fmt+' attention: query 355 and key tile 2',[
 'queryBlock 1; warp 1; M16 tile 2|group=16+4+2=22, base token 352|lane 13 owns query 355 and 363; head 7',
 f'Q chunk 0 vector:22×16384×{E}|+7×512×{E}+13×16 = {qaddr}|'+('one chunk covers 32 channels' if fp8 else 'chunk 1 is 512 bytes later'),
 f'keyTile 2 covers keys128…191|K group 9 chunk 0, lane 13: {kval} bytes|shared K panel 1, chunk 0: {208+512*qchunks} bytes',
 'QueryRow=2×16+floor(13/4)=35|denominator owner lane=35 mod32=3|select high Half; return scalar to all channels'])}
<p>The worked Q address identifies a 16-byte operand vector, not a scalar channel. Its output-fragment owner query 355 has local row 35 within the warp. During the final normalization it fetches the high Half of lane 3’s denominator pair. For example, output column tile 0 at lane 13 holds channels 2/3 of that query; column tile 1 holds10/11. The final output uses Q’s group/head/chunk/lane layout, so the next projection can consume it as an ordinary packed token tensor.</p>
<p>Small-profile branches are explicit and should not be extrapolated from the large-tile diagrams: {'FP8 forces valueGroup=0 when there is just one M32 value group.' if fp8 else 'FP16 remaps Q/K/V group reads to zero when T is between 1 and 16.'} The ordinary multi-group examples above do not take that path. Storage padding is {'32' if fp8 else '16'} rows in the kernel’s group bound; the host can allocate a larger common 32-row-rounded buffer. A larger allocation is not permission for unpredicated extra loads.</p>
{code(path,32,87 if fp8 else 91,'The exact K/V global-to-shared copy maps for this entry')}
<h2 id="synchronous">5. Construct a synchronous streamed attention kernel</h2>
{pseudo(f'''load this warp's64 Q rows into registers once
N[64,32] = Half zeros; D[64] = Half zeros
for j=0 .. ceil(T/64)-1:
    stage K[j*64:j*64+64,:] and matching transposed V into one shared slot
    fill missing groups with zero; CTA_barrier()
    load K/V native fragments into registers
    Scores[64,64] = Q * transpose(K) via {qchunks} head-channel chunk(s)
    E = exact Half affine/clamp/encoding transform(Scores)
    D = HalfAdd(D, fixed_order_64_key_row_sum(E))
    Eoperand = publish_{fmtval}(E)         # a register conversion, not a global store
    N = N + Eoperand * V via {pchunks} key-reduction chunks
    CTA_barrier()                       # retire old K/V readers
correct padding mass in D; compute reciprocal; scale N
publish valid output groups; clear invalid tail rows''','A one-slot scaffold already eliminates full score/probability allocations')}
<p>This scaffold is a useful intermediate implementation because it isolates the attention algebra from asynchronous lifetime bugs. Keep Q and N/D registers across iterations, while reusing the same shared bytes for the next 64-key tile. The next optimization is to give those bytes two alternating slots and permit transfer of the future tile while current arithmetic runs. More stages would consume extra shared memory and require a different schedule; the recovered entry uses exactly two K/V stages.</p>
<h2 id="pipeline">6. Build the two-stage K/V ring and predecessor protocol</h2>
<p>The shared allocation is K0,K1,V0,V1, followed by two 8-byte barriers. Each K or V slot is {2048*E} bytes, so total data storage is {8192*E} bytes. One barrier belongs to the matched K/V slot pair: all its key and value copies register completion there. A stage is ready only when both operands and all expected arrivals have completed. The source initializes both barriers for 128 threads, synchronizes, then waits for the predecessor token groups containing its Q before loading Q.</p>
{async_explanation(2)}
<p><code>WaitPredecessor(first,count)</code> lets lane 0/warp 0 poll counters indexed by <code>(queryBlock128·16+head/2)·4</code> until they are nonnegative, bounded by the real number of 128-token query blocks; it then performs a CTA barrier. Before Q load it covers the two 128-token blocks belonging to this 256-query CTA. Before a K/V tile it covers the 128-token block containing that 64-key tile. The source tests readiness ≥0, not “QKV split index equals 1.” The prepared plan’s full launch ordering supplies the complete QKV-before-attention dependency; the word <em>chained</em> is not evidence that arbitrary overlapping launches are safe.</p>
<p>The body preloads up to two K/V tiles, then waits for tile 0. After consuming tile j, if j+2 exists it calls WaitPredecessor for that future tile, whose CTA barrier also takes all old readers beyond current consumption, then refills the retired slot. Finally it waits for j+1 before the next iteration. The ring index alone is not synchronization. Removing the predecessor routine’s unconditional CTA barrier because its counter is “already ready” would also remove a point used by this schedule to coordinate readers.</p>
{code(path,103 if fp8 else 107,134 if fp8 else 140,'Register Q lifetime and the two-stage prefill')}
<h2 id="exponent">7. Convert scores to the exact recovered exponent surrogate</h2>
<p>For each of four query tiles and eight N8 key-column tiles, the kernel initializes two Half2 score words and accumulates {qchunks} MMA head-channel chunk(s). It then applies a packed Half affine transform with slope 0.08953857421875 and intercept 1.708984375. Clamp the result to [1.439453125,1.9775390625]. Finally reinterpret the two Half encodings together: <code>Ebits=(clampedBits&lt;&lt;4)+0x3ffc4000</code> with 32-bit wraparound.</p>
<p>The final expression is an integer encoding transform, not multiplication by 16 in floating point. It acts on the whole packed word; carries between low/high Half fields are accounted for by the recovered offset. Independently applying a guessed scalar shift to the two components changes the high component. Likewise <code>exp</code>, <code>exp2</code>, conventional stable softmax and row-maximum subtraction are different numerical programs. The clamp bounds the surrogate’s range so this source can accumulate unnormalized weights without an online rescaling scheme.</p>
{attention_score_figure(fp8)}
{code(path,149+delta,175+delta,'The source-exact score MMA and Half-bit exponent transform')}
<h2 id="denominator">8. Derive the denominator ownership transpose</h2>
<p>A score tile’s lane L initially owns only part of a query row: two key columns in each N8 tile, for two row halves. Four neighboring lanes jointly cover all eight key columns of an N8 fragment. To form 64-key row sums, first add the eight fragment pairs in the recorded local tree: add pair 0+1 and 2+3, add those results, then add4+5, then 6+7. Each operation is HalfAdd on packed components. The code performs this for four local row fragments at a time.</p>
<p>Now redistribute those partials so one lane can own a complete query sum. It first permutes the four registers with XOR of <code>lane mod4</code>. The source lane is <code>((lane&amp;7)&lt;&lt;2)+(lane&gt;&gt;3)</code>. Four shuffles read from that source XOR the register index, and a second register permutation uses <code>lane&gt;&gt;3</code>. Adding the resulting registers 0,1,2,3 in order restores the required channel-lane summation sequence. Adding low and high Half components completes the scalar query sum. This is a transpose of <em>who owns partial sums</em>, not a materialized shared-memory matrix transpose.</p>
<p>The procedure runs for two 32-query halves, then joins their scalar results into one Half2. Consequently lane L owns D for query L in its low Half and query L+32 in its high Half. That pair is Half-added to the running denominator after every 64-key tile. Preserving the order matters: a generic butterfly across all keys or an FP32 accumulator can produce different rounding. Fixed array indices inside the register permutation also avoid requiring dynamically indexed storage for the tiny quartet; confirm actual register/local-memory behavior from compilation rather than assuming the source array never spills.</p>
{code(path,178+delta,215+delta,'Follow local sums, the two-way warp transpose, and the persistent denominator')}
<h2 id="numerator">9. Reuse the exponent tile immediately as an MMA operand</h2>
<p>After contributing to D, the same unnormalized E tile becomes A for E×V. <code>PublishWindowChunk</code> {'converts pairs of Half2 values to E4M3 and joins the byte pairs' if fp8 else 'selects the existing Half words'} into the four-register A fragment. {'The denominator used the Half values before this conversion; the numerator must use the rounded E4M3 values. Summing converted E values for D, or using unconverted Half E for N, changes the FP8 algorithm.' if fp8 else 'Both branches retain Half E, but the denominator uses scalar Half-add reductions while the numerator uses Tensor Core MMA. Equivalent real arithmetic does not imply identical finite-precision summation.'}</p>
<p>{'A concrete check is score zero: its Half E is 0.083984375, but E4M3 publication rounds it to 0.0859375. Before considering the additional Half sum/MMA rounding, these differ by a factor 44/43. Thus even uniform scores must not be validated by assuming an exactly normalized arithmetic mean of V. Build the oracle from the two actual branches, not from the word “softmax.”' if fp8 else 'With uniform scores, every key begins with the same Half E. Even then, use the chunked Half denominator and MMA numerator as the exact oracle: dividing an FP32 sum of V by the token count discards the source’s accumulation and reciprocal rounding boundaries.'}</p>
<p>The key reduction has 64 elements, so the E×V loop needs {pchunks} chunks of K{32 if fp8 else 16}. For each query M16 tile, two V column groups supply four N8 result fragments, covering 32 output channels. The V vector’s x/y words form the lower B fragment and z/w the upper. Every MMA accumulates directly into the persistent Half N tile. E is not divided into normalized probabilities first; that would move the rounding point and require repeated denominator work across chunks.</p>
<p>Once this contribution finishes, the current E, K and V registers are dead. They can be reused for the next tile, while Q/N/D remain live. This is the central lifetime decision behind the kernel’s storage savings. The global inputs Q/K/V still exist and are reread by other query CTAs, so the source does not eliminate all global traffic or guarantee that all repeated data stays in cache.</p>
{code(path,218+delta,253+delta,'Consume E×V, retire the stage, issue its two-ahead refill and wait for the next')}
<h2 id="padding">10. Correct the artificial-key denominator without masking model tokens</h2>
{attention_padding_figure(fp8)}
<p>Let S=ceil(T/{align})·{align} be the kernel’s stored-group bound. The host allocation may round to 32 even for Half. P=ceil(T/64)·64 is a different quantity used by the key traversal. At T=2160, {'S=2176 and P=2176 happen to coincide.' if fp8 else 'S=2160 while P=2176; the final missing M16 group is staged as zeros.'} Rows between T and S must have zero K/V from the producer’s padding contract; groups beyond S are zero-filled by this kernel. These are separate mechanisms serving the same logical traversal padding.</p>
<p>At score zero, the Half affine result is 0x3ed6. The scalar correction path computes <code>((0x3ed6&lt;&lt;4)+0x4000) mod65536=0x2d60</code>, which represents 0.083984375. With 16 artificial keys, that adds1.34375 to the uncorrected denominator. The implementation converts E(0) and the padding count to FP32, multiplies with FTZ, rounds the correction back to Half, and applies one Half subtraction. It does not subtract one value per padded key with a different sequence of Half roundings.</p>
<p>The correction applies to P−T only. Network spatial padding already included in H×W is part of the model’s token field and remains in attention. After correction, the kernel applies the same Half epsilon floor0x0410, then <code>RcpHalf2</code>: each component widens for an approximate reciprocal and rounds back to Half. This avoids division by zero for a small or zero corrected denominator under the specified rule.</p>
{code(path,256+delta,277+delta,'Derive E(0), form one correction and invert the corrected denominator')}
<h2 id="publication">11. Return row scalars to output owners and publish</h2>
<p>The numerator still follows MMA output ownership, while denominator D follows one query per lane. For each M16 query tile m and row-half r, compute <code>QueryRow=16m+floor(lane/4)+8r</code>. Shuffle the denominator pair from lane QueryRow mod32, then choose its low/high Half with floor(QueryRow/32). Replicate that scalar in a Half2 and multiply every output column pair belonging to the row. In the worked example query 355 is local row 35, so lane 13 selects lane 3’s high Half. The same reciprocal reaches all 32 channel values through their fragment owners.</p>
<p>Publication {'packs the normalized Half output to E4M3 through PublishWindowChunk' if fp8 else 'retains the normalized Half fragments through PublishWindowChunk'} and writes Q’s native group/head/chunk layout with L1 no-allocation stores. Tail group stores can include rows beyond T but below S, so the source performs a CTA barrier and explicitly clears those invalid rows after all vector stores. Only afterward does another CTA barrier precede the optional completion-counter release. The completion index is <code>(queryBlock128·32+head)·4</code>, distinct from the QKV predecessor’s head-pair index.</p>
{code(path,280+delta,310+delta,'Select the denominator for each query fragment and publish the final format')}
<h2 id="reconstruction">12. Complete construction with every lifetime and synchronization boundary</h2>
{pseudo(f'''derive T, storedRows=round_up(T,{align}), groups16=storedRows/16
derive keyTiles=ceil(T/64), queryBlocks128=ceil(T/128), head, queryBlock256, lane, warp
allocate K0/K1/V0/V1 ({8192*E} bytes) and two 8-byte barriers
initialize barriers for 128 arrivals; CTA_barrier()
WaitPredecessor(queryBlock256*2,2)         # poll needed counters; includes CTA barrier
load four M16 Q tiles, each with {qchunks} chunk(s); predicate missing groups
apply the source's tiny-profile group-broadcast rule where selected
for j=0..min(2,keyTiles)-1:
    WaitPredecessor(j//2,1)
    StageKV(j): issue matched K/V copies or zero fill invalid groups
if keyTiles>0: arrive_and_wait(stage 0)
N = Half zero output fragments; D = one Half2 zero per lane
for j=0..keyTiles-1:
    load K fragments from shared slot j%2
    E = zero Half score fragments
    for each M16 query tile and eight N8 key tiles:
        for each of {qchunks} head-channel chunk(s): MMA Q×Kᵀ into E
        E = Half affine → clamp → whole-word encoding shift/add
    Dchunk = fixed local Half-add tree → register permutations/shuffles → complete row sums
    D = HalfAdd(D,Dchunk)
    load transposed V fragments from shared V slot j%2
    for each query tile, output panel and {pchunks} key chunk(s):
        publish E chunk to {fmtval} register A; MMA E×V into persistent N
    if j+2<keyTiles: WaitPredecessor((j+2)//2,1); StageKV(j+2)
    if j+1<keyTiles: arrive_and_wait(stage(j+1))
padding=keyTiles*64-T
if padding>0: D=HalfSub(D,Half(FP32(E(0))*FP32(padding)))
inverse=RcpHalf2(max(D,epsilon))
for each query row fragment: shuffle/select its inverse; HalfMul all N channel pairs
publish valid groups in native {fmtval} output layout
if storedRows!=T:
    CTA_barrier(); clear only invalid output rows T..storedRows-1
CTA_barrier()
if completion counter pointer is present:
    lane 0/warp 0 release-publishes this head's valid 128-query block counters''','Complete reconstruction: no global score, exponential, denominator or partial-numerator tensor')}
<h2 id="checks">13. Validate model behavior, numerical boundaries and pipeline safety</h2>
<ol><li><strong>Zero score:</strong> set Q or K to zero. Verify the exact surrogate produces 0.083984375, including both packed Half lanes. The denominator correction must remove only P−T contributions, and the numerator must use {'E4M3-rounded E' if fp8 else 'Half E'}.</li><li><strong>Key/value identity:</strong> give V distinct representable tags by token and channel. Decode using the transposed V map; changing one key’s V should affect all query rows according to that key’s weight, with no head cross-talk.</li><li><strong>Row ownership:</strong> use differing Q rows so denominators vary by query. Trace local rows 3,11,35,43 and verify the shuffle returns the correct inverse to every channel fragment. A constant-input test alone cannot expose a swapped row sum.</li><li><strong>Padding:</strong> exercise T values on both sides of 16,32,64,128 and 256 boundaries where admitted. Compare the valid-row result with a reference using only T model keys and the same rounding conventions; inspect the explicit correction separately. Invalid stored output rows must be zero and allocation guards unchanged.</li><li><strong>Precision:</strong> compare QK Half scores, transformed E bits, per 64-key Half sums, {'packed E4M3 MMA operands, ' if fp8 else ''}numerator fragments, reciprocal pairs and final output separately. This locates a mismatch at the first wrong boundary instead of masking it with final-output tolerance.</li><li><strong>Pipeline/counters:</strong> compare the one-slot synchronous scaffold with the two-slot entry over more than two key tiles. Verify both K and V have arrived before consumption, and both old readers have retired before refill. Test absent/present completion counters and valid predecessor initialization; do not launch against a producer schedule the host contract does not authorize.</li><li><strong>Tiny profiles:</strong> isolate the recovered {'one-M32 V broadcast' if fp8 else '1–16-token Q/K/V broadcast'} branch from ordinary multi-group padding tests; the normal large-shape address derivation alone does not cover that branch.</li></ol>
<p>The optimization progression can now be evaluated concretely. Register-resident Q removes repeated query loads within a CTA. Sharing 64-key K/V tiles across 256 queries reduces duplicate input fetches. Short-lived E fragments eliminate quadratic intermediate storage. The row-sum transpose avoids shared reduction storage while preserving add order. The two-slot ring permits asynchronous copies to overlap useful work. The costs are substantial register lifetimes, shared capacity and synchronization, plus repeated K/V reads across different query CTAs. This tutorial reconstructs the mechanisms and their correctness conditions; it does not claim new timings or measured cache residency.</p>
"""
    return dict(name=name,title=f'{name}: construct streamed global attention',summary=f'A standalone {fmt} reconstruction from scalar all-token attention to packed Q/K/V, per-lane scores, two-stage streaming, exact exponentials and corrected normalization.',family='Global bottleneck',body=body)


def build_lessons(inventory):
    entries=inventory['entries']
    result=[]
    for fp8 in (False,True):
        suffix='fp8' if fp8 else 'fp16'
        specs=[('global_ffn_expand_c1024_',lambda n:expand_lesson(n,fp8)),
               ('global_ffn_contract_c1024_',lambda n:contract_lesson(n,fp8,False)),
               ('global_projection_c1024_',lambda n:contract_lesson(n,fp8,True)),
               ('global_qkv_c1024_',lambda n:qkv_lesson(n,fp8)),
               ('global_attention_chained_c1024_',lambda n:attention_lesson(n,fp8))]
        for prefix,render in specs:
            name=prefix+suffix
            if name not in entries:
                raise KeyError('Required bottleneck public entry absent: '+name)
            result.append(render(name))
    return result
