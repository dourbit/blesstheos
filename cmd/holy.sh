# holy helper functions

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
  local the=${1-one}
  local name=$(goal $the)
  if exported $name; then
    # the holy home is guaranteed to exist, as the code is holy-sourced
    # for $the not one though we still need to test the you / other dir
    # TODO: maybe check for some file specific to dots / grep README.md?
    if [[ $the != "one" && ! -d "${!name}" ]]; then
      >&2 echo "Not Found: ${!name}"
      false; return
    fi
    true; return
  else
    false; return
  fi
}

# of echoed text, to read if on, and so we know
holy-say-on() {
  if [ $# -lt 1 ]; then
    >&2 echo "Missing expected args:"
    >&2 echo '* $1 - the one or you'
    >&2 echo '* $2 - 1=false or 0=true'
    false; return
  fi
  local the=$1
  local on=$2
  local not=$(if [ $on -eq 0 ]; then echo; else echo " Not"; fi)
  echo "Holy ${the^}$not On"
  if [[ $the == "one" && on -ne 0 ]]; then
    echo "Please: holy one init"
  fi
  return $on
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
