export NVM_DIR=~/.nvm
system_name=`uname -s`

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

if [ $system_name == 'Darwin' ]; then
  source $(brew --prefix nvm)/nvm.sh
else
  [ -s $HOME/.nvm/nvm.sh ] && . $HOME/.nvm/nvm.sh
fi

# add_to_PATH "$(yarn global bin)" # nvm does put this is the $PATH
