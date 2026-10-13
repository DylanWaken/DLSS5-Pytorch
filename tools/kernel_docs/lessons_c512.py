"""Twenty self-contained reconstruction lessons for C512 public CUDA entries."""
from html import escape
from common import ROOT, code, svg
from lesson_support import storage_legend, pseudo

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
    return f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="8" fill="{fill}" stroke="{stroke}"/><text x="{x+w/2}" y="{y+h/2-(len(lines)-1)*11+5}" font-size="15" style="font:15px Segoe UI,sans-serif;fill:#183244" text-anchor="middle">{parts}</text>'


def line(x1,y1,x2,y2,text=''):
    import math
    a=math.atan2(y2-y1,x2-x1)
    p1=(x2-9*math.cos(a)+4*math.sin(a),y2-9*math.sin(a)-4*math.cos(a))
    p2=(x2-9*math.cos(a)-4*math.sin(a),y2-9*math.sin(a)+4*math.cos(a))
    return f'<path d="M{x1},{y1} L{x2},{y2}" stroke="#536a79" stroke-width="2"/><polygon points="{x2},{y2} {p1[0]},{p1[1]} {p2[0]},{p2[1]}" fill="#536a79"/>'+lab((x1+x2)/2,(y1+y2)/2-10,text,14,'middle')


def lab(x,y,text,size=16,anchor='start'):
    return f'<text x="{x}" y="{y}" font-size="{size}" style="font:{size}px Segoe UI,sans-serif;fill:#183244" text-anchor="{anchor}">{escape(str(text))}</text>'


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
    return f'''<p>The working storage format on this page is <strong>{'E4M3 FP8' if fp8 else 'IEEE Half / FP16'}</strong>. Tensor-core accumulation, residual products, the recovered activation and the reduction trees discussed here use packed Half words. A <code>uint32_t</code> is a bit container for two Half values, not an integer approximation to their sum. <code>HalfMul</code>, <code>HalfAdd</code> and <code>HalfFma</code> express packed-Half source operations; replacing them with FP32 expressions and a final cast changes that arithmetic. However, ordinary CUDA Half intrinsics can be contracted by the compiler. Helper names alone do not prove a separate rounding boundary: the source-correlated SASS below establishes the actual compiled operations.{' E4 publication calls PackHalfPairsE4 on two Half2 words and produces four bytes. DecodeE4 performs the reverse operand preparation when a residual must participate in Half arithmetic. There is no scale tensor passed to those conversions.' if fp8 else ' The operand and accumulator use the same element type, but their lane-word arrangements still differ by matrix role. Equal dtype does not make an arbitrary row-major uint4 a valid MMA fragment.'}</p>
<p>Start with a high-precision scalar oracle to validate which input contributes to which output. Once the connectivity is correct, introduce a second oracle that follows the source’s K chunk order and publication points. A scalar FP32 sum is not a bitwise reference for Half MMA; it is a tool for catching transposes, wrong groups and wrong spatial coordinates. Keep these two correctness goals separate throughout reconstruction.</p>'''


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
            body=body.replace('</p>', '</p><p>The <a href="architecture.html">network architecture guide</a> places this operation in the full encoder–bottleneck–decoder. This lesson defines the operation and its physical implementation locally so it can be read independently.</p>', 1)
            body+=storage_legend()
            results.append(dict(name=name,title=titles[stem]+' — '+precision.upper(),
                summary='Reconstruct '+name+' from a scalar model baseline through packed tensor ownership, addresses, synchronization and final publication.',
                family='C512 and transitions',body=body))
    return results


# Each public entry is composed directly in the reader's six-step order.
from lessons_c512_figures import cta as cta_figure, warp as warp_figure, schedule as schedule_figure, trace as trace_figure


def channel(name,fp8):
    e=1 if fp8 else 2;typ='E4M3' if fp8 else 'Half';prec='fp8' if fp8 else 'fp16';path=D+prec+'/'+name+'.cu'
    steps=8 if fp8 else 16;step=64 if fp8 else 32
    problem=f'''<p><code>{name}</code> connects the C512 encoder to the C1024 bottleneck. Record 30 has already performed attention projection, saved its high-resolution skip and pooled the raw output. This kernel receives X[36,60,512] and applies W[512,1024] independently at every supplied position, producing Y[36,60,1024]. The valid pooled height was 34, padded to 36 by the surrounding model.</p><p>For token p, <code>Y[p,n]=publish(Σk=0…511 X[p,k]W[k,n])</code>, n=0…1023. There is no residual, activation, bias or additional pool. Doubling channel count leaves spatial positions unchanged. A scalar baseline repeats the same token's 512-input read for every output channel; the tiled design shares A across four output bands and reuses each B panel across multiple positions.</p>'''+graph(name,[('Pooled X',['[36,60,512]',typ+' native tiled input'],'tensor'),('Pointwise matrix',['512 → 1024','same spatial token'],'compute'),('Bottleneck input',['[36,60,1024]',typ+' native tiled output'],'storage')],'The pool precedes this kernel; the first C1024 attention/FFN block follows it.')
    cta='''<p>A CTA owns one 8×8 spatial region and 256 output channels. At H=36,W=60, spatialColumns=ceil(60/8)=8. Grid X combines four channel slabs with eight spatial columns: grid=(32,5,1), 160 CTAs; block=(32,8), 256 threads. Every CTA reduces all K512. At the last spatial row/column, synthetic native tiles are zero-filled and their output stores clipped.</p><p>Decode <code>slab=blockIdx.x/8</code>, <code>tileX=2·(blockIdx.x%8)</code>. For blockIdx.x=19, slab=2 and tileX=6. Warp 5 then owns output channels 576…639 and native tile row 2·blockIdx.y+1, columns 6/7. The quotient is a channel coordinate; the remainder is spatial. The worked token trace uses the simpler CTA (0,0,0), warp 2, channel 128.</p>'''+cta_figure(name,'channel',8,64,256,'4K low-field grid (32,5,1): 160 CTAs',['K512 → one 256-channel slab','Four slabs cover all C1024','Final row/column clip synthetic tiles'])
    warp='''<p>Compute ownership is <code>channelBase=256·slab+64·(warp&amp;3)</code>, native tileY=2·blockIdx.y+(warp&gt;&gt;2). Each warp owns two horizontal 4×4 tiles and 64 channels, a 32×64 result. Copy ownership is different: warp&amp;1 selects K stripe, (warp&gt;&gt;1)&amp;1 selects left/right tile, warp&gt;&gt;2 selects top/bottom tile. Eight producer warps each fill one 512-byte stripe. Four output-band warps later reuse each staged spatial half.</p>'''+warp_figure(name,'channel',8,2,64,128)+lane_contract(fp8,2,64)
    resources=budget(path,3,4096,8,168,[('Output accumulator','32 words/lane','[2 M16][4 N16][4 Half2 words]'),('A operands','16 words/lane','uint4[2 spatial][2 K]'),('B operands','32 words/lane','uint4[2 K][4 N16]')],'<p>The three slots hold only input A. Output and B remain per-warp registers. A larger stage count might reduce exposed copy latency but consumes more shared space; the source alone does not prove that a larger ring would improve residency or time.</p>')
    schedule=schedule_figure(name,steps,3,4096,['Finish zero-seeded projection','Publish native C1024 vectors'],full_prefill=True)+ring(3,steps,True)+copy_contract()+cut(path,'// Keep the reduction loop',36,caption='Rolled K loop, unrolled fragment loads and the three-slot reuse order')
    trace=f'''<p>Follow token (0,0), CTA (0,0,0), warp 2, lane 0 and output channel 128. At t=1, the input channel panel begins at k={step}. The final C word starts at zero because this entry has no residual.</p><h3>6.1 Give the copy warp a native source address</h3><p>Input native tile q has {8192*e:,} bytes. For t=1, first K subtile, q=0, source is <code>(q·512+t·{step})·16·{e}=1024</code>. Producer warp 0 copies the 512-byte stripe into slot 1 at shared+4096. Consumer warp 2 is the third output band, but reads this same spatial half and K stripe. Its lane 0 shared uint4 begins at 4096; word banks are 0,1,2,3. The next K stripe adds 512, the next spatial tile adds 1024 and the lower spatial half adds 2048.</p>'''+cut(path,'const int s_DestinationByteOffset',22,caption='Producer mapping and the packed global source offset')+trace_figure(name,['X + 1,024 bytes','tile 0, t=1, first K stripe','producer warp 0'],['slot 1 + spatial 0 + K0','shared byte 4,096; consumer warp 2','four banks 0…3; no XOR swizzle'],['W + 69,632 → B registers','MMA accumulates Y[(0,0),128]','32×64 result per warp'],[f'Y + {2048*e:,} bytes','C1024 tile extent '+str(16384*e),'one writer per token/channel'])
    trace+=f'''<h3>6.2 Use the C1024 weight stride, not the C512 one</h3><p>Weight vector address is <code>W+t·{step}·1024·{e}+outputBase·32+16·l+kSubtile·32768+N16·512</code>. Our t=1,outputBase=128,l=0,K0,N0 gives <strong>69,632 bytes</strong>. The instruction-K stride is 32,768 because there are 1024 output columns; copying the 16 KiB stride from the C512 projection would select the wrong matrix values. __ldca reads the two-K/four-N bundles into <code>r_WeightFragments[2][4]</code> without a shared weight stage.</p>'''+cut(path,'const int g_WeightTileByteBase',22,caption='Derive B spacing from the full output-column count')
    trace+=f'''<h3>6.3 Reuse operands while preserving each accumulator's K order</h3><p>Load the two spatial ×two-K A vectors. For each M16/N16 result, AccumulateTile consumes K subtile 0 then 1, issuing two N8 MMA updates per subtile. There are 2×4×2×2=32 warp-level MMA instructions per iteration, {32*steps} across the projection reduction. This is a source instruction count, not a measured utilization rate. Each A fragment is reused across four N16 panels; each B bundle serves two M16 spatial fragments. The selected result stays in spatial 0,N16 0,word 0 throughout all {steps} iterations.</p>'''+code(S+'tiled_mma.cuh',9,47,'Accumulator storage and the common M/N/K update order')
    trace+=f'''<h3>6.4 Publish the same token with a wider tile stride</h3><p>Y's native tile is 16×1024×{e}={16384*e:,} bytes, twice the X tile size. The lane-vector address is <code>Y+(q·1024+outputBase)·16·{e}+16·l</code>; our q=0,outputBase=128,l=0 gives {2048*e:,}. {'The writer converts matching Half2 channel pairs to E4 and merges two N16 panels per vector, yielding two vectors per lane.' if fp8 else 'The writer directly stores the four Half words of each N16 result, yielding four vectors per lane.'} StoreNoAllocate uses an aligned 16-byte global store. Valid tiles and channel slabs are disjoint, so no atomics or cross-CTA reduction are required.</p>'''+cut(path,'// Physical output',31,caption='The C1024 destination stride and validity guard')
    trace+=reconstruction('channel',fp8)
    trace+=finish_trace(fp8,['Use a matrix that copies X to both output halves; verify all 1024 channels and no spatial displacement.','Check the CTA-X quotient/remainder example at blockIdx.x=19 and the selected token trace with tagged values.','Exercise the 32 KiB instruction-K weight stride, both K subtiles and every output N16 panel.','Test [36,60] bottom/right partial CTA regions and native singleton read policy; no synthetic output address may be stored.'])
    return six_parts(problem,cta,warp,resources,schedule,trace)


