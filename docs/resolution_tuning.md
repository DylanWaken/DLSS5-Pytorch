# Continuous resolution tuning

`run_tuning.py resolution-tune` scans the inclusive integer domain
**width 1280–3840 × height 720–2160** by default. It examines every axis value,
including changes between 64/128 alignment and the coupled width-padding rule.
It does not assume monotonic padded dimensions or use a list of standard video
resolutions. The default 3,690,401 input resolutions reduce to 931 distinct padded
geometries, 23,976 prepared-GEMM dispatch keys and 22,433 memory-operator keys.
The prepared graph uses fused C32 blocks and fused attention. Add
`--include-compositional` to also tune standalone operators those fusions
eliminate; those extra probes are not actual prepared-graph launches.

Create the complete CPU-only manifest:

```powershell
.\.venv\Scripts\python.exe run_tuning.py resolution-tune --manifest-only
```

Run a bounded trial, then resume it with the same command without `--max-cases`:

```powershell
.\.venv\Scripts\python.exe run_tuning.py resolution-tune --width-min 1280 --width-max 1290 --height-min 720 --height-max 730 --operators gemm --max-cases 4 --output-dir outputs/resolution-trial
```

`--operators all` covers both GEMM and memory operators; `gemm` and `memory`
select individual families. `--precision fp8`, `fp16`, or `both` controls the
GEMM arithmetic domains. The input and output adapters always retain their
actual FP16 arithmetic. `--batch` enumerates a different model batch size.
Eligible global expansions include both resident row-major and persistent
packed weight layouts. Packed candidates must beat the freshly measured best
row-major candidate for the same shape; restoring weights is never timed as
that reference. `--packed-variants` selects those separate candidates.
Current grouped FFNs use distinct layout keys for shared inputs and interleaved
inputs/outputs. Their candidate timing compares against the resident earlier
GEMM policy with its broadcast/transpose composition. `--composed-groups`
retains the earlier layout as an explicit diagnostic scope.

`--packed-activations` selects the optional FP8 byte-storage graph. Its global
and grouped activation GEMMs use packed-output epilogue keys, and its memory
scope drops hidden re-packs while retaining the actual publication and bridge
operations. FP16 keeps its half-storage scope. The default-range packed memory
set contains 23,190 keys, including conditional C32 byte-to-half bridges, fused
decoder upsample/residual merges, and fused residual
seeds; the 23,976 matrix keys include FP8 EP2 activation and EP3 raw-publication
contraction outputs instead of intermediate half outputs. Unpack and residual
seed selection use their half output dtype in the C++ policy key. These
operators support the same 128/256/512-thread correctness-gated tuning as other
memory kernels. Decoder cases retain both their padded source shape and cropped
target shape; postprocessing also records its separate input-scale multiply.
Enumerating either storage scope does not establish its
numerical or speed coverage.

`--iterations`, `--repeats` and `--graph-output-budget-mib` control measurement
cost and captured output allocation. Each candidate must pass exact GEMM
comparison before graph-event timing; a promoted candidate must beat the
baseline by at least 3%. The native-speed and 85% counter gates are separate.

The largest output in the default prepared scope is 510 MiB. Reference
publication, residual and cubic arithmetic run in bounded chunks; correctness
comparisons are chunked too. Fused upsample validation gathers one output chunk
at a time and avoids a full upsampled reference tensor. Exact half-FMA oracles
correct FP64-to-half midpoint conversion to avoid an FP32 double-rounding step. The
actual input/output tensors and measured kernel shapes remain full size.
This avoids allocating whole-image FP64 oracle intermediates. Graph output
counts are also bounded by the configured memory budget.

The manifest records exact, nonoverlapping input rectangles and their padded
geometry IDs. It derives matrix shapes from the prepared graph, including
grouped experts, architectural K-partitions and decoder transitions. CPU
regressions compare matrix and memory keys from the earlier grouped composition
with the recorded v7 1080p operator trace, and the optional compositional set
with its earlier trace. Direct grouped launches have separate layout keys. The
fused attention implementations have geometry coverage metadata but do not
claim that enumeration benchmarks every attention shape.

