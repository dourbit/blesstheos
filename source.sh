#
export THIS_HOME="$HOLY_HOME"
# see it unset at the end of this source.sh
# exists for more concise calls of uses and holy-dot
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

# will export all functions found in a file - it just looks for patterns -
# these functions must have already been sourced - or else expect errors
holy-export() {
  local dry="no" var="no" force="no"
  [ "$1" == "--dry-run" ] && {
    dry="yes"; shift
  }
  [[ "$1" == "-f" || "$1" == "--force" ]] && {
    force="yes"; shift
  }
  if [ $# -eq 0 ]; then
    >&2 echo "holy-export: path required"
    false; return
  elif ! [ -f $1 ]; then
    >&2 echo "holy-export: nothing found at $1"
    false; return
  elif ! [ -s $1 ]; then
    >&2 echo "holy-export: empty file at $1"
    false; return
  fi
  local it fns vars cmd code=() status=0
  # NOTE: '^name() {$' - a rather strict regex for function matches
  fns=$(grep -E '^.*\(\) {$' $1 | grep -Eo '^[^(]*')
  status=$?
  # NOTE: expect at least one function to be found (perhaps wrong?)
  if [ $status -ne 0 ]; then
    >&2 echo "holy-export: functions not found in $1"
  else
    for it in $fns; do
      if is-true $HOLY_EXPORT || is-true $force; then
        code+=("export -f $it")
      else
        code+=("export -fn $it")
      fi
    done
  fi
  # it can un-export vars as well --
  # though that's turned off by default due to edge cases, also it's a bad idea
  # holy exports very few vars, which are very well-named, to cause no trouble
  # code is here though, and there would be an option to enable it:
  if is-true $var && ! is-true $HOLY_EXPORT; then
    vars=$(grep -oP '(?<=export )[^\$].*(?==)' $1)
    for it in $vars; do
      code+=("export -n $it")
    done
  fi
  for cmd in "${code[@]}"; do
    # just show or run it?
    if is-true $dry; then
      echo "$cmd"
    else
      $cmd
      # not-a-function error?
      [ $? -ne 0 ] && status=1
    fi
  done
  return $status
}
export -f holy-export

# sources use/ scripts - based on this-that
uses() {
  [ $# -eq 0 ] && {
    echo "uses -- source filepaths relative to use/ dir, with .sh ext optional"
    false; return
  }
  local status=0
  local use path the found home these
  if [ $# -gt 1 ]; then
    # $1 could be a home path request
    these=$(this-that $1)
    [ $? -eq 1 ] && shift # yes it is
  else
    these=$(this-that)
  fi
  for path; do
    found=0
    for the in $these; do
      home=$([ $the == "one" ] && echo $HOLY_HOME || echo $DOTS_HOME)
      use="${home}/use/${path}"
      if [[ ! "$use" =~ '.sh$' ]] && [ -s "${use}.sh" ]; then
        . "${use}.sh"
        found=1; break
      elif [ -s "$use" ]; then
        . "$use"
        found=1; break
      else
        status=1
      fi
    done
    [ $found -eq 0 ] && >&2 echo "Not found in \"$these\" by: uses $path"
  done
  return $status
}
export -f uses


# holy-one and src/core.sh - needed to bootstrap
if holy-one 1; then
  . "${HOLY_HOME}/core.sh"
  holy-export -f "${HOLY_HOME}/core.sh"
else
  # holy-one somehow isn't on
  # clean-up here
  unset THIS_HOME
  return 1
fi

# global $LEAD_HOME - $NEXT_HOME is not exported yet
holy-env

if is-true $HOLY_SOURCE; then
  for src in $(find "${HOLY_HOME}/src" -type f | grep -e '.sh$' | sort -r); do
    . "$src"
    holy-export "$src"
  done
else
  . "${HOLY_HOME}/src/os.sh"
  holy-export "${HOLY_HOME}/src/os.sh"
fi

PATH-add \
  ${HOLY_HOME}/cmd \
  ${HOLY_HOME}/bin-fn

uses colors term aliases git jump rundev

# bash-only stuff
[ -n "$BASH" ] && uses bash

umask 022

export HISTSIZE=10000 # much?
export HISTCONTROL=ignoredups

shopt -s checkwinsize # After each command, checks the windows size and changes lines and columns
#shopt -s globstar # research...


# programming-languages aka platforms
for src in $(ls "${HOLY_HOME}/use/platforms"/* | grep -v .skip.sh); do . "$src"; done

# thus far the PATH pas been added to from many places
uses path

unset THIS_HOME
