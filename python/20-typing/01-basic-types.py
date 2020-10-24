from typing import Generator, Union

def greet(name: str) -> str:
    return f"Hello, {name}!"

# bad argument type
greet(53)

# bad result type
greet("hello") + 123

d: dict[str, int] = {}
d["hello"] = 123
d["world"] = "haha"

# new in python3.9?
# before one had to write
# from typing import Tuple
# ....Tuple[int, str, float]...
p : tuple[int, str, float] = (123, "hello,", 1)

l: list[int] = [1,2,3]
l[5] + "123"

def evens() -> Generator[int, None, None]:
    i = 0
    while True:
        yield i
        i += 2

l2: list[int] = []
n = 5
for ev in evens():
    l2.append(ev)
    n -= 1
    if n <= 0:
        break

s: set[Union[int,str]] = { 1, 3, 5, 3, "asda"}

##---------------------------------------------

from collections import defaultdict
dd: defaultdict[str, int] = defaultdict(int)
dd["123"] = 32