C32 has a separate component policy keyed by precision, storage, requested raw
output, explicit skip, phase, and shifted-window count. The manifest retains
11,898 C32 dispatch keys and all colliding validation shapes for either storage
scope. These entries are enumerated coverage gaps until the C32 component
benchmark measures them; a completed GEMM/memory journal alone does not complete
C32 or fixed-attention performance coverage.

The prepared graph's matrix families vary their row count with resolution;
expert batch counts remain fixed. Standalone window-attention BMMs, whose
window batch count changes with resolution, are replaced by fused attention
in this graph and are outside this matrix manifest. Their separate diagnostic
policies retain exact batch matching; this scanner does not claim continuous
coverage for that unused decomposition.

The journals store each completed case transactionally in
`gemm-checkpoint.sqlite3` or `memory-checkpoint.sqlite3`. Their JSON counterparts are exported periodically and
at normal exit or interruption. Rerunning uses completed cases from the
journal, so interruption between JSON exports does not discard measurements.
A changed GPU UUID or extension binary is rejected; use a fresh output
directory after rebuilding. Failed/OOM cases remain explicit coverage gaps.
The progress counts report exact measured dispatch keys and geometries whose
entire derived matrix set has measurements.

After a run, measured records merge with existing `tuning/gemm_sm_120.json`
and `tuning/sm_120.json`; generators inject compact sorted tables into C++
headers. Rebuild the extension to deploy these policies. Python performs no
runtime kernel selection. Policy metadata preserves measured samples and
compiled hashes.

For each exact device/precision/operator family, runtime selection uses the
nearest measured matrix-row count or memory-element count. Counts below the
smallest measured point use its configuration; counts above the largest use
the largest point's configuration. The actual tensor dimensions, K order and
partition boundaries never change. Interior gaps select the nearest measured
configuration, with a lower-point tie break. Unmeasured devices or operator
families retain the original fallback. These configuration transfers are
explicitly **not measured performance coverage**; exact measurement counts
remain separate from the selected configuration's range of use.

A bounded hardware validation at widths 1280–1281 and heights 720–721 covered
all three resulting geometries: 166 matrix keys, including both precisions and
four packed-layout keys, plus 171 memory keys. The run resumed from its SQLite
journals, preserved completed measurements and reported no correctness gaps.
Evidence is in `outputs/resolution-v7-trial`. This validates the sweep mechanism;
it does not assert that the entire 720p–4K domain has been measured, or transfer
the old composition's measured timings to direct grouped kernels.

The residual GEMM family can also be tuned independently:

```powershell
python run_tuning.py residual-tune --shape 522240,64,64 --packed-skip --packed-output --omit-raw --output outputs/residual-case.json
python run_tuning.py residual-range --packed-activations --precision both --manifest-only
python run_tuning.py resolution-tune --operators residual --packed-activations --precision both --max-cases 1
```

`residual-tune` preserves the old `tests/benchmark_residual_gemm.py` CLI and
report format; that file now delegates to `tuning/residual_measure.py`.
`residual-range` and the `residual` resolution family enumerate the actual
prepared graph: packed FP8 C64/C128/C256 expert merges, plus FP16 expert and
branch merges, global FFN contraction, and attention projections. Global K
partitions remain 1024 for contraction and 256 for projection. C32 and post70
have separate fused policies. Half-storage FP8 is not counted as a residual
fusion route. The post70 families are listed separately as enumerated component
coverage; listing them does not benchmark them.

Residual journals reject changes to GPU, extension, runtime policy versions,
timing counts, graph budget, seed or measurement source. They retain per-case
original provenance when bounds are extended, label unsupported hardware and
failed allocations, and never count endpoint transfer as measured coverage.
Output retention is bounded by `--graph-output-budget-mib`; a case too large
for even one retained result remains an explicit gap. Candidate selection
requires exact output bytes and more than 3% improvement over the resident
composed policy. The generator merges prior anchors and every available SM
policy before emitting C++. Residual candidate 5 requires v14 or later;
the completed v14 measurements are recorded below.

