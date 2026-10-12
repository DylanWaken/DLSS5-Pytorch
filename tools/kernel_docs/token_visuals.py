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

    local=re.search(r'window_block_c(32|64|128|256)',name)
    if local:
        c=int(local[1])
        if c>32:body=append_section(body,['ffn'],local_exchange(c,fp8))
        elif 'upsample' not in name:
            body=append_section(body,['input'],local_scalar(fp8,'input_view' in name))


    elif name.startswith(('input_preprocess','output_window')):
        pass
    elif name.startswith('global_attention'):
        body=append_section(body,['pipeline'],kv_trace(fp8,path))

    else:
        gather=name.startswith('window_ffn_input_view_')
        if gather:body=append_section(body,['layout'],gather_trace(fp8,path))
    lesson['body']=body
