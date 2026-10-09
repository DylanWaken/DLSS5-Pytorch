"""Compact comparisons of the FFN and attention families in model.py.

The detailed diagrams retain each residual and publication boundary. These
comparisons emphasize the structural differences between the same families.
"""

try:
    from .architecture_flow import Flow
except ImportError:
    from architecture_flow import Flow


def ffn_variants():
    diagram = Flow(
        "ffn_variants", "FFN variants: three ways to mix channels",
        "All operate independently at each spatial position; outputs shown before the learned FFN residual join.",
        1120,
    )
    columns = (
        (20, "dense", "Dense FFN", "C32 and C1024"),
        (415, "branched", "Branched FFN", "C64, C128 and C256"),
        (810, "grouped", "Grouped FFN", "C512"),
    )
    for left, key, title, family in columns:
        diagram.region(left, 105, 370, 860, title)
        diagram.text(left + 185, 170, family, 18, bold=True, anchor="middle")
        diagram.tensor(key + "_input", left + 30, 205, 310, "Input X", "H × W × C")
        diagram.tensor(key + "_output", left + 30, 860, 310, "FFN result F(X)", "H × W × C")

    diagram.op("dense_expand", 50, 320, 310, "Expand C → 4C",
               ["32 → 128", "1024 → 4096"])
    diagram.op("dense_activation", 50, 465, 310, "Activation φ + publish",
               "Same expanded channel count")
    diagram.op("dense_contract", 50, 610, 310, "Contract 4C → C",
               ["128 → 32", "4096 → 1024"])
    diagram.link("dense_input", "dense_expand")
    diagram.link("dense_expand", "dense_activation")
    diagram.link("dense_activation", "dense_contract")
    diagram.link("dense_contract", "dense_output")

    diagram.op("branched_copy", 445, 320, 310, "Broadcast full X to each branch",
               ["E = C/32 = 2, 4 or 8", "Each branch reads all C channels"])
    diagram.op("branched_transform", 445, 465, 310, "E independent branches",
               ["Each: C → 128 → φ → 32", "Publish each 32-channel result"])
    diagram.op("branched_concat", 445, 610, 310, "Concatenate branch outputs",
               "E × 32 channels = C")
    diagram.op("branched_mix", 445, 740, 310, "Final channel mixing C → C")
    diagram.link("branched_input", "branched_copy")
    diagram.link("branched_copy", "branched_transform")
    diagram.link("branched_transform", "branched_concat")
    diagram.link("branched_concat", "branched_mix")
    diagram.link("branched_mix", "branched_output")

    diagram.op("grouped_mix", 840, 320, 310, "Premix 512 → 512; publish",
               "Every output sees all 512 inputs")
    diagram.op("grouped_split", 840, 430, 310, "Split into eight channel slices",
               "Each receives a different 64 lanes")
    diagram.op("grouped_transform", 840, 540, 310, "Eight independent groups",
               ["Each: 64 → 256 → φ → 64", "Publish each 64-channel result"])
    diagram.op("grouped_concat", 840, 665, 310, "Concatenate group outputs",
               "8 × 64 channels = 512")
    diagram.op("grouped_postmix", 840, 770, 310, "Postmix 512 → 512")
    diagram.link("grouped_input", "grouped_mix")
    diagram.link("grouped_mix", "grouped_split")
    diagram.link("grouped_split", "grouped_transform")
    diagram.link("grouped_transform", "grouped_concat")
    diagram.link("grouped_concat", "grouped_postmix")
    diagram.link("grouped_postmix", "grouped_output")

    diagram.note(35, 1000, [
        "Branched FFN broadcasts the full input. Grouped FFN splits the premixed input into disjoint slices.",
        "Every branch/group executes with its own weights; there is no router or sparse expert selection.",
        "φ is the recovered pointwise activation. No FFN family inserts LayerNorm or RMSNorm.",
    ])
    diagram.save()
    return diagram


