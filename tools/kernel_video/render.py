"""Render and publish the source-grounded FP16 FFN film (no shell commands).

All temporary Manim/TeX files live beside the cached runtime on C: by default.
Manim's still-image mode writes its own metadata, so previews are deliberately
isolated from the complete film's metadata and rendered clips.
"""
from __future__ import annotations

import argparse
import ast
from concurrent.futures import ThreadPoolExecutor, as_completed
from dataclasses import dataclass
from html import escape
import json
import math
import os
from pathlib import Path
import re
import subprocess
import sys


HERE = Path(__file__).resolve().parent
REPO = HERE.parents[1]
SOURCE = HERE / "ffn_expansion.py"
REVISION = "fc3276497f866bdad639cd443e75743f5d19b749"
GITHUB = "https://github.com/DylanWaken/DLSS5-Pytorch"
KERNEL = "csrc/kernel_impl/bottleneck_c1024_ffn/fp16/global_ffn_expand_c1024_fp16.cu"
FILENAME = "fp16-c1024-ffn-expansion.mp4"
LESSON = "../../global_ffn_expand_c1024_fp16.html"
MAX_FILE_BYTES = 95 * 1024 * 1024


@dataclass(frozen=True)
class SceneSpec:
    name: str
    number: int
    chapter: str


def scene_specs() -> list[SceneSpec]:
    """Read the scene registry without importing Manim or executing its source."""
    tree = ast.parse(SOURCE.read_text(encoding="utf-8"))
    classes = {}
    order = []
    for node in tree.body:
        if isinstance(node, ast.ClassDef):
            values = {}
            for stmt in node.body:
                if isinstance(stmt, ast.Assign) and isinstance(stmt.value, ast.Constant):
                    for target in stmt.targets:
                        if isinstance(target, ast.Name):
                            values[target.id] = stmt.value.value
            if "number" in values and values["number"]:
                classes[node.name] = SceneSpec(node.name, values["number"], values["chapter"])
        elif isinstance(node, ast.Assign) and any(
            isinstance(target, ast.Name) and target.id == "SCENES" for target in node.targets
        ):
            order = [item.id for item in node.value.elts]
    specs = [classes[name] for name in order]
    if not specs or len({s.number for s in specs}) != len(specs):
        raise ValueError("SCENES must list unique numbered Scene classes")
    return specs


def chapter_selection(value: str, specs: list[SceneSpec]) -> list[SceneSpec]:
    if value == "all":
        return specs
    chosen = set()
    for part in value.split(","):
        match = re.fullmatch(r"\s*(\d+)(?:-(\d+))?\s*", part)
        if not match:
            raise ValueError("--chapters accepts all, 3, 1,4,7 or 2-5")
        start, end = int(match[1]), int(match[2] or match[1])
        if start > end:
            raise ValueError("Chapter ranges must be increasing")
        chosen.update(range(start, end + 1))
    unknown = chosen - {s.number for s in specs}
    if unknown:
        raise ValueError(f"Unknown chapter numbers: {sorted(unknown)}")
    return [s for s in specs if s.number in chosen]


def run(command: list[str], *, cwd: Path, env: dict | None = None) -> None:
    # A list of arguments reaches the executable directly; no shell quoting or
    # command interpolation is involved, including for paths with spaces.
    subprocess.run([str(arg) for arg in command], cwd=cwd, env=env, check=True)


def runtime_environment(cache: Path) -> dict:
    env = os.environ.copy()
    tex = cache / "miktex/texmfs/install/miktex/bin/x64"
    scripts = cache / "venv/Scripts"
    env["PATH"] = os.pathsep.join([str(tex), str(scripts), env.get("PATH", "")])
    env["PYTHONUTF8"] = "1"
    return env


