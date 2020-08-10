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

# generate an absolute path from any path
a_path() {
  # takes any path, including a path with non-escaped spaces
  # echoes an absolute path if one exists
  local a_path="$@"
  local parent=$(dirname "${a_path}")

  if [ -d "${a_path}" ]; then
    echo "$(cd "${a_path}" && pwd)"
  elif [ -d "${parent}" ]; then
    local result="$(cd "${parent}" && pwd)/$(basename "${a_path}")"
    if [ -e "${result}" ]; then
      echo $result
    fi
  fi
}
export -f a_path

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
