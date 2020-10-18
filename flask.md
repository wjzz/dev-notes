# Flask

- Uses Jinja2 as a template language
- Has a nice tutorial with a thourough section on testing and test coverage

## Cookies vs Sessions

We can handle cookies explicitly using `make_response` and `request`, but it can be easier to use `Flask`'s built in `session`

First initialize a secret key:
```python
from Flask import session
app.secret_key = "OnlyIKnowThisSecretKey"
```

and then use `sessions` as a dictionary:

```python
if "user_id" in session:
  print(session["user_id"])
...
session["user_id"] = str(uuid())
...
def logout():
  session.pop("user_id")
```

## Passing data between functions among the same request

We can use the `g` object to pass data between e.g. then controller and the views without increasing the number of parameters:

```python
def login():
  g.user = None
  if valid(username, password):
    user = authenticate(username. password)
    g.user = user
...
  {% if g.user %}
    <p> Hello user! </p>
  {% else %}
     <p> Please log in ! </p>
  {% endif %}
```

`g` is local to the current thread, so it's safe to use.
