"""Specialised SVG figures for the two additive Small31 attention lessons.

This module is imported by ``lessons_small_attention.py``.  It deliberately does
not reuse the legacy global-attention figures: those say "Half accumulator",
while these entries persist an FP32 numerator and an FP32 denominator.  A shared
figure would make the numerical contract false.

Every figure is 1200 units wide with 13 px or larger labels, a unique title and
description, and no externally managed IDs.  Arrows are explicit polygons, so
the files do not depend on a document-global marker ID.
"""
from html import escape

W = 1200
GREEN, GREEN_S = '#e4f4ed', '#247666'
BLUE, BLUE_S = '#e9efff', '#5a6fa4'
GOLD, GOLD_S = '#fff0d6', '#a57425'
RED, RED_S = '#ffe6e0', '#a95847'
GREY, GREY_S = '#eef2f5', '#6b7f8c'
INK = '#17384a'
MONO = 'Consolas,ui-monospace,SFMono-Regular,monospace'
SANS = 'Segoe UI,Segoe UI Variable,sans-serif'


def T(x, y, value, size=15, anchor='start', fill=INK, weight='400', mono=False):
    family = MONO if mono else SANS
    size = max(13, int(size))
    return (f'<text x="{x}" y="{y}" text-anchor="{anchor}" '
            f'style="font-family:{family};font-size:{size}px;font-weight:{weight};fill:{fill}">'
            f'{escape(str(value))}</text>')


def R(x, y, w, h, title, lines=(), fill=GREEN, stroke=GREEN_S, size=15, lsize=13):
    parts = [f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="9" fill="{fill}" '
             f'stroke="{stroke}" stroke-width="1.5"/>', T(x + 12, y + 24, title, size, fill=INK, weight='600')]
    for i, line in enumerate(lines):
        parts.append(T(x + 12, y + 46 + i * 19, line, lsize, fill='#284653'))
    return ''.join(parts)


def A(x1, y1, x2, y2, color='#536a79', width=2.1):
    import math
    angle = math.atan2(y2 - y1, x2 - x1)
    left = (x2 - 11 * math.cos(angle) + 5 * math.sin(angle),
            y2 - 11 * math.sin(angle) - 5 * math.cos(angle))
    right = (x2 - 11 * math.cos(angle) - 5 * math.sin(angle),
             y2 - 11 * math.sin(angle) + 5 * math.cos(angle))
    return (f'<line x1="{x1}" y1="{y1}" x2="{x2}" y2="{y2}" stroke="{color}" '
            f'stroke-width="{width}" stroke-linecap="round"/>'
            f'<polygon points="{x2},{y2} {left[0]:.1f},{left[1]:.1f} {right[0]:.1f},{right[1]:.1f}" fill="{color}"/>')


def fig(slug, title, desc, height, inner, caption):
    ident = f'fig-{slug}'
    return (f'<figure class="diagram" id="{ident}-figure"><div class="diagram-scroll" '
            f'tabindex="0" role="region" aria-label="{escape(title)}">'
            f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {W} {height}" '
            f'width="{W}" height="{height}" role="img" '
            f'aria-labelledby="{ident}-title {ident}-desc" '
            f'style="min-width:1100px;width:1200px;height:auto">'
            f'<title id="{ident}-title">{escape(title)}</title>'
            f'<desc id="{ident}-desc">{escape(desc)}</desc>'
            f'{inner}</svg></div><figcaption>{escape(caption)}</figcaption></figure>')


def fmt(n):
    return f'{n:,}'


def attention_overview(name, fp8):
    e = 1 if fp8 else 2
    read_rows = 2176 if fp8 else 2160
    q_loads = 1 if fp8 else 2
    typ = 'E4M3' if fp8 else 'Half'
    qk = 'f16.e4m3.e4m3.f16' if fp8 else 'f16.f16.f16.f16'
    pv = 'f32.e4m3.e4m3.f32' if fp8 else 'f32.f16.f16.f32'
    b = T(28, 30, 'One head of global attention: the operation and the accumulation boundary', 21, weight='600')
    b += T(28, 53, 'T = 2,160 model positions; key stream padded to 2,176. 32 heads, 32 channels per head. Values shown are source-derived.', 14, fill='#476273')
    b += R(28, 78, 265, 102, f'Q read rows [{read_rows}, 32]', ['head-normalised, then scaled', f'{q_loads} x 16 B / M16 tile / lane', 'loaded once, retained'], BLUE, BLUE_S)
    b += R(318, 78, 265, 102, f'K read rows [{read_rows}, 32]', ['normalised per head', 'streamed in 64-key tiles', 'bulk copy to shared'], BLUE, BLUE_S)
    b += R(608, 78, 265, 102, f'V read rows [{read_rows}, 32]', ['not unit-bounded', 'transposed in the QKV producer', 'transposed panels in shared'], GOLD, GOLD_S)
    b += R(898, 78, 274, 102, 'Per-head problem', ['2,160 model queries x 2,160 model keys', 'one CTA head at blockIdx.x', 'nine 256-query blocks'], GREY, GREY_S)
    b += R(120, 232, 300, 112, 'QK^T scores (Half)', ['half C/D in both precisions', 'mma ' + qk, 'eight N8 groups per M16 row'], BLUE, BLUE_S)
    b += R(450, 232, 300, 112, 'E = packed Half surrogate', ['affine -> clamp -> word shift', 'positive: 0.0040283203125 .. 1.640625', 'E(score 0) = 0.083984375', 'not row-max softmax'], RED, RED_S)
    b += R(790, 232, 382, 112, 'Unnormalised prefix u', ['u = sum over keys of P x V', '64 FP32 values per lane, persistent', 'PV mma ' + pv, 'P = E4M3(E); D sums Half E' if fp8 else 'P = Half E; D sums the same Half E'], GOLD, GOLD_S)
    b += A(160, 180, 200, 232) + A(450, 180, 390, 232)
    b += A(420, 288, 450, 288) + A(750, 288, 790, 288)
    b += A(740, 180, 840, 232)
    b += R(450, 390, 300, 118, 'Row denominator D', ['sum of the same Half E terms', '2 FP32 values per lane', 'no Half tile total', 'warp transpose, then FP32 carry'], GREEN, GREEN_S)
    b += A(600, 344, 600, 390)
    b += R(790, 390, 382, 118, 'Publish y = u / D', ['FP32 clamp and reciprocal', 'one FP32 multiply', 'one Half round (PackFloatColumnsHalf2)', 'then E4M3 publication' if fp8 else 'packed Half vector publication'], GREEN, GREEN_S)
    b += A(1172, 288, 1172, 390) + A(750, 449, 790, 449)
    b += R(28, 390, 382, 118, 'Invariant: same model operation', ['same Q, K, V and token addresses', 'same padded-key obligation', 'P operand: E4M3; D: original Half' if fp8 else 'P operand and D input: original Half E', 'only the finite-precision sum differs'], GREY, GREY_S)
    b += T(28, 544, 'Forward invariant: every key prefix of u must fit the accumulator. A finite final value does not repair an earlier overflow.', 15, fill='#7a2f22')
    b += T(28, 568, 'FP16/FP8 QK scores are Half. Only the PV numerator and the whole row reduction are FP32 in these additive entries.', 15, fill='#476273')
    b += T(28, 592, 'FP8 numerator weights are E4M3(E), while D sums Half E; their ratio needs a quantization-error allowance.' if fp8 else 'FP16 numerator and denominator use the same positive Half E weights; widening protects their unnormalised prefixes.', 15, fill='#476273')
    b += T(28, 616, 'Read extents above are not allocation capacity: the host reserves 2,176 rows. Shared staging is explicit; L1/L2 are hardware-managed.', 14, fill='#476273')
    return fig(f'{name}-overview', 'Small31 global attention: logical graph and the FP32 accumulation boundary',
               'The per-head attention graph with Q, K, transposed V, Half scores, the fixed positive exponent surrogate E, the FP32 unnormalised numerator u, the FP32 row denominator and the single publication rounding.',
               650, b, f'This {typ} entry reads {read_rows:,} packed rows per head, serves 2,160 model queries and streams 2,176 key positions. Read extent, allocation capacity and execution coverage are separate contracts.')