The packed expert FFN family has completed the full requested domain on the
v13 binary: 1,677 measured keys, 931 geometries, zero errors, and all 20,124
candidate/composed exactness checks passing. The corresponding 1,680-row
production policy includes three prior smaller anchors. See
`outputs/resolution-group-ffn-v13-full/group-ffn-checkpoint.json`; the measured
1.579–2.269× improvement is against resident composed expert operators, not
the original DLL or the entire network.

The v14 residual sweep completed every one of its 3,626 dispatch keys across
all 931 geometries: 1,949 FP16 and 1,677 packed FP8. All 11,996 candidate results
matched the composed output byte-for-byte and preserved operands; there were
no failed/unsupported cases. FP8's selected candidates are 1.130–3.567× faster
than the resident composition. FP16 keeps the composed path at 86 keys where
fusion did not clear the 3% promotion threshold. The merged policy retains six
prior outside-domain anchors, for 3,632 entries, version `9505d20b293cb2b9`.
Individual timing samples and exact coverage are in
`outputs/residual-v14-full/residual-checkpoint.json`, with a transactional
SQLite journal. The measured binary is
`20341e11d0d7f1e117dd6642bd603eab0587035c41d9dd6c01342f3dc5c1fac4`.

The private short-K candidate 5 at packed C64/M522240 measures 49.456 microseconds
resident versus 84.672 for candidate4 and 176.396 for composition on that same
binary. Full/source NCU measures 57.888 microseconds cold, 67.61% aggregate DRAM,
29.35% L2 and 8.96% tensor activity; the 85% gate still fails. It uses 64 registers,
18,432shared bytes and four CTAs/SM, achieving 62.84% occupancy against 66.67%
theoretical. There are no spills. Source-correlated residual decode loads and
the first operand barrier now dominate long-scoreboard samples. Original
reports/SASS are in
`profile/residual-fp8-522240x64x64-v5-20261003T014447_903827Z`.

Post70 has a separate operational continuous driver:

```powershell
python run_tuning.py post70-range --packed-activations --precision both --manifest-only
python run_tuning.py resolution-tune --operators post70 --packed-activations --precision both --max-cases 1
```

The default domain contains 1,862 physical shapes across both precisions,
aggregated to 1,640 dispatch keys. Every physical aspect ratio is journaled and
measured separately, even when its shifted-window count collides with another
shape. Such a dispatch key is eligible for promotion only after all required
physical shapes pass, using the least favorable fused/composed latency ratio.
FP16 is explicitly composed-only and does not acquire fictitious fused timing.
The driver validates actual checkpoint payload hashes before any resume,
including no-op resumes. The bounded v15c run in `outputs/post70-v15-smoke`
passed all six physical cases for input widths 1280..1281 and heights 720..721,
covering three padded geometries in both precisions. Eager and captured heads
matched exactly and inputs stayed unchanged; interrupted, resumed, and no-op
invocations passed. Its three FP8 comparisons were 3.011–3.157× faster than
composition. Production post70 policy was unchanged. Those six cases do not
establish native DLL speed or roofline gates.
The smoke journal predates added decoder/constructor provenance hashes and
is retained as an immutable report, rather than being reused for new sweeps.

The subsequent full v15c sweep, `outputs/post70-v15c-full`, completed all 1,862
physical shapes, 1,640 dispatch keys, and 931 geometries in 326.2 seconds.
All 931 FP8 shapes had exact eager/captured head outputs and immutable operands;
all 931 FP16 shapes passed the composed-only capture check. There were no failed
or unsupported cases. Every one of the 820 FP8 dispatch keys cleared the 3%
promotion gate after checking all physical shape collisions. The measured FP8
gain over matching composition was 2.906–3.929×. The isolated policy version is
`734a80f294bf907c`; the review draft retaining six earlier anchors contains 826
rows, version `159238b1286db1c6`. That merged policy and header are installed in
the source tree for the v17 build. These measurements used binary
`ce4884e136b2520321c1a4def12444ef65284a4d97f2880e08d560dc3999d80d`.

C32 has a physical-checkpoint-block continuous driver:

