"""Source-grounded Manim film: one token through FP16 C1024 FFN expansion.

Render with render.py. Every caption is both burned into the film and exported
as a timed cue; assembly produces WebVTT, chapters and an illustrated transcript.
Coordinates and colors are pedagogical; instruction scheduling is dependency
order, never a claimed cycle-accurate trace or physical register-bank placement.
"""
from __future__ import annotations

import json
import os
from pathlib import Path
import textwrap

from manim import *
import numpy as np

BG = "#0B1020"
PANEL = "#141E33"
INK = "#E8EDF7"
MUTED = "#9AACC5"
A = "#58C4DD"
B = "#C99BFF"
C = "#83E3AB"
TOKEN = "#FFD166"
RED = "#FF7A90"
GRID = "#344766"
config.background_color = BG
config.frame_width = 16
config.frame_height = 9
TEMPLATE = TexTemplate(
    documentclass=r"\documentclass[preview]{standalone}",
    preamble=r"\usepackage{amsmath}\usepackage{amssymb}",
)


def label(s, size=25, color=INK, **kwargs):
    return Text(s, font="Segoe UI", font_size=size, color=color, **kwargs)


def formula(s, size=34, color=INK):
    return MathTex(s, tex_template=TEMPLATE, font_size=size, color=color)


def code(s, size=21):
    return Text(s, font="Consolas", font_size=size, color=INK,
                t2c={"LoadWeights": B, "StageInput": A, "WaitStage": TOKEN,
                     "AccumulateTile": C, "FfnActivation": C,
                     "uint4": A, "for": B, "if": B, "__ldca": B,
                     "StoreNoAllocate": C, "mma.sync": C})


def box(text, center, width=3, height=1, color=A, size=23):
    r = RoundedRectangle(width=width, height=height, corner_radius=.12,
                         stroke_color=color, stroke_width=2,
                         fill_color=PANEL, fill_opacity=1).move_to(center)
    t = label(text, size, color).move_to(r)
    if t.width > width-.25:
        t.scale_to_fit_width(width-.25)
    return VGroup(r, t)


def matrix(rows, cols, width, height, center=ORIGIN, color=A):
    cells = VGroup(*[
        Rectangle(width=width/cols, height=height/rows,
                  stroke_color=GRID, stroke_width=.8,
                  fill_color=color, fill_opacity=.08)
        for _ in range(rows*cols)
    ])
    cells.arrange_in_grid(rows=rows, cols=cols, buff=0).move_to(center)
    return cells


def arrow(start, end, color=MUTED, **kwargs):
    return Arrow(start, end, buff=.12, color=color, stroke_width=3,
                 max_tip_length_to_length_ratio=.15, **kwargs)


class LessonScene(Scene):
    chapter = ""
    number = 0
    source = "global_ffn_expand_c1024_fp16.cu"

    def setup(self):
        self.cues = []
        self.last_cue = None
        self.caption = None
        self.fixed = VGroup()
        top = label(f"{self.number:02d}  {self.chapter}", 33).to_corner(UL, buff=.43)
        stripe = Line([-7.55, 3.4, 0], [7.55, 3.4, 0], color=GRID)
        legend = VGroup(label("X / A", 17, A), label("W / B", 17, B),
                        label("accumulator / U", 17, C), label("token 83", 17, TOKEN))
        legend.arrange(RIGHT, buff=.45).to_corner(UR, buff=.47).shift(DOWN*.58)
        footer = label("FP16 C1024 FFN expansion  |  source fc3276497f86  |  " + self.source,
                       14, MUTED)
        if footer.width > 15:
            footer.scale_to_fit_width(15)
        footer.to_edge(DOWN, buff=.15)
        self.caption_bg = Rectangle(width=15.1, height=1.08, stroke_width=0,
                                    fill_color=BG, fill_opacity=1).move_to([0, -3.61, 0])
        self.fixed.add(top, stripe, legend, footer, self.caption_bg)
        self.add(self.fixed)

    def beat(self, caption, *animations, hold=None, run=1.5):
        now = float(self.renderer.time)
        if self.last_cue is not None:
            self.last_cue["end"] = now
        self.last_cue = {"start": now, "end": None, "text": caption}
        self.cues.append(self.last_cue)
        if self.caption is not None:
            self.remove(self.caption)
        # Two comfortably sized lines, independent of visual formula labels.
        lines = textwrap.wrap(caption, width=112)
        self.caption = label("\n".join(lines), 23).move_to([0, -3.60, 0])
        if self.caption.width > 14.7:
            self.caption.scale_to_fit_width(14.7)
        if self.caption.height > .88:
            self.caption.scale_to_fit_height(.88)
        self.add(self.caption)
        duration = hold if hold is not None else max(5.0, len(caption)/17.5)
        if animations:
            self.play(*animations, run_time=run)
            self.wait(max(.2, duration-run))
        else:
            self.wait(duration)

    def flow(self, origin, target, color=TOKEN, radius=.085):
        dot = Dot(origin, radius=radius, color=color)
        self.add(dot)
        return dot, dot.animate.move_to(target)

    def finish(self):
        self.wait(.7)
        self.last_cue["end"] = float(self.renderer.time)
        out = Path(os.environ.get("KERNEL_VIDEO_META", "media/kernel-video-meta"))
        out.mkdir(parents=True, exist_ok=True)
        (out / f"{self.number:02d}.json").write_text(json.dumps({
            "scene": self.__class__.__name__, "number": self.number,
            "chapter": self.chapter, "duration": float(self.renderer.time),
            "source": self.source, "cues": self.cues,
        }, indent=2), encoding="utf-8")