def cta_tile(name, fp8):
    e = 1 if fp8 else 2
    b = T(28, 30, 'CTA subdivision: one head, 256 queries, 64-key streaming tiles', 21, weight='600')
    b += T(28, 53, 'grid = (32 heads, ceil(T/256) = 9 query blocks); block = (32 lanes, 4 warps). Query block 0 is the q17 example.', 14, fill='#476273')
    # left logical matrix
    x0, y0, side = 56, 90, 390
    b += T(x0 + side / 2, 69, 'key index', 13, anchor='middle', fill='#5b7180')
    b += T(x0 - 8, 81, 'q', 13, anchor='end', fill='#5b7180')
    for key in (0, 512, 1024, 1536, 2176):
        b += T(x0 + side * key / 2176, 84, key, 13, anchor='middle', fill='#5b7180')
    b += f'<rect x="{x0}" y="{y0}" width="{side}" height="{side}" fill="#f6f8fa" stroke="#8aa0ad"/>'
    query_tail_y = y0 + side * 2160 / 2304
    key_tail_x = x0 + side * 2160 / 2176
    b += f'<rect x="{x0}" y="{query_tail_y:.2f}" width="{side}" height="{y0+side-query_tail_y:.2f}" fill="#d7dfe6"/>'
    b += f'<rect x="{key_tail_x:.2f}" y="{y0}" width="{x0+side-key_tail_x:.2f}" height="{side}" fill="#b8c7d3"/>'
    for i in range(1, 9):
        y = y0 + side * i / 9
        b += f'<line x1="{x0}" y1="{y:.1f}" x2="{x0+side}" y2="{y:.1f}" stroke="#c8d3da"/>'
        if i < 9:
            b += T(x0 - 8, y + 4, f'{i*256}', 12, anchor='end', fill='#5b7180')
    for i in range(1, 34, 4):
        x = x0 + side * i / 34
        b += f'<line x1="{x:.1f}" y1="{y0}" x2="{x:.1f}" y2="{y0+side}" stroke="#dde4e8"/>'
    b += f'<rect x="{x0+1}" y="{y0+1}" width="{side/34:.1f}" height="{side/9-1:.1f}" fill="#f2b65d" stroke="#a57425"/>'
    b += T(x0 + 8, y0 + 22, 'head 7 / block 0', 13, fill='#7a4a12', weight='600')
    b += T(x0 + side / 2, y0 + side + 24, 'execution: 2,304 query slots x 2,176 keys', 14, anchor='middle')
    b += T(x0 + side / 2, y0 + side + 46, 'model submatrix: 2,160 x 2,160; tails in grey', 13, anchor='middle', fill='#5b7180')
    b += T(x0 + side / 2, y0 + side + 68, 'orange: head 7 / CTA 0 / first key tile', 13, anchor='middle', fill='#7a4a12')
    # right detail
    rx, ry = 560, 90
    b += R(rx, ry, 610, 96, 'One CTA = 256 queries for one head', ['4 warps x 64 queries', 'each warp = 4 M16 query tiles', 'blockIdx.x = head, blockIdx.y = 256-query block'], BLUE, BLUE_S)
    for w in range(4):
        yy = ry + 116 + w * 64
        detail = 'M16 tiles 0..3; q17 is warp 0, tile 1' if w == 0 else f'M16 tiles {w*4}..{w*4+3}'
        b += R(rx, yy, 610, 58, f'warp {w}: queries {w*64}..{w*64+63} of this CTA', [detail], GREEN if w else GOLD, GREEN_S if w else GOLD_S, size=14, lsize=13)
    b += A(rx + 305, ry + 96, rx + 305, ry + 116)
    # key ring detail
    ky = ry + 116 + 4 * 64 + 12
    b += R(rx, ky, 610, 172, 'Two matched K/V stages (64 keys each)', [f'stage bytes = 2048 x {e} = {fmt(2048*e)} B per K or V slot', f'K0 {fmt(2048*e)} + V0 {fmt(2048*e)} + K1 {fmt(2048*e)} + V1 {fmt(2048*e)} + 2 x 8 B barriers', f'total shared = {fmt(8192*e+16)} B per CTA', 'slot parity alternates; parity is not a readiness test', 'FP8 reads 136 groups; upstream QKV group 135 is zero.' if fp8 else 'FP16 reads 135 groups; group 135 is zero-filled in shared.', 'Rows 2,160..2,175 are stored then cleared in the FP8 output.' if fp8 else 'Host capacity is 2,176 rows; this kernel stores 2,160.'], GOLD, GOLD_S)
    b += T(28, 680, 'Why the key axis streams: the per-query FP32 numerator must survive all keys, while each 64-key score/E tile is short-lived.', 16, weight='600')
    b += T(28, 706, 'The design assigns Q and u/D to register fragments. Compiler allocation and spills are checked separately in section 6.', 14, fill='#476273')
    b += T(28, 730, 'Streaming keys bounds the short-lived score tile to 64 words per lane; that tile is not persistent across key steps.', 14, fill='#476273')
    b += T(28, 756, 'Last CTA: 112 model queries. FP8 rows 2,160..2,175 store then clear; rows 2,176..2,303 execute but skip stores.' if fp8 else 'Last CTA: 112 model queries. FP16 rows 2,160..2,303 execute with zero Q fragments and skip stores.', 14, fill='#7a2f22')
    return fig(f'{name}-cta', 'CTA tile, query subdivision and the 64-key K/V ring',
               'A per-head 2160 by 2160 model matrix inside 2304 by 2176 executed query/key positions, divided into 256-query CTA rows and 64-key columns. Grey bands mark query and key tails; the matrix is never allocated.',
               790, b, 'The orange tile is the q17 CTA at its first key tile. The logical model matrix is 2,160 x 2,160; execution coverage adds query and key tails. No full score matrix is stored.')


