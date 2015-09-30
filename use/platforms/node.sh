export NVM_DIR=~/.nvm

if [ $system_name == 'Darwin' ]; then
  source $(brew --prefix nvm)/nvm.sh
else
  [ -s $HOME/.nvm/nvm.sh ] && . $HOME/.nvm/nvm.sh
fi
