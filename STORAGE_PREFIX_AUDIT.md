# Storage-prefix audit

Storage prefixes now describe a value's role instead of marking nearly every
local variable. The audit reviewed all **70 C++/CUDA files**, changing 326
file-scoped identifier pairs across 47 files. Every changed source token is an
identifier; numerical literals, types, expressions, inline PTX and control flow
are unchanged.

## What changed

| Before | After | Reason |
| --- | --- | --- |
| `r_Parameters`, `r_Arguments` | `Parameters`, `Arguments` | Mixed launch/configuration records are not register fragments. |
| `r_TileCoordinates` | `TileCoordinates` | The descriptor contains several coordinate and storage roles. |
| `r_Lane`, `r_Warp` | `Lane`, `Warp` | Execution coordinates serve multiple memory spaces. |
| `r_bValid`, `r_PhaseToken` | `bValid`, `PhaseToken` | Control predicate and opaque synchronization token. |
| Host `g_Tensor`, `g_Buffers`, `g_BufferIndex` | `Tensor`, `Buffers`, `BufferIndex` | CPU handles, containers and table indices are not device storage. |
| `g_CurrentTexture`, `g_OutputSurface` | `CurrentTexture`, `OutputSurface` | Opaque CUDA handles, not global-memory pointers. |
| Shared accessor `r_Tile`, `r_Panel` | `s_TileIndex`, `s_PanelIndex` | These select shared-memory arrays. |
| View accessor `r_Tile`, `r_Panel` | `g_TileIndex`, `g_PanelIndex` | These compute global-layout addresses. |

Scope matters. For example, a local `r_ColorScale` holding a computed Half value
keeps its prefix, while a launch record's configuration field is `ColorScale`.
Similarly, a host `Input` tensor handle is plain, while `Parameters.g_Input` is
an actual device pointer. Pixel coordinates used only to seed noise are plain
`PixelX`/`PixelY`; coordinates used for image addressing retain their storage role.

The following retain prefixes:

- `r_Accumulator`, packed Half/FP8 values, register fragments, their array indices
  and register shuffle selectors.
- `s_Storage`, shared tile fields, barrier offsets, stage sizes and shared indices.
- `g_Input`, `g_PackedWeights`, scalar device addresses and global-layout indices.
- Explicit `.reg` names inside intrinsic PTX. The assembly strings are unchanged.

These names describe source roles, not a promise that the compiler never spills
a value. Simply being a device local or using an intrinsic register constraint
does not justify an `r_` prefix. See the updated [naming conventions](CODE_READABILITY.md#names-describe-values-and-storage-roles).

## Validation

The [role audit and rename maps](storage_prefix_audit.json) record removed and
retained categories, scoped changes and source identities. The separate
[validation receipt](storage_prefix_validation.json) binds these checks to the
rebuilt extension:

| Check | Result |
| --- | --- |
| Source token comparison | Only prefixed identifiers changed across all 70 files; 2,654 occurrences |
| ABI and exports | All 1,044 assertions preserved; 81 unchanged C exports |
| Generated plans | All eight plans and their launch contracts unchanged |
| Normal extension build | Passed |
| GPU instructions, decoded resources and constants | All 81 instruction/resource rows and all ten modules' constant sections identical |
| CPU tests | 62 passed normally and 62 with Python optimization enabled |
| Native/candidate graph checks | FP8 and FP16 pass at 720p, 1080p, 1440p and 4K; 74 exact boundaries per case |
| Public C512 dispatcher | All 24 cases across 18 entries pass |

Graph checks include poisoned and changed-input replay. Dispatcher checks compare
the public Torch launcher with direct Driver launches of the same candidate,
including guards and immutable inputs/weights. The graph scope remains the
prepared-feature trunk on SM120. The installed extension SHA-256 is
`458abb67d0c2b4dbd0098f9193edb40637d22c1dfe8caed4270eb70bc35e12c7`.

No new speed or profiler samples were collected for this naming-only cleanup.
The [existing speed charts](BENCHMARKS.md) retain their measured build identities.
GPU code and launch contracts are unchanged from the preceding
[flat-symbol release](FLAT_SYMBOLS.md); host interfaces were revalidated. Historical
optimization logs and audit receipts remain intact.
