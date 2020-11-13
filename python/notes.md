# Python notes

[Official CPython3 documentation](https://docs.python.org/3/)

[Python Standard Library - a lot of modules!](https://docs.python.org/3/library/index.html)

## Running scripts

[Official docs](https://docs.python.org/3/using/cmdline.html)

## Benchmarking

```
$ python3 -m timeit "1+1"
50000000 loops, best of 5: 6.07 nsec per loop
```

### Prevent python from creating `__pycache__` directiories

There are two ways:

a) Pass a `-B` flag to the interpreter:

```bash
$ python3 -B main.py
```

b) Set the `PYTHONDONTWRITEBYTECODE` environment variable to any non-empty string:

```bash
$ PYTHONDONTWRITEBYTECODE=1 python3 main.py
```


### Path

```python
>>> import sys
>>> sys.path
['', '/home/wjzz/.pyenv/versions/3.9.0/lib/python39.zip', '/home/wjzz/.pyenv/versions/3.9.0/lib/python3.9', '/home/wjzz/.pyenv/versions/3.9.0/lib/python3.9/lib-dynload', '/home/wjzz/.pyenv/versions/3.9.0/lib/python3.9/site-packages']
```

## Language features

### New in Python 3.9

- Dictionary merging:
```
>>> dict(a=1) | dict(b=2)
{'a': 1, 'b': 2}
```

- `list`, `dict` etc work as generic types:
```
>>> def first(l: list[str]) -> str:
...   return l[0]
...
>>>
```

- `removeprefix` and `removesuffix`:
```
>>> "123".removeprefix("12")
'3'
```

### CLI

Useful trick to center a nice header:

```
>>> import shutil
>>> print("hello".center((shutil.get_terminal_size().columns), "-"))
------------------------------hello-------------------------------
```

### Decorators

#### Memoize a function using `@lru_cache`

```python
from functools import lru_cache

@lru_cache
def identity(x):
    return x
```
#### Create a static method using `@staticmethod`

```python
class Test:
    @staticmethod
    def example():
        print(__name__)

Test.example()
```

#### Create a class method using `@classmethod`

```python
class Test:
    @classmethod
    def create(self):
        print(self)

Test.create()
```

#### Create a getter, setter and deleter for a property

We use `@property`, `@X.setter` and `@X.deleter`:

```python
class Test:
    @property
    def count(self):
        return 1

    @count.setter
    def count(self, val):
        self._val = val

    @count.deleter
    def count(self):
        del self._val

t = Test()
print(t.count)
t.count = 5
print(t._val)
assert hasattr(t, "_val")
del t.count
assert not hasattr(t, "_val")
```

## Testing

### Doctest

[Official docs](https://docs.python.org/3/library/doctest.html)

Add this to a library file:
```python
# example.py
if __name__ == "__main__":
    import doctest
    doctest.testmod()
```
and run

```bash
$ python3 example.py
```

or (for a very detailed report):

```bash
$ python3 example.py -v
```

Alternatively, you can run all doctests in a file with:

```bash
$ python3 -m doctest example.py
```

## Typings

[Official docs](https://docs.python.org/3/library/typing.html)

[Pyright](https://github.com/microsoft/pyright) - available both as a cmd line tool and as a VSCode extension

[Mypy](https://pypi.org/project/mypy/)

### Type-checking

```
mypy example.py
pyright example.py
pyright 01-basic-types.py --watch
```

In classes we must still use:
```py
from __future__ import annotations
```
so we can use a type before it's defined:
```py
class Hello:
    def __add__(self: Hello, other: Hello) -> Hello:
        return self
```

## Pip

Upgrade package

```bash
$ pip3 install mypy --upgrade
```

## Bytecode

Disasseble a function:
```
>>> def foo(x,y):
...   return 2*x+y
...
>>> from dis import dis
>>> dis(foo)
  2           0 LOAD_CONST               1 (2)
              2 LOAD_FAST                0 (x)
              4 BINARY_MULTIPLY
              6 LOAD_FAST                1 (y)
              8 BINARY_ADD
             10 RETURN_VALUE
```
