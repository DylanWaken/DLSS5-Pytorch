"""Twenty self-contained reconstruction lessons for C512 public CUDA entries."""
from html import escape
from pathlib import Path
from common import ROOT, code, svg, note
from lesson_support import pseudo, mma_primer, storage_legend

F='csrc/kernel_impl/shared_encoder_decoder_c512_ffn/'
P='csrc/kernel_impl/shared_encoder_decoder_c512_attention_ffn_projection/'
A='csrc/kernel_impl/shared_encoder_decoder_c512_attention/'
D='csrc/kernel_impl/encoder_c512_downsample/'
U='csrc/kernel_impl/decoder_c1024_to_c512_upsample/'
S='csrc/kernel_impl/shared/common/'


def cut(path, needle, count=18, before=0, caption=''):
    lines=(ROOT/path).read_text(encoding='utf-8').splitlines()
    i=next(i for i,line in enumerate(lines) if needle in line)
    start=max(1,i+1-before)
    return code(path,start,min(len(lines),start+count-1),caption)


def box(x,y,w,h,lines,kind='tensor'):
    fill,stroke={'tensor':('#e4f4ed','#247666'),'compute':('#e9efff','#5a6fa4'),
                 'storage':('#fff0d6','#a57425'),'accent':('#ffe6e0','#a95847')}[kind]
    parts=''.join(f'<tspan x="{x+w/2}" dy="{0 if i==0 else 22}">{escape(str(t))}</tspan>' for i,t in enumerate(lines))
    return f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="8" fill="{fill}" stroke="{stroke}"/><text x="{x+w/2}" y="{y+h/2-(len(lines)-1)*11+5}" font-size="15" text-anchor="middle" fill="#183244">{parts}</text>'


def line(x1,y1,x2,y2,text=''):
    import math
    a=math.atan2(y2-y1,x2-x1)
    p1=(x2-9*math.cos(a)+4*math.sin(a),y2-9*math.sin(a)-4*math.cos(a))
    p2=(x2-9*math.cos(a)-4*math.sin(a),y2-9*math.sin(a)+4*math.cos(a))
    return f'<path d="M{x1},{y1} L{x2},{y2}" stroke="#536a79" stroke-width="2"/><polygon points="{x2},{y2} {p1[0]},{p1[1]} {p2[0]},{p2[1]}" fill="#536a79"/>'+lab((x1+x2)/2,(y1+y2)/2-10,text,14,'middle')


def lab(x,y,text,size=16,anchor='start'):
    return f'<text x="{x}" y="{y}" font-size="{size}" fill="#183244" text-anchor="{anchor}">{escape(str(text))}</text>'


def graph(name,steps,caption):
    # Two rows avoid shrinking labels to fit a whole kernel in one horizontal line.
    parts=''
    for i,(heading,detail,kind) in enumerate(steps):
        row=i//3
        col=i%3 if row%2==0 else 2-i%3
        x=20+col*345;y=35+row*150
        parts+=box(x,y,300,105,[heading,*detail],kind)
        if i:
            prevrow=(i-1)//3
            prevcol=(i-1)%3 if prevrow%2==0 else 2-(i-1)%3
            px=20+prevcol*345;py=35+prevrow*150
            if prevrow!=row:parts+=line(px+150,py+105,x+150,y)
            elif x>px:parts+=line(px+300,py+52,x,y+52)
            else:parts+=line(px,py+52,x+300,y+52)
    return svg(name+' — model tensor graph',f'0 0 1060 {185 if len(steps)<=3 else 365}',parts,caption)


def matrix_diagram(name,k,n,fp8,warps,fragments,channels=64):
    e=1 if fp8 else 2; kin=32 if fp8 else 16
    parts=box(20,30,275,105,[f'A: 16 token rows × {kin}',f'{16*kin*e} bytes per warp stripe',f'{kin} reduction channels','each lane contributes 16 bytes'],'storage')
    parts+=line(295,82,360,82,'×')+box(360,30,280,105,[f'B: {kin} input × 8 outputs',f'{kin*8*e} bytes per MMA B tile','2 packed words per lane','global W → cached register load'],'storage')
    parts+=line(640,82,705,82,'+')+box(705,30,335,105,['D/C: 16 tokens × 8 outputs','4 Half values / lane = 2 words','two N8 operations build one N16','all lanes execute the MMA'],'compute')
    parts+=box(20,195,455,115,[f'CTA: {warps} warps; warp tile {16*fragments} × {channels}',f'Full matrix: {k} reduction channels → {n} outputs',f'{fragments} M16 fragments × {channels//16} N16 groups',f'Accumulator array: {fragments*channels//16*4} words/lane'],'compute')
    parts+=box(525,195,515,115,['Lane 13, N16 panel 2: channel pairs 34–35 and 42–43','Physical x = (13 / 4) % 4 = 3','Physical y = 13 / 16 + 2·rowHalf = 0 or 2','Four adjacent lanes collectively cover each N8 row'],'tensor')
    return svg(name+' — derive the matrix tile and lane ownership','0 0 1060 345',parts,'All divisions in address formulas are integer divisions. Channel numbers in the example are relative to the warp’s output-channel base.')


def memory_diagram(name,fp8,stages,stagebytes,iterations,kind='bulk',input_shape='tiled input',extra=''):
    ty='E4M3' if fp8 else 'Half';total=stages*(stagebytes+8)
    parts=box(20,30,250,100,[f'Global {input_shape}',f'{ty} bytes in native order','weights have separate allocation'],'storage')
    parts+=line(270,80,330,80,'copy')+box(330,25,360,110,[f'CTA shared: {total:,} bytes',f'{stages} stages × {stagebytes:,} bytes',f'barriers at {stages*stagebytes} + 8·slot','slot = iteration % stages'],'storage')
    parts+=line(690,80,750,80)+box(750,25,290,110,['Register A → MMA → Half C/D','W → __ldca → register B','current operands reused across N','final store after reduction'],'compute')
    parts+=lab(20,185,f'{iterations} reduction iterations; {"4-byte per-thread cp.async gathers" if kind=="gather" else "512-byte CopyBulk stripes"}.')
    for i in range(stages):parts+=box(20+i*(1000/stages),215,970/stages,82,[f'slot {i}: fill → wait → consume',f'refill with t+{stages} after old reads end'],'storage')
    parts+=lab(20,340,extra or 'A completed copy makes bytes ready; CTA arrival/wait coordinates their consumers and safe slot reuse.')
    return svg(name+' — storage and stage lifetime','0 0 1060 375',parts,'Cache policy describes requested paths, not measured hits. Register-oriented C++ arrays still require compiled resource inspection to rule out spilling.')


def publication_diagram(name,fp8,output='global native tile',branch='no intermediate image',plane=False):
    pub=['pack(w0,w2), pack(w1,w3)','combine a second N16 group','16 E4 bytes per lane / uint4'] if fp8 else ['uint4(w0,w1,w2,w3)','8 Half values per lane / uint4','N16 warp stripe = 512 bytes']
    parts=box(20,30,280,135,['Register Half N16 result','w0: low N8, upper rows','w1: low N8, lower rows','w2,w3: upper N8 channels','each word stores two Half'],'storage')
    parts+=line(300,95,360,95)+box(360,30,300,135,['Publication mapping',*pub],'compute')
    parts+=line(660,95,720,95)+box(720,30,320,135,[output,'4-byte words' if plane else '16-byte vector per lane','valid spatial locations only','shape unchanged by conversion'],'storage')
    parts+=box(20,225,1020,80,[branch,'Publication is an arithmetic/layout boundary; it need not imply a global-memory write.'],'accent')
    return svg(name+' — accumulator publication','0 0 1060 340',parts,'E4 conversion packs Half pairs into bytes. Half publication preserves the existing accumulator words. A channel-plane writer selects individual words rather than storing a whole uint4.')


def projection_graph(name,inputname,residual,final,typ,pool,outplane):
    parts=box(20,30,310,105,[inputname,'[H,W,512]',typ+' native input'],'tensor')
    parts+=box(375,30,310,105,['Projection weight matrix','[512,512]',typ+' packed matrix'],'storage')
    parts+=box(730,30,310,105,[residual,'independent [H,W,512] branch','512 learned Half scales'],'tensor')
    parts+=box(355,215,350,115,['Half accumulator C = scale × R','then ordered Input × W + C',final+'raw, one 8×8×256 CTA'],'compute')
    parts+=line(175,135,355,240,'Input A')+line(530,135,530,215,'matrix B')+line(885,135,705,240,'seed C')
    parts+=box(20,395,480,100,[final+' publication',('channel-plane pixel packets' if outplane else 'native tiled result'),typ+' output for the next model operation'],'storage')
    parts+=line(400,330,260,395)
    if pool:
        parts+=box(560,395,480,100,['Separate raw-value branch','pool four Half accumulator tiles → one 4×4 tile','publish pooled C512 for channel expansion'],'compute')
        parts+=line(660,330,800,395,'raw')
    else:
        parts+=lab(560,435,'The matrix input and residual are different tensors.')
        parts+=lab(560,465,'No extra residual-add launch is required.')
    return svg(name+' — projection and residual model branches','0 0 1060 525',parts,'The independent residual seeds C before the K reduction. A pooled variant forks from raw C/D before working-format publication.')


def numerical(fp8):
    return f'''<p>The working storage format on this page is <strong>{'E4M3 FP8' if fp8 else 'IEEE Half / FP16'}</strong>. Tensor-core accumulation, residual products, the recovered activation and the reduction trees discussed here use packed Half words. A <code>uint32_t</code> is a bit container for two Half values, not an integer approximation to their sum. <code>HalfMul</code>, <code>HalfAdd</code> and <code>HalfFma</code> preserve the source’s separately rounded operations; replacing them with FP32 expressions and a final cast changes that contract.{' E4 publication calls PackHalfPairsE4 on two Half2 words and produces four bytes. DecodeE4 performs the reverse operand preparation when a residual must participate in Half arithmetic. There is no scale tensor passed to those conversions.' if fp8 else ' The operand and accumulator use the same element type, but their lane-word arrangements still differ by matrix role. Equal dtype does not make an arbitrary row-major uint4 a valid MMA fragment.'}</p>
<p>Start with a high-precision scalar oracle to validate which input contributes to which output. Once the connectivity is correct, introduce a second oracle that follows the source’s K chunk order and publication points. A scalar FP32 sum is not a bitwise reference for Half MMA; it is a tool for catching transposes, wrong groups and wrong spatial coordinates. Keep these two correctness goals separate throughout reconstruction.</p>'''


