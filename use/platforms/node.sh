# NOTE: sourced from elsewhere aliases/npm.sh and helpers/node.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

if onLinux; then
  [ -s "$NVM_DIR"/nvm.sh ] && . "$NVM_DIR"/nvm.sh
elif onMac; then
  . "$(brew --prefix nvm)"/nvm.sh
fi

# https://github.com/yarnpkg/yarn/issues/5353
# after the nvm / npm global packages
check-x yarn && add_to_PATH "$(yarn global bin)"
