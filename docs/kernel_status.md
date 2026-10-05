# Kernel progress snapshot

This snapshot separates the installed implementation from private CUDA/C++
reconstructions inferred from original PTX. Updated after the V4 downsampling
repair, matched NCU collection, C128/C256 qualification and wider source expansion.

The subsequent user direction expands the PTX -> CUDA/C++ workflow to every
deployment family below, including all view/transition/layout/adapter entries
and their FP16 counterparts. This is now the primary implementation route;
the existing implementations provide comparison and fallback paths during
qualification. These expanded requirements do not change the completed-status
claims in this snapshot.

The 71 numbered graph entries use 153 checkpoint records. The FP8 blocks-1–69
native comparison selects **36 distinct original symbols**. The larger DLL
inventory has 223 network entries, including 111 FP8/Half pairs and a clear
entry; inventory size is not a count of implemented or qualified reconstructions.

The [checked source census](../outputs/all-kernel-cuda-reconstruction/REPORT.md)
now covers **all 36 selected FP8 entries and all 36 independent Half counterparts**,
plus counter clear. Four additional front/output FP8/Half bodies are now frozen,
including their texture/surface and mixed-precision operations. The additional
pre0-with-pooling and final C32 output-view FP8/Half pairs are also frozen. All
23 frozen bundles and their listed file hashes passed verification (81 exact
entries). This source milestone does not imply that all 72 selected entries have been
built, GPU-qualified, integrated or optimized. The remaining original alternate
entries are listed individually in that census.

The first combined reconstruction is also built: eight global blocks (31–38),
covering 40 of 152 compute positions, with 32 captured counter resets and the
required input/output bridges. Its contract, native-4K, finite and exceptional
checks pass: all 74 network boundaries and two native replays are byte-exact,
and all 112 retained global workspace buffers agree. Both selected-function
sanitizers pass. Balanced six-order 4K timing is **8.458 ms** for the reconstructed
chain versus **9.063 ms** for the existing CUDA path and **6.314 ms** for the
extracted original. The chain is about **6.7% faster** than existing CUDA and
**34.0% slower** than the original; it improves the median in all six orders.
See the [integrated qualification report](../outputs/reconstructed-global-chain4k-runtime/REPORT.md). The other 112 compute positions use
the existing normal CUDA path; original cubins remain outside the candidate.

## Deployment kernel families

In the table, **installed** means the existing extension supplies the operation,
possibly through several kernels. It does not mean a one-to-one reconstruction
of every original entry. **Private** candidates have not changed the installed
network timing. C denotes channel count.

