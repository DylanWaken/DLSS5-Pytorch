# Private post70 operator with original physical I/O

The private `_inference_post70_physical_surface` operator removes the gather
tensors and final tensor-to-surface copy from the recovered post70 endpoint
comparison. Its arithmetic reuses the rotated C32/post-head implementation.
Production BHWC entrypoints and dispatch policy are unchanged.

The v15b all-architecture build passed. SM120 compilation reports 146 registers,
zero shared memory, zero stack and zero spills for this kernel. Build log:
`build_deployment_v15b_compile.log`. Compiled binary SHA256:
`a6f138778a2ee3cc4d2072fd55ff86ffffcebad7a42f6605d2e1a9bb722ff0ab`.
GPU correctness, sanitizer checks and speed were still pending when this note
was written; compilation is not evidence that it beats the original.

## Exact interface

```python
torch.ops.dlssnr._inference_post70_physical_surface(
    low_physical, adapter_physical, height, width, surface_handle,
    input_scale, adapter_scale,
    w1, w2, qkv_weight, projection_weight,
    ffn_scale, attn_scale, head_scale, bias, head_weight,
    phase=1,
)  # returns None; queues writes to the borrowed surface
```

The operation supports one image, with height and width from 16 to 4096 and
divisible by 8. Phase is 0 through 3. Inputs are flat contiguous CUDA uint8
tensors on one device:

- Low state contains `(H/2)*(W/2)*32` E4M3 bytes in the original 16-channel-plane
  layout, matching `tools.vendor_downsample_probe.down_offsets`.
- Adapter contains `H*W*32` E4M3 bytes in the original 4x4 tile layout, matching
  `tools.vendor_window_benchmark.image_offsets`.
- Both inputs are packed bytes. The public BHWC API's optional half adapter
  does not apply to this private native-layout interface.
- W1, W2, QKV and projection are the existing canonical-plus-rotated uint8 dual
  caches `[2,128,32]`, `[2,32,128]`, `[2,96,32]` and `[2,32,32]`.
- Input, adapter, FFN and attention scales are half `[32]`; head scale is half
  `[1]`; bias is half `[1,64,64]`; head weight is half `[4,32]`.

The launcher repairs pointer alignment through capture-compatible clones only
when needed: two bytes for physical inputs, four bytes for scales/bias/head,
and 16 bytes for weight caches. Ordinary aligned inputs launch a single kernel.

## Borrowed surface ownership

The caller creates and retains a CUDA surface object backed by an RGBA32F CUDA
array on the same device/context as the input tensors. The array must cover at
least `H x W`. The operator writes the top-left field; a larger array's border
is untouched. Output is raw head RGB converted from half to float and literal
positive-zero alpha. The fourth neural blend logit is intentionally not exposed
by this recovered original endpoint contract.

The integer argument must be a positive nonzero handle. That representation
check does not establish that an arbitrary number names a live surface. CUDA
surface handles are opaque identifiers, not pointers, so no invented pointer
alignment requirement is imposed on the handle. The kernel does not create,
query or destroy the surface or array. The owner must keep all resources alive
through every queued call and graph replay, synchronize, and only then destroy
them. Tests use the existing `tools.vendor_cuda_image.CudaImage` owner.

Only eager CUDA and CUDA Graph capture/replay are supported. The external array
write is a side effect outside Torch tensor alias tracking; this private void
operator is not an API for `torch.compile`, functionalization or autograd.
Calls that require gradients raise before launch. Hardware capability uses the
existing per-device cache, populated during weight preparation/warmup; there
are no per-launch borrowed-surface or context-resource queries during capture.

## Validation prepared

`tools/post70_physical_layout.py` and
`outputs/post70_physical_layout_cpu.json` establish address agreement with the
original physical mappings, aligned adjacent channel pairs and exactly one
surface writer per pixel across all four phases. This is a CPU coordinate proof.

`tests/test_post70_physical_surface.py` contains 58 GPU cases:

- 36 original-cubin and public-head comparisons over three geometries, all
  phases and zero/random/high inputs, with immutable inputs and surface borders.
- 8 CUDA Graph replay cases, including misaligned views and changed input bytes
  at the same captured addresses.
- 14 invalid-contract cases that must raise before any surface write.

The native comparison disables optional proxy/history/motion textures, uses
RGB output scale 1 and conversion flag 0, and checks alpha 0. This scope does not
cover complete renderer composition, the fourth blend logit or the NGX host.
