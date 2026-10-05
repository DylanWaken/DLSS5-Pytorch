# CUDA source layout

Deployment kernels are implemented as readable CUDA algorithms derived from the native PTX: named tensor tiles, fragment arrays, loops, pipelines and explicit publication layouts. Small exported wrappers select shared implementations by precision and configuration. Repeated network positions reuse those wrappers.

The exported roster contains **81 entries: 76 mathematical/frontend entries, four repack entries and one completion-counter clear**. The first 80 form 40 FP8/FP16 pairs. This counts ABI entry points, not independent algorithms or graph positions.

## Directory responsibilities

```text
csrc/
  kernel_impl/       CUDA algorithms, operation wrappers and shared device helpers
  kernel_launcher/  ABI records, launch geometry, graph plans and compiled selection
  torch_api/        PyTorch bindings and tensor-facing contracts
tests/              CPU, CUDA, graph and training checks
tuning/             Native profiles, measured policies and generated selection data
__init__.py         Minimal public Python entry points
run_tests.py        Test entry point
run_tuning.py       Offline tuning entry point
```

Kernel selection belongs in C++; Python does not select a different arithmetic implementation per call. A kernel's parameter ABI is declared once in `kernel_launcher/kernel_abi.h`, including size, alignment and offset assertions. There are no separate per-kernel ABI implementation files.

## Operation wrappers and shared algorithms

The `_fp8.cuh` and `_fp16.cuh` operation files group exported wrappers. Their shared implementation headers describe the computation, rather than repeating a complete body for every channel count or precision.

| Operation wrappers | Shared implementation and responsibilities |
| --- | --- |
| `window_block_fp8.cuh`, `window_block_fp16.cuh` | `warp_window32.cuh`, `warp_window_wide.cuh`, `window_view_io.cuh`: fused window FFN, QKV, attention and projection; physical input/output views |
| `downsample_fp8.cuh`, `downsample_fp16.cuh` | `window_downsample.cuh`, `window_pool.cuh`, `spatial_projection.cuh`: window pooling and projected downsample publication |
| `upsample_fp8.cuh`, `upsample_fp16.cuh` | `window_upsample.cuh`, `decoder.cuh`: residual upsample and C1024-to-C512 decoder |
| `attention_fp8.cuh`, `attention_fp16.cuh` | `window_qkv.cuh`, `global_qkv.cuh`, `global_attention.cuh`, `global_contract.cuh`: window/global attention stages and global projection |
| `ffn_fp8.cuh`, `ffn_fp16.cuh` | `window_ffn.cuh`, `global_ffn_expand.cuh`, `global_contract.cuh`: expansion, grouped MLP, contraction and split reduction |
| `projection_fp8.cuh`, `projection_fp16.cuh` | `channel_projection.cuh`: C512-to-C1024 channel projection |
| `frontend_fp8.cuh`, `frontend_fp16.cuh` | `input_features.cuh`, `window_preprocess.cuh`, `postprocess.cuh`, `composite.cuh`, `frontend_math.cuh`: feature preparation, output head and texture/surface processing |
| `repack_fp8.cuh`, `repack_fp16.cuh` | `global_repack_layout.cuh`: both physical layout-copy directions, parameterized by precision |
| `completion_counter_clear.cuh` | Shared precision-independent counter reset |

All 76 mathematical/frontend exports now use the semantic implementations in this table. The four repack entries share a layout-copy implementation, and the counter clear remains one precision-independent entry. The active implementation contains no register-transcript fallback. Development proposals and historical proof receipts remain under `outputs/semantic-rewrite`.

## Current source inventory

The final source tree contains **45 headers and 7,953 physical lines** in `kernel_impl`, including comments and blank lines:

| Source role | Headers | Lines |
| --- | ---: | ---: |
| Operation/precision entry wrappers | 16 | 1,658 |
| Shared operation and physical-layout algorithms | 21 | 5,422 |
| Common device utilities listed below | 7 | 857 |
| Precision-independent counter clear | 1 | 16 |
| Total | 45 | 7,953 |

The 21 algorithm headers serve multiple configurations; the largest has 579 lines. The structural inventory resolves all local includes and finds **81 exports in 17 entry headers, each owned by exactly one of ten CUDA emission units**. These counts describe the current production dependencies, not archived proposals or a count of network positions.

## Profiles represent real schedule differences

C32 window attention is warp-local. C64/C128/C256 use CTA shared-memory exchange and different channel tiles. They share the wider-window algorithm through compile-time dimensions and profiles; view, downsample and upsample policies provide the appropriate reads, residuals and publication. These policies must preserve bounds, singleton-dimension broadcast, fragment order and synchronization.

