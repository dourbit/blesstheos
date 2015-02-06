# borrowed from somewhere, possibly altered...

concise_logging_format='--pretty=format:%Cblue%h%Creset %cr %Cgreen%an%Creset %s'
color_ruby_words="--color-words='(:|@|@@|\$)?[a-zA-Z_][a-zA-Z0-9_]*[?!]?'"

alias gits='git status'
alias gita='git add'
alias gitau='git add -u'
alias gitd='git diff'
alias gitdc='git diff --cached'
alias gitdw="git diff $color_ruby_words"
alias gitdcw="git diff --cached $color_ruby_words"
alias gitd.="git diff --color-words='.'"
alias gitdc.="git diff --cached --color-words='.'"
alias gitc='git commit -v'
alias gitb='git branch -v'
alias gitl='git log -p'
alias gitlg='gitl --graph'
alias gitlc='git log "$concise_logging_format"'
alias gitlcg='gitlc --graph'
alias gitlg='git log -p -g'
alias gitlor_raw='git --no-pager log --graph ORIG_HEAD..HEAD "$concise_logging_format"'
alias gitlpend_raw='git --no-pager log --graph $(git config branch.`git-branch-name`.remote)/`git-branch-name`..HEAD "$concise_logging_format"'
alias gitlor='echo -e "commits from ${color_red}ORIG_HEAD${color_none} to ${color_red}HEAD${color_none}" &&
  gitlor_raw && echo'
alias gitlpend='echo -e "commits from ${color_red}$(git config branch.`git-branch-name`.remote)/`git-branch-name`${color_none} to ${color_red}HEAD${color_none}" &&
  gitlpend_raw && echo'
alias gitlorp='gitlor_raw -p'
alias gitup='git pull && gitlor && git submodule update'
alias gitp='gitup && gitlpend && git push'
alias gitpt='gitp && git push --tags'

alias git-set-remote='echo git config branch.`git-branch-name`.remote "$1" && echo git config branch.`git-branch-name`.merge "refs/heads/$2"'
