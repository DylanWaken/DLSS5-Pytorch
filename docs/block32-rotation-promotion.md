# Rotated C32 promotion

The integration is compiled in v13, with focused tests and full prepared graph
validation passing. `tuning/block32_rotation.integration.patch` records
the initial proposal. The generated SM120 policy is `757f135b0e474f97`.

The generic C++ dispatcher accepts ordinary `[N,K]` weights and opaque FP8
dual `[2,N,K]` caches. Every matrix's shape, dtype and device is checked before
selection. Shared and canonical register kernels receive zero-copy views of
cache slice0. The rotated kernel receives all four complete caches and reads
their prepared native layout. A policy choice of variant3 resolves to variant2
when any matrix is not cached. This preserves the ordinary public API during
CUDA Graph capture without hidden packing or persistent allocation.

`selected_block32_variant` gains `has_rotated_cache=False`. It returns the
resolved implementation, including the same variant3-to2 fallback. Unmeasured
devices or caller contracts continue to select the shared implementation.
FP16 keeps its existing half matrix layout and kernel.

Preparation declares only the C32 FP8 operand role: the four matrices of every
C32 block are cached once before capture. Python never inspects the SM or picks
a kernel variant. The native replay helper follows the same preparation rule,
so measured candidate blocks use production storage. Cache names are recorded
separately from general GEMM activation layouts.

Offline variant3 records require passed bitwise operator, unchanged-original
block and ordered-K tests, with paths and SHA256 hashes for all three reports.
The benchmark export checks those report files before timing/export. It also
records matching shared and canonical register timings; variant3 needs more
than a 3% improvement against both. Existing nearest-window interpolation and
endpoint clamping remain unchanged. The v12 sweep measured all four phases,
both skip contracts, eight input/output contracts and three fields: 192 exact
cases. It selects 123 rotated and 69 canonical configurations. All 128x128
cases keep canonical; all 512x576 cases use rotated; 59 of the 64 1088x1920
cases use rotated. These choices describe measured configurations on SM120,
not original-runtime speed or performance on every interpolated shape.

The accompanying CPU policy tests use clearly labeled synthetic records only.
It checks required proof fields, promotion margins, uncached fallback and
endpoint queries. They pass all 36 policy cases. The private rotated operator
passed 86 tests, and independent original C32 comparisons passed 32 cases and
65,536 bytes. The ordered-MMA permutation probe passed 58 cases. Report paths
and digests are pinned in `outputs/block32_rotation_v12_verification.json`;
all 192 timing cases are retained in `outputs/block32_rotation_v12_measurements.json`.
The generic operator passed its 35 cache/mixed-cache/capture tests, and the
v13 suite passed full prepared head, boundary and graph-capture comparisons.
Compute Sanitizer memcheck also covered the rotated and cache-dispatch cases.
