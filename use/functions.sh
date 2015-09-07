if [ -n "$TRANSMISSION_RE" ]; then
  transmission-remote() {
    exec transmission-remote ${TRANSMISSION_RE} ${@}
  }
  # make it available to scripts
  export -f transmission-remote
fi
