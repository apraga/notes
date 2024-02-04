# Git

## Outline

* Do you want to use Git ? Why ?
* Git in 5 minutes (demo)
* Advanceds git
* Install Git : CERFACS or at home


### Why Git ?
Centralized Version System depends on the server (not always reliable).
In Distributed VCS, a complete copy of the server is done locally.
Context : created by Linus Torvald for Linux kernel dev, after BitKeeper access
was revoked.
Qualities : fast, efficient, allows non-linear dev through branching

### Features
*  Git stores snapshots instead of file differences. If
there was no changes, it stores a link to the previous version.
*  Most of the operations are local (no need for network + fast).
*  Data integrity : everything is checksum (SHA-1 hash). The hash is used for
storing (ex: git log)
*  Adds data : difficult to lose something
*  3 states :  
  *  modified : changed, but not in database
  *  staged : changed, and ready to go in the next commit
  *  commited : in database

The folder are (resp.) :
 
  *  working directory (checkout of the project)
  *  staging area : a file with the info about the next commit
  *  git directory


## Basic Git
### Configuration :
Here we configure the name, email, editor and the diff tool :

    git config --global user.name ``John Doe''
    git config --global user.email johndoe@example.com
    git config --global core.editor emacs
    git config --global merge.tool vimdiff

This can be checked with `git config --list`
or in `.git/config`.

### Basics

* `git init`: init the git repo
* `git add README`: add the file 
* `git commit -m 'initial project version'`: commit with a message
* `git clone git://github.com/schacon/grit.git myfolder`: clone the git repo into a local folder


### Recording changes

