from sys import (
    argv,
    path,
)

from os import (
    environ
)

from shutil import (
    which,
    disk_usage,
    make_archive,
    unpack_archive,
)

import os.path

from collections import (
    defaultdict,
    namedtuple,
    deque,
    Counter,
    OrderedDict,
)
from typing import NamedTuple

from math import (
    cos,
    sin,
    sqrt,
    tan,
    pi,
    e,
    log,
)

import timeit
from time import (
    time,
    perf_counter,
)

from itertools import (
    permutations,
)

from functools import (
    lru_cache,
    # cache,     # new in python3.8
)

from csv import (
    reader,
)

from urllib import (
    request
)

from doctest import (
    testfile
)

import unittest
import unittest.mock

from threading import (
    Thread,
    local,
    current_thread,
    get_ident,
)

from multiprocessing import (
    Process,
    Queue,
    current_process,
)

from concurrent.futures import (
    ThreadPoolExecutor,
    ProcessPoolExecutor,
)

from http import (
    client
)

##--------------------------------------------

d = defaultdict(int)
assert d["hello"] == 0

Person = namedtuple("Person", "name age")
user = Person("Wojtek", 32)

Person2 = namedtuple("Person2", ["name", "age"])
user2 = Person2("Wojtek", 32)

class Person3(NamedTuple):
    name: str
    age: int
