"""Source-derived, scalar-level storage/ownership illustrations for each lesson.

Coordinates in an MMA drawing are instruction coordinates. FP8 model-channel
permutation is called out explicitly; byte offsets always name their base.
"""
from html import escape
import re
from common import ROOT, svg, code

INK = '#19394c'
TOKEN = '#d9eee9'
SELECT = '#ffc66d'
WEIGHT = '#dddff8'


def text(x, y, value, size=15, anchor='start'):
    return f'<text x="{x}" y="{y}" style="font:{size}px system-ui,sans-serif;fill:{INK}" text-anchor="{anchor}">{escape(str(value))}</text>'


def rect(x, y, w, h, fill=TOKEN, stroke='#75919d'):
    return f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="3" fill="{fill}" stroke="{stroke}"/>'


def box(x, y, w, lines, fill=TOKEN):
    h=26*len(lines)+22
    return rect(x,y,w,h,fill)+''.join(text(x+12,y+28+26*i,s) for i,s in enumerate(lines))


def arrow(x1,y1,x2,y2):
    return f'<path class="edge" d="M{x1} {y1} L{x2} {y2}"/>'


def figure(title,height,inner,caption):
    return svg(title,f'0 0 1060 {height}',inner,caption)


def evidence(path, needle, after=10):
    lines=(ROOT/path).read_text(encoding='utf-8').splitlines()
    i=next(i for i,line in enumerate(lines) if needle in line)
    return code(path,i+1,min(len(lines),i+after),'Source for the highlighted mapping')


def grid(x,y,rows,cols,cw,ch,selected,row=None,column=None):
    s=''
    for r in range(rows):
        for c in range(cols):
            fill=SELECT if (r,c)==selected else TOKEN if r==row else WEIGHT if c==column else '#f5f6f4'
            s+=rect(x+c*cw,y+r*ch,cw-1,ch-1,fill)
    return s


def mma_cells(fp8):
    """One input scalar, a weight scalar and a distinct output owner."""
    k=32 if fp8 else 16
    selected_k=4 if fp8 else 2
    s=text(20,25,'Follow token row 3: one scalar contribution to output channel 2',20)
    s+=text(20,62,f'A: 16 token rows × K{k}')+text(405,62,f'B: K{k} × 8 output channels')+text(775,62,'D: 16 tokens × 8 outputs')
    s+=grid(20,85,16,k,320/k,19,(3,selected_k),row=3)
    s+=grid(410,85,k,8,29,304/k,(selected_k,2),column=2)
    s+=grid(775,85,16,8,30,19,(3,2),row=3)
    s+=text(20,414,f'A[3,{selected_k}]: lane 13, word 0')
    s+=text(405,414,f'B[{selected_k},2]: lane 9, word 0')
    s+=text(775,414,'D[3,2]: lane 13, word 0')
    s+=arrow(345,235,395,235)+text(359,224,'×',22)+arrow(652,235,758,235)+text(665,224,'+ C',20)
    s+=box(20,449,490,[f'Chosen scalar: {"byte 0 of E4 word" if fp8 else "low Half of word"}',f'D[3,2] ← C[3,2] + Σ k=0…{k-1} A[3,k] B[k,2]',f'The colored row requires all {k} inputs.'],TOKEN)
    s+=box(550,449,490,['One MMA is issued collectively by 32 lanes.','Lane 13 does not compute this dot product alone.','A owner ≠ B owner; hardware combines fragments.'],WEIGHT)
    caption=('The orange cells are one multiplication, not the entire dot product. Pale green marks the selected token; purple marks its output-column weights. '
             'All coordinates here are local to one instruction. Add the kernel’s M/N/K bases to address a full tensor.')
    body='<h3 class="token-visual-heading">Under the microscope: what exactly enters one MMA?</h3>'+figure('A single token scalar through a warp-wide MMA',565,s,caption)
    body+=f'<p>For lane L, let g=L//4 and q=L%4. The highlighted A scalar uses g=3,q=1; B uses g=2,q=1. The output scalar uses g=3,q=1 again. These are <strong>three operand ownership maps</strong>, not a chain of thread-to-thread scalar multiplies. The selected result is the low Half of D word 0. For a pointwise projection, the row stays the same model token and N labels learned output channels; in QKᵀ, N instead labels key tokens.</p>'
    if fp8:
        body+='<p>In this repository’s native E4 activation packing, instruction K=4 corresponds to model channel 2: <code>packed_input_index(4)=2</code>. The packed weights use the matching inverse permutation. A physical byte labeled K=4 must not be read as model channel 4. For probability-times-value, apply the same distinction to the key axis.</p>'
    s=text(20,28,'Zoom into lane 13: a 16-byte input packet contains two token rows',20)
    labels=([['t3 c2','t3 c3','t3 c10','t3 c11'],['t11 c2','t11 c3','t11 c10','t11 c11'],
             ['t3 c18','t3 c19','t3 c26','t3 c27'],['t11 c18','t11 c19','t11 c26','t11 c27']] if fp8 else
            [['t3 c2','t3 c3'],['t11 c2','t11 c3'],['t3 c10','t3 c11'],['t11 c10','t11 c11']])
    for word,values in enumerate(labels):
        x=20+word*260
        s+=text(x,74,f'A word {word} · bytes {208+4*word}–{211+4*word}')
        for i,val in enumerate(values):
            s+=rect(x+i*60,90,59,58,SELECT if word==0 and i==0 else TOKEN if word%2==0 else '#e2e7f1')
            # Short labels on two lines stay readable at the normal 820px SVG width.
            t,c=val.split()
            s+=text(x+i*60+29,111,t,13,'middle')+text(x+i*60+29,133,c,13,'middle')
    s+=box(20,190,490,['512-byte instruction-A panel','32 lanes × 16 bytes; lane 13 starts at 208 B','Offsets above are relative to that panel.'])
    s+=box(550,190,490,['Model token 3 contributes to many output channels.','Its remaining channel pairs live in lanes 12,14,15.','A token is distributed; it is not one thread.'],WEIGHT)
    if fp8:
        s+=text(20,321,'Publication: word 0 = pack(Half pair [c2,c3], Half pair [c10,c11]); both belong to token 3.')
    else:
        s+=text(20,321,'Publication: two adjacent N8 result fragments become A words [D0,D1,D2,D3] for the next K16.')
    body+=figure('Token identity inside each packed lane word',350,s,'Channel labels are model channels within the first C32 panel. FP16 draws its first K16 chunk; its second chunk adds 16 to all channel labels. FP8 draws the complete K32 chunk.')
    return body


