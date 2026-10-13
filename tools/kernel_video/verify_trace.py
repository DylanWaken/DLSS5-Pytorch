"""Validate the film's address arithmetic, not GPU execution or numerical results.

Run with any Python 3.11+: python tools/kernel_video/verify_trace.py
No Torch, CUDA, Manim or installed TeX is required. Read source_audit.md for the
source references and the distinction between logical elements and packed bytes.
"""
from __future__ import annotations

import ast
from itertools import product
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[2]
KERNEL = "csrc/kernel_impl/bottleneck_c1024_ffn/fp16/global_ffn_expand_c1024_fp16.cu"
PROFILE = "csrc/kernel_impl/bottleneck_c1024_ffn/common/global_ffn_expand.cuh"
SHARED = "csrc/kernel_impl/shared/common/"


def read(path):
    return (ROOT / path).read_text(encoding="utf-8")


def numbers(pattern, source):
    match = re.search(pattern, source)
    assert match, f"Source declaration changed: {pattern}"
    return tuple(map(int, match.groups()))


def repository_weight_index():
    """Execute only the dependency-free packing function, not the Torch module."""
    path = "dlssnr/weights.py"
    tree = ast.parse(read(path))
    function = next(node for node in tree.body if isinstance(node, ast.FunctionDef)
                    and node.name == "packed_f16_weight_index")
    namespace = {}
    exec(compile(ast.Module(body=[function], type_ignores=[]), path, "exec"), namespace)
    return namespace[function.name]


def repository_input_word(token, channel_word):
    """Evaluate the existing C++ repack formula on its nonnegative FP16 domain."""
    path = "csrc/kernel_impl/bottleneck_c1024_layout/common/global_repack_layout.cuh"
    body = re.search(r"GlobalRepackPhysicalWord\([^{}]+\)\s*\{(.*?)\n\}", read(path), re.S)
    assert body, "GlobalRepackPhysicalWord definition changed"
    expression = re.search(r"return\s+(.*?);", body[1], re.S)[1]
    expression = re.sub(r"(\d+)u\b", r"\1", expression).replace("/", "//")
    tree = ast.parse(" ".join(expression.split()), mode="eval")
    allowed = (ast.Expression, ast.BinOp, ast.Add, ast.Mult, ast.FloorDiv, ast.Mod,
               ast.Name, ast.Load, ast.Constant)
    assert all(isinstance(node, allowed) for node in ast.walk(tree))
    return eval(compile(tree, path, "eval"), {"__builtins__": {}},
                {"g_TokenIndex": token, "g_ChannelWord": channel_word,
                 "WordsPerToken": 512})


def a_cell(lane, word, half):
    return lane // 4 + 8 * (word % 2), 2 * (lane % 4) + 8 * (word // 2) + half


def b_cell(lane, word, half):
    return 2 * (lane % 4) + 8 * word + half, lane // 4


def d_cell(lane, word, half):
    return lane // 4 + 8 * word, 2 * (lane % 4) + half


def check_panel(mapping, words, rows, columns):
    ownership = {(lane, word, half): mapping(lane, word, half)
                 for lane, word, half in product(range(32), range(words), range(2))}
    assert len(ownership) == rows * columns
    assert set(ownership.values()) == set(product(range(rows), range(columns)))
    return ownership


