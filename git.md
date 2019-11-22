# Git notes

My merge tool used to be `kdiff3` but nowadays VSCode seems to have everything require for coding.

# Concepts

We should think about git's history as a DAG (Directed Acyclic Graph), where each commit becomes a node and it points to it's parent note (or parents node in case of merges). Branches etc then become pointers/references to various node. 
* Each commit's hash is a reference to the commit's node
* Branches names like `master`, `myBranch` etc point to the latest commit in the given path
* `HEAD` points the commit that we currently work on (ie. if we make a new commit, it's parent will be node pointed by `HEAD` - `HEAD` will be moved immediately)

We can reference each node by it's hash (or by it's unique prefix), but we also have relative references:
* `ref^` refers to the parent of `ref`, e.g. `HEAD^` means the "parent of `HEAD`", `HEAD^^` means the parent of the parent of `HEAD` etc.
* `ref~NUM` to refers to the `NUM`th ancestor of `ref`, e.g. `HEAD~2` is equivalent to `HEAD^^`

# Some useful git commands

Git's help is really nice. When in doubt try:

```
$ git --help
# or 
$ git log --help       # concrete function
```

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

## Tagging and describig

To add a tag:

```
$ git tag v1      # defaults to HEAD  
$ git tag v2 ref 
```

To find out what is the closest tagged ancestor node and how many commits away it is located:

```
$ git describe ref
```

## Bisecting

```
$ git bisect start BAD_REF GOOD_REF
$ git bisect run TEST_COMMAND
$ git bisect reset
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
$ git log --graph                               # show the tree structure of the commits
```

## Branching and checkouting

Some operations on branches:
```
$ git branch NAME          # create branch
$ git branch -d NAME       # delete branch (should be fully merged)
$ git branch -D NAME       # force delete branch
$ git branch -m OLD_NAME NEW_NAME # rename branch
```

Changing HEAD to a different commit:
```
$ git checkout REF              # e.g. REF = master, branchName, HEAD, HEAD^ etc
$ git checkout -b BRANCH_NAME   # shortcut - create branch and checkout
$ git checkout -                # rename to the previously checked-out branch
```

Make a branch point to a different node:
```
$ git branch -f master HEAD^^^       # make master point to HEAD^^^
```

## Merging

Merging connects two seperate branches. Workflow:

```
$ git checkout -b newBranch
$ ... make some changes
$ git commit
$ git checkout master
$ git merge newBrach
# now master contains all the changes done in newBranch
```

In case there are conflicts: 

```
$ git mergetool
```

## Rebasing

Rebasing is similar to merging in that it allows us to add some changes from a different branch, but rebasing replays and copies the commits on top of e.g. `master`. This results in a linear history. Example

```
$ git checkout -b newBranch
$ ... make some changes
$ git commit
$ git checkout master
$ git rebase newBranch   # this changes
# now master contains all the changes done in newBranch
```

Interactive rebasing (it allows you to pick and reorder commits):
```
$ git rebase -i ref          # rebase commits after <ref> until HEAD
```

## Removing unused branches

Remove a local branch:
```
git branch -d BRANCH_NAME
# something this is required:
git branch -D BRANCH_NAME
```

Remove a remote branch:
```
git push --delete origin BRANCH_NAME
```

Remove local references for remote branches that do not exist anymore:
```
git remote prune origin --dry-run  # remove the --dry-run to actually run this
```

## Undo and update local commits

Undo the last commit (changes are still preserved)
```
$ git reset HEAD^         # change preserved, but files are not staged
$ git reset --soft HEAD^  # updates the index, preserves the changes and keeps the files staged
$ git reset --hard HEAD^  # updates the index and removes the changes
```
You can replace `HEAD^` with the commit name to go further back in history.

## Undo and update shared commits

For commits that are pushed we should create a commit that reverses some given changes:

```
$ git revert ref       # create a commit that will undo everything done by commit <ref>
```

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
$ git diff HEAD^^           # compare with some previous node
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

## Cherry-picking

We can pick some comments to be copied (replayed) below `HEAD`:

```
$ git cherry-pick Commit1 Commit2 ...
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
