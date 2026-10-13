"""Six-part C512 lesson figures: concrete ownership and execution, not banners."""
from html import escape
from common import svg


def txt(x, y, value, size=16, anchor='start'):
    return f'<text x="{x}" y="{y}" font-size="{size}" style="font:{size}px Segoe UI,sans-serif;fill:#17384a" text-anchor="{anchor}">{escape(str(value))}</text>'


def rect(x, y, w, h, lines, color='#e3f2eb'):
    size=13 if w<=245 else 15
    return f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="7" fill="{color}" stroke="#577783"/>'+''.join(txt(x+12,y+26+23*i,line,size) for i,line in enumerate(lines))


def arrow(x1,y1,x2,y2):
    import math
    a=math.atan2(y2-y1,x2-x1)
    left=(x2-9*math.cos(a)+4*math.sin(a),y2-9*math.sin(a)-4*math.cos(a))
    right=(x2-9*math.cos(a)-4*math.sin(a),y2-9*math.sin(a)+4*math.cos(a))
    return f'<path d="M{x1},{y1}L{x2},{y2}" stroke="#577783" stroke-width="2"/><polygon points="{x2},{y2} {left[0]},{left[1]} {right[0]},{right[1]}" fill="#577783"/>'


def cta(name, kind, warps, rows, channels, grid, detail):
    """Spatial tiles × channel/head bands. Its dimensions are the entry's dimensions."""
    b=txt(25,28,grid,18)
    edge=4 if kind=='decoder' else 8
    for y in range(edge):
        for x in range(edge):
            fill='#f2b65d' if (x,y)==(0,0) else ('#d8eee8' if y<4 else '#dce5f7')
            b+=f'<rect x="{25+x*32}" y="{55+y*32}" width="30" height="30" fill="{fill}" stroke="#ffffff"/>'
    b+=txt(25,78+edge*32,f'{edge} × {edge} positions; token (0,0) in orange',14)
    b+=rect(325,55,315,120,[f'One CTA: {rows} positions',f'{channels} '+('heads' if kind=='qkv' else 'output channels'),f'{warps} warps × 32 lanes'])
    b+=arrow(285,125,325,125)
    b+=rect(685,55,340,120,detail,'#fff0d4')
    b+=arrow(640,115,685,115)
    b+=txt(325,220,'Spatial ownership and channel/head ownership',17)
    b+=txt(325,248,'are independent axes of the launch.',17)
    return svg(name+' — concrete CTA subproblem','0 0 1060 365',b,'Orange marks the token followed in section 6. Grid dimensions are the documented 4K model geometry, not profiler timing evidence.')


