# Requires two env vars:
# 1. $HOLY_GOAL
# 2. $HOLY_HERE
# 3. $HOLY_COPY - becomes a comment in the $HOLY_HERE config (optional)
# TODO: add checks to make it official

# Does:
# failsafe a first-time init (hence "once") - unless forced
# export the $HOLY_GOAL path, without requiring that a path be explicitly given
# append the $HOLY_GOAL to $HOLY_HERE, starting with a # $HOLY_COPY
# ensure the $HOLY_HERE remains unchanges unless all is as expected


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

touch  $HOLY_HERE
tee -a $HOLY_HERE > /dev/null << END


# $HOLY_COPY
export $HOLY_GOAL="${!HOLY_GOAL}"
END
