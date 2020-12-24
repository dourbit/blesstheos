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


# node-in [specify]
# Installs the node version while keeping the same global packages from current.
# Anything nvm will take is valid: stable, default, lts/* specific version, etc.
# Defaults to lts/* (for long-term support)
# https://github.com/nvm-sh/nvm#migrating-global-packages-while-installing

node-in() {
  local kind
  [[ $# -eq 0 ]] && kind="lts/*" || kind="$1"
  nvm install ${kind} --reinstall-packages-from=current --latest-npm \
    || false; return
}


# node-to [specify]
# same as node-in, except makes it the default alias and switches to it

node-to() {
  local kind
  [[ $# -eq 0 ]] && kind="lts/*" || kind="$1"
  node-in "$kind" \
    && nvm alias default "$kind" \
    && nvm use default \
    || false; return
}


# node-v [specify]
# echoes the node version, or "N/A" if nvm can't find it

node-v() {
  [[ $# -eq 0 ]] && echo $(node -v) || echo $(nvm ls $1 | awk '{print $NF}')
}


# node-up [specify]
# upgrades node where it makes sense
# switches to, and possibly upgrades one of: "lts/*", "stable", or "default"
# "current" is the default and can work if it is set to "lts/*" or "stable"

node-up() {
  local kind=${1-"current"}
  # check if $kind is valid
  if ! $(node-use.clj $kind)
  then
    echo "Cannot nvm use this."
    echo "Make it one of: $(node-use.clj)"
    false; return
  elif [ "$kind" == "default" ] || [ "$kind" == "current" ]; then
    local kind_v=$(node-v $kind)
    if [ "$kind_v" == $(node-v lts/*) ]; then kind="lts/*"
    elif [ "$kind_v" == $(node-v stable) ]; then kind="stable"
    else
      echo "Cannot use $kind $kind_v - which is neither lts/* nor stable."
      false; return
    fi
  fi
  echo "nvm use $kind"
  echo "Attempt upgrade..."
  nvm use $kind > /dev/null
  node-to $kind
}


# npm-i [opts] <packages>
# NOTE: any --options (e.g. -g / --global) must come before the packages
# install any packages, whether explicitly versioned or not,
# only if not already installed - globally or otherwise ...
# better when expecting the packages to be installed already
# it does not reinstall and in fact that's the raison d'etre

npm-i() {
  local arg opts=()
  for arg in $@; do
    if [[ "$arg" =~ ^- ]]; then
      opts+=($arg)
    # NOTE: checking for installed modules can be oddly imprecice and tricky!
    # for example @hyperspace/cli shows up as npm ls -g hyperspace
    # the options below ensure an exact match for "Installed: ..."
    # otherwise a false positive would hinder a valid installation call
    elif npm ls ${opts[@]} --parseable --depth=0 $arg | \
      grep -e "node_modules/$arg\$" >/dev/null 2>&1; then
      echo "Installed: $arg"
    else
      npm i ${opts[@]} $arg
    fi
  done
}