C512 stages are separately launched FFN, QKV and projection operations. FP8 and FP16 can have different warp counts, K-step sizes and copy transactions. C1024 stages use global token layouts, split reductions and completion counters. Global contraction and attention projection share a tile/pipeline implementation through a profile; global QKV reuses its input pipeline and tile-consumption helper. Global attention has its own streaming K/V algorithm.

A new template parameter is justified by a real dimension, layout or scheduling choice. It must remove shared logic; wrapping two complete scalar transcripts in `if constexpr` does not accomplish that. Likewise, pooling, input views and output views should specialize their data access or epilogue without duplicating the entire network block.

The [historical per-entry census](kernel_schedule_census.json) preserves recovered symbols, original launch profiles and static transcript counts. Those counts describe the earlier source, not the current loop bodies or dynamic GPU instruction counts.

## Device utilities

| Header | Contract |
| --- | --- |
| `intrinsics.cuh` | Short force-inlined PTX wrappers: tensor instructions, conversions, shuffles, async copies, barriers, counters and texture/surface instructions |
| `mma.cuh`, `tiled_mma.cuh` | Named tensor-core fragment interfaces and shared accumulation loops; FP8 K32 and FP16 K16 instruction selection |
| `packed_math.cuh` | Packed Half arithmetic, conversion, publication and activation helpers |
| `numerical_constants.cuh` | Named `CONST_*` bit patterns with decoded values and documented arithmetic roles |
| `memoryops.cuh` | Shared pipeline barrier arrival and phase waiting |
| `kernel_helpers.cuh` | Common typed ABI and device-utility includes |

Operation headers carry the algorithm; `intrinsics.cuh` carries the instruction-level exception needed to express it exactly. Unused transcript-era helpers and their unused headers have been removed; the table lists the seven common device utility headers that remain. Keeping a primitive shared does not justify merging different Half reduction trees, cache policies or synchronization contracts.

## Launch plans and resolution policies

Original configurations remain in the launcher dispatch tables, generated deployment plans and geometry tables. `tuning/plan[_fp16]_W_H.json` records native symbols, launch dimensions, buffers and ABI bindings. Operation-based CUDA translation units emit each entry once; large groups compile their precisions separately.

Template coverage does not establish runtime support. A measured resolution policy must be backed by recorded measurements and correctness tests. The existing four admitted SM120 plans do not establish continuous-resolution tuning, arbitrary channels, or support on another architecture. Source organization and unmeasured templates add no such qualification.

## Final compiled qualification

The integrated extension passes exact comparison at all **74 prepared-feature trunk boundaries**, poisoned replay and changed-input replay for FP8 and FP16 at 1280 × 720, 1920 × 1080, 2560 × 1440 and 3840 × 2160. The [portable graph qualification](semantic_graph_qualification.json) records the tested extension, harness, schedule and native cubin hashes.

All eight precision/resolution combinations meet the **candidate/native median latency ratio ≤ 1.01 in both execution orders**. [Portable timing data](figures/semantic_deployment_measurements.json) retain the 64 alternating pairs per combination and the precise protocol. This qualification covers batch-one prepared-feature blocks 1–69 on SM120, excluding renderer input/output stages and DLL host overhead. It is an integrated graph result, not a claim that every individual kernel meets 1% or that the hardware roofline has been reached.

[Portable optimization evidence](semantic_optimization_evidence.json) preserves the separate NCU, SASS and isolated timing comparisons. Source readability, compiled correctness and measured speed remain separate checks; see [the conventions and qualification details](CODE_READABILITY.md).

## Inspect the current tree

```powershell
python -B tools/kernel_sources.py --output outputs/kernel-sources.json
python run_tests.py cpu --optimized
```

The inventory follows includes and exported names, checks that local includes resolve, and rejects duplicate exports or missing/duplicate CUDA emission owners. `--baseline-csrc <saved-csrc>` also compares the exported roster. These are structural checks; compiled correctness and performance are separate evidence.

See [code conventions and current validation scope](CODE_READABILITY.md). The earlier transcript cleanup and its timings remain unchanged in [the historical readability report](CODE_READABILITY_HISTORY.md); final semantic qualification is recorded separately above.

The [semantic naming audit](NAMING_AUDIT.md) covers the current typed ABI, named generated-plan fields and manual variable-role review. Its rebuild preserves all 81 GPU instruction payloads and separately revalidates the changed host packing.
