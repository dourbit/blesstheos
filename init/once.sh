# init/once.sh is reused by everyone
# must be sourced from a file that's in a subdirectory of a project's root dir
# init is such a dir and init/once does nothing useful to be called directly
# it's just a safety mechanism, whereas init.sh sets up the environment, and
# also does a most basic setup that constitutes a successful init
# all of it happens here below

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


# a failsafe to prevent re-init of same thing
${path}/once $HOLY_GOAL $HOLY_HERE "$@"

# exports an absolute path to a home by convention (one directory down)
# TODO: holy init always knows the home path, just give it to the script?
# that would mean adding a new var such as $HOME_PATH
a-home $HOLY_GOAL $(dirname $0)/..


touch  $HOLY_HERE
tee -a $HOLY_HERE > /dev/null << END


# $HOLY_COPY
export $HOLY_GOAL="${!HOLY_GOAL}"
END
