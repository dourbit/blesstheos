#!/usr/bin/env bash

# NOTE: using $DOTS_HOME instead of the $HOME_DOTS used to set it!
if [ -z $HOME_DOTS ]; then
  export DOTS_HOME="$(dirname $0)"
else
  # TODO: absolute path could be alowed - just check if it starts with /
  export DOTS_HOME="$HOME/$HOME_DOTS"
fi

for helper in "${DOTS_HOME}/use/helpers"/*; do . "$helper"; done

uses colors.sh
uses prompt/PS1.sh
uses systerm.sh # system/terminal-specific stuff
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


# programming languages - platforms & packages:
uses platforms/node.sh
uses platforms/java.sh
uses platforms/ruby.sh
# uses platforms/haskell.sh

# thus far the PATH pas been added to from many places
add_to_PATH  /usr/local/sbin
add_to_PATH ${DOTS_HOME}/bin
add_to_PATH ${DOTS_HOME}/bin-fn

# TODO: add_to_PATH_front (for the rest of these paths)
add_to_PATH .
mkdir -p ~/bin
add_to_PATH ~/bin
[ ! -e ~/.bin ] && ln -s ~/bin ~/.bin # .bin symlink to bin for b-compatibility
add_to_PATH ~/deps/bin # see install/shell

export PATH # concludes what the PATH will be
