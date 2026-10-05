# Original attention replay instability

The unchanged extracted `cc_vit_1d_attention_fp8` cubin can produce different
outputs on the same inputs under the documented SM120 replay contract.
This finding concerns that kernel launch, not the NGX host runtime, which was
not executed or intercepted. No modified cubin is used as an official baseline.

At288 tokens, a full resident trunk replay first differed at block32. All
expansion, contraction, Q, K and V bytes matched. Attention differed in1,984
bytes, confined to head9 and queries64–127. Original buffers were identical
immediately before and after candidate execution. Five subsequent launches
of only the original attention kernel, with the same Q/K/V pointers, all
matched the candidate exactly. The full candidate was stable across all74
checked boundaries. Retained evidence:

- `outputs/vendor_trunk_mutation_repeat_v12.json` records first-pass and
  isolated-replay comparisons.
- Its `.npz` contains the frozen first-bad original and candidate boundaries;
  SHA256 `fa019cd988435c5f82df1faf7c339980e2a0562b5c82bd50a0cfca2644677b52`.
- `outputs/vendor_attention_racecheck_v12.log` contains100 reported shared
  write-after-read hazards before its print limit. The run was terminated
  after retaining this evidence, so there is no final aggregate error count.
  SHA256 `abf332f69db1a58a78056eb0487654fcef9329757937ca0ec32183c76daefee5`.

One reported hazard is a read by thread(0,3,0) at SASS PC0x1090 versus an
overwrite by thread(0,0,0) at PC0x32e0, shared address0x400, CTA(5,1,0).
The original double-buffer loop issues the chunk `i+2` asynchronous replacement
copy into buffer `i` after each warp finishes its own computation. Its next
buffer's completion wait comes after that replacement. The disassembled
SASS has no CTA consumption barrier between the relevant shared loads and
replacement copies. This supplies a concrete explanation consistent with the
observed warp-sized output difference. Shared initialization and uncached
global memory checks both passed; neither check rules out this WAR hazard.

The module is pinned to SHA256
`bfb2ebe117b7c4d92a78e1885412acbb80233f2d9b11af1e854430eb3cc0a2a1`.
Launch parameters are a64-byte by-value struct: Q/K/V/output at0/8/16/24,
three unused pointers at32/40/48, height1 and token count at56/60. The launch
uses block(32,4,1), grid(32,ceil(tokens/256),1), and no dynamic shared memory.
Those dimensions match recovered query addressing **and the original DLL host
machine code**. Registration at DLL RVA0x73510 passes block(32,4,1) for plain
and chained entries. Forward at RVA0x72440 passes gridX32, gridYceil(M/256),
gridZ1 and a64-byte parameter struct. The saved excerpt is
`assets/vendor_sources/original_attention_host_forward.txt`, SHA256
`0d77ce6ab227450306c3ef3b8d471268097115b35b9077a3b97bfe8660908bd6`.
This is static disassembly, not a live NGX host interception. PTX declares
`.maxnreg168` but no `.reqntid` or `.maxntid`.
The harness uses the same nondefault Torch CUDA stream
for producer stages and this launch. Attention reads no external counters or
scratch pointers, so no missing persistent counter reset explains the result.

`tools/vendor_attention_replay.py` loads the frozen Q/K/V, allocates distinct
outputs, queues unchanged original launches, then synchronizes once. It can
be used under racecheck without running candidate kernels:

```powershell
compute-sanitizer --tool racecheck --racecheck-report analysis --kernel-name kns=cc_vit_1d_attention_fp8 --error-exitcode 99 --log-file outputs/vendor_attention_racecheck_single.log .venv/Scripts/python.exe tools/vendor_attention_replay.py --single-cta --replays 1 --output outputs/vendor_attention_racecheck_single.json
```

`--single-cta` is an explicit diagnostic restriction to head0/queries0–255,
not the complete launch or a timing baseline. The unrestricted command retains
the full documented launch. No warmup or extra synchronization is hidden in
the production native timing contract.

The diagnostic plain-entry route remains usable across all931 geometries.
Its affected global/trunk records carry `native_reference_evidence`; successful warmups or
replays cannot clear the numerical/native-speed gate. By default, a first-pass
parity failure stops timing for that case. `--diagnostic-native-timing` retains
raw timing samples even after this known native-reference failure, preserves
the mismatch counts, and marks the result inconclusive. Stable window/down/up
component comparisons retain their independent gates.

## Unchanged chained attention reference

The same pinned module includes `cc_vit_1d_attention_chained_fp8`. Its SASS
contains `BAR.SYNC` at 0x3650 before replacement copies at 0x3820/0x3ac0. It uses
the same Q/K/V/output layouts, dimensions and block/grid, with input completion
buffer at struct+40 and optional output completion buffer at+48. The original
host selects this entry when chaining is enabled and both buffers are supplied.

Input CB is `int32[ceil(M/128),16]`. The consumer waits for each selected element
to exceed -1, indexed by 128-token tile and head/2. Output CB is
`int32[ceil(M/128),32]`, initialized to -1; each attention CTA publishes 0 for its head
and up to two 128-token tiles using a GPU-release store after the final CTA
barrier. In this sequential-stream harness, input CB aliases the actual QKV
split counters, whose final value is 1 before attention starts. This meets the
consumer's readiness predicate; it does not claim that NGX uses the same alias
for concurrent producer/consumer execution. Output CB reset is included in
native graph timing. All CB storage has guards and final values are checked.

`vendor_attention_replay.py --chained --replays 32` matches the frozen previously
failing M288 fixture exactly across 32 separately allocated outputs. Report:
`outputs/vendor_attention_chained_replay_v13.json`, SHA256
`f583863ecd2ce37c4f133d38809227cf468ab69724e0a53719dcc53301f496a3`.
The bounded `--chained --single-cta --replays 1` racecheck completed with
**0 errors, 0 warnings**. Log SHA256
`c69d09b31a66173faf98f267db57c7eb988035ce364fa0f0f184ffc933c541a7`.
This sanitizer result covers one CTA only; it is not a full-network racecheck.

The original chained entry is now the range/trunk adapter default;
`--native-attention plain` retains the failing route and its inconclusive gate.
At 720p and 1080p, each chained resident trunk matched all 74 boundaries on the
first launch and two additional complete replays, then remained stable during
graph timing. Reports are `outputs/vendor_trunk_chained_720_v13.json` and
`outputs/vendor_trunk_chained_1080_v13.json`. Candidate performance still fails:
5.447680 ms versus original 2.187072 ms at 720p, and 8.614176 ms versus 2.544256 ms at 1080p.
The candidate here uses half storage. Renderer endpoints 0/70, all 931 geometries,
and live NGX host timing remain unverified.
