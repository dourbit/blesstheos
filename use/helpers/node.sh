# node-in [specify]
# Installs the node version while keeping the same global packages from current.
# Anything nvm will take is valid: stable, default, lts/* specific version, etc.
# Defaults to lts/* (for long-term support)

# https://github.com/nvm-sh/nvm#migrating-global-packages-while-installing

node-in() {
  [[ $# -eq 0 ]] && kind="lts/*" || kind="$1"
  nvm install ${kind} --reinstall-packages-from=current --latest-npm \
    || false; return
}
export -f node-in


# node-to [specify]
# same as node-in, except makes it the default alias and switches to it

node-to() {
  [[ $# -eq 0 ]] && kind="lts/*" || kind="$1"
  node-in "$kind" \
    && nvm alias default "$kind" \
    && nvm use default \
    || false; return
}
export -f node-to


# node-v [specify]
# echoes the node version, or "N/A" if nvm can't find it

node-v() {
  [[ $# -eq 0 ]] && echo $(node -v) || echo $(nvm ls $1 | awk '{print $NF}')
}
export -f node-v


# node-up [specify]
# upgrades node where it makes sense
# switches to, and possibly upgrades one of: "lts/*", "stable", or "default"
# "current" is the default and can work if it is set to "lts/*" or "stable"

node-up() {
  kind="$1"
  # check that $kind specifier is valid
  if ! $(bb -i '(boolean (some #{(first *input*)}
                ["lts/*" "stable" "default" "current" ""]))' <<< $kind)
  then
    echo "Cannot nvm use '$kind'."
    false; return
  elif [ $# -eq 0 ] || [ "$1" == "default" ] || [ "$1" == "current" ]; then
    [[ $# -eq 0 ]] && kind="current" # the default
    kind_v=$(node-v $kind)
    [[ "$kind_v" == $(node-v lts/*) ]] && kind="lts/*"
    [[ "$kind_v" == $(node-v stable) ]] && kind="stable"
  fi
  echo "nvm use $kind"
  echo "Attempt upgrade..."
  nvm use $kind > /dev/null
  node-to $kind
}
export -f node-up
