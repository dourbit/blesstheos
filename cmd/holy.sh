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

# test exported var + note fn must remain here as prior to holy one on
exported() {
  # TODO: cover for functions (opt-in $1 arg) with \-fx and \n instead of =
  export -p | grep -q "\-x ${1}="
}

# is holy one or you on / has holy init been run for this shell?
holy-on() {
  the=${1-one}
  name=$(goal $the)
  if exported $name; then
    # the holy home is guaranteed to exist, as the code is holy-sourced
    # for $the not one though we still need to test the you / other dir
    # TODO: maybe check for some file specific to dots / grep README.md?
    if [[ $the != "one" && ! -d "${!name}" ]]; then
      echo "Not Found: ${!name}"
      echo "Holy ${the^} Not On"
      false; return
    fi
    echo "Holy ${the^} On"
    true; return
  else
    echo "Holy ${the^} Not On"
    false; return
  fi
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
