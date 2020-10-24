from math import hypot

class Vector:
    def __init__(self, x=0, y=0):
        self._x = x
        self._y = y

    def __repr__(self):
        """
        Prints the representation of the vector

        >>> Vector(y=1, x=2)
        Vector(2, 1)
        """
        return f"Vector({self._x}, {self._y})"

    def __add__(self, other):
        """
        Adds two vectors

        >>> v1 = Vector(x=1, y=2)
        >>> v2 = Vector(2,5)
        >>> v1 + v2
        Vector(3, 7)
        """
        return Vector(x=self._x + other._x, y=self._y + other._y)

    def __abs__(self):
        """
        Returns the length of the vector

        >>> abs(Vector(3,4))
        5.0
        """
        return hypot(self._x, self._y)


class MyList:
    def __init__(self, seq):
        l = []
        for elem in seq:
            l.append(elem)
        self._l = l

# if __name__ == "__main__":
#     import doctest
#     doctest.testmod()
