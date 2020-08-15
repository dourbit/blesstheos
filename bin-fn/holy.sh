# Helpers for holy

# validates a lead mod aka modifier
lead() {
  [[ "$1" == "one" || "$1" == "you" ]] && true || false
}

# return the holy var name of a mod with which to get its home path
# if unknown mod then echo a "HOLY_HOME" default
goal() {
  local the=${1-one}; shift
  case $the in
    you)
      echo DOTS_HOME
      ;;
    one|*)
      echo HOLY_HOME
  esac
}

# the rc file for a shell; to use by holy init; relative to ~/.
shell-rc() {
  local shell=${1-$(basename $SHELL)}
  if [ $shell == "bash" ]; then
    echo ".bashrc"
  fi
}


# The rest of these require a holy one on.

installable() {
  local able=$1
  local path="${HOLY_HOME}/install/${able}"
  if [ $# -eq 0 ]; then
    find $HOLY_HOME/install -type f,l -executable -print \
    | sed -e "s/^.*\/install\///g" | sort \
    | grep -ve '\.sh$\|-skip$'
    # TODO: show help regarding what the above installs?
    true; return
  elif check-x $path; then
    true; return
  else
    false; return
  fi
}
