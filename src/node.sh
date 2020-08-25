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
