"""Draft-only conservative ownership for isolated native CUDA graph probes.

No CUDA import. Successful teardown requires completed capture, synchronization,
and explicit reset of every registered graph before closing raw resources.
Uncertain teardown retains the whole owner until the isolated process exits.
"""
from contextlib import contextmanager
import os
import sys
import traceback

QUARANTINED = []


class NativeGraphOwner:
    def __init__(self, synchronize, *, label="native probe"):
        self.synchronize = synchronize
        self.label = label
        self.graphs = []
        self.retained = []
        self.closers = []
        self.capture_uncertain = False
        self.context_uncertain = False
        self.quarantined = False
        self.closed = False

    def retain(self, value):
        self.retained.append(value)
        return value

    def own(self, value, close=None):
        self.retain(value)
        self.closers.append(close if close is not None else value.close)
        return value

    def graph(self, value):
        self.graphs.append(value)
        return value

    @contextmanager
    def capture(self, graph, context):
        if not any(value is graph for value in self.graphs):
            raise ValueError("graph must be registered before capture")
        # Leave the flag set even if context.__exit__/capture_end raises.
        self.capture_uncertain = True
        self.retain(context)
        context.__enter__()
        try:
            yield
        except BaseException as original:
            try:
                context.__exit__(type(original), original, original.__traceback__)
            except BaseException as cleanup:
                original.add_note("capture exit also failed: " + type(cleanup).__name__ + ": " + str(cleanup))
            # Probe failures must never be suppressed by a capture context.
            raise
        else:
            context.__exit__(None, None, None)
            self.capture_uncertain = False

    def stream(self, context):
        self.retain(context)
        return preserve_context(context,
            skip_exit=lambda: self.capture_uncertain or self.context_uncertain,
            failed=lambda: setattr(self, "context_uncertain", True))

    def __enter__(self):
        return self

    def __exit__(self, error_type, original, tb):
        failures = []
        if self.capture_uncertain or self.context_uncertain:
            failures.append(RuntimeError("capture or stream-context completion uncertain; CUDA teardown not attempted"))
        else:
            try:
                self.synchronize()
            except BaseException as error:
                failures.append(error)
            if not failures:
                # Clearing Python refs is insufficient: exception tracebacks may
                # retain torch.cuda.graph.self.cuda_graph. Reset native handles.
                for graph in reversed(self.graphs):
                    try:
                        graph.reset()
                    except BaseException as error:
                        failures.append(error)
            if not failures:
                for close in reversed(self.closers):
                    try:
                        close()
                    except BaseException as error:
                        failures.append(error)
                        break  # Never unload a dependency after an uncertain close.
        if failures:
            self.quarantined = True
            QUARANTINED.append(self)
            message = self.label + ": native resources retained until isolated process exit; " + "; ".join(
                type(error).__name__ + ": " + str(error) for error in failures)
            if original is not None:
                original.add_note(message)
                return False  # Preserve the primary failure and its traceback.
            failures[0].add_note(message)
            raise failures[0]
        self.closed = True
        self.graphs.clear()
        self.closers.clear()
        self.retained.clear()
        return False


@contextmanager
def preserve_context(context, *, skip_exit=lambda: False, failed=lambda: None):
    """Preserve a body error if context restoration also fails.

    A stream exit can invoke CUDA. Do not attempt it when the owner has already
    lost capture/context certainty; the isolated worker will exit instead.
    """
    try:
        value = context.__enter__()
    except BaseException:
        failed()
        raise
    try:
        yield value
    except BaseException as original:
        if not skip_exit():
            try:
                context.__exit__(type(original), original, original.__traceback__)
            except BaseException as cleanup:
                failed()
                original.add_note("context exit also failed: " + type(cleanup).__name__ + ": " + str(cleanup))
        raise
    else:
        if skip_exit():
            raise RuntimeError("context restoration skipped after uncertain capture; worker must exit")
        try:
            context.__exit__(None, None, None)
        except BaseException:
            failed()
            raise


def preserve_cleanup(action, original):
    """Run non-resource cleanup without replacing an already pending failure."""
    try:
        return action()
    except BaseException as error:
        if original is None:
            raise
        original.add_note("cleanup failed: " + type(error).__name__ + ": " + str(error))


def _exit_quarantined(*, diagnostic=False):
    # A broken stderr/pipe must never bypass process exit and trigger Python
    # finalization of quarantined CUDA objects.
    try:
        if diagnostic:
            try:
                traceback.print_exc()
            except BaseException:
                pass
        for stream in (sys.stdout, sys.stderr):
            try:
                stream.flush()
            except BaseException:
                pass
    finally:
        os._exit(1)


def cli(main):
    """Quarantined CUDA objects are never torn down by Python finalization."""
    try:
        result = main()
    except BaseException:
        if QUARANTINED:
            _exit_quarantined(diagnostic=True)
        raise
    if QUARANTINED:
        _exit_quarantined()  # A quarantined run can never report successful exit.
    return result
