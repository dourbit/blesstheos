## /usr/bin/env source $(dirname $0)/$(basename $0)

function uses {
  if [ -z $HOME_DOTS ]; then
    use="$(dirname $0)/use/$1"
  else
    use="$HOME/$HOME_DOTS/use/$1"
  fi
  source $use
}

uses colors.sh
uses aliases.sh # general-purpose, independent of systerm, etc.
uses systerm.sh
uses git.sh


umask 022

export GREP_COLOR='1;32' # why is it different than what colors.sh exports?
export GREP_OPTIONS='-i --color=auto' # case-insensitive
export HISTSIZE=1000000 # not much?
export HISTCONTROL=ignoredups

shopt -s checkwinsize # After each command, checks the windows size and changes lines and columns
#shopt -s globstar # research...

# bash completion settings (actually, these are readline settings - research...)
bind "set completion-ignore-case on" # note: bind used instead of sticking these in .inputrc
bind "set bell-style none" # no bell
bind "set show-all-if-ambiguous On" # show list automatically, without double tab
