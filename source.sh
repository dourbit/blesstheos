## /usr/bin/env source $(dirname $0)/$(basename $0)

# NOTE: using $DOTS_HOME instead of the $HOME_DOTS used to set it!
if [ -z $HOME_DOTS ]; then
  export DOTS_HOME="$(dirname $0)"
else
  # TODO: absolute path could be alowed - just check if it starts with /
  export DOTS_HOME="$HOME/$HOME_DOTS"
fi

function uses {
  source "$DOTS_HOME/use/$1"
}

uses colors.sh
uses aliases.sh # general-purpose, independent of systerm, etc.
uses systerm.sh # system/terminal-specific stuff
uses git.sh # also improves the prompt in non-git contexts


umask 022

export NODE_ENV=development
export JAVA_HOME=`/usr/libexec/java_home`

export PATH=${PATH}:${JAVA_HOME}:${DOTS_HOME}/bin

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