def render(args, specs: list[SceneSpec], preview: bool = False) -> None:
    media = args.cache / "preview/media" if preview else args.media_dir
    metadata = args.cache / "preview/metadata" if preview else args.metadata_dir
    media.mkdir(parents=True, exist_ok=True)
    metadata.mkdir(parents=True, exist_ok=True)
    if os.name == "nt" and media.drive.lower() != args.cache.drive.lower():
        raise ValueError("The media directory and cache working directory must share a drive for dvisvgm")
    env = runtime_environment(args.cache)
    env["KERNEL_VIDEO_META"] = str(metadata)
    logs = args.cache / ("preview/logs" if preview else "logs")
    logs.mkdir(parents=True, exist_ok=True)

    def render_one(spec: SceneSpec):
        # Separate media directories also isolate TeX compilation and avoid two
        # workers writing the same cached formula's DVI/SVG simultaneously.
        scene_media = media / spec.name
        logfile = logs / f"{spec.number:02d}-{spec.name}.log"
        command = [sys.executable, "-m", "manim", "--renderer", "cairo",
                   "--media_dir", str(scene_media), "--resolution", "1920,1080",
                   "--fps", "30", "--disable_caching"]
        command += ["-s"] if preview else ["--format", "mp4"]
        command += [str(SOURCE), spec.name]
        print(f"Starting {spec.number:02d}: {spec.chapter}; log: {logfile}", flush=True)
        with logfile.open("w", encoding="utf-8") as log:
            result = subprocess.run(command, cwd=args.cache, env=env,
                                    stdout=log, stderr=subprocess.STDOUT)
        if result.returncode:
            tail = "\n".join(logfile.read_text(encoding="utf-8", errors="replace").splitlines()[-25:])
            raise RuntimeError(f"{spec.name} failed; see {logfile}\n{tail}")
        print(f"Finished {spec.number:02d}: {spec.chapter}", flush=True)

    print(f"{'Previewing' if preview else 'Rendering'} {len(specs)} chapters with {args.jobs} worker(s); media: {media}", flush=True)
    with ThreadPoolExecutor(max_workers=args.jobs) as pool:
        futures = [pool.submit(render_one, spec) for spec in specs]
        for future in as_completed(futures):
            future.result()


def probe(path: Path) -> dict:
    import av

    with av.open(str(path)) as container:
        stream = container.streams.video[0]
        if stream.duration is not None:
            duration = float(stream.duration * stream.time_base)
        elif container.duration is not None:
            duration = float(container.duration / av.time_base)
        else:
            raise ValueError(f"Video has no duration: {path}")
        rate = float(stream.average_rate or stream.base_rate or 0)
        return dict(duration=duration, width=stream.width, height=stream.height,
                    fps=rate, frames=stream.frames, codec=stream.codec_context.name)


def find_clip(media: Path, spec: SceneSpec) -> Path:
    found = [p for p in media.rglob(spec.name + ".mp4")
             if "partial_movie_files" not in p.parts]
    correct = [p for p in found if probe(p)["width"] == 1920
               and probe(p)["height"] == 1080 and abs(probe(p)["fps"] - 30) < .01]
    if len(correct) != 1:
        raise ValueError(f"Expected exactly one 1920×1080 30 fps clip for {spec.name}, found {correct}; searched {media}")
    return correct[0]


def vtt_time(seconds: float) -> str:
    milliseconds = max(0, round(seconds * 1000))
    hours, remainder = divmod(milliseconds, 3_600_000)
    minutes, remainder = divmod(remainder, 60_000)
    whole, fraction = divmod(remainder, 1000)
    return f"{hours:02d}:{minutes:02d}:{whole:02d}.{fraction:03d}"


def display_time(seconds: float) -> str:
    whole = int(seconds)
    hours, remainder = divmod(whole, 3600)
    minutes, seconds = divmod(remainder, 60)
    return f"{hours}:{minutes:02d}:{seconds:02d}" if hours else f"{minutes}:{seconds:02d}"


def concat_path(path: Path) -> str:
    value = path.resolve().as_posix()
    if any(c in value for c in "\n\r\0"):
        raise ValueError("Invalid character in clip path")
    return "file '" + value.replace("'", "'\\''") + "'"