```powershell
python run_tuning.py block32-range --packed-activations --precision both --manifest-only
python run_tuning.py resolution-tune --operators block32 --packed-activations --precision both --max-cases 1
```

It enumerates 18,620 physical block/shape cases and 11,898 dispatch keys over
the default domain. This deliberately includes block70's composed path for
boundary capture and fusion fallback; fused post70 is timed separately above.
Every checkpoint block and aspect ratio sharing a shifted-window key must pass
its own exact output, immutable input, and captured replay checks. A promoted
variant must beat its required references by more than 3% on every member;
rotated C32 must beat canonical register C32 as well as the shared baseline.
Timing includes the conversions required for identical input/output storage
and raw-output contracts. FP16 remains measured shared-only. Rotated evidence
is hash-verified and limited to the SM named in its ordered-K report.

The v15c bounded C32 smoke in `outputs/block32-v15c-smoke` passed every one of
its 20 physical cases and 16 dispatch keys for valid input 1280×720 (padded full
field 1344×768). All 40 candidate comparisons were byte-exact with unchanged
inputs, including CUDA Graph replay. Ten FP16 cases used the shared path;
the ten FP8 cases compared shared, canonical register and rotated register
kernels under identical I/O contracts. Rotated C32 was 2.681–3.786× faster than
the shared baseline. The isolated policy selected eight FP16 shared and eight
FP8 rotated dispatch keys; production headers were unchanged.

The first one-case invocation took 1.73 seconds, the 19-case resumed invocation
4.21 seconds, and a final no-op resume 1.29 seconds. The subsequent v16 full
sweep completed in `outputs/block32-v16-full`: all 18,620 physical cases,
11,898 dispatch keys and 931 geometries are measured, comprising 9,310 FP16
and 9,310 FP8 cases. All 37,240 candidate checks passed; failures and unsupported
cases are both zero. The isolated policy `a8c900cd041e838f` selects 5,949 FP16
shared paths, 5,948 FP8 rotated-register paths and one canonical-register path.
Selected rotated paths improve by 2.696–6.275× over the matching shared baseline
and 1.040–1.447× over canonical register kernels. The canonical exception is
packed input/output with raw output and explicit skip, phase1, B1×1152×1344;
its 0.2397ms is faster than rotated's 0.2514ms and shared's 0.6652ms.

The measured binary remains exact v16
`f79e96c8c37698e5a6989cad8b62f62806262cbe4633ba65f58e79b144c11553`.
Artifacts and hashes are recorded in `outputs/block32-v16-full/summary.json`.
The isolated merge candidate preserves 182 existing storage/outside-domain
anchors, replaces ten exact overlaps, and contains 12,080 keys. Production
C32 JSON and headers remain unchanged pending review and rebuild. Manifest
enumeration and nearest-window configuration transfer
are never reported as measured speed, and these component timings do not prove
the native DLL or 85% roofline targets.

Complete C64/C128/C256 window blocks have their own continuous runner:

```powershell
python run_tuning.py window-block-range --manifest-only
python run_tuning.py window-block-range --native-proof outputs/window_experts_native_verification_v16.json --max-cases 1 --policy-dir outputs/window-range/policies --header-dir outputs/window-range/headers
```

The default scope is the actual packed-input/packed-output FP8 graph; optional
`--storage half` or `--storage both` adds other storage contracts. FP16 remains
the composed graph and is not falsely listed as a fused candidate. The packed
scope enumerates 33,516 physical checkpoint-block cases, 7,212 dispatch keys,
and all 931 geometries. Raw outputs are retained only at actual graph consumers
8, 14, and 22. Every physical block and aspect ratio sharing a key must pass its
own byte checks, capture replay, input/weight immutability checks and timing.
Promotion uses the worst ratio against the faster of both half and packed
resident compositions, including conversions for identical I/O contracts.

`window-block-range` requires a hash-verified native parity report for the exact
extension binary and SM being measured. Its independent source reports are
revalidated before every resume. The report is numerical evidence, not a native
latency claim. Earlier policy anchors with different native evidence require an
isolated output directory and an explicit equivalence review before merging.
The unified entry point is `resolution-tune --operators window_block` with
`--window-block-native-proof`; `--operators all` records an explicit unmeasured
gap when no proof is supplied. Source and CPU coverage tests are complete;
whole-window range GPU measurements require v16 or later.

