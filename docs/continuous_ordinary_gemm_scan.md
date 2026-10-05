# Continuous ordinary GEMM tuning

The deployment graph reaches matrix sizes that the old ordinary GEMM policy did not measure. For example, its global FFN contraction stops at M=640 even though the 4K graph reaches M=2160. Its C512 W1 and QKV policies stop at M=2160 while the 4K graph reaches M=8160. Nearest-anchor lookup correctly clamps these larger requests, but the old endpoint's kernel configuration may be a poor choice for them.

This scanner measures the existing kernel variants at the actual matrix sizes produced by the model. It does not add kernels or change arithmetic. Its default action is to write a CPU geometry manifest; GPU execution requires `--execute`.

## What is covered

The default input rectangle includes every integer width from 1280 through 3840 and every integer height from 720 through 2160. The model's actual padding and pooling rules reduce these 3,690,401 input pairs to 931 distinct geometries. The scanner derives 4,283 exact ordinary GEMM keys and 10,376 real-weight contracts across 15 families. These counts describe the requested domain, not completed GPU measurements.

The family key is precision, GEMM batch count, N, K, architectural partition, epilogue and weight layout; M varies within a family. Model batch is folded into M. This scan covers row-major packed-FP8 operands with raw Half output, epilogue 0 and layout 0.

| Role | Blocks | Matrix and partition | M source | Initial accumulator |
| --- | --- | --- | --- | --- |
| C512 W1 | 23–30, 40–47 | N512, K512, partition512 | Level4 | Zero |
| C512 QKV | 23–30, 40–47 | N1536, K512, partition512 | Level4 | Zero |
| Global FFN contraction | 31–38 | N1024, K4096, partition1024 | Level5 | Published block input × FFN scale, rounded to Half |
| Global QKV | 31–38 | N3072, K1024, partition512 | Level5 | Zero |
| Global projection | 31–38 | N1024, K1024, partition256 | Level5 | Published FFN state × attention scale, rounded to Half |
| Up39 contraction | 39 | N512, K1024, partition256 | Level5 | Zero |
| Down projections | 4, 8, 14, 22, 30 | N=2C, K=C, partition=K | Destination levels1–5 | Zero |
| Up projections | 48, 56, 62, 66 | N=C, K=2C, partition=K | Source levels4–1 | Zero |

At 4K, Level4 has M8160 and Level5 has M2160 for batch1. All requested shapes come from `Geometry`; these examples are not a substitute for its rules.

Global W1 activation, the C512 branch/group path and fused residual operations, attention, fused window blocks, Half adapters, the output head and the FP16 graph have separate contracts and are excluded. A full ordinary GEMM scan is not a full-network correctness or native-DLL performance sweep.

## What each measurement establishes

Every case uses its real checkpoint matrix and, where applicable, its real residual scale. The archive's matrix is transposed exactly as in the prepared model. Activations and published residual sources are deterministic synthetic fixtures: random, zero and higher amplitude. They are not captures of the actual upstream W1 or attention operation.

For a seeded operation, the harness independently computes the Half product of the unpacked published skip and its scale, checks that against deployed seed preparation, then supplies this seed as the initial accumulator. It preserves the architecture's Half partition accumulation. Up39 is unseeded; its later upsample-residual merge is outside this GEMM.

The comparison includes the current compiled dispatcher (variant0) and all existing variants1–10. Variant1 is the ascending ordered reference. The report records the diagnostic selector's resolved ID for variant0, its complete query and its compiled policy version. This is a selection prediction from the C++ diagnostic, not an observed kernel trace.

All variants are checked eagerly and after CUDA graph replay. Every captured call has a distinct retained output. All outputs are poisoned and checked after three changed-input replays; seeded cases change both the input and seed. Inputs, matrices, scales and seeds are checked for mutation. A fresh ordered reference is recomputed after timing and compared with the saved reference, then every output is checked again and replayed after another poison pass.