def warp_map(name, fp8):
    b = T(28, 30, 'Warp ownership: four M16 query tiles, 64 FP32 numerator values per lane', 21, weight='600')
    b += T(28, 53, 'Warp 0 of the q17 CTA is shown. Row 1 of M16 tile 1 is global query 17. Four lanes divide its 32 output channels.', 14, fill='#476273')
    # left 16x32 tile
    x0, y0, cw, ch = 28, 92, 17, 26
    b += T(x0, y0 - 12, 'M16 query tile 1 (queries 16..31), 32 output channels', 14, weight='600')
    for r in range(16):
        for c in range(32):
            fill = '#f7faf9'
            if r == 1:
                fill = '#e8eefc'
            if r == 1 and c == 9:
                fill = '#edaa44'
            b += f'<rect x="{x0+c*cw}" y="{y0+r*ch}" width="{cw-1}" height="{ch-1}" fill="{fill}" stroke="#ffffff"/>'
    for r in range(16):
        b += T(x0 - 7, y0 + r * ch + 17, f'{16+r}', 12, anchor='end', fill='#5b7180')
    for c in (0, 8, 16, 24, 32):
        b += T(x0 + c * cw, y0 + 16 * ch + 18, f'{c}', 12, anchor='middle', fill='#5b7180')
    b += T(x0 + 16 * cw, y0 + 16 * ch + 40, 'channel within the 32-channel head', 13, anchor='middle', fill='#5b7180')
    b += T(x0 + 4 * cw, y0 + 1 * ch + 17, 'q17', 12, fill='#7a2f22', weight='600')
    b += T(x0 + 9 * cw + 2, y0 + 1 * ch + 17, 'c9', 11, fill='#ffffff', weight='700')
    b += T(x0, y0 + 16 * ch + 66, 'Lane 4 owns c0/c1, c8/c9, c16/c17, c24/c25 for row 1', 13, fill='#7a2f22')
    b += T(x0, y0 + 16 * ch + 86, 'and the same eight channels for row 9 (D2/D3).', 13, fill='#7a2f22')
    # right D table
    rx, ry = 650, 92
    b += R(rx, ry, 520, 250, 'r_Output[4][4][4]: 64 FP32 values per lane', ['[query tile][N8 output group][D register]', 'D0/D1: row Lane/4, columns 2q and 2q+1', 'D2/D3: row Lane/4+8, same columns'], BLUE, BLUE_S)
    cols = ['D0', 'D1', 'D2', 'D3']
    for c in range(4):
        b += T(rx + 104 + c * 100, ry + 118, cols[c], 13, anchor='middle', weight='600')
    for g in range(4):
        b += T(rx + 12, ry + 148 + g * 26, f'group {g}', 13, fill='#5b7180')
        for c in range(4):
            fill = '#edaa44' if (g, c) == (1, 1) else '#ffffff'
            b += f'<rect x="{rx+76+c*100}" y="{ry+132+g*26}" width="56" height="20" rx="3" fill="{fill}" stroke="#8aa0ad"/>'
            b += T(rx + 104 + c * 100, ry + 147 + g * 26, f'[{g}][{c}]', 12, anchor='middle', fill='#7a2f22' if fill == '#edaa44' else '#284653')
    b += T(rx + 18, ry + 266, 'orange: r_Output[1][1][1] is query 17, output channel 9 (global channel 233)', 13, fill='#7a2f22')
    # denominators and MMA
    b += R(650, 370, 520, 150, 'Two FP32 denominators per lane', ['r_Denominator[0]: queries 0..31 of the warp (query 17 lives here)', 'r_Denominator[1]: queries 32..63', 'each lane owns one low and one high query sum', 'final broadcast reads lane 17 low for query 17'], GREEN, GREEN_S)
    b += R(650, 542, 520, 160, 'Instruction roles differ inside one warp', ['QK: MmaWindowFragment -> Half C/D in both precisions', 'PV: MmaWindowFragmentF32 -> FP32 D', 'FP16 PV: m16n8k16 f32.f16.f16.f32', 'FP8 PV: m16n8k32 f32.e4m3.e4m3.f32', 'FP8 P operand is E4M3(E); D sums the original Half E'], GOLD, GOLD_S)
    b += T(28, 730, 'The QK fragment words stay Half. Widening the PV accumulator does not widen the scores, the surrogate or the stored P operand.', 16, weight='600')
    b += T(28, 756, 'Lane 4 is the output owner for c9; lane 17 is the denominator owner for q17. They are different lanes on purpose:', 14, fill='#476273')
    b += T(28, 780, 'the PV fragment is distributed by output column, while the row reduction is transposed to one query per lane.', 14, fill='#476273')
    b += T(28, 804, 'Per lane: 4 query tiles x 4 N8 groups x 4 D registers = 64 FP32 numerator values, plus 2 FP32 denominators.', 14, fill='#476273')
    return fig(f'{name}-warp', 'Lane map for 64 FP32 numerator values and two FP32 denominators',
               'A 16 by 32 output tile showing the four-lane channel ownership of row 17, the 64-register D layout, and the lane-17 denominator owner.',
               820, b, 'The D grid is logical, not a promise that the compiler keeps all 64 values in physical registers. The two denominator lanes are query halves, not output columns.')


