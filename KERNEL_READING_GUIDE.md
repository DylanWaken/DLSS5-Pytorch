# Reading a deployment kernel

Open `csrc/kernel_impl/<export_name>.cu`. Each of the **81 exported kernels**
has its own source file, and its `extern "C" __global__` function contains the
actual storage, stage order, loops, synchronization and writebacks. There is no
separate `Run*` implementation behind a one-line exported wrapper.

For example, [window_block_c64_fp8.cu](../csrc/kernel_impl/window_block_c64_fp8.cu)
contains `window_block_c64_fp8(...)` itself. Its FP16 counterpart is
[window_block_c64_fp16.cu](../csrc/kernel_impl/window_block_c64_fp16.cu). The local
precision/channel constants select the recovered native profile; they do not
hide the operation in another function.

## Where to start

The following are concrete entry files. Other channel, precision and view
variants follow the same exact-export filename convention.

| Operation | Example entry file |
| --- | --- |
| Warp-local C32 window | [window_block_c32_fp8.cu](../csrc/kernel_impl/window_block_c32_fp8.cu) |
| Wider window with shared exchange | [window_block_c128_fp16.cu](../csrc/kernel_impl/window_block_c128_fp16.cu) |
| Physical input view | [window_block_c64_input_view_fp8.cu](../csrc/kernel_impl/window_block_c64_input_view_fp8.cu) |
| Fused window downsample | [window_block_c256_downsample_fp8.cu](../csrc/kernel_impl/window_block_c256_downsample_fp8.cu) |
| Fused window upsample | [window_block_c64_upsample_fp16.cu](../csrc/kernel_impl/window_block_c64_upsample_fp16.cu) |
| C512 FFN | [window_ffn_c512_fp8.cu](../csrc/kernel_impl/window_ffn_c512_fp8.cu) |
| C512 QKV/attention | [window_qkv_c512_fp16.cu](../csrc/kernel_impl/window_qkv_c512_fp16.cu) |
| C512 projection and pooling | [window_attention_projection_pool_c512_fp8.cu](../csrc/kernel_impl/window_attention_projection_pool_c512_fp8.cu) |
| C512 to C1024 projection | [channel_projection_c512_to_c1024_fp16.cu](../csrc/kernel_impl/channel_projection_c512_to_c1024_fp16.cu) |
| Global FFN expansion/contraction | [global_ffn_expand_c1024_fp8.cu](../csrc/kernel_impl/global_ffn_expand_c1024_fp8.cu), [global_ffn_contract_c1024_fp8.cu](../csrc/kernel_impl/global_ffn_contract_c1024_fp8.cu) |
| Global QKV and attention | [global_qkv_c1024_fp16.cu](../csrc/kernel_impl/global_qkv_c1024_fp16.cu), [global_attention_chained_c1024_fp16.cu](../csrc/kernel_impl/global_attention_chained_c1024_fp16.cu) |
| Global output projection | [global_projection_c1024_fp8.cu](../csrc/kernel_impl/global_projection_c1024_fp8.cu) |
| C1024 to C512 decoder | [decoder_upsample_c1024_to_c512_fp16.cu](../csrc/kernel_impl/decoder_upsample_c1024_to_c512_fp16.cu) |
| Input feature preparation and window | [input_preprocess_window_c32_fp8.cu](../csrc/kernel_impl/input_preprocess_window_c32_fp8.cu) |
| Output head and compositing | [output_window_postprocess_c32_fp16.cu](../csrc/kernel_impl/output_window_postprocess_c32_fp16.cu) |
| Global layout copy | [repack_2d_to_1d_c1024_fp8.cu](../csrc/kernel_impl/repack_2d_to_1d_c1024_fp8.cu) |
| Counter reset | [completion_counter_clear.cu](../csrc/kernel_impl/completion_counter_clear.cu) |

## Follow the data through the entry

For a window block, read the fragment/shared-storage declarations, input loads,
FFN loops, QKV normalization, attention and output projection in order. In fused
downsampling, that same global body then pools the captured Half output,
projects it and writes the downsampled field. In upsampling, the global body
first projects the low-resolution input and merges the skip, then executes the
window schedule and writes its output.

For a staged C512 or global GEMM, the global function also defines any small
local `LoadWeights`, `StageInput` or `WaitStage` lambdas. Their bodies keep
prefill/refill addressing and barrier accounting visible beside the reduction
loop. A local lambda is useful for repeated pipeline steps; it must not become
an anonymous wrapper around the whole kernel.

Parameter records and checked byte offsets are in
[kernel_abi.h](../csrc/kernel_impl/kernel_abi.h). Host launch geometry, plan
admission and C++ selection live in `kernel_launcher`; that directory contains
host code, not the device implementations.

## What remains shared

Shared headers contain substantial reused tensor arithmetic, physical-layout
maps, real storage/profile types and intrinsics. Examples include
`LinearWindow32`, normalization/softmax, expert GEMMs, packed Half reductions,
and fragment publication. FP8/FP16 profile pairs may share their record types
and constants without sharing a hidden whole-kernel owner.

The fragment interface is `MMA(...)` in [mma.cuh](../csrc/kernel_impl/mma.cuh).
Instruction-level assembly remains in
[intrinsics.cuh](../csrc/kernel_impl/intrinsics.cuh). Shared helpers must have
actual repeated users and preserve operand order, rounding, packing, cache and
synchronization contracts. A stage used only by one entry belongs in that
entry's file, normally in its global body.

## Validation status

The current layout has **81 CUDA compilation units and 25 shared headers**,
with ABI declarations in `kernel_impl` and host-only launchers. The portable
[source audit](global_entry_audit.json) records each entry's ownership and the
shared-helper review. The [validation receipt](global_entry_validation.json)
pins the successfully built candidate `aa207d37…`: compared with the preceding
build, 50/81 GPU instruction payloads, 72/81 decoded resource records and all
81 entry constant sections are identical.

Fresh measurements qualify this candidate in FP8 and FP16 at 720p, 1080p,
2K/1440p and 4K: all eight graph cases pass 74 native byte comparisons,
poisoned and changed-input replay, and the within-1% latency gate in each
execution order. The [paired measurements](figures/global_entry_deployment_measurements.json)
retain the samples and binary identities. The same validation receipt includes
70 CPU checks in each Python mode, native frontend/output-view fixtures and
24 C512 dispatcher cases.

The preceding canonical-function cleanup has a separate historical
[validation receipt](kernel_locality_validation.json) and
[source audit](kernel_locality_audit.json). Its 43/81 identical GPU instruction
payloads and successful four-resolution timing results describe that earlier
binary, not this per-entry-file migration. Older semantic and profiler records
remain historical evidence as well.

Deployment timing scope remains the batch-one prepared-feature trunk,
blocks 1–69, at four exact resolutions on SM120. That scope does not establish
full DLL/renderer host speed, every isolated kernel's speed, continuous
resolution support, other GPU support or an 85% hardware roofline.
