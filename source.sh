# OS has holy and wide variety of holy-one-on ways to check that it's all good
holy-one() {
  # $1 option:
  # level 0 is silent (the default)
  # level 1 is verbose about not finding a $HOLY_HOME
  # level 2 or whatever else will delegate to holy on
  local level="${1-0}"
  local holy="$HOLY_HOME"/holy
  local wtf="Very odd that \$HOLY_HOME has no holy in it!"
  command -v $holy > /dev/null
  local status=$?
  if [[ $level == "0" || $level == "1" ]]; then
    if [ -z "$HOLY_HOME" ]; then
      [ $level == "1" ] && echo "\$HOLY_HOME not set!"
      return 1
    elif ! [ -d "$HOLY_HOME" ]; then
      [ $level == "1" ] && echo "\$HOLY_HOME dir of $HOLY_HOME is Not Found!"
      return 1
    else
      [[ $level == "1" && $status -ne 0 ]] && \
        echo $wtf
      return $status
    fi
  elif [ $status -eq 0 ]; then
    # any other / unknown level delegates to $holy
    $holy one on
  else
    # holy is not known
    echo $wtf
    false; return
  fi
}
export -f holy-one

# holy-one and src/core.sh - needed to bootstrap
holy-one 1 && . "${HOLY_HOME}/src/core.sh" || return 1
holy-env

if is-true $HOLY_SOURCE; then
  for src in $(find "${HOLY_HOME}/src" -type f | grep -e '.sh$' | sort -r); do
    . "$src"
  done
else
  . "${HOLY_HOME}/src/os.sh"
fi

add_to_PATH ${HOLY_HOME}/cmd
add_to_PATH ${HOLY_HOME}/bin-fn

uses colors
uses term
uses aliases
uses git
uses jump
[ -n "$BASH" ] && uses bash # bash-only stuff
uses rundev

umask 022

export HISTSIZE=10000 # much?
export HISTCONTROL=ignoredups

shopt -s checkwinsize # After each command, checks the windows size and changes lines and columns
#shopt -s globstar # research...


# programming-languages aka platforms
for src in $(ls "${HOLY_HOME}/use/platforms"/* | grep -v .skip.sh); do . "$src"; done

# thus far the PATH pas been added to from many places
uses path
