# Tensor scheduling: isolate the assembler before changing the algorithm

The remaining FP8 window slowdown had a substantial compiler-backend cause.
Changing only the assembler removed most explicit NOP instructions while
preserving the tensor workload, register allocation budget, and source code.

## Evidence chain

1. In the archived C128 v6 source profile, the reference and candidate executed
   exactly **805,376 QMMA** warp instructions. The candidate's extra 659,520 issued
   instructions included **625,768 NOPs**. An instruction-count difference alone
   therefore did not show extra matrix work.
2. The first reference Expert PTX expansion visits four spatial tiles, with four
   N8 columns inside each tile. This is the same tile-outer/column-inner traversal
   used by the readable CUDA `Expert` and `Linear32` helpers. Reversing these loops
   was not justified by the recovered PTX.
3. Reference SASS scheduled independent QMMAs without intervening NOPs. CUDA
   12.8 SASS commonly inserted a NOP after each QMMA. The relevant instruction
   control highwords were `...ff60000000cff` in the reference and
   `...fde0000000cff` followed by a NOP with `...fe20000000000` in our build.
4. The cached reference cubin contains the compiler identification
   `Cuda compilation tools, release 13.4, V13.4.0`. This identifies the backend
   that produced that image; it does **not** establish the original DLL's source
   build compiler. A Driver JIT image can carry the driver compiler's version.
5. After the intervening source optimizations, CUDA 12.8 emitted PTX from the
   frozen v25 CUDA source. Assembling that exact
   PTX with CUDA 12.8 reproduced **all 76** frozen text sections, constants,
   function-scoped metadata, and resource records byte for byte. This controlled
   the experiment independently of the earlier v6 profile.
6. Assembling the **same PTX** with CUDA 13.4 changed the scheduling while keeping
   each listed kernel's register count and tensor-instruction count unchanged.

| FP8 window | Registers, both backends | NOPs, 12.8 | NOPs, 13.4 | Static instructions, 12.8 → 13.4 |
|---|---:|---:|---:|---:|
| C32 | 168 | 110 | 8 | 2,512 → 2,410 |
| C64 | 159 | 120 | 13 | 2,024 → 1,877 |
| C128 | 163 | 158 | 11 | 2,272 → 2,076 |
| C256 | 163 | 204 | 12 | 2,392 → 2,152 |

These are static per-function counts. They are not latency estimates or a
substitute for GPU timing. Both backends report zero stack and local-memory use
for these four functions. The controlled experiment demonstrates a backend
scheduling difference; it does not recover NVIDIA's internal latency tables.

## Reproducible build selection

The build helper `tuning/cuda_toolchain.py` accepts `DLSSNR_PTXAS_PATH` explicitly. It copies
that executable into a private, SHA-256-named build directory and returns:

- `--dont-use-profile`, so nvcc does not prepend its original assembler directory;
- the original toolkit's libdevice and include paths, including Conda Windows
  `include/targets/x64` when present;
- a PATH prefix containing the private assembler, followed by the original
  toolkit's `nvvm/bin` and `bin` directories.

The helper verifies that `cicc`, `cudafe++`, `fatbinary`, and `nvlink` still resolve
to CUDA_HOME. It leaves PyTorch's CUDA version check in place and modifies no
installed toolkit. An unset environment variable retains the normal build.
The assembler's SHA-256 also appears in an unused compiler definition. Changing
the selected assembler therefore changes Ninja's recorded compile command and
invalidates cached objects; changing PATH alone would not reliably rebuild them.
`setup.py` explicitly emits `compute_120`/`sm_120` and rejects a different
`TORCH_CUDA_ARCH_LIST`; this measured deployment build is SM120-only.
This is a validated mixed-tool build configuration, not a claim that NVIDIA
officially guarantees every cross-version assembler combination.
The tested Windows configuration uses CUDA 12.8.93 nvcc, CUDA 13.4.59 ptxas,
and PyTorch 2.8 with its CUDA 12.8 runtime.

The resulting cubin matches the independently assembled CUDA 13.4 cubin in all
76 kernels' text, constants, function-scoped metadata, and resource records.
A full host/device object also
compiled successfully using the original CUDA 12.8 host glue and fatbinary tool.

## Local reproduction receipts

These files are retained locally under
`outputs/semantic-rewrite/toolchain-scheduling/`. The portable evidence JSON
linked below embeds the controlled-build records for readers without that local
experiment directory.

- `build.json`: identical-PTX dual-assembler commands and output hashes.
- `baseline-reproduction.json`: CUDA 12.8 reproduces the frozen baseline.
- `sass-summary.json`: instruction counts and resources for both backends.
- `assembler-selection.json`: selected executable identity and resolved helpers.
- `driver-selection-equality.json`: integrated driver selection matches manual
  CUDA 13.4 assembly exactly.
- `driver-object-v1.json` and `driver-object-v1-dryrun.log`: complete host/device
  object build and stage commands.
- `cache-key-proof.json`: two real assembler binaries, with CUDA_HOME held
  constant, produce distinct compile commands through their digest definitions;
  selecting either binary again reproduces its flags.
- `initial-driver-failure-note.json`: explicitly reconstructed note of the first
  missing-CCCL-header failure; it is not presented as an original raw log.

Earlier NCU-derived dynamic work and native SASS evidence remain in
`profile/semantic-window-fp8-instruction-audit-v16/analysis/`.

Portable assembler identities, controlled-build results and SASS counts are retained in [compiler_scheduling_evidence.json](compiler_scheduling_evidence.json). Final graph qualification is reported in [the benchmark overview](BENCHMARKS.md).
