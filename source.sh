#
export THIS_HOME="$HOLY_HOME"
# see it unset at the end of this source.sh
# exists for more concise calls of holy-dot
# thus this-that needs no path arg, for the time being...
# only ever an issue when sourcing from the outside, e.g. ~/.bashrc, etc.
# essential for code portability between blesstheos and dots or its forks -
# it is an indicator of bootstrapping in progress...


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

# Мeasure and report elapsed time + optional config:
# HOLY_TIME=not # make it a yes or it will not run (saves time when not used)
# HOLY_TIME_TELL=yes # keep it on, or it will not be seen
# HOLY_TIME_ROUND=3 # override with 1 to 9 precison; the 3 default is for ms
holy-time() {
  [ "$HOLY_TIME" == "yes" ] || return # an on / off switch, needs literal "yes"
  local now=$(date +%s.%N) # used in too many places, keep it dry and accurate
  # holy-time now # command doesn't take any options, and returns immediately
  [ "now" == "$1" ] && echo $now && return # best performance command
  # NOTE: expects options before the commands, or any command-specific args
  local label mark=0 run=no
  while :; do
    case $1 in
      --label|-l)
        label="$2"; shift
        ;;
      --marker|-m)
        mark=$now
        ;;
      --run|-r)
        run=yes
        ;;
      -?*)
        >&2 echo "Not an option: holy-time $1"
        ;;
      *)
        break
    esac
    shift
  done
  if [ $# -eq 0 ] ; then
    echo "Usage: holy-time [opts] <cmd> [...]"
    echo "Where [opt] is: --label <what>, --marker, --run"
    echo "Where <cmd> is: start, now, tell, done"
  else
    local cmd=$1; shift
    local round=${HOLY_TIME_ROUND-'3'}
    if [ $cmd == "start" ]; then
      # only one context per environment
      # the start is an automatic marker
      # finalize with a holy-time done #summary
      export HOLY_TIME_START=$now
      export HOLY_TIME_WHAT="${1-START}"
      export HOLY_TIME_TOLD=0
      export HOLY_TIME_MARK=$now
    elif [ $cmd == "done" ]; then
      echo # spacer line
      local total=$(holy-time tell)
      echo "${total} #total $label"
      echo "$(echo $HOLY_TIME_TOLD | LC_ALL=C xargs /usr/bin/printf '%.*f' "$round") #told"
      # remove global environment variables
      unset HOLY_TIME_MARK
      unset HOLY_TIME_TOLD
      unset HOLY_TIME_WHAT
      unset HOLY_TIME_START
    elif [ $cmd == "tell" ]; then
      tis-true $HOLY_TIME_TELL || return # quietly skip if not on
      local since status=0
      if tis-true $run; then
        since=$now
        $@ # --run the rest of args
        status=$?
        now=$(holy-time now)
        # there is always a $label with $run
        # the code below ensures that
        if [ $# -eq 0 ]; then
          if [ "$label" == "" ]; then
            label="#empty #run"
          else
            # here we just wanted a label, should this be another command?
            # TODO: format with precision fn + calculate time for accuracy?
            # added to wasted time for total done stats?
            echo "0.    $label"
            return
          fi
        else
          # $@ is the label when no --label given
          label=${label-$@}
        fi
      else
        since=${1-$HOLY_TIME_START}
        tis-some $1 && shift;
      fi
      # is there a start time? can be timed as elapsed, and #told...
      if tis-some $since; then
        local what
        local elapsed=$(echo "$now - $since" | env bc)
        if [ $mark != 0 ]; then
          # a --marker = a duration since the last labeled marker
          since=$HOLY_TIME_MARK
          what="#since $HOLY_TIME_WHAT"
          if tis-some "$label"; then
            # a --marker with a --label becomes the latest marker
            what="#timed $label $what"
            export HOLY_TIME_WHAT="$label"
            export HOLY_TIME_MARK=$now
          fi
        else
          if tis-true $run; then
            # $run guarantees a label
            what="#for $label" #takes to run or #ran for
          else
            # TODO: do not add if nested; can run be told?
            export HOLY_TIME_TOLD=$(echo "$HOLY_TIME_TOLD + $elapsed" | env bc)
            [ "$label" != "" ] && what="#tell $label"
          fi
        fi
        [ "$what" != "" ] && what=" $what" # spaced if $label / $what not blank
        echo "$(echo $elapsed | LC_ALL=C xargs /usr/bin/printf '%.*f' "$round")$what"
        return $status
      else
        >&2 echo "Missing: holy-time start || holy-time tell <start> || holy-time --run tell ..."
        return 1
      fi
    else
      >&2 echo "Unknown: holy-time $cmd"
      return 1
    fi
  fi
}
export -f holy-time
holy-time start "holy-time start"

# holy-one and core.sh functions to bootstrap with
if holy-one 1; then
  . "${HOLY_HOME}/core.sh"
  holy-export -f "${HOLY_HOME}/core.sh"
else
  # holy-one somehow isn't on, unexpected but possible
  # clean-up here
  unset THIS_HOME
  return 1
fi

# exports $LEAD_HOME
holy-sort

if tis-true $HOLY_SOURCE; then
  holy-dot -x src/
  # or get more fancy, such as:
  # holy-dot -x $(find "${HOLY_HOME}/src" -type f | grep '.sh$')
else
  # must be sourced, maybe exported:
  holy-dot -x src/os.sh
fi

holy-time --marker --label "sourced core functions" tell


PATH-add \
  ${HOLY_HOME}/cmd \
  ${HOLY_HOME}/bin-fn

holy-dot --time use/ colors term aliases git jump rundev

# bash-only stuff
[ -n "$BASH" ] && holy-dot use/bash

umask 022

export HISTSIZE=10000 # much?
export HISTCONTROL=ignoredups

shopt -s checkwinsize # After each command, checks the windows size and changes lines and columns
#shopt -s globstar # research...

holy-time --marker tell

# platforms for programming / runtime
for src in $(ls "${HOLY_HOME}/use/platform"/* | grep -v .skip); do
  holy-dot --time "$src"
done

# so far the PATH pas been added to from many places
holy-dot use/path

unset THIS_HOME

holy-time -l "ALL" -m tell
holy-time -l "${HOLY_HOME}/source.sh" done