def decoder(name,fp8):
    e=1 if fp8 else 2;typ='E4M3' if fp8 else 'Half';prec='fp8' if fp8 else 'fp16';path=U+prec+'/'+name+'.cu'
    steps=4 if fp8 else 8;step=64 if fp8 else 32
    problem=f'''<p><code>{name}</code> implements transition-only record 39: project low C1024 to C512, repeat each projected token into a 2×2 patch, add the scaled high-resolution record-30 skip and crop. At 4K X=[36,60,1024], W=[1024,512], skip=[68,120,512]. Projection creates a logical [36,60,512] field; a nominal 2× repeat is [72,120,512], cropped to [68,120,512]. Record 40 receives the result.</p><p>For high token (y,x), <code>Y[y,x,n]=publish(project(X[floor(y/2),floor(x/2),:])[n]+HalfMul(skip[y,x,n],scale[n]))</code>. Project once at low resolution so four high destinations share that expensive dot product. The split-K implementation changes the reduction/storage schedule: it uses four ordered K256 partials with always-Half scratch before the final repeat/merge. No attention or grouped FFN is inside this entry.</p>'''+graph(name,[('Low bottleneck X',['[36,60,1024]',typ+' native tiles'],'tensor'),('Channel projection',['1024 → 512','four K256 partials'],'compute'),('Ordered Half reduction',['shared global scratch','0 → 1 → 2 → 3'],'storage'),('Nearest repetition',['one low token → four high tokens','indexed register shuffles'],'compute'),('Scaled high skip',['same high destination coordinate','HalfMul then HalfAdd'],'compute'),('Crop and publish',['[68,120,512]',typ+' native tiled output'],'storage')],'The final split holds the completed low value in registers and immediately repeats/merges it; no separate expanded projection image is written.')
    cta='''<p>One CTA owns one 4×4 low tile, 256 output channels and one K256 split. Block=(32,2), 64 threads. With 15 low native tile columns and 9 rows, the XY grid is (30,9). Native grid-Z mode launches four splits, grid=(30,9,4), 1080 CTAs. OrderedSplit mode instead selects one split per XY launch, four ordered launches of 270 CTAs each.</p><p>Decode low tileX=blockIdx.x%15 and channel slab=blockIdx.x/15. For blockIdx.x=23 the tile column is 8 and slab base is 256. Warp 1 then owns channels 384…511. Split 2 uses input channels 512…767. Only split 3 writes the high field: its low tile produces four high 4×4 quadrants, subject to the bottom crop. Scratch remains at low resolution.</p>'''+cta_figure(name,'decoder',2,16,256,'4K native grid (30,9,4), or four (30,9) ordered launches',['One low 4×4 tile; K256 partial','256 output channels; four splits','Final split → high 8×8 region'])
    warp='''<p>Warp channel base is <code>256·slab+128·warp</code>. Both warps own the same sixteen low positions and different 128-channel bands: one M16 fragment and eight N16 groups each. Producer warp 0 stages the first instruction-K stripe; producer warp 1 stages the second. Both consumers read both stripes. The trace uses CTA (0,0), warp 1/lane 0, low token (0,0), channel 128.</p>'''+warp_figure(name,'decoder',2,1,128,128)+lane_contract(fp8,1,128)
    resources=budget(path,2,1024,2,168,[('Partial C/D','32 words/lane','[1 M16][8 N16][4 Half2 words]'),('A operands','8 words/lane','uint4[1][2 K]'),('B operands','64 words/lane','uint4[2 K][8 N16]'),('Global split scratch','2,211,840 bytes at 4K','36×60×512×2, Half in both formats'),('Completion counters','1,080 bytes at 4K','30×9 independent XY CTAs ×4 bytes')],'<p>The global scratch is a model-launch resource, not shared memory and not E4 storage. Split 0 initializes it; splits 1/2 reduce into it; split 3 reads it without storing its final low result back. Counter initialization belongs to the launch contract.</p>')
    schedule=schedule_figure(name,steps,2,1024,['Ordered split reduction','split 3: repeat + skip + store'])+ring(2,steps)+copy_contract()+'''<p>Arithmetic for each K256 partial can run independently; scratch publication must follow split order 0,1,2,3. Split 0 stores Half vectors. Splits 1/2 use ReduceHalf4. Split 3 loads the predecessor scratch and HalfAdds its own partial into registers, then repeats and merges. CTA synchronization precedes the leader's release counter publication. More split CTAs provide parallel work at this small spatial level but add scratch traffic and control dependencies.</p>'''+cut(path,'// Split 0 stores Half scratch',44,caption='The ordered scratch writers and final register-only combination')
    trace=f'''<p>Follow low token (0,0), output channel 128 in warp 1/lane 0. Inspect split 2 at t=1 to make the split and step offsets visible; later split 3 combines the completed low value and sends it to high tokens (0,0),(0,1),(1,0),(1,1).</p><h3>6.1 Address the split's input panel and shared slot</h3><p>A native C1024 tile contains {16384*e:,} bytes. Split s contributes s·4096·{e} bytes; iteration t and producer stripe k add (2t+k)·512. For tile 0,s=2,t=1,k=0, source is <strong>{8192*e+1024:,} bytes</strong>. Producer warp 0 fills shared slot 1 at 1024. Consumer warp 1 reads the same lane-0 vector and the second K stripe at 1536. The first selected input channel is {512+step}; the split stops at 767.</p>'''+cut(path,'const uint64_t g_Source',13,caption='One split selects only its K256 subrange of the low native tile')
    woff=(512+step)*512*e+4096
    trace+=trace_figure(name,[f'X + {8192*e+1024:,} bytes','low tile 0, split 2, t=1',f'first selected k={512+step}'],['slot 1: byte 1,024','warp 1 reads both K stripes','banks 0…3; no XOR swizzle'],[f'W + {woff:,} → B registers','partial2 → ordered Half scratch','split3 combines, shuffles repeat'],['scratch vector: byte 4,096',f'high Y first vector: byte {2048*e:,}','four high tokens share one low value'])
    trace+=f'''<h3>6.2 Compute one partial and cross the global scratch boundary</h3><p>Weight vector address is <code>W+(256s+t·{step})·512·{e}+outputBase·32+16·l+16384·kSubtile+512·N16</code>. With s=2,t=1,base 128,l=0,K0,N0 this is <strong>{woff:,}</strong>. Two-K/eight-N vectors load with __ldca; shared A uses ordinary uint4 loads. Across {steps} iterations the converged MMA produces the split's partial Half result.</p><p>Scratch byte address is <code>scratch+lowTile·16384+outputBase·32+16·l+512·N16</code>, giving <strong>scratch+4096</strong>. It is independent of working precision. The sum is effectively (((partial0+partial1)+partial2)+partial3) with explicit Half boundaries. On SM90+ ReduceHalf4 emits vector <code>red.global.v4.f16x2.add.noftz</code>; earlier targets use four scalar Half2 reductions. These preserve elementwise Half addition/subnormals but do not themselves enforce split order.</p>'''+cut(path,'const uint64_t g_WeightTileBase',14,caption='Weight reduction base includes the split before instruction-K and N16 offsets')+code(S+'intrinsics.cuh',77,104,'The precision and architecture-dependent global Half reduction')
    trace+='''<h3>6.3 Keep counter ordering separate from data addressing</h3><p>Counter byte address is <code>4·(tileY·2·columns+blockIdx.x)</code>; all four splits for this XY output slab share it. With columns=15,tileY=3,blockIdx.x=23, the offset is 452. OrderedSplit−1 selects the split when nonzero, allowing stream-ordered launches. Native mode uses grid Z and polls predecessor completion with a GPU-scope relaxed no-L1-allocation load; publication uses a release store after CTA synchronization.</p>'''
    trace+=('<p>The FP8 entry skips both polling and its associated CTA barrier in OrderedSplit mode.</p>' if fp8 else '<p>The Half entry keeps the CTA barrier for every split greater than zero even in OrderedSplit mode; only the poll is skipped.</p>')
    trace+='''<p>The pinned entry does not call the available AcquireSplitPublication helper after its relaxed poll. Therefore this source walkthrough does not assert that an arbitrary relaxed poll plus CTA barrier acquires a predecessor's writes. Native mode also needs launch-capacity reasoning: resident polling consumers must not exclude their unscheduled producers. Rebuild and validate the ordered-stream mode first; evaluate native visibility, counter initialization and scheduling assumptions separately.</p>'''+cut(path,'if (Parameters.OrderedSplit == 0' if fp8 else 'if (TileCoordinates.Split > 0)',9,caption='The actual conditional predecessor wait in this precision variant')+cut(path,'CounterStoreRelease',1,caption='Release publication after the entry’s final CTA synchronization')
    trace+=f'''<h3>6.4 Repeat the completed token with register shuffles</h3><p>Only split 3 proceeds to high output. For destination quadrant bits ox,oy and row half r, source lane is <code>(l&amp;3)|((l&gt;&gt;1)&amp;4)|(8·ox)|(16·r)</code>; source accumulator row-half word is oy. For ox=oy=r=0, destination lanes 0,4,16,20 all select low source lane 0. Those destinations are high pixels (0,0),(0,1),(1,0),(1,1) for the same channel pair. This proves nearest repetition of the selected token without an expanded image allocation.</p><p>For each high destination, independently load its same-position skip, {'DecodeE4 into Half2, ' if fp8 else ''}HalfMul by the channel's Half scale, then HalfAdd the repeated low value. These are separate helper calls in the C++ expression, but that does not establish two rounding steps in the binary. The captured SM120 {'FP8 source line 226 lowers to <code>HFMA2 R6, R6, R24, R41</code>, with the nearby shuffle providing R41' if fp8 else 'FP16 source line 221 lowers to <code>HFMA2 R77, R32, R65, R72</code>, with the nearby shuffle providing R72'}. Thus the measured binary contracts this merge to a packed Half FMA; do not use the source helper boundary as a proof of a separately rounded multiply and add. The matrix is {524288*e:,} bytes followed by 512 Half scales. The low result is not published to E4 before this merge.</p>'''+cut(path,'const int r_SourceLane',18,caption='Select the low source lane, load the high skip and merge in Half')
    trace+=f'''<h3>6.5 Crop and store the final high token</h3><p>The high native vector address is <code>Y+highTile·{8192*e}+outputBase·{16*e}+16·l</code>. High tile 0,base 128,lane 0 starts at Y+{2048*e:,}. {'Four E4 vectors per lane cover 128 channels.' if fp8 else 'Eight Half vectors per lane cover 128 channels.'} Other lane destinations write the other three repeated tokens, each with its own skip contribution. Cropping excludes the nominal final four rows of the 72-row repetition. Final output has a single writer: split 3, its unique low tile/quadrant and channel slab.</p>'''
    trace+=reconstruction('decoder',fp8)
    trace+=finish_trace(fp8,['Implement a full K1024 projection first, then match four source-ordered partials including Half scratch boundaries.','Set skip scales to zero; one tagged low token must appear at four nearest high positions unless cropped.','Set W to zero; high output must equal the same-position scaled skip; match the compiled Half arithmetic when requiring bitwise agreement.','Guard the always-Half scratch and counter allocations. Test four splits and both channel slabs.','Validate ordered launches first; audit native counter visibility and residency assumptions independently of numerical tests.'])
    return six_parts(problem,cta,warp,resources,schedule,trace)


