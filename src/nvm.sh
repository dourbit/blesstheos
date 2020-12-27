holy-dot src/os

nvm-dir() {
  local dir
  if tis-some $NVM_DIR; then
    dir="$NVM_DIR"
  elif [ -x "$(command -v brew)" ] && brewCheck nvm; then
    # brew is installed, and nvm is installed with it (usually onMac)
    # in this case brewOn is rather irrelevant
    dir="$(brew --prefix nvm)"
  else
    # Linux or other not using brew
    dir="$HOME"/.nvm
  fi
  # validate the nvm dir
  if [ -s "$dir"/nvm.sh ]; then
    echo "$dir" && true; return
  else
    false; return
  fi
}

nvm-on() {
  local dir="$(nvm-dir)"
  if [ -d "$dir" ]; then
    export NVM_DIR="$dir"
    . "$NVM_DIR"/nvm.sh
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
    command -v nvm > /dev/null
  else
    >&2 echo "Not Found: nvm"
    false; return
  fi
}

nvm-up() {
  if tis-some $NVM_DIR; then
    # https://github.com/nvm-sh/nvm#manual-upgrade
    (
      cd "$NVM_DIR"
      git fetch --tags origin
      git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" \
        $(git rev-list --tags --max-count=1)`
    ) && \. "$NVM_DIR/nvm.sh"
  fi
}
