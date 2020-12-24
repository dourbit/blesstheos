# true if $1 is some rather than none, i.e. has any value other than blank (or)
# if $# >= 2; then is $1 = some of $2 = a space-separated words match-list
# NOTE: in the latter case, quote the "$1" (or blank produces a false positive)
tis-some() {
  if [ $# -lt 2 ]; then
    return "$((!${#1}))"
  else
    echo $2 | grep -wq "$1"
  fi
}

# true ($?) status of 0, on, yes, and of-course true
# anything else would be a false 1 return
tis-true() {
  if tis-some "$1" "0 on yes true"; then
    true; return
  fi
  false; return
}

# validates a holy lead mod / modifier
holy-be() {
  tis-some "$1" "one me you" && true || false
}

# echoes $HOLY_LEAD, if valid, or the "one" default
holy-lead() {
  if holy-be $HOLY_LEAD; then
    # optional system default
    echo $HOLY_LEAD
  else
    echo "one"
  fi
}

# we would want to have customized holy you be reachable too
# imitates the holy-one fn - see source.sh for reference
# this one is simpler & assumes holy-one is already true
holy-you() {
  # $1 option:
  # level 0 is silent (the default)
  # level 1 is verbose about not finding a $DOTS_HOME
  # level 2 or whatever else will delegate to holy on
  local level="${1-0}"
  if [[ $level == "1" || $level == "0" ]]; then
    if ! tis-some $DOTS_HOME; then
      [ $level == "1" ] && echo "\$DOTS_HOME not set!"
      return 1
    elif ! [ -d "$DOTS_HOME" ]; then
      [ $level == "1" ] && echo "\$DOTS_HOME dir of $DOTS_HOME is Not Found!"
      return 1
    fi
    return 0
  else
    holy you on
  fi
}

# export $LEAD_HOME & $NEXT_HOME depending on the $1 or $HOLY_LEAD
# if you not on: just $LEAD_HOME and return false
holy-sort() {
  local the=$1 # the holy subshell uses this with each run
  # NOTE: holy-one has already validated, for this to be sourced
  local level=$2 # give it a 1 to complain if holy-you not found
  if ! holy-be $the; then
    the=$(holy-lead)
    if [ $# -eq 1 ]; then
      # invalid $1 hereby interpreted as $level if just 1 arg is given
      level=$1
    fi
  fi
  local yours=1 # false status of holy-you (tested below)
  if holy-you $level; then
    yours=0 # is true
    if [[ $the == "one" ]]; then
      export LEAD_HOME="$HOLY_HOME"
      export NEXT_HOME="$DOTS_HOME"
    else
      export LEAD_HOME="$DOTS_HOME"
      export NEXT_HOME="$HOLY_HOME"
    fi
  else
    # only holy-one
    export LEAD_HOME="$HOLY_HOME"
    unset NEXT_HOME # maybe holy-you went off - this cleans the env
  fi
  return $yours
}

# because some functions, just holy-dot so far,
# prefer to source these rather than those files -
# code would favor code from the same repo first -
# unless $here is under $DOTS_HOME the one leads -
# given a $HOLY_HOME or $DOTS_HOME becomes $here -
# else if $THIS_HOME is set it will become $here -
# there's no holy-you until holy-one has sourced
this-that() {
  local status=0 dir=no ifs=" " here=$(cd $(dirname $0) && pwd)
  # NOTE: expects any options before the optional $here path
  while :; do
    case $1 in
      --dir)
        dir="yes"
        ;;
      --ifs)
        ifs="$2"
        shift
        ;;
      *)
        break
    esac
    shift
  done
  if [ -n "$1" ] && [[ "$1" == "$HOLY_HOME" || "$1" == "$DOTS_HOME" ]]; then
    # is given a specific home, which also checks out as valid
    here=$1
    status=1
  elif [ -n "$THIS_HOME" ]; then
    # available while sourcing either of the 2 source.sh files
    # a convenience and for code portability among dots, forks, or the "one"
    here=$THIS_HOME
  fi
  # $here is all-set; check if holy-you is on:
  if holy-you; then
    # is $here a $DOTS_HOME path?
    if grep -q "^$DOTS_HOME" <<< "$here"; then
      tis-true $dir && echo "${DOTS_HOME}${ifs}${HOLY_HOME}" || echo "you one"
    else
      tis-true $dir && echo "${HOLY_HOME}${ifs}${DOTS_HOME}" || echo "one you"
    fi
  else
    tis-true $dir && echo "$HOLY_HOME" || echo one
  fi
  # cannot be an error status -
  # 1 just means a given path matched a home path, making it a "this" first
  return $status
}

