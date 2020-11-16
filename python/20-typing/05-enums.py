from enum import Enum, auto
from typing import Callable

##-------------------------------------------------
## Trick from the net

from typing import NoReturn

def assert_never(x: None) -> NoReturn:
    raise AssertionError(f"Invalid value: {x!r}")

class Operator(Enum):
    Add = auto()
    Sub = auto()
    Mul = auto()
    Div = auto()

operators: list[Operator] = [ Operator.Add, Operator.Sub, Operator.Mul, Operator.Div ]

print(operators)

def denote_op(op: Operator) -> Callable[[int, int], int]:
    if op is Operator.Add:
        return lambda x, y: x + y
    elif op is Operator.Sub:
        return lambda x, y: x - y
    elif op is Operator.Mul:
        return lambda x, y: x * y
    elif op is Operator.Div:
        return lambda x, y: x // y
    else:
        return assert_never(op)
