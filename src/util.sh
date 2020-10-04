# For things that don't belong elsewhere.

errcho() { cat <<< "$@" 1>&2; }

# spaced echo for more readble output with less code
specho() {
  echo
  echo "$@"
}

# will use sudo, make it clear at the top, especially for long-running scripts
sudoUse() {
  # use in scripts using sudo
  # declare intent at the top
  # prompts for password early
  # when people are still looking
  # as sudo will be used later on
  sudo echo "" > /dev/null # does nothing except ask for password if necessary
}

# sudo with your own $PATH and maybe more in the future
sudomy() {
  sudo env "PATH=$PATH" $@
}

# sometimes brew is unnecessary as it takes too long to install
# that's especially true when there's a network or disk bottleneck
# perhaps it is unwanted when installing a cloud server from scratch
# when getting a machine from from zero to running is of the essence
brewOn() {
  [ "$HOLY_BREW_ON" = true ] && [ -x "$(command -v brew)" ] \
  && { true; return; } || { false; return; }
}

# NOTE: for a current Ubuntu this is automatically so, however...
# TODO: maybe add $HOLY_SNAP_ON because using snap may be unwanted by some
# though this logic may change further with use of other operating systems
snapOn() {
  [ -x "$(command -v snap)" ] && { true; return; } || { false; return; }
}

# NOTE: same as the above, or worse, read these criticisms:
# https://flatkill.org/
# https://news.ycombinator.com/item?id=18180017
flatpakOn() {
  [ -x "$(command -v flatpak)" ] && { true; return; } || { false; return; }
}
