import pytest
# rails like generation

class Meta(type):
    def __new__(cls, name, bases, dct):

        if "__annotations__" in dct and "__init__" not in dct:
            print("Generating a constructor for", name)
            keys = dct["__annotations__"].keys()
            def __init__(self, *args):
                if len(args) != len(keys):
                    raise TypeError(f"__init__ requires {len(keys)} arguments, but {len(args)} were given")
                for key, value in zip(keys, args):
                    setattr(self, key, value)
            dct["__init__"] = __init__

        return super().__new__(cls, name, bases, dct)

class Model(metaclass=Meta):
    pass

class Person(Model):
    name: str
    age: int

#----------------------------------------------
# Unit tests
#----------------------------------------------

@pytest.fixture
def person():
    return Person("wojtek", 32)

def test_init(person):
    assert person.name == "wojtek"
    assert person.age == 32
