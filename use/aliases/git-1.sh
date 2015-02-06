alias ga="git add"
alias gci="git commit"
alias gca="git commit -a"
alias gco="git checkout"

# w/o --author=om
alias glo="git --no-pager log --pretty=oneline --graph -22 --no-merges --abbrev-commit"
alias gsb="git show-branch"
alias ghi=gh-issues

# git checkout new branch
# see also: "greatest conceivable being" - philosophy / ontology
function gcb {
  branch=$1
  shift 1
  git checkout -b ${branch} $@
}

# checkout a new branch from the current
# but first push one with the same name to origin
# then have the new branch track it
function gcbot {
  current=`git-branch-name`
  branch=$1
  shift 1
  git push origin ${current}:${branch} &&
  git checkout -b ${branch} -t origin/${branch} $@
}

function git-branch-name {
  git symbolic-ref HEAD | sed 's/.*\///'
}
