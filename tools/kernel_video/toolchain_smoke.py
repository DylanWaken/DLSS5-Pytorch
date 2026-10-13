"""Check the real LaTeX -> DVI -> SVG -> Manim video pipeline."""

from manim import MathTex, Scene, Write


class ToolchainSmoke(Scene):
    def construct(self):
        formula = MathTex(
            r"U_{83,34}=\varphi\!\left(\sum_{k=0}^{1023}X_{83,k}W_{k,34}\right)"
        )
        self.play(Write(formula), run_time=1)
        self.wait(0.5)
