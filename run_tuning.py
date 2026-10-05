"""Offline tuning support: planning and policy export, not GPU measurement.

Enumeration alone creates neither measured anchors nor shape admissions.
Actual benchmarking is a separate, explicitly qualified execution workflow.
"""
from tuning.resolution_cli import main

if __name__=='__main__':
    main()