def main():
    entry, profile = read(KERNEL), read(PROFILE)
    elem, = numbers(r"ElementBytes\s*=\s*bFp8\s*\?\s*\d+\s*:\s*(\d+)", profile)
    reduction, = numbers(r"ReductionTile\s*=\s*bFp8\s*\?\s*\d+\s*:\s*(\d+)", profile)
    stage_bytes, = numbers(r"s_StageBytes\s*=\s*(\d+)", profile)
    stages, = numbers(r"s_StageCount\s*=\s*(\d+)", profile)
    k_total, = numbers(r"ReductionSteps\s*=\s*(\d+)\s*/\s*ReductionTile", profile)
    m_tiles, n_tiles = numbers(r"FMmaAccumulatorTile<(\d+),\s*(\d+)>", entry)
    a_m, a_k = numbers(r"uint4\s+r_Input\[(\d+)\]\[(\d+)\]", entry)
    b_k, b_n = numbers(r"uint4\s+r_Weight\[(\d+)\]\[(\d+)\]", entry)
    accumulator_words, = numbers(r"r_AccumulatorWords\[SpatialFragments\]\[ChannelGroups\]\[(\d+)\]",
                                read(SHARED + "tiled_mma.cuh"))
    assert (elem, reduction, stage_bytes, stages, k_total) == (2, 32, 8192, 3, 1024)
    assert (m_tiles, n_tiles, a_m, a_k, b_k, b_n, accumulator_words) == (4, 4, 4, 2, 2, 4, 4)
    assert "FProfile::s_BarrierBase + 24" in entry
    assert "mma.sync.aligned.m16n8k16.row.col.f16.f16.f16.f16" in read(SHARED + "intrinsics.cuh")

    a_map = check_panel(a_cell, 4, 16, 16)
    b_map = check_panel(b_cell, 2, 16, 8)
    d_map = check_panel(d_cell, 2, 16, 8)
    assert a_cell(13, 0, 0) == (3, 2) == d_cell(13, 0, 0)
    assert b_cell(9, 0, 0) == (2, 2)
    assert {lane for (lane, _, _), (row, _) in a_map.items() if row == 3} == {12, 13, 14, 15}
    assert {lane for (lane, _, _), (_, col) in b_map.items() if col == 2} == {8, 9, 10, 11}

    # All 256 A scalars in this panel agree with the actual C++ repack map.
    for (lane, word, half), (row, k) in a_map.items():
        scalar = 4 * repository_input_word(80 + row, (112 + k) // 2) + 2 * ((112 + k) % 2)
        vector = 5 * 32768 + 3 * 1024 + 512 + lane * 16
        assert scalar == vector + word * 4 + half * 2

    # Check both adjacent N8 fragments, including every companion Half in uint4.
    weight_index = repository_weight_index()
    for n_half in range(2):
        for (lane, word, half), (k, n) in b_map.items():
            scalar = elem * weight_index(112 + k, 32 + n_half * 8 + n, 4096)
            vector = 7 * 131072 + 2 * 512 + lane * 16
            assert scalar == vector + (n_half * 2 + word) * 4 + half * 2

    # D's complete N16 panel is a bijection to all 512 packed output bytes.
    output_addresses = {}
    for n_half in range(2):
        for (lane, word, half), (row, n) in d_map.items():
            coord = 80 + row, 32 + n_half * 8 + n
            address = 5 * 131072 + 2 * 512 + lane * 16 + (n_half * 2 + word) * 4 + half * 2
            assert coord not in output_addresses
            output_addresses[coord] = address
    assert len(set(output_addresses.values())) == 256
    assert set(output_addresses.values()) == set(range(656384, 656896, 2))

    a_scalar = 4 * repository_input_word(83, 114 // 2) + 2 * (114 % 2)
    b_scalar = elem * weight_index(114, 34, 4096)
    d_scalar = output_addresses[83, 34]
    a_vector, b_vector, d_vector = 167632, 918672, 656592
    assert (a_scalar, b_scalar, d_scalar) == (a_vector, b_vector, d_vector)
    assert output_addresses[83, 35] == d_vector + 2
    assert output_addresses[91, 34] == d_vector + 4
    assert output_addresses[83, 42] == d_vector + 8
    producer = 0 * 8192 + 1 * 1024 + 1 * 4096 + 512 + 13 * 16
    consumer = 0 * 8192 + (2 // 2) * 4096 + 1 * 1024 + 512 + 13 * 16
    assert producer == consumer == 5840
    assert [(consumer + 4 * word) // 4 % 32 for word in range(4)] == [20, 21, 22, 23]

    steps = k_total // reduction
    mma_per_step = m_tiles * n_tiles * a_k * 2
    assert (m_tiles * n_tiles * accumulator_words, a_m * a_k * 4, b_k * b_n * 4) == (64, 32, 32)
    assert (steps, mma_per_step, mma_per_step * steps, mma_per_step * steps * 4) == (32, 64, 2048, 8192)
    assert stage_bytes == 8 * 16 * reduction * elem
    assert stage_bytes * stages + 24 == 24600
    assert steps * a_k == 64  # One selected output receives 64 K16 updates.
    assert 32 * ((2160 + 127) // 128) == 544
    assert (2160 + 15) // 16 == 135
    assert [g for g in range(128, 136) if g < 135] == list(range(128, 135))
    assert "dim3(32, 4, 1)" in re.search(
        r"reinterpret_cast<const void\*>\(&global_ffn_expand_c1024_fp16\).*?;",
        read("csrc/kernel_launcher/plan_fp16_generated.inl"), re.S)[0]
    assert "GeometryGrid(32 * GeometryDivideUp(Shape.Tokens(), 128), 1, 1), // global_ffn_expand_c1024_fp16" in read(
        "csrc/kernel_launcher/plan_geometry_fp16_generated.inl")

    print("PASS: complete A16x16, B16x8 and D16x8 lane maps; 512-byte A16x16 and B/D N16 panels.")
    print("PASS: actual repo packing maps agree with all A and B scalar offsets in the selected panels.")
    print("Logical scalar X[83,114]: packed byte 167632; A lane13 uint4 starts at 167632 (word0, low Half).")
    print("Logical scalar W[114,34]: packed byte 918672; B lane9 uint4 starts at 918672 (word0, low Half).")
    print("Logical scalar U[83,34]: packed byte 656592; D lane13 uint4 starts at 656592 (word0, low Half).")
    print("These equalities hold because each selected scalar is the vector's first Half; companions use +2/+4/+8 offsets.")
    print("PASS: producer/consumer shared byte5840, banks20-23; 544 CTAs, 24600 shared bytes, 64 C words/lane.")
    print("PASS: 64 MMAs/warp/step, 2048/warp, 8192/CTA; 64 K16 updates per output; group135 tail skipped.")
    print("Documentation arithmetic only: no GPU launch, timing, register-allocation or numerical-output test was performed.")


if __name__ == "__main__":
    main()
