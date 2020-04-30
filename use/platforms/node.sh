export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

if onMac; then
  source $(brew --prefix nvm)/nvm.sh
elif onLinux; then
  [ -s $HOME/.nvm/nvm.sh ] && . $HOME/.nvm/nvm.sh
fi

# add_to_PATH "$(yarn global bin)" # nvm does put this is the $PATH
