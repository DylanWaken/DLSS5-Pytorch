"""Light shared metadata for the DLSS-NR Python runtime.

Importing this package must stay free of Torch, CUDA and native-extension
imports; consumers import the specific pure module they need (for example
:mod:`dlssnr.common.weight_schema`).
"""
