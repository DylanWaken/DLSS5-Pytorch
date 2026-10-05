# Model assets and validation provenance

The original DLSS-NR 310.8.0.0 runtime and its embedded model were obtained and
verified on 2026-10-03. The DLL has not been loaded or executed. Asset downloads,
weights, reference images, and vendor device code live under ignored `assets/`.

## Original runtime and weights

The public [RankFTW release](https://github.com/RankFTW/rhi-repo/releases/tag/dlssnr-310.8.0)
contains the original runtime. The downloaded archive matched its GitHub release
digest. The DLL matched the independently documented
[original runtime hash](https://huggingface.co/inarikami/dlss5-nr-reverse-engineering).
Windows `Get-AuthenticodeSignature` returned `Valid`, with signer
`CN=NVIDIA Corporation, OU=1005bk6, O=NVIDIA Corporation, L=Santa Clara, S=California, C=US`
and certificate thumbprint `7B7B0B6697AFB438CF6F65A155F00E86676FB186`.

| Artifact | Bytes | SHA-256 |
| --- | ---: | --- |
| `nvngx_dlssnr_310.8.0.zip` | 109,425,288 | `388c0a7912e15ec911b9c9e11a692142b11fe387ddf2b637d8c358138fffb3ac` |
| `nvngx_dlssnr.dll` | 165,840,496 | `e16bcf15e16e13f527491cdf7845b2fe6521a738d8f7c9c721866a8496e1fc8e` |
| PE resource `10/WEIGHTS_HT/1033` | 147,695,410 | `836f445d06ecd2e59bb9f17b84b91c143396fd76ccda1c9dc7fe81d5edd548f4` |

The resource begins at DLL file offset 18,129,248. Static extraction validated
every record boundary and produced `assets/nr/manifest.json`: 153 records across
71 blocks, grouped into 11 stages, containing 147,683,778 payload bytes. Each
stage and each original record has a SHA-256 in the generated manifest. Packed
bytes are preserved; extraction does not reinterpret them as floating-point
arrays or claim to recover an original training checkpoint.

Stage paths follow the actual OpenDLSS-NR loader: `model_directory / "model" /
stage["file"]`. For example, `file: "stages/encoder32.bin"` resolves to
`assets/nr/model/stages/encoder32.bin`.

From the repository root, the standard-library tool reproduces the acquisition:

```powershell
python tools/extract_assets.py download-runtime assets/original
python tools/extract_assets.py extract-model assets/original/nvngx_dlssnr.dll assets/nr
```

Downloads are pinned by size and SHA-256. The extractor refuses an unrecognized
DLL before writing model files. It accepts only safe paths within the chosen
output directory, rejects an existing artifact with different contents, and
allows identical repeated extraction. It never calls a DLL entry point.

The checked [OpenDLSS-NR revision](https://github.com/maanHimself/OpenDLSS-NR/tree/9d08f4184bbcb9d858e2fb7a7834ec0837a9d2f1)
contains implementation code, not model weights or native boundary captures.
Its only branch was `main`, no releases were present, and inspection of the
initial commit also found no cached weights. The browser server's `/weights`
route serves a local directory selected by `NR_WEIGHTS`; it is not a public
download service. Its `web/fixtures/numerics.bin` is a Vulkan-generated arithmetic
fixture, not an original NVIDIA inference capture.

## Public image references

`assets/reference_pngs/` contains three full-resolution input/output PNG pairs
published by [DLSSNR-AMD](https://github.com/mochizuki0323/DLSSNR-AMD/tree/82560c4fbfaac347fc5e22c22025191402ae916b/docs/ngx-verification),
pinned to commit `82560c4fbfaac347fc5e22c22025191402ae916b`:
1920x1080, 2560x1440, and 3840x2160. Local hashes are recorded in
`provenance.json`; the reproducible tool writes `download_manifest.json` and
checks the same hashes before accepting a downloaded file.

```powershell
python tools/extract_assets.py download-references assets/reference_pngs
```

The source documents execution of the unmodified DLL through NGX on an RTX 5090.
Settings are intensity 1, style 0, local tone 1, local structure 1, skin structure
-1, auto mask 1; motion is zero, depth is constant, and history resets each frame.
These are community-published final 8-bit RGB captures. They provide an image
comparison target, but contain neither FP8 internal boundaries nor the f32 head.
No original 75-boundary fixture was located in the checked public repositories.

## Vendor PTX and SASS inspection

Seven embedded NR fatbinary bundles were extracted from the verified DLL without
execution, yielding 223 PTX entry points and matching `sm_120` cubins. The PTX
version is 9.4. Eight additional utility bundles use a different header format
and are outside this extractor's scope.

```powershell
# Cubin/fatbin extraction works without a Zstandard package.
python tools/extract_assets.py extract-modules assets/original/nvngx_dlssnr.dll assets/vendor_modules
# Also extract compressed PTX with Python 3.14's standard-library Zstandard.
python tools/extract_assets.py extract-modules assets/original/nvngx_dlssnr.dll assets/vendor_modules_ptx --ptx
cuobjdump --dump-resource-usage --dump-sass assets/vendor_modules/module_0.cubin > assets/vendor_modules/module_0.sass.txt
```

The current workspace already has PTX, cubin, fatbin, and SASS files for all seven
modules in `assets/vendor_modules/`; `manifest.json` and
`extraction_manifest.json` preserve source hashes and file offsets. `cuobjdump`
13.4 successfully disassembled all seven cubins. It did not discover device code
when pointed directly at the DLL, so static bundle extraction was necessary.

Inspection found `QMMA.16832.F16.E4M3.E4M3` for FP8 dot products and
`cvt.rn.satfinite.e4m3x2.f16x2` publication in PTX. Thus the forward arithmetic
needs half accumulators and explicit FP8 publication points. An FP32-accumulating
GEMM does not implement the same rounding sequence. The original ViT expansion
uses asynchronous bulk global-to-shared copies with mbarriers, a 24,576-byte
shared input array, and three 8-byte copy barriers. Original resource usage:

| Kernel | Registers/thread | Static shared bytes | Local bytes |
| --- | ---: | ---: | ---: |
| `cc_vit_1d_ffn_expand_fp8` | 139 | 25,624 | 0 |
| `cc_vit_1d_ffn_contract_fp8` | 157 | 17,424 | 0 |
| `cc_vit_1d_qkv_fp8` | 163 | 9,232 | 0 |
| `cc_vit_1d_projection_fp8` | 148 | 9,232 | 0 |

The expanded input storage and three barriers are evidence for pipelining;
their impact on throughput still requires device profiling. The published
[OpenDLSS-NR numerical contract](https://github.com/maanHimself/OpenDLSS-NR/blob/9d08f4184bbcb9d858e2fb7a7834ec0837a9d2f1/docs/numerics.md)
also fixes the order of half reductions, residual seeding, and ViT split-K
partitions. Kernel tuning must preserve those boundaries.

The Ada CPU oracle's internal 16-product FP8 and 8-product FP16 grouping must
not be assumed to specify Blackwell. The original `sm_120` SASS contains
`QMMA.16832.F16.E4M3.E4M3` and `HMMA.16816.F16`, with no software conversion
between subgroups inside each instruction. NVIDIA's
[MMA specification](https://docs.nvidia.com/cuda/parallel-thread-execution/#warp-level-matrix-instructions-mma)
leaves internal accumulation order and rounding unspecified. An independent
[Blackwell FFN comparison](https://huggingface.co/inarikami/dlss5-nr-reverse-engineering/blob/main/docs/nr-numerical-validation.md)
reports that a 32-product/one-half-rounding reference matched the original ViT
FFN expansion in 24 trials, totaling 4,751,360 FP8 outputs. That evidence is
limited to the reported kernel, inputs, and final FP8 values; it does not prove
that every half intermediate or every operator matches that model. A mismatch
against the Ada oracle therefore requires device-specific investigation before
labeling either tensor-core output or the oracle incorrect.

No same-device end-to-end NVIDIA timing has been measured. Static SASS, public
RTX 5090 PNGs, and OpenDLSS-NR's published RTX 4070 SUPER timings cannot establish
the requested official-speed gate on this machine's RTX PRO 6000 Blackwell.
That gate requires a local NGX/D3D12 host with the verified runtime, identical
input/geometry/conditioning, GPU timing around evaluation after warmup, and
runtime/GPU/driver hashes recorded with the measurements. A direct microkernel
replay would establish only that kernel's timing, not full-runtime parity.

The original ViT FFN expansion kernel has now been replayed on this GPU through
the CUDA Driver API, with exact comparison against our extension and matched
stage timings. See [vendor_runtime.md](vendor_runtime.md) for the launch ABI,
31,129,600 byte-exact outputs, measured performance gap, and reproduction tool.

Asset validation tests run without Torch, CUDA, or network access:

```powershell
python -m unittest discover -s tests -p test_assets.py -v
```
