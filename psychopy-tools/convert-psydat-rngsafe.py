#!/usr/bin/env python3.10
#
# We need a specific psychopy, depending on which version of psychopy
# was used to run the experiment in the first place:
#    ERT1: 2024.2.4, req python 3.10
#
# Many of the psychopy function names/calls are very version dependent as well.
#
# psychopy does not work on Mac Silicon.
#
# SafeUnpickler class handles some situations with python version mismatches
# where stimulus data can be loaded but certain unneeded methods/datatypes cannot.

import argparse
import pickle
import psychopy
import psychopy.data

class DummyRNG:
    """Pickle-friendly stand-in for numpy.random.Generator / BitGenerator state."""
    def __init__(self, *a, **k):
        pass

    def __setstate__(self, state):
        # Accept anything without error
        self._state = state

    def __getstate__(self):
        return getattr(self, "_state", {})

class SafeUnpickler(pickle.Unpickler):
    def find_class(self, module, name):
        # Replace numpy's RNG objects with our dummy to avoid version-specific internals
        if (module, name) in [
            ("numpy.random._generator", "Generator"),
            ("numpy.random._pickle", "__generator_ctor"),
            ("numpy.random._pickle", "__bit_generator_ctor"),
            ("numpy.random._pcg64", "PCG64"),
            ("numpy.random._mt19937", "MT19937"),
            ("numpy.random._philox", "Philox"),
            ("numpy.random._sfc64", "SFC64"),
        ]:
            # For ctor functions, return something callable that produces DummyRNG
            if module == "numpy.random._pickle" and name in ("__generator_ctor", "__bit_generator_ctor"):
                return lambda *a, **k: DummyRNG()
            # For classes, return DummyRNG type
            return DummyRNG

        return super().find_class(module, name)

def safe_fromfile(path):
    with open(path, "rb") as f:
        return SafeUnpickler(f).load()

parser = argparse.ArgumentParser()
parser.add_argument('--psydat_file', required=True)
parser.add_argument('--out_file', required=True)
args = parser.parse_args()

data = safe_fromfile(args.psydat_file)

# Method here is to_csv in psychopy 2024.1.4 but saveAsWideText in 2024.2.4
data.saveAsWideText(args.out_file)
