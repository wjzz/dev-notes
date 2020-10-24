"""Use VSCode and debug this code.

Try:
  - F5 for debugging
  - create launch.json using the template
  - set breakpoints
  """

def open_non_existent_file():
    print("hello")
    x = 123
    with open("nonono", "r") as f:
        content = f.read()
    print(content)

if __name__ == "__main__":
    open_non_existent_file()