def layouts(fp8,k,n,channel_base=64,tile=7,lane=13):
    e=1 if fp8 else 2;kin=32 if fp8 else 16
    off=tile*16*k*e+512+lane*16
    woff=kin*n*e+channel_base*32+lane*16+512
    return f'''<h2 id="layout">3. Derive byte addresses before writing the fast loop</h2>
<p>A native input tile represents sixteen positions in a physical 4 × 4 image patch. Its byte extent is <code>16·{k}·{e} = {16*k*e:,}</code>. Tile index q advances by that whole extent, an instruction-K stripe advances by 512 bytes, and lane l selects <code>16·l</code> bytes within the stripe. Thus one A load is <code>input + q·{16*k*e} + stripe·512 + lane·16</code>. For q={tile}, stripe=1 and lane={lane}, the base-relative address is <strong>{off:,} bytes</strong>. The lane reads one uint4 containing {'sixteen E4' if fp8 else 'eight Half'} values. These values are already arranged as a matrix operand; they are not simply consecutive channels of one pixel.</p>
<p>The weight record groups output columns into N16 panels and reduction channels into K{kin} instruction slices. Each instruction slice consumes {kin}·{e}=32 bytes per output column. Its lane-vector address is <code>W + reductionStart·{n}·{e} + outputChannel·32 + lane·16 + panel·512</code>. For reductionStart={kin}, outputChannel={channel_base}, panel=1 and lane={lane}, this is <strong>{woff:,} bytes</strong>. The panel term is relative to the warp’s output base. Adding a complete K slice advances {32*n:,} bytes, not 512: 512 advances N16, while {32*n:,} advances all {n} output columns.</p>
<p>Write a small host-side address decoder first. Give each logical input element a distinguishable value, encode a single native tile, and check exactly which token/channel arrives in each lane word. Repeat for one weight panel. This isolates layout errors from arithmetic errors: a wrong transpose can still produce plausible values for uniform inputs. In the kernel, all these pointer expressions use byte offsets because the public ABI passes integer addresses rather than typed multidimensional tensor views.</p>'''


def pipeline(path,fp8,stages,stagebytes,iterations,gather=False,decoder=False,prefill_all=False):
    return f'''<h2 id="pipeline">5. Overlap input movement without reusing live bytes</h2>
<p>The scalar baseline reloads input independently for each output. Our tiled version first shares an input stripe among output-panel computations. A synchronous prototype can copy a stage, execute a CTA barrier, consume every fragment, then execute a second barrier before overwriting the stage. That establishes correct producer/consumer ownership. The deployed kernel replaces the idle copy phase with a {stages}-slot ring. A slot holds {stagebytes:,} data bytes; its 8-byte barrier lives after all data slots, so the allocation is <code>{stages}·({stagebytes}+8) = {stages*(stagebytes+8):,}</code> bytes.</p>
<p>{'This entry gathers four-byte words from channel planes. CopyAsync4 emits cp.async.ca.shared.global, CopyCommit groups this thread’s outstanding copies, and CopyWait0 waits for that thread’s committed groups. The subsequent ArriveAndWait is still necessary: a lane consuming shared fragments depends on copies issued by other lanes. A per-thread copy wait by itself does not coordinate the CTA.' if gather else 'CopyBulk accepts a shared byte offset, a global address, byte count and barrier offset. On SM90+ it uses a bulk asynchronous copy with transaction-byte completion and an elected producer; BarrierExpect registers the expected bytes. On supported earlier targets the helper distributes 16-byte copies across warp lanes and attaches their completion to the mbarrier. BarrierExpect is then intentionally a no-op because that path does not use the transaction-byte mechanism.'} Initialize every stage barrier once with the full CTA arrival count, then synchronize before any copy can refer to it. An out-of-domain stripe is filled with zeros by its lane writers; those threads still join the barrier protocol.</p>
<p>{'The prologue loads W0, issues X0 and waits for slot zero. Iteration t issues X[t+1] into the other slot before consuming X[t]. It then prefetches W[t+1] and waits on the next slot. Every warp reaches that wait only after reading its current stage, so the later producer phase can recycle it. The final iteration skips both the nonexistent refill and the next wait.' if stages==2 and not prefill_all else f'The prologue loads W0, issues the first {stages} input stages and waits for stage zero. Iteration t reads slot t%{stages}, performs its MMA work, loads the next weights and waits for the next stage. Only then does it issue t+{stages} into the old slot. The intervening full-CTA arrival/wait establishes that all warps have finished the previous read phase before anyone recycles its storage. Preserve this order even if a local warp has already consumed its own fragment.'}</p>
<p>The {iterations} outer iterations stay rolled in the source, while spatial, N-panel and instruction-K fragment loops unroll. That lets fixed array indices select register values without expanding the entire long reduction into a huge instruction stream. More stages can hide more copy latency but consume shared memory; more fragments improve operand reuse but increase live registers. Those are the relevant tradeoffs, not a claim that a larger ring is always faster. <code>__maxnreg__</code> supplies a compiler limit, not an observed register count. Inspect generated resource reports and time representative shapes before changing either knob.</p>'''


def helpers(fp8):
    return f'''<h2 id="helper-contracts">The helper contracts needed to reconstruct this entry</h2>
<p><code>FMmaAccumulatorTile&lt;M,N&gt;</code> contains <code>[M][N][4]</code> 32-bit words per lane. Each N index means sixteen output channels, built from two N8 MMA instructions; it does not mean a sixteen-byte vector in logical row-major order. <code>AccumulateTile</code> takes an array of four-word A fragments and four-word weight bundles, uses the lower two B words for the first N8 result and upper two for the second, and updates the four Half2 words in place. When two instruction-K subtiles exist, it advances each accumulator through subtile zero before subtile one; the FP16 QKV stage supplies only one K16 subtile. The API’s by-value operands ensure an output update does not change the fragment arguments still being evaluated.</p>
{code(S+'tiled_mma.cuh',9,13,'The complete accumulator storage contract')}
<p><code>StoreNoAllocate</code> emits an aligned 128-bit global store with an L1 no-allocation request. <code>__ldca</code> loads weights with cache-all policy; residual readers may use <code>__ldcg</code>. These are memory-policy choices rather than barriers or promises that an access reaches a particular cache level. A correct implementation must separately satisfy the synchronization protocol and vector alignment. {'PackHalfPairsE4 changes both element width and which channel pairs occupy the low and high halves of a word. Its order is part of the layout; substituting any four E4 conversions without matching that order is incorrect.' if fp8 else 'Direct Half publication preserves the accumulator words, which is precisely why the next packed matrix operation can reuse them without an intermediate logical tensor transpose.'}</p>'''


def tests(items):
    return '<h2 id="checks">Reconstruction checks, in the order they isolate errors</h2><ol>'+''.join(f'<li>{item}</li>' for item in items)+'''</ol><p>These are concrete tests to implement when rebuilding the kernel, not claims that this documentation run executed GPU comparisons. First establish layout and numerical equivalence; then measure latency with the same weights, geometry, precision and stream behavior. A source-level eliminated allocation establishes avoided traffic, but it does not quantify the speedup or prove absence of register spills.</p>'''


