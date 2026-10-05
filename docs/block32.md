# C32 fusion and v7 deployment measurements

Prepared inference now executes each complete 32-channel residual block in one
CUDA kernel. On the tested SM120 GPU, this reduced the measured block time by
about 2.2x for FP8 and 1.5x for FP16. The complete prepared graph remains exact
against the separate deployment operators at all 77 tested boundaries. Neither
the 85% hardware-throughput gate nor complete original-runtime parity has been
established.

## Implementation

`inference_block32` takes half BHWC state and raw skip tensors, four row-major
matrices, the two residual scales, head scale, attention prior and shift phase.
Weights are persistent E4M3 bytes for FP8 or half values for FP16; C++ selects
the arithmetic from the matrix dtype. The operator returns both published and
raw half outputs. Its implementation is split across:

- `csrc/kernel_impl/block32.cuh`: ordered MMA and shared-memory dataflow.
- `csrc/kernel_launcher/block32.cu`: shape/type/device validation, alignment,
  current-stream launch and output allocation.
- `csrc/torch_api/block32.cpp`: dispatcher schema and inference-only contract.

One 128-thread CTA owns a shifted 8x8 window. It computes FFN expansion,
native cubic activation and publication, residual-seeded FFN contraction,
QKV, normalized window attention and residual-seeded projection. The raw FFN
result stays in shared memory until projection; replacing it with the published
result would change C32 arithmetic. The caller also preserves the special raw
skip used by blocks 0, 66 and 70. Adapters, output head and inter-level transitions
remain separate operators.

The CTA uses 31,872 bytes of shared memory for FP8 or 42,112 bytes for FP16.
Nonoverlapping stage lifetimes share buffers, and barriers protect each reuse.
All four shifts, partial edge windows and batch dimensions are supported.
Contiguous views with unaligned offsets are copied only when four-byte alignment
is required for matrix-word or half2 loads. Ordinary prepared buffers are already
aligned. Floating FP32/BF16 training continues to use the existing ATen operators.

## Exactness checks

The v7 build passed **50 focused C32 tests** in
`outputs/block32-inference-tests.xml`: FP8/FP16, all four phases, aligned and
irregular edges, batch two, tiny geometry, zero/tiny inputs, residual-only cases,
real checkpoint blocks 0/1/66/70, offset views, rejected invalid contracts and
CUDA Graph capture/replay. Both raw and published outputs are compared bitwise
against the separate operator sequence.

After enabling the prepared route, **four full-network tests** passed in
`outputs/prepared-block32-full-tests.xml`: both deployment precisions at valid
33x33 and 512x512, all 77 boundaries, FP32 head and CUDA Graph replay. These
checks include the native squared-norm/denominator floors and true-half-FMA norm
correction. They compare to this implementation's independent operator path.
Scoped original-kernel comparisons are documented separately in
[native validation](vendor_runtime.md); full NGX runtime parity remains open.

## Block timing

`outputs/block32_sm120.json` measures real checkpoint block 1, phase 1, batch
one, with three warmups and eleven CUDA-event samples per captured graph.
The baseline is the prepared operator composition, including fused attention
and matrix-activation epilogues. Both outputs remained bitwise exact.

| Precision | Field WxH | Separate operators | Complete C32 fusion | Speedup |
|---|---|---:|---:|---:|
| FP8 | 320x320 | 0.100864 ms | 0.045632 ms | 2.210x |
| FP8 | 576x512 | 0.254912 ms | 0.114944 ms | 2.218x |
| FP16 | 320x320 | 0.103232 ms | 0.068384 ms | 1.510x |
| FP16 | 576x512 | 0.258528 ms | 0.168352 ms | 1.536x |

Reproduce with `python tests/benchmark_block32.py`. Its `--shape H,W` arguments
are repeatable. Timings are for one block, not the complete network or original
DLL implementation.

## Complete v7 network timing

The same binary's prepared network measured the following CUDA Graph replay
medians in `outputs/model_prepared_v7.json`. This uses half working storage,
batch one, two warmups and seven samples per case. All six heads were finite and
graph replay matched eager execution exactly.

| Precision | Valid WxH | Padded field WxH | Graph replay |
|---|---|---|---:|
| FP8 | 512x512 | 576x512 | 4.522 ms |
| FP8 | 1920x1080 | 1920x1152 | 16.479 ms |
| FP8 | 3840x2160 | 3840x2176 | 70.278 ms |
| FP16 | 512x512 | 576x512 | 5.084 ms |
| FP16 | 1920x1080 | 1920x1152 | 19.662 ms |
| FP16 | 3840x2160 | 3840x2176 | 83.045 ms |

Hardware is RTX PRO 6000 Blackwell Workstation Edition, SM120, driver 610.62;
PyTorch 2.8.0+cu128 and CUDA 12.8. Binary SHA-256 is
`46a1c78676691bf65644f4c630d4e01943381d3cdb7cba32ee0eae3c71b46217`,
unary policy `7cf1e6730fc51a96`, GEMM policy `84fc9149d68c2ace`. Reports retain
device UUID, individual measurements and metadata timestamps. These numbers
include several deployment optimizations, so they do not isolate the effect of
C32 fusion. No comparable complete official-runtime baseline was provided by
these measurements.

## Profiling

```powershell
.\.venv\Scripts\python.exe run_tuning.py block-profile --height 512 --width 576 --phase 1 --precision fp8
```

`block-profile` loads an unchanged real checkpoint block, creates deterministic
synthetic state and raw skip values, warms the operator, then brackets exactly
one fused kernel with CUDA profiler start/stop. It creates a fresh `profile/`
run with the binary and source snapshots, checkpoint-manifest hash, full NCU
collection with available PM sampling sections, source counters, per-PC stalls,
SASS and structured metrics parsed through `ncu_report`. Missing PM sections
are recorded explicitly. Use `--height 1152 --width 1920` for the full 1080p
padded field or `--height 2176 --width 3840` for 4K. Run profiling with exclusive
GPU access; profiler timings are separate from CUDA Graph latency measurements.
