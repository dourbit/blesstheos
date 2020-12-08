# helper functions for install scripts

# caller should check if onApt (src/os.sh)
sudo-add-apt-repository() {
  echo "sudo add-apt-repository -y $@"
  echo "Please wait for this silent run..."
  sudo add-apt-repository -y $@ > /dev/null 2>&1
}

# caller should check if onApt (src/os.sh)
sudo-apt-update() {
  echo "sudo apt update $@"
  echo "Please wait for this silent run..."
  sudo apt update $@ > /dev/null 2>&1
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

# sometimes brew is unnecessary as it takes too long to install
# that's especially true when there's a network or disk bottleneck
# perhaps it is unwanted when installing a cloud server from scratch
# when getting a machine from from zero to running is of the essence
brewOn() {
  [ "$HOLY_BREW_ON" = true ] && [ -x "$(command -v brew)" ] \
  && { true; return; } || { false; return; }
}

# report when something goes wrong
noInstall() {
  >&2 echo "Fail: $(basename $0) did not install $1"
  status=1 # if using global $status then less code needed on the calling side
  return 1
}
