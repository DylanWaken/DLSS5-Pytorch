# Vector loads for the ordered split-K reducer

The v34 vector reducer improves isolated reduction at every measured anchor. The complete contraction clears the 3% gate only for FP8 at the two 4K checkpoint blocks, both with raw half output and with packed publication. It remains a private experiment: these measurements do not establish native-DLL speed, an exhaustive candidate comparison, or the 85% hardware gate.

The motivation came from the [v31 4K profile](../profile/gemm-large-split-fp8-b31-m2160-20261003T092340_600370Z/ANALYSIS.md). The existing reducer loaded individual halves, packed pairs with `PRMT`, and spent most sampled stalls on global-load dependencies. NCU reported 50% excessive theoretical sectors and 78.739% elapsed DRAM utilization. Vectorizing those accesses tests a specific explanation for that overhead while preserving partition arithmetic.

The private `_ordered_partition_reduce(partial, variant=2)` accepts contiguous CUDA `Half[B,P,M,N]`, with 1-32 partitions. Each vector thread owns eight adjacent output halves within one batch. It loads partition 0 unchanged, then adds partitions 1 through P-1 in order through four independent half2 accumulators. Eligible layouts use one 16-byte load per partition and one 16-byte store. If `M*N` is not divisible by eight or either pointer lacks 16-byte alignment, the launcher uses the unchanged scalar reducer. Grid-tail threads return before accessing memory.

The [kernel](../csrc/kernel_impl/ordered_reduce_vector.cuh), [launcher](../csrc/kernel_launcher/ordered_reduce_vector.cu), and [API](../csrc/torch_api/ordered_reduce_vector.cpp) are installed as private operators in v34. The new [pipeline launcher](../csrc/kernel_launcher/gemm_large_split_vector.cu) exposes the actual partial buffer and allows either reducer after the same partial GEMM. A scoped rename gives that otherwise unchanged GEMM a unique compiled symbol. The existing public policy and `_gemm_large_split` entry point are unchanged.

The [CPU SASS audit](../profile/ordered-reducer-vector-sass-v34-cpu/REPORT.md) confirms a unique SM120 vector reducer with 40 registers, zero local/stack/shared allocation, and 128-bit global loads and stores. The older reducer uses 48 registers. The compiler emits both `HADD2` and exact-one `HFMA2` operations along the ordered accumulator chains. Register counts and instruction widths do not establish achieved occupancy or bandwidth. Numerical tests, rather than this instruction audit, cover NaN payload behavior.

## Resident measurements

The [raw-output report](../outputs/ordered_reduce_vector_v34.json) contains 12 cases: blocks 31 and 38, FP8 and FP16, and three actual geometries. The [packed-publication report](../outputs/ordered_reduce_vector_v34_published.json) repeats the six FP8 cases with the same final E4M3 publication on every compared path. Both reports are complete and byte exact.

| Valid image | Actual global H x W | M | Raw FP8 speedup, blocks 31 / 38 | Published FP8 speedup, blocks 31 / 38 | Raw FP16 speedup, blocks 31 / 38 |
|---|---|---:|---:|---:|---:|
| 1280x720 | 12x24 | 288 | 0.793x / 0.788x | 0.803x / 0.799x | 1.003x / 1.002x |
| 1920x1080 | 20x32 | 640 | 1.035x / 1.030x | 1.028x / 1.031x | 1.016x / 1.016x |
| 3840x2160 | 36x60 | 2160 | **1.039x / 1.039x** | **1.036x / 1.041x** | 1.019x / 1.019x |

Each ratio divides the fastest measured incumbent's median by the vector pipeline's median. A ratio above one means faster. The gate additionally requires more than 3% improvement in both balanced timing orders. Consequently, neither 1080p FP8 result passes, despite some aggregate medians rounding to or above 1.03. Only the four bold 4K FP8 cases pass the complete-contraction gate.

At 4K, raw FP8 contraction falls from 47.228-47.271 us to 45.459-45.488 us. With publication it falls from 48.959-49.309 us to 47.236-47.363 us. The isolated raw reducer improves from 5.415-5.426 us to 3.621-3.703 us for those FP8 fixtures, a 1.462-1.498x speedup. Across all raw fixtures its aggregate improvement ranges from 1.051x to 1.498x; all isolated-reducer cases pass the two-order gate. In the published report, the reducer group includes publication and still passes all six cases, with aggregate speedups of 1.038-1.345x.

The complete comparison contains seven paths: the existing private pipeline, the same new partial helper with the scalar reducer, the vector pipeline, automatic public selection, and explicit public variants 3, 10 and 11. This is not every available GEMM variant. At 720p FP8, a smaller-tile incumbent is substantially faster than either large-tile pipeline, so a reducer-only improvement cannot justify selecting the large tile there. FP16 spends more of the complete interval in GEMM, diluting the reduction saving.

The [benchmark](../tuning/benchmark_ordered_reduce_vector.py) uses real checkpoint W1/W2 weights and half scales. Three synthetic published-skip fixtures feed baseline W1 expansion, cubic activation/publication and the actual split contraction. Every partial is checked against an independent partition GEMM before ordered reduction. Graph timing excludes allocation, capture, fixture preparation and W1; it includes all GPU kernels and scratch accesses in the contraction, plus publication when requested. The old launcher allocates output before partials; the new helper allocates partials before output. Its scalar peer controls for that difference.

Seven rounds contain both shuffled forward and reverse orders. Every captured output is retained and checked after initial replay and after timing. Separate mutation checks visit fixtures **1, 2, 0** after initial fixture 0, assert three actual input changes, poison all three retained outputs, and check each replay against the preserved reference. Weights and guarded inputs remain compared with immutable snapshots, and a fresh ordered oracle runs after timing. These are resident CUDA-event measurements and must not be mixed with cold NCU times.

## Verification and provenance

The [CPU schedule proof](../tools/vector_reduce_schedule.py) covers 1,640 small layouts, 256 pointer-residue combinations, real-size boundary vectors and deliberately wrong order/stride/ownership/alignment variants. Its 18 tests and the 12 benchmark CPU tests pass. The 82 new GPU cases cover half encodings, ordered cancellation, guards, offsets, tails, batches, validation and graph replay. The broader [v34 focused run](../outputs/v34-private-tests.log) passed 273 tests with two skips; the same [memcheck run](../outputs/v34-private-memcheck.log) reported zero errors. Four mutated pipeline graph cases passed [racecheck](../outputs/v34-vector-racecheck.log) with zero hazards.

Both reports pin binary `213910ee7ad5a786064594b69109ab030f2284c47db0938142c41db9e7af9dc6`, RTX PRO 6000 Blackwell SM120, CUDA 12.8 and driver 610.62. Raw report SHA256: `aceae08c95339065a1b4515fb25b9aaff5f176e88b2448ee128c70a46b0c84d3`. Published report SHA256: `c78a080f0681a7fbd0ac1d8eb76c751161d6cb741e2d0ebd2c47612ff98ebbd4`. The reports preserve source hashes, checkpoint identity, timing samples and capture evidence.

The partial-buffer allocation and two-launch structure remain. The [fresh exact-symbol NCU profile](../profile/gemm-large-split-vector-fp8-b31-m2160-20261003T102031_055272Z/ANALYSIS.md) confirms zero excessive theoretical reducer sectors, compared with the earlier scalar mapping's 50%. The reducer reaches 81.4327% elapsed DRAM throughput and the partial GEMM 46.7351% elapsed tensor utilization; both remain below 85%. Cold per-kernel replay timings remain separate from the resident measurements above.
