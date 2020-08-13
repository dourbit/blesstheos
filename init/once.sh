set -eE # exit on error
trap 'echo "Did not init $(basename $0)!"' ERR

if [ ${HOLY_GOAL} == "HOLY_HOME" ]; then
  path=$(dirname $0)
else
  # NOTE: here we have holy & all its helper functions guaranteed by holy init
  # though we don't need much from it
  path=$(holy one path init)
fi

# NOTE: init/once & init/home reused by everyone
${path}/once  $HOLY_GOAL $HOLY_HERE "$@"
home=$(${path}/home $HOLY_GOAL $(dirname $0)/..)

export $HOLY_GOAL="$home"
