# Resident original-kernel trunk replay

The current default uses unchanged `cc_vit_1d_attention_chained_fp8` for global
attention. Static original-host code confirms its launch dimensions and ABI;
its internal CTA barrier differs from the unstable plain entry. The harness
passes actual completed QKV counters and a guarded output completion buffer,
whose reset is inside native timing. At720p and1080p, all74boundaries pass on
the first launch and two additional complete replays, then remain stable during
graph timing (`outputs/vendor_trunk_chained_{720,1080}_v13.json`). Native
medians are2.187072/2.544256ms and half-storage candidate medians5.447680/
8.614176ms; both native-speed gates fail. This is a stable path toward the931
geometry sweep, not a claim that the unmeasured domain or renderer endpoints
already pass. `--native-attention plain` retains the diagnosed route for
reproduction. See [the attention ABI and evidence](vendor_attention_race.md).

The target comparison begins at `transition-0-1`, after the initial feature
adapter, block 0, and its pool. Supply that tensor once, then compare original
kernels and the prepared extension from the same published FP8 values. The
endpoint is block 69, before full-resolution block 70 and the final RGBA head.
A tensor supplied from the prepared model is an input fixture; it does not
independently validate the upstream adapter or block 0.

`tools/vendor_trunk.py` now executes this complete resident chain. At valid
644×768 (padded full field768×768), all74 checked boundaries and90,980,352
bytes matched exactly. Levels were384²,192²,96²,48²,24²,12²; global attention
used144 tokens. The fixture was a seeded synthetic published transition0→1
input. Guards, immutable inputs/weights, counters, and graph replay passed.
The retained report is `outputs/vendor_trunk_644x768_v9.json`.

Both sides timed identical resident packed physical input/output boundaries,
including candidate layout conversions. Original median latency was2.05549ms,
candidate4.38525ms (2.13343× original), so this speed gate fails. This single
geometry proves neither all931 geometries nor the excluded texture endpoints.
Individual native comparisons are recorded in [vendor_runtime.md](vendor_runtime.md).

The second replay at valid1280×720, including padded C256/C512 transitions,
also passes all74 boundaries. Original2.16899ms and candidate5.77651ms give a
2.66322× speed gap in `outputs/vendor_trunk_1280x720_v10.json`. The resumable
range adapter's `--families trunk` now enumerates all931 geometries; enumeration
does not imply those unmeasured cases pass.

The follow-up found intermittent mismatches beginning at original global
attention, with identical preceding Q/K/V and stable candidate results.
Racecheck reports shared-memory WAR hazards in that unchanged cubin under the
documented launch. A successful single replay must not be generalized to stable
full-range parity; the original NGX host launch has not been captured.
Independent native attention address enumeration supports32-token allocation
padding; an uncached Compute Sanitizer run using that original extent reports
0errors and all74 boundaries exact at1280×720. Diagnostic64/256-token padding
changed outcomes without establishing a cause, so32 remains the default.
`tools/vendor_global_stability.py` isolates five original global-chain replays
from five candidate replays using a frozen original global31 input. Affected
comparisons retain an inconclusive native-reference gate. The explicit
`--diagnostic-native-timing` mode can retain all931 geometries' raw samples and
first-pass mismatches without treating an unstable reference as a verified
speed baseline. See [the retained race evidence](vendor_attention_race.md).

Use `--packed-activations` in `tools/vendor_trunk.py` or
`run_tuning.py native-range` to exercise the packed candidate path. Both paths
still receive and emit the same original packed physical endpoint layouts;
all candidate conversions remain inside the measured CUDA graph.

## Layout chain

There are three relevant image/token layouts:

- Ordinary window kernels use packed 4×4 spatial tiles with the native MMA
  channel fragment layout. `image_offsets` is verified through C1024 geometry
  as a CPU bijection and against native C32 through C512 blocks and the
  C512→C1024 bottleneck projection.
- Encoder `_ds_fp8` outputs and decoder stage-ending `_outview_fp8` outputs
  use consecutive 16-channel planes with raster pixels and a within-plane
  channel permutation. The encoder plane mapper is verified against original
  C32/64/128/256 down-projection outputs at exact half size.
  Original input-view and output-view window entries are now verified at12×20
  for C32/64/128/256, all four phases and two blocks per width:192 cases and
  5,529,600 output bytes match exactly. C512 input-view and output-view probes
  now each verify2,949,120 bytes over all four intermediate boundaries.
