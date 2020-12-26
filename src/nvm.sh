holy-dot src/os

nvm-dir() {
  local dir
  if tis-some $NVM_DIR; then
    dir="$NVM_DIR"
  elif onMac && silent brewCheck nvm; then
    dir="$(brew --prefix nvm)"
  else
    # Linux or other
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
