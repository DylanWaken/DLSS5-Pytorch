# Public block 0 and pool integration

The public C++ dispatcher and graph hook are now implemented and awaiting their
first rebuilt-binary validation. The underlying private candidate passed the
v23 correctness, sanitizer and bounded native DS checks. The initial generated
policy is `7618ab06f3984055`: four measured SM120, batch 1, phase 0, packed FP8
anchors, with exact half-size targets. Other families use composition.

The evidence-pinning exporter is `tuning.block0_adapter_pool_policy`:

```powershell
python -m tuning.block0_adapter_pool_policy --measurements outputs/block0_pool_v23.json --local-validation outputs/component_validation_v23.json --native-proof outputs/vendor_pre0_ds_v23.json
```

The retained full/pooled outputs match byte for byte. At padded fields
512×576, 768×1344, 1152×1920 and 2176×3840, the fused private candidate measured
1.356×, 1.613×, 1.673× and 2.009× faster than the better of the original and
coalesced adapter/pool compositions. These are resident component timings,
not a DLL renderer speed claim. The measured candidates retain the same two
outputs and use the same calls per graph.

The unchanged native DS entry passed 12 bounded fixtures (two exact-half
geometries, three constant proxy colors, two seeds), with three fresh native
launches and candidate graph replays per fixture. Both full and pooled bytes,
guards, input/weight immutability and replay stability were checked. Native
raw Half values remain unobserved, and native padded targets remain untested.

Fusion eliminates a large intermediate, so a lower bandwidth percentage can
accompany faster execution. The 4K NCU profile measured 860.22µs with 58.62% DRAM,
13.78% L2 and 40.14% tensor utilization. It **does not pass the 85% roofline gate**.
See `profile/block32-adapter-pool-fp8-b1-2176x3840-phase0-block0-20261003T045821_338391Z`.

The proposed operator returns two values: block 0's full published output for
the post70 merge, and the published pooled state for block 1. The fused path
does not allocate the full raw Half block 0 output. Pooling must still use the
raw accumulator before publication; pooling the full published skip would
change the network.

## Graph hook

Add a shared `_input_stage(features, phase, target)` hook returning
`(published_full, published_pooled)`. The base `DLSSNR` implementation calls the
existing `_input_block`, then `self.numerics.pool(raw, target)`. This keeps
training arithmetic, autograd and the ordinary inference fallback in their
existing implementations. Keep `_input_block` available with its existing
published/raw contract.

`PreparedInference._input_stage` calls a new public
`torch.ops.dlssnr.inference_block0_adapter_pool`. It passes
`target_height=target[1]` and `target_width=target[0]`: geometry uses `(W,H)`,
whereas the CUDA operator uses `(H,W)`.

In `DLSSNR.forward`, replace only the initial block/pool pair with this hook.
Continue storing its first result under `block-0` and its second result under
`transition-0-1` when boundaries are requested. Keep the first tensor alive as
`adapter` for `_post_head`. Do not substitute pooled state for that skip. The
remaining encoder, decoder and post70 calls stay the same. Prepared boundary
decoding remains in `PreparedInference.forward`.

The preparation-time `_requires_raw_output` flag for block 0 can remain true:
it describes the standalone block contract. The new stage hook controls which
values the graph materializes. No Python device, size or variant selection is
needed.

## Public C++ contract and fallback

Use the private pool operator's argument order and result shapes, but accept
the same weights as the existing public block 0 adapter: ordinary FP16 matrices,
ordinary FP8 matrices, or mixed/complete FP8 dual caches. The input features are
FP32 BHWC16, the adapter and scales are Half, and output precision follows the
weight dtype and `packed_output` flag. Reject packed output with FP16 weights.
Both input dimensions must be positive and even; target dimensions must be
positive. Preserve the existing no-autograd contract.

Validate the complete tensor/device/dtype/shape and integer-size contract before
policy lookup. Use the common int32 adapter-row bound even when the fused path
could support more, so route changes cannot alter accepted inputs. Validate
allocation products without signed overflow. Keep the current device guard,
stream selection, alignment handling and empty-batch behavior.

