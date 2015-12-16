# Sourced by `ipkgs`, this provides helpers.

# verify it's bash version >= 4
# for associative arrays, in use by ipkgs
if [ ${BASH_VERSION%%[^0-9]*} -lt 4 ]; then
  echo "Bash must be version 4 or greater."
  echo "Currently it's: '${BASH_VERSION}'."
  exit 1
fi

usage() {
  echo "Usage: $(basename $0) [-p] file(s)"
}

# special cases when command isn't the filename
# if a file isn't in this list, the $command is taken up until the first dash
declare -A special=(
  ["apt"]="apt-get"
  ["apt-get"]="apt-get" # just for example, or the '-get' would get truncated
  ["brew-cask"]="brew cask"
)

# some commands can only run on certain operating systems
# these are confirmed by filename
system=`uname -s`
declare -A syscheck=(
  ["apm-darwin"]="Darwin"
  ["apt"]="Linux" # could check for ubuntu or debian, yet presence is enough
  ["brew"]="Darwin"
  ["brew-cask"]="Darwin"
)

# it's `$pm install $package` - except for the following special cases
declare -A install=(
  ["npm"]="npm i -g"
)
