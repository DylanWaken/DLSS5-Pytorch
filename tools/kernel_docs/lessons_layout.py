"""Standalone lessons for four C1024 permutations and counter initialization."""
from common import code, svg, note
from lesson_support import pseudo
import re
from html import escape


TITLES = ['The whole problem', 'One CTA: its concrete subproblem', 'Warp and thread ownership',
          'Resource budget', 'Execution and scheduling', 'Trace one token through the source']


def chapter(ident, number, content):
    return f'<h2 id="{ident}">{number}. {TITLES[number-1]}</h2>' + content


def pieces(body):
    return {m[1]:(m[2],m[3]) for m in re.finditer(r'<h2 id="([^"]+)">(.*?)</h2>(.*?)(?=<h2 |\Z)',body,re.S)}


def sub(parts, key):
    title,body=parts[key]
    return '<h3 id="'+key+'">'+re.sub(r'^\d+\. ','',title)+'</h3>'+body


def take_source(fragment):
    """Move the owning instruction loop from ownership prose into the trace."""
    excerpts=re.findall(r'<details class="source".*?</details>',fragment,re.S)
    return re.sub(r'<details class="source".*?</details>','',fragment,flags=re.S),''.join(excerpts)


def stripmap(title, labels, caption):
    markup=''
    for i,(heading,detail) in enumerate(labels):
        x=20+230*i
        markup+=f'<rect class="{"compute" if i%2 else "storage"}" x="{x}" y="32" width="205" height="110" rx="8"/><text class="label" x="{x+12}" y="64">{escape(heading)}</text><text class="small" x="{x+12}" y="103">{escape(detail)}</text>'
        if i+1<len(labels):markup+=f'<path class="edge" d="M{x+206} 85 H{x+229}"/>'
    markup+=f'<text class="small" x="20" y="188">{escape(caption)}</text>'
    return svg(title, f'0 0 {230*len(labels)+20} 215', markup)