class Ch01Model(LessonScene):
    number = 1
    chapter = "A token enters the expansion"

    def construct(self):
        x = matrix(12, 16, 3.1, 3, [-5, .8, 0], A)
        w = matrix(16, 24, 3.5, 3, [0, .8, 0], B)
        u = matrix(12, 24, 3.1, 3, [5, .8, 0], C)
        labels = VGroup(label("X: T × 1024", 27, A).next_to(x, UP),
                        label("W₁: 1024 × 4096", 27, B).next_to(w, UP),
                        label("U: T × 4096", 27, C).next_to(u, UP))
        self.beat("The bottleneck dense FFN expands every token from 1024 channels to 4096, then applies its activation.",
                  FadeIn(x), FadeIn(w), FadeIn(u), FadeIn(labels))
        r = 5
        selected = VGroup(*x[r*16:(r+1)*16])
        result = VGroup(*u[r*24:(r+1)*24])
        t = label("one row = token 83", 24, TOKEN).next_to(x, DOWN)
        eq = formula(r"U_{83,n}=\phi\!\left(\sum_{k=0}^{1023} X_{83,k}W_{k,n}\right)", 37).move_to([0,-1.9,0])
        self.beat("Keep your eye on the gold row: token 83. Its outputs depend on all 1024 input channels, and on no other token.",
                  selected.animate.set_fill(TOKEN, .85), FadeIn(t), Write(eq))
        tracks = VGroup(*[arrow([-3.35,.92-j*.13,0],[3.35,.92-j*.13,0],TOKEN)
                          for j in range(3)])
        self.beat("We will follow one contribution, X[83,114] times W[114,34], into output channel 34, then reconnect it to the whole token.",
                  Create(tracks), result.animate.set_fill(TOKEN,.85))
        architecture = VGroup(box("bottleneck X",[-4,-2.75,0],2.5,.55,A,20),
                              box("expand + activation",[0,-2.75,0],3.6,.55,TOKEN,20),
                              box("later: contract + residual",[4.7,-2.75,0],4,.55,C,20))
        self.beat("This entry has no bias and no residual addition. The later FFN contraction consumes the packed expansion output.",
                  FadeIn(architecture))
        self.finish()


class Ch02Launch(LessonScene):
    number = 2
    chapter = "From model dimensions to CUDA blocks"
    source = "plan_fp16_generated.inl + entry lines 12–24"

    def construct(self):
        grid = matrix(17,32,7.5,4.3,[-3.1,.35,0], C)
        gridlabel = label("17 token tiles × 32 channel tiles = 544 CTAs",24).next_to(grid,UP)
        h = label("T = 36 × 60 = 2160  (batch 1)",24,A).move_to([3.8,2.55,0])
        eq = formula(r"M_{tiles}=\lceil T/128\rceil=17",30).move_to([3.8,1.8,0])
        self.beat("For the 4K architecture example, T is 2160. A block covers 128 tokens by 128 output channels, so the grid has 544 blocks.",
                  FadeIn(grid), FadeIn(gridlabel), FadeIn(h), Write(eq))
        f = VGroup(formula(r"nBlock=\lfloor blockIdx.x/17\rfloor",25),
                   formula(r"firstGroup=(blockIdx.x\bmod17)\,8",25),
                   code("grid = (544, 1, 1)\nblock = (32, 4, 1)",24))
        f.arrange(DOWN,buff=.3).move_to([3.8,.2,0])
        self.beat("The linear block index changes token tiles first. CTA zero owns tokens 0 through 127 and output channels 0 through 127.",
                  grid[0].animate.set_fill(TOKEN,1), FadeIn(f))
        sms = VGroup(*[box(f"SM {j}",[j*2-5,-2.5,0],1.55,.58,MUTED,20) for j in range(4)])
        dot, motion = self.flow(grid[0].get_center(),sms[1].get_center())
        self.beat("Hardware assigns ready CTAs to SMs. These arrows illustrate possible dispatch, not a fixed SM assignment or measured issue timing.",
                  FadeIn(sms), motion, run=2.5)
        thread = label("threadIdx.x = lane 0…31\nthreadIdx.y = warp 0…3",25,TOKEN).move_to([3.8,-1.75,0])
        self.beat("Inside one block, 128 threads form four warps. All four produce input copies and all four perform matrix work; there is no dedicated producer warp.",
                  FadeIn(thread))
        self.finish()


