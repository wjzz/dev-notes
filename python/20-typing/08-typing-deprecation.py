from collections.abc import Mapping
from collections.abc import MutableSequence
from collections.abc import Sequence

def contains_wojtek(seq: Sequence[str]) -> bool:
    return "wojtek" in seq

def value_of_wojtek_or_default(map: Mapping[str, str]) -> str:
    return map.get("wojtek", "jedynak")

def insert_wojtek(mut_seq: MutableSequence[str]) -> MutableSequence[str]:
    mut_seq.append("Wojtek")
    return mut_seq


