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

# OS has holy and $HOLY_HOME is set too - just a quick check without guarantees
holy-one() {
  command -v holy > /dev/null && is-some $HOLY_HOME && [ -d $HOLY_HOME ]
}
export -f holy-one

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
