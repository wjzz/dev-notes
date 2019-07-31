# Git notes

My merge tool used to be `kdiff3` but nowadays VSCode seems to have everything require for coding.

# Concepts

We should think about git's history as a DAG (Directed Acyclic Graph), where each commit becomes a node and it points to it's parent note (or parents node in case of merges). Branches etc then become pointers/references to various node. 
* Each commit's hash is a reference to the commit's node
* Branches names like `master`, `myBranch` etc point to the latest commit in the given path
* HEAD points the commit that we currently work on (ie. if we make a new commit, it's parent will be node pointed by HEAD - HEAD will be moved immediately)

We can reference each node by it's hash (or by it's unique prefix), but we also have relative references:
* `ref^` refers to the parent of `ref`, e.g. `HEAD^` means the "parent of `HEAD`", `HEAD^^` means the parent of the parent of `HEAD` etc.
* `ref~NUM` to refers to the `NUM`th ancestor of `ref`, e.g. `HEAD~2` is equivalent to `HEAD^^`

`HEAD`

# Some useful git commands

Show configuration:
```
$ git config -l
```

Show list of everything you did in git:
```
$ git reflog
...
$ git reset HEAD@{index}      # TIME MACHINE!
```

## Staging parts of a change

```
$ git add -p             # enters an interactive shell, type ? to see explanations
```

## Removing files not under VC

```
$ git clean -n      # dry run
```

## Logging

Show all commits in a short way:
```
$ git log --abbrev-commit --pretty=oneline
```

## Undo and update commits

Undo the last commit (changes are still preserved)
```
$ git reset HEAD^         # change preserved, but files are not staged
$ git reset --soft HEAD^  # updates the index, preserves the changes and keeps the files staged
$ git reset --hard HEAD^  # updates the index and removes the changes
```
You can replace `HEAD^` with the commit name to go further back in history.

## Stashing files

Stash current changes (useful when one needs to go back to a different branch or commit)

```
$ git stash
$ git stash save "my new readme"   # save with a name
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

Clean-up:
```
$ git stash drop 1      # drop stash stash@1
$ git stash clear       # remove all stashes
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

[Learn git branching (very nice!)](https://learngitbranching.js.org/)

[Git cheatsheet](https://github.github.com/training-kit/downloads/github-git-cheat-sheet/)

[Pro Git](https://git-scm.com/book/en/v2)

[Git from the bottom up](https://jwiegley.github.io/git-from-the-bottom-up/)

[Git best practices](http://sethrobertson.github.io/GitBestPractices/)

## Fixing stuff

[Oh, shit, git](https://ohshitgit.com/)

[On undoing, fixing...](https://sethrobertson.github.io/GitFixUm/fixup.html)
