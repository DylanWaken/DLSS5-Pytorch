# Native FP16 kernels: what exists and what remains to prove

The pinned DLSS-NR DLL contains real FP16 counterparts throughout the network.
CPU inspection found **109 entry points** containing
`mma.sync.aligned.m16n8k16.row.col.f16.f16.f16.f16`. This is instruction evidence,
not a conclusion based only on missing `_fp8` suffixes. The cached cubins also
contain these functions; their resource/SASS listings include Half tensor-core
instructions. The seven PTX modules target `sm_120`. These assets do not provide
an unchanged original SM80/SM89 speed reference.

`tools/vendor_fp16_inventory.py` verifies the DLL, PTX and cubin hashes against
the existing extraction manifest, inventories exact symbols and parameter
reads, enumerates PE resources, and proves a bounded proposed C32 layout. It
uses the Python standard library and has no GPU execution option. Its output
is `outputs/vendor_fp16_cpu_inventory.json`.

## Kernel coverage and parameter blocks

The following ordinary symbols are present. Additional wait, tilesync and
chained variants appear in the inventory and need their own synchronization
review before use. The table lists by-value parameter block sizes, not a claim
that the FP8 pointer/buffer contract can be reused.

| Module | Role | FP16 symbol | Parameter bytes |
|---|---|---|---:|
| 0 | Input adapter/block | `cc_tinlayout_fused_pre_block_swin_1h_32_1` | 264 |
| 0 | Input adapter/block/pool | `cc_tinlayout_fused_pre_block_swin_1h_32_1_ds` | 264 |
| 0 | Output block/head | `cc_tinlayout_fused_post_block_swin_1h_32` | 184 |
| 0 | C32 window | `cc_tinlayout_fused_swin_1h_32_1` | 96 |
| 1 | C64 window | `cc_tinlayout_fused_swin_2h_64_2` | 88 |
| 2 | C128 window | `cc_tinlayout_fused_swin_4h_128_4` | 88 |
| 3 | C256 window | `cc_tinlayout_fused_swin_8h_256_8` | 88 |
| 4 | C512 FFN branches | `cc_split_swin_16h_ffwd_512` | 56 |
| 4 | C512 FFN projection | `cc_split_swin_16h_ffwd_proj_512` | 72 |
| 4 | C512 QKV/attention | `cc_split_swin_16h_qkv_512` | 56 |
| 4 | C512 output projection | `cc_split_swin_16h_proj_512` | 72 |
| 4 | C512 projection/pool | `cc_split_swin_16h_proj_pool_512` | 80 |
| 4 | C512 down projection | `cc_split_swin_16h_final_head_512` | 40 |
| 5 | Global FFN expansion | `cc_vit_1d_ffn_expand` | 72 |
| 5 | Global FFN contraction | `cc_vit_1d_ffn_contract` | 72 |
| 5 | Global QKV | `cc_vit_1d_qkv` | 80 |
| 5 | Global attention | `cc_vit_1d_attention` | 64 |
| 5 | Global projection | `cc_vit_1d_projection` | 72 |
| 5 | Global layout adapters | `cc_vit_1d_repack_2d_to_1d`, `cc_vit_1d_repack_1d_to_2d` | 24 |
| 6 | Decoder 1024→512 transition | `cc_dec_input_upsample_1024_512` | 80 |

C32 ordinary PTX reads input/output/weight pointers at0/8/16, H/W at24/28 and
signed x/y origins at32/36. C64/128/256 retain pointers at0/8/16 but H/W move to
32/36 and origins to40/44. The extra fields remain outside the ordinary path;
down/up/view/synchronization variants must be inspected independently.

Global ordinary FFN expansion reads input0, output16, weights24 and batch/token
dimensions64/68. Contract/projection add skip8 and a completion pointer32.
QKV reads input0, Q8, K16, V24, weights32, completion40 and dimensions72/76.
Attention reads Q0, K8, V16, output24 and dimensions56/60. These assignments
follow the actual instructions and the paired FP8 wrappers; buffer layouts and
launch geometry still require FP16 calibration.

## Why replacing the symbol in an FP8 wrapper is unsafe

The FP16 global contract/projection entries do **not** read the FP8 scratch
pointer at40. They accumulate into Half output with
`red.global.v4.f16x2.add.noftz`, then use ordered completion stores and polling.
Examples occur at module5 PTX lines196235 and260572. FP16 QKV likewise omits
the separate scratch pointer at48 consumed by the FP8 entry. This changes
buffer reuse and reduction behavior despite unchanged ABI block lengths.
Completion counters, occupancy bounds and replay resets need a separate proof.
The known FP8 attention hazard cannot be used either to reject or certify the
different FP16 implementation.

FP16 activations also have a different physical layout. The ordinary C32 output
uses two512-byte N16 planes per16-token tile and eight128-bit stores per lane
across a full8×8 window. FP8 has four such stores and interleaves channel groups
inside bytes. Multiplying the existing FP8 offset map by two is incorrect:
token1/channel0 starts at byte64 in the proposed Half map, and token0/channel16
starts at512; the FP8 addresses are64 and8 respectively.

The helper derives a Half C-fragment map from these native stores and proves
it is bijective for64 tokens×32 channels. It has not yet been checked with a
native identity/basis calibration. Do not use that CPU proof as native byte
parity evidence.

## Checkpoint compatibility

PE resource enumeration of the pinned DLL finds only the147,695,410-byte
`10/WEIGHTS_HT/1033` payload and1184-byte version information. There is no
separate FP16 weight resource in this DLL. OpenDLSS-NR's README describes the
FP8 network, and `src/nr_model.cpp` describes only the input adapter and output
head as native F16 matrices. Its other matrix decoder reads E4M3 bytes and
undoes the within32-channel input permutation.

