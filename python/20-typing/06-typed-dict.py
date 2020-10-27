from typing import TypedDict

class Movie(TypedDict):
    title: str
    year: int

titanic: Movie = {
    "title": "Titanic",
    "year": 1999
}
