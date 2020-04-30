#!/usr/bin/env bash

# NOTE: using $DOTS_HOME instead of the $HOME_DOTS used to set it!
if [ -z $HOME_DOTS ]; then
  export DOTS_HOME="$(dirname $0)"
else
  # TODO: absolute path could be alowed - just check if it starts with /
  export DOTS_HOME="$HOME/$HOME_DOTS"
fi

source "$DOTS_HOME/use/helpers/path.sh"

# helper functions, in addition to helpers/path.sh
uses helpers/os.sh # checks for system-specific stuff, many scripts will use it

uses colors.sh
uses systerm.sh # system/terminal-specific stuff
uses aliases.sh # general-purpose, independent of systerm, etc.
uses git.sh # also improves the prompt in non-git contexts
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

# TODO: add_to_PATH_front (for the rest of these paths)
add_to_PATH .
mkdir -p ~/.bin
add_to_PATH ~/.bin

export PATH # concludes what the PATH will be
