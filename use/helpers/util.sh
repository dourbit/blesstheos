# spaced echo
specho() {
  echo
  echo "$@"
}
export -f specho

# sometimes brew is unnecessary as it takes too long to install
# that's especially true when there's a network or disk bottleneck
# perhaps it is unwanted when installing a cloud server from scratch
# when getting a machine from from zero to running is of the essence
brewOn() {
  [ "$BREW_ON" = true ] && { true; return; } || { false; return; }
}
export -f brewOn
