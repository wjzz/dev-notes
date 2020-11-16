# $ pytest --doctest-modules

def factorial(n):
	"""Calculates the factorial of n.

	>>> factorial(1)
	1
	>>> factorial(2)
	2
	>>> factorial(5)
	120
	"""

	result = 1
	for x in range(2, n+1):
		result *= x
	return result

