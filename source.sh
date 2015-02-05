## /usr/bin/env source $(dirname $0)/$(basename $0)

system_name=`uname -s` # usualy Darwin, sometimes also Linux

function uses {
  use="$HOME/$HOME_DOTS/use/$1"
  source $use
}

uses colors.sh
