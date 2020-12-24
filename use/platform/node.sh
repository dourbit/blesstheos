# NOTE: sourced from elsewhere
# use/aliases/npm.sh
# src/node.sh (sometimes)

holy-dot src/ install node

if holy-be-on platform/node; then

  nvm-on

  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

  # silently use /home/orlin/.nvmrc (this will pick up a change)
  nvm use > /dev/null

  # https://github.com/yarnpkg/yarn/issues/5353
  # after the nvm / npm global packages
  [ -x "$(command -v yarn)" ] && PATH-add "$(yarn global bin)"

fi
