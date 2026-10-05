# Experimental post70 fusion

The fused kernel is compiled in v13 and passes its 85 focused GPU tests and
Compute Sanitizer memcheck. Its measured public dispatch and prepared-model
hook are activated for the v14 build; integration validation is pending.
The rotated C32 body now uses input and output policies;
`block32_post70.integration.patch` records the initial refactor proposal.
The standalone rotated operator retains its signature and shares
the entire FFN, normalization, attention and projection implementation.

The post input policy reads `low[B,h,w,32]` and
`adapter[B,H,W,32]`, where `H <= 2h` and `W <= 2w`. Both inputs independently
accept half or logical E4M3 bytes. For a valid output location `(b,y,x)`, it
computes the following using native half2 instructions:

```
scaled_low = half(low[b,y//2,x//2] * input_scale)
raw_merge = half_fma(adapter[b,y,x], adapter_scale, scaled_low)
state = publish_E4M3(raw_merge)
```

This order follows original post SASS: `HMUL2` at PC `0x1950`, then `HFMA2`
at `0x1af0` in the reviewed original C32 up/post sequence. These are distinct
rounding points. FP32 FMA followed by half conversion is insufficient for a
half-midpoint plus a subnormal tie breaker. The raw merge remains the FFN
residual; the E4 publication is only its matrix input. Shifted-window padding
is zero before the FFN seed is formed. No global merged tensor is created.

The post output policy consumes raw half projection fragments. Two consecutive
N8 fragments are already one `m16n8k16` half A operand:
`[C(2h,row0), C(2h,row1), C(2h+1,row0), C(2h+1,row1)]`.
It executes head K16 chunk0 followed by chunk1, with a zero initial half
accumulator. The head weights remain ordinary half `[4,32]`; their K dimension
is not rotated. Four result channels are converted to FP32 and stored. No
published C32 output, raw C32 output or half head input is materialized.

The private API is `_inference_post70_rotated`, returning FP32
`[B,H,W,4]`. It requires the four persistent dual-layout C32 weight caches,
half scales/prior and a half head matrix. It defaults to the original post
phase1; all phases are available for diagnostics. The launcher validates
cropped geometry, repairs offset-view alignment and rejects backward use.
The input policy receives token coordinates directly from the common core,
so it does not reconstruct them with division by the image width or height.

The public `inference_post70` API accepts ordinary or dual-cache FP8 matrices
and ordinary FP16 matrices. It uses the generated policy
`aa75da0b438eab9a` for the eight measured SM120 configurations. Half and packed
storage have separate families; only phase1 was measured. Unknown devices,
phases and storage combinations, absent complete caches, and FP16 all use
the existing composed operators. Selection transfers the nearest measured
shifted-window count and clamps beyond endpoints. A transferred choice is
not a measured speed claim for an unmeasured shape.

`DLSSNR._post_head` keeps one shared graph implementation. Prepared inference
calls public C++ dispatch when boundary capture is disabled; requested
boundaries use the existing composed path so all 77 graph boundaries remain
available. Training continues through ordinary differentiable operators.

The focused suite compares against the existing separate operators:
upsample/true-half residual, E4 publication, the forced shared C32 oracle,
and ordered half head GEMM. It covers four input-storage combinations, all
phases, batch two, irregular and tiny crops, original block70 weights, changed
inputs during graph replay, offset views and a half-FMA midpoint fixture.
Original native post-kernel comparison remains required. Matched-I/O graph
timings against the current composed deployment path are saved in
`outputs/post70_v13.json`. All eight cases are bit exact. With packed low and
adapter tensors, fused/composed times are 7.902/16.518 us at 128x128,
26.491/58.731 us at 576x512, 174.336/672.585 us at 1152x1920, and
689.344/2759.840 us at 2176x3840 (H x W). These are post-stage times with the
same FP32 head output, not full-network or original-DLL timing.

The packed 1152x1920 NCU run is
`profile/post70-fp8-b1-1152x1920-phase1-low1-adapter1-20261003T004742_797581Z`.
It reports 215.71 us with cold replay, 144 registers, no spills or shared
memory, and 23.95% achieved occupancy. Tensor throughput reaches 45.22%, L2
9.32% and DRAM 24.94%; the 85% gate is not met. The leading sampled stalls
are fixed execution dependency (31.94%), math-pipe throttle (12.85%) and long
scoreboard (12.08%). These measurements support eliminating intermediate
traffic, while further instruction/latency work remains.

Reproduce timing with `python tests/benchmark_post70.py --storage all` and
collect counters with `python -m tuning.profile_post70 --height 1152 --width
1920 --packed-low --packed-adapter`. Static weights and publications are
prepared before timing; the separate path includes all required intermediate
operators and the generic compiled C32 selection policy.

`tools/probe_post70_layout.py` independently checks all 2,048 half coordinates
in the projection-to-head mapping, 285,648 unique output-channel writes over
24 shifted/cropped geometries, and the distinguishing half-FMA fixture. It
pins the original post SASS digest and the two merge instruction PCs. Results
are in `outputs/post70_layout_cpu.json`; they are CPU layout evidence only.
