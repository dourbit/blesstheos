#
export THIS_HOME="$HOLY_HOME"
# see it unset at the end of this source.sh
# exists for more concise calls of holy-dot
# thus this-that needs no path arg, for the time being...
# only ever an issue when sourcing from the outside, e.g. ~/.bashrc, etc.
# essential for code portability between blesstheos and dots or its forks -
# it is an indicator of bootstrapping in progress...


# OS has holy and wide variety of holy-one-on ways to check that it's all good
holy-one() {
  # $1 option:
  # level 0 is silent (the default)
  # level 1 is verbose about not finding a $HOLY_HOME
  # level 2 or whatever else will delegate to holy on
  local level="${1-0}"
  local holy="$HOLY_HOME"/holy
  local wtf="Very odd that \$HOLY_HOME has no holy in it!"
  command -v $holy > /dev/null
  local status=$?
  if [[ $level == "0" || $level == "1" ]]; then
    if [ -z "$HOLY_HOME" ]; then
      [ $level == "1" ] && echo "\$HOLY_HOME not set!"
      return 1
    elif ! [ -d "$HOLY_HOME" ]; then
      [ $level == "1" ] && echo "\$HOLY_HOME dir of $HOLY_HOME is Not Found!"
      return 1
    else
      [[ $level == "1" && $status -ne 0 ]] && \
        echo $wtf
      return $status
    fi
  elif [ $status -eq 0 ]; then
    # any other / unknown level delegates to $holy
    $holy one on
  else
    # holy is not known
    echo $wtf
    false; return
  fi
}
export -f holy-one


# holy-one and core.sh functions to bootstrap with
if holy-one 1; then
  . "${HOLY_HOME}/core.sh"
  holy-export -f "${HOLY_HOME}/core.sh"
else
  # holy-one somehow isn't on, unexpected but possible
  # clean-up here
  unset THIS_HOME
  return 1
fi

# exports $LEAD_HOME
holy-sort

if tis-true $HOLY_SOURCE; then
  holy-dot -x src/
  # or get more fancy, such as:
  # holy-dot -x $(find "${HOLY_HOME}/src" -type f | grep '.sh$')
else
  # must be sourced, maybe exported:
  holy-dot -x src/os.sh
fi


PATH-add \
  ${HOLY_HOME}/cmd \
  ${HOLY_HOME}/bin-fn

holy-dot use/ colors term aliases git jump rundev

# bash-only stuff
[ -n "$BASH" ] && holy-dot use/bash

umask 022

export HISTSIZE=10000 # much?
export HISTCONTROL=ignoredups

shopt -s checkwinsize # After each command, checks the windows size and changes lines and columns
#shopt -s globstar # research...


# platforms for programming / runtime
for src in $(ls "${HOLY_HOME}/use/platform"/* | grep -v .skip); do . "$src"; done

# so far the PATH pas been added to from many places
holy-dot use/path

unset THIS_HOME
