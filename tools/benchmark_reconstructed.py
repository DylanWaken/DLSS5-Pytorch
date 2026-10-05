"""Isolated original-cubin versus reconstructed DeploymentPlan worker.

GPU work is explicit. Importing this module performs no Torch/CUDA operations.
The caller must use a held process Job with a timeout. This tests the prepared
FP8 feature trunk (blocks 1..69), excluding DLL host/pre0/post70 processing.
"""
from __future__ import annotations
import argparse
import hashlib
import importlib.util
import json
import math
from pathlib import Path
import statistics
import sys
import traceback

PROTOCOL = "all-reconstructed-four-resolutions-physical-balanced-v1"
ROLES = ("native", "candidate")
ORDERS = (ROLES, ROLES[::-1])
CALLS = 3
PAIRS = 32
WARMUPS = 3
BOUNDARIES = tuple([f"b{i}.output" for i in range(1, 70)] +
                   [f"b{i}.down" for i in (4, 8, 14, 22, 30)])


def need(condition, message):
    if not condition:
        raise ValueError(message)


def milestone(message):
    print("[reconstructed] " + message, flush=True)


def sha256(path):
    h = hashlib.sha256()
    with Path(path).open("rb") as f:
        for block in iter(lambda: f.read(8 << 20), b""):
            h.update(block)
    return h.hexdigest()


def summarize(samples):
    need(len(samples) == PAIRS, "exactly 32 alternating pairs required")
    for i, row in enumerate(samples):
        need(row["pair"] == i and row["order"] == list(ORDERS[i % 2]) and
             set(row["ms"]) == set(ROLES), "incorrect pair/order/roles")
        need(all(type(v) in (int, float) and math.isfinite(v) and v > 0
                 for v in row["ms"].values()), "invalid event time")
    orders = {}
    for order in ORDERS:
        rows = [row for row in samples if row["order"] == list(order)]
        need(len(rows) == 16, "each order requires 16 samples")
        med = {role: statistics.median(row["ms"][role] for row in rows) for role in ROLES}
        ratios = [row["ms"]["candidate"] / row["ms"]["native"] for row in rows]
        orders["_".join(order)] = dict(samples=16, native_ms=med["native"],
            candidate_ms=med["candidate"], ratio_of_medians=med["candidate"] / med["native"],
            median_paired_ratio=statistics.median(ratios),
            paired_ratio_min=min(ratios), paired_ratio_max=max(ratios))
    pooled = {role: statistics.median(row["ms"][role] for row in samples) for role in ROLES}
    return dict(protocol=PROTOCOL, calls_per_graph=CALLS, warmups=WARMUPS, pairs=PAIRS,
        samples_per_order=16, orders=orders, pooled_ms=pooled,
        pooled_ratio=pooled["candidate"] / pooled["native"],
        matches_native_in_both_orders=all(row["ratio_of_medians"] <= 1 and
            row["median_paired_ratio"] <= 1 for row in orders.values()),
        performance_scope="Same prepared physical input and 3 repeated whole-trunk calls per graph; no end-to-end DLL claim")