def resources(name, fp8):
    e = 1 if fp8 else 2
    b = T(28, 30, 'Resource budget before implementation: persistent bytes and short-lived state', 21, weight='600')
    b += T(28, 53, 'Logical live values per lane and per CTA. First derive the budget; compiled allocation is checked in section 6.', 14, fill='#476273')
    # timeline bars
    x0, x1 = 270, 1150
    rows = [
        ('Q in registers', 0, 34, BLUE, BLUE_S, f'{32 if not fp8 else 16} words/lane'),
        ('K tile', 0, 34, GREY, GREY_S, '8 uint4/lane FP16; 4 FP8'),
        ('V tile', 0, 34, GOLD, GOLD_S, '8 uint4/lane FP16; 4 FP8'),
        ('score/E tile', 0, 34, RED, RED_S, '64 uint32 words/lane'),
        ('u numerator', 0, 34, GOLD, GOLD_S, '64 FP32/lane'),
        ('D denominator', 0, 34, GREEN, GREEN_S, '2 FP32/lane'),
        ('inverse + output', 33, 34, BLUE, BLUE_S, '2 inverse words, 1 fragment'),
    ]
    y = 94
    for label, a, z, fill, stroke, note in rows:
        b += T(x0 - 12, y + 18, label, 14, anchor='end', fill='#284653')
        xa = x0 + (x1 - x0) * a / 34
        xb = x0 + (x1 - x0) * z / 34
        b += f'<rect x="{xa:.1f}" y="{y}" width="{max(6, xb-xa):.1f}" height="26" rx="4" fill="{fill}" stroke="{stroke}"/>'
        b += T(x0 + 10, y + 18, note, 13, fill='#284653')
        y += 34
    for k in (0, 1, 8, 16, 24, 33, 34):
        x = x0 + (x1 - x0) * k / 34
        b += T(x, 392, str(k), 12, anchor='middle', fill='#5b7180')
    b += T((x0 + x1) / 2, 414, 'key-tile index (34 tiles of 64 keys; logical lifetime, not measured cycles)', 13, anchor='middle', fill='#5b7180')
    # tables
    b += R(28, 446, 555, 196, f'Shared allocation: {fmt(8192*e+16)} bytes per CTA', [f'K0/K1: 2,048 x {e} = {fmt(2048*e)} B each', f'V0/V1: 2,048 x {e} = {fmt(2048*e)} B each', 'two 8-byte barriers', 'no explicit XOR swizzle; 16 B/lane panels', 'static shared is a source declaration, not occupancy'], GOLD, GOLD_S)
    b += R(608, 446, 562, 196, 'Persistent values per CTA (logical)', ['64 FP32 u + 2 FP32 D = 66 words/lane', '128 threads x 66 x 4 = 33,792 B', 'legacy Half body: 16,896 B', 'delta: 16,896 B, not compiler register delta', 'transient float2 reduction tree is additional'], GREEN, GREEN_S)
    b += R(28, 662, 1146, 112, 'Declared source cap versus measured allocation', ['extern "C" __global__ __maxnreg__(208): a cap, not an allocation and not a register count.', 'Transient state includes 4 local float2 + 4 gathered float2 + 2 query sums + 2 inverse words.', 'Measured allocation and compiler spill sizes appear in section 6; achieved occupancy needs NCU.'], RED, RED_S)
    b += T(28, 804, 'The source declares 66 persistent FP32 words per lane; this counts persistent state only. Temporaries add live values, and some values may spill.', 14, fill='#7a2f22')
    return fig(f'{name}-resources', 'Resource and lifetime budget for the persistent FP32 state',
               'Lifetime bars for Q, K, V, score/E, the 64-value FP32 numerator, the two FP32 denominators and the final inverse state, plus shared and register budget tables.',
               820, b, 'The 208 cap is not a measured register allocation. The 33,792-byte figure is logical persistent state, not compiler-reported register-file usage.')


