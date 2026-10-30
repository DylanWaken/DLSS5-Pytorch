"""Render the aligned Legacy71 / Small31 architecture overview.

Standard library only.  The model roster is loaded from ``dlssnr/model_specs.py``
through a standalone importlib package shim, so importing this renderer never
imports torch, CUDA or the rest of the training package.  Stage roles, block
counts and the Small raw-id -> operation-role map all come from that spec.

Run from the project root (normally through ``tools/render_architecture.py``):

    python -B tools/render_architecture.py

The generated asset is ``docs/kernel-guide/assets/architecture/network-variants.svg``.
The existing ``network.svg`` and every other architecture figure are owned by
``tools/render_architecture.py`` and are deliberately untouched here.
"""
from __future__ import annotations

from dataclasses import dataclass
from html import escape
import importlib
from pathlib import Path
import sys
import types

ROOT = Path(__file__).resolve().parents[1]
OUT_DIR = ROOT / "docs/kernel-guide/assets/architecture"
NAME = "network-variants"

WIDTH = 960
HEIGHT = 2040
LANE_X = (70, 490)
LANE_W = 400
CARD_H = 90
ROW_TOP = 204
ROW_PITCH = 102

INK = "#172b45"
MUTED = "#52647c"
BLUE = "#2563ab"
TEAL = "#087f80"
PURPLE = "#7750aa"
ORANGE = "#b86910"
COLORS = {
    BLUE: "#edf5ff",
    TEAL: "#eaf8f5",
    PURPLE: "#f3eefb",
    ORANGE: "#fff5e5",
}

# Display order: input 0, five encoder stages, global, transition 39, five
# decoder stages and output 70.  Stage ids refer to the source model spec.
ROW_DEFS = (
    ("input", None, "Input C32", 32),
    ("enc32", "encoder32", "Encoder C32", 32),
    ("enc64", "encoder64", "Encoder C64", 64),
    ("enc128", "encoder128", "Encoder C128", 128),
    ("enc256", "encoder256", "Encoder C256", 256),
    ("enc512", "encoder512", "Encoder C512", 512),
    ("global", "vit1024", "Global C1024", 1024),
    ("transition", None, "Transition 39", 512),
    ("dec512", "decoder512", "Decoder C512", 512),
    ("dec256", "decoder256", "Decoder C256", 256),
    ("dec128", "decoder128", "Decoder C128", 128),
    ("dec64", "decoder64", "Decoder C64", 64),
    ("dec32", "decoder32", "Decoder C32", 32),
    ("output", None, "Output C32", 32),
)

SKIPS = ((0, 70), (4, 66), (8, 62), (14, 56), (22, 48), (30, 39))
SOURCE_ROW = {0: 0, 4: 1, 8: 2, 14: 3, 22: 4, 30: 5}
TARGET_ROW = {70: 13, 66: 12, 62: 11, 56: 10, 48: 9, 39: 7}
SKIP_OUT = {"input": 70, "enc32": 66, "enc64": 62, "enc128": 56, "enc256": 48, "enc512": 39}
SKIP_IN = {"transition": 30, "dec256": 22, "dec128": 14, "dec64": 8, "dec32": 4, "output": 0}

LEGACY_COUNTS = {
    "input": 1, "enc32": 4, "enc64": 4, "enc128": 6, "enc256": 8, "enc512": 8,
    "global": 8, "transition": 1, "dec512": 8, "dec256": 8, "dec128": 6,
    "dec64": 4, "dec32": 4, "output": 1,
}
SMALL_COUNTS = {
    "input": 1, "enc32": 2, "enc64": 2, "enc128": 2, "enc256": 2, "enc512": 2,
    "global": 8, "transition": 1, "dec512": 2, "dec256": 2, "dec128": 2,
    "dec64": 2, "dec32": 2, "output": 1,
}

SAMPLE = {
    "input": "16→32 adapter · 2× pool → next level",
    "enc32": "down 2× · C32→C64",
    "enc64": "down 2× · C64→C128",
    "enc128": "down 2× · C128→C256",
    "enc256": "down 2× · C256→C512",
    "enc512": "down 2× · C512→C1024",
    "transition": "project 1024→512 · 2× upsample",
    "dec512": "after 39's 2× upsample",
    "dec256": "up 2× · C512→C256",
    "dec128": "up 2× · C256→C128",
    "dec64": "up 2× · C128→C64",
    "dec32": "up 2× · C64→C32",
}

