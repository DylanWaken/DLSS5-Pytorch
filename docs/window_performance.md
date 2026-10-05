# Fused window attention measurements

These measurements use one head, FP8 deployment with half working storage,
BHWC field 512×576, phase 1, on the local sm120 device. They profile deterministic
synthetic QKV/scale/bias operands at an actual graph shape. NCU flushes caches;
its durations are separate from warm CUDA Graph timings.

| Revision | Cold NCU duration | DRAM read throughput | L2 throughput |
|---|---:|---:|---:|
| Initial fused attention | 76.29 us | 43.49% | 23.07% |
| Padded shared rows; native norm floor | 73.63 us | 45.16% | 24.07% |
| Paired half exponential/reduction/probability arithmetic | 67.84 us | 49.01% | 26.32% |
| Coalesced output and paired E4 publication | 64.35 us | 51.72% | 19.36% |
| Exact half FMA and paired Q/K normalization (v7) | 57.73 us | 57.61% | 21.58% |
| Reuse Q/K, probability and output shared storage (v8) | 52.74 us | 62.99% | 23.61% |

The first profile identified 3.1-way shared-load and 5.3-way shared-store bank
conflicts. Padding eliminated the severe store conflicts. Paired half arithmetic
then reduced conversions and instruction count while retaining reduction order.
The third profile showed only 8 useful bytes per 32-byte global store sector.
The fourth revision reuses dead Q/K shared storage to transpose MMA fragments
into aligned 16-byte stores. That warning disappears; lower L2 utilization here
reflects fewer unnecessary store sectors, alongside a shorter duration.

All four shifts, edge windows, multiple heads, batches, zero/tiny norms and
CUDA Graph capture pass exact comparison with the compositional deployment
operators. The first four revisions predate the half-FMA midpoint normalization
correction; v7 and v8 include it and pass the updated midpoint regressions.

The fourth profile's remaining long-scoreboard hotspot consumes QKV global loads
during scalar normalization. Shared loads show 1.4-way conflicts, and the LSU
pipeline is busier than the tensor pipe. The v7 revision pairs Q/K normalization and
uses the original half FMA directly, addressing both the midpoint error and
conversion overhead. The v8 experiment then retains all PV fragments in registers
until probability reads finish, and adds two CTA barriers to reuse one shared
buffer across all three phases. Shared bytes drop from 13,440 to 8,320 for FP8
and from 23,680 to 14,464 for FP16. FP8 still uses 40 registers with no spills;
theoretical active warps rise from 28 to 40 per SM and achieved occupancy from
54.96% to 71.89%. The additional barriers are included in the measured duration.
The 76 C32/window cases also pass Compute Sanitizer racecheck with zero hazards
(`outputs/v8-racecheck.log`). None of the recorded revisions passes the 85% gate.

Evidence: [initial](../profile/window-fp8-512x576x1-phase1-20261002T210349_496194Z/REPORT.md),
[padded](../profile/window-fp8-512x576x1-phase1-20261002T211342_634309Z/REPORT.md),
[paired arithmetic](../profile/window-fp8-512x576x1-phase1-20261002T212748_432666Z/REPORT.md),
[coalesced output](../profile/window-fp8-512x576x1-phase1-20261002T213900_655472Z/REPORT.md).
Further evidence: [v7](../profile/window-fp8-512x576x1-phase1-20261002T222806_146923Z/REPORT.md),
[v8](../profile/window-fp8-512x576x1-phase1-20261002T224616_812142Z/REPORT.md).