def ffn(name,fp8,view):
    prec='fp8' if fp8 else 'fp16';typ='E4M3' if fp8 else 'Half';e=1 if fp8 else 2
    path=F+prec+'/'+name+'.cu';warps=4 if view or not fp8 else 8;frags=4 if warps==4 else 2
    steps=8 if fp8 else 16;reg=255 if not fp8 else (255 if view else 128)
    start='channel-plane' if view else 'native tiled'
    pseudo_block_0 = pseudo('for each position p:\n    u[0:512] = publish_operand(X[p,0:512] @ Wpre)\n    for group g in 0..7:\n        hidden[0:256] = activate(u[64*g:64*g+64] @ Wexpand[g])\n        h = publish_operand(hidden)\n        B[p,64*g:64*g+64] = publish_output(h @ Wcontract[g])','Scalar connectivity baseline; publish_operand follows the selected working precision')
    pseudo_block_1 = pseudo(f'CTA region = 8x8 positions; group = warp%4 + 4*gridZ\ninitialize 2 barriers for {warps*32} threads; synchronize\nload premix weights 0; stage input 0; wait\nprojected = Half zero\nfor t in 0..{steps-1}:\n    if another step: issue next input into other stage\n    load own A fragments; MMA into projected\n    if another step: load next W; arrive/wait next stage\noutput = Half zero\nfor hiddenPanel in 0..7:\n    hidden = Half zero\n    expand this group from published projected operands\n    apply recovered Half activation\n    contract published hidden operands into output\nfor each owned valid spatial tile:\n    publish output in native packed {typ} layout','Final kernel skeleton; every address and helper above supplies a concrete substep')
    body=f'''<h2 id="model">The model operation this kernel must implement</h2>
<p><code>{name}</code> implements the premix and grouped MLP portion of a C512 FFN. It receives {start} X with logical shape [H,W,512] and produces the contracted branch tensor B of the same shape. {'This is record 23’s entry, immediately after the C256 encoder transition; its input-view addressing is a central part of the kernel.' if view else 'This is the ordinary C512 path used where the input already has native 4 × 4 tile storage, within records 23–30 and 40–47 according to launch selection.'} At the documented 4K geometry H=68 and W=120. Its output still needs a separate 512→512 postmix and scaled residual before becoming the block’s FFN result. Neither attention nor that postmix is silently included here.</p>
<p>For one position p, compute <code>u[p,:] = X[p,:] Wpre</code>. Partition the 512 premixed channels into eight distinct slices <code>u[p,64g:64g+64]</code>. Group g computes <code>B[p,64g:64g+64] = φ(u_g Wexpand_g) Wcontract_g</code>, with matrices [64,256] and [256,64]. All eight groups execute. The first matrix is [512,512]; its purpose is to mix original channels before slicing. This differs from a full-input branch model: each grouped expansion reads only its own 64 premixed channels.</p>
{graph(name,[('X for one position',['512 channels',f'{typ} {start} storage'],'tensor'),('Dense premix',['512 → 512','all original channels mix'],'compute'),('Slice group g',['channels 64g…64g+63','eight different inputs'],'tensor'),('Expand + activation',['64 → 256','recovered Half polynomial'],'compute'),('Contract group',['256 → 64','concatenate, no group sum'],'compute'),('B published',['[H,W,512]',f'{typ} native tiled output'],'storage')],'The second FFN launch consumes B and original X to apply postmix and the learned residual. This page reconstructs only the named entry.')}
<h2 id="baseline">1. Build the simplest correct graph before tiling it</h2>
<p>A first implementation can materialize u, a [H,W,8,256] hidden tensor and B. Assign one scalar output element to a thread and sum its input channels. This makes the grouping unambiguous: contraction for group 3 must read group 3’s hidden values, not any other group. It also exposes the costs we will remove: writing and rereading the dense premix, materializing a four-times-expanded hidden tensor, and fetching the same input vector independently for each output channel.</p>
{pseudo_block_0}
{numerical(fp8)}
<h2 id="ownership">2. Tile output ownership so a group’s intermediates stay local</h2>
<p>A CTA covers one 8 × 8 position region and four groups. Grid Z selects groups 0–3 or 4–7, and group ownership is <code>(warp%4)+4·blockIdx.z</code>. The block is <code>(32,{warps})</code>. {'Each of four warps owns one group and four M16 fragments, so it covers all 64 positions. This input-view profile deliberately retains four warps even with E4 operands.' if view else ('Eight warps divide the region into upper and lower halves: warp/4 chooses the two-fragment row, while warp%4 chooses the group. Each warp therefore retains 32 positions × 64 outputs.' if fp8 else 'Four warps each own one group over all four M16 fragments. The whole 64-position region is retained by that group’s warp.')} This arrangement makes expansion and contraction warp-local once the premix finishes; no inter-warp hidden exchange is required.</p>
{matrix_diagram(name,512,512,fp8,warps,frags)}
{mma_primer(fp8)}
'''
    if view:
        body+=f'''<h2 id="layout">3. Fuse the input-view conversion into the shared-memory gather</h2>
<p>The incoming storage is [channel panel, y, x, 16-byte pixel packet], not a native tile sequence. Each panel contains {'sixteen E4' if fp8 else 'eight Half'} channels. A separate transpose baseline would read and write the whole image before any useful matrix multiply. Instead, each CTA constructs exactly the next 4 KiB native input stage with four-byte asynchronous gathers. There are 128 threads and eight word copies per thread: 1,024 words fill the complete stage.</p>
<p>Give each word the ordinal <code>j=warp·32+lane+copyIndex·128</code>. Source local y is <code>4(j/512)+(j/64)%2+2(j%2)</code>; local x is <code>4((j/256)%2)+(j/16)%4</code>. The source panel is <code>4t+2((j/128)%2)+(j/2)%2</code>, and the four-byte component is <code>(j/4)%4</code>. Add the CTA’s pixel origin to x/y, and form <code>X+((panel·H+y)·W+x)·16+4·component</code>. Store at <code>shared+4096(t%2)+4j</code>. The expressions are easier to verify as separate bitfield coordinates than as one giant pointer expression.</p>
<p>For j=13, t=0 and origin=(0,0), the gather uses y=2, x=0, panel=0 and component=3. At W=120 the global offset is <strong>3,852 bytes</strong>, and the shared offset is 52. The four copied bytes carry {'four E4 channels' if fp8 else 'two Half channels'}; the remainder of the stage gives the consumer its four spatial tiles and two instruction-K panels. Test this exact word before testing an entire matrix.</p>
{cut(path,'const int sl_Word',24,caption='Build a native MMA stage directly from the channel-plane input')}
<p>The premix weights remain packed matrix panels. Their address is <code>W+t·{64 if fp8 else 32}·512·{e}+group·2048+lane·16+kSubtile·16384+nPanel·512</code>. For group=2, lane=13, t=1, kSubtile=1 and nPanel=3, this gives <strong>{(64 if fp8 else 32)*512*e+4096+208+16384+1536:,} bytes</strong>. The 16 KiB instruction-K stride follows from 512 output channels times 32 packed bytes per output column. Input transposition and weight packing are independent layouts.</p>'''
    else:
        body+=layouts(fp8,512,512,128)
        body+=cut(path,'const uint64_t g_WeightTileBase',13,caption='Premix weight loads are direct lane vectors, not a second shared allocation')
    body+=f'''<h2 id="reuse">4. Compute premix once, then stream hidden panels</h2>
<p>For a single instruction-K step, an input A fragment is reused across four N16 output panels, and each weight B bundle is reused across the warp’s {frags} spatial fragments. That is the first improvement over scalar outputs: input and weight fetches pay for multiple independent MMA results. Four-word accumulators remain live across the full K=512 reduction. When it completes, they already represent the group’s 64 premixed channels in the order needed by the next multiply.</p>
{cut(path,'FMmaAccumulatorTile<Profile::SpatialFragments, 4> r_Projected',29,caption='Create the premix register tile and accumulate the input reduction')}
<p>The hidden tensor is the next expensive allocation. We do not need all 256 hidden channels at once: the contraction is a sum over them. Visit eight panels of 32 hidden channels, allocate only that panel’s accumulator, expand from the 64-channel group, activate it, and immediately add its contraction contribution to B. This keeps the complete premix slice and final output but only one hidden panel. The tradeoff is a longer lifetime for output accumulators; the benefit is removing the full hidden image write/read and the premix image write/read.</p>
<p>The packed record contains 262,144 premix elements, then eight 16,384-element expansions, then eight 16,384-element contractions. Group g’s bases are <code>(262144+16384g)·{e}</code> and <code>(393216+16384g)·{e}</code> bytes. For group 5 these are <strong>{344064*e:,}</strong> and <strong>{475136*e:,}</strong> bytes. Add lane·16 and the selected hidden/K/N panel offsets only after selecting that group’s matrix. This prevents the common bug of treating each group’s expansion and contraction as interleaved in the record.</p>
{cut(path,'const uint64_t g_Expand',13,caption='The packed premix / group expansion / group contraction record boundaries')}
<p><code>LoadWindowFfnInputFragment</code> converts accumulator ownership into A-operand ownership. {'It combines adjacent N16 accumulator groups into one K32 E4 fragment. Half2 words 0 and 2 are converted together, as are 1 and 3, so channel pairs rather than token halves are joined. This publication happens after the premix and again after activation, even though neither intermediate reaches global memory. The grouped E4 helper issues one K32 across its M/N tiles before advancing to the next K32.' if fp8 else 'It forwards words 0,1,2,3 from one N16 accumulator group directly as a K16 A fragment. Expansion reduces the group’s 64 channels in four K16 pieces; contraction uses two K16 pieces per 32-hidden panel. The common helper preserves K0-before-K1 within each result.'} The activation helper takes b=clamp(x,−4,4), then evaluates <code>x·(b·(−0.055908203125·abs(b)+0.447265625)+0.89453125)</code>. Its two inner FMAs and final multiplication use Half rounding; the final multiplication uses the original x, not the clamped b. It is not standard SiLU.</p>
{cut(path,'for (int HiddenTileIndex',min(46,179 if fp8 else 190),caption='One hidden panel is created, activated and contracted before the next is live')}
{pipeline(path,fp8,2,4096,steps,gather=view)}
{memory_diagram(name,fp8,2,4096,steps,'gather' if view else 'bulk',start+' X','After the premix, shared stages are dead; expansion and contraction use register operands and direct weight loads.')}
<h2 id="publish">6. Publish only the contracted branch tensor</h2>
<p>For native output tile q, group g and lane l, the first vector goes to <code>B+q·{8192*e}+g·{1024*e}+16l</code>. {'Two E4 vectors per lane cover the 64-channel group; each packs two N16 accumulator groups.' if fp8 else 'Four Half vectors per lane cover the 64-channel group, one per N16 accumulator group.'} For q=7, g=5 and l=13, the first vector address is <strong>{7*8192*e+5*1024*e+208:,} bytes</strong> from B. Clip spatial tiles before storing. Every valid output group is written by exactly one warp, so no atomic is necessary.</p>
{publication_diagram(name,fp8,branch='u and the 256-channel hidden tensor stay in registers; only B crosses the final global boundary.')}
{cut(path,'// Publish contracted',24,caption='The output address includes both spatial-tile and expert-group ownership')}
{helpers(fp8)}
<h2 id="rebuild">A complete reconstruction checklist in executable order</h2>
{pseudo_block_1}
{tests(['Pack an identity premix and group-distinguishing expansion/contract matrices; prove that group g reads only its own premixed 64 channels and that all eight output groups appear.',f'Validate the numeric input and output addresses above with a single nonzero token/channel; compare native storage with a decoded logical [H,W,512] view.', 'Run H=68,W=120 and a small multi-tile shape to exercise an incomplete 8×8 bottom edge; separately exercise the explicitly supported singleton-tile broadcast policy.',('Check the j=13 gather and every j=0…1023 mapping for uniqueness and complete stage coverage; distinguish zero-filled invalid words from valid channel-plane reads.' if view else 'Check both grid-Z group slabs and, for an eight-warp launch, both upper/lower spatial halves. Make every warp’s expected output visibly different.'),'Use values near Half and E4 rounding boundaries to test the premix-publication, post-activation-publication and final-publication locations. Do not validate only with ones.','Use synchronization checking when altering the copy loop; an input stage may be overwritten only after every participating consumer has finished.'])}
'''
    return body


