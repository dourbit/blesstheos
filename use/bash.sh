# bash completion settings (actually, these are readline settings)
# NOTE: bind used instead of sticking these in .inputrc

bind "set bell-style none" # no bell
bind "set completion-ignore-case on" # case-insensitive tab-completion
bind "set show-all-if-ambiguous On" # show tab-completion list with a single tab
# anything else? http://ss64.com/bash/syntax-inputrc.html

# bash_completion
if onMac; then
  bash_v=${BASH_VERSION%%[^0-9]*} # also possible with $BASH_VERSINFO
  if [ $bash_v == "3" ]; then
    # brew install bash-completion # for bash 3.2+
    # http://www.caliban.org/bash/index.shtml#completion
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
      . $(brew --prefix)/etc/bash_completion
    fi
  fi
  if [ $bash_v == "4" ]; then
    # brew install bash-completion2 # for bash 4+?
    if [ -f $(brew --prefix)/share/bash-completion/bash_completion ]; then
      . $(brew --prefix)/share/bash-completion/bash_completion
    fi
  fi
else
  if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