* `git status`
* `git add `: untracked to unmodified/modified
* `git stage `: modified to staged
* `git commit `: staged to unmodified

    \# a comment - this is ignored
    *.a       
    !lib.a    
    /TODO     
    build/    
    doc/*.txt }
* git diff : view exact changes


### History

* `git log`: commit message, author, date
* `git log -p`: show the diff 
* `git log --stat`: number of modifications
* `git log --graph`: show branches

Graphical : `gitk`

### Undoing

* `git commit --amend`: add some file to a commit (staging area). Merge in
* single commit
* `git reset HEAD myfile`: unstage
* `git checkout`: undo changes

**Warning** : hard to lose something, but it must me commited.


### Remotes

* `git remote -v`: show remote 
* Warning : can only pull from SSH url
* `git remote add [shortname] [url]` : add a remote 
* `git fetch [shortname]` : fetch data without merging. Put it in local
* branches. (TODO: check that) 
* `git pull [shortname]` = git fetch \&\& git merge
* `git push remote branch` : push to the remote. Example : git push origin
* master
* `git remote show`: show some informations about the remote
* `git remote rm }\cmd{ git remote rename `

_Tip_: if you don't have the permissions to update branch, it's easiest to push
your local branch directly to the remote, instead of merging to the master.

### Tags

* `git tag -a v7.2 -m "This is the version 7.2"`: tag with a number and
* message 
* `git tag`: show tags
* `git show v7.2`: show info at version
* `git tag -s v7.2 -m "This is the version 7.2"`: tag with a GPG signature
* `git tag v7.2`: create lightweight tag (only checksum)
* `git tag -v v7.2`: verify tag
* `git tag -a v7.2 7epb61`: tag at the commit whose checksum is 7epb61 
* Warning : you have to push you tags ! `git push origin v7.2`or 
* `git push origin --tags`for all

_Tip_: there is a bash script for completion in the source code of git.
`source ~/.git-completion.bash`

Aliases can be created : `git config --global alias.co checkout`

## Advanced
### Branches
Why is it important ? Lightweight and fast.

#### Basics
Commit object = pointer to the snapshot, author, messages and pointer to the
previous commits (2 if merge).
A snapshot contains a blob (=version) for each file.

A branch is just a pointer to a commit. HEAD is a pointer to the current branch.
\begin{figure}[h]
  \begin{tikzpicture}[transform shape,font=\scriptsize,scale=1.9]
  \node (C1)[commit] {C1};
  \node (C2)[commit,right of=C1] {C2};
  \node (C3)[commit,below of=C2] {C3};
  \node (master)[branch,above of=C2] {master};
  \node (donkey)[branch,below of=C3] {donkey};
  \node (head)[branch,above of=master] {HEAD};
  \draw[arrow] (C2) to (C1);
  \draw[arrow] (C3) to (C1);
  \draw[arrow] (master) to (C2);
  \draw[arrow] (donkey) to (C3);
  \draw[arrow] (head) to (master);
\end{tikzpicture}
\end{figure}

Easy, right ?

* `git branch monkey`: creates a branch 
* `git checkout monkey`: switch to the branch 
* `git checkout -b monkey`: both of the above

#### Merging
`git checkout master}\cmd{ git checkout monkey`: merge to master
`git branch -d monkey`: delete the branch. Don't worry, removes only a
pointer !

#### Conflicts

    Auto-merging index.html
    CONFLICT (content): Merge conflict in index.html
    Automatic merge failed; fix conflicts and then commit the result.

Don't panic ! Simply remove the lines. Git cannot do that for you.
`git mergetool`for a visual merging tool.

Check everything has been merged : `git status`, and `git commit`
(default message).

_Tip_: with git merge, it will automatically commit. Use the --no-commit
option if you don't want to}

#### Management

* `git branch`: list branch, with * on the current 
* `git branch -v`: list branch with last commit 
* `git branch --merged`: list branch with last commit 

### Workflow
Long-term branches : differents branch for stability. Ex (Debian) : _stable_,
_testing_, _unstable_
Short-term branches : for testing ideas. This is only local.

### Remote branches
Warning : source of confusion.

#### What happens when I clone ?
Git create an origin remote and pull the master. So
we have origin/master copied locally. However, we will work on the master branch
locally (the other will not be modified until the next push).
Explains the difference between fetch and pull : it creates a divergence.
What happens if someone commit between my git pull and my git push ?
You should always pull (git should say so) before pushing.
AND you should always check the log before that.

#### Tracking branch
Cloning creates a master branch which will track origin/master so git push will
work without arguments.

* `git checkout --track origin/monkey`: will track monkey
* `git checkout -b donkey origin/monkey`: idem but with another name.
* `git push origin :monkey`: delete remote branch (! difficult to memorise)

### Rebase
git merge performs a merge between the 2 latest snapshots. 

* `git checkout donkey` and `git rebase master` will take all the changes
from donkey and apply it to master (starts from common ancestor and apply
successively)
* `git rebase master donkey`has the same result

What for ? Cleaner history (looks like we have done everything sequentially).
Result is the same.

**Quizz**: what does the following command does ?
`git rebase --onto master waiting testing`: will apply changes of testing
on master, but only from the ancestor of waiting and testing

NEVER use rebase on commits already pushed ? 
QUIZZ : why ?

## Working with others
### Commit guidelines

  * Check for whitespaces errors : `git diff --check`
  * Each commit should be about a specific change. Don't forget you can
    split your work into several commits ! More readable and easier for
    reverting.
  * Format your commit message. Ideally, a short description on the first
    line, followed by a body.

    commit a3347b988a338e95b7f3b11eda776ac0d7b84dd0
    Author: Linus Torvalds <torvalds@linux-foundation.org>
    Date:   Fri May 25 09:02:03 2012 -0700
    
    fmt-merge-message: add empty line between tag and signature verification
    
    When adding the information from a tag, put an empty line between the message of the tag and the commented -out signature verification information.
    
    At least for the kernel workflow, I often end up re-formatting the message that people send me in the tag data. In that situation, putting the tag message and the tag signature verification back-to-back then means that normal editor "reflow parapgraph" command will get confused and think that the signature is a continuation of the last message paragraph.
    
    So I always end up having to first add an empty line, and then go back and reflow the last paragraph. Let's just do it in git directly.
    
    The extra vertical space also makes the verification visually stand out more from the user-supplied message, so it looks a bit more readable to me too, but that may be just an odd personal preference.
    
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

### Patches
A patch is the differences you have added to the project.
`git format-patch -M origin/master`will create patches ready to be emailed.
One file will be create per commit. -M checks for rename
Better than diff as it contains commit messages.
Warning : copy/paste can lead to formatting issues. But you can configure Git.

`git apply mypatch.patch`: apply a patch generated by `git diff`(everything or nothing strategy).
`git am mypatch.patch` : apply a patch generated by `git format-patch`

### Communicating
`git archive master | gzip > myarchive.tar.gz`: create an archive
`git shortlog master`: create a summary of the commits

## Expert
### Older commits
A commit is referenced by its SHA number. Example : `commit
08920095740df4838b2b174624277c6372b40f3c`.  We can refer it by an abbreviation
(8-10 numbers should be enough).  We can refer to a parent with `HEAD~` (`HEAD~`
gives the other parent in case of a merge). Also we can access to the
grandparent `HEAD~~`.  For the first parent, `HEAD~`. Grandparent is
`HEAD~2`.

Everything on donkey that is not in master : `git log master..donkey`.
What I am about to commit : `git log origin/master..HEAD`.

Negation (useful for multiple branches) : `git log \^donkey`: everything
not on donkey. (or `git log --not donkey`).

`git log master...donkey`: everything on each that is not common to the
two.

Tip : you can see the older positions of head with `git reflog`. Warning :
only since the cloning or for the last few months.

### Interactive staging
D\'emo. Useful for 
\begin{git}
*** Commands ***
  1: status     2: update      3: revert     4: add untracked
    5: patch      6: diff        7: quit       8: help
\end{git}
patch allow for a partial staging.

### Stashing
Allows to temporary save your for switching to another tasks (without
committing). Ex : 
`git stash`: save
`git checkout -b testing`: change to a  new branch
`git checkout master`: return back to master
`git stash apply`: load saved data
We can also create a branch from a stashing : `git stash branch donkey`

_Tip_: if several stash, `git stash list`and \cmd{git stash apply
stash@\{2\}}.
Unapply stash : `git stash show -p stash@{1} | git apply -R`
