## /usr/bin/env source $(dirname $0)/$(basename $0)

system_name=`uname -s` # usualy Darwin, sometimes also Linux

function uses {
  if [ -z $HOME_DOTS ]; then
    use="$(dirname $0)/use/$1"
  else
    use="$HOME/$HOME_DOTS/use/$1"
  fi
  source $use
}

uses colors.sh
