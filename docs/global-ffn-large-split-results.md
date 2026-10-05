# Large tiles with ordered split-K: v31 results

The private large-tile split reduces the measured FP8 global FFN contraction time at 1080p and 4K, but loses at 720p. It preserves the network's existing partition arithmetic while exposing more parallel work. These are component measurements against this project's implementations; they establish neither original-DLL speed nor the 85% hardware-utilization requirement.

The experiment uses real block 31 and block 38 checkpoint weights, batch 1, N=1024, K=4096 and the required partition size 1024. Input Geometry maps valid 1280×720, 1920×1080 and 3840×2160 to global fields 12×24, 20×32 and 36×60: M=288, 640 and 2160. The global stage has additional alignment, so simply halving the preceding field gives the wrong M.

The [raw FP8 comparison](../outputs/global_ffn_large_split_v31_all.json) measures automatic selection, every ordinary row-major variant 1–10, and the private candidate. Seven rounds include balanced shuffled forward/reverse orders. Every captured output is retained and compared before and after timing, a fresh ordered reference is recomputed afterward, and separate changed-input graphs poison their outputs before replay. Historical metadata counts three poisoned replays in fixture order0,1,2 after warming fixture0: there are two actual input changes. Operands remain immutable. A synthetic published skip is passed through real checkpoint W1 to prepare the resident cubic-activated/published input. This input and the half-scaled residual seed are prepared before the timed contraction.

| Input | Block | Fastest existing path | Existing µs | Large split µs | Existing / split |
|---|---:|---|---:|---:|---:|
|1280×720|31|auto|15.76|19.56|0.806×|
|1280×720|38|small split 3|15.52|19.42|0.799×|
|1920×1080|31|auto|31.23|20.88|1.495×|
|1920×1080|38|tile 9|31.31|20.87|1.500×|
|3840×2160|31|large chain 10|54.39|47.23|1.151×|
|3840×2160|38|large chain 10|54.38|47.51|1.145×|

The four larger cases clear the >3% gate in both order directions. The [earlier reversed five-path screen](../outputs/global_ffn_large_split_v31_reverse.json) independently has the same trend; it is not a second all-variant experiment. With the same packed E4 publication added to every path and both raw/published outputs retained, the [published comparison](../outputs/global_ffn_large_split_v31_published.json) still gains 1.468–1.478× at 1080p and 1.129–1.135× at 4K, and still loses at 720p.

The separate [FP16 all-variant comparison](../outputs/global_ffn_large_split_v31_fp16.json) clears the gate in all six cases: 1.033–1.053× at 720p, 1.561–1.589× at 1080p and 1.301–1.302× at 4K. The 720p margin is small. These FP16 results use the project's ordered FP16 reference, without an original-DLL FP16 claim.

The change keeps 128×128 output tiles but assigns one CTA to each of the four existing K partitions. Partition 0 starts with `half(published_skip * half(scale))`; later partitions start with zero. Each accumulator receives the same ascending K32 FP8 MMA steps (K16 for FP16). Unchanged half partials are then added as `(((partial0 + partial1) + partial2) + partial3)`, rounding each addition to half. The [source and compiled-order audit](../profile/gemm-large-split-sass-v31-cpu/REPORT.md) checks the seed predicate, fragment order and reused ordered reducer. There are no atomics or reassociated sums.

At 4K, the grid grows from 136 chained CTAs to 544 partial CTAs. FP8 registers fall from the earlier large chained kernel's 102 to 64; the private FP16 kernel uses 80. Both private kernels have 40,960 user shared bytes and no spills. The extra partial allocation is 17,694,720 bytes (16.875 MiB), with 35,389,440 logical bytes written and reread, plus a reducer launch. Logical traffic is not necessarily DRAM traffic. At 1080p the grid grows 40→160; at 720p 24→96. This tradeoff explains the experiment's motivation, while the timings determine where it actually helps.

Fresh NCU captures separate the partial GEMM from the reducer:

| Case / kernel | Tensor, elapsed | L2 data, elapsed | DRAM, elapsed | 85% gate |
|---|---:|---:|---:|---|
|1080p partial|22.49%|16.71%|18.97%|fail|
|1080p reducer|0%|11.23%|55.23%|fail|
|4K partial|46.66%|27.09%|19.77%|fail|
|4K reducer|0%|16.40%|78.74%|fail|

The [4K analysis](../profile/gemm-large-split-fp8-b31-m2160-20261003T092340_600370Z/ANALYSIS.md) and [1080p analysis](../profile/gemm-large-split-fp8-b31-m640-20261003T092436_609255Z/ANALYSIS.md) explain remaining scheduling and memory costs. The L2 column uses data-stage sectors, not aggregate request/tag throughput. Neither sampled peaks nor active-cycle percentages replace the elapsed-cycle gate. These cold kernel-replay measurements must not be added or compared to the resident component timings above.

Validation includes 59 GPU tests plus 19 CPU schedule tests, [59 memcheck cases with zero errors](../outputs/v31-large-split-memcheck.log), and [two mutated-capture racecheck cases with zero hazards](../outputs/v31-large-split-racecheck.log). Tails, seeded/unseeded paths, odd batches, offsets, special values and graph behavior are covered. The benchmark reports pin binary SHA-256 `19dbbc00c00544dd9300c9caf71a2fccfe4c5268e8494bda94262d1c964845cb` and their source/settings provenance. They do not themselves promote a production policy, prove an unmeasured resolution, or establish complete-network speed.
