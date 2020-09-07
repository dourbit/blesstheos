# NOTE: sourced from elsewhere - use/aliases/npm.sh and src/node.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

if onLinux; then
  [ -s "$NVM_DIR"/nvm.sh ] && . "$NVM_DIR"/nvm.sh
elif onMac; then
  . "$(brew --prefix nvm)"/nvm.sh
fi

# https://github.com/yarnpkg/yarn/issues/5353
# after the nvm / npm global packages
[ -x "$(command -v yarn)" ] && PATH-add "$(yarn global bin)"
