import decimal
import math
from decimal import Decimal

math_e = math.e

# taylor series
#
# e := sum (k = 0 -> inf) [1 / k!]

# we reach the limit of the float type
# after 20 iterations, ie. n_20 = n_21 = n_22 = ...
def taylor_e():
    approx = 0
    term = 1.0
    k = 0
    while True:
        approx += term
        yield approx
        k += 1
        term /= k

dec_e = Decimal.exp(Decimal(1.0))

## the same, but using the decimal library
## here we get stuck after 26 iterations
def taylor_dec_e():
    approx = Decimal(0)
    term = Decimal(1)
    k = 0
    while True:
        approx += term
        yield approx
        diff = abs(approx - dec_e)
        digits = math.floor(-Decimal.log10(diff))
        print(f"diff after {k} iters = {digits}")
        print(approx)
        # print(dec_e)
        k += 1
        term /= k

def take(generator, n):
    for _ in zip(generator, range(n)):
        pass