def ring(name, fp8):
    e = 1 if fp8 else 2
    b = T(28, 30, 'Execution ring: prefill two K/V tiles, consume, refill two ahead, wait for the next tile', 21, weight='600')
    b += T(28, 53, 'Source order only. Warp/CTA launch order is unspecified; dependency counters do not create a fixed timeline.', 14, fill='#476273')
    # slot panel
    b += R(28, 88, 330, 218, 'Shared ring (two matched stages)', [f'K0 at byte 0, V0 at {fmt(2*2048*e)}', f'K1 at {fmt(2048*e)}, V1 at {fmt(3*2048*e)}', f'barriers at {fmt(4*2048*e)} and +8', f'each K/V slot: {fmt(2048*e)} B', 'slot = keyTile & 1'], GOLD, GOLD_S)
    b += R(378, 88, 330, 218, 'Producer / consumer protocol', ['init two mbarriers; CTA sync', 'WaitPredecessor for Q/K/V groups', 'load Q once into 4 x QueryChunks fragments', 'prefill key tiles 0 and 1', 'wait stage 0 before the first score tile'], BLUE, BLUE_S)
    b += R(728, 88, 442, 218, 'Persistent FP32 state starts here', ['u[4][4][4] = 64 FP32 per lane', 'D[2] = 2 FP32 per lane', 'both survive every key tile', 'K/V/score/E fragments do not', 'final inverse is produced after the loop'], GREEN, GREEN_S)
    # timeline
    y = 380
    labels = [
        ('init', ['barriers', 'CTA sync']),
        ('wait QKV', ['counter', '+ CTA sync']),
        ('Q load', ['once']),
        ('prefill 0', ['stage 0']),
        ('prefill 1', ['stage 1']),
        ('wait 0', ['arrive/wait']),
        ('compute j', ['K,V -> E -> u']),
        ('refill j+2', ['retired slot']),
        ('wait j+1', ['next slot']),
    ]
    for i, (head, subs) in enumerate(labels):
        x = 28 + i * 130
        fill = GOLD if i in (6, 7) else GREEN
        stroke = GOLD_S if i in (6, 7) else GREEN_S
        b += f'<rect x="{x}" y="{y}" width="118" height="78" rx="7" fill="{fill}" stroke="{stroke}"/>'
        b += T(x + 8, y + 24, head, 14, weight='600')
        for j, sub in enumerate(subs):
            b += T(x + 8, y + 45 + j * 17, sub, 13, fill='#476273')
        if i < len(labels) - 1:
            b += A(x + 118, y + 39, x + 129, y + 39)
    b += T(28, 492, 'Steady state: compute tile j, then refill the just-retired slot with j+2, then wait for j+1. The refill target is (j+2) & 1 = j & 1,', 14, fill='#476273')
    b += T(28, 514, 'so it overwrites the current slot only after its K and V have been read into registers. Slot parity alone is not readiness; each stage has its own barrier.', 14, fill='#476273')
    # detail rows
    b += R(28, 544, 550, 190, 'What the wait protects', ['Q/K/V groups: predecessor completion counters', 'stage j: K and V asynchronous copies complete', 'CTA barrier: visibility for every participating thread', 'counter wait is lane 0/warp 0; the CTA barrier follows'], BLUE, BLUE_S)
    b += R(600, 544, 570, 190, 'What is not claimed', ['no fixed warp or CTA launch order', 'no measured overlap or stall time', 'no promise that the bulk copy uses L1', 'no performance conclusion from this source order'], RED, RED_S)
    b += T(28, 766, 'At the final tile there is no nonexistent refill and no next-stage wait. Tail clearing follows all fragment stores; completion counters are released last.', 14, fill='#7a2f22')
    return fig(f'{name}-ring', 'Two-stage K/V ring and persistent FP32 accumulator lifetime',
               'A source-order schedule diagram showing barrier initialization, predecessor waits, Q load, prefill of two key tiles, steady-state compute plus two-ahead refill, and final drain.',
               790, b, 'Arrows are source dependencies, not measured durations. The persistent u/D lifetime spans the whole loop; K, V, score and E tiles are transient.')


def address_bank(name, fp8):
    e = 1 if fp8 else 2
    typ = 'FP8 E4' if fp8 else 'FP16 Half'
    b = T(28, 30, 'Exact Q/K/V address maps and shared-bank geometry', 21, weight='600')
    b += T(28, 53, 'A 16-byte lane vector is four consecutive 32-bit words. bankword = (byte address / 4) % 32.', 14, fill='#476273')
    # Q panel
    b += R(28, 86, 370, 214, 'Q: direct global -> registers', ['group * 16384*E + head * 512*E', '+ chunk * 512 + lane * 16', 'E=2: group stride 32,768; head 1,024', 'E=1: group stride 16,384; head 512', 'q17/head7/chunk0/lane4:', f'  {fmt(40000 if not fp8 else 20032)} B vector base'], BLUE, BLUE_S)
    # K panel
    b += R(414, 86, 370, 214, 'K: bulk global -> shared', ['group * 16384*E + head * 512*E', '+ keyChunk * 512', 'group = keyTile*4 + CopySlot/QueryChunks', 'same group/head stride as Q', 'no transpose; 512 B copy unit', 'q17 keyTile 0, head 7:', f'  {fmt(7168 if not fp8 else 3584)} B group base'], BLUE, BLUE_S)
    # V panel
    b += R(800, 86, 370, 214, 'V: transposed producer panels', ['group * 32768 + head * 1024', '+ (CopySlot & 1) * 512', 'FP16 group = 16 tokens', 'FP8 group = 32 tokens (two M16)', 'head plane = 1,024 B in both', 'not a dense token x channel array'], GOLD, GOLD_S)
    b += T(28, 326, 'Q and K share a group/head stride that depends on E. V does not: its 32,768-byte group and 1,024-byte head plane are byte-identical across precisions,', 14, fill='#7a2f22')
    b += T(28, 348, 'because the producer transposes 8x8 fragments and changes how many tokens share the 32,768 bytes (16 for FP16, 32 for FP8).', 14, fill='#7a2f22')
    # bank strip
    b += T(28, 396, f'Bank start for a 16 B lane vector in K or V shared panels (Q bypasses shared): 4 x lane mod 32. Lane 4 starts at bank 16; lane 17 at bank 4.', 15, weight='600')
    for bank in range(32):
        x = 28 + bank * 35
        fill = '#edaa44' if 16 <= bank <= 19 else ('#b9d9ff' if 4 <= bank <= 7 else '#eef2f5')
        b += f'<rect x="{x}" y="414" width="33" height="34" fill="{fill}" stroke="#ffffff"/>'
        b += T(x + 16, 436, str(bank), 12, anchor='middle', fill='#284653')
    b += T(28, 472, 'orange: lane 4 vector at bank 16; blue: lane 17 vector at bank 4. A 16 B vector touches four banks and wraps at bank 31.', 13, fill='#5b7180')
    # panel offsets
    b += R(28, 500, 555, 190, 'Shared panel address inside one stage', [f's_Base = stage*{fmt(2048*e)} + lane*16', 'K vector = s_Base + (columnTile*QueryChunks + chunk)*512', 'V vector = s_ValueOffset + s_Base + (chunk*2 + columnTile)*512', '512 B is 128 words = 4 full bank cycles, so it preserves the lane start bank', 'No XOR swizzle is applied in this kernel.'], GREEN, GREEN_S)
    b += R(608, 500, 562, 190, 'What the bank map does and does not prove', ['The source exposes 16 B/lane loads and 512 B panels.', 'A 32-lane ideal request repeats each bank four times.', 'We do not label that repetition a conflict.', 'The source does not expose a transaction split.', '128 B subtransactions were not verified in SASS.', 'Only the shared-bank-conflict counter can establish cost.'], RED, RED_S)
    b += T(28, 716, 'Q is read with __ldca into register fragments; K and V are bulk-copied into s_Storage and then read as uint4. Those are separate storage layers.', 14, fill='#476273')
    b += T(28, 738, 'Hardware-managed L1/L2 may serve global traffic. The 512-byte shared panel is explicitly addressed; it is not a cache and not a promise of residency.', 14, fill='#476273')
    return fig(f'{name}-address-bank', 'Exact Q, K and transposed-V addresses plus shared-bank starts',
               'Address equations and worked values for Q, K and transposed V, plus a 32-bank strip showing the lane-4 and lane-17 vector starts and the four-bank footprint.',
               760, b, 'The bank strip is address geometry, not a measured conflict report. V uses a different byte layout from Q/K because the producer stores transposed fragments.')


