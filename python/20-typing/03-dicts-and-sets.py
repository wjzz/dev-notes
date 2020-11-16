from collections import defaultdict
from typing import Union
from typing import Literal

def contains_one(fs: frozenset[int]) -> bool:
    return 1 in fs

def analyze_word_frequency(text: str) -> defaultdict[str, int]:
    words: defaultdict[str, int] = defaultdict(int)
    for line in text.splitlines():
        for word in line.split():
            words[word] += 1
    return words

Stage = Union[
    Literal["test"],
    Literal["staging"],
    Literal["production"],
]

stage_info: dict[Stage, str] = {
    "test": "testing",
    "staging": "dunno",
}
