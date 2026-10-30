#!/usr/bin/env python3
"""Render the public dual-model deployment latency charts.

The input is the compact public measurement summary, not the raw aggregate.
Every displayed value is the supplied scalar/paired ratio from that summary;
nothing is recomputed from aggregate medians.  The renderer is CPU-only and
does not import torch or touch a GPU.

Publication SVGs use vector text (``svg.fonttype=none``), a stable hash salt and
no save-date metadata so a repeated render is byte-identical.  Private PNGs are
an optional review aid.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import math
import re
import sys
from pathlib import Path
from xml.sax.saxutils import escape

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.patches import Patch

# ---------------------------------------------------------------------------
# Contract
# ---------------------------------------------------------------------------

MODELS = ("legacy71", "small31")
PRECISIONS = ("fp16", "fp8")
RESOLUTIONS = (
    (1280, 720, "720p", "1280 x 720"),
    (1920, 1080, "1080p", "1920 x 1080"),
    (2560, 1440, "1440p", "2560 x 1440"),
    (3840, 2160, "4K", "3840 x 2160"),
)
MODEL_ORDER = ("legacy71", "small31")
VALID_STATUS = {"accepted", "timing_only", "unsupported_export", "failed_reference_check"}
UNAVAILABLE_STATUS = {"unsupported_export", "failed_reference_check"}
COLORS = {
    "native": "#7b93b2",       # grey-blue: DLL-extracted kernels
    "candidate": "#147b86",    # teal: reconstructed kernels
    "ink": "#172a43",
    "muted": "#52647c",
    "faint": "#8c9ab0",
    "grid": "#dbe3ee",
    "background": "#f7f9fc",
}
REPO_ROOT = Path(__file__).resolve().parents[1]
FIG_W, FIG_H = 11.2, 10.0
SVG_HASH_SALT = "dual-model-deployment-v1"
SMALL_FP16_CONTRACT = (
    "Required Half exports absent from extracted 310.9.16 CUDA modules; "
    "candidate-only timing; no DLL ratio or numeric equivalence claim."
)
SMALL_FP8_SUBTITLE = (
    "Timing only - different arithmetic (FP32 candidate vs Half vendor PV)"
)
FP16_SUBTITLE = "Required Half exports absent from extracted 310.9.16 CUDA modules"
LEGACY_CONTRACT_PREFIX = "Legacy71:"
# The ratio column starts outside the axes; +0.06 axes-fraction (~29 px at the
# 850 px review width) clears the 4K value labels without moving any bars.
DELTA_COLUMN_X = 1.078


class ContractError(ValueError):
    """The measurement summary does not satisfy the publication contract."""


def _positive(value, where: str) -> float:
    if isinstance(value, bool) or not isinstance(value, (int, float)):
        raise ContractError(f"{where}: expected a positive finite number")
    number = float(value)
    if not math.isfinite(number) or number <= 0:
        raise ContractError(f"{where}: expected a positive finite number")
    return number


def _ratio(value, where: str) -> float:
    number = _positive(value, where)
    if number <= 0:
        raise ContractError(f"{where}: ratio must be positive")
    return number


def _nonempty(value, where: str) -> str:
    if not isinstance(value, str) or not value.strip():
        raise ContractError(f"{where}: expected a non-empty string")
    return value.strip()


def _sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for block in iter(lambda: handle.read(1 << 20), b""):
            digest.update(block)
    return digest.hexdigest()


def load_summary(path: Path) -> dict:
    try:
        data = json.loads(path.read_text(encoding="utf-8"))
    except FileNotFoundError as exc:
        raise ContractError(f"data file not found: {path}") from exc
    except json.JSONDecodeError as exc:
        raise ContractError(f"data file is not valid JSON: {exc}") from exc
    if not isinstance(data, dict):
        raise ContractError("top level must be an object")

    for key in ("device", "scope", "protocol", "provenance", "cases"):
        if key not in data:
            raise ContractError(f"missing top-level key: {key}")
    if not isinstance(data["device"], (dict, str)) or not data["device"]:
        raise ContractError("device must be a non-empty object or string")
    if not isinstance(data["scope"], dict):
        raise ContractError("scope must be an object")
    if not isinstance(data["protocol"], dict) or not data["protocol"]:
        raise ContractError("protocol must be a non-empty object")
    if not isinstance(data["provenance"], dict) or not data["provenance"]:
        raise ContractError("provenance must be a non-empty object")
    if not _nonempty(data["scope"].get("text"), "scope.text"):
        raise ContractError("scope.text must explain the public scope")

    raw = data.get("raw_evidence")
    if not isinstance(raw, dict):
        raise ContractError("raw_evidence must link the exact raw aggregate")
    raw_path = _nonempty(raw.get("path"), "raw_evidence.path")
    raw_sha = _nonempty(raw.get("sha256"), "raw_evidence.sha256").lower()
    if not re.fullmatch(r"[0-9a-f]{64}", raw_sha):
        raise ContractError("raw_evidence.sha256 must be a lowercase SHA-256 hex digest")
    raw_file = REPO_ROOT / raw_path
    if not raw_file.is_file():
        raise ContractError(f"raw_evidence path does not exist: {raw_path}")
    if _sha256(raw_file) != raw_sha:
        raise ContractError("raw_evidence sha256 does not match the raw aggregate")

    acceptance = data["scope"].get("acceptance")
    if not isinstance(acceptance, dict):
        raise ContractError("scope.acceptance is required")
    if acceptance.get("complete") is not True:
        raise ContractError("scope.acceptance.complete must be true")
    if acceptance.get("required_cases") != 16:
        raise ContractError("scope.acceptance.required_cases must be 16")

    cases = data["cases"]
    if not isinstance(cases, list) or len(cases) != 16:
        raise ContractError("exactly 16 cases are required")

    expected = {
        (model, precision, width, height)
        for model in MODELS
        for precision in PRECISIONS
        for width, height, _, _ in RESOLUTIONS
    }
    seen = set()
    for index, case in enumerate(cases):
        where = f"cases[{index}]"
        if not isinstance(case, dict):
            raise ContractError(f"{where}: expected an object")
        model = case.get("model")
        precision = case.get("precision")
        if model not in MODELS:
            raise ContractError(f"{where}.model: unknown model {model!r}")
        if precision not in PRECISIONS:
            raise ContractError(f"{where}.precision: unknown precision {precision!r}")
        width, height = case.get("width"), case.get("height")
        key = (model, precision, width, height)
        if key not in expected:
            raise ContractError(f"{where}: unexpected case {key!r}")
        if key in seen:
            raise ContractError(f"{where}: duplicate case {key!r}")
        seen.add(key)

        case_name = _nonempty(case.get("case"), f"{where}.case")
        if case_name != f"{model}_{precision}_{width}x{height}":
            raise ContractError(f"{where}.case: name does not match its dimensions")
        _nonempty(case.get("source_result"), f"{where}.source_result")
        _nonempty(case.get("source_result_sha256"), f"{where}.source_result_sha256")
        _nonempty(case.get("harness_sha256"), f"{where}.harness_sha256")
        _nonempty(case.get("native_dll_version"), f"{where}.native_dll_version")
        _nonempty(case.get("numerical_contract"), f"{where}.numerical_contract")

        candidate_status = case.get("candidate_status")
        native_status = case.get("native_status")
        if candidate_status not in VALID_STATUS:
            raise ContractError(f"{where}.candidate_status: unknown status")
        if native_status not in VALID_STATUS:
            raise ContractError(f"{where}.native_status: unknown status")
        if native_status == "failed_reference_check":
            # A failed reference check is an unavailable native arm, never zero.
            pass

        validation = case.get("validation")
        if not isinstance(validation, dict) or not validation:
            raise ContractError(f"{where}.validation: expected a non-empty object")

        if model == "small31" and precision == "fp8":
            evidence = case.get("source_result_evidence")
            if not isinstance(evidence, dict):
                raise ContractError(
                    f"{where}.source_result_evidence: required for Small31 FP8 error magnitudes"
                )
            for field in (
                "accumulation_range",
                "compared",
                "compared_post_timing",
                "accumulation_range_post_timing",
            ):
                if field not in evidence:
                    raise ContractError(f"{where}.source_result_evidence.{field}: required")

        _positive(case.get("candidate_ms"), f"{where}.candidate_ms")
        for field in ("candidate_p10", "candidate_p90"):
            _positive(case.get(field), f"{where}.{field}")
        if native_status in UNAVAILABLE_STATUS:
            if case.get("native_ms") is not None:
                raise ContractError(f"{where}: unavailable native arm must not have native_ms")
            if case.get("median_ratio") is not None:
                raise ContractError(f"{where}: unavailable native arm must not have a ratio")
            if case.get("by_order") is not None:
                raise ContractError(f"{where}: unavailable native arm must not have by_order")
            if case.get("native_p10") is not None or case.get("native_p90") is not None:
                raise ContractError(f"{where}: unavailable native arm must not have p10/p90")
        else:
            _positive(case.get("native_ms"), f"{where}.native_ms")
            _ratio(case.get("median_ratio"), f"{where}.median_ratio")
            for field in ("native_p10", "native_p90"):
                _positive(case.get(field), f"{where}.{field}")
            by_order = case.get("by_order")
            if not isinstance(by_order, list) or len(by_order) != 2:
                raise ContractError(f"{where}.by_order: expected two supplied order ratios")
            for order_index, value in enumerate(by_order):
                _ratio(value, f"{where}.by_order[{order_index}]")

        sample_summary = case.get("sample_summary")
        if not isinstance(sample_summary, dict):
            raise ContractError(f"{where}.sample_summary: expected kind/count")

    missing = expected - seen
    if missing:
        raise ContractError(f"missing cases: {sorted(missing)}")

    profile_harness = data["provenance"].get("harness", {}).get("per_case_sha256", {})
    if not isinstance(profile_harness, dict):
        raise ContractError("provenance.harness.per_case_sha256 must be an object")
    for case in cases:
        if profile_harness.get(case["case"]) != case["harness_sha256"]:
            raise ContractError(f"{case['case']}: per-case harness hash does not match provenance")
    return data


def cases_by(data: dict, model: str, precision: str) -> list[dict]:
    return sorted(
        (case for case in data["cases"] if case["model"] == model and case["precision"] == precision),
        key=lambda case: (case["width"], case["height"]),
    )


def _dll_version(cases: list[dict]) -> str:
    versions = {case["native_dll_version"] for case in cases}
    if len(versions) != 1:
        raise ContractError(f"a panel must have one DLL version, got {sorted(versions)}")
    return versions.pop()


def _panel_subtitle(model: str, precision: str, cases: list[dict]) -> str:
    if model == "legacy71":
        boundary_count = {case["validation"].get("boundary_count") for case in cases}
        equal = {case["validation"].get("boundaries_equal") for case in cases}
        exact = {case["validation"].get("all_exact") for case in cases}
        finite = {case["validation"].get("all_finite") for case in cases}
        if boundary_count == {74} and equal == {74} and exact == {True} and finite == {True}:
            return "74/74 boundaries byte-exact and finite"
        return "reference comparison supplied by validation metadata"
    if precision == "fp8":
        return SMALL_FP8_SUBTITLE
    if any(case["native_status"] == "failed_reference_check" for case in cases):
        return "reference check failed"
    return FP16_SUBTITLE


def _delta_label(case: dict) -> str:
    if case["native_status"] == "failed_reference_check":
        return "reference check failed"
    if case["median_ratio"] is None:
        return "not available"
    return f"{(case['median_ratio'] - 1.0) * 100.0:+.2f}%"


def _method_line(data: dict) -> str:
    return (
        "Prepared-feature reconstruction trunk only | DLL-extracted cubins replay | "
        "batch 1 | SM120 | lower is shorter"
    )


def _footer_lines(data: dict) -> list[str]:
    protocol = data["protocol"]
    paired = protocol.get("paired", {})
    candidate_only = protocol.get("candidate_only", {})
    device = data["device"]
    if isinstance(device, str):
        device_label = device
    else:
        device_label = device.get("name", "GPU not supplied")
        if device.get("sm") is not None:
            device_label += f", SM{device['sm']}"
    pairs = paired.get("pairs", 0)
    per_order = pairs // 2 if isinstance(pairs, int) else "?"
    return [
        f"GPU: {device_label}, batch 1.",
        "Prepared-feature reconstruction trunk only: DLL-extracted cubins replayed in CUDA graphs.",
        (
            f"CUDA events: {paired.get('calls_per_graph', '?')} passes/graph, "
            f"{paired.get('warmup_replays', '?')} warmup replays, {pairs} alternating "
            f"paired samples ({per_order} each order)."
        ),
        (
            f"{paired.get('replays_per_sample', '?')} graph replays/sample; "
            f"Small31 FP16: {candidate_only.get('samples', '?')} candidate-only samples."
        ),
        "Excludes RGB front/back ends and DLL host/NGX.",
        "Paired delta = candidate/reference paired median - 1; + longer, - shorter.",
    ]


# ---------------------------------------------------------------------------
# Rendering
# ---------------------------------------------------------------------------

def _configure_matplotlib() -> None:
    plt.rcParams.update({
        "font.family": "DejaVu Sans",
        "font.size": 10.5,
        "axes.edgecolor": COLORS["grid"],
        "axes.linewidth": 0.8,
        "axes.labelcolor": COLORS["ink"],
        "xtick.color": COLORS["muted"],
        "ytick.color": COLORS["ink"],
        "text.color": COLORS["ink"],
        "svg.fonttype": "none",
        "svg.hashsalt": SVG_HASH_SALT,
    })


def _scale(cases: list[dict]) -> float:
    maximum = 0.0
    for case in cases:
        maximum = max(maximum, float(case["candidate_ms"]))
        if case["native_ms"] is not None:
            maximum = max(maximum, float(case["native_ms"]))
    return maximum * 1.14


def _draw_panel(ax, data: dict, model: str, precision: str, show_xlabels: bool) -> None:
    cases = cases_by(data, model, precision)
    scale = _scale([case for m in MODELS for case in cases_by(data, m, precision)])
    y = list(range(len(RESOLUTIONS)))
    ax.set_facecolor(COLORS["background"])
    ax.set_xlim(0, scale)
    ax.set_ylim(3.55, -0.78)
    ax.set_yticks(y)
    ax.set_yticklabels(
        [f"{label}\n{dims}" for _, _, label, dims in RESOLUTIONS],
        fontsize=11.2,
        linespacing=1.15,
    )
    ax.set_xticks(range(0, int(scale) + 1, 2))
    ax.tick_params(axis="x", labelsize=9.6, length=3, pad=3, labelbottom=show_xlabels)
    ax.tick_params(axis="y", length=0, pad=10)
    ax.grid(axis="x", color=COLORS["grid"], linewidth=0.8, alpha=0.9)
    ax.set_axisbelow(True)
    for spine in ("top", "right", "left"):
        ax.spines[spine].set_visible(False)
    ax.spines["bottom"].set_color(COLORS["grid"])
    for boundary in (0.5, 1.5, 2.5):
        ax.axhline(boundary, color=COLORS["grid"], linewidth=0.65, alpha=0.7, zorder=0)

    ax.text(
        DELTA_COLUMN_X, -0.62, "paired delta", transform=ax.get_yaxis_transform(),
        ha="left", va="center", fontsize=9.4, color=COLORS["muted"], clip_on=False,
    )
    ax.text(
        0.012, -0.62, "median ms", transform=ax.get_yaxis_transform(),
        ha="left", va="center", fontsize=9.4, color=COLORS["muted"], clip_on=False,
    )

    for index, case in enumerate(cases):
        center = y[index]
        for arm, offset, color in (
            ("native", -0.17, COLORS["native"]),
            ("candidate", 0.17, COLORS["candidate"]),
        ):
            value = case[f"{arm}_ms"]
            if value is None:
                label = "N/A" if arm == "native" else ""
                text = ax.text(
                    0.012 * scale, center + offset, label, ha="left", va="center",
                    fontsize=10.6, color=COLORS["faint"], style="italic", zorder=4,
                    gid=f"value-{case['case']}-{arm}",
                )
                text.set_url("")
                continue
            ax.barh(
                center + offset, float(value), height=0.29, color=color,
                edgecolor="none", zorder=3, gid=f"bar-{case['case']}-{arm}",
            )
            ax.text(
                float(value) + 0.012 * scale, center + offset,
                f"{float(value):.3f} ms", ha="left", va="center", fontsize=10.7,
                color=COLORS["ink"], zorder=4, gid=f"value-{case['case']}-{arm}",
            )

        delta = _delta_label(case)
        delta_color = COLORS["muted"] if case["median_ratio"] is None else COLORS["ink"]
        ax.text(
            DELTA_COLUMN_X, center, delta, transform=ax.get_yaxis_transform(),
            ha="left", va="center", fontsize=10.9, fontweight="bold",
            color=delta_color, clip_on=False, gid=f"delta-{case['case']}",
        )

    if show_xlabels:
        ax.set_xlabel("latency (ms, CUDA-event graph)", fontsize=10.2, labelpad=6)


def _error_magnitude_summary(case: dict) -> dict | None:
    """Public scalar error magnitudes extracted from the case source receipt."""
    evidence = case.get("source_result_evidence")
    if not isinstance(evidence, dict):
        return None
    accumulation = evidence.get("accumulation_range", {})
    post = evidence.get("accumulation_range_post_timing", {})
    return {
        "max_abs_difference": accumulation.get("max_abs_difference"),
        "max_relative_l2": accumulation.get("max_relative_l2"),
        "first_differing_boundary": evidence.get("first_differing_boundary"),
        "post_timing_max_abs_difference": post.get("max_abs_difference"),
        "post_timing_max_relative_l2": post.get("max_relative_l2"),
        "boundary_count": len(evidence.get("compared", [])),
        "post_timing_boundary_count": len(evidence.get("compared_post_timing", [])),
    }


def _svg_description(data: dict, precision: str) -> str:
    cases = [case for case in data["cases"] if case["precision"] == precision]
    device = data["device"]
    device_name = device if isinstance(device, str) else device.get("name", "GPU not supplied")
    sm = "" if isinstance(device, str) else f", SM{device.get('sm')}"
    legacy = cases_by(data, "legacy71", precision)
    small = cases_by(data, "small31", precision)
    small_fp8_contract = small[0]["numerical_contract"] if precision == "fp8" else ""
    parts = [
        f"{precision.upper()} prepared-feature reconstruction trunk latency; two model panels, "
        "four resolutions (720p, 1080p, 1440p, 4K).",
        f"Scope: {data['scope']['text']}",
        f"Device: {device_name}{sm}, batch 1.",
        (
            "Protocol: CUDA-event graph timing; 3 passes/graph; 20 warmup replays; "
            "64 alternating paired samples (32 per order); 10 graph replays/sample. "
            "Small31 FP16 uses 64 candidate-only samples."
        ),
        "Bars are per-case medians. Paired delta is the supplied candidate/reference paired median "
        "ratio minus 1; positive means longer candidate latency, negative means shorter. "
        "Ratios are supplied by the measurement summary and are not recomputed from aggregate medians.",
        "Legacy71: " + _panel_subtitle("legacy71", precision, legacy) + ".",
    ]
    if precision == "fp8":
        parts.append("Small31 FP8: " + small_fp8_contract)
    else:
        parts.append("Small31 FP16: " + SMALL_FP16_CONTRACT)
    parts.append("No performance, speedup or equivalence claim is made.")
    return " ".join(parts)


def _svg_metadata(data: dict, precision: str) -> dict:
    cases = [case for case in data["cases"] if case["precision"] == precision]
    return {
        "schema_version": "dual-model-deployment-svg/1",
        "precision": precision,
        "title": f"{precision.upper()} prepared-feature trunk latency",
        "source": {
            "aggregate_path": data.get("source_aggregate", {}).get("path"),
            "aggregate_sha256": data.get("source_aggregate", {}).get("sha256"),
            "raw_evidence": data.get("raw_evidence"),
            "source_revision": data.get("source_revision"),
            "generated_at": data.get("generated_at"),
        },
        "device": data["device"],
        "scope": data["scope"],
        "protocol": data["protocol"],
        "generator": data.get("generator", {}),
        "panels": [
            {
                "model": model,
                "dll_version": _dll_version(cases_by(data, model, precision)),
                "subtitle": _panel_subtitle(model, precision, cases_by(data, model, precision)),
                "cases": [
                    {
                        "case": case["case"],
                        "native_ms": case["native_ms"],
                        "candidate_ms": case["candidate_ms"],
                        "median_ratio": case["median_ratio"],
                        "by_order": case["by_order"],
                        "native_status": case["native_status"],
                        "candidate_status": case["candidate_status"],
                        "sample_summary": case["sample_summary"],
                        "validation": case["validation"],
                        "numerical_contract": case["numerical_contract"],
                        "source_result": case["source_result"],
                        "source_result_sha256": case["source_result_sha256"],
                        "harness_sha256": case["harness_sha256"],
                        **(
                            {"error_magnitude": _error_magnitude_summary(case)}
                            if case.get("source_result_evidence") else {}
                        ),
                    }
                    for case in cases_by(data, model, precision)
                ],
            }
            for model in MODEL_ORDER
        ],
    }


def _inject_head(svg: str, title: str, description: str, metadata: dict) -> bytes:
    start = svg.find("<svg")
    if start < 0:
        raise RuntimeError("Matplotlib did not emit an SVG root")
    end = svg.find(">", start)
    if end < 0:
        raise RuntimeError("Matplotlib emitted an invalid SVG root")
    # Matplotlib writes point units; expose the native CSS-pixel canvas size.
    canvas_w = int(round(FIG_W * 100))
    canvas_h = int(round(FIG_H * 100))
    root = re.sub(r'width="[0-9.]+pt" height="[0-9.]+pt"',
                  f'width="{canvas_w}" height="{canvas_h}"', svg[start:end + 1], count=1)
    payload = (
        f'\n<title id="chart-title">{escape(title)}</title>'
        f'\n<desc id="chart-desc">{escape(description)}</desc>'
        f'\n<metadata id="chart-metadata">{escape(json.dumps(metadata, indent=2, ensure_ascii=False))}</metadata>'
    )
    result = svg[:start] + root + payload + svg[end + 1 :]
    # Matplotlib leaves spaces at the ends of multiline path attributes.
    # Remove only horizontal trailing whitespace; retain all SVG newlines.
    return re.sub(r"[ \t]+(?=\r?$)", "", result, flags=re.MULTILINE).encode("utf-8")


def render_precision(data: dict, precision: str, output_dir: Path, png_dir: Path | None) -> tuple[Path, Path | None]:
    _configure_matplotlib()
    fig = plt.figure(figsize=(FIG_W, FIG_H), dpi=100, facecolor=COLORS["background"])
    fig.text(0.018, 0.975, f"{precision.upper()} prepared-feature trunk latency",
             fontsize=19.5, fontweight="bold", va="top")
    fig.text(0.018, 0.944, _method_line(data), fontsize=10.3, color=COLORS["muted"], va="top")
    fig.legend(
        handles=[
            Patch(facecolor=COLORS["native"], edgecolor="none", label="DLL-extracted kernels"),
            Patch(facecolor=COLORS["candidate"], edgecolor="none", label="Reconstructed kernels"),
        ],
        loc="upper left", bbox_to_anchor=(0.014, 0.9325), ncol=2, frameon=False,
        fontsize=11.0, handlelength=1.2, columnspacing=1.6,
    )

    # The 1000 px canvas keeps the two panels at their original pixel heights and
    # gaps, anchored the same distance from the top, and reserves the extra
    # 100 px below the panels for the larger six-line footer.
    axes_positions = (
        (0.195, 0.5815, 0.565, 0.2385),
        (0.195, 0.2305, 0.565, 0.2430),
    )
    for panel_index, (model, position) in enumerate(zip(MODEL_ORDER, axes_positions)):
        ax = fig.add_axes(position)
        _draw_panel(ax, data, model, precision, show_xlabels=panel_index == 1)
        cases = cases_by(data, model, precision)
        label = f"{model.replace('legacy71', 'Legacy71').replace('small31', 'Small31')} - "
        label += "old" if model == "legacy71" else "new"
        label += f" DLL {_dll_version(cases)}"
        fig.text(position[0], position[1] + position[3] + 0.0369, label,
                 fontsize=14.2, fontweight="bold", va="top")
        subtitle = _panel_subtitle(model, precision, cases)
        if model == "small31" and precision == "fp8":
            fig.text(position[0], position[1] + position[3] + 0.0153, subtitle,
                     fontsize=10.4, color=COLORS["candidate"], fontweight="bold", va="top")
        else:
            fig.text(position[0], position[1] + position[3] + 0.0153, subtitle,
                     fontsize=10.2, color=COLORS["muted"], va="top")

    for line_index, line in enumerate(_footer_lines(data)):
        fig.text(0.018, 0.166 - 0.017 * line_index, line, fontsize=11.5,
                 color=COLORS["muted"], va="top")

    output_dir.mkdir(parents=True, exist_ok=True)
    svg_path = output_dir / f"deployment_{precision}_resolutions.svg"
    fig.savefig(svg_path, format="svg", facecolor=fig.get_facecolor(), metadata={"Date": None})
    raw_svg = svg_path.read_text(encoding="utf-8")
    title = f"{precision.upper()} prepared-feature trunk latency"
    svg_path.write_bytes(_inject_head(raw_svg, title, _svg_description(data, precision),
                                      _svg_metadata(data, precision)))

    png_path = None
    if png_dir is not None:
        png_dir.mkdir(parents=True, exist_ok=True)
        png_path = png_dir / f"deployment_{precision}_resolutions.png"
        fig.savefig(png_path, format="png", dpi=850.0 / FIG_W, facecolor=fig.get_facecolor())
    plt.close(fig)
    return svg_path, png_path


def parse_args(argv: list[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--data", type=Path,
                        default=Path("docs/figures/dual_model_deployment_measurements.json"))
    parser.add_argument("--output-dir", type=Path, default=Path("docs/figures"))
    parser.add_argument("--png-dir", type=Path, default=None,
                        help="optional private directory for 850px-wide PNG previews")
    return parser.parse_args(argv)


def main(argv: list[str] | None = None) -> int:
    args = parse_args(argv)
    try:
        data = load_summary(args.data)
        if args.png_dir is not None:
            try:
                import PIL  # noqa: F401
            except ImportError as exc:
                raise ContractError("PNG review requires Pillow alongside Matplotlib") from exc
        rendered = [
            render_precision(data, precision, args.output_dir, args.png_dir)
            for precision in PRECISIONS
        ]
    except ContractError as exc:
        print(f"error: {exc}", file=sys.stderr)
        return 2
    for svg_path, png_path in rendered:
        print(f"wrote {svg_path} sha256={_sha256(svg_path)}")
        if png_path is not None:
            print(f"wrote {png_path} sha256={_sha256(png_path)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