def denominator_gather(name, fp8):
    b = T(28, 30, 'FP32 denominator gather: one query row from four source lanes', 21, weight='600')
    b += T(28, 53, 'Lane 17 carries D[0] for query 17 and D[1] for query 49. Its four float2 words are gathered from source lanes 6, 7, 4, 5, then permuted.', 14, fill='#476273')
    # lane grid 8x4
    x0, y0 = 40, 92
    for lane in range(32):
        col, row = lane % 8, lane // 8
        x, y = x0 + col * 82, y0 + row * 60
        fill = '#edaa44' if lane == 17 else ('#b9d9ff' if lane in (4, 5, 6, 7) else '#eef2f5')
        b += f'<rect x="{x}" y="{y}" width="74" height="48" rx="5" fill="{fill}" stroke="#8aa0ad"/>'
        b += T(x + 37, y + 21, f'L{lane}', 14, anchor='middle', weight='600')
        b += T(x + 37, y + 39, 'row sum' if lane not in (4, 5, 6, 7, 17) else ('source' if lane != 17 else 'target'), 11, anchor='middle', fill='#476273')
    b += T(x0, 356, 'sourceLane = ((Lane & 7) << 2) + (Lane >> 3). For Lane 17: (1 << 2) + 2 = 6.', 15, weight='600')
    # gather flow
    fy = 392
    b += R(28, fy, 250, 190, 'Sources L4 / L5 / L6 / L7', ['q17: LocalProbabilitySums[2]', 'each source covers 16 keys', 'float2.x: even key columns', 'float2.y: odd key columns', 'both components belong to q17'], GOLD, GOLD_S)
    b += R(310, fy, 270, 190, 'Gather four source lanes', ['r_Row 0 -> source 6', 'r_Row 1 -> source 7', 'r_Row 2 -> source 4', 'r_Row 3 -> source 5', 'each source contributes 16 keys'], BLUE, BLUE_S)
    b += R(612, fy, 250, 190, 'Permute with Lane >> 3 = 2', ['swap word 0 with word 2', 'swap word 1 with word 3', 'result order: 4, 5, 6, 7', 'same two-level XOR swap as', 'PermuteGlobalAttentionQuadFloat2'], GREEN, GREEN_S)
    b += R(894, fy, 276, 190, 'FP32 total', ['r_Sum = g0 + g1', 'r_Sum += g2', 'r_Sum += g3', 'TotalFloat2 -> x + y (FP32)', 'D[0] += this query sum'], RED, RED_S)
    b += A(278, fy + 95, 310, fy + 95) + A(580, fy + 95, 612, fy + 95) + A(862, fy + 95, 894, fy + 95)
    b += T(28, 612, 'Key-count proof: 4 source lanes x 16 keys = 64 keys = one full key tile. Lane 17: D[0] is query 17; D[1] is query 49.', 15, weight='600')
    b += T(28, 638, 'The permutation does not lose or duplicate a source: before it the gathered order is [6,7,4,5]; after XOR 2 it is [4,5,6,7]. A tagged CPU fixture checks all 64 tags exactly once.', 14, fill='#476273')
    b += T(28, 666, 'For FP8 the same lane map is used, but the local probabilities are the original Half E and the PV operand is a separate E4M3 conversion. D never sums the E4 values.', 14, fill='#7a2f22')
    b += T(28, 694, 'The source carries D[0] and D[1] across all 34 key tiles with FP32 `+=`; there is no Half tile total to widen after the fact.', 14, fill='#476273')
    return fig(f'{name}-denominator-gather', 'Warp transpose and FP32 gather for query 17 denominator',
               'A 32-lane index map, the lane-17 source-lane calculation, the four-source gather, the two-bit permutation and the FP32 total for one query row.',
               710, b, 'Lane 17 is the denominator owner; lane 4 is the output owner. The arrows show the float2 gather order, not a memory address dependency.')