| Family | Original selected entries | Current implementation and progress | Remaining work |
|---|---:|---|---|
| C32 ordinary and input-view window blocks | 2 | Installed fused FFN, cubic activation, QKV, window attention and residual projection; native comparisons pass in tested scopes. | Independent ordinary FP8/Half source, host API and bounded runtime sources are reviewed. The private build, 12 exact original/object/linked extractions and bounded compiled mechanism review are complete. Both fixed H16/W24 pilots pass contracts, finite/exceptional comparisons, guarded graphs, memcheck and racecheck. Paired FP8 is roughly equal in one order and faster in the other; Half reverses rank, so no speed winner is assigned. Half has a 112-byte stack versus the original 32-byte stack. Full fields/phases remain unqualified. Six C32 input/down/up FP8/Half bodies and maps are frozen. Their private build, 36 exact extracts, compiled review and actual-schema argument checks pass; the six-entry runtime is sealed for numerical qualification. The Half stack sizes are 64/32/104 bytes for input-view/down/up; FP8 has no local sites. Native-speed gates remain open. |
| C32 block 4 plus downsampling | 1 | Installed direct-publication fusion; finite/exceptional fixtures, sanitizers and network integration pass. | Installed route remains slower. Independent C32 FP8/Half PTX-derived downsample bodies are built and pass bounded compiled review; the runtime is sealed and GPU qualification is pending. |
| C32 block 66 plus upsampling/skip | 1 | Installed affine-address/vector-store fusion; component and network qualification pass. | Installed route remains slower. Independent C32 FP8/Half upsample bodies are built and pass bounded compiled review; the runtime is sealed and GPU qualification is pending. |
| C64 ordinary window block | 1 | New private PTX-derived FP8 CUDA/C++ passes finite/exceptional fixtures, guarded graphs, 25 API contracts, memcheck and racecheck. Balanced candidate/native ratios are 1.01341 and 1.00954 by execution order. Independent Half now also passes compiled review, contracts, finite/exceptional comparisons, guarded graphs, memcheck and racecheck on H16/W24. | FP8 is approximately 0.95–1.34% slower at fixed B1/H544/W960/phase 1. Half retains the original 832 expanded K16 tensor operations and 168 registers, but introduces a 40-byte local stack; timing and counters are pending. Not installed; wider fields/phases and integration remain. |
| C64 block 8 plus downsampling | 1 | Private V2 reconstruction passes finite/exceptional fixtures, guarded CUDA Graph replay, memcheck and racecheck. Balanced candidate/native ratios are 1.01155 and 1.00952 by execution order. | V4 passes all fixed-pilot numerical/graph/contract/sanitizer checks and measures 1.35–1.40% faster than the original in both orders. Matched NCU reports 76.4% elapsed tensor utilization: the 85% gate still fails. Shape/phase expansion and integration remain; V2 numbers above are historical. |
| C64 input-view, output-view and upsampling variants | 3 | Working installed graph through the existing core and transition/layout operations. | Seven independent C64 transition bodies (FP8 input/output/up; Half input/output/down/up) are generated and pass seven CPU source/bit-extension checks. The seven private launchers/APIs and independent Half pilot footprints are reviewed and frozen; the build and seven-entry compiled review pass. FP8 has no spills; Half has spills including tensor payloads. All seven fixed pilots pass API contracts, finite and exceptional byte comparisons with guarded graphs. All seven also pass memcheck and racecheck. Fixed-pilot FP8 upsampling measures 1.29–3.12% faster; input/output views remain slightly slower. Tiny Half timings reverse rank by execution order; Nsight Systems confirms substantial gaps around nearly equal kernel intervals. The accepted 32-call independent-output graph reduces the order discrepancy to about 1%, but ranking still reverses; no Half speed winner is assigned. |
| C128 ordinary, input-view, downsample, output-view, upsample | 5 | Installed core works. Fresh ordinary FP8 source is built and its object/linked assembly review passes. The compiler unrolled two loops; expanded tensor-operation counts agree. All fixed-pilot numerical, graph, contract, memcheck and racecheck gates pass. Balanced timing is 2.69–2.78% slower than the original; an 8-byte stack and one scalar spill remain. | Matched NCU finds equal tensor work and global traffic, but 16.51% more executed instructions and extra packing. A separate packing-only V2 candidate is built and passes compiled operand review. V2 passes contracts, numerical/graph tests and both sanitizers, but its balanced ratios are 1.04051 and 1.02499; it still fails speed parity. Matched V2 NCU confirms fewer packing instructions, but four geometry spill words and 69.3% elapsed tensor utilization; speed and the 85% gate still fail. Independent ordinary Half, FP8/Half down/up, and FP8/Half input/output-view source is frozen. Their combined nine-entry build/package, all 54 selected original/object/linked extractions and bounded compiled mechanism review are complete. A first numerical batch passed ordinary Half and FP8 downsample, then stopped on an upsample test-adapter argument-order error before a kernel launched. A separately sealed v2 runtime corrects that call and passes actual-schema role tests; its nine-pilot GPU batch is pending. Speed optimization, wider shapes and variant GPU qualification remain. |
| C256 ordinary, input-view, downsample, output-view, upsample | 5 | Installed core works. Fresh ordinary FP8 passes compiled review, finite/exceptional fixtures, contracts, guarded graphs and both sanitizers. Balanced fixed-pilot timing is 2.64–3.33% faster than the extracted original. The nine remaining ordinary-Half, down/up and input/output-view FP8/Half entries have reviewed source/host/pilot bundles. Their combined private build/package, all 54 selected original/object/linked extractions and bounded compiled review are complete. A separately sealed v2 runtime corrects the shared upsample test-adapter argument order and passes actual-schema role checks; its GPU tests are pending. All five Half entries have no local sites but use 236–246 registers. FP8 transition/view variants retain address or geometry spills. Numerical and performance qualification remains. | Matched NCU confirms equal tensor work/global traffic, with 15.83% more executed instructions and four geometry spill words. CUDA reaches 65.4% elapsed tensor utilization, so the 85% gate fails. Wider shapes, remaining variants and integration remain. |
| C512 FFN and FFN projection, each ordinary/input-view | 4 | Installed grouped/branched FFN fusions and C++ selection policy; native stage comparisons exist. | All eight exact FP8/Half source bodies are frozen after peer review, retaining their distinct async-copy and barrier flow. Plain FP8 FFN passes 31 API contracts, finite/exceptional byte comparisons, guarded graphs and both sanitizers. Paired timing is 16.95–26.79% slower. Matched NCU confirms that 130 registers allocate as 136, limiting residency to one block versus two for the native 128-register kernel. Elapsed tensor use is 41.7% versus 51.5%; both fail OR85. A separate 128-register cap experiment passes all numerical, graph, contract and sanitizer checks without spills. Matched NCU confirms restored two-block residency and 48.9% elapsed tensor use versus the original 51.5%; OR85 still fails. Its short paired timings reverse rank (0.84982 / 1.19385). The accepted 32-call graphs with distinct output storage are 1.58–9.94% slower in opposite execution orders; the matching Nsight Systems trace verifies 64 launches and 2,048 kernels, with 2.79–8.73% longer CUDA kernel sums plus a separate leading gap attached to the first submission. The cap change also coincides with a measured shared-memory configuration change from 16 KiB to 64 KiB, so registers alone are not established as the whole cause. Plain Half FFN is built and passes compiled ordered-expression/async review, API contracts, four finite and seven exceptional fixtures with guarded replays. Both sanitizers pass; paired CUDA/original ratios are 0.95379 / 1.09701, reversing rank by execution order, so no speed winner is assigned. Six remaining FFN variants have reviewed host APIs and bounded address/record calibration, and their private build has completed. The six-entry compiled arithmetic review and separate async protocol reviews are complete. All six now pass API contracts, four finite fixtures and seven exceptional fixtures with guarded replay, memcheck and racecheck. All three FP8 paired comparisons reverse rank by execution order. The three Half variants are faster in both orders on small H16/W24 independent K16 fixtures (input-view FFN 6–19%, projection 21–38%, input-view projection 22–43% lower latency). These are bounded results; matched counters, full-size Half qualification, wider shapes and integration remain. |
| C512 QKV and local attention | 1 | Installed fused QKV-attention route with scoped native comparisons. | Four independent QKV/projection FP8/Half bodies and combined launcher/API are built, with selected native/object/linked assembly saved. Bounded compiled review and independent Half address calibration pass. All four fixed pilots pass contracts, finite/exceptional byte comparisons, guarded graphs, memcheck and racecheck. All four paired timings reverse ranking by execution order; no speed winner is assigned. Matched NCU is complete: every elapsed OR85 gate fails. A separate FP8 QKV address-rematerialization experiment removes the 8-byte address spill, but matrix-operand spills increase from 16 to 40 bytes. Its complete object/link code agrees and the other three entries are unchanged; numerical and timing qualification has not been run for this experiment. |
| C512 projection, output-view projection, projection/pool, 512-to-1024 adapter | 4 | Working installed operations and transitions with native comparison coverage. | Plain projection FP8/Half passes the bounded compiled and runtime checks above. Six independent output-view/pool/adapter FP8/Half bodies are frozen after peer review; host/build/runtime qualification remains. The adapter is not the final RGB head. |
| Global 2D-to-1D and 1D-to-2D repacking | 2 | Working layout connectors used by the native comparison. | Four independent FP8/Half repacks plus counter clear are built. Selected object/link code and raw bit-copy paths pass bounded compiled review. Native byte/graph/contract checks and both sanitizers pass for bounded FP8/Half fixtures. Diagnostic microkernel timings are unstable; no speed winner is qualified. |
| Global C1024 FFN expansion and ordered contraction | 2 | Working expansion/activation and ordered partial reduction; real-weight global block comparisons pass in tested scopes. | Plain resident 1D expansion/contraction FP8 and Half source reconstructions retain original async copies, barriers and ordered counter publication. Primitive/host source reviews pass. All four compile without spills and exact object/native extraction is complete; bounded compiled mechanism checks pass. All four fixed pilots pass GPU contracts, finite and exceptional byte comparisons with guarded replays and contraction counter checks, memcheck and racecheck. Three paired timings reverse ranking by order; Half contraction is faster in both orders in this bounded run. Matched NCU is complete and all elapsed OR85 gates fail. Half pilots are underfilled M128 fixtures; full-size Half plans are prepared, with fresh admission and runtime qualification still required. |
| Global C1024 QKV, chained attention, projection | 3 | Working normalization, fused global attention and ordered projection. Targeted native byte comparisons and global block boundary checks pass. | All six exact FP8/Half bodies and their host/pilot bundle are frozen after independent source/host review. A private two-TU build and 36 selected original/object/linked extractions are complete. All six object/linked entries agree exactly and have no spills. Bounded compiled protocol review passes, including actual count-one barrier operands, accumulator carry order and counter publication. All six pass API contracts, four finite fixtures and seven exceptional fixtures with guarded graph replays. FP8 QKV/attention/projection also pass both sanitizers and paired timing: attention is 6.03–7.98% faster in both orders in the fixed pilot, while QKV and projection reverse rank. Twelve FP8 matched NCU captures are complete: CUDA elapsed tensor use is 57.24% QKV, 48.69% attention and 32.97% projection; all 85% gates fail, with no local-memory sectors in these entries. All three Half entries pass both sanitizers and paired timing validation, but every Half ranking reverses by order; all twelve matched Half NCU captures are complete on the bounded M128 pilots. Every elapsed 85% gate fails; all three have zero local-memory sectors. These small pilots do not qualify full-frame Half efficiency. Its fixtures require a freshly verified QKV predecessor before chained attention, including graph replay. |
| Block 39: 1024-to-512 projection, upsample, scaled skip | 1 | Working transition; native arithmetic and boundary comparisons exist. | Both independent FP8/Half reconstructions pass private build, 12 exact selected extractions, bounded compiled review, 72 API contracts each, finite/exceptional byte comparisons, guarded graphs, memcheck and racecheck. Their distinct 80-byte ABIs and ordered scratch/high publication are retained. Paired CUDA/original ratios reverse ranking: FP8 0.97348 / 1.12402, Half 0.97087 / 1.05310; neither is a speed winner. Half has a 432-byte stack versus the original 56, with 107 scalar spill/reload pairs. All eight matched NCU captures pass their post-profile checks. Every elapsed OR85 gate fails; Half local load/store sectors each increase from 832 to 6,848 on the underfilled 32-CTA pilot. The eight-report source-PC audit also closes equal tensor work, ordered scratch updates and Half spill dataflow. Broader fixtures and integration remain. |
| **Total selected FP8 trunk symbols** | **36** | **All 36 FP8 and 36 independent Half source reconstructions are frozen and hash-checked.** | GPU and performance qualification is incomplete; none of this source count establishes full-network parity. |

