"""Per-entry, exportable SVG atlases: tiling, full dataflow, and physical storage."""
from html import escape
from pathlib import Path
import hashlib
import json
import math
import re
import textwrap
from common import ROOT, source_url
from kernel_map_profiles import profile

OUT=ROOT/'docs/kernel-guide/assets/kernels'
MAPS=[]
INK='#183347'; MUTED='#546b7b'; LINE='#c5d3dc'
A='#ead9f1'; B='#f6ebbb'; D='#c8eadb'; SELECT='#ef8e34'; SHARED='#dce9fa'
WARPS=['#b6dece','#d4d1f0','#f5d5a7','#b7dcea','#dfdca9','#f0cbd5','#c4dbf2','#d6e3bb']


class Drawing:
    def __init__(self,p,title,height):
        self.p=p;self.title=title;self.height=height;self.parts=[]
        self.rect(0,0,1440,height,'#fbfcfd',stroke='none')
        self.text(24,35,title,24,bold=True)
        self.text(24,62,p['name'],14,MUTED)
        self.rect(24,78,1392,3,SELECT,stroke='none')

    def text(self,x,y,s,size=16,fill=INK,bold=False,anchor='start'):
        self.parts.append(f'<text x="{x}" y="{y}" text-anchor="{anchor}" style="font-family:Segoe UI,Arial,sans-serif;font-size:{size}px;fill:{fill};font-weight:{650 if bold else 400}">{escape(str(s))}</text>')

    def lines(self,x,y,s,width=44,size=15,fill=INK):
        lines=textwrap.wrap(s,width=width,break_long_words=False,break_on_hyphens=False) or ['']
        for i,line in enumerate(lines):self.text(x,y+i*(size+6),line,size,fill)
        return len(lines)*(size+6)

    def rect(self,x,y,w,h,fill,stroke=LINE,r=0,sw=1,title=''):
        self.parts.append(f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="{r}" fill="{fill}" stroke="{stroke}" stroke-width="{sw}">'+(f'<title>{escape(title)}</title>' if title else '')+'</rect>')

    def path(self,points,color=SELECT,dash=False):
        self.parts.append(f'<path d="M'+ ' L'.join(f'{x},{y}' for x,y in points)+f'" fill="none" stroke="{color}" stroke-width="2"'+(' stroke-dasharray="5 4"' if dash else '')+'/>')
        x,y=points[-1];px,py=points[-2];a=math.atan2(y-py,x-px)
        pts=[(x,y),(x-8*math.cos(a)+4*math.sin(a),y-8*math.sin(a)-4*math.cos(a)),(x-8*math.cos(a)-4*math.sin(a),y-8*math.sin(a)+4*math.cos(a))]
        self.parts.append('<polygon points="'+' '.join(f'{u:.1f},{v:.1f}' for u,v in pts)+f'" fill="{color}"/>')

    def grid(self,x,y,w,h,rows,cols,fill=D,selected=None,colors=None,labels=False,prefix=''):
        for r in range(rows):
            for c in range(cols):
                color=colors(r,c) if colors else fill
                if selected==(r,c):color=SELECT
                self.rect(x+c*w/cols,y+r*h/rows,w/cols,h/rows,color,stroke='#ffffff',sw=.65,title=f'{prefix}[{r},{c}]')
                if labels:self.text(x+(c+.5)*w/cols,y+(r+.67)*h/rows,f'{r},{c}',10,anchor='middle')
        self.rect(x,y,w,h,'none',stroke='#7c949d')

    def panel(self,x,y,w,h,title):
        self.rect(x,y,w,h,'#fff',r=8)
        self.text(x+16,y+28,title,18,bold=True)

    def finish(self,description):
        return (f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 {self.height}" role="img" aria-labelledby="title desc" data-kernel="{self.p["name"]}">'
                f'<title id="title">{escape(self.title)} — {escape(self.p["name"])}</title><desc id="desc">{escape(description)}</desc>'+''.join(self.parts)+'</svg>')


def product(d,x,y,width,m,k,n,rows=8,cols=8,colors=None,select=False):
    """A-left / B-above / D-below; each view is independently rescaled."""
    ax=x; bx=x+76; by=y; cy=y+64; cw=width-76
    d.grid(ax,cy,55,142,rows,4,A,selected=(min(3,rows-1),0) if select else None,prefix='A tile')
    d.grid(bx,by,cw,42,4,cols,B,selected=(0,min(2,cols-1)) if select else None,prefix='B tile')
    d.grid(bx,cy,cw,142,rows,cols,D,selected=(min(3,rows-1),min(2,cols-1)) if select else None,colors=colors,prefix='D tile')
    d.text(ax,cy-10,f'A: {m}×{k}',12)
    d.text(bx,by-10,f'B: {k}×{n}',12)
    d.text(bx,cy+158,f'D: {m}×{n}',14,bold=True)


def hierarchy(p):
    d=Drawing(p,'Tiling ladder — '+p['focus'],1010)
    dims=[('Whole logical operation', 'T',p['k'],p['n']),('One CTA contribution',p['cm'],p['k']//p['splits'],p['cn']),('One warp result',p['wm'],p['k']//p['splits'],p['wn']),('One MMA instruction',16,p['ik'],8)]
    for i,(label,m,k,n) in enumerate(dims):
        x=24+i*352
        d.panel(x,102,336,330,label)
        colors=None
        if i==1:
            wr=p['cm']//p['wm'];wc=p['cn']//p['wn']
            colors=lambda r,c:WARPS[min(wr-1,r*wr//8)*wc+min(wc-1,c*wc//8)]
        product(d,x+18,178,300,m,k,n,16 if i==3 else p['wm']//16 if i==2 else 8,p['wn']//8 if i==2 else 8,colors,i==3)
        if i==1:
            for r in range(wr):
                for c in range(wc):
                    d.text(x+94+(c+.5)*224/wc,242+(r+.5)*142/wr,f'warp {r*wc+c}',12,bold=True,anchor='middle')
        label2=('logical axes; packed storage differs' if i==0 else f'{p["warps"]} warps; colors = owners' if i==1 else f'{p["wm"]//16} M16 × {p["wn"]//8} N8 instructions' if i==2 else f'32 lanes; {p["fmt"]} A/B; Half C/D')
        d.text(x+17,421,label2,13)
        if i<3:d.path([(x+320,276),(x+348,276)])
    d.text(24,463,f'Focus axes: M = {p["m_axis"]}; N = {p["n_axis"]}; K = {p["k"]} reduction values. B is {p["matrix"]}.',16)
    d.text(24,491,'Each level is rescaled. Macro grids show subtiles; the lower zoom resolves individual scalars. Warp-grid cells are M16×N8 instructions.',14,MUTED)
    d.panel(24,518,1392,330,'Zoom into the first instruction: token / query 3, reduction channel 2, output / key 2')
    kval=4 if p['fp8'] else 2
    d.text(46,582,f'A: 16×{p["ik"]} distributed registers',16,bold=True)
    d.grid(46,603,410,192,16,p['ik'],A,selected=(3,kval),colors=lambda r,c:'#dbaee7' if r==3 else A,prefix='A instruction')
    d.text(510,582,f'B: {p["ik"]}×8 distributed registers',16,bold=True)
    d.grid(510,603,320,192,p['ik'],8,B,selected=(kval,2),colors=lambda r,c:'#e7d485' if c==2 else B,prefix='B instruction')
    d.text(888,582,'D: 16×8 Half accumulators',16,bold=True)
    d.grid(888,603,320,192,16,8,D,selected=(3,2),colors=lambda r,c:WARPS[(4*(r%8)+c//2)%8],prefix='D instruction')
    for r in range(16):
        for c in range(8):d.text(888+(c+.5)*40,603+(r+.8)*12,4*(r%8)+c//2,9,anchor='middle')
    d.path([(465,700),(499,700)]);d.path([(840,700),(877,700)])
    d.text(46,823,f'A[3,{kval}] → lane 13, word 0',14)
    d.text(510,823,f'B[{kval},2] → lane 9, word 0',14)
    d.text(888,823,'D[3,2] → lane 13, low Half',14)
    d.lines(1230,600,'Orange: one scalar product. D cell numbers are owner lanes. All 32 lanes collectively perform the reduction.',width=19,size=14)
    y=879
    for note in p['notes']:
        d.text(30,y,'• '+note,14);y+=29
    return d.finish('Kernel-specific logical, CTA, warp and instruction tiles. A is purple, B yellow, D green; orange follows one contribution. FP8 instruction K=4 corresponds to native model channel 2. CTA K denotes one split; loop iterations visit its instruction panels.')


def flow(p):
    stages=p['stages'];rows=math.ceil(len(stages)/3);height=172+rows*292+90
    d=Drawing(p,'Tensor and token route — every fused stage',height)
    d.text(24,111,f'Input: {p["input"]}    →    Output: {p["output"]}',16)
    d.text(24,139,'Orange follows one selected token within each operation. The spatial-boundary map resolves pooling and repetition where present.',14,MUTED)
    for i,s in enumerate(stages):
        row=i//3;col=i%3 if row%2==0 else 2-i%3;x=24+col*472;y=165+row*292
        d.panel(x,y,448,258,f'{i+1:02}  '+s['label'])
        fill={'shared':SHARED,'registers':D,'global':'#eceff2'}[s['storage']]
        d.rect(x+15,y+44,418,23,fill,stroke='none')
        d.text(x+24,y+61,s['storage'].upper()+' · '+(f'M{s["m"]} × N{s["n"]}' if not s['k'] else f'M{s["m"]} × K{s["k"]} × N{s["n"]}'),13)
        d.grid(x+18,y+86,190,100,8,8,fill,colors=lambda r,c:SELECT if r==3 else fill,prefix=s['label'])
        d.text(x+224,y+106,f'{s["m"]} token positions',14)
        d.text(x+224,y+132,f'{s["n"]} columns',14)
        d.text(x+224,y+158,'8 sampled rows / columns',12,MUTED)
        d.lines(x+18,y+212,s['detail'],width=53,size=14)
        if i:
            prevrow=(i-1)//3;prevcol=(i-1)%3 if prevrow%2==0 else 2-(i-1)%3
            px=24+prevcol*472;py=165+prevrow*292
            if row!=prevrow:d.path([(px+224,py+258),(x+224,y)])
            elif col>prevcol:d.path([(px+448,py+125),(x, y+125)])
            else:d.path([(px,py+125),(x+448,y+125)])
    y=165+rows*292
    d.text(24,y+20,'Lifetimes follow the arrows; blocks labeled “registers” are not intermediate global tensors.',16,bold=True)
    d.text(24,y+48,'Source order, residual inputs, normalization axes and precision changes are detailed in the adjacent walkthrough.',14,MUTED)
    return d.finish('The complete sequence of model operations fused by this public entry, with per-stage tensor dimensions and storage. Matrix grids are schematic tensor tiles, not literal scalar counts. Shared, register and global boundaries differ across entries and precisions.')


def storage(p):
    d=Drawing(p,'Physical storage and address microscope',1190)
    d.text(24,111,f'{p["warps"]} warps · {p["fmt"]} operand elements ({p["e"]} B) · {p["shared"]:,} explicitly declared shared bytes',17,bold=True)
    d.panel(24,136,436,285,'Global Q / K / V' if p['kind']=='global-attention' else 'Global input and packed weights')
    d.lines(42,193,p['input'],width=45,size=15)
    d.grid(42,243,175,100,8,8,A,selected=(3,2),prefix='global input')
    d.grid(250,243,175,100,8,8,B,selected=(2,2),prefix='K / V operands' if p['kind']=='global-attention' else 'packed B weights')
    d.text(42,370,'Global pointer + byte offset',14)
    d.text(42,394,'L2 / eligible L1: hardware managed',14,MUTED)
    d.panel(492,136,924,285,'CTA-local storage actually used by this entry')
    sk=p['shared_kind']
    if sk in ('ring','gather'):
        for i in range(p['slots']):
            x=510+i*290;d.text(x,199,f'Slot {i}: base + {i*p["slotbytes"]:,} B',15,bold=True)
            d.grid(x,216,266,118,p['slotbytes']//512,32,SHARED,selected=(0,13) if i==0 else None,prefix=f'shared slot {i}: panel,lane')
            d.text(x,359,f'{p["slotbytes"]:,} B = {p["slotbytes"]//512} native 512 B panels',13)
        d.text(510,382,'Each cell = uint4 (16 B); each row = one native panel, 32 lane packets.',14)
        d.text(510,406,f'Barriers: +{p["slots"]*p["slotbytes"]:,} B, {p["slots"]} × 8 B. Complete the copy before A loads.',14)
    elif sk=='kv':
        for i,label in enumerate(['K0','K1','V0','V1']):
            x=510+i*222;d.text(x,199,f'{label}: +{i*p["slotbytes"]:,} B',15,bold=True)
            d.grid(x,218,202,112,p['slotbytes']//512,32,SHARED if label[0]=='K' else B,selected=(0,13) if i==0 else None)
            d.text(x,357,f'64×32 {p["fmt"]}',13)
        d.text(510,393,f'K/V tile has {p["slotbytes"]:,} B; barriers begin at +{4*p["slotbytes"]:,} B. Q remains in registers.',14)
    elif sk=='exchange':
        h=p['heads'];chunks=1 if p['fp8'] else 2
        d.text(510,190,f's_Tile[4][{h}][{chunks}][32] : uint4',18,bold=True)
        d.grid(510,208,576,136,4,h,SHARED,selected=(1,1),colors=lambda r,c:WARPS[c])
        for i in range(4):d.text(1099,231+i*31,f'tile {i}: {i*16*p["c"]*p["e"]:,} B',14)
        d.text(510,373,f'Rows = physical 4×4 tiles; columns = C32 panels; {chunks} K chunk(s) / panel.',14)
        d.text(510,397,'FFN → barrier → QKV; later attended heads reuse these same addresses.',14)
    elif sk=='features':
        for i in range(2):
            x=510+i*445;d.text(x,191,f's_Plane[{i}][64] · C{i*8}…C{i*8+7}',16,bold=True)
            d.grid(x,211,412,128,8,8,SHARED,selected=(0,3) if i==0 else None)
            d.text(x,369,f'uint4 pixel packet; base + {1024*i} B',14)
        d.text(510,400,'Feature stores → block barrier → Half adapter gathers A words. C32 body stays in registers.',14)
    else:
        d.text(510,191,'No shared allocation for this kernel’s transformer body.',19,bold=True)
        d.grid(510,220,405,116,4,8,D,selected=(0,3),prefix='register token fragments')
        d.lines(950,229,'Global native tiles or spatial words load directly into the owning warp’s registers. Shuffle instructions exchange lane values.',width=43,size=15)
        d.text(510,394,'Each of the four physical token tiles has its own live register fragments.',14)
    d.path([(462,285),(489,285)])
    d.panel(24,451,1392,305,'Follow one address into lane 13 — bases and address spaces stay separate')
    if sk=='exchange':
        offset=((p['heads']+1)*(1 if p['fp8'] else 2)*32+13)*16
        lines=[f'Physical tile 1, C32 panel 1, chunk 0, lane 13 → shared + {offset} B.',
               f'Address = (((1×{p["heads"]}+1)×{1 if p["fp8"] else 2}+0)×32+13)×16.',
               'Selected model value: physical token 19 / window pixel (7,0), channel 34.',
               'Producer FFN ownership changes to head ownership; all head warps may read this panel.']
    elif sk=='gather':
        lines=['Copy ordinal j=52: producer warp 1, lane 20, copy 0; H=8, W=120, stage t=0.',
               'Source pixel (3,0), plane 0, component 1: global byte ((0×8+0)×120+3)×16+4 = 52.',
               'Destination shared + 4j = 208 B. Consumer lane 13 loads uint4 at shared + 16×13.',
               'The copy remaps producer lane 20 to compute lane 13; no additional XOR bank swizzle.']
    elif sk=='features':
        lines=['Feature pixel (3,0), plane 0: s_Plane[0][3] begins at shared byte 48.',
               'Adapter lane 13, word 0 selects pixel 3 and uint32 component 1 → shared byte 52.',
               'This Half word contains feature channels 2 and 3. Adapter K=16; its output has C32.',
               'Feature storage is row-major by pixel, unlike the later native MMA packet layout.']
    else:
        lines=[f'First native M16×K{p["ik"]} A panel: lane 13 packet begins at +13×16 = +208 B.',
               f'Word 0 carries '+('E4 channels [2,3,10,11]' if p['fp8'] else 'Half channels [2,3]')+' for physical token row 3.',
               ('K/V memory above stages different operands; this A example is the retained Q register packet.' if sk=='kv' else 'For staged A, add the selected slot and panel bases; for a direct load, add the global panel base.'),
               f'Weights / B have a different map: selected B scalar is owned by lane 9, not lane 13.']
    for i,line in enumerate(lines):d.text(45,500+28*i,line,16)
    # Four uint32 words: visual byte ownership rather than another prose box.
    labels=([['t3 c2','t3 c3','t3 c10','t3 c11'],['t11 c2','t11 c3','t11 c10','t11 c11'],['t3 c18','t3 c19','t3 c26','t3 c27'],['t11 c18','t11 c19','t11 c26','t11 c27']] if p['fp8'] else [['t3 c2','t3 c3'],['t11 c2','t11 c3'],['t3 c10','t3 c11'],['t11 c10','t11 c11']])
    if sk=='features':labels=[['t3 c2','t3 c3'],['t11 c2','t11 c3'],['t3 c10','t3 c11'],['t11 c10','t11 c11']]
    for w,values in enumerate(labels):
        x=44+w*341;d.text(x,639,f'A word {w} · lane 13',15,bold=True)
        for j,val in enumerate(values):
            cw=316/len(values);d.rect(x+j*cw,655,cw-2,54,SELECT if (w,j)==(0,0) else A)
            d.text(x+(j+.5)*cw,688,val,14,anchor='middle')
    d.text(45,737,'Labels are panel-relative; add the model channel base. This is an operand fragment, not a contiguous token vector.',14,MUTED)
    d.panel(24,785,1392,255,'Address bits, banks, and the next consumer')
    if sk not in ('none','features'):
        for bank in range(32):
            x=44+bank*27;d.text(x+12,848,bank,11,anchor='middle')
            for region in range(4):
                lane=8*region+bank//4
                d.rect(x,859+region*31,26,29,SELECT if lane==13 and bank%4==0 else SHARED)
                d.text(x+13,879+region*31,f'{lane}:{bank%4}',10,anchor='middle')
        d.lines(943,847,'Native panel: byte = 16L + 4w. Bank = (byte/4) mod 32. Lane 13 word 0 → bank 20. Cells read lane:word; rows are 128-byte address regions.',width=49,size=15)
        d.text(44,1018,'Panel bases are 512-byte aligned. No extra XOR swizzle is present. Transaction splitting determines conflicts.',14)
    elif sk=='features':
        d.grid(44,870,800,96,1,32,SHARED,selected=(0,13))
        for bank in range(32):d.text(44+(bank+.5)*25,855,bank,12,anchor='middle')
        d.lines(890,847,'Feature word byte = 1024·plane + 16·pixel + 4·component. Pixel 3, component 1 → byte 52 → bank 13. Do not reuse the native-packet bank-20 example here.',width=56,size=16)
        d.text(44,1018,'The adapter’s word gather performs the layout conversion from pixel-major features to MMA A registers.',14)
    else:
        d.grid(44,856,800,94,1,32,D,selected=(0,13))
        d.lines(885,850,'Lanes own register words. There is no shared bank index for a register or warp shuffle. The final store uses this entry’s native or channel-plane output map.',width=57,size=16)
        d.text(44,1018,'Only global transactions and the instruction’s register ownership apply to this path.',14)
    d.text(24,1080,'Next consumer: '+p['output'],17,bold=True)
    if p['splits']>1:
        d.text(24,1110,f'{p["splits"]} ordered splits: prior Half scratch → add current partial → publish scratch or final working-format output.',15)
        d.text(24,1139,'Counter release/acquire or ordered launches establishes readiness; a memory address alone does not.',15)
    else:
        d.text(24,1110,'Shared reuse requires the source barrier sequence; register publication can stay inside the current warp.',15)
        d.text(24,1139,'The source determines cache policy. No cache residency, issue-cycle schedule, spill count or speedup is assumed.',15)
    return d.finish('Physical allocations, exact byte counts, a worked producer/consumer address, lane words, and bank mapping specialized to this kernel. Native panel bank rows show address regions rather than hardware transaction cycles.')


def layout_maps(p):
    """Layout/control kernels get their own geometry, never an invented MMA ladder."""
    if p['kind']=='counter':
        d=Drawing(p,'Counter ownership and guarded stores',710)
        d.text(24,117,'Example CounterCount=300 → 2 blocks × 256 threads; one int32 store per live thread.',19,bold=True)
        for block in range(2):
            x=24+block*706;d.panel(x,148,680,380,f'Block {block}: indices {block*256}…{block*256+255}')
            for w in range(8):
                d.text(x+15,215+w*35,f'w{w}',12)
                for lane in range(32):
                    i=block*256+32*w+lane
                    d.rect(x+50+lane*19,192+w*35,18,31,SELECT if i==299 else D if i<300 else '#edf0f3')
        d.text(24,569,'Counter 299 = block 1 / warp 1 / lane 11 → global byte 1196; store bits 0xFFFFFFFF.',19,bold=True)
        d.text(24,603,'Counter 300 and later fail the guard. Gray cells issue no store. No model token, shared tile or MMA exists here.',16)
        d.text(24,641,'Enqueue before split users. The later producers’ readiness protocol is separate from this initialization.',16)
        return [('ownership',d.finish('Every lane and all 300 live counter elements are shown; padded launch lanes are gray.'))]
    words=p['words'];forward=p['forward'];t=309;cw=13;sp=277
    def f(t,cw):return (t//16)*16*words+(cw//8)*128+(t%8)*16+(cw%4)*4+((cw%8)//4)*2+(t%16)//8
    d=Drawing(p,'Spatial tokens, logical work, and packed word destinations',930)
    d.text(24,116,p['input']+' → one uint32 register → '+p['output'],20,bold=True)
    for side,token in enumerate([sp,t] if forward else [t,sp]):
        x=24+side*760;d.panel(x,155,632,415,'Source address' if side==0 else 'Destination address')
        d.text(x+18,219,f'F(token={token}, channelWord=13)',20,bold=True)
        d.grid(x+20,247,590,190,16,8,A if side==0 else D,selected=(token%16,cw%8),labels=True,prefix='token-low/channel-word-low')
        d.text(x+20,474,f'4 × F({token},13) = {4*f(token,cw):,} bytes',19,bold=True)
        d.text(x+20,509,'Grid: token low 4 bits × channel-word low 3 bits.',14)
        d.text(x+20,541,'Cell values are logical coordinates, not physical offsets.',14,MUTED)
    d.path([(660,358),(780,358)])
    d.text(24,616,f'W=60: token 309 = pixel (9,5) → spatial token 277. {words} uint32 words per token.',18)
    i=t*words+cw
    d.text(24,651,f'Logical i={i:,}; first pass block={i//256}, thread=13, warp=0, lane=13. Smaller grids repeat at gridDim.x×256.',16)
    bits=['t2','t1','t0','c1','c0','c2','t3']
    for j,label in enumerate(bits):
        x=24+j*200;d.rect(x,690,185,81,A if label[0]=='t' else B)
        d.text(x+92,722,label,20,anchor='middle');d.text(x+92,751,f'word bit {6-j}',15,anchor='middle')
    d.text(24,813,'Inner physical permutation: [t2 t1 t0 c1 c0 c2 t3] = 1010110₂ = 86 words for this example.',18)
    d.text(24,853,f'Forward alignment = {32 if p["fp8"] else 16} tokens; '+('padded tokens write zero without a source load.' if forward else 'inverse copies valid T tokens only and never visits padded input rows.'),16)
    d.text(24,888,'No shared transpose, conversion or Tensor Core operation: the optimized operation is this exact bit-preserving permutation.',16)
    return [('ownership',d.finish('Direction-specific token-to-byte permutation with one grid-stride work item and individual low-bit coordinates.'))]


def boundary(p):
    name=p['name'];mode=p.get('mode','')
    up=mode=='upsample' or name.startswith('decoder_upsample')
    down=mode=='downsample' or 'projection_pool' in name or name.startswith('input_preprocess_window_downsample')
    view='input_view' in name or 'output_view' in name
    if not(up or down or view):return None
    d=Drawing(p,'Boundary mapping — coordinates, ownership and destination',880)
    if up or down:
        d.text(24,115,'Projection precedes repetition.' if up else 'Pooling reads the raw Half result, before output quantization.',20,bold=True)
        for side in range(2):
            low=(side==0) if up else (side==1);count=4 if low else 8
            x=24+side*760;d.panel(x,147,632,416,('Low' if low else 'High')+' spatial field')
            for y in range(count):
                for xx in range(count):
                    selected=(y==0 and xx==3) if low else (y<2 and xx>=6)
                    cell=352/count;px=x+24+xx*cell;py=205+y*cell
                    d.rect(px,py,cell-2,cell-2,SELECT if selected else D)
                    d.text(px+cell/2,py+cell*.57,f'{xx},{y}',13,anchor='middle')
            if low:
                d.lines(x+400,219,'Highlighted low token: pixel (3,0), natural token 3.',width=22,size=17)
            else:
                d.lines(x+400,219,'Highlighted high pixels: (6,0), (7,0), (6,1), (7,1).',width=22,size=17)
        d.path([(660,355),(780,355)])
        if up:
            lines=[f'Project each low token once: '+(f'1024→512 with {p["splits"]} K256 splits.' if name.startswith('decoder_') else f'{2*p["c"]}→{p["c"]} transition.'),
                   'The register shuffle/repetition broadcasts that low result into four distinct high token destinations.',
                   'Each high destination reads its own saved skip. Those four residual vectors are not copies of each other.',
                   'Crop to the actual high field; at the C1024→C512 4K transition, repeated height 72 is clipped to 68.' if name.startswith('decoder_') else 'The merged high-resolution tokens now enter this kernel’s FFN and window attention.']
        else:
            lines=['Read four raw high values at the orange coordinates; average them into low pixel (3,0).',
                   'The high skip is published separately. Its FP8 rounding must not replace the raw pooling input.',
                   f'This entry then projects pooled C{p["c"]}→C{2*p["c"]} and writes channel planes.' if mode=='downsample' else f'This entry keeps C{p["c"]}; channel expansion is not part of this pool.',
                   f'Low token count is 16 for the 8×8 high window; each low token still has its full channel vector.']
        for i,line in enumerate(lines):d.text(24,610+35*i,line,17)
        d.text(24,807,'Grid labels are actual pixel (x,y) coordinates relative to the selected window. Orange shows one complete spatial dependency.',15,MUTED)
    else:
        inp='input_view' in name
        residual='projection_input_view' in name
        c=p['c'];plane=0;glob=52;native=208
        d.text(24,114,('Residual' if residual else 'Input')+' channel planes → compute' if inp else 'Compute → output channel planes',20,bold=True)
        d.panel(24,148,632,380,'Channel-plane image storage')
        d.grid(48,217,448,224,8,16,A,selected=(0,3),prefix='pixel y,x')
        d.text(48,192,'Plane 0; H=8, W=16; each pixel contains 16 B',16)
        d.text(48,476,'Pixel (3,0), uint32 component 1 → byte 52',18,bold=True)
        d.panel(784,148,632,380,'Half accumulator seed / lane ownership' if residual else 'Native M16 packet / lane ownership')
        d.grid(806,217,584,224,8,4,D,selected=(3,1),prefix='lane quad, lane low bits')
        for r in range(8):
            for q in range(4):d.text(806+(q+.5)*146,217+(r+.67)*28,f'lane {4*r+q}',13,anchor='middle')
        d.text(806,476,'Lane 13, C word 0 → scaled Half pair' if residual else 'Lane 13, word 0 → native panel byte 208',18,bold=True)
        d.path([(660 if inp else 780,336),(780 if inp else 660,336)])
        lines=[f'Plane address = ((plane×H+y)×W+x)×16 + 4·component = ((0×8+0)×16+3)×16+4 = {glob}.',
               'No native temporary is written: decode the loaded pair, multiply by its scale, and seed the register accumulator.' if residual else f'Native packet address = tileBase + panelBase + chunkBase + 16·lane; first panel gives {native}.',
               ('The four bytes encode E4 model channels [2,3,10,11].' if p['fp8'] else 'The four bytes encode Half model channels [2,3].'),
               'The projection’s main A input stays native. Only the residual uses this plane address and is scaled into Half C.' if residual else 'For the C512 gather, producer lane 20 copies this word; consumer lane 13 reads it after the stage wait.' if p['shared_kind']=='gather' else 'The load/store adapter changes physical representation while preserving the token coordinate.',
               f'A whole physical M16×C{c} native tile contains {16*c*p["e"]:,} bytes. Plane strides span the full image.']
        for i,line in enumerate(lines):d.text(24,582+38*i,line,16)
        d.text(24,807,'A layout view is not a numerical operation. E4 decoding or final publication is a separate, source-defined step.',15,MUTED)
    return d.finish('Direction-specific spatial boundary. Every highlighted pixel and lane has an explicit coordinate; the two layouts use different address formulas. Residual-only views are distinguished from main-input gathers.')


def split_map(p):
    if p['splits']==1:return None
    count=p['splits'];width=p['k']//count
    d=Drawing(p,'Split-K reduction — one output token across launches or CTAs',840)
    d.text(24,115,f'Follow output token 3, channel 2: K{p["k"]} = {count} ordered contributions of K{width}.',20,bold=True)
    cellwidth=1392/count
    for s in range(count):
        x=24+s*cellwidth;d.panel(x,152,cellwidth-18,292,f'Split {s}: K{s*width}…{(s+1)*width-1}')
        d.grid(x+16,207,cellwidth-50,128,4,8,WARPS[s],selected=(1,2),prefix=f'split {s} partial')
        d.text(x+16,369,f'{width//p["step"]} input stages × K{p["step"]}',15)
        d.text(x+16,401,'Half partial accumulator',15,bold=True)
    for s in range(count):
        x=24+s*cellwidth
        d.rect(x+16,493,cellwidth-50,107,D if s==count-1 else SHARED,r=5)
        d.text(x+30,525,'Final consumer' if s==count-1 else f'Half scratch after split {s}',16,bold=True)
        initial=('first contribution + scaled residual' if p['name'].startswith(('global_ffn_contract','global_projection')) else 'first matrix contribution; no residual at this point')
        d.lines(x+30,553,'ordered prior sum + current partial' if s else initial,width=36 if count==4 else 75,size=14)
        d.path([(x+cellwidth/2,444),(x+cellwidth/2,493)])
        if s< count-1:d.path([(x+cellwidth-34,547),(x+cellwidth+16,547)])
    d.text(24,651,'Working-format inputs do not imply working-format scratch: intermediate split sums remain Half.',18,bold=True)
    d.lines(24,690,'Final split: '+('normalize Q/K, apply Q scale, publish separate Q/K/V layouts.' if 'global_qkv' in p['name'] else 'repeat the combined low result, add each high skip, crop, then publish.' if p['name'].startswith('decoder_') else 'publish the complete result after the single residual contribution and all K ranges are included.'),width=150,size=16)
    d.text(24,766,'Native mode uses the source completion-counter protocol; OrderedSplit mode uses launch order. These boxes are dependencies, not GPU issue cycles.',15,MUTED)
    return d.finish('Source-ordered split reduction for one selected scalar. Each split covers a disjoint K interval; Half scratch carries the running result. Only the final split performs the final consumer-specific publication.')


def figure_html(p,kind,xml,caption):
    directory=OUT/p['name'];directory.mkdir(parents=True,exist_ok=True)
    path=directory/(kind+'.svg');path.write_text(xml,encoding='utf-8',newline='\n')
    rel=path.relative_to(ROOT/'docs/kernel-guide').as_posix()
    MAPS.append(dict(kernel=p['name'],kind=kind,path=rel,sha256=hashlib.sha256(xml.encode()).hexdigest()))
    return (f'<figure class="diagram kernel-map" data-kernel-map="{escape(p["name"])}"><div class="diagram-scroll" tabindex="0" role="region" aria-label="{escape(kind)} map for {p["name"]}">'
            f'{xml}</div><figcaption>{caption} <a href="{rel}" target="_blank" rel="noopener">Open full-size SVG ↗</a> · '
            f'<a href="{rel}" download>Download SVG</a> · <a href="{source_url(p["source"])}">Owning kernel source</a></figcaption></figure>')


def insert(body,choices,extra):
    for ident in choices:
        match=re.search(r'<h2 id="'+ident+r'">.*?(?=<h2 |\Z)',body,re.S)
        if match:return body[:match.end()]+extra+body[match.end():]
    raise ValueError(choices)


def enrich(lesson,entry):
    p=profile(lesson['name'],entry)
    body=lesson['body']
    if p['kind'] in ('counter','repack'):
        for kind,xml in layout_maps(p):body=insert(body,['address'],figure_html(p,kind,xml,'The direction, word count, launch ownership and tail behavior are specific to this public entry.'))
    else:
        assert p['warps']*p['wm']*p['wn']==p['cm']*p['cn'],p['name']
        body=insert(body,['model'],figure_html(p,'flow',flow(p),'Full fused operation for this entry. Matrices show tensor axes; storage labels identify where the implementation keeps each intermediate.'))
        body=insert(body,['ownership','tiling','tile','storage'],figure_html(p,'tiling',hierarchy(p),'The CUTLASS-style hierarchy is specialized to the named focus operation; it does not treat this fused kernel as one generic GEMM.'))
        body=insert(body,['pipeline','layout','address','addresses','storage'],figure_html(p,'storage',storage(p),'Per-kernel allocations and one exact address trace. FP8 and FP16 have independently derived panel, stage and packet layouts.'))
        edge=boundary(p)
        if edge:body=insert(body,['publication','epilogue','merge','layout','addresses','storage','model'],figure_html(p,'boundary',edge,'Actual spatial/view mapping for this variant; arrows identify the changed coordinate or address, not just a renamed tensor.'))
        splits=split_map(p)
        if splits:body=insert(body,['split','splits','ordering','pipeline','model'],figure_html(p,'split',splits,'The K ranges, iteration counts and final consumer match this split-reduction entry.'))
    lesson['body']=body
    lesson['map_profile']=p


def write_manifest(lessons):
    target=ROOT/'docs/kernel-guide/kernel-map-manifest.json'
    target.write_text(json.dumps(dict(profiles=[p['map_profile'] for p in lessons],diagrams=MAPS),indent=2)+'\n',encoding='utf-8',newline='\n')
