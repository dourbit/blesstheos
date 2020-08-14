# Requires one env var:
# 1. $HOLY_GOAL

# The rest are optional:
# 2. $HOLY_HERE - based on $0 so if your script name != shell then set it!
# 3. $HOLY_COPY - becomes a comment in the $HOLY_HERE config

# There is also derived:
# $HOLY_RC - is the file name aka basename of the $HOLY_HERE

# TODO: add checks to make it official with basic validation

# Does:
# failsafe a first-time init (hence "once") - unless forced
# export the $HOLY_GOAL path, without requiring that a path be explicitly given
# append the $HOLY_GOAL to $HOLY_HERE, starting with a # $HOLY_COPY
# ensure the $HOLY_HERE remains unchanges unless all is as expected


set -eE # exit on error
trap 'echo "Did not init $(basename $0)!"' ERR

if [ ${HOLY_GOAL} == "HOLY_HOME" ]; then
  path=$(dirname $0)
  # NOTE: we can set $HOLY_HOME here;
  # and also ${holy} if it has to be run
else
  # NOTE: here we have holy guaranteed by holy init
  path=$(holy one path init)
fi

# helpers sourced from here on
. $path/../bin-fn/holy.sh

if [ "$HOLY_HERE" == "" ]; then
  HOLY_HERE=~/$(shell-rc $(basename $0))
fi
HOLY_RC=$(basename $HOLY_HERE)

# NOTE: init/once & init/home reused by everyone
${path}/once  $HOLY_GOAL $HOLY_HERE "$@"
home=$(${path}/home $HOLY_GOAL $(dirname $0)/..)


export $HOLY_GOAL="$home"

touch  $HOLY_HERE
tee -a $HOLY_HERE > /dev/null << END


# $HOLY_COPY
export $HOLY_GOAL="${!HOLY_GOAL}"
END
