from typing import Optional


def no_hints(a, b):
    c = a.rstrip() + b.rstrip()
    return c

def hints(a: str, b: str) -> Optional[str]:
    if a == "":
        return None

    c = a.rstrip() + b.strip() # intellisense works!
    return c
