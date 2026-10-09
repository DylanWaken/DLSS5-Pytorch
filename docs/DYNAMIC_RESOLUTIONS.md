# Arbitrary supported image resolutions

FP8 and FP16 deployment plans compute their geometry at runtime in C++.
An image size no longer needs an entry in a generated resolution table, a new
JSON plan, tuning run or extension rebuild. Odd sizes, portrait images and
ultrawide images use the same network padding rules as the training geometry.

```python
from dlssnr import Geometry, load_checkpoint

width, height = 1234, 777
geometry = Geometry.from_valid(width, height)
feature_width, feature_height = geometry.levels[0]

# prepared_state contains native FP16 plane16 features, stored as CUDA uint8.
# It is the prepared-feature trunk input, not an RGB image or a BHWC tensor.
expected_bytes = feature_width * feature_height * 32 * 2
assert prepared_state.numel() == expected_bytes

checkpoint = load_checkpoint("ckpts/dlss5_nr_fp16.pt")
plan = checkpoint.create_plan_fp16(prepared_state, width=width, height=height)
result = plan.run_fp16()
```

Use the FP8 checkpoint/method and one byte per feature element for FP8. The
valid image dimensions describe the requested field. The caller must supply
features in the resulting **padded physical layout**; changing a tensor's shape
or byte count does not perform packing. Renderer input/output preparation
remains outside the measured trunk.

Each plan owns its computed allocation extents, 185 logical launch grids and
scalar arguments. C++ derives them from the six network levels, window phases,
token padding and precision-specific layouts. A padded downsample retains its
extra clearing workspace. FP16 keeps its independent packing and decoder
scratch conventions. The four saved benchmark plans remain reference fixtures,
rather than an admission whitelist.

Create a new plan outside CUDA Graph capture when the image resolution changes.
The plan's buffers and prepared individual operators then keep fixed extents.
Both full C++ execution and `torch.compile` compositions use those same
descriptors. Replacing a prepared tensor with a different physical extent is
still rejected.

Resolution-policy lookup can clamp its query to measured extrema; it does not
resize the actual image, allocation or launch grid. With no tuned configuration
for a shape, the reconstructed configuration remains available. Accepting a
shape is separate from measuring its speed or qualifying a tuning policy.

## Limits and validation

The architecture target remains SM120, batch one. Dimensions must be positive
integers. Padding must satisfy the recovered operands, including complete
eight-pixel windows at the first level. Signed index and CUDA grid limits are
checked before allocating intermediates; the requested buffers must also fit
available device memory. Some very small dimensions fail the original padding
contract and are rejected rather than silently assigned different geometry.

The compiled C++ geometry is compared against the independent Python physical
schedule for all buffer sizes, launch grids and scalar fields at anchor,
rounding-boundary, odd, portrait, ultrawide and deterministic random sizes.
Separate GPU tests compare published values and replay behavior against the
extracted original kernels at additional non-anchor resolutions. See the
[validation receipt](small_gpu_validation.json) for the exact cases, binary and
device; arbitrary-resolution admission does not imply exhaustive numerical or
performance testing of every possible size.

The [small-GPU scheduling change](SMALL_GPU_SCHEDULING.md) applies to these
runtime grids too: reductions exceeding resident capacity automatically use
ordered split launches.
