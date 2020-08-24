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
export -f is-some

# true ($?) status of 0 / yes / true (anything else would be a false 1 return)
is-true() {
  if is-some "$1" "0 yes true"; then
    true; return
  fi
  false; return
}
export -f is-true

# validates a holy lead mod / modifier
holy-be() {
  [[ "$1" == "one" || "$1" == "you" ]] && true || false
}
export -f holy-be

# echoes the valid $HOLY_LEAD with "one" being default
holy-lead() {
  if holy-be $HOLY_LEAD; then
    # optional system default
    echo $HOLY_LEAD
  else
    echo "one"
  fi
}
export -f holy-lead

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
export -f holy-you

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
export -f holy-env

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
export -f holy-dot

# sources use/ scripts + extra features...
uses() {
  [ $# -eq 0 ] && {
    echo "uses -- source filepaths relative to use/ dir, with .sh ext optional"
    false; return
  }
  local use path status=0
  for path; do
    use="${HOLY_HOME}/use/${path}"
    if [[ ! "$use" =~ '.sh$' ]] && [ -s "${use}.sh" ]; then
      . "${use}.sh"
    elif [ -s "$use" ]; then
      . "$use"
    else
      >&2 echo "Not found: $use"
      status=1
    fi
  done
  return $status
}
export -f uses

# http://unix.stackexchange.com/questions/4965/keep-duplicates-out-of-path-on-source
add_to_PATH() {
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
export -f add_to_PATH