def projection(name,fp8,mode):
    prec='fp8' if fp8 else 'fp16';typ='E4M3' if fp8 else 'Half';e=1 if fp8 else 2
    isffn=mode in ('ffn','ffn_input_view');inplane=mode=='ffn_input_view';outplane=mode=='attention_output_view';pool=mode=='attention_pool'
    stages=2 if pool else 3;warps=8 if mode=='attention' else 4;frags=2 if warps==8 else 4;steps=8 if fp8 else 16
    if mode in ('ffn','attention'):path=P+prec+'/spatial_projection_'+prec+'.cu'
    elif inplane:path=F+prec+'/'+name+'.cu'
    elif outplane:path=A+prec+'/'+name+'.cu'
    else:path=D+prec+'/'+name+'.cu'
    opname='FFN postmix' if isffn else 'attention output projection'
    inputname='contracted group tensor B' if isffn else 'attended head tensor A'
    residual='original block input X' if isffn else 'published FFN output Z'
    final='Z' if isffn else 'Y'
    boundary=('record 23, whose original block input uses a channel-plane view' if inplane else 'record 47, whose output must be a channel-plane view for the next decoder transition' if outplane else 'record 30, which saves the high-resolution skip and sends a pooled tensor toward C1024' if pool else 'ordinary C512 blocks in records 23–30 and 40–47, when their boundary roles do not select a specialized view or pooling entry')
    pseudo_block_0 = pseudo(f'for each valid position p and output channel n:\n    acc = rounded_half(R[p,n] * scale[n])\n    for k in source-defined instruction-K order:\n        acc = matrix_accumulate(acc, Input[p,k], W[k,n])\n    raw[p,n] = acc\n    {final}[p,n] = publish_{typ}(acc)'+('\nfor each 2x2 cell:\n    pool = HalfMul(HalfAdd(HalfAdd(TL,TR),HalfAdd(BL,BR)),0.25)\n    publish pool in native C512 storage' if pool else ''),'Baseline dependencies; matrix_accumulate represents the exact MMA numerical contract rather than a scalar FMA substitute')
    pseudo_block_1 = pseudo(f'CTA = 8x8 positions x 256 output channels; block = (32,{warps})\ninitialize {stages} stage barriers and synchronize\nload W0; issue input stages 0..{stages-1}; wait stage 0\nfor own spatial / N16 / N8 / row-half fragments:\n    read '+('plane-view' if inplane else 'native-tiled')+f' residual; decode if needed\n    accumulator = HalfMul(residual, Half scale)\nfor t in 0..{steps-1}:\n    load A vectors from shared slot t%{stages}\n    AccumulateTile: ordered K subtiles into residual-seeded Half words\n    if next: prefetch W[t+1]; wait input[t+1]\n    if t+{stages} exists: refill old slot with input[t+{stages}]\npublish valid output as '+('channel-plane words' if outplane else 'native tile vectors')+('\npool four raw spatial fragments; publish valid pooled native tile' if pool else ''),'Complete schedule for this public projection entry')
    body=f'''<h2 id="model">The precise model suboperation: {opname}</h2>
<p><code>{name}</code> consumes the {inputname}, logically [H,W,512], applies a dense [512,512] channel matrix, and combines a separate learned 512-channel residual scale with the {residual}. Its role is {boundary}. At the documented 4K input the C512 field is [68,120,512]. Every output position mixes channels from the same position; the projection itself does not read spatial neighbors. {'The pooling suffix adds a spatial 2×2 reduction after that projection.' if pool else 'Any earlier attention or grouped MLP work has already produced the input tensor.'}</p>
<p>Write its graph as <code>{final}raw[p,n] = Σk Input[p,k]·W[k,n] + scale[n]·R[p,n]</code>, then publish {final} in {typ}. R is specifically the {residual}, not the projection input. {'Also compute Pool[y,x,n] = publish(average2x2(Yraw)[y,x,n]); save published Y for decoder record 39.' if pool else ''} The formula describes connectivity. The implementation seeds its accumulator with the rounded scaled residual <em>before</em> accumulating K, which defines a more specific numerical sequence than evaluating the sum and adding a residual afterward.</p>
{projection_graph(name,inputname,residual,final,typ,pool,outplane)}
<h2 id="baseline">1. Start from a scalar projection plus its exact residual branch</h2>
<p>A straightforward first kernel assigns one (pixel,output-channel) pair to a thread, loads 512 inputs and weights, forms a dot product, scales the residual and writes the result. This is an easy correctness baseline but repeats input loads for every output and exposes little reuse. {'A second baseline kernel could then read a high output and pool it. That is numerically wrong for E4 if it pools the published bytes instead of preserving Yraw; a correct unfused baseline must preserve the raw Half result separately.' if pool else 'A separate residual-add baseline is also possible, provided its arithmetic is explicitly matched later; it would add an extra read/write pass over the result.'} The reconstruction will remove those extra passes by putting the scaled residual into C before matrix multiplication.</p>
{pseudo_block_0}
{numerical(fp8)}
<h2 id="ownership">2. Give each warp a rectangular matrix result</h2>
<p>One CTA owns an 8 × 8 position region and 256 output channels. Let <code>columns=ceil(W/8)</code>. The spatial X tile is <code>2·(blockIdx.x%columns)</code>, while <code>blockIdx.x/columns</code> selects the 256-channel slab. Warp channel base is <code>256·slab+64·(warp%4)</code>. There are two channel slabs to cover all 512 outputs. {'Eight warps split the region’s upper/lower halves using warp/4, so each owns two M16 spatial fragments and 64 channels.' if warps==8 else 'Four warps each own 64 channels over all four M16 spatial fragments. This full-window ownership is useful here because '+('each warp must pool its four projected spatial tiles.' if pool else 'the per-pixel view conversion can be performed directly from all its tile accumulators.' if inplane or outplane else 'the FFN postmix retains four spatial tiles per output group.')} The public block shape is (32,{warps}); do not choose a different warp count while retaining these coordinate formulas.</p>
{matrix_diagram(name,512,512,fp8,warps,frags)}
{mma_primer(fp8)}
{layouts(fp8,512,512,128)}
<h2 id="residual">4. Place the residual in accumulator order before the reduction</h2>
<p>The packed record holds <code>512·512·{e} = {262144*e:,}</code> matrix bytes, followed by 512 Half scale values, another 1,024 bytes. For an output channel c, the scale address is <code>W+{262144*e}+2c</code>. Four lanes cooperate on an N8 row; each lane reads the two scale values corresponding to its channel pair, then uses the same pair for both row halves. Scales remain Half even when the large matrix uses E4. This small but essential mixed-precision field makes “every byte in an FP8 weight record is FP8” an incorrect assumption.</p>
{cut(path,'uint32_t r_ResidualScales',14,caption='The scale address selects output channels independently of the matrix K coordinate')}
'''
    if inplane:
        plane=10 if fp8 else 21;offset=((plane*68+4)*120+11)*16+4
        body+=f'''<p>This entry’s “input view” applies to R, the original block input. The projection input is already the native tiled branch tensor produced by the grouped FFN. R has address <code>((panel·H+y)·W+x)·16+4(lane&amp;3)</code>, with panel width {'16' if fp8 else '8'} channels. Derive pixel y from tileY·4+lane/16+2·rowHalf and x from tileX·4+(lane/4)%4. For tileY=1,tileX=2,lane=13,rowHalf=0, the pixel is (y,x)=(4,11). With output base=128,N16 panel=2,upper N8 and H=68,W=120, panel={plane} and the residual word starts at <strong>{offset:,} bytes</strong>.</p>
<p>{'Both N8 halves share one sixteen-channel E4 pixel panel. The source loads a four-byte word then shifts by 16·N8 before DecodeE4, selecting two E4 values for the Half2 accumulator pair. The byte displacement alone does not identify all selected channels; the shift is part of the address-to-value mapping.' if fp8 else 'Each N8 half occupies its own eight-channel Half pixel panel. The loaded four-byte word is already the Half2 pair that can be multiplied by the scale. Row-half words select distinct pixel rows, not a second channel panel.'} Keeping this gather inside the residual seeding removes a whole-image view conversion. It adds address arithmetic and smaller loads to this kernel; it does not change which model tensor R represents.</p>
{cut(path,'const int g_PixelY',25,caption='The specialized plane-view residual gather and accumulator seeding')}
'''
    else:
        body+=f'''<p>R is a native C512 tile allocation. Select a tile using the same spatial ownership as the output, then the warp’s 64-channel group. The first vector is at <code>R+tileIndex·{8192*e}+outputChannel·{16*e}+lane·16</code>. {'Decode E4 low/high halfwords into four Half2 accumulator words in the correct N8/row-half order, then multiply by the matching scale pair.' if fp8 else 'Load the four Half2 words and multiply words 0/1 by the lower-N8 scale pair and words 2/3 by the upper-N8 pair.'} This initializes every accumulator word; leaving even one uninitialized would corrupt an entire lane-owned channel pair across the K loop.</p>
{cut(path,'const uint64_t g_ResidualTileBase',28,caption='Read the correct independent residual tensor and seed the GEMM')}
'''
    body+=pipeline(path,fp8,stages,4096,steps,prefill_all=True)
    body+=memory_diagram(name,fp8,stages,4096,steps,input_shape=inputname,extra=f'{warps} warps reuse staged Input; scaled residual and accumulated results stay in registers through all {steps} K steps.')
    body+=cut(path,'// Keep K sequential',26,caption='Prefetch weights, wait for the next stage, then recycle the old stage')
    body+='''<p>Notice what does not enter shared memory: the weight fragments and the residual accumulator. Weights are fetched as lane vectors and reused across the warp’s spatial fragments. The input stage is shared because several output-group warps need those same bytes. This asymmetry is the optimization: stage the operand with cross-warp reuse, keep independent output ownership in registers, and choose weight cache policy without inventing a second staging ring. It also explains why doubling shared memory for weights is not an automatically beneficial change.</p>'''
    if pool:
        body+=f'''<h2 id="specialization">6. Retain raw output for a second consumer: 2 × 2 pooling</h2>
<p>The first output is the published high-resolution C512 skip. The second is a native tiled pooled C512 tensor. The kernel keeps the four raw projected spatial tiles in registers while writing the skip, then constructs one pooled 4 × 4 tile. In the 4K geometry [68,120] halves to [34,60], and the next-level field pads this to [36,60]. Bound checks and zero-filled synthetic input tiles create the padded rows; do not average already-published skip bytes to recreate them.</p>
<p><code>PoolHorizontalWords</code> first routes the left/right tile and row-half words by lane bits, swaps lane bits 2 and 3, then gathers four neighbor words through source-lane XOR 0,4,16,20. It performs exactly three Half additions and a Half quarter multiply, ordered as (TL+TR)+(BL+BR). This helper exchanges values within the warp, not through a shared pooled image. {'Only after that Half average does this entry convert to E4, so raw-pool fusion preserves a numerical boundary as well as removing traffic.' if fp8 else 'The Half output words can be stored directly, but the averaging tree still matters because reassociation changes rounding.'}</p>
{code(S+'window_pool.cuh',7,40,'The full pooling shuffle network and its non-reassociated Half arithmetic')}
{cut(path,'// Pool the unquantized',24,caption='The raw projection branch remains alive after the high-output publication')}
{graph(name+' pool',[('Raw top-left tile',['16 pixels × 64 channels','warp-local Half accumulators'],'storage'),('Raw top-right tile',['paired by shuffle routing','XOR 4 reaches X neighbor'],'storage'),('Gather 2 × 2 neighbors',['XOR 16/20 reaches Y neighbor','Half pair keeps two channels'],'compute'),('Rounded average',['(TL+TR)+(BL+BR)','then Half × 0.25'],'compute'),('Pooled 4 × 4 tile',[f'{typ} publication','pad field to [36,60,512]'],'storage'),('High skip already stored',['[68,120,512]','separate model consumer'],'tensor')],'Both outputs are produced from the same projected values, but the pooled consumer receives them before final working-format publication.')}
'''
    elif outplane:
        body+=f'''<h2 id="specialization">6. Write the destination view directly from accumulator words</h2>
<p>The destination is a channel-plane view, selected specifically at record 47 so the C512→C256 decoder transition can gather spatial pixels. A baseline would publish native tiles and then run a tensor-layout conversion. This kernel eliminates that intermediate write/read by choosing the final address separately for each row-half word. For tile coordinates ty,tx, pixel y is <code>4ty+lane/16+2·rowHalf</code> and x is <code>4tx+(lane/4)%4</code>. The word address is <code>output+((panel·H+y)·W+x)·16+4(lane&amp;3)</code>.</p>
<p>{'Each N16 group is one E4 channel panel. Pack the lower and upper N8 Half pairs for the same pixel into one four-byte word. Do not combine different row halves: that would mix two y coordinates within a pixel packet.' if fp8 else 'Each N16 group is two N8 Half channel panels. Word 0/1 selects the lower-N8 panel at the two y coordinates; word 2/3 selects the upper panel. The two panel halves are separated by an entire H×W×16-byte plane.'} For lane=13,tile=(1,2),rowHalf=0, output base=128 and N16 group=2, the lower-N8 panel is {10 if fp8 else 20}. With H=68,W=120 its word offset is <strong>{(((10 if fp8 else 20)*68+4)*120+11)*16+4:,} bytes</strong>. Verify this address independently before attempting a full image.</p>
{cut(path,'const int g_PixelY',23,caption='Per-word output-plane addressing fuses the final layout conversion')}
'''
    else:
        body+=f'''<h2 id="specialization">6. Finish with native tiled publication</h2>
<p>The output keeps native C512 tile storage. For spatial tile q, output-channel base c and lane l, the first vector is <code>output+q·{8192*e}+c·{16*e}+16l</code>. With q=7,c=128,l=13 that is <strong>{7*8192*e+128*16*e+208:,} bytes</strong>. {'The writer packs two adjacent N16 groups into each E4 uint4 and emits two vectors for the warp’s 64 channels.' if fp8 else 'The writer emits four Half uint4 vectors, one for each N16 output group.'} Two channel slabs and the warp ownership formulas make every valid output pair unique; no atomic accumulation or inter-CTA reduction is involved.</p>
<p>{'The original plane-view residual is no longer needed after seeding. The output switches to native tile order, which means the following QKV kernel can use 512-byte input stripes rather than repeating the channel-plane gather.' if inplane else 'The next model consumer can load the same native fragment order directly, so a separate BHWC tensor is unnecessary between the two operations.'} Only real spatial tiles are stored. The source resolver broadcasts a singleton native tile dimension for reading but still clips publication to the real output domain; general incomplete edges use zeros. Reading and writing do not have identical boundary rules.</p>
{cut(path,'// Write each projected',25,caption='Store only valid output tiles after all input channels have contributed')}
'''
    body+=publication_diagram(name,fp8,'global channel-plane view' if outplane else 'global native C512 tile','The residual seed stays live through the entire reduction; '+('raw output is also retained for pooling.' if pool else 'only the completed projected result is published.'),outplane)
    body+=helpers(fp8)
    body+=f'''<h2 id="rebuild">Final reconstruction, preserving every lifetime</h2>
{pseudo_block_1}
{tests([f'Use zero W and distinguishable R/scale channels: the output must be the correctly published scaled {residual}, not a scaled copy of the projection input.','Use identity W with zero residual scales to prove the 512-channel projection and byte layout independently. Then test a non-diagonal permutation to detect K/N transposes.','Use one nonzero lane-owned channel at a time, including both N8 halves and both row halves; validate the numeric address example and both 256-channel slabs.',('Use an asymmetric 2×2 patch such as 1,2,3,8 to check neighborhood routing, then adversarial Half values to check the exact averaging tree; verify the [34,60] valid region and padded [36,60] field.' if pool else 'Exercise H=68,W=120, the last native tile row, and any supported singleton tile case. Compare every published position with decoded logical output.'),('Compare direct output-plane publication against an independently decoded native result, including plane boundaries and row-half y offsets.' if outplane else 'Verify residual plane-gather coverage separately from branch-input native tile coverage.' if inplane else 'Check residual seeding with near-rounding-boundary values; adding the residual after the dot product is not a valid bitwise substitute.'),'Vary CTA scheduling and run a synchronization checker after any change to stage recycling. Confirm the final iteration neither waits on nor loads a nonexistent K panel.'])}
'''
    return body


