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
    for render in (overview, render_blocks, render_attention, render_stages, numerics):
        render()
    # These summary-card figures were replaced by individual tensor-flow views.
    for obsolete in ("ffn.svg", "endpoints.svg"):
        (OUT / obsolete).unlink(missing_ok=True)
    print(f"Rendered {len(list(OUT.glob('*.svg')))} architecture SVGs in {OUT}")


if __name__ == "__main__":
    main()
