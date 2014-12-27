from math import *

import sys
if sys.version_info >= (3, 0):
    import builtins
else:
    builtins = __builtins__

# random
import random
from random import randrange, randint, choice, shuffle, random as rand, uniform

# crypto
import hashlib

def md5(x):
    return hashlib.md5(x.encode("utf-8")).hexdigest()
def sha1(x):
    return hashlib.sha1(x.encode("utf-8")).hexdigest()
def sha256(x):
    return hashlib.sha256(x.encode("utf-8")).hexdigest()
def sha512(x):
    return hashlib.sha512(x.encode("utf-8")).hexdigest()

# conversion
import binascii
def hex(x):
    if isinstance(x, bytes):
        return "0x" + binascii.hexlify(x).decode("utf-8")
    elif isinstance(x, str):
        return "0x" + binascii.hexlify(x.encode("utf-8")).decode("utf-8")
    else:
        return builtins.hex(x)
def bin(x):
    return bin(int(hex(x), 16))
def unhex(x):
    if isinstance(x, str):
        x = x.encode("utf-8")
        if x.startswith(b"0x"):
            x = x[2:]
            return binascii.unhexlify(x)

# average
def avg(*args):
    try:
        return sum(args[0]) / len(args[0])
    except TypeError:
        return sum(args) / len(args)

# strings
def wcount(s):
    return len(s.split())

# date and time
from datetime import datetime, date, time, timedelta