def token_path(name, fp8):
    e = 1 if fp8 else 2
    qbase, cbyte = (20032, 20035) if fp8 else (40000, 40010)
    def route(points, color='#536a79'):
        path = ' '.join(f'{x},{y}' for x, y in points[:-1])
        return (f'<polyline points="{path}" fill="none" stroke="{color}" stroke-width="2.1"/>'
                + A(*points[-2], *points[-1], color=color))
    b = T(28, 30, 'Trace q17 / head 7 / key k0 / output c9: four different indices', 21, weight='600')
    b += T(28, 54, 'Score axis = query x key. Output axis = query x channel. Global output channel = 7*32+9 = 233.', 15, fill='#476273')
    b += R(28, 90, 350, 150, '1. Q(q17, head 7, reduction d)', [f'group 1, query tile 1, warp 0, lane 4', f'chunk 0 vector base = {fmt(qbase)} B', '__ldca: global -> Q registers', '16 B = 16 E4M3 values' if fp8 else '16 B = 8 Half values', 'Q stays in registers across key tiles'], BLUE, BLUE_S)
    b += R(410, 90, 360, 150, '2. K/V global panels for key tile 0', ['K group 0, head 7, chunk 0', f'K panel base = {fmt(3584 if fp8 else 7168)} B', 'V group 0, head 7: base 7,168 B', 'V was transposed by the QKV producer', 'bulk copy uses the stage barrier'], GOLD, GOLD_S)
    b += R(802, 90, 370, 150, '3. Shared -> K and V registers', [f'stage = keyTile & 1; slot = {2048*e:,} B', 'lane vector: slot base + lane*16', 'K/V panel offsets are multiples of 512 B', 'lane 4 starts at bank 16; no XOR', 'Q does not pass through shared'], GREEN, GREEN_S)
    b += A(770, 165, 802, 165)
    b += R(28, 310, 350, 150, '4. Score S(q17,k0), reduced over d', ['lane 4, query tile 1, local row 1', 'N8 KEY tile 0, row-half 0, low Half', 'Q(q17,d) x K(k0,d), sum over d', 'QK accumulator remains Half', 'output channel c9 is not a key index'], BLUE, BLUE_S)
    b += R(410, 310, 360, 150, '5. E(q17,k0), still Half', ['native affine -> clamp -> packed shift', 'range 0.0040283203125 .. 1.640625', 'zero score maps to E0 = 0.083984375', 'each key contributes to TWO paths', 'no row-max softmax transformation'], RED, RED_S)
    b += A(190, 240, 190, 310)
    b += route([(802, 205), (790, 205), (790, 277), (350, 277), (350, 310)], BLUE_S)
    b += T(540, 270, 'K fragment -> score', 13, fill=BLUE_S)
    b += A(378, 385, 410, 385)
    b += R(410, 570, 360, 150, '6a. P(q17,k0) x V(k0,c9)', ['P = E4M3(E); D sums original Half E' if fp8 else 'P = the original Half E', 'transposed V supplies key k0, channel c9', 'lane 4: u[1][1][1] is FP32', 'PV MMA accumulates each key prefix', 'repeat for all 34 streamed key tiles'], GOLD, GOLD_S)
    b += R(802, 570, 370, 150, '6b. D(q17): sum original Half E', ['each Half widens BEFORE any addition', 'q17 partials: lanes 4,5,6,7, local index 2', '16 keys/source -> 64 keys/tile', 'lane 17 gathers; carries FP32 D[0]', 'D[1] in lane 17 belongs to q49'], GREEN, GREEN_S)
    b += A(540, 460, 540, 570, GOLD_S)
    b += T(550, 505, 'P operand', 13, fill=GOLD_S)
    b += route([(770, 385), (980, 385), (980, 570)], GREEN_S)
    b += T(990, 415, 'original Half E', 13, fill=GREEN_S)
    b += route([(1172, 205), (1185, 205), (1185, 532), (740, 532), (740, 570)], GOLD_S)
    b += T(817, 525, 'V fragment -> PV (bypasses score)', 13, fill=GOLD_S)
    b += R(28, 570, 350, 150, 'Storage contract, not a cycle trace', ['global memory may be served by L2/L1', 'shared addresses are explicit', 'Q / K / V / E / u / D use registers', 'compiler-selected state may spill', 'compiled local/spill cost: see validation'], GREY, GREY_S)
    b += R(410, 835, 360, 150, '7. FP32 normalization, then pack', ['subtract 16*E0 = 1.34375 from D', 'clamp, ApproxRcp; lane 17 -> lane 4', 'u[1][1][1] times the q17 inverse', 'PackFloatColumnsHalf2 rounds to Half', 'then Half -> E4M3 before the store' if fp8 else 'one Half round before the store'], GREEN, GREEN_S)
    b += R(802, 835, 370, 150, '8. Publish q17 / head 7 / c9', [f'16-byte output vector base = {qbase:,} B', f'c9 scalar starts at byte {cbyte:,}', 'word 0 byte 3 (byte +3)' if fp8 else 'word 2 high Half (byte +10)', '16-byte no-allocate vector store', 'tail zero -> CTA barrier -> release'], BLUE, BLUE_S)
    b += A(500, 720, 500, 835, GOLD_S)
    b += T(510, 766, 'FP32 u', 13, fill=GOLD_S)
    b += route([(980, 720), (980, 789), (700, 789), (700, 835)], GREEN_S)
    b += T(800, 781, 'FP32 D(q17)', 13, fill=GREEN_S)
    b += A(770, 910, 802, 910)
    b += R(28, 1015, 1144, 112, 'Keep the two reductions and two coordinate systems separate', ['QK reduces over the 32 head channels d to produce E(q,k); PV reduces over keys k to produce output y(q,c).', 'E forks: original Half terms build D; PV consumes E4M3(E). D is never an operand for PV.' if fp8 else 'E forks: original Half terms build D and feed PV. D is never an operand for PV.', 'The 2,160 model positions include spatial padding. Only the extra 16 key-stream positions get the E0 correction.'], GREY, GREY_S, lsize=14)
    return fig(f'{name}-token-path', 'Query 17 and key 0 through attention to output channel 9',
               'Q bypasses shared memory. K/V enter shared then separate register fragments. QK over reduction channels produces E indexed by query and key. E forks into FP32 PV and FP32 denominator reduction. Both feed normalization and the exact output byte.',
               1150, b, 'Every arrow is a data dependency. This is a checked source address and ownership trace, not a claim about hardware issue order or cache residency.')


