"""FFmpeg argv construction, subprocess execution and frame-path handling."""
from __future__ import annotations

import subprocess
from pathlib import Path
from typing import Sequence


# -- ffmpeg commands (argv lists, never shell strings) ----------------------


def encode_png_sequence_command(ffmpeg, pattern, fps, output, *, crf=16,
                                preset="medium") -> list[str]:
    """Build a lossless-input H.264 encode of a numbered PNG sequence.

    No scale filter is inserted: the panels/streams keep their native pixel
    dimensions.  Audio is disabled.  The result is an argv list, so paths with
    spaces, quotes or parentheses need no shell escaping.
    """
    if not isinstance(fps, (int, float)) or isinstance(fps, bool) or not 0 < fps <= 240:
        raise ValueError("fps must be a positive number <= 240")
    if not isinstance(crf, int) or isinstance(crf, bool) or not 0 <= crf <= 51:
        raise ValueError("crf must be an integer 0..51")
    return [
        str(ffmpeg), "-hide_banner", "-loglevel", "error", "-y",
        "-framerate", fps_text(fps), "-start_number", "0", "-i", str(pattern),
        "-an", "-c:v", "libx264", "-preset", str(preset), "-crf", str(crf),
        "-pix_fmt", "yuv420p", "-movflags", "+faststart", str(output),
    ]


def decode_video_frames_command(ffmpeg, input_video, output_pattern) -> list[str]:
    """Build the passthrough frame extraction used for ``--input-video``.

    ``-fps_mode passthrough`` keeps one output per decoded source frame; there
    is no ``fps`` filter, duplication, drop or interpolation.
    """
    return [
        str(ffmpeg), "-hide_banner", "-loglevel", "error", "-y",
        "-i", str(input_video), "-map", "0:v:0", "-an",
        "-fps_mode", "passthrough", "-start_number", "0", str(output_pattern),
    ]


def fps_text(fps) -> str:
    if isinstance(fps, int) or float(fps).is_integer():
        return str(int(fps))
    return f"{float(fps):.6g}"


def run_command(argv: Sequence[str], *, cwd=None) -> subprocess.CompletedProcess:
    """Run an argv list with no shell, inheriting stdio; raise on failure.

    Stdio is inherited deliberately: the harness may run under a sandbox that
    denies cross-process pipes.  The exact argv is recorded in the manifest, so
    missing output is never hidden from the reproduction record.
    """
    try:
        return subprocess.run([str(value) for value in argv], cwd=cwd, check=True)
    except subprocess.CalledProcessError as error:
        raise RuntimeError(
            f"command failed with exit code {error.returncode}: {argv[0]}") from error


def ffmpeg_version(ffmpeg) -> str | None:
    try:
        result = subprocess.run([str(ffmpeg), "-version"], check=True,
                                capture_output=True, text=True, timeout=30)
    except (OSError, subprocess.SubprocessError):
        return None
    first = result.stdout.splitlines()[0] if result.stdout else ""
    return first.strip() or None


def iter_frame_paths(directory, *, limit=None, suffix=".png") -> list[Path]:
    """Return frame files in deterministic numeric/lexicographic order."""
    directory = Path(directory)
    if not directory.is_dir():
        raise ValueError(f"frame directory does not exist: {directory}")
    paths = sorted(path for path in directory.iterdir()
                   if path.is_file() and path.suffix.lower() == suffix.lower())
    if not paths:
        raise ValueError(f"no {suffix} frames in {directory}")
    if limit is not None:
        if isinstance(limit, bool) or not isinstance(limit, int) or limit < 1:
            raise ValueError("frame limit must be a positive integer")
        paths = paths[:limit]
    return paths
