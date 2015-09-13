if [ -n "$TRANSMISSION_RE" ]; then
  transmission-remote() {
    exec transmission-remote ${TRANSMISSION_RE} ${@}
  }
  # make it available to scripts
  export -f transmission-remote
fi

function tre-ids-pipe {
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
