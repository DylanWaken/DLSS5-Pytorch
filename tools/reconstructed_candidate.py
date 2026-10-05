"""Thin benchmark adapter for the compiled reconstructed-only DeploymentPlan.

The API object is supplied explicitly by the caller and must expose
record_names_fp8(), record_bytes_fp8(), and create_plan_fp8(state, records). There is no
operator-name fallback, Python kernel selection, or legacy model dependency.
"""
from dataclasses import dataclass, field
import hashlib


def packed_records(api, archive):
    """Validate every record before allocating any device tensor."""
    names = list(api.record_names_fp8())
    sizes = list(api.record_bytes_fp8())
    if not names or len(names) != len(sizes) or len(set(names)) != len(names):
        raise ValueError("compiled record roster must be nonempty, unique, and aligned")
    payloads, proof = [], []
    for name, size in zip(names, sizes):
        if type(name) is not str or type(size) is not int or size <= 0:
            raise ValueError("invalid compiled record descriptor")
        if name not in archive.records:
            raise ValueError("checkpoint is missing compiled record " + name)
        raw = bytes(archive.records[name].data)
        if len(raw) != size:
            raise ValueError("checkpoint/compiled record length differs: " + name)
        payloads.append(raw)
        proof.append(dict(name=name, bytes=size, sha256=hashlib.sha256(raw).hexdigest()))
    return payloads, proof


def transfer_bytes(raw, device):
    """Executed only by an explicit benchmark caller, never at module import."""
    import numpy as np
    import torch
    return torch.from_numpy(np.frombuffer(raw, dtype=np.uint8).copy()).to(device)


@dataclass
class Candidate:
    plan: object
    state: object
    records: list
    record_proof: list
    retained_outputs: list = field(default_factory=list)

    def run(self):
        result = self.plan.run_fp8()
        self.retained_outputs[:] = [result]
        return result

    def boundaries(self):
        names = list(self.plan.boundary_names())
        values = list(self.plan.boundaries())
        if len(names) != len(values) or len(set(names)) != len(names):
            raise ValueError("compiled boundary roster differs from retained outputs")
        return dict(zip(names, values))

    def compare(self, reference, equal):
        """Compare an independently produced native physical boundary mapping."""
        actual = self.boundaries()
        if set(actual) != set(reference):
            raise ValueError("native/candidate boundary names differ")
        for name in actual:
            if not equal(actual[name], reference[name]):
                raise AssertionError("native/candidate bytes differ at " + name)
        return dict(boundaries=len(actual), all_byte_exact=True)


def create_candidate(api, archive, state, transfer=transfer_bytes, *, width=3840, height=2160):
    payloads, proof = packed_records(api, archive)
    records = [transfer(raw, state.device) for raw in payloads]
    plan = (api.create_plan_fp8(state, records) if (width, height) == (3840, 2160)
            else api.create_plan_for_resolution_fp8(state, records, width, height))
    # Retain input and records beside the custom object until all captured
    # graphs have reset. The caller owns stream/capture/exception containment.
    return Candidate(plan=plan, state=state, records=records, record_proof=proof)