def publication_map(name, fp8):
    e = 1 if fp8 else 2
    base16, base8 = 40000, 20032
    b = T(28, 30, 'Publication packing: why channel 9 lands on a different word and byte per precision', 21, weight='600')
    b += T(28, 53, 'The final uint4 is produced by PublishWindowChunk. The pack order changes because FP8 consumes two N8 groups per word.', 14, fill='#476273')
    # FP16 strip
    b += T(28, 96, 'FP16: half-precision columns, one N8 group per two uint4 words', 16, weight='600')
    words16 = [
        ('word 0', ['c0 q17', 'c1 q17'], '#dce8f5'),
        ('word 1', ['c0 q25', 'c1 q25'], '#dce8f5'),
        ('word 2', ['c8 q17', 'c9 q17'], '#ffe0b3'),
        ('word 3', ['c8 q25', 'c9 q25'], '#ffe0b3'),
    ]
    for i, (word, cells, fill) in enumerate(words16):
        x = 28 + i * 270
        b += f'<rect x="{x}" y="116" width="250" height="56" rx="5" fill="{fill}" stroke="#8aa0ad"/>'
        b += T(x + 10, 136, word, 15, weight='600')
        b += T(x + 10, 158, cells[0] + ' | ' + cells[1], 13, fill='#284653')
    b += f'<rect x="{28+2*270+6}" y="116" width="238" height="56" fill="none" stroke="#a95847" stroke-width="3"/>'
    b += T(28, 196, f'uint4 base {fmt(base16)} B. Channel 9 is the high Half of word 2: byte offset 8 + 2 = 10, absolute {fmt(base16+10)} B.', 14, fill='#7a2f22')
    b += T(28, 220, 'Byte offsets inside the vector: word0 0..3, word1 4..7, word2 8..11, word3 12..15. The next chunk adds 512 B.', 13, fill='#476273')
    # FP8 strip
    b += T(28, 282, 'FP8: E4M3 columns, two N8 groups merged into one word', 16, weight='600')
    words8 = [
        ('word 0 q17', ['c0', 'c1', 'c8', 'c9'], '#ffe0b3'),
        ('word 1 q25', ['c0', 'c1', 'c8', 'c9'], '#ffe0b3'),
        ('word 2 q17', ['c16', 'c17', 'c24', 'c25'], '#e3f2eb'),
        ('word 3 q25', ['c16', 'c17', 'c24', 'c25'], '#e3f2eb'),
    ]
    for i, (word, cells, fill) in enumerate(words8):
        x = 28 + i * 270
        b += f'<rect x="{x}" y="302" width="250" height="74" rx="5" fill="{fill}" stroke="#8aa0ad"/>'
        b += T(x + 10, 322, word, 15, weight='600')
        for j, cell in enumerate(cells):
            b += f'<rect x="{x+10+j*57}" y="334" width="50" height="28" fill="#ffffff" stroke="#b6c4ce"/>'
            b += T(x + 35 + j * 57, 353, cell, 12, anchor='middle')
    b += f'<rect x="{28+10+3*57}" y="302" width="50" height="74" fill="none" stroke="#a95847" stroke-width="3"/>'
    b += T(28, 404, f'uint4 base {fmt(base8)} B. Channel 9 is byte 3 of word 0 after PackHalfPairsE4(pair0, pair1): absolute {fmt(base8+3)} B.', 14, fill='#7a2f22')
    b += T(28, 428, 'The first two words cover row halves 0 and 1 for channels 0/1 and 8/9; the last two words move to groups 2/3 (channels 16/17 and 24/25).', 13, fill='#476273')
    # formula footer
    b += R(28, 470, 1146, 118, 'Published fragment, not the accumulator layout', ['FP16: PublishWindowChunk<false> selects r_Pair[2*chunk + r_Half][r_RowHalf] into four words.', 'FP8: PublishWindowChunk<true> selects r_Pair[4*chunk + 2*r_Half][r_RowHalf] and its successor, then PackHalfPairsE4.', 'The same 64 FP32 numerator values feed this pack, but the scalar channel-to-byte map differs. The CPU fixture checks both maps.'], GREEN, GREEN_S, lsize=14)
    b += T(28, 626, 'The FP8 path first rounds the normalised FP32 to Half in PackFloatColumnsHalf2, then rounds Half to E4M3 in PublishFourE4.', 14, fill='#7a2f22')
    b += T(28, 650, 'The pad-clear loop writes zero uint32 words at (r_ColumnTile*2 + r_Half)*4; it does not change this real-row pack order.', 14, fill='#476273')
    return fig(f'{name}-publication-map', 'FP16 and FP8 uint4 publication maps for query 17 channel 9',
               'Two packed uint4 strips showing the exact word and byte occupied by output channel 9 for FP16 and FP8, with the PublishWindowChunk selection order.',
               680, b, 'The channel-9 byte differs by precision: word 2 high Half for FP16, word 0 byte 3 for FP8. Both are derived from the source pack order and checked by the CPU fixture.')


def build_all(name, fp8):
    return [
        attention_overview(name, fp8),
        cta_tile(name, fp8),
        warp_map(name, fp8),
        resources(name, fp8),
        ring(name, fp8),
        address_bank(name, fp8),
        denominator_gather(name, fp8),
        token_path(name, fp8),
        publication_map(name, fp8),
    ]
