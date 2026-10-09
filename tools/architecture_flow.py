"""Small SVG vocabulary for source-backed tensor-flow diagrams.

Tensor nodes show values and shapes; operation nodes show transformations.
Routes are authored explicitly so fan-out, residuals and joins stay readable.
"""
from html import escape
from pathlib import Path

OUT = Path(__file__).resolve().parents[1] / "docs/figures/architecture"
INK = "#172b45"
MUTED = "#52647c"
COLORS = {
    "flow": ("#2563ab", "#edf5ff"),
    "tensor": ("#087f80", "#f0fbf8"),
    "skip": ("#b86910", "#fff5e5"),
    "attention": ("#7750aa", "#f3eefb"),
    "muted": ("#52647c", "#f6f8fb"),
}


class Flow:
    def __init__(self, name, title, subtitle, height, width=1200):
        self.name, self.width, self.height = name, width, height
        self.nodes, self.text_bounds = {}, []
        self.parts = [
            f'<svg xmlns="http://www.w3.org/2000/svg" width="{width}" height="{height}" '
            f'viewBox="0 0 {width} {height}" role="img" aria-labelledby="title desc">',
            f'<title id="title">{escape(title)}</title><desc id="desc">{escape(subtitle)}</desc>',
            '<defs>' + ''.join(
                f'<marker id="arrow-{key}" viewBox="0 0 10 10" refX="9" refY="5" '
                f'markerWidth="7" markerHeight="7" orient="auto-start-reverse">'
                f'<path d="M0 0 L10 5 L0 10 Z" fill="{color[0]}"/></marker>'
                for key, color in COLORS.items()) + '</defs>',
            '<rect width="100%" height="100%" fill="white"/>',
        ]
        self.text(32, 40, title, 27, bold=True)
        self.text(32, 70, subtitle, 16, MUTED)

    def text(self, x, y, value, size=17, color=INK, bold=False, anchor="start"):
        self.parts.append(
            f'<text x="{x}" y="{y}" fill="{color}" font-family="Segoe UI,Arial,sans-serif" '
            f'font-size="{size}" font-weight="{600 if bold else 400}" text-anchor="{anchor}">'
            f'{escape(str(value))}</text>')
        self.text_bounds.append((x, y, str(value), size, anchor))

    def region(self, x, y, w, h, title, kind="muted"):
        stroke, fill = COLORS[kind]
        self.parts.append(f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="14" '
                          f'fill="{fill}" stroke="{stroke}" stroke-opacity=".25"/>')
        self.text(x + 18, y + 28, title, 18, stroke, True)

    def node(self, key, x, y, w, title, lines=(), *, h=None, kind="flow", tensor=False):
        if isinstance(lines, str):
            lines = [lines]
        h = h or 43 + 23 * len(lines)
        if key in self.nodes:
            raise ValueError(f"Duplicate node {key}")
        if x < 0 or y < 90 or x + w > self.width or y + h > self.height - 45:
            raise ValueError(f"Node outside canvas: {self.name}/{key}")
        if 43 + 23 * len(lines) > h:
            raise ValueError(f"Text exceeds node height: {self.name}/{key}")
        self.nodes[key] = (x, y, w, h)
        stroke, fill = COLORS["tensor" if tensor else kind]
        radius = 4 if tensor else 13
        self.parts.append(f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="{radius}" '
                          f'fill="{fill}" stroke="{stroke}" stroke-width="1.7"/>')
        self.text(x + w / 2, y + 27, title, 19, stroke, True, "middle")
        for i, line in enumerate(lines):
            self.text(x + w / 2, y + 51 + i * 23, line, 17, INK, anchor="middle")

    def tensor(self, key, x, y, w, title, shape, **kwargs):
        self.node(key, x, y, w, title, shape, tensor=True, **kwargs)

    def op(self, key, x, y, w, title, lines=(), **kwargs):
        self.node(key, x, y, w, title, lines, **kwargs)

    def add(self, key, x, y, label="+"):
        self.nodes[key] = (x - 21, y - 21, 42, 42)
        self.parts.append(f'<circle cx="{x}" cy="{y}" r="21" fill="#fff5e5" '
                          'stroke="#b86910" stroke-width="2"/>')
        self.text(x, y + 8, label, 26, COLORS["skip"][0], True, "middle")

    def port(self, key, side):
        x, y, w, h = self.nodes[key]
        return {"top": (x + w / 2, y), "bottom": (x + w / 2, y + h),
                "left": (x, y + h / 2), "right": (x + w, y + h / 2)}[side]

    def arrow(self, points, kind="flow", label=None, label_at=None):
        stroke = COLORS[kind][0]
        dash = ' stroke-dasharray="7 5"' if kind == "skip" else ''
        route = 'M ' + ' L '.join(f'{x},{y}' for x, y in points)
        self.parts.append(f'<path d="{route}" fill="none" stroke="{stroke}" stroke-width="2"'
                          f'{dash} marker-end="url(#arrow-{kind})"/>')
        if label:
            if label_at is None:
                raise ValueError("Arrow labels need explicit positions")
            self.text(*label_at, label, 16, stroke)

    def link(self, source, target, *, start="bottom", end="top", via=(), **kwargs):
        self.arrow([self.port(source, start), *via, self.port(target, end)], **kwargs)

    def note(self, x, y, lines, kind="muted"):
        if isinstance(lines, str):
            lines = [lines]
        for i, line in enumerate(lines):
            self.text(x, y + i * 24, line, 17, COLORS[kind][0])

    def save(self):
        self.text(32, self.height - 19,
                  "Logical tensor flow · shapes omit batch unless shown · operations may be fused in CUDA", 13, MUTED)
        self.parts.append('</svg>')
        OUT.mkdir(parents=True, exist_ok=True)
        (OUT / f'{self.name}.svg').write_text('\n'.join(self.parts) + '\n', encoding='utf-8')
