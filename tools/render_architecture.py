"""Render source-backed architecture SVGs using only the Python standard library.

Run from the project root: python -B tools/render_architecture.py
Geometry and the 71-record schedule are read from the implementation. Component
annotations describe model.py and weights.py.
"""
from html import escape
import importlib.util
from pathlib import Path
import sys
import textwrap

from architecture_attention import render as render_attention
from architecture_blocks import render as render_blocks
from architecture_stages import render as render_stages
from architecture_variants import render as render_variants

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
        self.text(44, self.height - 20, "DLSSNR-PyTorch · implemented logical graph · model.py / geometry.py / weights.py", 13, MUTED)
        self.parts.append("</svg>")
        (OUT / (self.name + ".svg")).write_text("\n".join(self.parts) + "\n", encoding="utf-8")


def field(level):
    w, h = G.levels[level]
    return f"{w} × {h}"


def overview():
    d = Diagram("network", "DLSS-NR network architecture", "71 numbered records · five encoder levels · global bottleneck · five decoder levels · 4K example fields shown as W × H", 1580)
    d.rect(25, 292, 1390, 1124, "#f8fafc", "#d8e1ed", 18)
    d.text(720, 318, "FP8 / FP16 prepared-feature deployment boundary: blocks 1–69", 16, BLUE, True, anchor="middle")
    d.box(44, 120, 440, 146, "Input stage C32 · block 0", ["Padded features: 3840 × 2176 × 16", "Adapter 16 → 32", "Dense FFN → Window attention"], BLUE)
    d.box(956, 120, 440, 146, "Output stage C32 · block 70", ["Full-field upsample + skip merge", "Dense FFN → Window attention", "Head 32 → 4; optional crop"], TEAL)
    d.arrow([(484, 194), (956, 194)], ORANGE, True)
    d.text(720, 181, "Full-field skip: block 0 → 70", 16, ORANGE, anchor="middle")
    enc = [(1, 4, 32), (5, 8, 64), (9, 14, 128), (15, 22, 256), (23, 30, 512)]
    dec = [(66, 69), (62, 65), (56, 61), (48, 55), (40, 47)]
    for level, ((first, last, c), (dfirst, dlast)) in enumerate(zip(enc, dec)):
        y = 350 + level * 172
        ffn = "Dense" if c == 32 else "Grouped" if c == 512 else "Branched"
        block_family = f"{ffn} FFN → Window attention"
        d.box(44, y, 440, 134, f"Encoder C{c} · blocks {first}–{last}", [f"{last-first+1} blocks · {field(level)}", block_family, "Save tail skip; pool + project down"], BLUE)
        title = f"Decoder C{c} · blocks {dfirst}–{dlast}"
        d.box(956, y, 440, 134, title, [f"{dlast-dfirst+1} blocks · {field(level)}", block_family, "After block 39's upsample + skip" if c == 512 else "Project + upsample + skip first"], TEAL)
        target = 39 if c == 512 else dfirst
        if c == 512:
            # This tail skip enters transition 39 before the C512 decoder blocks.
            d.arrow([(484, y + 74), (908, y + 74), (908, 1220), (1030, 1220), (1030, 1250)], ORANGE, True)
        else:
            d.arrow([(484, y + 74), (956, y + 74)], ORANGE, True)
        d.text(720, y + 61, f"C{c} skip: block {last} → {target}", 16, ORANGE, anchor="middle")
        if level == 0:
            d.arrow([(264, 266), (264, y)])
            d.text(48, 292, "2 × 2 mean pool", 14, BLUE)
            d.arrow([(1176, y), (1176, 266)])
        else:
            d.arrow([(264, y - 38), (264, y)])
            d.arrow([(1176, y), (1176, y - 38)])
    d.box(250, 1250, 620, 134, "Global bottleneck C1024 · blocks 31–38", [f"8 blocks · {field(5)} × 1024", "Dense FFN → Global attention", "32 heads; 2160 tokens, K/V padded to 2176"], PURPLE)
    d.box(972, 1250, 424, 134, "Decoder transition · block 39", ["Project 1024 → 512; 2× upsample", "Merge C512 skip from block 30", "No FFN or attention"], TEAL)
    d.arrow([(264, 1172), (264, 1210), (560, 1210), (560, 1250)], PURPLE)
    d.arrow([(870, 1317), (972, 1317)], PURPLE)
    d.arrow([(1176, 1250), (1176, 1172)], PURPLE)
    d.text(44, 1240, "Pool + project 512 → 1024", 15, PURPLE)
    d.note(1450, "FFN families: Dense at C32 / C1024 · Branched at C64 / C128 / C256 · Grouped at C512.")
    d.note(1476, "Attention: 8 × 8 Window attention at C32–C512 · Global attention over the C1024 bottleneck field.")
    d.note(1502, "Solid: main state. Dashed amber: learned-scale skip merges. Fields include padding; training includes input and output stages.")
    d.note(1528, "Block 39 only changes resolution and merges a skip. Renderer feature preparation and temporal reprojection are external.")
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
    for render in (overview, render_blocks, render_variants, render_attention, render_stages, numerics):
        render()
    # These summary-card figures were replaced by individual tensor-flow views.
    for obsolete in ("ffn.svg", "endpoints.svg"):
        (OUT / obsolete).unlink(missing_ok=True)
    print(f"Rendered {len(list(OUT.glob('*.svg')))} architecture SVGs in {OUT}")


if __name__ == "__main__":
    main()
