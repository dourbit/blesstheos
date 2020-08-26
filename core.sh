# true if $1 is some rather than none, i.e. has any value other than blank (or)
# if $# >= 2; then is $1 = some of $2 = a space-separated words match-list
# NOTE: in the latter case, quote the "$1" (or blank produces a false positive)
is-some() {
  if [ $# -lt 2 ]; then
    return "$((!${#1}))"
  else
    echo $2 | grep -wq "$1"
  fi
}

# true ($?) status of 0, on, yes, and of-course true
# anything else would be a false 1 return
is-true() {
  if is-some "$1" "0 on yes true"; then
    true; return
  fi
  false; return
}

# validates a holy lead mod / modifier
holy-be() {
  is-some "$1" "one me you" && true || false
}

# echoes $HOLY_LEAD, if valid, or the "one" default
holy-lead() {
  if holy-be $HOLY_LEAD; then
    # optional system default
    echo $HOLY_LEAD
  else
    echo "one"
  fi
}

# because some functions such as holy-dot & uses
# prefer to source these rather than those files -
# code would favor code from the same repo first -
# unless $here is under $DOTS_HOME the one leads -
# given a $HOLY_HOME or $DOTS_HOME becomes $here -
# else if $THIS_HOME is set it will become $here -
# there's no holy-you until holy-one has sourced
this-that() {
  status=0
  local here=$(cd $(dirname $0) && pwd)
  if [ -n "$1" ] && [[ "$1" == "$HOLY_HOME" || "$1" == "$DOTS_HOME" ]]; then
    # is given a specific home, which also checks out as valid
    here=$1
    status=1
  elif [ -n "$THIS_HOME" ]; then
    # available while sourcing either of the 2 source.sh files
    # a convenience and for code portability among dots, forks, or the "one"
    here=$THIS_HOME
  fi
  # $here is all-set; check if holy-you is on:
  if holy-you; then
    # is $here a $DOTS_HOME path?
    if grep -q "^$DOTS_HOME" <<< "$here"; then
      echo "you one"
    else
      echo "one you"
    fi
  else
    echo "one"
  fi
  return $status # is never an error, 1 just means a home path was given as $1
}

# we would want to have customized holy you be reachable too
# imitates the holy-one fn - see source.sh for reference
# this one is simpler & assumes holy-one is already true
holy-you() {
  # $1 option:
  # level 0 is silent (the default)
  # level 1 is verbose about not finding a $DOTS_HOME
  # level 2 or whatever else will delegate to holy on
  local level="${1-0}"
  if [[ $level == "1" || $level == "0" ]]; then
    if ! is-some $DOTS_HOME; then
      [ $level == "1" ] && echo "\$DOTS_HOME not set!"
      return 1
    elif ! [ -d "$DOTS_HOME" ]; then
      [ $level == "1" ] && echo "\$DOTS_HOME dir of $DOTS_HOME is Not Found!"
      return 1
    fi
    return 0
  else
    holy you on
  fi
}

# export $LEAD_HOME & $NEXT_HOME depending on the $1 or $HOLY_LEAD
# if you not on: just $LEAD_HOME and return false
holy-env() {
  local the=$1 # the holy subshell uses this with each run
  # NOTE: holy-one has already validated, for this to be sourced
  local level=$2 # give it a 1 to complain if holy-you not found
  if ! holy-be $the; then
    the=$(holy-lead)
    if [ $# -eq 1 ]; then
      # invalid $1 hereby interpreted as $level if just 1 arg is given
      level=$1
    fi
  fi
  local yours=1 # false status of holy-you (tested below)
  if holy-you $level; then
    yours=0 # is true
    if [[ $the == "one" ]]; then
      export LEAD_HOME="$HOLY_HOME"
      export NEXT_HOME="$DOTS_HOME"
    else
      export LEAD_HOME="$DOTS_HOME"
      export NEXT_HOME="$HOLY_HOME"
    fi
  else
    # only holy-one
    export LEAD_HOME="$HOLY_HOME"
    unset NEXT_HOME # maybe holy-you went off - this cleans the env
  fi
  return $yours
}

# sources files; guesses any relative paths; -f for fn exports; wip...
holy-dot() {
  local exports=no
  if [ "$1" == "-f" ]; then
    exports=yes; shift
  fi
  # TODO: implement exports (so far just an intention)
  if [ $# -eq 0 ]; then
    >&2 echo "No files specified - nothing to source!"
    false; return
  fi
  for path in "$@"; do
    . "$LEAD_HOME"/$path
    # TODO: implement $NEXT_HOME
  done
}

# http://unix.stackexchange.com/questions/4965/keep-duplicates-out-of-path-on-source
PATH-add() {
  for d; do
    # d=$(cd -- "$d" && { pwd -P || pwd; }) 2>/dev/null  # canonicalize symbolic links
    # if [ -z "$d" ]; then continue; fi  # skip nonexistent directory
    if ! [ -d "$d" ]; then continue; fi
    case ":$PATH:" in
      *":$d:"*) :;;
      *) PATH=$PATH:$d;;
    esac
  done
}
