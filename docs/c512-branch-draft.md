# C512 branch fusion: remove an intermediate without changing arithmetic

The private branch kernel passed 91 focused tests and the same 91 cases under
memcheck in v23. Its measured resident latency beat the two grouped operators
for blocks 23, 30 and 40 at all three tested row counts. Public C++ dispatch and
its policy were compiled in v24; all 49 public branch tests passed normally
and under memcheck, within the root's broader dispatch validation.
These are local component results. They do not establish native DLL speed or
measured coverage of every resolution from 720p to 4K.

Each C512 block has eight independent branches: 64→256, cubic activation and E4
publication, then 256→64 and another publication. The ordinary implementation
writes and rereads a `[M,8,256]` packed intermediate. At M8160 this accounts for
33,423,360 logical read-plus-write bytes. This is a traffic calculation, not
measured DRAM traffic; cache reuse and additional weight requests also matter.

One warp handles 16 consecutive rows of one branch. It loads the two input K32
fragments once. For each of eight ascending hidden chunks, it computes 32 hidden
outputs using K32 steps 0 then 32, performs the existing Half cubic arithmetic
and E4 publication, and rearranges those published bytes directly from a tensor
core output fragment into the next input fragment. Each contraction accumulator
receives eight ascending K32 MMA instructions. There is no reassociation or
change to the intermediate rounding.

The final output uses the existing four-lane byte transpose and aligned
eight-byte stores. The launch offers one, two and four independent warps per
CTA. An out-of-range warp returns uniformly; there are no CTA barriers or
shared-memory communication between warps. Offset input and weight views get
aligned copies on the current stream. Those copies remain inside captured
execution and any timing of an offset contract.

The cost is weight reuse. A warp loads weights for every 16 rows, while the
composed grouped GEMM shares them across a larger tile. The compiler reports
78 registers for one warp and 56 for two/four warps on SM120, with no spills.
The source deliberately avoids another shared-weight pipeline before counters
justify its cost. The isolated v23 branch profile reports 22.43% tensor-pipe
utilization, which is well below the requested 85% gate.

## What the measurements select

The benchmark keeps both baseline launches, identical resident packed input and
output contracts, all three warp alternatives, distinct retained graph outputs,
input/weight immutability checks and replay after input mutation. It obtains the
real branch input through W1 from checkpoint blocks 23, 30 and 40.

| Rows M | Selected warps | Slowest improvement among the three blocks |
|---:|---:|---:|
| 1056 | 1 | 1.200× |
| 2160 | 2 | 1.084× |
| 8160 | 1 | 1.569× |

Every repeated block sample must pass byte equality, input immutability and
mutated capture checks, and its chosen candidate must take less than 97% of
the composed latency. The exporter minimizes the worst candidate/composed
ratio across all retained samples. Candidates within 1% of that best worst
ratio tie; the smaller warp count wins. Warp alternatives do not need a 3%
advantage over each other. Re-exporting the same SHA-pinned report is
idempotent; a distinct repeated report is retained and can disqualify a choice.

The policy is [sm_120_branch_ffn.json](../tuning/sm_120_branch_ffn.json), generated
from [branch_ffn_v23.json](../outputs/branch_ffn_v23.json). Its compiled version
is `23e446b1701f31ab`. Dispatch matches SM120, FP8 weights, packed input and
packed output, then chooses nearest M, resolving distance ties toward lower M
and clamping configurations at both endpoints. Empty input returns an empty
output and diagnostic zero. No dimensions are padded or truncated by policy
selection. Intermediate and out-of-range sizes inherit a configuration; they
are not counted as measured performance results.

The public call is
`inference_branch_ffn(input, expansion, contraction, packed_output=True)` with
input `[...,8,64]`, W2 `[8,256,64]`, and W3 `[8,64,256]`. Its fixed shapes,
dtype, device, row limits and gradient contract are validated before dispatch.
Other architectures, Half input and Half output use the original grouped
composition; FP16 uses Half weights and `packed_output=False`. The contraction
Half result receives its original publication. Selection stays entirely in
C++; the Python exporter is an offline tool.

`selected_branch_ffn_variant(sm,m,fp8,packed_input,packed_output)` reports
zero for composition or 1/2/4 for fused warp counts. The private
`_inference_branch_ffn_composed` retains an explicit baseline for verification.
Training continues to use the existing training implementation.

## Evidence and reproducibility

The measured v23 extension SHA256 is
`06c3ad6f0c7f297dd7685d58d902a6b628fb3fa3df20f4383026ad51cabb4923`.
[component_validation_v23.json](../outputs/component_validation_v23.json)
pins the test and sanitizer artifacts. Its binary association is the root
runner's attestation; the JUnit files do not embed the extension hash. The
shared proof parser validates all sanitizer summaries, including rejecting a
log that contains both passing and failing summaries. Branch-specific parsing
then requires executed branch cases in both normal and memcheck collections.
The separate bounded racecheck collection covers selected global/cache tests;
it is not described as a branch-specific racecheck run.

The CPU coordinate proof verified 512 output-to-input fragment coordinates,
1,024 output transpose bytes, 256 input-word coordinates, 8,192 weight-word
coordinates and 2,483,904 unique aligned stores across tails and real anchors.
The private tests additionally exercised all E4 byte codes, overflow, signed
zero, misaligned and noncontiguous operands, graph mutations and real W1
outputs. The public suite has 49 passing cases covering policy boundaries,
fallback publication, gradient rejection and real branch captures. Root also
ran those cases under memcheck with zero errors in v24. The policy suite has 39 passing
CPU tests, including shared-parser rejection of mixed sanitizer summaries.

```powershell
.venv\Scripts\python.exe tests/benchmark_branch_ffn.py --output outputs/branch_ffn_measured.json
.venv\Scripts\python.exe -m tuning.branch_ffn_policy --measurements outputs/branch_ffn_v23.json --validation outputs/component_validation_v23.json
.venv\Scripts\python.exe tuning/profile_branch_ffn.py --block 23 --m 8160 --warps 2
```

The isolated profiler checks an independent, forced ordered GEMM oracle before
and after collection. Only the selected fused call lies between profiler
markers. Full/PM and source-counter collections are parsed through `ncu_report`;
the run saves the binary, source hashes, selected-symbol SASS and full/source
input/output fingerprints. Source or binary changes during collection fail.

Sources: [kernel](../csrc/kernel_impl/branch_ffn.cuh),
[private launcher](../csrc/kernel_launcher/branch_ffn.cu),
[public dispatcher](../csrc/kernel_launcher/branch_ffn_dispatch.cu),
[Torch API](../csrc/torch_api/branch_ffn_dispatch.cpp),
[offline exporter](../tuning/branch_ffn_policy.py),
[public tests](../tests/test_branch_ffn_dispatch.py),
[CPU policy tests](../tests/test_branch_ffn_policy.py).
