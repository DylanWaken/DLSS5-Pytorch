"""DLSS-NR geometry and packed-record layouts.

Adapted from OpenDLSS-NR, Copyright (c) 2026 maan, MIT license;
see third_party/OpenDLSS-NR/LICENSE and NOTICE.
"""
from dataclasses import dataclass


def align_up(value: int, alignment: int) -> int:
    return (value + alignment - 1) // alignment * alignment


def _field_alignment(valid: int) -> int:
    reductions, size = 0, valid
    for level in range(6):
        half = align_up((size + 1) // 2, 4)
        reductions += int(half < size)
        reductions += int(level == 0 and half % 8 != 0)
        size = half
    return 1 << reductions


@dataclass(frozen=True)
class Geometry:
    valid_width: int
    valid_height: int
    full_width: int
    full_height: int
    levels: tuple[tuple[int, int], ...]  # (width, height), finest first

    @classmethod
    def from_valid(cls, width: int, height: int) -> "Geometry":
        if isinstance(width, bool) or isinstance(height, bool) or not isinstance(width, int) or not isinstance(height, int):
            raise TypeError("width and height must be integers")
        if width < 1 or height < 1:
            raise ValueError("width and height must be positive")
        aw, ah = _field_alignment(width), _field_alignment(height)
        fw, fh = max(320, align_up(width, aw)), max(320, align_up(height, ah))
        if fw % (4 * aw) == 0 and fh % (4 * ah) == 0:
            fw += aw
        levels, w, h = [], fw, fh
        for _ in range(6):
            w, h = align_up((w + 1) // 2, 4), align_up((h + 1) // 2, 4)
            levels.append((w, h))
        if levels[0][0] % 8 or levels[0][1] % 8:
            raise ValueError("unsupported tiny image: level 0 needs a whole 8-pixel window; use dimensions >= 33")
        return cls(width, height, fw, fh, tuple(levels))

    @property
    def vit_tokens(self) -> int:
        return self.levels[5][0] * self.levels[5][1]

    @property
    def padded_vit_tokens(self) -> int:
        return align_up(self.vit_tokens, 64)


def window_shift(phase: int) -> tuple[int, int]:
    """Positive left/top padding; window origins are (-x, -y)."""
    return ((0, 0), (4, 4), (4, 0), (0, 4))[phase % 4]


def block_channels(block: int) -> int:
    for first, last, channels in ((0, 4, 32), (5, 8, 64), (9, 14, 128), (15, 22, 256),
                                  (23, 30, 512), (31, 38, 1024), (39, 47, 512),
                                  (48, 55, 256), (56, 61, 128), (62, 65, 64), (66, 70, 32)):
        if first <= block <= last:
            return channels
    raise ValueError(f"block index must be in [0, 70], got {block}")


def fused_layout(channels: int, kind: str = "standard") -> dict[str, int]:
    if channels not in (32, 64, 128, 256):
        raise ValueError("fused layout channels must be 32, 64, 128 or 256")
    if kind == "pre":
        if channels != 32:
            raise ValueError("pre layout is 32 channels")
        return dict(expand=0, contract=4096, input_adapter=8208, ffn_scale=9232, qkv=9312,
                    relative=12384, head_scale=20576, projection=20592, attn_scale=21616, end=21680)
    if kind == "post":
        if channels != 32:
            raise ValueError("post layout is 32 channels")
        return dict(expand=0, contract=4096, ffn_scale=8208, input_scale=8272, adapter_scale=8336,
                    qkv=8400, relative=11472, head_scale=19664, projection=19680, attn_scale=20704,
                    head=20784, end=21808)
    if kind not in ("standard", "upsample"):
        raise ValueError(f"unknown layout {kind!r}")
    c, experts = channels, channels // 32 if channels >= 64 else 0
    expand_bytes = experts * c * 128 if experts else c * 128
    total = expand_bytes + (experts * 128 * 32 + c * c if experts else 128 * c)
    layout = dict(expand=0, contract=expand_bytes)
    if kind == "upsample":
        padding = 16 if c == 32 else 0
        layout.update(up_projection=total, ffn_scale=total + 2 * c * c + padding)
        layout["transition_scale"] = layout["ffn_scale"] + c * 2 + padding
        qkv = layout["transition_scale"] + c * 2
    else:
        layout["ffn_scale"] = total + 16
        qkv = layout["ffn_scale"] + c * 2 + 16
    relative = qkv + 3 * c * c
    scale = relative + c // 32 * 8192
    projection = scale + align_up(4 * (c // 32), 16)
    layout.update(qkv=qkv, relative=relative, head_scale=scale, projection=projection,
                  attn_scale=projection + c * c, end=projection + c * c + 2 * c)
    return layout


def block_layout(block: int) -> dict[str, int]:
    kind = "pre" if block == 0 else "post" if block == 70 else "upsample" if block in (48, 56, 62, 66) else "standard"
    return fused_layout(block_channels(block), kind)


def graph_schedule(geometry: Geometry) -> tuple[dict, ...]:
    """The 71 numbered records, including transition-only block 39."""
    phases = [0] * 7
    schedule = []
    for block in range(71):
        c = block_channels(block)
        level = 6 if block in (0, 70) else {32: 0, 64: 1, 128: 2, 256: 3, 512: 4, 1024: 5}[c]
        width, height = (geometry.full_width, geometry.full_height) if level == 6 else geometry.levels[level]
        phase = None if c == 1024 or block == 39 else phases[level] % 4
        if phase is not None:
            phases[level] += 1
        schedule.append(dict(block=block, channels=c, width=width, height=height,
                             kind="transition" if block == 39 else "global" if c == 1024 else "window",
                             phase=phase))
    return tuple(schedule)
