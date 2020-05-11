# node-in [specify]
# Installs the node version while keeping the same global packages from current.
# Anything nvm will take is valid: stable, default, lts/* specific version, etc.
# Defaults to lts/* (for long-term support)

# https://github.com/nvm-sh/nvm#migrating-global-packages-while-installing

node-in() {
  [[ $# -eq 0 ]] && kind="lts/*" || kind="$1"
  nvm install ${kind} --reinstall-packages-from=current --latest-npm || false; return
}
export -f node-in

# node-to <specify>
# same as node-in, except makes it the default alias and switches to it

node-to() {
  [[ $# -eq 0 ]] && kind="lts/*" || kind="$1"
  node-in "$kind" \
    && nvm alias default "$kind" \
    && nvm use default \
    || false; return
}
export -f node-to
