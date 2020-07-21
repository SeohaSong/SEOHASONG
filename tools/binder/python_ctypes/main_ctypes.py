#!/usr/bin/env python

import os
import ctypes


if __name__ == "__main__":

    file = os.path.join(os.path.abspath("."), "libmult.so")
    c_lib = ctypes.CDLL(file)

    print(dir(c_lib))

    x = 6
    y = ctypes.c_float(2.3)
    c_lib.run.restype = ctypes.c_float
    print("python:\t", c_lib.run(x, y))