def load_timeline(specs: list[SceneSpec], args) -> tuple[list[dict], list[dict]]:
    chapters, cues = [], []
    offset = 0.0
    for spec in specs:
        clip = find_clip(args.media_dir, spec)
        info = probe(clip)
        metadata_path = args.metadata_dir / f"{spec.number:02d}.json"
        metadata = json.loads(metadata_path.read_text(encoding="utf-8"))
        if metadata["scene"] != spec.name or metadata["number"] != spec.number:
            raise ValueError(f"Scene identity mismatch in {metadata_path}")
        clock_duration = float(metadata["duration"])
        duration = info["duration"]
        if clock_duration <= 0 or not math.isfinite(clock_duration):
            raise ValueError(f"Invalid scene clock in {metadata_path}; do not use preview metadata")
        if abs(clock_duration - duration) > max(.2, duration * .01):
            raise ValueError(f"Metadata/video duration mismatch for {spec.name}: {clock_duration:.4f}s / {duration:.4f}s")
        # Manim's floating clock and encoded frame counts may differ by a small
        # amount. Anchor each chapter to its actual MP4 duration and proportionally
        # map only that chapter's cue clock; errors never accumulate across clips.
        ratio = duration / clock_duration
        local_cues = []
        previous_end = 0.0
        for item in metadata["cues"]:
            start = max(0.0, float(item["start"]) * ratio)
            end = min(duration, float(item["end"]) * ratio)
            if start < previous_end - .001 or end <= start or start >= duration:
                raise ValueError(f"Invalid or overlapping caption in {metadata_path}: {item}")
            cue = dict(start=offset + start, end=offset + end, text=item["text"],
                       chapter=spec.number, local_start=start, local_end=end)
            local_cues.append(cue)
            cues.append(cue)
            previous_end = end
        if not local_cues:
            raise ValueError(f"Missing captions in {metadata_path}")
        slug = re.sub(r"[^a-z0-9]+", "-", spec.name[4:].lower()).strip("-")
        chapters.append(dict(number=spec.number, scene=spec.name, title=spec.chapter,
                             start=offset, end=offset + duration, duration=duration,
                             clip=str(clip), source=metadata.get("source", ""),
                             still=f"stills/{spec.number:02d}-{slug}.jpg", cues=local_cues,
                             metadata_duration=clock_duration))
        offset += duration
    return chapters, cues


def encode_film(args, chapters: list[dict], ffmpeg: str) -> None:
    concat = args.cache / "concat-ffn-expansion.txt"
    concat.write_text("\n".join(concat_path(Path(ch["clip"])) for ch in chapters) + "\n", encoding="utf-8")
    temporary = args.output / ".fp16-c1024-ffn-expansion.encoding.mp4"
    command = [ffmpeg, "-hide_banner", "-y", "-f", "concat", "-safe", "0", "-i", str(concat),
               "-map", "0:v:0", "-an", "-map_metadata", "-1", "-c:v", "libx264",
               "-preset", "medium", "-crf", str(args.crf), "-pix_fmt", "yuv420p",
               "-r", "30", "-movflags", "+faststart", "-metadata",
               "title=One token through the FP16 C1024 FFN expansion", str(temporary)]
    print("Encoding the web MP4 with H.264, yuv420p and fast-start metadata...", flush=True)
    run(command, cwd=args.cache)
    result = probe(temporary)
    expected = chapters[-1]["end"]
    if abs(result["duration"] - expected) > 2 / 30:
        raise ValueError(f"Assembled duration differs from chapter sum: {result['duration']} versus {expected}")
    if temporary.stat().st_size >= MAX_FILE_BYTES:
        raise ValueError(f"MP4 is {temporary.stat().st_size / 1024**2:.1f} MiB; use --crf 24 or 26 to stay below the 95 MiB publication budget")
    temporary.replace(args.output / FILENAME)


def extract_stills(args, chapters: list[dict], ffmpeg: str) -> None:
    (args.output / "stills").mkdir(exist_ok=True)
    for chapter in chapters:
        final_cue = chapter["cues"][-1]
        local_time = min(chapter["duration"] - .1,
                         final_cue["local_start"] + min(2.5, (final_cue["local_end"] - final_cue["local_start"]) / 2))
        chapter["still_time"] = chapter["start"] + local_time
        run([ffmpeg, "-hide_banner", "-loglevel", "error", "-y", "-ss", f"{local_time:.6f}",
             "-i", chapter["clip"], "-frames:v", "1", "-q:v", "2", str(args.output / chapter["still"])],
            cwd=args.cache)
    # A tile hierarchy is a useful invitation to a film about implementation.
    poster_chapter = next((ch for ch in chapters if ch["number"] == 3), chapters[0])
    (args.output / "poster.jpg").write_bytes((args.output / poster_chapter["still"]).read_bytes())


