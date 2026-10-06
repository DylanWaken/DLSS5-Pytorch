# Reading a deployment kernel

There are **81 logical kernels in 56 CUDA source files**: 40 configurations share
15 full-body global templates; 41 retain direct entries. Start with the
[template manifest](../csrc/kernel_impl/common/kernel_templates.json) when a
logical name no longer has an exact-name file. It gives the owning source,
compile-time arguments and host address resolver.

Every authored body is a real `__global__` definition showing storage, pipeline,
loops, barriers and stores. Templates specialize at compile time; they do not
forward the algorithm to a hidden `Run*` function.

## Where to start

| Operation | Owning source |
| --- | --- |
| C32 ordinary/input-view | [window_block_compact_fp8.cu](../csrc/kernel_impl/fp8/window_block_compact_fp8.cu) |
| C64 ordinary/input/output-view | [window_block_two_warp_fp8.cu](../csrc/kernel_impl/fp8/window_block_two_warp_fp8.cu) |
| C128/C256 windows and views | [window_block_wide_fp16.cu](../csrc/kernel_impl/fp16/window_block_wide_fp16.cu) |
| C32 output-view exception | [window_block_c32_output_view_fp8.cu](../csrc/kernel_impl/fp8/window_block_c32_output_view_fp8.cu) |
| Wide fused downsample | [window_block_wide_downsample_fp8.cu](../csrc/kernel_impl/fp8/window_block_wide_downsample_fp8.cu) |
| Wide fused upsample | [window_block_wide_upsample_fp16.cu](../csrc/kernel_impl/fp16/window_block_wide_upsample_fp16.cu) |
| C64 fused upsample | [window_block_c64_upsample_fp16.cu](../csrc/kernel_impl/fp16/window_block_c64_upsample_fp16.cu) |
| C512 FFN | [window_ffn_c512_fp8.cu](../csrc/kernel_impl/fp8/window_ffn_c512_fp8.cu) |
| C512 QKV/attention | [window_qkv_c512_fp16.cu](../csrc/kernel_impl/fp16/window_qkv_c512_fp16.cu) |
| C512 plain attention/FFN projection | [spatial_projection_fp8.cu](../csrc/kernel_impl/fp8/spatial_projection_fp8.cu) |
| C512 projection with pooling | [window_attention_projection_pool_c512_fp8.cu](../csrc/kernel_impl/fp8/window_attention_projection_pool_c512_fp8.cu) |
| Encoder channel projection | [channel_projection_c512_to_c1024_fp16.cu](../csrc/kernel_impl/fp16/channel_projection_c512_to_c1024_fp16.cu) |
| Global FFN expansion | [global_ffn_expand_c1024_fp8.cu](../csrc/kernel_impl/fp8/global_ffn_expand_c1024_fp8.cu) |
| FP8 global contraction/projection | [global_contract_fp8.cu](../csrc/kernel_impl/fp8/global_contract_fp8.cu) |
| Global QKV and attention | [global_qkv_c1024_fp16.cu](../csrc/kernel_impl/fp16/global_qkv_c1024_fp16.cu), [global_attention_chained_c1024_fp16.cu](../csrc/kernel_impl/fp16/global_attention_chained_c1024_fp16.cu) |
| Decoder upsample | [decoder_upsample_c1024_to_c512_fp16.cu](../csrc/kernel_impl/fp16/decoder_upsample_c1024_to_c512_fp16.cu) |
| Input preparation/window | [input_preprocess_window_c32_fp8.cu](../csrc/kernel_impl/fp8/input_preprocess_window_c32_fp8.cu) |
| Output head/compositing | [output_window_postprocess_c32_fp16.cu](../csrc/kernel_impl/fp16/output_window_postprocess_c32_fp16.cu) |
| Layout copies | [repack_spatial_to_token.cu](../csrc/kernel_impl/common/repack_spatial_to_token.cu), [repack_token_to_spatial.cu](../csrc/kernel_impl/common/repack_token_to_spatial.cu) |
| Counter reset | [completion_counter_clear.cu](../csrc/kernel_impl/common/completion_counter_clear.cu) |

Precision directories remain separate; shared repacks emit both precisions from
`common/`. FP16 global contraction/projection retain distinct direct bodies.

## Follow the data

Read storage declarations, physical loads, FFN, QKV normalization, attention and
projection in order. C32 is warp-local; C64 uses two-warp token ownership;
C128/C256 exchange channel panels through shared memory. Their separate global
schedules keep these distinctions visible.

A downsample body then pools raw Half results, projects and publishes them.
An upsample body first projects low-resolution input and merges the skip with
native rounding, then runs its window. Local `LoadWeights`, `StageInput` and
`WaitStage` lambdas show repeated pipeline calculations beside the reduction.

Template parameters select channels, layouts and register caps at compile time.
Read the explicit resolver instantiations at the bottom to see supported
configurations. Resolvers only return registered function addresses; policy and
launch work remain in host launchers.

## Interfaces and primitives

[kernel_abi.h](../csrc/kernel_impl/common/kernel_abi.h) owns records and checked
offsets, plus host aliases/resolver declarations. The
[symbol map](../csrc/kernel_launcher/kernel_symbols.cpp) preserves logical names.
`torch.ops.dlssnr.kernel_symbol(name)` returns the actual CUDA symbol for Driver
tools; do not guess the template's mangled spelling.

Shared headers hold reused tensor math, layouts and profiles.
[mma.cuh](../csrc/kernel_impl/common/mma.cuh) provides `MMA(...)`;
[intrinsics.cuh](../csrc/kernel_impl/common/intrinsics.cuh) contains assembly.
Keep rounding, packing, cache and synchronization contracts. One-use stages
belong in the owning global body.

## Qualification

Use [template integration validation](template_integration_validation.json)
for the normal extension's identities and completed checks.
[The feasibility audit](KERNEL_TEMPLATE_FEASIBILITY.md) records the preceding
isolated-cubin experiment. The [81-file audit](global_entry_audit.json),
[validation](global_entry_validation.json) and
[paired measurements](figures/global_entry_deployment_measurements.json) remain
historical results for that earlier binary. Source organization does not extend
SM120 prepared-feature-trunk evidence to complete renderer host work, continuous
resolutions, other GPUs or an 85% hardware roofline.
