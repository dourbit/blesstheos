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

# export $LEAD_HOME & $NEXT_HOME
# if you not on: just $LEAD_HOME and return false
holy-env() {
  local the=${1-${HOLY_LEAD-"one"}}
  local level=$2 # give it a 1 to complain if holy-you not found
  # NOTE: holy-one has already validated, for this to be sourced
  local yours=1 # false status of holy-you (tested below)
  if holy-you $level; then
    yours=0 # is true
    if [ $the == "one" ]; then
      export LEAD_HOME="$HOLY_HOME"
      export NEXT_HOME="$DOTS_HOME"
    elif [ $the == "you" ]; then
      export LEAD_HOME="$DOTS_HOME"
      export NEXT_HOME="$HOLY_HOME"
    fi
  else
    # only holy-one
    export LEAD_HOME="$HOLY_HOME"
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
    echo "uses - sources filepath relative to use/ dir, with .sh ext optional"
    false; return
  }
  local use="$HOLY_HOME/use/$1"
  if [[ ! "$1" =~ .sh$ ]] && [ -s "$use.sh" ]; then
     . "$use.sh"
     true; return
  fi
  [ -s "$use" ] && . "$use" || false; return
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