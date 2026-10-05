# C512 W1: the larger tile helps at 4K, but regresses smaller inputs

Selecting existing GEMM variant10 **only for W1** improved the complete public
C512 block by **1.091–1.096× at the 4K anchor**, across blocks 23, 47 and 30.
That is an 8.36–8.72% reduction in block latency. The same choice was slower
at 720p and 1080p, so it must not replace the current W1 choice at every size.

The [complete measurement](../outputs/c512_w1_paired_v30.json) finished all nine
requested contracts. All output, raw-output, changed-input graph and input/weight
immutability checks passed. The aggregate nine-case performance gate is correctly
**false**: only the three M8160 cases meet the full-block improvement gate.

| Valid input | C512 field | Block | Raw output | Compiled baseline | W1 variant10 | Baseline/candidate | >3% gate in both orders |
| --- | --- | ---: | --- | ---: | ---: | ---: | --- |
| 1280×720 | 24×44, M1056 | 23 | No | 42.666 us | 46.596 us | 0.916× | Fail |
| 1280×720 | 24×44, M1056 | 47 | No | 42.768 us | 46.502 us | 0.920× | Fail |
| 1280×720 | 24×44, M1056 | 30 | Yes | 42.300 us | 46.370 us | 0.912× | Fail |
| 1920×1080 | 36×60, M2160 | 23 | No | 55.130 us | 56.836 us | 0.970× | Fail |
| 1920×1080 | 36×60, M2160 | 47 | No | 55.560 us | 57.062 us | 0.974× | Fail |
| 1920×1080 | 36×60, M2160 | 30 | Yes | 55.570 us | 57.542 us | 0.966× | Fail |
| 3840×2160 | 68×120, M8160 | 23 | No | 129.208 us | 117.940 us | 1.096× | Pass |
| 3840×2160 | 68×120, M8160 | 47 | No | 128.448 us | 117.706 us | 1.091× | Pass |
| 3840×2160 | 68×120, M8160 | 30 | Yes | 129.894 us | 118.701 us | 1.094× | Pass |

Times are medians per **complete public block**, including W1 publication,
branches, W4 with its residual seed, QKV, attention and final residual projection.
Both graphs use the same block object, real checkpoint weights and input storage.
The candidate's offline intercept changes W1 only; QKV, branch, residual and
attention keep their compiled choices. Capture audit records show the W1 override
returning to zero before QKV. This benchmark changes no production policy.

For the 4K cases, speedups also hold independently in each timing order:

| Block | Baseline then candidate | Candidate then baseline |
| ---: | ---: | ---: |
| 23 | 1.0943× | 1.0973× |
| 47 | 1.0900× | 1.0914× |
| 30 | 1.0924× | 1.0966× |

Each case uses eleven pairs in each order, shuffled with a recorded seed.
CUDA events time graph replay only. Both graphs retain and check every output
from every captured call. There are eight calls per graph except the 4K raw-output
block 30 case, which uses five to respect the combined 128 MiB output budget.
Each captured graph is replayed before reading its outputs. After timing, a fresh
ordered reference is checked; three input fixtures are then copied into the same
captured input and every retained output is poisoned and rechecked. Final input
and prepared-weight bytes remain unchanged.

The independent reference composes separate ordered dense/group GEMMs with the
original Half seed and E4 publication points. Attention is shared with the public
candidate. Inputs are deterministic synthetic published states and weights are
real; this is not a replay of full-network upstream activations. It establishes
a bounded C512 component result, not DLL parity, full-network speedup, sanitizer
coverage or an 85% roofline result. The three anchors do not establish the best
switch point at intermediate M values.

The result supports measuring W1 across the continuous row range, retaining the
small-tile choice where it wins and exporting the large-tile choice only where
the real-weight/common-variant gate passes. Any compiled-policy update requires
fresh whole-trunk native comparison under its own binary and journal identity.

Evidence is archived under
[the paired run](../profile/c512-w1-paired-public-v10-20261003T084207_930876Z/REPORT.md).
The measured device is the RTX PRO 6000 Blackwell SM120. Exact identities:

```text
Extension SHA256: de9ea93be1d9801e8934cf57a0ff498d300230b3aa0dbabe80e806ed97f24c33
Source manifest:   ecd35aec3cdae7b89aef17b884256d06771b45f2e0e43418bffffa1e528c9169
GEMM policy:       ec70c084051c4c3e
Residual policy:   61acd20342d20301
Branch policy:     23e446b1701f31ab
Cached policy:     86bfe65380016080
```