def six_parts(problem, cta, warp, resources, schedule, trace):
    headings=[('problem','1. The whole problem'),('cta','2. One CTA: its concrete subproblem'),
              ('warp','3. Warp and thread ownership'),('resources','4. Resource budget'),
              ('schedule','5. Execution and scheduling'),('trace','6. Trace one token through the source')]
    return ''.join(f'<h2 id="{key}">{title}</h2>{content}' for (key,title),content in zip(headings,(problem,cta,warp,resources,schedule,trace)))


def reconstruction(kind, fp8, view=False, mode=''):
    typ='E4' if fp8 else 'Half';step=64 if fp8 else 32;iterations=512//step
    if kind=='ffn':
        warps=4 if view or not fp8 else 8
        text=f'''map CTA to 8x8 positions and four of eight groups; use {warps} warps
initialize two 4096-byte stages and CTA-arrival barriers
stage input 0 using {'channel-plane 4-byte gathers, commit, per-thread wait, CTA wait' if view else 'native 512-byte stripe copies and CTA mbarrier wait'}
load premix W0; projected = Half zero
for t in 0..{iterations-1}:  # each step reduces K{step}
    issue next input into the other slot, if it exists
    load own shared A; update projected with both K subtiles
    load next W and wait for its input, if it exists
output = Half zero
for hiddenPanel in 0..7:  # only 32 of 256 hidden channels live
    hidden = Half zero
    expand from this group's published projected operands
        {'use two K32 calls across all M/N tiles' if fp8 else 'use four K16 contributions in source order'}
    hidden = recovered Half activation(hidden)
    output += publish_{typ}(hidden) @ this hidden panel's contraction W
publish contracted output only for real native tiles and this group'''
    elif kind=='projection':
        stages=2 if mode=='attention_pool' else 3
        text=f'''map CTA to 8x8 positions and 256 output channels
initialize {stages} stages; load W0; issue input 0..{stages-1}; wait for input 0
for every owned accumulator word:
    read {'plane-view' if mode=='ffn_input_view' else 'native-tiled'} residual R and channel Half scale
    C = HalfMul(decode_if_E4(R), scale)
for t in 0..{iterations-1}:  # K{step} per step
    load shared A; MMA its two instruction-K subtiles into seeded C
    if next exists: load W[t+1]; wait for input[t+1]
    if t+{stages} exists: refill the retired slot with input[t+{stages}]
{'write each row-half word directly to its channel-plane pixel address' if mode=='attention_output_view' else 'publish valid native output vectors from C'}'''
        if mode=='attention_pool':text+=f'''
retain raw Half C after the high-output store
shuffle the four spatial tiles into 2x2 neighborhoods
pooled = HalfMul(HalfAdd(HalfAdd(TL,TR),HalfAdd(BL,BR)), 0.25)
publish_{typ}(pooled) into its separate padded low field'''
    elif kind=='qkv':
        steps=8 if fp8 else 32;stage=4096 if fp8 else 2048
        text=f'''map CTA to one phase-shifted window; head = 4*gridZ + warp
initialize two {stage}-byte input stages; prime input 0 and W0
projected[4 spatial tiles][6 N16 QKV panels] = Half zero
for t in 0..{steps-1}:
    issue next input; read current A; MMA {'two K32' if fp8 else 'one K16'} subtiles
    if next exists: load next W and wait for next input
for each spatial tile:
    separate Q, K, V; normalize Q and K across 32 channels
    multiply Q by the learned head scale; publish Q and K as {typ}
    transpose V words into B-operand order and publish as {typ}
for {'query pair (0,1), then (2,3)' if fp8 else 'query tile 0,1,2,3'}:
    scores = Half bias; accumulate Q*K-transpose
    apply the recovered packed exponential
    {'transpose row-sum ownership; one reciprocal per row; broadcast inverses' if fp8 else 'gather four lane sums in source order; compute Half reciprocal'}
    P = publish_{typ}(normalized scores)
    attended = P*V over all 64 key slots
    publish attended head vectors only for real query tiles'''
    elif kind=='channel':
        text=f'''map CTA to 8x8 positions and one of four 256-channel output slabs
map eight copy warps to four spatial tiles x two instruction-K stripes
initialize three 4096-byte stages; load W0; issue input 0,1,2; wait 0
C[2 spatial][4 N16][4 Half2 words] = Half zero
for t in 0..{iterations-1}:  # each step reduces K{step}
    read both K subtiles for the warp's two spatial fragments
    MMA into C, K subtile 0 before 1 for every result
    if next exists: load next W; wait for next stage
    if t+3 exists: refill the retired slot
publish_{typ}(C) at the C1024 native-tile stride; clip synthetic tiles'''
    else:
        text=f'''select split = OrderedSplit-1 if nonzero, otherwise gridZ
map CTA to one low 4x4 tile and 256 output channels; two warps
initialize two 1024-byte stages; prime split's first A and W
partial = Half zero
for t in 0..{256//step-1}:  # K{step} per step, K256 per split
    issue next A; read current A; update partial; load/wait next if present
if split > 0 and native mode: wait for predecessor counter
{'CTA synchronize only for native predecessor-wait path' if fp8 else 'CTA synchronize for every split > 0, including OrderedSplit mode'}
if split == 0: store partial into always-Half global scratch
if split in (1,2): reduce partial into that scratch in predecessor order
if split == 3:
    low = HalfAdd(scratch, partial)
    for each of four high quadrants:
        nearest = indexed shuffle of low token/channel words
        merged = HalfAdd(nearest, HalfMul(decode(skip), Half scale))
        publish_{typ}(merged) only for in-field high tiles
CTA synchronize; leader release-stores completion counter
# Helper calls show source composition; inspect SASS for compiler contraction.'''
    return '<h3>Reconstruction algorithm</h3>'+pseudo(text,'Build this entry in source dependency order')