def qkv(name,fp8):
    prec='fp8' if fp8 else 'fp16';typ='E4M3' if fp8 else 'Half';e=1 if fp8 else 2
    path=A+prec+'/'+name+'.cu';stage=4096 if fp8 else 2048;steps=8 if fp8 else 32
    pseudo_block_0 = pseudo('for each window and head h:\n    Qraw,Kraw,Vraw = project every window token from all 512 channels\n    Q = publish(normalize32(Qraw) * headScale[h])\n    K = publish(normalize32(Kraw)); V = publish(Vraw)\n    for query i in 0..63:\n        for key j in 0..63:\n            scores[j] = bias[h,i,j] + dot32(Q[i],K[j])\n            weights[j] = recovered_exponential(scores[j])\n        P = publish(weights / sum_in_source_order(weights))\n        A[i] = publish(sum_over_keys(P[j] * V[j]))\n    publish only real image query positions','Connectivity baseline; norm, exponential and publication helpers are defined below')
    pseudo_block_1 = pseudo(f'CTA window origin = phase-shifted 8x8 region; head=4*gridZ+warp\ninitialize two barriers for 128 threads\nproject all 512 channels into 4x6 N16 Half QKV fragments\n    use {steps} input stages, {stage} bytes/stage; ping-pong with next input\nfor each of four spatial tiles:\n    reinterpret Q/K/V accumulator groups\n    normalize Q; multiply head scale; publish Q\n    normalize K; publish K\n    transpose V for B role; publish V\n'+('for query pair (0,1), then (2,3):\n    seed both score panels with bias; accumulate QK^T\n    paired row-sum transpose, reciprocal and broadcast\n' if fp8 else 'for query tile 0,1,2,3:\n    seed score panel with bias; accumulate QK^T\n    ordered Half row sum and reciprocal\n')+f'    publish P as {typ}; accumulate P*V in Half\n    publish attended rows and store only in-field query tiles','Reconstruction skeleton with the entry-specific score schedule')
    body=f'''<h2 id="model">The model operation: QKV and complete local attention</h2>
<p><code>{name}</code> consumes published C512 FFN output Z and produces attended features A, both logically [H,W,512]. It is used in C512 records 23–30 and 40–47. At 4K H=68,W=120. The kernel contains the [512,1536] QKV projection, sixteen 32-channel heads, separate Q/K channel normalization, per-window score normalization, and probability-times-value. It does <em>not</em> contain the later C512 head-mixing projection or attention residual. The model’s complete attention operation therefore spans this entry and a subsequent projection entry.</p>
<p>Within one 8 × 8 window/head, Q,K,V each have shape [64,32]. Q and K are independently L2-normalized across their 32 channels, Q receives its learned head scalar, and V bypasses normalization. Scores are <code>S=QKᵀ+bias</code>, shape [64,64]. Compute <code>P[i,j]=E(S[i,j])/Σk E(S[i,k])</code>, then <code>A=PV</code>. E is the recovered clamped exponential surrogate, not exp(score−maximum) from a standard softmax implementation. Unlike global C1024 attention, this local Q path has no extra √32 factor and no correction removing padded key slots from the denominator.</p>
{graph(name,[('Z within one window',['64 tokens × 512 channels',typ+' global native tiles'],'tensor'),('QKV pointwise projection',['512 → 1536','head h gets Q,K,V: 32 each'],'compute'),('Normalize Q and K',['channel norm per token','Q × learned head scale'],'compute'),('Scores for one head',['[64,32] × [32,64] + bias','[64,64] logical weights'],'compute'),('Normalize over 64 keys',['surrogate E / row sum',f'publish P as {typ} operands'],'compute'),('P × V and publish',['[64,64] × [64,32]','join sixteen heads as C512'],'storage')],'The implementation retains only current query score panels in registers; the diagram’s full score shape is a logical dependency, not a global allocation.')}
<h2 id="baseline">1. A deliberately materialized attention baseline</h2>
<p>Begin with separate kernels for QKV, Q/K normalization, scores, normalization and P×V. This gives explicit tensors that are easy to inspect. Use a single window and one head first, giving every token a recognizable channel vector. The cost is substantial intermediate traffic: QKV has three times the input channel count, and each head’s score tensor contains 4,096 values. Fusion will replace these intermediate allocations with warp register tensors, but only after their indexing and quantization points are established.</p>
{pseudo_block_0}
{numerical(fp8)}
<h2 id="ownership">2. Put an entire head/window inside one warp</h2>
<p>A CTA has four warps and one phase-dependent 8 × 8 window. Warp w owns head <code>h=4·blockIdx.z+w</code>; four grid-Z slabs cover all sixteen heads. Its six N16 projection panels are Q-low,Q-high,K-low,K-high,V-low,V-high, over four M16 spatial fragments. Because all 64 Q/K/V positions for that head belong to this warp, attention requires only register reuse and shuffles after the QKV reduction. Assigning one token per warp would instead force expensive exchange to reach the other 63 keys.</p>
<p>The origin in each axis is zero or −4 according to the window phase. TileY is <code>(8·blockIdx.y+OriginY)/4</code>, tileX is the analogous X expression. Four native 4 × 4 tiles make the window. For the first phase-1 CTA, the origin is (−4,−4); only its lower-right native tile is inside the field. Inputs outside the field become zeros, but all 64 key slots still participate in local normalization. Store clipping removes only invalid query positions. This is padding and cropping, not a cyclic image roll.</p>
{matrix_diagram(name,512,1536,fp8,4,4,96)}
{mma_primer(fp8)}
{layouts(fp8,512,1536,192)}
<p>The actual QKV stage packs {'two K32 input stripes for every spatial tile, so one stage advances 64 channels' if fp8 else 'one K16 input stripe for every spatial tile, so one stage advances 16 channels'}. Its weight head base is <code>head·3072</code>, since 96 head-local output channels each occupy 32 packed bytes per instruction-K slice. The N16 panel stride is 512 bytes. {'The second K32 inside a stage adds 49,152 bytes, which is 1536×32.' if fp8 else 'There is only one instruction-K slice in a stage; the next K16 reduction iteration advances 49,152 bytes.'} Do not substitute the two-K Half schedule used by other C512 matrix entries: this named QKV entry has its own blocking.</p>
{cut(path,'const uint64_t g_WeightTileBase',13,caption='The six adjacent Q/K/V panels and their packed K/head offsets')}
<h2 id="bias-layout">4. Give bias and head scales their own precision/address contracts</h2>
<p>The matrix occupies <code>3·512·512·{e} = {786432*e:,}</code> bytes. It is followed by sixteen 8,192-byte Half bias tables, each representing [64 query,64 key] values in packed fragment order. The head scales follow those tables as sixteen four-byte floating values. QKV conversion loads a scale’s float bits and rounds it to replicated Half2 for the normalization multiply. Thus the record contains {'E4 matrix bytes, Half bias and float head scales' if fp8 else 'Half matrix/bias values and float head scales'} rather than one uniform scalar type.</p>
<p>For query tile q, key tile j, head h and lane l, the bias vector is at <code>W+{786432*e}+8192h+2048q+512j+16l</code>. With h=2,q=1,j=3,l=13, the byte offset is <strong>{786432*e+20176:,}</strong>. The scale for head 2 is at <strong>{786432*e+131080:,}</strong>. Seed score accumulators with bias before adding QKᵀ; the Half rounding order depends on that placement. K and V use matching recovered physical key order, and bias columns are already packed to match it.</p>
{pipeline(path,fp8,2,stage,steps)}
{memory_diagram(name,fp8,2,stage,steps,input_shape='Z (published FFN)',extra='After QKV, all further Q/K/V/score work is warp-local; the final attended tensor is the next global write.')}
{cut(path,'// Native Half uses',20,caption='The concrete QKV reduction loop uses the entry-specific stage/K dimensions')}
<h2 id="normalization">6. Turn projected Half words into normalized operand fragments</h2>
<p>The QKV result is <code>r_Projected[4][6][4]</code> words per lane. Assign pairs of N16 groups to three [32-channel] accumulator views; this is a register rearrangement, not a global transpose. For a token, four adjacent lanes collectively hold all 32 channels. In each lane, four Half2 words represent channel pairs offset by 8. The norm helper squares upper channels first, fuses lower-channel squares into them, combines column groups, then uses XOR-2 and XOR-1 shuffles across the four lanes.</p>
<p>Swapping the packed Half components and adding makes a replicated scalar squared norm. Clamp it to Half epsilon <code>0x0410 = 0.00006198883056640625</code>, convert one Half to float, evaluate approximate reciprocal square root, round that inverse to Half2, and multiply each channel pair. Q then multiplies its learned scale. The helper <code>NormalizeWindow&lt;true&gt;</code> applies the scale; <code>&lt;false&gt;</code> does not. This reduces channels, not tokens or heads. A generic LayerNorm, RMSNorm or four-warp reduction would implement a different operation.</p>
{code(S+'warp_window32.cuh',161,191,'Norm helper: exact Half square/reduction tree and learned query scale')}
<p><code>PublishWindow32</code> now gives Q/K the {'one K32 E4 fragment' if fp8 else 'two K16 Half fragments'} required by score MMA. V must become a B operand rather than A: <code>TransposeM8n8</code> transposes each packed Half word using the warp matrix-transpose instruction. {'The two transposed row halves are then converted together into one E4 word.' if fp8 else 'The two transposed row halves remain two Half words.'} Keeping Q/K/V in registers removes their large global write/read, but the warp now has a substantial live fragment set; that register footprint is the main fusion tradeoff.</p>
{cut(path,'NormalizeWindow<true>',14,caption='Normalize Q/K and change V’s matrix role before score computation')}
<h2 id="attention">7. Stream query panels through scores, denominator and values</h2>
<p>For sixteen query rows, allocate eight N8 score columns, covering all 64 keys. The score accumulator is 16×64 Half values distributed as sixteen words per lane. Bias seeds these words. Score MMA consumes the query and each key tile in {'one K32 chunk' if fp8 else 'two K16 chunks'} because head width is 32. The exponential helper computes a Half FMA with slope <code>0.044921875</code> and intercept <code>1.30078125</code>, clamps to <code>[1.03125,1.5693359375]</code>, then evaluates <code>(packedClampedBits&lt;&lt;5)+0x7ff88000</code> with 32-bit wraparound. The denominator uses the same Half epsilon <code>0x0410</code> before its reciprocal. Keep that whole-word operation: independent shifts of the two halfwords alter carry behavior.</p>
{code(S+'warp_window32.cuh',194,203,'The recovered attention exponential is an exact packed operation, not library exp')}
'''
    if fp8:
        body+='''<p>This E4 entry uses a paired-query schedule. It produces two adjacent sixteen-query panels, then <code>SoftmaxWindowPair</code> normalizes their 32 logical rows together. An independent-panel baseline repeats each denominator reciprocal in four lanes. The paired schedule instead transposes four row-half partial vectors so each lane owns one complete row sum, computes one reciprocal there, and shuffles it back to the four lanes holding that row’s score fragments. This saves duplicate scalar inverse work without changing the key contribution order.</p>
<p>The transpose first permutes the four local partial words by lane&amp;3. Its source lane is <code>((lane&amp;7)&lt;&lt;2)|(lane&gt;&gt;3)</code>, and four XOR-indexed gathers collect the contributors. A second permutation restores contributor order 0,1,2,3 before Half addition. Lane 13 uses base source 21 and owns logical row 13. After the reciprocal, vector r at an original lane fetches inverse from <code>8r+lane/4</code>. This is an ownership transformation for row sums, not a change in the score matrix’s mathematical axes.</p>'''
        body+=code(S+'warp_window32.cuh',282,310,'Transpose denominator ownership while preserving the native Half sum order')
        body+=cut(path,'for (int r_FirstTile',23,caption='Two query tiles are scored, normalized and applied to values together')
    else:
        body+='''<p>This Half entry processes q0,q1,q2,q3 through <code>AttendWithBias</code> one at a time. <code>SoftmaxWindow</code> computes the local sums from pairs of N8 columns, then gathers the four lanes sharing a row. It adds lane 0 and lane 1, then lane 2, then lane 3, then combines the two Half components. This intentionally differs from the XOR butterfly used for the channel norm. Compute the reciprocal from the clamped replicated Half sum, round back to Half and multiply every score pair.</p>
<p>The single-query-panel design needs sixteen score words per lane at a time. Retaining multiple panels could expose more independent work but would increase register pressure and require a different denominator ownership schedule. Reconstruct this entry’s explicit panel sequence first. Source-level similarity between Q/K normalization and attention normalization does not justify merging their reduction helpers: their axes and addition orders differ.</p>'''
        body+=code(S+'warp_window32.cuh',206,238,'Half single-panel denominator reduction and normalization')
        body+=cut(path,'const auto r_AttendedTile',15,caption='One query tile is attended and published at a time')
    body+=f'''<p>Publication of P is another explicit boundary: normalized Half scores become {'E4 K32' if fp8 else 'Half K16'} A operands before P×V. The reduction now spans 64 key positions, requiring {'two K32' if fp8 else 'four K16'} chunks. <code>ProbabilityValues</code> or the equivalent inner portion of <code>AttendWithBias</code> extracts the matching transposed V words as B fragments. The result is sixteen queries ×32 channels. It stays Half until final publication; there is no global P image.</p>
{graph(name+' attention',[('Query panel',['16 query rows × 32 channels',f'{typ} register A operands'],'storage'),('All four key tiles',['64 candidates × 32 channels','bias seeds Half scores'],'storage'),('Score panel',['16 × 64 Half values','16 words per lane'],'compute'),('Row normalization',[('32 rows paired; one inverse/lane' if fp8 else '16 rows; ordered four-lane gather'),'packed exponential + reciprocal'],'compute'),('Published probability',['16 × 64 '+typ,'reduce across 64 key positions'],'tensor'),('P × V result',['16 × 32 Half values','publish only real query tiles'],'compute')],'Head width reduction and key-position reduction are different K axes, even though both use the same tensor-core wrapper.')}
<h2 id="publish">8. Return the attended head panels to global tile storage</h2>
<p>For native spatial tile q, head h, chunk r and lane l, output is <code>A+q·{8192*e}+h·{512*e}+512r+16l</code>. {'There is one E4 fragment per 32-channel head.' if fp8 else 'There are two Half fragments per 32-channel head.'} With q=7,h=2,r=0,l=13, the first vector starts at <strong>{7*8192*e+2*512*e+208:,} bytes</strong>. Heads write disjoint channel regions and windows write disjoint real query tiles for the selected phase. Clip both negative and upper tile coordinates; do not allow the zero-padded query slots to write before the allocation.</p>
{publication_diagram(name,fp8,branch='Q/K/V and current score panels remain registers; only the attended C512 tensor is stored globally.')}
{helpers(fp8)}
<h2 id="rebuild">The entire fused kernel, now derived</h2>
{pseudo_block_1}
{tests(['With zero Q/K matrices, use varying bias and V to verify the recovered exponential and normalized value weighting independently of projection.','With distinct head scales, distinguish every one of sixteen heads and both N16 halves of Q/K/V; confirm Q receives scale while K and V do not.','Test all four origin phases, especially the first shifted window and H=68’s incomplete final 8×8 row. Padded keys remain in the local denominator.','Trace one lane-owned norm using asymmetric channel magnitudes; compare its source-ordered Half sum and reciprocal-square-root path. Uniform vectors conceal channel permutation mistakes.',('For the paired path, give all 32 query rows different denominators, then verify lane 13 and the 8r+lane/4 reciprocal broadcast. Test the second pair separately.' if fp8 else 'Give each of four query tiles different scores; prove that single-panel temporaries do not accidentally retain bias or accumulators from the prior query tile.'),'Use rounding-sensitive probabilities to prove P is published before P×V, and compare decoded global output against the independently reconstructed head tensor.'])}
'''
    return body


