"""Source-backed tutorials for the C32 frontend and C32--C256 window family."""
from html import escape
from common import code, svg, note

K = 'csrc/kernel_impl/'
COMMON = K + 'shared/common/'
FRONT = K + 'shared_input_output_c32/common/'
WIN = K + 'shared_encoder_decoder_c32_c64_c128_c256_fused_window/'
DOWN = K + 'encoder_c32_c64_c128_c256_downsample/'
UP = K + 'decoder_c32_c64_c128_c256_upsample/'
IN16 = K + 'input_c32/fp16/input_preprocess_window_downsample_c32_fp16.cu'
IN8 = K + 'input_c32/fp8/input_preprocess_window_downsample_c32_fp8.cu'
OUT16 = K + 'output_c32/fp16/output_window_postprocess_c32_fp16.cu'


def txt(x, y, text, size=16, color='#172c40', anchor='start'):
    return f'<text x="{x}" y="{y}" font-size="{size}" fill="{color}" text-anchor="{anchor}" font-family="system-ui,sans-serif">{escape(str(text))}</text>'


def box(x, y, w, h, lines, color='#e7f2ff'):
    if isinstance(lines, str):
        lines = [lines]
    return (f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="9" fill="{color}" stroke="#55718a"/>'
            + ''.join(txt(x+13, y+26+i*22, line, 15) for i, line in enumerate(lines)))


def arrow(x1, y1, x2, y2, label='', lx=None, ly=None):
    # A small local triangle avoids cross-figure marker id collisions.
    import math
    a = math.atan2(y2-y1, x2-x1)
    p1 = (x2-10*math.cos(a)+5*math.sin(a), y2-10*math.sin(a)-5*math.cos(a))
    p2 = (x2-10*math.cos(a)-5*math.sin(a), y2-10*math.sin(a)+5*math.cos(a))
    return (f'<path d="M{x1},{y1} L{x2},{y2}" fill="none" stroke="#42647d" stroke-width="2"/>'
            + f'<polygon points="{x2},{y2} {p1[0]},{p1[1]} {p2[0]},{p2[1]}" fill="#42647d"/>'
            + (txt(lx if lx is not None else (x1+x2)/2, ly if ly is not None else (y1+y2)/2-9, label, 13, anchor='middle') if label else ''))


