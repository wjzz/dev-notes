from __future__ import annotations
from typing import NamedTuple

class Hello:
    def __len__(self) -> int:
        return 1

    def __add__(self: Hello, other: Hello) -> Hello:
        return self

    @property
    def count(self) -> int:
        return 123

h: Hello = Hello()
h + h
len(h)

# New syntax for declaring namedtuples

class Person(NamedTuple):
    name: str
    age: int

p = Person(name="Wojtek", age=32)
strange = p.name * p.age
(name, age) = p
print(p)