def graph_protocol(torch, owner, stream, calls, poison, verify, *, paired):
    """Small injectable protocol; owner resets graphs before native unload.

    poison/verify are outside captures and all timed intervals. All endpoints
    are plan-owned or native-owned, and every graph is registered before use.
    """
    groups = {}
    milestone("capture: native and candidate resident graphs")
    with owner.stream(torch.cuda.stream(stream)):
        for role in ROLES:
            for _ in range(WARMUPS):
                calls[role]()
            graph = owner.graph(torch.cuda.CUDAGraph())
            events = tuple(torch.cuda.Event(enable_timing=True, external=True) for _ in range(2))
            owner.retain(events)
            events[0].record()
            events[1].record()
            stream.synchronize()
            events[0].elapsed_time(events[1])  # Prime outside capture.
            with owner.capture(graph, torch.cuda.graph(graph, stream=stream)):
                events[0].record()
                for _ in range(CALLS):
                    calls[role]()  # Owner, rather than an ever-growing list, retains physical outputs.
                events[1].record()
            groups[role] = dict(graph=graph, events=events)
        for round_index in range(WARMUPS):
            for role in ORDERS[round_index % 2]:
                groups[role]["graph"].replay()
        stream.synchronize()
        proof = {}
        for phase in ("before", "after"):
            if phase == "after" and paired:
                milestone("timing: 32 alternating pairs, 16 per order, three calls per graph")
                samples = []
                for pair in range(PAIRS):
                    order = ORDERS[pair % 2]
                    times = {}
                    for role in order:
                        item = groups[role]
                        item["graph"].replay()
                        stream.synchronize()
                        times[role] = item["events"][0].elapsed_time(item["events"][1]) / CALLS
                    samples.append(dict(pair=pair, order=list(order), ms=times))
                timing = summarize(samples)
                proof["last_timed_outputs"] = {role: verify(role) for role in ROLES}
            milestone("graph proof " + phase + ": two poisoned replays per role")
            checks = []
            for repeat in range(2):
                for role in ROLES:
                    poison(role, repeat)
                    groups[role]["graph"].replay()
                    stream.synchronize()
                    checks.append(dict(role=role, repeat=repeat, proof=verify(role)))
            proof[phase] = checks
    return dict(graph_proof=proof, samples=samples if paired else [],
        timing=timing if paired else None, event_mode="primed external=True nodes",
        graph_integrity_scope="All 74 physical boundaries, same input, two complemented-output replays per role before and after measurement",
        changed_input_graph_proof=False)


def dependency_snapshot(package_root, helper_root, extension, asset_root, archive, input_path):
    paths = [extension, Path(__file__).resolve(), helper_root / "reconstructed_candidate.py"]
    paths += sorted((helper_root / "native_reference").glob("*.py"))
    paths += [package_root / "dlssnr" / name for name in
              ("__init__.py", "deployment.py", "geometry.py", "records.py")]
    paths += [asset_root / "original/nvngx_dlssnr.dll"]
    paths += [asset_root / "vendor_modules" / f"module_{i}.cubin" for i in range(7)]
    paths += [archive.directory / "manifest.json"]
    paths += [archive.directory / "model" / x["file"] for x in archive.manifest["stages"]]
    if input_path is not None:
        paths.append(input_path)
    resolved = sorted(set(path.resolve(strict=True) for path in paths))
    return {str(path): sha256(path) for path in resolved}


def verify_snapshot(snapshot):
    for path, digest in snapshot.items():
        need(sha256(path) == digest, "changed worker dependency: " + path)