# Conservative width estimates for Segoe UI/Arial fallback.  They are only used
# to fail generation when a drawn line cannot fit its declared box.
REGULAR_EM = 0.56
BOLD_EM = 0.60


def _text_width(text: str, size: int, bold: bool = False) -> float:
    return len(text) * size * (BOLD_EM if bold else REGULAR_EM)


def _fit(text: str, size: int, limit: float, where: str, bold: bool = False) -> None:
    if "\n" in text:
        raise ValueError(f"multi-line text passed to {where}: {text!r}")
    width = _text_width(text, size, bold)
    if width > limit:
        raise ValueError(f"{where} text does not fit ({width:.1f} > {limit:.1f}): {text!r}")


def _ids(values: tuple[int, ...]) -> str:
    values = tuple(sorted(values))
    if not values:
        raise ValueError("empty role/raw id set")
    if len(values) > 1 and values == tuple(range(values[0], values[-1] + 1)):
        return f"{values[0]}–{values[-1]}"
    return ",".join(str(value) for value in values)


def _heads(count: int) -> str:
    return "1 head" if count == 1 else f"{count} heads"


def load_model_specs():
    """Load dlssnr/model_specs.py without executing dlssnr/__init__.py."""
    package_name = "_dlssnr_architecture_specs"
    if package_name not in sys.modules:
        package = types.ModuleType(package_name)
        package.__path__ = [str(ROOT / "dlssnr")]
        package.__package__ = package_name
        sys.modules[package_name] = package
    return importlib.import_module(f"{package_name}.model_specs")


@dataclass(frozen=True)
class LaneRow:
    key: str
    title: str
    channel: int
    roles: tuple[int, ...]
    raws: tuple[int, ...]
    line1: str
    line2: str
    line3: str


@dataclass(frozen=True)
class Lane:
    name: str
    header: str
    sub1: str
    sub2: str
    rows: tuple[LaneRow, ...]


def _row_roles(spec, key: str, stage_id: str | None) -> tuple[int, ...]:
    if key == "input":
        return (spec.pre_role,)
    if key == "output":
        return (spec.post_role,)
    if key == "transition":
        if spec.transition_role is None:
            raise ValueError(f"{spec.id} has no transition role")
        return (spec.transition_role,)
    stage = next((item for item in spec.stages if item.id == stage_id), None)
    if stage is None:
        raise ValueError(f"{spec.id} has no stage {stage_id!r}")
    roles = list(stage.roles)
    if key == "enc32" and spec.pre_role in roles:
        roles.remove(spec.pre_role)
    if key == "dec512" and spec.transition_role in roles:
        roles.remove(spec.transition_role)
    if key == "dec32" and spec.post_role in roles:
        roles.remove(spec.post_role)
    return tuple(roles)


def _ffn_label(channel: int) -> str:
    if channel == 1024:
        return "Dense FFN → global attention"
    if channel == 512:
        return "Grouped FFN → 8×8 window"
    if channel in (64, 128, 256):
        return "Branched FFN → 8×8 window"
    return "Dense FFN → 8×8 window"


def _check_identity(spec, expected_blocks: int, expected_records: int, expected_raws: int) -> None:
    if spec.block_count != expected_blocks:
        raise RuntimeError(f"{spec.id}: expected {expected_blocks} roles, found {spec.block_count}")
    if spec.record_count != expected_records:
        raise RuntimeError(f"{spec.id}: expected {expected_records} records, found {spec.record_count}")
    if len(spec.raw_to_role) != expected_raws:
        raise RuntimeError(f"{spec.id}: expected {expected_raws} raw ids, found {len(spec.raw_to_role)}")


def _check_counts(rows: tuple[LaneRow, ...], expected: dict[str, int], name: str) -> None:
    actual = {row.key: len(row.roles) for row in rows}
    if actual != expected:
        raise RuntimeError(f"{name} display rows changed: {actual!r} != {expected!r}")
    if sum(actual.values()) != sum(expected.values()):
        raise RuntimeError(f"{name} row totals do not match the source roster")