def budget(path, stages, stagebytes, warps, limit, arrays, extra=''):
    rows=[('CTA threads',str(warps*32),'block=(32,'+str(warps)+')'),
          ('Shared data',f'{stages*stagebytes:,} bytes',f'{stages} slots × {stagebytes:,} bytes'),
          ('Shared barriers',f'{stages*8} bytes',f'8-byte barriers at {stages*stagebytes:,}+8·slot'),
          ('Declared static shared',f'{stages*(stagebytes+8):,} bytes','512-byte base alignment; no separate shared weight tile'),
          ('Compiler register ceiling',str(limit)+' registers/thread','__maxnreg__; not the compiled count')]+arrays
    table='<table><thead><tr><th>Resource</th><th>Source-level size</th><th>Meaning / lifetime</th></tr></thead><tbody>'+''.join('<tr>'+''.join('<td>'+v+'</td>' for v in row)+'</tr>' for row in rows)+'</tbody></table>'
    return table+f'''<p>A uint4 names four 32-bit register words; an accumulator word holds two Half scalars. These array counts describe the source's logical state. They are not additive estimates of physical registers: inlining, overlapping lifetimes, scalarization and spilling change the allocation. The shared declaration is a byte count, while an occupancy calculation must also honor the target GPU's allocation granularity, register file, thread limit and resident-block limit. The profiler evidence below is the place to establish actual registers, spills and occupancy.</p>{extra}'''+cut(path,'__shared__',6,caption='The allocation and alignment in this entry')+'<!-- RESOURCE_EVIDENCE -->'


def lane_contract(fp8,frags,cols):
    inst='mma.sync.aligned.m16n8k32.row.col.f16.e4m3.e4m3.f16' if fp8 else 'mma.sync.aligned.m16n8k16.row.col.f16.f16.f16.f16'
    text=f'''<p>One warp's result has {frags} M16 spatial fragments and {cols//16} N16 channel panels. For lane l, let g=l/4 and q=l%4, using integer division. In one N16 panel, word 0 holds row g at columns 2q and 2q+1; word 1 holds row g+8 at the same pair; words 2/3 add eight columns. Native matrix row g maps to physical x=g%4,y=g/4; row g+8 adds two to y. A lane therefore owns pieces of two tokens. It never owns a complete dot product independently.</p><p><code>{inst}</code> is a converged 32-lane operation. Four A words and two B words per lane collectively describe its operands; two Half2 accumulator words per lane describe the N8 result. Two N8 instructions build an N16 panel. Input fragments are reused across output panels; a weight bundle is reused across the warp's spatial fragments. The diagram maps Half C/D words in both modes. {'FP8 A bytes are formed by explicit E4 publication; do not reinterpret a Half accumulator array as FP8 without that conversion.' if fp8 else 'Half accumulator words can be forwarded to the next A role only where the source helper establishes that layout contract.'}</p>'''

    a='4q+16·floor(i/2)+b, b=0…3' if fp8 else '2q+8·floor(i/2)+b, b=0…1'
    b='4q+16j+b, b=0…3' if fp8 else '2q+8j+b, b=0…1'
    text+=f'<table><thead><tr><th>Lane operand</th><th>Instruction coordinates after packing</th></tr></thead><tbody><tr><td>A word i=0…3</td><td>row g+8(i%2); K channels {a}</td></tr><tr><td>B word j=0…1</td><td>column g; K channels {b}</td></tr><tr><td>C/D</td><td>row g or g+8; output pair 2q/2q+1</td></tr></tbody></table><p>These are matrix-instruction coordinates. The model channel order is supplied by the matching packed weights and publication helpers; it cannot be inferred from a raw uint4 alone.</p>'
    return text+cut(S+'intrinsics.cuh','void MmaE4' if fp8 else 'void MmaHalf',13,caption='The exact converged matrix instruction and register operand list')


def copy_contract(view=False):
    if view:
        text='''<p><code>CopyAsync4</code> emits <code>cp.async.ca.shared.global</code> for four bytes. <code>CopyCommit</code> commits the issuing thread's copies; <code>CopyWait0</code> waits for that thread's groups. The following CTA-wide <code>ArriveAndWait</code> is still necessary because the consuming lane may read words gathered by another thread. Invalid spatial words are explicitly zero-filled. The gather permutes image coordinates into fragment order; it does not apply an XOR bank swizzle.</p>'''
    else:
        text='''<p><code>CopyBulk</code> selects its implementation by target architecture. On SM90+ an elected lane issues the ordinary-address bulk asynchronous transfer and the mbarrier expects its byte count. On SM80/SM89 each warp lane copies sixteen bytes with <code>cp.async.cg.shared.global</code>; the helper attaches completion to the barrier, and transaction-byte expectation is unused. This is not a tensor-map descriptor or a software L2 allocation. The full CTA initializes and arrives at the barriers, including lanes that zero-fill invalid tiles.</p>'''

    excerpt=code(F+'common/intrinsics.cuh',8,29,'Four-byte gather, commit and wait instructions') if view else code(S+'intrinsics.cuh',236,271,'Target-selected bulk or striped async copy and its completion attachment')
    return text+excerpt+code(S+'memoryops.cuh',9,19,'Arrive on this mbarrier phase and poll its returned phase token')


def ring(stages,steps,full=False):
    if full:
        order=f'Load W0, issue input 0 through {stages-1}, and wait for input 0. Iteration t loads its A vectors, performs all MMA work, loads W[t+1], and waits for input[t+1]. Only after that full-CTA arrival does it issue input[t+{stages}] into the retired slot.'
    else:
        order='Load W0, issue input 0, and wait for it. Iteration t issues input[t+1] into the other slot before reading its own A vectors and performing MMA. It then loads W[t+1] and waits for the next input. When a slot comes around again, every warp has already passed the intervening wait after reading the previous contents.'
    return f'''<p>{order} There are {steps} K iterations. Conditions suppress the last nonexistent prefetch, refill and wait. Keep the outer reduction loop rolled as in the source and unroll the fixed M/N/K-subtile loops: constant fragment indices can become register selections without duplicating the entire reduction program.</p><p>These arrows specify legal data dependencies, not a guarantee that a measured GPU overlaps every copy with arithmetic. Similarly, <code>__ldca</code> requests cache-all global weight loads and <code>StoreNoAllocate</code> requests an aligned 128-bit global store without allocating an L1 line; neither instruction guarantees an L2 hit. Check the matching NCU counters before claiming latency hiding, bandwidth savings, bank-conflict freedom or absence of spills.</p>'''


def finish_trace(fp8,checks):
    return f'''<h3>Instruction and evidence boundary</h3><p>The explicitly managed storage is global allocations, shared stages and per-lane registers. L2 and L1 are hardware-managed caches on relevant accesses. Shared A vectors are loaded with ordinary aligned uint4 dereferences; there is no ldmatrix instruction or extra XOR shared-memory swizzle in these entry bodies. Bank indexing for a 32-bit word is <code>(byteOffset/4)%32</code>. A 16-byte lane vector spans four banks. Repeated bank indices across a whole warp do not alone prove serialization: the actual instruction's transaction decomposition and broadcast behavior matter.</p>{numerical(fp8)}<!-- NCU_EVIDENCE --><h3>Reconstruct and check in dependency order</h3><ol>'''+''.join('<li>'+x+'</li>' for x in checks)+'''</ol><p>These are reconstruction checks, not a claim that this documentation build ran them. Match layouts and numerical order first; use the attached capture and its exact launch conditions when evaluating performance.</p>'''


