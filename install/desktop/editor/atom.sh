#!/usr/bin/env bash

# atom.sh because atom won't use syntax highlighting, I guess taken for markup

# Depends on aton
# Using: onApt sudoUse sudo-add-apt-repository sudo-apt-update noInstall
holy-dot src/ os install util
status=0

check-x atom && echo "Notice: atom is already installed, proceeding anyway"

if onApt; then
  sudoUse
  wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
  sudo-add-apt-repository "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main"
  sudo-apt-update
  sudo apt install -y atom || noInstall "atom"
else
  status=1
fi

tis-true $status && type atom

exit $status
