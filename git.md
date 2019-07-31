# Git resources

My merge tool = `kdiff3`

# Some useful git commands

Show configuration:
```
$ git config -l
```

## Stashing files

Stash current changes (useful when one needs to go back to a different branch or commit)

```
$ git stash
```

Unstash:
```
$ git stash pop        # applies changes and removes the stash
$ git stash apply      # applies changes but keeps the stash
```

See available stashes
```
$ git stash list
```

With example output:
```
> stash{0}
> stash{1}
```

You can see the changes by
```
$ git stash show 0
$ git stash show 0 -p          # show the changes
```

## Listing files

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
