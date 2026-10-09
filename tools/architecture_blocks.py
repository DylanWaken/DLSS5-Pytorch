"""Source-backed residual and FFN tensor-flow diagrams.

Contracts come from Numerics/NRBlock.forward in model.py and decode_block in
weights.py. Matrix dimensions below use the nn.Linear [out, in] convention
after NRBlock transposes the decoded natural-channel matrices.
"""
from pathlib import Path

from architecture_flow import Flow


def residual_block():
    d = Flow("residual_block", "Repeated block: two learned residual paths",
             "FFN before attention · Q / K channel norms are separate from attention normalization over keys", 2300)
    d.tensor("x", 345, 110, 320, "Published input X", "H × W × C")
    d.tensor("override", 835, 110, 325, "Raw skip override", ["0: raw input adapter", "66 / 70: raw upsample merge"])
    d.op("ffn", 345, 215, 320, "FFN transform", ["Dense FFN: C32 / C1024", "Branched FFN: C64–C256", "Grouped FFN: C512", "F(X) is before residual addition"])
    d.op("choose_ffn", 835, 260, 325, "Choose FFN skip R", ["Normally R = X", "Override only for 0 / 66 / 70"], kind="skip")
    d.tensor("ffn_result", 345, 380, 320, "F(X)", "H × W × C")
    d.op("ffn_scale", 835, 410, 325, "Learned channel scale", ["R ⊙ s_ffn", "s_ffn has C values"], kind="skip")
    d.add("ffn_add", 505, 510)
    d.tensor("zraw", 345, 560, 320, "Raw FFN result Z", "Z = F(X) + R ⊙ s_ffn")
    d.op("zpublish", 395, 665, 220, "Publish", "Working precision")
    d.tensor("z", 345, 760, 320, "Published FFN result Zp", "H × W × C")
    d.op("choose_attn", 835, 760, 325, "Choose attention skip", ["C32: raw Z", "Other widths: published Zp"], kind="skip")
    d.op("qkv", 345, 870, 320, "QKV projection", ["C → 3C", "Q, K, V: H × W × C"], kind="attention")
    d.op("attn_scale", 835, 1000, 325, "Learned channel scale", ["Chosen skip ⊙ s_attn", "s_attn has C values"], kind="skip")

    # Show the channel normalization axis, learned Q scale and V bypass.
    for key, x, title in (("q", 35, "Q"), ("k", 300, "K"), ("v", 565, "V")):
        d.tensor(key, x, 985, 230, title, "H × W × (C/32) × 32")
        d.link("qkv", key, via=((505, 972), (x + 115, 972)), kind="attention")
    d.op("qnorm", 35, 1080, 230, "Q L2 norm", ["32 channels per head", "FP32; norm floor 1e−12"], kind="attention")
    d.op("knorm", 300, 1080, 230, "K L2 norm", ["32 channels per head", "FP32; norm floor 1e−12"], kind="attention")
    d.op("vpass", 565, 1080, 230, "V bypass", ["No normalization", "32 values per head"], kind="attention")
    d.op("qscale", 35, 1200, 230, "Q scale + publish", ["Global: × √32, round first", "Round learned head scale", "Multiply, round, publish"], kind="attention")
    d.op("kpublish", 300, 1200, 230, "K publish", "Working precision", kind="attention")
    d.op("vpublish", 565, 1200, 230, "V publish", "Working precision", kind="attention")

    # Expanded figures own tiling/padding details; this view locates both norms.
    d.op("scores", 35, 1360, 760, "Scores → positive weights E", ["Window attention (C≤512): local Q Kᵀ + learned bias", "Global attention (C1024): global Q Kᵀ, no bias", "Apply the family's recovered clamped exponential"], kind="attention")
    d.op("weight_norm", 35, 1510, 760, "Normalize over keys + mix values", ["Window attention: p = publish(round(E / sum64(E)))", "Then output = publish(p @ V): normalize before the value product", "Global attention: N = publish(E) @ V", "Then output = publish(round(N / corrected_sum(E))): divide after the value product"], kind="attention")
    d.tensor("attended", 345, 1680, 320, "Restore attended features", "H × W × C; published")
    d.op("projection", 345, 1770, 320, "Attention projection", "H × W × C → H × W × C", kind="attention")
    d.add("attn_add", 505, 1880)
    d.tensor("yraw", 345, 1930, 320, "Raw block result Y", "Projected attention + scaled skip")
    d.tensor("raw_use", 835, 1930, 325, "Raw-result consumers", ["Encoder tail / block 0: pool", "Block 70: learned output head"])
    d.op("ypublish", 395, 2025, 220, "Publish", "Working precision")
    d.tensor("y", 345, 2120, 320, "Published block result Yp", "Next block / saved encoder skip")

    d.link("x", "ffn")
    d.link("x", "choose_ffn", start="right", end="left", via=((750, 143), (750, 304.5)),
           kind="skip", label="Default skip", label_at=(765, 230))
    d.link("override", "choose_ffn", kind="skip")
    d.link("ffn", "ffn_result")
    d.link("choose_ffn", "ffn_scale", kind="skip")
    d.link("ffn_result", "ffn_add")
    d.link("ffn_scale", "ffn_add", start="left", end="right", via=((750, 454.5), (750, 510)), kind="skip")
    d.link("ffn_add", "zraw")
    d.link("zraw", "zpublish")
    d.link("zpublish", "z")
    d.link("zraw", "choose_attn", start="right", via=((997.5, 593),), kind="skip",
           label="C32 raw path", label_at=(820, 580))
    d.link("z", "choose_attn", start="right", end="left", via=((755, 793), (755, 804.5)), kind="skip")
    d.link("z", "qkv")
    for source, target in (("q", "qnorm"), ("k", "knorm"), ("v", "vpass"),
                           ("qnorm", "qscale"), ("knorm", "kpublish"), ("vpass", "vpublish")):
        d.link(source, target, kind="attention")
    for source, x in (("qscale", 150), ("kpublish", 415)):
        sx, sy = d.port(source, "bottom")
        d.arrow(((sx, sy), (x, 1360)), kind="attention")
    d.link("scores", "weight_norm", kind="attention")
    d.link("vpublish", "weight_norm", start="right", end="right", via=((815, 1233), (815, 1577.5)),
           kind="attention", label="V", label_at=(819, 1490))
    d.link("weight_norm", "attended", via=((415, 1660), (505, 1660)), kind="attention")
    d.link("attended", "projection", kind="attention")
    d.link("choose_attn", "attn_scale", kind="skip")
    d.link("projection", "attn_add", kind="attention")
    d.link("attn_scale", "attn_add", start="right", end="right", via=((1180, 1044.5), (1180, 1880)), kind="skip")
    d.link("attn_add", "yraw")
    d.link("yraw", "raw_use", start="right", end="left", via=((750, 1963), (750, 1974.5)))
    d.link("yraw", "ypublish")
    d.link("ypublish", "y")
    d.note(35, 2220, ["corrected_sum(E) sums unrounded global weights, then removes padded-key contributions; see expanded attention views.",
                      "Raw means before publication, not FP32 storage. No pre-FFN LayerNorm; block 39 is transition-only."])
    d.save()


