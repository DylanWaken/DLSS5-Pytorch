# Native trunk continuous-range run

Run from `D:\Research\DLSSNR-PyTorch`. The v24 extension used for the completed
run is saved at `outputs/binaries/v24/_C.cp311-win_amd64.pyd`, with SHA256
`baab87033c6725bd298db2d42fb00a48f2d19290471574ade2dc3a6ff9c9cf98`.
Use a new output/journal for a different binary or measurement identity.

The completed v24 run has 931 committed cases, zero numerical/integrity
failures, and 931 failed speed gates. A no-op resume preserves the canonical
journal digest; both audits are retained. The unweighted geometry median of
candidate/native latency ratios is 1.910, with range 1.484–2.057. See
`outputs/native-trunk-v24-completion.json` for the hashed completion artifacts.
Later builds and helper edits intentionally fail this historical journal's
current-source identity checks; they require a fresh measurement journal.

## Coverage and comparison contract

The inclusive domain is width **1280–3840**, height **720–2160**: **3,690,401**
integer input sizes, represented by **931** actual padded geometries. The scanner
inspects every integer axis state, including non-monotone padding and the coupled
width/height alignment branch. A CPU audit checks that the rectangles cover each
row without overlaps/holes, that their corners reproduce the actual geometry,
and that every distinct geometry has exactly one trunk case.

Manifest SHA256 is
`815376f179aa8b31543f71fb0c61420a4edd21377eac81adf9415c61eccf32ec`.
Anchor IDs are 0 (1280×720), 212 (1920×1080), 442 (2560×1440), and
900 (3840×2160). ID900 is the actual 4K geometry; the last ID need not be 4K
because padding is not monotone.

Each measured case runs **original extracted SM120 cubins for blocks1–69**,
using the original checkpoint and chained global-attention entry point, against
the prepared packed-activation implementation on the same device. Native input
is the published block0→1 boundary in 16-channel planes; output is the published
block69 boundary in 4×4 tiles. Candidate endpoint layout conversions are timed.
Original internal view/repack adapters, encoder down transitions, decoder skip
merges, and original attention counter resets are included. Candidate internal
encoder pools are included too. Original inputs/weights and cached candidate
weights are checked immutable; allocations are guarded.

**Excluded:** DLL/NGX host execution, renderer preprocessing, block0 (including
the new adapter+pool fusion), block70/post surface output, host transfers,
allocation/preparation, and correctness checks. The pool policy version remains
in provenance even though block0 fusion is outside this timing. Branch, global,
window, C32, GEMM and other applicable compiled policies are recorded as well.
FP16 is not included in this comparison. Separate bounded probes map ordinary
FP16 window entries; FP16 transitions, global completion/reduction and the
complete native FP16 trunk remain unverified.

All **74 internal published boundaries** are compared byte-for-byte on an
initial execution and two original replays. Timed graphs are warmed, their public
endpoint bytes are poisoned outside capture/timing, then replayed twice against
preserved reference bytes. Subsequent timing stability and immutable weights are
checked again. This tests a deterministic synthetic published input per geometry,
not every possible tensor value. The all-boundary check is eager; poisoned graph
validation covers the public trunk endpoint.

Every case records native and candidate resident CUDA Graph event samples. A
candidate/native median ratio above1 is a `speed_gap`; the aggregate cannot pass
if even one measured case has a gap, lacks correctness evidence, or remains
unmeasured. `whole_dll_speed_gate` remains `unverified` even if every trunk case
passes. Event timings do not establish the 85% NCU roofline gate.

## CPU preflight

```powershell
.\.venv\Scripts\python.exe tools/native_range_audit.py --output outputs/native-trunk-v24-preflight.json
.\.venv\Scripts\python.exe run_tuning.py native-range --families trunk --packed-activations --native-attention chained --width-min 1280 --width-max 3840 --height-min 720 --height-max 2160 --warmups 3 --repeats 15 --batch 3 --output outputs/native-trunk-v24-manifest.json
```

The dry run must report 931 unmeasured supported cases. Run the bounded GPU check
only after v24 validation and exclusive GPU availability. Preserve these timing
settings for smoke, continuation, and no-op resume.

## Bounded GPU check, then full continuation

```powershell
.\.venv\Scripts\python.exe run_tuning.py native-range --execute --families trunk --packed-activations --native-attention chained --width-min 1280 --width-max 3840 --height-min 720 --height-max 2160 --warmups 3 --repeats 15 --batch 3 --geometry-ids 0 212 900 --output outputs/native-trunk-v24.json
.\.venv\Scripts\python.exe tools/native_range_audit.py --report outputs/native-trunk-v24.json --allow-selected --require-complete --expected-binary-sha256 baab87033c6725bd298db2d42fb00a48f2d19290471574ade2dc3a6ff9c9cf98 --output outputs/native-trunk-v24-smoke-audit.json
```

Inspect all three rows: 74 exact boundaries, two native boundary replays,
post-capture poisoned-graph evidence for both paths, intact guards/immutable
weights, and no native-reference hazard. A speed gap does not invalidate timing
or numerical coverage, but must remain a failed speed gate. Fix any numerical or
integrity failure before the long run.

Continue with the same output path and remove only the geometry filter:

```powershell
.\.venv\Scripts\python.exe run_tuning.py native-range --execute --families trunk --packed-activations --native-attention chained --width-min 1280 --width-max 3840 --height-min 720 --height-max 2160 --warmups 3 --repeats 15 --batch 3 --output outputs/native-trunk-v24.json
.\.venv\Scripts\python.exe tools/native_range_audit.py --report outputs/native-trunk-v24.json --require-complete --expected-binary-sha256 baab87033c6725bd298db2d42fb00a48f2d19290471574ade2dc3a6ff9c9cf98 --output outputs/native-trunk-v24-audit.json
```

The benchmark exits0 only when every selected case passes the speed gate;
exit2 also covers valid completed runs with speed gaps. The audit exits0 for an
internally consistent complete report even when its reported speed gate fails.
Check its `selected_trunk_speed_gate`, not its process exit code, for speed.

## Resume and final checks

`outputs/native-trunk-v24.sqlite3` is authoritative. Each case commits separately;
the JSON export is refreshed on normal completion or caught interruption. Retry
the identical full command after interruption. `--max-cases N` limits additional
unmeasured cases, so it is suitable for a bounded continuation without changing
the measurement identity. No completed row is remeasured on ordinary resume.

The journal pins GPU UUID, installed extension SHA256, original DLL/cubin and
archive hashes, helper/model source hashes, seed, timing settings, packed IO,
attention ABI, driver/Torch/CUDA versions, SM, and every collected compiled policy
version including pool/branch. Source/runtime/binary mismatches reject resume.
Do not edit pinned `vendor_*.py`, `native_benchmark.py`, `dlssnr/*.py`, the geometry
scanner, or shared benchmark source during the run. New experiments can remain
in `.draft` files; any required live change needs a separate journal.

After completion, rerun the identical full command once and audit to a second
file. Both audits must contain 931 committed cases, zero unmeasured cases, and
the same `journal.records_sha256`. Require every boundary/graph/weight check;
report minimum/maximum and per-case speed ratios without discarding slow cases.
Historical interrupted-case errors remain in the journal for review. Geometry
coverage and transferred endpoint configurations outside the requested domain
do not imply measured correctness or performance there.
