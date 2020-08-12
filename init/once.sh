set -eE # exit on error
trap 'echo "Did not init $(basename $0)!"' ERR
$(dirname $0)/once $HOLY_GOAL $HOLY_HERE "$@"

export $HOLY_GOAL=$($(dirname $0)/home)