def channel(name,fp8):
    prec='fp8' if fp8 else 'fp16';typ='E4M3' if fp8 else 'Half';e=1 if fp8 else 2
    path=D+prec+'/'+name+'.cu';steps=8 if fp8 else 16;step=64 if fp8 else 32
    pseudo_block_0 = pseudo('for each low-resolution position p:\n    for output channel n in 0..1023:\n        acc = 0\n        for input channel k in 0..511:\n            acc += X[p,k] * W[k,n]\n        Y[p,n] = publish(acc)','Scalar connectivity baseline; exact Half MMA accumulation is introduced after indexing is verified')
    pseudo_block_1 = pseudo(f'gridX = 4 * ceil(Wlow/8); block=(32,8)\nmap gridX quotient to 256-channel slab, remainder to spatial X\nmap warp/4 to upper/lower tiles, warp%4 to 64 output channels\ninitialize three barriers for 256 threads; synchronize\nload W0; stage input 0,1,2; wait stage0\naccumulator[2 spatial][4 N16][4 words] = Half zero\nfor t in 0..{steps-1}:\n    load shared slot t%3, own spatial half, both K subtiles\n    accumulate all M/N fragments in source order\n    if next: load next W and wait next stage\n    if t+3 exists: refill old stage with t+3\nfor each owned valid 4x4 tile:\n    publish {typ} vectors with C1024 tile stride','The complete channel expansion, with no residual or pool hidden inside it')
    body=f'''<h2 id="model">The model operation: double channels after record 30’s pool</h2>
<p><code>{name}</code> is the encoder connector from C512 to C1024. Record 30 has already completed local attention, saved its high-resolution C512 skip and pooled its raw output. This entry takes that pooled tensor X, logically [Hlow,Wlow,512], and computes a pointwise [512,1024] projection. At a 3840×2160 input its logical field is [36,60,512] and output [36,60,1024]. There is no further pooling, residual addition, activation, bias, QKV or attention inside this kernel.</p>
<p>The equation for one low-resolution position p is <code>Y[p,n]=publish(Σk=0…511 X[p,k]·W[k,n])</code>, n=0…1023. The spatial axes remain unchanged. The input field includes the network’s padding: actual half-height 34 was padded to 36 before this call. The projection is still applied to the supplied padded field according to its ordinary tile-domain rules. This page builds that single matrix operation from scalar output ownership through the exact asynchronous CTA schedule.</p>
{graph(name,[('Pooled encoder tensor',['[36,60,512] at 4K',typ+' native tiled input'],'tensor'),('Pointwise channel matrix',['512 input channels','1024 output channels'],'compute'),('Bottleneck input',['[36,60,1024]',typ+' native tiled output'],'storage')],'The preceding pool and subsequent C1024 block are separate model operations and separate consumers/producers.')}
<h2 id="baseline">1. Implement one output dot product, then identify the duplicated reads</h2>
<p>A scalar baseline gives each thread one output position/channel and performs 512 multiplies and additions. Its most obvious inefficiency is that 1,024 output channels for the same position repeatedly read the same 512-input vector. We can improve this without changing the model by sharing input data across an output-channel tile and reusing a weight panel across multiple positions. The desired tile must fit the existing packed input/output convention, because inserting a BHWC conversion would create extra traffic before useful work.</p>
{pseudo_block_0}
{numerical(fp8)}
<h2 id="ownership">2. Derive the 8 × 8 × 256 CTA from the output tensor</h2>
<p>Take an 8 × 8 spatial region and 256 of the 1,024 output channels. Four channel slabs cover the full output. Eight warps divide this CTA as two spatial rows of four output groups. Warp w has channel base <code>256·slab+64·(w&amp;3)</code>, and native tile Y coordinate <code>2·blockIdx.y+(w&gt;&gt;2)</code>. Each warp owns the two horizontally adjacent 4 × 4 tiles in that row, so its matrix result is 32 positions ×64 channels. It therefore needs two M16 fragments and four N16 groups.</p>
<p>Let <code>spatialColumns=ceil(Wlow/8)</code>. Grid X encodes both the spatial region and channel slab: <code>slab=blockIdx.x/spatialColumns</code>, <code>tileX=2·(blockIdx.x%spatialColumns)</code>. At Wlow=60, spatialColumns=8. For blockIdx.x=19, slab=2 and tileX=6; warp 5 computes output channels 576…639 for native tile row 2·blockIdx.y+1 and native columns 6/7. Keep these arithmetic roles separate when testing: the quotient is a channel selection and the remainder is a spatial selection.</p>
{matrix_diagram(name,512,1024,fp8,8,2)}
{mma_primer(fp8)}
{layouts(fp8,512,1024,576)}
<h2 id="reuse">4. Separate copy ownership from compute ownership</h2>
<p>The compute ownership above does not mean each warp copies only its own inputs. For copying, <code>warp&amp;1</code> selects one of the two instruction-K stripes, <code>(warp&gt;&gt;1)&amp;1</code> selects left/right spatial tile, and <code>warp&gt;&gt;2</code> selects top/bottom spatial tile. Eight warps each issue one 512-byte stripe, filling a 4 KiB stage. Consumers then select the upper or lower 2 KiB half using warp&gt;&gt;2 and read both K stripes for both of their spatial fragments.</p>
<p>This remapping is the reuse mechanism. Four warps working on distinct 64-channel output groups consume the same input stage half; each loaded A fragment is also reused across four N16 accumulators inside a warp. Each weight fragment is used for both M16 spatial fragments. None of these transformations changes the number of model dot products; they change how many times bytes are fetched to support those products. The tradeoff is a shared-memory allocation and barrier protocol that the scalar baseline did not need.</p>
{cut(path,'const int g_OutputChannel',9,caption='Grid/warp output ownership and a distinct producer tile coordinate')}
{cut(path,'const int s_DestinationByteOffset',20,caption='One 512-byte stripe per producer warp; all output groups reuse it')}
<p>The actual stage source address is <code>X+(tileIndex·512+reductionStart+(warp&amp;1)·{step//2})·16·{e}</code>. The K-half displacement is always 512 bytes. For native tile 7, reductionStart={step}, and an odd producer warp, this is <strong>{(7*512+step+step//2)*16*e:,} bytes</strong>. The matching shared destination is <code>4096·slot+512·warp</code>. This exact mapping lets you write a diagnostic stage-fill kernel before the matrix instructions are introduced.</p>
{pipeline(path,fp8,3,4096,steps,prefill_all=True)}
{memory_diagram(name,fp8,3,4096,steps,input_shape='pooled C512 X',extra='Within each spatial half, four consumer warps reuse the same input stripes for different output channels.')}
{cut(path,'const int g_WeightTileByteBase',20,caption='1024 output columns make each packed instruction-K weight stride 32 KiB')}
<p>Weight address spacing deserves a separate check. The two K subtiles inside an iteration are separated by <code>({step}/2)·1024·{e}=32768</code> bytes. Four N16 channel groups advance only 512 bytes apiece. Accidentally carrying over a 16 KiB stride from a 512-output matrix would fetch a different output panel instead of the next input-K slice. The per-warp <code>r_WeightFragments[2][4]</code> holds these vector bundles; weights do not pass through shared memory.</p>
<h2 id="mma-loop">6. Preserve input order while unrolling only the fragment loops</h2>
<p>The output accumulator starts at zero because this is a pure projection. Each of the {steps} outer iterations advances {step} input channels, composed of two {'K32 E4' if fp8 else 'K16 Half'} instructions for every N8 result. The two N8 results make one N16 accumulator group. For each of the warp’s two spatial fragments and four N16 groups, the helper consumes K subtile zero then one. Its four Half2 accumulator words remain in place across the complete K=512 reduction.</p>
{cut(path,'// Keep the reduction loop',34,caption='The rolled K loop, unrolled fragment loads and safe three-stage recycling')}
<p>The source explicitly rolls the long reduction but unrolls the small fixed fragment loops. This is a practical register-indexing design: fixed r_SpatialTile and r_KSubtile indices let the compiler select concrete registers, while an entirely unrolled K=512 program could increase instruction footprint. Keep the compiler choice visible rather than assuming every loop should be maximally unrolled. The entry declares a register limit; actual live-register pressure, shared-memory residency and spills are properties to inspect in compiled output.</p>
<h2 id="publish">7. Publish a wider native tile without inventing a spatial transform</h2>
<p>Each output native tile now contains sixteen positions ×1,024 channels ×{e} bytes, or <strong>{16384*e:,} bytes</strong>. The first lane vector for tile q and output base c is <code>Y+(q·1024+c)·16·{e}+16·lane</code>. For q=7,c=576,lane=13, that is <strong>{(7*1024+576)*16*e+208:,} bytes</strong>. {'The writer takes pairs of adjacent N16 groups, packs their matching Half2 channel pairs to E4 and emits two vectors per lane.' if fp8 else 'The writer emits four direct Half vectors per lane, one per N16 group.'} Grid/channel ownership gives each output address one writer.</p>
{publication_diagram(name,fp8,'global native C1024 tile','The output has twice as many channels, but exactly the same spatial positions as the pooled input.')}
{cut(path,'// Physical output',31,caption='Output channels double the tile stride; only valid native spatial tiles are published')}
<p>The input resolver broadcasts a singleton tile dimension and otherwise zero-fills invalid 8 × 8 CTA edges. The output check clips to <code>Hlow/4</code> and <code>Wlow/4</code> native tiles. At [36,60], the final CTA row includes one valid native tile row and a synthetic one; the final CTA column likewise handles one real and one synthetic native tile. The synthetic inputs may support a convenient fixed compute schedule, but their results must not be stored beyond the field. These are boundary rules of the physical kernel, not extra logical pixels in the model.</p>
{helpers(fp8)}
<h2 id="rebuild">Final reconstruction schedule</h2>
{pseudo_block_1}
{tests(['Use W that copies each input channel to both output halves; decode all 1024 output channels and verify the duplication without any spatial shift.','Use four distinguishable output-channel slabs to catch grid-X quotient/remainder errors. Test the blockIdx.x=19,warp=5 worked ownership example.','Fill one input K stripe at a time; distinguish the two instruction-K halves and verify the 32 KiB weight stride. A constant weight matrix will not detect a wrong panel address.','Exercise [36,60] and inspect the right/bottom synthetic CTA tiles with guarded allocations; only actual native tiles may be stored.','Test zero input, sparse input and alternating-sign large/small values to separate layout errors from Half accumulator rounding differences.','Compare all output addresses against a host enumeration of (native tile,channel panel,lane) and ensure disjoint writes across every CTA/channel slab.'])}
'''
    return body