def ffn(name,fp8,view):
    e=1 if fp8 else 2;typ='E4M3' if fp8 else 'Half';prec='fp8' if fp8 else 'fp16'
    path=F+prec+'/'+name+'.cu';warps=4 if view or not fp8 else 8;frags=4 if warps==4 else 2
    steps=8 if fp8 else 16;step=64 if fp8 else 32;limit=(168 if view else 128) if fp8 else 255
    problem=f'''<p><code>{name}</code> is the first half of a C512 feed-forward block: a dense premix followed by eight independent grouped MLPs. At the 4K model geometry, X and output B have logical shape [68,120,512], or 8,160 tokens. {'Record 23 supplies X as a channel-plane view.' if view else 'X already uses native 4×4 tile storage in the ordinary C512 encoder/decoder blocks.'} A separate postmix/residual kernel follows this one.</p><p>For token p, compute u=X[p,:]Wpre with Wpre[512,512]. Group g reads u[64g:64g+64], expands it with Wexpand[g][64,256], applies the recovered activation, and contracts with Wcontract[g][256,64]. Concatenate the eight 64-channel outputs; do not sum groups or feed every group all 512 premixed channels. Operand publication occurs after premix and after activation, even when values stay in registers.</p>'''+graph(name,[('X for each token',['512 input channels',typ+(' channel-plane view' if view else ' native tile')],'tensor'),('Dense premix',['512 → 512','all input channels contribute'],'compute'),('Eight disjoint groups',['64 premixed channels / group','group-specific matrices'],'tensor'),('Grouped expansion',['64 → 256 + activation','eight 32-hidden panels'],'compute'),('Grouped contraction',['256 → 64','same group, no cross-group sum'],'compute'),('B, contracted branches',['[68,120,512]','separate postmix follows'],'storage')],'The fused kernel removes global u and hidden tensors while preserving their arithmetic/publication boundaries.')
    cta=f'''<p>One CTA owns an 8×8 region and four groups, hence 64×256 final values. Block=(32,{warps}); grid Z chooses groups 0–3 or 4–7. At H=68,W=120 the spatial grid is (15,9), so grid=(15,9,2) launches 270 CTAs. The last CTA row contains four real pixel rows and four synthetic rows; output bounds suppress the synthetic stores. Native reads broadcast a singleton tile dimension, but other incomplete edges use zeros. A view gather applies its explicit pixel-bound checks.</p><p>CTA (0,0,0) computes pixels y=0…7,x=0…7 and groups 0…3. The worked trace follows its token (0,0), group 2, output channel 128. Four native 4×4 tiles make the region. K=512 premix work is never split between CTAs: each selected group finishes its entire reduction locally.</p>'''+cta_figure(name,'ffn',warps,64,256,'4K grid (15,9,2): 270 CTAs',['Four groups × 64 output channels','Premix K512, then group K64/K256','No global u / hidden allocation'])
    warp=f'''<p>Group is <code>warp%4+4·blockIdx.z</code>. {'The four-warp profile assigns all four M16 spatial fragments to each group warp.' if warps==4 else 'Eight warps split spatial ownership: warp/4 selects the upper or lower tile row and warp%4 selects one group; each warp owns two M16 fragments.'} In CTA (0,0,0), warp 2 computes group 2, channels 128…191. Its lane 0 carries token (0,0) in words 0/2 and token (2,0) in words 1/3 for the first spatial tile. Once premix completes, all operands for its grouped expansion and contraction are within that warp.</p>'''+warp_figure(name,'ffn',warps,frags,64,128)+lane_contract(fp8,frags,64)
    resources=budget(path,2,4096,warps,limit,[('Premix accumulator',f'{frags*16} words/lane',f'[{frags}][4 N16][4 Half2 words]'),('Contracted output',f'{frags*16} words/lane','live across eight hidden panels'),('Current hidden panel',f'{frags*8} words/lane','32 hidden channels only'),('Premix A / B arrays',f'{frags*8} / 32 words/lane','A: uint4[M][2], B: uint4[2][4]')],'<p>The central fusion tradeoff is the simultaneous lifetime of projected u, the contracted output and one hidden panel. The entire 256-hidden-channel tensor is never declared. The FP8 ordinary eight-warp profile halves spatial fragments per warp; the FP8 input-view profile keeps four fragments and has a different register ceiling.</p>')
    schedule=schedule_figure(name,steps,2,4096,['8 × (expand → activate → contract)','Store contracted B only'],gather=view)+ring(2,steps)+copy_contract(view)+f'''<p>After K512 premix, shared input slots are no longer read. The hidden loop visits panels 0…7, each representing 32 hidden channels. Initialize the panel, reduce 64 group inputs, activate it, publish it as an operand and accumulate its contraction into B before the next panel. {'Expansion uses two K32 calls, each across all M/N tiles; contraction consumes one K32 per hidden panel.' if fp8 else 'Expansion uses four K16 contributions; contraction uses two K16 contributions per hidden panel.'} The output accumulator persists across all eight panels.</p>'''+cut(path,'// Prime the weight',30,caption='Premix prologue, asynchronous overlap and the first accumulator lifetime')
    trace=f'''<p>Fix CTA=(0,0,0), group 2/warp 2, spatial fragment 0, consumer lane 0. Follow token p=(0,0), first through input channel k={step}, then through premix u[p,128], hidden panel 0 and final B[p,128]. Other channels and tokens are simultaneously represented by the warp; the trace highlights one dependency chain, not a scalar execution lane.</p>'''
    if view:
        trace+=f'''<h3>6.1 Gather this pixel directly into native shared order</h3><p>For stage t=1, the four-byte word ordinal j=0 selects local y=0,x=0, source channel panel 4 and component 0. Each panel holds {'16 E4' if fp8 else '8 Half'} values. The source address is <code>((4·68+0)·120+0)·16+0 = 522240</code> bytes. Destination is <code>4096·(1%2)+4·0 = 4096</code>. Producer warp 0/lane 0 issues this word; consumer warp 2/lane 0 later reads it as the beginning of its uint4 A vector. Thus source panel 4 begins at logical input channel {step} for this precision.</p><p>General j=32·producerWarp+lane+128·copyIndex maps y=4⌊j/512⌋+⌊j/64⌋%2+2(j%2), x=4(⌊j/256⌋%2)+⌊j/16⌋%4, panel=4t+2(⌊j/128⌋%2)+⌊j/2⌋%2, component=⌊j/4⌋%4. There are eight copies per thread: 128×8×4=4096 bytes. This is the complete image-to-fragment permutation.</p>'''+cut(path,'const int sl_Word',25,caption='Four-byte gather: independently derive y, x, panel, component and shared destination')
        src=['t=1, panel=4, component=0','X + 522,240 bytes; token (0,0)','producer warp 0 / lane 0']
    else:
        trace+=f'''<h3>6.1 Copy the already-packed token stripe</h3><p>A native tile holds 16×512×{e}={8192*e:,} bytes. For tile 0 and reduction t=1, its first instruction-K stripe starts at <code>(2t+0)·512 = 1024</code> bytes. Producer warp 0 copies this 512-byte stripe to shared slot 1 at 4096. Consumer warp 2 reads the same bytes for a different output group; copy ownership and compute ownership are different. Its uint4 at shared 4096 begins with the selected token's first channel in this K panel.</p>'''+cut(path,'const int KSubtileIndex',32,caption='The copy warp selects K stripe and spatial tile, independently of its group')
        src=['t=1, native tile=0, stripe=2','X + 1,024 bytes; token (0,0)','producer warp 0; consumer warp 2']
    trace+=trace_figure(name,src,['slot 1 starts at byte 4,096','lane 0 vector → words at 4096…4108','banks 0,1,2,3; no XOR swizzle'],['Wpremix + 36,864 → B registers','A × B → u[p,128] in Half','group 2: expand → φ → contract'],[f'B + {2048*e:,} bytes','token (0,0), group 2 first panel','16-byte StoreNoAllocate'])
    trace+=f'''<h3>6.2 Load weights and update this token's premix fragment</h3><p>For t=1, group 2, lane 0, K subtile 0 and N16 panel 0, weight address is <code>t·{step}·512·{e}+2·2048 = 36864</code>. The second K subtile adds 16,384 bytes and an N16 panel adds 512. <code>__ldca(uint4*)</code> sends these lane vectors directly to registers; weights have no shared allocation. The A load at shared 4096 has bank indices 0…3 for its four words, but an instruction-level bank-conflict conclusion needs NCU. The accumulator <code>r_Projected[0][0][0]</code> carries the pair including u[p,128] after all {steps} iterations.</p>'''+cut(path,'const uint64_t g_WeightTileBase',13,caption='Global packed weights: group base, K stride and N16 stride')+cut(path,'uint4 r_Input[Profile::SpatialFragments][2]',13,caption='The source loads A from shared as uint4 and reuses it across N16 results')
    trace+=f'''<h3>6.3 Reuse the premix and stream one hidden panel at a time</h3><p>Group 2 expansion begins at <code>(262144+2·16384)·{e}={294912*e:,}</code> bytes; contraction begins at <code>(393216+2·16384)·{e}={425984*e:,}</code>. The record lays out all expansions before all contractions. It does not interleave them per group. <code>LoadWindowFfnInputFragment</code> maps premix C/D words into the next A operand. {'It converts Half pairs with PackHalfPairsE4 and joins adjacent N16 panels. The first word packs D words 0 and 2, and the next word packs 1 and 3, preserving token row while joining channel groups.' if fp8 else 'It directly forwards the selected N16 panel words 0,1,2,3 as a K16 A fragment.'} No global u store is involved.</p><p>For each of eight hidden panels, the activation first clamps a copy b=clamp(x,−4,4), then uses two Half FMAs and a final Half multiply to evaluate <code>x·(b·(−0.055908203125·abs(b)+0.447265625)+0.89453125)</code>. The original x, not clamped b, is the final multiplier. This is the recovered activation, not a library SiLU. Publish the activated hidden panel in {'E4' if fp8 else 'Half'} before its contraction; changing this quantization point changes the model's arithmetic.</p>'''+cut(path,'for (int HiddenTileIndex',48,caption='One 32-channel hidden panel: expand, activate, contract while its lifetime is local')+code(F+'common/window_ffn.cuh',28,48,'The exact register-to-operand publication map')
    trace+=f'''<h3>6.4 Publish only the final contracted tensor</h3><p>For tile q and group g, vector base is <code>B+q·{8192*e}+g·{1024*e}+16·l</code>. Our q=0,g=2,l=0 gives <strong>{2048*e:,} bytes</strong>. {'Two packed E4 vectors cover 64 channels; each combines two adjacent N16 accumulator groups.' if fp8 else 'Four Half uint4 vectors cover 64 channels, one N16 group each.'} Spatial bounds run before stores. Each valid token/group has one warp writer, so the output uses no atomics. Group ownership preserves token p through all three pointwise matrices; its companion row in lane 0 is never added to p.</p>'''+cut(path,'// Publish contracted',24,caption='Guard spatial ownership and store the group at its native output offset')
    trace+=reconstruction('ffn',fp8,view=view)
    trace+=finish_trace(fp8,['Start with separate scalar premix/expand/contract tensors and identity or permutation matrices; distinguish every group.','Validate the worked input, shared and output byte offsets with tagged elements before adding MMA.','Compare source-ordered Half arithmetic and each operand publication boundary; an FP32 sum is not a bitwise MMA oracle.','Exercise both grid-Z slabs, the final four real rows, singleton input policy, and every stage wrap.'])
    return six_parts(problem,cta,warp,resources,schedule,trace)