def build_lanes():
    # The standalone loader must never pull in torch; if torch was already
    # imported by the caller that is outside this renderer's control.
    torch_before = "torch" in sys.modules
    specs = load_model_specs()
    legacy_spec, small_spec = specs.LEGACY71, specs.SMALL31
    if not torch_before and "torch" in sys.modules:
        raise RuntimeError("model_specs import unexpectedly imported torch")

    _check_identity(legacy_spec, 71, 153, 71)
    _check_identity(small_spec, 31, 77, 31)
    if small_spec.post_head is None or small_spec.post_head.native_shape != (4, 32):
        raise RuntimeError("Small31 post head is not the 4×32 native layout")
    if legacy_spec.raw_to_role != tuple(range(71)):
        raise RuntimeError("Legacy71 raw->role map is not the expected identity")
    if small_spec.roles != tuple(sorted(set(small_spec.raw_to_role))):
        raise RuntimeError("Small31 operation-role namespace changed")
    if (small_spec.pre_role, small_spec.transition_role, small_spec.post_role) != (0, 39, 70):
        raise RuntimeError("Small31 pre/transition/post roles changed")

    legacy_rows = []
    small_rows = []
    for key, stage_id, title, channel in ROW_DEFS:
        legacy_roles = _row_roles(legacy_spec, key, stage_id)
        small_roles = _row_roles(small_spec, key, stage_id)
        legacy_raws = tuple(legacy_spec.raw_for_role(role) for role in legacy_roles)
        small_raws = tuple(small_spec.raw_for_role(role) for role in small_roles)
        if legacy_raws != legacy_roles:
            raise RuntimeError(f"Legacy71 raw ids differ from roles at {key}")

        if key == "input":
            legacy_title = f"{title} · block 0"
            small_title = f"{title} · block 0"
            legacy_l1 = "role 0 · 1 head · skip 0→70"
            small_l1 = "raw 0 → role 0 · 1 head"
            legacy_l2 = small_l2 = _ffn_label(channel)
            legacy_l3 = small_l3 = SAMPLE["input"]
        elif key == "output":
            legacy_title = f"{title} · block 70"
            small_title = f"{title} · block 70"
            legacy_l1 = "role 70 · 1 head · merge skip 0"
            small_l1 = "raw 30 → role 70 · 1 head"
            legacy_l2 = small_l2 = "2× up to full res · dense FFN → window"
            legacy_l3 = small_l3 = "head 32→4 = RGB + gate output"
            if small_raws != (30,):
                raise RuntimeError("Small31 post role is not raw 30")
        elif key == "transition":
            legacy_title = f"{title} · 1 role"
            small_title = f"{title} · 1 role"
            legacy_l1 = "role 39 · no FFN or attention"
            small_l1 = "raw 19 → role 39 · no FFN/attention"
            legacy_l2 = small_l2 = SAMPLE["transition"]
            legacy_l3 = small_l3 = "merge skip 30 · no residual block"
        else:
            legacy_title = f"{title} · {len(legacy_roles)} blocks"
            small_title = f"{title} · {len(small_roles)} blocks"
            ffn = _ffn_label(channel)
            if key == "global":
                legacy_l1 = f"roles {_ids(legacy_roles)} · 32 heads"
                small_l1 = f"raw {_ids(small_raws)} → roles {_ids(small_roles)} · 32 heads"
                if small_raws != tuple(range(11, 19)) or small_roles != tuple(range(31, 39)):
                    raise RuntimeError("Small31 global roster is not raw 11–18 -> roles 31–38")
                legacy_l2 = small_l2 = ffn
                legacy_l3 = f"all T tokens · {len(legacy_roles)} blocks"
                small_l3 = f"all T tokens · retains all {len(small_roles)}"
            elif key in SKIP_OUT:
                target = SKIP_OUT[key]
                legacy_l1 = (
                    f"roles {_ids(legacy_roles)} · {_heads(channel // 32)} · "
                    f"skip {legacy_roles[-1]}→{target}"
                )
                small_l1 = (
                    f"raw {_ids(small_raws)} → roles {_ids(small_roles)} · "
                    f"{_heads(channel // 32)}"
                )
                legacy_l2 = small_l2 = ffn
                legacy_l3 = SAMPLE[key]
                small_l3 = f"{SAMPLE[key]} · keeps {len(small_roles)} of {len(legacy_roles)}"
            elif key == "dec512":
                legacy_l1 = f"roles {_ids(legacy_roles)} · 16 heads"
                small_l1 = f"raw {_ids(small_raws)} → roles {_ids(small_roles)} · 16 heads"
                legacy_l2 = small_l2 = ffn
                legacy_l3 = SAMPLE[key]
                small_l3 = (
                    f"after 39's upsample · keeps {len(small_roles)} of {len(legacy_roles)}"
                )
            else:
                source = SKIP_IN[key]
                legacy_l1 = (
                    f"roles {_ids(legacy_roles)} · {_heads(channel // 32)} · "
                    f"merge {source}"
                )
                small_l1 = (
                    f"raw {_ids(small_raws)} → roles {_ids(small_roles)} · "
                    f"{_heads(channel // 32)}"
                )
                legacy_l2 = small_l2 = ffn
                legacy_l3 = SAMPLE[key]
                small_l3 = f"{SAMPLE[key]} · keeps {len(small_roles)} of {len(legacy_roles)}"

        legacy_rows.append(LaneRow(key, legacy_title, channel, legacy_roles, legacy_raws,
                                   legacy_l1, legacy_l2, legacy_l3))
        small_rows.append(LaneRow(key, small_title, channel, small_roles, small_raws,
                                  small_l1, small_l2, small_l3))

    legacy_rows = tuple(legacy_rows)
    small_rows = tuple(small_rows)
    _check_counts(legacy_rows, LEGACY_COUNTS, "Legacy71")
    _check_counts(small_rows, SMALL_COUNTS, "Small31")

    legacy_skips = tuple((row.roles[-1], SKIP_OUT[row.key]) for row in legacy_rows if row.key in SKIP_OUT)
    small_skips = tuple((row.roles[-1], SKIP_OUT[row.key]) for row in small_rows if row.key in SKIP_OUT)
    if legacy_skips != SKIPS or small_skips != SKIPS:
        raise RuntimeError(f"skip endpoints changed: legacy={legacy_skips} small={small_skips}")

    legacy = Lane(
        "Legacy71", "Legacy71",
        "71 roles · 153 records · identity raw→role",
        "encoder 4/4/6/8/8 · decoder 8/8/6/4/4",
        legacy_rows,
    )
    small = Lane(
        "Small31", "Small31",
        "31 roles · 77 records · source-derived roles",
        "separate weights, not a prune of Legacy71",
        small_rows,
    )
    return specs, legacy, small