def decoder(name,fp8):
    prec='fp8' if fp8 else 'fp16';typ='E4M3' if fp8 else 'Half';e=1 if fp8 else 2
    path=U+prec+'/'+name+'.cu';steps=4 if fp8 else 8;step=64 if fp8 else 32
    pseudo_block_0 = pseudo('for each low position p and output channel n:\n    projected[p,n] = dot1024(X[p,:], W[:,n])\nfor each valid high position (y,x), channel n:\n    low = projected[y//2,x//2,n]\n    scaledSkip = rounded_half(skip[y,x,n] * scale[n])\n    Y[y,x,n] = publish(rounded_half(low + scaledSkip))','Scalar dependency baseline; the split-K projection order is derived next')
    wait_schedule = ('if native grid mode and split>0: poll predecessor; CTA synchronize' if fp8 else 'if split>0:\n    if native grid mode: poll predecessor\n    CTA synchronize  # retained even in OrderedSplit mode')
    pseudo_block_1 = pseudo(f'select split from OrderedSplit-1 or gridZ\nmap XY grid to one low 4x4 tile and 256 output channels\ninitialize 2 input-stage barriers for 64 threads\naccumulate split’s K256 with {steps} steps of K{step}\n    prefetch next input; MMA current A/W; wait next stage\n{wait_schedule}\nif split==0: store Half scratch\nif split==1 or split==2: ordered Half reduction into scratch\nif split==3:\n    load previous Half scratch; HalfAdd own partial\n    for four high quadrants:\n        repeat low projected values with indexed lane shuffles\n        load high skip; decode if needed; HalfMul by Half scales\n        HalfAdd nearest value and scaled skip\n        crop and publish {typ} high vectors\nCTA synchronize; leader release-publishes split counter','No upsampled projection temporary is created; all cross-split storage stays explicitly Half')
    body=f'''<h2 id="model">Record 39: project, repeat, add the encoder skip</h2>
<p><code>{name}</code> implements the transition-only record 39. Its low input has 1,024 channels. A [1024,512] matrix first reduces channel width, each projected position is repeated into a 2 × 2 high-resolution patch, and a learned channelwise scale multiplies the saved record-30 skip before addition. The published C512 tensor feeds record 40’s ordinary FFN/attention block. There is no ordinary FFN or attention inside record 39 itself.</p>
<p>At the 4K geometry, input is [36,60,1024] and saved skip is [68,120,512]. Projection produces [36,60,512]. Nearest 2× repetition would give [72,120,512]; cropping to the destination field yields [68,120,512]. For high pixel (y,x) and channel n, the conceptual result is <code>Y[y,x,n]=publish((X[floor(y/2),floor(x/2),:] W)[n] + scale[n]·skip[y,x,n])</code>. Projection happens at low resolution so each dot product is evaluated once for four destinations.</p>
{graph(name,[('Low bottleneck X',['[36,60,1024]',typ+' native tiles'],'tensor'),('Pointwise projection',['1024 → 512','four ordered K256 partials'],'compute'),('Low projected values',['16 positions per 4×4 tile','Half accumulator / scratch'],'storage'),('Nearest repetition',['one low value → 2×2 patch','shuffle, no image temporary'],'compute'),('Scaled encoder skip',['record 30 at high coordinate','HalfMul then HalfAdd'],'compute'),('Crop and publish',['[68,120,512]',typ+' native tiled output'],'storage')],'The reduction is split in K; the spatial expansion occurs only after all four partial projections have been combined.')}
<h2 id="baseline">1. Separate the three operations before fusing them</h2>
<p>A simple reference first computes a complete low-resolution [Hlow,Wlow,512] projection, then launches an upsample/merge kernel that looks up floor(y/2),floor(x/2). This makes the spatial relation explicit. A less careful baseline could repeat X first and run the 1024→512 projection at high resolution, duplicating the same matrix work up to four times. Begin with projection-before-repeat. The optimized entry will additionally remove the low projected global image from the final split and directly shuffle its register values to high destinations.</p>
{pseudo_block_0}
{numerical(fp8)}
<h2 id="ownership">2. Split both output channels and input-K work deliberately</h2>
<p>A CTA owns one low 4 × 4 tile and 256 output channels. It has two warps, each producing 128 output channels over the same sixteen low positions. Each warp therefore needs one M16 fragment and eight N16 accumulator groups. Grid X has <code>2·ceil(InputWidth/4)</code> positions: its remainder selects low tile X, its quotient selects output channels 0…255 or 256…511. Grid Y selects low tile Y. Grid Z, or the OrderedSplit parameter, selects one of four 256-input-channel K ranges.</p>
<p>Let <code>columns=ceil(InputWidth/4)</code>, <code>tileX=blockIdx.x%columns</code>, and <code>outputBase=256·(blockIdx.x/columns)+128·warp</code>. For InputWidth=60 and blockIdx.x=23, columns=15, tileX=8 and the slab begins at 256. Warp 1 then owns output channels 384…511. Split 2 reads input channels 512…767 for that result. These three independent roles—spatial tile, output slab, K split—must all appear in the correct address terms.</p>
{matrix_diagram(name,256,512,fp8,2,1,128)}
{mma_primer(fp8)}
<h2 id="layout">3. Distinguish working-format inputs from always-Half split scratch</h2>
<p>A low input native tile is sixteen positions ×1,024 channels ×{e} bytes, or {16384*e:,} bytes. Split s contributes a <code>s·4096·{e}</code> byte offset, because it owns 256 channels across those sixteen positions. Current iteration t and producer warp w add <code>(2t+w)·512</code>. Thus <code>X+lowTile·{16384*e}+split·{4096*e}+(2t+warp)·512</code> names each input stripe. For lowTile=7,split=2,t=1,producer warp=1, it is <strong>{122880*e+1536:,} bytes</strong>. Both consumer warps then reuse both staged stripes for different output-channel groups.</p>
<p>The weight address is <code>W+(256·split+t·{step})·512·{e}+outputBase·32+16·lane+16384·kSubtile+512·N16</code>. For split=2,t=1,outputBase=128,lane=13,kSubtile=1,N16=3 it gives <strong>{(512+step)*512*e+22224:,} bytes</strong>. The full matrix consumes <code>1024·512·{e}={524288*e:,}</code> bytes, followed by 512 Half scale values. Matrix K slicing does not slice the residual scale array: scale depends only on the final output channel.</p>
{cut(path,'const uint64_t g_WeightTileBase',14,caption='Global weight addresses include the logical split-K range before panel offsets')}
{cut(path,'const uint64_t g_Source',13,caption='Each split stages only its 256-channel portion of the low input')}
<p>Scratch is <strong>Half in both precision variants</strong>. It stores one [16 positions,512 outputs] tensor per low tile, exactly 16,384 bytes, irrespective of e. Its address is <code>scratch+lowTile·16384+outputBase·32+16·lane+512·N16</code>. For lowTile=7,outputBase=128,lane=13,N16=3 that is <strong>120,528 bytes</strong>. The full [36,60,512] scratch payload is 2,211,840 bytes. {'Halving this allocation because input/weights are E4 would corrupt the scratch contract.' if fp8 else 'Its type agrees with the working output format, but its spatial field is low-resolution and its update lifetime is still distinct.'}</p>
<h2 id="split">4. Introduce split-K only after a complete low projection works</h2>
<p>The baseline has few low spatial tiles, so splitting the 1,024-channel reduction into four K256 jobs provides more independent CTAs. Each job computes one quarter of the dot product into Half accumulators. This adds scratch traffic, counters and ordering requirements; it is not a free reduction in work. A correct reconstruction should first implement all K=1024 in one CTA, verify the projection, then introduce four partials and explicitly match the source’s order. Floating-point partial sums cannot be freely rearranged while claiming identical results.</p>
<p>Split 0 stores its accumulator to scratch. Splits 1 and 2 add their accumulators using <code>ReduceHalf4</code>. Split 3 loads the prior scratch into registers and performs four <code>HalfAdd</code> operations with its own N16 words; it does not overwrite scratch. Consequently the source’s final low result is effectively (((partial0+partial1)+partial2)+partial3) with Half reduction/publication boundaries. Each split has its own internal ordered K accumulation. The final upsample and skip merge run only in split 3.</p>
{graph(name+' split',[('Split 0: K 0…255',['Half partial0','store Half scratch'],'compute'),('Split 1: K 256…511',['wait predecessor','reduce Half into scratch'],'compute'),('Split 2: K 512…767',['wait predecessor','reduce Half into scratch'],'compute'),('Split 3: K 768…1023',['read scratch + own Half partial','no scratch overwrite'],'compute'),('Final high image',['nearest repeat + scaled skip','published once'],'storage'),('Control per XY CTA',['one 32-bit completion counter','ordered stream or native grid-Z'],'accent')],'The arrows express the required partial-update order. Scratch and the final image have different writers and lifetimes.')}
{cut(path,'// Split 0 stores Half scratch',45,caption='The three scratch writers and the final register-only combination')}
<p><code>ReduceHalf4</code> uses a vector Half2 global reduction on SM90+ and scalar Half2 reductions on earlier supported targets. Its no-flush-to-zero modifier and Half addition are part of the numerical contract. It is not an E4 atomic, an FP32 atomic, or a substitute for the split order. The same scratch location is intentionally updated over time by multiple splits, while final output coordinates remain single-writer locations.</p>
{pipeline(path,fp8,2,1024,steps,decoder=True)}
{memory_diagram(name,fp8,2,1024,steps,input_shape='one C1024 tile / K split',extra='Two producer warps fill the two K stripes; both consumer warps reuse the complete stage for 128 channels each.')}
<h2 id="synchronization">6. Make cross-CTA publication an explicit part of the design</h2>
<p>The counter address is <code>completionCounters+4·(tileY·2·columns+blockIdx.x)</code>. It is shared by all K splits of the same low-tile/output-slab CTA. With columns=15,tileY=3,blockIdx.x=23, it is byte offset 452. Its initial state must come from the launch/counter-clear contract; allocating uninitialized counter bytes is not a valid starting point. Native later splits poll until the predecessor value is observed, and the producer publishes its split index after its CTA’s writes have reached the final synchronization point.</p>
<p>The source has two modes. When OrderedSplit is nonzero, its value minus one selects the logical split; the launcher can run four XY grids in stream order. This provides an easy-to-reason-about rebuild path: a later kernel starts after its predecessor’s writes, and no resident CTA waits on a producer that cannot be scheduled. When OrderedSplit is zero, grid Z supplies the split and the entry uses relaxed GPU-scope counter loads and a release counter store, with CTA barriers around publication. A grid full of polling consumers can prevent an unscheduled producer from running, so this mode also depends on launch-capacity reasoning.</p>
<p>{'The FP8 body skips both this poll and its following CTA barrier in OrderedSplit mode. The FP16 body skips only the poll: for every split greater than zero it retains the CTA barrier, even when the predecessor completed in a prior stream-ordered launch.' if fp8 else 'For every split greater than zero, this FP16 body executes a CTA barrier after the conditional poll. OrderedSplit mode skips the poll but retains that barrier; the FP8 body encloses both operations in its native-mode branch.'} The pinned entry bodies do not invoke the available <code>AcquireSplitPublication</code> helper after polling. Describe that actual source sequence faithfully; do not turn it into a generic proof that any relaxed poll followed by a CTA barrier acquires another CTA’s data. For an independent reconstruction, validate the ordered-stream mode first, then assess the full native counter protocol, memory visibility and resident-grid constraints as a separate change. The tutorial does not invent a missing fence or claim to have formally verified native inter-CTA synchronization.</p>
{cut(path,'if (Parameters.OrderedSplit == 0' if fp8 else 'if (TileCoordinates.Split > 0)',9,caption='The entry’s actual split wait path; ordered launch mode changes this control flow')}
{cut(path,'CounterStoreRelease',1,before=0,caption='Completion is published with the split index after the final CTA synchronization')}
<h2 id="repeat">7. Reconstruct nearest-neighbor repetition as lane selection</h2>
<p>A projected low 4 × 4 tile expands into four high 4 × 4 quadrants. Let ox and oy be the quadrant’s horizontal and vertical bits. For destination lane l and row half r, select source lane <code>(l&amp;3)|((l&gt;&gt;1)&amp;4)|(8·ox)|(16·r)</code>. Select source accumulator word with row half oy. The low lane’s channel bits l&amp;3 remain unchanged, while token bits select the low value that should repeat at that destination. This replaces an expanded temporary tensor with indexed register shuffles.</p>
<p>For ox=0,oy=0,r=0, destination lanes 0,4,16,20 all select source lane 0. Those lanes correspond to high positions (0,0),(1,0),(0,1),(1,1) for the same channel pair. The value repeats exactly four times; no interpolation weights appear. For a global worked example, high pixel (17,25), channel 137 reads the low projection at (8,12), channel 137, and the skip at the original high coordinate (17,25), channel 137. The low and skip spatial addresses must therefore be derived independently.</p>
{cut(path,'const int r_SourceLane',11,caption='The final split gathers a repeated low value and adds the separately scaled high skip')}
<p>Read the saved skip as native C512 vectors, {'decode E4 to Half pairs, ' if fp8 else ''}multiply by the channel scale with HalfMul, then add the nearest projected value with HalfAdd. This is a separately rounded skip product followed by addition. It is not a fused skip FMA. The crop occurs when choosing valid high output tiles; at 4K the bottom four rows of the nominal 72-row repetition are excluded. The final publication occurs after this merge, not between projection and repetition.</p>
<h2 id="publish">8. Give the final image a single writer</h2>
<p>Only split 3 stores high-resolution output. For high native tile q, output base c and lane l, its first vector begins at <code>Y+q·{8192*e}+c·{16*e}+16l</code>. For q=12,c=128,l=13, that is <strong>{100352*e+208:,} bytes</strong>. {'Four E4 uint4 vectors cover a warp’s 128 output channels; each packs two N16 results.' if fp8 else 'Eight Half uint4 vectors cover a warp’s 128 output channels, one per N16 result.'} Since a low tile’s four output quadrants are unique and channel slabs are disjoint, these stores need no atomics. Keep that property when changing the grid.</p>
{publication_diagram(name,fp8,'global high C512 image','Low projection partials use Half scratch; only final split 3 expands, merges, crops and publishes high output.')}
{helpers(fp8)}
<h2 id="rebuild">A complete source-order reconstruction</h2>
{pseudo_block_1}
{tests(['Before splitting, compare a full K1024 low projection with a host-decoded matrix reference. Then compare the source-ordered four partials, including Half scratch reductions.','Set the skip scale to zero and project one distinguishable low token: it must appear at exactly the four nearest high positions, subject to cropping.','Set the projection matrix to zero and verify every output channel equals the scaled same-position high skip. This isolates residual layout from repeat addressing.','Verify the lane 0/4/16/20 repetition trace and high pixel (17,25), channel137 example with unique spatial values.','Guard scratch and counter allocations; test both 256-channel slabs, all four splits, and the last low tile’s high crop. Scratch remains Half even in E4 mode.','Run OrderedSplit mode first. Qualify the native counter path separately with its counter initialization, memory-ordering and occupancy assumptions; successful arithmetic tests alone do not prove that synchronization protocol.'])}
'''
    return body


