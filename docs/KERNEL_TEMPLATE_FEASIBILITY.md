# Kernel template feasibility

The repeated channel configurations can share **true CUDA global templates**
while keeping their specialized GPU schedules. This investigation builds isolated
prototypes; the production source files and installed extension are unchanged.

Forty compiled specializations have **byte-identical instructions, constant
payloads and decoded resource usage** to the current implementation. Two more
C32 output-view specializations preserve resources and constants but change the
instruction sequence; they are not included in that equivalence claim.

## What can share a body

| Current entries | Proposed full-body templates | Compiled result |
| --- | --- | --- |
| C128/C256 window blocks, ordinary/input-view/output-view, both precisions | One wide-window template per precision, with compile-time channel and layout parameters | All 12 specializations identical |
| C128/C256 fused downsample and upsample, both precisions | Separate downsample and upsample templates per precision | All 8 identical |
| C64 ordinary/input-view/output-view, both precisions | One C64 schedule template per precision | All 6 identical |
| C32 ordinary/input-view, both precisions | One compact-window schedule template per precision | All 4 identical |
| C512 plain attention projection and FFN projection, both precisions | One spatial-projection template per precision | All 4 identical |
| FP8 C1024 attention projection and FFN contraction | One global-contract template | Both identical |
| C1024 repack, both directions and precisions | One precision template per direction | All 4 identical |
| C32 output-view, both precisions | Tested as an additional compact-window layout specialization | Instructions differ; retain separate bodies pending qualification |

The forty window configurations can therefore use **20 authored bodies**:
18 when combining all layouts, plus two separate C32 output-view bodies until
those changed compiler results are qualified. They still emit 40 specialized
kernels. Together with the confirmed projection/contract/repack merges, the
81-entry tree could use **56 authored global bodies**, preserving all 81 logical
launch names. These are proposed source counts, not an applied tree migration.

## Preserve the three window schedules

Channel count alone does not describe the work distribution:

| Schedule | Channels | Ownership and synchronization |
| --- | --- | --- |
| Compact | 32 | One warp holds four token tiles in registers; no cross-warp FFN exchange |
| Two-warp | 64 | Each warp keeps two token tiles and both channel panels during FFN, then publishes to shared memory |
| Wide | 128/256 | One warp per channel panel/expert; four token tiles move through shared memory with barriers between their uses |

C128/C256 differ through existing compile-time profiles. In particular, C256
uses a wider attention batch, and FP16 needs its register cap of 192 rather than
C128's 168. C512 plain projection similarly preserves two versus four spatial
tiles per warp, eight versus four warps, and register caps of 168 versus 128.
Templating these constants does not turn them into runtime decisions.

Ordinary/input-view/output-view share the math and barriers. Only their physical
read/write regions need `if constexpr` selection. Keep those regions inside the
global body so the memory flow remains visible. The six experimental layout
templates occupy 1,676 lines, including emission getters, versus 4,629 lines in
their 24 original files. Their bodies remain a few hundred lines each.

Keep fused downsample and upsample as separate visible flows. Downsample pools
raw Half accumulators before FP8 publication. Upsample preserves the rounding
of skip multiplication before addition. Removing either distinction changes
the algorithm rather than merely removing duplicated source.

The C32 output-view exceptions show why source similarity alone is not enough.
FP8 only swaps two adjacent independent `CS2R` zero initializations; the rest of
its encoded instructions and control words match. FP16 changes input validity
predicate lowering and stops sharing an input pointer calculation between two
chunks, adding four `LDC.64` and four `IADD.64` instructions. Its register count,
24-byte stack and existing spill/reload counts remain unchanged. This does not
establish a slowdown, but it requires numerical and timing qualification before
that specialization replaces the current body.

## Other channel-indexed families

The remaining source audit identifies these further candidates; they have not
earned compiled equivalence in this investigation:

| Candidate | Differences that need explicit compile-time branches |
| --- | --- |
| C512 projection views and pooling | Bulk versus word-copy protocol, physical layouts, two versus three pipeline stages |
| C512 FFN ordinary/input-view | Input-copy protocol and the FP8 ordinary eight-warp schedule |
| FP16 C1024 projection/contraction | Two-stage pipeline with a peeled final MMA versus three-stage refill |
| C32 preprocessing with/without pooling | Retained output fragments and first-stage pooling publication |

Keep window QKV, global QKV, global attention, dense global FFN expansion,
encoder channel projection, decoder upsample and output postprocessing as
separate algorithm families. For example, C512 grouped FFN is not the
channel-specialized version of C1024 dense FFN. Likewise, the encoder bridge
and decoder bridge are not inverse schedules. A matching channel suffix is
insufficient evidence for a shared body.

