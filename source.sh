#!/usr/bin/env bash

# NOTE: using $DOTS_HOME instead of the $HOME_DOTS used to set it!
if [ -z $HOME_DOTS ]; then
  export DOTS_HOME="$(dirname $0)"
else
  # TODO: absolute path could be alowed - just check if it starts with /
  export DOTS_HOME="$HOME/$HOME_DOTS"
fi

for SRC in "${DOTS_HOME}/use/helpers"/*; do . "$SRC"; done

uses colors.sh
uses prompt/PS1.sh
uses system.sh # system / terminal-specific stuff
uses aliases.sh # general-purpose, independent of systerm, etc.
uses git.sh
uses jump.sh
[ -n "$BASH" ] && uses bash.sh # bash-only stuff
uses rundev.sh

umask 022

export HISTSIZE=1000000 # not much?
export HISTCONTROL=ignoredups

shopt -s checkwinsize # After each command, checks the windows size and changes lines and columns
#shopt -s globstar # research...


# programming-languages aka platforms
for SRC in $(ls "${DOTS_HOME}/use/platforms"/* | grep -v .skip.sh); do . "$SRC"; done

# thus far the PATH pas been added to from many places
uses path.sh
