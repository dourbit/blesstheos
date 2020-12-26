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
  tis-true $HOLY_BREW_ON && [ -x "$(command -v brew)" ] && { true; return; } \
    || { false; return; }
}

# check if a given package is installed by brew
# this works regardless of brewOn
brewCheck() {
  if [ $# -eq 0 ]; then
    >&2 echo "Please provide a package name."
  elif ! [ -x "$(command -v brew)" ]; then
    >&2 echo "Homebrew isn't on, perhaps do: holy in brew"
  else
    brew list --formula | grep -w $1 >/dev/null 2>&1
    return $?
  fi
  false; return;
}

# report when something goes wrong
noInstall() {
  >&2 echo "Fail: $(basename $0) did not install $1"
  status=1 # if using global $status then less code needed on the calling side
  return 1
}

# see example use in bin/outdated
# NOTE: maybe just add options to holy-on and skip holy-be-on - altogether?
# TODO: think of a HOLY_VAR: for expressing a completely silent preference,
# because not installing a holy ability would be wanting to self-handle it?
# Thus not be bothered with any messages regarding outdated packages,
# how to install / bless it, etc. Though how do we catch certain holy bugs?
holy-be-on() {
  if [ $# -eq 0 ]; then
      >&2 echo "holy on <what>?"
      return 1
  else
    local what=$1; shift
    silent holy on $what
    if [ $? -eq 0 ]; then
      return 0
    elif [ $# -ne 0 ]; then
      # custom message given
      echo "$@"
    else
      # is informative enough
      holy on $what
    fi
    return 1
  fi
}
