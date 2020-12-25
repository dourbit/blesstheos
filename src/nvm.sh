holy-dot src/os

nvm-dir() {
  local dir
  if tis-some $NVM_DIR; then
    dir="$NVM_DIR"
  elif onMac && brewOn; then
    dir="$(brew --prefix nvm)"
  else
    # Linux or other
    dir="$HOME"/.nvm
  fi
  # validate nvm directory
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
    command -v nvm > /dev/null
  else
    >&2 echo "Not Found: nvm"
    false; return
  fi
}
