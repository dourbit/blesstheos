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
