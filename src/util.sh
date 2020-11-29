# For things that don't belong elsewhere.

# spaced echo for more readble output with less code
specho() {
  echo
  echo "$@"
}

# >&2 echo ... # is preferable
errcho() { cat <<< "$@" 1>&2; }

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
