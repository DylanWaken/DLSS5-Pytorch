# FP16 C1024 FFN expansion: animated kernel lesson

This Manim film follows token 83 through `global_ffn_expand_c1024_fp16`: model dimensions, launch decomposition, warp tiles, packed lanes, byte addresses, asynchronous copies, shared panels and banks, the three-slot schedule, direct weight loads, warp-wide MMA, register reuse, Half activation and packed output publication. It follows the contribution `X[83,114] × W[114,34]` into `U[83,34]` and reconnects it to all 4096 output channels.

The source is pinned to [`fc3276497f866bdad639cd443e75743f5d19b749`](https://github.com/DylanWaken/DLSS5-Pytorch/blob/fc3276497f866bdad639cd443e75743f5d19b749/csrc/kernel_impl/bottleneck_c1024_ffn/fp16/global_ffn_expand_c1024_fp16.cu). [source_audit.md](source_audit.md) records the numerical and instruction checks. The animation shows source dependency order, not measured GPU timing or physical register-bank placement. It uses visible captions and has no spoken audio.

## Chapters

1. A token enters the expansion
2. From model dimensions to CUDA blocks
3. A hierarchy of output tiles
4. A logical token becomes lane fragments
5. Compute the exact input address
6. Producer lanes move the packed slab
7. Shared memory: panels, banks, no XOR
8. The three-slot pipeline, in source order
9. B takes a different route and lane map
10. One product inside a warp-wide MMA
11. Reuse operands; keep the output live
12. The fused Half activation
13. Four words become one packed store
14. Finish the token and handle boundaries
15. Reconstruct the complete journey

The published transcript and `chapters.json` contain the times derived from the finished video clips.

## Install the isolated toolchain

From the repository root in PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File tools/kernel_video/setup.ps1
```

The script installs the pinned [requirements](requirements.txt) and portable MiKTeX in `$env:USERPROFILE\.cache\dlssnr-kernel-video`, separate from the project's training environment. It downloads from the official package/distribution services, configures missing TeX package installation, and renders a `MathTex` smoke test. It does not change the machine PATH or request registry integration. A working Python 3.11 or newer is needed to create the environment; the repository's `.venv\Scripts\python.exe` is the default base interpreter. To choose another interpreter or cache:

```powershell
powershell -ExecutionPolicy Bypass -File tools/kernel_video/setup.ps1 -BasePython C:\Python311\python.exe -RuntimeRoot C:\kernel-video-runtime
```

Official references: [Manim installation](https://docs.manim.community/en/stable/installation.html), [MiKTeX deployment](https://miktex.org/howto/deploy-miktex), [MiKTeX setup commands](https://docs.miktex.org/manual/miktexsetup.html).

## Preview, render, and assemble

Keep temporary media and the render working directory on the same drive. MiKTeX's Windows `dvisvgm` can fail when its DVI files and working directory are on different drives. `render.py` handles this by launching Manim from the cache directory and keeping media there; the Python source remains in the repository.

```powershell
$videoPython = Join-Path $env:USERPROFILE '.cache\dlssnr-kernel-video\venv\Scripts\python.exe'

# Fast final-frame review, without overwriting film timing metadata.
& $videoPython tools/kernel_video/render.py --preview

# Re-render one chapter or a range after an edit.
& $videoPython tools/kernel_video/render.py --render --chapters 7
& $videoPython tools/kernel_video/render.py --render --chapters 4-8

# Render all chapters at 1920×1080 and 30 fps, then assemble the publication.
& $videoPython tools/kernel_video/render.py --render --assemble --jobs 3

# Rebuild publication assets from existing full-resolution clips.
& $videoPython tools/kernel_video/render.py --assemble
```

`--chapters` also accepts comma-separated selections such as `1,4,9-11`. It only limits rendering or preview; assembly always requires the complete scene registry. Temporary outputs default to `CACHE/media`, scene timing JSON to `CACHE/metadata`, and isolated still previews to `CACHE/preview`. Use `--cache`, `--media-dir`, `--metadata-dir`, or `--output` to override those locations. The custom cache must contain the MiKTeX layout produced by `setup.ps1` (or an equivalent TeX toolchain must already be on PATH).

`--jobs 3` runs three scene processes concurrently. Each scene has its own media/TeX directory to avoid concurrent formula-cache writes. Render logs are in `CACHE/logs/`; preview logs are in `CACHE/preview/logs/`. The default is one worker. Rendering a chapter again replaces that chapter's clip and timing metadata.

The assembler uses FFmpeg bundled with `imageio-ffmpeg` to encode H.264 with `yuv420p`, CRF 22 and fast-start metadata. It verifies the 1080p/30 fps source clips and assembled duration and refuses to publish a film at or above 95 MiB. If the animation grows past that limit, review a higher CRF, for example `--assemble --crf 24`, before publishing. There is no audio stream. Runtime, TeX files and intermediate clips stay outside `docs`.

## Published artifacts

By default, assembly writes to `docs/kernel-guide/assets/video/`:

| File | Purpose |
| --- | --- |
| `fp16-c1024-ffn-expansion.mp4` | Browser-playable, full-resolution film |
| `poster.jpg` | Still from the tile hierarchy chapter |
| `captions.vtt` | Browser-accessible English caption track |
| `chapters.json` | Actual chapter start/end times, duration and source revision |
| `transcript.html` | Illustrated, timed transcript with an embedded player |
| `stills/*.jpg` | One representative frame per chapter |

Captions are burned into the animation and also emitted as WebVTT. Each chapter's cue clock is reconciled to that chapter's encoded MP4 duration, so small frame-rounding differences do not accumulate across the film. Large timing mismatches are rejected. The transcript's timestamps and stills seek within its player; the links also work as direct MP4 media fragments without JavaScript.

The FP16 expansion lesson embeds the video after introducing its model operation. To regenerate and check the documentation after assembly:

```powershell
.venv\Scripts\python.exe tools/build_kernel_docs.py
.venv\Scripts\python.exe tools/validate_kernel_docs.py
& $videoPython tools/kernel_video/verify_trace.py
& $videoPython tools/kernel_video/validate_video.py
```

`verify_trace.py` independently checks the film's lane maps and addresses against the repository's packing definitions. `validate_video.py` decodes every published frame and checks format, fast-start layout, caption order, chapter times and transcript resources. These checks do not launch or benchmark the CUDA kernel.

Review the animation, captions and transcript before committing generated files. Publication to GitHub Pages uses the repository's existing `docs` deployment workflow; `render.py` only creates local assets and does not commit or push.

## Editing the film

`ffn_expansion.py` defines the ordered `SCENES` registry. Every scene subclasses `LessonScene`, calls `beat(...)` for a captioned visual step, then calls `finish()` to emit timing metadata. Use the shared token and operand colors consistently. Preserve the distinction between A lane 13, B lane 9 and D lane 13 in the traced product; these are separate native operand maps. Shared input panels have no additional XOR swizzle in this kernel, and B goes directly from cached global loads into registers.

Review final-frame previews after geometry changes, then render the edited chapters and inspect their motion. Assembly extracts one final-state still per chapter, but that does not replace reviewing the intermediate transitions, moving token markers and caption readability.