class Ch03Tiling(LessonScene):
    number = 3
    chapter = "A hierarchy of output tiles"

    def construct(self):
        cta = matrix(2,2,4.4,4.1,[-4.4,.4,0],C)
        warpnames = VGroup(*[label(f"warp {j}\n64 × 64",25,TOKEN if j==2 else INK).move_to(cta[j]) for j in range(4)])
        ctalab = label("CTA: 128 tokens × 128 channels",25,C).next_to(cta,UP)
        self.beat("Warp parity selects the left or right channel half. Floor of warp divided by two selects the upper or lower token half.",
                  FadeIn(cta), FadeIn(warpnames), FadeIn(ctalab))
        tiles = matrix(4,4,4.4,4.1,[2.9,.4,0],C)
        titles = VGroup(label("warp 2: tokens 64…127; channels 0…63",22,TOKEN).next_to(tiles,UP),
                       label("4 M16 rows × 4 N16 columns",23).next_to(tiles,DOWN))
        self.beat("Token 83 is in warp 2's lower token half. Four M16 fragments and four N16 groups subdivide that warp's 64 by 64 outputs.",
                  cta[2].animate.set_fill(TOKEN,.25), TransformFromCopy(cta[2],tiles), FadeIn(titles))
        chosen=tiles[1*4+2]
        callout = label("m = 1, n16 = 2\ntokens 80…95\nchannels 32…47",23,TOKEN).move_to([-4.4,-2.35,0])
        self.beat("Our output [83,34] lives at M fragment one and N16 group two. An N16 group splits again into channels 32–39 and 40–47.",
                  chosen.animate.set_fill(TOKEN,.8), FadeIn(callout),
                  Create(Line(chosen.get_top(),chosen.get_bottom(),color=RED,stroke_width=4)))
        native = formula(r"(16\times16)\,(16\times8)+(16\times8)\longrightarrow16\times8",30).move_to([2.7,-2.5,0])
        self.beat("Each native MMA reduces 16 K values for 16 tokens and 8 output channels. Two N8 instructions cover N16; two K16 subtiles cover each K32 step.",
                  Write(native))
        self.finish()


class Ch04ALanes(LessonScene):
    number = 4
    chapter = "A logical token becomes lane fragments"
    source = "mma.cuh + native m16n8k16 fragment map"

    def construct(self):
        mat = matrix(16,16,5.4,4.3,[-4,.3,0],A)
        title=label("A panel: tokens 80…95 × K112…127",23,A).next_to(mat,UP)
        self.beat("Zoom into the second K16 panel of reduction step three. Token 83 is local row three; channel 114 is local K two.",
                  FadeIn(mat), FadeIn(title),
                  mat[3*16+2].animate.set_fill(TOKEN,1))
        coords=[(3,2),(3,3),(11,2),(11,3),(3,10),(3,11),(11,10),(11,11)]
        words=VGroup(*[box(s,[3.55,2.05-j*.65,0],5.5,.52,TOKEN if j%2==0 else A,22) for j,s in enumerate([
            "word 0: X[83,114] | X[83,115]",
            "word 1: X[91,114] | X[91,115]",
            "word 2: X[83,122] | X[83,123]",
            "word 3: X[91,122] | X[91,123]",
        ])])
        wordtitle=label("lane L = 13: four packed Half2 words",23,TOKEN).move_to([3.55,2.65,0])
        self.beat("Lane 13 owns eight Half values in four 32-bit words. Its fragment interleaves two token rows and two separated K pairs.",
                  *[mat[r*16+k].animate.set_fill(TOKEN if r==3 else A,.9) for r,k in coords],
                  FadeIn(words),FadeIn(wordtitle))
        eq=VGroup(formula(r"g=\lfloor L/4\rfloor=3,\quad q=L\bmod4=1",29),
                  formula(r"row=g+8(j\bmod2)",28),
                  formula(r"k=2q+8\lfloor j/2\rfloor+h",28),
                  label("word j = 0…3; half h = 0 or 1",21,MUTED))
        eq.arrange(DOWN,buff=.17).move_to([3.55,-1.5,0])
        self.beat("The map is explicit: lane gives g and q; word index j selects the row and K half; h selects the low or high 16-bit value.",
                  Write(eq))
        moving=[]
        for j in range(4):
            dot,motion=self.flow(mat[coords[2*j][0]*16+coords[2*j][1]].get_center(),words[j].get_left()+RIGHT*.12,
                                 TOKEN if j%2==0 else A)
            moving.append(motion)
        self.beat("The whole token row is distributed over lanes 12 through 15. Packing arranges each lane's eight values contiguously before this kernel starts.",
                  *moving, run=2.3)
        self.finish()


class Ch05GlobalAddress(LessonScene):
    number = 5
    chapter = "Compute the exact input address"

    def construct(self):
        groups=VGroup(*[box(f"g={j}",[j*1.0-5.5,2.25,0],.85,.65,A,20) for j in range(8)])
        title=label("Packed X: one group = 16 tokens × 1024 Half = 32768 bytes",26).move_to([0,1.45,0])
        self.beat("A global token group stores sixteen complete token rows in native panels. Group five contains tokens 80 through 95 and begins at byte 163840.",
                  FadeIn(groups), FadeIn(title))
        self.play(groups[5][0].animate.set_stroke(TOKEN,4).set_fill(TOKEN,.18), run_time=.7)
        steps=VGroup(*[box(f"i={j}",[j*1.7-5.8,.5,0],1.45,.7,A,22) for j in range(7)])
        rest=label("… 31",23,MUTED).next_to(steps,RIGHT)
        self.beat("Within that group, each K32 step occupies 1024 bytes. Step three adds 3072 bytes; the second K16 panel adds another 512.",
                  FadeIn(steps), FadeIn(rest))
        self.play(steps[3][0].animate.set_stroke(TOKEN,4).set_fill(TOKEN,.18), run_time=.7)
        panels=VGroup(box("K96…111",[-2,-.55,0],3.6,.65,A,24),box("K112…127",[2,-.55,0],3.6,.65,TOKEN,24))
        eq=formula(r"5\cdot32768+3\cdot1024+1\cdot512+13\cdot16=167632",34,TOKEN).move_to([0,-1.55,0])
        self.beat("Inside the panel, lane 13's sixteen-byte vector adds 208 bytes. X[83,114] is the low Half of its first word, so no further offset is needed.",
                  FadeIn(panels), Write(eq))
        note=label("adjusted X base + 167632 bytes\nexample: blockIdx.z = 0; all addresses here are byte offsets",24,MUTED).move_to([0,-2.5,0])
        self.beat("This is a packed address, not row times stride plus channel. The host launch uses grid.z equal to one; the source still defines explicit Z base adjustments.",
                  FadeIn(note))
        self.finish()


