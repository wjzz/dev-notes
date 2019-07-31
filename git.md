# Git resources

My merge tool = `kdiff3`

# Some useful git commands

Show configuration:
```
$ git config -l
```
## List files

List all tracked files:
~~~
$ git ls-files
~~~

List all ignored files

~~~
$ git ls-files --others --ignored --exclude-standard
~~~

## Diffing

```
$ git diff                  # show in terminal
$ git difftool              # show in configured difftool
$ git diff --name-only      # print only file names 
```

For staged changes:

```
$ git diff --cached                 # show in terminal
$ git difftool --cashed             # show in configured difftool
```

## Unstaging

```
git reset HEAD .gitignore   # unstage .gitignore
```
# Resources:

[Git cheatsheet](https://github.github.com/training-kit/downloads/github-git-cheat-sheet/)

[Git handbook](https://github.github.com/training-kit/downloads/github-git-cheat-sheet/)