class DualDiagram:
    """Small dedicated SVG writer for the dual-model figure only."""

    def __init__(self, title: str, subtitle_lines: tuple[str, ...]):
        self.parts = [
            f'<svg xmlns="http://www.w3.org/2000/svg" width="{WIDTH}" height="{HEIGHT}" '
            f'viewBox="0 0 {WIDTH} {HEIGHT}" role="img" aria-labelledby="title desc">',
            f'<title id="title">{escape(title)}</title>',
            '<desc id="desc">Aligned Legacy71 and Small31 architecture: fourteen stage rows, '
            'five encoder and five decoder levels, a C1024 global bottleneck, transition 39, '
            'six role-space skip rails, separate trained weights and four-channel output heads.</desc>',
            '<defs>',
            '<marker id="flowArrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="6" '
            'markerHeight="6" orient="auto"><path d="M0 0 L10 5 L0 10 Z" fill="#52647c"/></marker>',
            '<marker id="skipArrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="6" '
            'markerHeight="6" orient="auto"><path d="M0 0 L10 5 L0 10 Z" fill="#b86910"/></marker>',
            '</defs>',
            f'<rect width="{WIDTH}" height="{HEIGHT}" fill="#ffffff"/>',
        ]
        self.text(24, 40, title, 28, INK, True, limit=WIDTH - 48)
        for index, line in enumerate(subtitle_lines):
            self.text(24, 68 + index * 23, line, 20 if index == 0 else 16,
                      INK if index == 0 else MUTED, index == 0, limit=WIDTH - 48)

    def text(self, x, y, text, size=16, color=INK, bold=False, anchor="start", limit=None):
        if limit is not None:
            _fit(text, size, limit, "svg text", bold)
        weight = 650 if bold else 400
        self.parts.append(
            f'<text x="{x}" y="{y}" fill="{color}" font-family="Segoe UI,Arial,sans-serif" '
            f'font-size="{size}" font-weight="{weight}" text-anchor="{anchor}">{escape(text)}</text>'
        )

    def rect(self, x, y, w, h, fill, stroke="none", radius=10):
        self.parts.append(
            f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="{radius}" '
            f'fill="{fill}" stroke="{stroke}" stroke-width="1.4"/>'
        )

    def line(self, points, color=MUTED, width=2, dashed=False, marker=None, opacity=1):
        d = "M " + " L ".join(f"{x},{y}" for x, y in points)
        dash = ' stroke-dasharray="6 5"' if dashed else ""
        end = f' marker-end="url(#{marker})"' if marker else ""
        self.parts.append(
            f'<path d="{d}" fill="none" stroke="{color}" stroke-width="{width}" '
            f'stroke-linejoin="round" stroke-linecap="round" opacity="{opacity}"{dash}{end}/>'
        )

    def circle(self, x, y, radius, fill):
        self.parts.append(f'<circle cx="{x}" cy="{y}" r="{radius}" fill="{fill}"/>')

    def card(self, x, y, title, lines, color):
        self.rect(x, y, LANE_W, CARD_H, COLORS[color], color)
        self.text(x + 14, y + 23, title, 20, color, True, limit=LANE_W - 28)
        for index, line in enumerate(lines):
            self.text(x + 14, y + 45 + index * 20, line, 16,
                      MUTED if index == 2 else INK, limit=LANE_W - 28)

    def save(self, path: Path) -> Path:
        self.parts.append("</svg>")
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text("\n".join(self.parts) + "\n", encoding="utf-8", newline="\n")
        return path


