export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

if onMac; then
  source $(brew --prefix nvm)/nvm.sh
fi

if onLinux; then
  [ -s $NVM_DIR/nvm.sh ] && . $NVM_DIR/nvm.sh
fi

uses helpers/node.sh
# NOTE: also the aliases/npm

# add_to_PATH "$(yarn global bin)" # nvm does put this is the $PATH