The bounded v16 run in `outputs/window-block-v16-smoke` passed all 36 actual
720p checkpoint-block cases and 15 dispatch keys, with 108 byte-exact resident
path comparisons, captured replays and unchanged inputs/weights. Interrupted,
resumed, and no-op invocations passed. All 15 keys selected fusion: measured
gains against the fastest matching composition were 2.627–2.935× at C64,
1.982–2.195× at C128, and 1.159–1.401× at C256. This used the fresh 240-case
v16 native parity report and binary
`f79e96c8c37698e5a6989cad8b62f62806262cbe4633ba65f58e79b144c11553`.
Full-range whole-window timings remain pending; the native proof establishes
published-output parity, not native speed or raw-half-output equivalence.

The subsequent v17 anchor comparison measures the original whole fusion plus
rolled-K, coalesced-store, and combined experiments under all 288 existing
shape/phase/storage/raw-output contracts. Policy IDs are 1 composition,
2 baseline fusion, 3 rolled-K, 4 coalesced stores, and 5 combined. A new experiment
must improve by more than 3% over both baseline fusion and the fastest resident
composition. Its selected private variant and extension SHA are bound to a
fresh native parity report. Coalesced variants require packed output; Half
output may select only the rolled-K experiment.

`outputs/window_policy_candidates_v17.json` and four pinned native aggregates
produce policy `34eeab7d3ac605cc`: 117 baseline, 58 rolled-K, 20 coalesced, and
93 combined selections. The experimental winners improve on baseline fusion
by 1.041–1.544× for C64, 1.046–1.449× for C128, and 1.035–1.084× for C256.
All selected paths are 1.331–5.835× faster than the matching fastest composition.
These 288 keys replace the same earlier anchor keys; they are not full-range
coverage. The policy and generated header are installed for the v18 build.
The continuous runner defaults to baseline fusion. Add `--variants 0,1,2,3`
and repeat `--native-proof` once for each of those private variants to compare
the experimental paths. Every proof must identify the exact measured binary
and SM; the runner rejects missing, duplicate, or extra variant proofs. The
unified command accepts `--window-block-variants 0,1,2,3` and repeated
`--window-block-native-proof` arguments. Half-output cases explicitly exclude
private variants 2 and 3 because their coalesced epilogues emit packed bytes.

Every colliding physical block and shape must satisfy both promotion margins;
selection ranks qualifying variants by their worst candidate/composition
ratio. All requested eligible paths must have actual measurements before a
case counts as covered. Candidate IDs, per-variant proofs, timing settings,
source hashes, weights and binary identity are pinned in the resume journal.
Widening a requested collision group retracts its old promotion until every
new member has been measured; partial exports explicitly select composition
for affected keys and retain incomplete coverage metadata.
The extended driver has 57 passing CPU tests; its experimental GPU sweep has
not yet run. Use new isolated output directories because its timing protocol
and source identity differ from the earlier baseline-only smoke.

Global attention and block0 input-adapter fusion have separate offline
generators: `run_tuning.py global-attention-generate` and
`run_tuning.py block0-adapter-generate`. Repeat `--measurements` for saved
reports, and pass `--local-validation` and `--native-proof` for their matching
evidence files. Global attention selection includes preparation in its measured
graph; attention-only timing cannot qualify a configuration. Both generators
require a strict improvement above 3%, verify the recorded sample medians, and
pin the measurement JSON, extension binary, JUnit and sanitizer artifacts.

The v19 anchors produce `tuning/sm_120_global_attention.json` and generated
policy `b0d65b62b131a953`: eight vector selections across FP8/FP16 and token
counts 96, 288, 640 and 2160. Measured gains against the fastest corresponding
local composition are 2.420–2.878× for FP8 and 2.294–2.619× for FP16, including
preparation. Scalar prepacking remains private. Native FP8 evidence covers
published Q/K/V and attended bytes on its listed anchors; original raw-half
outputs and an original FP16 ABI are unverified. FP16 promotion uses exact local
FP16 arithmetic, capture, memcheck and racecheck evidence. The native matched
FP8 pipeline is still slower than NVIDIA's measured pipeline, so these local
gains do not satisfy the native-speed target.

