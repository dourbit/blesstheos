# For things that don't belong elsewhere.

# true if env var is set to anything
env-have() { return "$((!${#1}))"; }
export -f env-have

# true if env var is 1, yes, or true
env-true() {
  local var="$1"
  if env-have $var; then
    if [[ $var == '1' || $var == 'yes' || $var == 'true' ]]; then
      true; return
    fi
  fi
  false; return
}
export -f env-true

errcho() { cat <<< "$@" 1>&2; }
export -f errcho

# spaced echo for more readble output with less code
specho() {
  echo
  echo "$@"
}
export -f specho

# will use sudo, make it clear at the top, especially for long-running scripts
sudoUse() {
  # use in scripts using sudo
  # declare intent at the top
  # prompts for password early
  # when people are still looking
  # as sudo will be used later on
  sudo echo "" > /dev/null # does nothing except ask for password if necessary
}
export -f sudoUse

# sudo with your own $PATH and maybe more in the future
sudomy() {
  sudo env "PATH=$PATH" $@
}
export -f sudomy

# sometimes brew is unnecessary as it takes too long to install
# that's especially true when there's a network or disk bottleneck
# perhaps it is unwanted when installing a cloud server from scratch
# when getting a machine from from zero to running is of the essence
brewOn() {
  [ "$HOLY_BREW_ON" = true ] && check-x brew && { true; return; } || { false; return; }
}
export -f brewOn
