# Note: init/once.sh is reused by init of dourbit/dots and also its forks...

# Does:
# failsafe a first-time init (hence "once") - unless forced with an override
# ensure the $HOLY_HERE remains unchanged unless the conditions are met
# export the $HOLY_GOAL path, without requiring that a path be explicitly given
# append the $HOLY_GOAL to $HOLY_HERE, starting with a # $HOLY_COPY
# append the least possible code to the $HOLY_HERE $HOLY_RC

# Requires one env var:
# 1. $HOLY_GOAL - name of the home var

# The rest are optional:
# 2. $HOLY_COPY - becomes a comment in the $HOLY_HERE config, or an empty one
# 3. $HOLY_HERE - based on $0 so if your script name != shell then set it!

# There is also the always derived:
# $HOLY_RC - is the file name aka basename of the $HOLY_HERE
# $HOLY_PATH - is $(dirname $0)/.. as an init dir is a child of a home dir
# see comments where these are set if extra complexity would be introduced

# TODO: add checks to make it official with basic validation;
# also echo notices if ppl are setting vars unnecessarily


set -eE # exit on error
trap 'echo "Will not init $(basename $0), again!"' ERR

# need the $path to this init/ dir
if [ ${HOLY_GOAL} == "HOLY_HOME" ]; then
  path=$(dirname $0)
  # NOTE: we can set $HOLY_HOME here;
  # and also ${holy} if it has to be run
else
  # NOTE: here we have holy guaranteed by holy init
  path=$(holy one path init)
fi

# helpers sourced from here on
. $path/../src/path.sh
. $path/../cmd/holy.sh

# setup the optional / derived vars -- defaults ok by convention
[ "$HOLY_HERE" == "" ] && HOLY_HERE=~/$(shell-rc $(basename $0))
HOLY_RC=$(basename $HOLY_HERE)

# NOTE: $HOLY_PATH should always be automatic - TODO: YAGNI ...
# if we ever use anything hierarchical rather than a flat init/
# just cd .. intil init/ is reached + add the extra steps of /.. needed
[ "$HOLY_PATH" == "" ] && HOLY_PATH=$(dirname $0)/..


# a failsafe to prevent re-init of same thing
${path}/once $HOLY_GOAL $HOLY_HERE "$@"

# export the $HOLY_PATH as a $HOLY_GOAL absolute path
a-home $HOLY_GOAL $HOLY_PATH


touch  $HOLY_HERE
tee -a $HOLY_HERE > /dev/null << END


# $HOLY_COPY
export $HOLY_GOAL="${!HOLY_GOAL}"

. "\$$HOLY_GOAL"/declare.sh

# perhaps override some vars here...
# export HOLY_TIME=yes
END