The [exact 36-symbol inventory](../outputs/native-compute-flow-audit/provenance-coverage.md.draft)
lists every original name and graph location. Its audit-coverage labels are a
historical first pass; the newer C32/C64 work above supersedes those labels for
the specifically qualified cases.

## Other operators and precision paths

| Operation/path | Status |
|---|---|
| Ordered FP8/FP16 GEMM, grouped GEMM, residual-seeded GEMM, ordered reducers | Implemented with C++ dispatch; used throughout deployment. |
| Cubic SiLU, FP8 publication/packing/decoding, half residual arithmetic | Implemented and tested; several are fused into matrix/window kernels. |
| Cosine Q/K normalization, special exponential, ordered denominator sum/reciprocal | Implemented and tested; these are the native graph operations, not LayerNorm or ordinary softmax. |
| Window partition/addressing, pooling, nearest upsampling, skip/post blend | Implemented; some remain separate where original kernels fuse them. |
| Input 16-to-32 adapter and output 32-to-4 head | Implemented; scoped native endpoint checks exist. Four independent original pre/post FP8/Half source bodies are frozen after source/primitive review. Texture/surface descriptors, original host preparation and reconstructed GPU qualification remain open. Complete renderer/temporal-compositor equivalence is not established. |
| FP16 deployment | Working forward and prepared CUDA Graph path. Wider window blocks still use composed operations. Original Half kernels require independent layout/record reconstruction; full native Half parity is open. |
| FP32/BF16 training | Working PyTorch/ATen forward and autograd; complete-model gradient, dtype and capture checks pass. This differentiable arithmetic differs intentionally from quantized inference. |
| RTX 30/40 hardware coverage | Architecture targets exist, but current profiling/reconstruction evidence is from SM120. Physical RTX 30/40 qualification remains open. |
| Continuous-resolution tuning | 720p–4K geometry enumeration and endpoint-clamped C++ policies exist. Earlier sweeps cover 931 padded geometries; new private reconstructions still need their own shape/phase sweeps. |