def bank_map():
    s=text(20,28,'The actual shared layout: contiguous lane packets, not an added XOR swizzle',20)
    s+=text(20,61,'One 512-byte panel: byte = 16·lane + 4·word; bank = (byte // 4) mod 32')
    for bank in range(32):
        x=90+bank*29
        s+=text(x+13,97,bank,12,'middle')
        for group in range(4):
            lane=8*group+bank//4; word=bank%4
            s+=rect(x,109+group*49,28,43,SELECT if lane==13 and word==0 else TOKEN if lane==13 else '#edf1f3')
            s+=text(x+13,126+group*49,f'L{lane}',10,'middle')+text(x+13,143+group*49,f'w{word}',10,'middle')
    for g in range(4):s+=text(16,134+g*49,f'128B {g}',12)
    s+=box(20,335,490,['Lane 13, word 0 → byte 208','208 // 4 = 52 → bank 20','Lanes 5,13,21,29 share this bank index.'])
    s+=box(550,335,490,['Bank index alone does not prove a conflict.','These four words are in different 128B regions.','Inspect actual load width and transactions.'],WEIGHT)
    s+=text(20,460,'Stage/panel offsets in these layouts are multiples of 512 B, so they do not change these low bank bits.')
    return '<h3 class="token-visual-heading">Shared-memory address bits and banks</h3>'+figure('Native shared packet address to 32-bank map',490,s,
        'Rows are address regions, not measured issue cycles. For a vector load the compiler and hardware determine instruction splitting; scalarized loads can behave differently. This figure derives addresses, and does not claim measured conflict-free execution.')+'''
<p>The layout already matches <code>uint4</code> fragment loads. A producer places lane L’s four words at <code>panel+16L</code>, and the consumer reads that same vector. No <code>lane XOR row</code> transformation is applied here. The 32-bank, four-byte-word model follows the <a href="https://docs.nvidia.com/cuda/cuda-programming-guide/02-basics/writing-cuda-kernels.html#shared-memory-access-patterns">CUDA shared-memory bank description</a>. A bank-conflict diagnosis must use the emitted instruction and its transaction grouping; the same bank number across a whole warp is insufficient evidence.</p>'''


