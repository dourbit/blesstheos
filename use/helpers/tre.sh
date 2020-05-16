#!/usr/bin/env bash

# turned on by something like the following line added to .bashrc
# export TRANSMISSION_RE='127.0.0.1:9092 --auth username:password'
# needed by the bin/tre-* scripts

if onLinux && [ -n "$TRANSMISSION_RE" ]; then

  tre() {
    eval $(which transmission-remote) ${TRANSMISSION_RE} ${@}
  }
  export -f tre

  tre-ids() {
    tre --list | sed -e '1d;$d;s/^ *//' | cut -s -d ' ' -f 1
  }
  export -f tre-ids

  tre-ids-pipe() {
    # give it a function or script to call
    # pass on the rest of the args (slice)
    if [[ -p /dev/stdin ]]; then
      # the input is coming from a pipe
      eval $1 "${@:2}"
    else
      # the stdbuf tip came from http://unix.stackexchange.com/questions/117501/in-bash-script-how-to-capture-stdout-line-by-line
      stdbuf -oL tre-ids | eval $1 "${@:2}"
    fi
  }
  export -f tre-ids-pipe

fi
