# Network architecture

Start with the whole network, then follow the arrows inside one block. The expanded views show **which tensor goes where**, its shape, and where branches split or join. Repeated blocks share a diagram; the tables below map every numbered record to its implementation.

## The whole network

![Full network with stages and skip connections](figures/architecture/network.svg)

The encoder saves detailed features at five resolutions. The bottleneck exchanges information across the entire coarse image. The decoder brings that context back to higher resolutions and combines it with the saved encoder features.

The master diagram uses **width × height** at a valid 3840 × 2160 input. Expanded diagrams use **[height, width, channels]**, matching tensor axes; batch is omitted unless written explicitly. Padding belongs to the network geometry, so a level is not always exactly half the preceding field.

## Follow one block

An ordinary block preserves spatial size and channel count. First its FFN mixes channels **at each position independently**. Then attention lets positions exchange information. Each operation has a separate learned, channelwise residual path.

![Tensor flow through an ordinary block, including both residual branches](figures/architecture/residual_block.svg)

Green boxes represent tensors, rounded boxes represent operations, and `+` circles are elementwise additions. Amber dashed arrows carry bypass or side inputs, such as residuals and saved skips. `Publish` marks a working-precision boundary without changing shape. `Raw` names the value before that publication, retained for particular residual and transition paths.

The block runs **FFN before attention**. Q and K are normalized within each 32-channel head; there is no separate pre-FFN LayerNorm. [Numerical details](architecture/NUMERICS.md) explain the activation, normalization and attention exponential.

## Open a component

| What you want to understand | Tensor-flow view |
|---|---|
| How channels are mixed at each pixel | [Four FFN families](architecture/FFN.md) |
| How a pixel reads its 8 × 8 neighborhood | [Window attention: Q, K, V and weighted values](architecture/ATTENTION.md#local-window-attention) |
| How windows change between blocks | [Window partitioning and shifted boundaries](architecture/ATTENTION.md#how-windows-cover-the-image) |
| How coarse positions communicate across the whole image | [Global bottleneck attention](architecture/ATTENTION.md#global-bottleneck-attention) |
| Where encoder skips and the next level come from | [Encoder down-transition](architecture/TRANSITIONS.md#encoder-save-detail-and-reduce-the-field) |
| How low-resolution context joins high-resolution detail | [Decoder up-transition](architecture/TRANSITIONS.md#decoder-restore-the-field-and-add-the-skip) |
| How 16 features enter and a four-channel head leaves | [Input and output blocks](architecture/ENDPOINTS.md) |

## Which diagram applies to each block?

Weights differ between records. The operation flow is shared within each family.

| Channels | Numbered blocks | Channel mixing | Spatial mixing |
|---|---|---|---|
| 32 | 0–4, 66–70 | [Dense 32 → 128 → 32](architecture/FFN.md#dense-ffn-c32-and-c1024) | [One local head](architecture/ATTENTION.md#local-window-attention) |
| 64 | 5–8, 62–65 | [Two full-input branches](architecture/FFN.md#full-input-branches-c64-c128-and-c256) | Two local heads |
| 128 | 9–14, 56–61 | [Four full-input branches](architecture/FFN.md#full-input-branches-c64-c128-and-c256) | Four local heads |
| 256 | 15–22, 48–55 | [Eight full-input branches](architecture/FFN.md#full-input-branches-c64-c128-and-c256) | Eight local heads |
| 512 | 23–30, 40–47 | [Premix, eight groups, postmix](architecture/FFN.md#grouped-ffn-c512) | 16 local heads |
| 1024 | 31–38 | [Dense 1024 → 4096 → 1024](architecture/FFN.md#dense-ffn-c32-and-c1024) | [32 global heads](architecture/ATTENTION.md#global-bottleneck-attention) |
| 1024 → 512 | 39 only | [Projection and up-transition](architecture/TRANSITIONS.md#decoder-restore-the-field-and-add-the-skip) | No FFN or attention |

Input block 0 adds an adapter before the ordinary body. Output block 70 adds a merge before it and a head after it. Encoder tails and decoder entry blocks also perform transitions.

## Track a tensor between levels

Padded **width × height × channels** for the same 4K example:

| Stage | Records | Field | Saved skip or incoming merge |
|---|---|---|---|
| [Input](architecture/ENDPOINTS.md#input-block-0) | 0 | 3840 × 2176 × 32 | Save for 70; pool to 1 |
| [Encoder C32](architecture/TRANSITIONS.md#encoder-save-detail-and-reduce-the-field) | 1–4 | 1920 × 1088 × 32 | 4 → 66 |
| Encoder C64 | 5–8 | 960 × 544 × 64 | 8 → 62 |
| Encoder C128 | 9–14 | 480 × 272 × 128 | 14 → 56 |
| Encoder C256 | 15–22 | 240 × 136 × 256 | 22 → 48 |
| Encoder C512 | 23–30 | 120 × 68 × 512 | 30 → 39 |
| [Global bottleneck](architecture/ATTENTION.md#global-bottleneck-attention) | 31–38 | 60 × 36 × 1024 | All positions exchange information |
| [Up-transition](architecture/TRANSITIONS.md#decoder-restore-the-field-and-add-the-skip) | 39 | 120 × 68 × 512 | Merge 30 |
| Decoder C512 | 40–47 | 120 × 68 × 512 | Continue from 39 |
| Decoder C256 | 48–55 | 240 × 136 × 256 | Merge 22 at 48 |
| Decoder C128 | 56–61 | 480 × 272 × 128 | Merge 14 at 56 |
| Decoder C64 | 62–65 | 960 × 544 × 64 | Merge 8 at 62 |
| Decoder C32 | 66–69 | 1920 × 1088 × 32 | Merge 4 at 66 |
| [Output](architecture/ENDPOINTS.md#output-block-70) | 70 | 3840 × 2176 × 4 | Merge 0, then produce head |

## Scope and regeneration

The diagrams follow [model.py](../dlssnr/model.py), [geometry.py](../dlssnr/geometry.py) and the dimensions decoded by [weights.py](../dlssnr/weights.py). They show logical computation. CUDA fuses operations and uses packed FP8/FP16 layouts: an arrow need not be a global-memory write, and a box need not be a kernel launch. The [kernel reading guide](KERNEL_READING_GUIDE.md) maps operations to CUDA source.

Training covers all 71 records, 0–70. The measured deployment trunk covers prepared features through 1–69. Renderer feature extraction and temporal reprojection remain external. Actual DLSS5 transfer-learning losses and training procedures still require investigation.

Regenerate the SVGs and [source/shape ledger](figures/architecture/source-map.json):

```powershell
python -B tools/render_architecture.py
```

These diagrams represent this implementation, not recovered NVIDIA source diagrams.
