# true if env var is set to anything
env-have() { return "$((!${#1}))"; }
export -f env-have

# true if env var is 0, yes, or true
env-true() {
  local var="$1"
  if env-have $var; then
    if [[ "$var" == '0' || "$var" == 'yes' || "$var" == 'true' ]]; then
      true; return
    fi
  fi
  false; return
}
export -f env-true

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