The timing scope is resident GEMM execution only. Matrix packing, seed preparation, fixture generation and correctness checks occur outside CUDA event timing. Every candidate uses the same captured call count. A combined output budget covers the retained Half outputs of all eleven graphs; it does not include inputs, references or internal scratch. Normal rounds use a deterministic shuffled candidate order, and reverse rounds invert the corresponding order. Reports retain individual timings and the order of every round.

## Running and resuming

The equivalent module entry point is shown below. The top-level CLI also exposes `gemm-deployment-range`.

```powershell
# CPU manifest only: no CUDA work.
python -m tuning.resolution_gemm_deployment --output-dir outputs/gemm-deployment-v30

# Bounded preflight within the full requested domain.
python -m tuning.resolution_gemm_deployment --execute --max-cases 66 --output-dir outputs/gemm-deployment-v30

# Continue the same journal, preserving all completed measurements.
python -m tuning.resolution_gemm_deployment --execute --output-dir outputs/gemm-deployment-v30

# Continue or perform a no-op resume, then write reviewable policy/header drafts.
python -m tuning.resolution_gemm_deployment --execute --export-drafts --output-dir outputs/gemm-deployment-v30
```

The traversal visits 4K, 1080p and 720p contracts first, then the remaining continuous domain. Within each geometry it visits the core roles before transitions. The first 66 physical contracts cover all 15 families at 4K. `--max-cases` limits only the current invocation; it does not narrow the requested manifest or change resume identity. `--core-only` does narrow the requested domain and therefore requires its own journal.

The SQLite journal commits one completed physical contract at a time; the JSON report is its human-readable export. Resume identity includes the full workload manifest, settings and seed, checkpoint manifest, driver, Torch/CUDA versions, GPU UUID, extension hash, compiled policy versions and relevant source files, including every saved GEMM device policy. Changes to these inputs require a new journal. The controller checks identity before and after each measurement, before committing it, and before the final export—even on a completed no-op resume.

## Safe policy export

Export initially accepts only families whose entire requested set of real-weight contracts has been measured. For each exact family/M key, a new variant must beat both the compiled dispatcher and ordered reference by more than 3% for every real-weight member and in both timing orders. Equivalent new candidates do not need a separate 3% margin against one another.

Every measured M gets an explicit anchor. A key with no eligible winner gets a guard retaining the resolved compiled variant. This matters because adding an M8160 endpoint could otherwise cause nearest-anchor lookup to select that new variant at a measured M6000 where it had lost. Variant0 is never emitted into the C++ policy.

The existing policy validator remains unchanged. If fresh timings cannot validate a retained guard—for example, its latency is noisily slower than the ordered baseline—the entire family remains unchanged. The exporter neither invents a timing nor silently substitutes another variant. It also checks the final merged policy's selection at every measured key. Existing anchors outside the requested M set and policies for other devices are preserved.

Runtime selection remains C++ nearest-M lookup, with lower-anchor tie breaking and endpoint configuration clamping. Tensor dimensions are unchanged. Intermediate or out-of-range shapes that inherit a configuration are configuration transfers, not measured speed claims. Export writes `gemm_sm_<sm>.json.draft` and `gemm_policy.h.draft`; it does not activate or compile them.

## Status and limits

The initial CPU validation covers geometry derivation, real checkpoint matrix/scale dimensions when the cached checkpoint is available, a checked-in direct-packed trace fixture, guard behavior, temporary policy/header export, nested correctness evidence, source/runtime/manifest drift before commit, and no-op resume identity checks. Cached checkpoint/profile integration checks skip cleanly when those local assets are absent.

GPU completion must be read from the specific journal's `coverage_progress`. A preflight is not a completed continuous sweep. Resident GEMM wins do not establish a full-model win, a native-DLL speed win, or the 85% hardware-throughput target. Those require subsequent prepared-model, native ABI and Nsight Compute measurements with the promoted binary.
