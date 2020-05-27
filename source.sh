#!/usr/bin/env bash

# NOTE: using $DOTS_HOME instead of the $HOME_DOTS used to set it!
if [ -z $HOME_DOTS ]; then
  export DOTS_HOME="$(dirname $0)"
else
  # TODO: absolute path could be alowed - just check if it starts with /
  export DOTS_HOME="$HOME/$HOME_DOTS"
fi

for src in "${DOTS_HOME}/use/helpers"/*; do . "$src"; done
add_to_PATH ${DOTS_HOME}/bin-fn

uses colors
uses prompt/PS1
uses aliases
uses git
uses jump
[ -n "$BASH" ] && uses bash # bash-only stuff
uses rundev

umask 022

export HISTSIZE=10000 # much?
export HISTCONTROL=ignoredups

shopt -s checkwinsize # After each command, checks the windows size and changes lines and columns
#shopt -s globstar # research...


# programming-languages aka platforms
for src in $(ls "${DOTS_HOME}/use/platforms"/* | grep -v .skip.sh); do . "$src"; done

# thus far the PATH pas been added to from many places
uses path