def attention_variants():
    diagram = Flow(
        "attention_variants", "Attention variants: local windows and global tokens",
        "Both follow the FFN residual and QKV projection; each head has 32 channels. V bypasses Q/K normalization.",
        1370,
    )
    diagram.op("qk_norm", 240, 115, 720, "Shared Q/K normalization",
               ["Split projected QKV into heads; L2-normalize Q and K separately.",
                "Reduce over 32 channels, before spatial padding; V is unchanged."],
               kind="attention")
    diagram.region(25, 255, 560, 1010, "Window attention", kind="attention")
    diagram.region(615, 255, 560, 1010, "Global attention", kind="attention")
    diagram.text(305, 318, "C32 / C64 / C128 / C256 / C512", 17, bold=True, anchor="middle")
    diagram.text(895, 318, "C1024 · 32 heads · T = padded field H × W", 17, bold=True, anchor="middle")

    diagram.op("window_scale", 80, 350, 450, "Scale Q by learned scalar per head",
               "K remains normalized; V remains unnormalized", kind="attention")
    diagram.op("global_scale", 670, 350, 450, "Scale Q by √32, then learned scalar",
               "K remains normalized; V remains unnormalized", kind="attention")
    diagram.link("qk_norm", "window_scale", start="left", end="left",
                 via=((10, 159.5), (10, 383)))
    diagram.link("qk_norm", "global_scale", start="right", end="right",
                 via=((1190, 159.5), (1190, 383)))

    diagram.op("window_tokens", 80, 460, 450, "Pad and partition into 8 × 8 windows",
               ["64 query/key/value positions per window", "Reorder K and V together as Kπ and Vπ"])
    diagram.op("global_tokens", 670, 460, 450, "Flatten field; pad K/V to P tokens",
               ["T real query rows; P = 64⌈T/64⌉ key/value rows", "P − T extra K/V rows are zero"])
    diagram.link("window_scale", "window_tokens")
    diagram.link("global_scale", "global_tokens")

    diagram.op("window_scores", 80, 590, 450, "Window scores + learned position bias",
               "Q · Kπᵀ + B → 64 × 64 per head", kind="attention")
    diagram.op("global_scores", 670, 590, 450, "Global scores; no position bias",
               "Q · Kᵀ → T × P per head", kind="attention")
    diagram.link("window_tokens", "window_scores")
    diagram.link("global_tokens", "global_scores")

    diagram.op("window_exp", 80, 700, 450, "Clamped exponential Ewindow",
               "One positive value per query/key pair", kind="attention")
    diagram.op("global_exp", 670, 700, 450, "Clamped exponential Eglobal",
               "One positive value per query/key pair", kind="attention")
    diagram.link("window_scores", "window_exp")
    diagram.link("global_scores", "global_exp")

    diagram.op("window_weights", 80, 845, 450, "Normalize weights before value mixing",
               ["A = Publish(E / Σkey E)", "Each denominator includes all 64 key slots"],
               kind="attention")
    diagram.link("window_exp", "window_weights")
    diagram.op("global_numerator", 640, 845, 245, "Numerator N",
               ["Publish E; then E · V", "T × 32 per head"], kind="attention")
    diagram.op("global_denominator", 915, 845, 245, "Denominator d",
               ["Σkey E − (P − T)E(0)", "FP32 sum over keys"], kind="attention")
    diagram.link("global_exp", "global_numerator", via=((895, 805), (762.5, 805)))
    diagram.link("global_exp", "global_denominator", via=((895, 805), (1037.5, 805)))

    diagram.op("window_values", 80, 1010, 450, "Mix values: A · Vπ",
               "64 × 32 per head", kind="attention")
    diagram.op("global_values", 670, 1010, 450, "Normalize after value mixing: N / d",
               "T × 32 per head", kind="attention")
    diagram.link("window_weights", "window_values")
    diagram.link("global_numerator", "global_values", via=((762.5, 973), (895, 973)))
    diagram.link("global_denominator", "global_values", via=((1037.5, 973), (895, 973)))
    diagram.link("window_tokens", "window_values", start="right", end="right",
                 via=((565, 504.5), (565, 1043)), kind="skip")
    diagram.text(554, 977, "Vπ", 17, anchor="end")
    diagram.link("global_tokens", "global_numerator", start="left", end="left",
                 via=((627, 504.5), (627, 889.5)), kind="skip")
    diagram.text(638, 793, "V", 17)

    diagram.op("window_restore", 80, 1140, 450, "Assemble windows; crop padding",
               "Join heads → H × W × C")
    diagram.op("global_restore", 670, 1140, 450, "Restore spatial field; join heads",
               "H × W × 1024")
    diagram.link("window_values", "window_restore")
    diagram.link("global_values", "global_restore")
    diagram.note(35, 1300, [
        "Q/K normalization is across channels. The later division normalizes attention over key positions.",
        "Window padding stays in the row sum; global padding is subtracted. Output projection and residual follow.",
    ])
    diagram.save()
    return diagram


def render():
    return [ffn_variants(), attention_variants()]


if __name__ == "__main__":
    render()
