# information about built-in functions
__builtins__.__dict__

# dict interfaces:
import collections.abc

"""
>>> isinstance({}, collections.abc.Mapping)
True
"""

# KEYS must be hashable!

# E.g. lists are not hashable, because only unmutable stuff can be hashable

# useful shortcut(?)
{'a': 1, 'b': 2} == dict(a=1, b=1)

# dict comprehensions

"""
>>> { "n_"+ str(n):n for n in range(10) }
{'n_0': 0, 'n_1': 1, 'n_2': 2, 'n_3': 3, 'n_4': 4, 'n_5': 5, 'n_6': 6, 'n_7': 7, 'n_8': 8, 'n_9': 9}
"""

# dict methods (p.71)

"""
>>> d = {}
>>> d.setdefault(4, 0)
0
"""

# ChainMap is recommended for interpreters etc

# Frozenset

"""
>>> s1 = frozenset({1,2,3})
>>> s2 = frozenset({1,2,3,4})
>>> s1 <= s2     # subset checking
True
>>> s1 - s2
frozenset()
>>> s2 - s1
frozenset({4})
>>> s1 ^ s2
frozenset({4})
>>> s1 | s2
frozenset({1, 2, 3, 4})
>>> s1 + s2
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: unsupported operand type(s) for +: 'frozenset' and 'frozenset'
>>> s1 & s2
frozenset({1, 2, 3})
>>> hash(s1)
-272375401224217160
"""