Our FP16 mode can use those learned values after exact E4→Half decoding, but
the original FP16 kernels expect larger, differently packed records. They
cannot consume the existing checkpoint record unchanged. Standard C32 gives a
small complete example:

| Field | Original cached FP8 offset | Candidate FP16 offset |
|---|---:|---:|
| FFN expansion | 0 | 0 |
| FFN contraction | 4096 | 8192 |
| FFN residual scale | 8208 | 16400 |
| QKV | 8288 | 16480 |
| Relative bias | 11360 | 22624 |
| Head scale/padding | 19552 | 30816 |
| Attention projection | 19568 | 30832 |
| Attention residual scale | 20592 | 32880 |
| Logical data end | 20656 | 32944 |
| Padded record allocation | 20672 | 32960 |

The FP16 offsets are present in the actual standard C32 PTX. The helper
reconstructs a candidate32960-byte record from real block1 checkpoint data:
decode each matrix to natural channels, repack it as K16/N16 Half B fragments,
and relocate the existing Half scales, packed relative bias and float head
scale without changing their bits. All12,288 matrix coordinates map uniquely.
The report hashes both source and derived records; it does not save a binary.
This establishes a reproducible comparison input, not the behavior of the
DLL's unexecuted host conversion or a separately trained FP16 checkpoint.

## Bounded next steps

Start with the ordinary C32 symbol, source16×24, phase0, one warp per8×8 window,
and separately guarded Half input/output and derived weight records. Before
real weights, use finite positive identity-residual/basis fixtures to calibrate
the activation map and individual W1/W2/QKV/projection layouts. Keep Q/K norms
nonzero in those fixtures. Then compare a real block1 derived record against
the ordered FP16 extension, including repeat output poisoning, input/weight
immutability, CUDA graph replay and sanitizer checks. Only after byte parity
should timing be enabled.

Extend to all window phases and C64/128/256 after proving their grouped weight
offsets and activation ownership. Map C512 and decoder transitions separately.
For global attention, first calibrate Half Q/K/V with synthetic matrices at
small token counts, then audit the FP16 completion/reduction protocol, including
its direct Half output accumulation. Add global components and connections
only after those gates pass. A native resident FP16 trunk comparison requires
all these connections; full DLL/renderer latency also requires pre/post texture
endpoints and host orchestration. None is implied by the current inventory.

## Bounded C32 address proof and staged execution helper

The next CPU pass now goes beyond a proposed bijection. The pinned ordinary
entry starts at module0 PTX line228944; its extracted body SHA256 is
`edbc95312c9200a4405f5cfa58dbd86511e1a21eae953020aab85843dae7c4e0`.
[vendor_fp16_c32_proof.py](../tools/vendor_fp16_c32_proof.py) interprets its
integer control and global-address instructions, while leaving tensor arithmetic
unknown. An unknown branch condition or global address fails the proof.
All149 static global instructions are recognized, including the eight128-bit
output stores. The entry has no shared-memory or CTA-barrier protocol.

The proof enumerates every CTA/lane at8×8,12×20 and16×24 through all four phases.
Across these12 cases, every input byte is covered, every output byte has exactly
one writer, every vector address meets alignment, and all accesses stay inside
the input/output or32960-byte derived-weight allocations. Native stores never
target inputs or weights. Weight reads touch32900 unique bytes and end at32944,
leaving the final16 padding bytes untouched. The results are retained in
[vendor_fp16_c32_address_proof.json](../outputs/vendor_fp16_c32_address_proof.json).
An independent review additionally invalidated2730 omitted numerical destinations
and reproduced all2176 lane traces, checking that stale integer values could not
make the bounded address proof pass incorrectly.

The input and output layouts are four-pixel image tiles in row-major tile order.
Each4×4 tile occupies1024 bytes: two512-byte N16 planes, each holding32 lane
vectors. Inside a plane the Half output fragment order also matches the next
Half input fragment. There is no FP8 K-channel permutation in this activation
map. Weight tiles instead use the standard K16/N16 B-fragment packing. All12288
Half matrix coordinates are bijective and lie in regions loaded by the actual
entry. Decoding the derived record back to logical tensors independently agrees
with `WeightArchive.decode_block(1)` for every matrix, scale, head scale and bias.

The staged helper is
[vendor_fp16_c32_probe.py.draft](../tools/vendor_fp16_c32_probe.py.draft).
It accepts only ordinary C32,4-aligned dimensions from8 to64 and phases0–3.
Its default path verifies assets and repeats the CPU address proof. Execution
requires `--execute`; no execution has occurred yet. There is no timing option.
The reviewed fixtures are positive identity residuals, an FFN basis spanning
all128 hidden channels, an attention/projection basis, and derived real block1
weights. The synthetic Q/K matrices keep valid-token norms nonzero.

Each raw native allocation and each externally provided candidate input/weight
tensor has guard regions. Native and candidate input/weight bytes are checked
after every comparison. Candidate results use the extension's own allocator;
they are retained and byte-checked, but do not acquire external guard regions.
The draft includes three output-poisoned launches and three separately checked,
output-poisoned graph replays per fixture/phase, with current-stream native
launches inside capture. Sanitizer execution remains a separate required check.

The CPU suite [test_vendor_fp16_c32_cpu.py](../tests/test_vendor_fp16_c32_cpu.py)
passes24 tests covering parsing, address and ABI bounds, unknown-address/control
rejection, activation roundtrips, independent real-checkpoint decoding and all
fixture roundtrips. The execution helper stays a draft while the native range
runner pins active helper hashes. Neither the original FP16 host conversion nor
native numerical parity, speed or complete FP16 trunk behavior is yet verified.
