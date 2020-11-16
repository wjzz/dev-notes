# activate the virtual env by
# $ source venv/bin/activate
# and then
# run the code by:
# python -m pytest example.py

from typing import TypeVar


T = TypeVar('a')

def sum_list(l: list[T], start: T) -> T:
	result = start
	for a in l:
		result += a
	return result


## Testing code from here

from hypothesis import given, example
import hypothesis.strategies as st

@given(st.lists(st.integers()))
@example([])
def test_sum_list_eqv_stdlib_sum(xs):
	assert sum_list(xs, 0) == sum(xs)