# sources files based on this-that, with optional .sh ext;
# with a -x option: uses holy-export and passes on options to it +
# guesses relative paths with great flexibility and alternatives
# NOTE: has quirks, such as presuming base-dir/ context stickyness
# instead of fallback to the home-dir (could reset with // or / ?)
holy-dot() {
  local opts=() export="no" ifs=":" all="*.sh"
  # NOTE: expects options before the paths
  while :; do
    case $1 in
      -x)
        export="yes"
        ;;
      --ifs)
        ifs="$2"; shift
        ;;
      --all)
        all="$2"; shift
        ;;
      -?*)
        opts+=($1)
        ;;
      *)
        break
    esac
    shift
  done
  [ $# -eq 0 ] && {
    echo "Usage: holy-dot [options] [home-dir] [base-dirs/] <file-paths> [...]"
    false; return
  }
  local status=0 files=() bases=() that=not
  local use path the found home these homes homed base glob
  if [[ $# -gt 1 && $1 =~ ^/ ]]; then
    # the args count isn't much of an indicator
    # though a single path would skip this test
    # notice the absolute path requirement --
    # one can just use $DOTS_HOME for example
    # however it's usually, correctly guessed
    # anyway: $1 could be a home path request
    homes=$(this-that --ifs "$ifs" --dir $1)
    if [ $? -eq 1 ]; then
      # yes it is
      these=$(this-that $1)
      shift
    fi
  else
    homes=$(this-that --ifs "$ifs" --dir)
    these=$(this-that)
  fi
  IFS="$ifs" command read -a homed <<< $homes
  [[ $these =~ ' ' ]] && that=yes # space match
  for path; do
    # check if a base-dir: in either home if two of $these, or just "this" one
    # NOTE: expected with a trailing / which is because of these requirements:
    # 1. base/ dir precedes any file paths relative to it (must confirm first)
    # 2. two consecutive base1/ base2/ dirs are allowed (source all the files)
    # 3. current base context must take precedence over a new base context...
    # this is what caused the requirement -- src/ install vs. src/ install/
    # in this case install is both a file in current context and a base dir
    if [[ $path =~ /$ ]]; then
      if tis-true $that \
        && [[ -d "${HOLY_HOME}/${path}" || -d "${DOTS_HOME}/${path}" ]] \
        || [ -d "${homes}/${path}" ]; then
          tis-true $glob && bases+=($base) # previous $path also a $base
          # $path is a relative $base directory for sure (though files assumed)
          base=$path # not checked in advance, just it being a directory is ok.
          glob=yes # follow a base by one or more files - or all files sourced!
          shift # this base-dir
          continue # to the next $path
      fi
    fi
    found=none
    for home in ${homed[@]}; do
      if ! [[ $path =~ ^/ ]]; then
        # a relative $path
        use=${home}/${base}${path}
      else
        # an absolute path given
        if grep -q "^$home" <<< "$path"; then
          # expected to be $home-based
          use=${path}
        else
          # uncool, though maybe still a good $path, will find-out...
          # could be $the "that" of this-that $these (if there is another)
          status=1
          continue
        fi
      fi
      if [[ ! "$use" =~ '.sh$' ]] && [ -s "${use}.sh" ]; then
        . "${use}.sh"
        files+=("${use}.sh")
        found=yes; glob=not
        break
      elif [ -s "$use" ]; then
        . "$use"
        files+=("$use")
        found=yes; glob=not
        break
      else
        status=1
      fi
    done
    if ! tis-true ${found}; then
      glob=not # in order to prevent sourcing all for a current base by mistake
      >&2 echo "Not found in \"${these}\" by: holy-dot ${base}${path}"
    fi
  done
  # $bases without explicit files will get $all their files sourced, etc.
  tis-true $glob && bases+=($base)
  if [ ${#bases[@]} -ne 0 ]; then
    for base in "${bases[@]}"; do
      found=not
      for home in ${homed[@]}; do
        # because base is a relative path wrto either of this-that --dir
        if [ -d ${home}/${base} ]; then
          for use in ${home}/${base}${all}; do
            [ -f "$use" ] || continue
            . "$use"; files+=("$use")
            found=yes
          done
          break # onto a next base
        fi
      done
      if ! tis-true ${found}; then
        status=1
        >&2 echo "Not found in \"${these}\" by: holy-dot ${base}${all}"
      fi
    done
  fi
  # export / unexport all the files if asked to
  if tis-true $export && [ ${#files[@]} -ne 0 ]; then
    holy-export ${opts[@]} ${files[@]}
    [ $? -ne 0 ] && status=1
  fi
  # errors would return 1
  return $status
}

# based on HOLY_EXPORT preference or explicit -f (or -n / -fn)...
# will export all functions found in given files - just looks for patterns -
# these functions must have already been sourced - or else expect errors
# in reverse, it un-exports using export -fn, to ensure no export was made
# optionally, can also uset all variables that the given files export
holy-export() {
  local dry="no" var="no" force="no" none="no"
  # NOTE: expects options before the paths
  while :; do
    case $1 in
      --dry-run)
        dry="yes"
        ;;
      --vars)
        var="yes"
        ;;
      -f|--force)
        force="yes"
        ;;
      -n|--none|-fn)
        none="yes"
        ;;
      -?*)
        >&2 echo "Not an option: holy-export $1"
        ;;
      *)
        break
    esac
    shift
  done
  if [ $# -eq 0 ]; then
    >&2 echo "holy-export: path required"
    false; return
  else
    local exports
    if tis-true $none; then
      exports="no"
    elif tis-true $force; then
      exports="yes"
    else
      exports="$HOLY_EXPORT"
    fi
    local status=0 path
    for path in "$@"; do
      if ! [ -f $path ]; then
        >&2 echo "holy-export: no file at $path"
        status=1; continue
      elif ! [ -s $path ]; then
        >&2 echo "holy-export: empty file at $path"
        status=1; continue
      fi
      local it fns vars cmd code=()
      # NOTE: a permissive regex for function matches
      # ignores the function keyword, or extra spaces
      # though doesn't support `function NAME { CMDS; }`
      fns=$(grep -Po '[^ ]+(?=[[:space:]]*\(\)[[:space:]]*\{)' $path)
      for it in $fns; do
        if tis-true $exports; then
          code+=("export -f $it")
        else
          code+=("export -fn $it")
        fi
      done
      # it can un-export vars as well --
      # though that's turned off by default due to edge cases, also it's a bad idea
      # holy exports very few vars, which are very well-named, to cause no trouble
      # code is here though, and there is a --vars option that allows for this
      if tis-true $var && ! tis-true $exports; then
        vars=$(grep -oP '(?<=export )[^\$].*(?==)' $path)
        for it in $vars; do
          code+=("export -n $it")
        done
      fi
      if [ ${#code[@]} -eq 0 ]; then
        status=1
        >&2 echo "holy-export: useless is $path"
      else
        for cmd in "${code[@]}"; do
          # just show or run it?
          if tis-true $dry; then
            echo "$cmd"
          else
            $cmd
            # not-a-function error?
            [ $? -ne 0 ] && status=1
          fi
        done
      fi
    done
    return $status
  fi
}

# http://unix.stackexchange.com/questions/4965/keep-duplicates-out-of-path-on-source
PATH-add() {
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
