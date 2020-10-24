class Test:
    @staticmethod
    def example():
        print(__name__)

    @classmethod
    def create(self):
        print(self)

    @property
    def count(self):
        return 1

    @count.setter
    def count(self, val):
        self._val = val

    @count.deleter
    def count(self):
        del self._val

Test.example()
Test.create()

t = Test()
print(t.count)
t.count = 5
print(t._val)
assert hasattr(t, "_val")
del t.count
assert not hasattr(t, "_val")
