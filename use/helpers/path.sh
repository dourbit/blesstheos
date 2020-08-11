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

# generate an absolute path from any path relative to the ./
# absolute paths are simply verified
a-path() {
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
export -f a-path

# give it a path that is relative to $HOME ~/ or an absolute path
# will also accept any relative path if it turns out not based on ~/
# this is a step-up from a-path as long as ~/ precedence to ./ is ok
# receive an absolute path that is sure to exist
a-ffix() {
  local wanted="$@"
  if [[ $wanted =~ ^/ ]] || [[ $wanted =~ ^~ ]]; then
    echo $(a-path $wanted)
  else
    local result="$(a-path ~/$wanted)"
    # fallback to relative ./ path
    if [ "$result" == "" ]; then
      echo $(a-path ./${wanted})
    else
      echo $result
    fi
  fi
}
export -f a-ffix

# given name and path it makes the path absolute and ensures it's a directory
# if env var of the same name exists and the paths differ it echoes a warning
# in any case it exports name=path as some kind of a home directory
a-home() {
  local name=$1
  local home=${!name}
  local want=$2
  local path=$(a-path $want)
  if ! [ -d "$path" ]; then
    echo; echo "Path is not a directory and thus cannot be a home."
    echo "Given: $([[ $path == "" ]] && echo $want || echo $path)"; echo
    exit 1
  elif [[ "$home" != "" && "$home" != "$path" ]]; then
    echo; echo "Warning: \$$name is $home"
    echo "Exporting here as $path"; echo
  fi
  export $name=$path
}
export -f a-home

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
