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

holy-env() {
  local the=${1-${HOLY_LEAD-"one"}}
  if holy-one; then
    if holy-you; then
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
  fi
}
export -f holy-env

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
