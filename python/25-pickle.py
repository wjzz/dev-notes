import pickle
from dataclasses import dataclass

#---------------------------------

@dataclass
class Person:
    name: str
    age: int

#---------------------------------

def save(obj):
    with open("example.pickle", "wb") as f:
        pickle.dump(obj, file=f)

def load():
    """
    >>> save((123, "hello"))
    >>> load()
    (123, 'hello')

    >>> p = Person(name="Wojtek", age=32)
    >>> p
    Person(name='Wojtek', age=32)
    >>> save(p)
    >>> load()
    Person(name='Wojtek', age=32)
    """

    with open("example.pickle", "rb") as f:
        return pickle.load(file=f)
