# Reading a deployment kernel

Start with the canonical function below. It contains the operation's storage,
loop structure, pipeline and output handling. FP8/FP16 exports in the operation
wrapper headers select the ABI type and compile-time profile; they share these
implementations rather than duplicating whole kernels.

| Export family | Main function and source |
| --- | --- |
| C32 fused window, including views | `RunWindow32` in [warp_window32.cuh](../csrc/kernel_impl/warp_window32.cuh) |
| C64/C128/C256 fused window, including views | `RunWindowWide` in [warp_window_wide.cuh](../csrc/kernel_impl/warp_window_wide.cuh) |
| Fused window downsample | `RunWindowDownsample` in [window_downsample.cuh](../csrc/kernel_impl/window_downsample.cuh) |
| Fused window upsample | `RunWindowUpsample` in [window_upsample.cuh](../csrc/kernel_impl/window_upsample.cuh) |
| C512 FFN | `RunWindowFfn` in [window_ffn.cuh](../csrc/kernel_impl/window_ffn.cuh) |
| C512 QKV/attention | `RunWindowQkv` in [window_qkv.cuh](../csrc/kernel_impl/window_qkv.cuh) |
| C512 projection, views and pooling | `RunSpatialProjection` in [spatial_projection.cuh](../csrc/kernel_impl/spatial_projection.cuh) |
| C512→C1024 projection | `RunChannelProjection` in [channel_projection.cuh](../csrc/kernel_impl/channel_projection.cuh) |
| Global FFN expansion | `RunGlobalFfnExpand` in [global_ffn_expand.cuh](../csrc/kernel_impl/global_ffn_expand.cuh) |
| Global FFN contraction and attention projection | `RunGlobalContract` in [global_contract.cuh](../csrc/kernel_impl/global_contract.cuh) |
| Global QKV | `RunGlobalQkv` in [global_qkv.cuh](../csrc/kernel_impl/global_qkv.cuh) |
| Global attention | `RunGlobalAttention` in [global_attention.cuh](../csrc/kernel_impl/global_attention.cuh) |
| C1024→C512 decoder | `RunDecoder` in [decoder.cuh](../csrc/kernel_impl/decoder.cuh) |
| Preprocessing, with optional downsample | `RunPreprocess` in [window_preprocess.cuh](../csrc/kernel_impl/window_preprocess.cuh) |
| Output head and compositing | `RunPostprocess` in [postprocess.cuh](../csrc/kernel_impl/postprocess.cuh) |
| Global layout copies | `CopyGlobalRepackWords` in [global_repack_layout.cuh](../csrc/kernel_impl/global_repack_layout.cuh) |
| Counter reset | `completion_counter_clear` in [completion_counter_clear.cuh](../csrc/kernel_impl/completion_counter_clear.cuh) |

Pipeline helpers that belong to just one operation are local to its main
function. Repeated copy/refill sequences use local lambdas where necessary, so
their address calculation, zero fill and barrier accounting remain visible.
The same applies to split-reduction publication and operation-specific stores.

Some large pieces remain shared deliberately:

- Window computation is reused by ordinary blocks, views, sampling and frontend
  fusions. Those callers own any shared slab whose lifetime spans multiple stages.
- Tensor-fragment arithmetic, normalization, softmax and packing keep their
  native rounding/operand contracts in common helpers.
- Layout policies and per-tile frontend callbacks preserve the original order
  between window computation and output-head work. They are not separate kernel
  launches or a second inference path.
- Intrinsics remain in `intrinsics.cuh`; named profile constants and data types
  stay beside the algorithm that consumes them.

Future refactors should preserve this reading order. The criterion is whether
the operation's dataflow and schedule are visible in its main body, not whether
every mathematical primitive has been pasted into every precision variant.

## Validation

This refactor keeps all 81 exports and their launch contracts. It removes the
obsolete `composite.cuh` and moves operation-specific orchestration into the
canonical bodies above. The [source audit](kernel_locality_audit.json) records
the moved stages, storage ownership and retained helpers with their users.

The normal extension was rebuilt and tested on an RTX PRO 6000 Blackwell
(SM120). Against the preceding storage-prefix build, 43 of 81 GPU instruction
payloads and 71 resource records remain identical; all ten modules' constant
payloads and extents remain identical. The 38 changed instruction payloads are
qualified by fresh numerical and performance measurements, not by a claim of
compiled equivalence.

- 62 CPU checks pass both normally and with Python optimization enabled.
- FP8 and FP16 pass all 74 native graph boundaries at 720p, 1080p, 1440p and
  4K, including poisoned and changed-input replay.
- All eight timing cases pass the 1% limit in both execution orders. The worst
  order median is a 0.750% slowdown (FP8, 1080p).
- All 24 C512 public-dispatch cases pass, comparing Torch launches with direct
  Driver launches of the same candidate kernels.
- FP8 and FP16 postprocessing each pass 24 native-comparison cases, including
  border and immutable-buffer checks.

The [validation receipt](kernel_locality_validation.json) pins source, binary,
module and harness hashes, raw graph timings and worker completion. The C512
harness now verifies candidate extension/module hashes instead of requiring
unchanged instructions from an earlier release; its first rejected prelaunch
attempt is retained in the receipt. The qualified binary is installed locally.
See [benchmark results](BENCHMARKS.md) for the refreshed charts.

Timing covers the batch-one prepared-feature trunk, blocks 1–69, at four exact
resolutions. It does not time renderer stages or full DLL host execution, prove
every isolated kernel's speed, establish continuous-resolution or other-GPU
support, or measure a hardware roofline. This readability pass adds no new
Nsight captures; earlier optimization evidence remains historical.