def projection(name,fp8,mode):
    e=1 if fp8 else 2;typ='E4M3' if fp8 else 'Half';prec='fp8' if fp8 else 'fp16'
    isffn=mode in ('ffn','ffn_input_view');inplane=mode=='ffn_input_view';outplane=mode=='attention_output_view';pool=mode=='attention_pool'
    warps=8 if mode=='attention' else 4;frags=2 if warps==8 else 4;stages=2 if pool else 3;steps=8 if fp8 else 16;step=64 if fp8 else 32
    if mode in ('ffn','attention'):path=P+prec+'/spatial_projection_'+prec+'.cu'
    elif inplane:path=F+prec+'/'+name+'.cu'
    elif outplane:path=A+prec+'/'+name+'.cu'
    else:path=D+prec+'/'+name+'.cu'
    op='FFN postmix' if isffn else 'attention output projection';inp='contracted grouped-FFN branches' if isffn else 'attended head features';res='original block input' if isffn else 'published FFN output'
    limit=168 if warps==8 or pool else 128
    problem=f'''<p><code>{name}</code> computes the C512 {op}. Its matrix input is the {inp}; its independent residual R is the {res}. Both are logically [68,120,512] at 4K. For token p and channel n, the model dependency is <code>raw[p,n]=Input[p,:]W[:,n]+scale[n]·R[p,n]</code>, with W[512,512] and 512 learned Half scales. The implementation seeds C with the rounded scaled residual before accumulating K; adding R afterward is a different Half rounding sequence.</p><p>{'This is the record-23 postmix: only its original residual uses a channel-plane view; the grouped-FFN branch is already native tiled.' if inplane else 'This record-47 boundary writes a channel-plane view for the next decoder transition.' if outplane else 'This record-30 boundary saves the high-resolution skip and pools the raw Half result for the C512→C1024 channel projection.' if pool else 'The ordinary entry serves C512 blocks whose boundaries do not require specialized view conversion or pooling.'} {'The pooled field has valid [34,60] values and is padded to [36,60]. Pool raw Half C/D, before high-output publication.' if pool else 'The matrix is pointwise: no neighboring spatial token contributes to this projection.'}</p>'''+projection_graph(name,inp,res,'Y',typ,pool,outplane)
    cta=f'''<p>A CTA produces 64 positions ×256 channels from an 8×8 region. With spatialColumns=ceil(120/8)=15, <code>blockIdx.x/15</code> selects one of two output slabs and <code>blockIdx.x%15</code> selects the spatial X region. Grid=(30,9,1), 270 CTAs. Every CTA reduces all K=512 channels; it does not split K. CTA (0,0,0) owns pixels 0…7 in both axes and channels 0…255.</p><p>{'Each CTA also owns the corresponding 4×4 pooled tile for its 256 channels. The high and pooled outputs fork from raw C/D and have distinct spatial domains.' if pool else 'At H=68 the bottom CTA includes four real and four synthetic pixel rows; publication clips to the real tile domain.'} Native input reads broadcast a singleton tile dimension and zero-fill other out-of-domain tiles. Store bounds still describe the real destination.</p>'''+cta_figure(name,'projection',warps,64,256,'4K grid (30,9,1): 270 CTAs',['K512 → 256 output channels','Independent residual seeds C',('Second output: pooled 4×4 tile' if pool else 'One pointwise result per real token')])
    warp=f'''<p>Warp channel base is <code>256·slab+64·(warp%4)</code>. {'Eight warps divide the region into upper/lower native-tile rows through warp/4; each owns two M16 spatial fragments.' if warps==8 else 'Each of four warps owns all four M16 fragments for one 64-channel band.'} {'The full-window ownership keeps all four raw tiles needed for pooling inside one warp.' if pool else 'View conversion uses the lane and row-half bits to address the final pixel packet directly.' if inplane or outplane else 'Each output band is independent after the shared A stage is ready.'} The trace uses warp 2, channel base 128, first spatial fragment, lane 0.</p>'''+warp_figure(name,'projection',warps,frags,64,128)+lane_contract(fp8,frags,64)
    arrays=[('Half C/D accumulator',f'{frags*16} words/lane',f'[{frags} M16][4 N16][4 words], seeded from R'),('Current A operands',f'{frags*8} words/lane','uint4[M][2 K subtiles]'),('Current B operands','32 words/lane','uint4[2][4], global weight loads')]
    if pool:arrays.append(('Pooled accumulator','16 words/lane','[1 M16][4 N16][4 words], after the K loop'))
    resources=budget(path,stages,4096,warps,limit,arrays,'<p>Residual vectors and scales are temporary register inputs; there is no shared residual tensor. '+('Four raw tiles remain live while the high output is published and the pooled tile is assembled.' if pool else 'The output accumulator remains live through the whole K reduction.')+'</p>')
    tail=('Shuffle and average raw 2×2','Store high and pooled outputs') if pool else ('Convert accumulator layout','Store channel-plane words' if outplane else 'Store native tile vectors')
    schedule=schedule_figure(name,steps,stages,4096,tail,full_prefill=True)+ring(stages,steps,True)+copy_contract()+f'''<p>After the prologue, read R and its channel scales into the accumulator before the first MMA. The {steps} K iterations add the projected branch to that seed. {'After the reduction, store the high skip but retain its raw Half values; pooling consumes them before conversion to E4 or Half output.' if pool else 'After the final K step, the destination view determines whether the writer stores full native uint4 vectors or individual pixel words.'} Weights stay in register vectors throughout; only Input A has cross-warp shared reuse.</p>'''+cut(path,'// Keep K sequential',26,caption='The exact reduction/prefetch/wait/recycle order')
    trace=f'''<p>Follow CTA (0,0,0), warp 2, lane 0, token (0,0), output channel 128. This token has two independent incoming edges: Input[p,:] supplies matrix A and R[p,128] supplies the initial C. Keep those addresses separate.</p><h3>6.1 Seed C from the correct residual allocation</h3><p>The matrix record consumes {262144*e:,} bytes, then 1,024 bytes of Half scales. Scale 128 begins at <code>W+{262144*e}+2·128 = W+{262144*e+256:,}</code>. Scale 129 is its neighboring Half. These remain Half in the FP8 entry. The selected pair seeds word 0 of the first N16 accumulator after HalfMul.</p>'''+cut(path,'uint32_t r_ResidualScales',14,caption='Scale addressing is by output channel, independently of input-K')
    if inplane:
        panel=8 if fp8 else 16;roff=panel*68*120*16
        trace+=f'''<p>For this plane-view residual, p=(0,0), rowHalf=0 and lane=0 select panel {panel}, component 0. The address is <code>((panel·68+y)·120+x)·16+4(lane&amp;3)={roff:,}</code>. {'The four-byte E4 word contains both N8 channel-pair contributions; shift by 16·N8 before DecodeE4 selects the desired Half2 pair.' if fp8 else 'The four-byte word already holds the two Half channels for this N8 panel; the upper N8 half uses the next complete channel plane.'} The projection input A still uses native tiles; “input view” does not mean A is gathered here.</p>'''+cut(path,'const int g_PixelY',25,caption='Plane-view residual: pixel, channel panel, pair selection and Half seed')
    else:
        trace+=f'''<p>The residual native vector base is <code>R+tile·{8192*e}+channelBase·{16*e}+16·lane</code>. Our tile 0,base 128,lane 0 gives <strong>{2048*e:,}</strong> bytes. {'Decode the E4 pieces into Half2 before the multiply; matching N8/row-half words must receive the matching scale pair.' if fp8 else 'Its four words already hold the Half2 channel pairs for two row halves and two N8 halves.'} This seed is retained through every K update.</p>'''+cut(path,'const uint64_t g_ResidualTileBase',28,caption='Native residual load and accumulator seeding')
    trace+=f'''<h3>6.2 Stage Input and keep weights in a different storage path</h3><p>At reduction t=1, the native A stripe starts at Input+1024; slot 1 starts at shared+4096. Consumer warp 2/lane 0 reads shared 4096, carrying token (0,0)'s first value from this K panel. The native packing is copied unchanged, without XOR swizzle. Its four shared words address banks 0…3. For channel base 128, N16=0 and first K subtile, weight address is <code>1·{step}·512·{e}+128·32 = 36864</code>. Each second instruction-K bundle adds 16,384, and each N16 bundle adds 512 bytes. Direct __ldca weight loads bypass shared storage.</p>'''+trace_figure(name,['Input native tile 0, t=1','A stripe starts at byte 1,024','R has an independent address'],['slot 1; A vector byte 4,096','four words → banks 0,1,2,3','shared A reused by output bands'],['W + 36,864 → B registers','HalfMul(R,scale) seeds C','MMA adds all K512 contributions'],[('Pixel-plane word' if outplane else 'Native lane vector'),f'first native offset {2048*e:,} bytes',('raw C also feeds pooled (0,0)' if pool else 'one writer per channel band')])
    trace+=cut(path,'const uint64_t g_ReductionBase',17,caption='Matrix B is a packed global vector load')+cut(path,'uint4 r_Input[SpatialTiles][2]',14,caption='Shared A fragments and the MMA update of the residual-seeded C/D')
    trace+=f'''<h3>6.3 Follow the token through the converged MMA</h3><p>All 32 lanes jointly issue two N8 operations per N16 panel and two instruction-K subtiles per iteration. The selected C/D word remains lane 0, spatial fragment 0, N16 panel 0, word 0, although operands for its dot product are distributed across the warp. Each A fragment participates in four N16 panels; each B bundle serves {frags} spatial fragments. This reuse explains the tiling choice; actual speedup, cache hits and tensor-pipe utilization require the attached capture.</p><h3>6.4 Route the final raw value to this entry's destination</h3>'''
    if pool:
        trace+=f'''<p>The first writer publishes high token (0,0) at native output offset {2048*e:,}. Keep the raw Half result alive. Pooling combines tokens (0,0),(0,1),(1,0),(1,1) into pooled token (0,0), using the exact tree <code>HalfMul(HalfAdd(HalfAdd(TL,TR),HalfAdd(BL,BR)),0.25)</code>. <code>PoolHorizontalWords</code> routes tile/row-half words, exchanges lane bits 2 and 3, then gathers source-lane XOR 0,4,16,20. No shared pooled image is formed. The pooled native channel-128 vector also has offset {2048*e:,}, but in a different allocation.</p><p>At 4K, 68/2=34 valid pooled rows occupy a 36-row field. Zero-filled synthetic high tiles supply the padded region according to the actual source bounds. Pooling already-published E4 bytes would introduce an extra quantization boundary and produce a different result.</p>'''+code(S+'window_pool.cuh',7,40,'The spatial shuffle network and three-add/quarter-multiply tree')+cut(path,'// Pool the unquantized',24,caption='A second consumer reads the raw projected values before working-format publication')
    elif outplane:
        panel=8 if fp8 else 16;off=panel*68*120*16
        trace+=f'''<p>The channel-plane destination assigns a word to <code>((panel·68+y)·120+x)·16+4(lane&amp;3)</code>. For p=(0,0),base 128,first N16,lower N8,lane 0, panel={panel}, so output word offset is <strong>{off:,}</strong>. {'Pack the lower/upper N8 Half pairs for the same pixel into one E4 word; the two row halves are different pixels.' if fp8 else 'The lower/upper N8 halves occupy separate entire channel planes. Words 0/1 select the two pixel rows in the lower plane; words 2/3 select the same rows in the upper plane.'} This writer stores per-pixel words; do not replace it with the ordinary native uint4 publication. Direct output addressing removes a separate layout-conversion pass.</p>'''+cut(path,'const int g_PixelY',23,caption='The final address implements output view conversion word by word')
    else:
        trace+=f'''<p>The native output starts at <code>Y+tile·{8192*e}+128·{16*e}+16·0</code>, hence Y+{2048*e:,}. {'Each uint4 packs two N16 groups after E4 conversion, yielding two vectors for the warp band.' if fp8 else 'Each uint4 directly holds one N16 result, yielding four vectors for the warp band.'} StoreNoAllocate requests a 16-byte global store without L1 allocation. The bounds check clips synthetic spatial tiles. No output atomic is needed because the CTA/channel decomposition supplies a unique writer.</p>'''+cut(path,'// Write each projected',25,caption='Native publication preserves the next kernel’s packed operand order')
    trace+=reconstruction('projection',fp8,mode=mode)
    trace+=finish_trace(fp8,['Zero W and distinguish every residual channel/scale: prove that the independent R branch seeds the correct C word.','Use identity and non-diagonal permutation W with zero scales to isolate A/B addressing.','Exercise both channel slabs, upper/lower warp ownership and bottom-edge clipping.',('Compare raw-Half pooling with the exact four-token tree, including padding and E4 quantization.' if pool else 'Decode the destination layout independently and check the trace address plus both N8/row-half branches.')])
    return six_parts(problem,cta,warp,resources,schedule,trace)