- `_vit_1d_*` stages use flattened token tiles. The original
  `cc_vit_1d_repack_2d_to_1d_fp8` and reverse entry bridge spatial tiles and
  flattened token order. Their 24-byte structs contain source, destination,
  height, and width. Both directions pass at12×12 (144 tokens with32-token
  allocation padding): six cases and884,736 exact bytes.

The implemented original chain is:

| Blocks | Original entries and connection |
| --- | --- |
| 1–4 | C32 `_inpview_fp8` first, ordinary windows next, `_ds_fp8` last; retain last ordinary published output as the C32 decoder skip |
| 5–8, 9–14, 15–22 | Same sequence at C64/C128/C256; retain each encoder's last output and pass its plane-view down-output to the next level |
| 23–30 | C512 `_ffwd_inpview_512_fp8` and `_ffwd_proj_inpview_512_fp8` first; the latter needs the still-plane-view residual. Ordinary four-stage blocks thereafter. Block30 ends with `_proj_pool_512_fp8`, retaining the ordinary C512 skip and producing pooled C512 tiles |
| 30→31 | `cc_split_swin_16h_final_head_512_fp8` projects pooled C512 to C1024. Despite its name this is the bottleneck input projection, not the RGBA head; its template is `Conv2d1x1Config<1024,512,...NoActivation>`. Repack the result to the 1D ViT layout |
| 31–38 | Five-stage resident original global blocks, with each stage's split counters reset before reuse |
| 39 | Repack to spatial tiles, then `cc_dec_input_upsample_1024_512_fp8`: four K partitions, ordered scratch accumulation, nearest upsample, and the retained C512 skip |
| 40–47 | Ordinary C512 four-stage blocks; block47 uses `_proj_512_outview_fp8` to produce the plane view for the C256 decoder |
| 48–55, 56–61, 62–65 | Each level begins with its fused `_upsample_fp8` entry, consuming a lower-resolution plane view and the canonical encoder skip. End each level with `_outview_fp8` |
| 66–69 | C32 `_upsample_fp8` first, ordinary windows next, and a final canonical or outview output depending on the chosen comparison boundary |

Stage-specific `_inpview`, `_outview`, pooling and upsampling launch shapes
must be reviewed individually; similar entry names do not guarantee identical
thread blocks. C512 ordinary FFN and final projection use eight warps; the
input-view FFN, output-view final projection, pool projection, and all FFN
contraction entries use four. The decoder1024→512 uses two warps and its
gridY is ceil(sourceH/4), not ceil(sourceH/8).

## Phase and geometry contract

Maintain a separate phase counter at every spatial level, shared across its
encoder and decoder. C128 has six encoder blocks, so decoder block56 begins
at phase2. C32/C64/C256/C512 decoder levels begin at phase0. The full-resolution
level has block0 phase0 and block70 phase1. Using `block_index % 4` is wrong.

Real graph levels round half sizes up to multiples of four. Exhaustive CPU
enumeration of931 geometries finds no padded halves atC32/C64/C128. C256 has
697 padded cases andC512 has718. Those transitions now have bounded independent
proofs and one complete padded-trunk replay; smaller unreviewed padded fields
are rejected before launch.
C64/C128/C256 reverse-crop probes12×20→20×36 already pass48 cases; the C32
diagnostic at that geometry fails because its original plane stride uses the
unrounded half extent, a situation absent from the requested domain.

C512 window+pool+512→1024 downsampling20×36→12×20 passes all six tested cases
and11,059,200 bytes. For C64/C128/C256 padded downsampling, static PTX shows
the zero-fill loop writes twice the logical FP8 plane footprint. The diagnostic
allocator reserves that entire workspace with guards outside it. C128/C256
pass24 cases and5,529,600 bytes; all extra writes are zero, and outer guards
remain intact. Padded C64 differs numerically and remains unsupported, but
that transition is absent from the requested domain. This footprint alone does
not establish the original host allocation contract. Original decoder1024→512
exact8×8→16×16 passes393,216 bytes; padded12×20→20×36 now passes three cases
and1,105,920 bytes. Reports are `outputs/vendor_downsample_padded_workspace_20x36.json`
and `outputs/vendor_up512_padded_12x20.json`.

## Endpoint limitations

The original feature adapter and final RGBA matrix are fused into the module0
pre/post wrappers. No texture-free standalone entry for either was found in
the 223 network entries. The eight additional utility fatbins were also
inventoried statically: font, capture, motion capture, exposure capture,
buffer-to-texture capture, clear, postprocess, and copy. They contain no GEMM.
Those wrapper launches require reviewed CUDA texture/surface objects and scene
parameters. A successful trunk replay cannot establish complete rendered-image
or NGX host-runtime parity, and its latency is a kernel-replay measurement.
