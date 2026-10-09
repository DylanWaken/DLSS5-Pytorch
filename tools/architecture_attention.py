"""Attention tensor-flow SVGs backed by model.py and weights.py.

All tensor shapes omit batch. These are logical computation graphs: the CUDA
implementations fuse stages and stream tiles instead of allocating every value.
"""
from architecture_flow import Flow, INK, MUTED, COLORS


def window_attention():
    d = Flow(
        "window_attention", "Window attention · one 8 × 8 neighborhood at a time",
        "C ∈ {32, 64, 128, 256, 512} · h = C/32 heads · 32 channels per head · S = number of padded windows",
        1730)
    d.tensor("qkv", 380, 130, 440, "Projected QKV field", "H × W × 3C")
    d.op("split", 380, 240, 440, "Separate Q, K and V", "H × W × h × 3 × 32 → three fields")
    d.link("qkv", "split")

    for key, x, title in (("q", 55, "Query Q"), ("k", 455, "Key K"), ("v", 855, "Value V")):
        d.tensor(key, x, 355, 290, title, "H × W × h × 32")
        d.link("split", key, via=((600, 330), (x + 145, 330)))

    d.op("qnorm", 55, 470, 290, "Normalize + scale Q",
         ["L2 norm over 32 channels", "× learned head_scale[h]"], kind="attention")
    d.op("knorm", 455, 470, 290, "Normalize K",
         ["L2 norm over 32 channels", "one vector per pixel / head"], kind="attention")
    d.link("q", "qnorm")
    d.link("k", "knorm")
    for key, x in (("qw", 55), ("kw", 455), ("vw", 855)):
        d.op(key, x, 615, 290, f"Pad + partition {key[0].upper()}",
             ["Zero pad, then 8 × 8 windows", "S × h × 64 × 32"])
    d.link("qnorm", "qw")
    d.link("knorm", "kw")
    d.link("v", "vw")
    d.text(1017, 512, "V bypasses normalization", 14, MUTED)

    d.op("order", 455, 755, 690, "Reorder K and V together",
         "Kπ = K[π]; Vπ = V[π] · each S × h × 64 × 32", kind="attention")
    d.arrow([d.port("kw", "bottom"), (600, 755)], kind="attention")
    d.arrow([d.port("vw", "bottom"), (1000, 755)], kind="attention")
    d.op("scores", 55, 865, 490, "Dot product Q · Kπᵀ", "S × h × 64 queries × 64 keys", kind="attention")
    d.arrow([d.port("qw", "bottom"), (200, 820), (230, 820), (230, 865)])
    d.arrow([d.port("order", "left"), (395, 788), (395, 865)], kind="attention")
    d.add("bias_add", 300, 995)
    d.link("scores", "bias_add")
    d.tensor("bias", 660, 960, 450, "Learned relative-position bias B",
             "h × 64 natural queries × 64 physical keys")
    d.link("bias", "bias_add", start="left", end="right", kind="skip")
    d.op("exp", 55, 1055, 490, "Surrogate exponential E = f(scores + B)",
         "S × h × 64 × 64", kind="attention")
    d.link("bias_add", "exp")
    d.op("sum", 650, 1200, 460, "Row sum d = Σkey E", "S × h × 64 × 1", kind="attention")
    d.op("normalize", 55, 1260, 490, "Normalize each query row: P = E / d",
         ["Publish to the working precision", "S × h × 64 × 64"], kind="attention")
    d.link("exp", "sum", via=((300, 1160), (880, 1160)))
    d.link("exp", "normalize")
    d.link("sum", "normalize", start="left", end="right", via=((595, 1233), (595, 1304.5)))
    d.op("weighted", 55, 1400, 490, "Weighted values: P · Vπ", "S × h × 64 × 32", kind="attention")
    d.link("normalize", "weighted")
    d.link("order", "weighted", start="right", end="right",
           via=((1170, 788), (1170, 1433)), kind="skip")
    d.text(650, 1415, "Vπ bypasses scores and row normalization", 16, COLORS["skip"][0])
    d.op("restore", 55, 1520, 490, "Merge windows + crop padding",
         ["S × h × 64 × 32 → H × W × C", "Crop away top / left shifted padding"])
    d.link("weighted", "restore")
    d.note(650, 1328, ["Each output token combines 64 value vectors.",
                       "The denominator sums keys within its own window."])
    d.note(650, 1530, ["Q rows keep natural spatial order.",
                       "The same π reorders key columns and value rows.",
                       "The unpacked bias already uses that key order."])
    d.note(55, 1665, "Boundary windows also contain zero-padded slots; local normalization includes all 64 slots.")
    d.save()


