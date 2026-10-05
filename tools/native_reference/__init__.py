"""Original cubin reference only. Importing this package does not import Torch.

This is the prepared-feature trunk boundary, not the original DLL host runtime.
Only explicit NativeReference.build_trunk/run_trunk calls initialize CUDA.
"""
from .session import NativeReference, NativeArtifacts
from .trunk import NativeTrunk, validate_trunk_geometry
from .lifetime import NativeGraphOwner, cli

__all__ = ["NativeReference", "NativeArtifacts", "NativeTrunk", "validate_trunk_geometry", "NativeGraphOwner", "cli"]
