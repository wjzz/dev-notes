# @lru_cache
# @decorator

import time
from functools import lru_cache

def timeit(fun):
    def wrapper(*args, **kwargs):
        start = time.perf_counter()
        v = fun(*args, **kwargs)
        elapsed = time.perf_counter() - start

        all_args = [str(a) for a in args] + [f"{k}={v}" for k,v in kwargs.items()]
        args_str = ",".join(all_args)
        print(f"[{elapsed:.2f}s] {fun.__name__}({args_str}) -> {v}")

        return v
    wrapper.__name__ = fun.__name__
    return wrapper

@timeit
@lru_cache
def fib(n):
    if n < 2:
        return n
    return fib(n-2) + fib(n-1)

@timeit
def add_many(*args):
    return sum(args)

@timeit
def kwargs(*, n, k, p):
    return n + k + p

print(fib(20))
print(fib.__name__)

add_many(1,2,3,4)
kwargs(n=1, p=4, k=1)