def execute(args):
    package_root = args.package_root.resolve(strict=True)
    helper_root = Path(__file__).resolve().parent
    sys.path.insert(0, str(helper_root.parent))
    sys.path.insert(0, str(package_root))
    import numpy as np
    import torch
    from dlssnr import geometry, records, deployment
    from tools.reconstructed_candidate import create_candidate
    from tools.native_reference import NativeReference
    from tools.native_reference.lifetime import QUARANTINED, _exit_quarantined
    for module, expected in ((geometry, package_root / "dlssnr/geometry.py"),
                             (records, package_root / "dlssnr/records.py"),
                             (deployment, package_root / "dlssnr/deployment.py")):
        need(Path(module.__file__).resolve() == expected.resolve(strict=True), "wrong package import: " + module.__name__)
    need(Path(sys.modules[create_candidate.__module__].__file__).resolve() ==
         helper_root / "reconstructed_candidate.py", "wrong candidate helper import")
    need(Path(sys.modules[NativeReference.__module__].__file__).resolve() ==
         helper_root / "native_reference/session.py", "wrong original reference import")
    spec = importlib.util.find_spec("dlssnr._C")
    need(spec is not None and spec.origin is not None, "compiled extension missing")
    extension = Path(spec.origin).resolve(strict=True)
    need(extension.parent == package_root / "dlssnr" and
         sha256(extension) == args.binary_sha256, "wrong extension identity")
    milestone("load: exact binary and clean import origins checked")
    archive = records.WeightArchive(args.weights)
    snapshot = dependency_snapshot(package_root, helper_root, extension,
        args.assets.resolve(strict=True), archive, args.input_npy)
    milestone("assets: dependency snapshot and raw checkpoint validated")
    api = deployment.load_extension(extension)
    g = geometry.Geometry.from_valid(args.width, args.height)
    h, w = g.levels[0][1], g.levels[0][0]
    if args.input_npy is not None:
        codes = np.load(args.input_npy, allow_pickle=False)
        fixture_source = "caller supplied logical prepared-feature uint8 array"
    elif args.fixture == "finite_normal":
        generator = torch.Generator(device="cpu").manual_seed(args.seed)
        codes = (torch.randn((h, w, 32), generator=generator, device="cpu") * 0.5).half().to(torch.float8_e4m3fn).view(torch.uint8).numpy()
        fixture_source = "synthetic CPU 0.5*randn -> Half -> E4M3 finite prepared features; not pre0 output"
    else:
        rng = np.random.default_rng(args.seed)
        codes = rng.integers(0, 254, size=(h, w, 32), dtype=np.uint8)
        codes += (codes >= 127).astype(np.uint8)  # Finite-code stress; excludes 0x7f and 0xff.
        fixture_source = "synthetic full finite-code stress; may saturate internal Half arithmetic; not pre0 output"
    need(codes.dtype == np.uint8 and codes.shape == (h, w, 32), "input must match the logical level-zero uint8[height,width,32] field")
    need(not np.any((codes & 127) == 127), "this first complete-trunk cohort admits finite FP8 inputs only")
    fixture_sha = hashlib.sha256(codes.tobytes()).hexdigest()
    report = dict(protocol=PROTOCOL, mode=args.mode, accepted=False, gpu=True,
        binary=dict(path=str(extension), sha256=args.binary_sha256), source_snapshot=snapshot,
        geometry=dict(valid_width=args.width, valid_height=args.height, level0=[h, w, 32], batch=1, precision="fp8", sm=120),
        fixture=dict(source=fixture_source, kind=args.fixture if args.input_npy is None else "input_npy", logical_input_sha256=fixture_sha, seed=args.seed if args.input_npy is None else None),
        scope=dict(compute_positions=152, candidate_clear_calls=33, boundary_count=74,
            candidate="reconstructed CUDA only, compiled physical schedule",
            native="original cubins with original cc_cb_clear counter reset calls",
            excludes=["DLL host runtime", "pre0 frontend", "post70 output helpers"],
            continuous_resolution_qualified=False))
    milestone("native assets: original DLL/modules/records validation")
    reference = NativeReference(args.assets, device=args.device, archive=archive)
    owner = reference.lifetime
    guarded_inputs = []
    proof_rows = []
    try:
        with reference:
            milestone("native allocation: physical buffers, record caches and layout maps")
            trunk = reference.build_trunk(g, codes)
            stream = reference.stream
            with owner.stream(torch.cuda.stream(stream)):
                def guarded_transfer(raw, device):
                    source = torch.from_numpy(np.frombuffer(raw, dtype=np.uint8).copy())
                    backing = torch.full((len(raw) + 512,), 0xA5, dtype=torch.uint8, device=device)
                    payload = backing[256:-256]
                    payload.copy_(source)
                    golden = payload.clone()
                    guarded_inputs.append((backing, payload, golden))
                    owner.retain((source, backing, payload, golden))
                    return payload
                physical = reference.physical_input(trunk)
                backing = torch.full((physical.numel() + 512,), 0xA5, dtype=torch.uint8, device=physical.device)
                state = backing[256:-256]
                state.copy_(physical)
                state_golden = state.clone()
                guarded_inputs.append((backing, state, state_golden))
                owner.retain((backing, state, state_golden))
                milestone("candidate allocation: create compiled 185-step plan")
                candidate = owner.retain(create_candidate(api, archive, state, guarded_transfer, width=args.width, height=args.height))
                native_outputs = reference.deployment_boundaries(trunk)
                candidate_outputs = candidate.boundaries()
                # A padded fused downsample owns an extra allocation tail used by
                # its zeroing path. The next layer reads only the published plane
                # field. Compare that entire field, while guarding the full backing.
                # Global token padding stays in the oracle and is not truncated.
                publication_extents = {}
                for block_index, level_index in ((4, 1), (8, 2), (14, 3), (22, 4), (30, 5)):
                    name = f"b{block_index}.down"
                    field_width, field_height = g.levels[level_index]
                    published_bytes = field_width * field_height * geometry.block_channels(block_index) * 2
                    native_bytes = native_outputs[name].numel()
                    candidate_bytes = candidate_outputs[name].numel()
                    need(native_bytes == candidate_bytes and native_bytes in (published_bytes, 2 * published_bytes),
                         "unexpected downsample backing extent: " + name)
                    publication_extents[name] = dict(published_bytes=published_bytes,
                        backing_bytes=native_bytes, auxiliary_tail_bytes=native_bytes - published_bytes)
                    native_outputs[name] = native_outputs[name][:published_bytes]
                    candidate_outputs[name] = candidate_outputs[name][:published_bytes]
                report["downsample_publication_extents"] = publication_extents
                report["boundary_contract"] = "All published physical bytes, including global token padding; auxiliary downsample tail is guarded but not a network output"
                need(set(native_outputs) == set(candidate_outputs) == set(BOUNDARIES), "exact 74-boundary roster required")
                for name in BOUNDARIES:
                    a, b = native_outputs[name], candidate_outputs[name]
                    need(a.dtype == b.dtype == torch.uint8 and a.ndim == b.ndim == 1 and
                         a.is_contiguous() and b.is_contiguous() and a.numel() == b.numel(), "physical boundary extent/type mismatch: " + name)
                owner.retain(native_outputs)
                owner.retain(candidate_outputs)
                milestone("native launch: first original 185-step trunk")
                trunk()
                stream.synchronize()
                reference.check(trunk)
                golden = owner.retain({name: value.clone() for name, value in native_outputs.items()})
                milestone("candidate launch: reconstructed 185-step trunk")
                candidate.run()
                stream.synchronize()

                def check_guards_immutable():
                    reference.check(trunk)
                    need(candidate.plan.guards_intact(), "candidate workspace guard overwritten")
                    for i, (whole, payload, original) in enumerate(guarded_inputs):
                        need(bool(torch.all(whole[:256] == 0xA5)) and
                             bool(torch.all(whole[-256:] == 0xA5)), f"candidate input/record guard {i}")
                        need(torch.equal(payload, original), f"candidate input/record mutated {i}")
                    counter_names = [name for name in candidate.plan.buffer_names() if name.endswith("_counter")]
                    need(len(counter_names) == 33, "33 counter buffers expected")
                    for name in counter_names:
                        expected = 0 if name.endswith("attention_counter") else 1 if name.endswith("qkv_counter") else 3
                        need(bool(torch.all(candidate.plan.buffer(name).view(torch.int32) == expected)), "candidate final counter differs: " + name)

                def verify(role):
                    actual = native_outputs if role == "native" else candidate_outputs
                    compared = 0
                    for name in BOUNDARIES:
                        if not torch.equal(actual[name], golden[name]):
                            error = AssertionError(role + " differs from original bytes at " + name)
                            try:
                                torch.save(dict(boundary=name, role=role, original=golden[name].cpu(),
                                    actual=actual[name].cpu(), input_sha256=fixture_sha), args.output.parent / "first-boundary-failure.pt")
                            except BaseException as save_error:
                                error.add_note("counterexample save also failed: " + repr(save_error))
                            raise error
                        compared += actual[name].numel()
                    check_guards_immutable()
                    return dict(boundaries=74, physical_bytes=compared, byte_exact=True,
                        input_and_142_records_immutable=True, guards_intact=True, counters_complete=True,
                        includes_native_published_global_token_padding=True)

                milestone("74-boundary comparison: full physical bytes, guards, inputs and records")
                proof_rows.append(dict(stage="eager_candidate", proof=verify("candidate")))
                # Explicit second original replay establishes a stable oracle before capture.
                trunk()
                stream.synchronize()
                proof_rows.append(dict(stage="second_native_replay", proof=verify("native")))

                def poison(role, repeat):
                    outputs = native_outputs if role == "native" else candidate_outputs
                    if role == "candidate":
                        candidate.plan.poison(0x3C if repeat == 0 else 0xC3)
                    else:
                        from tools.native_reference.vendor_benchmark import GUARD_BYTES
                        seen = set()
                        for _, node in trunk.nodes:
                            for key, (allocation, _) in node.allocations.items():
                                if key in ("input", "skip") or key.startswith("weight") or id(allocation) in seen:
                                    continue
                                seen.add(id(allocation))
                                allocation[GUARD_BYTES:-GUARD_BYTES].fill_(0x3C if repeat == 0 else 0xC3)
                    for name in BOUNDARIES:
                        # Every retained endpoint byte now differs, including valid padded rows.
                        outputs[name].copy_(golden[name].bitwise_not())

                report.update(graph_protocol(torch, owner, stream,
                    dict(native=trunk, candidate=candidate.run), poison, verify,
                    paired=args.mode == "paired"))
                report["eager_proofs"] = proof_rows
                report["boundary_bytes"] = {name: value.numel() for name, value in golden.items()}
                report["native_identity"] = reference.identity()
                report["candidate_records"] = candidate.record_proof
                report["candidate_resources"] = candidate.plan.resources()
                stream.synchronize()
                check_guards_immutable()
        need(owner.closed and not owner.quarantined and not owner.graphs, "graph/native ownership did not close")
        milestone("teardown: graphs reset and native resources closed; final identities")
        verify_snapshot(snapshot)
        report.update(accepted=True, graph_reset_before_native_unload=True,
            final_identity=True, owner_closed=True, quiet_job_verified_by_parent=False)
        args.output.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
        return report
    except BaseException as error:
        report.update(accepted=False, error=repr(error), error_type=type(error).__name__,
            owner_closed=owner.closed, quarantined=owner.quarantined,
            traceback=traceback.format_exc())
        try:
            verify_snapshot(snapshot)
            report["final_identity"] = True
        except BaseException as identity_error:
            report["final_identity"] = False
            error.add_note("final identity also failed: " + repr(identity_error))
        try:
            args.output.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
        except BaseException as save_error:
            error.add_note("failure report write also failed: " + repr(save_error))
        if QUARANTINED:
            _exit_quarantined(diagnostic=True)
        raise


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--width", type=int, default=3840)
    p.add_argument("--height", type=int, default=2160)
    p.add_argument("--mode", choices=("numerical", "paired"), required=True)
    p.add_argument("--package-root", type=Path, required=True)
    p.add_argument("--binary-sha256", required=True)
    p.add_argument("--assets", type=Path, required=True)
    p.add_argument("--weights", type=Path, required=True)
    p.add_argument("--output", type=Path, required=True)
    p.add_argument("--input-npy", type=Path)
    p.add_argument("--fixture", choices=("finite_normal", "finite_codes"), default="finite_normal")
    p.add_argument("--seed", type=int, default=1729)
    p.add_argument("--device", type=int, default=0)
    args = p.parse_args()
    need(len(args.binary_sha256) == 64 and all(c in "0123456789abcdef" for c in args.binary_sha256), "expected lowercase SHA-256")
    need(not args.output.exists(), "refusing to overwrite a prior result")
    args.output.parent.mkdir(parents=True, exist_ok=True)
    execute(args)
    print("accepted " + args.mode + ": all 74 physical boundaries byte exact; parent must verify held Job cleanup", flush=True)


if __name__ == "__main__":
    main()