def ffn_dense():
    d = Flow("ffn_dense", "Dense FFNs: C32 windows and C1024 bottleneck",
             "One expansion and one contraction · both are bias-free linear maps · outputs shown before residual addition", 1110)
    for column, channels, hidden in ((0, 32, 128), (1, 1024, 4096)):
        left = 30 + column * 600
        center = left + 270
        prefix = f"c{channels}"
        d.region(left, 110, 540, 875, f"C{channels}: {channels} → {hidden} → {channels}")
        d.tensor(prefix + "x", center - 175, 170, 350, "Input X", f"H × W × {channels}")
        d.op(prefix + "w1", center - 175, 280, 350, "W1: channel expansion", f"[{hidden}, {channels}] weights")
        d.tensor(prefix + "expanded", center - 175, 390, 350, "Expanded values", f"H × W × {hidden}")
        d.op(prefix + "activation", center - 175, 500, 350, "Activation + publish", ["Reconstructed surrogate gate", "Same shape; working precision"])
        d.tensor(prefix + "hidden", center - 175, 635, 350, "Hidden features", f"H × W × {hidden}")
        d.op(prefix + "w2", center - 175, 745, 350, "W2: channel contraction", f"[{channels}, {hidden}] weights")
        d.tensor(prefix + "result", center - 175, 855, 350, "FFN result F(X)", f"H × W × {channels}")
        path = ("x", "w1", "expanded", "activation", "hidden", "w2", "result")
        for source, target in zip(path, path[1:]):
            d.link(prefix + source, prefix + target)
    d.note(35, 1030, ["Matrix shapes use [output channels, input channels], as stored by NRBlock after checkpoint decoding.",
                      "F(X) enters the FFN residual join in the block diagram; its learned skip scale is not inside this diagram."])
    d.save()