def build_lessons(inventory):
    entries=inventory.get('entries',inventory)
    results=[]
    specs=[
        ('window_ffn_c512','ffn','ordinary'),
        ('window_ffn_input_view_c512','ffn','view'),
        ('window_ffn_projection_c512','projection','ffn'),
        ('window_ffn_projection_input_view_c512','projection','ffn_input_view'),
        ('window_qkv_c512','qkv',''),
        ('window_attention_projection_c512','projection','attention'),
        ('window_attention_projection_output_view_c512','projection','attention_output_view'),
        ('window_attention_projection_pool_c512','projection','attention_pool'),
        ('channel_projection_c512_to_c1024','channel',''),
        ('decoder_upsample_c1024_to_c512','decoder',''),
    ]
    titles={
        'window_ffn_c512':'Build the C512 premix and grouped FFN',
        'window_ffn_input_view_c512':'Build the C512 grouped FFN from a channel-plane input',
        'window_ffn_projection_c512':'Build the C512 FFN postmix and residual',
        'window_ffn_projection_input_view_c512':'Build the C512 postmix with a plane-view residual',
        'window_qkv_c512':'Build fused C512 QKV and window attention',
        'window_attention_projection_c512':'Build the C512 attention head-mixing projection',
        'window_attention_projection_output_view_c512':'Build attention projection with direct plane-view output',
        'window_attention_projection_pool_c512':'Build the C512 attention projection and raw-output pool',
        'channel_projection_c512_to_c1024':'Build the C512 to C1024 channel expansion',
        'decoder_upsample_c1024_to_c512':'Build the C1024 to C512 split-K decoder transition',
    }
    for stem,kind,mode in specs:
        for precision in ('fp16','fp8'):
            name=stem+'_'+precision
            if name not in entries:raise ValueError('Missing public C512 entry '+name)
            fp8=precision=='fp8'
            if kind=='ffn':body=ffn(name,fp8,mode=='view')
            elif kind=='projection':body=projection(name,fp8,mode)
            elif kind=='qkv':body=qkv(name,fp8)
            elif kind=='channel':body=channel(name,fp8)
            else:body=decoder(name,fp8)
            body=body.replace('</p>', '</p><p>The <a href="architecture.html">network architecture guide</a>, rendered from <a href="../ARCHITECTURE.md">docs/ARCHITECTURE.md</a>, places this operation in the full encoder–bottleneck–decoder. This lesson defines the operation and its physical implementation locally so it can be read independently.</p>', 1)
            body+=storage_legend()
            results.append(dict(name=name,title=titles[stem]+' — '+precision.upper(),
                summary='Reconstruct '+name+' from a scalar model baseline through packed tensor ownership, addresses, synchronization and final publication.',
                family='C512 and transitions',body=body))
    return results
