if [ -z "$HOLY_HOME" ]; then
  echo "\$HOLY_HOME not set!"
  return 1
elif ! [ -d "$HOLY_HOME" ]; then
  echo "\$HOLY_HOME dir of $HOLY_HOME is Not Found!"
  return 1
fi

. "${HOLY_HOME}/src/core.sh"

if env-true ${HOLY_SOURCE}; then
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