The composed fallback should call `block0_adapter_dispatch_cuda(...,0)` to use
the current public adapter policy, then `pool_cuda(raw)`, then
`at::constant_pad_nd` with `[0,0,0,TW-W/2,0,TH-H/2]`, then pack or publish.
Negative padding implements the existing crop behavior. In FP16 mode use
Half publication without an E4 round trip. Return the original full published
tensor alongside the pooled published tensor.

This fallback handles FP16 on SM80+, ordinary or incomplete FP8 caches,
unmeasured devices/batches, crop/pad targets, and any policy record selecting
composition. It stays entirely in C++. An explicit private composed entry
point should share the same validation for comparison tests.

## Policy and measurement

Use a separate `block0_adapter_pool_policy.h` and
`tuning/sm_<SM>_block0_adapter_pool.json`; its output contract differs from the
existing published/raw adapter policy. Recommended initial IDs are 1 for the
public adapter followed by pool/publication, and 2 for the fused pool kernel.
If a coalesced adapter followed by pool wins and is not already selected by the
adapter policy, either promote that adapter policy first or register it as an
explicit third candidate. Never compare the fusion only with a slower forced
adapter fallback.

The first fused policy should require complete FP8 dual caches and an exact
half target. Group anchors by `(SM, packed_output, phase, batch)` and use the
existing window-count nearest-anchor rule with lower ties and endpoint clamps.
Unknown families and zero work select composition. A diagnostic
`selected_block0_adapter_pool_variant` should expose the same cache/target
eligibility checks; `compiled_block0_adapter_pool_policy_version` should expose
the compiled policy digest. This makes out-of-range configuration transfer
visible without claiming those sizes were measured.

Every record needs source H/W, target H/W, precision/storage, phase, batch,
window count, variant, output contract, seed, binary/source/device identity,
measurement protocol, graph-call count and both comparator timings. Record
numeric correctness, guard/sanitizer evidence and the scope of native evidence
separately. Include the pool policy version in model/network and benchmark
metadata. Re-run comparison if the underlying adapter policy changes, because
that can change the composed baseline.

CPU enumeration on 2026-10-03 found all **931** unique geometries in the inclusive
1280–3840 width / 720–2160 height manifest have exact half-size level 0 fields.
Manifest SHA256:
`815376f179aa8b31543f71fb0c61420a4edd21377eac81adf9415c61eccf32ec`.
Thus exact-half eligibility covers the requested input domain. General crop/pad
operator correctness is a separate capability; expand its fused policy only
with measurements keyed by target shape or target class, rather than projecting
exact-half timing onto arbitrary output work.

## Existing evidence and remaining checks

The private tests use an independent Half adapter and canonical C32 block,
then pool the raw output, crop/pad and publish. They cover all phases, packed
and Half storage, exact/cropped/padded/mixed targets, immutable offset inputs,
mutable graph capture, real weights, nonfinite publication, signed zeros and
empty/invalid contracts. The graph test poisons padded rows before replay.

The private benchmark retains the same two final outputs for all candidates.
It includes the pool, crop/pad and publication in both composed baselines and
reports speedup against their minimum median. The output budget is retained
logical output bytes, not a peak-memory measurement. Samples run in a fixed
candidate order; before promotion, confirm a close result in reversed or
interleaved order. Native texture preprocessing is absent from this benchmark,
so it cannot establish native pre0 latency.

`tools/vendor_pre_ds_probe.py` adds a different proof: unchanged original DS
full and pooled E4 outputs for bounded constant-proxy/no-history, phase0,
16×16→8×8 and16×24→8×12 fixtures. It captures the actual DS prefix, checks both
boundaries independently, and does not expose original raw Half values. Its
CPU proof traces the DS pool/store map and verifies exact-half targets skip
the larger padding-clear path. The v23 executed helper supplies the bounded
native parity; its static report alone proves only layout and bounds. It provides no native
padded-target, other-phase or ordinary-renderer claim.

Public integration tests should add policy anchors/interiors/clamps, unknown
SM/batch fallbacks, ordinary/mixed/dual caches, FP16, offsets and mutable capture,
both target classes, empty batch, and invalid/gradient contracts. Compare public
results to the independent composition. Finally compare complete prepared
heads and requested boundaries before/after the graph hook for FP8 packed,
FP8 Half storage and FP16, including a geometry with width/height reversed to
catch target-axis mistakes. A full-network graph replay must preserve the
post70 skip and eliminate only the raw block0/pool intermediate allocations.