def _token_grid(d, x, y, cells, size, *, labels=False, selected=None, window_outlines=False):
    """Draw an actual spatial token grid, with top/left four-cell padding."""
    for row in range(cells):
        for column in range(cells):
            padded = row < 4 or column < 4
            fill = "#e7ebf1" if padded else "#dff3ec"
            if selected == (row, column):
                fill = "#ffe1a8"
            d.parts.append(
                f'<rect x="{x + column * size}" y="{y + row * size}" '
                f'width="{size}" height="{size}" fill="{fill}" '
                'stroke="white" stroke-width="1"/>')
            if labels:
                value = f"q{row * cells + column}" if selected == (row, column) else str(row * cells + column)
                d.text(x + column * size + size / 2, y + row * size + size / 2 + 5,
                       value, 14, INK, selected == (row, column), "middle")
    d.parts.append(f'<rect x="{x}" y="{y}" width="{cells * size}" height="{cells * size}" '
                   'fill="none" stroke="#2563ab" stroke-width="2.3"/>')
    if window_outlines:
        for row in range(0, cells, 8):
            for column in range(0, cells, 8):
                d.parts.append(
                    f'<rect x="{x + column * size}" y="{y + row * size}" '
                    f'width="{8 * size}" height="{8 * size}" fill="none" '
                    'stroke="#2563ab" stroke-width="2.3"/>')


def window_partition():
    d = Flow(
        "window_partition", "How spatial windows and key order work",
        "Apply the same pad/partition transform to Q, K and V · one token is one spatial position within one head",
        1400)
    d.tensor("input", 50, 130, 290, "Head-wise feature field",
             ["H × W × h × 32", "Q, K and V remain separate"], h=112)
    d.op("pad", 410, 130, 380, "Zero pad from phase",
         ["Top = s_y; left = s_x",
          "P_h = 8⌈(H + s_y)/8⌉", "P_w = 8⌈(W + s_x)/8⌉"], h=112)
    d.op("partition", 860, 130, 290, "Cut 8 × 8 windows",
         ["N_y = P_h/8; N_x = P_w/8", "N_y × N_x × h × 64 × 32"], h=112)
    d.link("input", "pad", start="right", end="left")
    d.link("pad", "partition", start="right", end="left")
    d.text(50, 275, "Shift phases: (s_x, s_y) = (0,0), (4,4), (4,0), (0,4). Extra zeros fill the bottom / right tail.", 17, MUTED)

    d.region(30, 305, 550, 465, "Example field: H = W = 12, shift = (4,4)")
    d.region(620, 305, 550, 465, "One 8 × 8 window · 64 key positions", kind="attention")
    _token_grid(d, 70, 380, 16, 20, selected=(6, 6), window_outlines=True)
    _token_grid(d, 665, 380, 8, 40, labels=True, selected=(6, 6))
    d.arrow([(150, 380), (150, 357), (825, 357), (825, 380)], kind="attention")
    d.note(410, 406, ["Gray:", "added zeros", "", "Green:", "feature tokens", "", "Amber:", "selected query"])
    d.note(1006, 415, ["Each cell", "is one key", "with a", "32-channel", "vector."])
    d.note(50, 727, "Pixels stay in place; padding adds empty cells.")
    d.note(640, 727, "Query q54 retrieves values from all 64 keys.")

    d.region(30, 810, 1140, 450, "Memory order · Q stays natural; K and V share the same permutation π")
    for key, x, title in (("q", 50, "Q window"), ("k", 450, "K window"), ("v", 850, "V window")):
        d.tensor(key, x, 880, 300, title, "h × 64 × 32")
    d.op("qnatural", 50, 1015, 300, "Keep natural query order", "h × 64 × 32")
    d.op("korder", 450, 1015, 300, "Kπ = K[π]", "h × 64 × 32", kind="attention")
    d.op("vorder", 850, 1015, 300, "Vπ = V[π]", "h × 64 × 32", kind="attention")
    d.link("q", "qnatural")
    d.link("k", "korder")
    d.link("v", "vorder")
    d.tensor("permutation", 525, 1170, 550, "Same index array for both operands",
             "π = argsort(tiled_token(0…63))")
    d.link("permutation", "korder", start="top", end="bottom", via=((800, 1125), (600, 1125)), kind="skip")
    d.link("permutation", "vorder", start="top", end="bottom", via=((800, 1125), (1000, 1125)), kind="skip")
    d.note(50, 1152, ["The learned bias has axes", "[head, natural query, physical key].", "Reordering V with K preserves", "which value belongs to each key."])
    d.note(50, 1300, ["After attention, reshape windows into the padded field and crop [s_y:s_y+H, s_x:s_x+W].",
                      "Shifts use zero padding and cropping; they do not cyclically roll pixels to the opposite image edge."])
    d.save()