The actual network contains no convolution, LayerNorm, GELU or routing-gate
operators. See [operator arithmetic contracts](operators.md).

## Installed performance and outstanding goal

These are balanced resident **trunk** measurements against unchanged extracted
original kernels, not complete DLL/NGX/renderer host timing. All 74 compared
boundaries and two native replays pass at each size.

| Valid input | Installed implementation | Original kernels | Slowdown |
|---|---:|---:|---:|
| 1280 × 720 | 2.978 ms | 2.181 ms | 36.6% |
| 1920 × 1080 | 3.975 ms | 2.557 ms | 55.5% |
| 3840 × 2160 | 9.194 ms | 6.433 ms | 42.9% |

Matching the current 4K baseline requires about a 30% reduction in installed
latency. The private near-native C64 result has not been integrated and must
not be counted as a measured full-network gain. Its matched NCU tensor
utilization is approximately 73%, as is the original in that experiment;
the requested 85% gate remains unmet (V4 improves its measured tensor value to 76.4%). Nsight Systems, Nsight Compute and exact
SASS comparisons are in use, but coverage is not uniform across all variants.

Sources: [current performance evidence](performance.md),
[down8 matched NCU report](../profile/c64-down8-cuda-matched-v2/REPORT.md),
[ordinary C64 compiled review](../outputs/c64-ordinary-cuda-reconstruction/compiled-review/REPORT.md.draft),
and [optimization walkthrough](optimization_walkthrough.md).

The final causal postmortem and reusable `skills/` set requested after native
performance replication remain outstanding. The walkthrough records measured
findings and failed experiments as work proceeds.

Additional source work from the expanded workflow: ordinary C64 Half has four
generated source layers, an independent source review and six passing CPU checks;
its native K16 body is separate from FP8. Ordinary C32 FP8/Half source drafts
also exist with eight passing CPU checks. C512 FFN FP8/Half source is frozen; its four QKV/projection bodies and combined
launcher/API are built and their four-pilot runtime is sealed. Four global layout repacks and counter clear are built and have
passed bounded compiled review; their bounded runtime and sanitizer qualification passes; speed remains unresolved. Source
and compiled milestones alone do not establish GPU correctness or performance.
