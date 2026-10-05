# Block 0 and its first pooling transition

This private draft returns the full published block0 skip and the published pooled state for block1. It omits the full raw block0 output because pooling is its only consumer on this path. The public model graph is unchanged.

The baseline is the coalesced adapter fusion from v21. Its compiled SM120 SASS has eight 128-bit raw stores and eight 64-bit packed stores per window, 135 registers for packed publication, and no spills. At the time this draft was written, that candidate was compiled but had not yet completed GPU correctness and performance validation. The pool fusion now compiles for all target architectures in v22. SM120 uses 140 registers for packed output and 137 for half storage, with no spills. GPU exactness, sanitizer and speed checks remain pending.

The motivating v20 full-network profile is `profile/network-fp8-packed-20261003T040126_448805Z`. It attributes roughly 436 µs to the first pool alongside roughly 920 µs for the adapter fusion. Those are profile attributions, not a measured pool-fusion speedup.

## Retain raw values in the warp

The existing arithmetic core finishes one M16 output tile at a time. After the coalesced channel transpose, every four-lane group owns one token, and lane `t` owns eight consecutive channels. Within each side of that M16 tile:

- XOR 4 exchanges the same channels with the adjacent horizontal token.
- XOR 16 exchanges them with the adjacent vertical token.
- Groups with `(lane & 20) == 0` own the top-left pixels of the 2 × 2 cells.

Window origins are shifted by zero or four pixels, and each M16 side starts on an even coordinate. Every 2 × 2 pool cell therefore lies in one such group arrangement for all four phases. Even input height and width ensure a valid top-left pixel has valid right and bottom neighbors.

The pool uses the original arithmetic order, independently for each half lane:

```text
top    = half(left_top + right_top)
bottom = half(left_bottom + right_bottom)
sum    = half(top + bottom)
pooled = half(sum * 0.25)
```

`__hadd2_rn` and `__hmul2_rn` preserve each explicit rounding point and prohibit contraction into an FMA. The pooled raw half values are then published through the existing E4M3 conversion. The full skip is separately published from the original block0 accumulators. Pooling must not read the already-published full skip.

All transposes and pool shuffles execute before image or crop predicates. The arithmetic core, weight loading, MMA order, and full-resolution publication conversion are unchanged.

## Target shape and zero padding

The API accepts the target height and width from `geometry.levels[0]`. Its private schema is:

```text
_inference_block0_adapter_pool(
    features, input_adapter, w1, w2, qkv_weight, projection_weight,
    ffn_scale, attn_scale, head_scale, bias,
    target_height, target_width, phase=0, packed_output=True
) -> (published_full_skip, published_pooled_state)
```

The inputs use the existing FP8 dual-cache block0 contract. `packed_output=False` means FP8-published values stored in FP16 for both outputs; it does not select FP16 network arithmetic.

Valid pool cells write only when they fall inside the requested target. A grid-stride epilogue visits only the padded right and bottom strips and writes literal positive zeros. These strips exclude the valid region and each other, so there is no inter-CTA producer/consumer dependency or race. A cropped target requires no zero stores. Padding runs in the same kernel and is rewritten on every graph replay.

The launcher owns both allocations and validates positive target dimensions, even input dimensions, device, dtype, all weights/scales, and grid bounds. Empty batches return the correctly shaped empty pair. The private API rejects gradients. No full raw tensor is allocated or returned.

For a 2176 × 3840 field, the old raw block0 tensor contains 534,773,760 bytes. Removing its global write and the following pool read eliminates 1,069,547,520 bytes of logical traffic before accounting for caches. Avoiding the separate raw-half pool result can also remove its write/read before E4 publication. These are byte counts from the dataflow, not measured DRAM traffic or a speed claim.

## Proof and tests

`tools/block0_pool_layout_proof.py.draft` checks 256 warp ownership coordinates, 116 exhaustive geometry/phase/target cases covering 268,800 channel addresses, and 4,800 large-field edge/center groups. It verifies top-left/right/bottom ordering, no duplicate writers, complete target coverage, crop handling, and disjoint positive-zero padding. Results are in `outputs/block0_pool_layout_cpu_proof.json`.

The test draft compares both outputs against the independent canonical block0 composition, followed by the existing pool, target crop/pad, and publication. It covers every phase, both storage types, batches, even partial windows, target crop/pad combinations, offset pointers, real weights, half-rounding edge cases, empty batches, malformed inputs, and graph replay with modified inputs and poisoned padding.

The seeded benchmark compares the new pair against both original-adapter-plus-pool and coalesced-adapter-plus-pool baselines. Each path retains exactly the same full published skip and pooled published state, and the benchmark reports speedup over the faster baseline.

Before activation: compile and inspect registers/spills and shuffle/store SASS; run the tests plus memcheck/racecheck; compare against captured native block0 publication; then measure the complete pair at real geometries. Extra shuffle work and longer accumulator lifetimes may offset traffic savings at small shapes. No performance result has been measured for this draft.
