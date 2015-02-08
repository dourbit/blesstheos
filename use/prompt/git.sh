# TODO: make path start with the first found repository
# erase path from ~ to the .git containing directory
# otherwise make ~/ $PURPLE

# these colors are different from use/colors.sh, why?
WHITE="\[\033[1;37m\]"
BLUE="\[\033[0;34m\]"
GREEN="\[\033[0;32m\]"
RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
PURPLE="\[\033[0;35m\]"


function parse_git_branch {
  ref=$(git-symbolic-ref HEAD 2> /dev/null) || return
  echo "["${ref#refs/heads/}"]"
}

my_git_status() {
  # NOTE: exists because I don't know how to make the status $RED with dirty new_git_prompt()
  # ... but also to allow optional status (possibly on a per-repository basis)
  branch_prompt=$(__git_ps1)
  if [ -n "$branch_prompt" ]; then
    if [ `git config --bool --get bash.showdirtystate` ]; then
      if current_git_status=$(git status | grep 'added to commit' 2> /dev/null); then
        echo "⚠ "
      fi
    fi
  fi
}

my_git_propmt() {
  branch_prompt=$(__git_ps1)
  if [ -n "$branch_prompt" ]; then
    my_prompt=$(__git_ps1 "%s") # no parentheses around branchname
    if current_git_status=$(git status | grep 'added to commit' 2> /dev/null); then
      echo "$my_prompt "
    else
      echo "$my_prompt » "
    fi
  fi
}

my_new_git_propmt() {
  branch_prompt=$(__git_ps1)
  if [ -n "$branch_prompt" ]; then
    my_prompt=$(__git_ps1 "%s")
    if !current_git_status=$(git status | grep 'added to commit' 2> /dev/null); then
      echo "$my_prompt ⚠ "
    else
      echo "$my_prompt » "
    fi
  fi
}

my_sha() {
  sha=$(git rev-parse --short HEAD 2>/dev/null) || return
  echo "@$sha "
}

# non-zero exit status (of the last command) is bad
bad_exit() {
  if test $1 -ne 0 ; then
    echo "▻$1◅ "
  fi
}


PS1="${WHITE}⚚ $RED\$(bad_exit \$?)$WHITE\$(my_sha)$PURPLE\$(my_git_propmt)$RED\$(my_git_status)$YELLOW\w$WHITE ➔  $GREEN"
