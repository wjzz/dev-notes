# Probably an error in pylint, other files are OK!
# pylint: disable=E1136

##-------------------------------------------------
## Trick from the net

from typing import NoReturn

def assert_never(x: None) -> NoReturn:
    raise AssertionError(f"Invalid value: {x!r}")

##-------------------------------------------------
## Main

from typing import Union, Literal

Flag = Union[ Literal["debug"], Literal["report"], int ]

def process_flag_ok(flag: Flag) -> int:
    if isinstance(flag, int):
        return flag
    if flag == "debug":
        return 1
    elif flag == "report":
        return 2
    else:
        assert_never(flag)

def process_flag_wrong(flag: Flag) -> int:
    if flag == "debug":
        return 0
    elif flag == "report":
        return 2
    else:
        assert_never(flag)
