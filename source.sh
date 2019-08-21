#!/usr/bin/env bash

# NOTE: using $DOTS_HOME instead of the $HOME_DOTS used to set it!
if [ -z $HOME_DOTS ]; then
  export DOTS_HOME="$(dirname $0)"
else
  # TODO: absolute path could be alowed - just check if it starts with /
  export DOTS_HOME="$HOME/$HOME_DOTS"
fi

# http://unix.stackexchange.com/questions/4965/keep-duplicates-out-of-path-on-source
add_to_PATH () {
  for d; do
    # d=$(cd -- "$d" && { pwd -P || pwd; }) 2>/dev/null  # canonicalize symbolic links
    # if [ -z "$d" ]; then continue; fi  # skip nonexistent directory
    if ! [ -d "$d" ]; then continue; fi
    case ":$PATH:" in
      *":$d:"*) :;;
      *) PATH=$PATH:$d;;
    esac
  done
}

function uses {
  source "$DOTS_HOME/use/$1"
}


uses colors.sh
uses systerm.sh # system/terminal-specific stuff
uses aliases.sh # general-purpose, independent of systerm, etc.
uses functions.sh # sometimes an alias is not enough
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
uses platforms/haskell.sh

# crypto
uses bitcoin.sh

# thus far the PATH pas been added to from many places
add_to_PATH  /usr/local/sbin
add_to_PATH ${DOTS_HOME}/bin

# TODO: add_to_PATH_front (for the rest of these paths)
add_to_PATH .
mkdir -p ~/.bin
add_to_PATH ~/.bin

export PATH # concludes what the PATH will be
