"""Render source-backed architecture SVGs using only the Python standard library.

Run from the project root: python -B tools/render_architecture.py
Geometry and the 71-record schedule are read from the implementation. Component
annotations describe model.py and weights.py; their hashes accompany the output.
"""
from html import escape
import hashlib
import importlib.util
import json
from pathlib import Path
import sys
import textwrap

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "docs/figures/architecture"
spec = importlib.util.spec_from_file_location("architecture_geometry", ROOT / "dlssnr/geometry.py")
geometry_module = importlib.util.module_from_spec(spec)
sys.modules[spec.name] = geometry_module
spec.loader.exec_module(geometry_module)
G = geometry_module.Geometry.from_valid(3840, 2160)
SCHEDULE = geometry_module.graph_schedule(G)

INK = "#172b45"
MUTED = "#52647c"
BLUE = "#2563ab"
TEAL = "#087f80"
PURPLE = "#7750aa"
ORANGE = "#b86910"
COLORS = {BLUE: "#edf5ff", TEAL: "#eaf8f5", PURPLE: "#f3eefb", ORANGE: "#fff5e5", MUTED: "#f1f4f8"}


class Diagram:
    def __init__(self, name, title, subtitle, height):
        self.name, self.height = name, height
        self.parts = [f'<svg xmlns="http://www.w3.org/2000/svg" width="1440" height="{height}" viewBox="0 0 1440 {height}" role="img" aria-labelledby="title desc">',
                      f'<title id="title">{escape(title)}</title><desc id="desc">{escape(subtitle)}</desc>',
                      '<defs><marker id="arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 Z" fill="context-stroke"/></marker></defs>',
                      '<rect width="1440" height="100%" fill="#ffffff"/>']
        self.text(42, 45, title, 29, INK, True)
        self.text(42, 77, subtitle, 17, MUTED)

    def text(self, x, y, text, size=16, color=INK, bold=False, anchor="start"):
        self.parts.append(f'<text x="{x}" y="{y}" fill="{color}" font-family="Segoe UI,Arial,sans-serif" font-size="{size}" font-weight="{650 if bold else 400}" text-anchor="{anchor}">{escape(str(text))}</text>')

    def rect(self, x, y, w, h, fill, stroke="none", radius=12):
        self.parts.append(f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="{radius}" fill="{fill}" stroke="{stroke}" stroke-width="1.5"/>')

    def box(self, x, y, w, h, title, lines=(), color=BLUE):
        self.rect(x, y, w, h, COLORS[color], color)
        self.text(x + 15, y + 29, title, 18, color, True)
        ypos = y + 54
        for line in lines:
            for part in textwrap.wrap(line, max(12, int((w - 30) / 8.3)), break_long_words=False) or [""]:
                if ypos > y + h - 9:
                    raise ValueError(f"Text exceeds {self.name}: {title}")
                self.text(x + 15, ypos, part)
                ypos += 22

    def arrow(self, points, color=MUTED, dashed=False):
        d = "M " + " L ".join(f"{x},{y}" for x, y in points)
        dash = ' stroke-dasharray="7 6"' if dashed else ""
        self.parts.append(f'<path d="{d}" fill="none" stroke="{color}" stroke-width="2"{dash} marker-end="url(#arrow)"/>')

    def note(self, y, text, color=MUTED):
        self.text(44, y, text, 16, color)

    def lane(self, y, title, cards, color=BLUE, note=None, height=114):
        self.text(44, y, title, 20, color, True)
        gap, x = 24, 44
        width = (1352 - gap * (len(cards) - 1)) / len(cards)
        for index, (heading, lines) in enumerate(cards):
            self.box(x, y + 19, width, height, heading, lines, color)
            if index < len(cards) - 1:
                self.arrow([(x + width, y + 19 + height / 2), (x + width + gap, y + 19 + height / 2)])
            x += width + gap
        if note:
            self.note(y + height + 63, note)

    def save(self):
        self.text(44, self.height - 20, "DLSSNR-PyTorch · implemented logical graph · source and shape ledger: architecture/source-map.json", 13, MUTED)
        self.parts.append("</svg>")
        (OUT / (self.name + ".svg")).write_text("\n".join(self.parts) + "\n", encoding="utf-8")


def field(level):
    w, h = G.levels[level]
    return f"{w} × {h}"


def overview():
    d = Diagram("network", "DLSS-NR network architecture", "71 numbered records · five encoder levels · global attention · five decoder levels · 4K example fields shown as W × H", 1175)
    d.rect(25, 245, 1390, 830, "#f8fafc", "#d8e1ed", 18)
    d.text(720, 268, "FP8 prepared-feature deployment boundary: blocks 1–69", 16, BLUE, True, anchor="middle")
    d.box(60, 114, 370, 105, "Input stage · block 0", ["Padded features: 3840 × 2176 × 16", "Adapter 16 → 32 + window block"], BLUE)
    d.box(1010, 114, 370, 105, "Output stage · block 70", ["Full-field merge + window block", "Head 32 → 4; optional crop"], TEAL)
    d.arrow([(430, 169), (1010, 169)], ORANGE, True)
    d.text(720, 155, "Full-resolution block-0 skip", 16, ORANGE, anchor="middle")
    enc = [(1, 4, 32), (5, 8, 64), (9, 14, 128), (15, 22, 256), (23, 30, 512)]
    dec = [(66, 69), (62, 65), (56, 61), (48, 55), (40, 47)]
    for level, ((first, last, c), (dfirst, dlast)) in enumerate(zip(enc, dec)):
        y = 292 + level * 135
        d.box(60, y, 370, 94, f"Encoder C{c} · blocks {first}–{last}", [f"{last-first+1} window blocks · {field(level)}", "Save tail skip; pool + project down"], BLUE)
        title = f"Decoder C{c} · blocks {dfirst}–{dlast}"
        d.box(1010, y, 370, 94, title, [f"{dlast-dfirst+1} window blocks · {field(level)}", "Block 39 merges here first" if c == 512 else "Project + upsample + skip first"], TEAL)
        d.arrow([(430, y + 51), (1010, y + 51)], ORANGE, True)
        target = 39 if c == 512 else dfirst
        d.text(720, y + 38, f"C{c} skip: block {last} → {target}", 16, ORANGE, anchor="middle")
        if level == 0:
            d.arrow([(245, 219), (245, y)])
            d.text(64, 240, "2 × 2 mean pool", 14, BLUE)
            d.arrow([(1195, y), (1195, 219)])
        else:
            d.arrow([(245, y - 41), (245, y)])
            d.arrow([(1195, y), (1195, y - 41)])
    d.box(480, 975, 480, 85, "Global bottleneck · blocks 31–38", ["8 global blocks · 60 × 36 × 1024", "32 heads; 2160 tokens, K/V padded to 2176"], PURPLE)
    d.arrow([(245, 926), (245, 1017), (480, 1017)], PURPLE)
    d.arrow([(960, 1017), (1195, 1017), (1195, 926)], PURPLE)
    d.text(65, 973, "512 → 1024 after pool", 15, PURPLE)
    d.text(1010, 973, "39: 1024 → 512, upsample", 15, PURPLE)
    d.note(1105, "Solid arrows: main state. Dashed amber arrows: learned-scale skip merges. Fields include padding, not just valid image pixels.")
    d.note(1131, "Training covers input through output. Block 39 is transition-only. Renderer feature preparation and temporal reprojection are external.")
    d.save()


def encoder():
    d = Diagram("encoder", "Encoder stages · preserve detail, reduce spatial size", "Each row is one complete level. The last block exposes a published skip and a raw tail for the downsampling path.", 1240)
    rows = [(1, 4, 32), (5, 8, 64), (9, 14, 128), (15, 22, 256), (23, 30, 512)]
    for level, (first, last, c) in enumerate(rows):
        target = [66, 62, 56, 48, 39][level]
        d.lane(123 + level * 205, f"Level {level} · C{c} · {field(level)}", [
            (f"Blocks {first}–{last}", [f"{last-first+1} × FFN + window attention", f"{c//32} heads × 32 channels"]),
            ("Tail has two views", [f"Published block {last} → skip", f"Skip consumed at block {target}", "Raw tail → pooling path"]),
            ("2 × 2 mean pool", ["Average in FP32; cast back", "Pad to the next level field"]),
            (f"Projection {c} → {2*c}", ["Learned per-pixel linear", f"Next field: {field(level+1)}"]),
        ], BLUE, note="Skip storage is taken before downsampling; it retains this level's width, height and channel count.", height=120)
    d.note(1173, "At C64/C128/C256 the FFN uses parallel branches; C512 has a pre-projection and eight branches. See the FFN expansion diagram.")
    d.note(1201, "Source: DLSSNR.forward → _encoder_stage → Numerics.pool → down_projection. Shifts advance per spatial level.")
    d.save()


def decoder():
    d = Diagram("decoder", "Decoder stages · restore spatial detail with encoder skips", "Projection happens before 2× nearest-neighbor upsampling; crop to the recorded target field before adding the skip.", 1250)
    rows = [(4, 39, 40, 47, 512, 30), (3, 48, 48, 55, 256, 22), (2, 56, 56, 61, 128, 14), (1, 62, 62, 65, 64, 8), (0, 66, 66, 69, 32, 4)]
    for row, (level, transition, first, last, c, skip) in enumerate(rows):
        d.lane(123 + row * 205, f"Restore level {level} · C{c} · {field(level)}", [
            (f"Transition {transition}", [f"Learned linear {2*c} → {c}", "Read lower-resolution state"]),
            ("Upsample + crop", ["Repeat rows and columns ×2", f"Crop to {field(level)}"]),
            (f"Merge block-{skip} skip", ["U + transition_scale × skip", "Publish to working precision"]),
            (f"Blocks {first}–{last}", [f"{last-first+1} window blocks", "FFN then attention per block"]),
        ], TEAL, note=("Block 39 contains only projection and skip merge; the next ordinary block is 40." if transition == 39 else
                        "The transition weights belong to the first decoder block; that block's FFN and attention run after the merge."), height=120)
    d.note(1175, "C32 exception: block 66 keeps the raw merge as its first FFN residual. Other decoder levels use the published merged state.")
    d.note(1203, "Source: _bottleneck_stage (39), _decoder_stage (48/56/62/66). Block 70 performs a separate full-resolution merge.")
    d.save()


def endpoints():
    d = Diagram("endpoints", "Input adapter, output head and optional composition", "These full-resolution stages belong to the training graph. The measured CUDA deployment trunk begins after input-stage pooling.", 960)
    d.lane(128, "Input stage · block 0", [
        ("Caller features", ["[B, padded H, padded W, 16]", "FP32 or BF16 floating input"]),
        ("Adapter 16 → 32", ["Learned per-pixel linear", "Raw adapter seeds residual"]),
        ("C32 window block", ["32 → 128 → 32 FFN", "1 head, 8 × 8 attention"]),
        ("Two outgoing paths", ["Published → block-70 skip", "Raw → 2 × 2 mean pool", "Pooled C32 → block 1"]),
    ], BLUE, height=125)
    d.lane(351, "Output stage · block 70", [
        ("Block-69 state", ["C32 at encoder level 0", "2× upsample to full field"]),
        ("Full-field merge", ["input_scale × upsample", "+ adapter_scale × block 0", "Raw merge seeds residual"]),
        ("C32 window block", ["FFN then window attention", "Use raw attention output"]),
        ("Head 32 → 4", ["Learned linear; FP32 result", "Optional valid-size crop", "RGB correction + blend lane"]),
    ], TEAL, height=125)
    d.text(44, 574, "Optional compose() · caller supplies proxy and reprojected history", 20, ORANGE, True)
    d.box(44, 625, 470, 150, "Neural RGB", ["N = clamp(proxy + head.rgb / 4)", "Clamp range: [0, 1]", "Proxy uses sRGB code space"], ORANGE)
    d.box(630, 600, 766, 90, "Without history", ["Return N directly", "Composition is outside forward_train"], ORANGE)
    d.box(630, 710, 766, 100, "With history H", ["a = clamp(sigmoid(head.a) × blend_scale, 0, 1)", "Return N + a × (H − N)"], ORANGE)
    d.arrow([(514, 700), (565, 700), (565, 645), (630, 645)], ORANGE)
    d.arrow([(565, 700), (565, 760), (630, 760)], ORANGE)
    d.note(842, "The model does not generate renderer features, a proxy image, motion vectors or a reprojected history buffer.")
    d.note(870, "Training benchmarks stop at the four-channel head and use a diagnostic scalar; composition and temporal training are not measured.")
    d.note(909, "Source: _input_block, _input_stage, _post_head and compose in dlssnr/model.py.")
    d.save()


def block():
    d = Diagram("residual_block", "Inside a repeated network block", "FFN comes before attention. Norm means per-head vector L2 normalization of Q and K; this is not a pre-LayerNorm Transformer.", 780)
    d.lane(136, "1 · Channel mixing and first residual", [
        ("Input state X", ["C ∈ {32, 64, 128, 256,", "512, 1024}", "Residual R usually equals X"]),
        ("Channel FFN F(X)", ["Choose the channel family", "Learned linear layers and", "piecewise activation"]),
        ("Scaled residual", ["Zraw = F(X) + ffn_scale × R", "Scales act channelwise"]),
        ("Publish Z", ["Working-precision boundary", "FP32 or BF16 in training"]),
    ], BLUE, height=126)
    d.lane(380, "2 · Attention and second residual", [
        ("QKV projection", ["Linear C → 3C", "Reshape to C/32 heads", "32 channels per head"]),
        ("Attention A(Z)", ["C ≤ 512: 8 × 8 windows", "C = 1024: global tokens", "Normalize Q/K; scale Q"]),
        ("Output projection", ["Linear C → C", "+ attn_scale × residual", "C32 residual: Zraw; else Z"]),
        ("Output pair", ["Publish for next block / skip", "Also return raw result", "Raw feeds selected transitions"]),
    ], PURPLE, height=126)
    d.arrow([(1220, 281), (1407, 281), (1407, 350), (24, 350), (24, 462), (44, 462)], BLUE)
    d.note(613, "Residual overrides: input block 0 uses the raw adapter; block 66 uses its raw merge; output block 70 uses its raw full-field merge.")
    d.note(644, "Training can checkpoint each bound stage: retain stage inputs, recompute internal activations during backward; arithmetic stays the same.")
    d.note(687, "FP8/FP16 deployment has separate packed publication and fused CUDA schedules. Boxes here describe logical operations, not launch counts.")
    d.note(720, "Source: NRBlock.forward and NRBlock.attend. Transition-only block 39 does not execute this block body.")
    d.save()


def ffn():
    d = Diagram("ffn", "Four feed-forward network families", "Linear sizes are input channels → output channels. Every branch executes; the source has no router or top-k expert selection.", 1060)
    rows = [
        ("C32 · input, finest encoder/decoder and output", [("Input", ["32 channels"]), ("Expand + activate", ["W1: 32 → 128", "Piecewise activation"]), ("Contract", ["W2: 128 → 32"]), ("Residual", ["+ ffn_scale × R", "Publish 32 channels"])], BLUE),
        ("C64 / C128 / C256 · 2 / 4 / 8 parallel branches", [("Broadcast full X", ["Each branch reads all C", "E = C / 32 branches"]), ("Each branch", ["W1[e]: C → 128 + activation", "W2[e]: 128 → 32", "Publish branch output"]), ("Join and mix", ["Concatenate E × 32 = C", "W3: C → C"]), ("Residual", ["+ ffn_scale × R", "Publish C channels"])], BLUE),
        ("C512 · eight fixed 64-channel branches", [("Mix then split", ["W1: 512 → 512", "Publish, then split into", "8 groups of 64"]), ("Each branch", ["W2[e]: 64 → 256 + activation", "W3[e]: 256 → 64", "Publish branch output"]), ("Join and mix", ["Concatenate 8 × 64 = 512", "W4: 512 → 512"]), ("Residual", ["+ ffn_scale × R", "Publish 512 channels"])], TEAL),
        ("C1024 · global bottleneck", [("Input", ["1024 channels per token"]), ("Expand + activate", ["W1: 1024 → 4096", "Piecewise activation"]), ("Contract", ["W2: 4096 → 1024"]), ("Residual", ["+ ffn_scale × R", "Publish 1024 channels"])], PURPLE),
    ]
    for i, (title, cards, color) in enumerate(rows):
        d.lane(128 + i * 214, title, cards, color, height=126)
    d.note(976, "Matrix dimensions come from WeightArchive.decode_block; learned matrices are transposed once into the PyTorch linear convention.")
    d.note(1005, "The activation is the reconstructed piecewise function, not torch.nn.functional.silu. See the numerical primitives diagram.")
    d.save()


def local_attention():
    d = Diagram("window_attention", "Window attention · C32 through C512", "Each head has 32 channels. Each 8 × 8 window has 64 query positions and 64 key positions.", 1020)
    d.lane(128, "Prepare Q, K and V", [
        ("QKV: C → 3C", ["Reshape [B,H,W,heads,3,32]", "Heads = C / 32"]),
        ("Normalize + scale", ["Q, K: vector L2 normalize", "Q *= learned head_scale", "Publish Q, K and V"]),
        ("Pad into windows", ["Positive left/top padding", "Pad right/bottom to 8", "Partition each field into 8×8"]),
        ("Key/value order", ["Permute K and V tokens", "by physical_key_order", "Bias uses matching key order"]),
    ], BLUE, height=126)
    d.lane(363, "Compute weighted values", [
        ("Scores", ["Q × Kᵀ + learned bias", "Bias: [heads, 64, 64]"]),
        ("Surrogate exponential", ["E = exp_local(scores)", "Clamped affine + exponential", "Not ordinary softmax"]),
        ("Normalize weights", ["P = E / sum_64(E)", "FP32 sum and reciprocal", "Publish probabilities"]),
        ("Values and restore", ["P × V; publish", "Unpartition 8 × 8 windows", "Crop off left/top padding"]),
    ], TEAL, height=126)
    d.arrow([(1220, 273), (1407, 273), (1407, 327), (24, 327), (24, 445), (44, 445)], BLUE)
    d.text(44, 609, "Four-phase window origins", 21, PURPLE, True)
    for phase, (sx, sy) in enumerate(((0, 0), (4, 4), (4, 0), (0, 4))):
        x = 44 + phase * 344
        d.box(x, 630, 320, 145, f"Phase {phase}", [f"Left pad {sx}; top pad {sy}", f"Window origin ({-sx}, {-sy})", "Advance per spatial level"], PURPLE)
    d.note(818, "This is padding and cropping, not a cyclic torch.roll or a claim of standard Swin attention. Padding participates in the local computation.")
    d.note(850, "Encoder and decoder blocks share the phase counter for their level. Block 0 and block 70 share a separate full-resolution counter.")
    d.note(897, "4K fields use 1 / 2 / 4 / 8 / 16 heads at C32 / C64 / C128 / C256 / C512. Attention output is projected by the enclosing block.")
    d.note(943, "Source: NRBlock.attend, _windows, _unwindows, window_shift and WeightArchive.relative_bias.")
    d.save()


def global_attention():
    d = Diagram("global_attention", "Global attention · blocks 31–38", "C1024 · 32 heads × 32 channels · all bottleneck tokens attend globally · no local relative-bias table in this branch", 945)
    d.lane(128, "Prepare the global token sequence", [
        ("QKV: 1024 → 3072", ["Split 32 heads × Q/K/V", "Q and K: L2 normalize"]),
        ("Scale and flatten", ["Q *= √32 × head_scale", "Flatten H × W = T tokens", "Publish working values"]),
        ("Pad keys and values", ["P = ceil(T / 64) × 64", "Zero-pad K and V to P", "Q keeps T rows"]),
        ("Global scores", ["Q × Kᵀ", "[B, 32, T, P]", "4K: T=2160, P=2176"]),
    ], PURPLE, height=126)
    d.lane(377, "Normalize with explicit padded-key correction", [
        ("Exponential E", ["Use exp_global(scores)", "Global constants differ", "from local-window constants"]),
        ("Denominator D", ["Sum E in 64-key chunks", "FP32 running total", "Subtract (P−T) × exp_global(0)"]),
        ("Weighted value sum", ["publish(E) × padded V", "Padded V entries are zero", "No value correction needed"]),
        ("Normalize + restore", ["Multiply output by 1 / D", "Publish and restore [B,H,W,C]", "Then enclosing projection"]),
    ], PURPLE, height=126)
    d.arrow([(1220, 273), (1407, 273), (1407, 330), (24, 330), (24, 459), (44, 459)], PURPLE)
    d.box(44, 620, 654, 166, "Why the correction matters", ["Zero-padded K produces a zero dot product, but exp_global(0) is nonzero.", "Subtract its contribution from the denominator so padding does not dilute the normalized result."], ORANGE)
    d.box(728, 620, 668, 166, "Why training uses more memory", ["The eager Torch graph explicitly materializes score and exponential tensors.", "The reconstructed CUDA route uses its own tiled physical schedule; logical boxes do not imply these full allocations."], MUTED)
    d.note(840, "This diagram describes the implemented floating training arithmetic. It is not a substitution with a standard softmax/SDPA operator.")
    d.note(883, "Source: NRBlock.attend (C1024 branch), Numerics.exp(global_mode=True), sum64, matmul and reciprocal.")
    d.save()


def numerics():
    d = Diagram("numerics", "Numerical primitives and training precision", "Exact formulas below describe the pure-PyTorch training implementation; deployment additionally has precision-specific packing and rounding.", 965)
    d.box(44, 120, 654, 195, "Piecewise activation", ["b = clamp(x, −4, 4)", "a = −0.055908203125 × |b| + 0.447265625", "f(x) = x × (b × a + 0.89453125)", "Evaluate in FP32, then cast back to input dtype.", "Despite its source name, this is not standard SiLU."], BLUE)
    d.box(728, 120, 668, 195, "Per-head L2 normalization", ["normalize(v) = v / max(||v||₂, 1e−12)", "Reduce across 32 channels for Q and K separately.", "Compute the norm/division in FP32, then cast back.", "No learned LayerNorm gain or bias in this operation."], TEAL)
    d.text(44, 365, "Surrogate exponential: z = clamp(a × x + b, lo, hi); E = E₀ × exp((z − b) × s × ln 2)", 20, PURPLE, True)
    d.box(44, 391, 654, 179, "Local windows", ["a = 0.044921875; b = 1.30078125", "lo = 1.03125; hi = 1.5693359375", "s = 32; E₀ = 0.025390625", "Normalize each 64-key row after evaluation."], PURPLE)
    d.box(728, 391, 668, 179, "Global attention", ["a = 0.08953857421875; b = 1.708984375", "lo = 1.439453125; hi = 1.9775390625", "s = 16; E₀ = 0.083984375", "Correct denominator for zero-padded keys."], PURPLE)
    d.box(44, 620, 654, 215, "Precision and publication", ["FP32: FP32 matrix operands and floating operations.", "BF16: BF16 matrix operands and working publications.", "FP32 masters are recommended for both modes.", "Norms, exp, sums and residual arithmetic use FP32", "intermediates; casts retain autograd to the masters."], BLUE)
    d.box(728, 620, 668, 215, "Checkpointing is a memory schedule", ["checkpoint_blocks=True enables non-reentrant stage", "checkpointing while gradients are enabled.", "Backward recomputes stage internals instead of", "retaining every eager intermediate; no-grad bypasses it.", "It does not define a task loss or training procedure."], ORANGE)
    d.note(887, "Pointwise linear layers mix channels at each pixel/token; pooling changes spatial size, and upsampling repeats rows and columns.")
    d.save()


def main():
    if len(SCHEDULE) != 71 or SCHEDULE[39]["kind"] != "transition":
        raise RuntimeError("Network schedule changed; review the diagram annotations")
    OUT.mkdir(parents=True, exist_ok=True)
    for render in (overview, encoder, decoder, endpoints, block, ffn, local_attention, global_attention, numerics):
        render()
    sources = ("dlssnr/model.py", "dlssnr/geometry.py", "dlssnr/weights.py")
    data = dict(scope="Implemented logical training graph, with separately labelled FP8 deployment boundary",
                source_sha256={name: hashlib.sha256((ROOT / name).read_bytes()).hexdigest() for name in sources},
                valid_example=[3840, 2160], full_padded_example=[G.full_width, G.full_height],
                schedule=SCHEDULE, diagrams=[p.name for p in sorted(OUT.glob("*.svg"))])
    (OUT / "source-map.json").write_text(json.dumps(data, indent=2) + "\n", encoding="utf-8")
    print(f"Rendered {len(data['diagrams'])} architecture SVGs in {OUT}")


if __name__ == "__main__":
    main()