def warp(name,kind,warps,frags,channels,base):
    b=txt(25,28,'Compute ownership inside this exact CTA',18)
    for w in range(warps):
        x=25+(w%4)*255;y=52+(w//4)*90
        if kind=='qkv':role=f'head = 4·gridZ + {w}';span='all 64 positions; Q/K/V'
        elif kind=='ffn':role=f'group = 4·gridZ + {w%4}';span=('all 64 positions' if warps==4 else f'{32*(w//4)}…{32*(w//4)+31} tile-row positions')
        else:role=f'channels +{channels*w if kind=="decoder" else channels*(w%4)}…+{channels*(w+1)-1 if kind=="decoder" else channels*(w%4+1)-1}';span=f'{16*frags} positions'
        traced_warp=1 if kind=='decoder' else 2
        b+=rect(x,y,240,72,[f'warp {w}: {role}',span], '#fff0d4' if w==traced_warp else '#e3f2eb')
    yy=260 if warps>4 else 160
    b+=rect(25,yy,480,150,['Lane l: g = l / 4; q = l % 4','D.word 0: row g, columns 2q and 2q+1','D.word 1: row g+8, same columns','D.words 2/3: add 8 output columns','M16×N16 uses two N8 instructions.'])
    b+=rect(545,yy,480,150,[f'Trace lane 0; first N16, output base {base}','word 0: physical token (0,0), pair +0/+1','word 1: physical token (2,0), pair +0/+1','word 2: token (0,0), pair +8/+9','The whole warp participates in every MMA.'],'#e5eafa')
    b+=arrow(505,yy+75,545,yy+75)
    gy=yy+205
    b+=txt(25,gy-15,'One M16 × N16 accumulator panel; orange cells belong to lane 0',17)
    for row in range(16):
        for col in range(16):
            selected=row in (0,8) and col in (0,1,8,9)
            fill='#edaa44' if selected else ('#e3edf3' if row<8 else '#dce8df')
            b+=f'<rect x="{25+col*14}" y="{gy+row*14}" width="13" height="13" fill="{fill}"/>'
    b+=rect(300,gy,725,132,['word 0 → row 0, columns 0/1; word 1 → row 8, columns 0/1','word 2 → row 0, columns 8/9; word 3 → row 8, columns 8/9','Each neighboring lane moves the owned column pair by two.','Rows are native matrix rows, not row-major image token numbers.','The first trace token is row 0; row 8 is its packed companion.'],'#fff0d4')
    return svg(name+' — warp assignment and lane-word ownership',f'0 0 1060 {gy+250}',b,'The lane formula describes Half accumulator words in both precision modes. An FP8 A operand has a different byte grouping; use the conversion and source-address steps in section 6.')


def schedule(name,steps,stages,stagebytes,post,full_prefill=False,gather=False):
    actions=[('Initialize',f'{stages} mbarriers; CTA sync'),('Prime',f'W0 + input '+('0…'+str(stages-1) if full_prefill else '0')),('Wait',f'input 0 ready; {stagebytes:,} B/slot')]
    if full_prefill:
        actions += [('Read + compute','shared A → registers → MMA'),('Advance','load W[t+1]; wait input[t+1]'),('Recycle',f'old slot ← input[t+{stages}]')]
    else:
        actions += [('Issue next','input[t+1] into other slot'),('Read + compute','current A + W → Half result'),('Advance','load W[t+1]; wait input[t+1]')]
    actions += [('Drain',f'{steps} total K steps; stop refills'),('Fused work',post[0]),('Final publication',post[1])]
    b=txt(25,25,f'{steps} K iterations; slot = t % {stages}; '+('4-byte gather + commit/wait' if gather else 'architecture-selected async copy'),17)
    for i,(title,desc) in enumerate(actions):
        row=i//3;col=i%3 if row%2==0 else 2-i%3;x=25+col*345;y=55+row*125
        b+=rect(x,y,300,88,[title,desc], '#fff0d4' if i in (3,4,5) else '#e3f2eb')
        if i:
            pr=(i-1)//3;pc=(i-1)%3 if pr%2==0 else 2-(i-1)%3;px=25+pc*345;py=55+pr*125
            b+=arrow(px+150,py+88,x+150,y) if pr!=row else arrow(px+300 if x>px else px,py+44,x if x>px else x+300,y+44)
    b+=txt(25,455,'The middle row repeats. Arrows show source dependencies; they are not measured GPU cycle lengths.',15)
    return svg(name+' — executable producer/consumer schedule','0 0 1060 485',b,'All participating CTA threads reach the stage barrier, including zero-fill lanes. At the final K step there is no nonexistent next-input wait.')


def trace(name,source,shared,compute,dest):
    b=txt(25,30,'Follow token (y,x) = (0,0); companion row values are carried by the same lane',17)
    items=[('Global input',source),('Shared stage',shared),('Registers and instructions',compute),('Global output',dest)]
    for i,(title,lines) in enumerate(items):
        col=i%2 if i<2 else 1-i%2
        x=25+col*535;y=60+(i//2)*165
        b+=rect(x,y,495,130,[title,*lines], '#fff0d4' if i==2 else '#e3f2eb')
    b+=arrow(520,125,560,125)+arrow(807,190,807,225)+arrow(560,290,520,290)
    b+=txt(25,398,'Shared banks: one aligned 16-byte lane-0 vector occupies banks 0–3',17)
    for bank in range(32):
        b+=f'<rect x="{25+bank*31}" y="{420}" width="29" height="31" fill="'+('#edaa44' if bank<4 else '#e3edf3')+'"/>'+txt(39+bank*31,441,bank,12,'middle')
    b+=txt(25,482,'bank = (byte / 4) % 32. Actual conflict cost depends on transactions and must be checked in NCU.',15)
    return svg(name+' — one-token storage and instruction trace','0 0 1060 510',b,'Byte offsets are allocation-relative. Registers hold lane-owned fragments rather than contiguous token vectors. Hardware-managed caches are not explicitly allocated software stages.')
