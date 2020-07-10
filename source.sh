#!/usr/bin/env bash

# NOTE: using $HOLY_HOME instead of the $DOT_HOLY used to set it!
if [ -z $DOT_HOLY ]; then
  export HOLY_HOME="$(dirname $0)"
else
  # TODO: absolute path could be alowed - just check if it starts with /
  export HOLY_HOME="$HOME/$DOT_HOLY"
fi

for src in "${HOLY_HOME}/use/helpers"/*; do . "$src"; done
add_to_PATH ${HOLY_HOME}/bin-fn

uses colors
uses term
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
for src in $(ls "${HOLY_HOME}/use/platforms"/* | grep -v .skip.sh); do . "$src"; done

# thus far the PATH pas been added to from many places
uses path