`tuning/sm_120_block0_adapter.json` and policy `60faa7bd26e563ad` select fusion
for 32 measured shape/phase/output-storage contracts, with 1.887–3.027× local
composition gains. The native pre0 proof is deliberately bounded: phase0,
packed published output, 16×24 and captured features from an instrumented
original prefix. It does not prove original raw-half output, other phases,
general renderer preprocessing or native timing. Those additional contracts
use local parity and sanitizer validation. Both tables match batch exactly;
only SM120/batch1 is measured. Within an exact precision or storage/phase
family, C++ selects the nearest token/window anchor with lower ties and endpoint
clamping. Other devices/batches use composition, and transferred configurations
never count as measured continuous coverage.

`run_tuning.py global-attention-range --manifest-only` enumerates 83 distinct
global field shapes across the full default domain: 166 FP8/FP16 physical cases
and 106 precision/batch/token dispatch keys. It preserves both aspect ratios
when different H/W shapes share a token count. The unified entry point is
`resolution-tune --operators global_attention`; `--operators all` includes
this family when `--global-attention-local-validation` is supplied, otherwise
its manifest records the unmeasured gap.

The runner times the independent original composition, scalar preparation,
vector preparation and private prefetch implementation with identical raw-Half
QKV input and Half output. Every candidate timing includes preparation. An
operator absent from the installed binary is recorded as unmeasured, rather
than assigned another implementation's result. Available paths must agree
byte-for-byte in eager execution and captured replays, and preserve inputs.
Output graph retention is bounded. Each physical case commits to SQLite;
the device, binary, source hashes, available operators, evidence files, and
timing settings must match on resume.

Pass `--local-validation` and repeat `--native-proof` for candidate-specific
native anchor reports to generate a policy. Each FP8 candidate needs its own
same-binary native proof. Native anchors may qualify the unchanged kernel at
other locally validated token counts, but those shapes remain explicitly
unverified against NVIDIA until the independent native sweep checks them.
FP16 vector and prefetch promotion uses the exact ordered local FP16 baseline;
an original FP16 ABI remains unmapped. Scalar is timed as a competitor but
is not promoted without its own native evidence.

A scalar/vector incumbent must beat the original composition and the other
scalar/vector peer by more than 3% at every physical shape sharing its key.
Prefetch replaces that validated incumbent only when it beats every other
measured path, including vector, by more than 3% on every member. Near-ties
therefore retain vector instead of reverting to the slower original composition.
This incumbent/upgrade hierarchy is recorded in each policy row. Widened, incomplete
collision groups select the original implementation until all members finish.
The generated table uses the existing global-attention header and nearest-token
endpoint-clamped C++ selection. Prefetch is policy ID4 and requires a rebuilt
dispatcher supporting that ID. Outputs default to isolated policy/header
directories; producing JSON does not install or deploy a policy. The v23 range
run completed all 166 physical cases, all four implementations per case,
106 dispatch keys and 931 geometries with zero failures or missing candidates.
A final no-op resume preserved every SQLite measurement record. All 106 keys
selected prefetch: measured gains over vector are 1.109–1.412× for FP8 and
1.068–1.226× for FP16. Gains over the original local composition are
2.676–4.137× and 2.197–3.310× respectively.

`outputs/global-attention-v23/summary.json` preserves complete requested-range
coverage and hashes. Four separate supplemental measurements cover token96
at both 8×12 and 12×8 in both precisions; these are explicitly outside the
requested input domain. They requalify the historical smaller anchors and
also select prefetch. The staged 108-key policy is `4e692b46715fbc99`, alongside
the C32 staging in `outputs/v24-policy-staging`; its summary separates these
supplemental cases from the 166-case range. Production installation and a
rebuild are still required. Neither local speed gains nor native anchor parity
imply the full-range native-speed or 85% roofline target.