class Ch06AsyncCopy(LessonScene):
    number = 6
    chapter = "Producer lanes move the packed slab"
    source = "entry StageInput + intrinsics.cuh CopyBulk"

    def construct(self):
        glob=box("device memory X\n+167632",[-5,1.8,0],3,1.3,A,26)
        cache=box("L2 cache",[-1.2,1.8,0],2.7,1.3,MUTED,25)
        smem=box("shared slot 0\n+5840",[3.3,1.8,0],3.6,1.3,A,26)
        paths=VGroup(arrow(glob.get_right(),cache.get_left(),A),arrow(cache.get_right(),smem.get_left(),A))
        self.beat("Producer warp one copies group five: warp plus four. On SM80 and SM89, every lane issues two sixteen-byte asynchronous stripes for this 1024-byte slab.",
                  FadeIn(glob), FadeIn(cache), FadeIn(smem), Create(paths))
        stripes=VGroup(box("stripe 0: 32 lanes × 16 B = 512 B",[-3,-.05,0],6,.7,A,23),
                       box("stripe 1: 32 lanes × 16 B = 512 B",[3.3,-.05,0],6,.7,TOKEN,23))
        inst=code("cp.async.cg.shared.global [smem], [global], 16;\ncp.async.mbarrier.arrive.shared.b64 [barrier];",23).move_to([0,-1.0,0])
        dot,motion=self.flow(glob.get_right(),smem.get_left()+RIGHT*.12)
        self.beat("Our value is in stripe one, lane 13. The .cg copy path uses global-level caching and attaches asynchronous completion to the stage barrier.",
                  FadeIn(stripes), FadeIn(inst), motion,run=2.5)
        eq=formula(r"0\cdot8192+1\cdot1024+1\cdot4096+512+13\cdot16=5840",29,TOKEN).move_to([0,-1.85,0])
        self.beat("The shared destination sums the slot, producer warp, second copy group, second stripe and lane vector. The bytes arrive unchanged at shared offset 5840.",Write(eq))
        alt=box("SM90+: one elected lane per warp issues cp.async.bulk (1024 B)\nBarrierExpect adds 1024 expected bytes; ordinary addresses, no tensor descriptor",
                [0,-2.62,0],14.2,.85,B,20)
        self.beat("The compiled SM90-plus branch elects one bulk-copy issuer instead. Both branches populate the same layout, but their copy and completion instructions differ.",FadeIn(alt))
        exact=code("elect.sync _|elected, 0xffffffff;\n"
                   "cp.async.bulk.shared::cta.global.mbarrier::complete_tx::bytes\n"
                   "    [shared], [global], 1024, [barrier];",21).move_to([0,-1.03,0])
        self.beat("The SM90 instruction explicitly completes transaction bytes against the shared barrier. elect.sync selects one issuer from the converged full warp.",
                  FadeOut(stripes),FadeOut(inst),FadeOut(eq),FadeIn(exact))
        self.finish()


