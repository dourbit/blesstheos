# generate an absolute path from any path relative to the ./
# absolute paths are simply verified
a-path() {
  # takes any path, echoes an absolute path if one exists
  local a_path="$1"
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
  local wanted="$1"
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
  if [ $# -lt 2 ]; then
      echo "Please call a-home with:"
      echo "- \$1 env var name"
      echo "- \$2 path to export"
      return 0
  fi
  local name=$1
  local home=${!name}
  local want="$2"
  local path=$(a-path $want)
  if ! [ -d "$path" ]; then
    echo; echo "Path is not a directory and thus cannot be a home."
    echo "Given: $([[ $path == "" ]] && echo $want || echo $path)"; echo
    return 1
  elif [[ "$home" != "" && "$home" != "$path" ]]; then
    # a change of home to another path
    echo; echo "Warning: \$$name is $home"
    echo "Exporting here as $path"; echo
  fi
  export $name="$path"
}
export -f a-home