def render(out_dir: Path | None = None) -> Path:
    _, legacy, small = build_lanes()
    title = "DLSS-NR Legacy71 and Small31 aligned architecture"
    diagram = DualDiagram(title, (
        "Legacy71 and Small31: same block math and stage skeleton.",
        "Separate trained weights. Totals include input 0, transition 39 and post 70.",
        "Small raw ids are not legacy roles. Amber rails show the six shared role-space skips.",
    ))

    for lane_index, lane in enumerate((legacy, small)):
        x = LANE_X[lane_index]
        color = BLUE if lane_index == 0 else TEAL
        diagram.text(x, 144, lane.header, 22, color, True, limit=LANE_W)
        diagram.text(x, 166, lane.sub1, 16, INK, limit=LANE_W)
        diagram.text(x, 186, lane.sub2, 16, MUTED, limit=LANE_W)

    diagram.line([(24, 1632), (936, 1632)], "#d8e1ed", 1.2)

    # Six nested amber rails per lane.  Longest skip outermost; source and
    # target rows are ordered the same way, so the rails never cross.
    legacy_rails = (28, 34, 40, 46, 52, 58)
    small_rails = (930, 924, 918, 912, 906, 900)
    for lane_index, lane in enumerate((legacy, small)):
        edge = LANE_X[lane_index] if lane_index == 0 else LANE_X[lane_index] + LANE_W
        rails = legacy_rails if lane_index == 0 else small_rails
        for (source, target), rail_x in zip(SKIPS, rails):
            y1 = ROW_TOP + SOURCE_ROW[source] * ROW_PITCH + 50
            y2 = ROW_TOP + TARGET_ROW[target] * ROW_PITCH + 50
            diagram.line([(edge, y1), (rail_x, y1), (rail_x, y2), (edge, y2)],
                         ORANGE, 1.8, dashed=True, marker="skipArrow")

    for lane_index, lane in enumerate((legacy, small)):
        x = LANE_X[lane_index]
        for row_index, row in enumerate(lane.rows):
            y = ROW_TOP + row_index * ROW_PITCH
            if row.key.startswith("enc") or row.key == "input":
                stage_color = BLUE
            elif row.key == "global":
                stage_color = PURPLE
            elif row.key == "transition":
                stage_color = ORANGE
            else:
                stage_color = TEAL
            diagram.card(x, y, row.title, (row.line1, row.line2, row.line3), stage_color)

    # Source dots sit on the card edge; target arrowheads point into the merge card.
    for lane_index, lane in enumerate((legacy, small)):
        edge = LANE_X[lane_index] if lane_index == 0 else LANE_X[lane_index] + LANE_W
        for source, _ in SKIPS:
            diagram.circle(edge, ROW_TOP + SOURCE_ROW[source] * ROW_PITCH + 50, 2.4, ORANGE)

    for lane_index, lane in enumerate((legacy, small)):
        cx = LANE_X[lane_index] + LANE_W // 2
        for row_index in range(len(lane.rows) - 1):
            y1 = ROW_TOP + row_index * ROW_PITCH + CARD_H + 1
            y2 = ROW_TOP + (row_index + 1) * ROW_PITCH - 3
            diagram.line([(cx, y1), (cx, y2)], MUTED, 2.2, marker="flowArrow")

    left, right = 24, 492
    left_w, right_w = 440, 444
    diagram.text(left, 1654, "Skips and stage order", 20, INK, True, limit=left_w)
    left_lines = (
        "Solid arrows = stage order.",
        "Amber dashed rails = six role-space skips:",
        "0→70 · 4→66 · 8→62 · 14→56 · 22→48 · 30→39",
        "Rails run outside each lane and never cross.",
        "Legacy cards name the save/merge roles.",
    )
    for index, line in enumerate(left_lines):
        diagram.text(left, 1680 + index * 21, line, 16, MUTED, limit=left_w)

    diagram.text(left, 1795, "FFN, attention and heads", 20, INK, True, limit=left_w)
    left_lines = (
        "Dense: C32 32→128→32; C1024 1024→4096→1024.",
        "Branched C64/128/256: C/32 full-input branches.",
        "Grouped C512: premix+8×(64→256→64)+postmix.",
        "Attention: 8×8 window C32–C512; global C1024.",
        "Heads C/32 = 1/2/4/8/16/32; post 32→4.",
        "Both: 4 logical head channels = RGB + gate.",
        "Head weights 4×32 = 128 coefficients:",
        "96 RGB-row + 32 gate-row coefficients,",
        "producing 4 output activation channels/pixel.",
    )
    for index, line in enumerate(left_lines):
        diagram.text(left, 1821 + index * 21, line, 16, MUTED, limit=left_w)

    diagram.text(right, 1654, "Model identity", 20, INK, True, limit=right_w)
    right_lines = (
        "Legacy71: 71 roles / 153 records, raw=role.",
        "Small31: 31 roles / 77 records, raw ids 0–30.",
        "Small raw→role is source-derived.",
        "Raw ids are not legacy role ids.",
        "Separately trained; interior repeats omitted.",
        "Not a pruning of Legacy71 weights or records.",
        "Window phases differ by model; not merged here.",
        "Legacy deployment trunk: blocks 1–69.",
        "Input 0 and post 70 are separate paths.",
    )
    for index, line in enumerate(right_lines):
        diagram.text(right, 1680 + index * 21, line, 16, MUTED, limit=right_w)

    diagram.text(right, 1900, "Sources", 20, INK, True, limit=right_w)
    diagram.text(right, 1926, "model_specs.py · geometry.py · model.py", 16, MUTED, limit=right_w)
    diagram.text(right, 1947, "small_model.py · runtime-310-9-16 chapter", 16, MUTED, limit=right_w)

    out_dir = OUT_DIR if out_dir is None else Path(out_dir)
    return diagram.save(out_dir / f"{NAME}.svg")


def main() -> None:
    specs, legacy, small = build_lanes()
    path = render()
    print(f"Rendered {path}")
    print(f"  Legacy71: {specs.LEGACY71.block_count} roles / {specs.LEGACY71.record_count} records")
    print(f"  Small31:  {specs.SMALL31.block_count} roles / {specs.SMALL31.record_count} records")
    print(f"  Rows: {len(legacy.rows)} per lane; skips: {SKIPS}")


if __name__ == "__main__":
    main()