class Ch07SharedLayout(LessonScene):
    number = 7
    chapter = "Shared memory: panels, banks, no XOR"

    def construct(self):
        slot=matrix(8,2,4.0,3.6,[-4.35,.55,0],A)
        glabels=VGroup(*[label(f"group {j}",19,TOKEN if j==5 else MUTED).next_to(slot[2*j],LEFT,buff=.15) for j in range(8)])
        cap=label("one slot = 8 × 1024 = 8192 bytes",24,A).next_to(slot,UP)
        self.beat("Each shared slot contains eight token groups, each split into two 512-byte native A panels. Three slots plus three eight-byte barriers total 24600 bytes.",
                  FadeIn(slot), FadeIn(glabels), FadeIn(cap))
        lanevec=VGroup(*[box(str(j),[.6+(j%8)*.78,1.5-(j//8)*.53,0],.7,.42,TOKEN if j==13 else A,17) for j in range(32)])
        self.beat("The highlighted panel holds K112 through 127 for group five. Its 32 lane vectors occupy offsets zero, sixteen, thirty-two, and so on.",
                  slot[11].animate.set_fill(TOKEN,.8), FadeIn(lanevec))
        eq=formula(r"s=0\cdot8192+\lfloor2/2\rfloor4096+1\cdot1024+1\cdot512+13\cdot16",24).move_to([2.9,-.7,0])
        noxor=label("consumer warp 2, m=1, kSub=1, lane 13\nshared +5840 → A registers; no transpose / ldmatrix",23,TOKEN).move_to([2.8,-1.45,0])
        self.beat("Consumer warp two reaches the same byte address by its own formula. Warp three reuses this A tile for the other channel half. No XOR swizzle or ldmatrix is used.",
                  Write(eq), FadeIn(noxor))
        banks=VGroup(*[box(str(j),[-6.2+j*.4,-2.55,0],.37,.48,TOKEN if 20<=j<=23 else MUTED,15) for j in range(32)])
        bformula=formula(r"bank(5840+4j)=(1460+j)\bmod32",27).move_to([2.6,-2.08,0])
        self.beat("For this vector, the four 32-bit words address banks 20, 21, 22 and 23. Bank numbers alone do not prove conflicts: transaction grouping also matters.",
                  FadeIn(banks), Write(bformula))
        pointer=SurroundingRectangle(lanevec[13],color=TOKEN,buff=.06,stroke_width=3)
        self.beat("A shared pointer is converted to the CTA shared address space before inline PTX uses it. Lane index selects a vector; word index selects a bank; half index selects two bytes.",
                  Create(pointer))
        self.finish()


class Ch08Pipeline(LessonScene):
    number = 8
    chapter = "The three-slot pipeline, in source order"
    source = "entry lines 58–125 + memoryops.cuh"

    def construct(self):
        slots=VGroup(*[box(f"slot {j}\nA{j}",[j*4.4-4.4,1.65,0],3.7,1.25,A,29) for j in range(3)])
        barriers=VGroup(*[box(f"barrier @{24576+j*8}",[j*4.4-4.4,.55,0],3.7,.55,TOKEN,21) for j in range(3)])
        regs=box("B0 in registers",[0,-.6,0],4,.75,B,26)
        self.beat("Lane zero of warp zero initializes each barrier for 128 arrivals, then the CTA synchronizes. The prologue loads B0, issues A0, A1 and A2, and waits for A0.",
                  FadeIn(slots), FadeIn(barriers), FadeIn(regs))
        ptx=code("mbarrier.init.shared.b64 [barrier], 128;\n"
                 "mbarrier.arrive.shared.b64 phase, [barrier];\n"
                 "mbarrier.test_wait.shared.b64 ready, [barrier], phase;",22).move_to([0,-1.85,0])
        self.beat("On SM80 and SM89, mbarrier.init sets the arrival count. Every thread obtains a phase token with arrive, then test_wait polls completion of that exact phase.",FadeIn(ptx))
        ptx90=code("SM90+: mbarrier.arrive.shared::cta.b64 phase, [barrier], 1;\n"
                   "        mbarrier.try_wait.shared::cta.b64 ready, [barrier], phase;\n"
                   "        mbarrier.expect_tx.relaxed.cta.shared::cta.b64 [barrier], 1024;",19).move_to([0,-1.85,0])
        self.beat("SM90 uses the CTA-scoped arrive and try_wait forms, plus expected transaction bytes for bulk copies. Readiness includes copy completion, not just thread arrivals.",
                  ReplacementTransform(ptx,ptx90))
        self.play(FadeOut(ptx90),run_time=.7)
        order=code("read A[i % 3] → MMA with B[i]\nLoadWeights(i + 1) → WaitStage((i + 1) % 3)\nStageInput(i + 3, i % 3)",25).move_to([0,-1.85,0])
        self.beat("Read A0 into registers and perform the MMA work. Then preload B1, wait for A1, and only then refill retired slot zero with A3.",
                  slots[0][0].animate.set_stroke(TOKEN,5), FadeIn(order))
        self.play(Transform(regs,box("B1 in registers",[0,-.6,0],4,.75,B,26)),
                  Indicate(barriers[1],color=TOKEN),run_time=1.2)
        self.beat("Every thread arrives after its preceding consumption. Waiting for the next stage establishes that old readers have advanced before the consumed slot is recycled.",
                  Transform(slots[0],box("slot 0\nA3",[-4.4,1.65,0],3.7,1.25,A,29)))
        for i in (1,2,3):
            self.play(slots[i%3][0].animate.set_stroke(TOKEN,5),
                      Transform(regs,box(f"B{i} → compute step {i}",[0,-.6,0],5,.75,B,26)),run_time=.8)
            self.play(Indicate(barriers[(i+1)%3],color=TOKEN),run_time=.7)
            self.play(Transform(slots[i%3],box(f"slot {i%3}\nA{i+3}",[(i%3)*4.4-4.4,1.65,0],3.7,1.25,A,29)),run_time=.8)
        self.beat("After steps one and two, step three revisits slot zero. A fresh arrival phase token distinguishes this use from the earlier completed phase.",
                  Indicate(barriers[0],color=TOKEN))
        timeline=VGroup(*[Rectangle(width=.38,height=.25,fill_color=C if j<4 else A,fill_opacity=.5,stroke_width=0).move_to([-6.1+j*.395,-2.75,0]) for j in range(32)])
        self.beat("The same dependency pattern continues through all 32 K32 steps. Animation spacing is explanatory; actual warp interleaving and latency depend on hardware.",FadeIn(timeline))
        for i in range(4,29):
            self.play(timeline[i].animate.set_fill(TOKEN,1),run_time=.09,rate_func=linear)
        self.beat("Step 28 performs the final refill, A31. Steps 29, 30 and 31 drain the ring; step 31 has neither a next-B load nor a next-stage wait.",
                  *[timeline[i].animate.set_fill(C,1) for i in (29,30,31)],
                  *[Transform(slots[j],box(f"slot {j}\nA{(30,31,29)[j]} consumed",[j*4.4-4.4,1.65,0],3.7,1.25,C,27)) for j in range(3)],
                  Transform(regs,box("B31: reduction complete",[0,-.6,0],5,.75,C,24)))
        self.finish()


class Ch09Weights(LessonScene):
    number = 9
    chapter = "B takes a different route and lane map"

    def construct(self):
        w=matrix(16,8,3.9,4,[-4.7,.3,0],B)
        title=label("B: K112…127 × channels 32…39",23,B).next_to(w,UP)
        self.beat("Weights are not staged in shared memory. Cache-all vector loads fetch their prepacked words directly from global memory into each warp's B registers.",
                  FadeIn(w), FadeIn(title),w[2*8+2].animate.set_fill(TOKEN,1))
        route=VGroup(box("device memory W",[2.8,2.5,0],5,.58,B,23),
                     box("L2 cache",[2.8,1.72,0],5,.58,MUTED,23),
                     box("L1 permitted by __ldca",[2.8,.94,0],5,.58,MUTED,23),
                     box("B lane 9 registers",[2.8,.16,0],5,.58,B,23))
        self.beat("For the lower N8 fragment, lane L has column floor(L/4). Its first K pair starts at twice (L modulo four), and its second starts eight later. W[114,34] belongs to lane nine.",
                  FadeIn(route),*[w[r*8+2].animate.set_fill(TOKEN,.85) for r in (2,3,10,11)])
        cache_dot=Dot(route[0].get_left()+RIGHT*.12,color=TOKEN,radius=.07)
        self.add(cache_dot)
        for j in range(1,4):
            self.play(cache_dot.animate.move_to(route[j].get_left()+RIGHT*.12),run_time=.65)
        self.beat("The cache-all load permits both L2 and L1 caching. This hierarchy shows eligible storage levels; the actual cache hits, misses and residency were not measured.")
        eq=formula(r"(2\cdot3+1)131072+2\cdot512+9\cdot16=918672",31,B).move_to([1.9,-1,0])
        words=label("lane 9 word 0: W[114,34] | W[115,34]\nword 1: W[122,34] | W[123,34]\nwords 2–3: corresponding pairs for channel 42",22,B).move_to([2.1,-2.05,0])
        self.beat("The K-panel stride is 4096 times 32 bytes, or 131072. N16 group two adds 1024; lane nine adds 144. The selected weight is the low Half at byte 918672.",
                  Write(eq), FadeIn(words))
        self.beat("The complete weight column spans lanes eight through eleven. The input row spans lanes twelve through fifteen. A Tensor Core instruction combines these distributed operands.",
                  *[w[r*8+2].animate.set_fill(B,.65) for r in range(16) if r not in (2,3,10,11)])
        self.finish()


class Ch10MMA(LessonScene):
    number = 10
    chapter = "One product inside a warp-wide MMA"
    source = "mma.cuh + tiled_mma.cuh"

    def construct(self):
        am=matrix(1,16,6,.65,[-3.6,1.65,0],A)
        bm=matrix(16,1,.7,3.3,[2.1,.65,0],B)
        d=box("D lane 13\n[83,34]",[5.35,.65,0],2.8,1.25,C,26)
        al=label("token 83 across A lanes 12…15",23,A).next_to(am,UP)
        bl=label("channel 34\nB lanes 8…11",21,B).next_to(bm,UP)
        klabels=VGroup(label("K112",19,MUTED).next_to(am[0],DOWN),
                       label("K127",19,MUTED).next_to(am[15],DOWN))
        self.beat("This is a collective operation: all 32 lanes execute the same MMA instruction. A lane does not independently multiply only its own A and B registers.",
                  FadeIn(am), FadeIn(bm), FadeIn(d),FadeIn(al),FadeIn(bl),FadeIn(klabels))
        acell=am[2]; bcell=bm[2]
        self.beat("Our selected product uses X[83,114] from A lane thirteen and W[114,34] from B lane nine. The result contributes to D lane thirteen.",
                  acell.animate.set_fill(TOKEN,1),bcell.animate.set_fill(TOKEN,1))
        da,ma=self.flow(acell.get_center(),[.25,-.25,0])
        db,mb=self.flow(bcell.get_center(),[.25,-.25,0])
        times=label("×",35,TOKEN).move_to([.25,-.25,0])
        self.beat("The hardware operand network brings matching K values together. This highlight explains logical data dependency, not an exposed physical multiplier or register-bank route.",ma,mb,FadeIn(times),run=2.5)
        self.remove(da,db)
        product,mp=self.flow([.25,-.25,0],d.get_left()+RIGHT*.12)
        eq=formula(r"D_{83,34}\leftarrow C_{83,34}+\sum_{k=112}^{127}X_{83,k}W_{k,34}",34).move_to([0,-1.55,0])
        self.beat("Our highlighted product is one of sixteen K contributions. The instruction updates all 128 elements of its M16 by N8 result, using Half accumulation.",mp,Write(eq),run=2.4)
        inst=code("mma.sync.aligned.m16n8k16.row.col.f16.f16.f16.f16",23).move_to([0,-2.35,0])
        self.beat("The PTX shape is m16n8k16, row A and column B, with FP16 operands and accumulator. Treat this grouped operation as the numerical unit, not sixteen scalar additions.",FadeIn(inst))
        self.finish()


class Ch11Registers(LessonScene):
    number = 11
    chapter = "Reuse operands; keep the output live"
    source = "tiled_mma.cuh AccumulateTile"

    def construct(self):
        regs=matrix(4,4,4.4,3.6,[-4.3,.6,0],C)
        names=VGroup(*[label("4 words",17,C).move_to(cell) for cell in regs])
        counts=VGroup(label("per lane, declared tile storage",25),
                      label("C[4][4][4] = 64 × 32-bit words",26,C),
                      label("A[4][2] uint4 = 32 words",25,A),
                      label("B[2][4] uint4 = 32 words",25,B))
        counts.arrange(DOWN,buff=.32).move_to([3.2,1.6,0])
        self.beat("Each lane keeps 64 accumulator words alive across the entire reduction. The declared input and weight tiles each add 32 words; compiler allocation may differ.",
                  FadeIn(regs),FadeIn(names),FadeIn(counts))
        loop=code("for m = 0…3\n  for n16 = 0…3\n    for kSub = 0…1\n      MMA N8 low; MMA N8 high",25).move_to([3,-.45,0])
        self.beat("The unrolled issue order is M, then N16, then K subtile, with lower N8 before upper N8. K0 reaches each accumulator before K1, preserving the intended Half ordering.",FadeIn(loop))
        for j in range(4):
            self.play(regs[4+j].animate.set_fill(A,.55),run_time=.35)
        self.beat("One A fragment is reused across eight N8 column fragments. One B fragment is reused across four M16 token fragments, reducing repeated operand traffic.",
                  *[regs[i*4+2].animate.set_fill(B,.6) for i in range(4)])
        total=formula(r"4\cdot4\cdot2\cdot2=64\ \mathrm{MMA/warp/step};\quad64\cdot32=2048",30).move_to([0,-2.15,0])
        self.beat("There are 64 MMA instructions per warp per step, or 2048 across 32 steps. No partial accumulator tensor is written to global memory between steps.",Write(total))
        foot=label("__maxnreg__(168): a limit, not a measured register count or occupancy",23,MUTED).move_to([0,-2.8,0])
        self.beat("The resource tradeoff is deliberate: large register tiles and three shared slots buy reuse and overlap. Their actual performance requires compiled resource reports and measurements.",FadeIn(foot))
        self.finish()


class Ch12Activation(LessonScene):
    number = 12
    chapter = "The fused Half activation"
    source = "packed_math.cuh FfnActivation"

    def construct(self):
        axes=Axes(x_range=[-6,6,2],y_range=[-1,11,2],x_length=5.3,y_length=3.8,
                  axis_config={"color":MUTED,"include_tip":False}).move_to([-4.35,.55,0])
        def phi(x):
            b=max(-4,min(4,x))
            return x*(b*(-.055908203125*abs(b)+.447265625)+.89453125)
        curve=axes.plot(phi,x_range=[-6,6],color=C)
        glabel=label("shape of the recovered activation",22,C).next_to(axes,UP)
        eq=VGroup(formula(r"b=\operatorname{clamp}(x,-4,4)",32),
                  formula(r"p=\operatorname{HalfFMA}(-0.055908203125,|b|,0.447265625)",24),
                  formula(r"g=\operatorname{HalfFMA}(b,p,0.89453125)",28),
                  formula(r"y=\operatorname{HalfMul}(x,g)",31))
        eq.arrange(DOWN,buff=.37).move_to([2.5,.9,0])
        self.beat("After all 1024 channels have been reduced, the kernel applies its recovered clamped polynomial. The graph shows the real-valued shape; execution uses ordered Half operations.",
                  Create(axes),Create(curve),FadeIn(glabel),Write(eq[0]))
        self.beat("Clamp x to obtain b, take absolute b, then evaluate the first Half fused multiply-add. Its constants are exact values from the source.",Write(eq[1]))
        intrinsics=code("__hmin2 → __hmax2 → __habs2 → __hfma2 → __hfma2 → __hmul2",21).move_to([0,-2.82,0])
        self.beat("The clamp evaluates the upper minimum before the lower maximum. Preserve that order, the Half2 intrinsics and their NaN behavior when reconstructing the helper.",FadeIn(intrinsics))
        self.beat("A second Half fused multiply-add forms the gate. The final Half multiplication uses the original, unclamped x. Replacing this with standard SiLU changes the function.",Write(eq[2]),Write(eq[3]))
        pair=VGroup(box("x[83,34] | x[83,35]",[-3.8,-2.05,0],5.4,.75,TOKEN,25),
                    box("U[83,34] | U[83,35]",[3.8,-2.05,0],5.4,.75,C,25))
        path=arrow(pair[0].get_right(),pair[1].get_left(),C)
        self.beat("Both halves of every packed word pass through this sequence. Activation stays in registers: no preactivation write and no later activation read are needed.",FadeIn(pair),Create(path))
        self.finish()


class Ch13Store(LessonScene):
    number = 13
    chapter = "Four words become one packed store"

    def construct(self):
        words=VGroup(*[box(s,[-4,1.8-j*.85,0],6.5,.65,TOKEN if j%2==0 else MUTED,24) for j,s in enumerate([
            "word 0: U[83,34] | U[83,35]",
            "word 1: U[91,34] | U[91,35]",
            "word 2: U[83,42] | U[83,43]",
            "word 3: U[91,42] | U[91,43]",
        ])])
        packed=matrix(4,2,4.6,2.8,[4, .5,0],C)
        ptitle=label("uint4 = 16 bytes",28,C).next_to(packed,UP)
        self.beat("For output group five and N16 group two, lane thirteen assembles four Half2 words directly into a uint4. Token 91 is a packing companion, not an input dependency.",
                  FadeIn(words),FadeIn(packed),FadeIn(ptitle))
        dots=[]
        for j in range(4):
            dot,motion=self.flow(words[j].get_center(),VGroup(*packed[2*j:2*j+2]).get_center(),TOKEN if j%2==0 else MUTED)
            dots.append(motion)
        self.beat("The vector interleaves token rows 83 and 91, and channel pairs 34–35 and 42–43. It is already the layout expected by the next native tensor consumer.",*dots,run=2.5)
        eq=formula(r"5\cdot131072+0\cdot4096+0\cdot2048+13\cdot16+2\cdot512=656592",29,C).move_to([0,-1.65,0])
        inst=code("mov.b128 v, {w0,w1,w2,w3};\nst.global.L1::no_allocate.b128 [output], v;",23).move_to([0,-2.4,0])
        self.beat("Our selected result is the low Half at output base plus 656592 bytes. StoreNoAllocate writes the sixteen-byte vector with an L1 no-allocation cache hint.",Write(eq),FadeIn(inst))
        self.beat("There is no FP8 conversion, no FP32 postprocessing buffer and no split-K protocol in this entry. The store's cache hint is not a synchronization fence.",Indicate(packed[0],color=TOKEN))
        self.finish()


class Ch14Boundaries(LessonScene):
    number = 14
    chapter = "Finish the token and handle boundaries"

    def construct(self):
        blocks=VGroup(*[box(str(i),[-6.9+(i%16)*.92,1.9-(i//16)*.76,0],.82,.6,C,21) for i in range(32)])
        title=label("token 83: 32 channel CTAs × 128 outputs = 4096",28,TOKEN).move_to([0,2.8,0])
        self.beat("Our chosen CTA supplies only channels zero through 127. Thirty-two channel blocks independently finish token 83's complete 4096-channel expansion.",FadeIn(blocks),FadeIn(title))
        tail=VGroup(*[box(f"g={128+j}",[-5.9+j*1.65,-.15,0],1.45,.7,C if j<7 else RED,22) for j in range(8)])
        self.beat("At T equal to 2160, the final token tile has seven valid groups, or 112 rows. Group 135 is invalid: its input slab is zero-filled and its output store is skipped.",FadeIn(tail))
        small=box("T ≤ 16: broadcast input group 0 to virtual tile positions\nOutput stores are still bounded by ceil(T / 16)",[0,-1.4,0],13.5,1,A,24)
        self.beat("For the separate small-Half path, T at most sixteen broadcasts input group zero across virtual positions. Only group-bounded stores are allowed; callers provide padded group storage.",FadeIn(small))
        nextlayer=box("same CUDA stream: expansion completes → later contraction reads U",[0,-2.6,0],14,.7,C,24)
        self.beat("There is no CTA-to-CTA rendezvous inside this expansion. The later contraction relies on kernel launch ordering and the lifetime of the packed output allocation.",FadeIn(nextlayer))
        self.finish()


class Ch15Journey(LessonScene):
    number = 15
    chapter = "Reconstruct the complete journey"

    def construct(self):
        points=[[-5.5,1.65,0],[-1.8,1.65,0],[2,1.65,0],[5.55,1.65,0],
                [5.55,-.35,0],[1.8,-.35,0],[-2,-.35,0],[-5.5,-.35,0]]
        texts=["packed X\n+167632","SM80/89 copy\nproducer lane 13","shared A\n+5840","A registers\nconsumer lane 13",
               "warp MMA\nB lane 9 joins","Half accumulator\nD lane 13","Half activation\n64 words / lane","packed U\n+656592"]
        colors=[A,A,A,A,C,C,C,C]
        nodes=VGroup(*[box(t,p,3.1,1.15,c,23) for t,p,c in zip(texts,points,colors)])
        lines=VGroup(*[
            arrow(nodes[j].get_right(),nodes[j+1].get_left(),TOKEN) if j<3 else
            arrow(nodes[j].get_bottom(),nodes[j+1].get_top(),TOKEN) if j==3 else
            arrow(nodes[j].get_left(),nodes[j+1].get_right(),TOKEN)
            for j in range(7)
        ])
        self.beat("Now follow the single gold contribution once more: packed global X, an asynchronous stage copy, a native shared panel, then the consumer's A registers.",FadeIn(nodes),Create(lines))
        dot=Dot(points[0],color=TOKEN,radius=.12)
        self.add(dot)
        for j in range(1,4):
            self.play(dot.animate.move_to(points[j]),run_time=1.2,rate_func=smooth)
        self.beat("Weights arrive directly in B registers. Warp-wide MMA combines lanes and accumulates through all 32 steps; the fused Half activation then transforms the final result.",
                  dot.animate.move_to(points[4]),run=2)
        for j in (5,6,7):
            self.play(dot.animate.move_to(points[j]),run_time=1.2,rate_func=smooth)
        rule=label("scalar dependency → packed maps → tiles → synchronous version → pipeline → fused store",25).move_to([0,-1.8,0])
        self.beat("To rebuild the kernel, first verify the scalar dependencies and packing maps. Implement a synchronous tiled version before adding the three-slot pipeline and fused publication.",FadeIn(rule))
        tests=label("Check: unique output addresses · one-hot token · stage wrap · Half checkpoints · tails",24,C).move_to([0,-2.6,0])
        self.beat("Use address enumeration, one-hot inputs, stage-wrap comparisons, Half numerical checkpoints and tail tests. The linked lesson and source retain every formula for reconstruction.",FadeIn(tests))
        self.finish()


SCENES = [Ch01Model, Ch02Launch, Ch03Tiling, Ch04ALanes, Ch05GlobalAddress,
          Ch06AsyncCopy, Ch07SharedLayout, Ch08Pipeline, Ch09Weights, Ch10MMA,
          Ch11Registers, Ch12Activation, Ch13Store, Ch14Boundaries, Ch15Journey]