def global_attention():
    d = Flow(
        "global_attention", "Global bottleneck attention · every query sees all valid tokens",
        "C = 1024 · 32 heads × 32 channels · T = H×W query tokens · P = 64⌈T/64⌉ padded key/value tokens",
        1700)
    d.tensor("qkv", 380, 130, 440, "Projected QKV field", "H × W × 3072")
    d.op("split", 380, 240, 440, "Separate Q, K and V", "H × W × 32 heads × 3 × 32")
    d.link("qkv", "split")
    for key, x, title in (("q", 55, "Query Q"), ("k", 455, "Key K"), ("v", 855, "Value V")):
        d.tensor(key, x, 355, 290, title, "H × W × 32 × 32")
        d.link("split", key, via=((600, 330), (x + 145, 330)))
    d.op("qnorm", 55, 470, 290, "Normalize + scale Q",
         ["L2 norm; then × √32", "× learned head_scale[32]"], kind="attention")
    d.op("knorm", 455, 470, 290, "Normalize K",
         ["L2 norm over 32 channels", "one vector per token / head"], kind="attention")
    d.link("q", "qnorm")
    d.link("k", "knorm")
    d.op("qflat", 55, 615, 290, "Keep T query rows", ["Flatten the spatial field", "32 × T × 32"])
    d.op("kflat", 455, 615, 290, "Zero-pad K to P rows", ["P − T added key vectors", "32 × P × 32"])
    d.op("vflat", 855, 615, 290, "Zero-pad V to P rows", ["P − T added value vectors", "32 × P × 32"])
    d.link("qnorm", "qflat")
    d.link("knorm", "kflat")
    d.link("v", "vflat")
    d.op("scores", 55, 790, 490, "Dot product: S = Q · Kᵀ", "32 × T queries × P keys", kind="attention")
    d.arrow([d.port("qflat", "bottom"), (200, 750), (235, 750), (235, 790)])
    d.arrow([d.port("kflat", "bottom"), (600, 745), (395, 745), (395, 790)])
    d.op("exp", 55, 930, 490, "Surrogate exponential: E = f_global(S)", "32 × T × P", kind="attention")
    d.link("scores", "exp")

    d.op("sum", 55, 1080, 490, "Sum every padded key: d_raw = Σkey E", "32 × T × 1", kind="attention")
    d.op("numerator", 650, 1080, 460, "Weighted-value numerator: N",
         ["Publish E; then compute E · V", "32 × T × 32"], kind="attention")
    d.link("exp", "sum")
    d.link("exp", "numerator", via=((300, 1040), (880, 1040)))
    d.link("vflat", "numerator", start="right", end="right",
           via=((1170, 659.5), (1170, 1124.5)), kind="skip")
    d.text(1000, 845, "V bypass", 16, COLORS["skip"][0])
    d.tensor("correction", 55, 1220, 490, "Remove the padded-key contribution",
             ["c = (P − T) × f_global(0)", "Broadcast across heads and query rows"])
    d.op("denominator", 55, 1360, 490, "Corrected denominator: d = d_raw − c", "32 × T × 1", kind="attention")
    d.link("sum", "denominator", start="left", end="left", via=((35, 1113), (35, 1393)))
    d.link("correction", "denominator")
    d.op("divide", 650, 1360, 460, "Normalize each output: N / d", "32 × T × 32", kind="attention")
    d.link("numerator", "divide")
    d.link("denominator", "divide", start="right", end="left")
    d.op("restore", 650, 1480, 460, "Restore spatial field + join heads",
         ["32 × T × 32 → H × W × 1024", "Publish to the working precision"])
    d.link("divide", "restore")
    d.note(55, 1500, ["Global attention has no relative-position bias.",
                      "Zero K adds f_global(0) to the raw row sum.",
                      "Zero V already adds nothing to the numerator."])
    d.note(55, 1620, ["P is the attention traversal length; physical activation-storage padding is a separate layout detail.",
                      "CUDA streams 64-key tiles through this flow instead of allocating the full T × P score matrix."])
    d.save()


def render():
    window_attention()
    window_partition()
    global_attention()


if __name__ == "__main__":
    render()