def write_vtt(path: Path, cues: list[dict]) -> None:
    blocks = ["WEBVTT", "NOTE Captions follow the source animation. Timings are anchored to encoded chapter durations."]
    for index, cue in enumerate(cues, 1):
        # Escape cue text as WebVTT text, rather than allowing markup-like source.
        blocks.append(f"{index}\n{vtt_time(cue['start'])} --> {vtt_time(cue['end'])}\n{escape(cue['text'])}")
    path.write_text("\n\n".join(blocks) + "\n", encoding="utf-8")


def write_transcript(path: Path, chapters: list[dict]) -> None:
    source_url = f"{GITHUB}/blob/{REVISION}/{KERNEL}"
    nav = "".join(f'<li><a href="#{ch["scene"]}"><span>{display_time(ch["start"])}</span> {ch["number"]:02d}. {escape(ch["title"])}</a></li>' for ch in chapters)
    sections = []
    for ch in chapters:
        caption_items = "".join(
            f'<li><a class="time" href="{FILENAME}#t={cue["start"]:.3f}" data-seek="{cue["start"]:.3f}" aria-label="Play at {display_time(cue["start"])}">{display_time(cue["start"])}</a><p>{escape(cue["text"])}</p></li>'
            for cue in ch["cues"])
        sections.append(f'''<section id="{ch['scene']}"><h2><span>{ch['number']:02d}</span> {escape(ch['title'])}</h2>
<p class="chapter-meta"><a href="{FILENAME}#t={ch['start']:.3f}" data-seek="{ch['start']:.3f}">Play from {display_time(ch['start'])}</a> · source: {escape(ch['source'])}</p>
<figure><a href="{FILENAME}#t={ch['still_time']:.3f}" data-seek="{ch['still_time']:.3f}"><img src="{ch['still']}" alt="Animation frame for chapter {ch['number']}: {escape(ch['title'])}" width="1920" height="1080" loading="lazy"></a><figcaption>Representative frame at {display_time(ch['still_time'])}. Select the image to watch this moment in motion.</figcaption></figure>
<ol class="cues">{caption_items}</ol></section>''')
    html = f'''<!doctype html>
<html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>One token through FP16 C1024 FFN expansion — illustrated video transcript</title>
<meta name="description" content="An illustrated, timed transcript of the Manim source walkthrough for the FP16 C1024 FFN expansion CUDA kernel.">
<style>
:root{{--paper:#faf9f5;--ink:#1b2e43;--muted:#5b6b7c;--line:#dce2e4;--accent:#086f72}}*{{box-sizing:border-box}}html{{scroll-behavior:smooth}}body{{margin:0;background:var(--paper);color:var(--ink);font:17px/1.7 system-ui,-apple-system,'Segoe UI',sans-serif}}main{{max-width:1140px;margin:auto;padding:32px 30px 70px}}a{{color:var(--accent);text-underline-offset:3px}}a:focus-visible,video:focus-visible{{outline:3px solid #cc8a2e;outline-offset:5px}}.back,.eyebrow{{font-size:13px}}.eyebrow{{color:var(--accent);margin-top:40px;text-transform:uppercase;letter-spacing:.12em}}h1{{font-size:clamp(34px,4.5vw,58px);line-height:1.12;letter-spacing:-.04em;margin:12px 0 22px}}.intro{{font-size:20px;color:var(--muted);max-width:920px}}video{{display:block;width:100%;height:auto;aspect-ratio:16/9;background:#0b1020;border-radius:8px}}.resources{{display:flex;flex-wrap:wrap;gap:12px 24px;font-size:14px;margin:15px 0 30px}}.note{{border-left:4px solid #c08b4c;background:#f7efdf;padding:14px 20px;font-size:15px}}nav{{border-top:1px solid var(--line);border-bottom:1px solid var(--line);padding:18px 0;margin:28px 0 40px}}nav ol{{columns:2;list-style:none;padding:0;margin:0;font-size:14px}}nav li{{break-inside:avoid;margin:5px 0}}nav a{{text-decoration:none}}nav span,.time{{font:13px Consolas,ui-monospace,monospace}}nav span{{display:inline-block;min-width:4.4em;color:var(--muted)}}section{{margin-top:55px;scroll-margin-top:20px}}h2{{font-size:28px;line-height:1.3;letter-spacing:-.025em;border-top:1px solid var(--line);padding-top:24px;margin-bottom:8px}}h2 span{{color:var(--accent);font-size:20px;padding-right:7px}}.chapter-meta{{font-size:13px;color:var(--muted)}}figure{{margin:22px 0;background:white;border:1px solid var(--line);border-radius:8px;overflow:hidden}}figure img{{display:block;width:100%;height:auto}}figcaption{{font-size:13px;color:var(--muted);padding:12px 16px}}.cues{{list-style:none;margin:25px 0;padding:0}}.cues li{{display:grid;grid-template-columns:65px minmax(0,1fr);gap:14px;padding:11px 0;border-bottom:1px solid #e6eae9}}.cues p{{margin:0}}.time{{padding-top:8px}}footer{{margin-top:60px;padding-top:20px;border-top:1px solid var(--line);font-size:13px;color:var(--muted)}}code{{font:.9em Consolas,monospace;overflow-wrap:anywhere}}@media(max-width:650px){{main{{padding:20px 18px 45px}}nav ol{{columns:1}}.intro{{font-size:18px}}h2{{font-size:24px}}.cues li{{grid-template-columns:52px minmax(0,1fr);gap:7px}}}}@media(prefers-reduced-motion:reduce){{html{{scroll-behavior:auto}}}}@media print{{video{{display:none}}main{{padding:0}}figure,li{{break-inside:avoid}}a{{color:inherit}}}}
</style></head><body><main>
<a class="back" href="{LESSON}">← Return to the complete kernel lesson</a>
<p class="eyebrow">Illustrated video transcript · {len(chapters)} chapters · {display_time(chapters[-1]['end'])}</p>
<h1>One token through the FP16 C1024 FFN expansion</h1>
<p class="intro">Trace token 83 from its packed input through CTA and lane ownership, address arithmetic, asynchronous copies, shared panels, register fragments, warp-wide MMA, Half activation and the final output store.</p>
<video id="film" controls playsinline preload="metadata" width="1920" height="1080" poster="poster.jpg" aria-label="FP16 C1024 FFN expansion source walkthrough"><source src="{FILENAME}" type="video/mp4"><track kind="captions" src="captions.vtt" srclang="en" label="English captions">Download the <a href="{FILENAME}">MP4 video</a>.</video>
<div class="resources"><a href="{FILENAME}" download>Download MP4</a><a href="captions.vtt" download>Download WebVTT captions</a><a href="chapters.json">Chapter timings</a><a href="{GITHUB}/tree/main/tools/kernel_video">Manim source and render instructions ↗</a></div>
<p class="note">The film illustrates the source's dependency order. It does not measure GPU cycles, promise cache hits, or depict physical register-bank placement. The captions are also drawn into the video; the optional English caption track provides a separate browser-accessible version. This film uses captions and has no spoken audio.</p>
<nav aria-label="Video chapters"><ol>{nav}</ol></nav>
{''.join(sections)}
<footer><p>Kernel source: <a href="{source_url}"><code>{KERNEL}</code></a>, revision <code>{REVISION}</code>. The <a href="{LESSON}">written lesson</a> contains the surrounding model architecture, derivation and exact supporting source excerpts.</p><p>Rendered with Manim and MiKTeX. Chapter times and captions are aligned to the encoded 30 fps clips; the illustrations are explanatory drawings of the source.</p></footer>
</main><script>
const film=document.getElementById('film');
document.querySelectorAll('[data-seek]').forEach(link=>link.addEventListener('click',event=>{{
  event.preventDefault();
  const seek=()=>{{film.currentTime=Number(link.dataset.seek);film.play().catch(()=>{{}});}};
  if(film.readyState>=1)seek();else{{film.addEventListener('loadedmetadata',seek,{{once:true}});film.load();}}
  film.scrollIntoView({{block:'center'}});film.focus({{preventScroll:true}});
}}));
</script></body></html>'''
    path.write_text(html, encoding="utf-8")