def ffn_branched():
    d = Flow("ffn_branched", "Branched FFNs: every branch sees the full input",
             "C64 / C128 / C256 · E = C / 32 independent learned branches · E = 2 / 4 / 8", 1545)
    d.tensor("x", 450, 115, 300, "Input X", "H × W × C")
    d.op("broadcast", 430, 230, 340, "Broadcast full X to each branch", "No channel split and no router")
    d.link("x", "broadcast")
    columns = ((35, "first", "e = 0"), (435, "middle", "e = 1…E−2"),
               (835, "last", "e = E − 1"))
    for left, prefix, title in columns:
        center = left + 165
        d.region(left, 360, 330, 630, title)
        d.op(prefix + "w1", center - 145, 410, 290, "W1[e]: expand", "C → 128; full C inputs")
        d.op(prefix + "act", center - 145, 520, 290, "Activation + publish", "H × W × 128")
        d.tensor(prefix + "hidden", center - 145, 630, 290, "Hidden features", "H × W × 128")
        d.op(prefix + "w2", center - 145, 740, 290, "W2[e]: contract", "128 → 32")
        d.op(prefix + "publish", center - 145, 850, 290, "Publish branch result", "Working precision")
        d.tensor(prefix + "out", center - 145, 1015, 290, "Branch output B[e]", "H × W × 32")
        d.link("broadcast", prefix + "w1", via=((600, 325), (center, 325)),
               label="Full X: H × W × C" if prefix != "middle" else None,
               label_at=(left + 20, 345) if prefix != "middle" else None)
        for source, target in (("w1", "act"), ("act", "hidden"), ("hidden", "w2"), ("w2", "publish"), ("publish", "out")):
            d.link(prefix + source, prefix + target)
    d.op("concat", 340, 1160, 520, "Concatenate ordered channel slices", ["B[0] | B[1] | … | B[E−1]", "H × W × (32E) = H × W × C"])
    for prefix, x in (("first", 405), ("middle", 600), ("last", 795)):
        sx, sy = d.port(prefix + "out", "bottom")
        d.arrow(((sx, sy), (sx, 1125), (x, 1125), (x, 1160)))
    d.op("w3", 450, 1290, 300, "W3: mix concatenated channels", "C → C")
    d.tensor("result", 450, 1400, 300, "FFN result F(X)", "H × W × C; before residual")
    d.link("concat", "w3")
    d.link("w3", "result")
    d.note(35, 1500, "Middle represents branches 1…E−2 (none for C64). Every branch executes; weights differ by branch.")
    d.save()