def revise_repack(body,fp8,forward):
    old=pieces(body); words=256 if fp8 else 512; blocks=2176 if fp8 else 4352
    extent=2176 if fp8 and forward else 2160
    result=chapter('problem',1,old['model'][1]+sub(old,'baseline'))
    result+=chapter('cta',2,f'''<p>For the 3840×2160 image, the bottleneck is H=36, W=60, T=2160. The deployment launcher submits <strong>{blocks} CTAs × 256 threads</strong>. One CTA owns 256 logical uint32 work items on its first iteration: {'one complete token (1024 bytes)' if fp8 else 'half of a token (1024 bytes); two CTAs cover a 2048-byte token'}. Logical ownership is contiguous even though physical addresses are interleaved. There is no matrix subproblem or reuse across threads.</p><p>The launcher sizes for 2176 allocated tokens. This kernel actually covers {extent} tokens × {words} words. Thus {'the final 16 token CTAs write zeros' if fp8 and forward else f'the final {blocks-(extent*words//256)} CTAs have no valid loop iteration'}. A larger allocation or grid does not enlarge the source loop bound. The measured launch table below independently checks the submitted geometry.</p>''')
    result+=stripmap('One repack CTA covers a 1024-byte logical slice',[
        ('CTA b', 'i₀ = 256 × b'),('256 word owners','i = i₀ + thread'),
        ('Token / channel',f't = i/{words}; cw=i%{words}'),('Physical copy','4F(src) → 4F(dst)')],
        'Each word has one writer. The spatial permutation changes token bits; it never mixes values.')
    ownership,loop_source=take_source(old['threads'][1])
    result+=chapter('warp',3,ownership)
    result+=stripmap('Eight independent warps inside a repack CTA',[
        ('Warp 0','threads 0…31'),('Warp w','threads 32w…32w+31'),
        ('Lane ℓ','one uint32 word'),('Next iteration',f'i += {blocks*256:,} at 4K')],
        '32 lanes copy 128 useful bytes per warp iteration; transaction count depends on the permuted addresses.')
    result+=chapter('resources',4,'''<p>Application shared memory: <strong>0 bytes</strong>. Shared barriers, tensor fragments, and persistent register arrays: <strong>none</strong>. Each active thread needs a 32-bit word plus integer address/control temporaries; pointer and multiply lowering can consume more than one register. The source has no register cap. Do not infer allocated registers by counting C++ variables.</p><p>No staging buffer exists, so there is no shared-memory bank map or XOR swizzle to invent. L1/L2 cache residency is managed by hardware and varies with replay; the source only specifies global-memory addresses. The profiler's driver reservation is distinct from source-declared shared bytes.</p><!-- RESOURCE_EVIDENCE -->''')
    result+=chapter('schedule',5,'''<p>The SM schedules independent CTAs in any order; nothing in this permutation depends on that order. Within each thread, calculate a work index, test the loop bound, derive token and word coordinates, then execute the direction-specific copy. Increment by the grid stride and repeat. The next kernel observes completion through stream ordering.</p>''')
    result+=stripmap('Repack control flow',[
        ('Index + bound','i < logical extent?'),('Coordinates','t, cw → y,x → S(t)'),
        ('Input operand','zero if padded' if forward else 'load one uint32'),('Output + loop','store; i += grid stride')],
        'False loop predicate → exit. Forward valid rows load input; forward padded rows bypass that read entirely.')
    result+=chapter('trace',6,'''<p>Keep one colored payload in mind: <strong>token 309, channel word 13</strong>. It is owned by thread 13, warp 0, lane 13 in CTA '''+str((309*words+13)//256)+'''. The following derivation follows its spatial index, packed-word address, global load, register value, and global store without changing the example midway.</p>''')
    for key in ('spatial','address'):result+=sub(old,key)
    def packed(t,cw):
        return (t//16)*(16*words)+(cw//8)*128+(t%8)*16+(cw%4)*4+((cw%8)//4)*2+(t%16)//8
    src,dst=(4*packed(277,13),4*packed(309,13)) if forward else (4*packed(309,13),4*packed(277,13))
    result+=stripmap(f'{"FP8" if fp8 else "FP16"}: token309 word13 through actual storage',[
        ('Global input',f'base + {src:,} bytes'),('Ordinary 32-bit load','hardware-managed L1/L2'),
        ('Register payload','bits copied unchanged'),('Global output',f'base + {dst:,} bytes')],
        'One uint32 carries '+('[50,51,58,59] model channels.' if fp8 else 'Half channels26/27.')+' Cache hits and transactions require profiler evidence.')
    result+='<h3 id="copy-source">Execute the address derivation in the owning loop</h3><p>The selected logical work item is <code>i='+str(309*words+13)+'</code>. Its bound succeeds, integer decomposition gives token309 and word13, and the layout helpers produce the two byte offsets above. The source expresses an ordinary uint32 global load followed by a global store; there is no explicit cache operator, vector copy, shared stage or collective. The compiler selects machine instruction details, which the SASS evidence below can verify. On the documented covering grid the next grid-stride index exceeds the loop limit, so this thread executes one copy.</p>'+loop_source
    for key in ('bounds','rebuild','tests'):result+=sub(old,key)
    result+='<!-- NCU_EVIDENCE -->'
    return result.replace('This source tour supplies no new bandwidth result; measure effective read-plus-write bytes and memory transactions on the target GPU before changing the access width or introducing a tiled staging algorithm.','The measured evidence below checks traffic and instructions for the documented workload; an optimization still needs a controlled before/after experiment.')


def revise_counter(body):
    old=pieces(body)
    result=chapter('problem',1,old['model'][1]+sub(old,'baseline'))
    result+=chapter('cta',2,'''<p>A CTA initializes at most 256 adjacent int32 counters, or 1024 useful bytes. The first counter-clear call in the 4K deployment initializes 136 counters with one 256-thread CTA: threads 0…135 store, threads 136…255 return. Other calls use counts 272, 544 and 270, so their covering grids differ. The NCU case below profiles that first 136-counter call, while the teaching trace uses 300 counters to expose a partially occupied second CTA.</p>''')
    result+=stripmap('Counter CTA geometry: measured case and tail example',[
        ('4K first call','N=136; grid=1'),('CTA 0','256 threads'),
        ('Live stores','indices 0…135'),('Guarded tail','136…255 → exit')],
        'One writer per live int32; no grid-stride iteration and no inter-CTA communication inside this launch.')
    ownership,store_source=take_source(old['address'][1])
    ownership=re.sub(r'(block 1,? )lanes? (0…43|43|44)',lambda m:m[1]+('threads ' if m[2]=='0…43' else 'thread ')+m[2],ownership,flags=re.I)
    result+=chapter('warp',3,ownership)
    result+='''<p>Convert the flat thread index into warp and lane explicitly: thread 43 is <strong>warp 1, lane 11</strong>; thread 44 is warp 1, lane 12. A hardware warp has only 32 lanes. In the measured N=136 case, four warps are fully active, warp 4 has eight valid lanes, and warps 5–7 perform no stores.</p>'''
    result+=chapter('resources',4,'''<p>Application shared memory: <strong>0 B</strong>. No input payload, tensor-core fragments, shared barriers, or arrays are declared. Index arithmetic and the int32 −1 store operand need compiler-selected registers; the source specifies no max-register cap. The NCU table separates compiled allocation from any driver-managed shared reservation.</p><!-- RESOURCE_EVIDENCE -->''')
    result+=chapter('schedule',5,old['ordering'][1])
    result+=stripmap('Counter execution and stream dependency',[
        ('Prior work done','enqueue clear on stream'),('Index + guard','i = 256b + thread'),
        ('Store sentinel','counter[i] = −1'),('Next stream work','split producer may run')],
        'Rejected indices exit before dereference. No atomic or intra-block barrier is required for the independent stores.')
    result+=chapter('trace',6,'''<p>This kernel moves a <strong>control word</strong>, not an activation token. Trace the illustrative N=300 case: CTA 1, thread 43 (warp 1, lane 11) computes i=299, passes 299&lt;300, forms base+1196, and stores the four bytes FF FF FF FF. Thread 44 computes 300 and exits. A normal global store may be buffered/cached; the next ordered launch establishes when its users can proceed.</p>''')
    result+=stripmap('Trace control word299 to the global counter allocation',[
        ('CTA1 / thread43','warp1 / lane11'),('Predicate','299 < 300: write'),
        ('Register / immediate','int32 −1 = 0xFFFFFFFF'),('Global address','base + 1196 bytes')],
        'No input-memory load: the source supplies a literal sentinel. The following stream-ordered launch consumes it.')
    result+='<h3 id="store-source">The complete source at the write boundary</h3><p>The index expression uses the actual blockDim.x, which is256 in this plan. The signed int32 guard rejects the tail before pointer dereference; launcher validation supplies the admitted count/index domain. The ordinary int32 assignment is the only memory operation. Cache transaction count and the compiled store opcode come from the measured report, not from the number of source statements.</p>'+store_source
    result+=sub(old,'rebuild')+sub(old,'tests')+'<!-- NCU_EVIDENCE -->'
    return result.replace('No new launch-overhead measurement is claimed here.','The NCU duration below is one instrumented launch, not an end-to-end estimate of host launch overhead.')


def repack(name, entry):
    fp8 = name.endswith('fp8')
    forward = '2d_to_1d' in name
    precision, words, align, scalars = ('FP8', 256, 32, 4) if fp8 else ('FP16', 512, 16, 2)
    path = 'csrc/' + entry['header']
    direction = 'spatial → token' if forward else 'token → spatial'
    body = f'''<h2 id="model">1. The model operation: keep the values, change their order</h2>
<p>This kernel sits {'between the encoder C512→C1024 projection and the first global bottleneck block (records 30→31)' if forward else 'between the last global bottleneck block and the first decoder transition (records 38→39)'}. The logical activation has shape <code>[H,W,1024]</code>. Local blocks group pixels into physical 4×4 tiles. Global attention needs the same pixels in row-major sequence order, where token <code>t = yW+x</code>. {'This entry converts the tiled representation into that sequence and initializes its padding.' if forward else 'This entry converts the sequence back into tiled storage for the spatial decoder.'}</p>
<p>No learned matrix, activation function, channel mixing, or floating-point arithmetic belongs here. A {precision} word is copied as 32 unchanged bits containing {scalars} {'values in the native E4M3 channel order' if fp8 else 'adjacent Half channel values'}. Even NaN payloads and signed-zero bits survive the copy. The model-level equation is <code>Y[y,x,c] = X[y,x,c]</code>; the hard part is making that identity true for two different physical address functions. The <a href="architecture.html">architecture companion</a> locates the boundary, but all layout definitions needed for this kernel are below.</p>'''
    body += svg(f'{direction} model identity', '0 0 900 215', f'''<rect class="tensor" x="15" y="30" width="285" height="125" rx="8"/><text class="label" x="30" y="60">{'Spatial tiles' if forward else 'Global sequence'} · {precision}</text><text class="small" x="30" y="90">H × W pixels, 1024 channels</text><text class="small" x="30" y="120">{'4 × 4 tile traversal' if forward else 't = yW + x'}</text><path class="edge" d="M305 92 H365"/><rect class="compute" x="375" y="47" width="160" height="92" rx="8"/><text class="label" x="391" y="79">Copy uint32</text><text class="small" x="391" y="111">no conversion</text><path class="edge" d="M540 92 H595"/><rect class="storage" x="605" y="30" width="280" height="125" rx="8"/><text class="label" x="620" y="60">{'Global sequence' if forward else 'Spatial tiles'}</text><text class="small" x="620" y="90">{'t = yW + x; tail = +0' if forward else 'only real H × W tokens'}</text><text class="small" x="620" y="120">same channels, new addresses</text><text class="small" x="20" y="193">A permutation changes where a value lives, not which pixel or channel it represents.</text>''')
    body += '''<h2 id="baseline">2. Write a correctness baseline before parallelizing</h2><p>Begin with a CPU loop over every logical token and every channel word. Give each input word a recognizable integer bit pattern. Implement the two address functions below, and copy between their results. Integer patterns are a better first test than random floating-point activations because a wrong pixel or channel remains easy to identify.</p>'''
    body += pseudo(f'''WPT = {words}                       # uint32 words per 1024-channel token
T = H * W
P = ceil_div(T, {align}) * {align}
for t in range({'P' if forward else 'T'}):
    for cw in range(WPT):
        {'output[F(t,cw)] = input[F(S(t),cw)] if t < T else 0' if forward else 'output[F(S(t),cw)] = input[F(t,cw)]'}''', 'Scalar reference in the same physical layouts')
    body += f'''<p><code>F</code> is the packed-word address inside either representation; <code>S</code> changes a row-major pixel index into a spatial-tile index. Neither function changes the channel word. For this public entry, <code>WPT={words}</code> and the forward packing alignment is {align} tokens. These are compile-time precision choices, not runtime tensor metadata. The prepared deployment allocator can reserve a larger buffer than a single entry writes; distinguish allocation size from the kernel's actual loop extent.</p>
<h2 id="spatial">3. Derive the spatial token permutation</h2><p>Take <code>y=t//W</code> and <code>x=t%W</code>. The tile coordinate is <code>(y//4,x//4)</code>. There are <code>W//4</code> tile columns; its linear tile index is <code>(y//4)(W//4)+x//4</code>. Multiply by 16 to skip complete tiles. The pixel within that tile is <code>4(y%4)+x%4</code>. Therefore:</p>'''
    body += pseudo('S(t) = 16 * ((y // 4) * (W // 4) + x // 4) + 4 * (y % 4) + x % 4', 'Spatial token index')
    body += '''<p>For width 60 and token 309, <code>(y,x)=(5,9)</code>. The tile is <code>(1,2)</code>, tile index <code>17</code>, and the pixel inside it has index <code>5</code>. Thus <code>S(309)=17×16+5=277</code>. This example separates pixel permutation from the more intricate word interleave; do not apply the 4×4 permutation independently to channels.</p>'''
    body += svg('One pixel through spatial tile addressing', '0 0 920 230', '''<rect class="tensor" x="15" y="25" width="245" height="140" rx="8"/><text class="label" x="30" y="55">Row-major t = 309</text><text class="small" x="30" y="89">W = 60 → y = 5, x = 9</text><text class="small" x="30" y="119">tile (1,2), local pixel (1,1)</text><path class="edge" d="M265 94 H315"/><rect class="compute" x="325" y="25" width="255" height="140" rx="8"/><text class="label" x="340" y="55">15 tiles across</text><text class="small" x="340" y="89">tile index = 1 × 15 + 2</text><text class="small" x="340" y="119">local index = 1 × 4 + 1</text><path class="edge" d="M585 94 H635"/><rect class="storage" x="645" y="25" width="255" height="140" rx="8"/><text class="label" x="660" y="55">Spatial token = 277</text><text class="small" x="660" y="89">17 × 16 + 5</text><text class="small" x="660" y="119">channel word unchanged</text><text class="small" x="20" y="207">Width is measured in pixels; W / 4 is the number of physical 4×4 tiles per row.</text>''')
    body += '''<h2 id="address">4. Derive the packed-word interleave</h2><p>A naive <code>t×WPT+cw</code> address would not match the surrounding tensor-core kernels. Their fragments interleave 16 token rows with groups of eight channel words. Split the two indices into independent bit fields. The address below is in <strong>uint32 words</strong>; multiply it by four only when adding it to a byte pointer.</p>'''
    body += code('csrc/kernel_impl/bottleneck_c1024_layout/common/global_repack_layout.cuh', 1, 29, 'The two authoritative layout equations')
    body += f'''<div class="table-scroll"><table><thead><tr><th>Term in F(t,cw)</th><th>What it selects</th></tr></thead><tbody><tr><td>(t//16) × (16×{words})</td><td>A complete 16-token matrix tile</td></tr><tr><td>(cw//8) × 128</td><td>An eight-word channel panel, containing 16×8 words</td></tr><tr><td>(t%8) × 16</td><td>The low three token bits inside the panel</td></tr><tr><td>(cw%4) × 4</td><td>The low two channel-word bits</td></tr><tr><td>((cw%8)//4) × 2</td><td>The high bit of the eight-word channel group</td></tr><tr><td>(t%16)//8</td><td>The high token bit, interleaved at word granularity</td></tr></tbody></table></div>
<p>These fields do not overlap. Within a 128-word panel, the two channel low bits occupy address bits 2–3, the channel high bit occupies bit 1, and token bits occupy bits 4–6 and bit 0. Every combination has one address; this proves the inner layout is a permutation. Complete panels and complete 16-token tiles occupy disjoint intervals.</p>'''
    def F(t,cw): return (t//16)*(16*words)+(cw//8)*128+(t%8)*16+(cw%4)*4+((cw%8)//4)*2+(t%16)//8
    ft,fs=F(309,13),F(277,13)
    if fp8:
        body += '''<p>A channel-word index labels the native packed word, not four consecutive model channels. In a C32 panel let <code>v=cw%8</code>, <code>base=32×floor(cw/8)</code>, and <code>a=base+16×floor(v/4)+2(v%4)</code>. The four bytes contain model channels <code>[a,a+1,a+8,a+9]</code>, in that order. This follows the producer's <code>PackHalfPairsE4</code> of adjacent N8 accumulator groups: cw=0 carries [0,1,8,9]. The repack kernel neither undoes nor changes this channel permutation; surrounding MMA operands and packed weights already agree on it.</p>'''
    body += f'''<p>Continue with <code>cw=13</code>. It contains model channels {'[50,51,58,59]' if fp8 else '[26,27]'}. <code>F(309,13)={ft}</code> and <code>F(277,13)={fs}</code>. This kernel therefore copies byte offset <strong>{4*fs if forward else 4*ft}</strong> of its input to byte offset <strong>{4*ft if forward else 4*fs}</strong> of its output. Compute both sides on paper before implementing the device loop. Only the token argument differs.</p>
<h2 id="threads">5. Assign words to CUDA threads</h2><p>The prepared plan uses 256 threads per block. Flatten the launch as <code>i=blockIdx.x×blockDim.x+threadIdx.x</code>. Decompose the loop index as <code>t=i//WPT</code> and <code>cw=i%WPT</code>, then map to physical addresses. Notice that <code>i</code> is a logical work index, not the physical input or output offset. At the next iteration add <code>gridDim.x×blockDim.x</code>. This grid-stride loop preserves full coverage even when the launcher supplies fewer blocks than the number of words.</p><p>Each work index belongs to exactly one thread modulo the grid stride, and the address permutation is one-to-one. Consequently two threads never write the same output word. There is no cross-thread exchange, reduction, shared-memory tile, or barrier. Adjacent logical channel words are permuted within a compact 128-word panel, so the mapping retains spatial locality without a shared-memory transpose. The source uses ordinary 32-bit loads and stores; it does not explicitly vectorize them into 16-byte instructions or request asynchronous copies.</p>'''
    body += code(path, 10, 42 if forward else 35, 'The loop: decompose, permute, copy')
    body += svg('Word copy storage lifetime', '0 0 900 250', '''<rect class="storage" x="15" y="30" width="235" height="155" rx="8"/><text class="label" x="30" y="61">Input global allocation</text><text class="small" x="30" y="94">address = input + 4F(…)</text><text class="small" x="30" y="124">L2 / L1 service hardware</text><text class="small" x="30" y="152">no guaranteed residence</text><path class="edge" d="M255 105 H315"/><rect class="compute" x="325" y="48" width="230" height="117" rx="8"/><text class="label" x="340" y="80">Thread register</text><text class="small" x="340" y="113">r_CopiedWord: 32 bits</text><text class="small" x="340" y="142">or literal zero for tail</text><path class="edge" d="M560 105 H620"/><rect class="storage" x="630" y="30" width="250" height="155" rx="8"/><text class="label" x="645" y="61">Output global allocation</text><text class="small" x="645" y="94">address = output + 4F(…)</text><text class="small" x="645" y="124">one writer per word</text><text class="small" x="645" y="152">next launch consumes it</text><text class="small" x="20" y="224">Shared memory and tensor cores are absent: neither would add reuse to this bit permutation.</text>''')
    body += f'''<h2 id="bounds">6. Handle the boundary exactly</h2><p>{f'The forward loop covers P×{words} words, with P rounded up to {align}. For t≥T it emits literal integer zero and does not evaluate an input read. Those bits represent positive zero in every packed channel. This is an actual initialization step used by downstream bottleneck kernels, not just an allocation convention.' if forward else f'The inverse loop covers exactly T×{words} words. The input may contain padded token rows, but they have no real spatial destination and the kernel never reads them. An oversized launch simply fails its loop bound; it must not write extra spatial rows.'}</p><p>The supported host contract supplies positive, aligned spatial geometry and separate input and output buffers. This permutation is not generally safe in-place: a thread can overwrite a word another thread has not read. Width must be compatible with the four-pixel tiling; the prepared model geometry satisfies that contract. Unsigned 32-bit loop arithmetic also means the launcher must keep products within its validated bounds.</p>
<h2 id="rebuild">7. Reconstruct the final kernel</h2><p>Implement the two pure integer functions first. Then add the launch index and grid stride. Finally add the direction-specific extent and tail rule. Keep the full 32-bit word as an integer throughout: unpacking/repacking would add work and could alter special values. The only precision-specific choices are words per token and the forward alignment.</p>'''
    body += pseudo(f'''constexpr WPT = {words}, ALIGN = {align};
T = uint32(H) * uint32(W);
P = ceil_div(T, ALIGN) * ALIGN;
limit = {'P' if forward else 'T'} * WPT;
for i = block.x * blockDim.x + thread.x; i < limit; i += gridDim.x * blockDim.x:
    t = i / WPT; cw = i % WPT;
    {'word = 0;' if forward else 'word = input[F(t,cw)];'}
    {'if t < T: word = input[F(S(t),cw)];' if forward else '// Ignore all padded input tokens.'}
    output[{'F(t,cw)' if forward else 'F(S(t),cw)'}] = word;''')
    body += '''<h2 id="tests">8. Validate addresses before measuring bandwidth</h2><ol><li>Enumerate every <code>(token%16,cw%8)</code> pair on CPU. Verify 128 unique offsets from 0 through 127. Then check the full geometry has no destination collisions.</li><li>Fill packed words with an index-derived integer pattern. Compare this direction against the scalar baseline word for word; also run forward then inverse and compare every original bit.</li><li>Use widths with more than one tile column and heights with more than one tile row. Include a token such as the worked example that moves between tile indices; a single 4×4 tile can hide permutation mistakes.</li><li>Test a forward extent that requires padding where the geometry permits it, poison the destination first, and check only the specified aligned tail becomes zero. For inverse, poison padding in the input and put canaries after the spatial output.</li><li>Repeat with an intentionally smaller grid to exercise a second grid-stride iteration. Test both precisions separately, because their word counts differ.</li></ol><p>The optimization here is avoiding computation: copy packed bits, derive addresses with power-of-two divisions and remainders, and let independent threads stream through the permutation. This source tour supplies no new bandwidth result; measure effective read-plus-write bytes and memory transactions on the target GPU before changing the access width or introducing a tiled staging algorithm.</p>'''
    return dict(name=name,title=f'{precision} C1024 repack: {direction}',summary='Build a bit-exact layout permutation from pixel coordinates to packed words, with a numerical address trace, thread ownership and precise padding rules.',family='C1024 layout',body=revise_repack(body,fp8,forward))


def counter(entry):
    name='completion_counter_clear'
    body='''<h2 id="model">1. The model operation: initialize a dependency, not an activation</h2><p>Split-reduction kernels in the C1024 bottleneck cooperate through scratch tensors and integer completion counters. Before a new invocation, the counters must say that no producer has finished. This kernel writes the sentinel <code>-1</code> to each live counter. It does not transform a model tensor, but it prepares the scheduling state that makes the bottleneck's FFN, QKV and projection stages possible.</p><p>A counter is an <code>int32</code> element in a device allocation. A later producer advances a counter according to its own split protocol; a consumer polls for the required progress. Resetting to zero would falsely indicate progress for protocols whose first published index is zero. The exact sentinel is therefore part of the algorithm, not an arbitrary memset value.</p>'''
    body+=svg('Counter reset in the bottleneck dependency chain','0 0 900 220','''<rect class="storage" x="15" y="35" width="230" height="110" rx="8"/><text class="label" x="30" y="67">Previous invocation</text><text class="small" x="30" y="101">counter may look complete</text><path class="edge" d="M250 91 H312"/><rect class="compute" x="322" y="35" width="235" height="110" rx="8"/><text class="label" x="337" y="67">Clear: counter[i] = −1</text><text class="small" x="337" y="101">all live elements initialized</text><path class="edge" d="M562 91 H623"/><rect class="tensor" x="633" y="35" width="250" height="110" rx="8"/><text class="label" x="648" y="67">Producer / consumer</text><text class="small" x="648" y="101">new split progress begins</text><text class="small" x="20" y="188">Stream ordering must place the reset before any producer or polling consumer uses this array.</text>''')
    body+='''<h2 id="baseline">2. Start with the complete scalar algorithm</h2><p>For <code>i=0…CounterCount−1</code>, assign <code>counters[i]=-1</code>. There is no reduction and no dependence among those assignments. A simple CUDA implementation gives one element to each thread. This is the final strategy too: a more elaborate staging scheme would add synchronization without removing any required store.</p>'''
    body+=pseudo('for i in range(CounterCount):\n    counters[i] = int32(-1)', 'Reference initialization')
    body+='''<h2 id="address">3. Derive ownership and addressing</h2><p>The plan launches blocks of 256 threads and <code>ceil(CounterCount/256)</code> blocks. Thread <code>threadIdx.x</code> in block <code>blockIdx.x</code> owns <code>i=256×blockIdx.x+threadIdx.x</code>. The integer pointer conversion makes its byte address <code>g_Counters+4i</code>. Adjacent lanes therefore write adjacent four-byte counters. For 300 counters, block 0 writes indices 0…255 and block 1 lanes 0…43 write 256…299. Block 1 lane 44 owns 300 and returns before any access.</p><p>Unlike the repack kernels, this body has no grid-stride loop. The launcher must cover every live counter. A smaller grid would leave stale entries. A larger grid is safe within the validated index range because the upper-bound guard rejects excess threads. The <code>CounterCount</code> field counts elements, not bytes.</p>'''
    body+=code('csrc/kernel_impl/shared/common/completion_counter_clear.cu',1,12,'The complete reset body')
    body+=svg('Counter byte address and tail guard','0 0 900 230','''<rect class="tensor" x="15" y="30" width="270" height="130" rx="8"/><text class="label" x="30" y="62">block 1, lane 43</text><text class="small" x="30" y="94">i = 256 + 43 = 299</text><text class="small" x="30" y="126">address = base + 1196 bytes</text><path class="edge" d="M290 95 H350"/><rect class="storage" x="360" y="30" width="230" height="130" rx="8"/><text class="label" x="375" y="62">counter[299]</text><text class="small" x="375" y="94">0xFFFFFFFF (int32 −1)</text><text class="small" x="375" y="126">one global store</text><rect class="compute" x="620" y="30" width="260" height="130" rx="8"/><text class="label" x="635" y="62">block 1, lane 44</text><text class="small" x="635" y="94">300 ≥ CounterCount</text><text class="small" x="635" y="126">return; no address dereference</text><text class="small" x="20" y="201">No input tensor, shared allocation, register tile, matrix instruction or intra-block barrier.</text>''')
    body+='''<h2 id="ordering">4. Understand what makes the reset visible</h2><p>Each counter has one writer during this launch, so atomic stores are unnecessary. A block barrier would coordinate only threads in one block and would not order a subsequent kernel. The host enqueues this reset before the corresponding work on the CUDA stream; that launch dependency is the relevant ordering boundary. Across streams, the caller must establish an equivalent event or other dependency. Clearing a counter while an earlier invocation still uses it is a race.</p><p>The store travels from a thread's immediate/register value through the normal global-memory path. Hardware caches may service that path; the source neither reserves a cache line nor synchronizes consumers by relying on cache residence. The producer/consumer kernel's own release, acquire, fence and polling instructions are a separate protocol. This initializer does not substitute for any of them.</p>
<h2 id="rebuild">5. Reconstruct and integrate the kernel</h2><p>Use the exact ABI record in the appendix: a 64-bit device address, a 32-bit count, and reserved padding, totaling 16 bytes. Zero-initialize the record, bind a suitably aligned allocation large enough for <code>4×CounterCount</code> bytes, select the covering grid, and enqueue before its users. Do not substitute an 8-bit count or write floating-point negative one. The desired 32-bit bit pattern is all ones.</p>'''
    body+=pseudo('i = block.x * blockDim.x + thread.x\nif i >= CounterCount: return\nreinterpret_int32(g_Counters)[i] = -1', 'Final parallel algorithm')
    body+='''<h2 id="tests">6. Validate the sentinel and launch coverage</h2><ol><li>Use counts 1, 255, 256, 257 and 300. Fill the allocation with a different pattern, launch a covering grid, and check every live value is signed <code>-1</code>.</li><li>Put canaries after the live range. Verify the final partial block does not touch them.</li><li>Repeat after a simulated completed invocation has left nonnegative values. A fresh reset must remove all stale progress.</li><li>Check host launch ordering alongside the real consumer. A correct isolated reset cannot fix a cross-stream race or a consumer using the wrong counter array.</li></ol><p>The kernel is intentionally small. Its useful optimizations are coalesced stores, no unnecessary reads, and one guard at the tail. Combining it with another launch is only valid if the full dependency protocol still guarantees that every counter is initialized before any consumer can poll it. No new launch-overhead measurement is claimed here.</p>'''
    return dict(name=name,title='Completion-counter clear: initialize split progress',summary='Derive the sentinel, byte address, launch coverage and stream dependency of the small kernel that resets bottleneck scheduling state.',family='Scheduling',body=revise_counter(body))


def build_lessons(inventory):
    result=[]
    for name, entry in inventory['entries'].items():
        if name.startswith('repack_'):
            result.append(repack(name,entry))
        elif name=='completion_counter_clear':
            result.append(counter(entry))
    return result