def local_exchange(c,fp8):
    heads=c//32; chunks=1 if fp8 else 2
    offset=((1*heads+1)*chunks*32+13)*16
    s=text(20,28,f'C{c}: follow physical token 19, channel 34, across a warp handoff',20)
    s+=box(20,60,320,['Physical token = tile 1, row 3','Window pixel (x=7,y=0)','Natural row-major token = 7'])
    s+=arrow(340,110,385,110)+box(390,60,650,[f's_Tile[1][1][0][13].x → shared base + {offset} bytes',f'((((1×{heads}+1)×{chunks}+0)×32+13)×16)',f'{"byte 0 of E4 word" if fp8 else "low Half"}; token identity is unchanged by the store.'],SELECT)
    labels=(['warp 0: tiles 0,1 / both panels','warp 1: tiles 2,3 / both panels'] if c==64 else
            [f'warp {w}: expert {w} → C32 panel {w}' for w in range(heads)])
    y=218
    for i,label in enumerate(labels):
        s+=box(20+(i%2)*520,y+(i//2)*74,495,[label],SELECT if i==(0 if c==64 else 1) else TOKEN)
    y+=((len(labels)+1)//2)*74+10
    s+=rect(20,y,1020,39,'#ffe6da')+text(36,y+26,'Store published FFN Z → __syncthreads() → every head warp may read every channel panel')
    y+=61
    for w in range(heads):
        s+=box(20+(w%2)*520,y+(w//2)*74,495,[f'warp {w}: Q/K/V head {w}, reads token 19 / panel 1'],WEIGHT)
    y+=((heads+1)//2)*74+10
    s+=text(20,y+22,'The same shared word fans out to several warps; learned weights give it a different contribution in each head.')
    body='<h3 class="token-visual-heading">A token crosses a storage boundary, not a model boundary</h3>'+figure('Token-level shared publication and new warp ownership',y+55,s,
        'This trace starts at published FFN Z, after any input gather or decoder merge. C64 changes from token-parallel FFN ownership to head-parallel attention. C128/C256 have one expert/panel per warp before the dense mix.')
    body+='<p>Physical token 19 means tile 1, row 3; it is natural row-major token 7 in this window. Channel 34 means C32 panel 1, channel 2. Chunk 0 contains this scalar in both precisions. The address formula is independent of which warp currently produces the tensor.</p>'
    body+=evidence('csrc/kernel_impl/shared/common/warp_window_wide.cuh','uint4 s_Tile',28)
    body+='<p>During the later attended-head exchange, panel 1 is written by head warp 1 and consumed by every output-channel warp. Those are new values at the same offsets. The pre-overwrite barrier ends the old readers’ lifetime; the post-store barrier starts the new readers’ lifetime. A register shuffle cannot perform this cross-warp exchange.</p>'
    return body


def lane_launch(name):
    fp8=name.endswith('fp8')
    match=re.search(r'window_block_c(32|64|128|256)',name)
    if match:
        c=int(match[1]);warps=c//32
        roles=([['all four 4×4 token tiles','one C32 head']] if c==32 else
               [[f'FFN tiles {2*w},{2*w+1}; all C64','attention head '+str(w)] for w in range(2)] if c==64 else
               [[f'FFN expert / panel {w}',f'attention head {w}; all 64 tokens'] for w in range(warps)])
        grid_note='Grid XY selects the 8×8 window; OriginX / OriginY select its phase.'
    elif name.startswith(('input_preprocess','output_window')):
        warps=1;roles=[['all 64 pixels in the window','boundary features + fused C32 body']]
        grid_note='Grid XY selects one origin-adjusted 8×8 window. Texture/surface work shares this warp.'
    elif name.startswith('global_attention'):
        warps=4;roles=[[f'query rows {64*w}…{64*w+63}','all streamed key tiles; one head'] for w in range(4)]
        grid_note='block.x = head; block.y = 256-query block. Row numbers below are relative to that block.'
    elif name.startswith('global_'):
        warps=4;n=96 if name.startswith('global_qkv') else 64
        roles=[[f'token rows {64*(w//2)}…{64*(w//2)+63}',f'columns {n*(w%2)}…{n*(w%2)+n-1}'] for w in range(4)]
        grid_note='Grid selects the token/output tile; split variants also select a K slice. Add these bases below.'
    elif name.startswith('decoder_upsample'):
        warps=2;roles=[[f'all 16 low token rows',f'128 output channels: {128*w}…{128*w+127}'] for w in range(2)]
        grid_note='Grid XY selects a low 4×4 tile and C256 slab; split selects one K256 contribution.'
    elif name.startswith('window_qkv'):
        warps=4;roles=[[f'head 4·block.z + {w}','all 64 query/key/value positions'] for w in range(4)]
        grid_note='Grid XY selects the phase-shifted 8×8 window; grid Z selects four of the sixteen heads.'
    else:
        ffn=name.startswith(('window_ffn_c512','window_ffn_input_view'))
        warps=8 if (ffn and fp8 and 'input_view' not in name) or name.startswith(('channel_projection','window_attention_projection_c512')) else 4
        roles=[[f'4×4 tiles {2*(w//4)},{2*(w//4)+1}' if warps==8 else 'all four 4×4 tiles',
                f'{"FFN group" if ffn else "C64 output group"} {w%4} within CTA slab'] for w in range(warps)]
        grid_note='Grid XY/Z selects the spatial region and channel/group slab; formulas in this section give its base.'
    s=text(20,28,f'Launch block = (32,{warps},1): {warps} warps, {32*warps} CUDA threads',20)
    s+=text(20,60,grid_note,14)
    for w,role in enumerate(roles):
        x=20+(w%2)*520;y=88+(w//2)*117
        s+=box(x,y,500,[f'warp {w}: threadIdx.y = {w}',*role],SELECT if w==0 else TOKEN)
    y=88+((warps+1)//2)*117+12
    s+=text(20,y,'Zoom into any one warp: threadIdx.x is the lane number; x varies fastest.',16)
    for lane in range(32):
        x=20+lane*32
        s+=rect(x,y+20,30,36,SELECT if lane==13 else '#edf1f3')+text(x+15,y+44,lane,12,'middle')
    s+=text(20,y+89,'lane 13 → A(token rows 3,11) and D(row 3,11; channel pair 2,3), relative to one instruction tile.')
    s+=text(20,y+119,'Ready warps may interleave. The numbered boxes specify ownership, not an execution order.')
    return '<h3 class="token-visual-heading">From the launch grid down to one lane</h3>'+figure('Launch geometry, warp roles and lane ownership',y+145,s,
        'MMA is an instruction inside each warp, not a separately launched kernel. A memory wait or data dependency affects eligibility to issue; a CTA barrier coordinates the participating warps. No fixed SM assignment or cycle schedule is asserted.')


def gather_trace(fp8,path):
    s=text(20,28,'One gathered word: source pixel (3,0) → shared word 52 → consumer lane 13',20)
    s+=box(20,65,495,['Example: H=8, W=120, CTA origin=(0,0), t=0','j = warp·32 + lane + copy·128 = 52','Copy producer: warp 1, lane 20, copy 0'])
    s+=box(550,65,490,['j bits [9…0] = 0000110100','y = 4j9 + j6 + 2j0 = 0','x = 4j8 + (j5 j4)₂ = 3'],WEIGHT)
    s+=box(20,200,495,['plane = 4t + 2j7 + j1 = 0','component = (j3 j2)₂ = 1','global byte = ((0·8+0)·120+3)·16+4 = 52'])
    s+=arrow(515,250,550,250)+box(550,200,490,['cp.async copies exactly 4 bytes','shared byte = 4096·(t mod 2) + 4j = 208','CopyWait0 + ArriveAndWait before use'],SELECT)
    s+=arrow(795,300,795,340)
    s+=box(20,345,1020,['Consumer: spatial fragment 0, K subtile 0, lane 13, word 0 → shared + 13·16 = 208',
                            'All four compute warps read this word for their distinct FFN groups.',
                            'The highlighted bytes encode '+('model channels [2,3,10,11]' if fp8 else 'model channels [2,3]')+' of token row 3.'],TOKEN)
    s+=text(20,485,'Producer lane 20 ≠ consumer lane 13. The address transformation performs the layout conversion.')
    body='<h3 class="token-visual-heading">Bit-by-bit gather: producer and consumer are different threads</h3>'+figure('Channel-plane gather to native shared fragment',520,s,
        'Here t is the reduction iteration. j9 means bit 9 of j. This is a gather/permutation into a native packet layout, not a shared-memory XOR swizzle.')
    return body+evidence(path,'const int sl_Word',23)


def bulk_trace(fp8):
    # Common example: first native input stripe, where all reduction/row bases vanish.
    s=text(20,28,'A token packet crosses the asynchronous-copy boundary',20)
    s+=box(20,70,315,['Global native A panel','token 3, model channel 2','scalar at panel base + 208 B'])
    s+=arrow(335,117,380,117)+box(385,70,290,['SM90+: elected lane issues','bulk global → shared copy','copy engine preserves byte order'],WEIGHT)
    s+=arrow(675,117,720,117)+box(725,70,315,['Shared native A panel','same scalar: stage panel + 208','no intermediate thread register'],SELECT)
    s+=box(20,215,490,['SM80/89 fallback of CopyBulk','lane 13 issues 16 B at stripe + 208','512 B copy: every lane copies one packet'],TOKEN)
    s+=box(550,215,490,['1024 B copy: same lane also copies +720 B','that is the next 512 B instruction-K panel','FP8 execution itself requires SM89 or later'],WEIGHT)
    s+=arrow(790,170,790,330)+box(550,345,490,['Barrier completion → lane 13 loads uint4','A word 0 holds the selected input scalar','A is reused with several output B panels'],SELECT)
    s+=box(20,345,490,['W bypasses this shared staging allocation','packed global W → __ldca → B registers','MMA reads A/B registers and Half C words'])
    s+=text(20,480,'Global address ≠ shared address. The copy preserves the offset inside the packet, not the pointer value.')
    return '<h3 class="token-visual-heading">Track one byte range through the copy protocol</h3>'+figure('Global packet to shared storage to MMA registers',515,s,
        'Offsets are relative to the selected 512-byte A panel. The surrounding stage equations select that panel. Hardware cache service is not a separately addressed tensor.')+evidence('csrc/kernel_impl/shared/common/intrinsics.cuh','__device__ __forceinline__ void CopyBulk',32)


def kv_trace(fp8,path):
    size=2048 if fp8 else 4096
    s=text(20,28,'Global attention: Q stays in registers while K and V rotate through shared',20)
    s+=box(20,65,490,['Example: head 0, query block 0, key tile 0',
                           'Q token 3 / model channel 2: g_Query + 208 B',
                           'warp 0, lane 13, A word 0; held across key tiles'])
    s+=box(550,65,490,['K token 2 / model channel 2: g_Key + 144 B',
                            'copy slot 0 → shared K base + 144 B',
                            'lane 9, word 0 becomes B[reduction, key 2]'],SELECT)
    s+=text(20,205,'Shared byte ranges: colors mark allocations, not separate hardware memories.',16)
    for i,label in enumerate(['K slot 0','K slot 1','V slot 0','V slot 1']):
        x=20+i*260
        s+=rect(x,230,250,76,SELECT if i==0 else TOKEN if i<2 else WEIGHT)
        s+=text(x+125,257,label,17,'middle')+text(x+125,286,f'[{i*size}, {(i+1)*size}) bytes',14,'middle')
    s+=box(20,350,490,[f'K0 and V0 share barrier at byte {4*size}',
                           f'K1 and V1 share barrier at byte {4*size+8}',
                           'WaitStage waits for both K and V traffic.'])
    s+=box(550,350,490,['Q[3,:] × K[2,:] → score [3,2]',
                            'published score operand × V → output row 3',
                            'V is pretransposed for its B-operand role.'],WEIGHT)
    s+=text(20,490,f'Key tile 2 reuses K0/V0 only after old consumers finish; each K or V slot holds 64×32×{1 if fp8 else 2} bytes.')
    return '<h3 class="token-visual-heading">Separate query lifetime from key/value lifetime</h3>'+figure('A query and key scalar through the K/V shared ring',525,s,
        'The selected K scalar is byte 0 of lane 9’s word for E4, or its low Half for FP16. Q/K offsets assume first token group and first head; larger groups add the source strides. V has its own pretransposed addressing, not the K address formula.')+evidence(path,'const auto StageKeyValue',31)


def local_scalar(fp8,view=False):
    s=text(20,28,'C32 token 3, channel 2: from the input allocation to an instruction',20)
    s+=grid(20,78,8,8,35,35,(0,3),row=0)
    for y in range(8):
        for x in range(8):s+=text(20+x*35+17,78+y*35+23,8*y+x,12,'middle')
    s+=text(20,386,'Natural pixel/token index in the 8×8 window',13)
    s+=box(360,78,680,['Selected pixel (3,0): natural token 3 = physical tile 0, row 3',
                           'Channel 2 is part of lane 13’s word 0; channel pairs use lanes 12…15.',
                           'Example below: first input tile, panel 0, chunk 0; zero window origin.'],SELECT)
    if view:
        lines=['Spatial view: plane 0, y=0, x=3, component=1',
               'global byte = ((0·H+0)·W+3)·16 + 4 = 52',
               'lane 13 loads this uint32 directly into A word 0.']
    else:
        lines=['Native input: tile base + chunk·512 + lane·16',
               'selected scalar is at g_Input + 208 bytes',
               'lane 13 loads uint4; word 0 contains the scalar.']
    s+=box(360,222,680,lines,TOKEN)
    s+=arrow(697,330,697,376)+box(360,380,680,['A remains a register fragment; packed W loads supply B.',
                                                  'One warp computes the whole M16×N8 result per MMA.',
                                                  'For this token, D[3,2] is lane 13 / word 0 / low Half.'],WEIGHT)
    s+=text(20,520,'The C32 ordinary body has no shared tensor allocation. Inter-lane exchange uses shuffle instructions.')
    return figure('One pixel through native or view input addressing',555,s,
        'The orange pixel is one complete model token, spread across channel pairs in several lanes. A cache may serve the load; cache residency does not change the byte address. Matrix multiplication changes its channel values while retaining its row identity.')


def stage_schedule(stages):
    s=text(20,28,f'One packet survives a {stages}-slot ring: storage reuse follows consumption',20)
    cols=6;cw=133
    for i,label in enumerate(['issue fill','wait ready','load A','MMA reuse','advance / wait','refill old slot']):
        s+=text(236+i*cw,68,label,12,'middle')
    rows=[('global packet t',['X[t]','pending','complete','','','X[t+S]']),
          ('shared slot t % S',['write','bytes ready','read','old bytes','readers done','overwrite']),
          ('lane 13 A words',['','','load +208','A × B0, B1…','no old s-read','new A later']),
          ('Half accumulator',['C previous','C previous','C previous','C += A × B','keep C','keep C'])]
    for r,(label,vals) in enumerate(rows):
        y=90+r*70;s+=text(15,y+30,label,14)
        for i,val in enumerate(vals):
            s+=rect(174+i*cw,y,cw-4,54,SELECT if r==1 and i in (2,5) else TOKEN if r==2 else '#edf1f3')
            s+=text(174+i*cw+(cw-4)/2,y+31,val,12,'middle')
    s+=text(20,405,f'S = {stages}; iteration t and t+{stages} use the same shared slot but different barrier phases.')
    s+=text(20,438,'Arrows in the source define a partial order. Copy/compute overlap is possible; this is not a cycle trace.')
    return figure('Token packet lifetime and safe shared-ring reuse',470,s,
        'The lesson’s source loop specifies whether it prefills all slots or issues the next slot just in time. The diagram isolates one packet’s dependencies; it does not reorder that loop or replace its synchronization.')


def attention_tokens(global_attention=False):
    s=text(20,28,'One query token meets one key token, then consumes that key’s value',20)
    s+=box(20,65,300,['Q token 3: 32 channels','A row 3; channel fragments','weights from the Q projection'])
    s+=box(375,65,300,['K token 2: 32 channels','B column 2 in QKᵀ','same feature axis as Q'],WEIGHT)
    s+=arrow(320,114,375,114)+arrow(675,114,720,114)
    s+=box(725,65,315,['Score S[3,2]','D lane 13, low Half of word 0','reduce all 32 head channels'],SELECT)
    s+=text(20,205,'A score row belongs to query 3. Its 64 key columns are distributed across four lanes:',16)
    for key in range(64):
        x=20+(key%32)*32;y=225+(key//32)*58
        lane=12+(key%8)//2
        s+=rect(x,y,30,50,SELECT if key==2 else TOKEN if lane==13 else '#edf1f3')
        s+=text(x+15,y+19,key,11,'middle')+text(x+15,y+39,f'L{lane}',10,'middle')
    s+=box(20,365,495,['Surrogate E(S[3,2]) and row denominator','register sums + lane shuffles','no global score tensor for this row'],SELECT)
    s+=arrow(515,415,550,415)+box(555,365,485,['P[3,2] becomes an A-operand value','V token 2 supplies B values for output channels','O[3,n] accumulates P[3,2] × V[2,n]'],WEIGHT)
    if global_attention:
        s+=text(20,495,'Global path: accumulate unnormalized numerator and row sums across K/V tiles; divide the final output.')
        s+=text(20,525,'P here names the published surrogate operand. The final reciprocal is delayed until all key tiles finish.')
    else:
        s+=text(20,495,'Local path: normalize over this window’s 64 keys, publish probability operands, then multiply by V.')
        s+=text(20,525,'Key token 2 becomes a reduction coordinate in P×V; query token 3 remains the output row.')
    return '<h3 class="token-visual-heading">The meaning of the MMA axes changes inside attention</h3>'+figure('Query token 3 and key token 2 through score and value MMA',555,s,
        'Key numbers are relative to the current 64-key tile; channel numbers in Q/K are a different axis. The highlighted score resides in registers. The selected query/key example assumes valid, non-broadcast tokens.')


def norm_shuffle():
    s=text(20,28,'Query/key token 3: four lanes exchange register sums, with no shared address',20)
    for q in range(4):
        x=20+260*q
        s+=box(x,72,240,[f'lane {12+q}: token row 3',f'channels {2*q},{2*q+1}, {8+2*q},{9+2*q}',f'also +16 → local Half2 s{q}'],SELECT if q==1 else TOKEN)
    for q in range(4):
        x=20+260*q
        s+=arrow(x+120,172,20+260*(q^2)+120,242)
        s+=box(x,249,240,[f'lane {12+q} reads lane {12+(q^2)}',f'HalfAdd(s{q}, s{q^2})'],WEIGHT)
        s+=arrow(x+120,323,20+260*(q^1)+120,393)
        s+=box(x,400,240,[f'lane {12+q} reads lane {12+(q^1)}','all 4 lane contributions'],SELECT if q==1 else TOKEN)
    s+=text(25,214,'XOR 2',16)+text(25,368,'XOR 1',16)
    s+=box(20,506,1020,['Within each lane: swap the low/high Half components, then HalfAdd → same norm in both halves.',
                            'Clamp with epsilon → reciprocal square root → multiply this token’s channel pairs.',
                            'Row-half 1 repeats the process for token 11; its values never mix with token 3.'])
    return '<h3 class="token-visual-heading">Trace a token through the register shuffle network</h3>'+figure('Four-lane register butterfly for one token norm',620,s,
        'Arrows show which lane supplies a register word to ShuffleBfly. The local square tree precedes these exchanges. Each HalfAdd remains separately rounded in source order; “all 4” denotes contributors, not permission to reassociate the arithmetic.')


def repack_bits(name):
    fp8=name.endswith('fp8');words=256 if fp8 else 512
    t,cw=309,13
    f=lambda t,cw:(t//16)*16*words+(cw//8)*128+(t%8)*16+(cw%4)*4+(cw%8//4)*2+t%16//8
    s=text(20,28,'One pixel’s channel word: logical thread index and physical address are different',20)
    s+=box(20,65,490,[f'token t=309, W=60 → pixel (x=9,y=5)','spatial tile index 17, row 5 → S(t)=277',f'channel word cw=13; logical i=t·{words}+13={t*words+13}'])
    s+=box(550,65,490,[f'Covering grid, first iteration: block {(t*words+13)//256}',f'threadIdx.x=13 → warp 0, lane 13','This lane copies bits; no MMA instruction.'],WEIGHT)
    labels=['t2','t1','t0','c1','c0','c2','t3']
    vals=[(t>>2)&1,(t>>1)&1,t&1,(cw>>1)&1,cw&1,(cw>>2)&1,(t>>3)&1]
    for i,(label,v) in enumerate(zip(labels,vals)):
        x=25+i*145
        s+=text(x+65,224,f'word bit {6-i}',14,'middle')+rect(x,240,130,73,TOKEN if label[0]=='t' else WEIGHT)
        s+=text(x+65,268,label,17,'middle')+text(x+65,296,v,19,'middle')
    s+=text(20,350,'Address low bits: [t2 t1 t0 c1 c0 c2 t3] = 1010110₂ = 86 uint32 words')
    s+=box(20,380,490,[f'Token-layout byte offset: 4·F(309,13) = {4*f(309,13)}',f'Spatial-layout byte offset: 4·F(277,13) = {4*f(277,13)}','The inner 86-word displacement is identical.'])
    s+=box(550,380,490,['2D→1D: spatial input → token output','1D→2D: token input → spatial output','No decode, shared buffer, or quantization.'],SELECT)
    return figure('Token and channel bits become physical word-address bits',505,s,'t0…t3 are the low four bits of the token index; c0…c2 are the low three bits of cw. The outer group and panel terms are then added. A smaller grid reaches the same logical work through its grid-stride loop.')


def append_section(body,choices,extra):
    for ident in choices:
        match=re.search(r'<h2 id="'+re.escape(ident)+r'">.*?(?=<h2 |\Z)',body,re.S)
        if match:return body[:match.end()]+extra+body[match.end():]
    raise ValueError(f'No visualization insertion point among {choices}')


def enrich(lesson,entry):
    name=lesson['name'];body=lesson['body'];fp8=name.endswith('fp8')
    path='csrc/'+entry['header']
    if name.startswith('repack_'):
        lesson['body']=append_section(body,['address'],repack_bits(name));return
    if name=='completion_counter_clear':
        s=text(20,28,'Counter 299 follows one thread’s store path',20)
        for i,(heading,detail) in enumerate([('block 1 / 256 threads','thread 43 = warp 1, lane 11'),('register/immediate −1','32 bits: 0xFFFFFFFF'),('global counter[299]','base + 4·299 = base +1196')]):
            s+=box(20+i*350,85,320,[heading,detail],SELECT if i==2 else TOKEN)
            if i<2:s+=arrow(340+i*350,125,365+i*350,125)
        s+=text(20,220,'thread 44 → counter 300 → guard rejects it. No activation token, shared-memory traffic or MMA.')
        lesson['body']=append_section(body,['address'],figure('Counter element through lane and global store',255,s,'This scheduling kernel owns control words rather than model tokens. The same launch/lane/address reasoning applies.'));return
    body=append_section(body,['ownership','tiling','tile','storage'],lane_launch(name))
    local=re.search(r'window_block_c(32|64|128|256)',name)
    if local:
        c=int(local[1])
        if c>32:body=append_section(body,['ffn'],local_exchange(c,fp8)+bank_map())
        elif 'upsample' not in name:
            body=append_section(body,['input'],local_scalar(fp8,'input_view' in name))
        body=append_section(body,['qkv'],norm_shuffle())
        body=append_section(body,['attention'],attention_tokens())
    elif name.startswith(('input_preprocess','output_window')):
        body=append_section(body,['storage'],attention_tokens())
    elif name.startswith('global_attention'):
        body=append_section(body,['pipeline'],kv_trace(fp8,path)+bank_map()+stage_schedule(2))
        body=append_section(body,['numerator'],attention_tokens(True))
    else:
        gather=name.startswith('window_ffn_input_view_')
        if gather:body=append_section(body,['layout'],gather_trace(fp8,path))
        stages=2
        if name.startswith('global_ffn_expand') or name.startswith('channel_projection'):stages=3
        elif name.startswith('global_ffn_contract') and not fp8:stages=3
        elif name.startswith(('window_ffn_projection','window_attention_projection')) and 'pool' not in name:stages=3
        body=append_section(body,['pipeline'],('' if gather else bulk_trace(fp8))+bank_map()+stage_schedule(stages))
        if name.startswith(('window_qkv','global_qkv')):
            body=append_section(body,['normalization'],norm_shuffle())
        if name.startswith('window_qkv'):body=append_section(body,['attention'],attention_tokens())
    lesson['body']=body
