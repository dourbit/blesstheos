export HOLY_EAGER=no # git pull blesstheos only by holy update / up
export HOLY_SOURCE=not # source all of src to make the functions available
export HOLY_EXPORT=not # export the sourced src helpers to sub-shells too
export HOLY_ALIASES=yes # certain aliases bundled together with abilities
export HOLY_BREW_ON=yes # omit to decrease / skip Homebrew usage
export HOLY_TIME=not # must be true (i.e. yes) or does nothing, thus saves time
export HOLY_TIME_TELL=yes # a yes would print how long blesstheos takes to load
export HOLY_TIME_RUN_TELL=not # a yes enables seeing a greater depth of details

# Мeasure and report elapsed time, considering the following config vars:
# HOLY_TIME=yes # make it a yes or it will not run (saves time when not used)
# HOLY_TIME_TELL=yes # keep it on, or no output would be shown
# HOLY_TIME_ROUND=3 # override with 1 to 9 precison; the 3 default is for ms
# HOLY_TIME_RUN_TELL=yes # turns on more details, #for performance optimization
holy-time() {
  # an on / off switch, needs literal "yes"
  if [ "$HOLY_TIME" != "yes" ]; then
    # but only if called without the --run / -r option
    [[ "=$(printf "%s=" $@)" =~ =(--run|-r)= ]] || return
  fi
  local now=$(date +%s.%N) # used in too many places, keep it dry and accurate
  # holy-time now # command doesn't take any options, and returns immediately
  [ "now" == "$1" ] && echo $now && return # best performance command
  # NOTE: expects options before the commands, or any command-specific args
  local label mark=0 run=no silent=no
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
      --silent)
        silent=yes
        ;;
      -?*)
        >&2 echo "Not an option: holy-time $1"
        ;;
      *)
        break
    esac
    shift
  done
  if [ $# -eq 0 ]; then
    echo "Usage: holy-time [opts] <cmd> [...]"
    echo "Where [opt] is: --label <what>, --marker, --run, --silent"
    echo "Where <cmd> is: start, now, tell, done"
  else
    local cmd=$1;
    if [[ $run != "yes" || $cmd == "tell" ]]; then
      shift
    fi
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
      if tis-true $HOLY_TIME_TELL; then
        if tis-some $HOLY_TIME_START; then
          local total=$(holy-time tell)
          echo # spacer line
          echo "${total} #total $label"
          echo "$(echo $HOLY_TIME_TOLD | LC_ALL=C xargs /usr/bin/printf '%.*f' "$round") #told"
        else
          >&2 echo "Missing: holy-time start"
        fi
      fi
      # remove global environment variables
      unset HOLY_TIME_MARK
      unset HOLY_TIME_TOLD
      unset HOLY_TIME_WHAT
      unset HOLY_TIME_START
    elif [[ $cmd == "tell" || $run == "yes" ]]; then
      local tell=yes # quietly skip telling if not on; checked in two places
      tis-true $HOLY_TIME && tis-true $HOLY_TIME_TELL || tell=not
      local since status=0
      if tis-true $run; then
        since=$now
        # --run the rest of args, with --silent option?
        if tis-true $silent; then
          $@ >/dev/null 2>&1
        else
          $@
        fi
        status=$?
        if [ $tell == yes ] && tis-true $HOLY_TIME_RUN_TELL; then
          now=$(holy-time now)
        else
          return $status
        fi
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
        [ $tell == yes ] || return
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
