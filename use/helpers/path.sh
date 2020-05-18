uses() {
  source "$DOTS_HOME/use/$1"
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

# check that a command or function or alias exists
# thus conclude that something is installed
# only missing -x check for the executables, which would depend on type
check-x() {
  if [ $# -eq 0 ]; then
    echo "Usage: check-x <command>"
    false; return
  elif [ -z "$(command -v $1)" ]; then
    # Empty string of command -v (is good enough)
    # Don't check for ! [ -x ...] because that doesn't catch a function or alias
    echo
    echo "Command '$1' not found."
    false; return
  fi
}
export -f check-x