def qkv(name,fp8):
    e=1 if fp8 else 2;typ='E4M3' if fp8 else 'Half';prec='fp8' if fp8 else 'fp16';path=A+prec+'/'+name+'.cu'
    stage=4096 if fp8 else 2048;steps=8 if fp8 else 32;step=64 if fp8 else 16;sub=2 if fp8 else 1
    problem=f'''<p><code>{name}</code> fuses C512 QKV projection and complete window attention for records 23–30 and 40–47. Its input is published FFN output Z[68,120,512] at 4K; its output A has the same shape. It contains Wqkv[512,1536], sixteen heads of width 32, Q/K channel normalization, learned query scaling, score normalization, and P×V. A separate attention projection/residual kernel follows.</p><p>For each 8×8 window and head, Q,K,V are [64 tokens,32 channels]. Normalize Q and K independently across channels, multiply Q by its learned scalar, and compute S=QKᵀ+bias, shape [64,64]. The recovered E(S)/rowSum(E(S)) creates P, then A=PV. E is a clamped packed-bit exponential surrogate, not standard exp(score−max). This local path has no extra √32 multiplier and retains zero-padded key slots in its denominator.</p>'''+graph(name,[('Window Z',['64 positions × 512 channels',typ+' global input'],'tensor'),('QKV projection',['512 → 1536','six N16 panels / head'],'compute'),('Normalize Q and K',['32 channels / token','Q alone gets learned scale'],'compute'),('Scores + bias',['64 queries × 64 keys','current panels stay in registers'],'compute'),('Recovered normalization',['packed E / source-ordered row sum',typ+' probability operands'],'compute'),('P × V',['64 keys → 32 head channels','concatenate sixteen heads'],'storage')],'The full score matrix is a logical dependency; it is not a global-memory allocation in this entry.')
    cta=f'''<p>One CTA owns a phase-dependent 8×8 window and four complete heads: four warps, 128 threads. Grid Z has four slabs; head=4·blockIdx.z+warp. For unshifted H=68,W=120, the logical coverage is 15×9 windows and four head slabs, 540 CTAs. A −4 X origin uses ceil((120+4)/8)=16 columns; a −4 Y origin still uses ceil((68+4)/8)=9 rows. Thus X-shifted phases launch 576 CTAs and unshifted-X phases launch 540, with four head slabs in each case. This is padding/cropping, not a cyclic image roll.</p><p>CTA (0,0,0) at origin (0,0) consumes pixels 0…7 and supplies heads 0…3. At origin (−4,−4), only its lower-right native 4×4 tile lies in the field. Input predicates zero-fill invalid tiles; invalid query tiles do not store. The fixed 64-key attention computation still includes the padded key slots.</p>'''+cta_figure(name,'qkv',4,64,4,'Unshifted 4K coverage: 15 × 9 windows × 4 head slabs',['One window, four complete heads','QKV K512, scores K32, P×V K64','Origin phase changes border coverage'])
    warp='''<p>A warp owns all 64 tokens for one head, allowing later attention to remain warp-local. Six N16 projection panels are Q-low,Q-high,K-low,K-high,V-low,V-high. The four M16 spatial fragments are top-left, top-right,bottom-left,bottom-right native tiles. Warp 2/head 2 owns the traced token's full Q/K/V head; other warps compute other heads from shared copies of the same input.</p>'''+warp_figure(name,'qkv',4,4,96,0)+lane_contract(fp8,4,96)
    resources=budget(path,2,stage,4,168,[('Projected QKV','96 words/lane','[4 M16][6 N16][4 Half2 words]'),('Projection A / B',f'{16*sub} / {24*sub} words/lane',f'uint4[4][{sub}] and uint4[{sub}][6]'),('Published Q + K',str(32 if fp8 else 64)+' words/lane','four spatial tiles for each of two roles'),('Transposed V',str(16 if fp8 else 32)+' words/lane','four tiles; four columns; precision-dependent K words'),('Current score panels',str(32 if fp8 else 16)+' Half2 words/lane','two M16 query panels' if fp8 else 'one M16 query panel')],'<p>Projection storage can become dead while Q/K/V representations are formed. The paired E4 score schedule increases score-panel state but avoids repeating each denominator reciprocal in four lanes. These are source lifetimes; only compiled resource evidence establishes the physical peak and spills.</p>')
    schedule=schedule_figure(name,steps,2,stage,['Q/K norm; scores → P → P×V','Store in-field attended tokens'])+ring(2,steps)+copy_contract()+f'''<p>The projection stage advances {'two K32 subtiles (K64 total)' if fp8 else 'one K16 subtile'} per iteration. After K512 is complete, reinterpret Q/K/V accumulator panels, normalize Q and K, publish them and transpose V to the B-operand role. {'Then process query-tile pairs (0,1) and (2,3): score both, transpose denominator ownership, normalize both and apply both to V.' if fp8 else 'Then process query tiles 0,1,2,3 one at a time using AttendWithBias.'} There is no CTA barrier between those warp-local attention operations because no other warp owns this head's values.</p>'''+cut(path,'// Native Half uses',22,caption='The projection loop uses this entry’s precision-specific K/stage shape')
    trace=f'''<p>Fix unshifted CTA (0,0,0), head 2/warp 2, lane 0, token (0,0). Track its Q/K/V values, its query row and its attended head output. As a key/value token it also influences other query rows; the same stored Q/K/V fragments are reused rather than recomputed.</p><h3>6.1 Move the input channel stripe into shared memory</h3><p>At iteration t=1, native tile 0 starts its selected A stripe at <code>Z+{sub*512}</code>. Producer {'warp 0, CopyIndex 0' if fp8 else 'warp 0'} fills shared slot 1 at byte {stage}. Consumer warp 2/lane 0 reads that vector. This input panel starts at logical channel {step}; the first value belongs to the selected token. {'The second K32 stripe adds 512 shared bytes; all four spatial tiles together consume 4096 bytes per stage.' if fp8 else 'Only one K16 stripe exists per spatial tile, so four spatial tiles consume 2048 bytes per stage.'}</p>'''+cut(path,'const int g_LocalY',25,caption='Copy ownership differs between the Half K16 and E4 K64 profiles')
    woff=step*1536*e+6144
    trace+=trace_figure(name,[f'Z + {sub*512:,}: tile 0, t=1',f'first input channel k={step}','producer warp 0, consumer warp 2'],[f'slot 1 at shared byte {stage:,}','lane 0 vector; banks 0,1,2,3','no XOR swizzle / no shared weights'],[f'head-2 W + {woff:,}','Q/K norm → score row → P×V','all attention intermediates in registers'],[f'A + {1024*e:,} bytes','head 2; token (0,0)','clipped native StoreNoAllocate'])
    trace+=f'''<h3>6.2 Build this head's six projected panels</h3><p>Weight address is <code>W+t·{step}·1536·{e}+head·3072+lane·16+kSubtile·49152+N16·512</code>. For t=1,head=2,lane=0,first K/N panel it is <strong>{woff:,}</strong>. The six N16 panels are adjacent at 512-byte spacing; the instruction-K stride is 49,152 bytes, not the 16 KiB C512-output stride. Cached uint4 B loads and shared uint4 A loads feed the converged MMA, leaving Q/K/V in 96 Half2 words per lane.</p>'''+cut(path,'const uint64_t g_WeightTileBase',13,caption='QKV has 1536 output columns and six panels per head')
    trace+=f'''<h3>6.3 Normalize the selected token across four lanes</h3><p>For one 32-channel token, lanes 0,1,2,3 collectively hold all channels. The helper squares upper channel groups, fuses lower-channel squares, combines groups and uses XOR-2 then XOR-1 shuffles. It swaps/adds Half components to form the replicated squared norm, clamps to Half epsilon 0x0410 (0.00006198883056640625), converts to float, executes approximate reciprocal square root, rounds back to Half2 and multiplies every channel pair. Q additionally uses the learned head scalar; K does not; V is not normalized.</p><p>The weight matrix occupies {786432*e:,} bytes. Sixteen Half bias tables occupy 16×8192 bytes. Head-2 float scale is at <code>W+{786432*e+131080:,}</code>, then converted to replicated Half2. These mixed-precision fields are not E4 even in the FP8 entry. Publish Q/K as {'one K32 E4' if fp8 else 'two K16 Half'} fragments. V uses <code>TransposeM8n8</code> to change each packed word into B-operand orientation, with {'E4 conversion of the two transposed row halves' if fp8 else 'both transposed Half row words retained'}.</p>'''+code(S+'warp_window32.cuh',161,191,'Exact channel-norm arithmetic and query-only head scaling')+cut(path,'NormalizeWindow<true>',14,caption='Q/K publication and the V matrix-role transpose')
    trace+=f'''<h3>6.4 Follow query (0,0) across all 64 key slots</h3><p>Its first query panel covers sixteen rows. Bias for head 2,query tile 0,key tile 0,lane 0 starts at <code>W+{786432*e+16384:,}</code>; each key tile adds 512 bytes and each query tile adds 2048. Bias seeds Half scores before QKᵀ. Head width 32 requires {'one K32' if fp8 else 'two K16'} contribution(s). The exponential surrogate uses Half FMA slope 0.044921875/intercept 1.30078125, clamps to [1.03125,1.5693359375], then applies <code>(packedBits&lt;&lt;5)+0x7ff88000</code> with 32-bit wraparound. Do not replace the whole-word shift with independent halfword shifts.</p>'''+code(S+'warp_window32.cuh',194,203,'The packed exponential surrogate')
    if fp8:
        trace+='''<p>Two adjacent query tiles are normalized together. Local denominator vectors are permuted by lane&amp;3, then gathered from base <code>((lane&amp;7)&lt;&lt;2)|(lane&gt;&gt;3)</code> with XOR-indexed gathers. A second permutation restores contributor order before addition. Each lane now owns one of 32 complete row sums and computes one approximate reciprocal. The result is broadcast back with source <code>8r+lane/4</code>. For lane 0 and vector r=0 this is lane 0; lane 13's transpose base is 21. The ownership transform avoids four duplicate inverses per row without changing which key scores contribute.</p>'''+code(S+'warp_window32.cuh',282,310,'Paired row-sum transpose, source-order addition and inverse distribution')+cut(path,'for (int r_FirstTile',23,caption='Pair (0,1), then pair (2,3): concrete query scheduling')
    else:
        trace+='''<p>The Half path normalizes one query tile at a time. It computes local column-pair sums, gathers four lane contributors in explicit order 0,1,2,3, then joins the Half components. This addition tree differs from the XOR tree used for Q/K channel norms. Clamp the row sum with the same epsilon, compute approximate reciprocal, round it to Half and multiply the score words. Do not merge the two normalization helpers merely because both use shuffles.</p>'''+code(S+'warp_window32.cuh',206,238,'Single-panel denominator reduction and Half probability normalization')+cut(path,'const auto r_AttendedTile',15,caption='Query tiles are attended and stored one at a time')
    trace+=f'''<h3>6.5 Consume probabilities as A operands and publish the token</h3><p>P is published to {'E4' if fp8 else 'Half'} before P×V; this is an arithmetic boundary without a global P store. The new reduction axis is 64 key positions, requiring {'two K32' if fp8 else 'four K16'} chunks. Matching transposed V words supply B. The final sixteen-query ×32-channel head fragment is published only after the key reduction. Our token/head first vector goes to <code>A+tile·{8192*e}+head·{512*e}+chunk·512+lane·16</code>, giving <strong>A+{1024*e:,}</strong>. {'One E4 uint4 per lane covers the head.' if fp8 else 'Two Half uint4 vectors per lane cover the head.'} Negative and upper query-tile bounds prevent padded queries from writing.</p>'''
    trace+=reconstruction('qkv',fp8)
    trace+=finish_trace(fp8,['Separate QKV, normalization, scores and P×V in a reference before fusing; distinguish every head and query tile.','Use zero Q/K matrices with varying bias/V to isolate the surrogate and denominator behavior.','Check source-order Half channel norm and row-sum reductions using asymmetric values; uniform values hide lane permutations.','Exercise all origin phases and incomplete boundary windows; retain padded keys but clip invalid query stores.','Check each Q/K/P publication boundary and the final head-specific output offset.'])
    return six_parts(problem,cta,warp,resources,schedule,trace)
