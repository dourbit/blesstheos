holy-dot src/os

# need the following for using nvm in subshell scripts, and more...

nvm-on() {
  # TODO: first set $NVM_DIR if it exists depending on the os ...
  # then load "$NVM_DIR"/nvm.sh if it exists regardless of the os
  # return status by finally checking command -v nvm > /dev/null
  # use this nvm-on directly in the if of on/confirm/platform/node
  # does the optimization remain as a consideration (keep the NOTE)?
  # maybe an nvm-dir function will do it / be exactly enough?
  # which would also use and verify $NVM_DIR - if already set
  # then simply source $(nvm-dir) in this one + handle return codes
  # also export $NVM_DIR with this function - rather than nvm-dir

  export NVM_DIR="$HOME/.nvm"

  if onLinux; then
    [ -s "$NVM_DIR"/nvm.sh ] && . "$NVM_DIR"/nvm.sh
  elif onMac; then
    . "$(brew --prefix nvm)"/nvm.sh
  fi
}
