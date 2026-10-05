# DLSS-NR graph and operator contract

This is the actual network reconstructed by [OpenDLSS-NR](https://github.com/maanHimself/OpenDLSS-NR) as represented by the vendored source at `third_party/OpenDLSS-NR/src/nr_graph.cpp`, `src/nr_model.cpp`, and `docs/numerics.md`. The vendored repository's remote and revision are the source of truth for provenance. Layout and graph adaptations retain its MIT attribution (Copyright (c) 2026 maan); see `third_party/OpenDLSS-NR/LICENSE` and `NOTICE`.

**Current validation:** all 153 records from the original 310.8.0 checkpoint load with stage SHA-256 verification; all 71 numbered graph entries decode. Actual weights have passed forward and surrogate-backward tests for every block family and a complete graph forward/backward run. Full native-output parity and the requested performance gates are separate checks and are not established by these tests. The reference backend uses ordinary PyTorch GEMM reductions, so it is not an exact arithmetic oracle.

Targeted native comparisons now include the original unchanged SM120 QKV and global-attention kernels. Blocks 31 and 38, each with zero, random-amplitude-0.5 and random-amplitude-4 inputs, produced exact matches for **14,155,776 Q/K/V bytes** over 32/96/640 tokens and **4,521,984 global-attention bytes** over the real 96/640-token bottleneck sizes. Allocation guards remained intact; the global-attention reports also verify unchanged input bytes. The source reports are `outputs/vendor_qkv_sm120.json`, `vendor_qkv_m96.json`, `vendor_qkv_m640.json`, `vendor_attention_m96.json` and `vendor_attention_m640.json`; they retain kernel/binary hashes and per-buffer comparisons. See [the native-stage harness](vendor_runtime.md). These comparisons cover FP8 stages on SM120 and do not establish full-network/native-runtime parity.

Resident original five-stage global-block replay subsequently matched all seven intermediate boundaries and the prepared block output for blocks 31/38 at 96/640 tokens: **15,073,280 intermediate bytes** in `outputs/vendor_global_block_m96.json` and `vendor_global_block_m640.json`. Native window comparisons also matched **360 cases / 9,904,128 bytes** across complete C32/64/128/256 blocks and C512 QKV-attention, all four shifts, two checkpoint blocks per channel family, three input amplitudes, and 8x8/16x16/8x12 geometry (`outputs/vendor_window_8.json`, `vendor_window_16.json`, `vendor_window_8x12.json`). These remain scoped native block tests; they do not replace a complete 71-entry runtime capture.

## Graph

Input is float32 `[batch, padded_height, padded_width, 16]` for deployment. Floating training also accepts bfloat16 features. Output is float32 `[batch, padded_height, padded_width, 4]`: RGB residual and temporal logit. Dimensions use the native padding rule in `Geometry.from_valid(width,height)`, including the unusual extra width alignment. Geometry must be supplied or calculated from the original valid size; padded size alone is ambiguous.

| Blocks | Spatial level | Channels | Computation |
|---|---|---:|---|
| 0 | full field | 32 | f16 16→32 adapter, dense FFN, window attention |
| 1–4 | 0 | 32 | dense 32→128→32 FFN |
| 5–8 | 1 | 64 | two 64→128→32 paths, 64→64 contraction |
| 9–14 | 2 | 128 | four 128→128→32 paths, 128→128 contraction |
| 15–22 | 3 | 256 | eight 256→128→32 paths, 256→256 contraction |
| 23–30 | 4 | 512 | 512→512, eight 64→256→64 branches, 512→512 contraction |
| 31–38 | 5 | 1024 | dense 1024→4096→1024 FFN, global attention |
| 39 | 4 | 512 | **transition only:** 1024→512 projection, upsample, scaled encoder skip |
| 40–47 | 4 | 512 | split branch blocks |
| 48–55 | 3 | 256 | parallel path blocks; first includes transition |
| 56–61 | 2 | 128 | parallel path blocks; first includes transition |
| 62–65 | 1 | 64 | parallel path blocks; first includes transition |
| 66–69 | 0 | 32 | dense blocks; first includes transition |
| 70 | full field | 32 | post blend, dense block, f16 32→4 head |

There are no convolutions, layer norms, GELUs, routing gates, or generic Swin blocks in this graph. All paths run for each token. Each residual block runs FFN **before** attention. Heads have 32 channels. The 8x8 window grid cycles origins `(0,0),(-4,-4),(-4,0),(0,-4)`; decoder phases continue the same level's encoder counter. Out-of-field keys/values are zero but still contribute their prior-dependent exponential to the denominator.

## Individual operations

| Operation | Inputs and output | Arithmetic contract |
|---|---|---|
| Publish / pack / unpack | floating activation ↔ E4M3 bytes | round to f16 first, RNE E4M3FN, saturate ±448, NaN→+0, preserve signed zero |
| Ordered FP8 linear | `x[...,K]`, `weight[N,K]`, optional seed | E4M3 MMA with f16 accumulator; residual seeds the chain |
| Input/output adapter | f16 matrices | native f16 MMA chain, half accumulator, widen published head to f32 |
| Native cubic SiLU | half values | bounded cubic with individually rounded half FMAs; not `torch.nn.functional.silu` |
| Scaled residual | activation, skip, per-channel scale | half product for seeded GEMM; one half FMA for upsample skip merge |
| Cosine Q/K normalize | head vectors of 32 | low/high square pair, stride 8/4/2/1 half sum tree, squared-norm floor 6.198883056640625e-5, f32 rsqrt rounded half |
| Window partition/reverse | BHWC and phase | zero pad at shifted edges, 8x8 windows, physical 4x4-tiled key order |
| Window score / value GEMM | Q/K/V and `[heads,64,64]` prior | prior seeds score accumulator; P is normalized and E4M3-published before PV |
| Special exponential | half score | half-affine bit reinterpretation, separate window/global constants, no max subtraction |
| Softmax sum64 | physical ordered keys | fixed pair/add tree, denominator floor 6.198883056640625e-5 before half reciprocal |
| Global attention | coarsest tokens | pad K/V to 64, unnormalized E4M3 exponentials for PV, subtract padding correction then normalize value accumulator |
| Box pool | raw half BHWC | `((a+b)+(c+d))*0.25`, round each half operation, zero extra aligned rows/columns |
| Upsample | BHWC | nearest 2x, crop to the encoder level |
| Post blend | low-resolution state, block-0 state, two scale vectors | half multiply then half FMA |
| Compose | head, sRGB proxy, optional reprojected history | clipped RGB residual `/4`; learned blend-scale times sigmoid logit |

The following split-K lengths are mathematical requirements, not tunable choices: global FFN contraction 1024, global QKV 512, global output projection 256, and block-39 up-projection 256. The first partial chain starts from the scaled residual seed; later partials start from zero. Published half partials are reduced in partition order. Other FP8 GEMMs are unsplit. This ordering follows the executable `gemmFp8Element` implementation, resolving the upstream prose's ambiguous description of zero-initialized partitions.

## Checkpoint loading

`WeightArchive(directory)` expects `manifest.json` and `model/<stage.file>` exactly as OpenDLSS-NR. It validates the 71-block/153-name schema, eleven unique stages, SHA-256 hashes, lengths, duplicate records, record-name consistency, slice bounds, path containment, and overlapping slices. Matrix unpacking removes the native within-32 channel rotation once at load. Attention priors decode to natural queries and physical keys. Model weights are stored as contiguous `[N,K]` matrices (batched for parallel paths) for the native API.

Eight `block31..38.layer3.layer` two-byte records are intentionally not executed, matching the reference graph. `block70.layer0.blend_scale` is used by `compose`. No executable checkpoint serialization is loaded and no DLL is executed by this reader.

## Use and precision

```python
import torch
from dlssnr import DLSSNR
from dlssnr.geometry import Geometry

geometry = Geometry.from_valid(512, 512)
model = DLSSNR.from_directory("assets/nr", device="cuda",
                             precision="fp8", backend="reference")
# Supply externally prepared 16-lane features covering the padded field.
features = torch.zeros(1, geometry.full_height, geometry.full_width, 16,
                       device="cuda", dtype=torch.float32, requires_grad=True)
head = model(features, geometry=geometry)
head.square().mean().backward()
```

`backend="extension"` uses registered C++/CUDA operators. Kernel architecture/launch variant selection stays in C++; this Python option selects implementation for validation. Native `normalize32`, `exp_weight`, and `sum64` operators implement the attention arithmetic; ordered linear and batched GEMM operators handle its matrix products. Importing or loading the reference model does not compile an extension. `precision="fp8"` reproduces publication locations; `precision="fp16"` replaces E4M3 publications with half precision and thus changes the checkpoint's forward function. FP16 is useful on Ampere and newer GPUs, and is not a claim of native FP8 parity.

Training forward has two explicit floating modes; see [training configuration and dtype audit](training.md). `precision="fp32"` uses FP32 matrix operands and activations; `precision="bf16"` uses BF16 matrix operands/activations with FP32 master weights by default. Both modes compute normalization, probability sums, reciprocal and exponential in FP32, and return an FP32 head. They accept FP32 or BF16 input features. Explicit matrix precision takes precedence over ambient autocast. `trainable=True` registers decoded weights as parameters and defaults to `precision="fp32"`; nontrainable models default to `"fp8"`. Explicit precision always overrides that default.

```python
model = DLSSNR.from_directory("assets/nr", device="cuda", backend="extension",
                             trainable=True, precision="bf16", dtype=torch.float32)
# FP32 master parameters remain trainable; matmul operands are BF16.
head = model(features, geometry=geometry)
head.square().mean().backward()
```

Floating training preserves the 71-entry graph and weights but intentionally changes deployment arithmetic. It removes all binary16/E4M3 publications, replaces ordered half-accumulator chains with ordinary floating matrix multiplication, uses standard L2 normalization with norm epsilon `1e-12`, and differentiates the native cubic polynomial without its rounding. The discontinuous bit-affine exponential becomes the continuous function `exp0 * exp((clamp(a*score+b,lo,hi)-b)*shift*ln(2))`, with the original half-valued constants; `exp0` is `0.025390625` for windows and `0.083984375` globally. These are differentiable training functions, not a claim of numerical equality with quantized inference. Global padding correction and normalization ordering remain part of the graph.

For deployment/QAT, working storage is a separate choice: `dtype=torch.float16` or `dtype=torch.float32` (the default). Input features and head remain FP32. The general forward stores published values in that floating storage and packs operands for GEMMs. The prepared inference path described below caches packed weights and fuses attention and complete C32 residual blocks. Activations between blocks still use half storage. Floating training accepts FP32/BF16 storage and rejects FP16 storage, including a later `.half()` conversion detected before forward. FP32 master parameters are recommended for BF16 training.

Explicit `precision="fp8"` or `"fp16"` with `trainable=True` selects quantization-aware surrogate training. Master weights are republished for GEMMs and rounding uses a straight-through estimator. Bit-affine exponential uses a smooth exponential surrogate derivative inside the clamped region, zero outside. Cubic activation differentiates the continuous polynomial with publication derivatives treated as identity. These are not exact derivatives of discrete quantization, which would be zero almost everywhere. Native and reference deployment normalization use a continuous L2 surrogate with the native squared-norm floor. Below the floor, including zero vectors, its derivative is the constant inverse square root of that floor. The forward still follows the half reduction tree and publications. This floor is supported by the original DLL PTX and corrects the earlier zero-only OpenDLSS-NR transcription. Half-published reciprocals clamp their denominator to the same native floor before reciprocal, including global padding-correction cancellation. Their VJP is evaluated in FP32 and is zero below the floor, avoiding overflow and NaNs from invalid small denominators. Floating FP32/BF16 training retains its ordinary FP32 reciprocal.

## Prepared deployment

Current complete C32 fusion and v7 network timing are summarized in
[C32 deployment evidence](block32.md).

```python
# Training retains ordinary ATen autograd and independent FP32 master weights.
head = training_model.forward_train(features, geometry=geometry)
# Prepare outside CUDA Graph capture, then reuse the returned frozen snapshot.
deployed = training_model.prepare_inference(precision="fp8", device="cuda")
head = deployed.forward_inference(features, geometry=geometry)
```

`prepare_inference` creates an independent module with frozen buffers and half working storage; the source parameters and optimizer state remain untouched. FP8 matrix weights are packed into persistent uint8 buffers once. Input/output adapters retain FP16 weights. Use `precision="fp16"` for the FP16 deployment path. Both `deployed(...)` and `deployed.forward_inference(...)` disable autograd. Prepare a fresh snapshot after training updates; calling `train()` on the frozen snapshot is an error.

Parallel FFN branches are evaluated with grouped matrix calls, preserving per-branch accumulation order and publication points. FFN expansion matrix calls include cubic activation and publication in their epilogue; the ordinary training/reference paths retain the original composed operations. Standalone cubic-plus-publication remains available for operator tests. Window attention for channels below 1024 uses a fused kernel covering Q/K normalization, half/E4M3 publication, shifted windows, prior-seeded scores, the native exponential/reduction tree and value mixing. Global 1024-channel attention uses a separate fused kernel that processes ascending 64-key tiles, retains its PV accumulator across tiles, and preserves ordered denominator accumulation and padded-key correction. Kernel dispatch remains in C++.

Complete 32-channel residual blocks use `inference_block32`: one CTA per shifted 8x8 window computes FFN expansion/cubic, contraction, QKV, attention and residual projection. It retains the raw FFN residual in shared memory and returns both raw and published outputs, preserving the special caller-provided raw skip in blocks 0/66/70. Static shared memory is 31,872 bytes for FP8 or 42,112 bytes for FP16. Contiguous offset views are realigned only when their pointers lack the four-byte alignment required by word loads. Input/output adapters and inter-level transitions remain separate operators.

The v16 source adds `inference_window_block_experts` for complete FP8 C64,
C128 and C256 windows. It accepts canonical packed matrix weights, half scales
and biases, and half or packed-byte BHWC state. It returns the requested
half/byte publication plus a raw half tensor, or an empty half tensor when no
consumer needs raw output. Kernel selection is entirely in C++: measured SM120
anchors use the fused window; unmeasured devices use ordered constituent
operators. FP16 blocks continue to use the existing half operator composition.
The prepared graph requests raw output only for blocks0/4/8/14/22/30/70.
An explicit private composed entry point remains available for independent
benchmarks after public model routing changes. All wider-window residual
projections seed from the published FFN, unlike C32's raw FFN rule.

`tests/test_inference.py` compares grouped GEMMs, matrix-activation epilogues and all half-pattern activations against the unfused deployment operations. Its full-model tests compare all 77 intermediate boundaries and the head exactly against the existing deployment path at valid 33x33 and 512x512 sizes, then capture and replay a CUDA Graph. `tests/test_window_inference.py` covers window phases, edge padding, multiple heads, zero norms and capture. `tests/test_global_inference.py` covers both precisions, 32/96/640-token geometry, tiny norms, batch two and capture. The global fusion passed 18 focused cases and four full-model equality/capture cases before the subsequent true-half-FMA normalization correction (`outputs/global-inference-tests.xml`, `outputs/prepared-global-full-tests.xml`). Each arithmetic correction still requires a fresh validation run. This is equivalence to this implementation's established deployment arithmetic, not a claim of equality to the original DLL.

The subsequent v7 build includes true-half-FMA normalization and complete C32 fusion. It passed all 50 C32 focused cases, including both precisions, four phases, irregular/tiny geometry, real checkpoint blocks 0/1/66/70, raw residuals, offset views and graph replay (`outputs/block32-inference-tests.xml`). After enabling the prepared C32 route, all four full-network comparisons passed again at all 77 boundaries and the head with CUDA Graph replay (`outputs/prepared-block32-full-tests.xml`).

`return_boundaries=True` returns 77 named tensors: all numbered block outputs plus six encoder transitions. Upstream native captures compare 75: omit block 70 and transition 30→31 when adapting those fixtures. Captures are for localization; production-schedule parity must be checked separately.

The caller supplies proxy conversion, Gaussian feature injection, mirroring, conditioning, motion reprojection, and recurrent history. The network interface deliberately starts at the same prepared 16-lane tensor as upstream's graph. `compose` accepts already reprojected history; it does not estimate motion.

## Tests and remaining gates

`python -m pytest tests/test_model.py -q` checks native geometry examples, continued phases, independently packed fragment fixtures, malformed archives, signed-zero/NaN publication, all 65,536 half patterns against the independent upstream binary numerical fixture, global exponential golden values, pooling, all real checkpoint decodes and each block family's input/parameter backward paths. Real-weight tests skip explicitly if the checkpoint is unavailable. Set `DLSSNR_WEIGHTS` to another extracted directory. Set `DLSSNR_FULL_MODEL_TEST=1` for complete forward/backward and CUDA Graph capture/replay tests for both backends, both precisions, and both working storage dtypes, plus complete trainable-parameter backward for all four extension precisions. Floating FP32/BF16 tests use FP32 master parameters and verify every used parameter gradient is finite and nonzero; BF16 additionally supplies BF16 features. `tests/test_training_contract.py` audits dispatched arithmetic to reject FP16/float8 conversions during floating training, including attention normalization and probability reductions. Every captured boundary must be finite and replay must equal the uncaptured output.

The general extension forward (before prepared deployment) was timed on an RTX PRO 6000 Blackwell Workstation Edition (SM120), batch 1, half working storage, with two warmups and seven CUDA-event samples per case. Median forward times:

| Precision | Valid region | Padded field | Eager | CUDA Graph replay |
|---|---|---|---:|---:|
| FP8 | 33x33 | 320x320 | 69.457 ms | 13.107 ms |
| FP8 | 512x512 | 576x512 | 64.195 ms | 16.701 ms |
| FP16 | 33x33 | 320x320 | 48.479 ms | 19.765 ms |
| FP16 | 512x512 | 576x512 | 50.200 ms | 24.215 ms |

All four heads were finite and graph replay exactly matched eager execution. Raw samples, host timings and memory measurements are saved in `outputs/model_sm120.json`; regenerate with `python tests/benchmark_model.py`. Eager times include GPU idle gaps caused by Python dispatch; graph replay removes those gaps. These measurements have no official DLL baseline and do not establish the 85% roofline or native-speed gate. Independent native captures and a comparable official benchmark remain required.

Prepared deployment with cached weights, grouped branches, fused activation and fused window attention, still using the baseline GEMM variant, measured:

| Precision | Padded field | Eager | CUDA Graph replay |
|---|---|---:|---:|
| FP8 | 320x320 | 16.153 ms | 5.826 ms |
| FP8 | 576x512 | 17.010 ms | 7.909 ms |
| FP16 | 320x320 | 14.299 ms | 10.110 ms |
| FP16 | 576x512 | 16.642 ms | 13.535 ms |

These use the same batch size and sampling counts. `outputs/model_prepared_sm120.json` records the device UUID, driver, extension SHA-256, compiled policy version, packed weight size and raw measurements; use `python tests/benchmark_model.py --prepared --output outputs/model_prepared_sm120.json` to repeat. The prepared full-model checks passed exact equality at all 77 boundaries and the head for both precisions, plus CUDA Graph replay (`outputs/prepared-inference-tests.xml`). The FP8 profile in `profile/network-fp8-prepared-20261002T210227_779218Z` identifies 374 standalone GEMM launches and 62 fused window-attention launches; profiling attribution carries overhead and is not the timing protocol above.

The prepared measurements above were collected before the original-DLL norm/denominator-floor corrections were integrated. They remain a historical optimization comparison with their recorded binary hash; regenerate correctness and timing reports after that arithmetic correction before treating them as the current build's results.

Prepared FFN expansion uses `inference_linear_activation` and `inference_group_linear_activation`; global attention is also fused. These have passed the scoped and complete-graph comparisons described above, but their new measurements must retain the matching binary and policy identifiers before superseding historical timings. Floating training still uses the same ATen matrix, cubic and autograd composition.

After the training entry-point/FFN refactor, `outputs/floating-training-regression.xml` records 46 passing training/operator/contract tests on the pre-epilogue-fusion binary. These include complete FP32/BF16 forward/backward, finite nonzero input and parameter gradients, dtype audits, and CUDA Graph replay. Deployment fusion changes do not alter that floating training path.

### C32 fusion measurement

`outputs/block32_sm120.json` compares one real checkpoint block 1 using the prepared operator composition against complete C32 fusion, with three warmups and eleven CUDA-event samples per CUDA Graph. Both raw and published outputs matched bitwise. Measurements use the v7 binary, recorded by SHA-256, and are block timings rather than a complete network or original-runtime benchmark.

| Precision | Field HxW | Separate prepared operators | Fused C32 | Speedup |
|---|---|---:|---:|---:|
| FP8 | 320x320 | 0.100864 ms | 0.045632 ms | 2.210x |
| FP8 | 512x576 | 0.254912 ms | 0.114944 ms | 2.218x |
| FP16 | 320x320 | 0.103232 ms | 0.068384 ms | 1.510x |
| FP16 | 512x576 | 0.258528 ms | 0.168352 ms | 1.536x |

Reproduce with `python tests/benchmark_block32.py`; repeated `--shape H,W` arguments select additional field sizes. The report includes device UUID, driver, extension hash, compiled policies and individual samples. These speedups establish neither the original DLL speed gate nor 85% hardware throughput.