def ffn_grouped():
    d = Flow("ffn_grouped", "Grouped C512 FFN: mix first, then split channels",
             "The eight groups receive disjoint 64-channel slices of the mixed tensor; they do not receive full X", 2020)
    d.tensor("x", 440, 110, 320, "Input X", "H × W × 512")
    d.op("w1", 440, 215, 320, "W1: mix all channels", "512 → 512")
    d.op("publish_mix", 440, 320, 320, "Publish mixed features", "Working precision")
    d.tensor("mixed", 440, 425, 320, "Mixed tensor M", "H × W × 512")
    d.op("split", 420, 530, 360, "Split channel axis into eight groups", "M[0:64] | M[64:128] | …")
    for source, target in (("x", "w1"), ("w1", "publish_mix"), ("publish_mix", "mixed"), ("mixed", "split")):
        d.link(source, target)
    columns = ((35, "first", "Group 0", "M[..., 0:64]"),
               (435, "middle", "Groups 1…6", "M[..., 64e:64(e+1)]"),
               (835, "last", "Group 7", "M[..., 448:512]"))
    for left, prefix, title, slice_label in columns:
        center = left + 165
        d.region(left, 655, 330, 775, title)
        d.tensor(prefix + "input", center - 145, 710, 290, "Group input", [slice_label, "H × W × 64"])
        d.op(prefix + "w2", center - 145, 850, 290, "W2[e]: expand", "64 → 256")
        d.op(prefix + "act", center - 145, 955, 290, "Activation + publish", "H × W × 256")
        d.tensor(prefix + "hidden", center - 145, 1060, 290, "Hidden features", "H × W × 256")
        d.op(prefix + "w3", center - 145, 1165, 290, "W3[e]: contract", "256 → 64")
        d.op(prefix + "publish", center - 145, 1270, 290, "Publish group result", "Working precision")
        d.tensor(prefix + "out", center - 145, 1460, 290, "Group output G[e]", "H × W × 64")
        d.link("split", prefix + "input", via=((600, 625), (center, 625)))
        for source, target in (("input", "w2"), ("w2", "act"), ("act", "hidden"), ("hidden", "w3"), ("w3", "publish"), ("publish", "out")):
            d.link(prefix + source, prefix + target)
    d.op("concat", 340, 1590, 520, "Concatenate in original group order", ["G[0] | G[1] | … | G[7]", "H × W × (8 × 64) = H × W × 512"])
    for prefix, x in (("first", 405), ("middle", 600), ("last", 795)):
        sx, sy = d.port(prefix + "out", "bottom")
        d.arrow(((sx, sy), (sx, 1555), (x, 1555), (x, 1590)))
    d.op("w4", 440, 1715, 320, "W4: final channel mixing", "512 → 512")
    d.tensor("result", 440, 1830, 320, "FFN result F(X)", "H × W × 512; before residual")
    d.link("concat", "w4")
    d.link("w4", "result")
    d.note(35, 1960, "All eight groups execute. The middle path repeats independently for e = 1…6, each with its own weights.")
    d.save()


def source_checks():
    """Fail fast if the defining branches change and the diagrams need review."""
    root = Path(__file__).resolve().parents[1]
    model = (root / "dlssnr/model.py").read_text(encoding="utf8")
    weights = (root / "dlssnr/weights.py").read_text(encoding="utf8")
    contracts = (
        "residual = state if skip_override is None else skip_override",
        "if c in (32, 1024):",
        "for expert in range(c // 32):",
        "hidden = n.linear_activate(state, self.w1[expert])",
        "branches = n.publish(n.linear(state, self.w1)).split(64, dim=-1)",
        "for branch in range(8):",
        "raw if c == 32 else ffn",
        "return n.publish(raw_out), raw_out",
        "skip_override=raw_merge if index == 66 else None",
        "phase, skip_override=raw_adapter",
        "phase, skip_override=raw_merge",
        "q, k = n.norm(q), n.norm(k)",
        "q = n.round(q * math.sqrt(32))",
        "q = n.publish(n.round(q * n.round(self.head_scale).unsqueeze(-1)))",
        "k, v = n.publish(k), n.publish(v)",
        "p = n.publish(n.round(e * n.reciprocal(n.sum64(e))))",
        "attended = n.publish(n.matmul(p, vw.transpose(-1, -2)))",
        "output = n.matmul(n.publish(exponentials), v.transpose(-1, -2))",
        "total = n.reduction_round(total - correction)",
        "output = n.publish(n.round(output * n.reciprocal(total)))",
    )
    for contract in contracts:
        if contract not in model:
            raise ValueError(f"Review block diagrams against model.py: {contract}")
    for contract in ("c, 128", "128, c", "e, c, 128", "e, 128, 32", "8, 64, 256", "8, 256, 64", "1024, 4096", "4096, 1024"):
        if contract not in weights:
            raise ValueError(f"Review FFN matrix dimensions against weights.py: {contract}")
    return {"model_contracts": len(contracts), "weight_shapes": 8}


def render():
    source_checks()
    residual_block()
    ffn_dense()
    ffn_branched()
    ffn_grouped()
    return ["residual_block.svg", "ffn_dense.svg", "ffn_branched.svg", "ffn_grouped.svg"]


if __name__ == "__main__":
    print(render())