There are twelve useful non-window-block *algorithm groups*. That does not mean
twelve proven CUDA bodies: precision-specific implementations and scheduling
branches can still be necessary.

## Integration design

Keep the complete kernel body in the templated `__global__` definition. Share
small intrinsics and substantial repeated mathematics as today; avoid restoring
thin device entries that forward the entire algorithm to hidden `Run` helpers.
Only the explicitly supported native profiles should be instantiated.

CUDA global templates have mangled C++ symbols. The 81 public Torch names can
remain stable logical aliases. A small host address resolver beside the global
definition can expose NVCC's registered specialization pointer; the host
launcher caches it when preparing the plan and continues to use the existing
launch path. That resolver performs no launch or tuning-policy selection.

Do not rely on cross-translation-unit template-stub linkage: NVCC's whole-program
template-stub behavior must be respected. Driver-based comparison tools also
need a logical-name-to-compiled-symbol map; CUDA provides `cudaFuncGetName` for
registered functions. See the [NVCC template-stub documentation](https://docs.nvidia.com/cuda/cuda-compiler-driver-nvcc/index.html#static-global-template-stub-true-false-static-global-template-stub)
and [CUDA execution API](https://docs.nvidia.com/cuda/cuda-runtime-api/cuda_runtime_api/group__CUDART__EXECUTION.html).

Before replacing production files, update plan generation, the C++ symbol
tables, Driver fixtures and source-layout audits together. Then qualify the
integrated extension and its captured graphs. This investigation does not claim
that host integration has already happened.

## Evidence and scope

The source baseline is commit `b192ae4c7eade053f38e9911c8ff8ee245c10157`, installed
binary SHA-256
`4a45e4f3e903406a91775729b815cc709c8f704c97249d1eec4b9aa50408e346`.
The prototypes use the same CUDA 12.8 frontend, CUDA 13.4 assembler and SM120
target. Compile-time source substitution was checked before compilation.

The final frozen compile experiment is
`outputs/template-feasibility/compiled-v4/comparison.json`: 15 template
definitions, 42 specializations, 40 exact instruction matches, and 42 exact
constant/resource matches. Initial trials and the two changed compiler results
remain preserved under `outputs/template-feasibility`; they were not discarded
to present only successful comparisons.

GPU results and portable identities are recorded in
[the audit receipt](kernel_template_feasibility.json). These compare templates
with the current implementation on the RTX PRO 6000 Blackwell. They are not a
new whole-DLL, renderer, whole-network timing or other-GPU qualification.

All **320 numerical cases passed**: 40 confirmed entries at 720p, 1080p, 1440p
and 2160p, with two prepared-feature input rounds. Checks cover independent
guarded outputs, unchanged inputs/records, eager execution and poisoned CUDA
Graph replay. Each entry uses a real launch position and intermediates from the
checkpoint-backed C++ plan. This is not every repeated graph position or every
possible boundary shape.

The initial 160 timing cases use 64 alternating pairs, 16 kernel launches per
graph and four replays per interval. The median of the per-case template/current
ratios is **0.99994**. Three 720p cases exceeded the 1% execution-order limit;
they remain in the receipt. Follow-up trials use 64 launches per graph and
16 replays per interval, then swap output allocations and run an identical
baseline-function control:

| 720p case | Initial worst order ratio | Longer intervals | Swapped buffers | Identical-function control |
| --- | ---: | ---: | ---: | ---: |
| FP8 global projection | 1.01034 | 0.99896 | 0.99667 | 1.00469 |
| FP8 token-to-spatial repack | 1.03074 | 1.00391 | 0.98536 | 1.01408 |
| FP16 token-to-spatial repack | 1.01094 | 1.00016 | 1.00007 | 1.00004 |

Ratios above one mean the candidate-side graph took longer. Both template
follow-up configurations meet the 1% criterion. The FP8 repack control also
exceeds 1% despite using the same function instance on both sides, and the
swapped-buffer result reverses the observed difference. These observations
show sensitivity to the measurement/storage arrangement; they do not establish
a compiler-induced regression in the identical instruction stream. The
initial outliers are not silently replaced by the follow-up results.

Contract/projection timings include their required completion-counter reset on
both sides. The other entries measure only the named kernel. These are repeated
resident-kernel timings, not an estimate of whole-network speed. No new Nsight
profile or roofline result is claimed: the primary evidence for the confirmed
merges is the unchanged compiled schedule, supported by the runtime checks.
