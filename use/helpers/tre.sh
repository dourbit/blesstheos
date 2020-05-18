#!/usr/bin/env bash

# Some functions in use by the bin/tre-* scripts

check-tre() {
  if ! onLinux; then
    echo "Only Linux supported so far."
    false; return
  elif [ ! -x "$(command -v transmission-remote)" ]; then
    echo "Command 'transmission-remote' not found."
    if onApt; then
      echo "The following command can install:"
      echo "sudo apt install transmission-cli"
    elif check-x brew; then
      echo "Since you have brew installed:"
      echo "brew install transmission-cli"
    else
      echo "Check the following on how to setup:"
      echo "https://transmissionbt.com/download/"
    fi
    false; return
  elif [ -z "${TRANSMISSION_RE}" ]; then
    echo "Not finding transmission-remote configuration"
    echo "Retry after adding the following to ~/.bashrc-pre with changed values"
    echo "export TRANSMISSION_RE='127.0.0.1:9092 --auth user:password'"
    false; return
  fi
}
export -f check-tre

if [ ! -z "${TRANSMISSION_RE}" ] && check-tre; then

  tre() {
    eval $(command -v transmission-remote) ${TRANSMISSION_RE} ${@}
  }
  export -f tre

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

else false; return
fi