def feature_diagram():
    s = box(20,20,285,92,['Renderer texture allocations','current / history / motion / depth','descriptor transforms + sampling'])
    s += box(380,20,290,92,['Per-pixel registers (FP32/Half)','reflected image lookup; original noise','16 feature channels, Half publication'])
    s += arrow(305,66,380,66,'texture path',342,128)
    s += box(745,20,310,92,['CTA shared: 2 × 64 × uint4','plane 0 = channels 0…7','plane 1 = channels 8…15'], '#fff2d5')
    s += arrow(670,66,745,66,'32 B/pixel',707,128)
    labels = ['0 noise x','1 noise y','2 noise z','3 one','4 current R','5 current G','6 current B','7 history R',
              '8 history G','9 history B','10 constant','11 green','12 blue','13 override G','14 override B','15 zero']
    for i,label in enumerate(labels):
        x = 20+(i%8)*130; y=165+(i//8)*66
        s += box(x,y,122,48,[label], '#e5f4ec' if i < 8 else '#f0e8fa')
    s += txt(20,332,'One pixel occupies 16 bytes in each plane. Whole 8 × 8 window: 2,048 shared bytes.',16)
    s += txt(20,362,'Barrier: every feature store completes before warp lanes gather the adapter A fragments.',16)
    return svg('Renderer inputs become two shared feature planes', '0 0 1080 390', s,
               'Feature order: input_preprocess_window_downsample_c32_fp16.cu:130–145; shared allocation: input_features.cuh:28–33. Texture cache residency is not inferred from this code.')


def adapter_diagram():
    s=txt(20,25,'Worked adapter gather: tile 2 (bottom-left 4 × 4), lane 17',20)
    s+=box(20,55,290,130,['Shared row-major 8 × 8','w0: plane 0, pixel 40 = (0,5)','w1: plane 0, pixel 56 = (0,7)','w2: plane 1, pixel 40 = (0,5)','w3: plane 1, pixel 56 = (0,7)'],'#fff2d5')
    s+=box(385,55,290,130,['A fragment in lane registers','word select = lane & 3 = 1','w0/w1: feature channels 2,3','w2/w3: feature channels 10,11','two rows; each word = 2 Half'])
    s+=arrow(310,115,385,115,'4 × 4 B',348,202)
    s+=box(745,55,305,130,['Tensor Core, warp collective','A: 16 tokens × 16 features','B: 16 features × 8 channels','D: 16 tokens × 8 channels','repeat 4 output column groups'],'#f5e3eb')
    s+=arrow(675,115,745,115,'register A',710,202)
    s+=box(20,245,290,92,['Weight allocation → cache/load','adapter is 1,024 Half bytes','2 vectors/lane × 16 B'])
    s+=box(385,245,290,92,['Raw adapter, Half registers','4 tiles × 16 tokens × 32','retain for scaled FFN residual'])
    s+=box(745,245,305,92,['Published adapter fragments','FP16: same Half words','FP8: convert pairs → E4M3 bytes'])
    s+=arrow(310,282,385,282,'B + MMA',348,357)
    s+=arrow(675,282,745,282,'Publish',710,357)
    return svg('The adapter is always Half, even in the FP8 entry', '0 0 1080 380',s,
               'The exact pixel equation and word selection appear at input_preprocess_window_downsample_c32_fp16.cu:163–185. Tile 2 adds 32 to the shared pixel index; lane 17 selects channel-pair word 1.')


def frontend_lifetime():
    s=box(20,25,255,104,['Raw adapter / merged input','Half accumulator words','kept in registers for residual'])
    s+=box(405,25,255,104,['Published working input','Half or E4M3 fragments','consumed by FFN MMA'])
    s+=box(805,25,255,104,['FFN + attention body','32 → 128 → 32; one head','raw output stays Half'])
    s+=arrow(275,73,405,73,'publish',340,60)+arrow(660,73,805,73,'A operand',733,60)
    s+='<path d="M147,129 L147,165 L790,165 L790,118" fill="none" stroke="#42647d" stroke-width="2"/>'
    s+=arrow(790,118,805,118)
    s+=txt(445,157,'raw adapter → scaled FFN residual inside the body',14,anchor='middle')
    s+=arrow(933,129,933,210,'Half',969,180)
    s+=box(805,210,255,94,['Block-0 raw result [64,32]','registers, then shuffle pool','no C → 2C projection'])
    s+=box(20,210,300,94,['Full-resolution saved skip','published Half/E4M3','global physical 4 × 4 tiles'])
    s+=box(405,210,280,94,['Pooled [16,32]','Half reduction → publication','global channel-plane view'])
    s+=arrow(805,249,685,249,'pool',744,235)
    s+='<path d="M933,304 L933,340 L170,340" fill="none" stroke="#42647d" stroke-width="2"/>'
    s+=arrow(170,340,170,304)
    s+=txt(535,331,'publish full result separately',14,anchor='middle')
    s+=txt(20,363,'FP8 publication does not erase the raw Half branch. Pooling the saved E4M3 skip would change rounding.',16)
    return svg('Input block lifetime: publication and pooling are separate branches','0 0 1080 390',s,
               'Input raw residual: FP16 entry:224–233; FP8 pooling fork:359–374. The body reuses the fused C32 schedule described in the next chapter.')


def output_diagram():
    s=box(20,20,280,90,['Global low C32 plane view','nearest-repeat through shuffles','round(low × input scale)'])
    s+=box(390,20,280,90,['Global block-0 skip','16-byte tile loads via __ldcg','HalfFma(skip, scale, low product)'])
    s+=box(760,20,290,90,['C32 body → Half output head','32 → 4 logical channels','MMA N=8 fragment; use 4'])
    s+=arrow(300,64,390,64,'Half pairs',345,131)+arrow(670,64,760,64,'raw merge',715,131)
    s+=box(20,180,310,117,['Head registers → pixel registers','warp shuffles gather four channels','RGB: OutputScale × head + current','gate: fourth head channel'])
    s+=box(400,180,310,117,['Optional display conversion','clamp(8 × neural RGB + 0.5)','gate weight ≈ sigmoid(head[3])','× clamped external blend scale'])
    s+=box(780,180,270,117,['History texture reconstruction','five filtered texture samples','RGB + weight × (history − RGB)','FP32 RGBA → surface write'])
    s+=arrow(905,110,175,180,'Half head words stay in registers',542,155)
    s+=arrow(330,235,400,235,'FP32',365,317)+arrow(710,235,780,235,'blend',745,317)
    s+=txt(20,355,'No intermediate global [H,W,4] head is required by this fused postprocess entry.',16)
    return svg('Output block 70 combines model inference with rendering composition','0 0 1080 385',s,
               'Source: output_window_postprocess_c32_fp16.cu:26–93,229–355. The optional branches are controlled by ABI flags and texture handles.')


FRONTEND = f'''
<h2 id="frontend-model">Target architecture: input record 0 and output record 70</h2>
<p>These kernels surround the C32 trunk. Record 0 starts from sixteen features at each full-resolution pixel, applies a learned <strong>16 → 32 adapter</strong>, then a dense <strong>32 → 128 → 32 FFN</strong> and one 32-channel attention head over each 8 × 8 window. Its output forks: a published full-resolution C32 skip is saved for record 70; a 2 × 2 average of the raw output supplies the half-resolution C32 field. Record 70 repeats the final low-resolution C32 field to full resolution, combines it with the record-0 skip using two learned channelwise scales, runs another C32 block, and applies a <strong>32 → 4 output head</strong>. Three head values control color; the fourth controls optional history blending.</p>
<p>Read <a href="../ARCHITECTURE.md#entering-and-leaving-the-network">the architecture document's input/output section</a> alongside this chapter. Its prepared-feature tensor is [B,H,W,16]; the deployment frontend additionally implements renderer texture sampling to construct those features. For the documented 3840 × 2160 example the full padded field is [2176,3840,32], while the record-0 pooled path is [1088,1920,32]. One CTA here handles an 8 × 8 full-resolution window. Neither the channelwise adapter nor the FFN exchanges neighboring pixels; only attention and the explicit pool do.</p>
<h2 id="frontend-features">Step 1 — turn renderer samples into sixteen Half features</h2>
<p>The input entry stages two 8-channel planes in CTA shared memory. Each plane is 64 <code>uint4</code> vectors, with one 16-byte vector per pixel. A pixel's channels are therefore split across two shared addresses rather than stored as one 32-byte struct. The cooperative loop indexes pixel <code>p = 32 × threadIdx.y + threadIdx.x</code>, advancing by the CTA's thread count. Under the single-warp schedule each lane stages two pixels. The image position is <code>(8 × blockIdx.x + (p &amp; 7), 8 × blockIdx.y + p/8)</code>.</p>
<p>Padding is part of the network field. The texture lookup reflects an out-of-valid-range coordinate once using <code>2 × validExtent − coordinate − 2</code>, whereas the noise generator receives the original coordinate. Thus a reflected border pixel reuses image information without necessarily reusing the same noise. The reflection formula is not a general repeated-mirror address function for arbitrary distant coordinates; read it in the intended padded-field geometry. The UV transform then scales and biases each texture lookup according to its descriptor parameters. The actual filtering and addressing settings come from the texture object, so the source does not establish a cache-hit rate or a specific filter for every supplied texture.</p>
{feature_diagram()}
{code(IN16,21,39,'Pixel ownership, reflected texture coordinates, noise, and current-color conditioning')}
<p>Current RGB is converted to Half, shifted by one half, and multiplied by the Half-rounded value of twice <code>ColorScale</code>. Those intermediate rounding points are deliberate: moving the entire affine expression to FP32 and converting once is a different calculation. History defaults to the conditioned current sample when the required texture handles are absent. With history and motion available, motion displaces the current UV to the previous frame. Optional depth selection examines the center and four diagonal candidates in a fixed order, retaining the old candidate on the documented tie/unordered comparisons. The source carefully leaves the semantic meaning of several renderer conditioning controls unspecified; the diagram labels their ABI channels rather than inventing material or lighting meanings.</p>
{code(FRONT+'input_features.cuh',91,107,'Conversion and conditioning preserve Half rounding')}
<h3>History reconstruction is a small texture computation of its own</h3>
<p><code>ComputeCubicAxis</code> builds three positions per axis by merging the middle two coefficients. <code>ReconstructHistory</code> evaluates a cross of five filtered samples: left, top, center, bottom, right. It omits the four corner products and renormalizes the retained weights. Horizontal and vertical coefficients are FP32 values produced by explicit native arithmetic wrappers. The same routine is reused by preprocessing and output composition, preventing those two entry points from drifting numerically. The coefficient algebra resembles Catmull–Rom, but the source explicitly treats the intended filter name as an inference.</p>
{code(FRONT+'frontend_math.cuh',166,190,'Five-sample history reconstruction and its fixed sum order')}
<h2 id="frontend-adapter">Step 2 — gather shared features directly into the adapter's MMA layout</h2>
<p>After <code>__syncthreads()</code>, lanes no longer own whole pixels. They cooperate as one matrix-multiply warp. Four physical 4 × 4 tiles make the window. The adapter constructs a four-word A fragment per lane from the two shared feature planes. For a tile index <code>t</code> and word index <code>w</code>, the shared pixel is <code>4(t &amp; 1) + 32(t &gt;&gt; 1) + ((lane/4) &amp; 3) + 8(lane/16) + 16(w &amp; 1)</code>. Plane <code>w/2</code> selects features 0–7 or 8–15; the lane's bottom two bits choose a pair of those channels.</p>
{adapter_diagram()}
{code(IN16,163,185,'Shared-to-register adapter gather and four m16n8k16 products')}
<p>The worked lane-17 example is useful because it demonstrates both independent dimensions: words 0 and 1 select different tokens, while words 0 and 2 select different channel planes at the same token. This is not four adjacent words from a BHWC tensor. The adapter weight loader provides two 16-byte vectors per lane, covering a total 1024-byte 16 × 32 Half matrix over the warp. Four N=8 output groups build the 32-channel result. No adapter activation allocation is required in global memory: <code>r_Adapter[4]</code> immediately feeds the C32 body.</p>
<p>The adapter is always Half, including the FP8 entry. <code>FPreprocessWindowProfile</code> reserves exactly <code>16 × 32 × sizeof(__half)</code> bytes and shifts the ordinary record's subsequent offsets by 1024 bytes. An FP8 filename therefore describes the main block's working operands, not every arithmetic operation in that entry. The raw adapter output remains packed Half words for the FFN residual, while <code>PublishWindow32&lt;true&gt;</code> creates E4M3 operands for the FP8 FFN.</p>
{code(FRONT+'frontend_profiles.cuh',6,17,'The adapter changes packed record offsets in both precision modes')}
<h2 id="frontend-body">Step 3 — retain the correct raw branch through the fused block</h2>
<p>The ordinary body is explained in <a href="fused-windows.html">the fused-window chapter</a>. Here its important boundary is the dual use of the adapter: matrix multiplication consumes the published input, but the first residual is seeded from the raw adapter pair multiplied by its learned Half scale. After FFN contraction, QKV sees the published FFN result. The C32 attention residual retains the raw FFN accumulator rather than decoding the E4M3 publication. These separate values often occupy registers at the same time; “raw” identifies the numerical branch and does not mean FP32.</p>
{frontend_lifetime()}
{code(IN16,219,257,'Raw adapter residual and streamed hidden panels')}
<p>The downsample entry preserves the final four raw tile accumulators until pooling. It also writes the published full-resolution skip in packed physical tiles. Pooling exchanges values through warp shuffles, makes three rounded Half additions and a quarter multiply, then publishes a 4 × 4 C32 result in channel-plane form. Crucially, block 0 has no C → 2C projection. The similarly named later encoder downsample kernels do, which is why replacing this fork with a generic encoder transition would silently alter the model. The input entry without <code>downsample</code> performs the frontend and full-resolution publication without this pooled-output branch.</p>
{code(IN8,359,374,'Block 0 pools directly to C32 and clears the required output padding')}
<h2 id="frontend-output">Step 4 — merge the output skip and run the Half head</h2>
<p>Record 70 reads the low-resolution channel-plane view and the record-0 physical-tile skip. A shuffle implements nearest repetition of the low field into each high-resolution 2 × 2 cell. The merge computes <code>HalfFma(skip, adapterScale, HalfMul(low, inputScale))</code>: the low product rounds first, and the skip multiplication is fused with its addition. This ordering is a concrete part of the recovered arithmetic. It cannot be replaced by an arbitrary sum of products while claiming identical numerics. The raw merged words then serve the same dual role as record 0's raw adapter.</p>
{code(OUT16,66,89,'Two scale paths and the exact output merge rounding')}
{output_diagram()}
<p>After attention projection, the output head consumes Half fragments in both precision modes. Its loop covers two K16 chunks of the 32-channel input and executes <code>MmaWindowFragment&lt;false&gt;</code>. The logical model needs four outputs, while the native instruction has N=8; the subsequent gather selects the four useful channels. Keeping this head inside the tile loop avoids a mandatory global C32-to-head intermediate. The variable name <code>r_Head</code> denotes arrays of packed words owned by warp lanes, not one ordinary four-float pixel per lane yet.</p>
{code(OUT16,229,244,'The output head uses Half operands and Half accumulators')}
<h2 id="frontend-compose">Step 5 — change ownership from matrix fragments to pixels</h2>
<p>The final gather uses <code>sourceLane = ((lane &amp; 7) &lt;&lt; 2) | (lane &gt;&gt; 3)</code> plus three XOR variants to retrieve the head words. For each of two tile rows, every lane obtains a complete four-channel pixel, converts its Half components to FP32, and computes a surface coordinate. For example lane 17 in tile-row 0 has local output coordinates (5,0), relative to the window origin. This differs from its adapter-fragment coordinates: ownership changes to suit the next operation, and the shuffles make that change without a shared-memory staging image.</p>
{code(OUT16,254,286,'Fragment-to-pixel transpose, pixel coordinates, and Half-to-FP32 decoding')}
<p>For a valid pixel with a current-color texture, RGB is <code>OutputScale × headRGB + (0.125 × currentRGB − 0.0625)</code>, evaluated with the shown fused operations. Without that input, it starts from the scaled head. Display output then applies <code>clamp(8 × RGB + 0.5,0,1)</code> and sets alpha to one; non-display output leaves alpha zero. If display/history/motion/validity and blend-scale conditions permit, the fourth head channel forms an approximate sigmoid through exp2 and reciprocal. The external blend scale is clamped, with the source's special infinity/unordered handling. Final RGB is updated as <code>RGB + weight × (history − RGB)</code> and four FP32 components are sent to the output surface. The conversion to a particular surface format is a property of that surface, not a hidden E4M3 store.</p>
{code(OUT16,329,355,'Optional temporal composition and surface publication')}
{note('Optimization lesson: renderer sampling, adapter, C32 body, head, and composition have different ownership and precision needs. Fusion keeps the handoffs in shared memory or registers, but preserves explicit publication and rounding boundaries. Source-level register arrays and __maxnreg__(168) do not prove zero spills; compiled resource reports and profiling are needed for that claim.')}
'''


def token_grid():
    s=txt(20,25,'An 8 × 8 window: cell = natural row-major token / physical token',19)
    for y in range(8):
        for x in range(8):
            natural=8*y+x; physical=(y//4)*32+(x//4)*16+(y%4)*4+x%4
            s+=box(20+x*79,50+y*42,73,36,[f'{natural}/{physical}'], ['#e5f4ec','#e7f2ff','#fff2d5','#f0e8fa'][(y//4)*2+x//4])
    s+=box(690,70,355,130,['Four physical tiles, 16 rows each','tile 0: upper-left; tile 1: upper-right','tile 2: lower-left; tile 3: lower-right','natural t=13 → (x=5,y=1)','physical p=16+4+1=21'])
    s+=box(690,240,355,130,['Lane ownership in one 16-token tile','row = lane/4 + 8 × rowHalf','channel = 8 × column + 2(lane mod 4)','lane 6, column 2, rowHalf 1:','physical row 9, channels 20 and 21'])
    return svg('Natural positions, physical token order, and accumulator ownership','0 0 1080 405',s,
               'weights.py:79–81 defines physical order. warp_window32.cuh:14–19 defines packed accumulator ownership. Physical row 9 inside a 4 × 4 tile is local pixel (1,2).')


def memory_diagram():
    s=box(20,20,285,105,['Global activation allocation','physical tile → channel panel','FP8 C32 tile: 512 bytes','FP16 C32 tile: 1,024 bytes'])
    s+=box(405,20,250,105,['L2 path for __ldcg','16-byte vector per lane','L1 bypass requested'])
    s+=box(755,20,300,105,['Register A fragments','4 words/lane per K chunk','FP8 K32: 1 chunk','FP16 K16: 2 chunks'])
    s+=arrow(305,70,405,70,'load',355,142)+arrow(655,70,755,70,'uint4',705,142)
    s+=box(20,195,285,105,['Global weights and Half bias','__ldca: L1 + L2 eligible','packed 16-output panels','same weights reused across tiles'])
    s+=box(405,195,250,105,['Register B fragments','2 words/lane per MMA','bias seeds D in Half'])
    s+=box(755,195,300,105,['Tensor Core mma.sync','M16 × N8 × K16 or K32','Half D/C words in registers','activation / QK / PV / projection'],'#f5e3eb')
    s+=arrow(305,245,405,245,'cache/load',355,318)+arrow(655,245,755,245,'B',705,318)+arrow(905,125,905,195,'A',935,167)
    s+=box(405,365,650,65,['Published output → st.global.L1::no_allocate.b128 → global allocation','C32 has no software shared slab; C64+ adds the exchange slab below.'],'#fff2d5')
    s+=arrow(905,300,905,365,'Half/E4',962,338)
    return svg('The source requests different caching for activations and reusable weights','0 0 1080 455',s,
               'Loads: window_block_compact_fp8.cu:64–79; weights: warp_window32.cuh:105–127. MMA/store intrinsics: intrinsics.cuh:188–224. Cache boxes show requested paths, not measured cache hits.')


def slab_diagram():
    s=txt(20,25,'C128: four warps exchange four C32 panels in the same 8,192-byte FP8 slab',19)
    phases=[('X published','all 4 branches read all panels'),('Branch outputs','each warp writes its C32 branch'),('FFN result Z','mix all branches + residual'),('Attention output','one head/warp; cross-head projection')]
    for i,(name,desc) in enumerate(phases):
        x=20+i*265
        s+=box(x,65,245,85,[name,desc],'#fff2d5')
        for p in range(4):
            s+=box(x,185+p*46,245,38,[f'warp {p} owns panel {p}, tiles 0…3'], ['#e5f4ec','#e7f2ff','#f0e8fa','#f5e3eb'][p])
        if i<3:s+=arrow(x+245,108,x+265,108)
    s+=txt(20,405,'Barrier before overwrite: every reader must finish the old tensor. Barrier after stores: expose the new tensor.',16)
    s+=txt(20,435,'Address = ((((tile × Heads + panel) × Chunks + chunk) × 32 + lane) × 16) bytes.',16)
    return svg('Shared memory is a sequence of tensor lifetimes, not four separate allocations','0 0 1100 465',s,
               'FSharedWindow layout: warp_window_wide.cuh:33–61. Ordinary wide FP8 barriers and reuse: window_block_wide_fp8.cu:76–106,150–174,246.')


def reductions_diagram():
    s=txt(20,27,'A query row is distributed over a group of four warp lanes',20)
    for l in range(4):
        s+=box(20+265*l,65,245,96,[f'lane {l}: channels / key columns',f'channel pairs {2*l},{2*l+1} + 8j','4 pairs for Q/K; 8 for scores'],'#e7f2ff')
    s+=box(20,215,495,114,['Q/K L2 channel reduction','contracted square tree → XOR 2 → XOR 1','add packed Half components → clamp → rsqrt','Half inverse × vector; Q gets learned head scale'],'#e5f4ec')
    s+=box(565,215,495,114,['Attention denominator over 64 key positions','surrogate exponential → local column-pair sums','lane 0 + lane 1, then + lane 2, then + lane 3','add Half components → clamp → reciprocal'],'#fff2d5')
    s+=arrow(285,161,285,215,'Half partial sums',383,195)+arrow(810,161,810,215,'Half partial sums',920,195)
    s+=txt(20,380,'These reductions deliberately have different addition orders. Replacing either with a generic reduction changes rounding.',16)
    s+=txt(20,410,'C32 FP8 pairs two query tiles: transpose four row halves so each of 32 lanes computes one reciprocal, then broadcast back.',15)
    return svg('Normalize over channels, then separately normalize over key positions','0 0 1100 440',s,
               'NormalizeWindow: warp_window32.cuh:160–192; SoftmaxWindow:206–238; paired schedule:261–316. All arrows are register operations and warp shuffles, with no shared row-sum array.')


FUSED = f'''
<h2 id="fused-model">Target architecture: the ordinary C32, C64, C128 and C256 blocks</h2>
<p>This family implements an entire FFN–attention residual block without changing image size. C32 appears at records 0–4 and 66–70 and has a dense 32 → 128 → 32 FFN. C64 (5–8,62–65), C128 (9–14,56–61), and C256 (15–22,48–55) use respectively 2,4,8 full-input branches, each computing <code>C → 128 → 32</code>; the concatenated C-channel branch output then passes through a C → C mixing matrix. Every branch runs on every token. The source variable “expert” does not imply sparse routing. Transition and frontend records add work around this ordinary body, covered separately.</p>
<p>For a token vector X, the conceptual first stage is <code>Zraw = FFN(X) + ffnScale ⊙ X</code>. QKV consumes the working-precision publication Z. Each 32-channel head normalizes Q and K across channels, scales Q by a learned head scalar, computes a biased 64 × 64 score matrix inside an 8 × 8 window, normalizes its recovered exponential weights, multiplies by V, then mixes heads through a C → C output projection. The attention residual uses raw Zraw for C32 and published Z for the wider families. See <a href="../ARCHITECTURE.md#follow-one-block">the complete model block</a> and <a href="../ARCHITECTURE.md#channel-mixing-inside-a-block">FFN variants</a>. These kernels do not implement a pre-FFN LayerNorm.</p>
<h2 id="fused-layout">Step 1 — make token and lane ownership explicit</h2>
<p>The logical window contains 64 tokens. Physical storage divides it into four contiguous 4 × 4 tiles, each a 16-row MMA tile. Define natural token <code>t = 8y+x</code>. Its physical index is <code>p = 32(y/4) + 16(x/4) + 4(y mod 4) + x mod 4</code>, with integer division. Natural token 13 at (5,1) becomes physical token 21. This organization lets a warp load already packed fragments directly rather than materialize a temporary BHWC window in shared memory. Window origins may be shifted by 0 or −4 pixels per axis according to the phase; out-of-bounds positions are zero-filled rather than cyclically wrapped.</p>
{token_grid()}
{code('dlssnr/weights.py',79,81,'Natural token → physical tile order')}
<p>An accumulator holds one packed Half pair per lane for each N=8 column group and each of two row halves. Lane L owns rows <code>L/4</code> and <code>L/4+8</code>, and channels <code>8j+2(L mod 4)</code> and the following channel. Thus four adjacent lanes collectively own one token's 32 channels. Lane 6, column group 2, row half 1 owns physical row 9 and channels 20–21. Natural query order in the model is reconciled with physical rows when decoding the bias; K and V use the same physical-key order. The kernel's packed bias already matches its fragments, so no runtime token-sort kernel is involved.</p>
{code('dlssnr/weights.py',208,216,'Bias decoding establishes natural query versus physical key indexing')}
<h2 id="fused-load">Step 2 — load packed operands through the right addressing path</h2>
<p>For normal tile storage, the C32 byte address is <code>base + physicalTileIndex × TileBytes + chunk × 512 + lane × 16</code>. FP8 has one K32 chunk and 512 bytes per C32 tile; FP16 has two K16 chunks and 1024 bytes. Four 32-bit words form a lane's A fragment. In C128/C256 a channel-panel term <code>panel × PanelBytes</code> is inserted inside each physical tile. An input-view variant instead reads the spatial channel planes directly: <code>base + (((plane × H + y) × W + x) × 16) + 4(lane &amp; 3)</code>. This fused gather is how a transition's output can feed an ordinary window without an extra layout-copy launch.</p>
{memory_diagram()}
{code(WIN+'fp8/window_block_compact_fp8.cu',64,79,'Packed activation load: adjacent lanes read adjacent 16-byte fragments')}
<p>As a worked byte calculation, C32 FP8 tile index 7 and lane 6 load at <code>base + 7×512 + 6×16 = base+3680</code>. C32 FP16 chunk 1 for the same tile/lane loads at <code>base + 7×1024 + 512 + 96 = base+7776</code>. The offsets identify different physical layouts even when the logical tensor shape is identical. For a weight panel, one K32 FP8 or K16 Half panel has 32 bytes per output channel, so the loader uses the same 512-byte stride for each block of 16 outputs. Matrix reduction advances by 32 logical channels in the helper, but that means one FP8 MMA chunk or two FP16 chunks.</p>
{code(COMMON+'warp_window32.cuh',105,139,'Weight panel addressing and reduction-chunk MMA dispatch')}
<p>Activation tile loads use <code>__ldcg</code>; reusable weights and bias use <code>__ldca</code>. PTX defines the former cache policy as L2-and-below with L1 bypass, and the latter as eligible for L1 and L2. The final vector store requests <code>L1::no_allocate</code>. These are performance hints, not a proof of cache hits or a synchronization mechanism. <a href="https://docs.nvidia.com/cuda/parallel-thread-execution/#cache-operators">NVIDIA's PTX cache documentation</a> defines the policies. The software-visible storage chain is global allocation → requested cache path → registers → Tensor Core operands, with a CTA shared exchange added for wider blocks. Source arrays prefixed <code>r_</code> express intended register ownership; compiler spilling remains a separate compiled-code question.</p>
<h2 id="fused-ffn">Step 3 — stream hidden panels through the FFN</h2>
<p>For C32, one warp retains all four token tiles. Each input is decoded if necessary and multiplied by the FFN residual scale to seed <code>r_Ffn</code>. The loop visits four hidden panels of 32 channels. For one panel it loads expansion and contraction weights, creates a 16-token × 32-hidden accumulator, applies the recovered clamped Half polynomial, publishes that panel to the working precision, and immediately contracts it into the final 32-channel accumulator. The logical [64,128] hidden tensor never needs a global allocation, and only a panel is live at a time. Ordered contraction accumulation preserves the intended Half numerical boundaries while limiting live register state.</p>
{code(WIN+'fp8/window_block_compact_fp8.cu',96,122,'Stream four hidden panels instead of materializing a complete FFN intermediate')}
<p>The gate is a piecewise polynomial built from min, max, absolute value, two Half fused multiply-adds, and a final Half multiply. Both storage modes share this arithmetic. FP8 saves operand bytes and uses a longer K dimension, but it does not turn the residual, activation, normalization, or accumulator into an 8-bit computation. The intrinsic spells this out: FP8 is <code>mma.sync.aligned.m16n8k32.row.col.f16.e4m3.e4m3.f16</code>, while Half is <code>m16n8k16.row.col.f16.f16.f16.f16</code>. The last and first data-type fields describe Half accumulator input and output, not FP32 accumulation.</p>
{code(COMMON+'packed_math.cuh',141,164,'Exact activation implementation shared by both storage modes')}
{code(COMMON+'intrinsics.cuh',188,224,'The actual MMA and final-store instructions')}
<h3>Why C64 and C128/C256 distribute work differently</h3>
<p>C64 uses two warps and token parallelism for the FFN: each warp retains two 4 × 4 token tiles and both C32 input panels. Each computes both branches for its own tokens and immediately mixes each branch into two output panels. Only the complete published FFN result enters shared memory. After that barrier the ownership changes: each warp owns one attention head across all four token tiles. This avoids shared intermediate branch outputs in the C64 FFN while still enabling attention to read the whole window.</p>
{code(WIN+'fp16/window_block_two_warp_fp16.cu',92,115,'C64 branch accumulation followed by a token-to-head ownership exchange')}
<p>C128 and C256 instead assign one branch to each warp. Every branch must read all C input channels, so the input first enters a shared slab. Each warp computes four token tiles for its branch, retains its own scaled residual, and publishes its branch's 32 outputs back into its panel of that slab. All warps then read all branch panels for the mixing matrix. This moves branch ownership from spatial partitions to channel panels and requires carefully placed barriers. The source chooses this schedule; the text does not claim it is universally optimal for every GPU.</p>
{slab_diagram()}
{code(WIN+'fp8/window_block_wide_fp8.cu',76,106,'Wide-FFN read lifetime, overwrite, publish, and cross-panel mix')}
<p>The shared array is <code>uint4 s_Tile[4][Heads][Chunks][32]</code>. Its size is exactly <code>64 × C × elementBytes</code>: C64 uses 4096/8192 bytes, C128 uses 8192/16384, and C256 uses 16384/32768 for FP8/FP16. These are declaration sizes, not an occupancy prediction. For C128 FP8, tile 2, panel 3, chunk 0, lane 6 starts at <code>((2×4+3)×32+6)×16 = 5728</code> shared bytes. The layout stores a complete native A fragment per lane, and the helper explicitly states that it does not add a bank swizzle. A barrier before overwrite protects old readers; the next barrier exposes new data. Removing one merely because each warp writes a distinct panel ignores the cross-panel reads.</p>
<h2 id="fused-qkv">Step 4 — project and normalize one head per warp</h2>
<p>QKV reads the published FFN result. Wide records pack outputs as <code>[head][Q,K,V][32]</code>, which explains the output-channel base <code>96×warp + 32×component</code>. Each head still projects from all input channel panels. Q and K are independently normalized over their 32 channels. V bypasses normalization and is transposed with <code>movmatrix.sync.trans.aligned.m8n8.b16</code> so probability-times-value can consume it as a B fragment. In FP8 the transpose happens on Half accumulator words before E4M3 packing; this preserves the intended row/column ownership at publication.</p>
{code(WIN+'fp8/window_block_wide_fp8.cu',113,147,'Interleaved QKV weight addresses, separate Q/K norms, and the V transpose')}
{reductions_diagram()}
<p>The norm uses a specific contracted square tree: products for channels 16–31 round before channels 0–15 are fused into them. Butterfly XOR 2 then XOR 1 combines the four lanes belonging to one token, followed by addition of the two Half components. A Half epsilon clamp precedes approximate reciprocal square root; the scalar inverse is converted back to Half and replicated. Q additionally receives the learned head scale. The semantic operation is L2 normalization, but matching a generic FP32 norm formula is insufficient to reproduce these numerical boundaries.</p>
{code(COMMON+'warp_window32.cuh',160,191,'Register-only channel norm and learned query scaling')}
<h2 id="fused-attention">Step 5 — score, normalize, and apply values without a global score matrix</h2>
<p>For one query tile the warp seeds a 16 × 64 score accumulator from packed Half bias. It multiplies the query fragment against all four key tiles and then applies <code>AttentionExponential</code>. This helper clamps a Half affine transform and shifts the packed word's exponent encoding; it is a recovered exponential surrogate, not a library softmax. The source warns that independently shifting each Half lane changes the carry behavior. Attention normalization uses sequential lane additions 0+1, then +2, then +3 rather than the butterfly used by the channel norm. Different reductions serve different recovered arithmetic contracts.</p>
{code(COMMON+'warp_window32.cuh',194,238,'Exponential surrogate and exact 64-key denominator order')}
<p>C32 FP8 processes two adjacent query tiles together. Four row halves represent 32 query rows; a shuffle transpose gives each lane one complete row sum, allowing one reciprocal per row before broadcasting the result back to the four MMA column lanes. FP16 C32 keeps the one-query-tile schedule. Wider <code>AttendWithBias</code> uses the single-tile normalization helper even though the outer schedule may retain multiple attended tiles. C256 retains all four attended query tiles before projection; C64/C128 reuse the slab twice, two tiles at a time. These are distinct meanings of “batch” and should not be conflated.</p>
{code(COMMON+'warp_window32.cuh',281,315,'Paired C32 FP8 row-sum ownership and reciprocal broadcast')}
<p>The probabilities are published to Half or E4M3 before the P×V product. Its reduction spans 64 keys, so it uses four K16 chunks in FP16 or two K32 chunks in FP8. The output is 16 × 32 Half values per query tile. Wider blocks publish each head's output to shared memory, synchronize, then read all heads for the C → C projection. The projection accumulator begins with the correctly scaled attention residual. C32 can perform that projection immediately in its warp registers; it retains raw FFN words as the residual. Finally, the result is published and stored as physical fragments or directly into a requested spatial view.</p>
{note('Optimization lesson: most savings here come from choosing ownership to match the next consumer—physical token tiles for MMA, registers for streamed hidden panels, shared panels for cross-warp channel mixing, and shuffle transposes for row reductions. No full [64,64] score allocation is written to global memory. The source explains the avoided traffic; it does not establish a measured speedup or a universal best schedule.')}
'''


def transition_arch_diagram():
    s=box(20,20,310,110,['Encoder tail: raw [8,8,C]','published skip → global tiles','raw Half output retained in registers','4 spatial 4 × 4 tiles per warp/head'])
    s+=box(395,20,280,110,['Pool to [4,4,C]','three Half adds + × 1/4','working-precision publication','shared C32 panels'])
    s+=box(745,20,310,110,['C → 2C projection','Tensor Core channel mixing','global [plane,y,x,16 bytes]','next-level field + zero padding'])
    s+=arrow(330,72,395,72,'shuffle',362,151)+arrow(675,72,745,72,'MMA',710,151)
    s+=box(20,215,310,110,['Decoder low [4,4,2C]','global channel planes → registers','2C → C projection in low field','16-token Half result retained'])
    s+=box(395,215,280,110,['Repeat to [8,8,C]','warp shuffles select low tokens','four high tokens per low token','no expanded global allocation'])
    s+=box(745,215,310,110,['Merge global saved skip','HalfAdd(projected, HalfMul(skip,s))','crop/clear out-of-field positions','publish → ordinary FFN/attention'])
    s+=arrow(330,270,395,270,'registers',362,346)+arrow(675,270,745,270,'Half pairs',710,346)
    return svg('The downward and upward dataflows place channel mixing at low resolution','0 0 1080 375',s,
               'Encoder wide FP8:204–253; decoder wide FP8:27–113. Projection before spatial repetition avoids doing the same linear transform four times.')


def pooling_diagram():
    s=txt(20,25,'A single destination channel pair comes from four source pixel pairs',20)
    cells=[(20,65,'top-left a'),(280,65,'top-right b'),(20,145,'bottom-left c'),(280,145,'bottom-right d')]
    for x,y,label in cells:s+=box(x,y,225,60,[label,'2 Half channels / register word'])
    s+=box(620,65,435,140,['Lane routing, then exact arithmetic','swap lane bits 2 and 3','gather sourceLane, sourceLane XOR 4,','sourceLane XOR 16, sourceLane XOR 20','q = HalfMul(HalfAdd(a+b, c+d), 0.25)'],'#fff2d5')
    s+=arrow(505,109,620,109,'shfl.idx',562,240)
    s+=box(20,275,1035,100,['Worked target lane 0: sourceLane = 0; gathers lanes 0,4,16,20 after the conditional word routing.',
                            'The tile-X and row-half swaps choose the correct left/right tile and top/bottom rows before the gather.',
                            'One 8 × 8 window becomes one 4 × 4 output tile. This is spatial pooling, not a channel reduction.'],'#e5f4ec')
    return svg('Pooling operates on raw Half accumulators through a specific shuffle network','0 0 1080 400',s,
               'window_pool.cuh:7–42 is the complete routing and reduction. Conditional swaps are part of the mapping; XOR lane indices alone are insufficient to describe it.')


def plane_diagram():
    s=txt(20,25,'Channel-plane publication: each pixel owns a 16-byte vector inside each plane',20)
    for i in range(4):
        s+=box(20,60+i*59,260,47,[f'FP16 plane {i}: channels {8*i}…{8*i+7}'],'#e7f2ff')
    for i in range(2):
        s+=box(365,60+i*115,275,80,[f'FP8 plane {i}: 16 channels',f'two 8-channel groups packed',f'four E4M3 bytes / lane word'],'#e5f4ec')
    s+=box(735,60,320,195,['Example: FP8 C128 → C256','OutputPanel=5, word=2','plane = 5×2 + 2/2 = 11','H=136, W=240, (x,y)=(2,1)','lane=9 → byte-in-vector=4','offset = ((11×136+1)×240+2)','          ×16+4 = 5,748,516 bytes'],'#fff2d5')
    s+=txt(20,335,'General plane = OutputPanel × 2 × Chunks + 2 × chunk + word/2',17)
    s+=txt(20,367,'Address = base + ((plane × H + y) × W + x) × 16 + 4(lane & 3)',17)
    s+=txt(20,399,'FP8 plane channel order follows packed MMA bytes; do not assume simple contiguous BHWC channel order.',15)
    return svg('Spatial views preserve packed channel fragments while changing token addressing','0 0 1080 430',s,
               'window_downsample.cuh:31–50; wide_downsample_fp8.cu:242–248. The byte example assumes the stated H/W and base-relative coordinates; plane channel grouping does not imply natural byte order.')


def repeat_diagram():
    s=box(20,25,320,135,['Projected low token (0,0)','C32 pair in source lane 0','Half accumulator; projection done once','low rowHalf 0','feeds high tile 0, rowHalf 0'])
    coords=[(440,25,0,'high (0,0)'),(745,25,4,'high (1,0)'),(440,125,16,'high (0,1)'),(745,125,20,'high (1,1)')]
    for x,y,l,label in coords:
        s+=box(x,y,275,75,[label,f'destination lane {l} → source lane 0'],'#e5f4ec')
    s+=arrow(340,77,440,77,'shfl.idx',390,216)
    s+=box(20,260,470,115,['Source lane = (L & 3) | ((L >> 1) & 4)','              | 8(tile & 1) | 16×rowHalf','Select accumulator rowHalf = tile >> 1','then add the independently addressed high skip'])
    s+=box(560,260,495,115,['Publication boundary after merge','C64/C128/C256: published shared slab → FFN','C32: published merge → FFN operands','      raw Half merge → FFN residual'],'#fff2d5')
    return svg('A concrete nearest-repeat trace through warp lanes','0 0 1080 405',s,
               'window_block_wide_upsample_fp8.cu:88–103. For tile 0,rowHalf 0, destination lanes 0,4,16,20 all compute sourceLane 0 while their physical pixel coordinates differ.')


TRANSITIONS = f'''
<h2 id="transition-model">Target architecture: encoder tails 4/8/14/22 and decoder entries 66/62/56/48</h2>
<p>The encoder transition preserves detail at the current resolution and creates the next coarser field. For C=32,64,128,256, its ordinary block produces Yraw, saves <code>Publish(Yraw)</code> as a skip, averages each 2 × 2 group of Yraw, then projects <code>C → 2C</code> at the pooled positions. The decoder performs the complementary operation: project <code>2C → C</code> at low resolution, repeat each projected token to a 2 × 2 patch, add the scaled corresponding encoder skip, crop to the destination field, then run that destination record's FFN and window attention. These operations are additions and learned channel mixing, not skip concatenation.</p>
<p>The concrete pairing is record 4 → 66 for C32, 8 → 62 for C64, 14 → 56 for C128, and 22 → 48 for C256. At the 4K example, record 14 starts at [272,480,128], stores that full skip, pools to [136,240,128], and projects to [136,240,256]. Record 56 later projects the low [136,240,256] field to C128, expands to [272,480,128], and merges record 14's skip. Read <a href="../ARCHITECTURE.md#moving-between-resolutions">the architecture transition diagrams</a> first. The C512 → C1024 tail and record-39 transition use separate families; block 0 is a special C32 pool with no channel doubling, described in <a href="frontend.html">the frontend chapter</a>.</p>
{transition_arch_diagram()}
<h2 id="transition-raw">Step 1 — fork the encoder output before publication loses information</h2>
<p>The beginning of a fused downsample entry is the same body as its ordinary window counterpart. It computes the FFN, QKV, attention, output projection, and attention residual. The final per-tile accumulator is kept in <code>r_WindowOutput[4]</code> while a published copy goes to the full-resolution output allocation. This allocation is the skip that the later decoder loads. The two consumers require different data: the skip needs the working-precision publication; pooling needs the raw Half words. In FP8, decoding the already published skip and averaging it would introduce an extra E4M3 rounding boundary before the reduction.</p>
<p>“Raw” is not a synonym for “unrounded real number.” Every preceding Half MMA has already rounded its accumulator output, and the residual arithmetic is Half. The term means only that the final E4M3 publication has not happened on this branch. This distinction also matters for the next step: pooled Half values are themselves published before the down-projection, so the projection receives E4M3 operands in FP8 mode. There are two intentional conversion boundaries, with pooling between them; they cannot be moved freely through arithmetic.</p>
<h2 id="transition-pool">Step 2 — reduce four pixels using lane shuffles and Half arithmetic</h2>
<p><code>PoolWindow</code> processes each of the four 8-channel column groups. It combines tiles 0 and 1 to form the first row half of a 4 × 4 destination, and tiles 2 and 3 to form the second. <code>PoolHorizontalWords</code> first conditionally swaps left/right words for lanes with bit 2 set, and low/high row-half words for lanes with bit 4 set. The source lane equation then swaps lane bits 2 and 3. Four indexed shuffles, using XOR offsets 0,4,16,20, assemble the spatial 2 × 2 cell while retaining the lane's channel pair.</p>
{pooling_diagram()}
{code(COMMON+'window_pool.cuh',7,42,'Complete packed-Half pooling primitive')}
<p>The arithmetic is <code>HalfMul(HalfAdd(HalfAdd(a,b),HalfAdd(c,d)),quarter)</code>. That is three separately rounded additions and one rounded multiplication, with horizontal pairs combined first. An FP32 average, a reassociated serial sum, or pooling after E4M3 publication all produce different rounding opportunities. For a simple sanity trace using exactly representable Half values a=1,b=2,c=3,d=4, the intermediate horizontal sums are 3 and 7, the combined sum is 10, and the destination is 2.5. This easy trace validates geometry but cannot detect all incorrect rounding rewrites; adversarial values near Half rounding boundaries are needed for a numerical-equivalence test.</p>
<p>The operation contains no global neighbor reads because all four source tile accumulators are already live inside the warp after attention projection. It also contains no shared-memory scratch array. The shuffles move 32-bit words between lanes, preserving two adjacent channels together. This illustrates why a spatial operation can be implemented with warp register exchange even though the model describes it as a conventional image pool. The earlier physical tile layout deliberately makes the relevant neighbors recoverable by simple lane-bit transformations.</p>
<h2 id="transition-project">Step 3 — share pooled panels and project C → 2C</h2>
<p>For the wide encoder, each warp publishes its pooled C32 channel panel into shared slot <code>s_Window[0][warp]</code>. A CTA barrier makes all C channels visible. Each warp then produces two output panels: channel base <code>32×warp</code> and channel base <code>32×warp + C</code>. For each output half, the loop visits every input C32 panel and accumulates a matrix product. This doubles channels without doubling the number of warps. The reduction order follows increasing input panel index. Down-projection weights begin immediately after the ordinary block's attention scale array in the packed record, as the excerpt's pointer arithmetic shows.</p>
{code(DOWN+'fp8/window_block_wide_downsample_fp8.cu',204,219,'Publish pooled panels once, then each warp emits two C32 output panels')}
<p>For C128 there are four warps. Warp 1 computes projected output channels 32–63 during output-half 0 and 160–191 during output-half 1, while reading all four pooled C32 panels for each. The retained shared input occupies a single logical 4 × 4 pooled tile even though the declared shared slab has room for four tiles. The larger slab existed already for the ordinary block and is reused. There is no need to allocate a separate full pooled image just to launch a C → 2C projection kernel.</p>
<h2 id="transition-planes">Step 4 — publish the next-level spatial view and define its padding</h2>
<p>The projected output is written in channel planes: each plane has H×W 16-byte vectors, with four lanes cooperating on one vector. The plane index combines output panel, reduction chunk, and half of the fragment-word index. A word index's low bit chooses one of two token row halves, separated by two physical rows; its high bit chooses the plane. This layout is spatially addressable for transitions and view kernels while preserving the packed channels needed by MMA. It is neither BHWC nor a generic contiguous CHW tensor.</p>
{plane_diagram()}
{code(DOWN+'common/window_downsample.cuh',24,50,'Exact channel-plane dimensions, addresses, and local padding stores')}
<p>The diagram's byte calculation is deliberately base-relative so the same derivation applies to any allocation. For FP8 C128 → C256, output panel 5 and word 2 select plane 11. Taking H=136,W=240,x=2,y=1 and lane 9 yields <code>(((11×136+1)×240+2)×16)+4 = 5,748,516</code>. This can be checked against the source independently of tensor semantics. For FP16, <code>Chunks=2</code> and each C32 panel occupies four planes instead of two, changing both plane numbers and total bytes. Do not reuse a byte offset computed for the other precision.</p>
<p>Valid pooled dimensions are ceil(H/2),ceil(W/2). C32 writes compact half extents in its supported geometry; wider entries align those extents up to multiples of four. The projection store immediately writes zero for its own padded cells. This is a race-avoidance rule: a later clear should not compete with a valid projection store to the same location. The separate padding-clear logic covers caller-provided target extents, including uncovered bottom/right borders handled by CTA zero. Its documented workspace footprint remains Half-sized for C → 2C even in FP8. Workspace size and live payload size therefore are distinct contracts; blindly halving the allocation because the operands are FP8 would be unsafe.</p>
{code(DOWN+'common/window_downsample.cuh',56,94,'Padding clear contract and uncovered-border handling')}
<h2 id="transition-up">Step 5 — project the decoder input before expanding it</h2>
<p>The decoder reads one 4 × 4 low-resolution region from the channel-plane layout. Each warp is assigned 32 output channels and loops over <code>2×Heads</code> input panels to perform 2C → C. This projection is computed at sixteen low tokens; nearest repetition afterwards expands it to sixty-four high tokens. Since all four members of a high 2 × 2 cell need the same low projected value, doing the channel projection after expansion would duplicate that work. The packed input address uses the same plane/row/column equation as downsample publication. Boundary reads zero-fill unless a singleton dimension triggers the explicit broadcast behavior.</p>
{code(UP+'fp8/window_block_wide_upsample_fp8.cu',27,59,'Low-resolution spatial-view gather and 2C → C projection')}
<p>The projected low tile stays in Half accumulators. A source-lane formula combines the destination lane's channel bits, its horizontal position, the high tile's left/right selection, and its row half. The high tile's top/bottom selection chooses which low accumulator row half to read. For high tile 0 and row half 0, destination lanes 0,4,16,20 all read source lane 0. Their high physical coordinates are respectively (0,0),(1,0),(0,1),(1,1). This is an explicit one-to-four repetition trace, not bilinear interpolation.</p>
{repeat_diagram()}
<h2 id="transition-merge">Step 6 — add the saved skip and hand ownership to the ordinary block</h2>
<p>The high-resolution skip arrives from normal packed tile storage through 16-byte global loads. <code>ScaledWindowResidual</code> decodes E4M3 if needed, multiplies the skip by its learned transition scale in Half, and retains the rounded product. The repeated projection is added with <code>HalfAdd</code>. The kernel then clears coordinates outside the destination field before the FFN sees them. This order matters: multiplying a padded skip or projecting zero input is not a substitute for applying the final spatial-validity mask after the merge.</p>
{code(UP+'fp8/window_block_wide_upsample_fp8.cu',81,113,'Nearest repetition, separately rounded skip product, masking, and publication')}
<p>Wide decoder entries publish the merged window into the reusable shared slab and synchronize. The subsequent ordinary FFN/attention consumes this working-precision tensor with the same cross-warp ownership described in <a href="fused-windows.html">the fused-window chapter</a>. C32 is intentionally different: its <code>r_Merged</code> array remains available for the FFN residual, while the FFN matrices consume its published form. This is the record-66 raw-merge exception documented in the model architecture. Treating all destination widths as one generic residual path would lose that distinction, especially in FP8.</p>
{code(UP+'fp8/window_block_c32_upsample_fp8.cu',140,153,'Record 66 retains raw Half merge for the FFN residual')}
{note('Optimization lesson: transition fusion removes separate pool, layout-copy, projection, repeat, and merge intermediates while preserving their numerical order. Global memory still stores the encoder skip and the next-level field because later stages consume them. Shared memory is used where warps exchange channel panels; shuffles handle spatial neighbors already present within one warp. No runtime benchmark is implied by these source-level traffic reductions.')}
'''


CHAPTERS = [
    dict(slug='frontend', title='Input and output C32: pixels, fragments, and composition',
         summary='Records 0 and 70: texture features, shared Half adapter, raw residuals, pooling, output head, and temporal composition.', body=FRONTEND),
    dict(slug='fused-windows', title='Fused C32–C256 windows: ownership is the optimization',
         summary='Follow physical tokens through packed loads, streamed FFNs, shared panel exchanges, normalized attention, and publication.', body=FUSED),
    dict(slug='local-transitions', title='Local encoder and decoder transitions: pool, project, repeat, merge',
         summary='Trace exact lane shuffles, channel-plane byte addresses, padding, and FP8 publication across resolution changes.', body=TRANSITIONS),
]