def assemble(args, specs: list[SceneSpec]) -> None:
    import imageio_ffmpeg

    args.output.mkdir(parents=True, exist_ok=True)
    ffmpeg = imageio_ffmpeg.get_ffmpeg_exe()
    chapters, cues = load_timeline(specs, args)
    encode_film(args, chapters, ffmpeg)
    extract_stills(args, chapters, ffmpeg)
    write_vtt(args.output / "captions.vtt", cues)
    write_transcript(args.output / "transcript.html", chapters)
    public_chapters = [{key: value for key, value in ch.items() if key not in {"clip", "cues"}}
                       for ch in chapters]
    manifest = dict(title="One token through the FP16 C1024 FFN expansion",
                    video=FILENAME, width=1920, height=1080, fps=30,
                    duration=chapters[-1]["end"], caption_count=len(cues),
                    source_revision=REVISION, source_url=f"{GITHUB}/blob/{REVISION}/{KERNEL}",
                    schedule="Source dependency order; not a measured or cycle-accurate trace",
                    chapters=public_chapters)
    (args.output / "chapters.json").write_text(json.dumps(manifest, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
    video = args.output / FILENAME
    print(f"Published locally: {video}\n{display_time(manifest['duration'])}; {len(chapters)} chapters; "
          f"{len(cues)} captions; {video.stat().st_size / 1024**2:.2f} MiB", flush=True)


def parse_args():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--render", action="store_true", help="Render selected chapters at 1920×1080, 30 fps")
    parser.add_argument("--preview", action="store_true", help="Render each selected chapter's final frame; separate preview metadata")
    parser.add_argument("--assemble", action="store_true", help="Assemble all 15 existing full-resolution chapters and documentation assets")
    parser.add_argument("--chapters", default="all", help="Chapters to render/preview: all, 3, 1,4,7 or 2-5 (assembly always includes all)")
    parser.add_argument("--jobs", type=int, default=1, help="Concurrent Manim processes, each with isolated TeX media and a log (default 1)")
    parser.add_argument("--cache", type=Path, default=Path.home() / ".cache/dlssnr-kernel-video")
    parser.add_argument("--media-dir", type=Path, help="Existing/new full-film Manim media (default: CACHE/media)")
    parser.add_argument("--metadata-dir", type=Path, help="Full-film scene timing JSON (default: CACHE/metadata)")
    parser.add_argument("--output", type=Path, default=REPO / "docs/kernel-guide/assets/video")
    parser.add_argument("--crf", type=int, default=22, help="H.264 quality; default 22; increase if the film exceeds 95 MiB")
    args = parser.parse_args()
    if not (args.render or args.preview or args.assemble):
        parser.error("Choose --render, --preview and/or --assemble")
    if args.render and args.preview:
        parser.error("Run --preview separately from --render")
    if not 0 <= args.crf <= 51:
        parser.error("--crf must be in 0..51")
    if args.jobs < 1:
        parser.error("--jobs must be positive")
    args.cache = args.cache.expanduser().resolve()
    args.media_dir = (args.media_dir or args.cache / "media").expanduser().resolve()
    args.metadata_dir = (args.metadata_dir or args.cache / "metadata").expanduser().resolve()
    args.output = args.output.expanduser().resolve()
    return args


def main() -> None:
    args = parse_args()
    specs = scene_specs()
    selected = chapter_selection(args.chapters, specs)
    args.cache.mkdir(parents=True, exist_ok=True)
    if args.render:
        render(args, selected)
    if args.preview:
        render(args, selected, preview=True)
    if args.assemble:
        assemble(args, specs)


if __name__ == "__main__":
    main()
